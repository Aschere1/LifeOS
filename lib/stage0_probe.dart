import 'dart:convert';
import 'dart:io';

import 'package:crypto/crypto.dart';
import 'package:sqlite3/sqlite3.dart' as sqlite;

import 'stage0_database.dart';

const _databaseName = 'PROTOTYPE_stage0_lifeos.sqlite';
const _captureId = '018f0000-0000-7000-8000-000000000001';
const _artifactId = '018f0000-0000-7000-8000-000000000002';
const _prototypeRawText =
    'PROTOTYPE ONLY: Stage 0 raw capture; never user data.';
const _sourceInstallationId = '123e4567-e89b-42d3-a456-426614174000';
const _capturedAtUtcMicros = 1735689600123456;
const _createdAtUtcMicros = 1735689601123456;
const _offsetMinutes = 480;
const _timeZone = 'Asia/Shanghai';

class Stage0ProbeResult {
  const Stage0ProbeResult({
    required this.ok,
    required this.databasePath,
    required this.expectedRawSha256,
    required this.userVersion,
    required this.steps,
    this.verifiedRawSha256,
    this.rawValuePreserved,
    this.derivedArtifactPresent,
    this.error,
  });

  final bool ok;
  final String databasePath;
  final String expectedRawSha256;
  final int? userVersion;
  final List<String> steps;
  final String? verifiedRawSha256;
  final bool? rawValuePreserved;
  final bool? derivedArtifactPresent;
  final String? error;

  Map<String, Object?> toJson() => {
    'probe': 'lifeos-stage0-persistence-migration',
    'status': ok ? 'PASS' : 'FAIL',
    'database_name': _databaseName,
    'database_path': databasePath,
    'expected_raw_sha256': expectedRawSha256,
    if (verifiedRawSha256 != null) 'verified_raw_sha256': verifiedRawSha256,
    if (rawValuePreserved != null) 'raw_value_preserved': rawValuePreserved,
    'user_version': userVersion,
    if (derivedArtifactPresent != null)
      'derived_artifact_present': derivedArtifactPresent,
    'steps': steps,
    if (error != null) 'error': error,
  };
}

class Stage0Probe {
  Future<Stage0ProbeResult> run() async {
    final steps = <String>[];
    final rawHash = sha256.convert(utf8.encode(_prototypeRawText)).toString();
    final dataDirectory = _resolveProbeDirectory();
    final databaseFile = File(
      '${dataDirectory.path}${Platform.pathSeparator}$_databaseName',
    );

    try {
      await dataDirectory.create(recursive: true);
      if (await databaseFile.exists()) {
        await databaseFile.delete();
      }
      steps.add('cleared_fixed_probe_database');

      _createV1Database(databaseFile.path);
      steps.add('v1_created_and_closed');

      final migratedDatabase = Stage0Database(databaseFile);
      try {
        await migratedDatabase.customSelect('SELECT 1').get();
        await _assertRawPreserved(migratedDatabase, rawHash);
        await _assertRawMediaSchema(migratedDatabase);
        steps.add('drift_v2_migrated_raw_preserved');
        steps.add('raw_media_schema_contract_verified_after_migration');

        await migratedDatabase
            .into(migratedDatabase.derivedArtifacts)
            .insert(
              DerivedArtifactsCompanion.insert(
                artifactId: _artifactId,
                sourceCaptureId: _captureId,
                artifactKind: 'prototype_metadata',
                content: 'Derived probe artifact; not a user record.',
                provenance: 'stage0_probe',
                createdAtUtcMicros: _createdAtUtcMicros + 1,
              ),
            );
      } finally {
        await migratedDatabase.close();
      }
      steps.add('derived_artifact_written_and_closed');

      final reopenedDatabase = Stage0Database(databaseFile);
      final DerivedArtifact? artifact;
      final int userVersion;
      try {
        await reopenedDatabase.customSelect('SELECT 1').get();
        await _assertRawPreserved(reopenedDatabase, rawHash);
        await _assertRawMediaSchema(reopenedDatabase);
        artifact =
            await (reopenedDatabase.select(reopenedDatabase.derivedArtifacts)
                  ..where((row) => row.artifactId.equals(_artifactId)))
                .getSingleOrNull();
        final versionRows = await reopenedDatabase
            .customSelect('PRAGMA user_version')
            .get();
        userVersion = versionRows.single.read<int>('user_version');
      } finally {
        await reopenedDatabase.close();
      }

      if (artifact == null || userVersion != 2) {
        throw StateError('reopen verification failed');
      }
      steps.add('reopened_raw_and_derived_verified');
      steps.add('raw_media_schema_contract_verified_after_reopen');
      return Stage0ProbeResult(
        ok: true,
        databasePath: databaseFile.path,
        expectedRawSha256: rawHash,
        userVersion: userVersion,
        verifiedRawSha256: rawHash,
        rawValuePreserved: true,
        derivedArtifactPresent: true,
        steps: steps,
      );
    } catch (error) {
      return Stage0ProbeResult(
        ok: false,
        databasePath: databaseFile.path,
        expectedRawSha256: rawHash,
        userVersion: null,
        steps: steps,
        error: error.toString(),
      );
    }
  }

