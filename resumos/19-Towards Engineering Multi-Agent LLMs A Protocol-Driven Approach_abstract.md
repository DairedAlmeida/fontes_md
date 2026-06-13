# Abstract do artigo: 19-Towards Engineering Multi-Agent LLMs A Protocol-Driven Approach

**Arquivo original:** 

## Abstract

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
*Extraído em 2026-06-12 23:54:24*
