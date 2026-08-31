enum CaptureVisibility { private }

/// An immutable, user-authored source record. It is not a task, session, or
/// canonical record.
class RawCapture {
  const RawCapture({
    required this.captureId,
    required this.rawText,
    required this.sourceInstallationId,
    required this.capturedAtUtcMicros,
    required this.originalOffsetMinutes,
    required this.sourceTimeZoneId,
    required this.visibility,
    required this.revision,
    required this.createdAtUtcMicros,
  });

  final String captureId;
  final String rawText;
  final String sourceInstallationId;
  final int capturedAtUtcMicros;
  final int originalOffsetMinutes;
  final String? sourceTimeZoneId;
  final CaptureVisibility visibility;
  final int revision;
  final int createdAtUtcMicros;

  DateTime get capturedAtUtc =>
      DateTime.fromMicrosecondsSinceEpoch(capturedAtUtcMicros, isUtc: true);
}
