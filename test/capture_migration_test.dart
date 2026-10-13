import 'dart:io';

import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lifeos/src/persistence/capture_database.dart';
import 'package:lifeos/src/persistence/drift_capture_store.dart';
import 'package:sqlite3/sqlite3.dart';

import 'support/v1_fixture.dart';

void main() {
  group('CaptureDatabase v1 to v2 migration', () {
    test('preserves every v1 raw field, then reopens and saves text', () async {
      final fixture = await V1Fixture.create();
      addTearDown(fixture.dispose);

      // Exercise the production background-isolate executor against a real v1
      // file before using any foreground executor in migration diagnostics.
      final firstOpen = await DriftCaptureStore.openFile(fixture.file);
      await firstOpen.close();
      expect(_rawSnapshot(fixture.file), [
        for (final row in fixture.captures)
          [
            row.captureId,
            row.rawText,
            fixture.installationId,
            row.capturedAtUtcMicros,
            row.originalOffsetMinutes,
            row.sourceTimeZoneId,
            'private',
            1,
            row.createdAtUtcMicros,
            'text',
          ],
      ]);
      expect(_installations(fixture.file), [
        [fixture.installationId, 1788090000000000],
      ]);

      // A second production open must be a no-op, including the schema version.
      final store = await DriftCaptureStore.openFile(
        fixture.file,
        clock: () => DateTime.utc(2026, 8, 31, 1),
      );
      addTearDown(store.close);
      expect(_userVersion(fixture.file), 2);
      expect(_rawSnapshot(fixture.file).take(fixture.captures.length), [
        for (final row in fixture.captures)
          [
            row.captureId,
            row.rawText,
            fixture.installationId,
            row.capturedAtUtcMicros,
            row.originalOffsetMinutes,
            row.sourceTimeZoneId,
            'private',
            1,
            row.createdAtUtcMicros,
            'text',
          ],
      ]);

      final added = await store.saveRawText('new text remains text');
      expect(added.sourceInstallationId, fixture.installationId);
      expect(_rawSnapshot(fixture.file).last[1], 'new text remains text');
      expect(_rawSnapshot(fixture.file).last[9], 'text');
    });

    test(
      'fresh and upgraded databases have equivalent schema, indexes and FKs',
      () async {
        final fixture = await V1Fixture.create();
        addTearDown(fixture.dispose);
        await _openAndClose(fixture.file);

        final freshDirectory = await Directory.systemTemp.createTemp(
          'lifeos_v2_',
        );
        addTearDown(() => freshDirectory.delete(recursive: true));
        final fresh = File(
          '${freshDirectory.path}${Platform.pathSeparator}fresh.sqlite',
        );
        await _openAndClose(fresh);

        expect(_schemaShape(fixture.file), _schemaShape(fresh));
      },
    );

    for (final checkpoint in MigrationCheckpoint.values) {
      test(
        'failure at $checkpoint rolls back entirely and retry succeeds',
        () async {
          final fixture = await V1Fixture.create();
          addTearDown(fixture.dispose);
          final before = _v1State(fixture.file);
          var reachedCheckpoint = false;
          final database = CaptureDatabase(
            NativeDatabase(fixture.file, setup: setupCaptureDatabase),
            migrationFailureForTest: (current) async {
              if (current == checkpoint) {
                reachedCheckpoint = true;
                throw StateError('test migration fault');
              }
            },
          );
          final expectedFault = isA<StateError>().having(
            (error) => error.message,
            'message',
            'test migration fault',
          );
          await expectLater(database.ensureReady(), throwsA(expectedFault));
          expect(reachedCheckpoint, isTrue);
          await expectLater(database.ensureReady(), throwsA(expectedFault));
          await database.close();

          expect(_v1State(fixture.file), before);
          await _openAndClose(fixture.file);
          expect(_userVersion(fixture.file), 2);
          expect(
            _rawSnapshot(fixture.file),
            hasLength(fixture.captures.length),
          );
        },
      );
    }

    test('upgrades an empty v1 database', () async {
      final fixture = await V1Fixture.create(withRows: false);
      addTearDown(fixture.dispose);
      await _openAndClose(fixture.file);
      expect(_userVersion(fixture.file), 2);
      expect(_rawSnapshot(fixture.file), isEmpty);
      expect(
        _tableNames(fixture.file),
        containsAll(['installations', 'raw_captures', 'raw_media']),
      );
    });

    test('rejects an unknown newer version without mutating it', () async {
      final fixture = await V1Fixture.create();
      addTearDown(fixture.dispose);
      _withDatabase(
        fixture.file,
        (db) => db.execute('PRAGMA user_version = 999'),
      );
      final before = _v1State(fixture.file);
      final database = CaptureDatabase(
        NativeDatabase(fixture.file, setup: setupCaptureDatabase),
      );
      await expectLater(
        database.ensureReady(),
        throwsA(
          isA<UnsupportedError>().having(
            (error) => error.message,
            'message',
            'Unsupported local database version transition.',
          ),
        ),
      );
      await database.close();
      expect(_v1State(fixture.file), before);
    });

    test(
      'rejects a pre-existing v1 schema with user_version zero unchanged',
      () async {
        final fixture = await V1Fixture.create();
        addTearDown(fixture.dispose);
        _withDatabase(
          fixture.file,
          (db) => db.execute('PRAGMA user_version = 0'),
        );
        final before = _v1State(fixture.file);
        final database = CaptureDatabase(
          NativeDatabase(fixture.file, setup: setupCaptureDatabase),
        );
        try {
          await expectLater(
            database.ensureReady(),
            throwsA(
              isA<StateError>().having(
                (error) => error.message,
                'message',
                contains('Unversioned database is not empty'),
              ),
            ),
          );
        } finally {
          await database.close();
        }
        expect(_v1State(fixture.file), before);
      },
    );
  });

  group('unknown v1 structures are preserved instead of rebuilt', () {
    final changes = <String, void Function(Database)>{
      'extra raw column': (db) {
        db.execute('ALTER TABLE raw_captures ADD COLUMN extra_fact TEXT');
        db.execute("UPDATE raw_captures SET extra_fact = 'must remain'");
      },
      'extra installation column': (db) {
        db.execute('ALTER TABLE installations ADD COLUMN extra_fact TEXT');
        db.execute("UPDATE installations SET extra_fact = 'must remain'");
      },
      'incoming cascade reference': (db) {
        db.execute('''CREATE TABLE unknown_reference (
          capture_id TEXT REFERENCES raw_captures(capture_id) ON DELETE CASCADE,
          original_fact TEXT NOT NULL)''');
        db.execute('''INSERT INTO unknown_reference
          SELECT capture_id, 'dependent original' FROM raw_captures''');
      },
      'wrong occurrence index': (db) {
        db.execute('DROP INDEX raw_captures_occurrence_idx');
        db.execute('''CREATE INDEX raw_captures_occurrence_idx
          ON raw_captures (raw_text)''');
      },
    };
    for (final change in changes.entries) {
      test('rejects ${change.key} without changing facts', () async {
        final fixture = await V1Fixture.create();
        addTearDown(fixture.dispose);
        _withDatabase(fixture.file, change.value);
        final before = _v1State(fixture.file);
        final database = CaptureDatabase.openFile(fixture.file);
        try {
          await expectLater(
            database.ensureReady(),
            throwsA(
              isA<Exception>().having(
                (error) => error.toString(),
                'remote cause',
                'Bad state: Unrecognized version-1 database schema; data retained.',
              ),
            ),
          );
        } finally {
          await database.close();
        }
        expect(_v1State(fixture.file), before);
        if (change.key == 'incoming cascade reference') {
          expect(
            _withDatabase(
              fixture.file,
              (db) => db
                  .select(
                    'SELECT original_fact FROM unknown_reference ORDER BY capture_id',
                  )
                  .map((row) => row.values.single)
                  .toList(),
            ),
            ['dependent original', 'dependent original'],
          );
        }
      });
    }
  });

  group('v2 raw payload and media constraints', () {
    test('enforces payload, media reference and metadata invariants', () async {
      final directory = await Directory.systemTemp.createTemp(
        'lifeos_constraints_',
      );
      addTearDown(() => directory.delete(recursive: true));
      final file = File('${directory.path}${Platform.pathSeparator}v2.sqlite');
      await _openAndClose(file);
      final id = '0198f9e5-24d4-7000-8000-000000000099';
      _withDatabase(file, (db) {
        db.execute('PRAGMA foreign_keys = ON');
        db.execute("INSERT INTO installations VALUES ('install', 1)");
        void raw(String captureId, String text, String kind) => db.execute(
          '''INSERT INTO raw_captures (
                capture_id, raw_text, source_installation_id,
                captured_at_utc_micros, original_offset_minutes,
                source_time_zone_id, visibility, revision,
                created_at_utc_micros, payload_kind
              ) VALUES (?, ?, 'install', 1, 0, NULL, 'private', 1, 1, ?)''',
          [captureId, text, kind],
        );
        raw(id, 'valid text', 'text');
        expect(
          () => raw('bad-empty', '', 'text'),
          throwsA(isA<SqliteException>()),
        );
        expect(
          () => raw('bad-kind', 'x', 'other'),
          throwsA(isA<SqliteException>()),
        );
        expect(
          () => raw('bad-voice', 'not empty', 'voice'),
          throwsA(isA<SqliteException>()),
        );

        String voiceCapture(String suffix) {
          final captureId = 'voice-$suffix';
          raw(captureId, '', 'voice');
          return captureId;
        }

        void media({
          String mediaId = '0198f9e5-24d4-7000-8000-000000000100',
          String? captureId,
          String path = 'raw/one.m4a',
          String hash = 'aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa',
          int length = 1,
          int? duration = 0,
        }) => db.execute(
          '''INSERT INTO raw_media VALUES (?, ?, ?, ?, ?, NULL, NULL, ?, 2)''',
          [mediaId, captureId ?? id, path, hash, length, duration],
        );
        // Unknown recorder metadata is explicitly legal, rather than guessed.
        media(duration: null);
        expect(
          () => media(mediaId: 'fk', captureId: 'missing', path: 'raw/fk.m4a'),
          throwsA(isA<SqliteException>()),
        );
        expect(
          () => media(
            mediaId: 'hash',
            captureId: voiceCapture('hash'),
            path: 'raw/hash.m4a',
            hash: 'A' * 64,
          ),
          throwsA(isA<SqliteException>()),
        );
        expect(
          () => media(
            mediaId: 'length',
            captureId: voiceCapture('length'),
            path: 'raw/length.m4a',
            length: 0,
          ),
          throwsA(isA<SqliteException>()),
        );
        expect(
          () => media(
            mediaId: 'duration',
            captureId: voiceCapture('duration'),
            path: 'raw/duration.m4a',
            duration: -1,
          ),
          throwsA(isA<SqliteException>()),
        );
        expect(
          () => media(
            mediaId: 'path',
            captureId: voiceCapture('path'),
            path: 'raw/one.m4a',
          ),
          throwsA(isA<SqliteException>()),
        );
        expect(
          () => media(
            mediaId: 'empty-path',
            captureId: voiceCapture('empty-path'),
            path: '',
          ),
          throwsA(isA<SqliteException>()),
        );
        expect(
          () => media(mediaId: 'capture', path: 'raw/capture.m4a'),
          throwsA(isA<SqliteException>()),
        );
        db.execute('DELETE FROM raw_captures WHERE capture_id = ?', [id]);
        expect(
          db.select('SELECT * FROM raw_media WHERE capture_id = ?', [id]),
          isEmpty,
        );
      });
    });
  });
}

