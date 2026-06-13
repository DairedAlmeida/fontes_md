# Abstract do artigo: 12-LiSSA Toward Generic Traceability Link Recovery through RAG

**Arquivo original:** 

## Abstract

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
*Extraído em 2026-06-12 23:54:22*
