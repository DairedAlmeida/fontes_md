CARLETON UNIVERSITY, TECHNICAL REPORT SCE-15-01 3RD VERSION -- OCTOBER
2017

         A systematic identification of consistency
                 rules for UML diagrams
                       Damiano Torre, Yvan Labiche, Marcela Genero, and Maged Elaasar

        Abstract—UML diagrams describe different views of one piece of software. These diagrams strongly depend on each other and
        must therefore be consistent with one another, since inconsistencies between diagrams may be a source of faults during software
        development activities that rely on these diagrams. It is therefore paramount that consistency rules be defined and that
        inconsistencies be detected, analyzed and fixed. The relevant literature shows that authors typically define their own UML
        consistency rules, sometimes defining the same rules and sometimes defining rules that are already in the UML standard. The
        reason might be that no consolidated set of rules that are deemed relevant by authors can be found to date. The aim of our
        research is to provide a consolidated set of UML consistency rules and obtain a detailed overview of the current research in this
        area. We therefore followed a systematic procedure in order to collect and analyze UML consistency rules. We then consolidated
        a set of 116 UML consistency rules (avoiding redundant definitions or definitions already in the UML standard) that can be used
        as an important reference for UML-based software development activities, for teaching UML-based software development, and
        for further research.

        Index Terms—Software/Program Verification, Model checking

                                            ————————————————————

1 INTRODUCTION

M ODEL Driven Architecture (MDA) \[1\] is an approach to software
development by the Object Management tween different diagrams may arise
\[9\]. When UML dia- grams communicate contradicting or conflicting
syntax or Group (OMG) that promotes the efficient use of models
semantics, the diagrams are said to be inconsistent \[10\]. throughout
software development phases, from require- Such inconsistencies may be a
source of faults in software ments to analysis, design, implementation,
and deploy- systems down the road \[9\], \[10\]. It is therefore of
para- ment \[2\]. Much attention has been paid to MDA by aca- mount
importance that the consistency between diagrams demia and industry in
recent years \[3\], \[4\], \[5\], which has be defined and that
inconsistencies be routinely detected, resulted in models gaining more
importance in software analyzed and fixed \[11\]. development. The
Unified Modeling Language (UML) \[6\] In an attempt to obtain an
accurate picture of current is the OMG specification that is most
frequently used and research in the area of UML diagram consistency, we
con- is the de-facto standard modeling language for software ducted a
systematic mapping study \[8\], which resulted in modeling and
documentation \[7\]. It is the prefered model- a number of findings
concerning publications in the do- ing language for implementing MDA,
although it is not in- main, such as: the majority of the publications
discussing tended to be used in every single software development UML
diagram consistency refer to consistency between the project \[8\]. The
UML provides 14 diagram types \[6\] with class diagram and sequence
diagrams; only a very few which to describe a software system from
different per- publications discuss a consistency dimension other than
spectives (e.g., structure and behavior) and abstraction lev- horizontal
consistency, also referred to as intra-model con- els (e.g., analysis
and design), which, among other things, sistency, and the UML 2.0 is the
most frequently used ver- help deal with complexity and distribute
responsibilities. sion in papers discussing consistency. Although the
aim of Since the various UML diagrams in a model typically this mapping
study was to discover frequencies of publi- describe different views of
one, and only one, software sys- cations in different categories and was
not specifically to tem under development, they strongly depend on each
study published UML diagram consistency rules, the other and hence need
to be consistent with one another. As study provided anecdotal evidence
that: (1) authors rou- the UML is not a formal specification,
inconsistencies be- tinely define consistency rules for different UML
based software engineering activities; (2) some authors tend to
------------------------------------------------ define similar, often
identical rules, over and over again, and (3) some authors are not aware
that the UML standard  D. Torre is with the Department of Systems and
Computer Engineering, Carleton University, ON K1S5B6, Canada, and the
Departamento de specification defines consistency rules (a.k.a.,
well-formed- Tecnologías y Sistemas de Información de la Universidad de
Castilla-La ness rules). We also observed that even though many re-
Mancha, CO 13071, Spain. E-mail:dctorre@sce.carleton.ca. searchers have
either explicitly or implicitly proposed  Y. Labiche is with the
Department of Systems and Computer Engineering, Carleton University, ON
K1S5B6, Canada. rules with which to detect inconsistencies in the UML,
no E-mail: labiche@sce.carleton.ca. consolidated set of UML consistency
rules had been pub-  M. Genero iswiththe Departamento de Tecnologías y
Sistemas de Informa- lished to date. By the word "consolidated", we mean
the ción de la Universidad de Castilla-La Mancha, CO 13071, Spain.
process of combining a number of UML consistency rules
E-mail:marcela.genero@uclm.es.  M. Elaasar is with Department of
Systems and Computer Engineering, that other authors feel are important
for UML into a single, Carleton University, ON K1S5B6, Canada.
E-mail:melaasar@gmail.com. coherent set. We believe that, even though
the rules re- are shown in Section 7. quired may be domain,
organization, or project specific, this lack of a consolidated list of
UML consistency rules forces researchers to define the rules that they
rely on for 2 RELATED WORK their own research \[9\], thus resulting in
some rules being Since this paper concerns the systematic identification
of defined over and over again. This motivated our main re- UML
consistency rules, related work pertains to system- search objective in
this paper, which is to identify a consol- atic discussions of UML
consistency. We have found five idated set of consistency rules for UML
diagrams. Identi- pieces of work that fit this description. We first
discuss the fying such a set of UML consistency rules has several ben-
only review \[13\] that presented UML consistency rules, efits: it will
be a reference for practitioners, educators, and and another four
reviews regarding UML consistency researchers alike; it will provide
guidance as to which rules which we considered that it would be
important to in- to use in each context; and it will highlight which
areas are clude. more developed and which need further work. Moreover,
The work of Kalibatiene and colleagues \[13\] is, to the best the
consolidated set of rules could be a good input to the of our knowledge,
the closest piece of work to our research UML revision task force for
inclusion in a forthcoming re- since the authors searched for, collected
and presented vision of the standard. UML diagram consistency rules.
They obtained 50 rules by In order to identify such a consolidated set
of UML reviewing eight articles, which they did not select by fol-
Consistency rules, we decided to revisit the primary stud- lowing a
systematic protocol (Systematic Literature Re- ies obtained in our
systematic mapping study \[8\], which view or Systematic Mapping Study):
no mention was made led us to collect and analyze the rules from the
publications of the processes used to obtain the articles or to in- in
question. This was done by following a systematic pro- clude/exclude
these documents. After conducting our re- cedure inspired by well-known
guidelines for empirical re- search, we confirmed that all of their 50
rules are included search in software engineering \[12\]. These
guidelines pro- in our final set of 116 rules. vide a systematic and
rigorous procedure that is used to The following four pieces of work are
reviews whose identify the quantity of existing research related to a
spe- purpose is to increase the body of knowledge on UML di- cific
research topic. agram consistency, although not necessarily on UML con-
The research work presented in this paper is therefore sistency rules.
an extension of the systematic mapping study published in Spanoudakis
and Zisman \[11\] presented a literature re- \[8\]. Of the 95 primary
studies identified during the map- view on the problem of managing
inconsistencies in soft- ping study, we collected 603 consistency rules,
including ware models in general, but not specifically UML models.
duplicates and rules already in the UML standard, which The authors
presented a conceptual framework that views we then analyzed in order to
answer a number of research inconsistency management as a process, which
incorpo- questions: rates activities with which to detect overlaps and
inconsist- RQ1) What are the existing UML consistency rules? encies
between software models, diagnose and handle in- RQ2) Which types of
consistency problems are tackled consistencies, track the information
generated along the in the existing rules? way, and specify and monitor
the exact means used to RQ3) What types of UML diagrams are involved in
carry out each of these activities. They then surveyed all UML
consistency rules? the research works published prior to 2001 (the year
of RQ4) For what software engineering activities are publication of
their work) that address one or more of the UML consistency rules used?
aspects of their conceptual framework/process. RQ5) Which UML diagram
elements are involved in Usman and colleagues \[3\] presented a
literature review UML consistency rules? of consistency checking
techniques for UML models. The We subsequently employed a systematic
refinement authors argued that formalizing UML models is preferable
process with the objective of removing duplicates and to verifying
consistency because this helps remove ambi- rules already in the UML
standard, as explained later in guities and enforce consistency. They
briefly reviewed 17 this paper, and we eventually compiled a
consolidated set articles, which represent less than a quarter of the
number of 116 rules. We believe that this is an important, long- of
articles considered in our work (95): the two pieces of awaited
contribution that will be of interest to researchers, research have only
ten studies in common since our search educators and practitioners
alike. Another important con- has a different objective. During this
survey, the authors tribution is a discussion, structured by means of
our re- did not follow any Systematic Literature Review (SLR) or search
questions, of the current state of the research and Systematic Mapping
Study (SMS) protocols, and they practice as regards UML diagram
consistency and future simply provided an initial summary of their
findings con- directions in which further research is needed. cerning
UML consistency checking techniques (not con- The remainder of this
document is structured as fol- sistency rules). lows: Section 2 provides
a summary of the related work; Lucas, Molina, and Toval \[5\] presented
an SMS on UML the definition of the systematic procedure that we
followed consistency management in which they reviewed 44 pa- is
presented in Section 3; Section 4 presents the execution pers published
between 2001 and 2007, focusing on the of the study; the results are
described in Section 5; a dis- consistency across two or more UML
diagrams. This work cussion of the threats to validity is presented in
Section 6; is different from ours in several ways. The first important
and finally, our conclusions and outlines of future work difference is
that they did not present any UML con- of a consolidated set of UML
consistency rules sistency rules during their review. The second main
differ- ence is the purpose: they focused solely on the manage- ment of
UML (in)consistencies, i.e., they focused on the 3 DEFINITION OF THE
SYSTEMATIC PROCEDURE techniques used to identify and fix
inconsistencies, with- As discussed earlier, we started this work using
the 95 pri- out providing a detailed discussion of which inconsisten-
mary studies obtained in our systematic mapping study \[8\] cies had to
be identified and fixed. In contrast, our work as a basis (see Appendix
C) for the detailed planning of the focuses on those inconsistencies
that need to be identified SMS \[8\]). Of an initial set of 1134
research papers, 95 pri- and fixed. A direct consequence of this
difference is that mary studies were selected by following a precise
selection we considered a broader number of articles in order to con-
protocol driven by seven research questions (see Appendix solidate the
set of UML consistency rules (95 articles rather C). The primary studies
were then classified according to than 44), and approximately half of
their studies (24) are several criteria that were also derived from the
aforemen- not considered in our work. tioned research questions, after
which an initial set of 603 Ahmad and Nadeem \[14\] presented a
literature review rules was coalesced (see Section 4). Since our
previous restricted to Description Logic (DL)-based consistency work was
not meant to provide a list of UML consistency checking approaches. They
briefly described the back- rules, we did not present the rules
collected; our previous ground to the DL formalism and reviewed three
articles, work presented only anecdotal evidence that justified this
which are also studied in our research. Their main finding new
contribution (please recall the introduction). is that only class
diagram, sequence diagram and state ma- In this section, we present the
procedure we followed, chine diagram inconsistencies were covered in the
papers inspired by a well accepted systematic search and analysis
surveyed and that a few common types of inconsistencies process \[12\],
to obtain our consolidated set of UML con- were discussed. sistency
rules, starting from the initial set of 603 rules col- Our work differs
from the last four reviews \[5\], \[14\], \[3\], lected from the 95
primary studies. From here on they will \[11\] in three ways: a
different goal, a more extensive and be refered to simply as rules. We
present the main compo- systematic review, and the presentation of UML
con- nents of the planning of our work, which are: the specifica-
sistency rules. Our goal is to identify which consistency tion of
research questions that the study aim to answer rules for all the UML
diagrams have been proposed in lit- (section 3.1); the procedure
followed to select (or reject) erature and to create a consolidated set
of UML con- rules to be part of our final consolidated set of rules
(sec- sistency rules. This contrasts with previous reviews that tion
3.2); and the procedure used to extract data from the had very different
goals, such as focusing on a small subset rules selected in order to
answer the research questions of UML diagrams, inconcistency management
and con- (section 3.3). sistency checking techniques. 3.1 Research
questions Another difference is that all but one piece \[5\] of work
performed an informal literature review or comparison The underlying
motivation for the research questions was with no defined research
question, no precise, repeatable to analyze the state-of-the-art
regarding rules. In order to search process and no defined data
extraction or data anal- do this, we considered five research questions
(RQs): TA- ysis process. Our work, however, follows a systematic pro-
BLE 1. cedure inspired by a strict, well-known protocol \[12\]. Three of
those five research questions (specifically, RQs In summary, we were
unable to find answers to the 1, 2, and 3) had already been used in our
previous work \[8\] question posed in our main research objective
(Section 1), (see Section 1 of Appendix C). The main differences be-
which confirmed the need for the systematic construction tween the three
RQs in this paper and those in our previ- ous work \[8\] lies in how and
for what they are used: TABLE 1 RESEARCH QUESTIONS Research questions
Main motivation To find the UML consistency rules used in literature in
order to assess the state of RQ1) What are the existing UML consistency
rules? the field. To find the types of consistency problems tackled in
the UML consistency rules: 1) RQ2) Which types of consistency problems
are tackled horizontal, vertical and evolution consistency; 2) syntactic
and semantic con- in the existing rules? sistency; 3) observation and
invocation consistency; and assess the state of the field as regards
that dimension of UML diagram consistency. To discover the UML diagrams
that research and practice has focused on, to reveal RQ3) What types of
UML diagrams are involved in the UML diagrams that are considered more
important than others, and to identify UML consistency rules?
opportunities for further research. To find the different software
engineering activities that require UML diagrams to RQ4) For what
software engineering activities are be consistent according to specific
sets of consistency rules, in order to understand UML consistency rules
used? what they should focus on. RQ5) Which UML diagram elements are
involved in To find the UML diagram elements that are most frequently
tackled in the UML UML consistency rules? consistency rules.  RQ1: In
our previous work we did not present any We also recorded the papers
that introduced each rule (we merely provided a link to a webpage with a
rule, which can, for instance, be used to identify list of rules) and
solely discussed metadata about the the rules that are the most
important to users; rules, while in this work we present the
consolidated  Which of the 14 UML diagrams are involved in the set of
rules and provide a detailed analysis of the rule: 1) Class Diagram
(CD); 2) Communication Dia- rules. gram (COMD) or Collaboration Diagram
(COD); 3) RQ2: Unlike our previous work, we now filter out the Use Case
Diagram (UCD); 4) State Machine Diagram rules we collected that are
already in the UML stand- (SMD) or Protocol State Machine Diagram
(PSMD); ard. 5) Sequence Diagram (SD); 6) Component Diagram RQ3: In our
previous work, the focus of the study was (CTD); 7) Object Diagram (OD);
8) Profile Dia- a series of papers and we therefore studied how UML
gram(PD); 9) Activity Diagram (AD); 10) Composite diagrams are involved
in papers that present con- Structure Diagram (CSD); 11) Interaction
Overview sistency rules, whereas in this work the focus of the Diagram
(IOD); 12) Package Diagram (PD); 13) Tim- study is rules and we
therefore study how UML dia- ing Diagram (TD); 14) Deployment Diagram
(DD). grams are involved in rules. UML terminology has changed over the
years, and The other two research questions (RQs 4 and 5) are new to the
following pair of UML diagrams were therefore this paper. considered and
counted (in the statistical reports presented in this research) as only
one diagram: 3.2 Inclusion and exclusion criteria o COD and COMD
(diagram 2) were counted as one In this section, we discuss the
inclusion and exclusion cri- diagram since COMD is the UML 2.x
equivalent teria used to refine the set of rules. Since we used the 603
of the COD in UML 1.x \[7\]. rules found in our SMS \[8\] as a starting
point, and those o PSMD is a kind of SMD (diagram number 4 in the rules
had already been obtained through the use of inclu- list above) \[15\].
Nevertheless, we initially decided sion and exclusion criteria, we only
applied additional ex- to collect the information for these two diagrams
clusion criteria: separately since they have different purposes dur- 
Inaccurate rules: ing software development, but both diagrams o Rules
that we considered wrong. For instance, one were eventually reported as
only one diagram. rule specified that each message in a sequence di- 
UML consistency dimensions and types (see Appen- agram should trigger a
transition in a state ma- dix C). chine diagram. We believe that this is
incorrect  The software engineering activity that required since some
of the classifiers receiving a message UML diagrams to be consistent
with one another in in a sequence diagram may not have a state-based
some way as specified in rules. The following eight behavior, and even
if they have, not all messages definitions describe activities in
software engineer- need to trigger state changes; ing in which UML
diagram consistency was re- o Rules not focusing on UML diagram
consistency. quired, as explained by some authors. Since this is a For
instance, rules which discussed consistency list of activities from the
primary studies we found, between UML diagrams and other non-UML this
list is not meant to exhaustively represent all the data, such as
requirements or source code, were software engineering activities that
require dia- discarded; grams to be consistent: o Rules that were
considered obsolete because they o The verification of consistency
(Verification) is the focus on UML characteristics that are no longer
process of detecting inconsistencies between (or in supported in the
latest UML standard; a singular) UML diagram(s) during software de- 
Redundant rules, i.e., all those rules that can be im- velopment. (This
definition is in line with the IEEE plied by other rules; definition of
verification \[16\].)  Rules that were already included in previous UML
o Consistency management (Management) includes standard versions. the
detection of inconsistencies in a software model, the diagnosis of the
significance of incon- 3.3 Data extraction strategy sistencies, and the
handling of detected inconsist- We answered the research questions
(TABLE 1) by extract- encies \[11\]. ing data from the collected rules,
and recording that data o Model Refinement and Transformation (Ref. on
an Excel spreadsheet (our data extraction form). For &Tra.) are defined
as follows \[17\]: each rule we collect the following data: 
Refinement, which is a semantics-preserving  Reason for excluding the
rule, as per the exclusion transformation applied to a model, and which
criteria (see section 3.2) produces the same kind of model, e.g.,
refining  Precise definition of the rules (see Section 5 and a
Plateform Independent Model (PIM) into a Appendix A). When the rule, as
originally speci- new PIM; fied by others, was not sufficiently clear or
precise,  Transformation (also called mapping), which we redefined it,
whilst maintaing the original in- generates a new kind of model, e.g.,
transform- tent as we understood it, thus hopefully facilitat- ing a
Platform Independent Model into a Plat- ing comparisons and the
consolidation of rules.  form Specific Model (PSM), or a PSM into exe-
to the exclusion criteria. We identified 242 redun- cutable code. These
transformations generally dant rules and obtained a set of 182 accurate
and add detail to the model. non-redundant rules. o Safety and Security
consistency (Saf. & Sec.): From  Fourth task (T4): we further reduced
the set of rules the point of view of automated analysis, safety by
deleting those already presented in previous consistency implies that
there are no conflicting UML standards, again according to the exclusion
requirements and unintentional (internal) non- criteria. We identified
66 rules that were already in determinism in a UML diagram \[18\].
Security the standard (i.e., well-formedness rules) and ob- consistency
is, meanwhile, defined as the con- tained a set of 116 rules that are
accurate, non-re- sistency of bounded values in non-abstract ele-
dundant and not already in the standard. ments of a UML diagram \[19\].
The set of 424 accurate rules (T2), and the final set of o Impact
Analysis (Impact analysis) is defined as the 116 consistency rules (T4)
were then classified according to process of identifying the potential
consequences the data exctraction strategy discussed in section 3.2.
(side-effects) of a change to the model, and esti- mating what needs to
be modified to accomplish a change \[20\]. 5 RESULTS o Model
formalization (Formalization) describes the The data recorded on our
data extraction form (an excel formal process used to specify/develop a
UML file) permits the five research questions shown in section model
\[21, 22\]. 3.1 to be answered. A quantitative summary of the results o
Model understanding (Understanding) is the pro- for research questions
RQ2 to RQ5 is presented in TABLE cess employed to understand that a UML
model 2. More details are provided in the following sub-sections, is
much more than a set of annotated boxes and in which we shall refer to
TABLE 2 for raw data. lines as it reflects the meaning of a software,
that Two different set of rules were used to answer our 5 re- is, the
UML has semantics. The semantics of the search questions: UML is
expressed through its metamodel and in 1) the final set of 116
consistency rules (T4 in Section 4) particular through both the
so-called well- to answer RQ1, RQ2 and RQ3; formedness rules and
context/domain dependent 2) the set of 424 accurate rules (T2 in Section
4) for RQ4 consistency rules, which describe in plain lan- and RQ5. We
chose to include the 242 redundant rules guage and often using the
Object Constraint Lan- (T3 in Section 4) and the 66 rules already
presented in guage (OCL) constraints that UML model ele- the UML
standard (T4 in Section 4) to answer these ments have to satisfy \[23\].
two research questions, because we wished to show the whole picture of
what researchers have focused on. TABLE 2 (first raw) simply refers to
Appendix A for 4 EXECUTION research question RQ1 since the purpose of
the question is In this section we report the results obtained, in terms
of to report on the consistency rules we have coalesced. The number of
collected rules, after conducting the protocol section of TABLE 2 that
contains data for research question discussed in Section 3. Please
recall that we started from RQ3 shows all the combinations of UML
diagrams for the primary studies collected in our systematic mapping
which we have found consistency rules in the primary study (SMS) \[8\],
which began in September 2012 and was studies, and the number of
consistency rules for each com- completed in October 2013: the primary
studies selected bination after conducting the protocol discussed in
section span the period from 2000 to 2012; the list of primary stud- 3
(e.g., after applying inclusion/exclusion criteria): e.g., we ies can be
found elsewhere \[24\]. The execution of the rule have found 14 rules
involving only the state machine dia- selection protocol of our SMS
began in May 2014 and was gram (SMD), 5 rules involving the sequence and
use case completed in October 2014. diagrams at the same time (SD and
UCD), and 1 rule in- We then started to study the 95 primary study
papers volving the class, state machine and activity diagrams at
obtained from our SMS \[8\], which allowed us to identify the same time
(CD, SMD and AD). Primary studies 603 rules. In order to document the
execution activity of showed rules for 36 different diagram
combinations, i.e., a the protocol described in Section 3 in sufficient
detail, we small subset of all the possible combinations of UML dia-
describe the following multi-tasks process: grams. Note also that the
table shows combinations with  First task (T1): 621 unique rules were
eventually no rule (e.g., UCD and SMD): this means that we found
specified; we identified that, in order to obtain rules in primary
studies involving those diagrams but the unique, we had to split 18 of
the 603 rules into two rules were eventually discarded because of our
in- rules each. clude/exclusion criteria. The colored column shows the 
Second task (T2): we obtained a reduced set of rules unique ID# we gave
to each of the 36 UML diagram com- by deleting all the inaccurate ones,
according to the binations; these unique IDs will later be used in
figures to exclusion criteria. We identified 197 innacurate rules
simplify the data analysis; the color code for combinations and obtained
a set of 424 accurate rules. will later be used in section 5.3. The
colored column is  Third task (T3): we further reduced the set of rules
white when the number of rules for the corresponding by deleting all the
redundant ones, again according combination of diagrams is zero. The 36
UML diagram combinations refer to: 1) rules involving only one diagram 
TABLE 2 SUMMARY OF THE ANSWERS TO THE RQS Research Question 1: What are
the existing UML consistency rules? (see Appendix A) Research Question
2:Which types of consistency problems are tackled in the existing rules?
Horizontal 97 Invocation 8 Vertical 7 Evolution 3 Observation 1
Syntactic 95 Semantic 21 - - Research Question 3: What types of UML
diagrams are involved in UML consistency rules? 1 SMD 14 10 UCD and SMD
0 19 COMD 1 28 CD 33 2 CD, SMD and AD 1 11 CD and SMD 7 20 UCD and CD 3
29 ID and CD 0 3 SD and UCD 5 12 PSMD and CD 0 21 OD and AD 0 30 ID and
UCD 2 4 AD 0 13 SD and AD 7 22 COMD and AD 1 31 PSMD and SMD 0 5 SD 6 14
UCD and OD 0 23 COMD and CD 3 32 CSD 8 6 OD and COMD 0 15 SMD and COMD 1
24 COMD and UCD 0 33 SD and CD 9 7 OD and CD 1 16 COMD and CD 1 25 UCD
and AD 4 34 SD and COMD 0 8 AD and CD 4 17 SMD and SD 1 26 UCD 4 35 CD,
SMD and COMD 0 9 SMD and AD 0 18 PSMD 0 27 SMD and OD 0 36 UCD, SD and
CD 0 Research Question 4: For what software engineering activities are
UML consistency rules used? Verification 220 Ref/ &Tra. 54 Understanding
21 Saf. & Sec. 7 Impact Analysis 57 Management 51 Formalization 14 - -
Research Question 5: Which UML diagram elements are involved in UML
consistency rules? class/es 161 action/s 18 invariant/s 9 capsule/es 4
state/s 86 Collaboration 17 interface/s 9 class name 3 operation/s 56
chart/s 17 Interaction 9 super class 2 association/s 45 machine/s 17
Sender 8 sub sequence 2 use case 41 pre-condition 16 Flow 8 sub classes
2 activity/ies 39 Strings 15 composite 8 scenario 2 message/s 38 Link 13
property 7 query 2 sequence/s 38 event/s 12 connector/s 7 post-state 2
object/s 36 guard/s 12 Call 7 package 2 instance/s 30 Visibility 11 node
6 swimlanes 1 name/s 26 Aggregation 11 generalization/s 6 stimulus 1
transition/s 26 post-condition/s 10 constraint/s 6 stimuli 1 type/s 23
method/s 10 Port 5 name pace 1 attribute/s 19 Receiver 10 Parameter 5
edge 1 Behavior 18 Multiplicity 9 Lifeline 4 actor 1

