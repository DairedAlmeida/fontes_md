# Abstract do artigo: 52-Establishing Traceability between NL Requirements and Software Artifacts using RAG+LLM

**Arquivo original:** 

## Abstract

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
*Extraído em 2026-06-12 23:54:40*
