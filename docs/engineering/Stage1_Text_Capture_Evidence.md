# LifeOS Stage 1 Text Capture Evidence

> - 文档类型：工程实现与验收证据
> - 状态：Implemented Text Slice / Reviewed
> - 证据日期：2026-08-31（Asia/Shanghai）
> - 分支：`codex/stage1-text-capture`
> - 基线：`acb3add`

## 1. 结论边界

本批实现形成了第一条可运行的本地价值切片：用户可从 Now 打开随手记，不预先选择内部类型，按原样保存非空文字；内容以默认 `private` 的 Raw Capture 写入本机 SQLite，并在 Today Timeline 以“原始 · 未整理”状态显示，点击后可回看完整原文。

本证据不声称 Stage 1 或 V0.1 已完成。原始语音、Raw Media、删除、真实 schema v2 迁移、Android 实机重启、Session、Task、Daily Review、AI、同步、导出和备份均不在本批实现范围。

## 2. 产品与验收依据

本批覆盖以下 Requirement 的文字 Capture 切片，不把部分覆盖标记为完整 Requirement 通过：

- `V0-P0-06`：全局 Capture 的文字、本地离线与失败真实性切片；
- `V0-P0-08`：Today Timeline 的本地 Raw Capture 展示切片；
- `V0-P0-12`：原始文字可回看且不被派生内容覆盖；
- `V0-P0-13`：新记录默认私人、本地边界切片；
- `AC-P0-06`、`AC-P0-07`、`AC-P0-17`、`AC-P0-22` 的对应文字/离线切片。

Stage 1 executable acceptance 的状态必须进一步区分：

| Stage 1 ID | 本批状态 | 说明 |
|---|---|---|
| `S1-AC-01` | PARTIAL | Windows 与 Android 均已从同一源码构建；Windows 已实际启动到 Now/Capture，Android 真实设备启动仍待验证 |
| `S1-AC-02` | PASS（文字切片） | 不选内部类型即可保存非空文字，首次写入默认 Private，repository 不依赖网络 |
| `S1-AC-05` | PASS（Windows 文字路径）/ PARTIAL（Stage 1 整体） | Windows 已完成正式版 UI 写入、进程关闭、重启、Timeline 与详情回看；Android 真机与原始语音路径仍待验证 |
| `S1-AC-06` | PASS（当前文字边界） | production schema 不存在派生字段或派生表，Raw Capture 没有被修改派生内容的入口；未来新增派生能力仍需独立验收 |
| `S1-AC-07` | PASS（文字切片） | Today Timeline 按发生时间显示本地 Raw Capture，并标注“原始 · 未整理” |
| `S1-AC-09` | PASS（已实现文字切片） | 当前实现不包含网络、AI 或同步依赖；未实现的语音/删除部分不在此声明内 |

`S1-AC-10` 尚未声明通过：production schema 当前从版本 1 起步，没有真实的下一版本变化，因此没有伪造 v1→v2 migration 证据。

## 3. 实现证据

### 3.1 原始文字与事务

- `CaptureStore` 只暴露保存原始文字、观察明确时间区间和关闭资源三个责任；
- 非空输入不执行 trim、摘要、标题、分类或格式归一化；换行和首尾空格按原样保存；
- 空字符串没有 payload，UI 禁止保存，repository 与数据库约束再次拒绝；
- installation 首写与 Raw Capture 插入位于同一 SQLite transaction；只有 transaction commit 后才缓存 installation ID；
- 写入异常返回不包含原文的通用错误，失败后输入仍留在编辑框，不显示伪造成功状态。

### 3.2 身份、时间与隐私

- `capture_id` 使用 RFC 9562 UUIDv7，installation ID 使用随机 UUIDv4；
- 同时持久化发生时间 UTC 微秒、当时 UTC offset、可选来源时区、数据库写入时间、revision 与来源 installation；
- 无法可靠取得 IANA time-zone ID 时保存 `null`，不根据缩写猜测；
- 首写强制 `visibility = private`，数据库以 CHECK constraint 保护；
- Windows 数据根为非漫游 `%LOCALAPPDATA%\com.aschere\lifeos`；
- Android manifest 禁止系统云备份与设备转移提取，并为各应用数据 domain 设置排除规则；
- 本阶段只依赖 OS 应用数据边界，不声称数据库已加密。

### 3.3 SQLite 与查询

- SQLite 由 Drift typed boundary 管理，文件 executor 在 background isolate 中运行；
- production 初始化启用 `foreign_keys = ON`、`journal_mode = WAL`、`synchronous = FULL`；
- Today Timeline 使用半开区间 `[todayStart, tomorrowStart)`，并按发生时间与 capture ID 稳定排序；
- `(captured_at_utc_micros, capture_id)` 复合索引进入 schema v1 snapshot；
- 页面跨过本地午夜或从后台恢复时重新计算 Today 区间；
- 读取失败显示明确错误，不把错误伪装成“今天没有记录”。

## 4. 自动化验证

在 Flutter 3.47.2 / Dart 3.13.2、Windows 11、Android SDK API 36 环境执行：

