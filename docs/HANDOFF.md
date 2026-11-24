# LifeOS 换机交接

盘点日期为 2026-11-24。当前产品代码基线为 `51b10e7`，开发入口为 [Aschere1/LifeOS](https://github.com/Aschere1/LifeOS) 的 `main` 分支。

## 1. 从哪里接手

先读[产品文档入口](README.md)，再按其中的顺序阅读。交接页记录当前进度和恢复方法，产品行为以正式需求文档为准。

| 想了解什么 | 去哪里看 |
| --- | --- |
| LifeOS 的设计理念、默认隐私和 AI 边界 | [产品宪法](LifeOS_Product_Constitution.md) |
| 长期产品、真实人生时间线、行动、记忆与回响 | [Master PRD](LifeOS_Master_PRD_v1.0.md)、[领域术语](../CONTEXT.md) |
| 首版做什么、如何验收 | [V0.1 PRD](LifeOS_V0.1_PRD.md)、[P0 验收追踪表](engineering/V0.1_P0_Traceability_Matrix.md) |
| 为什么先做文字、录音什么时候恢复 | [决策日志 D-035](LifeOS_Decision_Log.md)、[文字优先试用路线](engineering/Text_First_Trial_Implementation_Route.md) |
| Flutter、SQLite/Drift 的技术取舍，已有验证 | [工程文档索引](engineering/README.md)，含两份架构决策、测试证据及语音实验结论 |
| 如何让下一位 Codex 接手 | [操作手册](Codex_Operating_Manual.md)、[模型路由与协作流程](LifeOS_Model_Routing_and_Codex_Workflow.md) |

LifeOS 通过时间线连接人真实经历过的事情、未来的行动和长期回忆。记录要足够轻量，原话和原始资料应可追溯，空白可以保留，用户有权确认、修改与删除。休息和娱乐也是生活。资料默认私有、本地优先，外部 AI 需要单独授权。实现时区分用户原话、可证实的事实和 AI 推断。

## 2. 已有功能与验证

| 内容 | 当前状态 |
| --- | --- |
| 文字随手记 | Windows 和 Android 可离线把文字原样保存为私有原始记录。在「现在」页可以阅读今天的列表和原文。两端已有关闭进程后重新打开的回看证据。见[文字捕获证据](engineering/Stage1_Text_Capture_Evidence.md)。 |
| 本地数据库 | 已采用 SQLite/Drift，包含 schema v2、v1→v2 迁移、原文及元数据保留和失败回滚测试。原始媒体的数据结构已预留。见[迁移证据](engineering/Stage1_Migration_Evidence.md)。 |
| 往日历史与文字删除 | 待实现。当前「现在」页只展示当天，独立时间线和日期选择尚未进入产品代码。 |
| Session、Entry、Spark、Task/DDL、Unknown、Daily Review、Life Area | 均待按当前路线分批实现和验收。 |
| 录音与播放 | 仍属 V0.1 P0，排在文字试用之后。本地实验与生产代码隔离。平台实验有构建和部分 Windows 运行证据，Android 真机语音及故障恢复验收仍待完成。见[语音路线](engineering/Stage1_Raw_Voice_Implementation_Route.md)。 |
| AI、同步、备份与完整隐私设置 | 仍待按 V0.1 范围及后续决策推进。不要把源码的 GitHub 迁移理解为应用记录的跨设备同步。 |

## 3. 新 Windows 电脑恢复开发

1. 安装 Git 和 Flutter，按现有基线优先使用 Flutter `3.47.2`（随附 Dart `3.13.2`）。运行 Windows 版需要 Visual Studio 的 C++ 桌面开发组件和 Windows 开发者模式。已验证的 Android 构建环境使用 JDK 21 和 Android SDK API 36。用 `flutter doctor -v` 确认目标平台环境。
2. 在新电脑选择自己的项目目录。用 `Aschere1` 登录 GitHub 即可管理仓库。旧电脑的 `D:\Archer` 路径仅供对照。根据新电脑实际安装位置配置 Flutter、Java 和 Android SDK。
3. 克隆并验证。Android 调试时连接设备，先运行 `flutter devices`，再用 `flutter run -d <设备ID>`。生产签名密钥需要独立保管和配置。

```powershell
git clone https://github.com/Aschere1/LifeOS.git
Set-Location LifeOS
flutter --version
flutter doctor -v
flutter pub get
flutter analyze --no-pub
flutter test --no-pub
flutter run -d windows
```

首次打开后，用一条临时测试文字验证「随手记 → 保存 → 首页显示 → 点开原文」，再关闭应用并重开确认还在。应用会使用当前设备的数据目录。换机时如需保留旧电脑里已有的真实记录，请另做私密本地备份，先保留原件并确认应用已退出。Windows 的应用数据在 `%LOCALAPPDATA%\com.aschere\lifeos`。数据库、录音、登录凭据、签名密钥和工具缓存均应留在各自的本地或专用保管位置。

旧电脑另存的离线迁移包可通过 U 盘等私密渠道搬走。解压后，若要恢复本地实验分支和提交历史，可在解压目录运行 `git clone --branch main LifeOS-handoff-2026-11-24.bundle LifeOS-offline`。用 `git branch -a` 查看随包保留的分支。包里的工作笔记反映各阶段当时的进度，当前接手以本页和正式路线为准。

## 4. 下一批开发工作

1. 完成往日文字回看（V0.1 §3.1–3.2、V0-P0-08/12）。保留「现在」的今日视图，新增可选日期的时间线和原文详情入口。复用 `CaptureStore.watchCaptures`，在界面层验证当天零点、次日零点、日期切换、空态、读取失败和原文显示。从往日页面开始一条新随手记时，仍使用实际记录时间。
2. 单独处理文字本地删除。按 PRD、决策和数据生命周期约束确认删除提示、删除后有效数据的边界，以及与未来同步的关系。只有在正式文档仍缺少必要的产品规则时，才提交 `PRODUCT DECISION REQUIRED`。
3. 按[文字优先路线](engineering/Text_First_Trial_Implementation_Route.md)继续行动段、现场文字/火花、时间线与回顾、基本任务与截止时间。以实际试用验证低成本记录和回看。完整 V0.1 验收继续包含原始语音与其余 P0。

涉及日期界面的代码入口是 `lib/src/ui/lifeos_app.dart`，本地存储接口在 `lib/src/capture/capture_store.dart`，实现位于 `lib/src/persistence/`。已有界面、存储和迁移测试在 `test/`。

新电脑的 Codex 可以从这段任务描述开始：

> 请阅读 `docs/HANDOFF.md` 和 `docs/README.md`，按规定顺序读取相关产品文档。对照当前 Git 状态和文字优先路线，从往日文字回看继续。按任务风险选择模型与推理强度，完成测试及独立审查。VibeHub 已停用。用通俗中文汇报，专业维护项目文档。
