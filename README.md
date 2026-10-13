# LifeOS

## External AI Coding review

The current review snapshot is on the repository's default `main` branch: [Aschere1/LifeOS](https://github.com/Aschere1/LifeOS). It includes the working text-capture slice, schema v2, migration tests and product/engineering documentation.

On another machine, install the Flutter/Dart versions listed below and use your own Android/Java or Windows build toolchain. The absolute paths in this README describe the author's local setup. From the cloned repository, run:

```powershell
flutter pub get
flutter analyze
flutter test
flutter run -d windows
# Or connect an Android device, then run flutter run.
```

Windows requires Flutter's usual Visual Studio C++ build tools and Developer Mode for plugin symlinks. The public repository contains source code and disposable test fixtures; private application databases, captured media, signing keys and local build output are not included.

Publication verification on 2026-10-13: clean-source `flutter analyze --no-pub` passed with no issues; `flutter test --no-pub` passed all 27 tests. Voice recording/playback and the remaining text-first trial work retain the completion boundaries described below and in the engineering evidence.

LifeOS Stage 1 is a local-first Flutter walking skeleton for raw text capture on Windows and Android. It saves exact non-empty text as a private `Raw Capture`, persists it in local SQLite, and shows it in today's timeline as `原始 · 未整理`.

This slice does not include voice or media capture, tasks, sessions, daily review, Inbox organization, AI, sync, settings, deletion, telemetry, encryption claims, onboarding, or next-step ranking.

The database now includes the schema foundation for original voice media and a lossless v1→v2 migration. This is not a voice feature: no production recording, voice-write, playback, pending-audio recovery or deletion API is connected yet. See [migration evidence](docs/engineering/Stage1_Migration_Evidence.md) for the exact verification boundary.

## Toolchain

- Flutter 3.47.2 / Dart 3.13.2: `D:\Archer\LifeOS-stage0-tools\flutter\bin\flutter.bat`
- Java: `D:\Archer\LifeOS-stage0-tools\jdk\jdk-21.0.12.1+1`
- Android SDK: `D:\Archer\LifeOS-stage0-tools\android-sdk`
- Pub cache: `D:\Archer\LifeOS-stage0-tools\pub-cache`
- Gradle cache: `D:\Archer\LifeOS-stage0-tools\gradle-cache`

From PowerShell at the repository root, set the local tool caches first:

```powershell
$env:PUB_CACHE='D:\Archer\LifeOS-stage0-tools\pub-cache'
$env:GRADLE_USER_HOME='D:\Archer\LifeOS-stage0-tools\gradle-cache'
$env:JAVA_HOME='D:\Archer\LifeOS-stage0-tools\jdk\jdk-21.0.12.1+1'
$env:ANDROID_HOME='D:\Archer\LifeOS-stage0-tools\android-sdk'
$env:ANDROID_SDK_ROOT=$env:ANDROID_HOME
```

## Commands

```powershell
$flutter='D:\Archer\LifeOS-stage0-tools\flutter\bin\flutter.bat'
$dart='D:\Archer\LifeOS-stage0-tools\flutter\bin\dart.bat'
& $dart format lib test integration_test
& $flutter analyze
& $flutter test
& $flutter test integration_test/text_capture_restart_test.dart -d windows
& $dart run build_runner build
& $dart run build_runner build --only-check
& $dart run drift_dev schema dump lib/src/persistence/capture_database.dart drift_schemas/
& $flutter build windows --release
& $flutter build apk --debug
```

Generated Drift source and schema snapshots live in the repository. Schema v2 migrates the original v1 text records without rewriting their content or source facts; unsupported version transitions fail closed. Future schema changes must add their own migration and evidence. Windows stores production data under the non-roaming `%LOCALAPPDATA%\com.aschere\lifeos` boundary. Android backup and device-transfer extraction are disabled for every app-owned data domain.

Android production signing is intentionally not stored in this repository. Release packages must use a separately managed production key; the project never falls back to the development-only debug key.

## Current gaps

The app uses the OS application-data boundary and does not claim database encryption. It does not yet provide production IANA time-zone discovery, so the optional source time-zone field is `null` rather than guessed. Windows builds require Windows Developer Mode for Flutter plugin symlinks.
