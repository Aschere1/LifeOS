# LifeOS

LifeOS Stage 1 is a local-first Flutter walking skeleton for raw text capture on Windows and Android. It saves exact non-empty text as a private `Raw Capture`, persists it in local SQLite, and shows it in today's timeline as `原始 · 未整理`.

This slice does not include voice or media capture, tasks, sessions, daily review, Inbox organization, AI, sync, settings, deletion, telemetry, encryption claims, onboarding, or next-step ranking.

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

Generated Drift source and the version-1 schema snapshot are committed. The current schema has no upgrade path because it starts at version 1; a future schema change must add a real migration and its evidence. Windows stores production data under the non-roaming `%LOCALAPPDATA%\com.aschere\lifeos` boundary. Android backup and device-transfer extraction are disabled for every app-owned data domain.

Android production signing is intentionally not stored in this repository. Release packages must use a separately managed production key; the project never falls back to the development-only debug key.

## Current gaps

The app uses the OS application-data boundary and does not claim database encryption. It does not yet provide production IANA time-zone discovery, so the optional source time-zone field is `null` rather than guessed. Windows builds require Windows Developer Mode for Flutter plugin symlinks.
