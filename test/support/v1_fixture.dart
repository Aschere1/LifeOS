import 'dart:convert';
import 'dart:io';

import 'package:sqlite3/sqlite3.dart';

/// A deliberately real v1 file: its DDL comes only from Drift's committed
/// v1 schema snapshot, rather than from a hand-maintained test copy.
class V1Fixture {
  V1Fixture._(this.directory, this.file, this.installationId, this.captures);

  final Directory directory;
  final File file;
  final String installationId;
  final List<V1Capture> captures;

  static Future<V1Fixture> create({bool withRows = true}) async {
    final directory = await Directory.systemTemp.createTemp('lifeos_v1_');
    final file = File(
      '${directory.path}${Platform.pathSeparator}lifeos.sqlite',
    );
    const installationId = '2c8434ea-1b1b-4c3d-9e65-55b21c876902';
    const captures = <V1Capture>[
      V1Capture(
        captureId: '0198f9e5-24d4-7000-8000-000000000001',
        rawText: '  \u7b2c\u4e00\u884c\nsecond line  ',
        capturedAtUtcMicros: 1788095940000000,
        originalOffsetMinutes: 480,
        sourceTimeZoneId: 'Asia/Shanghai',
        createdAtUtcMicros: 1788096005000000,
      ),
      V1Capture(
        captureId: '0198f9e5-24d4-7000-8000-000000000002',
        rawText: '\u65c5\u9014\u4e2d\u7684\u539f\u8bdd\u3000\ud83c\udf19',
        capturedAtUtcMicros: 1788134340000000,
        originalOffsetMinutes: -240,
        sourceTimeZoneId: null,
        createdAtUtcMicros: 1788134401000000,
      ),
    ];

    final snapshot = jsonDecode(
      File('drift_schemas/drift_schema_v1.json').readAsStringSync(),
    ) as Map<String, Object?>;
    final database = sqlite3.open(file.path);
    try {
      final fixedSql = snapshot['fixed_sql'] as List<Object?>;
      for (final item in fixedSql.cast<Map<String, Object?>>()) {
        final dialects = item['sql'] as List<Object?>;
        for (final dialect in dialects.cast<Map<String, Object?>>()) {
          if (dialect['dialect'] == 'sqlite') {
            database.execute(dialect['sql']! as String);
          }
        }
      }
      database.execute('PRAGMA user_version = 1');
      if (withRows) {
        database.execute(
          'INSERT INTO installations (id, created_at_utc_micros) VALUES (?, ?)',
          [installationId, 1788090000000000],
        );
        for (final capture in captures) {
          database.execute(
            '''INSERT INTO raw_captures (
              capture_id, raw_text, source_installation_id,
              captured_at_utc_micros, original_offset_minutes,
              source_time_zone_id, visibility, revision, created_at_utc_micros
            ) VALUES (?, ?, ?, ?, ?, ?, 'private', 1, ?)''',
            [
              capture.captureId,
              capture.rawText,
              installationId,
              capture.capturedAtUtcMicros,
              capture.originalOffsetMinutes,
              capture.sourceTimeZoneId,
              capture.createdAtUtcMicros,
            ],
          );
        }
      }
    } finally {
      database.close();
    }
    return V1Fixture._(directory, file, installationId, captures);
  }

  Future<void> dispose() => directory.delete(recursive: true);
}

class V1Capture {
  const V1Capture({
    required this.captureId,
    required this.rawText,
    required this.capturedAtUtcMicros,
    required this.originalOffsetMinutes,
    required this.sourceTimeZoneId,
    required this.createdAtUtcMicros,
  });

  final String captureId;
  final String rawText;
  final int capturedAtUtcMicros;
  final int originalOffsetMinutes;
  final String? sourceTimeZoneId;
  final int createdAtUtcMicros;
}
