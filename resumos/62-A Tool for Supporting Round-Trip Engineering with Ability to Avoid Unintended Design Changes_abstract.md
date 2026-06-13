# Abstract do artigo: 62-A Tool for Supporting Round-Trip Engineering with Ability to Avoid Unintended Design Changes

**Arquivo original:** 

## Abstract

Abstract:

It is difficult to maintain consistency between artifacts in a round-trip engineering project, such as an agile
development method. In such software development projects, there is a method using traceability links as a
method for maintaining consistency between artifacts. A method for creating traceability links from design
artifacts to programs has been proposed in the past. However, few studies have proposed traceability links
from source code to UML artifacts. Round-trip engineering could involve the developer making changes to
the source code and applying those changes to the UML artifacts. The larger the system, the more difficult it
becomes to apply changes to the UML artifact. We believe that traceability from the program to UML artifacts
effectively addresses this problem. In this paper, we propose a traceability link method for programs to design
artifacts, develop a tool for supporting the method, evaluate its effectiveness, and identify the difficulties for
developers in manually modifying class diagrams.

1

INTRODUCTION

In recent years, agile development methods, e.g.
Scrum (Schwaber, 1995) are widely used to produce
software products in a short period. These methods
are expected to be utilized to reduce discrepancies in
perceptions with clients regarding artifacts. To use
these techniques, it is necessary to develop the software by repeatedly going between design and coding
(round-trip engineering) (Sendall and Küster, 2004).
For example, suppose that a developer creates a prototype of a program based on a design document and
presents it to a customer. The customer requests improvements, which the developers then reflect on the
design documents and programs. The project progresses through a series of iterations. On the other
hand, the repetitive back-and-forth between design
and coding, as described above, may lead to consistency loss and integrity among artifacts. If this situation is left unchecked, the following additional problems may arise.
a

---
*Extraído em 2026-06-12 23:54:44*
