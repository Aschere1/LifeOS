# LifeOS Stage 0 Flutter persistence spike

> **PROTOTYPE / THROWAWAY.** This worktree exists only to verify that the
> pinned Flutter toolchain can build a minimal Windows and Android shell and
> preserve a fixed synthetic raw record through a local SQLite migration. It
> is not LifeOS product code and contains no real Capture, Timeline, voice,
> sync, or AI behaviour.

## Scope

- Flutter project name: `lifeos_stage0_spike`
- Android application ID: `com.aschere.lifeos.spike.lifeos_stage0_spike`
- Platforms: Windows and Android only

## Cross-platform persistence probe

From this worktree, run:

```powershell
pwsh -ExecutionPolicy Bypass -File .\scripts\run_stage0_probe.ps1
```

The default command safely recreates only `build\stage0-probe-data`, pins all
Flutter, JDK, Android SDK, Pub, and Gradle paths to the configured D: tool
roots, builds and runs the Windows release probe, then builds the Android debug
APK. It writes complete Windows runtime diagnostics to a `.log`, and extracts
one validated, parseable PASS/FAIL JSON object to a sibling `.json` file in
`build\stage0-logs`. The fixed database name is
`PROTOTYPE_stage0_lifeos.sqlite`.

For only the second repeatability run of the Windows probe, use:

```powershell
pwsh -ExecutionPolicy Bypass -File .\scripts\run_stage0_probe.ps1 -SkipAndroid
```

The Windows child process has a 30-second timeout. On timeout the script kills
only that owned process tree, preserves available output in the sibling `.log`,
and returns failure.

The probe deliberately performs only this sequence:

1. use `sqlite3` to create the v1 raw tables and fixed synthetic raw text;
2. close the v1 database;
3. open it with Drift schema v2 using `NativeDatabase.createInBackground`;
4. assert every raw value and its SHA-256 remain exact, then add one derived row;
5. close, reopen, and assert the raw value/hash, derived row, and
   `PRAGMA user_version = 2` again.

The v1 fixture has one text Raw Capture only. It creates no Raw Media row or
audio file, and it does not establish mixed text/voice input behavior. The
probe checks the Raw Media reference schema contract before and after reopen;
the v2 `derived_artifacts` table remains a disposable spike boundary, not a
production schema.

`LIFEOS_STAGE0_DATA_DIR` optionally selects the probe directory; it is for
this disposable prototype only. Neither the JSON evidence nor app UI prints
the synthetic raw text.

The ordinary app window runs the same probe once and displays `PASS` or
`FAIL`, the schema version, raw hash, and a brief diagnostic. It is not a
product UI.

Build commands, tool versions, artifacts, hashes, and failures are recorded in
`STAGE0_BUILD_RECORD.md` once validation is complete.
