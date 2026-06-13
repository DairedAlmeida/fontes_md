                                         MANUSCRIPT                                                                                                                                                    1




                                             CCIS OLVER: End-to-End Detection and Repair
                                             of Method-Level Code-Comment Inconsistency
                                                   Renyi Zhong, Yintong Huo, Wenwei Gu, Jinxi Kuang, Zhihan Jiang, Guangba Yu, Yichen Li,
                                                                               David Lo , and Michael R. Lyu



                                                                                                                       ✦

arXiv:2506.20558v1 \[cs.SE\] 25 Jun 2025

                                         Abstract— Comments within code serve as a crucial foundation for                      /**
                                         software documentation, facilitating developers to communicate and                    *Parses the output collection from the raw DBObject result.
                                         understand the code effectively. However, code-comment inconsistency                  */
                                         (CCI) can negatively affect software development, testing, and mainte-                - private static String parseOutputCollection(DBObject rawResults) {
                                                                                                                               + private static String parseOutputCollection(Document rawResults) {
                                         nance. Recent efforts to mitigate this issue have emerged, but existing                    Object resultField = rawResults.get("result");
                                         studies often suffer from inaccurate datasets and inadequate solutions,                    if (resultField == null) { return null; }
                                         weakening their practical effectiveness. In this study, we first conduct a            -    return resultField instanceof DBObject ? ((DBObject)
                                         quantitative analysis of existing datasets, revealing a substantial portion           resultField).get(“collection”).toString() : resultField.toString(); }
                                         of sampled data are mislabeled. To address these data limitations, we                 +     return resultField instanceof Document ? ((Document)
                                                                                                                               resultField).get(“collection”).toString() : resultField.toString(); }
                                         introduce CCIB ENCH, a refined dataset comprising high-quality data,
                                         to support the training and evaluation of method-level CCI methods.
                                         Furthermore, we present an innovative end-to-end LLM-based frame-                     Fig. 1: A CCI example in spring-data-mongodb [6].
                                         work, CCIS OLVER, designed to improve code quality by identifying and
                                         rectifying CCIs. Comprehensive evaluations demonstrate CCIS OLVER’s                    To ensure that comments align with their related code,
                                         superior performance. For detection, it establishes a new state-of-the-           it is imperative for comments to be updated alongside code
                                         art with an F1-score of 89.54%. In fixing task, it achieves a remarkable          modifications [4]. However, developers often neglect to re-
                                         18.84% relative improvement in GLEU score over the strongest base-
                                                                                                                           vise comments during code changes or refactoring, resulting
                                         line. This superiority is confirmed by human evaluation, where CCI-
                                                                                                                           in code-comment inconsistencies (CCI) where comments
                                         S OLVER’s fixing success rate of 0.6533 significantly surpasses existing
                                         methods. Critically, in a practical end-to-end setting, CCIS OLVER’s in-          misrepresent the code. For instance, Figure 1 illustrates a
                                         novative architecture is approximately 36% faster for inference than the          CCI scenario in spring-data-mongodb, where a method was
                                         baseline model, underscoring its scalability and real-world applicability.        modified to handle Document objects, yet the comment
                                                                                                                           incorrectly claims it works with DBObject. These inconsis-
                                         Index Terms—Code Comment Inconsistency, Large Language Model,                     tencies can hinder development workflows by misrepresent-
                                         Java Method-Level Comment, Comment Quality, Comment Main-                         ing code intent and wasting developers’ time interpreting
                                         tainance                                                                          incorrect comments [5].
                                                                                                                                Recognizing the scale of modern systems and the labor-
                                                                                                                           intensive nature of manually resolving CCI, researchers
                                         1    I NTRODUCTION
                                                                                                                           have proposed automated CCI detection techniques. These
                                                                                                                           techniques leverage both traditional machine learning clas-
                                         C     ODE comments serve as fundamental documentation
                                               artifacts in software development, providing crucial
                                         metadata and explanations that facilitate program compre-
                                                                                                                           sifiers [7] and advanced deep learning models [5], [8],
                                                                                                                           [9]. However, there are limitations from both dataset side
                                         hension and maintenance. These textual annotations enable                         and proposed solution side. Specifically, existing datasets
                                         developers to communicate essential information, including                        contain data mislabelling issues originating from the trade-
                                         implementation details, component relationships, and code                         offs made during dataset construction [9]. Existing deep
                                         evolution rationale [1], [2]. Research has demonstrated that                      learning methods [5], [8] excel in detecting CCIs but are
                                         well-maintained comments can enhance software maintain-                           inherently limited in fixing them, while approaches like
                                         ability and support developers’ understanding of complex                          C4RLLaMA [10] that utilize fine-tuned LLMs for both tasks
                                         codebases [3].                                                                    introduce significant computational overhead, particularly
                                                                                                                           during the detection phase.
                                         •   Renyi Zhong, Wenwei Gu, Jinxi Kuang, Zhihan Jiang,                                 Existing dataset limitations. The current CCI datasets
                                             Guangba Yu, Yichen Li, Michael R. Lyu are with The                            (e.g., JITD ATA [8] and O CD D ATA [5]) contain data mislabel-
                                             Chinese     University    of     Hong    Kong,    Hong    Kong.    (e-        ing issues stemming from the trade-offs made during their
                                             mail:ryzhong22@cse.cuhk.edu.hk; wwgu21@cse.cuhk.edu.hk; jxkuang22
                                             @cse.cuhk.edu.hk;            zhjiang22@cse.cuhk.edu.hk;        guang-         construction. Researchers often opt for automated labeling
                                             bayu@cuhk.edu.hk; ycli21@cse.cuhk.edu.hk; lyu@cse.cuhk.edu.hk)                over manual labeling due to the latter’s high costs, although
                                         •   Yintong Huo and David Lo are with Singapore Management University,            it can lead to labeling errors [9], [11]. Specifically, inconsis-
                                             Singapore. (e-mail: ythuo@smu.edu.sg; davidlo@smu.edu.sg)
                                                                                                                           tencies are identified by comparing pairs of methods and

MANUSCRIPT 2

comments from older and newer code versions, under the different
methodologies: (1) For detection, the component assumption that an
individual comment update indicates a CCID ETECTOR uses a traditional
deep learning approach. It correction for the method, thus labeling the
old comment as first extracts code comments and associated code changes,
inconsistent with the new code. However, this process relies then
encodes this information for a semantic-based classi- on an overly broad
assumption that may not hold true in fier to accurately identify
inconsistent cases. This ensures practice. For example, a comment may be
updated to correct efficient processing of numerous instances, a crucial
aspect typos or add information, which could mistakenly classify where
LLM-only detection can be prohibitively slow and it as inconsistent.
While previous studies \[10\], \[11\] have costly. (2) Once an
inconsistency is detected, the CCIF IXER acknowledged the issue of
erroneous labeling, no further component leverages the generative power
of LLMs for investigation has been conducted to identify the causes of
repair. Specifically, CCIF IXER is fine-tuned on the high- false
positives and their prevalence. quality inconsistent cases derived from
our newly devel- Existing solution limitations. A complete CCI solution
oped CCIB ENCH dataset. This targeted fine-tuning enables requires both
detecting inconsistencies and fixing them by it to learn robust
correction patterns and generate accurate suggesting appropriate comment
revisions \[10\]. While exist- and contextually appropriate comment
updates. ing deep learning methods \[5\], \[8\] have shown promising re-
We conduct comprehensive evaluations of CCI detection sult in detection
phase, they fall short in fixing CCIs. Recent methods using both JITD
ATA and our newly developed advancements in large language model (LLM)
have demon- CCIB ENCH dataset. Our evaluation reveals the following
strated exceptional capabilities in code understanding and key findings:
(1) Our CCID ETECTOR component achieves repair \[12\]. C4RLLaMA \[10\]
utilizes a fine-tuned LLM to state-of-the-art performance in CCI
detection. With an F1 handle both detection and correction activities.
Nonetheless, score of 89.54%, it outperforms existing methods by 1.73%,
this method incurs considerable performance overhead be- establishing
itself as the leading approach for CCI detection. cause the detection
task examines a vast number of cases, (2) Our CCIF IXER component
demonstrates remarkable ef- most of which do not require further
inconsistency fixing. fectiveness in comment repair. It substantially
outperforms To investigate the potential dataset limitations, we first
existing solutions, achieving GLEU score improvements of conduct a
preliminary study on the widely-used JITD ATA 18.84% and 12.07% on the
full and validated test sets, re- dataset. Our findings are alarming: a
manual inspection spectively. Human evaluation further validates these
results, of 600 sampled cases revealed that a staggering 45.67% of with
CCIF IXER achieving a success rate of 0.6533, signif- instances labeled
as positive (i.e., inconsistent) are, in fact, icantly surpassing both
DeepJIT (0.4867) and C4RLLaMA incorrectly identified (§ 2.2.3). We
pinpoint four primary rea- (0.5867). The end-to-end evaluation confirms
that the two- sons for these errors: add/delete information, fix typos,
change stage architecture of CCIS OLVER is both more effective and case,
and change lexical. These results not only alarm critical time
efficient, improving detection and fixing quality while data quality
issues in existing resources, but also underscore reducing inference
time by approximately 36%, making it the urgent need for a cleaner
dataset. a more practical and scalable solution. The above results In
response to the data quality issues identified, we demonstrate the
supreme quality of CCIB ENCH and the develop a new dataset, CCIB ENCH,
derived from JITD ATA. effectiveness of CCIS OLVER in handling CCI
issues. The construction of CCIB ENCH aims to directly address
Contributions. We conclude this paper's contribusions: the identified
shortcomings, such as high false positive • \[Study\] First quantitative
analysis of label quality about rates and their underlying causes, to
provide a high-quality CCI. Our study represents the first quantitative
investiga- resource for CCI detection and fixing tasks. This involved a
tion into CCI data, uncovering potential issues with label multi-stage
process incorporating advanced de-duplication, quality. We identify four
primary categories of labeling syntactic cleaning, and semantic-based
filtering. Initially, errors: addition/deletion of information, typo
corrections, we eliminate duplicates in the data, a common issue that
changes in case, and alterations in lexical content. inflates existing
datasets \[9\]. We then use refined syntactic • \[Dataset\] Construction
of a high-quality CCI dataset, rules to remove trivial changes (e.g.,
typo corrections, case CCIB ENCH. We build CCIB ENCH, a new dataset for
CCI adjustments) that do not lead to CCI, directly addressing research.
Its construction involves a multi-stage pipeline some of the previously
identified false positive sources. To that combines syntactic cleaning
to filter trivial changes address more complicated cases, particularly
those related and a novel semantic filtering process. to changes like
information addition or deletion which • \[Framework\] CCIS OLVER : A
novel and efficient two- syntactic rules may miss, we employ three
powerful LLMs stage framework. We propose CCIS OLVER, a novel frame-
(i.e., GPT4o \[13\], Claude3.5-Sonnet \[14\], and LLaMA3.1- work for
efficient CCI detection and repair. It features a 405b \[15\]) as
independent voters to identify true CCIs, two-stage architecture: a
lightweight deep learning-based resulting in a dataset of 22,360
verified CCI cases. CCID ETECTOR for fast and accurate detection , and a
Beyond the critical need for a cleaner dataset, effectively powerful
LLM-based CCIF IXER to repair inconsistencies. addressing CCIs also
requires overcoming the limitations This decoupled design is more
practical and significantly inherent in current solutions. As previously
discussed, ex- faster than monolithic LLM baselines in an end-to-end
isting approaches either excel at detection but lack repair setting.
capabilities, or utilize computationally intensive LLMs for •
\[Evaluation\] Comprehensive empirical validation. Exten- both tasks,
leading to inefficiencies. To bridge this gap, sive experiments show
that CCIS OLVER surpasses exist- we propose CCIS OLVER, an innovative
end-to-end frame- ing methods in both CCI detection and repair. Its
effec- work designed for both efficient CCI detection and effective
tiveness is validated by automated metrics and rigorous automated
repair. CCIS OLVER combines the strengths of human evaluation, which
confirms its superior ability MANUSCRIPT 3

    to generate correct fixes. The design also provides an          2.1.3    Existing dataset
    advantage in time efficiency, making it a more practical            JITD ATA [8] is created by identifying inconsistencies in
    and scalable solution.                                          code changes in the commit histories of 1,518 open-source
                                                                    Java projects. The dataset encompasses positive instances

