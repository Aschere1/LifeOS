import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:lifeos/src/persistence/drift_capture_store.dart';
import 'package:lifeos/src/ui/lifeos_app.dart';
import 'package:path/path.dart' as path;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('raw capture survives app and file-backed store restart', (
    tester,
  ) async {
    final directory = await Directory.systemTemp.createTemp(
      'lifeos_restart_test_',
    );
    final file = File(path.join(directory.path, 'lifeos.sqlite'));
    final captureTime = DateTime(2026, 8, 31, 10);
    DriftCaptureStore? store;

    Future<void> pumpUntilFound(
      Finder finder, {
      Duration timeout = const Duration(seconds: 5),
    }) async {
      final deadline = DateTime.now().add(timeout);
      while (finder.evaluate().isEmpty) {
        if (DateTime.now().isAfter(deadline)) {
          throw TestFailure('Timed out waiting for $finder.');
        }
        await Future<void>.delayed(const Duration(milliseconds: 50));
        await tester.pump();
      }
    }

    Future<void> closeStore() async {
      final current = store;
      store = null;
      if (current != null) {
        await current.close();
      }
    }

    addTearDown(() async {
      await tester.pumpWidget(const SizedBox.shrink());
      await tester.pump();
      await closeStore();
      if (await directory.exists()) {
        await directory.delete(recursive: true);
      }
    });

    const raw = '  first line\nsecond line  ';
    store = await DriftCaptureStore.openFile(file, clock: () => captureTime);
    await tester.pumpWidget(LifeOsApp(store: store!, now: () => captureTime));
    await tester.tap(find.byKey(const Key('capture-entry')));
    await tester.pumpAndSettle();
    await tester.enterText(find.byKey(const Key('capture-text-field')), raw);
    await tester.pump();
    expect(
      tester
          .widget<FilledButton>(find.byKey(const Key('save-capture')))
          .onPressed,
      isNotNull,
    );
    await tester.tap(find.byKey(const Key('save-capture')));
    await pumpUntilFound(find.text('今天的时间线'));
    await tester.pumpAndSettle();

    expect(find.text('今天的时间线'), findsOneWidget);
    expect(find.text(raw), findsOneWidget);
    expect(find.textContaining('原始 · 未整理'), findsOneWidget);

    await tester.tap(find.text(raw));
    await tester.pumpAndSettle();
    expect(find.text('原始 · 未整理'), findsOneWidget);
    expect(find.byType(SelectableText), findsOneWidget);
    expect(find.text(raw), findsOneWidget);

    await tester.pumpWidget(const SizedBox.shrink());
    await tester.pump();
    await closeStore();

    store = await DriftCaptureStore.openFile(file, clock: () => captureTime);
    await tester.pumpWidget(LifeOsApp(store: store!, now: () => captureTime));
    await pumpUntilFound(find.text(raw));
    await tester.pumpAndSettle();

    expect(find.text(raw), findsOneWidget);
    expect(find.textContaining('原始 · 未整理'), findsOneWidget);
    await tester.tap(find.text(raw));
    await tester.pumpAndSettle();
    expect(find.byType(SelectableText), findsOneWidget);
    expect(find.text(raw), findsOneWidget);
    expect(find.text('原始 · 未整理'), findsOneWidget);
  });
}
