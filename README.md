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

## Windows persistence probe

From this worktree, run:

```powershell
pwsh -ExecutionPolicy Bypass -File .\scripts\run_stage0_windows.ps1
```

The command safely recreates only
`build\stage0-probe-data`, builds a Windows release executable, and runs it
with `LIFEOS_STAGE0_HEADLESS=1`. It pins `PUB_CACHE` to the configured D:
tool cache, writes complete runtime diagnostics to a `.log`, and extracts one
validated, parseable PASS/FAIL JSON object to a sibling `.json` file in
`build\stage0-logs`. The fixed database name is
`PROTOTYPE_stage0_lifeos.sqlite`.

The probe deliberately performs only this sequence:

1. use `sqlite3` to create the v1 raw tables and fixed synthetic raw text;
2. close the v1 database;
3. open it with Drift schema v2 using `NativeDatabase.createInBackground`;
4. assert every raw value and its SHA-256 remain exact, then add one derived row;
5. close, reopen, and assert the raw value/hash, derived row, and
   `PRAGMA user_version = 2` again.

`LIFEOS_STAGE0_DATA_DIR` optionally selects the probe directory; it is for
this disposable prototype only. Neither the JSON evidence nor app UI prints
the synthetic raw text.

The ordinary app window runs the same probe once and displays `PASS` or
`FAIL`, the schema version, raw hash, and a brief diagnostic. It is not a
product UI.

Build commands, tool versions, artifacts, hashes, and failures are recorded in
`STAGE0_BUILD_RECORD.md` once validation is complete.