  Directory _resolveProbeDirectory() {
    final configured = Platform.environment['LIFEOS_STAGE0_DATA_DIR'];
    return Directory(
      configured ??
          '${Directory.current.path}${Platform.pathSeparator}build${Platform.pathSeparator}stage0-probe-data',
    );
  }

  void _createV1Database(String path) {
    final database = sqlite.sqlite3.open(path);
    try {
      database.execute('PRAGMA foreign_keys = ON');
      database.execute('''
        CREATE TABLE raw_captures (
          capture_id TEXT NOT NULL PRIMARY KEY,
          raw_text TEXT NOT NULL,
          source_installation_id TEXT NOT NULL,
          captured_at_utc_micros INTEGER NOT NULL,
          original_offset_minutes INTEGER NOT NULL,
          source_time_zone_id TEXT,
          visibility TEXT NOT NULL,
          revision INTEGER NOT NULL,
          created_at_utc_micros INTEGER NOT NULL
        )
      ''');
      database.execute('''
        CREATE TABLE raw_media_references (
          media_id TEXT NOT NULL PRIMARY KEY,
          capture_id TEXT NOT NULL REFERENCES raw_captures(capture_id),
          relative_path TEXT NOT NULL,
          sha256 TEXT NOT NULL,
          byte_length INTEGER NOT NULL,
          mime_type TEXT,
          codec TEXT,
          duration_millis INTEGER,
          created_at_utc_micros INTEGER NOT NULL
        )
      ''');
      final statement = database.prepare('''
        INSERT INTO raw_captures (
          capture_id, raw_text, source_installation_id, captured_at_utc_micros,
          original_offset_minutes, source_time_zone_id, visibility, revision,
          created_at_utc_micros
        ) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)
      ''');
      try {
        statement.execute([
          _captureId,
          _prototypeRawText,
          _sourceInstallationId,
          _capturedAtUtcMicros,
          _offsetMinutes,
          _timeZone,
          'private',
          1,
          _createdAtUtcMicros,
        ]);
      } finally {
        statement.close();
      }
      database.execute('PRAGMA user_version = 1');
    } finally {
      database.close();
    }
  }

  Future<void> _assertRawPreserved(
    Stage0Database database,
    String rawHash,
  ) async {
    final raw = await (database.select(
      database.rawCaptures,
    )..where((row) => row.captureId.equals(_captureId))).getSingle();
    final restoredHash = sha256.convert(utf8.encode(raw.rawText)).toString();
    if (raw.rawText != _prototypeRawText ||
        restoredHash != rawHash ||
        raw.sourceInstallationId != _sourceInstallationId ||
        raw.capturedAtUtcMicros != _capturedAtUtcMicros ||
        raw.originalOffsetMinutes != _offsetMinutes ||
        raw.sourceTimeZoneId != _timeZone ||
        raw.visibility != 'private' ||
        raw.revision != 1 ||
        raw.createdAtUtcMicros != _createdAtUtcMicros) {
      throw StateError('raw capture changed during migration');
    }
  }

  Future<void> _assertRawMediaSchema(Stage0Database database) async {
    final columns = await database
        .customSelect('PRAGMA table_info(raw_media_references)')
        .get();
    final expectedColumns = <String, ({bool nullable, int primaryKey})>{
      'media_id': (nullable: false, primaryKey: 1),
      'capture_id': (nullable: false, primaryKey: 0),
      'relative_path': (nullable: false, primaryKey: 0),
      'sha256': (nullable: false, primaryKey: 0),
      'byte_length': (nullable: false, primaryKey: 0),
      'mime_type': (nullable: true, primaryKey: 0),
      'codec': (nullable: true, primaryKey: 0),
      'duration_millis': (nullable: true, primaryKey: 0),
      'created_at_utc_micros': (nullable: false, primaryKey: 0),
    };
    if (columns.length != expectedColumns.length) {
      throw StateError('raw media schema column count changed');
    }
    for (final column in columns) {
      final name = column.read<String>('name');
      final expected = expectedColumns[name];
      if (expected == null ||
          (column.read<int>('notnull') == 0) != expected.nullable ||
          column.read<int>('pk') != expected.primaryKey) {
        throw StateError('raw media schema contract changed');
      }
    }
    final foreignKeys = await database
        .customSelect('PRAGMA foreign_key_list(raw_media_references)')
        .get();
    final captureForeignKey = foreignKeys.where(
      (foreignKey) =>
          foreignKey.read<String>('from') == 'capture_id' &&
          foreignKey.read<String>('table') == 'raw_captures' &&
          foreignKey.read<String>('to') == 'capture_id',
    );
    if (captureForeignKey.length != 1) {
      throw StateError('raw media capture foreign key changed');
    }
  }
}
