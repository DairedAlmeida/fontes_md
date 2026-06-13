# Abstract do artigo: 49-R2Code A Self-Reflective LLM Framework for Requirements-to-Code Traceability

**Arquivo original:** 

## Abstract

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
*Extraído em 2026-06-12 23:54:39*
