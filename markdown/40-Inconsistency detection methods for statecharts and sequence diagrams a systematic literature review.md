                        Spectrum - The Journal of Operational Applications in Defense Areas 1 (2025) 43–48


                  Spectrum - The Journal of Operational Applications in Defense Areas
                                                 Journal homepage: https://spectrum.ita.br

Operational Analysis and Logistics Engineering: Decision Support

Inconsistency detection methods for statecharts and sequence diagrams: a
systematic literature review Matheus Cogo , Carline Muenchen,
Christopher Cerqueira , and Emilia Villani Instituto Tecnológico de
Aeronáutica (ITA), São José dos Campos/SP -- Brazil

Article Info Abstract

Article History: During model-based systems engineering or software
engineering activities, diagrams rep- resenting use cases (sequence
diagrams) and diagrams representing object behaviors (state Received 28
May 2025 machine diagrams or statecharts) can conflict with each other
in what is called an inconsistency. Revised 28 June 2025 Detecting these
inconsistencies is crucial to check if a given specification is
realizable through the behavior that was conceived to meet it. This
paper provides a systematic literature review Accepted 24 July 2025 of
inconsistency detection methods for UML state machine diagrams and
sequence diagrams. Available online 23 September 2025 The selection
process is aided by an open-source machine-learning tool, and resulted
in the qualitative synthesis of 27 works. The included publications
offer methods to tackle the Keywords: detection of horizontal-semantic
behavior inconsistencies. systematic literature review model-based
systems engineering model consistency prisma

E-mail adresses: cogo@ita.br chris@ita.br evillani@ita.br

                      I. INTRODUCTION                                    and even overlap as development goes on. As a consequence
                                                                         of poor viewpoint integration, inconsistencies may surface

