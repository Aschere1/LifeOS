# Stage 1 原始语音技术研究

> 文档类型：技术研究 / 实施前 Spike 输入（不改变产品或隐私决策）  
> 日期：2026-09-02  
> 状态：Proposed — 必须完成真实设备 gate，不能据此声称语音能力已验收  
> 范围：Flutter Windows + Android 的本地原始语音录制、播放，以及其与 Stage 1 staged write 的适配性。

## 1. 问题与既定约束

Stage 1 需要把用户刚录制的原始语音保存为私有、本地、可回放且可删除的 Raw Media；不得把它变为 SQLite BLOB、云端对象或 AI 输入。文件系统与 SQLite 不能组成一个原子事务，所以实现必须遵守 [First-Write Invariants](./Stage1_First_Write_Invariants.md)：临时私有目录录制 → close/flush → SHA-256 + byte length → 同卷 atomic rename → 单一 SQLite transaction 写 `Raw Capture` 与 `Raw Media Reference`；失败补偿、重启清理及删除 staging 也必须可恢复。

本研究不决定用户可见时长/大小限制、后台录音、加密、同步或转写。当前仓库的 Android `minSdk` 是 24，`targetSdk` 取 Flutter 配置；ADR-0001 记录的 Stage 1 基线为 target/compile API 36。主 Android manifest 当前尚未声明 `RECORD_AUDIO`；Windows runner 也没有 microphone capability 声明。这是待实施项，不是缺陷已修复的宣称。

项目的 Dart constraint 为 `^3.13.2`。本机此工作 shell 未能找到 `flutter` 可执行文件，故未在本文声称本机 Flutter 版本已满足任一 package 的 Flutter 最低版本。

## 2. 证据方法和限制

版本是截至本报告日期在官方 pub.dev 所见的最新 stable；平台、API、格式和限制来自 package 官方页面与上游源码/README，系统权限来自 Android Developers 与 Microsoft Learn。只采用第一方来源；没有把搜索结果、博客或 package 下载量当作兼容性证据。链接紧邻对应陈述。

“支持”仅表示上游声称该平台/API 可用，**不**表示 LifeOS 已在真机或真实 Windows 安装包上验证。特别是驱动、设备、Windows 隐私控制、OEM 编码器和 app lifecycle 都会改变实际结果。

## 3. 录音候选