2 BACKGROUND AND M OTIVATION where comments are updated along with code
changes, 2.1 Code-Comment Inconsistency and negative instances where
comments remain unchanged 2.1.1 Definitions despite code modifications.
Heuristics \[16\] are employed We first clarify some frequently used
concepts in this to filter out irrelevant comment updates, while concen-
work. trating on @return, @param, and summary comments. A curated sample
of 300 cases is chosen for reliable evaluation, Definition 2.1
(Code-comment pair). A code-comment pair with negative instances
downsampled to ensure a balanced (M , C ) is comprised of a method M ,
which encapsulates dataset. Table 3 presents the core statistics of JITD
ATA. a functional segment, and an associated method comment Figures 3
demonstrate three distinct CCI cases. In the C that pertains
specifically to the method M . Note that we instance of return type
inconsistency depicted in Figure 3a, only consider method comments,
excluding class comments the code modifies the return type from a list
of FontIcon- and inline comments. Sets to a collection of registered
IconSets. Nonetheless, the Definition 2.2 (Code Comment Inconsistency).
A code com- original comment claims that the method supplies a list of
ment inconsistency between a code-comment pair (M, C) is registered
FontIconSets. This results in a mismatch between described as the return
type described by the comment and the actual  code. Figure 3b
illustrates an inconsistency in the method 1, if f (M ′) ̸= g(C), 
signature where the original comment and method param- Inconsistency(M,
C) = where M → M ′; (1) eter referred to 'instant', but the revised code
substituted it  0, otherwise. with 'partial'. Figure 3c presents a case
of summarization  inconsistency, where the code introduces a set named
visite- where f (M ′) denotes the factual behavior or operation of
dInterfaces and replaces the findMetaAnnotations call with the modified
code M ′, and g(C) signifies the intention or
findMetaAnnotationsRecursive, signaling a logical change. interpretation
of the original comment C . The condition However, the data collection
process of JITD ATA can f (M ′) ̸= g(C) indicates that the revised
code's behavior introduce labeling errors (i.e., false positives).
Specifically, is inconsistent with the comment's meaning. The notation
they extract the code-comment pair from the old and new M → M ′
indicates the code change. versions ((M ,C ) ,(M ′,C′)) where C ̸= C′.
By assuming that Definition 2.3 (CCI Detection Task). Given a code
change the developer updated the comment because it would have (M → M ′)
and a related comment C , the CCI detection otherwise become
inconsistent as a result of code changes, task is to determine whether
the M → M ′ lead to a CCI they take C to be inconsistent with M ′ \[8\],
as the left part according to the definition in equation 1. The output
of of Figure 2 shows. While it is convenient for data collection, this
task is a binary classification indicating whether the the assumptions
are not always valid in practice \[9\]. For inconsistency exist or not.
example, if C is updated because of typos or refactoring, despite it
actually being consistent with M ′, it would be Definition 2.4 (CCI Fix
Task). Given a code change (M → assigned as an inconsistent case. M ′)
and a related comment C , where M ′ is inconsistent According to
Definition 2.2, we focus primarily on fac- with C , the CCI fix task
aims to generate a modified com- tual inconsistencies between code and
comments, as de- ment C′ that ensures f (M ′) = g(C′). picted on the
right side of Figure 2. Only some code changes 2.1.2 Two scenarios can
lead to a CCI occurrence. Consequently, it is crucial to determine what
other types of changes can take place Following prior work \[8\], we
categorize this CCI task and their frequency, to assist in devising a
method for their into two distinct scenarios. exclusion. Just-in-time
(JIT): The objective here is to detect inconsis- tencies at the moment
code changes occur, prior to their commitment. Specifically, M , M ′,
and C are accessible, 2.2 Motivating Study enabling an examination of
the differences between the old This study aims to quantitatively
investigate the preva- and new versions. lence of false positives in
JITD ATA and their taxonomy. Post-hoc: In this case, only a single
version of the code comment pair (M , C ) is available for assessment.
In this study, we concentrate on the just-in-time (JIT) 2.2.1 Data
sampling scenario, as it closely aligns with the practical needs of con-
To conduct manual analysis, we randomly sample 200 temporary software
development. Identifying mismatches positive cases each from @return,
@param, and summary at the point of code modifications enables immediate
reso- from JITD ATA respectively (600 in total) based on a 95% lution of
potential issues before they are committed, thereby confidence level and
5% confidence interval \[17\]. For each minimizing the likelihood of
introducing errors into the sampled positive code-comment inconsistency
case, we ob- codebase. Furthermore, the JIT setting is also adopted by
tain the old comment, old code, new code, new comment, recent studies on
CCI detection \[9\], \[10\], highlighting its and differentiate between
old and new code for further pivotal role in current development
processes. inspection. MANUSCRIPT 4

                                                                                         TABLE 1: Preliminary study result.

                                                                                                          @return   @param   summary   Total
                                                                            Real Inconsistency              113      124       89      326
                                                                            False Positive                  87        76       111     274
         C                   C’                                                – add/delete information     69        60       90      219
                                                                               – fix typo                    4         3        9       16
                                                                               – change case                 5         7        4       16
                                                                               – change lexical              9         6        8       23


                                                  factual change          2.2.2   Two-stage examination process
                                                                              To ensure a high-quality manual analysis, we establish
                                                                          a multi-tiered annotation protocol. The process is initiated
         M                  M’                                            by two experienced co-authors (A1 and A2), each with over
                                                                          seven years of programming experience, who served as the
             all code change
                                                                          primary annotators. They follow a two-step procedure: First,
                                                                          they independently analyze and label each sampled case.
                                                   other change           Second, for any individual case where their labels disagreed,
                                                                          they discuss the issue to reach a mutual consensus. For the
                                                                          rare and particularly challenging cases where an agreement

