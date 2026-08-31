import 'dart:collection';
import 'dart:io';

import 'package:drift/drift.dart' hide isNull;
import 'package:flutter_test/flutter_test.dart';
import 'package:lifeos/src/capture/capture_store.dart';
import 'package:lifeos/src/capture/raw_capture.dart';
import 'package:lifeos/src/persistence/capture_database.dart';
import 'package:lifeos/src/persistence/drift_capture_store.dart';
import 'package:uuid/uuid.dart';

void main() {
  group('DriftCaptureStore with in-memory SQLite', () {
    test('preserves raw text and deterministic occurrence metadata', () async {
      final timestamp = DateTime.utc(2026, 8, 30, 10, 15, 30, 12);
      final store = await DriftCaptureStore.openInMemoryForTest(
        clock: () => timestamp,
        sourceTimeZoneProvider: () => 'Asia/Shanghai',
        originalOffsetProvider: (_) => 480,
      );
      addTearDown(store.close);
      const raw = '  first line\nsecond line  ';

      final capture = await store.saveRawText(raw);

      expect(capture.rawText, raw);
      expect(capture.visibility, CaptureVisibility.private);
      expect(capture.revision, 1);
      expect(capture.capturedAtUtcMicros, timestamp.microsecondsSinceEpoch);
      expect(capture.createdAtUtcMicros, timestamp.microsecondsSinceEpoch);
      expect(capture.originalOffsetMinutes, 480);
      expect(capture.sourceTimeZoneId, 'Asia/Shanghai');
    });

    test('rejects an empty raw payload', () async {
      final store = await DriftCaptureStore.openInMemoryForTest();
      addTearDown(store.close);

      expect(store.saveRawText(''), throwsA(isA<EmptyRawCaptureFailure>()));
    });

    test(
      'uses a stable UUIDv4 installation ID and unique valid UUIDv7 IDs',
      () async {
        final store = await DriftCaptureStore.openInMemoryForTest();
        addTearDown(store.close);

        final first = await store.saveRawText('first');
        final second = await store.saveRawText('second');

        expect(first.sourceInstallationId, second.sourceInstallationId);
        expect(
          Uuid.isValidUUID(fromString: first.sourceInstallationId),
          isTrue,
        );
        expect(first.sourceInstallationId[14], '4');
        expect(first.captureId, isNot(second.captureId));
        expect(Uuid.isValidUUID(fromString: first.captureId), isTrue);
        expect(first.captureId[14], '7');
      },
    );

    test('orders an explicit range by occurrence time', () async {
      final timestamps = Queue<DateTime>.from([
        DateTime.utc(2026, 8, 30, 12),
        DateTime.utc(2026, 8, 30, 12),
        DateTime.utc(2026, 8, 30, 10),
        DateTime.utc(2026, 8, 30, 10),
      ]);
      final store = await DriftCaptureStore.openInMemoryForTest(
        clock: timestamps.removeFirst,
      );
      addTearDown(store.close);
      await store.saveRawText('later');
      await store.saveRawText('earlier');

      final captures = await store
          .watchCaptures(
            startInclusive: DateTime.utc(2026, 8, 30),
            endExclusive: DateTime.utc(2026, 8, 31),
          )
          .first;
      expect(captures.map((capture) => capture.rawText), ['earlier', 'later']);
    });

    test(
      'rolls back an installation and raw row when the first transaction fails',
      () async {
        var attempt = 0;
        final store = await DriftCaptureStore.openInMemoryForTest(
          beforeRawCaptureInsertForTest: () async {
            if (attempt++ == 0) {
              throw StateError('intentional database write failure');
            }
          },
        );
        addTearDown(store.close);
        const raw = 'raw content stays out of failure messages';

        await expectLater(
          store.saveRawText(raw),
          throwsA(
            isA<LocalStorageFailure>().having(
              (failure) => failure.userMessage,
              'user message',
              isNot(contains(raw)),
            ),
          ),
        );
        final retry = await store.saveRawText('retry succeeds');
        final captures = await store
            .watchCaptures(
              startInclusive: DateTime.utc(2000),
              endExclusive: DateTime.utc(2100),
            )
            .first;

        expect(captures.map((capture) => capture.rawText), ['retry succeeds']);
        expect(
          captures.single.sourceInstallationId,
          retry.sourceInstallationId,
        );
      },
    );
  });

  test(
    'file-backed store persists records and its installation ID after reopen',
    () async {
      final directory = await Directory.systemTemp.createTemp(
        'lifeos_capture_test_',
      );
      addTearDown(() => directory.delete(recursive: true));
      final file = File(
        '${directory.path}${Platform.pathSeparator}lifeos.sqlite',
      );
      final firstStore = await DriftCaptureStore.openFile(file);
      final first = await firstStore.saveRawText('kept after close');
      final pragmas = await firstStore.pragmaValuesForTest();
      await firstStore.close();

      final reopenedStore = await DriftCaptureStore.openFile(file);
      addTearDown(reopenedStore.close);
      final second = await reopenedStore.saveRawText('same installation');
      final captures = await reopenedStore
          .watchCaptures(
            startInclusive: DateTime.utc(2000),
            endExclusive: DateTime.utc(2100),
          )
          .first;

      expect(
        captures.map((capture) => capture.rawText),
        containsAll(['kept after close', 'same installation']),
      );
      expect(second.sourceInstallationId, first.sourceInstallationId);
      expect(pragmas['foreign_keys'], 1);
      expect(pragmas['journal_mode'], 'wal');
      expect(pragmas['synchronous'], 2);
    },
  );

  test('foreign-key failure leaves no raw row', () async {
    final database = CaptureDatabase.inMemory();
    addTearDown(database.close);
    await database.ensureReady();

    await expectLater(
      database
          .into(database.rawCaptureRows)
          .insert(
            RawCaptureRowsCompanion.insert(
              captureId: Uuid().v7(),
              rawText: 'content is not included in assertions',
              sourceInstallationId: Uuid().v4(),
              capturedAtUtcMicros: 1,
              originalOffsetMinutes: 0,
              sourceTimeZoneId: const Value.absent(),
              visibility: 'private',
              revision: 1,
              createdAtUtcMicros: 1,
            ),
          ),
      throwsA(isA<Object>()),
    );
    expect(await database.select(database.rawCaptureRows).get(), isEmpty);
  });
}
