                                        Traceability and Accountability in Role-Specialized
                                                    Multi-Agent LLM Pipelines
                                                                                                    Amine Barrak
                                                                                Department of Computer Science and Engineering
                                                                                    Oakland University, Rochester, MI, USA
                                                                                           aminebarrak@oakland.edu


                                           Abstract—Sequential multi-agent systems built with large lan-                          Large Language Models Agents Pool
                                        guage models (LLMs) can automate complex software tasks,
                                        but they are hard to trust because errors quietly pass from                                                   …
                                        one stage to the next. We study a traceable and accountable                               LLM-A       LLM-B             LLM-Y    LLM-Z

arXiv:2510.07614v1 \[cs.AI\] 8 Oct 2025

                                        pipeline, meaning a system with clear roles, structured handoffs,
                                        and saved records that let us trace who did what at each                                                                                   This is wrong !
                                                                                                                                                                                   Who is responsible
                                        step and assign blame when things go wrong. Our setting is                                                                                 for this error ?!
                                        a Planner → Executor → Critic pipeline. We evaluate eight                                               Role Assignment
                                        configurations of three state-of-the-art LLMs on three bench-                                     (Planner, Developer, Tester, …)
                                        marks and analyze where errors start, how they spread, and                                 Planner            Executor          Critic
                                                                                                                  User Prompt /
                                        how they can be fixed. Our results show: (1) adding a structured,           Task Spec

                                        accountable handoff between agents markedly improves accuracy                                                                                      Final
                                                                                                                                                                                          Answer
                                                                                                                                    LLM-A               LLM-B           LLM-Y
                                        and prevents the failures common in simple pipelines; (2) models
                                        have clear role-specific strengths and risks (e.g., steady planning                        Solution
                                                                                                                                    Outline
                                                                                                                                                        Worked
                                                                                                                                                       Solution
                                                                                                                                                                        Critique
                                                                                                                                                                         & Fixes
                                        vs. high-variance critiquing), which we quantify with repair
                                        and harm rates; and (3) accuracy–cost–latency trade-offs are          Fig. 1: A sequential multi-agent pipeline. A failure in the final
                                        task-dependent, with heterogeneous pipelines often the most           output makes debugging and assigning responsibility a critical
                                        efficient. Overall, we provide a practical, data-driven method
                                        for designing, tracing, and debugging reliable, predictable, and      challenge.
                                        accountable multi-agent systems.
                                           Index Terms—Multi-agent LLMs, Sequential pipelines, Role           developers already spending over 50% of their time on debug-
                                        Based Reasoning, Agents Collaboration, Traceable Pipeline.            ging traditional software, the introduction of these complex,
                                                                                                              non-deterministic agentic systems threatens to exacerbate this
                                                               I. I NTRODUCTION                               challenge significantly [6]. Debugging a sequential pipeline of
                                           The field of software engineering is undergoing a signif-          agents is therefore a crucial, yet largely unsolved, problem
                                        icant transformation, driven by the rise of Large Language            standing in the way of their reliable deployment [7, 8].
                                        Models (LLMs). This evolution is progressing from LLM-                   While the potential of multi-agent systems is well-
                                        powered “co-pilots” that assist developers to fully autonomous,       documented, the engineering principles required to make them
                                        multi-agent systems capable of tackling complex software              trustworthy and maintainable are still nascent [9]. Much of the
                                        development tasks with minimal human intervention [1, 2].             existing research on systems like ChatDev [4], MetaGPT [5],
                                        A common architectural pattern is the sequential multi-agent          and other debugging agents [6] focuses on demonstrating the
                                        pipeline, where specialized LLM-based agents collaborate in           capabilities of agent collaboration. While these studies are
                                        a predefined order to perform roles such as planning, devel-          foundational, they often treat the pipeline as a black box,
                                        opment, and testing [3]. Systems like ChatDev and MetaGPT             evaluating only the final output. Consequently, they do not
                                        have demonstrated the potential of this approach, where task          provide a systematic analysis of the internal system dynamics
                                        decomposition allows multiple agents to synergistically solve         or the root causes of failure. This is a critical omission, as
                                        problems that would be intractable for a single monolithic            recent work has shown that multi-agent systems can unex-
                                        model [4, 5].                                                         pectedly underperform strong, yet simpler, single-agent base-
                                           However, this shift to sequential agent pipelines intro-           lines due to coordination overhead and these very cascading
                                        duces a critical software engineering challenge: the loss of          errors [10]. The software engineering community has long
                                        transparency and the immense difficulty of debugging. When            recognized traceability as a cornerstone of building robust
                                        agents are chained together, an error introduced by an early          systems [11], yet this principle has not been systematically
                                        agent can silently cascade, corrupting the entire workflow and        applied to the internal workings of agentic pipelines. This
                                        leading to a final output that is incorrect for reasons that are      gap has recently been framed as the challenge of “automated
                                        difficult to diagnose [3]. As illustrated in Figure 1, this turns     failure attribution”—identifying which agent is responsible for
                                        the collaborative pipeline into a new kind of opaque system           a failure—a task that is critical for debugging but remains a
                                        where failures are observable, but their origins are not. With        labor-intensive and underexplored problem [12, 13].

