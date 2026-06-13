## 1. 11-A Complete Traceability Methodology Between UML Diagrams and Source Code

**Arquivo:** 

**Abstract:**
Abstract: Traceability in software development proves its importance in many domains like change
management, customer's requirements satisfaction, model slicing, etc. Existing traceability techniques
trace either between requirement and design or between requirement and code. However, none of the
existing approaches achieved reliable results when dealing with traceability between requirements,
design models and source code. In this paper, we propose an improvement and an extension of our design
traceability approach in order to tackle the traceability between design, requirement and code. The finetuning of our methodology stems from considering an expanded textual description. A pre-treatment step
is added in order to divide the textual description of system functionalities into different parts, each of
which represents a specific goal. In fact, the extension consists in extracting an expanded textual
description from a natural language text in order to trace between related elements belonging to
requirement, design and code while using an information retrieval technique. The proposed method is
based on different scenarios (nominal, alternatives and errors), particularly on concepts related to control
structures to establish the traceability between artefacts. Furthermore, we implemented our method in a
tool allowing the evaluation of its performance. The evaluation is performed on real existing applications
that consist in comparing results found by our approach with results found by experts. Our method
achieves an average precision of 0.84 and a recall of 0.91 in traceability between requirement, design
and code. Besides its promising performance outcomes, our automated method has the merit of generating
a traceability report describing the correspondence between different artefacts.
Povzetek: Prispevek opisuje novo metodo za sledenje povezavam med UML diagrami in izvirno kodo.

1

Introduction

Traceability quality is defined as the degree to which
existing artefacts of a software development project are
traceable as mandated by the project’s traceability
stakeholders. The Unified Modelling Language (UML) is
used for specifying, constructing, and documenting these
artefacts. It is composed of a set of diagrams grouping
structural and semantic dependencies between UML

---

## 2. 12-LiSSA Toward Generic Traceability Link Recovery through RAG

**Arquivo:** 

**Abstract:**
Abstract—There are a multitude of software artifacts which
need to be handled during the development and maintenance
of a software system. These artifacts interrelate in multiple,
complex ways. Therefore, many software engineering tasks are
enabled — and even empowered — by a clear understanding of
artifact interrelationships and also by the continued advancement
of techniques for automated artifact linking.
However, current approaches in automatic Traceability Link
Recovery (TLR) target mostly the links between specific sets of
artifacts, such as those between requirements and code. Fortunately, recent advancements in Large Language Models (LLMs)
can enable TLR approaches to achieve broad applicability. Still,
it is a nontrivial problem how to provide the LLMs with the
specific information needed to perform TLR.
In this paper, we present LiSSA, a framework that harnesses LLM performance and enhances them through RetrievalAugmented Generation (RAG). We empirically evaluate LiSSA on
three different TLR tasks, requirements to code, documentation
to code, and architecture documentation to architecture models,
and we compare our approach to state-of-the-art approaches.
Our results show that the RAG-based approach can significantly outperform the state-of-the-art on the code-related tasks.
However, further research is required to improve the performance of RAG-based approaches to be applicable in practice.
Index Terms—Traceability Link Recovery, Large Language
Models, Retrieval-Augmented Generation

I. I NTRODUCTION
In the complex task of software development, developers
and other stakeholders handle numerous artifacts, such as requirements, code, documentation, and models. Consequently,
success in development depends, in part, on understanding
how software artifacts interrelate. To deal with the interrelations of these artifacts, researchers and practitioners actively
investigate the creation and recovery of so-called trace links
between these artifacts. Traceability Link Recovery (TLR)
identifies correspondences between elements in artifacts and

---

## 3. 13-Recovering Trace Links Between Software Documentation And Code

**Arquivo:** 

**Abstract:**
**[Abstract não encontrado no PDF]**

---

## 4. 14-A Survey on Code Generation with LLM-based Agents

**Arquivo:** 

**Abstract:**
Abstract—Code generation agents powered by large language models (LLMs) are revolutionizing the software development paradigm.
Distinct from previous code generation techniques, code generation agents are characterized by three core features. 1) Autonomy:
the ability to independently manage the entire workflow, from task decomposition to coding and debugging. 2) Expanded task scope:
capabilities that extend beyond generating code snippets to encompass the full software development lifecycle (SDLC). 3) Enhancement
of engineering practicality: a shift in research emphasis from algorithmic innovation toward practical engineering challenges, such
as system reliability, process management, and tool integration. This domain has recently witnessed rapid development and an
explosion in research, demonstrating significant application potential. This paper presents a systematic survey of the field of LLMbased code generation agents. We trace the technology’s developmental trajectory from its inception and systematically categorize its
core techniques, including both single-agent and multi-agent architectures. Furthermore, this survey details the applications of LLMbased agents across the full SDLC, summarizes mainstream evaluation benchmarks and metrics, and catalogs representative tools.
Finally, by analyzing the primary challenges, we identify and propose several foundational, long-term research directions for the future
work of the field.
Index Terms—Code Generation; Software Development; Large Language Models; LLM-based Agent; Multi-agent System

✦

1

I NTRODUCTION

and rapidly become one of the most promising application
directions for LLM technology.
Although LLM-based code generation techniques have
Code generation aims to automatically transform human
intentions expressed in certain specifications into executable shown excellent performance in generating standalone procomputer programs, serving as a fundamental approach grams [7–9], their single-response mode exposes significant
to improving software productivity. Early research in code limitations when handling complex, engineering-oriented
generation primarily adopted program synthesis meth- software development tasks. Native LLMs lack the ability
ods [1], deriving verifiably correct programs through formal to autonomously decompose tasks, interact with real develspecifications. However, due to the difficulty of writing opment environments, validate generated code, and implespecifications, this approach was long confined to well- ment continuous self-correction mechanisms. As a result,
defined specific tasks. To enhance generalization capa- they struggle to independently complete software develbilities, research subsequently shifted toward data-driven opment tasks that require cross-file context understanding,
paradigms based on deep learning, treating code gener- dynamic debugging, and iterative optimization. To address
ation as a probabilistic sequence learning problem [2, 3]. these problems, LLM-based code generation agents have
Nevertheless, code snippets generated by such methods been proposed, which use LLMs as the brain to construct

---

## 5. 16-AgentCoder Multi-Agent-based Code Generation with Iterative Testing and Optimisation

**Arquivo:** 

**Abstract:**
Abstract
The advancement of natural language processing
(NLP) has been significantly boosted by the development of transformer-based large language models (LLMs). These models have revolutionized
NLP tasks, particularly in code generation, aiding
developers in creating software with enhanced efficiency. Despite their advancements, challenges
in balancing code snippet generation with effective test case generation and execution persist. To
address these issues, this paper introduces MultiAgent Assistant Code Generation (AgentCoder),
a novel solution comprising a multi-agent framework with specialized agents: the programmer
agent, the test designer agent, and the test executor agent. During the coding procedure, the programmer agent will focus on the code generation
and refinement based on the test executor agent’s
feedback. The test designer agent will generate test
cases for the generated code, and the test executor
agent will run the code with the test cases and write
the feedback to the programmer. This collaborative
system ensures robust code generation, surpassing
the limitations of single-agent models and traditional methodologies. Our extensive experiments
on 9 code generation models and 12 enhancement
approaches showcase AgentCoder’s superior performance over existing code generation models
and prompt engineering techniques across various
benchmarks. For example, AgentCoder achieves
77.4% and 89.1% pass@1 in HumanEval-ET and

---

## 6. 17-MetaGPT Meta Programming for A Multi-Agent Collaborative Framework

**Arquivo:** 

**Abstract:**
**[Abstract não encontrado no PDF]**

---

## 7. 18-ChatDev Communicative Agents for Software Development

**Arquivo:** 

**Abstract:**
Abstract

Software

Develop a
Gomoku game

Codes

arXiv:2307.07924v5 [cs.SE] 5 Jun 2024

Software development is a complex task that
necessitates cooperation among multiple members with diverse skills. Numerous studies used
deep learning to improve specific phases in a
waterfall model, such as design, coding, and
testing. However, the deep learning model
in each phase requires unique designs, leading to technical inconsistencies across various
phases, which results in a fragmented and ineffective development process. In this paper,
we introduce ChatDev, a chat-powered software development framework in which specialized agents driven by large language models
(LLMs) are guided in what to communicate
(via chat chain) and how to communicate (via
communicative dehallucination). These agents
actively contribute to the design, coding, and
testing phases through unified language-based
communication, with solutions derived from
their multi-turn dialogues. We found their utilization of natural language is advantageous
for system design, and communicating in programming language proves helpful in debugging. This paradigm demonstrates how linguistic communication facilitates multi-agent collaboration, establishing language as a unifying bridge for autonomous task-solving among
LLM agents. The code and data are available
at https://github.com/OpenBMB/ChatDev.

---

## 8. 19-Towards Engineering Multi-Agent LLMs A Protocol-Driven Approach

**Arquivo:** 

**Abstract:**
Abstract—The increasing demand for software development
has driven interest in automating software engineering (SE)
tasks using Large Language Models (LLMs). Recent efforts
extend LLMs into multi-agent systems (MAS) that emulate
collaborative development workflows, but these systems often fail
due to three core deficiencies: under-specification, coordination
misalignment, and inappropriate verification, arising from the
absence of foundational SE structuring principles. This paper
introduces Software Engineering Multi-Agent Protocol (SEMAP),
a protocol-layer methodology that instantiates three core SE
design principles for multi-agent LLMs: (1) explicit behavioral
contract modeling, (2) structured messaging, and (3) lifecycleguided execution with verification, and is implemented atop
Google’s Agent-to-Agent (A2A) infrastructure. Empirical evaluation using the Multi-Agent System Failure Taxonomy (MAST)
framework demonstrates that SEMAP effectively reduces failures
across different SE tasks. In code development, it achieves up to
a 69.6% reduction in total failures for function-level development
and 56.7% for deployment-level development. For vulnerability
detection, SEMAP reduces failure counts by up to 47.4% on
Python tasks and 28.2% on C/C++ tasks.
Index Terms—Large Language Models, Multi-Agent Systems,
AI Agent Protocols, Software Engineering, AI for SE

