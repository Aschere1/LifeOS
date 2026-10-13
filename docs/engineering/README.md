# LifeOS Engineering Documents

本目录保存低于 Product Constitution、Master PRD、当前 Version PRD 与 Decision Log 的工程证据和实现契约。它们不能创造产品行为；出现语义冲突时必须回到 [产品文档入口](../README.md)。

## 当前实施路线

[文字优先内部试用路线](./Text_First_Trial_Implementation_Route.md)（D-035）为当前执行入口。原始语音路线暂停新增实现；已完成迁移和样机证据继续保留，完整 V0.1 P0 不变。

## Stage 0（已完成）/ Stage 1 foundation

1. [V0.1 P0 Traceability Matrix](./V0.1_P0_Traceability_Matrix.md)：14 个 P0 Requirement、22 个 P0 acceptance criteria 与 Stage 1 executable slice；
2. [Stage 0 Architecture Spike Plan](./Stage0_Architecture_Spike_Plan.md)：技术问题、候选方案、keep/kill gate 与原型边界；
3. [Stage 0 Spike Results](./Stage0_Spike_Results.md)：双目标 build、migration/reopen、异常恢复、失败历史与限制；
4. [Stage 1 First-Write Invariants](./Stage1_First_Write_Invariants.md)：Raw/Derived、identity/time、privacy、media write/delete 与 migration contract。
5. [Stage 1 Text Capture Evidence](./Stage1_Text_Capture_Evidence.md)：首批文字 Capture 纵向切片的实现、测试、双平台构建与范围验收证据。
6. [Stage 1 Schema v2 Migration Evidence](./Stage1_Migration_Evidence.md)：真实 v1 文字库升级、失败回滚与 Raw Media schema 基础；不代表语音功能或恢复协议已完成。

## Architecture decisions

- [Stage 1 Raw Voice Implementation Route](./Stage1_Raw_Voice_Implementation_Route.md)：原始语音实施依赖、模型与推理强度、样机证据和未完成验收。
- [Stage 1 Raw Voice Failure Matrix](./Stage1_Raw_Voice_Failure_Matrix.md)：保存、待决定音频、删除、迁移与重启恢复的故障断言；测试规格不等于已验收。
- [Stage 1 Raw Voice Technical Research](./Stage1_Raw_Voice_Technical_Research.md)：候选录音/播放方案研究；最终选择须结合样机证据。

- [ADR-0001：V0.1 Windows 与 Android 客户端采用 Flutter](../adr/0001-use-flutter-for-v01-clients.md)；
- [ADR-0002：本地数据采用 SQLite/Drift，并分离 Raw 与 Derived 存储](../adr/0002-use-sqlite-drift-and-separate-raw-derived-storage.md)。

Stage 0 的 evidence、PRD alignment 与风险检查已通过独立 Review；ADR-0001 与 ADR-0002 状态均为 `accepted`。这只接受 Stage 1 的技术基础，不代表 Stage 1 或 V0.1 产品验收完成。
