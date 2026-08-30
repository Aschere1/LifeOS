# LifeOS Stage 1 First-Write Invariants

> - 文档类型：工程实现契约，低于 Product Constitution / Master PRD / V0.1 PRD / Decision Log
> - 状态：Accepted Contract / Stage 1 Verification Pending
> - 适用范围：Stage 1 本地文字/原始语音 Capture 首写、重启恢复与本地删除基础

## 1. 目的

本契约让 Stage 1 Implementer 不需要猜测数据完整性、隐私默认值或原始/派生边界。它不新增用户功能，也不定义同步、AI、Timeline 全量行为、导出/备份或未来媒体系统。

对应产品依据：

- Product Constitution 原则 2、3、4、5、7、8；
- Master PRD §4、§6、§16、§20；
- V0-P0-01、V0-P0-06、V0-P0-12、V0-P0-13；
- D-006、D-007、D-008、D-019、D-020、D-021、D-031；
- `S1-ARCH-01`、`S1-DATA-01..06`、`S1-PRIV-01`。

## 2. 既有领域概念，不创造替代名词

| Concept | Stage 1 technical responsibility | 禁止折叠 |
|---|---|---|
| Raw Capture | 保存原始文字或指向原始语音的来源记录 | 不等同于已整理 Record，不被摘要覆盖 |
| Raw Media | 保存音频文件本体及其可验证元信息 | 不作为普通附件塞进 SQLite BLOB，不自动关联 Session |
| Derived Artifact | 未来转写、摘要、标题、分类等派生产物的技术边界 | 不自动成为 Fact/Canonical Record，不写回 Raw Capture |
| Visibility | 单条记录的可见性；首写默认 `private` | 不等同于 AI 授权、加密状态或分享 |
| Capture Source | 记录来源安装与入口 | 不使用硬件序列号、广告 ID 或隐式监控数据 |

`Derived Artifact` 是内部实现名称，不是新的用户可见领域对象。Stage 1 不需要生产派生内容；只需保证未来加入时有独立边界。

## 3. 首写必须持久化的事实

### 3.1 Raw Capture

| Field | Contract |
|---|---|
| `capture_id` | RFC 9562 UUIDv7；全局唯一、不可复用。UUID 内时间只用于索引局部性，不能作为人生时间事实 |
| `raw_text` | 原始文字；语音 Capture 时允许为空。不得被转写、摘要或格式化文本覆盖 |
| `source_installation_id` | 本次应用安装生成的随机 UUIDv4；不得来自 MAC、IMEI、硬盘序列号等硬件标识 |
| `captured_at_utc_micros` | 明确的 UTC 瞬时值，使用 64-bit Unix microseconds |
| `original_offset_minutes` | Capture 当时设备的 UTC offset；以后设备时区变化不得重写 |
| `source_time_zone_id` | 可得时保存 IANA zone ID；取不到时为 `null`，不能猜测 |
| `visibility` | 首写强制为 `private`，除非未来经已批准的用户显式选择改变 |
| `revision` | 首写为 `1`；Stage 1 不由此擅自定义同步冲突或编辑产品行为 |
| `created_at_utc_micros` | 数据库实际提交时间，用于审计；不得替代发生/Capture 时间 |

一次成功 Capture 至少要有一个已持久化的原始 payload：`raw_text` 或一个已验证的 Raw Media。UI 是否允许空白、混合输入或修改原文，若 PRD 未给出，不由 repository 层创造产品行为。

### 3.2 Raw Media Reference

| Field | Contract |
|---|---|
| `media_id` | RFC 9562 UUIDv7 |
| `capture_id` | 必须引用现存 Raw Capture；本地删除遵守同一事务边界 |
| `relative_path` | 相对应用数据根的路径；数据库不得保存设备绝对路径 |
| `sha256` | 对最终保存字节计算的小写十六进制 SHA-256 |
| `byte_length` | 最终文件字节数 |
| `mime_type` / `codec` | 来自实际录制结果；未知时明确为空，不猜测 |
| `duration_millis` | 录制器可靠提供时保存；取不到时为 `null` |
| `created_at_utc_micros` | 媒体提交时间，不替代 Capture 时间 |

Raw Media 字节保存在应用数据目录的独立文件中，不作为数据库 BLOB。Stage 1 只支持 D-031 的原始语音；照片、截图、视频和结构化 Session 媒体关联仍为 P1。

## 4. 原始与派生边界

