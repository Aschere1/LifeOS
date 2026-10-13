# Stage 1 Raw Voice Implementation Route

Status: deferred under D-035, 2026-09-20. Schema-only migration is complete; remaining voice implementation and runtime acceptance are pending. The active sequence is the [text-first internal trial](./Text_First_Trial_Implementation_Route.md). Ordered packages below remain the future voice contract, not authorization to resume them now.

## Product basis

This plan implements D-031/032/033 and V0-P0-06/12/13 under the [first-write contract](./Stage1_First_Write_Invariants.md) and [traceability matrix](./V0.1_P0_Traceability_Matrix.md). It changes no product requirement. Raw voice remains independent source material; saving it grants no AI access.

## Evidence and candidate selection

The isolated `spike/stage1-raw-voice-platform` branch ends at `5ac4b60`. Its code is disposable and must not be merged into the production app.

- `record 7.1.1` with `audioplayers 6.8.1` passed Windows and Android release builds using the complete repository toolchain environment.
- Windows produced a local RIFF/WAVE sample; independent byte-length, header and SHA-256 checks passed. Playback state and active stop were observed.
- Human audibility, Windows cancellation/deletion/fault paths and Android physical-device behavior remain unverified. No Android device was attached on 2026-09-07.
- Independent Standards and Spec reviews passed for the spike code. This does not constitute production acceptance.
- `just_audio_windows 0.2.3` failed with the fixed Windows compiler; no third-party source patch is proposed.

The fallback package pair is the provisional implementation candidate. Complete the runtime gates before final adoption. Build success is not evidence of microphone permission, audibility or crash safety.

## Ordered work packages

| Package | Responsibility | Dependencies | Acceptance |
|---|---|---|---|
| RV-01 | Finish isolated Windows/Android record, play, stop, cancel, delete and permission checks | Existing spike; physical device and human hearing | Content-free evidence with explicit pass/fail/unverified outcomes |
| RV-02 | Specify production media ownership, staged writes/deletes and recovery failure matrix | Accepted first-write contract | Every failure point has truthful state, retry/recovery owner and a preservation assertion |
| RV-03 | Implement schema v1→v2 and media repository | Reviewed RV-02 | Real v1 fixture preserves original text, identity, time and privacy; failed writes create no successful Capture; interrupted delete completes or rolls back |
| RV-04 | Implement recorder/player adapters and Capture UI integration | RV-03 reviewed contract; RV-01 candidate may be used provisionally, adoption still requires runtime evidence | Explicit microphone action; raw voice in Today; D-033 background stop/pending decision; no fabricated transcript/title; failure and cancellation remain recoverable |
| RV-05 | Cross-platform end-to-end acceptance | RV-03/04 | Offline save, process restart, replay, cancellation, deletion and failure recovery; existing text regression checks pass |

RV-02/03 can proceed while RV-01 awaits a device: filesystem/database behavior is independently testable using disposable fixtures. RV-04 development may use the provisional candidate after its own contract review, without claiming adoption or Stage 1 completion. D-033 resolves background behavior; platform mapping must be verified. No imposed recording limit is authorized.

The 2026-09-11 batch is limited to decision synchronization, migration and voice persistence/recovery APIs with synthetic fixtures. Native recording/playback, UI integration, date selection and real-device acceptance are subsequent work; a storage pass is not a complete voice feature. Existing text behavior must remain usable.

Resumption on 2026-09-17 splits RV-03 into independently reviewable increments: first schema v2 + lossless v1 migration (First-Write §5.1), then durable pending/voice-write/delete/recovery APIs (§6/7). No operation journal or voice row is created in the first increment. The interrupted September 12 implementation never changed code; prior plans must not be mistaken for delivered APIs.

2026-09-20: the schema-only increment passed 27 regression tests, analyze, Windows/Android builds and independent review; see [migration evidence](./Stage1_Migration_Evidence.md). RV-03 remains partial until the file/operation recovery repository is implemented and reviewed. No platform acceptance status changed.

