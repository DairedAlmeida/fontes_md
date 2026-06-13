                                                   Towards Engineering Multi-Agent LLMs: A
                                                           Protocol-Driven Approach
                                                       Zhenyu Mao1 , Jacky Keung1 , Fengji Zhang1 , Shuo Liu1,∗ , Yifei Wang1 , and Jialong Li2
                                                             1
                                                             City University of Hong Kong, Hong Kong, China 2 Waseda University, Tokyo, Japan
                                                          zhenyumao2-c@my.cityu.edu.hk, Jacky.Keung@cityu.edu.hk, fzhang278-c@my.cityu.edu.hk
                                                                           ywang4748-c@my.cityu.edu.hk, lijialong@fuji.waseda.jp
                                                                             *corresponding author: sliu273-c@my.cityu.edu.hk


                                            Abstract—The increasing demand for software development           agent LLM frameworks, such as AutoGen, MetaGPT, and
                                         has driven interest in automating software engineering (SE)          ChatDev, have been developed to model distinct development

arXiv:2510.12120v1 \[cs.SE\] 14 Oct 2025

                                         tasks using Large Language Models (LLMs). Recent efforts             roles and workflows based on existing software process models
                                         extend LLMs into multi-agent systems (MAS) that emulate
                                         collaborative development workflows, but these systems often fail    such as Agile [17] and Waterfall [18].
                                         due to three core deficiencies: under-specification, coordination       Despite their conceptual appeal, current multi-agent LLM
                                         misalignment, and inappropriate verification, arising from the       systems often under-perform in practice, as evidenced by high
                                         absence of foundational SE structuring principles. This paper        failure rates on SE tasks. Cemri et al. [19] introduced the
                                         introduces Software Engineering Multi-Agent Protocol (SEMAP),        Multi-Agent System Failure Taxonomy (MAST) and identified
                                         a protocol-layer methodology that instantiates three core SE
                                         design principles for multi-agent LLMs: (1) explicit behavioral      three recurring issue categories: under-specification, inter-
                                         contract modeling, (2) structured messaging, and (3) lifecycle-      agent misalignment, and inappropriate verification.
                                         guided execution with verification, and is implemented atop             From a classical SE perspective, these failures can be inter-
                                         Google’s Agent-to-Agent (A2A) infrastructure. Empirical eval-        preted as symptoms of three deeper structural deficiencies: (1)
                                         uation using the Multi-Agent System Failure Taxonomy (MAST)          inadequate component design, where agent responsibilities and
                                         framework demonstrates that SEMAP effectively reduces failures
                                         across different SE tasks. In code development, it achieves up to    role boundaries are poorly defined; (2) insufficient interface
                                         a 69.6% reduction in total failures for function-level development   specification, where inter-agent communication lacks semantic
                                         and 56.7% for deployment-level development. For vulnerability        structure or typed formats; and (3) inappropriate transition
                                         detection, SEMAP reduces failure counts by up to 47.4% on            logic, where the system progresses between stages without
                                         Python tasks and 28.2% on C/C++ tasks.                               formal gating or validation. Traditional SE addresses such
                                            Index Terms—Large Language Models, Multi-Agent Systems,
                                         AI Agent Protocols, Software Engineering, AI for SE
                                                                                                              challenges through well-established principles: components
                                                                                                              are designed with explicit contracts, interfaces are formal-
                                                                                                              ized to ensure consistent integration, and system behavior
                                                                 I. I NTRODUCTION
                                                                                                              is governed by state-based coordination models that enforce
                                            As software has become an essential backbone supporting           correctness through verification. However, these SE principles
                                         almost every aspect of modern society, nowadays there has            remain largely absent from current multi-agent LLM frame-
                                         been a rapid increase in demand not only for more software           works, which are often built on loosely coupled prompts and
                                         but also for more advanced software development to sustain           informal, ad hoc role specifications.
                                         and accelerate technological progress. However, although the            To operationalize this vision, this paper introduces the Soft-
                                         number of software developers is reaching 47 million in              ware Engineering Multi-Agent Protocol (SEMAP), a protocol-
                                         2025 [1], this remains insufficient to meet the rising demand,       layer methodology that instantiates three core SE-inspired
                                         prompting increasing reliance on AI-powered tools.                   design principles: (1) explicit behavioral contract modeling,
                                            Large Language Models (LLMs) have emerged as a promis-            (2) structured messaging, and (3) lifecycle-guided execution
                                         ing solution to address the growing gap between software             with verification. SEMAP is implemented as a lightweight
                                         development demand and available developer resources. With           protocol middleware atop Google’s Agent-to-Agent (A2A)
                                         LLMs’ strong ability to understand and interpret both nat-           infrastructure and supports both centralized and decentralized
                                         ural and machine languages, LLMs have been successfully              workflows. While elements of these principles have appeared
                                         applied across a wide range of domains, including evolutionary       independently, SEMAP is the first to unify them in a domain-
                                         computation [2], communication analysis [3], self-adaptive           specialized protocol for the coordination in multi-agent LLMs.
                                         systems [4], and, increasingly, software engineering (SE) [5]–
                                                                                                                                    II. BACKGROUND
                                         [7]. Recent research has explored how teams of LLMs can
                                         be orchestrated to simulate collaborative workflows in real-         A. Multi-Agent LLMs for SE
                                         world SE tasks [8] such as requirement engineering [9], [10],          The recent progress in LLMs has led the development
                                         code generation [11], [12], quality assurance [13], [14], and        of multi-agent LLMs, where multiple LLM instances, each
                                         maintenance [15], [16]. In addition, several end-to-end multi-       assuming a distinct, role-specific function, collaborate to solve

