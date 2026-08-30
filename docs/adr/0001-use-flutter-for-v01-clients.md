---
status: accepted
---

# V0.1 Windows 与 Android 客户端采用 Flutter

LifeOS V0.1 客户端采用固定 stable Flutter/Dart 基线，以共享 domain/data code、允许 Windows 与 Android 使用不同平台适配和界面组合。Stage 0 在 commit `119b0e8` 上实际完成 Windows release、Android API 36 debug 和 Windows SQLite migration/reopen；相较 MAUI/KMP，它以当前最小工具与平台适配面通过了本项目的 measured keep gate。[完整证据](../engineering/Stage0_Spike_Results.md)

## Considered Options

- .NET MAUI 10：官方支持两个目标，但本机 workload 更重，且没有降低 Windows/Android 原始语音适配风险；
- Kotlin/Compose Multiplatform：两个目标可行，但 desktop packaging 与平台音频 seam 更大；
- Flutter：先通过实际双目标 build 与共享 persistence probe，因此采用；MAUI/KMP 保留为 kill-gate fallback。

## Consequences

- API 24 只是 Stage 1 初始构建下界，正式 Android 支持下界仍待依赖与设备矩阵确认；compile/target baseline 为 API 36。Windows V0.1 release matrix 以主流 Windows 11 25H2 为目标，当前 Insider host 证据不能替代 GA 验证；
- Flutter 共享代码不要求两端 UI 完全相同，平台权限、文件、通知与音频使用明确 adapter seam；
- 本 ADR 不采用任何具体录音 plugin，也不声称原始语音已验证；Stage 1 必须在真实 Windows/Android 设备上通过 permission/record/play/delete gate；
- throwaway spike source 不合并进 `main`，Stage 1 production scaffold 需按正式模块与测试边界重新建立。