| 候选（截至 2026-09-02 stable） | Windows + Android / 原生实现 | License、最低要求和维护信号 | 文件、控制与错误接口 | 结论 |
|---|---|---|---|---|
| [`record` 7.1.1](https://pub.dev/packages/record) | Android 使用 `AudioRecord` + `MediaCodec`/`MediaRecorder`；Windows 使用 Media Foundation；官方矩阵同时列出两个目标。[上游 README](https://github.com/llfbandit/record) | BSD-3-Clause；核心及 Windows/Android implementation 的 pubspec 要求 Dart `^3.12.0`，项目 Dart 3.13.2 满足。[核心 pubspec](https://raw.githubusercontent.com/llfbandit/record/main/record/pubspec.yaml) [Windows pubspec](https://raw.githubusercontent.com/llfbandit/record/main/record_windows/pubspec.yaml) [Android pubspec](https://raw.githubusercontent.com/llfbandit/record/main/record_android/pubspec.yaml)；7.1.1 是 7.1 系列的修复发布，pub.dev 标为 active。[changelog](https://pub.dev/packages/record/changelog) | `AudioRecorder.start(RecordConfig, path:)` 写调用者指定的绝对路径；`stop()` 回传路径；`cancel()` 删除录音；有 `pause`/`resume`、`getAmplitude`/amplitude stream、状态 stream、输入设备列举/选择与 `dispose`。调用失败通过 Future/stream error 返回，官方未提供统一的公开 recorder-error stream。[平台接口](https://raw.githubusercontent.com/llfbandit/record/main/record_platform_interface/lib/src/record_platform_interface.dart) | 唯一应进入 Stage 1 spike 的录音候选。它能由 repository 控制临时及最终路径，但应用必须自己完成 hash、rename、DB transaction、orphan cleanup 与错误归一化。 |
| [`flutter_sound`](https://pub.dev/packages/flutter_sound) | 本次筛选没有找到其官方 package 页面/上游资料中可与 `record` 同等核实的 Windows 本地录音承诺。 | 不作为候选版本钉定，避免把“可在别的平台录音”误写成 Windows 录音支持。 | 不进入 API 或格式评估。 | 排除：跨端关键条件缺少可复核的 Windows 录音证据。 |
| [`audio_waveforms`](https://pub.dev/packages/audio_waveforms) | 官方 package 平台标记不包含 Windows。 | 不适合本项目双端录音前提。 | 不进入评估。 | 排除。 |

### `record` 的格式和功能细节

官方矩阵称 Android 与 Windows **文件**共同支持 AAC-LC、AMR-NB、WAV、FLAC、PCM16；共同的 stream 编码为 AAC-LC（raw AAC，带 ADTS headers）及 PCM16。WAV 和 PCM16 由 package 自己提供。Android 另列 AAC-ELD/HE、AMR-WB 和 Opus；这些不应作为跨端契约。[格式与 stream matrix](https://github.com/llfbandit/record#file)

官方矩阵同时声明两端均支持 pause/resume、dBFS amplitude、channel count、输入设备选择及文件路径；Windows **没有** `permission check`、AGC、echo cancellation 或 noise suppression。Android 的 AGC/echo/noise 标有设备/模式限制，Android README 还明确无 recording-gain/volume control，effects 可能降低输出音量。[功能 matrix](https://github.com/llfbandit/record#platform-feature-parity-matrix) [Android implementation README](https://raw.githubusercontent.com/llfbandit/record/main/record_android/README.md)

Android package 的最低 SDK 是 23（AMR-NB/WB 26，Opus 29）；LifeOS 的 24 覆盖默认共同格式。暂停/恢复在 Android API 24+ 才实际支持，低版本为 no-op；因此项目的 minSdk 24 恰好是此功能的有效下界。[上游 README](https://github.com/llfbandit/record#android) [平台接口注释](https://raw.githubusercontent.com/llfbandit/record/main/record_platform_interface/lib/src/record_platform_interface.dart)

**建议的 Stage 1 音频契约（待 spike 证明）**：以 `AudioEncoder.wav` 和明确的 `.wav` 临时/最终文件扩展名作为首选共同输出。它避开 AAC container/codec 差异，便于将实际字节的 `audio/wav`、`wav` 与 hash 写入 Raw Media Reference；不可将配置名称或文件扩展名当成录制成功或 MIME 的证据。若 Windows 或目标 Android 的实际录制/播放失败，先停在 gate，不静默切换成其他格式。

## 4. 本地播放候选

| 候选（截至 2026-09-02 stable） | 本地文件能力、平台与接口 | License、要求与维护/依赖风险 | 适配本项目的评价 |
|---|---|---|---|
| [`just_audio` 0.10.6](https://pub.dev/packages/just_audio) + [`just_audio_windows` 0.2.3](https://pub.dev/packages/just_audio_windows) | core 在 Android 使用 ExoPlayer；Windows 必须另加 implementation，`just_audio_windows` 为 WinRT MediaPlayer。官方矩阵列 Android/Windows 均支持 file、play/pause/seek、position/duration 与 player error；`setFilePath` / `AudioSource.file` 可只打开本地路径。[core README](https://github.com/ryanheise/just_audio#platform-support) [Windows backend README](https://pub.dev/packages/just_audio_windows) | core 要求 Dart `^3.6.0`，项目满足；core license 为 Apache-2.0、Windows implementation 为 MIT。[core pubspec](https://raw.githubusercontent.com/ryanheise/just_audio/master/just_audio/pubspec.yaml) [core license](https://github.com/ryanheise/just_audio/blob/master/just_audio/LICENSE) [Windows license](https://github.com/bdlukaa/just_audio_windows/blob/master/LICENSE)；core 0.10.6 和 backend 0.2.3 近期稳定发布（官方 pub 页）。 | **推荐播放组合**：用一个 player，严格只用 local-file API，不启用 URL、cache、headers 或 `StreamAudioSource`。需要保留 `.wav` 与实际格式一致；官方说明本地文件没有 Content-Type header，解码通常按扩展名选择。[文件扩展名说明](https://pub.dev/packages/just_audio#file-names) |
| [`audioplayers` 6.8.1](https://pub.dev/packages/audioplayers) | Federated package 原生覆盖 Android/Windows；`DeviceFileSource(path)`、play/pause/resume/stop/seek 和 position/duration/state/completion event 是官方支持的本地文件路径。[官方 Getting Started](https://github.com/bluefireteam/audioplayers/blob/main/getting_started.md) | MIT；Dart `^3.6.0`，项目满足。[pubspec](https://raw.githubusercontent.com/bluefireteam/audioplayers/main/packages/audioplayers/pubspec.yaml) [license](https://github.com/bluefireteam/audioplayers/blob/main/LICENSE) | **Fallback**，并非首选：Windows plugin 当前 CMake 在缺少 `nuget` 时会下载 NuGet executable 与 Microsoft.Windows.ImplementationLibrary；这会增加可复现/离线构建风险，尽管不代表应用运行时联网。[Windows CMake source](https://raw.githubusercontent.com/bluefireteam/audioplayers/main/packages/audioplayers_windows/windows/CMakeLists.txt) |
| [`media_kit` 1.2.6](https://pub.dev/packages/media_kit) | `Player.open(Media(filePath))` 支持本地路径，Android/Windows 均有实现；为 Windows 需配套 native libs，且基于 mpv，格式面比 OS decoder 更广。[上游平台/使用说明](https://github.com/media-kit/media-kit) | MIT；额外 native binaries 与初始化/发布负担较高；Windows audio-only lib package 为 unlisted，较久未更新。[Windows audio libs package](https://pub.dev/packages/media_kit_libs_windows_audio) | 只在真机 gate 证明系统 decoder 无法可靠播放所选输出时评估，不作为 Stage 1 最小依赖。 |

`just_audio` 的 URL、cache、custom byte stream 等能力不应调用：其 Android 文档称远程 URL 要 `INTERNET`，而 proxy-backed 的 headers/cache/`StreamAudioSource` 需要 localhost cleartext 配置。[Android-specific configuration](https://pub.dev/packages/just_audio#android) 这不是本地 `setFilePath` 的需要，也不是 Stage 1 可引入的网络路径。

## 5. 平台权限与 capability

### Android（minSdk 24；Stage 1 baseline target 36）

`RECORD_AUDIO` 是 dangerous permission；Android 6.0 / API 23 及以上必须在 manifest 声明并在运行时请求。创建 `AudioRecord` 而无此许可时，Builder 可抛 `UnsupportedOperationException`，constructor 可得到 `STATE_UNINITIALIZED`。`record_android` 自己的 library manifest 也声明该 permission，但应用 manifest 和真实安装包仍必须在 spike 中核实 merged result 与 prompt/deny/retry 行为。[Android runtime permission guide](https://developer.android.com/training/permissions/requesting) [AudioRecord API](https://developer.android.com/reference/android/media/AudioRecord) [record Android manifest](https://raw.githubusercontent.com/llfbandit/record/main/record_android/android/src/main/AndroidManifest.xml)

Stage 1 应仅在可见 Activity 中、用户直接启动录音后请求/使用 microphone，并在 app background/loss of recording 时停止、flush 并走 staged-write failure path；不设计后台录音。若以后要求离开前台仍继续录音，target 36 需要 `microphone` foreground-service type、`FOREGROUND_SERVICE_MICROPHONE` 和已授予的 `RECORD_AUDIO`，还要显示持续通知。Android 明确说明 microphone permission 是 while-in-use，后台不能创建 microphone FGS（少数例外除外）。这属于新的产品和 Android implementation 决策，不能在本研究中默认加入。[FGS microphone requirements](https://developer.android.com/develop/background-work/services/fgs/service-types#microphone) [background-start restrictions](https://developer.android.com/develop/background-work/services/fgs/restrictions-bg-start)

### Windows

`record_windows` 在 CMake 中链接 `mf.lib`、`mfplat.lib`、`mfreadwrite.lib`、`mfuuid.lib`，即 Microsoft Media Foundation；Microsoft 说明 Media Foundation 的音频 capture device 经 WASAPI 支持。它并不提供与 Android `hasPermission()` 对等的 API。[record Windows CMake](https://raw.githubusercontent.com/llfbandit/record/main/record_windows/windows/CMakeLists.txt) [Microsoft Media Foundation capture](https://learn.microsoft.com/en-us/windows/win32/medfound/audio-video-capture-in-media-foundation)

Windows 麦克风访问还会受设备级、用户级和组织策略控制；Microsoft 的 App Privacy policy 文档说明可由 Settings 或 MDM/Group Policy 设为 user-in-control / force allow / force deny，策略应用后 app 或设备可能需要重启。若以后选择 MSIX/AppContainer packaging，Microsoft 的 capability documentation 把 `microphone` capability 定义为访问麦克风 audio feed；当前 Flutter Windows runner 是未打包 Win32 manifest，是否需要/如何声明 capability 必须按实际分发方式验证，不能套用 UWP/MSIX 一概而论。[Windows microphone privacy policy](https://learn.microsoft.com/en-us/windows/client-management/mdm/policy-csp-privacy#letappsaccessmicrophone) [Windows capability declarations](https://learn.microsoft.com/en-us/windows/apps/package-and-deploy/app-capability-declarations)

## 6. 与 staged write、私有路径、hash、restart 与 delete 的适配

| Invariant | 推荐组合的适配方式 | 不能交给 plugin 的责任 |
|---|---|---|
| 私有临时/最终路径 | 由 repository 从 OS app-data root 构造 LifeOS-owned relative temporary 与 final path，并把绝对 temporary path 传给 `record.start`。`record` 的 path 控制满足这个 seam。[record usage](https://github.com/llfbandit/record#usage) | 不让 plugin 随机选择 public/media library 路径；DB 不写绝对路径。 |
| hash、长度、codec/MIME | `stop` 后 close/flush 完成，再读取最终 bytes 计算 SHA-256 与 byte length；只记录实际 probe/录制结果可确定的 MIME/codec。 | 不把 `RecordConfig`、`.wav` 后缀或 package matrix 当最终事实。 |
| atomic commit / restart | 同卷 temporary → final rename 后才以单 SQLite transaction 写 Capture + Media Reference；transaction failure 按契约删除 final 或写无内容 orphan cleanup；启动仅扫 LifeOS own temp/orphan namespaces。 | plugin 不会跨文件系统与 SQLite 原子提交，也不会执行 LifeOS orphan recovery。 |
| delete | 先将 LifeOS final file rename 至 delete staging，再删 DB ref；DB failure 回滚 rename；commit 后 physical delete，重启完成/回滚。播放前查有效 DB ref。 | player 的 stop/dispose 不等于安全删除；不得扫/删非 LifeOS 路径。 |
| no network/cloud/AI | 录音为 OS local Media Foundation / Android media APIs；播放只以 local-file API 配置。项目不加入 `INTERNET`、后台 audio、cloud、AI 或 telemetry。 | package 具备 URL/stream 功能不构成授权；封装层必须不给 domain 层 URL source。 |

## 7. 推荐、fallback 与未决定项

**建议进入 spike 的最小组合：** `record: 7.1.1` + `just_audio: 0.10.6` + `just_audio_windows: 0.2.3`，固定 Stage 1 的候选共同输出为 WAV。它使用 Android/Windows 的系统媒体设施，录音方可指定文件路径，播放方可只加载 local file；没有为本地回放额外声明网络或后台服务。版本锁定须在实施 PR 中重新以 `dart pub get` 的 resolved lockfile 复核，而不是仅抄录本文。

**fallback：** 录音继续为 `record: 7.1.1`，播放改 `audioplayers: 6.8.1` 并仍只用 `DeviceFileSource`。只有当推荐组合的 Windows local WAV playback gate 失败、而 fallback 成功且其 NuGet build-time download/reproducibility 风险被工程接受时使用。若两者都不能跨平台播放 WAV，不应静默引入 AAC/Opus/FFmpeg/媒体云；升级为架构/产品 gate 后再评估 `media_kit`。

未决定且不可由本研究解决：用户可见时长/大小限制；是否允许 background recording；正式 Windows 打包方式与 capability；WAV 的 sample rate/channels/文件大小取舍；音频 MIME/codec 的实际 probe 策略；Windows privacy-denied 的用户可见文案；真实设备上 pause/resume 后的 WAV 连续性。

## 8. 必须通过的真实设备 spike / kill gates

以下每项必须在一台 Android API 24+ 真机（另加 API 36 target device）和一台目标 Windows 11 GA 设备上通过；模拟器、编译成功、package matrix 或 host-only 手工播放都不替代。记录 OS/build/version、真实 output 的 SHA-256、字节数、扩展名、duration、codec/MIME probe 结果与不含音频内容的 error code。

| Gate | Pass 标准 | Kill / escalation 条件 |
|---|---|---|
| Build and permission | clean Android/Windows release-like build；Android 第一次用户操作触发准确的 mic prompt；grant、deny、permanent deny/reopen 均不创建 Capture。Windows device absent、privacy denied、policy denied 能得到非内容错误并不创建 Capture。 | 需要 `INTERNET`、cloud/AI、隐式 background capture，或 Windows denied 被误报为保存成功。 |
| Record / pause / resume | 在项目 private temporary path 录 10–30 s WAV，pause/resume 后 `stop` 成功；回放可听、波形/时长无明显断裂；amplitude 只作 UI 辅助且不进日志。 | API 24/Windows 任何端无可靠输出、停止后文件仍被锁定、或 pause/resume 损坏输出。 |
| Staged write durability | 在 rename 前、rename 后/DB 前、DB transaction 中、commit 后分别 kill app；relaunch 后仅出现“文件和有效 reference 均存在”的 Capture，或被安全清理/可重试；hash/length 与最终 bytes 一致。 | 出现假成功、孤儿被当有效 Capture、扫描/删除非 LifeOS 文件、或 raw metadata 与最终字节不一致。 |
| Local playback | 从 DB reference 的 app-private final `.wav` 以 local-file API load/play/pause/seek/stop/dispose；重启后仍可播；损坏/不存在文件返回可分类错误，不能崩溃或联网 fallback。 | 为播放要求 URL、cleartext、INTERNET、远程 cache，或任一端不能播放实际录音。 |
| Delete / recovery | 播放中 stop/dispose 后 delete；kill 于 delete staging 与 DB delete 两端；重启后得到原记录+原文件或两者皆不可见并完成物理删除。 | DB/media split-brain、原始语音泄漏进日志/临时公开目录，或删除尝试触达应用外路径。 |

## 9. 研究结论与升级建议

推荐组合在文档层面满足 Stage 1 所需的双平台本地路径/录制/回放 seam，且没有技术理由要求加入网络、云或 AI；但 **尚无 LifeOS 实测证据**。建议立刻进行上述小型真实设备 spike；它是实现前的必要 gate，而不是产品范围升级。

若发生任一 kill 条件，或为满足需求必须加入后台 microphone FGS、改变音频格式、声明 Windows packaged capability、设定用户可见限制，建议升级为 `PRODUCT DECISION REQUIRED` / ADR 输入后再继续。否则 spike 通过后可在不改变产品决策的前提下进入 Stage 1 repository implementation。