To address this gap, this paper presents an in-depth empir- The choice
of LLM for each specialized agent is a critical ical study of an
accountable sequential pipeline of LLM- design decision with economic
and performance implications. based agents. Rather than proposing a new
framework, our Stronger models deliver higher accuracy and reasoning but
contribution is a rigorous analysis of the internal dynamics of incur
greater cost and latency, while lighter models are faster such a
pipeline. We employ a blame attribution methodology and cheaper but less
effective for planning or critical analysis to monitor the correctness
of a solution as it passes through a \[16\]. This trade-off compels
careful role allocation to balance Planner → Executor → Critic sequence.
This allows cost, speed, and quality \[3\]. To automate this process,
routing us to quantify novel, role-specific behaviors such as repair
frameworks have emerged; for example, CARGO introduces (when an agent
corrects an error from a preceding stage) and a confidence-aware system
that dynamically assigns prompts harm (when an agent introduces an error
to a previously to the most suitable model, managing the
performance--cost correct state). Through a large-scale study involving
three trade-off without manual intervention \[17\]. state-of-the-art
LLMs in eight distinct pipeline configurations However, these frameworks
often model entire organizations across three diverse benchmarks, we
systematically investigate with complex interaction patterns. In our
study, we abstract the following research questions: away from specific
organizational structures to investigate the • RQ1: How do sequential
multi-agent pipelines compare fundamental effectiveness of a pipelined
LLM workflow. We to the performance of monolithic LLMs? propose to
isolate and analyze a core, generalizable process • RQ2: How do
individual LLMs perform in specialized by splitting a task into three
distinct stages---Plan, Execution, roles, and what are the dynamics of
error propagation and and Critic. To formally study the impact of this
role-based correction within the pipeline? decomposition, we evaluate
its accuracy, cost, and latency • RQ3: What are the trade-offs between
accuracy, cost, across a range of complex tasks foundational to modern
and latency when designing accountable sequential agent software
engineering. pipelines? B. Traceability and Correction in Agentic
Pipelines We release the dataset used in this study.1 Beyond end-to-end
simulation, a parallel stream of research II. R ELATED W ORK has focused
on the feedback mechanisms within agentic work- Our work sits at the
intersection of multi-agent LLM sys- flows. The Self-Refine \[18\]
framework established that an tems for software development and
verifiable feedback loops LLM can iteratively improve its own output by
generating for agentic workflows, addressing a key gap: the lack of a
self-feedback and then acting upon it. This principle has been formal,
traceable, and debuggable pipeline design. adapted for coding in systems
like Self-Debug \[19\], where an agent is prompted to first analyze and
explain a bug before A. Multi-Agent Collaboration in Autonomous Software
Engi- attempting a fix. The role of a critic is further exemplified in
neering automated code review agents \[20\] and in workflows inspired
The inherent limitations of single, monolithic LLMs in by Test-Driven
Development. handling complex, multi-step tasks are well-established. A
While these approaches validate the concept of a critique- prominent
issue is the "lost in the middle" problem, where and-refine loop, a
simple pipeline is not sufficient for building models exhibit degraded
performance in utilizing information robust and reliable systems. A
primary challenge in current positioned in the center of long context
windows \[14\]. This agentic systems is the lack of observability and
traceability has catalyzed a shift towards multi-agent systems, where a
\[3, 7\]. When a pipeline produces a final, incorrect answer, it complex
problem is decomposed and delegated to a society of is often difficult
to perform root cause analysis and identify specialized, collaborative
agents. which stage or agent introduced the error. This "black box"
Within software engineering, this paradigm has been suc- nature hinders
debugging and iterative improvement. Further- cessfully instantiated by
frameworks that simulate entire devel- more, recent work on iterative
refinement for ML pipelines opment organizations. For instance, ChatDev
\[4\] constructs a has shown that modifying and evaluating one component
at a virtual software company where LLM agents embody roles time leads
to more stable and interpretable improvements \[21\]. like CEO,
programmer, and tester, following a structured This highlights the need
for modularity, where a specific LLM waterfall process to develop
software. Similarly, MetaGPT in the pipeline can be evaluated and
replaced if it proves to be \[5\] employs agents as product managers and
architects, man- a weak link. The concept of using multiple, diverse
verifiers dating the generation of standardized artifacts like
requirement to evaluate an output also suggests that a robust critique
stage documents and system designs before implementation begins. is
multi-faceted and crucial for reliability \[22\]. This structured
approach is facilitated by general-purpose Our work directly addresses
this gap. We contend that a frameworks like AutoGen \[15\], which
provides a toolkit for pipeline must be designed for traceability to
track the evolution orchestrating these complex multi-agent
conversations. These of decisions and artifacts at each stage. This not
only facilitates systems convincingly demonstrate the feasibility of
role-based debugging and the modular replacement of underperforming
decomposition for complex software generation. agents but also enables
early-stage error correction. By evalu- ating the output of each stage,
our pipeline allows a subsequent 1
https://sites.google.com/view/mas-gain2025/home agent to identify and
rectify issues before they propagate.

                                                                   2

