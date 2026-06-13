# Abstract do artigo: 43-CodeBLEU a Method for Automatic Evaluation of Code Synthesis

**Arquivo original:** 

## Abstract

Abstract

Evaluation metrics play a vital role in the growth of an area
as it defines the standard of distinguishing between good and
bad models. In the area of code synthesis, the commonly used
evaluation metric is BLEU or perfect accuracy, but they are
not suitable enough to evaluate codes, because BLEU is originally designed to evaluate natural language, neglecting important syntactic and semantic features of codes, and perfect
accuracy is too strict thus it underestimates different outputs
with the same semantic logic. To remedy this, we introduce a
new automatic evaluation metric, dubbed CodeBLEU. It absorbs the strength of BLEU in the n-gram match, and further
injects code syntax via abstract syntax trees (AST) and code
semantics via data-flow. We conduct experiments by evaluating the correlation coefficient between CodeBLEU and quality scores assigned by the programmers on three code synthesis tasks, i.e., text-to-code, code translation, and code refinement. Experimental results show that, our proposed CodeBLEU can achieve a better correlation with programmer assigned scores compared with BLEU and accuracy.

1

Introduction

A suitable evaluation metric is important to push forward
the research of an area, such as BLEU (Papineni et al. 2002)
and ROUGE (Lin 2004) for machine translation and text
summarization. Along with the rapid progress of code synthesis such as text-to-code synthesis, code translation and
code change prediction (Karaivanov, Raychev, and Vechev
2014; Oda et al. 2015; Barone and Sennrich 2017; Chen,
Liu, and Song 2018; Kanade et al. 2019; Husain et al. 2019;
Feng et al. 2020; Dinella et al. 2020; Lachaux et al. 2020),
different automatic evaluation methods for code synthesis
are leveraged, including n-gram accuracy (Karaivanov, Raychev, and Vechev 2014), perfect accuracy (Chen, Liu, and
Song 2018), and computational accuracy (Lachaux et al.
2020). The n-gram accuracy (e.g. 4-gram BLEU) is the most
popular evaluation method for code synthesis (Karaivanov,

---
*Extraído em 2026-06-12 23:54:34*
