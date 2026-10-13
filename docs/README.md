# LifeOS 产品文档入口

这里是 LifeOS 的 Markdown 产品文档集合。它们是后续产品讨论、设计和 Codex 实现任务的长期锚点。Markdown 是唯一权威源；如果未来生成 DOCX/PDF，它们只是阅读版或归档版。`Codex_Operating_Manual.md` 是每次接到任务时的执行 SOP，模型路由文档是它引用的协作与路由规则。

## Codex 推荐阅读顺序

进入本页即完成 README 入口阅读。随后每次开始 LifeOS 相关任务时，按下面顺序读取：

1. [产品宪法](./LifeOS_Product_Constitution.md)：理解使命、不可违背的原则和产品边界；
2. 当前任务对应的版本 PRD，例如 [V0.1 PRD](./LifeOS_V0.1_PRD.md)：确认本次实际范围；
3. 与任务相关的 [Master PRD v1.0](./LifeOS_Master_PRD_v1.0.md) 章节：确认该能力在完整 LifeOS 中的长期形态和上下游关系；
4. [Decision Log](./LifeOS_Decision_Log.md)：查找历史取舍、未决问题和文档看似冲突的背景；
5. [模型路由与 Codex 协作工作流](./LifeOS_Model_Routing_and_Codex_Workflow.md)：选择模型、Agent 拆分、实现/审查分工、升级降级或并行协作；
6. [Codex Operating Manual](./Codex_Operating_Manual.md)：按本手册执行授权确认、范围控制、测试、验收、审查和结果汇报。

`CONTEXT.md` 是跨任务的术语和领域上下文，任务涉及对象、状态或概念时必须一并查阅；它不改变上述产品文档的权威层级。局部机械任务可以缩短 Master 章节阅读，但一旦出现语义、隐私、AI、原始记录、离线/同步或范围问题，必须回到完整顺序。

工程实施前还应进入 [工程文档索引](./engineering/README.md)，读取与当前阶段相关的 traceability、Spike 证据、实现契约与 ADR。工程文档只落实上位产品语义，不能覆盖本页的权威层级。

## 权威层级与冲突规则

```text
Product Constitution
        ↓
Master PRD
        ↓
当前 Version PRD
        ↓
其他产品/设计文档
        ↓
模型路由与 Codex 协作工作流（只规定协作，不改变产品语义）
```

`Decision Log` 解释关键决定及其原因；它不是完整 PRD，也不能用一条未经确认的聊天内容覆盖产品文档。模型路由文档是执行规则，不能把模型或 Agent 的建议提升为产品需求。

`Codex_Operating_Manual.md` 与模型路由文档都属于执行层，只能规定如何协作和验证，不能改变产品文档定义的对象、状态、权限、范围或长期含义。

### 如何判断冲突

- 宪法与任何下位文档冲突：以宪法为准，停止实现并报告；
- Master PRD 与 Version PRD 看似冲突：先判断 Version PRD 是否只是明确“当前版本暂不实现”；如果是，不构成冲突；
- Version PRD 若改变了长期语义：不能自行猜测，必须提出产品决策并更新 Decision Log；
- 术语与功能描述冲突：以 [CONTEXT.md](../CONTEXT.md) 的统一定义为准；若确实需要改变含义，先更新术语表并记录理由；
- 聊天记录与正式文档冲突：正式文档优先；聊天中的新决定只有在更新文档后才成为可执行要求；
- 模型路由规则与产品文档看似冲突：产品文档优先；应调整协作方式，而不是调整产品语义；
- Operating Manual 与产品文档看似冲突：产品文档优先；应暂停并上报，而不是为了遵守流程擅自改变产品行为；
- 文档不明确：保守实现、保留原始信息、不要自动扩大范围，并在结果中列出待决问题。

### “暂不实现”不等于“永远不需要”

例如：

- Master PRD：长期需要 Echo；
- V0.1 PRD：本版本暂不实现 Echo。

这是合法的版本裁剪。V0.1 仍不得把普通时间线设计成无法承载未来 Moment/Echo 的错误语义。

## 文件职责

| 文件 | 负责什么 | 不负责什么 |
|---|---|---|
| `../CONTEXT.md` | 统一领域语言、对象定义、避免同义词漂移 | 功能规格、技术设计、临时笔记 |
| `LifeOS_Product_Constitution.md` | 使命、价值观、永久边界、功能审查原则 | 页面细节、实现计划 |
| `LifeOS_Master_PRD_v1.0.md` | 完整长期产品、核心系统、对象关系和未来能力 | 当前迭代的工程任务拆解 |
| `LifeOS_V0.1_PRD.md` | 首版页面、流程、状态、异常、P0/P1/P2、验收标准 | 终局产品定义 |
| `LifeOS_Model_Routing_and_Codex_Workflow.md` | 模型角色、任务路由、Agent 协作、升级降级、审查和度量 | 业务实现代码、产品语义和架构细节 |
| `Codex_Operating_Manual.md` | 每次接任务的阅读顺序、授权、执行阶段、停问条件、测试、DoD 和汇报 | 产品语义、具体业务实现代码、替代产品决策 |
| `LifeOS_Decision_Log.md` | 关键取舍、背景、原因、后果、待决问题 | 代替 PRD 描述完整功能 |

