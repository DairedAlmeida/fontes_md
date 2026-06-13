# Abstract do artigo: 37-Deep Just-In-Time Inconsistency Detection Between Comments and Source Code

**Arquivo original:** 

## Abstract

Abstract

rameter constraints (Zhou et al. 2017), null values and
exceptions (Tan et al. 2012), locking (Tan et al. 2007),
interrupts (Tan, Zhou, and Padioleau 2011)). Some have
also addressed the notion of coherence between comments
and code as a text similarity problem with traditional machine learning models that leverage bag-of-words techniques (Corazza, Maggio, and Scanniello 2018; Cimasa
et al. 2019). In contrast, we design an approach that generalizes across types of inconsistencies and captures deeper
comment/code relationships. Furthermore, prior research
has predominantly focused on detecting inconsistencies that
already reside in a software project, within the code repository. We refer to this as post hoc inconsistency detection
since it occurs potentially many commits after the inconsistency has been introduced.
Ideally, these inconsistencies should be detected before
they ever enter the repository (e.g., during code review)
since they pose a threat to the development cycle and reliability of the software until they are found. Because inconsistent comments generally arise as a consequence of developers failing to update comments immediately following
code changes (Wen et al. 2019), we aim to detect whether a
comment becomes inconsistent as a result of changes to the
accompanying code, before these changes are merged into a
code base. We refer to this as just-in-time inconsistency detection, as it allows catching potential inconsistencies right
before they can materialize.
Detecting inconsistencies immediately following code
changes allows us to utilize information from the version
of the code before the changes, for which the comment is
consistent. By considering how the changes affect the relationship the comment holds with the code, we can determine
whether the comment remains consistent after the changes.
For instance, in Figure 1(a), the comment describes the return type of nodeIds() as an array. When the method is
modified to return a Set instead of an array, the comment no
longer describes the correct return type, making it inconsistent. Such analysis is not possible in post hoc inconsistency
detection since the exact code changes that triggered inconsistency cannot be easily pinpointed, making it difficult to
align the comment with relevant parts of the code.

---
*Extraído em 2026-06-12 23:54:31*
