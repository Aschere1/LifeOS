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
const _sourceDeviceId = 'PROTOTYPE-WINDOWS-DEVICE';
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
        steps.add('drift_v2_migrated_raw_preserved');

        await migratedDatabase
            .into(migratedDatabase.derivedArtifacts)
            .insert(
              DerivedArtifactsCompanion.insert(
                id: _artifactId,
                captureId: _captureId,
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
        artifact = await (reopenedDatabase.select(
          reopenedDatabase.derivedArtifacts,
        )..where((row) => row.id.equals(_artifactId))).getSingleOrNull();
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
          id TEXT NOT NULL PRIMARY KEY,
          raw_text TEXT NOT NULL,
          source_device_id TEXT NOT NULL,
          captured_at_utc_micros INTEGER NOT NULL,
          original_offset_minutes INTEGER NOT NULL,
          source_time_zone TEXT,
          visibility TEXT NOT NULL,
          revision INTEGER NOT NULL,
          created_at_utc_micros INTEGER NOT NULL
        )
      ''');
      database.execute('''
        CREATE TABLE raw_media_references (
          id TEXT NOT NULL PRIMARY KEY,
          capture_id TEXT NOT NULL REFERENCES raw_captures(id),
          relative_path TEXT NOT NULL,
          sha256 TEXT NOT NULL,
          byte_length INTEGER NOT NULL,
          mime_type TEXT NOT NULL,
          codec TEXT,
          created_at_utc_micros INTEGER NOT NULL
        )
      ''');
      final statement = database.prepare('''
        INSERT INTO raw_captures (
          id, raw_text, source_device_id, captured_at_utc_micros,
          original_offset_minutes, source_time_zone, visibility, revision,
          created_at_utc_micros
        ) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)
      ''');
      try {
        statement.execute([
          _captureId,
          _prototypeRawText,
          _sourceDeviceId,
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
    )..where((row) => row.id.equals(_captureId))).getSingle();
    final restoredHash = sha256.convert(utf8.encode(raw.rawText)).toString();
    if (raw.rawText != _prototypeRawText ||
        restoredHash != rawHash ||
        raw.sourceDeviceId != _sourceDeviceId ||
        raw.capturedAtUtcMicros != _capturedAtUtcMicros ||
        raw.originalOffsetMinutes != _offsetMinutes ||
        raw.sourceTimeZone != _timeZone ||
        raw.visibility != 'private' ||
        raw.revision != 1 ||
        raw.createdAtUtcMicros != _createdAtUtcMicros) {
      throw StateError('raw capture changed during migration');
    }
  }
}
