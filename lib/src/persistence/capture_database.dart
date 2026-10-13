import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:sqlite3/sqlite3.dart' as sqlite;

part 'capture_database.g.dart';

enum MigrationCheckpoint {
  afterCopy,
  afterTableSwap,
  afterValidation,
  afterVersionWrite,
}

typedef MigrationFailureHook = Future<void> Function(MigrationCheckpoint point);

class Installations extends Table {
  @override
  String get tableName => 'installations';

  TextColumn get id => text().named('id')();
  IntColumn get createdAtUtcMicros =>
      integer().named('created_at_utc_micros')();

  @override
  Set<Column<Object>> get primaryKey => {id};
}

@TableIndex(
  name: 'raw_captures_occurrence_idx',
  columns: {#capturedAtUtcMicros, #captureId},
)
class RawCaptureRows extends Table {
  @override
  String get tableName => 'raw_captures';

  TextColumn get captureId => text().named('capture_id')();
  TextColumn get rawText => text().named('raw_text')();
  TextColumn get payloadKind =>
      text().named('payload_kind').withDefault(const Constant('text'))();
  TextColumn get sourceInstallationId =>
      text().named('source_installation_id').references(Installations, #id)();
  IntColumn get capturedAtUtcMicros =>
      integer().named('captured_at_utc_micros')();
  IntColumn get originalOffsetMinutes =>
      integer().named('original_offset_minutes')();
  TextColumn get sourceTimeZoneId =>
      text().named('source_time_zone_id').nullable()();
  TextColumn get visibility => text().named('visibility')();
  IntColumn get revision => integer().named('revision')();
  IntColumn get createdAtUtcMicros =>
      integer().named('created_at_utc_micros')();

  @override
  Set<Column<Object>> get primaryKey => {captureId};

  @override
  List<String> get customConstraints => const [
    "CHECK ((payload_kind = 'text' AND length(raw_text) > 0) OR "
        "(payload_kind = 'voice' AND raw_text = ''))",
    "CHECK (visibility = 'private')",
    'CHECK (revision = 1)',
  ];
}

/// References only. A row cannot establish that audio bytes exist or are valid;
/// the later voice repository must enforce that in its staged-write protocol.
class RawMediaRows extends Table {
  @override
  String get tableName => 'raw_media';

  TextColumn get mediaId => text().named('media_id')();
  TextColumn get captureId => text()
      .named('capture_id')
      .unique()
      .references(RawCaptureRows, #captureId, onDelete: KeyAction.cascade)();
  TextColumn get relativePath => text().named('relative_path').unique()();
  TextColumn get sha256 => text().named('sha256')();
  IntColumn get byteLength => integer().named('byte_length')();
  TextColumn get mimeType => text().named('mime_type').nullable()();
  TextColumn get codec => text().named('codec').nullable()();
  IntColumn get durationMillis =>
      integer().named('duration_millis').nullable()();
  IntColumn get createdAtUtcMicros =>
      integer().named('created_at_utc_micros')();

  @override
  Set<Column<Object>> get primaryKey => {mediaId};

  @override
  List<String> get customConstraints => const [
    'CHECK (length(relative_path) > 0)',
    "CHECK (length(sha256) = 64 AND sha256 NOT GLOB '*[^0-9a-f]*')",
    'CHECK (byte_length > 0)',
    'CHECK (duration_millis IS NULL OR duration_millis >= 0)',
  ];
}

@DriftDatabase(tables: [Installations, RawCaptureRows, RawMediaRows])
class CaptureDatabase extends _$CaptureDatabase {
  CaptureDatabase(super.executor, {this.migrationFailureForTest});

  final MigrationFailureHook? migrationFailureForTest;

  factory CaptureDatabase.openFile(File file) {
    return CaptureDatabase(
      NativeDatabase.createInBackground(file, setup: setupCaptureDatabase),
    );
  }

  factory CaptureDatabase.inMemory() {
    return CaptureDatabase(NativeDatabase.memory(setup: setupCaptureDatabase));
  }

  @override
  int get schemaVersion => 2;

  @override
  MigrationStrategy get migration => MigrationStrategy(
    onCreate: (migrator) => transaction(() async {
      // SQLite version 0 is not proof of a fresh database: Drift also routes
      // existing, unversioned files here. Never relabel unknown data as v2.
      final existingObjects = await customSelect(
        "SELECT 1 FROM sqlite_master WHERE name NOT GLOB 'sqlite_*' LIMIT 1",
      ).get();
      if (existingObjects.isNotEmpty) {
        throw StateError('Unversioned database is not empty; data retained.');
      }
      await migrator.createAll();
      await customStatement('PRAGMA user_version = 2');
    }),
    onUpgrade: (migrator, from, to) async {
      if (from != 1 || to != 2) {
        throw UnsupportedError(
          'Unsupported local database version transition.',
        );
      }
      await _upgradeFromV1(migrator);
    },
  );

  Future<void> _upgradeFromV1(Migrator migrator) => transaction(() async {
    // v1 has no incoming references to raw_captures. Keep FK enforcement on;
    // create raw_media only after the original table has been replaced.
    const temporaryName = 'raw_captures_v2_migration';
    await _requireKnownV1Shape();

    await migrator.createTable(rawCaptureRows.createAlias(temporaryName));
    await customStatement('''
      INSERT INTO $temporaryName ($_v1RawColumns, payload_kind)
      SELECT $_v1RawColumns, 'text' FROM raw_captures
    ''');
    await migrationFailureForTest?.call(MigrationCheckpoint.afterCopy);

    // Compare both directions as sets AND count, including nullable time zones.
    // Never interpolate life content or include it in an error message.
    final comparison = await customSelect('''
      SELECT
        (SELECT COUNT(*) FROM raw_captures) =
          (SELECT COUNT(*) FROM $temporaryName) AS same_count,
        NOT EXISTS (
          SELECT $_v1RawColumns FROM raw_captures
          EXCEPT SELECT $_v1RawColumns FROM $temporaryName
        ) AS old_preserved,
        NOT EXISTS (
          SELECT $_v1RawColumns FROM $temporaryName
          EXCEPT SELECT $_v1RawColumns FROM raw_captures
        ) AS no_new_facts
    ''').getSingle();
    if (!comparison.read<bool>('same_count') ||
        !comparison.read<bool>('old_preserved') ||
        !comparison.read<bool>('no_new_facts')) {
      throw StateError(
        'Migration verification failed; original data retained.',
      );
    }

    await customStatement('DROP TABLE raw_captures');
    await customStatement('ALTER TABLE $temporaryName RENAME TO raw_captures');
    await migrator.createIndex(rawCapturesOccurrenceIdx);
    await migrationFailureForTest?.call(MigrationCheckpoint.afterTableSwap);
    await migrator.createTable(rawMediaRows);

    final foreignKeyFailures = await customSelect('PRAGMA foreign_key_check')
        .get();
    final integrity = await customSelect('PRAGMA integrity_check').get();
    if (foreignKeyFailures.isNotEmpty ||
        integrity.length != 1 ||
        integrity.single.data.values.single != 'ok') {
      throw StateError(
        'Migration integrity check failed; original data retained.',
      );
    }
    await migrationFailureForTest?.call(MigrationCheckpoint.afterValidation);

    // Drift 2.34.3 otherwise writes user_version AFTER onUpgrade returns.
    // Commit version and schema together so a process exit cannot split them.
    await customStatement('PRAGMA user_version = 2');
    await migrationFailureForTest?.call(MigrationCheckpoint.afterVersionWrite);
  });

  Future<void> _requireKnownV1Shape() async {
    // A version number alone cannot authorize dropping unknown columns,
    // triggers or incoming references. v1 shipped exactly these objects.
    const expectedObjects = {
      'table:installations:installations',
      'table:raw_captures:raw_captures',
      'index:raw_captures_occurrence_idx:raw_captures',
    };
    final objects = await customSelect(
      'SELECT type, name, tbl_name FROM sqlite_master '
      "WHERE name NOT GLOB 'sqlite_*'",
    ).get();
    final actualObjects = objects
        .map(
          (row) =>
              '${row.read<String>('type')}:${row.read<String>('name')}:'
              '${row.read<String>('tbl_name')}',
        )
        .toSet();
    final columns = await customSelect('PRAGMA table_xinfo(raw_captures)')
        .get();
    final actualColumns = columns
        .map((row) => row.read<String>('name'))
        .toSet();
    final expectedColumns = _v1RawColumns
        .split(',')
        .map((name) => name.trim())
        .toSet();
    final installationColumns = await customSelect(
      'PRAGMA table_xinfo(installations)',
    ).get();
    final installationNames = installationColumns
        .map((row) => row.read<String>('name'))
        .toSet();
    final references = await customSelect(
      'PRAGMA foreign_key_list(raw_captures)',
    ).get();
    final knownReference =
        references.length == 1 &&
        references.single.read<String>('table') == 'installations' &&
        references.single.read<String>('from') == 'source_installation_id' &&
        references.single.read<String>('to') == 'id' &&
        references.single.read<String>('on_delete') == 'NO ACTION' &&
        references.single.read<String>('on_update') == 'NO ACTION';
    final indexColumns = await customSelect(
      'PRAGMA index_info(raw_captures_occurrence_idx)',
    ).get();
    final knownIndex =
        indexColumns.length == 2 &&
        indexColumns[0].read<String>('name') == 'captured_at_utc_micros' &&
        indexColumns[1].read<String>('name') == 'capture_id';
    if (actualObjects.length != expectedObjects.length ||
        !actualObjects.containsAll(expectedObjects) ||
        actualColumns.length != expectedColumns.length ||
        !actualColumns.containsAll(expectedColumns) ||
        installationNames.length != 2 ||
        !installationNames.containsAll({'id', 'created_at_utc_micros'}) ||
        !knownReference ||
        !knownIndex) {
      throw StateError(
        'Unrecognized version-1 database schema; data retained.',
      );
    }
  }

  Future<void> ensureReady() async {
    await customSelect('SELECT 1').get();
  }

  Future<Map<String, Object?>> pragmaValues() async {
    final foreignKeys = await customSelect('PRAGMA foreign_keys').getSingle();
    final journalMode = await customSelect('PRAGMA journal_mode').getSingle();
    final synchronous = await customSelect('PRAGMA synchronous').getSingle();
    return {
      'foreign_keys': foreignKeys.data['foreign_keys'],
      'journal_mode': journalMode.data['journal_mode'],
      'synchronous': synchronous.data['synchronous'],
    };
  }
}

const _v1RawColumns = '''
  capture_id, raw_text, source_installation_id, captured_at_utc_micros,
  original_offset_minutes, source_time_zone_id, visibility, revision,
  created_at_utc_micros
''';

/// Top-level and static so Drift can invoke it in its background isolate.
void setupCaptureDatabase(sqlite.Database database) {
  database.execute('PRAGMA foreign_keys = ON');
  database.execute('PRAGMA journal_mode = WAL');
  database.execute('PRAGMA synchronous = FULL');
}
