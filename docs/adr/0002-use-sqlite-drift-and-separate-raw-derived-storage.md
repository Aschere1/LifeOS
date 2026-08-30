---
status: accepted
---

# 本地数据采用 SQLite/Drift，并分离 Raw 与 Derived 存储

LifeOS V0.1 本地结构化数据采用 SQLite，由 Drift 提供 typed repository、background native executor 与 versioned migration boundary；Raw Capture、Raw Media reference 和 Derived Artifact 必须保持独立，派生数据不得覆盖原始文字、原始媒体引用、来源或发生时间。Stage 0 已证明 v2 只新增派生表时，v1 原始字段/hash 和 Raw Media schema 在 close/migrate/reopen 后不变。[实现契约](../engineering/Stage1_First_Write_Invariants.md) [Spike 证据](../engineering/Stage0_Spike_Results.md)

## Considered Options

- 直接使用 sqlite3：依赖更薄，但会把 typed queries、migration seam 与 isolate lifecycle 重复推给应用层；
- Drift + sqlite3 native assets：增加 codegen，但在 Windows/Android 共用 typed data boundary，并把同步 SQLite 工作移出 Flutter UI isolate；
- 文件/JSON 作为主存储：难以提供关系完整性、迁移与未来变化交换所需的稳定边界。

## Consequences

- Raw Media bytes 存 OS application-data 文件，SQLite 只保存相对路径、hash 与元数据；不把原始音频作为 BLOB；
- production schema 必须提交 snapshot、逐步 migration 与数据完整性验证；不得 drop-and-recreate 原始表；Spike 的 `derived_artifacts` 不是 production schema；
- Stage 1 使用随机 installation UUID、RFC 9562 UUIDv7 record identity、UTC micros + 原始 offset + optional IANA zone，首次写入默认 `private`；UUID 内时间不成为人生事实；只有 Spike 的固定 synthetic fixture 是 UUIDv7-shaped 测试值；
- durability 起点为 WAL + `synchronous=FULL`，Stage 1 测量真实写入延迟后才能调整；
- 本 ADR 不实现同步/change log、AI、SQLCipher 或密钥管理，也不声称“数据库已加密”。
