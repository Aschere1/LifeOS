import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';

import 'stage0_probe.dart';

/// A deliberately minimal shell used only to prove desktop and Android builds.
///
/// This is not a LifeOS feature and must not be promoted into the product.
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final result = await Stage0Probe().run();
  if (Platform.environment['LIFEOS_STAGE0_HEADLESS'] == '1') {
    stdout.writeln(jsonEncode(result.toJson()));
    exit(result.ok ? 0 : 1);
  }
  runApp(Stage0SpikeApp(result: result));
}

class Stage0SpikeApp extends StatelessWidget {
  const Stage0SpikeApp({required this.result, super.key});

  final Stage0ProbeResult result;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Text(
              'LifeOS Stage 0 persistence probe — PROTOTYPE ONLY\n'
              '${result.ok ? 'PASS' : 'FAIL'}\n'
              'schema user_version: ${result.userVersion ?? 'unavailable'}\n'
              '${result.verifiedRawSha256 == null ? 'expected' : 'verified'} '
              'raw hash: ${result.verifiedRawSha256 ?? result.expectedRawSha256}\n'
              '${result.error ?? result.steps.join(' → ')}',
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ),
    );
  }
}
