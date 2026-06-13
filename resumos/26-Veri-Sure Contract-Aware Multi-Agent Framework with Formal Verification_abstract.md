# Abstract do artigo: 26-Veri-Sure Contract-Aware Multi-Agent Framework with Formal Verification

**Arquivo original:** 

## Abstract

Abstract

bar for productivity and correctness in Electronic Design
Automation (EDA). In practice, the central artifact in the
design flow is the Register-Transfer Level (RTL) description, typically written in Hardware Description Languages
(HDLs) such as Verilog and SystemVerilog, which specifies
clocked state and the combinational logic between registers,
precisely capturing concurrent circuit behavior under strict
timing constraints and enabling downstream synthesis and
implementation. As a result, writing high-quality, synthesizable RTL remains an indispensable yet costly step in
modern chip development.

In the rapidly evolving field of Electronic Design Automation (EDA), the deployment of Large
Language Models (LLMs) for Register-Transfer
Level (RTL) design has emerged as a promising
direction. However, silicon-grade correctness remains bottlenecked by (i) limited test coverage
and reliability of simulation-centric evaluation,
(ii) regressions and repair hallucinations introduced by iterative debugging, and (iii) semantic
drift as intent is reinterpreted across agent handoffs. In this work, we propose V ERI -S URE, a
multi-agent framework that establishes a design
contract to align agents’ intent and uses a patching
mechanism guided by static dependency slicing to
perform precise, localized repairs. By integrating
a multi-branch verification pipeline that combines
trace-driven temporal analysis with formal verification consisting of assertion-based checking and
boolean equivalence proofs, V ERI -S URE enables
functional correctness beyond pure simulations.
We also introduce V ERILOG E VAL - V 2-EXT, extending the original benchmark with 53 more
industrial-grade design tasks and stratified difficulty levels, and show that V ERI -S URE achieves
state-of-the-art verified-correct RTL code generation performance, surpassing standalone LLMs

---
*Extraído em 2026-06-12 23:54:27*
