# Abstract do artigo: 11-A Complete Traceability Methodology Between UML Diagrams and Source Code

**Arquivo original:** 

## Abstract

Abstract: Traceability in software development proves its importance in many domains like change
management, customer's requirements satisfaction, model slicing, etc. Existing traceability techniques
trace either between requirement and design or between requirement and code. However, none of the
existing approaches achieved reliable results when dealing with traceability between requirements,
design models and source code. In this paper, we propose an improvement and an extension of our design
traceability approach in order to tackle the traceability between design, requirement and code. The finetuning of our methodology stems from considering an expanded textual description. A pre-treatment step
is added in order to divide the textual description of system functionalities into different parts, each of
which represents a specific goal. In fact, the extension consists in extracting an expanded textual
description from a natural language text in order to trace between related elements belonging to
requirement, design and code while using an information retrieval technique. The proposed method is
based on different scenarios (nominal, alternatives and errors), particularly on concepts related to control
structures to establish the traceability between artefacts. Furthermore, we implemented our method in a
tool allowing the evaluation of its performance. The evaluation is performed on real existing applications
that consist in comparing results found by our approach with results found by experts. Our method
achieves an average precision of 0.84 and a recall of 0.91 in traceability between requirement, design
and code. Besides its promising performance outcomes, our automated method has the merit of generating
a traceability report describing the correspondence between different artefacts.
Povzetek: Prispevek opisuje novo metodo za sledenje povezavam med UML diagrami in izvirno kodo.

1

Introduction

Traceability quality is defined as the degree to which
existing artefacts of a software development project are
traceable as mandated by the project’s traceability
stakeholders. The Unified Modelling Language (UML) is
used for specifying, constructing, and documenting these
artefacts. It is composed of a set of diagrams grouping
structural and semantic dependencies between UML

---
*Extraído em 2026-06-12 23:54:22*
