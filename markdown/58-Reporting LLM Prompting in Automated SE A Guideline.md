                                         Reporting LLM Prompting in Automated Software Engineering:
                                           A Guideline Based on Current Practices and Expectations
                                                           Alexander Korn                                                    Lea Zaruchas                                  Chetan Arora
                                                    alexander.korn@uni-due.de                                           University of Cologne                        chetan.arora@monash.edu
                                                   University of Duisburg-Essen                                          Cologne, Germany                                Monash University
                                                          Essen, Germany                                                                                               Melbourne, Australia

                                                          Andreas Metzger                                                    Sven Smolka                                    Fanyu Wang
                                                   andreas.metzger@uni-due.de                                      sven.smolka@uni-due.de                            fanyu.wang@monash.edu
                                                   University of Duisburg-Essen                                   University of Duisburg-Essen                          Monash University
                                                         Essen, Germany                                                 Essen, Germany                                 Melbourne, Australia

arXiv:2601.01954v1 \[cs.SE\] 5 Jan 2026

                                                                                                                       Andreas Vogelsang
                                                                                                                 andreas.vogelsang@uni-due.de
                                                                                                                  University of Duisburg-Essen
                                                                                                                        Essen, Germany

                                        Abstract                                                                                        Keywords
                                        Large Language Models, particularly decoder-only generative mod-                                LLM, Guideline, Prompting, SE Research, Survey
                                        els such as GPT, are increasingly used to automate Software Engi-                               ACM Reference Format:
                                        neering tasks. These models are primarily guided through natural                                Alexander Korn, Lea Zaruchas, Chetan Arora, Andreas Metzger, Sven Smolka,
                                        language prompts, making prompt engineering a critical factor in                                Fanyu Wang, and Andreas Vogelsang. 2026. Reporting LLM Prompting in
                                        system performance and behavior. Despite their growing role in                                  Automated Software Engineering: A Guideline Based on Current Practices
                                        SE research, prompt-related decisions are rarely documented in a                                and Expectations. In Proceedings of The 3rd ACM International Conference
                                        systematic or transparent manner, hindering reproducibility and                                 on AI Foundation Models and Software Engineering (FORGE ’26). ACM, New
                                        comparability across studies. To address this gap, we conducted a                               York, NY, USA, 11 pages. https://doi.org/XXXXXXX.XXXXXXX
                                        two-phase empirical study. First, we analyzed nearly 300 papers
                                        published at the top-3 SE conferences since 2022 to assess how                                  1    Introduction
                                        prompt design, testing, and optimization are currently reported.                                Automated software engineering is about applying computational
                                        Second, we surveyed 105 program committee members from these                                    methods and tools to automate various activities within the soft-
                                        conferences to capture their expectations for prompt reporting in                               ware engineering life cycle. Large Language Models (LLMs), par-
                                        LLM-driven research. Based on the findings, we derived a structured                             ticularly decoder-only generative models such as GPT-3 [2], have
                                        guideline that distinguishes essential, desirable, and exceptional                              rapidly transformed how Software Engineering (SE) tasks can be
                                        reporting elements. Our results reveal significant misalignment                                 automated [4]. These models simultaneously “speak” fluent natural
                                        between current practices and reviewer expectations, particularly                               language and multiple programming languages, making them at-
                                        regarding version disclosure, prompt justification, and threats to                              tractive for several SE tasks, such as code synthesis, test generation,
                                        validity. We present our guideline as a step toward improving trans-                            defect repair, requirements analysis, and beyond [9]. LLMs are pri-
                                        parency, reproducibility, and methodological rigor in LLM-based                                 marily guided by textual prompts. Prompting, i.e., giving carefully
                                        SE research.                                                                                    designed textual instructions, has become the primary interface to
                                                                                                                                        guide model behavior, making Prompt Engineering (PE) a crucial
                                        CCS Concepts                                                                                    factor in LLM performance [8, 12, 13].
                                                                                                                                           The use of decoder-only LLMs in SE research has steadily in-
                                        • Software and its engineering; • General and reference →                                       creased recently. As we will show later in this paper, we identified
                                        Computing standards, RFCs and guidelines; Surveys and overviews;                                almost 300 papers published in the top three SE conferences since
                                                                                                                                        2022 that have leveraged such models to automate a wide range of
                                                                                                                                        SE tasks. Yet, despite their widespread use, how prompts are con-
                                        Permission to make digital or hard copies of all or part of this work for personal or
                                        classroom use is granted without fee provided that copies are not made or distributed           structed, refined, and evaluated is rarely reported in a systematic
                                        for profit or commercial advantage and that copies bear this notice and the full citation       or transparent manner.
                                        on the first page. Copyrights for components of this work owned by others than the                 Despite the central role of prompting in determining model be-
                                        author(s) must be honored. Abstracting with credit is permitted. To copy otherwise, or
                                        republish, to post on servers or to redistribute to lists, requires prior specific permission   havior, current research practices lack consistency in how prompts
                                        and/or a fee. Request permissions from permissions@acm.org.                                     are documented and justified, as expected of other SE experimental
                                        FORGE ’26, Rio de Janeiro, Brazil                                                               artifacts. There is no established standard for reporting prompt de-
                                        © 2026 Copyright held by the owner/author(s). Publication rights licensed to ACM.
                                        ACM ISBN 978-x-xxxx-xxxx-x/YYYY/MM                                                              sign, testing, or optimization. As a result, prompt-related decisions
                                        https://doi.org/XXXXXXX.XXXXXXX                                                                 are often underreported or omitted entirely, limiting reproducibility,

FORGE '26, April 12--13, 2026, Rio de Janeiro, Brazil Korn et al.