I. I NTRODUCTION
As software has become an essential backbone supporting
almost every aspect of modern society, nowadays there has
been a rapid increase in demand not only for more software
but also for more advanced software development to sustain
and accelerate technological progress. However, although the
number of software developers is reaching 47 million in
2025 [1], this remains insufficient to meet the rising demand,

---

## 9. 1-Quality in Model-Driven Engineering

**Arquivo:** 

**Abstract:**
Abstract Context: Model-Driven Engineering (MDE) is believed to have a signiﬁcant impact in software quality. However, researchers and practitioners may
have a hard time locating consolidated evidence on this impact, as the available
information is scattered in several diﬀerent publications.
Objective: Our goal is to aggregate consolidated ﬁndings on quality in MDE, facilitating the work of researchers and practitioners in learning about the coverage and
main ﬁndings of existing work as well as identifying relatively unexplored niches
of research that need further attention.
Method: We performed a tertiary study on quality in MDE, in order to gain a
better understanding of its most prominent ﬁndings and existing challenges, as
reported in the literature.
Results: We identiﬁed 22 systematic literature reviews and mapping studies and
the most relevant quality attributes addressed by each of those studies, in the
context of MDE. Maintainability is clearly the most often studied and reported
quality attribute impacted by MDE. 80 out of 83 research questions in the selected
secondary studies have a structure that is more often associated with mapping
Miguel Goulão
NOVA LINCS, Departamento de Informática
Universidade Nova de Lisboa
Tel.: +351-21-2948536
Fax: +351-21-2948541
E-mail: mgoul@fct.unl.pt
Vasco Amaral
NOVA LINCS, Departamento de Informática
Universidade Nova de Lisboa
Tel.: +351 212948536
Fax: +351 212948541
E-mail: vma@fct.unl.pt
Marjan Mernik
Faculty of Electrical Engineering and Computer Science
University of Maribor
Tel.: +386 22207455

---

## 10. 20-Designing LLM-based Multi-Agent Systems for Software Engineering Tasks

**Arquivo:** 

**Abstract:**
Abstracting with credit is permitted. To copy otherwise, or republish, to post on servers or to redistribute to lists, requires
prior specific permission and/or a fee. Request permissions from permissions@acm.org.
© 2025 Copyright held by the owner/author(s). Publication rights licensed to ACM.
ACM 1557-7392/2025/0-ART0
https://doi.org/XXXXXXX.XXXXXXX
ACM Trans. Softw. Eng. Methodol., Vol. 0, No. 0, Article 0. Publication date: 2025.

0:2

Cai et al.

capabilities of MASs [28]. LLM-based MASs consist of multiple autonomous agents that collaborate
through communication and responsibility specialization to tackle complex tasks given by users
and simulate problem-solving environments [11]. LLM-based MASs have demonstrated significant
potential in addressing Software Engineering (SE) tasks and have become a focal point of research
and practice in SE [13]. Many researchers have designed LLM-based MASs to address specific SE
tasks [13]. For example, Hong et al. [14] proposed an LLM-based MAS named MetaGPT, which is
capable of automatically developing an entire software system. Jin et al. [17] proposed an LLM-based
MAS named MARE (Multi-Agents Collaboration Framework for Requirements Engineering), which
could complete the process of requirements engineering.
Effective design is paramount to the success of LLM-based MASs, as it directly shapes key quality
attributes such as reliability, maintainability, scalability, and safety, and profoundly influences
collaborative behaviors of agents (e.g., volunteering, conformity, and destructive actions), which
in turn affect overall task-solving efficiency among agents in MASs [8]. Therefore, a principled
understanding of design rationale is essential not only for constructing high-quality MASs but
also for navigating trade-offs among competing quality attributes (e.g., correctness vs. efficiency)
[18]. Despite the increasing interest and adoption of LLM-based MASs for various SE tasks, no
existing study has systematically investigated the specific Quality Attributes (QAs), design patterns,
and underlying design rationale that inform their construction. To address this gap, our goal is
to identify QAs and design patterns that practitioners prioritize when building LLM-based MASs,

---

## 11. 21-Agyn A Multi-Agent System for Team-Based Autonomous SE

**Arquivo:** 

**Abstract:**
Abstract
Large language models have demonstrated strong capabilities in individual software
engineering tasks, yet most autonomous systems still treat issue resolution as a
monolithic or pipeline-based process. In contrast, real-world software development
is organized as a collaborative activity carried out by teams following shared
methodologies, with clear role separation, communication, and review. In this
work, we present a fully automated multi-agent system that explicitly models
software engineering as an organizational process, replicating the structure of an
engineering team. Built on top of AGYN, an open-source platform for configuring
agent teams, our system assigns specialized agents to roles such as coordination,
research, implementation, and review, provides them with isolated sandboxes for
experimentation, and enables structured communication. The system follows a
defined development methodology for working on issues, including analysis, task
specification, pull request creation, and iterative review, and operates without any
human intervention. Importantly, the system was designed for real production use
and was not tuned for SWE-bench. When evaluated post hoc on SWE-bench 500,
it resolves 72.2% of tasks, outperforming single-agent baselines using comparable
language models. Our results suggest that replicating team structure, methodology,
and communication is a powerful paradigm for autonomous software engineering,
and that future progress may depend as much on organizational design and agent
infrastructure as on model improvements.

1

Introduction

Large Language Models (LLMs) have recently demonstrated strong capabilities in software engineering tasks such as code understanding, bug fixing, and test generation. Benchmarks such as
SWE-bench [Jimenez et al., 2024] have emerged as a standard evaluation framework for measuring
progress toward autonomous software engineering agents by requiring systems to resolve real GitHub
issues through patches that pass repository test suites. Despite steady improvements in model quality,

---

## 12. 22-DoVer Intervention-Driven Auto Debugging for LLM Multi-Agent Systems

**Arquivo:** 

**Abstract:**
**[Abstract não encontrado no PDF]**

---

## 13. 23-Multi-Agent Code Verification via Information Theory

**Arquivo:** 

**Abstract:**
Abstract
LLMs generate buggy code: 29.6% of SWE-bench “solved” patches fail, 62% of BaxBench solutions have vulnerabilities, and existing tools only catch 65% of bugs with 35% false positives. We built CodeX-Verify, a multi-agent
system that uses four specialized agents to detect different types of bugs. We prove mathematically that combining
agents with different detection patterns finds more bugs than any single agent when the agents look for different
problems, using submodularity of mutual information under conditional independence. Measuring agent correlation
of ρ = 0.05–0.25 confirms they detect different bugs. Testing on 99 code samples with verified labels shows our system
catches 76.1% of bugs, matching the best existing method (Meta Prompt Testing: 75%) while running faster and
without test execution. We tested all 15 agent combinations and found that using multiple agents improves accuracy
by 39.7 percentage points (from 32.8% to 72.4%) compared to single agents, with diminishing returns of +14.9pp,
+13.5pp, and +11.2pp for agents 2, 3, and 4, validating our theoretical model. The best two-agent combination
(Correctness + Performance) reaches 79.3% accuracy. Testing on 300 real patches from Claude Sonnet 4.5 runs in
under 200ms per sample, making this practical for production use.
Keywords: Multi-agent systems, Code verification, LLM-generated code, Information theory
that runs four specialized agents in parallel: Correctness
1 Introduction
(logic errors, edge cases, exception handling), Security
LLMs generate code that looks correct but often fails (OWASP Top 10, CWE patterns, secrets), Performance
in production. While LLM-generated code passes basic (algorithmic complexity, resource leaks), and Style (mainsyntax checks and simple tests, recent studies show it tainability, documentation). Each agent looks for differcontains hidden bugs. Xia et al. [28] find that 29.6% ent bug types. We prove that combining agents finds
of patches marked “solved” on SWE-bench don’t match more bugs than any single agent using submodularity
what human developers wrote, with 7.8% failing full test of mutual information under conditional independence:
suites despite passing initial tests. SecRepoBench reports I(A1 , A2 , A3 , A4 ; B) > maxi I(Ai ; B). Measuring how ofthat LLMs write secure code ¡25% of the time across 318 ten our agents agree shows correlation ρ = 0.05–0.25,
C/C++ tasks [8], and BaxBench finds 62% of backend confirming they catch different bugs.
code has vulnerabilities or bugs [26]. Studies suggest 40–
Results. We tested on 99 code samples with verified
60% of LLM code contains undetected bugs [13], making labels covering 16 bug categories from real SWE-bench
automated deployment risky.
failures. Our system catches 76.1% of bugs, matching
The Problem. Existing verification tools check code Meta Prompt Testing (75%) [27] while running faster
in one way at a time, missing bugs that require looking and without executing code. We improve 28.7 percentfrom multiple angles. Traditional static analyzers (Sonar- age points over Codex (40%) and 3.7 points over tradiQube, Semgrep, CodeQL) catch 65% of bugs but flag tional static analyzers (65%). Our 50% false positive rate
good code as buggy 35% of the time [22]. Test-based is higher than test-based methods (8.6%) because we flag

---

## 14. 24-Automated Verification and Structural Consistency in Multi-Agent Code Generation

**Arquivo:** 

**Abstract:**
Abstract and
Conclusion

