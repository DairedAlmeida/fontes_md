# Abstract do artigo: 51-A GraphRAG-Based Framework for Requirement-Code Traceability

**Arquivo original:** 

## Abstract

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
*Extraído em 2026-06-12 23:54:40*
