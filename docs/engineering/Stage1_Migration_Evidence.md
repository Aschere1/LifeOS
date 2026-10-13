# Stage 1 Schema v2 Migration Evidence

- Execution dates: 2026-09-17 and resumed verification 2026-09-20 (Asia/Shanghai)
- Scope: First-Write Invariants §5.1; schema-only increment of RV-03
- Baseline: `ed210c2`, branch `codex/stage1-raw-voice`; existing uncommitted product/engineering documentation preserved
- Status: schema-only increment complete / independent review Pass

## Product and completion boundary

Implements the database preparation for V0-P0-06/12/13 and the original-text migration portion of S1-AC-10. D-031/032/033 remain controlling product decisions. This increment adds no microphone access, voice-save API, operation journal, playback, deletion UI, AI, network, synchronization or telemetry. It neither creates voice Captures nor proves that referenced audio exists. Native and staged-file recovery acceptance remain open.

## Implementation

- Retain all nine v1 Raw Capture fields and the installation table unchanged; add `payload_kind`, defaulting to `text`.
- Raw Capture CHECK constraints distinguish nonempty text from empty-text voice; private and revision=1 remain enforced. No placeholder transcript is written.
- Add one-to-one Raw Media references with unique relative path, lowercase SHA-256 representation, positive byte length, nullable actual MIME/codec/duration and nonnegative known duration. Files remain outside SQLite; future repository code must prove path ownership, actual format and bytes.
- One transaction creates the new Capture table, copies original fields, compares both directions with EXCEPT plus count, replaces the table, recreates its occurrence index, creates Raw Media, checks foreign keys/integrity, and writes `user_version=2` before commit.
- Explicit version write avoids the pinned Drift 2.34.3 runtime's otherwise separate post-migration version write. Unknown transitions throw rather than reset. Production still opens SQLite in the existing background isolate.
- Pre-existing unversioned databases are not treated as empty. Unknown v1 objects, extra columns, unexpected foreign-key targets or occurrence-index columns reject migration before replacement, preserving unsupported data for diagnosis.

## Verified evidence

- Real disposable v1 databases originate from `drift_schemas/drift_schema_v1.json` fixed_sql, not a reconstructed approximation of v1.
- Success preserves original text, identity, occurrence/commit times, offsets, nullable zone, installation, private and revision. Reopen is idempotent and text writes continue.
- Inject failures after copy, swap/index, integrity validation and version write; inspect old schema/version/data after closing the failed executor, then retry successfully.
- Compare fresh and migrated v2 schema, indexes and foreign keys; test empty v1 and rejection of unknown newer versions.
- First migration/open uses the production background executor. Unknown version 0/999 and extra raw/installation fields, incoming cascade-reference table and wrong index are rejected; exact old schema and facts are inspected afterward.
- Verify new constraints independently, without letting another constraint accidentally satisfy the expected failure.

## Results

| Check | Result (2026-09-20) |
|---|---|
| `flutter test` | PASS — 27 tests, including existing text/UI regressions and 14 migration/schema tests |
| `flutter analyze` | PASS — no issues |
| `dart format --output=none --set-exit-if-changed lib test integration_test` | PASS — 13 files, 0 changes |
| `dart run build_runner build --only-check` | PASS |
| Original v1 schema snapshot unchanged | PASS — git diff is empty |
| Windows release build | PASS — not launched against production data |
| Android debug build | PASS — APK built; no installation or runtime claim |
| Independent final code/product review | PASS — separate Astra/high reviewer; previous Sol/high findings resolved |
| `git diff --check` and local links | PASS — 12 delivery documents checked |

Review corrections included populated-version-zero protection, unknown-schema rejection, exact rollback/index assertions, background-executor migration coverage and isolated constraint tests. Background errors are wrapped by Drift; tests assert the exact remote failure string and unchanged data, not an arbitrary exception. A test-only experimental API import was removed; final analyze and tests passed again.

No production application database has been opened, migrated or used as a fixture in this task. Exceptions exercise transaction rollback; they do not constitute process-kill or hardware power-loss testing. SQL constraints do not establish media-file ownership or byte integrity.

## Remaining gates

1. Durable pending audio ownership and explicit save/discard/delete recovery; never auto-clean pending audio.
2. Recorder/player adapters, truthful lifecycle handling and typed voice presentation. The existing text-only watcher is not a voice display API.
3. Windows/Android real-device permissions, recording, audibility, process restart and deletion. Unit tests and build success do not prove those behaviors or hardware power-loss durability.

## Routing

Astra Lead implements high-risk migration; Terra/medium authored separate migration fixtures/tests, with Lead follow-up fixes. Sol/high independently reviewed the contract and initial diff; its quota ended before final acceptance, so another Astra/high Agent performed final independent review. Planning-with-files retained work state across interruptions. No GitHub write, commit or push is part of this increment.