such as AD, SD etc.; 2) rules involving pairs of diagrams they were
inaccurate: 31.72%, 197 out of 621; resuling in such as SD and UCD; 3)
rules involving 3-tuples of dia- 424 accurate rules. Specifically, 87
(14.00%) were not con- grams such as CD, SMD and AD. However, not all
the 14 sistency rules (e.g., rules describing good modeling prac-
diagrams appear in TABLE 2, since a diagram (or a pair or tices); 28
(4.50%) were explained in a too ambiguous lan- a 3-tuples of diagrams)
is not shown in TABLE 2 if we were guage; 14 (2.25%) were obsolete
because they referred to unable to find a rule involving that (those)
diagram(s) in UML elements that are no longer used in the latest UML
primary studies. standard; and 68 (10.95%) were simply wrong (i.e.,
contra- dicting the UML specification). Other rules were mostly 5.1 What
are the existing UML consistency rules? eliminated because of
redundancies (57.08%, 242 out of (RQ1) 424). Finally, 66 out of 182
(36.26%) non-redundant rules The principal observation we can make about
RQ1 is that were excluded because they are already part of the UML the
researchers of UML consistency rules have typically standard. defined a
number of similar rules over and over again. Spe- The rules with the
largest number of references in pri- cifically, we collected a list of
621 rules from the 95 primary mary studies are rule 112 (with 48
references), and rules studies. After removing rules tha were
inaccurate, redun- 110, 48, and 115 (respectively with 33, 25, and 15
reference dant, and already presented in UML standards, we ob- each). In
a nutshell, rule 121 focus focus on the required tained a final set of
116 rules that are presented in TABLE visibility in order to exchange
messages in a sequence dia- 3 in Appendix A. In other words, only 18.68%
(116 out of gram; rule 110 concerns the consistency of messages in a
621) of the rules initially collected are included in our final sequence
diagram and the class diagram; rule 48 specifies set of rules because of
our include/exclusion criteria (sec- the consistency of behavior
specification in lifelines of a se- tion 3.2). The remaining rules were
eliminated because quence diagram and a state machine of the
corresponding classifiers; and rule 115 describe the consistency of
class rules (only one rule, 0.86%). We believe that the mappings names
in class diagrams and sequence diagrams. The com- between vertical
levels, the evolution of a UML model, the plete list of references for
the 116 rules presented in TABLE invocation and observation consistency,
are concepts 3 in Appendix A, and elsewhere \[24\]. much less easy to
understand than the mere specification of a UML model or the horizontal
consistency levels, and 5.2 Which types of consistency problems are this
explains why, even though we found papers discuss- tackled in the
existing rules? (RQ2) ing these consistency dimensions, these papers did
not The results obtained for RQ2 show (TABLE 2) that the vast present
many consistency rules. majority of rules are Horizontal (83.62%, 97 out
of 116 rules) and Syntactic (81.90%, 95 out of 1116 rules). Moreo- 5.3
What types of UML diagrams are involved in ver, we found 21 (18.10%)
Semantic rules. Researchers UML consistency rules? (RQ3) strikingly
described many more syntactic than semantic In Fig. 1, we use a bubble
plot to represent multiple dimen- consistency rules. We conjecture that
the main reason for sions of the results in one figure: the bubble plot
essentially this is that syntactic rules are easier to specify than
seman- embodies a two x--y scatter plot with bubbles at the cate- tic
rules and that the UML standard more formally speci- gory intersections.
This synthesis method is useful since it fies syntax than semantics,
which hinders the specification provides both a map and a rapid overview
of a research of semantic rules. It may also be the case that semantic
field \[25\]. Combined with the bubble plot are some bubbles rules are
specific to the way in which the UML notation is (left-hand side) which
are pie charts to help us describe the actually used, which is
organization, project, or team spe- many dimensions involved in this
research. cific, and are therefore seldom described in published Fig. 1
shows the mapping of the selection process onto the manuscripts. 36
combinations of UML diagrams presented in TABLE 2: Researchers have also
paid much less attention to: 1) In- the combinations are numbered
vertically in Fig. 1. On the vocatoin rules (8 rules, 6.90%); 2)
Vertical rules (7 rules, left-hand side of Fig. 1, each bubble pie chart
describes the 6.03%); Evolution rules (3 rules, 2.59%); and Onservation
number of rules included in the final set (in red) and the

Fig. 1. Summary of UML Consistency rules selection number of rules
deleted (in yellow) for each of the 36 UML ensure that the diagrams are
consistent, unless all the rules diagram combinations. For instance, for
combination 1 required are already in the UML standard (which is un-
(i.e., SMD, as per TABLE 2, i.e., State Machine Diagram as likely).
Another possible reason for a lack of rules for some per section 3.3)
the initial set of rules involving only the diagrams (or diagram
combinations) is that users of the State Machine Diagram contained 66
rules (14+52), of UML notation follow a specific UML (behavior) modeling
which we removed 52 and kept only 14. On the right-hand practice that is
assumed to be standard and does not there- side, we present our reasons
for deleting rules and the fore require the definition of consistency
rules. Neverthe- magnitude of each reason for each combination of dia-
less, since the UML allows different behavior modeling grams. For
instance, of the 52 deleted rules involving only practices, rules
underpinning such practices should be the State Machine Diagram, 10 were
deleted because they specified so as to be clear for all stakeholders.
were ambiguous (beyond repair), 24 were already in the Another
interesting finding is the high percentage standard, six were redundant
(with rules we kept), eight (88.33%) of rules eliminated for the
Sequence Diagram. If were not consistency rules, and four were wrong. we
consider all the UML diagram combinations in which The results show that
the diagram combination that in- the Sequence Diagram is involved (rows
3, 5, 13, 17, 33 and volves the largest number of rules in the initial
set, specifi- 34 in Fig. 1), it is actually possible see that, when
starting cally 128 rules (33+95), is combination 28 (y-axis), i.e., the
with the total of 240 rules collected, only 28 (11.67%) made Class
Diagram: the majority of the rules involve only the it to the final set
of 116 rules. The main reason why rules Class Diagram. This is followed
by combination 33, i.e., were discarded is redundancy, i.e., rules
presented several rules involving the Class Diagram and the Sequence
Dia- times by authors: for instance, 25 of the 45 discarded rules gram,
with 125 rules (9+116). These two sets of rules make involving only the
Sequence Diagram (row 5 in Fig. 1) were up 40.74% (253 out of 621 rules)
of the total number of ini- redundant. One possible explanation for this
is that the se- tial rules, and 36.21% of the final set of rules (42 out
of 116). quence diagram is one of the most ill-specified diagrams in It
is also important to mention that there is a huge gap be- the UML
specification and researchers are attempting to tween these two most
involved diagram combinations and make sense of it by specifying rules
which, when coa- the next most involved diagram combinations, which are
lesced, happen to be redundant with one another (138 of the State
Machine Diagram (66 rules, y-axis value 1), Se- the 212 eliminated
rules, 65.09%, were redundant with quence Diagram (51 rules, y-axis
value 5), Class Diagram other rules). We discussed the 36 different
combinations of with State Machine Diagram (49 rules, y-axis value 11),
and UML diagrams (detailed in TABLE 2) covered by the final State
Machine Diagram with Sequence Diagram (38 rules, set of 116 rules. Our
results show that rules collected de- y-axis value 17). The absence of
rules for some diagrams or scribe consistency in only 10 of the 14 UML
diagrams. some diagram combinations can be explained by the fact Fig. 2
shows only seven diagrams because we grouped that the semantics and
syntax of some diagrams overlap rules for the Sequence, Communication,
Interaction Over- (e.g., package, object and class diagrams). However,
it is view and Timing diagrams together under the Interaction possible
to argue that the fact that the semantics and syntax Diagram (ID)
category since these diagrams are different of those diagrams overlap,
and that there is a need for these variants of the ID \[15\]. We did not
find any rules involving different diagrams, should justify the
definition of rules to the Package, Component, Profile, Timing,
Interaction

Fig. 2. UML Consistency rules grouped into UML diagrams. Overview and
Deployment diagrams. We conjecture that 5.4 For what software
engineering activities are there are several reasons for the lack of
rules involving UML consistency rules used? (RQ4) these diagrams. First,
as already mentioned, the fact that In this section, we discuss the
results of the different uses the Package Diagram and the Deployment
Diagrams over- of rules. As we already explained in Section 5, we an-
lap with the Class Diagram might be a reason for the lack swered this RQ
by considering the set of 424 rules rather of rules involving these
diagrams; However, as agrued than only the final set of 116 rules. We
chose to do this be- previously, this similarity between the two
diagrams could cause, since redundant rules may have been defined in the
be the very reason needed to justify more rules involing context of
different Software Engineering activities, we these two diagrams or the
Package Diagram with other di- wished to show what researchers have
focused on. agrams. The lack of widespread tool support and under-
Results (pie chart on the left-hand side of Fig. 3) show
specification/ambiguity in the specification for the Timing that 51.89%
(220 out of 424) of the rules are proposed for and Interaction Overview
diagrams is a possible reason for model consistency verification
(Verification in the figure), the lack of rules involving these
diagrams. 13.44% (57 out of 424) for impact analysis (Impact Analysis
Fig. 2 uses the same color code and ID# numbers for in the figure),
12.74% (54 out of 424) for model refinement diagram combinations as
TABLE 2. The figure shows, for and transformation (ref. &tra.), 12.03%
(51 out of 424) for each of the seven diagrams involved in at least one
rule consistency management (Management), 4.95% (21 out of (labels on
the y-axis), the total number of rules found that 424) for model
understanding (understanding), 3.30% (14 involve that diagram (large
font size, bold faced, square- out of 424) for model formalization
(formalization), and bordered number) and the proportions of those rules
that 1.65% (7 out of 424) for safety and security consistency (saf. are
shared with other diagrams as a pie chart. These data & sec.). All the
percentages shown in this section are were taken directly from TABLE 2,
although they are pre- rounded off in the pie chart (left-hand side) of
the Fig. 3. sented in a different form. For instance, the Activity Dia-
In the light of these figures, the reader may be sur- gram (AD) was
found to be involved in 17 rules. TABLE 2 prised to discover that half
of the consistency rules have indicates that one rule involves AD with
CD and SMD been defined without any additional context of use such as
(combination number 2), four rules involve AD and CD specific
model-driven activities. This may suggest that not (combination 8),
seven rules involve AD and SD (combina- many UML-based software
engineering activities require tion 13), one rule involves AD and COD
(combination 22) UML diagrams to be consistent, which would be surpris-
and four rules involve AD and UCD (combination 25); ing, or at least
that papers describing UML-based software These appear clock-wise from
the top of the pie-chart for engineering activities do not discuss (or
need to rely on?) row AD in Fig. 2. Note that upon summing up the rule
consistency rules. On the other hand, this may rather mean count of each
pie chart in Fig. 2 we obtain 167 rather than that typical UML-based
software engineering activities re- 116 because when a rule involves
more than one diagram quire the same set of consistency rules, which can
therefore it contributes to more than one pie chart. be described
independently of their context of use. Not surprisingly, the UML
diagrams that are most in- volved in the final set of 116 rules are the
Class Diagram 5.5 Combining RQ3) and RQ4) (62 rules, 53.45%), the
Interaction Diagram (37 rules, Upon combining the data presented for
RQ4) in the previ- 31.90%), and the State Machine Diagram (24 rules,
20.69%). ous section (For what software engineering activities are
Research on UML consistency rules has paid much less at- UML consistency
rules used?) with the data presented in tention to the Use Case Diagram
(22 rules, 15.52%) and the the analysis of RQ3) in section 5.2 (What
types of UML di- Activity Diagram (17 rules, 14.66%). agrams are
involved in UML consistency rules?), we show The diagrams that are least
covered are the Composite in Fig. 3 (right-hand side) which UML diagram
was cov- Structure Diagram and the Object Diagram, which only ered by
rules in which Software Engineering activity. had 6.90% (eight rules)
and 0.86% (one rule) of the total of The bubble plot in Fig. 3
(right-hand side) shows that 116 rules, respectively. the Class Diagram
(CD) is mostly involved in rules used for verification (116 rules) and
impact analysis (53 rules)