reducing comparability between studies, and ultimately hindering they do
not offer explicit guidelines on how prompting should be progress in
this fast-moving domain. reported in SE research. Given the novelty and
evolving nature of LLM-based SE research, Trinkenreich et al. \[15\]
issue a call to action for the SE research it is premature to impose
top-down standards based solely on expert community to develop reporting
guidelines to ensure continued opinion. Instead, we argue that reporting
guidelines should emerge rigor and impact. In particular, they advocate
for transparent re- from observed practices and the expectations of the
research com- porting when using LLMs, including specification of the
model munity itself. Understanding how prompts are currently reported
and version, prompting strategies, and mechanisms for human and how they
should be requires empirical investigation grounded oversight. However,
their work stops short of proposing concrete, in both literature
analysis and researcher insight. operationalized guidelines. To address
this need, we conducted a multi-phase empirical study Baltes et
al. \[1\] propose a set of guidelines for the use and evalu- structured
around the following research questions: ation of LLMs in SE. Developed
through expert discussions at the RQ1: How do researchers currently
report prompts in SE 2024 International Software Engineering Research
Network (ISERN) research papers? We analyzed nearly 300 papers published
in meeting, their guidelines follow a top-down consensus-driven pro-
ICSE, FSE, and ASE since 2022 to assess how authors report on cess and
cover a wide range of topics, including tool architecture, prompt
design, validation, and optimization. evaluation metrics, baselines, and
benchmarks. For prompt report- RQ2: What are the expectations of SE
researchers regard- ing specifically, they define eight recommendations,
five marked as ing prompt creation, evaluation, and reporting in SE
research MUST and three as SHOULD, which call for full prompt disclosure
papers? We surveyed 105 Program Committee (PC) members of (including
structure and formatting), rationale for prompt design, the
aforementioned conferences to capture their expectations for reuse
documentation, input handling, and interaction log sharing. prompt
reporting practices. The guidelines are available in an open source
repository2 . RQ3: How consistent is the current state with the expecta-
Our work complements this effort by empirically assessing the tions? We
distilled the expressed expectations into a guideline and current state
of prompt reporting in SE research and capturing compared them against
current reporting practices. the expectations of PC members. While
Baltes et al.'s guidelines This work makes the following contributions:
reflect expert consensus, our guidelines are derived bottom-up (1) A
taxonomy and frequency analysis of how prompt design, from observed
reporting practices in nearly 300 SE research papers testing, and
optimization are currently reported in nearly and validated through a
survey of PC members from top-tier SE 300 SE research papers (RQ1).
conferences. (2) An empirically derived set of reporting expectations
from In addition, we see our findings as a valuable contribution to on-
SE reviewers (RQ2). going community efforts aimed at standardizing
empirical research (3) A comparative analysis revealing gaps and
alignments be- practices. In particular, the ACM SIGSOFT Empirical
Standards3 tween current practices and community expectations (RQ3).
initiative currently provides structured guidance on study design (4) A
guideline grounded in empirical evidence to enhance trans- and reporting
across various empirical methods but does not yet parency,
reproducibility, and comparability in LLM-based include standards
tailored to LLM-based research. By contributing SE research. empirically
grounded, task-specific insights into prompt reporting, By synthesizing
current practices and reviewer expectations, we aim to help fill this
gap and support the development of future this study aims to raise the
methodological standard for LLM-based standards for the transparent and
reproducible use of LLMs in SE. research in software engineering and to
support future work with more transparent and reproducible foundations.
3 Current State of Prompt Reporting (RQ1) Data Availability The goal of
this RQ is to analyze how prompting is described and evaluated in recent
research papers proposing LLM-driven SE ap- All data we used in our
study and the code used to analyze the data proaches. are available in
our replication package1 . To investigate how prompts are currently
reported in software engineering research, we conducted a systematic
review of recent 2 Related Work publications from leading conferences.
The goal of this review was Recent Systematic Literature Reviews (SLRs)
provide an analysis to assess the extent, consistency, and depth of
prompt reporting of the use of LLMs for automating SE tasks, aiming to
determine practices across empirical studies involving large language
models. which LLMs are used, the methods for data collection and
prepara- We selected a literature review approach to obtain an objective
tion, the strategies for prompt engineering, and the techniques for and
comprehensive understanding of the current state of practice. optimizing
and evaluating the performance of LLMs. Several such Systematic reviews
are a well-established method for synthesiz- SLRs focus on specific SE
tasks, such as requirements engineer- ing research evidence and are
particularly effective for identifying ing \[5\], code generation
\[17\], program repair \[18\], and software trends, gaps, and variations
in how specific techniques or artifacts, testing \[16\]. In contrast,
Hou et al. \[4\] performed an SLR covering such as prompts, are used and
reported in published work \[6\]. the entire software development life
cycle. While the aforementioned publications provide important in-
sights into how LLMs are used in automated software engineering, 2
https://llm-guidelines.org/ 1 https://doi.org/10.5281/zenodo.16101751 3
https://www2.sigsoft.org/EmpiricalStandards/ Reporting LLM Prompting in
Automated SE: A Guideline Based on Current Practices and Expectations
FORGE '26, April 12--13, 2026, Rio de Janeiro, Brazil

3.1 Study Design System Prompt: LLM-Based Filtering We answer RQ1
through a SLR \[7\]. By examining publications You are a researcher
conducting a literature review. You will from top-tier SE conferences,
we aim to identify common prac- be given the full text of various
academic papers. Your task is tices in prompt documentation, the level
of detail provided, and the to decide whether each paper should be
included based on the reported techniques used to create and evaluate
prompts. The find- following strict criteria: ings will highlight
potential reporting gaps, assess inconsistencies Inclusion Criteria:
between studies, and provide information on how PE is currently
approached in SE research. This review will serve as a foundation • The
primary focus of the study must be on automating for understanding the
state of prompt reporting and will contribute software engineering (SE)
tasks. to establishing best practices for future studies. • The study
must utilize generative LLMs (decoder-only architectures, e.g., GPT
models). Paper selection: We began our paper selection process by
collect- • The study must be a primary study (i.e., proposing, eval- ing
all papers published in 2022 or later from the three top SE uating, or
implementing a method). Meta-analyses, liter- conferences according to
the CORE ranking4 : the IEEE/ACM Inter- ature reviews, and systematic
reviews must be excluded. national Conference on Software Engineering
(ICSE'22--ICSE'25), the ACM International Conference on the Foundations
of Software Instructions: Engineering (FSE'22--FSE'24), and the IEEE/ACM
International Con- • Base your decision solely on the content of the
paper. ference on Automated Software Engineering (ASE'22--ASE'24).5 We •
If the paper does not clearly meet all criteria, exclude it. chose 2022
as the starting year based on the assumption that the • Respond with
exactly one word: "include" or "exclude". use of decoder-only LLMs was
rare before the release of ChatGPT • Do not provide explanations,
justifications, or additional in December 2021. text. We limited our
scope to these conferences to focus on venues Examples: that typically
reflect the highest methodological standards and {four examples
including a paper's title, a one-sentence sum- most up-to-date research
practices. Journal papers were excluded mary, and whether to include or
exclude that paper} to maintain a consistent corpus, as their extended
length and format may lead to substantially different reporting
behaviors compared We tested different prompts for the LLM-based
filtering, employ- to page-restricted conference papers. Moreover, given
their longer ing PE techniques such as role prompting, zero-shot
prompting, and review cycles, many journal articles may not yet have
been relevant few-shot prompting. After testing various prompts across
multiple at the time of our analysis. models, we selected the final
prompt based on its ability to achieve We filtered these papers in three
steps to ensure that only those the highest recall by correctly
including papers that met the inclu- relevant to our study were retained
in the dataset. sion criteria. We evaluated this approach by manually
screening all (1) Filtering by document length: We considered only full
papers. papers from ICSE'22 to ICSE'24 using the same inclusion criteria
If a paper has fewer than 7 pages, we exclude it because provided to the
LLM in the prompt. We then compared the LLM- short papers may not
present fully developed approaches, based filtering results to the
outcomes of the manual screening. preliminary evaluations, or make
compromises due to page For the final filtering process, we used three
different LLMs (gpt- limitations. 4.1-mini-2025-04-14, deepseek-v3-0324,
and gemini-2.5-flash-preview- (2) Filtering by keywords: To filter
irrelevant papers, we defined 05-20), accessing them via their
respective APIs. For all models, we a set of keywords that we expected
to be present in any maintained a temperature of 1.0. We also tested
lower temperature relevant paper. Papers not including any of the
following settings, which did not lead to improved results. We did not
con- keywords were excluded: LLM, LLMs, Large Language Model, figure any
other settings. We selected the three models because GenAI, Generative
AI, OpenAI, GPT, ChatGPT, Llama, Claude, (a) they achieved the best
performance in our comparative tests Prompt, Prompting, Prompted. with
other models, (b) they were the most cost-effective out of the (3)
LLM-based filtering: As the final step, we used different LLMs tested
models, and (c) they are offered by different providers, which to
further filter the papers. We prompted the LLMs to include we considered
beneficial for enhancing the trustworthiness of the only papers that a)
focus primarily on automating SE tasks, approach by mitigating potential
provider-specific biases. The pre- b) use generative LLMs (i.e.,
decoder-only models), and c) cision and recall metrics for these models
are reported in Table 1. conduct primary studies (i.e., no
meta-analyses, literature The best-performing model,
gpt-4.1-mini-2025-04-14, achieved a reviews, etc.). The full prompt is
given below. recall of 84.83 %. For the final filtering step, we
included a paper if any of the three models recommended its inclusion.
This strategy allowed us to reach a combined recall of 98.28 %, which we
deemed sufficient given the substantial reduction in manual workload en-
abled by pre-filtering. The approach prioritized maintaining high recall
despite the risk of decreasing precision, since manual data extraction
was still conducted afterward, allowing us to identify 4
https://portal.core.edu.au/conf-ranks/ and exclude any false positives
at a later stage. 5 The proceedings of FSE'25 appeared too shortly
before the submission deadline to be Table 2 provides an overview of the
number of papers before included. and after each filtering step. FORGE
'26, April 12--13, 2026, Rio de Janeiro, Brazil Korn et al.

            Table 1: LLM-Based Filtering Performance                       LLM usage: E1 (used LLM): Most papers (92.31 %) mention the
                                                                           name of the LLM used in their study. In 39.16 % of the papers, the