("large language model" OR "language model" OR "LLM") AND
("multi-agent" OR "multiagent" OR "AI agent" OR "intelligent agent" OR "LLM
based agent" OR "agent-based system" OR "collaborative agent") AND
("code generation" OR "program synthesis" OR "automated programming"
OR "code writing" OR "software generation" OR "code completion" OR "code
synthesis" OR "program generation")

F Results Documentation
Forward
Snowballing

Backward
Snowballing

Research
Demography

Peer Reviewed Papers

297

37

ACM

441

---

## 15. 25-Traceability and Accountability in Role-Specialized Multi-Agent LLM Pipelines

**Arquivo:** 

**Abstract:**
Abstract—Sequential multi-agent systems built with large language models (LLMs) can automate complex software tasks,
but they are hard to trust because errors quietly pass from
one stage to the next. We study a traceable and accountable
pipeline, meaning a system with clear roles, structured handoffs,
and saved records that let us trace who did what at each
step and assign blame when things go wrong. Our setting is
a Planner → Executor → Critic pipeline. We evaluate eight
configurations of three state-of-the-art LLMs on three benchmarks and analyze where errors start, how they spread, and
how they can be fixed. Our results show: (1) adding a structured,
accountable handoff between agents markedly improves accuracy
and prevents the failures common in simple pipelines; (2) models
have clear role-specific strengths and risks (e.g., steady planning
vs. high-variance critiquing), which we quantify with repair
and harm rates; and (3) accuracy–cost–latency trade-offs are
task-dependent, with heterogeneous pipelines often the most
efficient. Overall, we provide a practical, data-driven method
for designing, tracing, and debugging reliable, predictable, and
accountable multi-agent systems.
Index Terms—Multi-agent LLMs, Sequential pipelines, Role
Based Reasoning, Agents Collaboration, Traceable Pipeline.

I. I NTRODUCTION
The field of software engineering is undergoing a significant transformation, driven by the rise of Large Language
Models (LLMs). This evolution is progressing from LLMpowered “co-pilots” that assist developers to fully autonomous,
multi-agent systems capable of tackling complex software
development tasks with minimal human intervention [1, 2].
A common architectural pattern is the sequential multi-agent
pipeline, where specialized LLM-based agents collaborate in
a predefined order to perform roles such as planning, development, and testing [3]. Systems like ChatDev and MetaGPT
have demonstrated the potential of this approach, where task

---

## 16. 26-Veri-Sure Contract-Aware Multi-Agent Framework with Formal Verification

**Arquivo:** 

**Abstract:**
Abstract

bar for productivity and correctness in Electronic Design
Automation (EDA). In practice, the central artifact in the
design flow is the Register-Transfer Level (RTL) description, typically written in Hardware Description Languages
(HDLs) such as Verilog and SystemVerilog, which specifies
clocked state and the combinational logic between registers,
precisely capturing concurrent circuit behavior under strict
timing constraints and enabling downstream synthesis and
implementation. As a result, writing high-quality, synthesizable RTL remains an indispensable yet costly step in
modern chip development.

In the rapidly evolving field of Electronic Design Automation (EDA), the deployment of Large
Language Models (LLMs) for Register-Transfer
Level (RTL) design has emerged as a promising
direction. However, silicon-grade correctness remains bottlenecked by (i) limited test coverage
and reliability of simulation-centric evaluation,
(ii) regressions and repair hallucinations introduced by iterative debugging, and (iii) semantic
drift as intent is reinterpreted across agent handoffs. In this work, we propose V ERI -S URE, a
multi-agent framework that establishes a design
contract to align agents’ intent and uses a patching
mechanism guided by static dependency slicing to
perform precise, localized repairs. By integrating
a multi-branch verification pipeline that combines
trace-driven temporal analysis with formal verification consisting of assertion-based checking and
boolean equivalence proofs, V ERI -S URE enables
functional correctness beyond pure simulations.
We also introduce V ERILOG E VAL - V 2-EXT, extending the original benchmark with 53 more
industrial-grade design tasks and stratified difficulty levels, and show that V ERI -S URE achieves
state-of-the-art verified-correct RTL code generation performance, surpassing standalone LLMs

---

## 17. 27-TDD Governance for Multi-Agent Code Generation

**Arquivo:** 

**Abstract:**
Abstract
Large language models (LLMs) accelerate software development
but often exhibit instability, non-determinism, and weak adherence to development discipline in unconstrained workflows. While
test-driven development (TDD) provides a structured Red-GreenRefactor process, existing LLM-based approaches typically use tests
as auxiliary inputs rather than enforceable process constraints. We
present an AI-native TDD framework that operationalizes classical TDD principles as structured prompt-level and workflow-level
governance mechanisms. Extracted principles are formalized in a
machine-readable manifesto and distributed across planning, generation, repair, and validation stages within a layered architecture that
separates model proposal from deterministic engine authority. The
system enforces phase ordering, bounded repair loops, validation
gates, and atomic mutation control to improve stability and reproducibility. We describe architecture and discuss encoding software
engineering discipline directly into prompt orchestration, which
we think offers a promising direction for reliable LLM-assisted
development.

CCS Concepts
• Software and its engineering → Software development techniques; Automatic programming; • Computing methodologies → Artificial intelligence; Machine learning.

Keywords
Test-Driven Development, Large Language Models, Multi-Agent
Systems, Prompt Engineering, Software Engineering Governance

∗ Both authors contributed equally to this research.

Permission to make digital or hard copies of all or part of this work for personal or
classroom use is granted without fee provided that copies are not made or distributed
for profit or commercial advantage and that copies bear this notice and the full citation
on the first page. Copyrights for components of this work owned by others than the
author(s) must be honored. Abstracting with credit is permitted. To copy otherwise, or
republish, to post on servers or to redistribute to lists, requires prior specific permission

---

## 18. 28-Spec-Driven Development From Code to Contract in the Age of AI Coding Assistants

**Arquivo:** 

**Abstract:**
Abstract—The rise of AI coding assistants has reignited interest in an old idea: what if specifications—not code—were
the primary artifact of software development? Spec-driven development (SDD) inverts the traditional workflow by treating
specifications as the source of truth and code as a generated
or verified secondary artifact. This paper provides practitioners
with a comprehensive guide to SDD, covering its principles,
workflow patterns, and supporting tools. We present three levels
of specification rigor—spec-first, spec-anchored, and spec-assource—with clear guidance on when each applies. Through
analysis of tools ranging from Behavior-Driven Development
frameworks to modern AI-assisted toolkits like GitHub Spec
Kit, we demonstrate how the spec-first philosophy maps to real
implementations. We present case studies from API development,
enterprise systems, and embedded software, illustrating how
different domains apply SDD. We conclude with a decision
framework helping practitioners determine when SDD provides
value and when simpler approaches suffice.
Index Terms—Spec-Driven Development, AI-Assisted Coding,
Behavior-Driven Development, Test-Driven Development, API
Design First, Software Specifications

I. I NTRODUCTION
For decades, code has been the king of software development. Requirements documents exist, but they drift. Design
diagrams are drawn, but they rot. Tests are written, but often
after the fact. The code—whatever it actually does—becomes
the de facto truth of the system.
This code-centric reality has consequences. When a new
developer asks “what should this function do?” the answer
is often “read the code.” When a stakeholder asks “does the
system meet our requirements?” the answer requires reverseengineering intent from implementation. When an AI coding
assistant is asked to add a feature, it must guess what the
developer wants from a vague prompt.

---

## 19. 29-Design-OS A Specification-Driven Framework for Engineering System Design

**Arquivo:** 

**Abstract:**
ABSTRACT
Engineering system design—whether mechatronic, control, or
embedded—often proceeds in an ad hoc manner, with requirements left implicit and traceability from intent to parameters
largely absent. Existing specification-driven and systematic design methods mostly target software, and AI-assisted tools tend
to enter the workflow at solution generation rather than at problem framing. Human–AI collaboration in the design of physical
systems remains underexplored. This paper presents Design-OS,
a lightweight, specification-driven workflow for engineering system design organized in five stages: concept definition, literature
survey, conceptual design, requirements definition, and design
definition. Specifications serve as the shared contract between
human designers and AI agents; each stage produces structured
artifacts that maintain traceability and support agent-augmented
execution. We position Design-OS relative to requirements-driven
design, systematic design frameworks, and AI-assisted design
pipelines, and demonstrate it on a control systems design case
using two rotary inverted pendulum platforms—an open-source
SimpleFOC reaction wheel and a commercial Quanser Furuta
pendulum—showing how the same specification-driven workflow
accommodates fundamentally different implementations. A blank
template and the full design-case artifacts are shared in a public repository to support reproducibility and reuse. The workflow makes the design process visible and auditable, and extends
specification-driven orchestration of AI from software to physical
engineering system design.

---

## 20. 2-Automation in Model-Driven Engineering A look back, and ahead

**Arquivo:** 

**Abstract:**
**[Abstract não encontrado no PDF]**

---

## 21. 31-Do Large Language Models Respect Contracts Evaluating Contract-Adherence

**Arquivo:** 

**Abstract:**
**[Abstract não encontrado no PDF]**

---

## 22. 32-SpecEval Evaluating Code Comprehension via Program Specifications

**Arquivo:** 

**Abstract:**
**[Abstract não encontrado no PDF]**

---

## 23. 33-SpecMap Hierarchical LLM Agent for Datasheet-to-Code Traceability

**Arquivo:** 

**Abstract:**
Abstract
Establishing precise traceability between embedded systems datasheets and their corresponding
code implementations remains a fundamental challenge in systems engineering, particularly for lowlevel software where manual mapping between specification documents and large code repositories is
infeasible. Existing Traceability Link Recovery (TLR) approaches primarily rely on lexical similarity
and information retrieval techniques, which struggle to capture the semantic, structural, and symbollevel relationships prevalent in embedded systems software. We present a hierarchical datasheet-to-code
mapping methodology that employs large language models (LLMs) for semantic analysis while explicitly structuring the traceability process across multiple abstraction levels. Rather than performing
direct specification-to-code matching, the proposed approach progressively narrows the search space
through repository-level structure inference, file-level relevance estimation, and fine-grained symbollevel alignment. The method extends beyond function-centric mapping by explicitly covering macros,
structs, constants, configuration parameters, and register definitions commonly found in systems-level
C/C++ codebases. We evaluate the approach on multiple open-source embedded systems repositories
using manually curated datasheet-to-code ground truth. Experimental results show substantial improvements over traditional information-retrieval-based baselines, achieving up to 73.3% file mapping
accuracy. The hierarchical decomposition significantly reduces computational overhead, lowering total
LLM token consumption by 84% and end-to-end runtime by approximately 80%. This methodology
supports automated analysis of large embedded software systems and enables downstream applications
such as training data generation for systems-aware machine learning models, standards compliance
verification, and large-scale specification coverage analysis.

1

Introduction

Modern systems engineering faces a critical challenge in establishing precise mapping between embedded
systems datasheets and their code implementations. This problem is particularly acute in embedded
systems, IoT devices, and standards-compliant implementations where understanding the relationship
between datasheet specifications and actual code becomes essential for maintenance, verification, and
development processes. The complexity of this challenge has grown significantly as embedded systems
become more sophisticated and datasheet documents become more detailed.
Consider a typical embedded systems project implementing communication protocols from hardware
datasheets. The datasheet specification may contain hundreds of sections describing protocols, interfaces,
data structures, and behavioral requirements. The corresponding implementation spans thousands of files

---

## 24. 34-Cascade Detecting Inconsistencies between Code and Documentation

**Arquivo:** 

**Abstract:**
**[Abstract não encontrado no PDF]**

---

## 25. 35-CCISolver End-to-End Detection and Repair of Code-Comment Inconsistency

**Arquivo:** 

**Abstract:**
Abstract— Comments within code serve as a crucial foundation for
software documentation, facilitating developers to communicate and
understand the code effectively. However, code-comment inconsistency
(CCI) can negatively affect software development, testing, and maintenance. Recent efforts to mitigate this issue have emerged, but existing
studies often suffer from inaccurate datasets and inadequate solutions,
weakening their practical effectiveness. In this study, we first conduct a
quantitative analysis of existing datasets, revealing a substantial portion
of sampled data are mislabeled. To address these data limitations, we
introduce CCIB ENCH, a refined dataset comprising high-quality data,
to support the training and evaluation of method-level CCI methods.
Furthermore, we present an innovative end-to-end LLM-based framework, CCIS OLVER, designed to improve code quality by identifying and
rectifying CCIs. Comprehensive evaluations demonstrate CCIS OLVER’s
superior performance. For detection, it establishes a new state-of-theart with an F1-score of 89.54%. In fixing task, it achieves a remarkable
18.84% relative improvement in GLEU score over the strongest baseline. This superiority is confirmed by human evaluation, where CCIS OLVER’s fixing success rate of 0.6533 significantly surpasses existing

---

## 26. 36-Larger Is Not Always Better Leveraging Structured Code Diffs for Comment Inconsistency

**Arquivo:** 

**Abstract:**
Abstract—Ensuring semantic consistency between source code
and its accompanying comments is crucial for program comprehension, effective debugging, and long-term maintainability.
Comment inconsistency arises when developers modify code
but neglect to update the corresponding comments, potentially
misleading future maintainers and introducing errors. Recent
approaches to code–comment inconsistency (CCI) detection leverage Large Language Models (LLMs) and rely on capturing
the semantic relationship between code changes and outdated
comments. However, they often ignore the structural complexity
of code evolution, including historical change activities, and
introduce privacy and resource challenges. In this paper, we
propose a Just-In-Time CCI detection approach built upon the
CodeT5+ backbone. Our method decomposes code changes into
ordered sequences of modification activities such as replacing,
deleting, and adding to more effectively capture the correlation
between these changes and the corresponding outdated comments. Extensive experiments conducted on publicly available
benchmark datasets–JITDATA and CCIBENCH–demonstrate that
our proposed approach outperforms recent state-of-the-art models by up to 13.54% in F1-Score and achieves an improvement
ranging from 4.18% to 10.94% over fine-tuned LLMs including
DeepSeek-Coder, CodeLlama and Qwen2.5-Coder.
Index Terms—code comment inconsistency, large language
models, code change, code evolution.

I. I NTRODUCTION
Code comments are essential documentation artifacts in
software development, enabling developers to communicate
a program’s functionality, design rationale, and intended usage [1]. Well-maintained comments have been shown to enhance developers’ comprehension of complex systems and
facilitate more efficient software maintenance.However, as
software systems evolve through continuous modifications and
feature extensions, developers often fail to update corresponding comments, leading to code–comment inconsistency (CCI),
where comments no longer align with the underlying implementation [2]–[4]. Such inconsistencies can mislead future

---

## 27. 37-Deep Just-In-Time Inconsistency Detection Between Comments and Source Code

**Arquivo:** 

**Abstract:**
Abstract

rameter constraints (Zhou et al. 2017), null values and
exceptions (Tan et al. 2012), locking (Tan et al. 2007),
interrupts (Tan, Zhou, and Padioleau 2011)). Some have
also addressed the notion of coherence between comments
and code as a text similarity problem with traditional machine learning models that leverage bag-of-words techniques (Corazza, Maggio, and Scanniello 2018; Cimasa
et al. 2019). In contrast, we design an approach that generalizes across types of inconsistencies and captures deeper
comment/code relationships. Furthermore, prior research
has predominantly focused on detecting inconsistencies that
already reside in a software project, within the code repository. We refer to this as post hoc inconsistency detection
since it occurs potentially many commits after the inconsistency has been introduced.
Ideally, these inconsistencies should be detected before
they ever enter the repository (e.g., during code review)
since they pose a threat to the development cycle and reliability of the software until they are found. Because inconsistent comments generally arise as a consequence of developers failing to update comments immediately following
code changes (Wen et al. 2019), we aim to detect whether a
comment becomes inconsistent as a result of changes to the
accompanying code, before these changes are merged into a
code base. We refer to this as just-in-time inconsistency detection, as it allows catching potential inconsistencies right
before they can materialize.
Detecting inconsistencies immediately following code
changes allows us to utilize information from the version
of the code before the changes, for which the comment is
consistent. By considering how the changes affect the relationship the comment holds with the code, we can determine
whether the comment remains consistent after the changes.
For instance, in Figure 1(a), the comment describes the return type of nodeIds() as an array. When the method is
modified to return a Set instead of an array, the comment no
longer describes the correct return type, making it inconsistent. Such analysis is not possible in post hoc inconsistency
detection since the exact code changes that triggered inconsistency cannot be easily pinpointed, making it difficult to
align the comment with relevant parts of the code.

---

## 28. 38-Deep Learning Based Identification of Inconsistent Method Names

**Arquivo:** 

**Abstract:**
Abstract For any software system, concise and meaningful method names
are critical for program comprehension and maintenance. However, for various
reasons, the method names might be inconsistent with their corresponding implementations. Such inconsistent method names are confusing and misleading,
often resulting in incorrect method invocations. To this end, a few intelligent
deep learning-based approaches based on neural networks have been proposed
to identify such inconsistent method names in the industry. Existing evaluations suggest that the performance of such DL-based approaches is promising.
However, the evaluations are conducted with a perfectly balanced dataset
where the number of inconsistent method names is exactly equivalent to that of
consistent ones. In addition, the construction method of this balanced dataset
is flawed, leading to false positives in this dataset. Consequently, the reported
performance may not represent their efficiency in the field where most method
names are consistent with their corresponding method bodies and only a small
part of method names are inconsistent with corresponding method bodies. To
this end, in this paper, we conduct an empirical study to assess the state-ofthe-art DL-based approaches in the automated identification of inconsistent
method names. We first build a new benchmark (dataset) by using both automatic identification from commit history and manual inspection by developers,
aiming to reduce the number of false positives. Based on the benchmark, we
evaluate five representative DL-based approaches to identifying inconsistent
Yuxia Zhang
E-mail: yuxiazh@bit.edu.cn
Hui Liu
E-mail: liuhui08@bit.edu.cn
1 School of Computer Science & Technology, Beijing Institute of Technology, Beijing, China. E-mail: wangtaiming@bit.edu.cn, yuxiazh@bit.edu.cn, liuhui08@bit.edu.cn
2 China Telecom Corporation Limited Beijing Research Institute, Beijing, China. E-mail:
jiangl34@chinatelecom.cn
3 Academy of Military Science of the People’s Liberation Army National Innovation Institute
of Defense Technology, Beijing, China. E-mail: xtangee@hotmail.com, liguangjie er@126.com

2

Taiming Wang 1 et al.

---

## 29. 39-DeepBugs A Learning Approach to Name-based Bug Detection

**Arquivo:** 

**Abstract:**
**[Abstract não encontrado no PDF]**

---

## 30. 3-Report from MDE practice An interview-based evaluation

**Arquivo:** 

**Abstract:**
Abstract

OPEN ACCESS
Citation: Alfraihi H, Lano K (2025) Report
from MDE practice: An interview-based
evaluation of model-driven engineering
uses. PLoS One 20(11): e0335461.
https://doi.org/10.1371/journal.pone.
0335461

In this study, we investigate the usability of Model-Driven Engineering (MDE) through
interviews with fifteen practitioners from diverse roles (e.g., developers, researchers,
architects) and domains, and with a range of expertise levels across academic and
industrial software sectors, capturing in-depth perspectives on its practical application. Participants emphasized MDE’s benefits in enhancing project robustness, reliability, development speed, and system organization. However, they also identified
challenges such as a steep learning curve, technological constraints, organizational
resistance, and a shortage of skilled professionals. To address these issues, participants recommended simplifying tools and language, improving consistency and
flexibility, enhancing integration with existing workflows, and raising awareness of
MDE. These insights provide valuable guidance for improving MDE usability and
encouraging broader MDE adoption.

Editor: Muhammad Suhail, Hanshan
Normal University, CHINA
Received: April 4, 2025
Accepted: October 9, 2025

1 Introduction

Published: November 5, 2025

Usability is a paramount consideration in any software engineering methodology, and

---

## 31. 40-Inconsistency detection methods for statecharts and sequence diagrams a systematic literature review

**Arquivo:** 

**Abstract:**
Abstract

Article History:

During model-based systems engineering or software engineering activities, diagrams representing use cases (sequence diagrams) and diagrams representing object behaviors (state
machine diagrams or statecharts) can conflict with each other in what is called an inconsistency.
Detecting these inconsistencies is crucial to check if a given specification is realizable through
the behavior that was conceived to meet it. This paper provides a systematic literature review
of inconsistency detection methods for UML state machine diagrams and sequence diagrams.
The selection process is aided by an open-source machine-learning tool, and resulted in
the qualitative synthesis of 27 works. The included publications offer methods to tackle the
detection of horizontal-semantic behavior inconsistencies.

Received

28 May 2025

Revised

28 June 2025

Accepted

24 July 2025

Available online

23 September 2025

Keywords:

---

## 32. 41-ProtocolGuard Detecting Protocol Non-compliance Bugs via LLM-guided Static Analysis

**Arquivo:** 

**Abstract:**
Abstract—Network protocol implementations are expected
to strictly comply with their specifications to ensure reliable
and secure communications. However, the inherent ambiguity
of natural-language specifications often leads to developers’
misinterpretations, causing protocol implementations to deviate
from standard behaviors. These deviations result in subtle noncompliance bugs that can cause interoperability issues and critical
security vulnerabilities. Unlike memory corruption bugs, these
bugs typically do not exhibit explicit error behaviors, resulting
in existing bug oracles being insufficient to thoroughly detect
them. Moreover, existing works require heavy manual effort to
verify findings and analyze root causes, severely limiting their
scalability in practice.
In this paper, we present ProtocolGuard, a novel framework
that systematically detects non-compliance bugs by combining
LLM-guided static analysis with fuzzing-based dynamic verification. ProtocolGuard first extracts normative rules from protocol
specifications using a hybrid method, and performs LLM-guided
program slicing to extract code slices relevant to each rule. It then
leverages LLMs to detect semantic inconsistencies between these
rules and code logic, and dynamically verify whether these bugs
can be triggered. To facilitate bug verification, ProtocolGuard
first uses LLMs to automatically generate assertion statements
and instrument the code to turn silent inconsistencies into
observable assertion failures. Then, it produces initial test cases
that are more likely to trigger the bug with the help of LLMs
for dynamic verification. Lastly, ProtocolGuard dynamically tests
the instrumented code to confirm bug identification and generate
proof-of-concept test cases. We implemented a prototype of
ProtocolGuard and evaluated it on 11 widely-used protocol
implementations. ProtocolGuard successfully discovered 158 noncompliance bugs with high accuracy, 70 of which have been confirmed, and the majority of which can be converted into assertions
and dynamically verified. The comparison with existing state-ofthe-art tools demonstrates that ProtocolGuard outperforms them

---

## 33. 42-FindICI Using ML to detect linguistic inconsistencies between code and NL

**Arquivo:** 

**Abstract:**
Abstract
Linguistic anti-patterns are recurring poor practices concerning inconsistencies in the
naming, documentation, and implementation of an entity. They impede the readability,
understandability, and maintainability of source code. This paper attempts to detect linguistic anti-patterns in Infrastructure-as-Code (IaC) scripts used to provision and manage
computing environments. In particular, we consider inconsistencies between the logic/body
of IaC code units and their short text names. To this end, we propose FINDICI a novel automated approach that employs word embedding and classification algorithms. We build and
use the abstract syntax tree of IaC code units to create code embeddings used by machine
learning techniques to detect inconsistent IaC code units. We evaluated our approach with
two experiments on Ansible tasks systematically extracted from open source repositories for
various word embedding models and classification algorithms. Classical machine learning
models and novel deep learning models with different word embedding methods showed
comparable and satisfactory results in detecting inconsistent Ansible tasks related to the
top-10 used Ansible modules.
Keywords Infrastructure as code · Linguistic anti-patterns · Word embedding ·
Machine learning · Deep learning

Communicated by: Foutse Khomh, Gemma Catolino and Pasquale Salza
This article belongs to the Topical Collection: Machine Learning Techniques for Software Quality
Evaluation (MaLTeSQuE)
 Nemania Borovits

n.borovits@tilburguniversity.edu
1

Jheronimus Academy of Data Science, Tilburg University, Tilburg, The Netherlands

2

University of Salerno, Salerno, Italy

---

## 34. 43-CodeBLEU a Method for Automatic Evaluation of Code Synthesis

**Arquivo:** 

**Abstract:**
Abstract

Evaluation metrics play a vital role in the growth of an area
as it defines the standard of distinguishing between good and
bad models. In the area of code synthesis, the commonly used
evaluation metric is BLEU or perfect accuracy, but they are
not suitable enough to evaluate codes, because BLEU is originally designed to evaluate natural language, neglecting important syntactic and semantic features of codes, and perfect
accuracy is too strict thus it underestimates different outputs
with the same semantic logic. To remedy this, we introduce a
new automatic evaluation metric, dubbed CodeBLEU. It absorbs the strength of BLEU in the n-gram match, and further
injects code syntax via abstract syntax trees (AST) and code
semantics via data-flow. We conduct experiments by evaluating the correlation coefficient between CodeBLEU and quality scores assigned by the programmers on three code synthesis tasks, i.e., text-to-code, code translation, and code refinement. Experimental results show that, our proposed CodeBLEU can achieve a better correlation with programmer assigned scores compared with BLEU and accuracy.

1

Introduction

A suitable evaluation metric is important to push forward
the research of an area, such as BLEU (Papineni et al. 2002)
and ROUGE (Lin 2004) for machine translation and text
summarization. Along with the rapid progress of code synthesis such as text-to-code synthesis, code translation and
code change prediction (Karaivanov, Raychev, and Vechev
2014; Oda et al. 2015; Barone and Sennrich 2017; Chen,
Liu, and Song 2018; Kanade et al. 2019; Husain et al. 2019;
Feng et al. 2020; Dinella et al. 2020; Lachaux et al. 2020),
different automatic evaluation methods for code synthesis
are leveraged, including n-gram accuracy (Karaivanov, Raychev, and Vechev 2014), perfect accuracy (Chen, Liu, and
Song 2018), and computational accuracy (Lachaux et al.
2020). The n-gram accuracy (e.g. 4-gram BLEU) is the most
popular evaluation method for code synthesis (Karaivanov,

---

## 35. 44-CrystalBLEU Precisely and Efficiently Measuring the Similarity of Code

**Arquivo:** 

**Abstract:**
ABSTRACT
Recent years have brought a surge of work on predicting pieces
of source code, e.g., for code completion, code migration, program
repair, or translating natural language into code. All this work faces
the challenge of evaluating the quality of a prediction w.r.t. some
oracle, typically in the form of a reference solution. A common
evaluation metric is the BLEU score, an n-gram-based metric originally proposed for evaluating natural language translation, but
adopted in software engineering because it can be easily computed
on any programming language and enables automated evaluation at
scale. However, a key difference between natural and programming
languages is that in the latter, completely unrelated pieces of code
may have many common n-grams simply because of the syntactic
verbosity and coding conventions of programming languages. We
observe that these trivially shared n-grams hamper the ability of
the metric to distinguish between truly similar code examples and
code examples that are merely written in the same language. This
paper presents CrystalBLEU, an evaluation metric based on BLEU,
that allows for precisely and efficiently measuring the similarity of
code. Our metric preserves the desirable properties of BLEU, such
as being language-agnostic, able to handle incomplete or partially
incorrect code, and efficient, while reducing the noise caused by

---

## 36. 45-CodeScore Evaluating Code Generation by Learning Code Executio

**Arquivo:** 

**Abstract:**
Abstract
A proper code evaluation metric (CEM) profoundly impacts the evolution of code
generation, which is an important research field in NLP and software engineering.
Prevailing match-based CEMs (e.g., BLEU, Accuracy, and CodeBLEU) suffer
from two significant drawbacks. 1. They primarily measure the surface differences between codes without considering their functional equivalence. However,
functional equivalence is pivotal in evaluating the effectiveness of code generation,
as different codes can perform identical operations. 2. They are predominantly
designed for the Ref-only input format. However, code evaluation necessitates
versatility in input formats. Aside from Ref-only, there are NL-only and Ref&NL
formats, which existing match-based CEMs cannot effectively accommodate. In
this paper, we propose CodeScore, a large language model (LLM)-based CEM,
which estimates the functional correctness of generated code on three input types.
To acquire CodeScore, we present UniCE, a unified code generation learning framework, for LLMs to learn code execution (i.e., learning PassRatio and Executability
of generated code) with unified input. Extensive experimental results on multiple
code evaluation datasets demonstrate that CodeScore absolutely improves up to
58.87% correlation with functional correctness compared to other CEMs, achieves

---

## 37. 46-Out of the BLEU How Should We Assess Quality of Code Generation Models

**Arquivo:** 

**Abstract:**
abstract syntax tree, and as text. For text, CodeBLEU provides two
different submetrics, one of which treats all tokens as being equally
important, and another gives higher weight to the keywords.
2.2.3 Test-based evaluation. The impressive performance of recent

---

## 38. 47-Is Functional Correctness Enough to Evaluate Code Language Models

**Arquivo:** 

**Abstract:**
Abstract
Language models (LMs) have exhibited impressive abilities in generating codes from natural
language requirements. In this work, we highlight the diversity of code generated by LMs as
a critical criterion for evaluating their code generation capabilities, in addition to functional
correctness. Despite its practical implications,
there is a lack of studies focused on assessing
the diversity of generated code, which overlooks its importance in the development of code
LMs. We propose a systematic approach to
evaluate the diversity of generated code, utilizing various metrics for inter-code similarity as
well as functional correctness. Specifically, we
introduce a pairwise code similarity measure
that leverages large LMs’ capabilities in code
understanding and reasoning, demonstrating
the highest correlation with human judgment.
We extensively investigate the impact of various factors on the quality of generated code,
including model sizes, temperatures, training
approaches, prompting strategies, and the difficulty of input problems. Our consistent observation of a positive correlation between the test
pass score and the inter-code similarity score
indicates that current LMs tend to produce functionally correct code with limited diversity.

1

Introduction

Language models (LMs) pre-trained on massivescale code corpora show remarkable performance
in generating codes from natural language requirements. Extensive research has explored various
methods to enhance the functional correctness of
code generated by these models (Austin et al., 2021;
Wang et al., 2022; Chen et al., 2021). As a result,
recent benchmarks assessing the functional correctness of generated code (Ben Allal et al., 2022) show

---

## 39. 48-ACES Leave-One-Out AUC Consistency for Code Generation

**Arquivo:** 

**Abstract:**
**[Abstract não encontrado no PDF]**

---

## 40. 49-R2Code A Self-Reflective LLM Framework for Requirements-to-Code Traceability

**Arquivo:** 

**Abstract:**
Abstract—Accurate requirement-to-code traceability is crucial
for software maintenance. However, existing IR- and embeddingbased methods are heavily dependent on lexical similarity, often
yielding incomplete or inconsistent links across projects and
languages and incurring high cost from long-context retrieval and
prompting. This paper presents R2Code, an LLM-based semantic
traceability framework designed to improve trace link accuracy
while reducing inference cost. R2Code integrates three components: 1) a decomposition-enhanced Bidirectional Alignment
Network (BAN) that aligns four-layer requirement semantics with
corresponding code structures to support cross-level semantic
matching; 2) a Self-Reflective Consistency Verification (SRCV)
module that conducts explanation-guided consistency checking
to calibrate link reliability; and 3) a Dynamic Context-Adaptive
Retrieval (DCAR) mechanism that adjusts retrieval granularity
and filters contexts using semantic-overlap weighting for efficient
context utilization. Experiments on five public datasets spanning
multiple domains and two programming languages demonstrate
that R2Code consistently outperforms the strongest baselines,
achieving an average F1 gain of 7.4%, while reducing token
consumption by up to 41.7% through adaptive context control.
Index Terms—Requirements traceability, LLMs, Semantic
alignment, Self-reflection, Context-adaptive retrieval.