Fig. 3. Summary of rules between UML diagrams and uses in Software
Engineering activities. activities. Furthermore, the Interaction Diagram
(ID) and However, the left side of Fig. 4 shows only 424 rules in State
Machine Diagram (SMD) have 100 and 89 rules, re- the period between 2000
and 2012 (without overlapping) spectively, which are used for
verification. This is not en- classified in the eight Software
Engineering activities pre- tirely surprising since these three UML
diagrams are likely sented in section 3.3. On the the left-hand side of
Fig. 4, no the behavioral UML diagrams that are most frequently rules
overlap because each of the 95 primary study papers used in the
activities cited above. \[8\] was assigned only one of the eight
Software Engineer- Fig. 3 (right-hand side) shows a total of 660 rules
rather ing activities presented in section 3.3. The rules presented than
424 accurate rules because we grouped all the rules in each paper were
consequently classified according to related to each of the seven UML
diagram separately, re- only those seven activities. sulting in some
rules being repeated. The results show (left-hand side of Fig. 4) that a
great In Fig. 4 we present a bubble plot distribution that was number of
rules were proposed in 4 of the 13 years consid- obtained by combining
the results of RQ3 and RQ4 with ered in this study: 49.76% (211 out of
424 rules) of the rules the years of the rules publications \[24\]. In
Fig. 4, we cou- were published between 2002 and 2005. In these 4 years,
pled the years of rule's publication, on the right-hand with 152 out of
259 (58.69%) of the total number of rules related the UML diagram
covered, and on the left-hand with the to the Class Diagram and 103 out
of 199 (51.76%) of the to- Software Engineering activity that used the
rule. tal number of rules related to the Interaction Diagram were The
right-hand side of Fig. 4 shows the number of rules published
(right-hand side of Fig. 4). Moreover, in these 4 presented in the
period between 2000 and 2012, and classi- years we can see that the
three peaks of Software Engineer- fied by the seven UML diagrams covered
by the rules. As ing activities use (left-hand side of Fig. 4): 1) 57
rules pre- in the previous two sections, we grouped all the rules re-
sented in 2003 for impact analisys, 32 rules in 2005 for ver- lated to
each of the seven UML diagrams, resulting in 660 ification, and finally
25 rules in 2004 for refinement and rules instead of 424 rules, since
some rules were repeated. transformation activities. We can conclude
that these four For instance, the 17 rules presented for CD and SMD
(com- years represent the most prolific period in literature in bination
11 in TABLE 2) were included in both the CD terms of publishing UML
consistency rules to date. count and in the SMD. Another important
aspect that should be highlighted is

Fig. 4. Summary of UML Consistency rules between UML diagrams. that the
number of UML consistency rules covering the Verification activity (left
side of Fig. 4) remained relatively stable in the entire period
considered, with a peak of 32 new rules in 2005 and with only seven
rules being pre- sented in 2006 and 2012. Furthermore, the right-hand
side of Fig. 4 shows that class and interaction diagrams re- mained
stable in the period between 2002 and 2009 with a peak of 72 rules in
2003 and 35 rules in 2004, respectively. The fact that researchers
consistently continued to focus on class and interaction diagrams during
these years, shows the vital importance of these diagrams. The number of
rules decreased in 2012, but this is likely because many pa- pers
published in that year were not yet available online when we performed
searches \[8\].