complex tasks. This approach is inspired by human collabora- mitigates
under-specification at both role and task levels; (2) tive work, in
which modular responsibilities are distributed Structured messaging,
drawing from typed interface design among team members and coordinated
through structured and schema-driven communication in SE, enforces
seman- communication. In the context of SE, multi-agent LLMs seek
tically typed inter-agent messaging to ensure clarity, com- to automate
SE processes by breaking down high-level goals pleteness, and
coordination alignment; (3) Lifecycle-guided into sub-tasks and
delegating them to specialized agents. execution with verification,
reflecting state machine--based Multi-agent LLMs have been utilized to
support a wide workflow modeling and stage-wise testing in SE,
structures range of SE tasks. In requirements engineering, they enable
collaboration around a task-specific lifecycle with embedded the
elicitation, analysis, and validation of requirements by verification
gates. This ensures output correctness and guards simulating human users
interactions and processing natural against premature or invalid
termination. language specifications \[9\], \[10\]. For code generation,
role- specialized agents, such as planners, implementers, and re- B.
Explicit Behavioral Contract Modeling viewers, collaborate to produce
code, integrate components, and ensure alignment to coding standards
\[11\], \[12\]. Within To address under-specification in multi-agent
LLMs, the the scope of quality assurance, multi-agent LLMs contribute
proposed methodology adopts a contract-oriented modeling to software
testing through automated test case generation, paradigm inspired by DbC
principle. In traditional SE, DbC execution, and analysis \[13\],
\[14\]. Additionally, they support establishes a formal agreement
between software components, vulnerability detection by identifying and
mitigating security including pre-conditions define what must be true
before exe- flaws within software systems \[13\]. In software
maintenance, cution, and post-conditions define what must hold
afterward. they assist in monitoring runtime behavior, diagnosing
faults, Translating this into the multi-agent LLM systems context, and
generating appropriate patches or modifications \[15\], \[16\]. each
agent is modeled through an explicit behavioral contract, a verifiable
schema that specifies the required input artifacts B. Multi-Agent
Protocols and expected output artifacts. Inputs capture the minimal
Recent efforts to formalize communication in multi-agent artifacts the
agent requires to operate meaningfully, such as LLMs have led to the
development of a diverse set of task plans, peer feedback, or prior
outputs, while outputs protocols. A recent survey \[20\] categorized
these protocols represent the agent's expected contributions, such as
the code along two dimensions: (1) context-oriented vs. inter-agent,
artifact generated by the Coder, or a review log produced depending on
whether the focus is on managing internal by the Reviewer. This
contract-oriented modeling formalizes context of agents or external
coordination between them, and agent responsibilities and role
boundaries, reducing ambiguity (2) general-purpose vs. domain-specific,
depending on whether across both design-time and runtime interactions.
Formally, a they are intended for broad use or tailored to a specific
domain. behavioral contract C ∈ C is represented as a tuple as follows:
A significant advancement in general-purpose agent in- teroperability is
Google's Agent-to-Agent (A2A) protocol. C = (name, IC , OC ) A2A
establishes a modular communication framework where autonomous agents
interact through structured HTTP-based where: APIs, using JSON-RPC 2.0
as the foundational message • name: a role identifier (e.g., Reviewer);
format. Each agent exposes a run() function and publishes • IC : set of
required input artifacts (i.e., pre-conditions); a machine-readable
Agent Card, a JSON-based declaration of • OC : set of required output
artifacts (i.e., post-conditions). its identity, supported endpoints,
input/output modalities (e.g., text, image, file), authentication
requirements, and capabili- C. Structured Messaging ties. This approach
enables dynamic discovery and seamless integration of agents across
diverse environments, laying the While behavioral contracts define the
roles, inputs and groundwork for scalable and interoperable multi-agent
LLMs. outputs of agents, effective coordination also requires that
inter-agent communication be semantically clear and com- III. M
ETHODOLOGY plete. To address coordination misalignment in multi-agent A.
Methodology Overview LLMs, the proposed methodology adopts a structured
mes- This section introduces the Software Engineering Multi- saging
model that standardizes how information is exchanged Agent Protocol
(SEMAP), a structured methodology built on between agents. Each message
M ∈ M is formalized as: the insight that reliable multi-agent
coordination requires the same core abstractions that underpin classical
SE, namely M = (sender, receiver, CM ) components, interfaces, and
transition logic. As shown in Fig. 1, SEMAP comprises three core
principles, each grounded where: in foundational SE practices: (1)
Explicit behavioral con- • sender: the identifier of the source agent;
tract modeling, inspired by the principle of Design by Con- • receiver:
the identifier of the target agent; tract (DbC), formalizes agent
responsibilities through pre- • CM : a payload structured as a list of
schema-designated conditions and post-conditions. This reduces ambiguity
and objects (e.g., code, review log, reviewer comment).  Fig. 1:
Methodology Overview