- 未来每个 Derived Artifact 必须有自己的 ID、`source_capture_id`、种类、内容、生成来源/provenance 和生成时间；
- 任何派生产物的创建、更新、失败或删除都不能 `UPDATE` Raw Capture 的原文、时间、来源或 Raw Media 引用；
- Raw Capture 被用户真正删除后，依赖它的派生产物必须同步失效或删除；Stage 1 没有 AI/Insight 实现，不提前构建它们；
- Spike 中的 `derived_artifacts` 表只用于证明 v1→v2 迁移和边界，不自动进入 Stage 1 production schema。

## 5. 数据库与迁移

- 本地数据库：SQLite，由 Drift 提供 typed repository / migration boundary；原生查询运行在 Drift background isolate；
- `PRAGMA foreign_keys = ON`；
- 起始策略：`journal_mode = WAL`、`synchronous = FULL`。Raw Capture 是用户刚留下的人生资料，不按可重建缓存处理；Stage 1 必须测量实际写入延迟，不能未经证据降为 `NORMAL/OFF`；
- 每次 schema version 变化必须提交 Drift schema snapshot、逐步 migration 和迁移数据完整性验证；
- 生产 migration 禁止 `drop-and-recreate`、清库或用 AI 生成内容回填原始字段；
- 应用启动时先完成 migration，再向 repository 开放写入口；失败时显示本地存储不可用，不创建伪造成功记录。

## 6. 写入协议

### 6.1 Text Capture

1. 在单个 SQLite transaction 中写入 Raw Capture；
2. commit 成功后才返回成功；
3. commit 失败时不保留半条记录，原始输入仍留在当前 UI 供用户重试或复制；
4. 日志、异常报告和 analytics 不得包含原文。

### 6.2 Voice Capture

SQLite 与文件系统不能组成一个原子 transaction，因此 repository 必须实现可恢复的 staged write：

1. 录音只写入应用数据根内的临时命名空间；
2. 关闭并 flush 文件，计算 SHA-256 与长度；
3. 在同一文件系统内 atomic rename 到最终 Raw Media 相对路径；
4. 在一个 SQLite transaction 中写 Raw Capture 与 Raw Media Reference；
5. transaction 失败时删除刚生成的最终文件；删除失败则记录不含原始内容的 orphan cleanup 项；
6. 只有文件和数据库引用都成功后才向用户显示 Capture 已保存；
7. 启动恢复只清理 LifeOS 自己的明确临时/orphan 命名空间，不扫描或删除用户其他文件。

权限拒绝、用户取消、录制失败或存储不足都不能创建成功 Capture。

## 7. 本地删除基础

Stage 1 只定义来源设备上的本地删除；局域网 tombstone、删除/修改冲突和远端媒体传播留到 Stage 5 决策门。

- 删除后该 Capture 立即不再参与有效查询、统计或未来 AI 输入；
- 有 Raw Media 时，先在应用数据根内 atomic rename 到删除 staging，再 transaction 删除数据库引用；
- transaction 失败则把文件恢复到原路径；commit 成功后再物理删除 staging 文件；
- 启动恢复必须能完成或回滚中断的删除，但不得伪造远端已删除；
- Stage 1 没有配对设备，因此本地 hard delete 不提前实现同步 tombstone/change log。

## 8. 隐私与存储声明

- 数据库、WAL、临时文件、Raw Media 和证据文件必须位于 OS 提供的应用数据目录；
- 首写默认 `private`；保存不产生外部 AI、云、同步、分享或 telemetry 授权；
- production 日志只允许记录 ID、错误码和不含人生内容的状态；
- Stage 1 基线依赖 OS 用户/应用数据边界。本阶段没有验证数据库级加密，因此 UI、文档和发布说明不得声称“端到端加密”或“数据库已加密”；
- SQLCipher 与密钥管理如需进入 V0.1，必须在 Stage 4 隐私/安全门形成独立 ADR 和迁移证据。

## 9. 明确不在本契约

- AI、转写、摘要、分类、Canonical Record 自动生成；
- 照片、截图、视频、Session 媒体关联；
- LAN/热点同步、设备配对、tombstone、冲突合并；
- 云端、备份、导出、LXF、Echo、Ask My Life；
- 用户可见的录音时长/大小限制、原文编辑规则或其他 PRD 未定义行为。

如果 Stage 1 实际设备证据表明必须增加用户可见限制或改变上述产品边界，停止该部分并输出 `PRODUCT DECISION REQUIRED`。