5.6 Which UML diagram elements are involved in UML consistency rules?
(RQ5) Fig. 5 shows the 200 most frequently used words in the Fig. 5.
Summary of the UML diagram elements involved in UML Con- plain English
specification of the 116 rules found (4761 sistency rules. attempted to
mitigate this risk by carefully defining: 1) our words in total), in
which we can recognize the 60 UML el- inclusion and exclusion criteria
in order to select primary ement names already presented in TABLE 2.
This is a studies \[8\], and 2) our exclusion criteria in order to
select weighted word cloud of the 116 rules found in the 95 pa- rules in
this work, based on our predefined research ques- pers included as
primary studies in our SMS \[8\]. tions. We used seven search engines to
search journals, Fig. 5 was created using Tagxedo \[26\] , which uses a
conference and workshop proceedings that are relevant to streaming
algorithm to filter the text input. The aim of Fig. UML consistency
rules \[8\]. We did not consider grey liter- 5 is to provide a first
impression of the main UML diagram ature (e.g., PhD theses, books)
because it might have af- elements referenced in the final set of 116
UML consistency fected the validity of our results. We then organized
the rules. Not surprisingly, the UML elements most involved selection of
rules by following a rigorous multi-phase pro- in the rules are related
to the class, sequence, state ma- cess, during which our filtering
criteria were applied, to ar- chine, use case and finally activity
diagrams. These re- rive at a consolidated set of UML consistency rules.
sults concerning the model elements most frequently The limited number
of rules in this research could be involved in UML consistency issues
may be useful as an inherent statistical threat to validity, despite the
fact regards helping focus the teaching of UML by concen- that we
attempted to mitigate this by following rigorous trating on specific
elements. Indeed, if an element is guidelines that are well-known in the
empirical software not rigorously specified, then there is a risk of
many engineering community \[12\]. However, the classification semantics
issues appearing in the model. scheme and process that we provide in
this paper may be used as a starting point for future research. 5.7
Additional results The terminology used for UML consistency rules in
this In this section we shortly discuss the 66 rules that were ex- study
has been identified from a number of other studies cluded from the final
set of rules because they had already found in \[8\]. We observed that
the terminology used by re- been presented in previous UML standards. It
is important searchers is not always consensual and the authors in this
to note that 66 of the 182 (36.26%) non-redundant and ac- field
sometimes discuss UML consistency issues using dif- curate UML
consistency rules presented by different au- ferent terms such as
"Horizontal consistency" and" Intra- thors had already been proposed in
previous UML stand- model consistency" to refer to the same concept.
Thus, by ards. We compared the rules with the applicable UML following a
systematic research method \[12\], we devel- specification version at
the time of publication (in which oped a set of terms with the intention
of providing a useful the rule was found): we either found a reference
to the ap- and accessible set of definitions for the terms that are used
plicable version in the publication or inferred it from the within the
UML consistency domain. Nevertheless, we time of publication; finally,
we also checked whether the consider that this set of terms and
definitions is a threat to rule was contained in the most recent version
of the speci- validity that needs to be pointed out. fication (UML 2.4.1
and 2.5). The 66 rules were excluded Another threat to consider is that,
since in this study we because they had already been presented in one of
the pre- relied solely on rules that have been published in literature
vious UML standards (UML 1.3, 1.5, 2.0, 2.4.1, and 2.5). \[8\], the fact
that we did not find rules involving some dia- gram(s) (described in
section 5.3) does not mean that none 6 THREATS TO VALIDITY have been
created.There is a lot of tool support for UML, and since these tools do
support some kinds of model- The main issues that may constitute a
threat to the validity driven development activities, they must rely on,
(and of our research are related to publication bias, selection likely
enforce) UML diagram consistency. However, the bias, inaccuracy in data
extraction, and misclassification rules they rely on are not necessarily
in the public domain \[27\]. Selection bias refers to the distortion of
a statistical or at least discussed in published literature. In
addition, analysis owing to the criteria used to select the rules. We
some rules might also be for specific domains (industry, has paid much
less attention is the Use Case Dia- organization, project, team
specific, etc). gram (22 rules, 15.52%). We believe that one of the
Finally, as it is impossible to thoroughly search for reasons for these
results is that the semantics of the every rule published on UML
consistency, we use case diagram is simple and the semantics gener-
acknowledge that some rules might not have been in- ally presents the
include, extend and generalization, cluded, such as rules concerning
diagram (model) synthe- even though the semantics for this diagram is
not, sis, rules in standard UML-driven software development however,
very clear to every one: Cockburn argues processes discussed in
textbooks, and rules for domain \[31\] for instance that generalization
between use specific languages. cases is not clear and necessary, while
other \[32-34\] argue that there are consistency rules between use case,
and more so use case descriptions and other di- 7 CONCLUSION agrams such
as class and sequence diagrams. In ad- In recent years, a great number
of UML consistency rules dition, the mapping between semantics in the
use have been proposed by researchers in order to detect in- case
diagram and other diagrams is not clear either: consistencies between
UML diagrams. However, no previ- for instance, if we have a
generalization between use ous study has, to the best of our knowledge,
summarized cases and use cases to map in two sequence dia- and analyzed
these UML consistency rules by following a grams, how does the
generalization (in the use case) systematic process. This work presents
the results obtained translate into relations between the two sequence
di- after following a systematic protocol, whose aim was to agrams.
identify, present and analyze a consolidated set of UML  Besides the
Class, Interaction, and State Machine di- Consistency rules from
literature. No such mapping study agrams, there is a need for much
additional research or review existed prior to our work. on consistency
rules involving other UML diagrams. We obtained the set of UML
Consistency rules by fol- For example, no rule was found for the
Package, lowing a systematic procedure inspired by well-known Component,
Timing, Profile, Interaction Overview guidelines for performing
systematic literature reviews in soft- and Deployment Diagrams. One
consideration that ware engineering presented by Kitchenham and Charters
could partially explain the lack of rules for these di- \[12\]. A
significant amount of space in this paper has been agrams is their
overlap with the Class diagram syn- used to discuss the 116 rules and we
have also discussed tax/semantics. how the systematic process was
defined, since we felt that  Additionally, 38.97% (242 of 621) of the
collected it is of the upmost importance to allow readers to precisely
rules that have been proposed by researchers over understand the results
and the conclusions we came to, the years describe redundant (similar or
even identi- and to allow other researchers to replicate the study or
cal) rules. This highlights the need for a central re- compare their
results with ours. pository for such rules, such as this manuscript. An-
From an initial set of 621 UML consistency rules, pub- other adequate
place in which to record those rules lished in literature and extracted
from seven scientific re- would be the UML specification itself. search
databases, a total of 116 rules were eventually se-  We found that
36.26% (66 of 182) of non-redundant lected and analyzed in depth, by
following a precise selec- and accurate UML consistency rules presented
by tion protocol driven by four research questions. We ob- different
authors had already been presented in one serve that (in no particular
order of importance): of the previous UML standards.  The UML diagram
that is most involved in the final  The main software development
activity that justi- set of the 116 rules is the Class Diagram (62
rules, fied the description of UML diagram consistency 53.45%), followed
by the Interaction Diagram (37 rules is UML consistency verification,
51.89%, fol- rules, 31.90%) and the State Machine Diagram (24 lowed by
impact analysis, 13.44%, UML model re- rules, 15.52%). This is not
entirely surprising since finement & transformation, 12.74%, and manage-
these are likely the most frequently used UML dia- ment of consistency,
12.03%; grams \[28\]. However, recent research \[29\] suggests  We
found that 49.76% of the rules were published that the Activity Diagram
is the second most fre- between the years 2002 and 2005, and this period
quently used UML diagram after the Class Diagram. represents the most
prolific period in literature in Considering the very scarce number of
rules we terms of publishing UML consistency rules; found for the
Activity Diagram (17 of 116 rules,  The results show that the vast
majority of the rules 14.66%), we believe that future research should
focus are horizontal and syntactic rules, and very few ad- more on this
diagram. However, if we compare the dress vertical, semantic,
invocation, observation and last UML 2.5 spec. (released in 2015)
\[6\]with the most evolution consistency. One reason for this could be
frequently used UML 2.0 spec. (released in 2005) the fact that the UML
syntax is more formally de- \[30\], we can see that the UML has put more
effort scribed (by the UML metamodel) in the specification into the
definition of activity diagrams, which con- than semantics, and creating
syntactic rules may sequently leads to (explicitly or otherwise) con-
therefore prove more feasible. Another reason for sistency rules
concerning that diagram. Another di- this lack could be explained by the
fact that users agram to which research on UML consistency rules mostly
employ a few types of behavior diagrams that they understand or find
suitable. Despite the  fact that the topic of UML consistency is mature,
it Version 2.5," 2015. still needs to evolve to include more definitions
of \[7\] Z. Manna and R. J. Waldinger, "Toward automatic program
synthesis. UML consistency rules in all dimensions. Commun.," ACM
vol. 14, pp. 151-165, 1971. By demonstrating that there are various
areas concern- \[8\] D. Torre, Y. Labiche, and M. Genero, "UML
consistency rules: a ing UML consistency rules that require
improvements, our systematic mapping study,"in Proceedings of 18th
International research calls for future work in this area. Firstly, we
pose Conference on Evaluation and Assessment in Software Engineering the
following question: should some of the rules presented (EASE 2014),
London, UK, 2014. in this work, for instance, the most referenced rules
num- \[9\] N. Ibrahim, R. Ibrahim, M. Z. Saringat, D. Mansor, and T.
Herawan, bered 112, 110, 48 and 115 (see Appendix A), be specified
"Consistency rules between UML use case and activity diagrams using in
the UML standard? logical approach," International Journal of Software
Engineering and Finally, we believe that the final consolidated set of
its Applications, vol. 5, pp. 119-134, 2011. UML consistency rules
resulting from this research could \[10\] J. Simmonds, R. V. Straeten,
V. Jonkers, and T. Mens, "Maintaining be used as a reference in the
future by researchers in the Consistency between UML Models using
Description LogicZ," RSTI field of UML model consistency. -- L'Object
LMO'04, vol. 10, pp. 231-244, 2004. Different avenues for future work
can be considered. According to \[8\], there are still very few
evaluation \[11\] G. Spanoudakis and A. Zisman, "Inconsistency
management in works on consistency rules reported in literature. We
there- software engineering: Survey and open research issues," in
Handbook fore initialized the process of validating the rules collected
of Software Engineering and Knowledge Engineering, S. K. Chang, by
organizing the 1st International Workshop on UML Ed., ed Singapore:
World Scientific Publishing Co., 2001, pp. 329- Consistency Rules
(WUCOR) \[35\], which will be followed 380. by the implemention of an
online survey that will be used \[12\] B. Kitchenham and S. Charters,
"Guidelines for performing systematic to obtain the opinions of experts
from academia and indus- literature reviews in software engineering,"
Keele University2007. try. In addition, the set of rules will be checked
against a \[13\] D. Kalibatiene, O. Vasilecas, and R. Dubauskaite, "Rule
Based number of UML models from academia and industry. Approach for
Ensuring Consistency in Different UML Models,"in As part of our future
work, we also believe that addi- Proceedings of 6th SIGSAND/PLAIS
EuroSymposium 2013, Gdańsk, tional consistency rules could be collected
from other Poland, 2013. sources, such as: 1) textbooks on UML-based
object-ori- \[14\] M. A. Ahmad and A. Nadeem, "Consistency checking of
UML models ented software development \[36\] that implicitly or explic-
using Description Logics: A critical review,"in Proceedings of 6th itly
suggest consistency rules; 2) techniques in which UML International
Conference on Emerging Technologies Islamabad, diagrams are synthesized
from other diagrams \[37\], in Pakistan, 2010. other words the process
of enforcing some consistency \[15\] OMG, "OMG Unified Modeling
LanguageTM - Superstructure rules between diagrams; 3) consistency rules
presented in Version 2.4.1," 2011. the context of Domain Specific
Languages \[38\]. \[16\] IEEE, "IEEE Standard for Software VeriÞcation
and Validation Plans (IEEE Std 1012-1986)," 1992. ACKNOWLEDGMENT \[17\]
R. F. Paige, D. S. Kolovos, and F. A. C. Polack, "Refinement via This
work has been developed within the SEQUOIA Pro- Consistency Checking in
MDA," Electronic Notes in Theoretical ject, (TIN2015-63502-C3-1-R)
(MINECO/FEDER) funded Computer Science, vol. 137, pp. 151-161, 2005. by
Fondo Europeo de Desarrollo Regional and Ministerio \[18\] Z. Pap, I.
Majzik, A. Pataricza, and A. Szegi, "Methods of checking de Economía y
Competitividad, and a NSERC discovery general safety criteria in UML
statechart specifications," Reliability grant. Engineering & System
Safety, vol. 87, pp. 89-107, 2005. \[19\] O. Pilskalns, D. Williams, D.
Aracic, and A. Andrews, "Security REFERENCES Consistency in UML
Designs,"in Proceedings of 30th Annual International Computer Software
and Applications Conference, \[1\] J. Mukerji and J. Miller, "Overview
and guide to OMG's architecture," Chicago, USA, 2006. Object Management
Group2003. \[20\] L. C. Briand, Y. Labiche, and L. O'Sullivan, "Impact
analysis and \[2\] D. Thomas,"MDA: Revenge of the modelers or UML
utopia?," IEEE change management of UML models,"in Proceedings of
International Software, vol. 21, pp. 15--17, 2004. Conference on
Software Maintenance, Amsterdam, The Netherlands, \[3\] M. Usman, A.
Nadeem, K. Tai-hoon, and C. Eun-suk,"A Survey of 2003. Consistency
Checking Techniques for UML Models,"in Proceedings \[21\] I.-Y. Song, R.
Khare, Y. An, and M. Hilsbos,"A Multi-level of Advanced Software
Engineering and Its Applications, Hainan Methodology for Developing UML
Sequence Diagrams,"in Island, China, 2008. Proceedings of 27th
International Conference on Conceptual \[4\] M. Genero, A. M.
Fernández-Saez, H. J. Nelson, G. Poels, and M. Modeling, Barcelona,
Spain, 2008. Piattini,"A Systematic Literature Review on the Quality of
UML \[22\] J. Yang, "A framework for formalizing UML models with formal
Models," Journal of Database Management, vol. 22, pp. 46-70, July-
language rCOS,"in Proceedings of 4th International Conference on
September 2011 2011. Frontier of Computer Science and Technology,
Shanghai, China, 2009. \[5\] F. J. Lucas, F. Molina, and A. Toval,"A
systematic review of UML \[23\] Y. Labiche, "The UML is more than boxes
and lines,"in Proceedings model consistency management," Information and
Software of Workshops and Symposia at MODELS 2008, Toulouse, France,
Technology, vol. 51, pp. 1631-1645, 2009. 2008. \[6\] OMG, "OMG Unified
Modeling LanguageTM - Superstructure \[24\] D. Torre, Y. Labiche, M.
Genero, and M. Elaasar,"A systematic  identification of consistency
rules for UML diagrams," Carleton \[37\] D. Torre, Y. Labiche, M.
Genero, and M. Elaasar, "UML diagram University, Ottawa2015. synthesis
techniques: a systematic mapping study," Carleton \[25\] K. Petersen, R.
Feldt, S. Mujtaba, and M. Mattsson, "Systematic University, Ottawa2015.
mapping studies in software engineering,"in Proceedings of 12th \[38\]
B. Hoisl and S. Sobernig, "Consistency Rules for UML-based International
Conference on Evaluation and Assessment in Software Domain-specific
Language Models: A Literature Review," in 1st Engineering (EASE 2008),
Bari, Italy, 2008. International Workshop on UML Consistency Rules
(WUCOR 2015) \[26\] H. Leung. (2014). Tagxedo. Available:
http://www.tagxedo.com/ co-located with ACM/IEEE 18th International
Conference on Model \[27\] D. I. K. Sjoberg, J. E. Hannay, O. Hansen, V.
B. Kampenes, A. Driven Engineering Languages and Systems (MoDELS 2015),
Ottawa, Karahasanovic, N.-K. Liborg, et al., "A Survey of Controlled
Canada, 2015. Experiments in Software Engineering," IEEE Trans. Softw.
Eng., vol. \[39\] P. Brereton, B. Kitchenham, D. Budgen, M. Turner, and
M. Khalil, 31, pp. 733-753, September 2005 2005. "Lessons from applying
the systematic literature review process \[28\] B. Dobing and J.
Parsons,"How UML is used," ACM, vol. 49, pp. 109- within the software
engineering domain," Journal of Systems and 113, May 2006 2006.
Software, vol. 80, pp. 571--583, 2007. \[29\] G. Reggio, M. Leotta, F.
Ricca, and D. Clerissi, "What are the used \[40\] T. Mens, R. Van der
Straeten, and J. Simmonds,"A framework for UML diagrams? A Preliminary
Survey,"in Proceedings of In managing consistency of evolving UML
models,"in Proceedings of Proceedings of 3rd International Workshop on
Experiences and Software Evolution with UML and XML, Hershey 2005.
Empirical Studies in Software Modeling - CEUR Workshop \[41\] Z. Huzar,
L. Kuzniarz, G. Reggio, and J. L. Sourrouille, "Consistency Proceedings
(EESSMod 2013), Miami, Florida - USA, 2013. problems in UML-based
software development,"in Proceedings of \[30\] OMG, "OMG Unified
Modeling LanguageTM - Superstructure International Conference on UML
Modeling Languages and Version 2.0," 2005. Applications, Lisbon,
Portugal, 2005. \[31\] A. Cockburn, Writing Effective Use Cases, 1st
ed. Boston, MA, USA: \[42\] G. Engels, J. H. Hausmann, and R. Heckel,
"Testing the consistency Addison-Wesley Longman Publishing Co., Inc.,
2000. of dynamic UML diagrams,"in Proceedings of Integrated Design and
\[32\] N. Ibrahim, R. Ibrahim, and M. Z. Saringat, "Definition of
Consistency Process Technology, Pasadena, California, 2002. Rules
between UML Use Case and Activity Diagram,"in Proceedings \[43\] G.
Engels, R. Heckel, and J. M. Küster, "Rule-Based Specification of of 2nd
International Conference, Daejeon, South Korea, 2011. Behavioral
Consistency Based on the UML Meta-model,"in \[33\] J. Chanda, A.
Kanjilal, S. Sengupta, and S. Bhattacharya, "Traceability Proceedings of
4th International Conference on The Unified Modeling of Requirements and
Consistency Verification of UML Use case, Language, Modeling Languages,
Concepts, and Tools, Toronto, Activity and Class Diagram: A Formal
Approach,"in Proceedings of Ontario, Canada, 2001. IEEE ICM2CS New
Delhi, 2009. \[44\] G. Engels, J. M. Küster, R. Heckel, and L.
Groenewegen, "A \[34\] L. Fryz and L. Kotulski,"Assurance of System
Consistency During methodology for specifying and analyzing consistency
of object- Independent Creation of UML Diagrams,"in Proceedings of 2nd
oriented behavioral models," Sigsoft Software Engineering Notes, vol.
International Conference on Dependability of Computer Systems 26,
pp. 186-195, September 2001 2001. (DEPCOS-RELCOMEX '07), 2007. \[45\] R.
Wieringa, N. A. M. Maiden, N. R. Mead, and C. Rolland, \[35\] D. Torre,
Y. Labiche, M. Genero, M. Elaasar, T. K. Das, B. Hoisl, et "Requirements
engineering paper classification and evaluation al.,"1st International
Workshop on UML Consistency Rules criteria: a proposal and a
discussion," Requirements Eng., vol. 11, pp. (WUCOR 2015): Post workshop
report," SIGSOFT Softw. Eng. Notes, 102--107, 2006. vol. 41, pp. 34-37,
2016. \[46\] ProQuest, "RefWorks - A web-based bibliography and database
\[36\] D. Torre, Y. Labiche, M. Genero, and M. Elaasar,"UML consistency
manager " http://www.refworks.com/2014. rules in technical books,"in
Proceedings of IEEE International \[47\] D. Torre, Y. Labiche, and M.
Genero,"UML consistency rules: a Symposium on Software Reliability
Engineering, Fast Abstract systematic mapping study," Carleton
University, Ottawa2014. (ISSRE 2015). APPENDIX A This appendix contains
TABLE 3 in which the final set of 119 UML consistency rules is
presented. The following table contains:  type(s) of UML diagram(s)
involved in the UML consistency rules (grey row) with the appropriate
ID# pre- sented in TABLE 2);  the univocal number of each UML
consistency rule;  the description of the UML consistency rules;  UML
consistency dimensions (for definitions, see Section 4 of Appendix C): o
H: which corresponds to Horizontal Consistency; o V: which corresponds
to Vertical Consistency; o I: which corresponds to Invocation
Consistency; o O: which corresponds to Observation Consistency; o E:
which corresponds to Evolution Consistency; o Sy: Syntactic Consistency;
o Se: Semantic Consistency.

                                                                  TABLE 3
                                                        SET OF UML CONSISTENCY RULES
     1 - State Machine Diagram
            Consider two State Machines U' and U of a class O' and its superclass O, where U' extends the state
      1 machine of U by adding states and transitions. The initial states of the state machine diagrams U' and                 I   Se   [1, 2]
            U must be identical.
            Consider two State Machines U' and U of a class O' and its superclass O, where U' extends the state
      2 machine of U by adding states and transitions. Every transition of U' which is already in U has at least               I   Se    [1]
            the same source states and sink states as it has in U.
            Consider two State Machines U' and U of a class O' and its superclass O, where U' extends the state
            machine of U by adding states and transitions. For each transition t in U' that is already present in U,
      3                                                                                                                        I   Se    [1]
            the guard condition g'(t) in U' must be at least as strong as the guard condition g(t) for t in U: g'(t) →
            g(t).
            Consider two State Machines U' and U of a class O' and its superclass O, where U' extends the state
      4 machine of U by adding states and transitions. A transition of U in U' cannot therefore receive an                     I   Se    [1]
            additional source state or sink state that is already present in U.
            Consider two State Machines U' and U of a class O' and its superclass O, where U' extends the state
      5 machine of U by adding states and transitions. A transition added to U' does not receive a source state                I   Se    [1]
            or a sink state that was already present in U.
            Consider two State Machines U' and U of a class O' and its superclass O, where U' extends the state
      6 machine of U by adding states and transitions. The set of transitions of U' is a superset of the set of                I   Se    [1]
            transitions of U.
            Consider two State Machines U' and U of a class O' and its superclass O, where U' extends the state
      7 machine of U by adding states and transitions. A transition in U' which is already present in U has in                 I   Se    [1]
            U' at most the source states that the transition has in U.
            Consider two State Machines U' and U of a class O' and its superclass O, where U' extends the state
      8 machine of U by adding states and transitions. For each transition t in U' that is already present in U,               I   Se    [1]
            U: g(t) → g'(t).
            Consider two State Machine U’’ and U of a class O’’ and its superclass O, where U’’ refines the state
            diagram of U by means of a refinement function h that maps transitions onto transitions and states of
            U’’ and that maps simple states of U’’ onto simple states of U. Intuitively, the concept of the refine-
            ment function means that if a simple state s of U has been refined to a composite state in U’’, then h
            maps the substates of s in U’’ and transitions between these states to s, and h maps the transitions in
            U’’ that are incident to the substates of s into transitions of U that are incident to s.

           s is a state in U, so s Є U (from the rule: "a simple state s of U","s of h(t')")
           s' is a refined state in U', so s' Є U' (from the rule: "a state s' in U' ","sink state s' of t' in U' ")
      9                                                                                                                        E   Se   [1, 2]
           Source+(t): t → set of states.
           Source+(t) = { source of t}[3] U sub-states*{source of t}
           s' Є Source+(t)

           For every transition t' in S': for every source state s of h(t'), there exists a state s' in S' such that h(s') =
           s, and for every sink state s of h(t') there exists a sink state s' of t' in S' such that h(s') = s.

           Informal rule definition: A transition t’’ (of U’’) that is refined from t (of U) must have s’’ (state sender
           and receiver of U’’) that is refined from s (of U) Є Source+(t).

Consider two State Machine U'' and U of a class O'' and its superclass
O, where U'' refines the state \[1\] diagram of U by means of refinement
function h that maps transitions onto transitions and states of U'' and
that maps simple states of U'' onto simple states of U. Intuitively, the
concept of the refine- ment function means that if a simple state s of U
has been refined to a composite state in U'', then h maps the substates
of s in U'' and transitions between these states to s, and h maps the
transitions in U'' that are incident to the substates of s into
transitions of U that are incident to s.

      s is a state in U, so s Є U (from the rule: "a simple state s of U","s of h(t')")
      s' is a refined state in U', so s' Є U' (from the rule: "a state s' in U' ","sink state s' of t' in U' ")
      Source+(t): t → set of states.

10 Source+(t) = { source of t} U sub-states\*{source of t} E Se s' Є
Source+(t)

      For every source state s' of a transition t' in S’’, where s’’ and t’’ do not belong to the same refined
      state (i.e., h(s’’) /= h(t’’)), h(s’’) is therefore a source state of h(t’’), and for every sink state s’’ of a tran-
      sition t’’ in S’’, where s' and t' do not belong to the same refined state, h(s’’) is therefore a sink state of
      h(t’’).

    Informal rule definition: This rule is about transitions that go between states that are not substates of
    a complex state that is a refinement of a simple state. The rule says that such transitions have their
    sources and sinks in U' as refinements of those ones in U.
    Using a signal/message on a transition in a state diagram that no object sends, creates structural and                               [4]
    syntactic inconsistencies. The information about the sending object can be found in another state ma-

11 chine, in another partition of the same state machine, in a sequence
diagram, or any other diagram H Sy where one can specify an object can
send a signal/message. 12 A state machine should be deadlock-free. H Se
\[5-7\] A state machine must be deterministic, that is, in every state,
only one transition (accounting for the \[6, 8, 9\] 13 different levels
of nested states) should fire on a reception of an event. H Sy

14 An abstract operation cannot be invoked in a state machine. H Sy
\[10\] The joint effect of a sequence of refined operations should
exactly adheres to the refined abstract oper- 117 ation. I.e. if
u=operation if u1+u2+u3 refine u, -\> the joint effect of u1+u2+u3
should exactly adheres I Se \[2\] to u. 2 - Class Diagram, State Machine
Diagram and Activity Diagram There is an inconsistency if a precondition
on an operation is in contradiction with a state machine or \[11\] 15 an
activity diagram including a call of that operation. H Sy 3 - Sequence
Diagram and Use Case Diagram If a use case is further specified by one
or more sequence diagram, then every scenario described in 16 one of
those sequence diagrams should match a sequence of steps in that use
case's use case descrip- H Se \[12, 13\] tion. If a sequence diagram
depicts all the behavior required for successful completion of a use
case, it fol- 17 lows that each post-condition specified in the use case
description must be achieved by a message (or H Sy \[14\] a set of
messages) in the sequence diagram (including referred diagrams) for that
use case. If a sequence diagram depicts all the behavior required for
successful completion of a use case, it fol- 18 lows that results
achieved by alternative message flows in the sequence diagram (including
referred H Sy \[14\] diagrams) must correspond to post-conditions
specified in the use case description. Each action specified or implied
in a use case description should be detailed in a corresponding mes-
sage or set of messages in the sequence diagram corresponding to that
use case. Depending on the 19 clarity and completeness of the use case
description text, the author of the sequence diagram may need H Se
\[14\] to infer some of the operations. A use case is complemented by a
set of sequence diagrams, each sequence diagram representing an 20
alternative scenario of the use case. H Se \[14\] 4 - Activity Diagram
(no rule) 5 - Sequence Diagram Arguments to messages must represent
information that is known to the sender. This includes attribute 21
values of the sender, navigation expressions starting with the sender,
constants; This should account H Sy \[14\] for inheritance. Variables
used in the guard of a message must represent information that is known
to the sender. This 22 includes attribute values of the sender,
navigation expressions starting with the sender, constrants; H Sy
\[14-17\] This should account for inheritance. If SD2 is a sequence
diagram referred to by an Interaction Use (a nested sequence diagram)
embedded 23 in sequence diagram SD1, then for every matched pair of
message to and from SD2 in SD1, there is a H Sy \[15, 17\] corresponding
matched pair of sourceless message and targetless message in SD2. In a
sequence diagram, if an attribute is assigned the return value of a
message, then the types have to \[10\] 24 be compatible H Sy

25 Return messages from ExecutionSpecification instances should always
be shown. H Sy \[14\] 26 Arguments of messages should always be shown. H
Sy \[14\]  6 -- Object Diagram and Collaboration Diagram (no rule) 7 -
Object Diagram and Class Diagram The number of occurrences of a link in
an object diagram, an instance of an association in a class dia- \[18\]
27 H Sy gram, must satisfy the multiplicity constraints specified for
the association. 8 - Activity Diagram and Class Diagram 28 A class name
that appears in an activity diagram also appears in the class diagram.
Sy \[12, 19-21\] An action that appears in an activity diagram must also
appear in the class diagram as an operation of \[13, 19, 29 H Sy a
class. 21, 22\] When an activity diagram specifies an exachange of
information, through control or data flow, between 30 two different
instances, the class diagram should specify a mechanism (e.g., direct
association) so that H Sy \[19\] those instances can indeed communicate.
Swimlanes (Activity pattern in UML 2.0) in an Activity diagram
(represented as className in activity 31 H Sy \[20, 22\] state) must be
present as a unique class in a class diagram. 9 - State Machine Diagram
and Activity Diagram (no rule) 10 -- Use Case Diagram and State Machine
Diagram (no rule) 11 - Class Diagram and State Machine Diagram When a
state machine specifies the behavior of a class, the actions and
activities in the state machine \[4, 8, 10, should be operations of the
class (in the class diagram) which behavior the state machine specifies.
An 19, 22-26\] 32 action or activity can be part of a navigation
expression, in which case the navigation expression must H Sy legal
according to the class diagram and the context (class) of the specified
behavior in the state ma- chine. When a state machine specifies the
behavior of a class, any property (i.e., attribute, navigation) in the
\[10, 22, state machine should be one of the class (in the class
diagram) which behavior the state machine spec- 27\] 33 ifies. A
property can be part of a navigation expression, in which case the
navigation expression must H Sy legal according to the class diagram and
the context (class) of the specified behavior in the state ma- chine.
When the state machine diagram specifies the behaviour of a class in the
class diagram, the class is an \[4, 11, 28- 34 active class with a
classifierBehavior, then the triggers of the transitions in the state
machine diagram H Sy are operations of the active class. 31\] No
operation can be called on a state machine or from a state machine if
this breaks the visibility rules 35 H Sy \[10\] of the class diagram
(public, protected, private). When behaviour is triggered from a state
machine diagram (e.g., calling an operation, sending a signal) \[10, 25,
that describes the behaviour of a class, and the triggered behaviour
belongs to another class, then the 26\] 36 former must have a handle to
the latter as specified in the class diagram. Another way of saying this
is H Sy that the former must have visibility to the latter. A specific
case of this situation is when the former class has an association
(possibly inherited) to the latter class. For a send action, there
should be a reception within the classifier of the receiver instance
that corre- 37 H Sy \[25\] sponds to the signal of the send action
describing the expected behavior response to the signal. For all call or
send events specified in the class diagram for a classifier (context)
which behavior is 38 specified with a state machine, there should be
transitions in that state machine describing the detailed H Sy \[25\]
behavior of the events. 12 -- Protocol State Machine Diagram and Class
Diagram (no rule) 13 - Sequence Diagram and Activity Diagram If an
activity diagram shows scenarios of an operation and that operation
appears in a sequence dia- 39 gram, the different diagrams should
specify the same scenarios: e.g., same sequence of messages/op- H Sy
\[13, 32\] erations/actions, same branching or repetition conditions. If
an activity diagram shows scenarios of an operation and that operation
appears in a sequence dia- 40 gram, a flow of interaction between
objects in an activity diagram should be a flow of interactions H Sy
\[19\] between the same objects in a sequence diagram. If an activity
diagram shows scenarios of an operation and that operation appears in a
sequence dia- gram, a sequence of messages in the sequence diagram,
uninterupted by control flow structures, must 41 H Sy \[32\] correspond
to one activity node in the activity diagram which name is the series of
message names of the sequence diagram. If an activity diagram shows
scenarios of an operation and that operation appears in a sequence dia-
gram, a synchronous message between objects running in different threads
of control in the sequence 42 H Sy \[32\] diagram must match a join node
for the receiving side (thread) in the corresponding activity diagram,
and a fork node for the asynchronous reply. If an activity diagram shows
scenarios of an operation and that operation appears in a sequence dia-
gram, an asynchronous creation of an active object in the sequence
diagram must match a fork node in 43 the corresponding activity diagram:
the input action node is matching the calling thread message; two H Sy
\[32\] outgoing edges should flow out of the fork node, one for the node
matching continuation of execution in the calling thread and one for the
node matching the newly created active object. If an activity diagram
shows scenarios of an operation and that operation appears in a sequence
dia- gram, an asynchronous message sent between two active objects in
the sequence diagram should 44 H Sy \[32\] match, in the corresponding
activity diagram, a join node on the receiver side and a fork node on
the sender side. If an activity diagram shows scenarios of an operation
and that operation appears in a sequence dia- 45 H Sy \[32\] gram, a
InteractionUse in the sequence diagram must match an activity node in
the activity diagram  that refers to the activity diagram matching the
sequence diagram referred to in the InteractionUse. 14 -- Use Case
Diagram and Object Diagram (no rule) 15 - State Machine Diagram and
Communication Diagram When one specifies an active class, i.e., one that
has a state-based behaviour described in a state ma- \[19, 33\] chine
diagram, and an instance of this active class is used in a communication
diagram, the messages 46 H Sy sent to this objects and emitted by this
object as specified in the communication diagram must comply to the
protocol specified in the state machine diagram. 16 - Communication
Diagram and Class Diagram In order for objects to exchange messages in a
communication diagram, the sending object must have \[34\] a handle to
the receiving object as specified in the class diagram. Another way of
saying this is that the 47 H Sy sender must have visibility to the
receiver. A specific case of this situation is when the sending object's
class has an association (possibly inherited) to the receiving object's
class. 17 - State Machine Diagram and Sequence Diagram When one
specifies an active class, i.e., one that has a state-based behaviour
described in a state ma- \[1, 19, 22, chine diagram, and an instance of
this active class is used in a sequence diagram, the messages sent to
23, 27, 35- 48 this objects and emitted by this object as specified in
the sequence diagram must comply (e.g., sequence H Sy 51\] and types of
signals, receivers and emitters of signals) to the protocol specified in
the state machine diagram. 18 -- Protocol State Machine Diagram (no
rule) 19 - Communication Diagram If communication diagram A is a
specialization of communication diagram B, all the messages present
\[52\] 49 E Sy in B have to be included in A. 20 - Use Case Diagram and
Class Diagram \[12, 13, 50 The noun of the use case's name should equal
the name of one class in the class diagram. H Sy 19, 21, 53\] \[12, 19,
51 The verb of the use case's name should equal the name of an operation
of a class in the class diagram. H Sy 21, 22, 53\] 52 Entity classes
correspond to data manipulated by the system as described in a use case
description. H Sy \[23\] 21 -- Object Diagram and Activity Diagram (no
rule) 22 - Communication Diagram and Activity Diagram If an activity
diagram specifies a flow of interaction between objects, and those
objects (or a subset of \[19\] 53 those objects) appears in a
communication diagram, then the communication diagram should specify H
Sy the same flow of interaction. 23 - Communication Diagram and Class
Diagram 54 Objects involved in a communication diagram should be
instances of classes of the class diagram. H Sy \[19, 54-56\] In order
for objects to exchange messages in a communication diagram, the sending
object must have a handle to the receiving object as specified in the
class diagram. Another way of saying this is that the \[19, 56, 55 H Sy
sender must have visibility to the receiver. A specific case of this
situation is when the sending object's 57\] class has an association
(possibly inherited) to the receiving object's class. Each class in the
class diagram appears with at least one instance in at least one
communication dia- \[16, 19, 56 H Sy gram. 54-56\] 24 -- Communication
Diagram and Use Case Diagram (no rule) 25 - Use Case Diagram and
Activity Diagram If a use case U (the including use case) includes use
case V (the included use case) in the use case diagram, and both use
case U's flows and use case V's flows are specified as activity
diagrams, then \[12, 58, 57 H Sy the activity diagram specifying use
case U should contain an action node (likely a CallBehaviorAction 59\]
node) that refers to the activity diagram specifying use case V. 58 Each
use case is described by at least one activity diagram. H Sy \[58, 59\]
Each event (flow of steps) specified or implied in the use case
description should be detailed in a cor- \[21\] 59 responding event of
the activity diagram. This rule is valid only if the activity diagram
further specifies H Sy the use case. An actor that is associated with a
use case will be an activity partition in the activity diagram
describing 67\] 60 H Sy that use case. 26 - Use Case Diagram The use
case description of a use case in the use case diagram should contain at
least one event (flow 61 of steps). Even if a use case description may
be shown/represented in a separate view respect the use H Sy \[60\] case
diagram, we consider that a use case comes with a description. An event
(flow of steps) in a use case description of a use case of the use case
diagrm has to be of either 62 a basic or an alternate type. Even if a
use case description may be shown/represented in a separate H Sy \[60\]
view respect the use case diagram, we consider that a use case comes
with a description. Each use case in the use case diagram must have a
use case description specifying event flows. Even if 63 a use case
description may be shown/represented in a separate view respect the use
case diagram, we H Sy \[23\] consider that a use case comes with a
description. 64 The name of a use case must include a verb and a noun
(for instance "Validate User"). H Sy \[53\] 28 - Class Diagram A class
invariant must be satisfied by any non-trivial instantiation of the
class diagram (i.e., an instan- \[11\] 65 H Sy tiation that is not
reduced to having no instance of any class).  The type of a relationship
between two classes at a (high) level of abstraction (e.g., plain
association, aggregation, composition, generalization) must be the same
as the type of a refinement of that rela- \[61\] 66 V Se tionship at a
more concrete (low) level of abstraction. For instance, a plain
association at a low level of abstraction being abstracted as an
aggregation (a high level of abstraction) denotes an inconsistency. A
class diagram is consistent if it can be instantiated without violating
any of the constraints in the 67 diagram (e.g., association end
multiplicities). H Sy \[62\] Two classes are equivalent if they denote
the same set of instances whenever the constraints imposed 68 by the
class diagram are satisfied. Determining equivalence of two classes
allows their merging, thus H Sy \[62\] reducing the complexity of the
diagram. A class relationship at a (low) level of abstraction must have
an abstraction at a higher level of abstrac- 69 V Se \[61, 63\] tion,
either a class or a relation. If a class relationship A refines relation
B, A must have the same destinations classes as the destination 70 V Se
\[61\] classes of the abstraction of B. 71 If a class relationship A
refines relation B, A must have the same type as B. V Se \[61\] The
group of relationships between any two high level classes must be
identical with the group of 72 relationships between their corresponding
low-level classes: ensures the same interactions among low V Se \[61\]
level classes and high-level classes. If a navigation expression is used
in an operation contract, then the expression must be a legal one \[10\]
73 H Sy (according to the syntax of the language and the class diagram).
74 This Liskov's substitution principle holds. O Se \[1, 64-66\] A class
that realizes an interface must declare all the operations in the
interface with the same signa- 75 tures (including parameter direction,
default values, concurrency, polymorphic property, query char- H Sy
\[10, 67\] acteristic). 76 An abstract operation can only belong to an
abstract class. H Sy \[28\] 77 If an operation appears in a pre or post
condition then it must have the property isQuery equal to true. H Sy
\[10\] No (public) method of a class violates, as indicated by its pre
and post-conditions, the class invariant 78 of that class. H Sy \[68\]
In a class, the names of the association ends (on the opposite side of
associations from this class) and 79 H Sy \[69\] the names of the
attributes (of the class) are different. 80 No precondition should
violate the class invariant. H Sy \[10\] 81 No post-condition should
violate the class invariant. H Sy \[10\] 82 A class that contains an
abstract operation must be abstract. H Sy \[10\] There must be no cycle
in the directed path of aggregation associations: A class cannot be a
part of an \[10\] 83 aggregation in which it is the whole; A class
cannot be a part of an aggregation in which its superclass H Sy (or
ancestor) is the whole. A class cannot be a part of more than one
composition - no composite part may be shared by two \[10\] 84 H Sy
composite classes. Each concrete class, i.e., it is not abstract, must
implement all the abstract operations of its super- \[10\] 85 H Sy
class(es). If an attribute's type is a class, then that class has to be
visible to the class containing the attribute. \[10\] 86 Example: same
package or there exists a path in the class diagram that allows the
class containing the H Sy attribute to have a hold on that type. If the
return type of an operation is a class, then that class has to be
visible to the class containing the \[10\] 87 operation. Example: same
package or there exists a path in the class diagram that allows the
class con- H Sy taining the operation to have a hold on that type. An
operation may not be overridden by a descendant class only if its isLeaf
attribute (from metaclass \[10\] 88 H Sy RedefinableElement) is defined
accordingly. A static operation cannot access an instance attribute (as
indicated by its pre and post conditions, for \[10\] 89 H Sy instance).
A static operation cannot invoke an instance operation (as indicated by
its pre and post conditions, for \[10\] 90 H Sy instance). If an
association end has a private visibility, then the class at this end can
only be accessed via the \[10\] 91 association by the class at the other
association end (e.g., as indicated by pre and post conditions of H Sy
operations of the class at this other end of the association). If an
association end has a protected visibility, then the class at this end
can only be accessed via the \[10\] 92 association, by the class at the
other association end and its descendants (e.g., as indicated by pre and
H Sy post conditions of operations of the class at this other end of the
association). The multiplicity range for an attribute must be adhered to
by all elements (operation contracts, guard \[10\] 93 H Se conditions)
that access it. For class A's operations to use another class B, as
indicated by contracts in A, there must be a means \[10\] 94 (e.g., in
the form of a path involving associations, generalization and/or
dependencies) in the class H Sy diagram for A to get a hold on B. 95 A
class at a low-level of abstraction refines at most one class from a
higher-level of abstraction. V Sy 76\] 96 A class at a high-level of
abstraction is refined by at least one class from a lower-level of
abstraction. V Sy \[63\] There should not be semantically redundant
paths between any two classes in the class diagram graph, 97 H Sy \[70\]
unless precisely specified by a constraint (e.g., specified in OCL). For
instance, from class A, it may be  possible to navigate as
self.theA.theB, along with self.theC.theB. The question is then whether
the two collections self.theA.theB and self.theC.theB are identical. 118
Parent Class should not have a Method with a Parameter referring to a
Child Class H Sy \[30\] 119 A Class should not have an Attribute which
as a Class typed as Child Class. H Sy \[30\] 29 -- Interaction Diagram
and Class Diagram (no rule) 30 - Use Case Diagram and Interaction
Diagram Each interaction diagram corresponds to a use case in the use
case diagram, and each use case in the 98 H Sy \[23\] use case diagram
is specified by an interaction diagram. If a use case is further
specified by one or more interaction diagrams, then every scenario
described in 99 one of those interaction diagrams should match a
sequence of steps in that use case's use case descrip- H Sy \[23\] tion.
31 -- Protocol State Machine Diagram and State Machine Diagram (no rule)
32 - Composite Structure Diagram A delegation connector connects a port
on the boundary of a classifier to a port on the internal structure (or
parts) of the classifier. It basically delegates signals or operation
calls arriving on the boundary port to the internal port, or those
coming from the internal port to the boundary port. Therefore, these
ports 100 at the end of the delegation connector must have the same (or
compatible) interfaces. If both ports H Sy \[71\] require the interface,
then the direction of delegation is from the boundary port to the
internal port. If both ports provide the interface, then the direction
of delegation is from the internal port to the bound- ary port. If an
assembly connector exists between two ports, one of the ports (the
source) must be a required port and the other (the destination) must be
a provided port. This rule describes the opposite case of delegation,
where both ports at the end of an assembly connector have conjugate
interfaces (one port 101 requires an interface; the other provides the
same interface). What matters is that the two ports must H Sy \[71\]
either have the same interface but one of them is marked as isConjugate,
while the other is not, or they should have conjugate interfaces (i.e.,
ones that have the same operations or signal receptions that are
annotated as provided on one interface and required on the other). If a
connector is typed with an association, the direction of the association
must conform to the direc- tion of the connector as derived from the
direction of the ports at its ends (association navigable from class A
to class B if the connector between A and B indicates that A requires
services that B provides). 102 H Sy \[71\] Given that the direction of
associations and connectors (however, it is calculated) could be encoded
using the order of their 'memberEnd' and 'end' collection, respectively,
the rule is basically saying that such direction should be the same in
both cases, if a connector is typed by an association. If a link
outgoing from a port is statically typed with an association, then the
association must be nav- 103 igable to an interface which is part of the
set of interfaces and the type indicated by the association H Sy \[71\]
must belong to the set of transported interfaces for that link. If the
link originates from a component, then the link must be statically typed
with an association, and 104 the type of the entity at the other end of
the link must be compatible with (i.e. be equal or a subtype of H Sy
\[71\] ) the type at the corresponding end of the association. 105 The
set of transported interfaces by a link should not be empty. H Sy \[71\]
If several non-typed connectors start from one port, then the sets of
interfaces transported by each of 106 H Sy \[71\] these connectors have
to be pair wise disjoint. The union of the sets of interfaces
transported by each of the connectors originating from a port P must 107
H Sy \[71\] be equal to the set of interfaces provided/required by P.
33 - Sequence Diagram and Class Diagram The type of a lifeline (type of
the connectable element of the lifeline) in a sequence diagram must not
\[10, 16\] 108 H Sy be an interface nor an abstract class. In case a
message in a sequence diagram is referring to an operation, that
operation must not be ab- 109 H Sy \[10, 16\] stract. \[10, 12, 14-17,
19, If a message in a sequence diagram refers to an operation, through
the signature of the message, then 22-24, 28, 110 that operation must
belong, as per the class diagram, to the class that types the target
lifeline of the H Sy message. 30, 31, 38, 44, 56, 60, 68, 72-86\]
Interactions between objects in a sequence diagram, specifically the
numbers of types of interacting \[15, 17, 111 objects, must comply with
the multiplicity restrictions specified by the class diagram (e.g.,
association H Sy end multiplicities). 64, 78, 87\] \[10, 14-17, 19, 22,
24, In order for objects to exchange messages in a sequence diagram, the
sending object must have a handle 25, 30, 31, to the receiving object as
specified in the class diagram. Another way of saying this is that the
sender 44, 48, 56, 112 must have visibility to the receiver. A specific
case of this situation is when the sending object's class H Sy 64, 68,
72- has an association (possibly inherited) to the receiving object's
class. 74, 76, 78, 80-84, 86- 88\]  The behavioral semantics of a
composition or aggregation association in the class diagram must be 113
inferred in sequence diagrams. For instance, in a whole-part
(composition) relation, the part should H Sy \[14, 87\] not outlive the
whole. \[16, 27, 114 Each public method in a class diagram triggers a
message in at least one sequence diagram. H Sy 31\] \[14, 15, 19, 22,
115 Each class in the class diagram must be instantiated in a sequence
diagram. H Sy 24, 55, 56, 77, 88\] No operation can be used in a message
of a sequence diagram if this breaks the visibility rules of the \[10\]
116 class diagram (public, protected, private). H Sy 34 - Sequence
Diagram and Communication Diagram (no rule) 35 - Class Diagram, State
Machine Diagram and Communication Diagram (no rule) 36 - Class Diagram,
Sequence Diagram and Use Case Diagram (no rule)

                                                REFERENCES OF CONSISTENCY RULES

\[1\] M. Stumptner and M. Schrefl, "Behavior consistent inheritance in
UML," presented at the 19th international conference on Conceptual
modeling, Salt Lake City, Utah, USA, 2000. \[2\] J. Seiter, R. Wille, U.
Kühne, and R. Drechsler, "Automatic refinement checking for formal
system models," presented at the Forum on Specification and Design
Languages (FDL), Munich, Germany, 2014. \[3\] R. Wieringa, N. Maiden, N.
Mead, and C. Rolland, "Requirements engineering paper classification and
evaluation criteria: a proposal and a discussion," Requirements Eng.,
vol. 11, pp. 102-107, 2005. \[4\] L. A. Campbell, B. H. C. Cheng, W. E.
McUmber, and R. E. K. Stirewalt, "Automatically Detecting and
Visualising Errors in UML Diagrams," Requirements Engineering, vol. 7,
pp. 264-287, 2002. \[5\] G. Engels, J. M. Küster, R. Heckel, and L.
Groenewegen, "A methodology for specifying and analyzing consistency of
object-oriented behavioral models," Sigsoft Software Engineering Notes,
vol. 26, pp. 186-195, September 2001 2001. \[6\] C. Schwarzl and B.
Peischl, "Static- and dynamic consistency analysis of UML state chart
models," presented at the 13th international conference on Model driven
engineering languages and systems: Part I, Oslo, Norway, 2010. \[7\] H.
Qiu, "Consistency Checking of UML-LIGHT with CSP," WS 2004/2005: Seminar
: Modellbasierte Softwareentwichklung Department of Computer Science,
University of Paderborn, Paderborn, Germany 2004. \[8\] G. Costagliola,
V. Deufemia, F. Ferrucci, and C. Gravino, "Exploiting Visual Languages
Generation and UML Meta Modeling to Construct Meta- CASE Workbenches,"
Electronic Notes in Theoretical Computer Science, vol. 72, pp. 25-35,
2003. \[9\] Z. Pap, I. Majzik, A. Pataricza, and A. Szegi, "Methods of
checking general safety criteria in UML statechart specifications,"
Reliability Engineering & System Safety, vol. 87, pp. 89-107, 2005.
\[10\] L. C. Briand, Y. Labiche, and L. O'Sullivan, "Impact analysis and
change management of UML models," presented at the International
Conference on Software Maintenance, Amsterdam, The Netherlands, 2003.
\[11\] E. Astesiano and G. Reggio, "An attempt at analysing the
consistency problems in the UML from a classical algebraic viewpoint,"
presented at the 16th International Workshop, Frauenchiemsee, Germany,
2003. \[12\] P. G. Sapna and H. Mohanty, "Ensuring consistency in
relational repository of UML models," presented at the 10th
International Conference on Information Technology, Orissa, India, 2007.
\[13\] C. F. Borba and A. E. A. Da SIlva, "Knowledge-based system for
the maintenance registration and consistency among UML diagrams,"
presented at the 20th Brazilian Conference on Advances in Artificial
Intelligence, São Bernardo do Campo, Brazil, 2010. \[14\] M. Hilsbos and
I.-Y. Song, "Use of Tabular Analysis Method to Construct UML Sequence
Diagrams," presented at the 23th International Conference on Conceptual
Modeling, Shanghai, China, 2004. \[15\] J. Yang, Q. Long, Z. Liu, and X.
Li, "A predicative semantic model for integrating UML models," presented
at the 1st international Conference on Theoretical Aspects of Computing,
Guiyang, China, 2004. \[16\] R. F. Paige, D. S. Kolovos, and F. A. C.
Polack, "Refinement via Consistency Checking in MDA," Electronic Notes
in Theoretical Computer Science, vol. 137, pp. 151-161, 2005. \[17\] L.
Quan, L. Zhiming, L. Xiaoshan, and J. He, "Consistent code generation
from UML models," presented at the Australian Conference on Software
Engineering, Brisbane, Australia, 2005. \[18\] J. H. Hausmann, R.
Heckel, and S. Sauer, "Extended model relations with graphical
consistency conditions," presented at the UML 2002 Workshop on
Consistency Problems in UML-based Software Development, Blekinge
Institute of Technology, 2002. \[19\] A. Ohnishi, "A supporting system
for verification among models of the UML," Systems and Computers in
Japan, vol. 33, pp. 1-3, April 2002 2002. \[20\] J. Chanda, A. Kanjilal,
S. Sengupta, and S. Bhattacharya, "Traceability of requirements and
consistency verification of UML use case, activity and Class diagram: A
Formal approach," presented at the International Conference on Methods
and Models in Computer Science, New Delhi, India, 2009. \[21\] A.
Kanjilal, S. Sengupta, and S. Bhattacharya, "Analysis of object-oriented
design: A metrics based approach," presented at the IEEE Region 10
Annual International Conference, Singapore; Singapore, 2009. \[22\] X.
Liu, "Identification and check of inconsistencies between UML diagrams,"
presented at the 2013 International Conference on Computer Sciences and
Applications, 2013. \[23\] Y. Labiche, "The UML is more than boxes and
lines," presented at the Workshops and Symposia at MODELS 2008,
Toulouse, France, 2008. \[24\] H. Il-Kyu and K. Byung-Wook,
"Meta-validation of UML structural diagrams and behavioral diagrams with
consistency rules," presented at the IEEE Pacific Rim Conference on
Communications, Computers and signal Processing, Victoria, B.C., Canada,
2003. \[25\] S. K. Kim and D. Carrington, "A formal object-oriented
approach to defining consistency constraints for UML models," presented
at the Australian Conference on Software Engineering, Melbourne,
Australia, 2004. \[26\] X. Xia, J. Shi, Z. Fan, Z. Ai, and Y. Dong, "A
Consistency Checking Approach for System Architecture," presented at the
Annual IEEE Systems Conference (SysCon), Orlando, FL, USA, 2016 \[27\]
J. Kienzle, W. A. Abed, and J. Klein, "Aspect-oriented multi-view
modeling," presented at the 8th ACM international conference on Aspect-
oriented software development, Charlottesville, Virginia, USA, 2009.
\[28\] O. Vasilecas, R. Dubauskaitė, and R. Rupnik, "Consistency
checking of UML business model," Technological and Economic Development
of Economy, vol. 17, pp. 133-150, 2011. \[29\] J. Yang, "A framework for
formalizing UML models with formal language rCOS," presented at the 4th
International Conference on Frontier of Computer Science and Technology,
Shanghai, China, 2009. \[30\] A. Reder and A. Egyed, "Determining the
Cause of a Design Model Inconsistency," IEEE Trans. Softw. Eng. ,
vol. 39, pp. 1531-1548, November 2013 2013. \[31\] I. Zaretska, O.
Kulankhina, and H. Mykhailenko, "Cross-Diagram UML Design Verification,"
presented at the ICT in Education, Research, and Industrial Applications
(ICTERI), 2013. \[32\] N. Pattanasri, V. Wuwongse, and K. Akama, "XET as
a Rule Language for Consistency Maintenance in UML," presented at the
3rd International Workshop, Hiroshima, Japan, 2004. \[33\] A. Zisman and
A. Kozlenkov, "Knowledge Base Approach to Consistency Management of UML
Specifications," presented at the 16th IEEE international conference on
Automated software engineering, Coronado Island, San Diego, CA, USA,
2001. \[34\] F. J. L. Martínez and A. T. Álvarez, "A precise approach
for the analysis of the UML models consistency," presented at the 24th
international conference on Perspectives in Conceptual Modeling,
Klagenfurt, Austria, 2005. \[35\] B. Bjørn, "Consistency checking UML
interactions and state machines," Master Thesis, Department of
Informatics, University of Oslo, Oslo, Norway, 2008. \[36\] D. Du, J.
Liu, H. Cao, and M. Zhang, "BAS: A Case Study for Modeling and
Verification in Trustable Model Driven Development," Electronic Notes in
Theoretical Computer Science, vol. 243, pp. 69-87, July 2009 2009.
\[37\] D. Ruta and V. Olegas, "The approach of ensuring consistency of
UML model based on rules," presented at the 11th International
Conference on Computer Systems and Technologies and Workshop for PhD
Students in Computing on International Conference on Computer Systems
and Technologies, Sofia, Bulgaria, 2010. \[38\] A. Egyed, "Fixing
Inconsistencies in UML Design Models," presented at the 29th
international conference on Software Engineering Minneapolis, MN, USA,
2007. \[39\] H. Wang, T. Feng, J. Zhang, and K. Zhang, "Consistency
check between behaviour models," presented at the International
Symposium on Communications and Information Technology, Beijing, China,
2005. \[40\] P. Pelliccione, P. Inverardi, and H. Muccini, "CHARMY: A
Framework for Designing and Verifying Architectural Specifications,"
IEEE Transactions on Software Engineering, vol. 35, pp. 325-346, 2009.
\[41\] J. Kuster and J. Stroop, "Consistent design of embedded real-time
systems with UML-RT," presented at the 4th International Symposium on
Object-Oriented Real-Time Distributed Computing, Magdeburg, Germany,
2001. \[42\] W. Shengjun, J. Longfei, and J. Chengzhi, "Ontology
Definition Metamodel based Consistency Checking of UML Models,"
presented at the 10th International Conference on Computer Supported
Cooperative Work in Design, Nanjing, China, 2006. \[43\] K. N. Chang,
"Model checking consistency between sequence and state diagrams,"
presented at the International Conference on Software Engineering
Research and Practice, Las Vegas, NV, USA, 2008. \[44\] A. Egyed, E.
Letier, and A. Finkelstein, "Generating and evaluating choices for
fixing inconsistencies in UML design models," presented at the 23rd
IEEE/ACM International Conference on Automated Software Engineering,
L'Aquila, Italy, 2008. \[45\] A. Nimiya, T. Yokogawa, H. Miyazaki, S.
Amasaki, Y. Sato, and M. Hayase, "Model checking consistency of UML
diagrams using alloy," World Academy of Science, Engineering and
Technology, vol. 71, pp. 547-550, 2010. \[46\] X. Zhao, Q. Long, and Z.
Qiu, "Model checking dynamic UML consistency," presented at the 8th
International Conference on Formal Engineering Methods, Macao, China,
2006. \[47\] Y. Hammal, "A modular state exploration and compatibility
checking of UML dynamic diagrams," presented at the 6th IEEE/ACS
International Conference on Computer Systems and Applications, Doha,
Qatar, 2008. \[48\] K. Lano, "Formal specification using interaction
diagrams," presented at the 5th IEEE International Conference on
Software Engineering and Formal Methods, London; United Kingdom, 2007.
\[49\] M. N. Alanazi and D. A. Gustafson, "Super state analysis for UML
state diagrams," presented at the 2009 WRI World Congress on Computer
Science and Information Engineering Los Angeles, California, USA, 2009.
\[50\] T. Yokogawa, S. Amasaki, K. Okazaki, Y. Sato, K. Arimoto, and H.
Miyazaki, "Consistency Verification of UML Diagrams Based on Process
Bisimulation," presented at the IEEE 19th Pacific Rim International
Symposium on Dependable Computing (PRDC), 2013. \[51\] A. Knapp, T.
Mossakowski, and M. Roggenbach, "Towards an Institutional Framework for
Heterogeneous Formal Development in UML," Software, Services, and
Systems, pp. 215-230, 2015. \[52\] H. Nakanishi, T. Miura, and I.
Shioya, "Formalizing UML collaborations by using description logics,"
presented at the 2nd IEEE International Conference on Computational
Cybernetics, Vienna, Austria, 2004. \[53\] C. M. Zapata, G. González,
and A. Gelbukh, "A rule-based system for assessing consistency between
UML models," presented at the 6th Mexican International Conference on
Advances in Artificial Intelligence, Aguascalientes, Mexico, 2007.
\[54\] R. g. Laleau and F. Polack, "Using formal metamodels to check
consistency of functional views in information systems specification,"
Information and Software Technology, vol. 50, pp. 797-814, 2008. \[55\]
R. F. Paige, P. J. Brooke, and J. S. Ostroff, "Metamodel-based model
conformance and multiview consistency checking," ACM Transactions
Software Engineering Methodology, vol. 16, p. 11, July 2007 2007. \[56\]
H. Il-kyu and B. Kang, "Cross Checking Rules to Improve Consistency
between UML Static Diagram and Dynamic Diagram," presented at the 9th
International Conference on Intelligent Data Engineering and Automated
Learning, Daejeon, South Korea, 2008. \[57\] H. Hamed and A. Salem,
"UML-L: a UML based design description language," presented at the
ACS/IEEE International Conference on Computer Systems and Applications,
Beirut, Lebanon, 2001. \[58\] T. Mens, R. Van Der Straeten, and M.
D'Hondt, "Detecting and resolving model inconsistencies using
transformation dependency analysis," presented at the 9th International
conference on Model Driven Engineering Languages and Systems, Genova,
Italy, 2006. \[59\] N. Ibrahim, R. Ibrahim, M. Z. Saringat, D. Mansor,
and T. Herawan, "Consistency rules between UML use case and activity
diagrams using logical approach," International Journal of Software
Engineering and its Applications, vol. 5, pp. 119-134, 2011. \[60\] S.
Sengupta and S. Bhattacharya, "Formalization of UML diagrams and their
consistency verification: A Z notation based approach," presented at the
1st India software engineering conference, Hyderabad, India, 2008.
\[61\] A. Egyed, "Consistent adaptation and evolution of class diagrams
during refinement," presented at the 7th International Conference (FASE
2004), Held as Part of the Joint European Conferences on Theory and
Practice of Software, Barcelona, Spain, 2004. \[62\] A. Calì, D.
Calvanese, G. De Giacomo, and M. Lenzerini, "A Formal Framework for
Reasoning on UML Class Diagrams," presented at the 13th International
Symposium on Foundations of Intelligent Systems, Lyon, France, 2002.
\[63\] W. Shen, K. Wang, and A. Egyed, "An efficient and scalable
approach to correct class model refinement," IEEE Transactions on
Software Engineering, vol. 35, pp. 515-533, 2009. \[64\] R. Van Der
Straeten, "Inconsistency detection between UML models using RACER and
nRQL," presented at the the KI-2004 Workshop on Applications of
Description Logics, Ulm, Germany, 2004. \[65\] G. Engels, R. Heckel, and
J. M. Küster, "Rule-Based Specification of Behavioral Consistency Based
on the UML Meta-model," presented at the 4th International Conference on
The Unified Modeling Language, Modeling Languages, Concepts, and Tools,
Toronto, Ontario, Canada, 2001. \[66\] R. Van Der Straeten, V. Jonckers,
and T. Mens, "A formal approach to model refactoring and model
refinement," Software & Systems Modeling, vol. 6, pp. 139-162, 2007.
\[67\] R. Wagner, H. Giese, and U. Nickel, "A plug-in for flexible and
incremental consistency management," presented at the International
Conference on the Unified Modeling Language 2003 (Workshop 7:
Consistency Problems in UML-based Software Development), San Francisco,
USA, 2003. \[68\] L. Jing, L. Zhiming, H. Jifeng, and L. Xiaoshan,
"Linking UML models of design and requirement," presented at the
Australian Conference on Software Engineering, Melbourne, Australia,
2004. \[69\] K. C. Lavanya, K. V. Bala, H. Mohanty, and R. K.
Shyamasundar, "How Good is a UML Diagram? A Tool to Check It," presented
at the IEEE Region 10, Melbourne, Australia, 2005. \[70\] M. Snoeck, C.
Michiels, and G. Dedene, "Consistency by construction: the case of
MERODE," presented at the Conceptual Modeling for Novel Application
Domains, Workshops ECOMO, IWCMQ, AOIS, and XSDM, Chicago, IL, USA, 2003.
\[71\] I. Ober and I. Dragomir, "Unambiguous UML composite structures:
the OMEGA2 experience," presented at the 37th international conference
on Current trends in theory and practice of computer science, Nový
Smokovec, Slovakia, 2011. \[72\] G. Spanoudakis and H. Kim, "Diagnosis
of the significance of inconsistencies in object-oriented designs: a
framework and its experimental evaluation," Journal of Systems and
Software, vol. 64, pp. 3-22, October 2002 2002. \[73\] A. Egyed,
"UML/Analyzer: A Tool for the Instant Consistency Checking of UML
Models" presented at the 29th international conference on Software
Engineering, Minneapolis, MN, USA, 2007. \[74\] A. Egyed, "Instant
consistency checking for the UML," presented at the 28th international
conference on Software engineering, Shanghai, China, 2006. \[75\] H.
Ledang, "B-based Consistency Checking of UML Diagrams," presented at the
2nd National Symposium on Research, Development and Application of
Information and Communication Technology, Hanoi, Vietnam, 2004. \[76\]
R. Van Der Straeten, "ALLOY for Inconsistency Resolution in MDE,"
presented at the BENEVOL 2009 The 8 th BElgian-NEtherlands software
eVOLution seminar, Université catholique de Louvain - Belgium, 2009.
\[77\] J. Chanda, T. Janowski, H. Mohanty, A. Kanjilal, and S. Sengupta,
"UML-Compiler: A Framework for Syntactic and Semantic Verification of
UML Diagrams," presented at the 6th international conference on
Distributed Computing and Internet Technology, Bhubaneswar, India, 2010.
\[78\] Z. Khai, A. Nadeem, and G.-s. Lee, "A Prolog Based Approach to
Consistency Checking of UML Class and Sequence Diagrams," presented at
the Communication and Networking - International Conference (FGCN 2011),
Held as Part of the Future Generation Information Technology  Conference
(FGIT 2011), in Conjunction with GDC 2011, Jeju Island, South Korea,
2011. \[79\] I.-Y. Song, R. Khare, Y. An, and M. Hilsbos, "A Multi-level
Methodology for Developing UML Sequence Diagrams," presented at the 27th
International Conference on Conceptual Modeling, Barcelona, Spain, 2008.
\[80\] R. Van Der Straeten, T. Mens, J. Simmonds, and V. Jonckers,
"Using Description Logic to Maintain Consistency between UML Models,"
presented at the 6th International Conference on Unified Modeling
Language, Modeling Languages and Applications, San Francisco, CA, USA,
2003. \[81\] J. Muskens, R. J. Bril, and M. R. V. Chaudron,
"Generalizing Consistency Checking between Software Views," presented at
the 5th Working IEEE/IFIP Conference on Software Architecture,
Pittsburgh, Pennsylvania, USA, 2005. \[82\] L. Xiaoshan, L. Zhiming, and
J. He, "A formal semantics of UML sequence diagram," presented at the
Australian Conference on Software Engineering, Melbourne, Australia,
2004. \[83\] G. Spanoudakis, K. Kasis, and F. Dragazi, "Evidential
diagnosis of inconsistencies in object-oriented designs," International
Journal of Software Engineering and Knowledge Engineering, vol. 14,
pp. 141-178, 2004. \[84\] A. Reder and A. Egyed, "Computing repair trees
for resolving inconsistencies in design models," presented at the 27th
IEEE/ACM International Conference on Automated Software Engineering,
Essen, Germany, 2012. \[85\] O. Vasilecas and R. Dubauskaite, "Ensuring
consistency of information systems rules models," presented at the
International Conference on Computer Systems and Technologies and
Workshop for PhD Students in Computing, Ruse, Bulgaria, 2009. \[86\] D.
Allaki, M. Dahchou, and A. En-Nouaary, "Detecting and fixing UML model
inconsistencies using constraints," presented at the 4th IEEE
International Colloquium on Information Science and Technology (CiSt),
2016. \[87\] O. Pilskalns, D. Williams, D. Aracic, and A. Andrews,
"Security Consistency in UML Designs," presented at the 30th Annual
International Computer Software and Applications Conference, Chicago,
USA, 2006. \[88\] C. F. J. Lange and M. R. V. Chaudron, "Effects of
defects in UML models: an experimental investigation," presented at the
28th international conference on Software engineering, Shanghai, China,
2006. APPENDIX B As follows, we present the list of the 105 primary
studies of our SMS \[PS 1-105\]:

\[PS 1\] A. Egyed, "Semantic abstraction rules for class diagrams,"
presented at the 15th IEEE international conference on Automated
software engineering, Grenoble, France, 2000. \[PS 2\] D. C. Petriu and
Y. Sun, "Consistent behaviour representation in activity and sequence
diagrams," presented at the 3rd International conference on The unified
modeling language: advancing the standard, York, UK, 2000. \[PS 3\] M.
Stumptner and M. Schrefl, "Behavior consistent inheritance in UML,"
presented at the 19th international conference on Conceptual modeling,
Salt Lake City, Utah, USA, 2000. \[PS 4\] G. Engels, R. Heckel, and J.
M. Küster, "Rule-Based Specification of Behavioral Consistency Based on
the UML Meta-model," presented at the 4th International Conference on
The Unified Modeling Language, Modeling Languages, Concepts, and Tools,
Toronto, Ontario, Canada, 2001. \[PS 5\] G. Engels, J. M. Küster, R.
Heckel, and L. Groenewegen, "A methodology for specifying and analyzing
consistency of object-oriented behavioral models," Sigsoft Software
Engineering Notes, vol. 26, pp. 186-195, September 2001 2001. \[PS 6\]
H. Hamed and A. Salem, "UML-L: a UML based design description language,"
presented at the ACS/IEEE International Conference on Computer Systems
and Applications, Beirut, Lebanon, 2001. \[PS 7\] J. Kuster and J.
Stroop, "Consistent design of embedded real-time systems with UML-RT,"
presented at the 4th International Symposium on Object-Oriented
Real-Time Distributed Computing, Magdeburg, Germany, 2001. \[PS 8\] A.
Zisman and A. Kozlenkov, "Knowledge Base Approach to Consistency
Management of UML Specifications," presented at the 16th IEEE
international conference on Automated software engineering, Coronado
Island, San Diego, CA, USA, 2001. \[PS 9\] A. Calì, D. Calvanese, G. De
Giacomo, and M. Lenzerini, "A Formal Framework for Reasoning on UML
Class Diagrams," presented at the 13th International Symposium on
Foundations of Intelligent Systems, Lyon, France, 2002. \[PS 10\] L. A.
Campbell, B. H. C. Cheng, W. E. McUmber, and R. E. K. Stirewalt,
"Automatically Detecting and Visualising Errors in UML Diagrams,"
Requirements Engineering, vol. 7, pp. 264-287, 2002. \[PS 11\] J. H.
Hausmann, R. Heckel, and S. Sauer, "Extended model relations with
graphical consistency conditions," presented at the UML 2002 Workshop on
Consistency Problems in UML-based Software Development, Blekinge
Institute of Technology, 2002. \[PS 12\] A. Ohnishi, "A supporting
system for verification among models of the UML," Systems and Computers
in Japan, vol. 33, pp. 1-3, April 2002 2002. \[PS 13\] G. Spanoudakis
and H. Kim, "Diagnosis of the significance of inconsistencies in
object-oriented designs: a framework and its experimental evaluation,"
Journal of Systems and Software, vol. 64, pp. 3-22, October 2002 2002.
\[PS 14\] E. Astesiano and G. Reggio, "An attempt at analysing the
consistency problems in the UML from a classical algebraic viewpoint,"
presented at the 16th International Workshop, Frauenchiemsee, Germany,
2003. \[PS 15\] L. C. Briand, Y. Labiche, and L. O'Sullivan, "Impact
analysis and change management of UML models," presented at the
International Conference on Software Maintenance, Amsterdam, The
Netherlands, 2003. \[PS 16\] G. Costagliola, V. Deufemia, F. Ferrucci,
and C. Gravino, "Exploiting Visual Languages Generation and UML Meta
Modeling to Construct Meta- CASE Workbenches," Electronic Notes in
Theoretical Computer Science, vol. 72, pp. 25-35, 2003. \[PS 17\] H.
Il-Kyu and K. Byung-Wook, "Meta-validation of UML structural diagrams
and behavioral diagrams with consistency rules," presented at the IEEE
Pacific Rim Conference on Communications, Computers and signal
Processing, Victoria, B.C., Canada, 2003. \[PS 18\] B. Litvak, S.
Tyszberowicz, and A. Yehudai, "Behavioral consistency validation of UML
diagrams," presented at the 1st International Conference on Software
Engineering and Formal Methods, Brisbane, Australia, 2003. \[PS 19\] H.
Rasch and H. Wehrheim, "Checking Consistency in UML Diagrams: Classes
and State Machines," presented at the 6th IFIP WG 6.1 International
Conference, Paris, France, 2003. \[PS 20\] M. Snoeck, C. Michiels, and
G. Dedene, "Consistency by construction: the case of MERODE," presented
at the Conceptual Modeling for Novel Application Domains, Workshops
ECOMO, IWCMQ, AOIS, and XSDM, Chicago, IL, USA, 2003. \[PS 21\] R. Van
Der Straeten, T. Mens, J. Simmonds, and V. Jonckers, "Using Description
Logic to Maintain Consistency between UML Models," presented at the 6th
International Conference on Unified Modeling Language, Modeling
Languages and Applications, San Francisco, CA, USA, 2003. \[PS 22\] R.
Wagner, H. Giese, and U. Nickel, "A plug-in for flexible and incremental
consistency management," presented at the International Conference on
the Unified Modeling Language 2003 (Workshop 7: Consistency Problems in
UML-based Software Development), San Francisco, USA, 2003. \[PS 23\] D.
Chiorean, M. Pasca, A. Carcu, C. Botiza, and S. Moldovan, "Ensuring UML
Models Consistency Using the OCL Environment," Electronic Notes in
Theoretical Computer Science, vol. 102, pp. 99-110, November 2004 2004.
\[PS 24\] A. Egyed, "Consistent adaptation and evolution of class
diagrams during refinement," presented at the 7th International
Conference (FASE 2004), Held as Part of the Joint European Conferences
on Theory and Practice of Software, Barcelona, Spain, 2004. \[PS 25\] M.
Hilsbos and I.-Y. Song, "Use of Tabular Analysis Method to Construct UML
Sequence Diagrams," presented at the 23th International Conference on
Conceptual Modeling, Shanghai, China, 2004. \[PS 26\] L. Jing, L.
Zhiming, H. Jifeng, and L. Xiaoshan, "Linking UML models of design and
requirement," presented at the Australian Conference on Software
Engineering, Melbourne, Australia, 2004. \[PS 27\] S. K. Kim and D.
Carrington, "A formal object-oriented approach to defining consistency
constraints for UML models," presented at the Australian Conference on
Software Engineering, Melbourne, Australia, 2004. \[PS 28\] H. Ledang,
"B-based Consistency Checking of UML Diagrams," presented at the 2nd
National Symposium on Research, Development and Application of
Information and Communication Technology, Hanoi, Vietnam, 2004. \[PS
29\] H. Nakanishi, T. Miura, and I. Shioya, "Formalizing UML
collaborations by using description logics," presented at the 2nd IEEE
International Conference on Computational Cybernetics, Vienna, Austria,
2004. \[PS 30\] N. Pattanasri, V. Wuwongse, and K. Akama, "XET as a Rule
Language for Consistency Maintenance in UML," presented at the 3rd
International Workshop, Hiroshima, Japan, 2004. \[PS 31\] H. Qiu,
"Consistency Checking of UML-LIGHT with CSP," WS 2004/2005: Seminar :
Modellbasierte Softwareentwichklung Department of Computer Science,
University of Paderborn, Paderborn, Germany 2004. \[PS 32\] G.
Spanoudakis, K. Kasis, and F. Dragazi, "Evidential diagnosis of
inconsistencies in object-oriented designs," International Journal of
Software Engineering and Knowledge Engineering, vol. 14, pp. 141-178,
2004. \[PS 33\] R. Van Der Straeten, "Inconsistency detection between
UML models using RACER and nRQL," presented at the the KI-2004 Workshop
on Applications of Description Logics, Ulm, Germany, 2004. \[PS 34\] L.
Xiaoshan, L. Zhiming, and J. He, "A formal semantics of UML sequence
diagram," presented at the Australian Conference on Software
Engineering, Melbourne, Australia, 2004. \[PS 35\] J. Yang, Q. Long, Z.
Liu, and X. Li, "A predicative semantic model for integrating UML
models," presented at the 1st international Conference on Theoretical
Aspects of Computing, Guiyang, China, 2004. \[PS 36\] K. C. Lavanya, K.
V. Bala, H. Mohanty, and R. K. Shyamasundar, "How Good is a UML Diagram?
A Tool to Check It," presented at the IEEE Region 10, Melbourne,
Australia, 2005. \[PS 37\] F. J. L. Martínez and A. T. Álvarez, "A
precise approach for the analysis of the UML models consistency,"
presented at the 24th international conference on Perspectives in
Conceptual Modeling, Klagenfurt, Austria, 2005. \[PS 38\] J. Muskens, R.
J. Bril, and M. R. V. Chaudron, "Generalizing Consistency Checking
between Software Views," presented at the 5th Working IEEE/IFIP
Conference on Software Architecture, Pittsburgh, Pennsylvania, USA,
2005. \[PS 39\] R. F. Paige, D. S. Kolovos, and F. A. C. Polack,
"Refinement via Consistency Checking in MDA," Electronic Notes in
Theoretical Computer Science, vol. 137, pp. 151-161, 2005. \[PS 40\] Z.
Pap, I. Majzik, A. Pataricza, and A. Szegi, "Methods of checking general
safety criteria in UML statechart specifications," Reliability
Engineering & System Safety, vol. 87, pp. 89-107, 2005. \[PS 41\] L.
Quan, L. Zhiming, L. Xiaoshan, and J. He, "Consistent code generation
from UML models," presented at the Australian Conference on Software
Engineering, Brisbane, Australia, 2005. \[PS 42\] H. Wang, T. Feng, J.
Zhang, and K. Zhang, "Consistency check between behaviour models,"
presented at the International Symposium on Communications and
Information Technology, Beijing, China, 2005. \[PS 43\] M. Balaban and
A. Maraee, "Consistency of UML class diagrams with hierarchy
constraints," presented at the 6th international Conference on Next
Generation Information Technologies and Systems, Kibbutz Shefayim,
Israel, 2006. \[PS 44\] A. Egyed, "Instant consistency checking for the
UML," presented at the 28th international conference on Software
engineering, Shanghai, China, 2006. \[PS 45\] C. F. J. Lange and M. R.
V. Chaudron, "Effects of defects in UML models: an experimental
investigation," presented at the 28th international conference on
Software engineering, Shanghai, China, 2006. \[PS 46\] H. Malgouyres and
G. Motet, "A UML model consistency verification approach based on
meta-modeling formalization," presented at the ACM symposium on Applied
computing, Dijon, France, 2006. \[PS 47\] T. Mens, R. Van Der Straeten,
and M. D'Hondt, "Detecting and resolving model inconsistencies using
transformation dependency analysis," presented at the 9th International
conference on Model Driven Engineering Languages and Systems, Genova,
Italy, 2006. \[PS 48\] O. Pilskalns, D. Williams, D. Aracic, and A.
Andrews, "Security Consistency in UML Designs," presented at the 30th
Annual International Computer Software and Applications Conference,
Chicago, USA, 2006. \[PS 49\] W. Shengjun, J. Longfei, and J. Chengzhi,
"Ontology Definition Metamodel based Consistency Checking of UML
Models," presented at the 10th International Conference on Computer
Supported Cooperative Work in Design, Nanjing, China, 2006. \[PS 50\] M.
Szlenk, "Formal Semantics and Reasoning about UML Class Diagram,"
presented at the International Conference on Dependability of Computer
Systems, Szklarska Poręba, Poland, 2006. \[PS 51\] R. Van Der Straeten
and M. D'Hondt, "Model refactorings through rule-based inconsistency
resolution," presented at the ACM symposium on Applied computing, Dijon,
France, 2006. \[PS 52\] X. Zhao, Q. Long, and Z. Qiu, "Model checking
dynamic UML consistency," presented at the 8th International Conference
on Formal Engineering Methods, Macao, China, 2006. \[PS 53\] A. Egyed,
"Fixing Inconsistencies in UML Design Models," presented at the 29th
international conference on Software Engineering Minneapolis, MN, USA,
2007. \[PS 54\] A. Egyed, "UML/Analyzer: A Tool for the Instant
Consistency Checking of UML Models" presented at the 29th international
conference on Software Engineering, Minneapolis, MN, USA, 2007. \[PS
55\] F. Lagarde, H. Espinoza, F. Terrier, and S. Gérard, "Improving uml
profile design practices by leveraging conceptual domain models,"
presented at the 22nd IEEE/ACM international conference on Automated
software engineering, Atlanta, Georgia, USA, 2007. \[PS 56\] K. Lano,
"Formal specification using interaction diagrams," presented at the 5th
IEEE International Conference on Software Engineering and Formal
Methods, London; United Kingdom, 2007. \[PS 57\] R. F. Paige, P. J.
Brooke, and J. S. Ostroff, "Metamodel-based model conformance and
multiview consistency checking," ACM Transactions Software Engineering
Methodology, vol. 16, p. 11, July 2007 2007. \[PS 58\] P. G. Sapna and
H. Mohanty, "Ensuring consistency in relational repository of UML
models," presented at the 10th International Conference on Information
Technology, Orissa, India, 2007. \[PS 59\] R. Van Der Straeten, V.
Jonckers, and T. Mens, "A formal approach to model refactoring and model
refinement," Software & Systems Modeling, vol. 6, pp. 139-162, 2007.
\[PS 60\] C. M. Zapata, G. González, and A. Gelbukh, "A rule-based
system for assessing consistency between UML models," presented at the
6th Mexican International Conference on Advances in Artificial
Intelligence, Aguascalientes, Mexico, 2007. \[PS 61\] B. Bjørn,
"Consistency checking UML interactions and state machines," Master
Thesis, Department of Informatics, University of Oslo, Oslo, Norway,
2008. \[PS 62\] K. N. Chang, "Model checking consistency between
sequence and state diagrams," presented at the International Conference
on Software Engineering Research and Practice, Las Vegas, NV, USA, 2008.
\[PS 63\] A. Egyed, E. Letier, and A. Finkelstein, "Generating and
evaluating choices for fixing inconsistencies in UML design models,"
presented at the 23rd IEEE/ACM International Conference on Automated
Software Engineering, L'Aquila, Italy, 2008. \[PS 64\] Y. Hammal, "A
modular state exploration and compatibility checking of UML dynamic
diagrams," presented at the 6th IEEE/ACS International Conference on
Computer Systems and Applications, Doha, Qatar, 2008. \[PS 65\] H.
Il-kyu and B. Kang, "Cross Checking Rules to Improve Consistency between
UML Static Diagram and Dynamic Diagram," presented at the 9th
International Conference on Intelligent Data Engineering and Automated
Learning, Daejeon, South Korea, 2008. \[PS 66\] Y. Labiche, "The UML is
more than boxes and lines," presented at the Workshops and Symposia at
MODELS 2008, Toulouse, France, 2008. \[PS 67\] R. g. Laleau and F.
Polack, "Using formal metamodels to check consistency of functional
views in information systems specification," Information and Software
Technology, vol. 50, pp. 797-814, 2008. \[PS 68\] S. Sengupta and S.
Bhattacharya, "Formalization of UML diagrams and their consistency
verification: A Z notation based approach," presented at the 1st India
software engineering conference, Hyderabad, India, 2008. \[PS 69\] I.-Y.
Song, R. Khare, Y. An, and M. Hilsbos, "A Multi-level Methodology for
Developing UML Sequence Diagrams," presented at the 27th International
Conference on Conceptual Modeling, Barcelona, Spain, 2008. \[PS 70\] M.
N. Alanazi and D. A. Gustafson, "Super state analysis for UML state
diagrams," presented at the 2009 WRI World Congress on Computer Science
and Information Engineering Los Angeles, California, USA, 2009. \[PS
71\] J. Chanda, A. Kanjilal, S. Sengupta, and S. Bhattacharya,
"Traceability of requirements and consistency verification of UML use
case, activity and Class diagram: A Formal approach," presented at the
International Conference on Methods and Models in Computer Science, New
Delhi, India, 2009. \[PS 72\] Z. Chen and G. Motet, "A
language-theoretic view on guidelines and consistency rules of UML,"
presented at the 5th European Conference, Enschede, The Netherlands,
2009. \[PS 73\] D. Du, J. Liu, H. Cao, and M. Zhang, "BAS: A Case Study
for Modeling and Verification in Trustable Model Driven Development,"
Electronic Notes in Theoretical Computer Science, vol. 243, pp. 69-87,
July 2009 2009. \[PS 74\] A. Kanjilal, S. Sengupta, and S. Bhattacharya,
"Analysis of object-oriented design: A metrics based approach,"
presented at the IEEE Region 10 Annual International Conference,
Singapore; Singapore, 2009. \[PS 75\] J. Kienzle, W. A. Abed, and J.
Klein, "Aspect-oriented multi-view modeling," presented at the 8th ACM
international conference on Aspect- oriented software development,
Charlottesville, Virginia, USA, 2009. \[PS 76\] P. Pelliccione, P.
Inverardi, and H. Muccini, "CHARMY: A Framework for Designing and
Verifying Architectural Specifications," IEEE Transactions on Software
Engineering, vol. 35, pp. 325-346, 2009. \[PS 77\] W. Shen, K. Wang, and
A. Egyed, "An efficient and scalable approach to correct class model
refinement," IEEE Transactions on Software Engineering, vol. 35,
pp. 515-533, 2009. \[PS 78\] R. Van Der Straeten, "ALLOY for
Inconsistency Resolution in MDE," presented at the BENEVOL 2009 The 8 th
BElgian-NEtherlands software eVOLution seminar, Université catholique de
Louvain - Belgium, 2009. \[PS 79\] O. Vasilecas and R. Dubauskaite,
"Ensuring consistency of information systems rules models," presented at
the International Conference on Computer Systems and Technologies and
Workshop for PhD Students in Computing, Ruse, Bulgaria, 2009. \[PS 80\]
J. Yang, "A framework for formalizing UML models with formal language
rCOS," presented at the 4th International Conference on Frontier of
Computer Science and Technology, Shanghai, China, 2009. \[PS 81\] C. F.
Borba and A. E. A. Da SIlva, "Knowledge-based system for the maintenance
registration and consistency among UML diagrams," presented at the 20th
Brazilian Conference on Advances in Artificial Intelligence, São
Bernardo do Campo, Brazil, 2010. \[PS 82\] J. Chanda, T. Janowski, H.
Mohanty, A. Kanjilal, and S. Sengupta, "UML-Compiler: A Framework for
Syntactic and Semantic Verification of UML Diagrams," presented at the
6th international conference on Distributed Computing and Internet
Technology, Bhubaneswar, India, 2010. \[PS 83\] K. Kaneiwa and K. Satoh,
"On the complexities of consistency checking for restricted UML class
diagrams," Theoretical Computer Science, vol. 411, pp. 301-323, January
2010 2010. \[PS 84\] A. Nimiya, T. Yokogawa, H. Miyazaki, S. Amasaki, Y.
Sato, and M. Hayase, "Model checking consistency of UML diagrams using
alloy," World Academy of Science, Engineering and Technology, vol. 71,
pp. 547-550, 2010. \[PS 85\] D. Ruta and V. Olegas, "The approach of
ensuring consistency of UML model based on rules," presented at the 11th
International Conference on Computer Systems and Technologies and
Workshop for PhD Students in Computing on International Conference on
Computer Systems and  Technologies, Sofia, Bulgaria, 2010. \[PS 86\] S.
S. Satish, S. R. Shashikant, V. K. Sambhe, R. B. Shelke, and G.
Kocharekar, "A minimum cardinality consistency-checking algorithm for
UML class diagrams," presented at the International Conference and
Workshop on Emerging Trends in Technology, Mumbai, Maharashtra, India,
2010. \[PS 87\] C. Schwarzl and B. Peischl, "Static- and dynamic
consistency analysis of UML state chart models," presented at the 13th
international conference on Model driven engineering languages and
systems: Part I, Oslo, Norway, 2010. \[PS 88\] N. Ibrahim, R. Ibrahim,
and M. Z. Saringat, "Definition of Consistency Rules between UML Use
Case and Activity Diagram," presented at the 2nd International
Conference, Daejeon, South Korea, 2011. \[PS 89\] N. Ibrahim, R.
Ibrahim, M. Z. Saringat, D. Mansor, and T. Herawan, "Consistency rules
between UML use case and activity diagrams using logical approach,"
International Journal of Software Engineering and its Applications,
vol. 5, pp. 119-134, 2011. \[PS 90\] Z. Khai, A. Nadeem, and G.-s. Lee,
"A Prolog Based Approach to Consistency Checking of UML Class and
Sequence Diagrams," presented at the Communication and Networking -
International Conference (FGCN 2011), Held as Part of the Future
Generation Information Technology Conference (FGIT 2011), in Conjunction
with GDC 2011, Jeju Island, South Korea, 2011. \[PS 91\] I. Ober and I.
Dragomir, "Unambiguous UML composite structures: the OMEGA2 experience,"
presented at the 37th international conference on Current trends in
theory and practice of computer science, Nový Smokovec, Slovakia, 2011.
\[PS 92\] O. Vasilecas, R. Dubauskaitė, and R. Rupnik, "Consistency
checking of UML business model," Technological and Economic Development
of Economy, vol. 17, pp. 133-150, 2011. \[PS 93\] A. Reder and A. Egyed,
"Computing repair trees for resolving inconsistencies in design models,"
presented at the 27th IEEE/ACM International Conference on Automated
Software Engineering, Essen, Germany, 2012. \[PS 94\] Z. Wang, H. He, L.
Chen, and Y. Zhang, "Ontology based semantics checking for UML activity
model," Information Technology Journal, vol. 11, pp. 301-306, 2012. \[PS
95\] C. Wilke, A. Bartho, J. Schroeter, S. Karol, and U. Aßmann,
"Elucidative development for model-based documentation," presented at
the 50th International conference on Objects, Models, Components,
Patterns, Prague, Czech Republic, 2012. \[PS 96\] X. Liu,
"Identification and check of inconsistencies between UML diagrams,"
presented at the 2013 International Conference on Computer Sciences and
Applications, 2013. \[PS 97\] A. Reder and A. Egyed, "Determining the
Cause of a Design Model Inconsistency," IEEE Trans. Softw. Eng. ,
vol. 39, pp. 1531-1548, November 2013 2013. \[PS 98\] T. Yokogawa, S.
Amasaki, K. Okazaki, Y. Sato, K. Arimoto, and H. Miyazaki, "Consistency
Verification of UML Diagrams Based on Process Bisimulation," presented
at the IEEE 19th Pacific Rim International Symposium on Dependable
Computing (PRDC), 2013. \[PS 99\] I. Zaretska, O. Kulankhina, and H.
Mykhailenko, "Cross-Diagram UML Design Verification," presented at the
ICT in Education, Research, and Industrial Applications (ICTERI), 2013.
\[PS 100\] J. Seiter, R. Wille, U. Kühne, and R. Drechsler, "Automatic
refinement checking for formal system models," presented at the Forum on
Specification and Design Languages (FDL), Munich, Germany, 2014. \[PS
101\] D. Allaki, M. Dahchou, and A. En-Nouaary, "Detecting and fixing
UML model inconsistencies using constraints," presented at the 4th IEEE
International Colloquium on Information Science and Technology (CiSt),
2016. \[PS 102\] X. Xia, J. Shi, Z. Fan, Z. Ai, and Y. Dong, "A
Consistency Checking Approach for System Architecture," presented at the
Annual IEEE Systems Conference (SysCon), Orlando, FL, USA, 2016 \[PS
103\] A. Knapp, T. Mossakowski, and M. Roggenbach, "Towards an
Institutional Framework for Heterogeneous Formal Development in UML,"
Software, Services, and Systems, pp. 215-230, 2015. \[PS 104\] P.
Kaufmanna, M. Kroneggerb, A. Pfandlerbe, M. Seidlac, and M. Widl,
"Intra- and interdiagram consistency checking of behavioral multiview
models," Computer Languages, Systems & Structures, vol. 44, pp. 72-88,
2015. \[PS 105\] E.M.N.K.Ekanayake and S. R. Kodituwakku, "Consistency
Checking of UML Class and Sequence Diagrams," presented at the 8th
International Conference on Ubi-Media Computing (UMEDIA), Colombo, Sri
Lanka, 2015. APPENDIX C In this appendix we present the main components
of the protocol required to carry out an SMS \[12\] presented in \[8\].
In this research, the SMS \[8\] was used as starting point to build the
consolidated set of 116 UML costistency rules. At the end of this
appendix we also present the execution of the SMS.

