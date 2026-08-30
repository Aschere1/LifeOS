# LifeOS Stage 0 Architecture Spike Results

> - 文档类型：一次性技术原型结果
> - 日期：2026-08-30
> - 状态：Evidence Complete / ADR Accepted / Independent Review Passed
> - 对应计划：[Stage0 Architecture Spike Plan](./Stage0_Architecture_Spike_Plan.md)
> - 原型源码：`spike/stage0-flutter-persistence`，最终审查 commit `119b0e8`

## 1. 结论

Flutter 3.47.2 + Dart 3.13.2 已在受控源码上完成 Windows release 与 Android API 36 debug 命令行构建；同一 Dart/Drift 数据边界已在 Windows 实际完成 v1 创建、关闭、v2 迁移、派生数据写入、再次关闭/重开，并证明原始字段与原文 SHA-256 不变。

因此 Stage 0 的 leading approach 通过进入 ADR 的证据门。建议 V0.1 客户端基础采用 Flutter，Stage 1 本地数据采用 SQLite + Drift，并继续遵守 [Stage 1 First-Write Invariants](./Stage1_First_Write_Invariants.md)。这不是 Stage 1 或 V0.1 功能验收，也没有把原型代码提升为 production code。

## 2. 固定环境与单一入口

| Item | Fixed value |
|---|---|
| Flutter / Dart | 3.47.2 stable / 3.13.2；framework `d3b14c876900e553bc736ca19295fc09e3853e8e`；engine `a804b261645ef8c13eb3d5c44a5c2fb0340c5539` |
| JDK | Microsoft OpenJDK 21.0.12.1+1 |
| Android | Stage 1 初始构建下界 API 24；compile/target API 36；Build Tools 36.0.0；NDK 28.2.13676358；正式支持下界待设备矩阵确认 |
| Validation host | Windows 11 x64 Insider Preview build 10.0.29648 |
| Persistence | drift 2.34.3；sqlite3 3.5.2；drift_dev 2.34.5；build_runner 2.16.0 |
| Tool/cache root | `D:\Archer\LifeOS-stage0-tools` |
| Worktree | `D:\Archer\LifeOS-stage0-spike` |
| Prototype database | `PROTOTYPE_stage0_lifeos.sqlite` |

原型 README 的默认单一入口为：

```powershell
pwsh -ExecutionPolicy Bypass -File .\scripts\run_stage0_probe.ps1
```

该命令固定 Flutter、JDK、Android SDK、Pub 与 Gradle 路径到 D:，并在构建前严格校验 Flutter/Dart 版本、channel、官方仓库 URL、framework revision 与 engine revision；随后依次执行依赖解析、Windows release build、Windows runtime probe 和 Android debug build。`-SkipAndroid` 只用于 Windows repeatability、cleanup 和恢复复验。

## 3. 构建证据

### Windows

- 默认双目标证据批次：Windows release build PASS，约 25.0 秒，随后完成 Android debug build；
- 后续 Windows-only cleanup/version-check 复验：`-SkipAndroid` 正常与恢复路径分别约 9.1 秒；这些结果不替代前述 Android 证据；
- 完整 release runner：27,848,756 bytes，共 12 个文件，包含 `sqlite3.dll`；
- 原型进程实际运行并返回结构化结果；不是只检查编译产物存在。

### Android

- debug APK：173,142,673 bytes；
- SHA-256：`529722E30E308466DD7B01C03F35C26E8293153C9A894CDE53C2DF0B2D71C4F7`；
- application ID：`com.aschere.lifeos.spike.lifeos_stage0_spike`；
- `aapt2`：`compileSdkVersion=36`、`targetSdkVersion=36`；
- native ABIs：`arm64-v8a`、`armeabi-v7a`、`x86_64`；
- 三个 ABI 均包含 `libsqlite3.so`。

Android 证据只证明真实 Gradle/Flutter 编译、打包及 native SQLite inclusion；本阶段没有声称已在 Android 实机运行 migration。

## 4. 数据完整性证据

v1 fixture 只包含一条固定 synthetic text Raw Capture；不包含真实用户资料、音频文件或 Raw Media row。它使用：

- UUIDv7-shaped `capture_id`；
- 固定 synthetic UUIDv4 `source_installation_id`；
- UTC microseconds、原始 offset、IANA time-zone ID；
- `visibility=private`、`revision=1`；
- 与候选 Stage 1 契约一致的 Raw Media 列、nullability、primary key 和 Capture foreign key。

