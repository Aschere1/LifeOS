import 'raw_capture.dart';

abstract interface class CaptureStore {
  /// Saves [rawText] exactly as supplied. An empty string is not a capture.
  Future<RawCapture> saveRawText(String rawText);

  /// Observes captures in the explicit UTC interval [startInclusive, endExclusive).
  Stream<List<RawCapture>> watchCaptures({
    required DateTime startInclusive,
    required DateTime endExclusive,
  });

  Future<void> close();
}

sealed class CaptureStoreFailure implements Exception {
  const CaptureStoreFailure();

  String get userMessage;
}

final class EmptyRawCaptureFailure extends CaptureStoreFailure {
  const EmptyRawCaptureFailure();

  @override
  String get userMessage => '请输入内容后再保存。';
}

/// Deliberately content-free: errors and logs must never reveal raw text.
final class LocalStorageFailure extends CaptureStoreFailure {
  const LocalStorageFailure();

  @override
  String get userMessage => '暂时无法保存到本机，请重试。';
}
