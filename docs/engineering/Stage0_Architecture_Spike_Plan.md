# LifeOS Stage 0 Architecture Spike Plan

> - 文档类型：一次性技术原型计划
> - 状态：Completed / Keep Gate Passed
> - 原型问题：Flutter 是否能在当前 Windows 主机上，以可重复命令构建 Windows + Android，并用同一数据边界证明本地持久化、迁移和重启恢复？
> - 非目标：不实现正式 Capture UI、语音录制、Timeline、同步或 AI。

## 1. 为什么做这个 Spike

V0.1 要求 Windows 与 Android、local-first、原始数据可回看和未来局域网同步。纸面支持不足以成为架构决定；Stage 0 需要在选定方案上取得双目标构建和本地持久化的实际证据。

原型代码从第一天起即为 throwaway：只保存在 `spike/stage0-flutter-persistence` 分支，不合入 `main`。`main` 只保留问题、证据、结论与 ADR。

## 2. 产品约束

- 同一领域语义服务 Windows 与 Android，但两端 UI 可以不同；
- 无网络、服务器或 AI 时，核心记录仍可写入和回看；
- 首次写入默认私人；
- 原始文字/音频与转写、摘要、分类等派生内容分离；
- 原始语音本地可保存、回放、删除；照片/视频和结构化 Session 媒体关联不进入 Stage 1；
- 本阶段不实现同步，但本地身份、来源、迁移和数据边界不能堵死未来变化交换。

## 3. 候选方案纸面筛选

| Candidate | Official Windows + Android | Shared code | Local SQLite path | Raw-voice path | Stage 0 concern | Disposition |
|---|---|---|---|---|---|---|
| Flutter stable | Yes；官方列出两个目标并提供 CLI build | UI、domain、data 可共享；允许平台适配 | Drift/sqlite3 可覆盖 Android/Windows，需实测 | 活跃 `record` 插件使用 Android recorder + Windows Media Foundation，需 Stage 1 设备实测 | 核心依赖含社区包；本机需安装 Flutter/Android SDK | **Leading measured spike** |
| .NET 10 MAUI | Yes；.NET 10 LTS，WinUI 3 + Android | C#/XAML single project | Microsoft 文档提供 SQLite 路径 | 无同等明确的一方跨平台录音 API，需要社区库或平台实现 | 本机无 SDK/workload；安装更重，C: 空间紧；音频风险未降低 | Fallback if Flutter fails a kill gate |
| Kotlin/Compose Multiplatform | Yes；Android + desktop stable，Windows tooling available | Kotlin domain/UI 可共享 | SQLDelight 等路径成熟 | Android 与 Windows desktop 录音仍更可能需要 expect/actual 平台代码 | JVM desktop packaging、音频与平台适配面更大 | Fallback if Flutter/data spike fails |

本筛选不代表永久排除 MAUI/KMP；它只决定先测哪个候选，以控制 Stage 0 成本。

## 4. 当前平台基线

- Flutter pinned SDK：3.47.2 stable / Dart 3.13.2（2026-08-27 官方 Windows release metadata）；网页文档页仍可能显示前一文档快照 3.44.7；
- Android production target/compile baseline：API 36；API 37/Android 17 作为兼容性验证边界，不冒充当前稳定发布基线；
- Android minimum proposal for the spike：API 24（Flutter 当前 CI 下界）；正式最低版本由 ADR 基于依赖与设备证据确认；
- Windows validation：Windows 11 mainstream 25H2 compatibility target；26H1 为新设备线，另作兼容性说明；当前 Insider 主机只能提供先行兼容证据，不能替代正式 GA 设备矩阵；
- SDK、缓存和原型工作区必须放在 D:。C: 初检仅约 8 GB、安装前复检约 25.8 GB；只允许补齐既有 Visual Studio Build Tools 的精确必需组件，不作为 Flutter/Android SDK 或缓存目标。

## 5. 原型范围

原型只包含：

1. 一个 Flutter 壳，可生成 Windows release artifact 和 Android debug/release artifact；
2. 一个极小的 persistence probe：
   - schema v1 创建一条 `text` Raw Capture；
   - 关闭并重新打开数据库；
   - 校验原文、source device、UTC、offset、visibility 和 revision；
   - schema v2 增加不改变原始字段的派生元数据结构或列；
   - 执行迁移后重新校验 v1 原始内容；