III. D ESIGN S TUDY D. Evaluation Metrics To evaluate the effectiveness
of the traceable multi-agent To conduct a comprehensive evaluation of
both monolithic pipeline, we conducted a controlled study across
multiple models and the sequential agent pipelines, we compute a
datasets, model configurations, and prompt conditions. This set of
quantitative metrics designed to capture effectiveness, section outlines
the design choices and experimental setup. efficiency, and operational
cost. A. Prompts Datasets Collection Token statistics We collect
detailed token usage for each model interaction, including the number of
input (prompt) We curated multiple-choice datasets, retaining only
prompts tokens and output (completion) tokens. This data is essential
with valid ground-truth answers to ensure consistent evaluation for
analyzing the complexity of the tasks given to each agent of accuracy
across role configurations and blame attribu- and serves as the basis
for cost computation. We report the tions. All prompts were aligned to
the standard answer space median to provide a robust measure of token
consumption. ({A, B, C, D, E}). Accuracy This is the primary metric for
evaluating the cor- We evaluate on three complementary benchmarks:
rectness of the final output. For each task, the generated • PythonIO
(127 prompts): programming and algorithmic answer is compared against a
ground-truth solution. Accuracy reasoning problems expressed in natural
language, stress- is calculated as the percentage of tasks for which the
model ing systematic reasoning and code-like logic \[23\]. or pipeline
produced the correct final answer. • LogiQA (283 prompts): formal logic
and deductive rea- Cost Computation To assess the operational expense of
each soning tasks; originally released by Liu et al. (2020) and
approach, we compute the monetary cost. Let Rin (m) and publicly
available via GitHub \[24\]. Rout (m) be the provider's prices (USD) per
1,000 tokens • AGIEval (263 prompts): standardized test--style ques- for
input and output respectively for model m. For a dataset tions (math,
reading, commonsense); derived from public D, with total prompt tokens
Tin (m, D) and total completion exam data (e.g. Gaokao, SAT) and
repurposed in AGIEval tokens Tout (m, D) produced by model m, the exact
total cost benchmark \[25\]. we report is: B. Model Selection Rationale
When per-call cost is needed, it is computed itemwise as prompti
completioni For this study, we selected three frontier LLMs that held
top 1000 Rin (m) + 1000 Rout (m) and summarized by the positions on
public leaderboards during our evaluation period: median across items.
For the sequential multi-agent pipeline, • GPT-4o (A). Reported at the
top of the Chatbot Arena the total cost for a single task is the sum of
the costs incurred (LMSYS) overall leaderboard in mid--2024 \[26\].
Noted by each agent: for stable, low-variance responses and strong
text+code Pipeline Cost = Costplanner + Costexecutor + Costcritic
reasoning. • Claude 3.5 Sonnet (B). Public reports placed it at the All
reported monetary totals were computed with the fixed top of key LMSYS
Chatbot Arena categories shortly after per-token rates detailed in Table
I. release (June 2024) \[27\]. Noted for strict instruction- TABLE I:
Pricing comparison of major LLMs with input and following and effective
multi-step revision/correction. output costs per 1K tokens. • Gemini 2.5
Pro (C). Covered as leading the LMArena (human-preference) leaderboard
in early 2025 \[28\]. Noted Input Output Model Source for efficient
high-capability reasoning and coding with (USD / 1K tokens) (USD / 1K
tokens) reliable schema compliance in MCQ settings. GPT-4o (A) \$0.0050
\$0.0200 \[29\] C. Experimental Conditions Claude Sonnet 4 (B) \$0.0030
\$0.0150 \[30\] Gemini 2.5 Pro (C) \$0.00125 \$0.0100 \[31\] We compare
three inference regimes: (1) Single-model baselines. Each model answers
end-to-end with the prompt above. These runs establish individual capa-
Latency statistics To measure the efficiency and responsive- bility and
serve as reference points. ness of each configuration, we record the
end-to-end latency for each task in seconds. This includes the time
taken for all (2) Pipelines without traceability. We compose three-step
API calls and intermediate processing within the pipeline. We pipelines
(length 3) using ordered model triples from report the median latency to
provide a stable measure of the {A, B, C}, e.g., AAA, BBB, CCC, ABC,
ACB, . . .. Each system's response time. step consumes the previous
step's artifact (question and current answer) and emits a new one-letter
answer. We score only the E. Blame Assignment in Multi-Agent Pipelines
final output. We use a three--role pipeline: a Planner proposes an (3)
Pipelines with traceability (blame tracking). We instru- initial answer,
an Executor solves the task conditioned on ment the same configurations
to capture stagewise inputs/out- the planner's output, and a Critic
reviews or revises the puts and deltas against gold labels. For each
item we com- executor's answer. The pipeline publishes a single final
answer pute whether the intermediate step repaired a wrong answer, by
preferring later stages (critic → executor → planner). harmed a correct
answer, or performed a no-op. To analyze accountability, we define a
blame function that

                                                                   3

