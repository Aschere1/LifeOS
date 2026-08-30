# Stage 0 build record

> **PROTOTYPE / THROWAWAY.** This record documents environment validation, not
> product acceptance. The shell intentionally has no LifeOS product behaviour.

## Fixed tool locations

- Flutter: `D:\Archer\LifeOS-stage0-tools\flutter`
- JDK: `D:\Archer\LifeOS-stage0-tools\jdk\jdk-21.0.12.1+1`
- Android SDK: `D:\Archer\LifeOS-stage0-tools\android-sdk`
- Pub cache: `D:\Archer\LifeOS-stage0-tools\pub-cache`
- Gradle cache: `D:\Archer\LifeOS-stage0-tools\gradle-cache`

## Validation log

### 2026-08-30 — persistence/migration probe

- Flutter: `3.47.2 stable`; Dart: `3.13.2`; Windows host.
- Dependencies resolved: `drift 2.34.3`, `sqlite3 3.5.2`, `drift_dev 2.34.5`,
  `build_runner 2.16.0` (all compatible with the requested constraints).
- `flutter pub get`: PASS with `PUB_CACHE` set to the fixed D: cache.
- `flutter pub run build_runner build --delete-conflicting-outputs`: PASS;
  generated `lib/stage0_database.g.dart`.
- `flutter analyze`: PASS, no issues.
- Windows release builds in the final one-command evidence runs: PASS in 9.6s
  and 9.4s. Full release runner directory: 27,848,756 bytes.
- Windows headless probe, final run 1: PASS. Evidence JSON:
  `build/stage0-logs/windows-probe-20260830-084808.json` (647 bytes), parsed
  with `ConvertFrom-Json`; sibling full runtime log: `.log` (782 bytes).
- Windows headless probe, final run 2: PASS. Evidence JSON:
  `build/stage0-logs/windows-probe-20260830-084828.json` (647 bytes), also
  parsed with `ConvertFrom-Json`; sibling full runtime log: `.log` (782 bytes).
  Both JSON files have `status=PASS`, `raw_value_preserved=true`,
  `derived_artifact_present=true`, `PRAGMA user_version=2`, and matching
  expected/verified raw SHA-256
  `d78109f2d5f16089394dc648135e765838f856a6435683894c50442aee06c8cf`.
  The script validates one JSON object, JSON parsing, exit code, and PASS status;
  it cleans only the explicit `build/stage0-probe-data` directory between runs.
- Android debug build: PASS on one final official-repository build. APK:
  `build/app/outputs/flutter-apk/app-debug.apk` (173,139,843 bytes). `aapt`
  reports `compileSdkVersion=36`, `targetSdkVersion=36`, and application ID
  `com.aschere.lifeos.spike.lifeos_stage0_spike`; the APK contains
  `libsqlite3.so` for `arm64-v8a`, `armeabi-v7a`, and `x86_64`. No repository,
  transport, dependency, or SDK-version workaround was applied.

This is evidence for the Stage 0 technical question only. It is not a claim
that Stage 1 or V0.1 product acceptance is complete.