## Storage implementation boundaries

D-032 now fixes voice occurrence time at recording start. Capture time and original offset must survive save retries; commit time remains distinct. Include a cross-midnight assertion.

The [failure matrix](./Stage1_Raw_Voice_Failure_Matrix.md) is the next executable test specification. Its cases remain pending until exercised; writing the specification does not mark RV-02 or production acceptance passed.

- Preserve existing Capture identity, original timestamps, installation identity and private defaults during migration.
- Store original audio bytes in the application's own data directory; SQLite stores relative references and verified metadata.
- Persist operation identity/start metadata before providing a recording path; after confirmed stop, retain verified audio pending explicit save/discard. Follow file-close → verify/hash → same-filesystem rename → Capture/media database transaction. Report success only after both components commit.
- Exercise failures before/after rename and database commit, compensation failures, restart cleanup and retry. Pending-owned audio is not an orphan: failed save restores it for retry, and restart never auto-creates a Capture. Committed identity prevents duplicate retry and accidental cleanup. Cleanup must be scoped to explicitly owned paths.
- Follow deletion staging → database transaction → physical deletion; rollback restores the original path. Pending cleanup must remain recoverable.
- Keep recording-state uncertainty visible and retryable. Do not use an exception as proof that recording stopped.
- Validate generated WAV metadata from actual bytes; do not infer duration or codec from a filename.

## Model and reasoning routing

| Work | Model role / effort | Reason |
|---|---|---|
| Evidence inventory, links and routine verification | LUNA / low | Bounded, mechanical checks |
| Platform adapters and UI with approved contract | TERRA / medium | Defined multi-file implementation |
| Lead, migration, file/database recovery and difficult failure analysis | ASTRA / high for this batch | Raw-data integrity and cross-component reasoning; D-034 |
| Independent final product/data review | SOL / high | Separate reviewer checks requirements, diff and evidence |

Escalate a repeated state/recovery defect to ASTRA implementation rather than sending identical instructions through repeated TERRA retries. Reserve xhigh for demonstrated unresolved architectural or recovery complexity, not routine review. Routine Lead work uses medium; do not require every task to traverse all models. D-034 and Model Routing §2.4 govern the current mapping.

## Subsequent V0.1 sequence

After Stage 1 acceptance: Stage 2 Session/Entry/Spark; Stage 3 Task/DDL, complete Today, Unknown repair, Life Area and Daily Review; Stage 4 privacy/settings/deletion and the export decision; Stage 5 paired LAN sync and explicit media/conflict decisions; Stage 6 complete P0 release verification. Pending product decisions stay at their documented stage gates.

## Completion boundary

Independent SOL/high gate review on 2026-09-07 identified two gates. The 2026-09-11 reassessment and user-approved continuation resolve their decision inputs, without claiming implementation acceptance:

1. Before RV-03: First-Write Invariants §5 and ADR-0002 now explicitly allow validated, rollback-safe table reconstruction and prohibit destructive reset or sentinel text. The concrete migration still needs independent review and real v1 success/failure fixtures.
2. Before RV-04: D-033 and V0.1 §4.7 now record the already-approved stop-and-await-user-confirmation behavior. D-032 resolves occurrence time. No repeat product question is needed; native lifecycle, stop uncertainty and durable pending ownership still need tests.

The previous pre-commit orphan rule is narrowed by D-033: absence of a Capture reference alone never authorizes cleanup. A pending save retains ownership across rename/failed transaction; recover it for the user's explicit retry. Only identifiable, unreferenced compensation residue without pending ownership is eligible for orphan cleanup. Never auto-create a record on restart.

This route is executable without asserting final platform adoption. Do not mark Stage 1 complete until S1-AC-03/04/05/08/09/10 have production evidence. The earlier sample's audibility is unknown until the user confirms or a new supervised listening check succeeds.