compares each stage's answer to the ground truth and sets A. RQ1: How do
sequential multi-agent pipelines compare to binary flags indicating
whether a downstream stage repaired the performance of monolithic LLMs?
a wrong upstream answer or harmed a correct one; the error origin is the
earliest stage whose mistake remains unrepaired To justify the use of
multi-agent systems, we first estab- in the final output (NONE if the
final answer is correct). The lish a performance baseline by evaluating
each LLM as a operational logic is summarized below. monolithic,
end-to-end problem solver. We then compare these results against two
types of sequential pipelines---a simple, unmonitored pipeline and an
accountable pipeline with a Algorithm 1 Traceable Pipeline (Roles and
Blame Logic) structured handoff protocol---to determine the impact of
both Require: Dataset D = {(xi , yi )}N i=1 ; models MP (Planner),
collaboration and accountability. ME (Executor), MC (Critic) Ensure: For
each i: stage answers (P, E, C), final F , blame 1) Baseline Performance
of Monolithic Models flags, error origin 1: for i ← 1 to N do We began
by assessing the individual capabilities of our three 2: P ← MP (xi )
selected LLMs---Gemini 2.5 Pro (Model C), Claude Sonnet 4 3: E ← ME (xi
, P ) (Model B), and GPT-4o (Model A)---on each benchmark. The 4: C ← MC
(xi , P, E) results, shown in Table II, summarizes the accuracy, median
5: Final selection: latency, and median cost per prompt for each model.
6: if C is defined then 7: F ←C TABLE II: Baseline Performance of Single
Models Across All 8: else if E is defined then Datasets 9: F ←E Median
Median 10: else Dataset Model Accuracy (%) Latency (s) Cost/Prompt (USD)
11: F ←P AgiEval Gemini 2.5 Pro (C) 92.40 11.84 \$0.0112 12: end if
Claude Sonnet 4 (B) 58.20 4.21 \$0.0036 13: Blame flags: GPT-4o (A)
43.70 0.74 \$0.0006 14: planner_error\[i\] ← (P ̸= yi ) PythonIO Gemini
2.5 Pro (C) 99.21 11.20 \$0.0120 15: executor_repair\[i\] ← (P ̸= yi ) ∧
(E = yi ) Claude Sonnet 4 (B) 53.54 5.48 \$0.0054 16: executor_harm\[i\]
← (P = yi ) ∧ (E ̸= yi ) GPT-4o (A) 69.29 0.71 \$0.0009 17:
critic_repair\[i\] ← (E ̸= yi ) ∧ (C = yi ) LogiQA Gemini 2.5 Pro (C)
84.45 14.78 \$0.0134 18: critic_harm\[i\] ← (E = yi ) ∧ (C ̸= yi )
Claude Sonnet 4 (B) 79.51 6.74 \$0.0051 19: Error origin: GPT-4o (A)
67.49 0.77 \$0.0009 20: if F = yi then 21: origin\[i\] ← NONE 22: else
The results in Table II establish a clear performance hierar- 23: if (E
= yi ) ∧ (C ̸= yi ) then chy, with Gemini 2.5 Pro representing the
best-case scenario 24: origin\[i\] ← CRITIC for a single-model,
monolithic approach. While its accuracy 25: else if (P = yi ) ∧ (E ̸= yi
) then is formidable, the increasing complexity of agentic AI tasks is
26: origin\[i\] ← EXECUTOR beginning to challenge the limits of
single-agent systems, par- 27: else ticularly for long-horizon problems
that require intricate plan- 28: origin\[i\] ← PLANNER ning and
reasoning \[32, 33\]. Fields such as autonomous soft- 29: end if ware
development and multi-step scientific discovery present 30: end if
significant hurdles for monolithic models \[1\]. For such intri- 31:
Record (P, E, C, F, flags, origin\[i\]) cate problems, a monolithic
model faces significant hurdles: 32: end for it can struggle to maintain
context across numerous steps, its reasoning process for intermediate
sub-problems remains opaque, and a single early error can irrevocably
corrupt the IV. R ESULTS entire solution without any mechanism for
verification or recovery. This paradigm of growing task complexity
motivates our investigation into a decomposed, multi-agent pipeline. The
This section presents the empirical findings from our eval- central
hypothesis is not to compete with the raw accuracy uation of monolithic
and sequential multi-agent pipeline con- of the best single model on
constrained benchmarks, but to figurations across three distinct
benchmarks: AgiEval (general propose a modular and verifiable
architecture suited for reasoning), PythonIO (code generation), and
LogiQA (logical complex, multi-step processes. By assigning specialized
roles reasoning). The results are organized to systematically address
(e.g., planning, execution, critique) to different agents, we can our
three primary research questions. construct systems designed for this
purpose.

                                                                  4

2) Impact of Accountable Protocol on Pipeline Performance and BCC
configurations saw minor decreases of 2.28 and 0.76 points,
respectively. Having established the monolithic baselines, we next
investi- On the PythonIO benchmark, the accuracy gains were gated the
impact of the pipeline structure. We compared two even more substantial
for several configurations. The BBB architectures: a Simple Pipeline,
where the output of one configuration's accuracy increased by 36.22
percentage points, agent is passed to the next, and an Accountable
Pipeline, from 61.42% to 97.64%. Similarly large gains were recorded
which implements a structured handoff protocol with blame for BAB
(+33.07 points), CBA (+27.56 points), and CCA attribution. This protocol
ensures that each agent's output is (+26.78 points). The top-performing
configurations, ABC and validated and passed in a consistent format,
giving subsequent CCC, showed no change, as both the simple and
accountable agents a clear state to evaluate and act upon. versions
achieved 99.21% accuracy. Only one configuration, Table III presents a
direct comparison of the final accuracy BCC, showed a small decrease of
0.78 points. of these two pipeline types across all configurations. For
the LogiQA benchmark, the changes were generally positive but more
modest. The largest improvement was seen TABLE III: Comparative Accuracy
of Simple vs. Accountable in the CCA configuration, which increased by
6.99 percentage Pipelines Across Datasets (%) --- rows by configuration.
points. Other configurations like CCC and CBA saw smaller Dataset Config
Simple Pipeline Accountable Pipeline Accuracy ∆ gains of 3.82 and 2.41
points, respectively. The AAA and BBB configurations showed negligible
negative changes of - AgiEval 0.10 and -0.07 points. AAA 57.41 77.19
+19.78 ABC 81.37 90.87 +9.50 Monolithic (Gemini) AAA (Accountable) BAB
88.97 86.69 −2.28 AAA (Simple) Strong Accountable (best of CCC/CBA) BBB
88.97 89.73 +0.76 100 BCC 91.25 90.49 −0.76 80 CBA 87.07 92.40 +5.33
Accuracy (%) CCA 91.25 92.40 +1.15 60 CCC 91.63 93.54 +1.91 40 PythonIO
20 AAA 73.23 88.98 +15.75 0 AgiEval PythonIO LogiQA ABC 99.21 99.21 0.00
BAB 63.78 96.85 +33.07 Fig. 2: Impact of pipeline architecture on
accuracy. BBB 61.42 97.64 +36.22 BCC 99.21 98.43 −0.78 Figure 2 provides
a visual summary of these key perfor- CBA 71.65 99.21 +27.56 mance
trade-offs, comparing the monolithic baseline against CCA 71.65 98.43
+26.78 the weakest and strongest pipeline configurations. The chart CCC
99.21 99.21 0.00 clearly illustrates three core findings across the
datasets. LogiQA First, the AAA (Simple) pipeline consistently
underperforms, demonstrating the significant risk of "anti-synergy"
where AAA 71.48 71.38 −0.10 unstructured collaboration is actively
harmful. Second, the ABC 79.58 80.57 +0.99 AAA (Accountable) pipeline
shows a dramatic performance BAB 78.52 79.86 +1.34 improvement over its
simple counterpart on AgiEval and BBB 79.58 79.51 −0.07 PythonIO,
highlighting the effectiveness of the accountable BCC 82.75 83.39 +0.64
protocol in raising the performance floor. Finally, the Strong CBA 81.34
83.75 +2.41 Accountable pipeline (representing the best of the CCC and
CCA 78.52 82.28 +3.76 CBA configurations) consistently performs at or
near the level CCC 81.34 85.16 +3.82 of the best monolithic model, and
in the case of LogiQA, slightly surpasses it. The data in Table III
shows that the introduction of the accountable protocol leads to notable
changes in pipeline Findings for RQ1 accuracy, with the magnitude and
direction of the change varying by configuration and dataset.
Unstructured pipelines degrade performance. Without On the AgiEval
benchmark, the largest accuracy increase clear roles and checks, errors
compound across stages and was observed in the AAA configuration, which
rose by 19.78 accuracy falls below a competent single model. percentage
points from 57.41% to 77.19%. The ABC config- Accountability lifts the
floor and ceiling. A struc- uration also saw a significant gain of 9.50
points. Most other tured, accountable handoff reliably improves accuracy
and configurations showed smaller positive changes, such as CCC
stability, with strong accountable pipelines matching or (+1.91 points)
and CBA (+5.33 points). Conversely, the BAB surpassing weaker monolithic
baselines.

                                                                            5