3. 一个最薄的界面/命令入口，显示当前 probe 状态和最后一次结果；
4. 原型数据库必须明确命名为 `PROTOTYPE_stage0_lifeos.sqlite`，不能读取或写入任何真实用户数据。

语音录制本身不在本原型：D-031 的平台权限、取消、失败、音频回放与删除将在 Stage 1 与生产 Capture 边界一起做设备级验证。本 Spike 只验证数据层能以独立 Raw Media 引用承载它。

## 6. Keep criteria

只有全部成立，Flutter 才能进入 ADR 的 Adopted 方案：

- 固定版本的 Flutter/Dart 能在无需完整 IDE 的情况下完成 Windows 与 Android 命令行构建；
- Windows artifact 可以启动，Android artifact 结构有效；
- 同一 Dart domain/data module 在两个目标中编译；
- scratch SQLite 在 Windows 实际完成 create → close → reopen → migrate → reopen；
- 迁移前后的原始字段与校验值不变；
- 数据库路径和缓存可定向到 D:，不依赖云/服务端；
- 依赖许可证、维护状态和平台支持没有阻断项；
- 失败路径和环境限制被如实记录，不通过降低 LifeOS 原始数据/隐私原则来“修好”。

## 7. Kill / fallback criteria

出现任一情况，停止把 Flutter 当默认方案并转测 MAUI 或 KMP：

- 在两轮不同的针对性修复后，固定稳定版仍无法构建任一目标；
- persistence 依赖不能同时编译到 Android/Windows，或迁移会重写/丢失原始字段；
- Windows 运行需要不可接受的服务器/WebView/联网前提；
- Android target API 36 或 Windows 11 当前版本需要依赖未发布/预览框架；
- Stage 1 原始语音只能通过不维护、无许可或无法覆盖 Windows+Android 的路径实现；
- 为通过 Spike 必须提前实现 P1/P2 能力或改变产品语义。

## 8. 执行与证据

- 工具链根：`D:\Archer\LifeOS-stage0-tools`；
- throwaway worktree：`D:\Archer\LifeOS-stage0-spike`；
- branch：`spike/stage0-flutter-persistence`；
- 单一运行入口：原型 README 中的一条 PowerShell 命令；
- 结果写入 `docs/engineering/Stage0_Spike_Results.md`；
- 原型分支可以保留并推送作为证据，但不得合并到 `main`；
- ADR 只引用 commit hash、工具版本、命令、artifact 和验证结果。

## 9. 官方资料

- [Flutter supported platforms](https://docs.flutter.dev/reference/supported-platforms)
- [Flutter platform integration](https://docs.flutter.dev/platform-integration)
- [Flutter Android setup](https://docs.flutter.dev/platform-integration/android/setup)
- [Flutter Windows build](https://docs.flutter.dev/platform-integration/windows/building)
- [Flutter Android build](https://docs.flutter.dev/deployment/android)
- [Flutter SDK archive](https://docs.flutter.dev/install/archive)
- [Flutter official Windows release metadata](https://storage.googleapis.com/flutter_infra_release/releases/releases_windows.json)
- [.NET MAUI supported platforms](https://learn.microsoft.com/en-us/dotnet/maui/supported-platforms?view=net-maui-10.0)
- [.NET support policy](https://dotnet.microsoft.com/en-us/platform/support/policy)
- [Compose Multiplatform 1.10](https://blog.jetbrains.com/kotlin/2026/01/compose-multiplatform-1-10-0/)
- [Google Play target API requirements](https://developer.android.com/google/play/requirements/target-sdk)
- [Windows 11 release information](https://learn.microsoft.com/en-us/windows/release-health/windows11-release-information)
- [Flutter `record` package](https://pub.dev/packages/record)

## 10. 完成结果

Stage 0 已按本计划完成，leading Flutter + SQLite/Drift 方案通过 keep gate；最终证据、失败历史和未验证边界见 [Stage 0 Spike Results](./Stage0_Spike_Results.md)。ADR-0001 与 ADR-0002 已完成独立产品/架构复核并接受。原型继续留在独立 Spike 分支，不合入 `main`。
