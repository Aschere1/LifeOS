import 'dart:async';

import 'package:flutter/material.dart';

import 'src/capture/capture_store.dart';
import 'src/persistence/drift_capture_store.dart';
import 'src/ui/lifeos_app.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const LifeOsBootstrap());
}

class LifeOsBootstrap extends StatefulWidget {
  const LifeOsBootstrap({super.key});

  @override
  State<LifeOsBootstrap> createState() => _LifeOsBootstrapState();
}

class _LifeOsBootstrapState extends State<LifeOsBootstrap> {
  CaptureStore? _openedStore;
  bool _disposed = false;
  late final Future<CaptureStore> _store = _openStore();

  Future<CaptureStore> _openStore() async {
    final store = await DriftCaptureStore.openProduction();
    if (_disposed) {
      await store.close();
      return store;
    }
    _openedStore = store;
    return store;
  }

  @override
  void dispose() {
    _disposed = true;
    final store = _openedStore;
    if (store != null) {
      unawaited(store.close());
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<CaptureStore>(
      future: _store,
      builder: (context, snapshot) {
        if (snapshot.hasData) return LifeOsApp(store: snapshot.requireData);
        if (snapshot.hasError) return const _StorageUnavailableApp();
        return const MaterialApp(
          home: Scaffold(body: Center(child: CircularProgressIndicator())),
        );
      },
    );
  }
}

class _StorageUnavailableApp extends StatelessWidget {
  const _StorageUnavailableApp();

  @override
  Widget build(BuildContext context) => const MaterialApp(
    home: Scaffold(
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(24),
          child: Text('本地存储暂不可用。此次随手记未保存。', textAlign: TextAlign.center),
        ),
      ),
    ),
  );
}