D. Lifecycle-Guided Execution with Verification Deployment-level
development: The deployment-level de- While behavioral contracts and
structured messaging ensure velopment task is based on ProgramDev
\[19\], where agents local correctness and coordination, they do not
guarantee develop a complete deployment starting from a one-sentence
global task completion or output validity. To address this, the user
requirement. methodology introduces a lifecycle-guided execution model,
C/C++ vulnerability detection: This task uses which structures agent
collaboration as a state machine with devign100, a 100-sample subset of
the Devign dataset \[22\], verification-driven transitions. This ensures
that task progres- constructed by randomly selecting 50 vulnerable and
50 safe sion is gated by validation and that failures can trigger C/C++
functions. Each sample contains a function-level code appropriate
recovery or reassignment actions. Formally, a task snippet and a binary
label indicating the presence or absence lifecycle is modeled as a
finite state machine (FSM): of a vulnerability. The code snippets are
typically short (under 30 lines), enabling agents to focus on localized
vulnerability L = (S, Σ, δ, s0 , F) patterns such as pointer misuse or
unsafe memory operations. where: Python vulnerability detection: This
task uses vudenc100, a 100-sample dataset created by randomly • S: a set
of lifecycle stages (e.g., initialized, implementing, sampling from the
CVEFixes dataset \[23\]. A function is reviewing, completed, failed);
labeled as vulnerable if any of its lines are marked as such in • Σ:
verification outcomes (e.g., pass, fail); the original line-level
annotations. Similarly, the final dataset • δ : S × Σ → S: a transition
function for the next stage; consists of 50 vulnerable and 50 safe
Python functions. • s0 ∈ S: the initial stage (typically initialized);
Compared to devign100, these code snippets are longer • F ⊆ S: terminal
stages (e.g., completed, failed). and structurally more complex, often
containing real-world IV. P RELIMINARY E VALUATION CVE patches with
nested logic and broader reasoning scopes. This section presents the
evaluation of SEMAP, focusing on b) Baseline and model settings: The
baseline system is its effectiveness in reducing failures in multi-agent
LLMs for implemented using the MetaGPT framework. For development SE
tasks. The research questions (RQs) are set as follows: tasks, it adopts
a centralized CEO-style multi-agent architec- • RQ1: To what extent does
SEMAP mitigate fail- ture consisting of five agents: a CEO, a Planner, a
Coder, ures across the three major categories, namely under- a Reviewer,
and a Tester. For vulnerability detection tasks, specification,
coordination misalignment, and verification both the baseline and SEMAP
use a decentralized three-agent failure, compared to the baseline in
different SE tasks? settings consisting of an Auditor, a Critic, and a
Tester. • RQ2: How effectively does SEMAP enable consistent Experiments
are conducted using DeepSeek-V3-0324 and and stable failure reduction
across collaboration rounds, gpt-4.1-nano-2025-04-14 as the underlying
agent models. For particularly in minimizing recurrence in each
category? development tasks, SEMAP and the baseline are allowed up to
five collaboration rounds per task. For vulnerability detection, A.
Experiment Settings the system executes a single round of analysis and
voting. a) Tasks and datasets: The experiments include two rep- c)
Evaluation metrics: The LLM-as-a-Judge pipeline resentative SE tasks:
software development and vulnerability proposed in \[19\] is employed to
categorize multi-agent LLMs detection, each evaluated using two
comprehensive datasets. failures, assigning each instance to one or more
categories: Function-level development: In function-level develop-
specification issues, inter-agent misalignment, and task verifi- ment,
agents solve problems from the HumanEval \[21\], each cation failures,
using a separate model, gpt-4o-2024-08-06. requiring the writing of a
concise function that satisfies a given To evaluate RQ1, total number of
failures in each category textual specification. across different SE
tasks, including both development and vulnerability detection, is
compared. To evaluate RQ2, change effectiveness in clarifying ambiguous
task specifications. Also, in failure counts change across collaboration
rounds in devel- similar results can be observed in inter-agent
misalignment opment tasks, is compared between SEMAP and baseline. (Fig.
2e) and task verification (Fig. 2f). Compared to the baseline, SEMAP not
only reduces fail- B. Experiment Results ure counts more effectively,
but also exhibits a more stable Results for RQ1: The total number of
failures in each of downward trend across rounds, whereas baseline
failures often the three major categories are reported in Table I
(develop- reappear after temporary drops. The underlying mechanisms ment
tasks) and Table II (vulnerability detection), respectively.
contributing to this stability are further discussed later. Across all
datasets and model configurations, SEMAP consis- Thus, RQ2 is answered:
SEMAP promotes more reliable and tently reduces the number of failures
compared to the baseline. consistent behavior across collaboration
rounds, reducing the In function-level development (HumanEval), SEMAP
re- recurrence of specification, coordination, and verification fail-
duces the total number of failures by 64.1% with ChatGPT ures in both
function-level and deployment-level development. (from 256 to 92) and by
69.6% with DeepSeek (from 112 to V. C ONCLUSION AND F UTURE W ORKS 34).
The largest reduction occurs in under-specification, where ChatGPT drops
from 137 to 39 (71.5%), and DeepSeek from This paper presents SEMAP, a
protocol-layer methodology 63 to 17 (73.0%). Similarly, in
deployment-level development for addressing common failures in
multi-agent LLMs, includ- (ProgramDev), SEMAP achieves a 12.6% reduction
with Chat- ing under-specification, coordination misalignment, and in-
GPT (from 103 to 90) and a 56.7% reduction with DeepSeek adequate
verification. SEMAP instantiates three SE-informed (from 67 to 29), with
the most notable improvement in under- principles, behavioral contracts,
structured messaging, and specification for DeepSeek (39 to 18, a 53.8%
decrease) and lifecycle-guided execution with verification, supporting
both a complete elimination of inter-agent misalignment errors.
centralized and decentralized workflows. Empirical results In
vulnerability detection, SEMAP also shows consistent across diverse SE
tasks demonstrate that SEMAP substantially advantages over the baseline.
On devign100, total failures improves system robustness. In
function-level and deployment- decrease by 28.2% with ChatGPT (from 78
to 56) and by level code development, it achieves up to 69.6% and 56.7%
8.3% with DeepSeek (from 48 to 44). On vudenc100, the reductions in
total failures, with the greatest gains observed reduction is 47.4% with
ChatGPT (from 38 to 20) and 16.4% in mitigating under-specification and
coordination issues. In with DeepSeek (from 55 to 46). Unlike
development tasks, the vulnerability detection, SEMAP consistently
reduces failure reductions here are more evenly distributed across the
three rates across Python and C/C++ tasks up to 47.4%, while failure
categories, indicating SEMAP's balanced impact on promoting better agent
alignment in decentralized workflows. decentralized workflows involving
parallel agent collaboration. To strengthen validity, future experiments
will be scaled Thus, RQ1 is answered: SEMAP consistently reduces failure
to larger datasets, agent populations, and longer workflows, counts
across all categories and tasks, with the most significant and compared
against more baselines, including single-agent improvements observed in
under-specification during develop- LLMs and domain-specific detectors.
Ablation studies will iso- ment, and more balanced reductions in
vulnerability detection. late the impact of contracts, messaging, and
lifecycle control. Results for RQ2. Figure 2 illustrates how failure
counts Future work also includes measuring resource overhead, en- evolve
across development rounds, separated by different abling cross-agent
tool use, adding formal protocol correctness datasets and failure
categories. Unlike RQ1, which evaluates verification, and releasing
artifacts for reproducibility. end-to-end failure counts, RQ2 focuses on
its changes during R EFERENCES the iterative process, examining whether
SEMAP promotes \[1\] SlashData, "Global developer population trends
2025: How more stable and robust collaboration over repeated trials.
many developers are there?" 2025, accessed: 2025- In the HumanEval
dataset, SEMAP results in fewer failures 05-15. \[Online\]. Available:
https://www.slashdata.co/post/ across all development rounds compared to
the baseline.
global-developer-population-trends-2025-how-many-developers-are-there
\[2\] J. Cai et al., "Exploring the improvement of evolutionary
computation As shown in Fig. 2a, SEMAP leads to a sharp and steady via
large language models," in Proceedings of the Genetic and Evolu-
reduction in under-specification failures, dropping from 20 to 2 tionary
Computation Conference Companion, 2024, pp. 83--84. for ChatGPT-SEMAP
and from 14 to 0 for DeepSeek-SEMAP \[3\] J. Fan et al., "Coding latent
concepts: a human and llm-coordinated content analysis procedure,"
Communication Research Reports, vol. 41, by round 5. However, the
baseline declines more gradually, no. 5, pp. 324--334, 2024. with
ChatGPT-Baseline ending at 9 failures and DeepSeek- \[4\] J. Li et al.,
"Generative ai for self-adaptive systems: State of the art and Baseline
at 2. Similar patterns also can be found in inter-agent research
roadmap," ACM Transactions on Autonomous and Adaptive Systems, vol. 19,
no. 3, pp. 1--60, 2024. misalignment (Fig. 2b) and task verification
(Fig. 2c). \[5\] Y. Sun et al., "Semirald: A semi-supervised hybrid
language model In the ProgramDev dataset, SEMAP continues to demon- for
robust anomalous log detection," Information and Software strate
improved round-wise behavior compared to the baseline. Technology,
vol. 183, p. 107743, 2025. \[Online\]. Available: https:
//www.sciencedirect.com/science/article/pii/S0950584925000825 As shown
in Fig. 2d, SEMAP significantly reduces under- \[6\] Z. Yang et al.,
"Exploring and unleashing the power of large language specification
failures across rounds, with DeepSeek-SEMAP models in automated code
translation," Proc. ACM Softw. Eng., vol. 1, dropping from 14 to 0 and
ChatGPT-SEMAP from 16 to no. FSE, Jul. 2024. \[Online\]. Available:
https://doi.org/10.1145/3660778 \[7\] Z. Mao et al., "Hybrid privacy
policy-code consistency check 3 by round 5. In contrast, the baseline
systems converge using knowledge graphs and llms," 2025. \[Online\].
Available: more slowly and finish at 3 failures each, indicating limited
https://arxiv.org/abs/2505.11502  TABLE I: Results of RQ1: Development
Tasks HumanEval ProgramDev Failure Category GPT-4.1-nano Deepseek-V3
GPT-4.1-nano Deepseek-V3 Baseline SEMAP ∆% Baseline SEMAP ∆% Baseline
SEMAP ∆% Baseline SEMAP ∆% Under-specification 137 39 71.5 63 17 73.0 48
46 4.1 39 18 53.8 Inter-Agent Misalignment 27 5 81.5 10 3 70.0 9 9 0.0 8
0 100.0 Task Verification 92 48 47.8 39 14 64.1 46 35 23.9 20 11 45.0
Total 256 92 64.1 112 34 69.6 103 90 12.6 67 29 56.7

                                         TABLE II: Results of RQ1: Vulnerability Detection Tasks
                                                 devign100 (C/C++)                                             vudenc100 (Python)
      Failure Category                GPT-4.1-nano               Deepseek-V3                        GPT-4.1-nano                Deepseek-V3
                               Baseline   SEMAP     ∆% Baseline      SEMAP           ∆%      Baseline   SEMAP     ∆%     Baseline   SEMAP             ∆%
      Under-specification        12           9     25.0       5        4            20.0       4          3      25.0      16        15               6.3

