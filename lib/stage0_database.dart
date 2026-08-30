import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';

part 'stage0_database.g.dart';

/// The v1 raw boundary. It is intentionally never modified by the v2 probe.
class RawCaptures extends Table {
  TextColumn get captureId => text().named('capture_id')();
  TextColumn get rawText => text().named('raw_text')();
  TextColumn get sourceInstallationId =>
      text().named('source_installation_id')();
  IntColumn get capturedAtUtcMicros =>
      integer().named('captured_at_utc_micros')();
  IntColumn get originalOffsetMinutes =>
      integer().named('original_offset_minutes')();
  TextColumn get sourceTimeZoneId =>
      text().named('source_time_zone_id').nullable()();
  TextColumn get visibility => text()();
  IntColumn get revision => integer()();
  IntColumn get createdAtUtcMicros =>
      integer().named('created_at_utc_micros')();

  @override
  Set<Column<Object>> get primaryKey => {captureId};

  @override
  String get tableName => 'raw_captures';
}

class RawMediaReferences extends Table {
  TextColumn get mediaId => text().named('media_id')();
  TextColumn get captureId =>
      text().named('capture_id').references(RawCaptures, #captureId)();
  TextColumn get relativePath => text().named('relative_path')();
  TextColumn get sha256 => text()();
  IntColumn get byteLength => integer().named('byte_length')();
  TextColumn get mimeType => text().named('mime_type').nullable()();
  TextColumn get codec => text().nullable()();
  IntColumn get durationMillis =>
      integer().named('duration_millis').nullable()();
  IntColumn get createdAtUtcMicros =>
      integer().named('created_at_utc_micros')();

  @override
  Set<Column<Object>> get primaryKey => {mediaId};

  @override
  String get tableName => 'raw_media_references';
}

/// A v2-only boundary for generated metadata. It has no writable path to raw.
class DerivedArtifacts extends Table {
  TextColumn get artifactId => text().named('artifact_id')();
  TextColumn get sourceCaptureId =>
      text().named('source_capture_id').references(RawCaptures, #captureId)();
  TextColumn get artifactKind => text().named('artifact_kind')();
  TextColumn get content => text()();
  TextColumn get provenance => text()();
  IntColumn get createdAtUtcMicros =>
      integer().named('created_at_utc_micros')();

  @override
  Set<Column<Object>> get primaryKey => {artifactId};

  @override
  String get tableName => 'derived_artifacts';
}

@DriftDatabase(tables: [RawCaptures, RawMediaReferences, DerivedArtifacts])
class Stage0Database extends _$Stage0Database {
  Stage0Database(File file) : super(NativeDatabase.createInBackground(file));

  @override
  int get schemaVersion => 2;

  @override
  MigrationStrategy get migration => MigrationStrategy(
    onCreate: (migrator) async => migrator.createAll(),
    onUpgrade: (migrator, from, to) async {
      if (from < 2) {
        await migrator.createTable(derivedArtifacts);
      }
    },
    beforeOpen: (details) async {
      await customStatement('PRAGMA foreign_keys = ON');
    },
  );
}