I. I NTRODUCTION
Requirements-to-Code Traceability maintains explicit links
among heterogeneous software artifacts such as requirements,
design documents, source code, and test cases [1]. It links
high-level, free-text documentation (e.g., requirements and
design documents) to the source code elements that implement
those requirements [2]. Such links support change impact
analysis and program comprehension, and they influence the

---

## 41. 4-Quality in model-driven engineering a tertiary study

**Arquivo:** 

**Abstract:**
Abstract Context: Model-Driven Engineering (MDE) is believed to have a signiﬁcant impact in software quality. However, researchers and practitioners may
have a hard time locating consolidated evidence on this impact, as the available
information is scattered in several diﬀerent publications.
Objective: Our goal is to aggregate consolidated ﬁndings on quality in MDE, facilitating the work of researchers and practitioners in learning about the coverage and
main ﬁndings of existing work as well as identifying relatively unexplored niches
of research that need further attention.
Method: We performed a tertiary study on quality in MDE, in order to gain a
better understanding of its most prominent ﬁndings and existing challenges, as
reported in the literature.
Results: We identiﬁed 22 systematic literature reviews and mapping studies and
the most relevant quality attributes addressed by each of those studies, in the
context of MDE. Maintainability is clearly the most often studied and reported
quality attribute impacted by MDE. 80 out of 83 research questions in the selected
secondary studies have a structure that is more often associated with mapping
Miguel Goulão
NOVA LINCS, Departamento de Informática
Universidade Nova de Lisboa
Tel.: +351-21-2948536
Fax: +351-21-2948541
E-mail: mgoul@fct.unl.pt
Vasco Amaral
NOVA LINCS, Departamento de Informática
Universidade Nova de Lisboa
Tel.: +351 212948536
Fax: +351 212948541
E-mail: vma@fct.unl.pt
Marjan Mernik
Faculty of Electrical Engineering and Computer Science
University of Maribor
Tel.: +386 22207455

