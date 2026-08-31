import 'dart:io';

import 'package:drift/drift.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';
import 'package:uuid/uuid.dart';

import '../capture/capture_store.dart';
import '../capture/raw_capture.dart';
import 'capture_database.dart';

typedef CaptureClock = DateTime Function();
typedef SourceTimeZoneProvider = String? Function();
typedef OriginalOffsetProvider = int Function(DateTime captureTime);
typedef BeforeRawCaptureInsertHook = Future<void> Function();

class DriftCaptureStore implements CaptureStore {
  DriftCaptureStore._(
    this._database,
    this._uuid,
    this._clock,
    this._sourceTimeZoneProvider,
    this._originalOffsetProvider,
    this._beforeRawCaptureInsertForTest,
  );

  final CaptureDatabase _database;
  final Uuid _uuid;
  final CaptureClock _clock;
  final SourceTimeZoneProvider _sourceTimeZoneProvider;
  final OriginalOffsetProvider _originalOffsetProvider;
  final BeforeRawCaptureInsertHook? _beforeRawCaptureInsertForTest;
  String? _installationId;

  static Future<DriftCaptureStore> openProduction() async {
    final supportDirectory = await _productionDataDirectory();
    await supportDirectory.create(recursive: true);
    return openFile(File(path.join(supportDirectory.path, 'lifeos.sqlite')));
  }

  static Future<DriftCaptureStore> openFile(
    File file, {
    Uuid? uuid,
    CaptureClock? clock,
    SourceTimeZoneProvider? sourceTimeZoneProvider,
    OriginalOffsetProvider? originalOffsetProvider,
  }) async {
    await file.parent.create(recursive: true);
    final database = CaptureDatabase.openFile(file);
    try {
      await database.ensureReady();
      return DriftCaptureStore._(
        database,
        uuid ?? const Uuid(),
        clock ?? DateTime.now,
        sourceTimeZoneProvider ?? _unknownTimeZone,
        originalOffsetProvider ?? _deviceOffset,
        null,
      );
    } catch (_) {
      await database.close();
      rethrow;
    }
  }

  /// Uses Drift's real SQLite executor while keeping test files ephemeral.
  static Future<DriftCaptureStore> openInMemoryForTest({
    Uuid? uuid,
    CaptureClock? clock,
    SourceTimeZoneProvider? sourceTimeZoneProvider,
    OriginalOffsetProvider? originalOffsetProvider,
    BeforeRawCaptureInsertHook? beforeRawCaptureInsertForTest,
  }) async {
    final database = CaptureDatabase.inMemory();
    await database.ensureReady();
    return DriftCaptureStore._(
      database,
      uuid ?? const Uuid(),
      clock ?? DateTime.now,
      sourceTimeZoneProvider ?? _unknownTimeZone,
      originalOffsetProvider ?? _deviceOffset,
      beforeRawCaptureInsertForTest,
    );
  }

  @override
  Future<RawCapture> saveRawText(String rawText) async {
    if (rawText.isEmpty) {
      throw const EmptyRawCaptureFailure();
    }

    try {
      final localCaptureTime = _clock();
      final captureId = _uuid.v7();
      final cachedInstallationId = _installationId;
      late RawCapture capture;
      late String committedInstallationId;

      await _database.transaction(() async {
        final createdAtUtcMicros = _clock().toUtc().microsecondsSinceEpoch;
        final installationId =
            cachedInstallationId ??
            await _getOrCreateInstallationId(createdAtUtcMicros);
        capture = RawCapture(
          captureId: captureId,
          rawText: rawText,
          sourceInstallationId: installationId,
          capturedAtUtcMicros: localCaptureTime.toUtc().microsecondsSinceEpoch,
          originalOffsetMinutes: _originalOffsetProvider(localCaptureTime),
          sourceTimeZoneId: _sourceTimeZoneProvider(),
          visibility: CaptureVisibility.private,
          revision: 1,
          createdAtUtcMicros: createdAtUtcMicros,
        );
        await _beforeRawCaptureInsertForTest?.call();
        await _database
            .into(_database.rawCaptureRows)
            .insert(
              RawCaptureRowsCompanion.insert(
                captureId: capture.captureId,
                rawText: capture.rawText,
                sourceInstallationId: capture.sourceInstallationId,
                capturedAtUtcMicros: capture.capturedAtUtcMicros,
                originalOffsetMinutes: capture.originalOffsetMinutes,
                sourceTimeZoneId: Value(capture.sourceTimeZoneId),
                visibility: capture.visibility.name,
                revision: capture.revision,
                createdAtUtcMicros: capture.createdAtUtcMicros,
              ),
            );
        committedInstallationId = installationId;
      });
      _installationId ??= committedInstallationId;
      return capture;
    } on CaptureStoreFailure {
      rethrow;
    } catch (_) {
      throw const LocalStorageFailure();
    }
  }

  @override
  Stream<List<RawCapture>> watchCaptures({
    required DateTime startInclusive,
    required DateTime endExclusive,
  }) {
    final startMicros = startInclusive.toUtc().microsecondsSinceEpoch;
    final endMicros = endExclusive.toUtc().microsecondsSinceEpoch;
    final query = _database.select(_database.rawCaptureRows)
      ..where(
        (row) =>
            row.capturedAtUtcMicros.isBiggerOrEqualValue(startMicros) &
            row.capturedAtUtcMicros.isSmallerThanValue(endMicros),
      )
      ..orderBy([
        (row) => OrderingTerm.asc(row.capturedAtUtcMicros),
        (row) => OrderingTerm.asc(row.captureId),
      ]);
    return query.watch().map((rows) => rows.map(_toRawCapture).toList());
  }

  Future<String> _getOrCreateInstallationId(int createdAtUtcMicros) async {
    final existing = await _database
        .select(_database.installations)
        .getSingleOrNull();
    if (existing != null) {
      return existing.id;
    }
    final id = _uuid.v4();
    await _database
        .into(_database.installations)
        .insert(
          InstallationsCompanion.insert(
            id: id,
            createdAtUtcMicros: createdAtUtcMicros,
          ),
        );
    return id;
  }

  RawCapture _toRawCapture(RawCaptureRow row) => RawCapture(
    captureId: row.captureId,
    rawText: row.rawText,
    sourceInstallationId: row.sourceInstallationId,
    capturedAtUtcMicros: row.capturedAtUtcMicros,
    originalOffsetMinutes: row.originalOffsetMinutes,
    sourceTimeZoneId: row.sourceTimeZoneId,
    visibility: CaptureVisibility.private,
    revision: row.revision,
    createdAtUtcMicros: row.createdAtUtcMicros,
  );

  @override
  Future<void> close() => _database.close();

  Future<Map<String, Object?>> pragmaValuesForTest() =>
      _database.pragmaValues();
}

String? _unknownTimeZone() => null;

int _deviceOffset(DateTime captureTime) => captureTime.timeZoneOffset.inMinutes;

Future<Directory> _productionDataDirectory() async {
  if (!Platform.isWindows) {
    return getApplicationSupportDirectory();
  }

  final localAppData = Platform.environment['LOCALAPPDATA'];
  if (localAppData == null || localAppData.isEmpty) {
    throw const FileSystemException(
      'Windows LocalAppData directory is unavailable.',
    );
  }
  return Directory(path.join(localAppData, 'com.aschere', 'lifeos'));
}
