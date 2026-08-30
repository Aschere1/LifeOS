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
- `flutter pub run build_runner build`: PASS and idempotent; generated
  `lib/stage0_database.g.dart`. An earlier invocation included the removed
  `--delete-conflicting-outputs` option; build_runner 2.16 ignored it, so the
  final documented command omits that obsolete flag.
- `flutter analyze`: PASS, no issues.
- `scripts/run_stage0_probe.ps1` pins Flutter, JDK, Android SDK, Pub, and
  Gradle paths to D:. Its default path builds Windows, runs the probe, and
  builds Android; `-SkipAndroid` is only for the second Windows repeat.
  The owned Windows probe process has a 30-second timeout and controlled
  process-tree cleanup.
- Windows release builds in the latest evidence runs: PASS in 9.5s and 9.2s
  (`-SkipAndroid` normal/recovery paths). Full release runner directory:
  27,848,756 bytes.
- Windows headless probe, normal success: PASS. Evidence JSON:
  `build/stage0-logs/windows-probe-20260830-134645.json` (750 bytes), parsed
  with `ConvertFrom-Json`; sibling full runtime log: `.log` (885 bytes).
- Windows timeout path: expected failure with `-ProbeTimeoutSeconds 1`.
  `windows-probe-20260830-134705.log` (216 bytes) records the owned process-tree
  termination; process inspection found zero remaining owned probe processes.
- Windows headless probe, post-timeout recovery: PASS. Evidence JSON:
  `build/stage0-logs/windows-probe-20260830-134731.json` (750 bytes), parsed
  with `ConvertFrom-Json`; sibling full runtime log: `.log` (885 bytes).
  Both JSON files have `status=PASS`, `raw_value_preserved=true`,
  `derived_artifact_present=true`, `PRAGMA user_version=2`, and matching
  expected/verified raw SHA-256
  `d78109f2d5f16089394dc648135e765838f856a6435683894c50442aee06c8cf`.
  The script validates one JSON object, JSON parsing, exit code, and PASS status;
  it cleans only the explicit `build/stage0-probe-data` directory between runs.
- Lead fault-injection check: `-ProbeTimeoutSeconds 1 -SkipAndroid` returned
  failure after the bounded timeout, wrote `windows-probe-20260830-090320.log`
  with `SCRIPT_TIMEOUT`, and left zero owned probe processes running. The next
  normal `-SkipAndroid` invocation cleaned the fixed probe directory and passed
  (`windows-probe-20260830-090353.json`), proving recovery after interruption.
- The fixture aligns its candidate first-write names with `capture_id`,
  `source_installation_id`, and `source_time_zone_id`; it uses a fixed synthetic
  UUIDv4 installation source. `raw_media_references` remains empty but is
  asserted (columns, nullability, primary key, and capture foreign key) before
  and after reopening. `derived_artifacts` uses `artifact_id` and
  `source_capture_id` and remains a spike-only schema boundary.
- Android debug build: PASS as part of the final default official-repository
  invocation. APK: `build/app/outputs/flutter-apk/app-debug.apk`
  (173,142,673 bytes), SHA-256
  `529722E30E308466DD7B01C03F35C26E8293153C9A894CDE53C2DF0B2D71C4F7`.
  `aapt` reports `compileSdkVersion=36`, `targetSdkVersion=36`, and application ID
  `com.aschere.lifeos.spike.lifeos_stage0_spike`; the APK contains
  `libsqlite3.so` for `arm64-v8a`, `armeabi-v7a`, and `x86_64`. No repository,
  transport, dependency, or SDK-version workaround was applied.

## Environment failure chronology and dependency checks

- The initial Windows check found an incomplete Visual Studio Build Tools setup.
  The repair was limited to the exact missing Windows desktop build requirement;
  Flutter, Android SDKs, and caches remained on D:.
- Flutter doctor and the new Android CLI exposed a license-output contract
  mismatch. Vendor scripts were not modified; direct SDK artifact inspection
  and the actual Gradle build are the availability authority.
- The installed NDK path exposed an installer defect. The replacement used the
  checksum-gated official Android NDK r28c archive; no unofficial mirror was
  used.
- A canonical Maven Central request temporarily returned Cloudflare HTTP 403;
  it later returned HTTP 200 with no project change. The Android build evidence
  therefore records an external transient, not a code or dependency failure.
- Early Windows evidence combined Impeller stderr with JSON, making the `.json`
  file invalid. The runner now preserves full diagnostics in `.log`, extracts
  one stdout JSON object, validates it and the process exit code, then writes a
  pure JSON evidence file.
- No insecure HTTP, third-party mirror, or dependency downgrade was used.

Local verification used Flutter's official platform-support documentation for
Windows and Android. Drift and sqlite3 are MIT-licensed dependencies. Their
SQLite migration boundary is proven here; the community `record` package and
real microphone/audio behavior remain a Stage 1 device gate, not a Stage 0
acceptance claim.

This is evidence for the Stage 0 technical question only. It is not a claim
that Stage 1 or V0.1 product acceptance is complete.