1.  Research Questions The underlying motivation for the research
    questions was to determine the current state of the art as regards
    UML con- sistency rules, and this guided the design of the review
    process. In order to identify the current state of the art of UML
    consistency rules, we considered seven research questions (RQs):
    TABLE 4 RESEARCH QUESTIONS Research questions Main motivation RQ1:
    What are the UML versions used To discover what UML versions are
    used in the approaches that handle UML consistency. by researchers
    in the approaches found? RQ2: Which types of UML diagrams To
    discover the UML diagrams that research has focused upon, to reveal
    the UML diagrams that have been tackled in each approach are
    considered more important than others, in addition to identifying
    opportunities for further found? research. RQ3: What are the UML
    consistency To find the UML consistency rules to be checked and to
    assess the state of the field. rules to be checked? To find the
    types of consistency problems tackled in the rules. The data found
    are categorized RQ4: Which types of consistency prob- into three
    consistency dimensions split into three sub-dimensions: 1)
    horizontal, vertical and evo- lems have been tackled in the rules
    lution consistency; 2) syntactic and semantic consistency; 3)
    observation and invocation con- found? sistency. To determine
    whether the field is generally more applied or more basic research,
    along with RQ5: Which research type facets are used identifying
    opportunities for future research. The papers found were categorized
    into six types: in research on UML model consistency? evaluation
    research, validation research proposal of solution, philosophical
    papers, opinion pa- pers and personal experience papers.

                                       To discover how the approaches used to check UML consistency are implemented, in other

    RQ6: Is the approach presented auto- words whether their check
    system is presented in an automatic, manual or semi-automatic man-
    matic, manual or semi-automatic? ner.