B. RQ2: How do individual LLMs perform in specialized methodology allows
us to measure two key behaviors: the roles, and what are the dynamics of
error propagation and repair rate (the frequency with which an agent
corrects an error correction within the pipeline? from the preceding
stage) and the harm rate (the frequency To address RQ2, we analyzed the
internal dynamics of error with which an agent incorrectly modifies a
correct output from origination and correction. the preceding stage).
Table V summarizes these behavioral metrics, aggregated across all
experiments. 1) Error Origination: The Primacy of the Planner TABLE V:
Role-Specific Repair and Harm Rates by Model (Aggregated). Our analysis
reveals that the vast majority of unrecoverable pipeline failures
originate from a flawed plan created in the Repair Rate Harm Rate very
first step. To quantify this, we measured the error rate for Model Role
(%) (%) each model when it was assigned the Planner role. The "Total
Cases" in Table IV represents the total number of times each Executor
1.27 0.25 Gemini 2.5 Pro (C) model acted as the Planner across all
relevant configurations Critic 2.66 0.25 for a given dataset. For
example, since GPT-4o (Model A) was the Planner in two configurations
(AAA and ABC), its total Executor 10.01 0.25 Claude Sonnet 4 (B) cases
for the AgiEval benchmark (which has 263 instances) is Critic 3.04 1.90
2 \* 263 = 526. Executor 2.28 1.33 TABLE IV: Planner Error Rate by Model
and Dataset. GPT-4o (A) Critic 5.20 0.89 Errors Error Rate Planner Model
Dataset Total Cases Introduced (%) The data in Table V reveals distinct
behavioral profiles for AgiEval 789 58 7.35 each model in the mid-stream
roles. Gemini 2.5 Pro (C) PythonIO 381 3 0.79 Gemini 2.5 Pro (Model C)
exhibited the lowest harm rates LogiQA 849 129 15.19 across both roles,
at just 0.25%. Its repair rates were also the lowest for an Executor
(1.27%) and modest for a Critic AgiEval 789 106 13.43 (2.66%). Claude
Sonnet 4 (B) PythonIO 381 15 3.94 Claude Sonnet 4 (Model B) was the most
effective Executor, LogiQA 849 187 22.03 achieving a repair rate of
10.01%, which was significantly AgiEval 526 213 40.49 higher than any
other model in that role. It maintained a low GPT-4o (A) PythonIO 254 28
11.02 harm rate of 0.25% as an Executor. In the Critic role, its repair
LogiQA 566 162 28.62 rate was 3.04%, while its harm rate was the highest
recorded for that role at 1.90%. GPT-4o (Model A) showed the highest
repair rate in the The results in Table 3 show a clear and consistent
perfor- Critic role, at 5.20%. As an Executor, its repair rate was
2.28%, mance hierarchy among the models in the Planner role: Gemini but
it had the highest harm rate in that role at 1.33%. is the most
reliable, followed by Claude, with GPT-4o being the least reliable. This
trend holds across all three datasets. Findings for RQ2 The error rates
are also highly task-dependent. On the structured PythonIO coding task,
all models performed ex- Planner primacy. The Planner has the highest
leverage; ceptionally well as planners. Gemini's error rate was less
than its error rate is the strongest predictor of pipeline failure. 1%,
and even the weakest planner, GPT-4o, only introduced an Role-specific
aptitudes. Models show distinct strengths. error in 11.02% of cases.
This suggests that for well-defined Gemini is a reliable generator but
weak corrector; Claude tasks like code generation, the planning stage is
less prone to is an excellent Executor; GPT-4o is a high-variance, high-
failure. reward Critic. In contrast, performance degraded significantly
on the more Data-driven casting. Cast roles by strengths, Gemini
abstract reasoning tasks. On LogiQA, all models struggled (Planner) →
Claude (Executor) → GPT-4o (Critic). more, with Claude's error rate
climbing to 22.03% and GPT- 4o's to 28.62%. The most challenging
benchmark for planners C. RQ3: What are the trade-offs between accuracy,
cost, was AgiEval, where GPT-4o's error rate reached a substantial and
latency when designing accountable sequential agent 40.49%. pipelines?
While maximizing accuracy is a primary goal, real-world 2) Mid-stream
Dynamics: Quantifying Repair and Harm deployments are constrained by
operational budgets and re- sponse time requirements. Figure 3
visualizes the multi- While the Planner sets the stage, the Executor and
Critic dimensional trade-off space for our accountable pipeline con-
roles determine the pipeline's resilience. Our blame attribution
figurations across the three benchmarks, plotting accuracy

                                                                         6