| 验证 | 结果 | 证据摘要 |
|---|---|---|
| `dart format --output=none --set-exit-if-changed lib test` | PASS | 10 files，0 changed |
| `flutter analyze` | PASS | No issues found |
| `flutter test` | PASS | 13 tests passed |
| `flutter test integration_test/text_capture_restart_test.dart -d windows` | PASS | 1 Windows integration test passed |
| `dart run build_runner build --only-check` | PASS | 生成检查通过；tracked generated source 与 schema 无变化 |
| Drift schema dump | PASS | `drift_schema_v1.json` 已生成并含复合索引 |

13 项测试覆盖：原文精确保留、时间/offset/time-zone/隐私/revision、空 payload、UUID 版本与稳定 installation、时间区间排序、首次事务回滚与重试、文件关闭重开、PRAGMA、外键失败无半条记录、无类型选择、保存与详情回看、写失败保留输入、读失败不冒充空状态、跨本地午夜切换 Today 区间。

Windows integration test 使用真实 file-backed Drift store 和界面操作保存包含换行、首尾空格的原文；随后卸载应用 widget、关闭 store、从同一数据库重建 store 与应用，验证 Timeline 和详情页精确保留原文。该测试使用实时 integration binding，避免普通 widget test 的受控时间与后台数据库 Future 互相等待。

## 5. 平台构建与启动证据

| 目标 | 命令 | 结果 |
|---|---|---|
| Windows x64 release | `flutter build windows --release` | PASS；`build/windows/x64/runner/Release/lifeos.exe` |
| Android debug APK | `flutter build apk --debug` | PASS；`build/app/outputs/flutter-apk/app-debug.apk` |

- Windows EXE SHA-256：`FACFBC2502C35DA6078355F38C7AA235D899236C07308F305AFAA210F0A0E580`；
- Android APK SHA-256：`D0E7B8D396A638738BF9A6BBFA4E8718325AEF665B6EC5A7C7C2422689320C93`；
- APK application ID：`com.aschere.lifeos`；min SDK 24；compile/target SDK 36；
- APK 包含 `arm64-v8a`、`armeabi-v7a`、`x86_64` 的 `libsqlite3.so`；
- Windows release 实际启动到 Now，确认出现“默认私有 · 仅存本机”“今天的时间线”和“随手记”；打开随手记后确认只有原文输入与保存入口，没有类型选择；未写入测试 Capture，随后正常关闭；
- 启动产生的 production 数据库位于 `%LOCALAPPDATA%\com.aschere\lifeos\lifeos.sqlite`，核验时 `installations = 0`、`raw_captures = 0`。

另以独立 `%LOCALAPPDATA%` 测试根运行 Windows release 成品，完成：界面保存测试原文 → 数据库核验 1 条 `private` / revision 1 记录且 `integrity_check = ok` → 正常关闭进程 → 使用同一测试根重启 → Today Timeline 恢复记录 → 打开“原始 · 未整理”详情并回看原文。测试进程关闭后，隔离数据目录已逐项核验并删除；正式数据目录未被写入。

Android build 输出一条 SDK XML 工具版本提示，但 Gradle 最终成功，APK manifest 与 native library 已用 API 36 build-tools 重新检查。正式 Android 签名不存放在仓库内，release 不再回退到 debug key；发布签名与实机安装属于后续 release gate。

## 6. 当前限制与后续 Gate

- 当前主机未连接 Android 设备，也未安装可用模拟器；需要 Android API 24 与最新受支持版本的真实设备执行启动、写入、进程终止、设备重启和回看；
- 原始语音及权限拒绝、取消、文件落盘、回放和删除证据仍未实现；
- schema 首次真实升级时必须新增逐步 migration、旧数据完整性与失败回滚证据；
- IANA time-zone discovery、数据库级加密、正式签名、安装/升级/卸载数据保留策略分别留在对应架构与 release gate；
- 本批没有增加 AI、网络、同步、telemetry 或外部数据读取权限。

## 7. 产品决策

本批未发现需要新增用户行为的产品缺口，也未作隐藏产品决策。空字符串因为不存在 payload 而不可保存；任何非空字符串（包括纯空白）均按原样保存。后续若要改变可见的空白输入、编辑、删除或自动整理规则，必须先回到产品文档与 Decision Log。

## 8. 独立审查

- Standards Reviewer 首轮提出 Windows roaming data、Android backup、release debug signing、读取错误状态、跨午夜刷新和 Timeline 索引六项问题；修复后逐项复审为 `RESOLVED`，最终 `PASS`，无新增 P0/P1/P2 finding；
- Verification Reviewer 独立复跑格式、静态检查、13 项测试、Drift 生成一致性、schema index、Android manifest/APK 与 Windows release 产物，全部 `PASS`，无残余阻塞；
- Spec Reviewer 确认实现没有 Session、Task、AI、sync、media 或 Moment scope drift，也没有修改/覆盖 Raw Capture；同时指出 `S1-AC-01` 与 `S1-AC-05` 证据过早声明，本文件已改为上述 `PARTIAL` 状态；
- Spec Reviewer 指出的“实现文件尚未进入受控源码”必须由本批 Git commit 关闭；在 commit 前不得把工作树状态当成可复现验收结果。
