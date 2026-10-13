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
- production schema 必须提交 snapshot、逐步 migration 与数据完整性验证；不得以 drop-and-recreate 清除原始资料；Spike 的 `derived_artifacts` 不是 production schema；
- Stage 1 使用随机 installation UUID、RFC 9562 UUIDv7 record identity、UTC micros + 原始 offset + optional IANA zone，首次写入默认 `private`；UUID 内时间不成为人生事实；只有 Spike 的固定 synthetic fixture 是 UUIDv7-shaped 测试值；
- durability 起点为 WAL + `synchronous=FULL`，Stage 1 测量真实写入延迟后才能调整；
- 本 ADR 不实现同步/change log、AI、SQLCipher 或密钥管理，也不声称“数据库已加密”。

## 2026-09-11 工程澄清：无损表结构重建

v1 的 `CHECK(length(raw_text)>0)` 无法承载 D-031 已明确的纯语音。原禁令约束丢数据式重置，不排除 SQLite 的事务化表结构重建：创建新版表、原样复制/逐字段验证、替换表、恢复索引、检查外键和完整性；失败整体回滚，不能用假文字满足旧约束。禁止先重命名旧表导致引用漂移的捷径。详见 [SQLite 官方迁移程序](https://www.sqlite.org/lang_altertable.html#otheralter) 与 [First-Write Invariants §5](../engineering/Stage1_First_Write_Invariants.md)。这不变更产品语义，只有真实 v1 fixture 的成功/回滚证据通过后才能接受具体 migration。
