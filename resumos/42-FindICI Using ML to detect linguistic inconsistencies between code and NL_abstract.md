# Abstract do artigo: 42-FindICI Using ML to detect linguistic inconsistencies between code and NL

**Arquivo original:** 

## Abstract

Abstract
Linguistic anti-patterns are recurring poor practices concerning inconsistencies in the
naming, documentation, and implementation of an entity. They impede the readability,
understandability, and maintainability of source code. This paper attempts to detect linguistic anti-patterns in Infrastructure-as-Code (IaC) scripts used to provision and manage
computing environments. In particular, we consider inconsistencies between the logic/body
of IaC code units and their short text names. To this end, we propose FINDICI a novel automated approach that employs word embedding and classification algorithms. We build and
use the abstract syntax tree of IaC code units to create code embeddings used by machine
learning techniques to detect inconsistent IaC code units. We evaluated our approach with
two experiments on Ansible tasks systematically extracted from open source repositories for
various word embedding models and classification algorithms. Classical machine learning
models and novel deep learning models with different word embedding methods showed
comparable and satisfactory results in detecting inconsistent Ansible tasks related to the
top-10 used Ansible modules.
Keywords Infrastructure as code · Linguistic anti-patterns · Word embedding ·
Machine learning · Deep learning

Communicated by: Foutse Khomh, Gemma Catolino and Pasquale Salza
This article belongs to the Topical Collection: Machine Learning Techniques for Software Quality
Evaluation (MaLTeSQuE)
 Nemania Borovits

n.borovits@tilburguniversity.edu
1

Jheronimus Academy of Data Science, Tilburg University, Tilburg, The Netherlands

2

University of Salerno, Salerno, Italy

---
*Extraído em 2026-06-12 23:54:34*
