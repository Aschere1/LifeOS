import 'dart:async';

import 'package:uuid/uuid.dart';

import 'package:lifeos/src/capture/capture_store.dart';
import 'package:lifeos/src/capture/raw_capture.dart';

/// Test adapter for the same small store contract. It intentionally has no
/// persistence implementation details.
class InMemoryCaptureStore implements CaptureStore {
  InMemoryCaptureStore({Uuid? uuid, DateTime Function()? now})
    : _uuid = uuid ?? const Uuid(),
      _now = now ?? DateTime.now;

  final Uuid _uuid;
  final DateTime Function() _now;
  final List<RawCapture> _captures = [];
  final StreamController<void> _changes = StreamController<void>.broadcast();
  String? _installationId;
  bool failWrites = false;
  bool failReads = false;

  @override
  Future<RawCapture> saveRawText(String rawText) async {
    if (rawText.isEmpty) {
      throw const EmptyRawCaptureFailure();
    }
    if (failWrites) {
      throw const LocalStorageFailure();
    }
    final localNow = _now();
    final capture = RawCapture(
      captureId: _uuid.v7(),
      rawText: rawText,
      sourceInstallationId: _installationId ??= _uuid.v4(),
      capturedAtUtcMicros: localNow.toUtc().microsecondsSinceEpoch,
      originalOffsetMinutes: localNow.timeZoneOffset.inMinutes,
      sourceTimeZoneId: null,
      visibility: CaptureVisibility.private,
      revision: 1,
      createdAtUtcMicros: _now().toUtc().microsecondsSinceEpoch,
    );
    _captures.add(capture);
    _changes.add(null);
    return capture;
  }

  @override
  Stream<List<RawCapture>> watchCaptures({
    required DateTime startInclusive,
    required DateTime endExclusive,
  }) {
    if (failReads) {
      return Stream.error(const LocalStorageFailure());
    }
    final startMicros = startInclusive.toUtc().microsecondsSinceEpoch;
    final endMicros = endExclusive.toUtc().microsecondsSinceEpoch;

    List<RawCapture> query() {
      final captures = _captures
          .where(
            (capture) =>
                capture.capturedAtUtcMicros >= startMicros &&
                capture.capturedAtUtcMicros < endMicros,
          )
          .toList();
      captures.sort((a, b) {
        final byTime = a.capturedAtUtcMicros.compareTo(b.capturedAtUtcMicros);
        return byTime != 0 ? byTime : a.captureId.compareTo(b.captureId);
      });
      return captures;
    }

    return Stream<List<RawCapture>>.multi((controller) {
      controller.add(query());
      final subscription = _changes.stream.listen(
        (_) => controller.add(query()),
      );
      controller.onCancel = subscription.cancel;
    });
  }

  @override
  Future<void> close() => _changes.close();
}