Model Precision Recall number of parameters is included as part of the
name (e.g., llama3 70b). The exact version is specified in only 16.43 %
of the papers. gpt-4.1-mini-2025-04-14 68.75 % 94.83 % We did not count
labels such as gpt-3.5 as specifying a version, deepseek-v3-0324 88.46 %
79.31 % since GPT and other models can vary significantly for different
gemini-2.5-flash-preview-05-20 86.54 % 77.59 % major versions,
effectively making them separate models. Instead, Combined result (≥ 1
of 3) 67.86 % 98.28 % we treated specific snapshots or dates as
indicating a version (e.g., 0125 or 2024-05-13). The most used models
were gpt-3.5-turbo (63 instances), gpt-4 (61 instances), codellama (36
instances), gpt-3.5 (27 instances), and text-davinci-003 (12 instances).
Data extraction: After selecting the relevant papers, we proceeded E2
(configuration parameters): Of all papers, 69.93 % reported at with the
data extraction. We created an extraction sheet containing least one
configuration parameter. The most commonly reported 11 questions, which
are listed in Table 3. A more detailed description parameters were the
temperature (131 instances), output token of the questions, including
explicit instructions on how to answer limit (33 instances), top-p value
(29 instances), number of prompt them, is provided in the extraction
sheet, which is part of our iterations (24 instances), and input token
limit (23 instances). replication package. Questions E3--E5 and E7--E9
were closed-ended, allowing only Prompt description and design: E3, E4,
E5 (prompt documenta- yes, no, or partially as possible answers. The
option partially was tion): In a majority of papers, the authors either
fully or partially permitted only when multiple prompts or LLMs were
used in the describe the used prompt(s) and their structure (75.17 %;
yes + par- paper, but the question could not be answered consistently
for all tially). In more than half of all papers, the authors even
provide the of them. While question E1 was a free-text question,
questions E2, used prompt(s) word-by-word (69.58 %). Some authors
provided E6, E10, and E11 were open-text questions constrained by a
prede- detailed descriptions of the prompts without listing the exact
word- fined set of answers developed by the authors of this paper during
ing, leading to higher positive responses for question E4. Around
extraction. Question E10 specifically consisted only of software de-
half of the papers (58.74 %) specifically justified their prompt con-
velopment life cycle (SDLC) phases, while question E11 initially used
struction, i.e., they gave reasons for why they created the prompt all
tasks extracted by Hou et al. \[4\], enabling comparability to their in
the specified way. study. E6 (PE techniques): In 62.24 % of the papers,
the authors report To ensure consistency in data extraction among the
six authors which PE techniques they use. The most frequently reported
PE of this paper, we conducted three extraction rounds, with the first
techniques were few-shot prompting (62 instances), chain-of-thought two
serving as test rounds. In the first round, each author extracted
prompting (53 instances), zero-shot prompting (49 instances), in- data
from 10 papers. The papers were assigned with an overlap such context
learning (27 instances), and retrieval-augmented generation that each
paper was reviewed by two authors, and each author's set (19 instances).
A total of 50 unique PE techniques were mentioned overlapped with those
of two other authors. After extraction, we across all papers. The full
list is included in our replication package. manually examined the
differences, discussed misunderstandings It is important to note that we
extracted PE techniques only if they in the extraction sheet, and
refined the questions to improve clarity. were explicitly mentioned as
such by the authors, i.e., we did not Following these first
improvements, we conducted a second identify PE techniques by ourselves
(e.g., by analyzing the prompts). round in which each author again
received 10 papers with overlap- Prompt testing and evaluation: E7
(Prompt tuning): In only 46.5 % ping assignments similar to round 1.
Again, data were extracted in- of papers, the authors fully or partially
mention that they refined dependently, and any remaining
misunderstandings were discussed or tuned the used prompts as part of
their research process. In the to finalize the extraction sheet and
align everyone's understanding remaining 53.5 % of papers, there is no
indication that the authors of the questions to ensure consistent data
extraction. have refined the prompts during their research process.
Automated For the final round of extraction, we divided all remaining
papers prompt-tuning techniques, such as self-refinement, were used only
from the filtering step (332; cf. Table 2) equally among the authors.
rarely (in 4.9 % of papers). This time, there was no overlap, with each
author reviewing a E8 (Prompt comparison): In 44.06 % of the papers, the
authors unique subset of the papers. While this approach was chosen for
explicitly describe different prompt variations and also provide time
efficiency, we were confident in its validity given the prior two
results of their performance. rounds, which served to harmonize our
understanding of the extrac- Prompting as a threat to validity: E9: Only
23.43 % of the papers tion process. Additionally, two authors
cross-validated a random explicitly report prompting as part of their
threats to validity. In sample of 5 papers of the other raters to
uncover any remaining these papers, the authors usually mention that the
results may be systematic inconsistencies. influenced by the composition
and phrasing of prompts. Rephrasing or optimizing the prompts may change
the results. 3.2 Study Results The results represent extracted data from
the final list of 286 papers 3.3 Threats to Validity (see Table 2).
Figure 1 shows an overview of the results for the Construct Validity:
Our analysis focuses exclusively on papers closed-ended questions.
Together with these results, we report the from the top-3 SE conferences
(ICSE, FSE, ASE), which may not fully results of the open-ended
questions in the following. represent the broader SE research landscape.
While these venues Reporting LLM Prompting in Automated SE: A Guideline
Based on Current Practices and Expectations FORGE '26, April 12--13,
2026, Rio de Janeiro, Brazil

                                                             Table 2: Paper Selection Process

                                                                          ICSE                                        FSE                                  ASE
                                                                                                                                                                                         Sum
                                                            2022      2023     2024             2025     2022         2023          2024     2022          2023           2024