Inter-Agent Misalignment 33 24 27.2 20 18 10.0 14 11 21.3 16 11 31.3
Task Verification 33 23 30.3 23 20 13.0 10 6 40.0 23 20 13.0 Total 78 56
28.2 48 44 8.3 38 20 47.4 55 46 16.4

      (a) HumanEval: Under-Specification              (b) HumanEval: Inter-Agent Misalignment                 (c) HumanEval: Task Verification




      (d) ProgramDev: Under-Specification            (e) ProgramDev: Inter-Agent Misalignment                (f) ProgramDev: Task Verification
                                   Fig. 2: Results of RQ2: Failures v.s. Rounds in Development Tasks

\[8\] J. He et al., "Llm-based multi-agent systems for software
engineering: language models with the interactive chain of repair,"
arXiv preprint Literature review, vision and the road ahead," ACM
Transactions on arXiv:2311.09868, 2023. Software Engineering and
Methodology, 2024. \[16\] W. Tao et al., "Magis: Llm-based multi-agent
framework for github issue \[9\] D. Jin et al., "Mare: Multi-agents
collaboration framework for require- resolution," 2024. \[Online\].
Available: https://arxiv.org/abs/2403.17927 ments engineering," arXiv
preprint arXiv:2405.03256, 2024. \[17\] D. Cohen et al., "An
introduction to agile methods," Advances in \[10\] M. Ataei et al.,
"Elicitron: An llm agent-based simulation framework computers, vol. 62,
no. 03, pp. 1--66, 2004. for design requirements elicitation," 2024.
\[Online\]. Available: \[18\] K. Petersen et al., "The waterfall model
in large-scale development," https://arxiv.org/abs/2404.16045 in
International Conference on Product-Focused Software Process Im- \[11\]
H. Zhang et al., "A pair programming framework for code generation via
provement. Springer, 2009, pp. 386--400. multi-plan exploration and
feedback-driven refinement," in Proceedings \[19\] M. Cemri et al., "Why
do multi-agent llm systems fail?" arXiv preprint of the 39th IEEE/ACM
International Conference on Automated Software arXiv:2503.13657, 2025.
Engineering, 2024, pp. 1319--1331. \[20\] Y. Yang et al., "A survey of
ai agent protocols," arXiv preprint \[12\] D. Zan et al., "Codes:
Natural language to code repository via arXiv:2504.16736, 2025.
multi-layer sketch," 2024. \[Online\]. Available: https://arxiv.org/abs/
\[21\] M. Chen et al., "Evaluating large language models trained on
code," 2403.16443 arXiv preprint arXiv:2107.03374, 2021. \[22\] Y. Zhou
et al., "Devign: Effective vulnerability identification by learn- \[13\]
Z. Mao et al., "Multi-role consensus through llms discussions for ing
comprehensive program semantics via graph neural networks," in
vulnerability detection," in 2024 IEEE 24th International Conference on
Advances in Neural Information Processing Systems (NeurIPS), vol. 32,
Software Quality, Reliability, and Security Companion (QRS-C). IEEE,
2019, pp. 10 197--10 207. 2024, pp. 1318--1319. \[23\] H.-C. Tran et
al., "Detectvul: A statement-level code vulnerability \[14\] S. Hu et
al., "Large language model-powered smart contract detection for python,"
Future Generation Computer Systems, p. vulnerability detection: New
perspectives," 2023. \[Online\]. Available: 107504, 2024. \[Online\].
Available: https://www.sciencedirect.com/
https://arxiv.org/abs/2310.01152 science/article/pii/S0167739X24004680
\[15\] H. Wang et al., "Intervenor: Prompting the coding ability of
large 
