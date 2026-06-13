# Abstract do artigo: 57-Non-Determinism of “Deterministic” LLM System Settings

**Arquivo original:** 

## Abstract

Abstract
LLM (large language model) users of hosted
providers commonly notice that outputs can
vary for the same inputs under settings expected
to be deterministic. While it is difficult to
get exact statistics, recent reports on specialty
news sites and discussion boards suggest that
among users in all communities, the majority
of LLM usage today is through cloud-based
APIs. Yet the questions of how pervasive nondeterminism is, and how much it affects performance results, have not to our knowledge been
systematically investigated. We apply five APIbased LLMs configured to be deterministic to
eight diverse tasks across 10 runs. Experiments
reveal accuracy variations of up to 15% across
runs, with a gap of up to 70% between best possible performance and worst possible performance. No LLM consistently delivers the same
outputs or accuracies, regardless of task. We
speculate about the sources of non-determinism
such as input buffer packing across multiple
jobs. To better quantify our observations, we
introduce metrics focused on quantifying determinism, TARr@N for the total agreement
rate at N runs over raw output, and TARa@N
for total agreement rate of parsed-out answers.
Our code and data will be publicly available at
https://github.com/breckbaldwin/llm-stability.

1

Introduction

Large Language Models (LLM) perform well on
many types of Natural Language Processing (NLP)

---
*Extraído em 2026-06-12 23:54:43*
