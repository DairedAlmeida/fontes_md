# Abstract do artigo: 27-TDD Governance for Multi-Agent Code Generation

**Arquivo original:** 

## Abstract

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
*Extraído em 2026-06-12 23:54:28*