94 CCC (34.82s) 34.8 ABC (7.97s) CBA (14.02s) CCC (25.01s) 25.0 86 CCA
(20.06s) 25.0 CBA (18.12s) 92 ABC (16.22s) BBB (5.21s) BCC (15.52s) 84
CBA (14.06s) CCC (24.99s) CCA (26.54s) 98 CCA (20.07s) 90 BBB (9.57s)
BCC (15.53s) BCC (25.71s) 82 96 BAB (4.83s) ABC (8.10s) Final Accuracy
(%)

                                                                                                    Final Accuracy (%)




                                                                                                                                                                                                         Final Accuracy (%)
                     88     BAB (8.21s)                                                                                                                                                                                            BAB (4.79s)
                                                                                                                                                                                                                              80




                                                                                      Latency (s)




                                                                                                                                                                                           Latency (s)




                                                                                                                                                                                                                                                                                                 Latency (s)
                     86                                                                                                                                                                                                                   BBB (5.19s)
                                                                                                                         94                                                                                                   78
                     84                                                         17.2                                                                                                 11.0                                                                                                  11.1
                     82                                                                                                  92                                                                                                   76

                     80                                                                                                                                                                                                       74
                                                                                                                         90
                     78   AAA (4.74s)                         Pareto frontier
                                                                                                                              AAA (2.18s)                         Pareto frontier                                             72     AAA (2.22s)                         Pareto frontier
                          0.010 0.015 0.020 0.025 0.030 0.035 0.040             4.7                                           0.010 0.015 0.020 0.025 0.030 0.035 0.040 0.045        2.2                                      0.005 0.010 0.015 0.020 0.025 0.030 0.035 0.040              2.2
                                        Cost per Prompt ($)                                                                                 Cost per Prompt ($)                                                                                    Cost per Prompt ($)
                                              AgiEval                                                                                            PythonIO                                                                                                LogiQA
                                                      Fig. 3: Accuracy vs. cost with latency color-coded; Pareto frontier shown (dashed).


    against cost, with latency represented by the color of each                                                                                               Findings for RQ3
    point. The dashed line in each plot indicates the Pareto frontier,                                                                                        Trade-offs are task-dependent. The optimal balance of
    representing the set of configurations that are optimal because                                                                                           accuracy, cost, and latency varies by task, reflected in the
    no other configuration offers higher accuracy at a lower or                                                                                               differing Pareto frontiers across datasets.
    equal cost.
                                                                                                                                                              Heterogeneous pipelines offer robustness. A mixed
       The plots in Figure 3 reveal that the optimal configuration                                                                                            configuration such as CBA delivers strong, balanced per-
    is highly dependent on the specific task. On AgiEval, there                                                                                               formance and often lies on the Pareto frontier.
    is a clear trade-off between accuracy and cost. The CCC                                                                                                   Accountability has a price. The accountable protocol
    configuration achieves the highest accuracy (93.54%) but is                                                                                               adds traceability and stability but can increase operational
    also the most expensive. Configurations like CBA and CCA                                                                                                  cost.
    sit on the Pareto frontier, offering near-peak accuracy (92.40%)
    at a significantly lower cost, making them excellent balanced
    choices. The fastest and cheapest configurations, such as                                                                                                             V. D ISCUSSION AND T HREATS TO VALIDITY
    AAA and BAB, offer lower accuracy but may be suitable for
    applications where speed and cost are the primary constraints.                                                                                            Our results show that accountability improves stability and
       On PythonIO, the trade-off dynamics are different. Sev-                                                                                             interpretability, but it comes with trade-offs. In some cases,
    eral configurations (ABC, CBA, CCC) achieve near-perfect                                                                                               strict handoffs limit the flexibility of later agents, leading
    accuracy of 99.21%. As the plot shows, these top-tier con-                                                                                             to small accuracy decreases. Structured outputs and logging
    figurations are spread out horizontally, indicating that the                                                                                           also add overhead: compared to simple monolithic baselines,
    key decision is no longer about gaining accuracy but about                                                                                             accountable pipelines increased costs by about 2–3× and
    minimizing cost and latency. The ABC configuration is the                                                                                              raised median latency from ∼2s in lightweight settings to 20–
    most efficient of this group, while the CCC configuration is                                                                                           25s in heavier ones (roughly 8–10× slower). Model choice
    by far the most expensive for no additional accuracy gain,                                                                                             further shapes this balance: stronger models yield higher
    placing it well inside the Pareto frontier.                                                                                                            accuracy but incur higher cost and more latency, while lighter
                                                                                                                                                           models improve efficiency at the risk of reduced reasoning
       On LogiQA, the Pareto frontier is again clearly visible,
                                                                                                                                                           depth. Designing reliable pipelines therefore requires tuning
    showing a direct relationship between cost and accuracy. The
                                                                                                                                                           role assignments to the task and deployment budget.
    CCA configuration provides the highest accuracy at 85.51%.
    The CBA configuration offers a slightly lower accuracy                                                                                                    These findings should be interpreted in light of three
    (83.75%) but is significantly cheaper, making it a strong                                                                                              main validity concerns. First, construct validity: we rely on
    alternative on the frontier. As with the other datasets, the                                                                                           multiple-choice benchmarks (PythonIO, LogiQA, AGIEval),
    AAA configuration is the most economical but also the least                                                                                            which simplify open-ended tasks into discrete answers. This
    accurate.                                                                                                                                              makes blame attribution feasible but may not reflect the full
                                                                                                                                                           complexity of real-world software engineering. Second, inter-
      Across all three datasets, the plots illustrate that there is                                                                                        nal validity: blame assignment assumes access to ground-truth
    no single ”best” configuration. The choice depends on the                                                                                              labels, not always available at runtime; practical deployments
    specific requirements of the application, balancing the need for                                                                                       would require proxies such as self-consistency checks, verifier
    accuracy with the constraints of cost and latency. Furthermore,                                                                                        agents, or unit tests. Finally, external validity: results are
    the analysis highlights the value of heterogeneous pipelines, as                                                                                       based on three proprietary LLMs during a fixed evaluation
    configurations like CBA and CCA frequently represent optimal                                                                                           window. Model updates may alter performance, though we
    points on the Pareto frontier.                                                                                                                         release prompts, logs, and evaluation dates to support replica-
                                                                                                                                                           tion and encourage extension to open-source models.



                                                                                                                                                       7