Fig. 2: The presumptive scenario (left portion) and the actual could not
be established through discussion, a third senior scenario (right
portion) that lead to CCI. author, acting as an expert arbiter, is
consulted to make the final decision. This multi-tiered process ensures
that all disagreements are resolved rigorously, thereby guaranteeing the
consistency and high quality of the final labeled dataset Old comment:
@return a list of registered FontIconSets. for subsequent analysis. The
specific steps of the study are New comment:@return a collection of
registered FontIconSets. as follows: - public static
List`<FontIconSet>`{=html} getRegisteredIconSets() { - return
FONT_ICON_SET_LIST; Step I: A1 and A2 independently analyze all 600
sampled +public static Collection`<IconSet>`{=html}
getRegisteredIconSets() { cases to decide inconsistencies. They then
compare their + return REGISTERED_ICON_SETS.values(); results,
discussing any disagreements until they reach a con- sensus. The level
of agreement before discussion is indicated (a) The example of return
inconsistency. by a Cohen kappa of 0.76, reflecting a substantial level
of Old comment: @param instant the instant to compare to. New comment:
@param partial the partial to compare to. agreement \[18\]. Step II:
After receiving the false positive case, A1 ran- - public int
compareTo(ReadablePartial instant) { domly selects 30% of them and
reviews the difference be- - if (instant == null) { + public int
compareTo(ReadablePartial partial) { tween the code changes and the
semantic meaning of the + if (partial == null) { comments. A1 further
drafts a list of categories of reasons throw new
IllegalArgumentException("The instant must that cause false positives.
Then A1 and A2 follow the draft not be null"); } list to label the 30%
samples collaboratively to revise and int thisValue = get(); - int
otherValue = instant.get(getField()); refine the categories. Then A1 and
A2 independently study + int otherValue = partial.get(getFieldType());
the rest of the cases. The results in this phase have a Cohen's ....
Kappa of 0.91, which is an almost perfect agreement. (b) The example of
param inconsistency. Old comment: Finds all annotations recusively for a
class and its 2.2.3 Study Result superclasses. Table 1 presents the
findings of the preliminary study. New comment:Finds all annotations
recusively for a class and its superclasses or interfaces. According to
the analysis, 54.33% (326 out of 600) of the public static
`<A extends Annotation>`{=html} Set`<A>`{=html} instances are recognized
as inconsistencies, indicating a findAnnotationsRecursive(Class\<?\>
clazz, Class`<A>`{=html} true contradiction between the outdated
comments and the annotationType) { ... updated code. The other 45.67%
(274 out of 600) are cate- + Set\<Class\<?\>\> visitedInterfaces = new
HashSet\<\>(); gorized as false positives. Among false positives, the
pri- while (clazz != null && mary causative factors are detailed as
follows: Add/Delete !clazz.getName().startsWith("java.lang.")) {
information (219 instances, 80%) is the leading contributor -
findMetaAnnotations(clazz, annotationType, ret, visited); +
findMetaAnnotationsRecursive(clazz, annotationType, ret, to false
positives, reflecting changes where comments are visited,
visitedInterfaces); elaborated or reduced for enhanced clarity. Typo
correction clazz = clazz.getSuperclass();} (16 instances, 6%)
encompasses the rectification of errors return ret;} such as
misspellings in the comments. Change case (16 (c) The example of summary
inconsistency. instances, 6%) pertains to modifications in letter
casing, including capitalizing or decapitalizing words, which are Fig.
3: Three inconsistent cases in JITD ATA, where old minor formatting
adjustments. Change lexical (23 instances, comment is inconsistent with
the new code. 8%) involves synonym substitution or rewording. Table 2
gives examples for each false positive categories. MANUSCRIPT 5

                                                                        typo             lexical
                                                                     correction         changing                                      human evaluation   validated testset

                                                                                                             prompt    LLM voters
                 original dataset         de-duplication                case            stopword
                                                                      changing          changing
                                                                                                                                       cleaned testset
                                                                   syntactic-based data cleaning           semantic-based filtering


                                                                      Fig. 4: CCIB ENCH construction process.

                 TABLE 2: Four false positive examples.                                                    3.0.2      Syntactic-based data cleaning

Type Comment change Inspired by the preliminary study results and Xu et
add/delete information Removes the account with the primary key from the
database. Removes the account from the database. al. \[9\], many false
positives arise from syntactic changes fix typo Returns the result of
interpretting the object as an instance of 'Dial Region'. Returns the
result of interpreting the object as an instance of 'Dial Region'. in
comments. To address this, we design our filter rules change
case/stopwords Provides a string representation of the property. using a
trial-and-error method. Initially, we create rules Provides the string
representation of the property. change lexical Check if specified
address is allowed by current IPAccess rules. based on manually labeled
false positives from Section 2. We Checks if specified address is
allowed by current IPAccess rules. then manually review 20% of the
filtered results to further enhance the rules for better high precision
as the upcoming The study results reveal that many false positives stem
next phase can partially address syntactic false positives. from
modifications aimed at improving comment quality Ultimately, we
establish the following rules to detect four or formatting rather than
from any actual conflict with the types of syntactic changes: code. The
relatively small percentage of typo corrections, case changes, and
lexical updates further support that most • Typo correction. If and only
if one comment word is

false positives arise from content enhancement or reduction. changed,
the minimum edit distance is smaller than 4, Additionally, the results
emphasize the importance of care- and the word before editing is not in
the old code. fully distinguishing real inconsistencies from false
positives • Case changing. If and only if the case of one or more

in the dataset construction process, as the latter can inflate words in
the comment is changed, and the words before results and misrepresent
the tool's performance. editing are not in the old code. • Stopword
changing. If one or more of the following Summary: Our analysis of a
representative sample from the words (\[a, an, the, in, on, at, by\])
are added or deleted. JITDATA dataset suggests that a substantial
portion of cases, • Lexical changing. If and only if the root word after
the approximately 45.67%, are likely false positives according to
lemmatization of the changed word is the same, and our definition. Among
the false positive samples, we identify the word before editing is not
in the old code. four reasons: add/delete information, fix typo, change
case, and change lexical. To evaluate the performance of the CCI task
tool, it is essential to construct a new dataset. 3.0.3 Semantic-based
false positive filtering Based on the results of the preliminary study,
80% of the 3 DATASET C ONSTRUCTION -- CCIB ENCH false positives are
caused by add/delete information, which cannot be filtered out by the
above syntactic-based method. In this section, we introduce a new
dataset, CCIB ENCH, This is because such changes require an
understanding of containing an automated pipeline to acquire
high-quality the factual and logical meaning of the code and comment,
samples with accurate labels, as shown in Figure 4. a task we define as
semantic analysis. Syntactic cleaning, by contrast, only addresses
superficial textual patterns. We 3.0.1 Data source and data
de-duplication therefore choose to leverage the capabilities of LLMs to
filter We choose the JITD ATA as our data source due to its out these
semantically-driven false positives, as LLMs have popularity in the past
CCI-related studies \[8\], \[10\], \[19\], demonstrated effectiveness in
comprehending and labeling \[20\]. This step aims to remove duplicates
and cases with code-related tasks \[21\]. only formatting differences.
To achieve this, for each case, In this step, we employ a trio of
popular and pow- we first normalize the codes and comments by stripping
erful LLMs to develop a voting mechanism: GPT4o \[13\], away characters
such as tabs ("`\t”`{=tex}) and newlines ("`\n`{=tex}").
Claude3.5-Sonnet \[14\], and LLama3.1-405b \[15\]. These mod- We
consider cases as duplicates only if they share identical els are
selected not merely for their widespread use, but for values for Mold ,
Mnew , Cold , and Cnew . Labels are excluded their state-of-the-art
performance in code tasks \[22\], their from consideration due to
potential labeling errors. For diverse training methodologies and
architectures which re- duplicate cases, we prioritize keeping examples
with a duce the likelihood of correlated errors, and their prevalent
true label. If all labels are false, we randomly retain one. use in
recent software engineering studies \[23\], \[24\]. The vot- The
thorough data de-duplication prevents any vulnerable ing mechanism
aggregates responses from multiple LLMs functions from leaking from the
training set into the test set, and selects the common one \[25\],
maximizing the models' and avoids label conflicts. After de-duplication
of the initial capabilities and enhancing judgment accuracy.
Specifically, 40,688 JITD ATA instances, removing 337 duplicates, 40,351
if the two-thirds majority or all of the voters identify an unverified
entries remain. Manually labeling this extensive inconsistency between a
comment and the corresponding dataset is impractical. code, we choose to
keep this case in our cleaned dataset. MANUSCRIPT 6

TABLE 3: Statistics of the JITD ATA and CCIB ENCH in
`<ReplaceOld>`{=html} findMetaAnnotations `<ReplaceNew>`{=html}
different inconsistency and set types. findMetaAnnotationsRecursive
`<ReplaceEnd>`{=html} `<Keep>`{=html} ( clazz , annotationType , ret ,
visited `<KeepEnd>`{=html} `<Add>`{=html} , Type Train Valid Test Total
visitedInterfaces `<AddEnd>`{=html} `<Keep>`{=html} ) ;
`<KeepEnd>`{=html} return 15,950 1,790 1,840 19,580 param 8,640 932
1,038 10,610 JITD ATA Summary 8,398 1,034 1,066 10,498 Fig. 6: Code diff
representation related to Figure 3c, removed Full 32,988 3,756 3,944
40,688 tokens in red and added tokens in green. return 9,188 1,092 1,088
11,368 param 6,004 620 646 7,270 CCIB ENCH of two main components: the
CCID ETECTOR to identify Summary 2,970 356 396 3,722 Full 18,162 2,068
2,130 22,360 inconsistent cases, and the CCIF IXER, which corrects these
inconsistencies. In the first stage, CCID ETECTOR obtains the code
comments and related code changes from the training data of CCIB ENCH.
After encoding with various techniques, synthesize input it undergoes a
semantic similarity classifier. To continuously fine-tune combine
knowledge from failure examples, we propose an sampled LLM-based
enhancement technique to iteratively synthesize CCIBench LLM challenging
data that are mistakenly classified. In the second training data wrong
cases stage, CCIF IXER is implemented by using the parameter- e

           train                                          alignment   efficient fine-tuning (PEFT) methods to fine-tune and align
                                       at
                                    alu




                                                                      the pre-trained LLM, using the inconsistent cases in training
                                  ev




                                                                      data in CCIB ENCH.

    CCIBench        CCIDetector                    CCIFixer           4.2   CCID ETECTOR
    test data                                                         4.2.1 Code diff representation
                                                                          In the domain of code diff representation,
             Fig. 5: The framework of CCIS OLVER.                     employing semantically identical yet formally distinct
                                                                      representations concurrently as input has yielded

Conversely, if fewer than two-thirds register an inconsis- remarkable
performance results \[8\], \[27\]. In this method, tency, we discard the
data. we utilize difflib \[28\] to extract code diffs based on Appendix
A provides a detailed prompt used for this the study by Panthaplackel et
al. \[8\], as previous work semantic filtering. In addition to this
mechanism, we apply indicates that this diff structure outperforms the
token- a dynamic 4-shot in-context learning (ICL) strategy. This is
level diff structure \[29\]. Specifically, we employ four crucial, as it
aids the LLM voters in comprehending the edit actions: add, del, rep,
and keep. The actions add, del, task at hand more precisely \[26\],
thereby allowing them and keep are formatted as
⟨Action⟩\[tokens\]⟨EndAction⟩. to concentrate on specific semantic
discrepancies or factual The replace action, which incorporates content
from contradictions. The four examples are specifically chosen to both
the old and new versions, is structured as cover the different types:
one example for a consistent case, ⟨ReplaceOld⟩\[tokens\]⟨ReplaceN
ew⟩\[tokens\]⟨ReplaceEnd⟩. and one for each of the three inconsistency
types (return We extract the diff between Mold and Mnew using the above
type, method signature, and application logic). Note that all diff
lexicon. Figure 6 shows the Medit corresponding to filtering query use
the same four examples. After the above code diff in Figure 3c. process,
the statistics of CCIB ENCH are illustrated in Table 3. 4.2.2 Encoding
3.0.4 Validated test set construction For raw code and comment, we use
the encoder-only Following previous studies \[8\], we created a
validated Unixcoder \[30\] to embed the raw code and comment into subset
within the test set to better assess the effectiveness fixed-size
vectors. Unixcoder is a unified pre-trained model of methods. First, we
involve cases that were unanimously for programming languages that are
based on a multi-layer deemed inconsistent by all three LLM voters,
indicating transformer and utilizes mask attention matrices \[31\] with
a strong likelihood of inconsistency. Then, two annotators prefix
adapters to control the access to context for each manually verify the
label corrections, following a process token and has been widely used in
code-related tasks \[32\], similar to that in Section 2.2.2. The
annotators achieved a \[33\]. Note that the training process is
end-to-end where the Cohen's Kappa of 0.95, indicating almost perfect
agreement parameters of the encoder layers are adjusted to enhance and
highlighting our annotation reliability. Ultimately, we the
representation vectors, allowing these vectors to better get 300
validated test cases. adapt to the CCI detection task. For the code diff
representation, following the previous 4 M ETHODOLOGY work \[9\],
\[11\], we use Bi-GRU layers to encode the diff representation. Such
encoder specifically models token rep- 4.1 Overview resentation in code
diffs by considering the current token xt , In this section, we
introduce CCIS OLVER, an end-to-end the previous hidden state ht−1 , and
contextual information framework to tackle the CCI problem effectively.
This struc- from both directions, which enhances the model's grasp ture
of CCIS OLVER are shown in Figure 5, which consists of contextual
dependencies. Each code diff is tokenized MANUSCRIPT 7

and processed through a Bi-GRU. At each step t, the cur-
over-concentration on a narrow subset of errors, we sample rent token
and previous hidden state update the current a fraction of these
incorrect cases (e.g., with a default sam- hidden state ht = GRU(xt ,
ht−1 ). The Bi-GRU captures pling rate of 0.1). We then utilize a
teacher LLM to generate both forward and backward information. − At each
time → new samples similar to these selected difficult ones. step, the
output combines the forward ht and backward Algorithm 1 shows the
iterative enhancement procedure. ←− → − ← − ht hidden states ht = Wf ·
ht + Wb · ht + b where Wf The input contains the original cleaned
dataset D0 , original and Wb are the respective weight matrices, and b
is a detection model and the teacher LLM. The process begins bias. Given
that code diffs involve long-range dependen- with training the base CCID
ETECTOR model on the initial cies, we also use Multi-Head Self-Attention
for capturing dataset D0 , establishing a foundational detection perfor-
global context. This mechanism evaluates token interrela- mance.
tionships using Query (Q), Key  (K ), and  Value (V ) vectors:
Afterward, the model is evaluated on the current train- ⊤ Attention(Q,
K, V ) = softmax QK √ V where dk scales ing set, and the evaluation
results are analyzed to pin- dk point instances of misclassification
errors. Instead of feeding the softmax. Multi-Head Attention uses
several heads to all problematic cases into the LLM, which could bias
the focus on various code diff aspects: MultiHead(Q, K, V ) =
augmentation towards the most frequent error types, we Concat(head1 , .
. . , headh )W O . Each attention head is: Q randomly sample a subset of
these instances based on a headi = Attention(QWi , KWiK , V WiV ) This
multi-head predefined sampling rate (defaulting to 0.1). These selected
approach enhances the encoder's ability to capture diverse cases, which
highlight the model's limitations, are then representations. fed into
the LLM. By carefully designing prompts for the LLM, synthetic examples
are generated. These examples 4.2.3 Semantic similarity classification
maintain conceptual consistency with the original cases to After
obtaining representations for Cold and Mnew ensure task relevance while
introducing semantic diversity (Mdif f ), a classifier head is devised
to identify CCI. Instead to improve the model's robustness. The
synthesized data is of using a basic classifier with fully connected
layers, we subsequently merged with the existing training dataset to
introduce a similarity-based classification model as com- produce an
updated training set Di+1 , which is then used ments should align with
the semantic meaning of adjacent for the next round of training. This
iterative process con- code. The classifier concatenates the embeddings
of the tinues, enhancing the model's ability to handle challenging
comment Cold and its corresponding code snippet M . The cases, until a
termination criterion is met, such as achieving loss function, detailed
in Equation 2, combines binary cross- a desired performance level or
observing convergence in entropy (BCE) loss and a similarity-based term.
The BCE model improvement. loss is standard in machine learning, while
the similarity- Similar to \[38\], we only use cases from the original
data based term assesses semantic alignment between comments D0 to
create additional data to avoid degradation from and code. A weighting
parameter λ balances the influence of multiple iterations. While LLMs
can produce high-quality each term, with an additional constraint
ensuring the total cases, errors may still occur. Further expanding
these flawed loss remains positive. examples can spread errors and
compromise dataset quality. The details of designed prompts and examples
are shown in N Appendix A. 1 X L = −( \[yi log(pi ) + (1 − yi ) log(1 −
pi )\] N i=1 Algorithm 1: Iterative enhancement procedure N 1 X ci · mi
Input: The original cleaned dataset D0 , original +λ − λ) (2) N i=1 ∥ci
∥∥mi ∥ CCIDetection model Mdetect , and LLM T Output: Enhanced training
dataset Di 4.2.4 Iterative enhancement i←0; As data enhancement becomes
popular \[34\], \[35\], \[36\], while true do i 0 we aim to boost CCID
ETECTOR's performance from the Mdetect ← Train(Mdetect , Di );
perspective of training data. A straightforward approach is Edetect ←
Evaluate(Mdetect , D0 ) ; i i

to use a prompted LLM to augment the entire dataset \[37\], if stop
condition then but this has restrictions in considering the model's
vary- return Di ; i i ing performance across different data. For
instance, while Dsynthetic ← Synthesize(Edetect ,T) ; CCID ETECTOR may
handle the majority of the dataset, it i+1 i i D ← D + Dsynthetic may
struggle with a few challenging cases. Rather than duplicating simple
cases, it is more beneficial to generate challenging and difficult
examples. 4.3 CCIFixer Inspired by using LLMs for data augmentation
\[38\] and the Self-Instruct framework \[39\], we introduce an iterative
4.3.1 Fine-tuning methodology to improve the training dataset,
successfully Using our cleaned dataset, we fine-tune the base LLM
mitigating challenges associated with certain error-prone to develop our
inconsistency fixing model, CCIF IXER. We instances of the CCID ETECTOR.
Specifically, in each train- employ LoRA \[40\] for our fine-tuning
process, an effi- ing iteration, we identify cases where the model
predicts cient parameter-efficient fine-tuning (PEFT) scheme. This
incorrect classifications. Then, to ensure diversity and avoid approach
is advantageous as it significantly reduces the MANUSCRIPT 8 (  resource
demands for fine-tuning tasks while achieving λD σ β rθ (x, y) − z0 if y
∼ ydesirable \| x v(x, y) =  results comparable to full-parameter
fine-tuning. It accom- λU σ β z0 − rθ (x, y) if y ∼ yundesirable \| x
plishes this by utilizing a small fraction (e.g., as little as (6) 1.5%)
of the original model's parameters for the fine-tuning rθ (x, y) is a
reward function that measures the deviation process. The underlying
principle of LoRA is based on of the model's predictions from a
reference distribution. the hypothesis that the change in weights during
model A baseline z0 normalized the reward, accounting for the adaptation
has a low intrinsic rank. Thus, the update to a overall divergence. The
utility v(x, y) is then calculated weight matrix ∆W can be decomposed
into a product of differently for desirable and undesirable outputs,
scaled by two low-rank matrices. Mathematically, for a pre-trained
parameters λD , λU , and adjusted by a sensitivity factor β . weight
matrix W0 ∈ Rd×k , the fine-tuned matrix W ′ is expressed as: W ′ = W0 +
∆W = W0 + BA. Here, ∆W represents the change after fine-tuning, which is
the product 5 E XPERIMENT S ETUP BA, where B ∈ Rd×r and A ∈ Rr×k . The
dimensions d 5.1 Baselines and k correspond to the dimensions of the
original weight To fairly evaluate CCIS OLVER's performance, we care-
matrix W0 , while r is the rank, satisfying r ≪ min(d, k). fully choose
open-source baselines through a brief review During the fine-tuning
stage, W0 is kept frozen (i.e., not of related papers from SE venues in
the past decade. Fur- subject to gradient updates); only the matrices A
and B thermore, we take general-purpose LLMs and code-based contain
trainable parameters and are updated. Importantly, LLMs into
consideration, as they have been demonstrated for an input x, both W0
and ∆W = BA process x, and excellent performance in SE tasks \[43\],
\[44\], \[45\]. their respective output vectors, W0 x and BAx, are
summed element-wise: h = W0 x + BAx = (W0 + BA)x. The 5.1.1
Learning-based method significant reduction in trainable parameters
(from dk for We compare our approach against a variety of learning- W0
to r(d + k) for A and B ) makes it feasible to fine-tune based
baselines. These include methods that leverage large large models with
minimal parameter overhead. pre-trained models like CodeBERT BOW \[46\]
and the use of Bert and Longformer \[20\] to better handle long se-
4.3.2 Alignment quences. Other methods focus on explicitly modeling code
structures and changes. For instance, DeepJIT \[8\] explores Although
fine-tuning large models on task-specific data sequential (SEQ),
graph-based (GRAPH), and hybrid en- can improve performance, the
creative capabilities of these coders (HYBRID). OCD \[5\] represents
code edits as triple models in a CCI fix task may result in comments
that sequences processed by Bi-LSTM and Co-Attention layers, are
semantically correct but significantly different from the while AdvOC
\[9\] employs a Gated Graph Neural Network ground truth when evaluated
with text similarity metrics. on edit trees within an adversarial
learning framework. Therefore, we employ the process of alignment to
guide the DocChecker \[19\] utilizes the UniXcoder model \[30\] for
just- model in learning the overall programming preferences in in-time
inconsistency detection. CCIB ENCH. Conventional alignment methods
require paired data, 5.1.2 General-purpose LLMs such as preferred and
dispreferred data. In this specific code In this study, we select three
widely-used general- comment inconsistent fix task, it is not possible
to acquire purpose LLMs as baselines: GPT-3.5 \[47\], GPT-4o \[13\], and
the dispreferred data naturally. Therefore, we need an align- LLaMA-3.1
\[15\]. These models are chosen due to their exten- ment algorithm that
does not rely on paired data. Inspired sive adoption and proven
effectiveness in SE tasks \[43\], \[44\], by Ethayarajh et al. \[41\],
we introduced the Kahneman- \[45\]. Their robust performance in
understanding and gener- Tversky Optimization (KTO) algorithm to our
alignment ating code-related text makes them suitable benchmarks for
process. Unlike traditional methods like RLHF or DPO \[42\] evaluating
our proposed framework. that rely on ranked comparisons, KTO models
human pref- erences through a utility-based objective derived from the
5.1.3 Code-based LLMs perceived gains and losses in prospect theory. The
utility function U (x) is defined relative to a reference point r, with
Building on the success of LLMs in natural language risk sensitivity
parameters α, β and a loss aversion factor processing, researchers have
also developed code-oriented λ, capturing human behavior toward gains
and losses. The LLMs to enhance code comprehension and task generation.
model optimization directly minimizes the Human Aligned In this study,
we choose Deepseek-coder\[48\] to deal with Loss Objective (HALO), LHALO
= Ex∼pθ (x) \[−U (x)\], where the CCI task. Furthermore, C4RLLaMA \[10\]
is a fine-tuned pθ (x) represents the model's output distribution.
Specifi- large language model based on the CodeLLaMA and shows cally,
the default KTO optimization task is: promising results for CCI tasks.

           LKTO (πθ , πref ) = Ex,y∼D [λy − v(x, y)] ,      (3)   5.2    Eavaluation metrics
                                                                  5.2.1 Evaluation Metrics for CCIDetector

where The detection of code comment inconsistency is a binary πθ (y\|x)
classification problem \[5\]. Based on the methodology out- rθ (x, y) =
log (4) πref (y\|x) lined in previous work \[8\], we evaluated the
performance of the related approaches using Precision, Recall, F1-score,
z0 = KL(πθ (y ′ \|x)∥πref (y ′ \|x)) (5) and Accuracy metrics.
MANUSCRIPT 9

      TABLE 4: Fine-tuning hyperparameters with LoRA.               6     E XPERIMENTAL R ESULTS
      stage   epoch   bs    lr    max len   lorar   loraa   lorad   6.1   Research Questions

fine-tune 10 16 1e-5 2048 8 32 0.05 In this study, we investigate the
following research ques- alignment 5 32 1e-5 2048 8 32 0.05 tions (RQs)
and provide a case study to understand the fixing ability of CCIF IXER:
• RQ1: How effective is CCID ETECTOR in CCI detection? 5.2.2 Evaluation
Metrics for CCIFixer • RQ2: How do different design choices enhance the
To rigorously evaluate the performance of CCIFixer, performance of CCID
ETECTOR? our methodology employs metrics targeting both text gen- • RQ3:
How effective is CCIF IXER in fixing the inconsis- eration and text
editing tasks, in line with the previous tency of the existing code
comments? work \[8\]. For assessing generation quality, we utilize BLEU-
• RQ4: How do LLM backbones and tuning process en- 4 \[49\] to measure
n-gram precision against reference com- hance the performance of CCIF
IXER? ments, providing an indication of surface-level fidelity. This •
RQ5: How effective and efficient is CCIS OLVER at end- is complemented
by METEOR \[50\], which offers a more to-end CCI detection and repair
compared to existing semantically-aware evaluation by considering
synonyms method? and stemming. To assess the model's effectiveness from
a text-editing perspective, we adopt SARI \[51\] to specifically 6.2
RQ1: How effective is CCID ETECTOR in CCI detec- quantify the quality of
the performed edit operations (i.e., tion? additions, deletions, and
retentions), and GLEU \[52\] to measure the similarity between the
generated output and 6.2.1 Motivation the reference, a standard approach
for grammatical error The purpose of this RQ is two-fold. First, we want
to correction tasks. Together, these four metrics provide a com-
evaluate the performance of existing approaches on our prehensive,
multi-faceted evaluation of the system's output new proposed clean
dataset CCIB ENCH. Second, we want quality. to investigate whether CCID
ETECTOR outperforms existing baselines in detecting CCI. 5.3
Implementation and Environment 6.2.2 Approach For hyperparameters in our
proposed approach, we set To achieve our objective, we reimplement all
the baseline the train epoch number as 10, the loss function weight λ
methods. We apply these implementations to both the JIT- as 1, the
default iteration number of enhancement is 10 D ATA \[8\] and CCIB ENCH.
Each of these datasets provides for CCIDetector. In CCIFixer, the
hyperparameters in fine- a validated test set consisting of 300 cases.
However, it is tuning stage and alignment stage are displayed in Table
4. important to note that the process of creating the validated We opted
for GPT4o as the teacher LLM in CCID E - dataset differs, leading to
their differing cases. TECTOR , primarily because of its advanced
abilities in un- derstanding and generating code. Meanwhile, for the
CCI- 6.2.3 Result F IXER base model, we selected Qwen2.5-Coder-14B. This
Table 5 presents the just-in-time code comment inconsis- decision was
influenced by the necessity to balance device tency detection results on
two datasets with four metrics: resource limitations with the
requirement for proficient code accuracy, precision, recall, and F1
score. and prompt comprehension ability. The CCID ETECTOR method
outperforms all other tech- For conventional baseline approaches, we
reproduced niques in CCIB ENCH, establishing itself as the most pro-
them based on the replication packages released by the ficient strategy
for just-in-time CCI detection. Within the authors. Note that for
C4RLLaMA, we re-implemented and validated test dataset, CCID ETECTOR
secures an impressive fine-tuned using the exact same Qwen2.5-Coder-14B
model F1 score of 92.20, considerably exceeding its nearest com- as our
backbone. This crucial step ensures that any ob- petitor, C4RLLaMA,
which achieves an F1 score of 90.63 by served performance differences
between our method and a margin of 1.73%. This consistent superiority
underscores the baseline are attributable to the proposed methodological
CCID ETECTOR 's robustness in managing high-confidence advancements,
rather than a disparity in the underlying samples, maintaining a balance
between precision and re- power of the base models. We repeat five times
and report call, and effectively generalizing across datasets with
differ- the median results to avoid potential random bias. We ran ent
degrees of complexity. them on a server with Intel Xeon Gold 6248R CPU,
512GB An interesting observation is that the performance im- physical
memory, and 2x NVIDIA A100 40G GPU. The OS provement gained by adding
features is significantly greater version is Ubuntu 18.04. when using
the CCIB ENCH dataset compared to JITD ATA. For LLMs, we called their
official APIs to infer. We adapt For example, on DeepJIT's Full Test
Set, Graph+features 4-shot in-context learning for prompt techniques in
the data improves the F1-score from 79.67 to 82.06, an increase of 2.39
cleaning process. We use the prompt in Appendix A for the points.
However, in CCIB ENCH, the same feature enhance- iterative enhancement
in the detection phase. As a baseline, ment yields a much larger
improvement, with the F1 score we also retrieve 4 cases with the highest
similarity using rising from 83.95 to 87.88, a notable increase of 3.93
points. BM25 \[53\] algorithms to detect CCI. For all experiments
Similarly, for the Hybrid model, adding features in JITD ATA related to
LLM inference, we set the temperature to 0 so that from 77.47 to 81.96
(4.49 points), while in CCIB ENCH, the LLM would generate the same
output for the same query to improvement jumps from 81.41 to 87.15 (5.74
points). ensure reproducibility. MANUSCRIPT 10

                         TABLE 5: Just-in-time CCI detection performance on DeepJIT and CCIB ENCH.

                                                            Full Test Set                                                         Validated Test Set
               Dataset          Model
                                              Accuracy   Precision     Recall   F1-score                 Accuracy                  Precision    Recall                          F1-score
                            CodeBERT BOW       72.04       68.87       73.24       70.99                           75.33               77.14                  72.00                  74.48
                                  Seq          79.46       83.78       73.07       78.06                           80.67               81.94                  78.67                  80.27
                                 Graph         79.74       79.94       79.41       79.67                           82.00               82.43                  81.33                  81.88
                                Hybrid         78.22       80.23       74.89       77.47                           85.21               83.45                  86.43                  84.91
                             Seq+features      81.56       87.75       73.38       79.92                           86.67               87.67                  85.33                  86.48
                            Graph+features     82.48       84.05       80.17       82.06                           86.33               86.09                  86.67                  86.38
                            Hybrid+features    82.15       82.85       81.08       81.96                           89.00               89.26                  88.67                  88.96
                              DocCheaker       72.97       71.25       73.17       72.20                           76.33               78.01                  73.33                  75.60
                                  Bert         77.67       76.18       78.21       77.18                           80.05               81.94                  78.67                  80.27
              JITD ATA
                              Longformer       78.75       74.98       79.82       77.32                           81.43               83.33                  80.00                  81.63
                                 OCD           76.50       82.92       66.75       73.96                           74.67               75.34                  73.33                  74.32
                                AdvOC          80.28       84.37       75.28       79.57                           79.82               83.33                  76.67                  79.86
                              C4RLLaMA         86.24       86.20       84.30       85.24                           87.82               89.67                  85.33                  87.45
                                GPT3.5         53.13       67.21       46.28       54.82                           58.33               69.40                  52.67                  59.89
                                GPT4o          77.74       79.25       75.33       77.24                           75.67               75.16                  76.67                  75.91
                               LLaMA3.1        77.89       68.24       88.75       77.16                           78.00               75.61                  82.67                  78.98
                            Deepseek-coder     65.98       74.33       60.24       66.55                           68.00               68.24                  67.33                  67.78
                             CCID ETECTOR      86.48       87.24       85.17       86.19                           88.74               87.67                  88.67                  88.17
                            CodeBERT BOW       73.04       71.20       73.64       72.40                           76.00               77.86                  72.67                  75.18
                                  Seq          82.44       84.38       79.62       81.93                           85.00               85.23                  84.67                  84.95
                                 Graph         84.13       84.92       83.00       83.95                           84.33               85.03                  83.33                  84.17
                                Hybrid         80.65       78.37       84.69       81.41                           83.67               79.53                  90.67                  84.74
                             Seq+features      87.51       89.67       84.79       87.16                           89.67               88.88                  90.67                  89.77
                            Graph+features     88.22       90.46       85.44       87.88                           92.00               91.45                  92.67                  92.06
                            Hybrid+features    87.32       88.41       85.92       87.15                           89.67               89.40                  90.00                  89.70
                              DocCheaker       76.46       75.13       77.27       76.18                           76.67               75.00                  80.00                  77.42
                                  Bert         82.04       82.03       81.68       81.85                           83.00               80.00                  88.00                  83.81
             CCIB ENCH
                              Longformer       82.47       80.82       83.35       82.07                           84.00               80.72                  89.33                  84.81
                                 OCD           77.86       84.68       70.24       76.79                           76.67               77.86                  74.67                  76.23
                                AdvOC          84.10       87.25       79.31       83.09                           84.28               86.82                  80.64                  83.62
                              C4RLLaMA         89.16       88.24       89.10       88.67                           87.82               92.67                  88.67                  90.63
                                GPT3.5         64.41       70.72       49.20       58.03                           63.00               69.70                  46.00                  55.42
                                GPT4o          83.19       84.76       80.94       82.81                           82.67               88.89                  74.67                  81.16
                               LLaMA3.1        78.87       72.27       93.71       81.61                           80.67               75.56                  90.67                  82.43
                            Deepseek-coder     74.27       80.45       64.13       71.37                           77.67               84.30                  68.00                  75.28
                             CCID ETECTOR      89.92       89.84       89.25       89.54                           90.95               92.67                  91.74                  92.20

    Although LLMs have shown exceptional performance                                                                                    F1 Score Comparison
                                                                                                 94                                                                                           Full test set

in many natural language processing tasks, their effective- Validated
test set ness in CCI detection appears to lag behind most baseline 92.20
92 91.64 methods. As observed in the results, models like GPT- 91.06

3.5 and deepseek-coder achieve significantly lower perfor- F1 Score (%)

                                                                                                 90    89.54                                                 89.52

mance metrics compared to tailored baseline methods. For 88.76 88.38
88.27 example, on the validated test set in CCIB ENCH, GPT-3.5 88
records a recall of only 46.00 and an F1 score of 55.42. Simi- 87.24
86.64 larly, on the JITD ATA dataset, the F1 score of deepseek coder 86
(67.78) is outperformed by even traditional approaches such as CodeBERT
Bow, which achieves 74.48. Defau lt h=5 h=1 5 da = 0 da = 2 Epoc Epoc
Lamb Lamb Hyperparameter Settings RQ1 Result: The CCID ETECTOR method
exhibits better re- sults across both datasets, thereby establishing it
as the fore- Fig. 7: Hyperparameter analysis. most technique for
just-in-time CCI detection by 1.73%.

                                                                          6.3.3              Results

6.3 RQ2: How do different design choices enhance the performance of CCID
ETECTOR? Figure 7 evaluates how varying the number of epochs, 6.3.1
Motivation and the lambda parameter affects model accuracy on both the
full and validated test sets. With the default settings This RQ
investigates the impact of hyperparameter se- (epoch = 10, lambda = 1),
the model achieves its highest lection in the detector module and the
advantage of the accuracy of 89.54% on the full test set and 92.2% on
the iterative enhancement technique on detector performance. validated
test set. Reducing epochs to 5 lowers the full test set accuracy by 2.90
point and the validated set accuracy 6.3.2 Approach by 3.82 point.
Increasing epochs to 15 results in an 87.24% We experiment with various
detection model configu- accuracy on the full test set (a 2.30-point
drop) and 89.52% rations to understand hyperparameter effects on
results, on the validated test set (a 2.68-point reduction).
specifically adjusting the epoch in fine-tuning and the α in Adjusting
the lambda parameter shows similar effects. the loss function to balance
BCE loss and cosine similarity Setting lambda to 0 reduces the accuracy
on the full test regularisation. We then examine the impact of different
set to 88.76%, a drop of 0.78 percentage points, and on the iteration
numbers in iterative enhancement. validated test set to 91.64%, a drop
of 0.56 percentage points. MANUSCRIPT 11

TABLE 6: CCID ETECTOR performance with different itera- tion number.
CCIFixer 0.6533

     Iteration number    0       1       5      10      20
                                                                           C4RLLaMA                                        0.5867
         F1 score       86.6   86.92   87.84   89.54   89.42

Increasing lambda to 2 results in an accuracy of 88.27% DeepJIT 0.4867
on the full test set, a drop of 1.27 percentage points, and 91.06% on
the validated test set, a drop of 1.14 percentage 0.0 0.1 0.2 0.3 0.4
0.5 0.6 0.7 points. These results demonstrate that the default settings
Fig. 8: Success rate of human evaluation for the fixing. for epochs and
lambda strike an optimal balance between accuracy and generalization.
6.4.3 Results Table 6 illustrates the F1 scores of the CCID ETECTOR
model across varying iteration numbers, with the default The results
presented in Table 7 demonstrate the perfor- configuration set at 10
iterations. Under this standard con- mance of various fixing models.
Notably, CCIF IXER con- dition, the model attains the highest F1 score
of 89.54. In sistently outperforms all other models, delivering excep-
comparison, the F1 score is recorded at 86.6 for 0 iterations, tional
results across all metrics on both the full test set indicating a
significant enhancement of 2.94 points when and the validated test set.
In the full test set, CCIF IXER transitioning to the default
configuration. With 1 iteration, achieves the highest BLEU-4 and METEOR
scores of 68.78 the F1 score exhibits a slight increase to 86.92,
reflecting and 67.60, respectively, surpassing the next-best model, an
improvement of 0.32 points over 0 iterations. At the C4RLLaMA, by
margins of 4.22 and 9.34 points. Similarly, 5-iteration mark, the F1
score attains a value of 87.84, in the validated test set, CCIFixer
excels further, attaining representing a gain of 0.92 points compared to
1 iteration, SARI and GLEU scores of 74.56 and 74.90, which signifi-
although still falling short by 1.70 points relative to the cantly
exceed C4RLLaMA's scores of 67.04 and 66.83, with default setting.
Notably, when the number of iterations improvements of 7.52 and 8.07
points, respectively. For the is increased to 20, the F1 score registers
at 89.42, which "No Update" baseline, where the old comment is directly
is a marginal decrement of 0.12 points compared to the used as the
predicted output, relatively high performance default setting, thereby
indicating diminishing returns with is still achieved on certain
metrics. This is attributed to the escalation of iterations. This slight
performance drop the inherent similarity between the inconsistent
comments suggests the potential onset of overfitting, underscoring the
and the ground truth, where minimal adjustments suffice to importance of
selecting an optimal number of iterations to resolve inconsistencies.
balance performance gains with this risk. These findings Human
evaluation. Metrics such as BLEU-4 and METEOR, reinforce the notion that
our default configuration offers an which emphasize text similarity,
provide only a partial optimal setting. evaluation of the fixing
efficacy \[10\]. To comprehensively assess our approach, two authors
independently examined RQ2 Result: Experiments show that the model is
robust the predicted results in the validated test set to confirm the
across various hyperparameter configurations. Although de- accuracy of
the fixes. A unanimous consensus between the fault settings offer
balanced performance, tuning parameters authors signifies a successful
instance. The success rate is like epochs and iteration numbers also
yields high accuracy calculated as the ratio of successful cases to the
total number and F1 scores, highlighting the model's resilience and
adapt- of fixes. The authors attained a Cohen's Kappa coefficient of
ability across different scenarios. 0.86. Figure 8 illustrates the human
assessment results for 6.4 RQ3: How effective is CCIF IXER in fixing the
incon- the CCI fixing task. It can be inferred that in comparison to
sistency of the existing code comments? the baselines, CCIF IXER
achieves the highest success rate of 0.6533, surpassing the rates of
0.4867 for DeepJIT and 0.5867 6.4.1 Motivation for C4RLLaMA. This RQ
examines our CCIF IXER's effectiveness in cor- recting code comment
inconsistencies. RQ3 Result: CCIF IXER consistently outperforms all
other models and increases performance by 18.84% and 12.07% on 6.4.2
Approach GLEU in full and validated test set, respectively. Furthermore,
To evaluate fix performance, we compare it with ex- human evaluation
achieves a success rate of 65.33%, implying the potential for practical
use. isting models, including Panthaplackel et al. \[8\] and C4RLLaMA
\[10\]. For Panthaplackel et al., we use the pre- trained update model
due to its superior fix performance. 6.5 RQ4: How do LLM backbones and
tuning process Regarding C4RLLaMA, we adopt the "just-in-time with
enhance the performance of CCIF IXER? standard diff" setting, which
corresponds with our CCI task in just-in-time mode. We use all
inconsistent cases as the 6.5.1 Motivation test set (i.e. filter out all
consistent cases, leaving 1065 cases This RQ investigates the impact of
our different design in the full test set and 150 cases in the validated
test set), on the fixer model. unlike previous work \[8\]. This change
is important because, in consistent cases, the unchanged old comment
matches the 6.5.2 Approach ground truth exactly, causing evaluation
metrics like BLEU- We examine this issue from two distinct angles.
Initially, 4 and GLEU to be 1, which inflates the evaluation results. we
substitute various LLM backbones to determine if our MANUSCRIPT 12

                                             TABLE 7: The result of inconsistent case fixes.

                                                        Full Test Set                                                            Validated Test Set
                    Model
                                              BLEU-4   METEOR       SARI         GLEU                      BLEU-4                 METEOR        SARI                           GLEU
                    No Update                  48.31     35.27     19.16               37.03                   52.33                     36.52                20.62             37.69
                    Jointly trained SEQ        54.25     39.98     53.55               51.33                   62.11                     57.77                63.51             57.89
                    Jointly trained GRAPH      54.74     40.26     53.68               51.81                   63.33                     58.74                64.02             59.02
                    Jointly trained HYBRID     55.20     40.87     54.14               52.47                   64.08                     59.21                64.34             59.47
                    C4RLLaMA                   64.56     58.26     63.47               61.23                   68.67                     63.19                67.04             66.83
                    CCIFixer                   68.78     67.60     65.23               72.77                   75.63                     72.45                74.56             74.90

design has consistent effects across different models. Subse- 74.90 GLEU
70.49 quently, we remove the fine-tuning and alignment processes 21.80
37.69 to assess their influence on a particular LLM.

                                                                             VALIDATED TEST SET
                                                                                                                                                                                                                         74.56
                                                                                                    SARI                                                                                                        69.37
                                                                                                                                             26.21
                                                                                                                                 20.62
                                                                                                                                                                                                                    72.45

6.5.3 Results METEOR 16.96 68.82 36.52 The two figures present the
comparative evaluation 70.45 75.63 BLEU-4 19.03 of Qwen2.5-Coder-14B
(Figure 9) and LLaMA3.1-8B (Fig- 52.33 72.77 ure 10) across multiple
configurations (no update, base, fine- GLEU 14.06 69.18 37.03 tune only,
and fine-tune with alignment) using four metrics 65.23 62.74

                                                                             FULL TEST SET
                                                                                                    SARI

on both the validated test set and the full test set. First, 19.84 19.16

fine-tuning with alignment achieves the best performance METEOR 59.17
67.61 6.06 consistently across both models, all metrics, and test sets.
35.27 68.78 65.32 Qwen2.5-Coder-14B fine-tuned with alignment achieves
BLEU-4 8.31 48.31 GLEU (74.90), while LLaMA3.1-8B achieves GLEU (69.46).
0.00 10.00 20.00 30.00 40.00 50.00 60.00 70.00 80.00

This consistent improvement across models validates the
Qwen2.5-Coder-14B fine-tune and alignment Qwen2.5-Coder-14B fine-tune
only

effectiveness of the alignment strategy in enhancing model
Qwen2.5-Coder-14B base No Update

performance. Second, models without any fine-tuning perform poorly Fig.
9: The fixing result of Qwen2.5-Coder-14B with different across all
metrics. For example, the base Qwen2.5-Coder- strategy settings. 14B
achieves GLEU (21.80) and METEOR (16.96) on the val- idated test set,
while LLaMA3.1-8B base scores even lower, 63.02 69.46 GLEU with GLEU
(19.84) and METEOR (12.19). Interestingly, the 19.84 37.69

result is even worse than "no update". Note that it does not 67.28
VALIDATED TEST SET

                                                                                                    SARI                                                                                      57.83
                                                                                                                                   21.38

suggest that a base LLM's fix introduces more inconsistency; 20.62 64.32
it may be because the base LLM lacks the ability to align METEOR 12.19
59.73 36.52 with the dataset-specific comment preferences. 68.58 61.94
Third, Qwen2.5-Coder-14B consistently outperforms BLEU-4 15.36 52.33
LLaMA3.1-8B across all metrics and configurations. For 60.74 GLEU 59.39
instance, in the validated test set, Qwen2.5-Coder achieves 11.98 37.03

higher GLEU (74.90) and BLEU-4 (75.63) scores compared SARI 48.29 53.37
FULL TEST SET

                                                                                                                               17.85

to LLaMA3.1-8B's GLEU (69.46) and BLEU-4 (68.58). This 19.16 52.28
performance gap can likely be attributed to the larger pa- METEOR 5.72
47.92 35.27 rameter size of Qwen2.5-Coder (14B vs. 8B) and its de- 59.31
55.16 sign as a coding-specific model, whereas LLaMA3.1-8B is BLEU-4
6.24 48.31 not primarily trained for code. Nevertheless, the observed
0.00 10.00 20.00 30.00 40.00 50.00 60.00 70.00 80.00 improvements across
both models demonstrate that the LLaMA3.1-8B fine-tune and alignment
LLaMA3.1-8B fine-tune only LLaMA3.1-8B base No Update

proposed fine-tuning and alignment method is robust and effective,
regardless of model scale or type. Fig. 10: The fixing result of
LLaMA3.1-8B with different strategy settings. RQ4 Result: The
fine-tuning and alignment techniques en- hance the performance of CCIF
IXER. Additionally, CCIF IXER is shown to be both robust and efficient
for general-purpose Subsequently, they focus their efforts on fixing the
cases LLMs as well as code-focused LLMs. that are inconsistent.
Therefore, this RQ aims to evaluate the combined effectiveness and
efficiency of CCIS OLVER in 6.6 RQ5: How effective and efficient is CCIS
OLVER at a simulated real-world workflow. This directly addresses
end-to-end CCI detection and repair compared to exist- the need to
understand how CCID ETECTOR and CCIF IXER ing method? work together and
how the system performs when applied 6.6.1 Motivation to a large-scale
codebase, where computational resources Preious research questions have
separately evaluated the and time are practical constraints. We
investigate whether performance of our two main component. In real-world
our two-stage approach---a lightweight detector followed application, a
developer would first use the detection tool by a more powerful
fixer---is more practical than using a to scan a batch of modified code
to identify potential CCIs. single, monolithic model for both tasks.
MANUSCRIPT 13

                   TABLE 8: The end-to-end performance comparisons of CCIS OLVER with the baseline.

                          Accuracy   Precision   Recall    F1     BLEU-4   METEOR     SARI    GLEU     inference time
             C4RLLaMA       89.16      88.24     89.10    88.67    66.35     59.87    65.79   63.24       0.9618
             CCIS OLVER     89.92      89.84     89.25    89.54    72.42     70.14    70.93   76.31       0.6164

6.6.2 Approach changes the return type of the method. Among the three To
evaluate the end-to-end performance in a realistic prediction methods,
CCIF IXER provides a return comment setting, our approach simulates a
complete workflow. We that is accurate but less informative compared to
the ground use the entire CCIB ENCH testset as our test data. We execute
truth and C4RLLaMA. While it correctly identifies the return the full
pipeline of CCIS OLVER, where the CCID ETECTOR type
UserInformationResponse, it does not offer additional component first
scans the entire dataset to identify all in- descriptive context about
what the object contains. In com- stances it predicts as inconsistent,
after which only these parison, C4RLLaMA stands out by including details
about flagged instances are passed to the CCIF IXER component for the
returned object, specifying that it contains "the received repair. We
choose C4RLLaMA as a baseline and assess the user information", which
closely aligns with the ground performance from two deimensions:
effectiveness and effi- truth. However, CCIF IXER performs comparably to
the Hy- ciency. In practice, the time spent on detecting and updating
brid Prediction, both prioritizing accuracy and brevity but a CCI is
significant in the JIT mode. Thus, we introduce the lacking the depth
needed for optimal documentation. As average time spent on detecting and
updating a single CCI a result, CCIF IXER could benefit from
incorporating more (inference time) \[43\] to represent the time
efficency. descriptive elements to enhance the clarity and utility of
its predictions. 6.6.3 Results In the case shown in Figure 12, CCIF IXER
provides the The results of the end-to-end performance comparison best
performance by accurate prediction, which perfectly between CCIS OLVER
and the C4RLLaMA baseline are pre- aligns with the ground truth. It
effectively reflects the up- sented in Table 8. The findings clearly
demonstrate that dated code, capturing the essence of the parameter's
role CCIS OLVER achieves superior performance in both effec- with
clarity and correctness. In contrast, Hybrid Prediction tiveness and
efficiency. fails to adapt to the code change, erroneously describing
the In terms of effectiveness, CCIS OLVER demonstrates en- version as
"the current time in millis," which corresponds hancements in both
detection and correction tasks. For to the old implementation. This
demonstrates a lack of con- the detection phase, CCID ETECTOR attains an
F1-score of textual understanding and results in an incorrect
prediction. 89.54, surpassing C4RLLaMA's 88.67. The edge is even more
C4RLLaMA's prediction, "@param version The version", is substantial in
the correction phase, where CCIF IXER signif- vague and overly generic.
While it avoids being outright icantly outperforms C4RLLaMA in all text
generation met- incorrect, it fails to provide any meaningful detail
about the rics, achieving a GLEU score of 76.31, while C4RLLaMA is
parameter, making it less useful for developers. 63.24. This indicates
that our proposed pipeline CCIS OLVER The code change updates the logic
of the findIfAc- not only accurately detects inconsistencies but also
delivers tualMin method by replacing the old actual l and actual L
superior quality corrections. parameters with preBound and postBound,
reflecting a shift Regarding efficiency, which is critical for
application in in terminology and functionality. Specifically, the
condition large codebases with limited resources, CCIS OLVER demon- now
uses preBoundChange and maxPostBound instead of d strates a substantial
advantage. The average inference time and L, and the output event
parameters have been updated for CCIS OLVER to process a single instance
is 0.6164 sec- accordingly. This indicates a refinement in the method's
onds, which is approximately 36% faster than C4RLLaMA's logic, aligning
it with a more robust schema. Among the 0.9618 seconds. This directly
validates the architectural de- fixing methods, CCIS OLVER demonstrates
the best perfor- sign of CCIS OLVER. mance by accurately reflecting the
updated code's context, correctly identifying preBound and postBound
along with RQ5 Result: The end-to-end evaluation confirms that the their
conditions (preBoundChange, maxPostBound) and two-stage architecture of
CCIS OLVER is both more effective aligning its comment with the updated
logic, matching the and time efficient, improving detection and fixing
quality ground truth. In contrast, Hybrid Prediction fails to adapt
while reducing inference time by approximately 36%, making to the code
changes, referencing the obsolete actual l and it a more practical and
scalable solution. providing a vague, incomplete description. C4RLLaMA
also fails to adapt, retaining references to outdated parameters 6.7
Case study and conditions (d, L), making its prediction inaccurate and
misleading. CCIS OLVER stands out as the only method In this section, we
conduct a case study to understand providing a clear and contextually
appropriate comment. the fixing ability of CCIF IXER compared to DeepJIT
and C4RLLaMA. Overall, the case studies highlight the varying strengths
Figure 11--13 shows three real-world examples from the and weaknesses of
the three prediction models. CCIF IXER consistently excels in producing
accurate and contextu- test sets. Light red and light green indicate the
code ally aligned comments that reflect the updated code logic, block
sections affected by code changes, while dark red making it the most
reliable model in terms of correctness. and dark green highlight the
keywords related to code However, its comments occasionally lack the
depth and de- comments. Figure 11 shows a return inconsistent case which
scriptiveness needed for optimal clarity, as seen in the return
MANUSCRIPT 14

    Old code comment: @return UserInfoResponse Object                            Old code comment: if d, L conditions are met, send stream event output
    Related code change:                                                         with extrema type, actual_l (distance at which a value satisfying d condition
    - public UserInfoResponse getUserInfo(OIDCConfiguration                      is found), actual_L (distance at which a value satisfying D condition is found)
    oidcConfiguration, String acsToken) throws UserInfoException {               Related code change:
    + public UserInformationResponse getUserInfo(OIDCConfiguration               private StreamEvent findIfActualMin(AttributeDetails latestEvent) {
                                                                                    int indexCurrentMin = valueStack.indexOf(currentMin);
    oidcConfiguration, String acsToken) throws UserInfoException {
                                                                                 - int actual_L = valueStack.indexOf(latestEvent) - indexCurrentMin;
       BearerAccessToken accessToken = new BearerAccessToken(acsToken);
                                                                                 - if (actual_L > L) {...}
       URI userInfoEndpoint = oidcConfiguration.getUserInfoEndpoint();           + int postBound = valueStack.indexOf(latestEvent) - indexCurrentMin;
       UserInfoRequest userInfoRequest = new                                     + if (postBound > maxPostBound) {...}
    UserInfoRequest(userInfoEndpoint, accessToken);                              - int actual_l = NUM;
       HTTPRequest request = userInfoRequest.toHTTPRequest();                    - double dThreshold = currentMin.getValue() + currentMin.getValue() * d / NUM;
       return processUserInfoResponse(request);                                  - while (actual_l <= l && indexCurrentMin - actual_l >= NUM) {
     }                                                                           -      if (valueStack.get(indexCurrentMin - actual_l).getValue() >= dThreshold) {
    Ground truth: @return {@link UserInformationResponse} Object with            + if (maxPreBound == NUM) {
    received values.                                                             +       StreamEvent outputEvent = eventStack.get(indexCurrentMin);
    Hybrid prediction: @return {@link UserInformationResponse} Object            +       complexEventPopulater.populateComplexEvent(outputEvent, new Object[]
    C4RLLaMA prediction: @return {@link UserInformationResponse}                 { STR, NUM, postBound });
    Object containing the received user information.                             +       currentMin.sentOutputAsRealMin();
    CCIFixer prediction: @return {@link UserInformationResponse} Object          +       return outputEvent; }
                                                                                 + int preBound = NUM;
                                                                                 + double dThreshold = currentMin.getValue() + currentMin.getValue() *
                                                                                 preBoundChange / NUM;
                Fig. 11: Return inconsistency case.                              + while (preBound <= maxPreBound && indexCurrentMin - preBound >= NUM) {
                                                                                 +       if (valueStack.get(indexCurrentMin - preBound).getValue() >= dThreshold) {
    Old code comment: @param now The current time in millis, as                             StreamEvent outputEvent = eventStack.get(indexCurrentMin);
    returned by System#currentTimeMillis()                                       -          complexEventPopulater.populateComplexEvent(outputEvent, new Object[]
    Related code change:                                                         { STR, actual_l, actual_L });
    - public CalciteSchema createSnapshot(long now) {                            +           complexEventPopulater.populateComplexEvent(outputEvent, new Object[]
    + public CalciteSchema createSnapshot(SchemaVersion version) {               { STR, preBound, postBound });
                                                                                            currentMin.sentOutputAsRealMin();
        Preconditions.checkArgument(this.isRoot(), "must be root schema");
                                                                                            return outputEvent;
    - return snapshot(null, now);
                                                                                     ......
    + return snapshot(null, version);
                                                                                 Ground truth: if preBoundChange, maxPostBound conditions are met, send
      }                                                                          stream event output with extrema type, preBound (distance at which a value
    Ground truth: @param version The current schema version                      satisfying preBoundChange condition is found), postBound (distance at
    Hybrid prediction: @param version The current time in millis, as             which a value satisfying postBoundChange condition is found)
    returned by System#currentTimeMillis()                                       Hybrid prediction: send stream event output with extrema type, actual_l
    C4RLLaMA prediction: @param version The version.                             (condition is found), actual condition found)
    CCIFixer prediction: @param version The current schema version               C4RLLaMA prediction: if d, L conditions are met, send stream event
                                                                                 output with extrema type, actual_l (distance at which a value satisfying d
                                                                                 condition is found), actual_L (distance at which a value satisfying D
                 Fig. 12: Param inconsistency case.                              condition is found)
                                                                                 CCIFixer prediction: if preBoundChange, maxPostBound conditions are met,
                                                                                 send stream event output with extrema type, preBound (distance at which a

case. Hybrid Prediction shows significant shortcomings, of- value
satisfying preBoundChange condition is found), postBound (distance at
ten failing to adapt to code changes and relying on obsolete which a
value satisfying postBoundChange condition is found) or incorrect
references, which limits its utility. C4RLLaMA, while occasionally more
descriptive, suffers from a lack of accuracy and contextual awareness in
critical cases, such as Fig. 13: Summary inconsistency case. retaining
outdated parameter names and conditions. These observations underscore
CCIF IXER 's strong fixing ability semantic reasoning capabilities.
while highlighting the need for further enhancements in Figure 14b
illustrates a different kind of limitation for providing more
descriptive and developer-friendly com- CCIF IXER, one that arises when
the original comment lacks ments. substantive content. In this case, the
old comment is merely While the successful cases demonstrate the
effective- a placeholder, "Not implemented yet", which provides no ness
of CCIS OLVER, analyzing its failures is crucial for a semantic
information about the method's intended func- comprehensive
understanding of its limitations. Figure 14 tionality. Consequently,
when the method's body undergoes presents two failure cases, one for
CCID ETECTOR and one a significant change from being empty to containing
a for CCIF IXER, which reveal areas for future improvement. complex
implementation with conditional logic, CCIF IXER In the CCID ETECTOR
failure case shown in Figure 14a, is deprived of a crucial reference. It
cannot perform a com- the model incorrectly classifies a clear
inconsistency as parative analysis between the old comment and new code;
consistent. The code modification involves changing the instead, it must
generate a comment entirely from scratch method parameter's type from
Class to AuthenticationToken based solely on its interpretation of the
new code. and updating the return statement's logic to handle the This
lack of a content-rich anchor makes the generation new type (i.e.,
token.getClass()) along with a null check. task significantly more
challenging. Without the context CCID ETECTOR's failure to detect this
inconsistency likely information from a previous comment, the model's
output stems from its inability to fully grasp the semantic shift can
become less reliable, especially for non-trivial code. As behind the
syntactically similar code. The core API call, seen in its prediction,
"Tries to find a stub that has already isAssignableFrom, remains in both
versions of the code. The been created for the given portName", CCIF
IXER only grasps a model may have over-indexed on this syntactic
similarity, partial aspect of the new logic. The absence of a meaningful
failing to recognize the critical change in how the parameter old
comment as a guide seems to have hindered its ability is used
(token.getClass() and tokenClass). This suggests that to form a
complete, holistic understanding of the two-path the CCID ETECTOR, while
generally robust, can be brittle control flow, leading to an incomplete
and inaccurate sum- when faced with changes that are subtle in syntax
but mary. This failure highlights a specific weakness: CCIF IXER
significant in semantics, highlighting a need for deeper is most
effective when it can update an existing description, MANUSCRIPT 15

      Old code comment: Convenience implementation that returns                    in fixing CCI using four text-based metrics. However, we
      getAuthenticationTokenClass().isAssignableFrom( tokenClass );.               found that higher scores in these metrics do not necessarily
      Related code change:
      - public boolean supports(Class tokenClass) {                                reflect better fixing performance. This is partly because pre-
      + public boolean supports(AuthenticationToken token) {                       fix comments are often already similar to the ground truth,
      +     if ( log.isInfoEnabled() ) {                                           and successful fixes might not improve metric scores if
      +         log.info(“Received null AuthenticationToken. Returning false for
      supports(token) implementation (can‘t process null tokens).” );}             the predicted comments use synonyms. Additionally, dif-
      - return getAuthenticationTokenClass().isAssignableFrom( tokenClass );       ferent metrics may yield inconsistent results, with models
      + return token != null &&
      getAuthenticationTokenClass().isAssignableFrom(token.getClass());
                                                                                   performing well in one but poorly in another. Therefore,
      }                                                                            metrics like BLEU and METEOR, although widely used in
      CCIDetector prediction: consistency                                          other tasks, might not be ideal for evaluating CCI fixes. An
      Ground truth prediction: inconsistency
      Ground truth comment: Convenience implementation that returns                alternative assessment method is a manual evaluation, as
      getAuthenticationTokenClass().isAssignableFrom( token.getClass() );.         demonstrated in RQ4, which addressing these issues, but
                                                                                   also has limitations. It may introduce bias and can only be
                   (a) Failure case for CCID ETECTOR.                              applied to a limited amount of data. Further alternatives still
      Old code comment: Not implemented yet                                        need to be discovered.
      Related code change:
      public Remote getPort(QName portName, Class proxyInterface) throws
      ServiceException {
      + // First, try to find a generated stub. If that                                Appropriate design of prompt strategies for LLMs may en-
      + // returns null, then find a dynamic stub.                                 hance their performance. Our experiments reveal that prompt
      + Remote stub = getGeneratedStub(portName, proxyInterface);                  quality greatly affects the results. Providing LLMs with
      - return getPort(null, portName, proxyInterface);
      + return stub != null ? stub : getPort(null, portName, proxyInterface);      examples similar to the target code and comment snippets
      }                                                                            yields better outputs than just using instructions. However,
      Ground truth: Return either an instance of a generated stub, if it can
      be found, or a dynamic proxy for the given proxy interface.
                                                                                   the detection performance with 4-shot ICL remains lower
      CCIFixer prediction: Tries to find a stub that has already been created      than task-specific baselines. Further research could focus on
      for the given portName.                                                      developing improved prompting strategies.
                       (b) Failure case for CCIF IXER.
                                                                                       Rationale for CCID ETECTOR’s design and optimality. An
    Fig. 14: Two failure cases in detection and repair stage.                      important consideration is whether the architecture and

but its performance diminishes when it must perform pure data
enhancement strategy used in CCID ETECTOR are op- code summarization on
complex logic without any prior timal. While the space of all possible
models is infinite, semantic context. our design choices were guided by
extensive empirical validation against a wide array of alternatives. In
our RQ1 7 D ISCUSSION evaluation, CCID ETECTOR is benchmarked against
different 7.1 Implications baselines. Its superior performance across
both the full and The necessity of building high-quality datasets. To
the best validated test sets demonstrates the effectiveness of our of
our knowledge, although some previous studies \[9\], \[10\]
architectural choices, such as our code diff representation have
recognized the possible influence of assumptions made and
similarity-based classifier. Furthermore, the contribu- during data
collection on labeling errors, this research is pi- tion of our
iterative enhancement strategy is validated in oneering in quantifying
the extent of these errors. Our initial the ablation study for RQ2. The
results in Table 6 show that analysis of the widely-used dataset reveals
that, within our this targeted approach, which focuses on generating
difficult manually inspected sample, 45.67% of positive instances are
cases the model misclassifies, yields a significant F1-score incorrectly
identified. This contributes considerable noise, improvement of 2.94
points compared to no enhancement. potentially degrading the
effectiveness of methods trained Together, these findings confirm that
while other configura- with these datasets. tions may exist, our
proposed design is a highly effective Appropriate data augmentation can
improve performance. and robust solution, validated by its
outperformance of Data augmentation has long been explored in
traditional numerous alternative strategies. NLP fields \[34\], \[35\].
Inspired by this, recent advancements in LLMs have spurred a new wave of
data generation The efficiency for CCIS OLVER pipeline design. CCI-
methods. For instance, several studies have successfully S OLVER's
architecture is specifically designed for practi- employed LLMs to
create new training data for various cal efficiency, comprising a
lightweight CCID ETECTOR and SE tasks \[54\], \[55\], \[56\], \[57\],
\[58\]. Our work aligns with an LLM-based CCIF IXER. In a real-world
workflow, the this emerging direction. As shown in Table 6, our experi-
lightweight detector first filters out the vast majority of ments
confirm that iteratively synthesizing incorrectly pre- consistent
code-comment pairs, allowing the computation- dicted cases could enhance
CCID ETECTOR's performance. ally expensive fixer to process only the
small subset of in- Nevertheless, owing to constraints on computational
re- stances flagged as inconsistent. This two-stage design makes
sources, we do not evaluate this augmentation technique CCIS OLVER
approximately 36% faster than the baseline in against other comparative
methods. Theoretically, most of the end-to-end evaluation. More
importantly, given that the the training-dependent approaches could
benefit from data proportion of inconsistencies in real-world code
commits is augmentation techniques. typically far lower than in our test
set, CCIS OLVER 's actual Text-based metrics cannot indicate the
performance of the efficiency improvement could exceed the measured
number, fix method. Table 7 analyzes the effectiveness of methods making
it a highly practical and scalable solution. MANUSCRIPT 16

7.2 Threats to Validity \[60\]. This lack of synchronization between
code and com- ments can result in inefficiencies, such as wasted time
dur- 7.2.1 Construct validity ing development and debugging, and may
contribute to the Dataset cleaning. The process of cleaning datasets is
chal- introduction of errors in the software \[61\]. lenging, primarily
because fundamental assumptions about A significant amount of previous
research \[62\], \[63\] fo- existing inconsistencies in the dataset
often contain signifi- cused on the issue of inconsistencies in code and
comments. cant flaws. Due to the extensive size of the dataset, manually
These studies can be broadly categorized into two main inspecting
numerous inconsistent instances is not feasible. types based on their
detection timing. Consequently, we utilized LLMs to autonomously assess
Just-in-time. Xu et al. \[9\] tackled data quality concerns,
inconsistencies, although this approach does not guarantee showing that
accuracy can improve even with a few label dataset quality. To mitigate
this issue, we introduced a vot- corrections on a small dataset. They
proposed an adver- ing mechanism to attest the true inconsistency of
retained sarial learning framework that making CCI predictions. data.
Furthermore, we developed a validated test set to Dau et al. \[19\]
introduced DocChecker, a tool that utilizes enhance the assessment of
performance. a pre-trained code language model in conjunction with
contrastive learning. Liu et al. \[5\] developed an obsolete 7.2.2
Internal validity comment detector based on a unique neural network
model Potential data leakage. We use LLMs to clean false positive
designed to predict whether a comment requires updating.
inconsistencies, enhance the dataset by iteratively synthe- Steiner et
al. \[20\] proposed two models---one based on sizing incorrect
predictions, and serve as the backbone BERT \[64\] and the other on
Longformer \[65\]---to detect for correcting inconsistent comments. The
training data of inconsistencies in the context of natural language
inference. LLMs are not publicly available, raising concerns about
Panthaplackel et al. \[8\] utilized gated graph neural networks
potential data leakage. However, our experiments show that to embed code
sequences and abstract syntax tree (AST) prompting LLMs to detect
inconsistent code comments does data, effectively linking comments to
code changes. not produce promising outcomes. Thus, we believe the fix
Post-hoc. Rabbi et al. \[66\] proposed an ensemble ap- comments
generated by CCIFixer are not merely a result of proach using multiple
topic modeling techniques to detect memorizing training data. Human
involvement. We manually inconsistencies between code and comments more
robustly. study code-comment inconsistencies, construct a validated
Ouyang et al. \[67\] explored code-documentation viola- test set, and
conduct end-to-end performance checks. This tions in Rust, developing
tools to identify and understand process may introduce bias, so we
employ two independent breaches in code documentation practices for this
specific annotators with more than seven years of experience to
programming language. Ratol et al. \[60\] utilized heuristic- minimize
this risk. Any discrepancies are resolved through based rules to detect
fragile comments in source code, discussion until consensus is achieved.
We achieved a Co- identifying annotations that are likely to become
obsolete hen's Kappa of 0.91 for the manual studies, 0.95 for the test
due to code changes. set construction, and 0.86 for the performance
checks. The aforementioned studies represent significant progress in CCI
detection and repair, employing techniques from deep learning to
advanced pre-trained models. 7.2.3 External validity However, our work
is distinguished from these state-of-the- The selection of programming
languages. The programming art methods in several aspects. While many
existing tools language of our source data is Java, which may raise
ques- are primarily detectors , CCIS OLVER is a comprehensive tions
about the generalizability of our proposed method to framework designed
for both detection and automated other programming languages. However,
Java is among the repair. Our two-stage architecture is fundamentally
most prevalent programming languages for code comment different from
LLM-based solutions. CCIS OLVER combines research purposes, in
accordance with previous works \[5\], a lightweight deep learning model
(CCID ETECTOR) for \[8\]. The core idea of detection and fix can be
generalized efficient, large-scale detection with a powerful LLM-based
to other languages easily. The selection of LLMs. There are no fixer
(CCIF IXER) that is only invoked on the small subset established
criteria for evaluating better LLMs. In this study, of identified
inconsistencies. This design makes our we choose three popular
general-purpose LLMs (GPT3.5, framkework a more practical and scalable
solution for GPT4o, LLaMA3.1) and one code-specific LLM (Deepseek-
real-world software development workflows. coder) as baselines, which
are commonly used in related software engineering research \[44\]. Our
CCIFixer's perfor- 8.2 Empirical Studies on Code Comment mance may vary
with different LLM backbones. We choose Prior research has explored code
comments from var- Qwen2.5-Coder-14b due to its powerful performance in
ious perspectives \[68\], \[69\]. For example, Jabrayilzade et
code-related tasks \[59\] and our resource limitations. al. \[70\]
developed a taxonomy of inline code comment smells and analyzed the
frequency of each smell type across 8 R ELATED W ORK software projects.
Wang et al. \[71\] examined independent comment changes to propose a new
proxy for studying 8.1 Code-Comment Inconsistency Detection suboptimal
comments, uncovering insights regarding the Comments are essential in
the software development prevalence, practices, and impact of commenting
guidelines lifecycle as they facilitate understanding and
maintainability and comment-checking tools. Zhai et al. \[72\]
introduced a of code \[29\]. However, comments are not always consis-
method leveraging program analysis to systematically de- tently updated
to reflect modifications in the codebase \[11\], rive, refine, and
propagate code comments. They developed MANUSCRIPT 17

a comprehensive taxonomy and classifier for comments, \[7\] Z. Liu, H.
Chen, X. Chen, X. Luo, and F. Zhou, "Automatic demonstrating its
effectiveness in enhancing software en- Detection of Outdated Comments
During Code Changes," in 2018 IEEE 42nd Annual Computer Software and
Applications Conference gineering tasks by generating precise comments
and identi- (COMPSAC), vol. 01, 2018, pp. 154--163. fying bugs. Wen et
al. \[73\] performed the most extensive \[8\] S. Panthaplackel, J. J.
Li, M. Gligoric, and R. J. Mooney, "Deep Just- empirical study to date
on the co-evolution of code and In-Time Inconsistency Detection Between
Comments and Source comments, revealing multiple instances where
developers Code," Proceedings of the AAAI Conference on Artificial
Intelligence (AAAI), vol. 35, no. 1, pp. 427--435, 2021. either
introduced or resolved inconsistencies between code \[9\] S. Xu, Y. Yao,
F. Xu, T. Gu, J. Xu, and X. Ma, "Data Quality and comments. Their
combined quantitative and qualitative Matters: A Case Study of Obsolete
Comment Detection," in 2023 analyses provided distilled lessons and
actionable recom- IEEE/ACM 45th International Conference on Software
Engineering mendations for both researchers and practitioners. In addi-
(ICSE). Melbourne, Australia: IEEE, 2023, pp. 781--793. \[10\] G. Rong,
Y. Yu, S. Liu, X. Tan, T. Zhang, H. Shen, and J. Hu, "Code tion, there
is also significant research interest in automated comment inconsistency
detection and rectification using a large comment generation and
improvement \[45\], \[74\], \[75\]. language model," in 2025 IEEE/ACM
47th International Conference 9 C ONCLUSION AND F UTURE W ORK on
Software Engineering (ICSE). IEEE, 2025, pp. 432--443. \[11\] Z. Xu, S.
Guo, Y. Wang, R. Chen, H. Li, X. Li, and H. Jiang, To assess data
quality issues, our motivating study an- "Code Comment Inconsistency
Detection Based on Confidence alyzed a representative sample of the
JITDATA dataset, Learning," IEEE Transactions on Software Engineering
(TSE), vol. 50, no. 3, pp. 598--617, 2024. and the results indicated
that approximately 45.67% of \[12\] M. R. Lyu, B. Ray, A. Roychoudhury,
S. H. Tan, and P. Thong- the sampled CCIs were false positives. These
mislabeled tanunam, "Automatic programming: Large language models and
cases stemmed from four main sources: information addi- beyond," ACM
Trans. Softw. Eng. Methodol., vol. 34, no. 5, May tions/deletions, typo
corrections, case changes, and lexical 2025. modifications. To address
these quality concerns, we cre- \[13\] OpenAI, "Gpt-4o," 2024, accessed:
2024-06-18. \[Online\]. Available:
https://openai.com/index/hello-gpt-4o/ ated CCIB ENCH, a refined dataset
derived from JITD ATA. \[14\] Anthropic, "Claude 3.5: Sonnet," 2024,
accessed: 2024- CCIB ENCH1 incorporates robust de-duplication, syntactic
07-10. \[Online\]. Available: https://www.anthropic.com/news/ cleaning,
and semantic filtering to ensure high-quality data claude-3-5-sonnet for
CCI detection and fixing tasks. Furthermore, we present \[15\] AI@Meta,
"Llama 3 model card," 2024. \[Online\]. Available:
https://github.com/meta-llama/llama3/blob/main/ CCIS OLVER, an
end-to-end framework for handling CCIs. MODEL CARD.md It combines two
main components: CCID ETECTOR, a deep \[16\] S. Panthaplackel, M.
Gligoric, R. J. Mooney, and J. J. Li, "Asso- learning model for
identifying inconsistencies, and CCI- ciating natural language comment
and source code entities," in F IXER, an LLM-based system for comment
repair. Proceedings of the AAAI Conference on Artificial Intelligence
(AAAI), vol. 34, no. 05, 2020, pp. 8592--8599. In forthcoming research,
our aim will be to rigorously \[17\] S. Boslaugh, Statistics in a
nutshell: A desktop quick reference. assess methodologies for
determining the success of prob- O'Reilly Media, Inc., 2012. lem
resolution. As highlighted previously, metrics derived \[18\] J. Sim and
C. C. Wright, "The kappa statistic in reliability studies: from text
(BLEU) are inadequate for this task. Conversely, use, interpretation,
and sample size requirements," Physical ther- apy, vol. 85, no. 3,
pp. 257--268, 2005. manual evaluation is neither scalable for extensive
datasets \[19\] A. T. V. Dau, J. L. C. Guo, and N. D. Q. Bui, "Doc- nor
free from potential bias. The concept of LLM-as-a-judge Checker:
Bootstrapping Code Large Language Model for Detect- has recently emerged
as a viable avenue for SE tasks \[76\]. ing and Resolving Code-Comment
Inconsistencies," arXiv preprint We will persist in investigating the
practicality of utilizing arXiv:2306.06347, 2024. \[20\] T. Steiner and
R. Zhang, "Code comment inconsistency detection this approach for
evaluating tasks. with bert and longformer," arXiv preprint
arXiv:2207.14444, 2022. \[21\] L. Zheng, W.-L. Chiang, Y. Sheng, S.
Zhuang, Z. Wu, Y. Zhuang, R EFERENCES Z. Lin, Z. Li, D. Li, E. Xing et
al., "Judging llm-as-a-judge with mt- bench and chatbot arena," Advances
in Neural Information Processing \[1\] L. Pascarella, M. Bruntink, and
A. Bacchelli, "Classifying code Systems (NeurIPS), vol. 36, pp. 46
595--46 623, 2023. comments in java software systems," Empirical
Software Engineer- \[22\] LiveCodeBench, "Livecodebench leaderboard,"
https: ing (EMSE), vol. 24, no. 3, pp. 1499--1537, 2019.
//livecodebench.github.io/leaderboard.html, 2024, accessed: \[2\] Y.
Padioleau, L. Tan, and Y. Zhou, "Listening to program- 2024-12-27.
mers---taxonomies and characteristics of comments in operating \[23\] S.
Gao, C. Gao, W. Gu, and M. Lyu, "Search-based llms for code system
code," in 2009 IEEE 31st International Conference on Software
optimization," in 2025 IEEE/ACM 47th International Conference on
Engineering (ICSE). IEEE, 2009, pp. 331--341. Software Engineering
(ICSE). IEEE, 2025, pp. 254--266. \[3\] R. P. Buse and W. R. Weimer,
"Learning a metric for code readabil- \[24\] R. Zhong, Y. Li, G. Yu, W.
Gu, J. Kuang, Y. Huo, and M. R. ity," IEEE Transactions on software
engineering (TSE), vol. 36, no. 4, Lyu, "Larger is not always better:
Exploring small open-source pp. 546--558, 2009. language models in
logging statement generation," arXiv preprint \[4\] R. Zhong, " Towards
Quality Assurance of Natural Language in arXiv:2505.16590, 2025. Code ,"
in 2025 IEEE/ACM 47th International Conference on Software Engineering:
Companion Proceedings (ICSE-Companion). IEEE, May \[25\] S. Arora, A.
Narayan, M. F. Chen, L. Orr, N. Guha, K. Bhatia, 2025, pp. 187--189. I.
Chami, and C. Re, "Ask me anything: A simple strategy for \[5\] Z. Liu,
X. Xia, D. Lo, M. Yan, and S. Li, "Just-In-Time Obsolete prompting
language models," in The Eleventh International Confer- Comment
Detection and Update," IEEE Transactions on Software ence on Learning
Representations, 2023. Engineering (TSE), vol. 49, no. 1, pp. 1--23,
2023. \[26\] S. Gao, X.-C. Wen, C. Gao, W. Wang, H. Zhang, and M. R.
\[6\] S. Projects, "Code comment inconsistency Lyu, "What makes good
in-context demonstrations for code in- cases in spring-data-mongodb,"
https://github. telligence tasks with llms?" in 2023 38th IEEE/ACM
International com/spring-projects/spring-data-mongodb/blob/ Conference
on Automated Software Engineering (ASE). IEEE, 2023,
74654cd7c788cdc53b05afe892607396a00f50a2/ pp. 761--773.
spring-data-mongodb/src/main/java/org/springframework/ \[27\] A.
LeClair, S. Jiang, and C. McMillan, "A neural model for generat-
data/mongodb/core/mapreduce/MapReduceResults.java#L142, ing natural
language summaries of program subroutines," in 2019 2024, accessed:
2024-12-15. IEEE/ACM 41st International Conference on Software
Engineering (ICSE). IEEE, 2019, pp. 795--806. 1. Data are available at
https://drive.google.com/drive/folders/1c4iTYKoe \[28\] P. S.
Foundation, difflib, 2025, accessed: 2025-11-27. \[Online\].
UnXnV9qUXKwp95Fs6eolyLiY?usp=sharing. Available:
https://docs.python.org/3/library/difflib.html MANUSCRIPT 18

\[29\] S. Panthaplackel, P. Nie, M. Gligoric, J. J. Li, and R. Mooney,
\[48\] Q. Zhu, D. Guo, Z. Shao, D. Yang, P. Wang, R. Xu, Y. Wu,
"Learning to Update Natural Language Comments Based on Code Y. Li, H.
Gao, S. Ma et al., "Deepseek-coder-v2: Breaking the bar- Changes," in
Proceedings of the 58th Annual Meeting of the Associa- rier of
closed-source models in code intelligence," arXiv preprint tion for
Computational Linguistics (ACL). Online: Association for
arXiv:2406.11931, 2024. Computational Linguistics, 2020, pp. 1853--1868.
\[49\] K. Papineni, S. Roukos, T. Ward, and W.-J. Zhu, "Bleu: a method
\[30\] D. Guo, S. Lu, N. Duan, Y. Wang, M. Zhou, and J. Yin, "Unix- for
automatic evaluation of machine translation," in Proceedings of coder:
Unified cross-modal pre-training for code representation," the 40th
annual meeting of the Association for Computational Linguis- in
Proceedings of the 60th Annual Meeting of the Association for tics
(ACL), 2002, pp. 311--318. Computational Linguistics (Volume 1: Long
Papers), 2022, pp. 7212-- \[50\] S. Banerjee and A. Lavie, "Meteor: An
automatic metric for mt 7225. evaluation with improved correlation with
human judgments," in \[31\] L. Dong, N. Yang, W. Wang, F. Wei, X. Liu,
Y. Wang, J. Gao, Proceedings of the acl workshop on intrinsic and
extrinsic evaluation M. Zhou, and H.-W. Hon, "Unified language model
pre-training measures for machine translation and/or summarization,
2005, pp. 65-- for natural language understanding and generation,"
Advances in 72. neural information processing systems (NeurIPS),
vol. 32, 2019. \[51\] W. Xu, C. Napoles, E. Pavlick, Q. Chen, and C.
Callison-Burch, \[32\] Y. Zhang, Z. Qiu, K.-J. Stol, W. Zhu, J. Zhu, Y.
Tian, and H. Liu, "Optimizing statistical machine translation for text
simplifica- "Automatic commit message generation: A critical review and
di- tion," Transactions of the Association for Computational
Linguistics, rections for future work," IEEE Transactions on Software
Engineering vol. 4, pp. 401--415, 2016. (TSE), 2024. \[52\] C. Napoles,
K. Sakaguchi, M. Post, and J. Tetreault, "Ground Truth \[33\] Q. Guo, J.
Cao, X. Xie, S. Liu, X. Li, B. Chen, and X. Peng, "Ex- for Grammatical
Error Correction Metrics," in Proceedings of the ploring the potential
of chatgpt in automated code refinement: An 53rd Annual Meeting of the
Association for Computational Linguistics empirical study," in
Proceedings of the 46th IEEE/ACM International and the 7th International
Joint Conference on Natural Language Process- Conference on Software
Engineering (ICSE). IEEE, 2024, pp. 1--13. ing (Volume 2: Short Papers),
C. Zong and M. Strube, Eds. Beijing, \[34\] J. Wei and K. Zou, "Eda:
Easy data augmentation techniques for China: Association for
Computational Linguistics, 2015, pp. 588-- boosting performance on text
classification tasks," in Proceedings 593. of the 2019 Conference on
Empirical Methods in Natural Language Pro- \[53\] S. Robertson, H.
Zaragoza et al., "The probabilistic relevance cessing and the 9th
International Joint Conference on Natural Language framework: Bm25 and
beyond," Foundations and Trends® in Infor- Processing (EMNLP-IJCNLP),
2019, pp. 6382--6388. mation Retrieval, vol. 3, no. 4, pp. 333--389,
2009. \[35\] C. Shorten, T. M. Khoshgoftaar, and B. Furht, "Text data
augmen- \[54\] S. Ubani, S. O. Polat, and R. Nielsen, "Zeroshotdataaug:
Gener- tation for deep learning," Journal of big Data, vol. 8, no. 1,
p. 101, ating and augmenting training data with chatgpt," arXiv preprint
2021. arXiv:2304.14334, 2023. \[36\] I. Bouzenia and M. Pradel, "When to
say what: Learning to \[55\] S. Wang, Y. Liu, Y. Xu, C. Zhu, and M.
Zeng, "Want to reduce find condition-message inconsistencies," in 2023
IEEE/ACM 45th labeling cost? gpt-3 can help," in Findings of the
Association for International Conference on Software Engineering (ICSE).
IEEE, 2023, Computational Linguistics: EMNLP 2021, 2021, pp. 4195--4205.
pp. 868--880. \[56\] Y. Wei, Z. Wang, J. Liu, Y. Ding, and L. Zhang,
"Magicoder: empowering code generation with oss-instruct," in
Proceedings of \[37\] H. Dai, Z. Liu, W. Liao, X. Huang, Y. Cao, Z. Wu,
L. Zhao, S. Xu, the 41st International Conference on Machine Learning
(ICML), 2024, F. Zeng, W. Liu et al., "Auggpt: Leveraging chatgpt for
text data pp. 52 632--52 657. augmentation," IEEE Transactions on Big
Data, 2025. \[57\] N. Jain, T. Zhang, W.-L. Chiang, J. E. Gonzalez, K.
Sen, and \[38\] N. Lee, T. Wattanawong, S. Kim, K. Mangalam, S. Shen, G.
Anu- I. Stoica, "Llm-assisted code cleaning for training accurate code
manchipalli, M. Mahoney, K. Keutzer, and A. Gholami, "Llm2llm:
generators," in The Twelfth International Conference on Learning
Boosting llms with novel iterative data enhancement," in Findings
Representations (ICLR), 2023. of the Association for Computational
Linguistics ACL 2024, 2024, pp. \[58\] R. Zhong, Y. Li, J. Kuang, W. Gu,
Y. Huo, and M. R. Lyu, 6498--6526. "Logupdater: Automated detection and
repair of specific defects \[39\] Y. Wang, Y. Kordi, S. Mishra, A. Liu,
N. A. Smith, D. Khashabi, and in logging statements," ACM Trans. Softw.
Eng. Methodol. (TOSEM), H. Hajishirzi, "Self-instruct: Aligning language
models with self- Apr. 2025. generated instructions," in Proceedings of
the 61st Annual Meeting of \[59\] Q. Team, "Qwen2.5-coder," 2025,
accessed: 2025-12-13. the Association for Computational Linguistics
(Volume 1: Long Papers), \[Online\]. Available:
https://qwenlm.github.io/blog/qwen2. 2023, pp. 13 484--13 508.
5-coder-family/ \[40\] E. J. Hu, P. Wallis, Z. Allen-Zhu, Y. Li, S.
Wang, L. Wang, W. Chen \[60\] I. K. Ratol and M. P. Robillard,
"Detecting fragile comments," in et al., "Lora: Low-rank adaptation of
large language models," in 2017 32nd IEEE/ACM International Conference
on Automated Software International Conference on Learning
Representations. Engineering (ASE). Urbana, IL: IEEE, 2017,
pp. 112--122. \[41\] K. Ethayarajh, W. Xu, N. Muennighoff, D. Jurafsky,
and D. Kiela, \[61\] L. Tan, D. Yuan, G. Krishna, and Y. Zhou, "/\*
icomment: Bugs "Kto: Model alignment as prospect theoretic
optimization," arXiv or bad comments?\*," in Proceedings of twenty-first
ACM SIGOPS preprint arXiv:2402.01306, 2024. symposium on Operating
systems principles (SOSP), 2007, pp. 145-- \[42\] R. Rafailov, A.
Sharma, E. Mitchell, C. D. Manning, S. Ermon, and 158. C. Finn, "Direct
preference optimization: Your language model is \[62\] S. Hao, Y. Nan,
Z. Zheng, and X. Liu, "Smartcoco: Checking secretly a reward model,"
Advances in Neural Information Processing comment-code inconsistency in
smart contracts via constraint Systems (NeurIPS), vol. 36, 2024.
propagation and binding," in 2023 38th IEEE/ACM International \[43\] Z.
Tian, H. Shu, D. Wang, X. Cao, Y. Kamei, and J. Chen, "Large Conference
on Automated Software Engineering (ASE). IEEE, 2023, language models for
equivalent mutant detection: How far are pp. 294--306. we?" in
Proceedings of the 33rd ACM SIGSOFT International Sympo- \[63\] Z. Gao,
X. Xia, D. Lo, J. Grundy, and T. Zimmermann, "Au- sium on Software
Testing and Analysis (ISSTA), 2024, pp. 1733--1745. tomating the removal
of obsolete todo comments," in Proceedings \[44\] Y. Li, Y. Huo, Z.
Jiang, R. Zhong, P. He, Y. Su, L. C. Briand, and of the 29th ACM Joint
Meeting on European Software Engineering M. R. Lyu, "Exploring the
effectiveness of llms in automated log- Conference and Symposium on the
Foundations of Software Engineering ging statement generation: An
empirical study," IEEE Transactions (ESEC/FSE), 2021, pp. 218--229. on
Software Engineering (TSE), vol. 50, no. 12, pp. 3188--3207, 2024.
\[64\] J. Devlin, M.-W. Chang, K. Lee, and K. Toutanova, "Bert: Pre-
\[45\] M. Geng, S. Wang, D. Dong, H. Wang, G. Li, Z. Jin, X. Mao,
training of deep bidirectional transformers for language under- and X.
Liao, "Large Language Models are Few-Shot Summarizers: standing," in
Proceedings of the 2019 conference of the North American Multi-Intent
Comment Generation via In-Context Learning," in chapter of the
association for computational linguistics: human language Proceedings of
the IEEE/ACM 46th International Conference on Soft- technologies, volume
1 (long and short papers), 2019, pp. 4171--4186. ware Engineering
(ICSE). Lisbon Portugal: IEEE, 2024, pp. 1--13. \[65\] I. Beltagy, M. E.
Peters, and A. Cohan, "Longformer: The long- \[46\] Z. Feng, D. Guo, D.
Tang, N. Duan, X. Feng, M. Gong, L. Shou, document transformer," arXiv
preprint arXiv:2004.05150, 2020. B. Qin, T. Liu, D. Jiang et al.,
"Codebert: A pre-trained model for \[66\] F. Rabbi, M. N. Haque, M. E.
Kadir, M. S. Siddik, and A. Kabir, programming and natural languages,"
in Findings of the Association "An ensemble approach to detect code
comment inconsistencies for Computational Linguistics: EMNLP 2020, 2020,
pp. 1536--1547. using topic modeling." in SEKE, 2020, pp. 392--395.
\[47\] OpenAI., "Gpt-3.5," Mar 2022. \[Online\]. Available: https:
\[67\] W. Ouyang and B. Hua, "Towards detecting and understanding
//platform.openai.com/docs/models/gpt-3-5 code-document violations in
rust," in 2021 IEEE International MANUSCRIPT 19

     Symposium on Software Reliability Engineering Workshops (ISSREW).         A PPENDIX A
     IEEE, 2021, pp. 189–197.

\[68\] M. Linares-Vásquez, B. Li, C. Vendome, and D. Poshyvanyk, "How do
developers document database usages in source Prompt: Please help me
judge whether the comment is code?(n)," in 2015 30th IEEE/ACM
International Conference on Auto- inconsistent with the code. Please DO
NOT consider typo or unclear as inconsistent. mated Software Engineering
(ASE). IEEE, 2015, pp. 36--41. Mark "inconsistent" ONLY if the comment
FACTUALLY \[69\] W. M. Ibrahim, N. Bettenburg, B. Adams, and A. E.
Hassan, "On contradicts with the code return type, method signature the
relationship between comment update practices and software or
application logic. The following is four examples for consistent case,
return bugs," Journal of Systems and Software (JSS), vol. 85, no. 10,
pp. type inconsistency, method signature inconsistency and 2293--2304,
2012. application logic inconsistency. \[70\] E. Jabrayilzade, A.
Yurtoğlu, and E. Tüzün, "Taxonomy of inline
`<In Context Learning>`{=html} code comment smells," Empirical Software
Engineering (EMSE), vol. 29, no. 3, p. 58, 2024. \<Example 1 for
consistent case Input\> \[71\] C. Wang, H. He, U. Pal, D. Marinov, and
M. Zhou, "Suboptimal 1. comment: @return the current time in ms 2. code:
private long now() {{`\n `{=tex}return Comments in Java Projects: From
Independent Comment Changes SystemClock.uptimeMillis();`\n`{=tex}}} to
Commenting Practices," ACM Transactions on Software Engineer- \<Example
1 for consistent case Output\> ing and Methodology (TOSEM), vol. 32, no.
2, pp. 1--33, 2023. 1. judgement: consistent \[72\] J. Zhai, X. Xu, Y.
Shi, G. Tao, M. Pan, S. Ma, L. Xu, W. Zhang, L. Tan, 2. reason: The
comment states that the method returns and X. Zhang, "CPC: Automatically
classifying and propagating the current time in milliseconds, which is
consistent with natural language comments via program analysis," in
Proceedings the return type of 'long' and the logic of the code, which
calls SystemClock.uptimeMillis() to get the current of the ACM/IEEE 42nd
International Conference on Software Engineer- uptime in milliseconds.
ing (ICSE). Seoul South Korea: IEEE, 2020, pp. 1359--1371. ...
`<Three more inconsistent case Input and Output>`{=html} \[73\] F. Wen,
C. Nagy, G. Bavota, and M. Lanza, "A Large-Scale Empiri-
`<Query Begin>`{=html} cal Study on Code-Comment Inconsistencies," in
2019 IEEE/ACM `<Query Input>`{=html} 27th International Conference on
Program Comprehension (ICPC). 1. comment: Returns a collection of wires
contained in Montreal, QC, Canada: IEEE, 2019, pp. 53--64. this
composite. 2. code: public Map\<LogicalReference,
Set`<LogicalWire>`{=html}\> \[74\] B. Lin, S. Wang, Z. Liu, X. Xia, and
X. Mao, "Predictive comment getWires() {{`\n `{=tex}return
wires;`\n `{=tex}}}`\n`{=tex}`\n`{=tex} updating with heuristics and
ast-path-based neural learning: A two-phase approach," IEEE Transactions
on Software Engineering `<LLM Output>`{=html} (TSE), vol. 49, no. 4,
pp. 1640--1660, 2022. 1. judgement: inconsistent 2. reason: The comment
states that the method returns a \[75\] Q. Chen, X. Xia, H. Hu, D. Lo,
and S. Li, "Why my code summa- 'collection of wires', but the code
actually returns a Map rization model does not work: Code comment
improvement with of Sets of LogicalWires. category prediction," ACM
Transactions on Software Engineering and Methodology (TOSEM), vol. 30,
no. 2, pp. 1--29, 2021. \[76\] R. Wang, J. Guo, C. Gao, G. Fan, C. Y.
Chong, and X. Xia, "Can llms Fig. 15: The prompt template for
semantic-based filtering. replace human evaluators? an empirical study
of llm-as-a-judge in software engineering," arXiv preprint
arXiv:2502.06193, 2025.

                                                                                        System Prompt: You are SEGPT, an AI agent who knows
                                                                                        software engineering domain knowledge well.
                                                                                        You are training someone who is classifying code
                                                                                        comments as consistent or inconsistent with their
                                                                                        surrounding code.
                                                                                        You are trying to give the user assistance by giving them
                                                                                        more practice cases for the cases that they classify wrong.

                                                                                        Here are the requirements:
                                                                                        1. The case you generate should be either consistent or
                                                                                           inconsistent.
                                                                                        2. Inconsistent here means that the code comment is
                                                                                           factually inconsistent with surrounding code in the
                                                                                           following three aspect: return type, method signature,
                                                                                           and application logic.
                                                                                        3. Don’t make any mistakes with your answer yourself.
                                                                                        4. Try not use too much information from the original
                                                                                           case. You don’t want the user to just memorize the
                                                                                           practice problems but the intrinsic meanings.

                                                                                         <User Input>
                                                                                         Code comment: Returns a collection of wires contained in
                                                                                         this composite.
                                                                                         Surrounding code: public Map<LogicalReference,
                                                                                         Set<LogicalWire>> getWires() {{\n return
                                                                                         wires;\n }}\n\n
                                                                                         Wrong Judgement: consistent

                                                                                         <System Output>
                                                                                         Code comment: Returns a list of active user accounts.
                                                                                         Surrounding code: public Set<UserAccount>
                                                                                         getActiveAccounts() { \n return activeAccounts; \n }
                                                                                         Judgement: inconsistent



                                                                                Fig. 16: The prompt template for iterative enhancement.


