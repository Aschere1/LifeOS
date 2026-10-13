# Raw Voice Persistence Failure Matrix

Status: test specification for RV-02; implementation and fault injection pending.

This matrix operationalizes [First-Write Invariants](./Stage1_First_Write_Invariants.md) §§5–8. It does not define new user-facing recording behavior.

## Test fixtures

Use disposable directories and real SQLite fixtures, never the production application data directory. Generate known synthetic audio bytes; record baseline hashes. Supply occurrence metadata explicitly so tests do not invent the product's voice timestamp policy. Separate database-commit, rename, deletion and recorder-state failures.

## Required failure assertions

| Injection point | Required persisted state | Recovery / assertion |
|---|---|---|
| Permission denied / cancel before commit | No successful Capture or media reference | Recorder state remains truthful; only owned partials may be cleaned |
| Stop/flush fails | No successful Capture | Retain uncertainty and retry control until actual stopped state is known |
| Verification/hash fails | No successful Capture | Preserve pending-owned bytes with a truthful failure state; no guessed metadata or automatic expiry |
| Final rename fails | No database reference; pending-owned source bytes, operation identity and start metadata remain | Expose save retry; do not delete or reclassify as orphan |
| Background stop confirmed; app restarts before user decides | No successful Capture; pending-owned audio and start metadata remain | Restore pending decision, not an Inbox/Timeline item; never auto-save or clean it as orphan |
| Process exits after final rename, before transaction | No successful Capture; final file still owned by pending save operation | Restore pending ownership/path and retain bytes for explicit retry; never auto-create Capture or classify it solely by missing DB reference |
| Capture insert or media insert fails | Neither row committed | Restore audio to pending location or retain durable recovery ownership; no data loss on retry |
| Compensation deletion fails for independently proven orphan residue | No formal reference AND no pending ownership; residue has explicit compensation provenance | Restart can retry without raw content in logs; save failure alone never qualifies as orphan provenance |
| User explicitly discards pending audio; physical deletion fails | No Capture; durable discard/deletion intent and remaining bytes tracked | Display deletion failure, retain retry; restart may complete the explicit discard, never claim erasure until absence is verified |
| Commit succeeds, acknowledgement is interrupted | Capture and exact bytes remain | Restart recognizes committed identity; retry creates no duplicate; recovery must not delete it |
| Delete staging rename fails | Original reference/file remain | No deletion-success claim |
| Delete transaction fails | Original database reference remains | Restore staged bytes to original path; failed restore remains recoverable |
| Process exits after staging rename | Database decides whether deletion committed | Reference present: restore; reference absent after committed deletion: finish cleanup |
| Physical deletion after commit fails | Capture excluded from effective queries | Staged file cleanup remains pending; do not claim physical erasure |
| Recovery called twice | Same final state as once | No duplicate Capture, overwrite or deletion of unrelated files |
| Unexpected path / traversal / unowned file | Unowned bytes unchanged | Reject unsafe reference; recovery never broadens its scan/delete scope |
| v1 migration succeeds | Existing original fields unchanged | Build real file fixture from committed v1 snapshot fixed_sql; compare all nine raw fields and installation, new payload_kind=text; fresh/upgraded v2 schema equivalent |
| Migration fails after copy, table swap/index, integrity validation, or in-transaction version write | No partly upgraded writable store | Inject each checkpoint separately; reopen raw SQLite as schema/version 1 with original fields/installation/index intact, no v2 or temporary table; subsequent normal upgrade succeeds |

## Test layering

Repository tests prove file/database consistency and restart reconciliation. Recorder fakes prove error-state handling but do not prove native permission or hardware behavior. Physical Windows/Android runs prove actual recording and replay; human audibility remains explicit evidence. A pass at one layer cannot substitute for another.

## Review gate

Before RV-03, independently review the concrete schema migration and operation ownership against this matrix. The 2026-09-11 contract clarification permits transactional copy/verify/rebuild without data loss, not reset. D-032 establishes occurrence time; D-033 establishes background stop and retained pending audio. Platform lifecycle mapping still requires device evidence; it is not proved by storage tests.