VI. C ONCLUSION \[13\] S. Triantafyllou, A. Singla, and G. Radanovic,
"On blame attribution for accountable multi-agent sequential decision
making," Advances in We present a large-scale study that opens the black
box Neural Information Processing Systems, vol. 34, pp. 15 774--15 786,
of sequential multi-agent LLM pipelines. Across three bench- 2021.
\[14\] N. F. Liu, K. Lin, J. Hewitt, A. Paranjape, M. Bevilacqua, marks
we compare monolithic models, simple pipelines, and F. Petroni, and P.
Liang, "Lost in the middle: How language accountable pipelines. Key
insights: (1) accountability is es- models use long contexts,"
Transactions of the Association for sential; structured handoffs prevent
failure cascades and can Computational Linguistics, vol. 12,
pp. 157--173, 2024. \[Online\]. Available:
https://aclanthology.org/2024.tacl-1.9/ raise accuracy by more than 36
points (PythonIO), (2) role \[15\] Q. Wu, G. Bansal, J. Zhang, Y. Wu, B.
Li, E. Zhu, L. Jiang, X. Zhang, specialization is real; planner quality
dominates (best planner S. Zhang, J. Liu et al., "Autogen: Enabling
next-gen llm applications via 7.35% error vs worst 40.49%) and models
differ by role multi-agent conversations," in First Conference on
Language Modeling, 2024. (Executor repair 10.01%, Critic repair 5.20%),
which supports \[16\] W. Chen, Y. Su, J. Zuo, C. Yang, C. Yuan, C. Qian,
C.-M. Chan, data driven casting, and (3) trade-offs among accuracy,
cost, Y. Qin, Y. Lu, R. Xie et al., "Agentverse: Facilitating
multi-agent col- and latency are task dependent, with heterogeneous
pipelines laboration and exploring emergent behaviors in agents," arXiv
preprint arXiv:2308.10848, vol. 2, no. 4, p. 6, 2023. often on the
Pareto frontier. We move from black box evalu- \[17\] A. Barrak, Y.
Fourati, M. Olchawa, E. Ksontini, and K. Zoghlami, ation to a glass box
engineering approach, with metrics and "Cargo: A framework for
confidence-aware routing of large language methods that help diagnose,
debug, and optimize multi-agent models," in Proceedings of the 35th IEEE
International Conference on Collaborative Advances in Software and
Computing (CASCON). IEEE, systems for robust, predictable performance.
2025. \[18\] A. Madaan, N. Tandon, P. Gupta, S. Hallinan, L. Gao, S.
Wiegreffe, VII. ACKNOWLEDGEMENT U. Alon, N. Dziri, S. Prabhumoye, Y.
Yang et al., "Self-refine: Iter- ative refinement with self-feedback,"
Advances in Neural Information This work was conducted in collaboration
with zuvu.ai, an Processing Systems, vol. 36, pp. 46 534--46 594, 2023.
industrial partner developing AI-powered tools. \[19\] X. Chen, M. Lin,
N. Schaerli, and D. Zhou, "Teaching large language models to
self-debug," in The 61st Annual Meeting Of The Association R EFERENCES
For Computational Linguistics, 2023. \[20\] R. Tufano, L. Pascarella, M.
Tufano, D. Poshyvanyk, and G. Bavota, \[1\] J. He, C. Treude, and D. Lo,
"Llm-based multi-agent systems for "Towards automating code review
activities," in 2021 IEEE/ACM 43rd software engineering: Literature
review, vision, and the road ahead," International Conference on
Software Engineering (ICSE). IEEE, 2021, ACM Transactions on Software
Engineering and Methodology, vol. 34, pp. 163--174. no. 5, pp. 1--30,
2025. \[21\] E. Xue, Z. Huang, Y. Ji, and H. Wang, "Improve: Iterative
model pipeline \[2\] H. Jin, L. Huang, H. Cai, J. Yan, B. Li, and H.
Chen, "From llms to llm- refinement and optimization leveraging llm
agents," arXiv preprint based agents for software engineering: A survey
of current, challenges arXiv:2502.18530, 2025. and future," arXiv
preprint arXiv:2408.02479, 2024. \[22\] S. Lifshitz, S. A. McIlraith,
and Y. Du, "Multi-agent verification: Scaling \[3\] L. Wang, C. Ma, X.
Feng, Z. Zhang, H. Yang, J. Zhang, Z. Chen, test-time compute with
multiple verifiers (abridged)," in Workshop on J. Tang, X. Chen, Y. Lin
et al., "A survey on large language model based Reasoning and Planning
for Large Language Models. autonomous agents," Frontiers of Computer
Science, vol. 18, no. 6, p. \[23\] Z. Zhang, Z. Jiang, L. Xu, H. Hao,
and R. Wang, "Multiple-choice 186345, 2024. questions are efficient and
robust llm evaluators," arXiv preprint \[4\] C. Qian, X. Cong, C. Yang,
W. Chen, Y. Su, J. Xu, Z. Liu, and arXiv:2405.11966, 2024. M. Sun,
"Communicative agents for software development," arXiv \[24\] J. Liu, L.
Cui, H. Liu, D. Huang, Y. Wang, and Y. Zhang, "Logiqa: preprint
arXiv:2307.07924, vol. 6, no. 3, p. 1, 2023. A challenge dataset for
machine reading comprehension with logical \[5\] S. Hong, M. Zhuge, J.
Chen, X. Zheng, Y. Cheng, C. Zhang, J. Wang, reasoning," arXiv preprint
arXiv:2007.08124, 2020. Z. Wang, S. K. S. Yau, Z. Lin et al., "Metagpt:
Meta programming for \[25\] W. Zhong, R. Cui, Y. Guo, Y. Liang, S. Lu,
Y. Wang, A. Saied, W. Chen, a multi-agent collaborative framework."
International Conference on and N. Duan, "Agieval: A human-centric
benchmark for evaluating Learning Representations, ICLR, 2024.
foundation models," arXiv preprint arXiv:2304.06364, 2023. \[6\] C. Lee,
C. S. Xia, L. Yang, J.-t. Huang, Z. Zhu, L. Zhang, and M. R. \[26\] R.
Hart. (2024, July) What ai is the best? chatbot Lyu, "A unified
debugging approach via llm-based multi-agent synergy," arena relies on
millions of votes. Forbes coverage of arXiv preprint arXiv:2404.17153,
2024. Chatbot Arena overall leaders (GPT-4o listed first). \[On- \[7\]
W. Epperson, G. Bansal, V. Dibia, A. Fourney, J. Gerrits, E. Zhu,
line\]. Available: https://www.forbes.com/sites/roberthart/2024/07/18/
and S. Amershi, "Interactive debugging and steering of multi-agent ai
what-ai-is-the-best-chatbot-arena-relies-on-millions-of-human-votes/
systems," in Proceedings of the 2025 CHI Conference on Human Factors
\[27\] S. Sharma. (2024, June) Anthropic's claude 3.5 sonnet surges in
Computing Systems, ser. CHI '25, 2025. to top of ai rankings in lmsys
chatbot arena, challenging \[8\] A. Z. Yang, C. Le Goues, R. Martins,
and V. Hellendoorn, "Large industry giants. \[Online\]. Available:
https://venturebeat.com/ai/ language models for test-free fault
localization," in Proceedings of the
anthropic-claude-3-5-sonnet-surges-to-top-of-ai-rankings 46th IEEE/ACM
International Conference on Software Engineering, \[28\] U. Shakir.
(2025, March) Google says its new 'reasoning' gemini 2024, pp. 1--12. ai
models are the best ones yet. Mentions Gemini 2.5 Pro leading \[9\] K.
Ronanki, "Facilitating trustworthy human-agent collaboration in llm-
LMArena with a 39 Elo point margin. \[Online\]. Available: https://www.
based multi-agent system oriented software engineering," in Proceedings
theverge.com/news/635502/google-gemini-2-5-reasoning-ai-model of the
33rd ACM International Conference on the Foundations of \[29\] OpenAI.
(2025) Api pricing. \[Online\]. Available: https://openai.com/ Software
Engineering, 2025, pp. 1333--1337. api/pricing/ \[10\] M. Z. Pan, M.
Cemri, L. A. Agrawal, S. Yang, B. Chopra, R. Tiwari, \[30\] Anthropic.
Claude sonnet 4 api pricing. \[Online\]. Available: https: K. Keutzer,
A. Parameswaran, K. Ramchandran, D. Klein et al., "Why
//www.anthropic.com/news/1m-context do multiagent systems fail?" in ICLR
2025 Workshop on Building Trust \[31\] Google AI. (2025) Gemini
developer api pricing. \[Online\]. Available: in Language Models and
Applications, 2025. https://ai.google.dev/gemini-api/docs/pricing \[11\]
J. Cleland-Huang, O. C. Gotel, J. Huffman Hayes, P. Mäder, and \[32\] G.
Wang, Y. Xie, Y. Jiang, A. Mandlekar, C. Xiao, Y. Zhu, L. Fan, and A.
Zisman, "Software traceability: trends and future directions," in A.
Anandkumar, "Chain of agents: Large language models collaborating Future
of software engineering proceedings, 2014, pp. 55--69. on long-context
tasks," arXiv preprint arXiv:2404.18260, 2024. \[12\] S. Zhang, M. Yin,
J. Zhang, J. Liu, Z. Han, J. Zhang, B. Li, C. Wang, \[33\] A. Mushtaq,
M. R. Naeem, I. Ghaznavi, M. I. Taj, I. Hashmi, H. Wang, Y. Chen et al.,
"Which agent causes task failures and when? on and J. Qadir, "Harnessing
multi-agent llms for complex engineer- automated failure attribution of
llm multi-agent systems," arXiv preprint ing problem-solving: A
framework for senior design projects," arXiv arXiv:2505.00212, 2025.
preprint arXiv:2501.01205, 2025.

                                                                                 8


