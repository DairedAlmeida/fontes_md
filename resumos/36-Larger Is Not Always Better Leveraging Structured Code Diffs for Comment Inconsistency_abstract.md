# Abstract do artigo: 36-Larger Is Not Always Better Leveraging Structured Code Diffs for Comment Inconsistency

**Arquivo original:** 

## Abstract

Abstract—Ensuring semantic consistency between source code
and its accompanying comments is crucial for program comprehension, effective debugging, and long-term maintainability.
Comment inconsistency arises when developers modify code
but neglect to update the corresponding comments, potentially
misleading future maintainers and introducing errors. Recent
approaches to code–comment inconsistency (CCI) detection leverage Large Language Models (LLMs) and rely on capturing
the semantic relationship between code changes and outdated
comments. However, they often ignore the structural complexity
of code evolution, including historical change activities, and
introduce privacy and resource challenges. In this paper, we
propose a Just-In-Time CCI detection approach built upon the
CodeT5+ backbone. Our method decomposes code changes into
ordered sequences of modification activities such as replacing,
deleting, and adding to more effectively capture the correlation
between these changes and the corresponding outdated comments. Extensive experiments conducted on publicly available
benchmark datasets–JITDATA and CCIBENCH–demonstrate that
our proposed approach outperforms recent state-of-the-art models by up to 13.54% in F1-Score and achieves an improvement
ranging from 4.18% to 10.94% over fine-tuned LLMs including
DeepSeek-Coder, CodeLlama and Qwen2.5-Coder.
Index Terms—code comment inconsistency, large language
models, code change, code evolution.

I. I NTRODUCTION
Code comments are essential documentation artifacts in
software development, enabling developers to communicate
a program’s functionality, design rationale, and intended usage [1]. Well-maintained comments have been shown to enhance developers’ comprehension of complex systems and
facilitate more efficient software maintenance.However, as
software systems evolve through continuous modifications and
feature extensions, developers often fail to update corresponding comments, leading to code–comment inconsistency (CCI),
where comments no longer align with the underlying implementation [2]–[4]. Such inconsistencies can mislead future

---
*Extraído em 2026-06-12 23:54:31*
