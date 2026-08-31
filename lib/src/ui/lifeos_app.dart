import 'dart:async';

import 'package:flutter/material.dart';

import '../capture/capture_store.dart';
import '../capture/raw_capture.dart';

class LifeOsApp extends StatelessWidget {
  const LifeOsApp({super.key, required this.store, this.now});

  final CaptureStore store;
  final DateTime Function()? now;

  @override
  Widget build(BuildContext context) => MaterialApp(
    title: 'LifeOS',
    theme: ThemeData(
      colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xff245f4b)),
      useMaterial3: true,
    ),
    home: NowScreen(store: store, now: now),
  );
}

class NowScreen extends StatefulWidget {
  const NowScreen({super.key, required this.store, this.now});

  final CaptureStore store;
  final DateTime Function()? now;

  @override
  State<NowScreen> createState() => _NowScreenState();
}

class _NowScreenState extends State<NowScreen> with WidgetsBindingObserver {
  late DateTime _todayStart;
  late DateTime _tomorrowStart;
  bool _hasDayRange = false;
  Timer? _midnightTimer;

  DateTime _now() => widget.now?.call() ?? DateTime.now();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _refreshDayRange(notify: false);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      _refreshDayRange();
    }
  }

  void _refreshDayRange({bool notify = true}) {
    final now = _now();
    final nextTodayStart = DateTime(now.year, now.month, now.day);
    final nextTomorrowStart = DateTime(now.year, now.month, now.day + 1);
    final changed =
        !_hasDayRange ||
        nextTodayStart != _todayStart ||
        nextTomorrowStart != _tomorrowStart;
    _todayStart = nextTodayStart;
    _tomorrowStart = nextTomorrowStart;
    _hasDayRange = true;
    _scheduleMidnightRefresh(now);
    if (notify && changed && mounted) {
      setState(() {});
    }
  }

  void _scheduleMidnightRefresh(DateTime now) {
    _midnightTimer?.cancel();
    final untilTomorrow = _tomorrowStart.difference(now);
    _midnightTimer = Timer(
      untilTomorrow.isNegative ? Duration.zero : untilTomorrow,
      _refreshDayRange,
    );
  }

  @override
  void dispose() {
    _midnightTimer?.cancel();
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('现在')),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Text('默认私有 · 仅存本机'),
              const SizedBox(height: 16),
              FilledButton.icon(
                key: const Key('capture-entry'),
                onPressed: () async {
                  await Navigator.of(context).push(
                    MaterialPageRoute<void>(
                      builder: (_) => CaptureScreen(store: widget.store),
                    ),
                  );
                },
                icon: const Icon(Icons.edit_note),
                label: const Text('随手记'),
              ),
              const SizedBox(height: 28),
              Text('今天的时间线', style: Theme.of(context).textTheme.titleLarge),
              const SizedBox(height: 8),
              Expanded(
                child: StreamBuilder<List<RawCapture>>(
                  key: ValueKey(_todayStart),
                  stream: widget.store.watchCaptures(
                    startInclusive: _todayStart,
                    endExclusive: _tomorrowStart,
                  ),
                  builder: (context, snapshot) {
                    if (snapshot.hasError) {
                      return const Center(child: Text('暂时无法读取本地记录，请稍后重试。'));
                    }
                    final captures = snapshot.data ?? const <RawCapture>[];
                    if (captures.isEmpty) {
                      return const Center(child: Text('今天还没有随手记。'));
                    }
                    return ListView.separated(
                      itemCount: captures.length,
                      separatorBuilder: (_, _) => const Divider(height: 1),
                      itemBuilder: (context, index) {
                        final capture = captures[index];
                        return ListTile(
                          title: Text(
                            capture.rawText,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                          subtitle: Text(
                            '${_originalTime(capture)} · 原始 · 未整理',
                          ),
                          onTap: () => Navigator.of(context).push(
                            MaterialPageRoute<void>(
                              builder: (_) =>
                                  RawCaptureDetailScreen(capture: capture),
                            ),
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

String _originalTime(RawCapture capture) {
  final wallTime = DateTime.fromMicrosecondsSinceEpoch(
    capture.capturedAtUtcMicros,
    isUtc: true,
  ).add(Duration(minutes: capture.originalOffsetMinutes));
  return '${wallTime.hour.toString().padLeft(2, '0')}:${wallTime.minute.toString().padLeft(2, '0')}';
}

class CaptureScreen extends StatefulWidget {
  const CaptureScreen({super.key, required this.store});

  final CaptureStore store;

  @override
  State<CaptureScreen> createState() => _CaptureScreenState();
}

class _CaptureScreenState extends State<CaptureScreen> {
  final _controller = TextEditingController();
  String? _error;
  bool _saving = false;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _save() async {
    if (_controller.text.isEmpty || _saving) return;
    setState(() {
      _saving = true;
      _error = null;
    });
    try {
      await widget.store.saveRawText(_controller.text);
      if (mounted) {
        Navigator.of(context).pop();
      }
    } on CaptureStoreFailure catch (failure) {
      if (mounted) {
        setState(() => _error = failure.userMessage);
      }
    } catch (_) {
      if (mounted) {
        setState(() => _error = const LocalStorageFailure().userMessage);
      }
    } finally {
      if (mounted) {
        setState(() => _saving = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: const Text('随手记')),
    body: SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text('按原样记录下来。'),
            const SizedBox(height: 16),
            Expanded(
              child: TextField(
                key: const Key('capture-text-field'),
                controller: _controller,
                autofocus: true,
                expands: true,
                maxLines: null,
                minLines: null,
                textAlignVertical: TextAlignVertical.top,
                onChanged: (_) => setState(() {}),
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: '输入随手记…',
                ),
              ),
            ),
            if (_error != null) ...[
              const SizedBox(height: 12),
              Text(_error!, key: const Key('capture-save-error')),
            ],
            const SizedBox(height: 16),
            FilledButton(
              key: const Key('save-capture'),
              onPressed: _controller.text.isEmpty || _saving ? null : _save,
              child: Text(_saving ? '正在保存…' : '保存'),
            ),
          ],
        ),
      ),
    ),
  );
}

class RawCaptureDetailScreen extends StatelessWidget {
  const RawCaptureDetailScreen({super.key, required this.capture});

  final RawCapture capture;

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: const Text('原始随手记')),
    body: SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text('原始 · 未整理'),
            const SizedBox(height: 16),
            Expanded(
              child: SingleChildScrollView(
                child: SelectableText(capture.rawText),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
