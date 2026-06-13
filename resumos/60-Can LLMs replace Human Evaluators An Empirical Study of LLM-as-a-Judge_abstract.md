# Abstract do artigo: 60-Can LLMs replace Human Evaluators An Empirical Study of LLM-as-a-Judge

**Arquivo original:** 

## Abstract

Abstracting with credit is permitted. To copy otherwise, or republish, to post on servers or to redistribute to lists, requires
prior specific permission and/or a fee. Request permissions from permissions@acm.org.
ISSTA ’25, June 25–28, 2025, Trondheim, Norway
© 2025 Copyright held by the owner/author(s). Publication rights licensed to ACM.
ACM ISBN 978-1-4503-XXXX-X/18/06. . . $15.00
https://doi.org/XXXXXXX.XXXXXXX
1

ISSTA ’25, June 25–28, 2025, Trondheim, Norway

1

Wang et al.

INTRODUCTION

Since BERT [6] and GPT [36], pre-trained language models (PLMs) have been widely used in various
natural language processing (NLP) tasks, such as machine translation and text summarization. With
the scaling of PLM parameters, the concept of large language models (LLMs) has been proposed.
Featuring up to hundreds of billions of parameters, LLMs emerge new capabilities absent on smaller
models [49], beyond solving simple linguistic tasks. These capabilities include, but not limited
to, instruction following and multi-step reasoning, enabling LLMs to simulate human experts
and achieve state-of-the-art performance in certain domains. Software engineering (SE) is one
of the specialized domains that benefits from this trend. Many researchers and companies either
emphasize their LLMs’ strong coding performance [33, 37], or develop specialized code LLMs. For
instance, DeepSeek-Coder-V2 [5] correctly generates code for 75.3% instructions in HumanEval [4]
and MBPP [1] with 236B parameters, second only to GPT-4o. Qwen2.5-Coder [18] achieves 88.4%
Pass@1 on HumanEval with merely 7B parameters.
However, there has been limited progress in evaluating LLM-generated content for SE. The
commonly used Pass@𝑘 metric executes the first 𝑘 generated code snippets on human-curated

---
*Extraído em 2026-06-12 23:54:44*
