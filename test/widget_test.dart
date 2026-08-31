import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lifeos/src/ui/lifeos_app.dart';

import 'support/in_memory_capture_store.dart';

void main() {
  testWidgets('Now explains local privacy and Capture has no type selection', (
    tester,
  ) async {
    final store = InMemoryCaptureStore();
    addTearDown(store.close);
    await tester.pumpWidget(LifeOsApp(store: store));

    expect(find.text('默认私有 · 仅存本机'), findsOneWidget);
    await tester.tap(find.byKey(const Key('capture-entry')));
    await tester.pumpAndSettle();

    expect(find.byType(TextField), findsOneWidget);
    expect(find.byType(DropdownButton<Object>), findsNothing);
    expect(find.text('Task'), findsNothing);
  });

  testWidgets('empty text is disabled and not saved', (tester) async {
    final store = InMemoryCaptureStore();
    addTearDown(store.close);
    await tester.pumpWidget(LifeOsApp(store: store));
    await tester.tap(find.byKey(const Key('capture-entry')));
    await tester.pumpAndSettle();

    final button = tester.widget<FilledButton>(
      find.byKey(const Key('save-capture')),
    );
    expect(button.onPressed, isNull);
  });

  testWidgets(
    'successful save shows raw label and opens exact read-only detail',
    (tester) async {
      final store = InMemoryCaptureStore();
      addTearDown(store.close);
      const raw = '  exact\nraw text  ';
      await tester.pumpWidget(LifeOsApp(store: store));
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
      await tester.pump();
      await tester.pumpAndSettle();
      await tester.pump();

      expect(find.text('现在'), findsOneWidget);
      expect(find.textContaining('原始 · 未整理'), findsOneWidget);
      await tester.tap(find.text(raw));
      await tester.pumpAndSettle();
      expect(find.text('原始 · 未整理'), findsOneWidget);
      expect(find.text(raw), findsOneWidget);
      expect(find.byType(SelectableText), findsOneWidget);
    },
  );

  testWidgets('save failure retains exact input and uses a generic message', (
    tester,
  ) async {
    final store = InMemoryCaptureStore()..failWrites = true;
    addTearDown(store.close);
    const raw = 'private input must stay in the field';
    await tester.pumpWidget(LifeOsApp(store: store));
    await tester.tap(find.byKey(const Key('capture-entry')));
    await tester.pumpAndSettle();
    await tester.enterText(find.byKey(const Key('capture-text-field')), raw);
    await tester.pump();
    await tester.tap(find.byKey(const Key('save-capture')));
    await tester.pumpAndSettle();

    expect(find.text('暂时无法保存到本机，请重试。'), findsOneWidget);
    expect(
      tester
          .widget<TextField>(find.byKey(const Key('capture-text-field')))
          .controller!
          .text,
      raw,
    );
  });

  testWidgets('read failure is distinct from an empty timeline', (
    tester,
  ) async {
    final store = InMemoryCaptureStore()..failReads = true;
    addTearDown(store.close);

    await tester.pumpWidget(LifeOsApp(store: store));
    await tester.pump();

    expect(find.text('暂时无法读取本地记录，请稍后重试。'), findsOneWidget);
    expect(find.text('今天还没有随手记。'), findsNothing);
  });

  testWidgets('timeline changes its date range after local midnight', (
    tester,
  ) async {
    var captureTime = DateTime(2026, 8, 30, 22);
    final store = InMemoryCaptureStore(now: () => captureTime);
    addTearDown(store.close);
    await store.saveRawText('yesterday');
    captureTime = DateTime(2026, 8, 31, 0, 1);
    await store.saveRawText('today');

    var interfaceTime = DateTime(2026, 8, 30, 23, 59, 59);
    await tester.pumpWidget(LifeOsApp(store: store, now: () => interfaceTime));
    await tester.pump();
    expect(find.text('yesterday'), findsOneWidget);
    expect(find.text('today'), findsNothing);

    interfaceTime = DateTime(2026, 8, 31, 0, 0, 1);
    await tester.pump(const Duration(seconds: 1));
    await tester.pump();
    expect(find.text('yesterday'), findsNothing);
    expect(find.text('today'), findsOneWidget);
  });
}