---

## 42. 50-ReqToCode Embedding Requirements Traceability

**Arquivo:** 

**Abstract:**
Abstract
Requirements traceability in safety-critical software development remains
largely dependent on external documentation maintained separately from the
systems it describes. This separation introduces structural fragility: traces
degrade silently as requirements, code, and tests evolve independently across
tools, repositories, and revisions. Recent advances in LLM-based traceability
focus on recovering broken links after the fact — an inherently retrospective
approach. This paper introduces ReqToCode, an approach that prevents
trace degradation by embedding traceable system elements directly into the
codebase, making traceability a compile-time verifiable property of the system
rather than an external documentation task. Central to the approach is the
concept of the Traceable — a language-native, generated code element that
represents a single requirement and carries its metadata. Developers reference
Traceables in implementation and test code, creating hard, bidirectional links
that are validated automatically during the build process. When requirements
change, the system responds through a graduated lifecycle — from deprecation
warnings to build failures — providing teams with actionable signals rather
than abrupt breakage. We describe the approach, its architectural principles,
the Traceable lifecycle, and illustrate it with a generic example spanning
requirement definition, artifact generation, code integration, and build-time
validation.
Keywords: requirements traceability, safety-critical software, compile-time
verification, code generation, bidirectional traceability, regulated industries