RQ7: How are the UML consistency To discover how the consistency rules
used to check the consistency of the UML diagrams are rules specified?
How are the UML con- specified (e.g., Plain English, OCL, Promela) and
to discover with which tools those consistency sistency rules checked?
rules are checked (e.g., SPIN, OCL-Checker)

2.  Search strategy Conducting a search for primary studies requires the
    identification of search strings (SS), and the specification of the
    parts of primary studies (papers) in which the search strings are
    sought (the search fields). We identified our search strings by
    following the procedure of Brereton et al \[39\]:

    1.  Define the major terms;
    2.  Identify alternative spellings, synonyms or related terms for
        major terms;
    3.  Check the keywords in any relevant papers that are already
        available;
    4.  Use the Boolean OR to incorporate alternative spellings,
        synonyms or related terms;
    5.  Use the Boolean AND to link the major terms. The major search
        terms were "UML" and "Consistency" and the alternative
        spellings, synonyms or terms related to the major terms are
        presented in the following table. TABLE 5 SEARCH STRINGS Major
        Terms Alternative terms UML (uml OR unified modeling language OR
        unified modelling language) Consistency (consistency OR
        inconsistency)

    In the selection of the SS, we considered various alternatives. For
    example the SS used in the SLR on consistency management \[5\] was
    discarded owing to the fact that it might not strictly focus on UML
    consistency rules: we are much more interested in collecting rules
    than in identifying consistency management issues and solutions.
    (This is the main reason why we obtained a different set of primary
    studies.) Other SSs were experimented with, but it is not possible
    to discuss all the alternative search strings below owing to space
    limitations. In the set of alternative SSs, we selected the
    following, as it allowed us to retrieve the largest number of useful
    papers, i.e., the largest number of papers focusing on UML
    consistency: ((uml OR unified modeling language OR unified modelling
    language) AND (consistency OR inconsistency)) We did not establish
    any restrictions on publication years up to December 12, 2012. The
    SMS process started in Sep- tember 2012 and was completely finished
    on October 2013. We used the before mentioned SS with the following
    seven search engines: IEEE Digital Library, Science Direct, ACM
    Digital Library, Scopus, Springer Link, Google Scholar, and WILEY.
    The searches were limited to the following search fields: title,
    keywords and abstract.

