import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:sqlite3/sqlite3.dart' as sqlite;

part 'capture_database.g.dart';

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
    'CHECK (length(raw_text) > 0)',
    "CHECK (visibility = 'private')",
    'CHECK (revision = 1)',
  ];
}

@DriftDatabase(tables: [Installations, RawCaptureRows])
class CaptureDatabase extends _$CaptureDatabase {
  CaptureDatabase(super.executor);

  factory CaptureDatabase.openFile(File file) {
    return CaptureDatabase(
      NativeDatabase.createInBackground(file, setup: setupCaptureDatabase),
    );
  }

  factory CaptureDatabase.inMemory() {
    return CaptureDatabase(NativeDatabase.memory(setup: setupCaptureDatabase));
  }

  @override
  int get schemaVersion => 1;

  @override
  MigrationStrategy get migration => MigrationStrategy(
    onCreate: (migrator) async => migrator.createAll(),
    onUpgrade: (migrator, from, to) async {
      throw UnsupportedError('No schema upgrades exist at version 1.');
    },
  );

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

/// Top-level and static so Drift can invoke it in its background isolate.
void setupCaptureDatabase(sqlite.Database database) {
  database.execute('PRAGMA foreign_keys = ON');
  database.execute('PRAGMA journal_mode = WAL');
  database.execute('PRAGMA synchronous = FULL');
}
