# Abstract do artigo: 33-SpecMap Hierarchical LLM Agent for Datasheet-to-Code Traceability

**Arquivo original:** 

## Abstract

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
*Extraído em 2026-06-12 23:54:30*