1. Introduction

---

## 43. 51-A GraphRAG-Based Framework for Requirement-Code Traceability

**Arquivo:** 

**Abstract:**
Abstract
Requirement-Code Traceability Link Recovery (RC-TLR) maps requirements to the code
artifacts that implement them. The task remains difficult because requirements and source
code use different vocabularies and expose different structural cues. Recent large language model (LLM) methods can improve trace-link classification, but the final decision
still depends on which candidate artifacts reach the validator. We propose DSDR, a
Graph Retrieval-Augmented Generation (GraphRAG)-based dual-path structural diffusion
framework for zero-shot RC-TLR. DSDR uses pre-trained embedding models and LLMs
without project-specific trace supervision. It builds three-layer heterogeneous graphs for
requirements and code, links requirement entities to code identifiers through cross-modal
semantic alignment, and ranks candidate classes with semantic-gated forward diffusion
and backward verification. The same diffusion states are backtracked into evidence paths
for LLM-based structural validation. On five benchmark datasets, retrieval-only DSDR
raises recall over the strongest evaluated RAG-style retrieval baseline on all five tasks and
gives the top retrieval-only result on four tasks in this comparison. With GPT-4o validation,
DSDR yields a trace-link set with higher precision than the strongest evaluated LLM-based
baseline in the same evaluation setup, while the recall–precision balance varies by project.
The comparison suggests that structural evidence is useful for zero-shot RC-TLR retrieval
and for precision-oriented validation.
Keywords: traceability link recovery; retrieval-augmented generation; information
retrieval; large language models; software engineering

1. Introduction

---

## 44. 52-Establishing Traceability between NL Requirements and Software Artifacts using RAG+LLM

**Arquivo:** 

**Abstract:**
Abstract. Software Engineering aims to effectively translate stakeholders’ requirements into executable code to fulfill their needs. Traceability
from natural language use case requirements to classes in a UML class
diagram, subsequently translated into code implementation, is essential
in systems development and maintenance. Tasks such as assessing the
impact of changes and enhancing software reusability require a clear link
between these requirements and their software implementation. However, establishing such links manually across extensive codebases is prohibitively challenging. Requirements, typically articulated in natural language, embody semantics that clarify the purpose of the codebase. Conventional traceability methods, relying on textual similarities between requirements and code, often suffer from low precision due to the semantic
gap between high-level natural language requirements and the syntactic
nature of code. The advent of Large Language Models (LLMs) provides
new methods to address this challenge through their advanced capability to interpret both natural language and code syntax. Furthermore,
representing code as a knowledge graph facilitates the use of graph structural information to enhance traceability links. This paper introduces an
LLM-supported retrieval augmented generation approach for enhancing
requirements traceability to the class diagram of the code, incorporating
keyword, vector, and graph indexing techniques, and their integrated application. We present a comparative analysis against conventional methods and among different indexing strategies and parameterizations on
the performance. Our results demonstrate how this methodology significantly improves the efficiency and accuracy of establishing traceability
links in software development processes.

Keywords: Large Language Models · LLM · Requirements Traceability · Retrieval Augmented Generation · Requirements Engineering

1

Introduction

Traceability information is a fundamental prerequisite for many essential software maintenance and evolution tasks, such as change impact and software

2

S.J. Ali et al.

Fig. 1: Requirements to Code Traceability-based UML Classes Evolution
reusability analyses. Traceability can also help validate that the right system

---

## 45. 53-Guidelines for Empirical Studies in SE involving Large Language Models

**Arquivo:** 

**Abstract:**
Abstract Large Language Models (LLMs) are widely used in software engineering (SE) research and practice, yet their non-determinism, opaque training
data, and rapidly evolving models threaten the reproducibility and replicability
of empirical studies. We address this challenge through a collaborative effort
of 22 researchers, presenting a taxonomy of seven study types that organizes
how LLMs are used in SE research, together with eight guidelines for designing and reporting such studies. Each guideline distinguishes requirements
(must) from recommended practices (should) and is contextualized by the
study types it applies to. Our guidelines recommend that researchers: (1) declare LLM usage and role; (2) report model versions, configurations, and customizations; (3) document the tool architecture beyond the model; (4) disclose
University of Rome Tor Vergata, Italy
E-mail: falessi@ing.uniroma2.it
Brian Fitzgerald
Lero, Ireland
University of Limerick, Ireland
E-mail: brian.fitzgerald@ul.ie
Davide Fucci
Blekinge Institute of Technology, Sweden
E-mail: davide.fucci@bth.se
Junda He · Christoph Treude
Singapore Management University, Singapore
E-mail: {jundahe, ctreude}@smu.edu.sg
Marcos Kalinowski
PUC Rio de Janeiro, Brazil
E-mail: kalinowski@inf.puc-rio.br
Stefano Lambiase · Daniel Russo
Aalborg University in Copenhagen, Denmark
E-mail: {stla, daniel.russo}@cs.aau.dk
Mircea Lungu
IT University of Copenhagen, Denmark
E-mail: mlun@itu.dk
Cristina Martinez Montes
Chalmers University of Technology, Sweden

---

## 46. 54-Breaking the Silence the Threats of Using LLMs in Software Engineering

**Arquivo:** 

**Abstract:**
Abstract
Large Language Models (LLMs) have gained considerable traction
within the Software Engineering (SE) community, impacting various SE tasks from code completion to test generation, from program
repair to code summarization. Despite their promise, researchers
must still be careful as numerous intricate factors can influence the
outcomes of experiments involving LLMs. This paper initiates an
open discussion on potential threats to the validity of LLM-based
research including issues such as closed-source models, possible
data leakage between LLM training data and research evaluation,
and the reproducibility of LLM-based findings. In response, this
paper proposes a set of guidelines tailored for SE researchers and
Language Model (LM) providers to mitigate these concerns. The
implications of the guidelines are illustrated using existing good
practices followed by LLM providers and a practical example for
SE researchers in the context of test case generation.

