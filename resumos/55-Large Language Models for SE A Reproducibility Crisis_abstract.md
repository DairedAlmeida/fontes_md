# Abstract do artigo: 55-Large Language Models for SE A Reproducibility Crisis

**Arquivo original:** 

## Abstract

Abstract
Reproducibility is a cornerstone of scientific progress, yet its state in large language model (LLM)-based software engineering (SE) research remains poorly
understood. This paper presents the first large-scale, empirical study of reproducibility practices in LLM-for-SE research. We systematically mined and
analyzed 640 papers published between 2020 and 2025 across premier software
engineering, machine learning, and natural language processing venues, extracting structured metadata from publications, repositories, and documentation.
Guided by four research questions, we examine (i) the prevalence of reproducibility smells, (ii) how reproducibility has evolved over time, (iii) whether artifact
evaluation badges reliably reflect reproducibility quality, and (iv) how publication
venues influence transparency practices. Using a taxonomy of seven smell categories: Code and Execution, Data, Documentation, Environment and
Tooling , Versioning , Model , and Access and Legal , we manually annotated all papers and associated artifacts. Our analysis reveals persistent gaps
in artifact availability, environment specification, versioning rigor, and documentation clarity, despite modest improvements in recent years and increased
adoption of artifact evaluation processes at top SE venues. Notably, we find that
badges often signal artifact presence but do not consistently guarantee execution fidelity or long-term reproducibility. Motivated by these findings, we provide
actionable recommendations to mitigate reproducibility smells and introduce a

1

Reproducibility Maturity Model (RMM) to move beyond binary artifact
certification toward multi-dimensional, progressive evaluation of reproducibility
rigor.
Keywords: Large Language Models (LLMs), Software Reproducibility,
Reproducibility Smell, Artifact Evaluation, Reproducibility Maturity Model

1 Introduction
Reproducibility is a core part of scientific inquiry, enabling independent verification
and extension of research findings [1, 2]. In software engineering (SE) research, reproducibility enables independent verification of results, speeds up cumulative knowledge
building, and prompts trust in empirical evidence [3]. However, despite its importance, reproducibility remains a persistent challenge in modern machine learning
(ML) and natural language processing (NLP) research [4, 5]. This challenge is further exacerbated in the context of large language models (LLMs), where rapidly
evolving frameworks, model dependencies, and legal or access restrictions can limit
experimental replicability [6, 7].
The integration of LLMs into SE workflows, ranging from code generation and bug

---
*Extraído em 2026-06-12 23:54:42*