## 维护流程

LifeOS 的产品维护流程是：

```text
讨论新需求
    ↓
明确问题、对象、边界和取舍
    ↓
决定是长期能力、当前版本能力还是实验
    ↓
更新 Decision Log
    ↓
更新 Master PRD / 当前 Version PRD / CONTEXT.md
    ↓
选择模型与协作方式，建立验收标准
    ↓
按 Codex Operating Manual 执行、验证、审查和汇报
    ↓
再进入设计或实现
```

### 什么时候更新哪份文件

- 改变“LifeOS 为什么存在”或默认价值观：更新 Product Constitution；
- 新增或改变长期核心系统：更新 Master PRD；
- 改变当前版本范围、页面或验收条件：更新对应 Version PRD；
- 新对象、术语或对象边界出现变化：更新 `CONTEXT.md`；
- 存在明显替代方案、真实取舍或未来读者会问“为什么”：更新 Decision Log；
- 模型角色映射、升级阈值、并行原则或路由指标发生变化：更新 `LifeOS_Model_Routing_and_Codex_Workflow.md`，并在 Decision Log 记录依据；
- Codex 的启动顺序、授权边界、DoD、测试/汇报 SOP 发生变化：更新 `Codex_Operating_Manual.md`，并在 Decision Log 记录依据；
- 只是文案、排版或不改变语义的修正：可以直接更新对应文档，但仍需保持交叉链接正确。

## 给 Codex 的标准任务提示

可以使用下面的短提示作为任务前缀：

> 阅读 `docs/README.md`，然后按 `docs/Codex_Operating_Manual.md` 的顺序读取 Product Constitution、当前 Version PRD、相关 Master PRD 章节、Decision Log 和 `docs/LifeOS_Model_Routing_and_Codex_Workflow.md`。当前任务只实现当前版本 PRD 明确包含的范围，不要把 Master PRD 的后续能力擅自提前。遵守 Product Constitution 的事实、隐私、AI、离线和用户控制边界。若发现需求冲突、需求缺口或需要新增产品行为，先报告冲突和影响；不要用猜测改写长期产品语义。完成前必须测试、对照 PRD 验收、安排 Reviewer，并按 Operating Manual 汇报风险和文档缺口。

## 实现前检查清单

- [ ] 已确认本次任务对应的版本 PRD 和范围；
- [ ] 已查过相关 Master Requirement；
- [ ] 已复用 `CONTEXT.md` 中的术语；
- [ ] 已区分 Capture、Record、Session、Task、Moment、Insight 等对象；
- [ ] 已区分 Fact、User Expression 和 Inference；
- [ ] 未把 AI 或网络设为核心记录的必要条件；
- [ ] 未把休息、娱乐、未知或失败变成羞辱/惩罚；
- [ ] 未扩大默认数据收集、外部 AI 读取或分享权限；
- [ ] 原始输入仍可回看，AI 建议可审阅、可拒绝；
- [ ] 已考虑删除、离线、同步冲突和用户离开后回来；
- [ ] 若使用 Agent 协作，已阅读模型路由文档并明确五项指标、owner 和 Reviewer；
- [ ] 已按 `Codex_Operating_Manual.md` 确认授权、范围、停止条件、测试、DoD 和汇报格式；
- [ ] 需求缺口没有被执行 Agent 自行决定；
- [ ] 已安排与风险匹配的独立验证；
- [ ] 新的产品取舍已写入 Decision Log。

## 文档状态说明

- `Draft`：已经形成可执行的产品描述，但仍允许通过正式决策修订；
- `Adopted`：当前明确采用；
- `Provisional`：方向明确，等待原型、真实使用或进一步选择；
- `Open`：不能当成已确认需求。

## 当前文档基线

当前基线为：

- Product Constitution：Draft v1.0；
- Master PRD：Draft v1.0；
- V0.1 PRD：首版范围基线；
- Model Routing and Codex Workflow：Draft v1.0；
- Codex Operating Manual：Draft v1.0；
- Decision Log：D-001 至 D-035；
- 当前实施顺序：[文字优先内部试用](engineering/Text_First_Trial_Implementation_Route.md)（D-035）；暂停新增语音实现，不移除 V0.1 P0 语音要求。
- `CONTEXT.md`：LifeOS 领域统一语言初版。
- Stage 0 工程基础：Completed；ADR-0001（Flutter）与 ADR-0002（SQLite/Drift、Raw/Derived 分离）已接受，Stage 1 真实设备与 production data gate 尚未验收。

后续修改请保留历史语义，优先增加版本、决策和变更说明，而不是静默重写过去。