CCS Concepts
• Software and its engineering → Empirical software validation; • Computing methodologies → Machine learning; •
General and reference → Evaluation.
ACM Reference Format:
June Sallou, Thomas Durieux, and Annibale Panichella. 2024. Breaking the
Silence: the Threats of Using LLMs in Software Engineering. In Proceedings
of the 46th International Conference on Software Engineering (ICSE ’24). ACM,
New York, NY, USA, 5 pages.

1

Introduction

In recent years, the utilization of Large Language Models (LLMs) has

---

## 47. 55-Large Language Models for SE A Reproducibility Crisis

**Arquivo:** 

**Abstract:**
Abstract
Reproducibility is a cornerstone of scientific progress, yet its state in large language model (LLM)-based software engineering (SE) research remains poorly
understood. This paper presents the first large-scale, empirical study of reproducibility practices in LLM-for-SE research. We systematically mined and
analyzed 640 papers published between 2020 and 2025 across premier software
engineering, machine learning, and natural language processing venues, extracting structured metadata from publications, repositories, and documentation.
Guided by four research questions, we examine (i) the prevalence of reproducibility smells, (ii) how reproducibility has evolved over time, (iii) whether artifact
evaluation badges reliably reflect reproducibility quality, and (iv) how publication
venues influence transparency practices. Using a taxonomy of seven smell categories: Code and Execution, Data, Documentation, Environment and
Tooling , Versioning , Model , and Access and Legal , we manually annotated all papers and associated artifacts. Our analysis reveals persistent gaps
in artifact availability, environment specification, versioning rigor, and documentation clarity, despite modest improvements in recent years and increased
adoption of artifact evaluation processes at top SE venues. Notably, we find that
badges often signal artifact presence but do not consistently guarantee execution fidelity or long-term reproducibility. Motivated by these findings, we provide
actionable recommendations to mitigate reproducibility smells and introduce a

1

Reproducibility Maturity Model (RMM) to move beyond binary artifact
certification toward multi-dimensional, progressive evaluation of reproducibility
rigor.
Keywords: Large Language Models (LLMs), Software Reproducibility,
Reproducibility Smell, Artifact Evaluation, Reproducibility Maturity Model

1 Introduction
Reproducibility is a core part of scientific inquiry, enabling independent verification
and extension of research findings [1, 2]. In software engineering (SE) research, reproducibility enables independent verification of results, speeds up cumulative knowledge
building, and prompts trust in empirical evidence [3]. However, despite its importance, reproducibility remains a persistent challenge in modern machine learning
(ML) and natural language processing (NLP) research [4, 5]. This challenge is further exacerbated in the context of large language models (LLMs), where rapidly
evolving frameworks, model dependencies, and legal or access restrictions can limit
experimental replicability [6, 7].
The integration of LLMs into SE workflows, ranging from code generation and bug

---

## 48. 56-Reflections on the Reproducibility of Commercial LLM Performance

**Arquivo:** 

**Abstract:**
Abstract

CCS Concepts

Large Language Models have gained remarkable interest in industry and academia. The increasing interest in LLMs in academia is
also reflected in the number of publications on this topic over the
last years. For instance, alone 78 of the around 425 publications at
ICSE 2024 performed experiments with LLMs. Conducting empirical studies with LLMs remains challenging and raises questions
on how to achieve reproducible results, for both researchers and
practitioners. One important step towards excelling in empirical
research on LLM and their application is to first understand to
what extent current research results are eventually reproducible
and what factors may impede reproducibility. This investigation is
within the scope of our work.
We contribute an analysis of the reproducibility of LLM-centric
studies, provide insights into the factors impeding reproducibility,
and discuss suggestions on how to improve the current state. In
particular, we studied the 85 articles describing LLM-centric studies,
published at ICSE 2024 and ASE 2024. Of the 85 articles, 18 provided
research artefacts and used OpenAI models. We attempted to replicate those 18 studies. Of the 18 studies, only five were sufficiently
complete and executable. For none of the five studies, we were able
to fully reproduce the results. Two studies seemed to be partially
reproducible, and three studies did not seem to be reproducible.
Our results highlight not only the need for stricter research artefact
evaluations but also for more robust study designs to ensure the
reproducible value of future publications.

• General and reference → Empirical studies; • Software and
its engineering; • Computing methodologies → Artificial intelligence;

---

## 49. 57-Non-Determinism of “Deterministic” LLM System Settings

**Arquivo:** 

**Abstract:**
Abstract
LLM (large language model) users of hosted
providers commonly notice that outputs can
vary for the same inputs under settings expected
to be deterministic. While it is difficult to
get exact statistics, recent reports on specialty
news sites and discussion boards suggest that
among users in all communities, the majority
of LLM usage today is through cloud-based
APIs. Yet the questions of how pervasive nondeterminism is, and how much it affects performance results, have not to our knowledge been
systematically investigated. We apply five APIbased LLMs configured to be deterministic to
eight diverse tasks across 10 runs. Experiments
reveal accuracy variations of up to 15% across
runs, with a gap of up to 70% between best possible performance and worst possible performance. No LLM consistently delivers the same
outputs or accuracies, regardless of task. We
speculate about the sources of non-determinism
such as input buffer packing across multiple
jobs. To better quantify our observations, we
introduce metrics focused on quantifying determinism, TARr@N for the total agreement
rate at N runs over raw output, and TARa@N
for total agreement rate of parsed-out answers.
Our code and data will be publicly available at
https://github.com/breckbaldwin/llm-stability.

1

Introduction

Large Language Models (LLM) perform well on
many types of Natural Language Processing (NLP)

---

## 50. 58-Reporting LLM Prompting in Automated SE A Guideline

**Arquivo:** 

**Abstract:**
Abstract
Large Language Models, particularly decoder-only generative models such as GPT, are increasingly used to automate Software Engineering tasks. These models are primarily guided through natural
language prompts, making prompt engineering a critical factor in
system performance and behavior. Despite their growing role in
SE research, prompt-related decisions are rarely documented in a
systematic or transparent manner, hindering reproducibility and
comparability across studies. To address this gap, we conducted a
two-phase empirical study. First, we analyzed nearly 300 papers
published at the top-3 SE conferences since 2022 to assess how
prompt design, testing, and optimization are currently reported.
Second, we surveyed 105 program committee members from these
conferences to capture their expectations for prompt reporting in
LLM-driven research. Based on the findings, we derived a structured
guideline that distinguishes essential, desirable, and exceptional
reporting elements. Our results reveal significant misalignment
between current practices and reviewer expectations, particularly
regarding version disclosure, prompt justification, and threats to
validity. We present our guideline as a step toward improving transparency, reproducibility, and methodological rigor in LLM-based
SE research.

CCS Concepts
• Software and its engineering; • General and reference →
Computing standards, RFCs and guidelines; Surveys and overviews;

Permission to make digital or hard copies of all or part of this work for personal or
classroom use is granted without fee provided that copies are not made or distributed
for profit or commercial advantage and that copies bear this notice and the full citation
on the first page. Copyrights for components of this work owned by others than the
author(s) must be honored. Abstracting with credit is permitted. To copy otherwise, or
republish, to post on servers or to redistribute to lists, requires prior specific permission

---

## 51. 59-Human Evaluation of Large Language Models A Review and Protocol

**Arquivo:** 

**Abstract:**
Abstract
Evaluating large language models (LLMs) critically depends on human judgment. This
article reviews and develops a conceptual framework for human-centered LLM evaluation,
synthesizing research across evaluation methodology, psychometrics, cognitive science, and
domain-specific applications. Four primary challenges are identified that limit current human evaluation practice: imperfect gold standards, evaluator fatigue and overload, shared
and unique bias structures across humans and LLM judges, and the routine omission of
uncertainty and dispersion estimates. To address these gaps, the STEP-V design framework
is proposed: Stakes, Task-type, Evaluator availability, Purpose, and Volume, for selecting
human and/or automated LLM evaluation methods under real-world constraints. An
evaluator failure mode taxonomy is also proposed that analyzes human and LLM judges
within a common error framework, clarifying where hybrid pipelines can compensate for
weaknesses and where they might compound them. The framework motivates a more
rigorous science of LLM evaluation, one that treats human judgment as a necessary but
fallible measurement requiring explicit design, calibration, and uncertainty quantification.
Keywords: large language models; human evaluation; LLM-as-judge; psychometrics;
inter-rater reliability; methods; measurement validity; evaluation design

1. Introduction

---

## 52. 60-Can LLMs replace Human Evaluators An Empirical Study of LLM-as-a-Judge

**Arquivo:** 

**Abstract:**
Abstracting with credit is permitted. To copy otherwise, or republish, to post on servers or to redistribute to lists, requires
prior specific permission and/or a fee. Request permissions from permissions@acm.org.
ISSTA ’25, June 25–28, 2025, Trondheim, Norway
© 2025 Copyright held by the owner/author(s). Publication rights licensed to ACM.
ACM ISBN 978-1-4503-XXXX-X/18/06. . . $15.00
https://doi.org/XXXXXXX.XXXXXXX
1

ISSTA ’25, June 25–28, 2025, Trondheim, Norway

1

Wang et al.

INTRODUCTION