3.  Selection procedure and inclusion and exclusion criteria In this
    section we discuss the inclusion and exclusion criteria used. We
    then discuss the process followed to include a primary study in this
    SMS. The inclusion criteria were:  Electronic Papers (EPs) focusing
    on UML diagram consistency which contained at least one UML
    consistency rule;  EPs written in English language;  EPs published
    in peer-reviewed journals, international conferences and workshops;
     EPs published up to December 12, 2012.  EPs which proposed UML
    consistency rules with a restriction (or extension) of the UML
    models that do not strictly follow the OMG standard \[15\]. The
    exclusion criteria were:  EPs not focusing on UML diagram
    consistency;  EPs which did not present a full-text paper (title,
    abstract, complete body of the article and references) but were
    reduced to an abstract, for instance;  EPs focusing on UML diagram
    consistency which did not contain at least one UML consistency rule;
     Duplicated EPs (e.g., returned by different search engines);  EPs
    which discussed consistency rules between UML diagrams and other
    non-UML sources of data, such as requirements or source code.

4.  Data extraction strategy We extracted the data from the primary
    studies according to a number of criteria, which were directly
    derived from the research questions detailed in TABLE 4. Using each
    criterion to extract the data required, we read the full text of
    each of the 95 primary studies. Once recorded, we collected the data
    on an Excel spreadsheet employed as our data form. The following
    information from each primary study was extracted and collected on
    the Excel data form:  Search engines: where the paper was found
    (see section 2 of the Appendix C);  Inclusion and Exclusion
    Criteria;  Data related to Research Questions: o What UML version
    was used; o What are the UML consistency rules discussed (see
    Appendix C); o What diagrams are involved in consistency rules (see
    section 3.3 of this paper); o UML consistency dimensions: UML
    diagram consistency is discussed in the literature according to sev-
    eral dimensions \[40\]:  Horizontal, Vertical and Evolution
    Consistency: Horizontal consistency, also called intra- model
    consistency, refers to consistency between different diagrams at the
    same level of ab- straction (e.g., class and sequence diagrams
    during analysis) in a given version of a model \[41\]. Vertical
    Inconsistency, also called inter-model consistency, refers to
    consistency between dia- grams at different levels of abstraction
    (e.g., analysis vs. design) in a given version of a model \[42\].
    Evolution consistency refers to consistency between diagrams of
    different versions of a model in the process of evolution \[41\]. 
    Syntactic versus Semantic consistency: Syntactic consistency ensures
    that a specification con- forms to the abstract syntax specified by
    the meta-model, and requires that the overall model has to be well
    formed \[42\]. Semantic consistency requires diagrams to be
    semantically compat- ible \[42\]. This does not mean that semantic
    consistency is necessarily restricted to behavioral diagrams. For
    instance, operation contracts (e.g., pre and post conditions)
    provided in the class diagram specify behavior. Semantic consistency
    applies at one level of abstraction (with hori- zontal consistency),
    at different levels of abstraction (vertical consistency), and
    during model evolution (evolution consistency) \[14\].  Observation
    versus Invocation consistency: Observation consistency requires an
    instance of a subclass to behave like an instance of its superclass,
    when viewed according to the superclass description \[43\] . In
    terms of UML state machine diagrams (corresponding to protocol state
    machines) this can be rephrased as "after hiding all new events,
    each sequence of the subclass  state machine diagram should be
    contained in the set of sequences of the superclass state ma- chine
    diagram." Invocation consistency requires an instance of a subclass
    of a parent class to be used wherever an instance of the parent is
    required \[44\]. In terms of UML state machine diagrams
    (corresponding to protocol state machines), each sequence of
    transitions of the su- perclass state machine diagram should be
    contained in the set of sequences of transitions of the state
    machine diagram for the subclass.  Tool support (Automatic,
    Semi-Automatic, Manual); o Automatic means that a tool automatically
    checks the UML consistency rules with no human interven- tion; 
    Semi-automatic means that the checking of the UML consistency rules
    was partially automated (for instance when the checking of a UML
    model needs a user's supportfor the process to be completed); 
    Manual means that the UML consistency rules were not supported by
    any implemented and automatic tool. o What mechanisms were used to
    specify the rules: e.g., plain language, Promela, etc.; o How are
    the UML consistency rules checked: e.g., SPIN, OCL-Checker, etc.; o
    Research type facet followed in the paper, for which we used the
    following classification \[45\]:  Evaluation research (ER): this is
    a paper that investigates techniques that are implemented in
    practice and an evaluation of the technique is conducted. This means
    that the paper shows how the technique is implemented in practice
    (solution implementation) and what the conse- quences of the
    implementation are in terms of benefits and drawbacks
    (implementation eval- uation).  Proposal of solution (PS): this is
    a paper that proposes a solution to a problem and argues for its
    relevance, without a full-blown validation.  Validation Research
    (VR): this is a paper that investigates the properties of a solution
    that has not yet been implemented in practice.  Philosophical
    papers (PP): this is a paper that sketches a new way of looking at
    things, a new conceptual framework, etc.  Opinion paper (OP): this
    is a paper that contains the author's opinion about what is wrong or
    good about something, how something should be done, etc.  Personal
    experience paper (PEP): this is a paper that places more emphasis on
    what and not on why.

5.  Execution The planning for this SMS with the seven search engines
    begun in September 2012 and was completed on December 12,

6.  In this section we present the execution of the SS in the seven
    search engines and the selection of primary studies according to the
    inclusion/exclusion criteria previously described. In order to
    document the review process with suffi- cient details \[12\], we
    describe the multi-phase process of the four sub-phases we followed:
     First sub-phase (SP1): the search string was used to search the
    seven search engines, as mentioned earlier.  Second sub-phase
    (SP2): we deleted duplicates automatically, by using the RefWorks
    tool \[46\]; we also removed duplicates manually.  Third sub-phase
    (SP3): we obtained an initial set of studies by reading the title,
    abstract and keywords of all the papers obtained after SP2 while
    enforcing the inclusion and exclusion criteria. When reading just
    the title, ab- stract and keywords of a paper was not sufficient to
    decide whether to include or exclude it, we checked the full-text. 
    Fourth sub-phase (SP4): all the papers identified in SP3 were read
    in their entirety and the exclusion criteria were applied again.
    This resulted in the final set of primary studies. TABLE 6 breaks
    down the number of papers we have found by sub-phases. Row SP1 in
    TABLE 6 shows the first results which were obtained by running the
    SS in the seven search engines selected. The next two rows show the
    results obtained after applying SP2 and SP3 of the study selection
    process. We eventually collected 95 primary studies for further
    analysis. The complete list of references can be found elsewhere
    \[47\]. TABLE 6 SUMMARY OF PRIMARY STUDIES SELECTION Sub phase IEEE
    Scopus Springer Link Google Scholar WILEY ACM Science Direct Total

                SP1: Raw results       363   601   163           341           9      87    39           1603
                SP2: No duplicates     279   325   159           247           9      80    36           1135
                SP3: First selection   62    64    62            28            4      33    14           267
                SP4: Primary studies   16    21    21            12            1      16    8            95

    