Future<void> _openAndClose(File file) async {
  final database = CaptureDatabase(
    NativeDatabase(file, setup: setupCaptureDatabase),
  );
  try {
    await database.ensureReady();
  } finally {
    await database.close();
  }
}

T _withDatabase<T>(File file, T Function(Database database) action) {
  final database = sqlite3.open(file.path);
  try {
    return action(database);
  } finally {
    database.close();
  }
}

int _userVersion(File file) => _withDatabase(
  file,
  (db) => db.select('PRAGMA user_version').single.values.single as int,
);

List<List<Object?>> _rawSnapshot(File file) => _withDatabase(
  file,
  (db) => db
      .select('''SELECT capture_id, raw_text, source_installation_id,
    captured_at_utc_micros, original_offset_minutes, source_time_zone_id,
    visibility, revision, created_at_utc_micros, payload_kind
    FROM raw_captures ORDER BY capture_id''')
      .map((row) => row.values)
      .toList(),
);

List<List<Object?>> _installations(File file) => _withDatabase(
  file,
  (db) => db
      .select('SELECT * FROM installations ORDER BY id')
      .map((row) => row.values)
      .toList(),
);

Map<String, Object?> _v1State(File file) => {
  'version': _userVersion(file),
  'tables': _tableNames(file),
  'sqliteMaster': _withDatabase(
    file,
    (db) => db
        .select('''SELECT type, name, tbl_name, sql FROM sqlite_master
          WHERE type IN ('table', 'index') ORDER BY type, name''')
        .map((row) => row.values)
        .toList(),
  ),
  'raw': _withDatabase(
    file,
    (db) => db
        .select('SELECT * FROM raw_captures ORDER BY capture_id')
        .map((row) => row.values)
        .toList(),
  ),
  'installations': _installations(file),
};