Since BERT [6] and GPT [36], pre-trained language models (PLMs) have been widely used in various
natural language processing (NLP) tasks, such as machine translation and text summarization. With
the scaling of PLM parameters, the concept of large language models (LLMs) has been proposed.
Featuring up to hundreds of billions of parameters, LLMs emerge new capabilities absent on smaller
models [49], beyond solving simple linguistic tasks. These capabilities include, but not limited
to, instruction following and multi-step reasoning, enabling LLMs to simulate human experts
and achieve state-of-the-art performance in certain domains. Software engineering (SE) is one
of the specialized domains that benefits from this trend. Many researchers and companies either
emphasize their LLMs’ strong coding performance [33, 37], or develop specialized code LLMs. For
instance, DeepSeek-Coder-V2 [5] correctly generates code for 75.3% instructions in HumanEval [4]
and MBPP [1] with 236B parameters, second only to GPT-4o. Qwen2.5-Coder [18] achieves 88.4%
Pass@1 on HumanEval with merely 7B parameters.
However, there has been limited progress in evaluating LLM-generated content for SE. The
commonly used Pass@𝑘 metric executes the first 𝑘 generated code snippets on human-curated

---

## 53. 61-Comparing Human and LLM Generated Code The Jury is Still Out

**Arquivo:** 

**Abstract:**
Abstract—Much is promised in relation to AI-supported
software development. However, there has been limited
evaluation effort in the research domain aimed at validating
the true utility of such techniques, especially when compared to
human coding outputs. We bridge this gap, where a benchmark
dataset comprising 72 distinct software engineering tasks is used
to compare the effectiveness of large language models (LLMs)
and human programmers in producing Python software code.
GPT-4 is used as a representative LLM, where for the code
generated by humans and this LLM, we evaluate code quality
and adherence to Python coding standards, code security and
vulnerabilities, code complexity and functional correctness. We
use various static analysis benchmarks, including Pylint, Radon,
Bandit and test cases. Among the notable outcomes, results
show that human-generated code recorded higher ratings for
adhering to coding standards than GPT-4. We observe security
flaws in code generated by both humans and GPT-4, however,
code generated by humans shows a greater variety of problems,
but GPT-4 code included more severe outliers. Our results show
that although GPT-4 is capable of producing coding solutions,
it frequently produces more complex code that may need more
reworking to ensure maintainability. On the contrary however,
our outcomes show that a higher number of test cases passed
for code generated by GPT-4 across a range of tasks than code
that was generated by humans. That said, GPT-4 frequently
struggles with complex problem-solving that involve in-depth
domain knowledge. This study highlights the potential utility
of LLMs for supporting software development, however, tasks
requiring comprehensive, innovative or unconventional solutions,
and careful debugging and error correction seem to be better

---

## 54. 62-A Tool for Supporting Round-Trip Engineering with Ability to Avoid Unintended Design Changes

**Arquivo:** 

**Abstract:**
Abstract:

It is difficult to maintain consistency between artifacts in a round-trip engineering project, such as an agile
development method. In such software development projects, there is a method using traceability links as a
method for maintaining consistency between artifacts. A method for creating traceability links from design
artifacts to programs has been proposed in the past. However, few studies have proposed traceability links
from source code to UML artifacts. Round-trip engineering could involve the developer making changes to
the source code and applying those changes to the UML artifacts. The larger the system, the more difficult it
becomes to apply changes to the UML artifact. We believe that traceability from the program to UML artifacts
effectively addresses this problem. In this paper, we propose a traceability link method for programs to design
artifacts, develop a tool for supporting the method, evaluate its effectiveness, and identify the difficulties for
developers in manually modifying class diagrams.

1

INTRODUCTION

In recent years, agile development methods, e.g.
Scrum (Schwaber, 1995) are widely used to produce
software products in a short period. These methods
are expected to be utilized to reduce discrepancies in
perceptions with clients regarding artifacts. To use
these techniques, it is necessary to develop the software by repeatedly going between design and coding
(round-trip engineering) (Sendall and Küster, 2004).
For example, suppose that a developer creates a prototype of a program based on a design document and
presents it to a customer. The customer requests improvements, which the developers then reflect on the
design documents and programs. The project progresses through a series of iterations. On the other
hand, the repetitive back-and-forth between design
and coding, as described above, may lead to consistency loss and integrity among artifacts. If this situation is left unchecked, the following additional problems may arise.
a

---

## 55. 63-Triple Graph Grammars Concepts, Extensions, Implementations (clássico)

**Arquivo:** 

**Abstract:**
Abstract
Triple Graph Grammars (TGGs) are a technique for defining the
correspondence between two different types of models in a declarative way. The power of TGGs comes from the fact that the relation
between the two models cannot only be defined, but the definition
can be made operational so that one model can be transformed into
the other in either direction; even more, TGGs can be used to synchronize and to maintain the correspondence of the two models,
even if both of them are changed independently of each other; i. e.,
TGGs work incrementally.
TGGs have been introduced more than 10 years ago by Andy Schürr.
Since that time, there have been many different applications of
TGGs for transforming models and for maintaining the correspondence between these models. To date, there have been several modifications, generalizations, extensions, and variations. Moreover,
there are different approaches for implementing the actual transformations and synchronizations of models. In this paper, we present
the essential concepts of TGGs, their spirit, their purpose, and their
fields of application. We also discuss some of the extensions along
with some of the inherent design decisions, as well as their benefits
and caveats. All these are based on several year’s of experience of
using TGGs in different projects in different application areas.

ii

Contents
1 Introduction

1

2 Ideas and Principles
1
2.1 Models and Meta-models . . . . . . . . . . . . . . . . . . . . . . 2

---

## 56. 6-UML consistency rules a systematic mapping study

**Arquivo:** 

**Abstract:**
abstract syntax specified by the meta-model, and requires
that the overall model has to be well formed [26].
Semantic consistency requires that the behavior of
diagrams be semantically compatible [26]. Semantic
consistency applies at one level of abstraction (with
horizontal consistency), at different levels of abstraction
(vertical consistency), and during model evolution
(evolution consistency) [7].
o Observation versus Invocation consistency: Observation
consistency requires that an instance of a subclass behave
like an instance of its superclass, when viewed according

Page 4 of 28

 Manual means that that the UML consistency rules
were not supported by any implemented and
automatic tool.
o What mechanisms were used to specify the rules: e.g.,
plain language, Promela, etc.;
o How the UML consistency rules are checked: e.g., SPIN,
OCL-Checker, etc.;
o Type of research method followed in the paper, for which
we used the following classification [28]:


Evaluation research (ER): this is a paper that
investigates techniques that are implemented in
practice and an evaluation of the technique is
conducted. That means, the paper shows how the
technique is implemented in practice (solution

---

## 57. 7-A systematic identification of consistency rules for UML diagrams

**Arquivo:** 

**Abstract:**
Abstract—UML diagrams describe different views of one piece of software. These diagrams strongly depend on each other and
must therefore be consistent with one another, since inconsistencies between diagrams may be a source of faults during software
development activities that rely on these diagrams. It is therefore paramount that consistency rules be defined and that
inconsistencies be detected, analyzed and fixed. The relevant literature shows that authors typically define their own UML
consistency rules, sometimes defining the same rules and sometimes defining rules that are already in the UML standard. The
reason might be that no consolidated set of rules that are deemed relevant by authors can be found to date. The aim of our
research is to provide a consolidated set of UML consistency rules and obtain a detailed overview of the current research in this
area. We therefore followed a systematic procedure in order to collect and analyze UML consistency rules. We then consolidated
a set of 116 UML consistency rules (avoiding redundant definitions or definitions already in the UML standard) that can be used
as an important reference for UML-based software development activities, for teaching UML-based software development, and
for further research.
Index Terms—Software/Program Verification, Model checking

————————————————————

1

INTRODUCTION

M

ODEL Driven Architecture (MDA) [1] is an approach
to software development by the Object Management
Group (OMG) that promotes the efficient use of models
throughout software development phases, from requirements to analysis, design, implementation, and deployment [2]. Much attention has been paid to MDA by academia and industry in recent years [3], [4], [5], which has
resulted in models gaining more importance in software
development. The Unified Modeling Language (UML) [6]
is the OMG specification that is most frequently used and
is the de-facto standard modeling language for software
modeling and documentation [7]. It is the prefered modeling language for implementing MDA, although it is not intended to be used in every single software development

---

## 58. 8-Event-Driven Inconsistency Detection Between UML Class and Sequence Diagrams

**Arquivo:** 

**Abstract:**
ABSTRACT
Modeling is a central and demanding activity in software engineering that requires skills such as abstraction, consistency maintenance, and precise communication. These skills are difficult to
master and even harder to teach effectively. Educators and students
often struggle to understand and manage inconsistencies that arise
during the modeling process. To address this challenge, we present
Harmony Validator, a tool integrated as a plugin for the Papyrus
modeling environment, designed to automatically detect and report inconsistencies in UML models, including class and sequence
diagrams. The tool adopts an event-driven architecture that continuously monitors modeling actions and notifies users of emerging
inconsistencies in real time. This approach enhances awareness of
model integrity and supports the iterative refinement of design artifacts. The paper describes the architecture, detection mechanisms,
and usage scenarios of Harmony Validator. It also includes a case
study conducted with students in a software engineering course to
evaluate the perceived usefulness and benefits of UML modeling in
teaching and learning. Our results indicate that Harmony Validator
fosters a better understanding of model consistency and promotes
reflective learning practices in software modeling education.

KEYWORDS
Event-driven architecture; EDA; UML models; Model Inconsistencies

1

---

## 59. 9-Detecting Inconsistencies in Multi-view UML Models

**Arquivo:** 

**Abstract:**
ABSTRACT
Inconsistencies in conflicting multi-view UML models can be
major obstacles to the quality and productivity of software
development. In the current literature it can be observed that
some tools were developed to support the detection of
inconsistencies, but none of them are still consolidated. In
addition, many of these tools only evaluate syntactic
inconsistencies, not considering semantic ones. The tools
available are often unable to detect syntactic and semantic
inconsistencies in conflicting multi-view UML models. To
address this issue, we propose DIUML, a tool that includes: (i)
detection of inconsistencies in multi-view UML models
through design metrics; (ii) detection of syntactic and semantic
inconsistencies, indicating objects and classes affected by
them; and (iii) evaluation of the severities of each type of
inconsistency detected. Our preliminary evaluation indicated
that DIUML was able to detect inconsistencies in multi-view
UML models with 337 elements from 10 different
combinations of UML class and sequence diagrams.

Keywords: Inconsistencies Detection, Multi-view UML

---

