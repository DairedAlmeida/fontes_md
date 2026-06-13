# Abstract do artigo: 50-ReqToCode Embedding Requirements Traceability

**Arquivo original:** 

## Abstract

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
*Extraído em 2026-06-12 23:54:40*
