# Abstract do artigo: 21-Agyn A Multi-Agent System for Team-Based Autonomous SE

**Arquivo original:** 

## Abstract

Abstract
Large language models have demonstrated strong capabilities in individual software
engineering tasks, yet most autonomous systems still treat issue resolution as a
monolithic or pipeline-based process. In contrast, real-world software development
is organized as a collaborative activity carried out by teams following shared
methodologies, with clear role separation, communication, and review. In this
work, we present a fully automated multi-agent system that explicitly models
software engineering as an organizational process, replicating the structure of an
engineering team. Built on top of AGYN, an open-source platform for configuring
agent teams, our system assigns specialized agents to roles such as coordination,
research, implementation, and review, provides them with isolated sandboxes for
experimentation, and enables structured communication. The system follows a
defined development methodology for working on issues, including analysis, task
specification, pull request creation, and iterative review, and operates without any
human intervention. Importantly, the system was designed for real production use
and was not tuned for SWE-bench. When evaluated post hoc on SWE-bench 500,
it resolves 72.2% of tasks, outperforming single-agent baselines using comparable
language models. Our results suggest that replicating team structure, methodology,
and communication is a powerful paradigm for autonomous software engineering,
and that future progress may depend as much on organizational design and agent
infrastructure as on model improvements.

1

Introduction

Large Language Models (LLMs) have recently demonstrated strong capabilities in software engineering tasks such as code understanding, bug fixing, and test generation. Benchmarks such as
SWE-bench [Jimenez et al., 2024] have emerged as a standard evaluation framework for measuring
progress toward autonomous software engineering agents by requiring systems to resolve real GitHub
issues through patches that pass repository test suites. Despite steady improvements in model quality,

---
*Extraído em 2026-06-12 23:54:25*