\# of published papers 197 211 237 246 186 205 121 213 209 265 2,090 \#
of full papers (≥ 7 pages) 197 207 234 246 130 161 121 116 145 174 1,731
\# of full papers with keywords 24 44 94 152 19 55 61 23 74 138 684 \#
of full papers after LLM-based filtering 5 13 40 97 7 20 42 7 34 67 332
final \# of papers after manual analysis 4 11 38 91 3 10 33 3 22 71 286

Table 3: Data Extraction Sheet. C = Closed-ended question Answer
(yes/no/partially), O = Open-ended question Yes Partially No

ID Question C/O E3 57.69 11.89 30.42

1.  LLM Usage E1 Which LLM(s) was/were used? O E4 66.08 9.09 24.83 E2
    Which configuration parameters of the LLM(s) are O reported? E5
    51.40 7.34 41.26
2.  Prompt Description and Design Question

E3 Is the full prompt provided word-by-word? C Does the paper provide
the full prompt(s) word-by-word, E7 45.45 53.50 e.g. in a listing?
Placeholders and templates are allowed. E4 Is the prompt and its
structure explained? C Does the paper explain the prompt and its
structure, e.g., E8 43.36 55.94 by describing it in the text outside of
the word-by-word representation? E5 Do the authors justify why they
constructed the C E9 21.68 76.57 prompt the way they did? What is the
rationale for choosing a certain PE tech- 0 20 40 60 80 100 nique,
structure, phrasing, context, etc.? Percentage (%) E6 Which PE
techniques are reported? O 3. Prompt Testing and Evaluation Figure 1: A
bar chart showing the percentages of closed-ended extraction questions
(cf. Table 3) answered with either Yes, E7 Does the paper mention any
form of prompt testing C No, or Partially. or tuning (e.g., prompt
refinement) to improve LLM performance? This question focuses on whether
the paper mentions testing or tuning prompts without needing to provide
are highly selective and influential, important LLM-based work may
specific details. appear in other venues, such as specialized
conferences or journals. E8 Does the paper report results of multiple
prompt vari- C Additionally, publication bias may affect our results:
papers that ations? successfully applied prompting may be more likely to
be accepted This question examines whether the paper explicitly and
published, potentially skewing the picture of actual practices.
describes variations in prompts, provides details on how Furthermore,
our corpus includes papers published up to mid-2025. they differ, and
presents results for those variations. Due to conference submission
timelines, many of these papers were 4. Threats to Validity likely
written no later than mid-2024. As a result, our findings may E9 Is
prompting seen as a threat to validity? C lag behind current practices
or recent trends in prompt reporting. Internal Validity: Despite
systematic procedures, there are risks 5. Software Engineering Tasks of
bias in paper selection and data extraction. Although we used E10 For
which task categories was/were the LLM(s) used? O keyword-based and
LLM-assisted filtering to identify relevant pa- E11 For which tasks
was/were the LLM(s) used? O pers, it is possible that some relevant
studies were unintentionally excluded. We tested several prompts used to
filter papers automati- cally and finally ended up with a prompt that
achieved a high recall. However, further prompt tuning may achieve even
better recall. FORGE '26, April 12--13, 2026, Rio de Janeiro, Brazil
Korn et al.