Systems engineering (SE) activities have become increas- either in the
structure of a model or in its behavior. ingly more "model-driven" in
the past 20 years \[1\]. The shift Of particular interest to this paper
is the Arcadia MBSE from document-based engineering to model-based
systems method \[5\], implemented in the Capella tool, which exten-
engineering (MBSE) or model-driven engineering (MDE) sively uses both
Sequence Diagrams (SDs) and Statecharts was sparked by several reasons,
such as ambiguity reduction (SCs, originated from \[6\]) to model the
system's behavior. and improved traceability, but it was the advent and
popular- This systematic literature review (SLR) provides an overview
ization of digital tools, methods and languages that promoted of
available inconsistency detection methods, and aims to and effectively
enabled this transition \[1\]. UML (Unified answer the following
research question: which methods are Modeling Language), SysML (Systems
Modeling Language) suitable to be implemented in the Arcadia-Capella
environ- and, more recently, Arcadia are the most prominent examples
ment as a plugin for the detection of behavior inconsistency of
MBSE-enabling languages. between SDs (representing use cases) and SCs
(representing The mere adoption of MBSE or MDE, however, did not the
system components' behavior)? solve all problems intrinsic to the
engineering of intricate and Detecting inconsistencies between SC
diagrams and SDs highly coupled systems. Just as consistency issues can
arise has the practical effect of checking if a given use case (as in
document-based approaches, SE models may also exhibit defined by the
Arcadia methodology) proposed to fulfill them. Logically, an
inconsistency represents a contradiction. a certain capability is
realizable by the behavioral logic If any two propositions defined in a
model are not simul- of that system's components. If any inconsistencies
are taneously true, it is said that the model is not consistent found,
the model should have its behavior changed to match \[2\]. Model
consistency is then defined as the absence of the expected use case or
vice-versa. The same applies to inconsistencies, and may be
taxonomically branched into forbidden sequences of events. several types
such as horizontal or vertical consistency and In general, an
inconsistency may also arise not due to a semantic or syntactic
consistency \[3\]. A SE model is often semantic divergence, but from a
syntactic one. For example, composed of several abstraction facets of a
system called SCs transitions should contain the same events' names as
viewpoints \[4\]. These viewpoints may evolve concurrently SDs messages'
names. The Capella tool, however, already

https://doi.org/10.55972/spectrum.v26i1.427 43  Cogo, M. et al. /
Spectrum - The Journal of Operational Applications in Defense Areas 1
(2025)

                                                                                       Table I. Search protocol

eases the detection and handling of these, as the diagrams are
feature-rich and internally linked with their metamodels. Search
parameter In fact, the tool user may implement validation rules that
nav- Data sources Web of Science, Scopus, IEEE Xplore igate through the
metamodel to check if a specific element has all the linkage expected
for that type. For those reasons, *consisten* AND ( model\* OR diagram\*
) this SLR is concerned only with inconsistencies derived from AND (
statechart\* OR semantic contradictions. Search string "state machine*"
OR petri* OR A previous survey on model consistency \[2\], carried out
automata ) AND sequenc\* in 2001, has tackled the issue on a broader
management Search fields Title, abstract, keywords level, including not
only the inconsistency detection methods Period 1995-2023 but its
diagnosis, handling and tracking with a focus on software engineering.
An SLR conducted in 2009 presented Languages English inconsistency
management methods for UML while explic- Document type All itly showing
which types of inconsistencies and diagrams were supported for each
method analyzed \[7\]. An SLR conducted in 2017 \[8\] followed a similar
strategy, noting duplicates removed. the lack of CASE-integrated or
tool-integrated methods for detection and handling of inconsistencies.
In fact, it was ASReview is an open-source machine-learning tool \[11\]
found that almost 90% of studies were not tried in industrial that
enables the quick systematic labeling of papers into two settings \[8\].
Yet another SLR \[9\] published in 2017 classifies categories: relevant
and irrelevant. The labeling decision is inconsistency managing methods
by their paradigm and, up to the user, and each input is used to train
the model most noticeably, by their compliance to some quality features
so that the next entry shown has a higher chance of being proposed, like
support for all kinds of inconsistencies. This relevant. The screening
step can then be prematurely stopped paper differs slightly from those
due to the need of surveying (compared to a manual screening process)
once a stopping updated, state-of-the-art methods for a more specific
and criteria \[11\] is met. The labeling of entries is done according
narrow use case: the horizontal-semantic behavioral inconsis- to the
eligibility criteria from Table II, applying exclusion tency detection
between SCs and SDs inside the Capella tool. rules to titles, abstracts
and keywords provided by ASReview. Naturally, any method would, in
theory, be implementable The stopping criteria chosen was to label at
least 33% of in the Capella platform, but it is beneficial to know
during the sample's total size and hit 50 consecutively irrelevant the
research phase which methods require intermediate steps publications.
Although somewhat arbitrary, this criteria is - like translation of
diagrams to a third construct - before considered to be conservative
enough and is also being development begins. It also important to know
the methods' used in similar SLR publications \[12\]. During the
screening limitations, as they could hinder the usage of the Capella
tool. procedure, whenever the authors disagreed on whether or As a last
remark, some of them may also require external not to include a
publication, it was included to be further tools, which could be an
obstacle when developing an open- analyzed in the full-text eligibility
assessment step. Similarly, source plugin. whenever the search string
keywords appeared in an unclear The rest of the paper is structured as
follows: Section context but the authors were not confident enough to
exclude 2 will provide the reader with the SLR methodology used, it
using the E1 criterion from Table II, the publication was such as the
eligibility criteria, search strategy and selection included in the
full-text analysis. process. Section 3 presents the SLR results, such as
the The next step is an eligibility assessment where the sample study
selection and its characteristics. Section 4 contains a is refined by
reapplying inclusion and exclusion rules on the discussion and an
interpretation of the results found. Section full-text analysis of the
sample's content. Lastly, a few more 5 contains final remarks in regards
to the methods surveyed related works are included in the sample by
using the forward and to future works. and backward snowball sampling
method \[13\], a technique consisting of exploring references and
citations that match II. METHODS the inclusion and exclusion criteria.

The SLR is guided by the Preferred Reporting Items The most impactful
factors that may threaten the SLR for Systematic reviews and
Meta-Analyses (PRISMA) 2020 validity are missing studies due to a biased
search protocol statement \[10\]. For the data collection step, the
sources and relevant studies being excluded at the screening process.
used are Web of Science, Scopus and IEEE Xplore. The The risk of the
first factor is considered to be low, as the search strategy protocol is
presented in Table I. The search search string used is similar to that
of previous SLRs \[2\] \[7\] string reflects the need to identify a
model inconsistency \[8\] - in fact, in some cases the usage of
asterisks as suffixes detection (or management) method suitable for SCs
(or and prefixes of keywords cause the initial sample to be even similar
behavior-modeling diagrams, such as petri-nets, state more inclusive.
machines or finite automata) and SDs. The second factor is considered to
be of moderate risk After data collection a data set preparation is
required. due to two main reasons: there was limited, misleading By
using ASReview Data Tools, an extension of ASReview, or confusing
phrasing in abstracts; the machine-learning the individual data sets
sourced from the aforementioned approach may not have presented all
relevant papers before databases can be merged into a single RIS file
with their the stopping criteria was met.

                                                                                                                                 44

Cogo, M. et al. / Spectrum - The Journal of Operational Applications in
Defense Areas 1 (2025)

                 Table II. Eligibility criteria
                                                                           Identification through search protocol, sample size
                                                                                         after duplicate removal:

Criterion Description n = 442

            Out of scope due to                                                                                   ​ ​ ​Exclusion criteria hits

E1 ​E1: 105 records different keyword meaning. ​E2: - Records added back
​E3: 1 record The inconsistency detection method is due to authors E2 ​E4:
3 records not defined in sufficient details to replicate it. divergence:
​E5: 9 records n=7 Full-text or abstract not available E3 at the time or
in another language. Excluded due to ASReview stopping criteria The
inconsistency detection is referenced n = 245 E4 but is not part of the
research effort. Post screening step sample size The method supports
only a translation E5 n = 86 or conversion between diagrams. The method
is applied semantically, ​ ​ ​Exclusion criteria hits Added from the ​E1: 31
records I1 horizontally between statecharts (or similar) snowball
method: ​E2: 2 records and sequence diagrams. n=3 ​E3: 16 records ​E4: 11
records ​E5: 2 records

                       III. RESULTS
                                                                                   Records included in the synthesis:

In this section the SLR selection process flow diagram is n = 27
presented, containing the sample size changes that occurred in each
step. The results are then qualitatively presented. Due to size
limitations, a quantitative analysis will not be Fig. 1. Selection
process flow diagram included in this paper.

A. Selection process tool. It supports pseudostates, and is not
integrated into a Figure 1 contains the selection process flow diagram
and CASE/MBSE tool. the sample size of each step. During the screening
step, from 442 articles initially identified, 118 were excluded based on
Lucas, F. et al \[7\]: employs a transformation language Table II. Out
of these, 105 were excluded due to E1; 3 (IQVT-Maude) that maps the
semantics between distinct were excluded due to E4; 9 were excluded due
to E5; 1 metamodels and defines rewriting rules. These rewriting rules
publication was excluded due to E3. From the remaining can be used to
check the semantic consistency of state 324 publications, 245 were
considered not relevant because machines and SDs, since lifeline
messages can, for example, the stopping criteria was met. 7 publications
were added be expressed as class methods or state machine triggers. back
to the sample after divergences between the authors Even though the
method is implemented using an EMF during application of exclusion
rules. During the eligibility metamodel, a full integration into a
CASE/MBSE tool is assessment step, out of 86 articles, 62 were excluded
after not realized. the full-text analysis. Out of these, 31 were
excluded due to Yokogawa, T. et al \[15\]: uses the Labelled Transition
E1; 2 were excluded due to E2; 16 were excluded due to E3; System
Analyser (LTSA) model checker to detect inconsis- 11 were excluded due
to E4 and 2 due to E5. Finally, during tencies in state diagrams and SDs
that were converted to the snowball sampling step, 3 papers were
included into the processes. Presents no support for hierarchy in SDs
and no final sample. These steps produced a final sample size of
CASE/MBSE tool integration. 27 relevant papers which were included in
the qualitative Phuklang, S. et al \[16\]: translates state machine dia-
synthesis. grams and SDs to a process representation described by the
Communicating sequential processes (CSP) language, which B. Synthesis of
methods surveyed is then fed into a Failures-Divergence Refinement (FDR)
The following paragraphs synthesize the methods' char- model checker,
similarly to the method proposed in \[15\]. No acteristics, exposing the
rationale behind the technique used, mention of features supported.
Integrated into a standalone their use cases and gaps identified by the
original authors. Java application. In Section IV the applicability of
methods will be discussed Matsumoto, A. et al \[17\]: extension of a
previous work based on parameters like easiness of implementation and
\[18\] similar to \[15\] that allows for hierarchical structures in UML
features supported. SDs, such as combined fragments (the two types
allowed Litvak, B. et al \[14\]: describes an algorithm to check are alt
and loop). The translated CSP from SDs and state consistency based on
semantic equivalence of both diagrams machine diagrams are checked with
a FDR model checker. (e.g. lifelines and state machine objects). This
algorithm is Yokogawa, T. et al \[19\]: extension of previous works
implemented as the Behavioral Validator of UML (BVUML) \[17\] \[15\].
The method used is the same as \[17\], but the

                                                                                                                                                 45

Cogo, M. et al. / Spectrum - The Journal of Operational Applications in
Defense Areas 1 (2025)

types of combined fragments increased to include the alt, SDs as input.
The proposed implementation does not support opt, par, loop, strict and
seq operators. Provides a counterex- sub-states (hierarchy),
pseudostates or combined fragments. ample if an inconsistency is
detected. Not integrated with a Not integrated to a CASE/MBSE tool.
CASE/MBSE tool. Hammal, Y. \[29\]: detects time and semantic inconsis-
Shinkawa, Y. \[20\]: translates state machine diagrams tencies by
mapping SCs to Petri-nets (using the semantic and SDs into Colored
Petri-nets (CPN), then verifies the formalism of a previous work \[30\])
and then comparing correctness via two sets of formal rules
(Method-based and its reachability graph to the SD specification model.
Not State-based Consistency). Translation rules exist for all UML
integrated to a CASE/MBSE tool. state machine diagram pseudostates and
for alt, opt, par, Yao, S., Shatz, S. \[31\]: proposes the Extended
Colored loop, critical, break and seq SDs fragments. There are no
Petri-Nets (ECPN) to verify if the behavior sequences pro- case studies
and the formal rule set is not implemented in duced by the SD ECPN are
included in behavior sequences an algorithm or tool. produced by the SC
ECPN. A flattening strategy is also Shinkawa, Y. \[21\]: extension of
\[20\]. Proposes three included to deal with hierarchical SCs, but
pseudostates and perspectives on correctness (consistency, completeness
and guards support are proposed as future work. Not integrated
soundness) and methods to verify them by a mapping to to a CASE/MBSE
tool. CPNs. There are no case studies or examples and the formal
Kawakami, Y. et al \[32\]: extension of previous work \[33\]. rule set
that maps diagrams to CPNs is not implemented in Models state machine
diagrams and SDs as boolean formulae an algorithm or tool. through the
proposed formalism. Checks the consistency Tan, H. et al \[22\]: maps
the parallel regions of a state using the symbolic model checker SMV.
Does not support machine diagram and parallel fragments of SDs to
Labeled UML SCs features, and supports only a subset of combined
Petri-nets, proposing a formal rule set to verify consistency fragment
operators. Not integrated to a CASE/MBSE tool. between the two
constructs. No mention of other types Kaufmann, P. et al \[34\]:
extension and revision of of SDs fragments (other than par) or
pseudostates. Not \[35\]. Translates the semantics of state machine
diagrams integrated into a CASE/MBSE tool. and SDs to propositional
formulas that are then fed into Diethers, K. et al \[23\]: uses the
UPPAAL model checker a SAT solver. The implementation was developed with
the to detect inconsistencies. SCs and SDs are loaded into Eclipse
Modeling Framework (EMF), which is also used Vooduu, a plugin
implemented in the Poseidon UML tool, to define Capella metamodels. Not
all UML features are which translates them into UPPAAL behavior and
observer included in the formalism, though, like hierarchical states,
automata. combined fragments or evaluation of guards. Implemented Zhao,
X. et al \[24\]: translates state machine diagrams in a standalone tool.
into Split Automata, a formalism proposed by the authors that enables
inconsistency detection with the SPIN model Xie, Y. et al \[36\]:
definition of LTL specifications from checker and mitigates the state
explosion problem associated Collaboration-Contracts, which in turn come
from SDs. SCs with flattened automata. It is implemented into a
MagicDraw are translated into the Promela language to be used in the
plugin. Other features of UML, such as pseudostates or SPIN model
checker. Some of the UML state machine dia- combined fragments in SDs,
are not mentioned. gram features (Initial, Final, Fork/Join and
composite states) Wang, H. et al \[25\]: maps SCs into Finite State
Processes have mapping rules to the Promela language. Similarly, and SDs
into a trace of messages, then uses the LTSA tool combined fragments
from UML SDs are not considered in to verify the consistency. Does not
mention UML features the translation to Promela. Not integrated to a
CASE/MBSE such as pseudostates or fragments and is not integrated into
tool. a CASE/MBSE tool. Xuandong, L. et al \[37\]: checks if a scenario
mapped Lam, V. et al \[26\]: encodes both SDs and SCs diagrams by a
Message Sequence Chart (MSC) can (or can not, in in the π-calculus
process algebra formalism. The Mobility the case of forbidden scenarios)
be generated from a Petri- Workbench (MWB) tool then checks if the
created specifica- net run. No explicit support for fragments in the
scenario tions are weakly open bisimilar or not. The example provided
description. Implemented in a Java tool with partial support contains a
SD with an alt fragment, but no composite states for the Rational Rose
tool (importing of UML diagrams). or pseudostates in SCs. Not
implemented in a CASE/MBSE Xuandong, L. et al \[38\]: similar to \[37\],
checks con- tool. sistency between bMSCs (basic MSCs) and Petri-nets
with Gongzheng, L. et al \[27\]: describes SCs using XYZ/E emphasis on
timing consistency, that is, a scenario specifica- then translates that
description to Promela. SDs are mapped tion has timing constraints that
a Timed Petri-net shall fulfill. to Linear Temporal Logic (LTL)
specifications. Both are The check is done by an algorithm, but a full
implementation then jointly analyzed with the SPIN model checker.
Mapping of the method is not included. Like \[37\], there is no explicit
rules are given for some of the SD fragments (alt, opt, par, support for
fragments. loop, neg) and SCs may have hierarchical states. Provides
Choi, J. et al \[39\]: exposes how state machine diagrams no mapping
rules for pseudostates and no integration with a and SDs can be
represented with MARTE (Modeling and CASE/MBSE tool. Analysis of
Real-Time and Embedded systems) annotations, Gherbi, A., Khendek, F.
\[28\]: branches semantic and proposes the UMCA (UML/Marte timing
Consistency consistency into three different definitions (Behavioral,
Analyzer), a tool that can extract timing requirements from
Concurrency-related and Time Consistency) and proposes an SDs. These
requirements are then implemented in the UP- algorithm that generates a
schedulability model with SCs and PAAL and TIMES model checkers. There
is no explicit

                                                                                                                                46

Cogo, M. et al. / Spectrum - The Journal of Operational Applications in
Defense Areas 1 (2025)

support for combined fragments. Partial integration with the without
loss of expressiveness. And even if expressiveness Papyrus Modeling
environment (importing of diagrams). is not lost, a seamless experience
is not feasible if the user is Straeten, R. et al \[40\]: the
behavioural inconsistency prohibited from using all diagram features,
like pseudostates detection is presented as part of a formal approach
for model and combined fragments. The mapping procedure itself is
refinement using Description Logics (DLs). SD traces and also cumbersome
and computationally expensive due to the Protocol State Machines (PSMs)
are then translated into the state explosion problem. SHIQ DL. After
translation, it can be checked if a given In contrast to static
consistency, some methods check the message occurs at least once or
always occurs. Only supports dynamic or symbolic consistency \[8\]. A
dynamic consistency a subset of state machine pseudostates, and there is
no check implies detecting inconsistencies between diagrams explicit
support for fragments. Integrated into the Poseidon during the
simulation or execution of the behavior. The UML tool. benefit of this
approach is that the generated trace (e.g. Haga, S. et al \[41\]: checks
inconsistencies between UML runtime output from an SC) can be compared
to the spec- state machine diagrams and SDs through process algebra.
ification trace (e.g. use case), provided there is semantic A set of
entities and the interaction transition graph (ITG) equivalence between
the metamodels. The downside is that, is defined for the
Structure-Behavior Coalescence (SBC) without performing an exhaustive
search, an event-firing process algebra. Formalisms to translate loops,
sequence strategy needs to be devised - like the random walk method
compositions, alternative compositions and parallel composi- proposed in
\[45\] that randomly fires transitions until a fault tions from UML
diagrams to SBC ITGs are given. According detection is verified. Another
strategy commonly used \[14\] to a previous work from the same authors
\[42\], SBC-SMDs \[7\] \[44\] is to fire SD messages as events in the
execution do not contain components such as pseudostates due to of the
state machines. Lastly, a user could also select which the higher-level
nature of the algebraic description. There triggers to send to a
simulation at a given timestamp. The are no explicit translation rules
from these pseudostates to generated trace from this execution could
then be compared SBC-ITGs, however. The method is not integrated into a
to predefined traces that shall or shall not be included in the
CASE/MBSE tool. desired behavior. Knapp, A., Mossakowski, T. \[43\]:
uses the Institution formalism to check if interactions such as between
SCs and V. FINAL REMARKS SDs are realizable. In their example, a state
machine is constructed as a composite structure and this structure is,
For future works, it is necessary to study the feasibility of in turn,
converted to a set of traces. If these set intersect employing model
checkers along with fully-featured UML with the SD traces, it is said
the interaction is realizable and diagrams, i.e., including all
pseudostates, composite states thus the diagrams are horizontally
consistent. Not integrated and combined fragments. As long as the formal
language into a CASE/MBSE tool. translation is hidden from the end user,
exhaustive search Mithun, M., Jayaraman, S. \[44\]: uses SCs as "design-
processes could significantly aid the detection of inconsis- time"
models and SDs as "run-time" test cases to check the tencies.
consistency of Java programs, with a similar algorithm to Alternatively,
a dynamic consistency method can also be \[14\]. The algorithm relies on
the Java Interactive Visualiza- implemented if SD traces could be
generated from SCs mod- tion Environment (JIVE) to generate the run-time
traces of eled in Capella, and then compared to use cases previously
applications. modeled. This is part of an ongoing work to develop a
plugin that brings execution capabilities for Capella statecharts. IV.
DISCUSSION REFERENCES A great deal of work has been put in detecting
semantical inconsistencies between SCs and SDs. Most of the included
\[1\] C. Haskins, "A historical perspective of mbse with a view to the
future," vol. 1, 2011. publications have employed formal approaches in
their meth- \[2\] G. SPANOUDAKIS and A. ZISMAN, "Inconsistency
management in ods, and a majority of those have used model checkers.
These software engineering: Survey and open research issues,"
pp. 329--380, methods can check the static consistency \[8\] of
diagrams, 12 2001. which means the behavior can be proved to be
consistent \[3\] M. Usman, A. Nadeem, T. hoon Kim, and E. suk Cho, "A
survey of without executing it. The main advantage of these methods
consistency checking techniques for uml models." IEEE, 12 2008,
pp. 57--62. is that the exhaustive search of a specific trace (e.g. a
SD) \[4\] I. J. S. . Software and systems engineering, \[ISO/IEC/IEEE in
a generator of traces (e.g. an SC) also leads to assertive 42010:2011\]
Systems and software engineering --- Architecture de- temporal
specifications. It would be beneficial, for example, scription, 1st ed.,
ser. International Standard. ISO; IEC; IEEE, 2011, to know if a
forbidden use case is ever allowed to happen in a vol. ISO/IEC/IEEE
42010:2011. \[5\] J.-L. Voirin, Model-based system and architecture
engineering with the given component modeled in an SC without manually
testing arcadia method. London, Kidlington, Oxford: ISTE Press ;
Elsevier, all possible behaviors, or if a small interaction between
2018, oCLC: 1013462528. two components can happen in all generated
traces. This \[6\] D. Harel, "Statecharts: a visual formalism for
complex systems," assertiveness, however, comes at a cost: the mapping
of UML Science of Computer Programming, vol. 8, pp. 231--274, 6 1987.
constructs to a formal language adequate for model checkers \[7\] F. J.
Lucas, F. Molina, and A. Toval, "A systematic review of uml model
consistency management," Information and Software Technol- is complex.
For this reason, most studies consider only a sub- ogy, vol. 51,
pp. 1631--1645, 12 2009. set of SD features or a subset of SC features.
These subsets \[8\] F. ul Muram, H. Tran, and U. Zdun, "Systematic
review of software may not be adequate to represent Capella/Arcadia
models behavioral model consistency checking," ACM Computing Surveys,

                                                                                                                                            47

Cogo, M. et al. / Spectrum - The Journal of Operational Applications in
Defense Areas 1 (2025)

     vol. 50, pp. 1–39, 3 2018.                                                      diagrams with combined fragments by smv,” vol, vol. 4, pp. 1692–

\[9\] D. Allaki, M. Dahchour, and A. En-nouaary, "Managing inconsis-
1695, 2010. tencies in uml models: A systematic literature review,"
Journal of \[33\] S. HARADA, T. YOKOGAWA, H. MIYAZAKI, S. Yoichiro, and
Software, vol. 12, pp. 454--471, 6 2017. M. HAYASE, "A tool support for
verifying consistency between uml \[10\] M. J. Page, J. E. McKenzie, P.
M. Bossuyt, I. Boutron, T. C. Hoffmann, diagrams by smv," in ITC-CSCC:
International Technical Conference C. D. Mulrow, L. Shamseer, J. M.
Tetzlaff, E. A. Akl, S. E. Brennan, on Circuits Systems, Computers and
Communications, 2009, pp. 897-- R. Chou, J. Glanville, J. M. Grimshaw,
A. Hróbjartsson, M. M. Lalu, 900. T. Li, E. W. Loder, E. Mayo-Wilson, S.
McDonald, L. A. McGuinness, \[34\] P. Kaufmann, M. Kronegger, A.
Pfandler, M. Seidl, and M. Widl, L. A. Stewart, J. Thomas, A. C. Tricco,
V. A. Welch, P. Whiting, "Intra- and interdiagram consistency checking
of behavioral multiview and D. Moher, "The prisma 2020 statement: An
updated guideline for models," Computer Languages, Systems and
Structures, vol. 44, pp. reporting systematic reviews," 3 2021. 72--88,
12 2015. \[11\] R. van de Schoot, J. de Bruin, R. Schram, P. Zahedi, J.
de Boer, \[35\] ------, "A sat-based debugging tool for state machines
and sequence F. Weijdema, B. Kramer, M. Huijts, M. Hoogerwerf, G.
Ferdinands, diagrams," pp. 21--40, 2014. A. Harkema, J. Willemsen, Y.
Ma, Q. Fang, S. Hindriks, L. Tummers, \[36\] Y. Xie, D. Du, J. Liu, and
Z. Ding, "Towards the verification of services and D. L. Oberski, "An
open source machine learning framework collaboration." IEEE, 2009,
pp. 428--433. for efficient and transparent systematic reviews," Nature
Machine \[37\] X. Li, J. Hu, L. Bu, J. Zhao, and G. Zheng, "Consistency
checking Intelligence, vol. 3, pp. 125--133, 2 2021. of concurrent
models for scenario-based specifications," pp. 298--312, \[12\] F. van
Ommen, P. Coenen, A. Malekzadeh, A. G. E. M. de Boer, M. A. 2005.
Greidanus, and S. F. A. Duijts, "Interventions for work participation of
\[38\] L. Xuandong, W. Linzhang, Q. Xiaokang, L. Bin, Y. Jiesong, Z.
Jian- unemployed or work-disabled cancer survivors: a systematic
review," hua, and Z. Guoliang, "Runtime verification of java programs
for Acta Oncologica, pp. 1--12, 4 2023. scenario-based specifications,"
pp. 94--105, 2006. \[13\] C. Wohlin, "Guidelines for snowballing in
systematic literature studies \[39\] J. Choi, E. Jee, and D.-H. Bae,
"Timing consistency checking for and a replication in software
engineering." ACM, 5 2014, pp. 1--10. uml/marte behavioral models,"
Software Quality Journal, vol. 24, pp. \[14\] B. Litvak, S.
Tyszberowicz, and A. Yehudai, "Behavioral consistency 835--876, 9 2016.
validation of uml diagrams." IEEE, 2003, pp. 118--125. \[40\] R. V. D.
Straeten, V. Jonckers, and T. Mens, "A formal approach \[15\] T.
Yokogawa, S. Amasaki, K. Okazaki, Y. Sato, K. Arimoto, and to model
refactoring and model refinement," Software and Systems H. Miyazaki,
"Consistency verification of uml diagrams based on Modeling, vol. 6,
pp. 139--162, 6 2007. process bisimulation." IEEE, 12 2013,
pp. 126--127. \[41\] S. W. Haga, W.-M. Ma, and W. S. Chao,
"Inconsistency checking of \[16\] S. Phuklang, T. Yokogawa, P.
Leelaprute, and K. Arimoto, "Tool uml sequence diagrams and state
machines using the structure-behavior support for consistency
verification of uml diagrams," pp. 606--609, coalescence method." IEEE,
10 2022, pp. 1--6. 2017. \[42\] ------, "Formalizing uml 2.0 state
machines using a structure-behavior \[17\] A. Matsumoto, T. Yokogawa, S.
Amasaki, H. Aman, and K. Arimoto, coalescence method." IEEE, 10 2022,
pp. 174--179. "Consistency verification of uml sequence diagrams
modeling wireless \[43\] A. Knapp and T. Mossakowski, "Uml interactions
meet state machines- sensor networks." IEEE, 7 2019, pp. 458--461. an
institutional approach," in 7th Conference on Algebra and Coalge- \[18\]
H. MIYAZAKI, T. YOKOGAWA, S. AMASAKI, K. ASADA, and bra in Computer
Science (CALCO 2017). Schloss Dagstuhl-Leibniz- Y. SATO, "Synthesis and
refinement check of sequence diagrams," Zentrum fuer Informatik, 2017.
IEICE Transactions on Information and Systems, vol. E95.D, pp. \[44\] M.
Mithun and S. Jayaraman, "Comparison of sequence diagram from
2193--2201, 2012. execution against design-time state specification."
IEEE, 9 2017, pp. \[19\] T. Yokogawa, A. Matsumoto, S. Amasaki, H. Aman,
and K. Arimoto, 1387--1392. "Synthesis and consistency verification of
uml sequence diagrams with \[45\] C. Schwarzl and B. Peischl, "Static-
and dynamic consistency analysis hierarchical structure," Information
Engineering Express, vol. 6, p. of uml state chart models,"
pp. 151--165, 2010. 529, 2020. \[20\] Y. Shinkawa, "Inter-model
consistency between uml state machine and sequence models." vol. 2.
SciTePress - Science and and Technology Publications, 01 2011,
pp. 135--142. \[21\] ------, "Evaluating behavioral correctness of a set
of uml models," in International Conference on Software Paradigm Trends,
vol. 2. SCITEPRESS, 2012, pp. 247--254. \[22\] H. Tan, S. Yao, and J.
Xu, "Behavioral consistency analysis of the uml parallel structures,"
pp. 287--292, 2011. \[23\] K. Diethers and M. Huhn, "Vooduu:
Verification of object-oriented designs using uppaal," pp. 139--143,
2004. \[24\] X. Zhao, Q. Long, and Z. Qiu, "Model checking dynamic uml
consistency," pp. 440--459, 2006. \[25\] H. Wang, T. Feng, J. Zhang, and
K. Zhang, "Consistency check between behaviour models." IEEE,
pp. 470--473. \[26\] V. S. W. Lam and J. Padget, "Consistency checking
of sequence diagrams and statechart diagrams using the π-calculus,"
pp. 347--365, 2005. \[27\] L. Gongzheng and Z. Guangquan, "An approach
to check the consis- tency between the uml 2.0 dynamic diagrams." IEEE,
8 2010, pp. 1913--1917. \[28\] A. Gherbi and F. Khendek, "Consistency of
uml/spt models," pp. 203-- 224. \[29\] Y. Hammal, "A formal methodology
for semantics and time consis- tency checking of uml dynamic diagrams,"
pp. 78--85, 2009. \[30\] ------, "A formal semantics of uml statecharts
by means of timed petri nets," pp. 38--52, 2005. \[31\] S. Yao and S.
Shatz, "Consistency checking of uml dynamic models based on petri net
techniques." IEEE, 11 2006, pp. 289--297. \[32\] Y. Kawakami, T.
Yokogawa, H. Miyazaki, S. Amasaki, Y. Sato, and M. Hayase, "Symbolic
model checking of interactions in sequence

                                                                                                                                                           48