v2 只新增 disposable `derived_artifacts`，没有 ALTER/UPDATE Raw Capture 或 Raw Media schema。两次最终 probe 均取得以下结果：

| Check | Result |
|---|---|
| JSON strict parse | PASS |
| Expected vs verified raw SHA-256 | 相同：`d78109f2d5f16089394dc648135e765838f856a6435683894c50442aee06c8cf` |
| All Raw Capture values unchanged | PASS |
| Raw Media schema after migration | PASS |
| Derived row exists independently | PASS |
| Close/reopen verification | PASS |
| `PRAGMA user_version` after reopen | 2 |
| Raw Media schema after reopen | PASS |

完整 runtime diagnostics 与纯 JSON evidence 分开保存；JSON 不输出 synthetic raw text。失败结果不会把“尚未验证”误写成 `raw_value_preserved=false`。

## 5. 失败路径与处置

| Failure / constraint | Diagnosis | Disposition |
|---|---|---|
| Visual Studio Build Tools incomplete | 既有安装被取消，缺 CMake/SDK payload | 只补齐 Flutter 明确要求的 VCTools、CMake、Windows SDK；SDK/cache 仍在 D: |
| Flutter doctor license warning | Flutter 3.47.2 仍解析 legacy sdkmanager 文案；新 Android CLI 改变输出契约 | 不修改 vendor script；直接 SDK artifact 检查与真实 Gradle build 作为可用性证据 |
| Android CLI 无法安装 exact NDK | command-line tools 23.0 对 NDK package resolution 返回无 URL | 使用 Google 官方 r28c archive；校验 size、revision 与 SHA-1 `086bba43ff2f5eb0e387b15c8278bb4e0d89ba1d` |
| Maven Central Cloudflare 403 | canonical Maven-only artifacts 稳定 403，Google Maven/Flutter Storage 正常；相同请求稍后无代码变化恢复 200 | 判定为 transient egress/edge failure；只重试真实构建一次并通过；未改依赖/仓库 |
| 首版 `.json` 混入 Impeller stderr | combined stream 不是合法 JSON | `.log` 保留完整诊断，stdout 中唯一 JSON 经 strict parse 后单独写 `.json` |
| Probe 进程可能 hang | 首版 wait 无 timeout | 增加 30 秒 bounded wait、owned process-tree cleanup 与 Dispose |

未使用 insecure HTTP、第三方 Maven mirror、dependency downgrade 或虚假绿色 doctor 输出。

## 6. 异常/恢复验证

Lead 使用 `-ProbeTimeoutSeconds 1 -SkipAndroid` 注入 timeout：命令按预期失败，日志包含 `SCRIPT_TIMEOUT`，并确认没有残留本 worktree 的 probe 进程。紧接着按正常 timeout 重跑，脚本清理固定 probe 目录并恢复七步 PASS。

## 7. Keep / Kill Gate

| Gate | Result |
|---|---|
| 固定 Flutter/Dart 命令行构建 Windows + Android | PASS |
| 同一 Dart domain/data module 编译到两端 | PASS |
| Windows create → close → migrate → close/reopen | PASS |
| 原始字段与 hash 迁移前后不变 | PASS |
| 工具与缓存定向 D:，无需 cloud/server | PASS |
| Drift/sqlite3 license、维护状态与平台支持无阻断 | PASS；2026-08-30 核验官方 package page/upstream，均为 MIT，native assets 已在两端 artifact 中验证；详见原型 build record |
| Raw voice permission/record/play/delete | Stage 1 device gate；未在本 Spike 冒充完成 |
| 正式 Windows/Android device matrix | Stage 1/Release gate；当前主机为 Windows Insider，Android 未做实机 runtime |

没有触发 Flutter→MAUI/KMP fallback 的 kill 条件；两者仍保留为真实 fallback，而不是被永久排除。

## 8. 明确未证明

- 正式 Capture UI、原始语音、权限拒绝、取消、回放、删除；
- Android 实机 SQLite migration/restart；
- Windows 11 25H2 GA release matrix；
- production schema snapshot/generated migration tests；
- WAL + `synchronous=FULL` 的真实写入延迟；
- SQLCipher、密钥管理、备份/导出、同步、AI 或 telemetry；
- debug APK 的发布包大小、启动时间或商店发布流程。

上述项目按 Stage 1 或后续既定 gate 处理，不得把本结果扩大解释为 V0.1 完成。
