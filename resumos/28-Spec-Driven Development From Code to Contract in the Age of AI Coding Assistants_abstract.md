# Abstract do artigo: 28-Spec-Driven Development From Code to Contract in the Age of AI Coding Assistants

**Arquivo original:** 

## Abstract

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
*Extraído em 2026-06-12 23:54:28*