List<String> _tableNames(File file) => _withDatabase(
  file,
  (db) => db
      .select(
        "SELECT name FROM sqlite_master WHERE type = 'table' ORDER BY name",
      )
      .map((row) => row.values.single as String)
      .toList(),
);

Map<String, Object?> _schemaShape(File file) => _withDatabase(file, (db) {
  List<List<Object?>> pragma(String table, String pragma) =>
      db.select('PRAGMA $pragma($table)').map((row) => row.values).toList();
  List<List<Object?>> indexes(String table) =>
      db.select('PRAGMA index_list($table)').map((index) {
        final name = index['name']! as String;
        return [
          name,
          index['unique'],
          ...db
              .select('PRAGMA index_info($name)')
              .expand((entry) => entry.values),
        ];
      }).toList();
  return {
    for (final table in ['installations', 'raw_captures', 'raw_media'])
      table: {
        'columns': pragma(table, 'table_info'),
        'foreignKeys': pragma(table, 'foreign_key_list'),
        'indexes': indexes(table),
        'createSql': _normalizedCreateSql(
          db.select(
                "SELECT sql FROM sqlite_master WHERE type = 'table' AND name = ?",
                [table],
              ).single['sql']!
              as String,
        ),
      },
  };
});

String _normalizedCreateSql(String sql) => sql
    .replaceAll(RegExp(r'IF\s+NOT\s+EXISTS', caseSensitive: false), '')
    .replaceAll(RegExp(r'\s+'), ' ')
    .trim();
