# Abstract do artigo: 25-Traceability and Accountability in Role-Specialized Multi-Agent LLM Pipelines

**Arquivo original:** 

## Abstract

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
*Extraído em 2026-06-12 23:54:26*
