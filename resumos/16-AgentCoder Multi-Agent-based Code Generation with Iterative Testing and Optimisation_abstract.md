# Abstract do artigo: 16-AgentCoder Multi-Agent-based Code Generation with Iterative Testing and Optimisation

**Arquivo original:** 

## Abstract

Abstract
The advancement of natural language processing
(NLP) has been significantly boosted by the development of transformer-based large language models (LLMs). These models have revolutionized
NLP tasks, particularly in code generation, aiding
developers in creating software with enhanced efficiency. Despite their advancements, challenges
in balancing code snippet generation with effective test case generation and execution persist. To
address these issues, this paper introduces MultiAgent Assistant Code Generation (AgentCoder),
a novel solution comprising a multi-agent framework with specialized agents: the programmer
agent, the test designer agent, and the test executor agent. During the coding procedure, the programmer agent will focus on the code generation
and refinement based on the test executor agent’s
feedback. The test designer agent will generate test
cases for the generated code, and the test executor
agent will run the code with the test cases and write
the feedback to the programmer. This collaborative
system ensures robust code generation, surpassing
the limitations of single-agent models and traditional methodologies. Our extensive experiments
on 9 code generation models and 12 enhancement
approaches showcase AgentCoder’s superior performance over existing code generation models
and prompt engineering techniques across various
benchmarks. For example, AgentCoder achieves
77.4% and 89.1% pass@1 in HumanEval-ET and

---
*Extraído em 2026-06-12 23:54:23*