Moreover, although we employed a method for information extrac- We
included both closed-ended and open-ended questions in the tion that
allowed selection only from an extendable predefined list, survey.
Closed-ended questions were used to collect clear and quan- the
interpretation of reporting practices may still involve subjective
tifiable data \[10\]. They provide straightforward answers (e.g., yes,
judgment, particularly in borderline cases or when details were am- or
no), which simplifies both responding and subsequent analysis. biguous.
We mitigated this issue by cross-checking coding among In contrast,
open-ended questions were included at the end of the researchers;
however, subjectivity cannot be fully eliminated. survey to gain insight
into additional contextual factors underlying External Validity: Our
findings may not generalize to all SE re- participants' responses. These
questions are essential for validating search involving LLMs, especially
in industry or non-academic the data obtained from closed-ended
questions and for gathering settings, where PE practices and
documentation norms may differ information that could not be captured
otherwise. Efforts were significantly. Additionally, practices in other
research communities made to minimize biases such as order effects,
where responses to that use LLMs, such as NLP, HCI, or education, might
follow differ- one question could influence answers to subsequent
questions. The ent reporting standards. Thus, while our findings are
grounded in order of questions was carefully designed to mitigate this
issue. the SE community, the proposed guidelines may not directly apply
To encourage honest responses, anonymity was guaranteed to all to other
domains. Finally, as the LLM ecosystem evolves rapidly, participants. No
personally identifiable information was collected. our results may
become outdated as tools, APIs, and community The survey remained open
for a period of 30 days. To maximize the norms change, potentially
limiting the long-term applicability of response rate, a reminder email
was sent after three weeks to ask our analysis. for participation from
those who had not yet completed the survey. Questionnaire content: The
final questionnaire comprised five content sections and one feedback
section. The sections contained 4 Expectations of SE Researchers (RQ2) a
total of 17 questions, including four open-ended questions (includ- To
investigate the expectations of SE researchers, we targeted mem- ing one
final feedback question) and 13 closed-ended questions. All bers of the
program committees of SE conferences. We designed and sections,
including the corresponding questions, are presented in conducted an
online survey to elicit their views on what aspects of Table 4. For the
closed-ended questions, we employed the following PE they consider
essential to report. We selected a questionnaire- scale, which resembles
the one used in the ACM SIGSOFT Empirical based approach using an online
survey tool to obtain a broad and Standards for Software Engineering
\[11\]: diverse set of responses, aiming for greater representativeness.
Sur- • Essential: A required element that must be included in a veys are
well established as effective means of gathering descriptive paper to
satisfy expectations for clarity, reproducibility, or and retrospective
insights, providing a valuable "state-of-the-art rigor. overview on a
particular method, tool, or technique" \[10\]. • Desirable: A
recommended element that should be included The survey was carefully
designed to enhance usability and to enhance quality, although it is not
strictly necessary. participant engagement, as detailed below.
Participants were guided • Exceptional: An advanced element that could
be included to through sequential pages, ensuring a clear,
well-structured, and go beyond typical expectations and significantly
elevate the easy-to-navigate format. While online surveys do require a
certain paper's overall quality. level of technological proficiency, we
anticipated that our target • Not recommended: An element that should
not be included demographic, i.e., SE researchers, would possess the
necessary in the paper, as it does not improve quality and may exceed
skills. the intended scope, introduce ambiguities, or cause other
undesirable effects. We included definitions for all response options,
both at the start 4.1 Study Design of the questionnaire and at the top
of each section, to enable easy reference throughout. Sampling of
participants: We targeted PC members from ICSE, ASE, and FSE for the
years 2022--2024, which results in a total pop- ulation of 612 potential
participants. Given the international scope 4.2 Study Results and nature
of these conferences, the sample included researchers We contacted 612
former PC members, of whom 105 (17.16 %) from diverse nationalities,
backgrounds, and areas of expertise in responded. A total of 92
responses were complete, with all closed- SE research. Participants were
contacted via email to request their ended questions answered. This
corresponds to a response rate of participation in the study. 15.03 %,
which is considerably higher than the anticipated rate of Survey design:
The survey was designed following the principles 5 % typically achieved
in questionnaire-based SE surveys \[14\]. The described by Kitchenham et
al. \[7\], and Punter et al. \[10\]. The complete dataset is available
in our replication package. full survey, including all questions, is
included in our replication Among the 92 complete responses, 59
participants (64.13 %) package. In the following, we describe the key
aspects of the survey reported being familiar with LLMs, while 31 (33.7
%) were somewhat in more detail. While taking care to avoid overcrowding
the screen familiar. Only 2 participants (2.17 %) indicated having no
familiarity with too many questions, we kept the number of pages
manageable with LLMs and were therefore excluded from the results. to
reduce the risk of participants losing focus over time. The survey When
asked about their experience reviewing research papers consisted of five
pages with 2--4 questions each, along with an involving LLMs, a majority
of participants (70; 76.09 %) reported additional page containing a
feedback text field. It was designed to reviewing such papers frequently
(more than 5 papers per year), take approximately 10 minutes to
complete. while 19 (20.65 %) indicated doing so occasionally (1--4
papers per Reporting LLM Prompting in Automated SE: A Guideline Based on
Current Practices and Expectations FORGE '26, April 12--13, 2026, Rio de
Janeiro, Brazil

                   Table 4: Survey Questionnaire                                                                                                 Answer
                                                                                                                                   Essential                Exceptional
                                                                                                                                   Desirable                Not recommended

ID Question 1. General Information S4 97.75

S1 What is your primary area of expertise in SE? S5 82.02 16.85 S2 How
familiar are you with the use of LLMs in SE research? S3 How frequently
do you review research papers involving 29.21 60.67 8.99 S6 LLMs? 2. LLM
Usage S7 87.64 8.99

S4 Authors name the used LLMs. S8 68.54 26.97 S5 Authors precisely name
the used LLM versions.

                                                                                     Question

S6 Authors use different LLMs and compare the results. 55.06 37.08 7.87
S9 3. Prompt Usage S10 61.80 32.58 S7 Authors describe the prompts used
to solve a task. S8 Authors provide the exact prompts used. S11 29.21
51.69 17.98 S9 Authors justify why a specific prompt structure or
phrasing was chosen. 43.82 44.94 7.87 S12 S10 Authors use and mention
prompt engineering techniques to create prompts. S13 16.85 43.82 34.83
4. Prompt Testing and Iterations S14 60.67 34.83 S11 Authors report how
they refined/iterated the prompts to improve performance. 0 20 40 60 80
100 S12 Authors apply automated prompt tuning techniques to opti-
Percentage (%) mize their prompts. S13 Authors test multiple prompt
variations and report the re- Figure 2: A bar chart showing the
percentages of closed-ended sults. survey questions (cf. Table 4)
answered with either Essential, S14 Authors discuss their use of prompts
as part of threats to Desirable, Exceptional, or Not recommended.
validity or potential limitations. 5. Overlooked Aspects of Prompting
S15 Are there any aspects of prompt usage or documentation which evolve
fast.", "LLMs are evolving so prompt engineering tech- that you feel are
often overlooked in research papers? niques are also in flux.").
Furthermore, 60.67 % of the participants S16 Is there another aspect or
comment you would like to add considered comparing results across
different LLMs to be desirable, regarding prompt usage and
documentation? while 29.21 % regarded it as essential. 6. Feedback
Prompt usage: The majority of participants (87.65 %) supported S17 Do
you have any comments, suggestions, or feedback about describing
prompts, and most (68.54 %) considered including the full this survey?
prompt to be essential. Providing exact prompts was the most fre-
quently mentioned concern, appearing in multiple answers across the
free-text answer fields (e.g., "I rarely see exact prompts used, which I
guess is understandable given page limits, but still disappoint- year).
Only 3 participants (3.26 %) stated that they have never re- ing.").
More than half of the participants (55.06 %) indicated that viewed such
papers so far. Their responses were excluded from providing sufficient
justification for how prompts are constructed is the analysis to ensure
the dataset reflected participants with rele- essential. Additionally,
61.8 % of participants regarded utilizing and vant experience. Of these
participants, 2 were the same individuals reporting on PE techniques as
essential, while 32.58 % considered who reported having no familiarity
with LLMs, resulting in 89 re- it desirable. sponses for analysis. The
results of all closed-questions can be seen Prompt testing and
iterations: The aspects covered in this section in Figure 2. were
generally perceived as elements that enhance research quality LLM usage:
Most participants (87 out of 89; 97.75 %) agreed that rather than being
strictly necessary. Approximately half of the naming the LLMs used is
essential, with a majority (82.02 %) em- participants (51.69 %)
considered refining or iterating on prompts phasizing the importance of
specifying the exact version. Some to be desirable, while 29.21 % deemed
it essential. However, in respondents stressed this point also in the
free-text responses, es- the free-text fields, several respondents felt
that authors often do pecially concerning the fast-developing landscape
of LLMs (e.g., not explain how prompts were developed, tuned, or
selected (e.g., "Prompts' effectiveness may depend on the parameters of
the LLM, "Yes, the details of concrete prompts and prompt tuning
strategies are FORGE '26, April 12--13, 2026, Rio de Janeiro, Brazil
Korn et al.

often lacking.", "One needs a sort of pre-experiment to find the right
academically acceptable, rather than fully reflecting their typical
prompt."). reviewing practices. Prompt tuning was rated as desirable by
43.82 % and as excep- External validity: Our survey targeted researchers
who have tional by 44.94 %. This question also received the highest
number served on program committees for top SE conferences. While this
of not recommended responses (7; 7.87 %). In the comments, par- group
was appropriate for assessing reviewer expectations, their ticipants
raised concerns about the risk of overfitting prompts to views may not
fully align with those of developers, practitioners, specific LLMs when
applying prompt tuning (e.g., "Overfitting of or researchers in other
domains actively working with LLMs. This prompts to specific LLMs is
starting to be a big issue."). The use of academic focus may bias the
results toward expectations grounded multiple prompt variations was
largely seen as beneficial but not in scientific transparency rather
than industrial pragmatism. Fur- mandatory, with 43.82 % regarding it as
essential and 34.83 % as thermore, non-response bias is a concern:
participants with a strong exceptional. interest in LLMs or prompting
may have been more likely to re- Furthermore, the majority of
participants (60.67 %) believed that spond. This could overemphasize the
importance of prompt re- acknowledging prompt-related threats to
validity is essential, while porting. However, based on open-ended
responses and critique 34.83 % considered it desirable. diversity, we
observed participation from both proponents and Overlooked aspects of
prompting: In this free-text response field, skeptics of LLM-based
research, suggesting a range of perspectives participants highlighted
the need for clearer documentation of was represented. LLM settings and
configurations. Five participants emphasized that LLM parameters (e.g.,
temperature and top-p) should be reported 5 Alignment of Current State
with Expectations alongside prompts and datasets, as all these factors
influence model (RQ3) behavior and are important for reproducibility.
Six participants For RQ3, we compare the extracted practices with the
expectations noted the absence of a rationale for model selection.
Additionally, assessed in our survey. For this purpose, we first derive
a guideline four participants pointed out the lack of information on
computa- from the survey responses and then compare it with the
reporting tional costs, including resource consumption and financial
expenses practices identified in our review of the literature.
associated with running LLMs on commercial APIs. Generally, the
importance of reproducibility was emphasized. One participant suggested
that commercial models should not be 5.1 Guideline Derivation solely
relied upon due to concerns about their long-term avail- We derive a
guideline by analyzing the perceived importance of ability. Another
participant argued that prompt creation should different reporting
elements collected through our survey. We used be viewed as a form of
program development, suggesting that the statistical methods to analyze
the differences in the response pat- entire lifecycle, from design to
development and testing, should be terns between the survey items. We
first used the Friedman test (a systematically documented.
non-parametric omnibus test for repeated measures) to test whether there
are statistically significant differences between the response patterns
to survey items. The Friedman test yielded a highly signifi- 4.3 Threats
to Validity cant result (𝑝 \< 0.000001 with 𝛼 = 0.05), indicating strong
evidence Construct validity: A key threat to construct validity is the
po- that there are differences in responses in the criteria. Hence, we
tential misinterpretation of survey items by participants. To reduce
reject the null hypothesis that all criteria share the same response
ambiguity, we used standard SE terminology and clearly defined
distribution. To identify these differences, we conducted pairwise the
rating scale (i.e., Essential, Desirable, Exceptional, Not Recom-
Wilcoxon signed-rank tests as post-hoc tests for all pairs of crite-
mended). However, differences in individual interpretation of these ria.
The unadjusted p-values were corrected with the Bonferroni categories
may still affect consistency across responses. To mitigate procedure.
wording bias, we phrased items as neutral statements (e.g., "Authors
Figure 3 shows a graph-based representation of the significant name the
used LLMs") rather than value-laden questions (e.g., "Is it differences
between the response patterns of the survey items (S4-- essential to
name the LLM?"). Despite these efforts, subtle bias in S14). Arrows
indicate statistically significant pairwise differences how items were
framed may still have influenced responses. The between response items
(Wilcoxon signed-rank test, Bonferroni- granularity of our four-point
scale also limits expressiveness: some corrected, 𝛼 = 0.05).
participants may have found it difficult to fully express nuanced Based
on this analysis, three groups of items emerged, which opinions within
these fixed categories. Finally, the selection of re- we characterized
as essential, desirable, and exceptional elements. porting items itself
may introduce bias, as the list was derived from This classification
aligns with the ACM SIGSOFT Empirical Stan- our literature review
(Section 3) and may not include all dimensions dards \[11\]. To
formulate the guideline, we followed the idea of that participants
consider relevant. Baltes et al. \[1\] and used must, should, and may as
suggested in Internal validity: Surveys inherently lack interactivity,
which RFC 21196 . We assigned items to essential, desirable, and excep-
limits opportunities for clarification or follow-up. Unlike inter-
tional groups based on their median response ranks and statistically
views, we could not probe deeper into ambiguous or contradictory
significant differences identified through post-hoc comparisons.
answers. This constraint was accepted as a trade-off to support Our
final guidelines are shown in 5, categorized into three groups
quantitative analysis and ensure consistency with the literature
depending on their importance. The table outlines the key reporting
review. Additionally, self-reporting bias may be present, as partici-
pants might have responded in ways they perceived as socially or 6
https://www.rfc-editor.org/rfc/rfc2119 Reporting LLM Prompting in
Automated SE: A Guideline Based on Current Practices and Expectations
FORGE '26, April 12--13, 2026, Rio de Janeiro, Brazil

                                                                                        5.2    Discussion of Practices

S4 S5 S7 S8 S10 S9 S14 Quantitative comparison of expectations and
practices: The results reveal notable gaps between community
expectations and current reporting practices. In particular, two
guideline items ex- hibit especially large discrepancies. First, only
16.4 % of the analyzed papers reported the exact version of the LLM
used, despite more S6 S11 S13 than 80 % of survey respondents
identifying this as an essential practice. This gap may be due to
limited awareness among authors, e.g., some may not realize that models
like GPT-4 are regularly S12 updated even under the same version name,
or it may reflect a belief that such version differences are negligible.
Second, only around 20 % of papers addressed prompting as a Figure 3:
Survey items (S4--S14) and their response patterns. potential threat to
validity, whereas over 60 % of respondents con- An arrow pointing from
node 𝐴 to 𝐵 indicates that 𝐴 had a sidered this discussion essential.
This mismatch may be attributed significantly higher median response
than 𝐵. to the relative novelty of prompting in SE research, where
commu- nity norms around validity threats and mitigation strategies have
yet to be established. 10 While the proportion of papers following the
desirable and excep- tional items generally aligns with reviewer
expectations, adherence to essential items remains inconsistent. Most
essential items were 8 reported in only 51--66 % of papers, indicating
substantial room for improvement. Interpretation and implications: There
are several possible rea- Reported Guidelines

                               6                                                        sons for the mismatch between how often papers follow the pro-
                                                                                        posed guideline items and how strongly reviewers expect them to
                                                                                        be reported. A straightforward explanation is the strict page limits
                               4                                                        imposed by major SE conferences, which often force authors to
                                                                                        omit methodological details perceived as less important. This effect
                                                                                        may be amplified by the lack of community consensus on whether
                               2
                                                                                        prompts constitute part of the method or merely the experimental
                                                                                        setup. Many researchers still treat prompt wording as an implemen-
                                                                                        tation detail rather than as a methodological decision that impacts
                               0
                                                                                        the results and reproducibility.
                                        2022        2023            2024   2025             Reviewer bias may further reinforce this cycle. For example, if
                                                             Year                       only about two-thirds of reviewers consider including the exact
                                                                                        prompt as essential, the remaining third may overlook its omission

Figure 4: A box plot showing, for each year of extracted pa- during
review. As a result, authors receive inconsistent feedback pers, the
number of reported guidelines per paper. and may lower the priority of
prompt reporting in subsequent submissions. Over time, such variability
in reviewing standards can lead to more brief reporting practices, even
when most reviewers conceptually value transparency. elements along with
their classification and reported literature Equally important as
understanding why these mismatches occur frequencies, grounding our
recommendations on expert judgment is recognizing how they affect the
replicability and methodological and comparing them to empirical
evidence. The values in column soundness of published work. With the
rapid evolution of current "PC member agreement" correspond to the ratio
of respondents LLMs, omitting the exact version used in experiments
already se- who categorized the item in the respective group (e.g.,
44.94 % verely limits replicability as different updates of the same
model of respondents categorized the use of automated prompt tuning may
produce noticeably different outputs. Likewise, not reporting techniques
as exceptional). the exact prompt can hinder reproducibility entirely,
as subsequent To assess whether reporting practices have improved over
time, researchers cannot reconstruct the original interaction that
gener- we analyzed trends in guideline adherence across publication
years. ated the results. Figure 4 shows the distribution of guideline
items followed per Methodological soundness further depends on
transparent rea- paper by year. The data suggests a slight upward trend
in adherence, soning behind experimental decisions. When authors neither
jus- though the median remains modest, ranging from 4.5 to 6 out of 11
tify why specific prompts were chosen nor reviewers consistently
possible items. The variance is also considerable: while some papers
request such explanations, the conceptual foundation of a study follow
nearly all recommended practices, a significant number becomes weaker.
The fact that most papers omit prompting as a po- report only three or
fewer, highlighting continued inconsistency in tential threat to
validity illustrates that prompting is still not widely reporting
standards. FORGE '26, April 12--13, 2026, Rio de Janeiro, Brazil Korn et
al.

                                                       Table 5: Guidelines on Reporting LLM Prompting

                                                                                                                                Followed    PC Member

Guideline in Papers Agreement Essential Authors must name the used LLMs
(e.g., GPT-4, Llama 3, Claude Opus 4). 92.31 % 97.75 % Authors must
precisely name the used LLM versions (e.g., GPT-4 2024-08-06). 16.43 %
82.02 % Authors must provide the exact prompts used word-by-word. They
may shorten the prompt using templates. 57.69 % 68.54 % Authors must
describe the prompts used and how they are structured. 66.08 % 87.64 %
Authors must justify why a specific prompt structure or phrasing was
chosen. 51.40 % 55.06 % Authors must mention all prompt engineering
techniques used (e.g., few-shot, chain-of-thought). 62.24 % 61.80 %
Authors must discuss their use of prompts as part of threats to
validity. 21.68 % 60.67 % Desirable Authors should use different LLMs
and compare the results. 56.99 % 60.67 % Authors should report how they
refined/iterated the prompts to improve performance. 45.45 % 51.69 %
Authors should test multiple prompt variations and report the results.
43.36 % 43.82 % Exceptional Authors may apply automated prompt tuning
techniques. 4.90 % 44.94 %

regarded as a methodological factor that can bias outcomes if not
fine-tuned models vs. zero-shot APIs), and study types \[1\]. A single
applied carefully. Addressing these reporting omissions is there-
unified set of recommendations may not fully account for these fore
essential to ensure credible, reproducible, and theoretically task- and
context-specific differences. This was also highlighted by grounded
LLM-based SE research. some of our respondents (e.g., "For me, a lot of
this depends on the To help close these gaps, we propose that authors
adopt prompt- RQs. If the prompt is core to the experiment, it must be
disclosed.") reporting templates that facilitate the inclusion of longer
prompts Finally, the proposed guideline has not yet been empirically
val- and detailed descriptions without exceeding page limits. Authors
idated in terms of its practical impact. While we believe it can should
also critically evaluate which LLM-specific details, such as improve
reproducibility and transparency, future work is needed model version,
system settings, or fine-tuning parameters, are nec- to assess whether
guideline adoption leads to measurable improve- essary to maximize
reproducibility and methodological soundness. ments in review quality,
replicability, or research clarity. Reviewers, in turn, could consider
checklists to ensure completeness These limitations underscore the need
to treat our guideline of such information during evaluation.
Integrating these empiri- as an empirically grounded starting point,
rather than a fixed or cally grounded standards directly into review
forms would simplify universal standard, and to revisit and refine it as
the field matures. the review process while reinforcing consistent
expectations. Relation to existing evidence: Our guideline overlaps with
Baltes et al.'s \[1\] in key areas, such as the importance of reporting
ex- 6 Conclusions and Future Directions act prompts, describing their
structure, and documenting prompt General limitations of our approach:
While our guideline is engineering techniques. We extend their work by
providing quanti- grounded in a systematic literature review and a
survey of expe- tative data on how often practices are followed and to
what extent rienced SE researchers, the methodology carries several
general reviewers expect them, thus offering an evidence-based prioriti-
limitations that should be acknowledged. zation. Importantly, we do not
claim to replace or supersede the First, expectations and practices are
evolving rapidly in the do- broader LLM guidelines proposed by Baltes et
al. Rather, we view main of LLM-based software engineering. As prompting
techniques, our work as a complementary effort, focused specifically on
prompt LLM capabilities, and community norms continue to develop, parts
reporting within SE research, and as an empirical validation of key of
the proposed guideline may become outdated or require revision.
prompt-related aspects from their broader proposal. Where Baltes Second,
our approach may introduce a descriptive versus pre- et al. provide an
expert-driven vision, our work aims to anchor that scriptive bias. The
literature review reflects what authors chose to vision in current
practice and reviewer expectations. report, which may not always
correspond to best practices. Simi- Future work: Our study opens up
several directions for future larly, survey responses indicate what
participants believe should research and community engagement. One
promising avenue is to be reported, which may be influenced by
individual experience, expand the current guidelines toward the emerging
paradigms of norms, or exposure rather than empirical validation of
reporting "promptware" \[3\] and "AI-ware"7 , where prompts become
persistent effectiveness. artifacts embedded in software systems. In
these contexts, docu- Third, the guideline may overgeneralize across
diverse use cases. menting prompts is critical not just for research
reproducibility Prompting strategies and documentation needs vary across
SE tasks (e.g., code generation vs. test synthesis), LLM configurations
(e.g., 7 https://conf.researchr.org/home/aiware-2025 Reporting LLM
Prompting in Automated SE: A Guideline Based on Current Practices and
Expectations FORGE '26, April 12--13, 2026, Rio de Janeiro, Brazil

but also for long-term maintainability, debugging, and managing \[3\]
Zhenpeng Chen, Chong Wang, Weisong Sun, Guang Yang, Xuanzhe Liu, Jie M.
technical debt. Alongside prompt engineering, context engineering Zhang,
and Yang Liu. 2025. Promptware Engineering: Software Engineering for LLM
Prompt Development. doi:10.48550/ARXIV.2503.02400 is gaining importance
as a technique for managing information \[4\] Xinyi Hou, Yanjie Zhao,
Yue Liu, Zhou Yang, Kailong Wang, Li Li, Xiapu Luo, within the limited
context window of LLMs. Future guidelines could David Lo, John Grundy,
and Haoyu Wang. 2024. Large Language Models for Software Engineering: A
Systematic Literature Review. ACM Trans. Softw. Eng. incorporate
documentation practices for context segmentation, to- Methodol. 33, 8
(Dec. 2024), 220:1--220:79. doi:10.1145/3695988 ken compression, and
retrieval-augmented generation, which are \[5\] Kaicheng Huang, Fanyu
Wang, Yutan Huang, and Chetan Arora. 2025. Prompt increasingly relevant
in complex LLM-powered systems. Engineering for Requirements
Engineering: A Literature Review and Roadmap. arXiv:2507.07682 \[cs.SE\]
https://arxiv.org/abs/2507.07682 Another important direction is the
empirical validation of our \[6\] Barbara Kitchenham, Stuart Charters,
et al. 2007. Guidelines for performing reporting guidelines. While our
survey and literature analysis sup- systematic literature reviews in
software engineering. (2007). port their relevance, future work could
assess their impact on actual \[7\] Barbara A. Kitchenham and Shari
Lawrence Pfleeger. 2002. Principles of Survey Research Part 2: Designing
a Survey. SIGSOFT Softw. Eng. Notes 27, 1 (Jan. 2002), research quality
(e.g., by measuring improvements in reproducibil- 18--20.
doi:10.1145/566493.566495 ity, peer review scores, or clarity of
experimental design). Moreover, \[8\] Pengfei Liu, Weizhe Yuan, Jinlan
Fu, Zhengbao Jiang, Hiroaki Hayashi, and Graham Neubig. 2023. Pre-Train,
Prompt, and Predict: A Systematic Survey of while our study focused on
the software engineering domain, simi- Prompting Methods in Natural
Language Processing. ACM Comput. Surv. 55, 9 lar prompting practices are
used in other fields such as HCI, data (Jan. 2023), 195:1--195:35.
doi:10.1145/3560815 science, and NLP. Investigating how these guidelines
transfer to or \[9\] Anh Nguyen-Duc, Beatriz Cabrero-Daniel, Adam
Przybylek, Chetan Arora, Dron Khanna, Tomas Herda, Usman Rafiq, Jorge
Melegati, Eduardo Guerra, Kai-Kristian need adaptation in other research
communities would help ensure Kemell, Mika Saari, Zheying Zhang, Huy Le,
Tho Quan, and Pekka Abrahamsson. their broader applicability. 2023.
Generative Artificial Intelligence for Software Engineering -- A
Research To promote practical adoption, tooling and author/reviewer sup-
Agenda. doi:10.48550/ARXIV.2310.18648 \[10\] T. Punter, M. Ciolkowski,
B. Freimut, and I. John. 2003. Conducting on-line sur- port could be
developed. This may include prompt reporting tem- veys in software
engineering. In International Symposium on Empirical Software plates,
automated checklists, or integration with artifact evaluation
Engineering (ISESE). IEEE, 80--88. doi:10.1109/isese.2003.1237967 \[11\]
Paul Ralph, Nauman bin Ali, Sebastian Baltes, Domenico Bianculli,
Jessica Diaz, processes. Given the pace of innovation in LLM research,
we also Yvonne Dittrich, Neil Ernst, Michael Felderer, Robert Feldt,
Antonio Filieri, envision maintaining the guidelines as a living
resource, allowing Breno Bernard Nicolau de França, Carlo Alberto Furia,
Greg Gay, Nicolas Gold, them to evolve in response to emerging tools,
prompting strategies, Daniel Graziotin, Pinjia He, Rashina Hoda, Natalia
Juristo, Barbara Kitchen- ham, Valentina Lenarduzzi, Jorge Martínez,
Jorge Melegati, Daniel Mendez, and community norms. Tim Menzies,
Jefferson Molleri, Dietmar Pfahl, Romain Robbes, Daniel Russo, Finally,
we aim to contribute our findings to broader commu- Nyyti Saarimäki,
Federica Sarro, Davide Taibi, Janet Siegmund, Diomidis Spinel- nity
standardization efforts. In particular, we see opportunities lis,
Miroslaw Staron, Klaas Stol, Margaret-Anne Storey, Davide Taibi, Damian
Tamburri, Marco Torchiano, Christoph Treude, Burak Turhan, Xiaofeng
Wang, to collaborate with the complementary work by Baltes et al. \[1\],
and Sira Vegas. 2021. Empirical Standards for Software Engineering
Research. whose top-down guidelines address a broader range of
LLM-related arXiv:2010.03525 \[cs\] doi:10.48550/arXiv.2010.03525 \[12\]
Pranab Sahoo, Ayush Kumar Singh, Sriparna Saha, Vinija Jain, Samrat
Mondal, research practices. Our empirically grounded, bottom-up results
and Aman Chadha. 2024. A Systematic Survey of Prompt Engineering in
Large provide a valuable counterpoint and validation. We also plan to
Language Models: Techniques and Applications.
doi:10.48550/ARXIV.2402.07927 offer our findings as input to the ACM
SIGSOFT Empirical Stan- \[13\] Jiho Shin, Clark Tang, Tahmineh Mohati,
Maleknaz Nayebi, Song Wang, and Hadi Hemmati. 2025. Prompt Engineering
or Fine-Tuning: An Empirical Assessment dards8 , which currently lack
guidance on LLM-driven research. By of LLMs for Code. In IEEE/ACM 22nd
International Conference on Mining Software contributing to these
community-driven initiatives, we hope to Repositories (MSR). IEEE,
490--502. doi:10.1109/msr66628.2025.00082 support the development of
consistent, high-quality practices for \[14\] Janice Singer, Susan E
Sim, and Timothy C Lethbridge. 2008. Software engi- neering data
collection for field studies. In Guide to advanced empirical software
documenting and evaluating LLM usage in software engineering
engineering. Springer, 9--34. and beyond. \[15\] Bianca Trinkenreich,
Fabio Calefato, Geir Hanssen, Kelly Blincoe, Marcos Kali- nowski, Mauro
Pezzè, Paolo Tell, and Margaret-Anne Storey. 2025. Get on the Train or
be Left on the Station: Using LLMs for Software Engineering Research.
Acknowledgments doi:10.48550/ARXIV.2506.12691 \[16\] Junjie Wang, Yuchao
Huang, Chunyang Chen, Zhe Liu, Song Wang, and Qing We used Generative AI
(e.g., Gemini-2.5 and ChatGPT) to support Wang. 2024. Software Testing
With Large Language Models: Survey, Landscape, and validate data
extraction and filtering, and to improve the text. and Vision. IEEE
Trans. Software Eng. 50, 4 (2024), 911--936. doi:10.1109/TSE.2024.
3368208 \[17\] Daoguang Zan, Bei Chen, Fengji Zhang, Dianjie Lu,
Bingchao Wu, Bei Guan, References Wang Yongji, and Jian-Guang Lou. 2023.
Large Language Models Meet NL2Code: A Survey. In 61st Annual Meeting of
the Association for Computational Linguistics \[1\] Sebastian Baltes,
Florian Angermeir, Chetan Arora, Marvin Muñoz Barón, Chun- (Volume 1:
Long Papers). Association for Computational Linguistics. doi:10.18653/
yang Chen, Lukas Böhme, Fabio Calefato, Neil Ernst, Davide Falessi,
Brian v1/2023.acl-long.411 Fitzgerald, Davide Fucci, Marcos Kalinowski,
Stefano Lambiase, Daniel Russo, \[18\] Quanjun Zhang, Chunrong Fang,
Yuxiang Ma, Weisong Sun, and Zhenyu Chen. Mircea Lungu, Lutz Prechelt,
Paul Ralph, Rijnard van Tonder, Christoph Treude, 2024. A Survey of
Learning-based Automated Program Repair. ACM Trans. Softw. and Stefan
Wagner. 2025. Guidelines for Empirical Studies in Software En- Eng.
Methodol. 33, 2 (2024), 55:1--55:69. doi:10.1145/3631974 gineering
involving Large Language Models. arXiv:2508.15503 \[cs.SE\] https:
//arxiv.org/abs/2508.15503 \[2\] Tom Brown, Benjamin Mann, Nick Ryder,
Melanie Subbiah, Jared D Kaplan, Prafulla Dhariwal, Arvind Neelakantan,
Pranav Shyam, Girish Sastry, Amanda Askell, Sandhini Agarwal, Ariel
Herbert-Voss, Gretchen Krueger, Tom Henighan, Rewon Child, Aditya
Ramesh, Daniel Ziegler, Jeffrey Wu, Clemens Winter, Chris Hesse, Mark
Chen, Eric Sigler, Mateusz Litwin, Scott Gray, Benjamin Chess, Jack
Clark, Christopher Berner, Sam McCandlish, Alec Radford, Ilya Sutskever,
and Dario Amodei. 2020. Language Models Are Few-Shot Learners. In
Advances in Neural Information Processing Systems, Vol. 33. Curran
Associates, Inc., 1877-- 1901.

8 https://www2.sigsoft.org/EmpiricalStandards/ 
