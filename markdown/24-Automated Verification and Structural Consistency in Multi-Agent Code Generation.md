                                         LLM-Based Multi-Agent Systems for Code Generation: A Multi-Vocal
                                         Literature Review⋆
                                         Zeeshan Rasheeda , Muhammad Waseema , Kai-Kristian Kemella , Mika Saaria and
                                         Pekka Abrahamssona,∗
                                         a Faculty of Information Technology and Communication Sciences, Tampere University, Tampere, Finland



                                         ARTICLE INFO                                           ABSTRACT
                                         Keywords:                                              Large Language Models (LLMs) have enabled multi-agent systems to perform autonomous code
                                         Large Language Models                                  generation for complex tasks. Despite the recent growth in research and industrial applications in this
                                         Multi-Agent Systems                                    area, there is little work on synthesizing evidence from both academic and industrial sources to capture
                                         Automation                                             the current state of research on LLM-based multi-agent systems for code generation. To this end,

arXiv:2604.16321v1 \[cs.SE\] 25 Feb 2026

                                         Multi-Vocal Literature Review                          we conducted a Multi-Vocal Literature Review (MLR), combining insights from both academia and
                                                                                                industry, including peer-reviewed studies and grey literature. The aim of this study is to systematically
                                                                                                synthesize and analyze existing knowledge on LLM-based multi-agent systems for code generation.
                                                                                                Specifically, the review examines the motivations for their use, employed benchmarks and models,
                                                                                                key challenges, proposed solutions, and potential directions for future research.
                                                                                                    We selected and reviewed 114 studies, and the key findings are: 1) the identified reasons for
                                                                                                adopting multi-agent systems for code generation were classified into nine categories; 2) the models
                                                                                                and evaluation benchmarks utilized across the studies were systematically analyzed to provide a
                                                                                                structured overview of commonly adopted LLM configurations and assessment practices; 3) the
                                                                                                reported challenges and corresponding solutions were synthesized into six main categories and 26
                                                                                                subcategories; and 4) future research directions were identified and organized into six main categories
                                                                                                and 18 subcategories. The results of this MLR will assist researchers and practitioners in pursuing
                                                                                                further studies and supporting the real-world adoption of multi-agent systems in industrial settings.



                                         1. Introduction                                                                   fundamental questions remain regarding the reliability, con-
                                                                                                                           sistency, and generalizability of LLM-based agents across
                                             Large Language Model (LLM)–based agents have been                             diverse SE contexts [11]. A range of technical and oper-
                                         widely adopted in software development processes [1]. In                          ational challenges, including hallucinations, inconsistency,
                                         recent years, a growing body of research from both academia                       high computational costs, and context-length limitations,
                                         and industry has examined the capabilities and impact of                          continue to constrain the effective deployment of LLM-
                                         LLM-based agents across a range of Software Engineering
                                                                                                                           based agents in real-world settings [10].
                                         (SE) tasks [2]. Modern SE workflows increasingly follow
                                                                                                                               Moreover, the recent growth of white papers, technical
                                         an agent-centric design, in which autonomous or semi-                             blogs, and industry-driven case studies has resulted in a
                                         autonomous agents play a central role throughout the soft-                        large and loosely connected body of knowledge. This makes
                                         ware development lifecycle [3]. This shift toward automated                       it difficult to combine existing findings, compare different
                                         and collaborative software development is exemplified by
                                                                                                                           approaches, and develop a clear understanding of the current
                                         agent-based frameworks such as MetaGPT [4], ChatDev
                                                                                                                           state of LLM-based agent systems in SE [2]. Furthermore,
                                         [5], AgentCoder [6], MapCoder [7], SWE-Agent [8], and                             both researchers and practitioners still face challenges in
                                         CodeSim [9]. These systems commonly employ multi-agent                            fully understanding the practical applicability, limitations,
                                         architectures, in which each agent serves as a prompt-driven                      and broader implications of employing LLM-based multi-
                                         component with well-defined roles, responsibilities, and be-                      agent systems in software development [3]. To catalyze
                                         havioral constraints. By decomposing complex development
                                                                                                                           further research and development, there is a need for a
                                         tasks into smaller, coordinated sub-tasks, such frameworks
                                                                                                                           systematic synthesis of the existing body of academic and
                                         enable functional specialization and distribute the cognitive                     grey literature to provide a structured overview of how
                                         load across agents [10].                                                          these systems are currently used, their limitations, proposed
                                             Despite their potential, the practical adoption of LLM-                       solutions, and future research directions.
                                         based multi-agent systems in SE remains in an early stage                             Motivation: This study is part of the MAISA project
                                         of development [10]. Although both academic research and
                                                                                                                           (2025–2027), funded by Business Finland, which aims to
                                         industrial initiatives have demonstrated notable capabilities,
                                                                                                                           investigate the integration of LLM-based agents into SE.
                                             ⋆
                                                 Submitted to the Journal of Systems and Software (JSS).                   The project brings together academia and industry, involv-
                                             ∗ Corresponding author: Zeeshan Rasheed (zeeshan.rasheed@tuni.fi).
                                                                                                                           ing eight leading Finnish companies, each with distinct
                                                 zeeshan.rasheed@tuni.fi (Z. Rasheed); muhammad.waseem@tuni.fi             requirements and goals related to SE and the adoption of
                                         (M. Waseem); kai-kristian.kemell@tuni.fi (K. Kemell);
                                                                                                                           LLM-based multi-agent systems. This study addresses in-
                                         mika.saari@tuni.fi (M. Saari); pekka.abrahamsson@tuni.fi (P.
                                         Abrahamsson)                                                                      dustry needs by examining the role of LLM-based agent
                                              ORCID (s):                                                                   systems in software development, including tasks such as

                                         Rasheed et al.: Preprint submitted to Elsevier                                                                                                 Page 1 of 34

LLM-Based Multi-Agent Systems for Code Generation

code generation, and by assessing their reliability. Recent Structure of
the paper: The structure of the paper studies indicate that although
LLM-based agents for soft- is organized as follows. Section 2 presents
the research ware development are increasingly being explored in in-
methodology, and the findings of this study are reported dustrial
settings, organizations continue to face challenges in Section 3.
Section 4 discusses the key results and their related to reliability,
evaluation practices, and integration implications. Section 5 outlines
the threats to validity, and into existing workflows \[12\], \[10\],
\[8\], \[2\]. These sources Section 6 reviews existing survey studies on
LLMs and also point to a lack of shared knowledge on how agent-
LLM-based agents in SE. Section 7 concludes the paper and based systems
are assessed in practice and what types of suggests directions for
future work. issues commonly arise during their use. Building on this
broader industry context, this study provides an overview of LLM-based
multi-agent performance by identifying the 2. Research Method key
challenges encountered in practice and summarizing the We conducted an
MLR following the guidelines given in solutions proposed to mitigate
these issues. Our study also \[14\] and \[15\]. In an MLR, peer-reviewed
academic studies aims to provide a clear view of LLM-based agent
practices, and grey literature are systematically analyzed to provide
addressing the needs of both researchers and practitioners by a broad
understanding of a research topic by incorporating bridging academic
insights with industrial perspectives. perspectives from both academia
and industry \[14\]. Our To address this knowledge gap and meet the
practi- MLR consists of three phases: 1) defining the research cal needs
of the MAISA project consortium, in this study questions and search
string, 2) conducting the peer-reviewed we systematically identify and
analyze the key objectives, and grey literature search, and 3)
performing data extraction reliability considerations, challenges,
proposed solutions, and analysis. Figure 1 illustrates the MLR process.
and future research directions related to LLM-based multi- agent system
for code generation. Through a Multi-Vocal 2.1. Objective and Research
Questions Literature Review (MLR) that integrates both peer-reviewed
This MLR is designed to examine the role of multi-agent and grey
literature, we provide a systematic and up-to- systems in code
generation by assessing both the current date overview of the field and
offer actionable insights for state of the art and emerging trends. As
noted by Garousi researchers, practitioners, and decision-makers. et
al. \[14\], when a research topic is fast-developing and Contributions:
This study makes the following key strongly influenced by industrial
practice, grey literature contributions: should be taken into
consideration. In recent years, the devel- opment of agentic frameworks
and LLM-based coding sys- • An overview of LLM-based multi-agent systems
for tems has been continuously evolving and is strongly driven code
generation through systematic analysis of both by industry practice,
where many key insights, tools, and academic and industrial studies.
empirical observations are reported in grey literature such as technical
blogs, open-source repositories, and industry • Identification of the
motivations for adopting LLM- reports. Depending only on peer-reviewed
academic studies based agent system for code generation in both aca-
would not fully represent the current state and practical reali- demic
and industrial contexts. ties of the field. By integrating evidence from
both academic • Extraction of the benchmarks and models reported and
grey literature, this study aims to offer practical and in both academic
and industrial studies and analyzed actionable insights for researchers
and practitioners in the their frequency of use to identify those most
com- SE community. The investigation is structured around seven monly
adopted in academia and industry. clearly defined research questions,
which are listed in Table 1. • Identification and categorization of the
challenges and RQ1 maps the evidence base by quantifying the volume
corresponding solutions reported in peer-reviewed lit- and types of
publications on multi-agent systems for code erature and grey
literature. generation. Its primary aim is to identify publication
trends and the most prominent venues in this research area. RQ2 •
Identification of emerging trends and future direc- aims to understand
the motivations behind the adoption of tions, and recommendations to
guide future studies as multi-agent systems for code generation by
researchers and well as practical adoption in both academic and indus-
practitioners. RQ3 examines the evaluation benchmarks and trial research
on agent-based software development. metrics used to assess agent
performance. RQ4 focuses on • The replication package of our MLR is
publicly avail- identifying the language models employed in academia and
able online to support validation and replication of industry for these
agent systems. Since language models our study \[13\]. The dataset
includes detailed study de- serve as the core reasoning component of
such systems, it mographics, the extracted and analyzed benchmarks is
important to determine which models are most frequently and models, as
well as the identified and categorized adopted. Finally, RQ5, RQ6, and
RQ7 collectively address challenges, corresponding solutions, and future
re- the research gaps: RQ5 analyzes the challenges encountered, search
directions for multi-agent systems in software RQ6 investigates the
proposed solutions to mitigate these development. challenges and enhance
performance, and RQ7 outlines

Rasheed et al.: Preprint submitted to Elsevier Page 2 of 34  LLM-Based
Multi-Agent Systems for Code Generation

                                       Phase 1                                                                 Phase 2                                                                Phase 3


                                 Specifying Research                                                      Conducting the Multi-                                               Performing Data Analysis
                              Questions and Search String                                                Vocal Literature Search                                                and Documentation

                                           Specifying
                                 A      Research Question
                                                                                                     C       Primary Search                                               E        Data Extraction
                                       Research Questions
                                                                                                 Extraction of                                                            Extraction of
            Purpose of using multi-                                                             Primary Studies                                                               Data
                                                            Agents reliability for
          agents for code generation                         code generation
          Model and benchmark
        utilization for multi-agents

       Challenges and Solutions                                Future research trend                      Screening of Studies
                                                                                                                                                                   Data                              Classifying
                                        Search String and                                                                                                      Familiarization                        Themes
                                 B           Source                                                                                                                                Data Identifying
                                                                                             Title and                              Full
                                                                                             Keywords         Abstract and                                                        Coding Themes
                                                                                                                                    Text
                                                                                                              Conclusion
                                                                                                                                                                          F Results Documentation
                                                                                                     D        Snowballing
                                         Search String

               ("large language model" OR "language model" OR "LLM") AND                      Backward                         Forward                          Research                                                Validity
                                                                                             Snowballing                      Snowballing                                              Answers to
       ("multi-agent" OR "multiagent" OR "AI agent" OR "intelligent agent" OR "LLM                                                                             Demography                                               Threats
                                                                                                                                                                                   Research Questions
           based agent" OR "agent-based system" OR "collaborative agent") AND
         ("code generation" OR "program synthesis" OR "automated programming"
       OR "code writing" OR "software generation" OR "code completion" OR "code
                            synthesis" OR "program generation")
                                                                                                     Peer Reviewed Papers                                            Grey Literature Studies




                                                                                                                                                 Snowballing
                                                                                                          Abstract and Conclusions
                                                                                                                                                                                 Full Text Reading




                                                                                                                                                                                                          Snowballing
                                                                                                         Title and Keywords
                                                                                                Initially Extracted                                                       Title and Keywords
                                                                                                                                                                  Initially Extracted
         Peer-Reviewed Papers Databases               Grey Literature Search Engine         IEEE Xplore      297      37                   8
                                                                                                                              28                                Google
                                                                                               ACM                                                                            138         49    24
                                                                                                             441      38      31           17
                                                                                                                                                                 Bing         219         89    9
                                                                                          Springer Link      118      28      24           3
                                                                                                                                                                 Yahoo        125         36     4
                                                                                         Google Scholor      986   39          31           1
                                                       Google                               Scopus                                                                Total        482        174    37          3
              Springer             Google                             Bing       Yahoo                        32   8           8            4
       ACM             IEEE Scopus
                Link               Scholor                                                      Total        1874 150         122          34     41

                                                                                                                                            Studies = 74                                                 Studies = 40




                           Figure 1: Visual representation of the research methodology implemented in this study for MLR

Table 1 Research questions and rationales for the MLR on LLM-based
multi-agent systems for code generation RQ Research Question Rationale
Demographic Detail This RQ aims to map the evidence base by collecting
data on the volume and type What is the frequency and type of published
research on LLM-based of literature concerning multi-agent systems for
code generation. The findings derived RQ1 multi-agent systems for code
generation? from this RQ will establish publication trends and identify
the most frequent publishing venues for multi-agent system research in
this domain. Reasons for using Agents This question aims to identify why
LLM-based multi-agent systems are adopted for What are the main purposes
for using multi-agent LLM-based systems code generation, particularly in
addressing complexity, verification, and quality RQ2 in code generation?
issues. It helps clarify the practical motivations behind using multiple
agents instead of single-agent approaches. Model and Benchmark
Utilization The objective of this question is to identify the evaluation
benchmarks and metrics What evaluation metrics or benchmarks are used to
assess these LLM-agent RQ3 used to assess LLM-based multi-agent systems
in code generation, clarifying how multi-agent systems in code
generation? performance, quality, and reliability are measured across
studies. This question examines which LLM models are most frequently
used in RQ4 What LLM models are most commonly employed in code
generation tasks? code generation to reveal common choices and trends.
It helps identify standard practices and informs comparisons across
existing multi-agent systems. Challenges, Solutions, and Future Research
Trends What are the main challenges reported in applying LLM-based The
objective of this question is to identify the main challenges reported
RQ5 multi-agent systems for code generation? in the application of
multi-agent systems for code generation. The objective of this question
is to examine the solutions proposed to address What solutions are
proposed to mitigate these challenges and improve the RQ6 identified
challenges and to improve the performance of LLM-based multi-agent
performance of LLM-based multi-agent systems for code generation?
systems for code generation. The objective of this question is to
identify future research directions and open What future research
directions and open challenges are identified in studies challenges
highlighted in studies on LLM-based multi-agent systems for code RQ7 on
LLM-based multi-agent systems for code generation? generation,
emphasizing gaps, emerging trends, and areas requiring further
investigation.

future research directions and open issues identified by the 2.2. Search
Strategy community. In this section, we describe the process used to
collect both peer-reviewed studies and grey literature sources for
inclusion in our review.

Rasheed et al.: Preprint submitted to Elsevier Page 3 of 34  LLM-Based
Multi-Agent Systems for Code Generation

Table 2 Studies were included if they (1) investigated LLM-based Sources
for collecting peer-reviewed and grey literature multi-agent systems for
code generation, (2) reported an Databases (Peer-reviewed / White
Literature) evaluation of agent-based systems for code generation us-
Database Targeted Search Area ing benchmarks such as HumanEval,
SWE-bench, APPS, ACM Digital Library Paper title, keywords, abstract
IEEE Xplore Paper title, keywords, abstract MBPP, or other measurable
real-world programming tasks, Scopus Paper title, keywords, abstract and
(3) were published in English as peer-reviewed papers SpringerLink
Google Scholar Paper title, abstract Paper title, abstract or credible
grey literature within the defined temporal scope. Grey Literature
Sources In contrast, studies were excluded if they (1) were not Source
Targeted Search Area available in English or lacked full-text
accessibility through Google Web search (titles/snippets); domain
filters when relevant institutional access, (2) fell outside the scope
of LLM-based Bing Web search (titles/snippets); domain agentic systems
for code generation, or (3) consisted of filters when relevant Yahoo Web
search (titles/snippets); domain opinion pieces, news articles, or short
abstracts that did filters when relevant not provide sufficient
methodological detail or evaluative evidence. 2.2.1. Search String
Development 2.2.4. Search and Selection Process for Peer-Reviewed First,
we considered using the PICO (Population, Inter- and Grey Literature
vention, Comparison, Outcome) framework \[16\] to guide We conducted the
search and selection process for peer- the development of the search
strategy. However, applying reviewed papers in June 2025 and considered
all publications PICO resulted in an extensive combination of keywords
released between 2022 and 2025. The application of our and Boolean
operators, which exceeded the query length search terms resulted in
1,874 unique papers, as shown in limitations imposed by several digital
libraries. Finally, we Figure 1. For grey literature, the search was
conducted in formulated the search string using our domain knowledge
September 2025 and included all publications available up to and a
series of iterative trial searches conducted with the co- that date.
Applying the search terms resulted in 482 unique authors. This approach
allowed us to refine the search strat- grey literature contributions, as
reported in Figure 1. egy to align with the aims of our study while
maintaining broad coverage within practical constraints. Primary Search:
In the development of our search string, we com- bined domain-specific
terminology to capture studies related • Step 1: Extraction of Studies:
For collecting peer- to LLMs and their application in multi-agent and
code- reviewed studies, we performed custom search generation contexts.
Specifically, we used combinations of queries across the selected
databases (see Table 2) the phrases "large language model", "language
model", and to retrieve study titles, authors, publication years, "LLM"
to represent general references to foundation models. venues,
publication types, and abstracts. This initial To capture literature
focused on multi-agent collaboration, retrieval process resulted in
1,874 studies collected we included variations such as "multi-agent",
"multiagent", from five databases. For grey literature, we used the "AI
agent", "intelligent agent", "LLM-based agent", "agent- same search
terms as those adopted for peer-reviewed based system", and
"collaborative agent". Finally, to target studies. We performed custom
search queries across research addressing SE applications, the search
string incor- three search engines, Google, Bing, and Yahoo, result-
porated phrases such as "code generation", "program synthe- ing in 482
studies retrieved from these sources. sis", "automated programming",
"code writing", "software • Step 2: Title and Keyword Screening: For
peer- generation", "code completion", and "program generation". reviewed
studies, we manually reviewed the titles Logical operators (AND/OR) were
applied to ensure that and keywords of the papers initially collected
using all retrieved studies discussed the intersection of these core the
predefined inclusion and exclusion criteria shown themes. in Table 3. We
included only studies that examined LLM-based agents for code generation
or software 2.2.2. Bibliographic Sources development, while papers
focusing solely on multi- To retrieve white papers, we selected relevant
biblio- agent or agent-based systems without a connection graphic
sources in accordance with the guidelines proposed to code generation
were excluded. Duplicate entries by Kitchenham and Charters \[17\]. For
the white literature, collected from multiple databases (e.g., IEEE
Xplore, we searched five major sources: ACM Digital Library, IEEE ACM,
and Scopus) were identified and removed by Xplore, Scopus, SpringerLink,
and Google Scholar. For the sorting and comparing records, resulting in
the elim- grey literature, we used three widely used search engines:
ination of 478 duplicates from the initial set of 1,874 Google, Bing,
and Yahoo. papers. After applying the inclusion and exclusion cri-
2.2.3. Inclusion and Exclusion Criteria teria to titles and keywords,
150 papers were retained To maintain the quality and relevance of the
reviewed for the next stage of the review. For grey literature, studies,
a set of inclusion and exclusion criteria was defined duplicate studies
retrieved from Google, Bing, and according to the objectives of this
study (see Table 3). Yahoo were first identified and removed by sorting
and

Rasheed et al.: Preprint submitted to Elsevier Page 4 of 34  LLM-Based
Multi-Agent Systems for Code Generation

Table 3 Inclusion and exclusion criteria defined for this MLR Selection
Criteria Inclusion Criteria Exclusion Criteria Language English
Non-English Study type Primary studies from peer-reviewed sources (e.g.,
journal articles, Duplicate studies or sources lacking accessible full
text (e.g., conference papers, workshop and symposium papers) as well as
broken links, missing documents). relevant grey literature (e.g.,
technical reports, practitioner blogs, industry documents, videos).
Study focus Studies that explicitly focus on LLM-based agents for code
Studies that discuss LLM-based agents without involving code generation.
This includes research on agent-based programming generation tasks
(e.g., reasoning, planning, dialogue), studies workflows, the
development or application of LLM-driven agents using LLMs for code
generation without an agent-based compo- for automating code generation,
and evaluations of agent perfor- nent, and studies on agents performing
tasks unrelated to code mance in code generation tasks. generation.
Study duration Studies published between January 2022 and June 2025.
Studies published before January 2022 or after June 2025.

Table 4 Quality assessment criteria Quality Assessment Criteria for
Peer-Reviewed Studies QA Descriptions QA1 Is the study focused on the
use of LLM-based agents for code generation tasks? QA2 Is there a clear
statement of the aims of the research? QA3 Is the study design suitable
for achieving the stated research objectives? QA4 Are empirical or
experimental data available to support the research? QA5 Was the data
collection process aligned with the research objectives? QA6 Was the
data analysis conducted in a systematic and robust manner? QA7 Has the
relationship between researcher and participants been appropriately
considered? QA8 Is there a clear statement of findings? QA9 Is the study
valuable for research or practice? Quality Assessment for Grey
Literature Criteria Questions Possible Answers 1: Well-known
organization Is the publishing organization reputable? 0.5: Existing but
not well known 0: Low-reputation organization 1: Yes Is the author
affiliated with a reputable organization? 0: No Author and Source 1:
More than three publications Credibility Does the author have sufficient
experience in the field? 0.5: 1--2 publications 0: No prior publications
1: Yes Does the source have a clearly stated aim? 0: No 1: Reputable
sources Is the source supported by authoritative references? 0.5: Less
reputable sources 0: No references 1: Yes Does the work cover a specific
research question? 0.5: Partially 0: No Research Objectivity 1: No
vested interest Are the conclusions free from bias? 0.5: Minor interest
0: Strong interest 1: Yes Are the conclusions supported by data? 0.5:
Partially 0: No 1: Yes Does the item have a clearly stated publication
date? 0: No Evidence and Date 1: Yes Are key grey or formal sources
discussed? 0: No 1: Yes Context and Novelty Does the source contribute
novel insights? 0.5: Partially 0: No 1: High control (books, reports,
etc.) Outlet Type Level of outlet control 0.5: Moderate control
(articles, Q/A sites) 0: Low control (blogs, emails, tweets)

       comparing records, resulting in the elimination of 84                                • Step 3: Abstract-Based Screening: For peer-reviewed
       studies from the initial set of 482 studies. Next, the                                 studies, we reviewed the abstracts of the collected
       titles and abstracts of the remaining 398 studies were                                 papers to assess their alignment with our research
       manually screened using the inclusion and exclusion                                    topic. The first author independently examined the
       criteria presented in Table 3. This screening process                                  abstract of each paper and assigned a status of “Yes” or
       covered a variety of sources, including blogs, techni-                                 “No” based on its relevance to the research objectives.
       cal reports, arXiv papers, articles, and videos. As a                                  Following this process, 122 papers were retained after
       result, a total of 178 studies were selected for full-text                             applying the abstract-level inclusion and exclusion
       screening.                                                                             criteria. For grey literature, most sources do not
                                                                                              provide an abstract; therefore, we skipped the abstract
                                                                                              screening stage and directly reviewed the full text.

Rasheed et al.: Preprint submitted to Elsevier Page 5 of 34  LLM-Based
Multi-Agent Systems for Code Generation

Table 5 Data items to be extracted in this MLR Code Data Item
Description RQ D1 Index ID of the study D2 Publication Year Publication
year of the study D3 Publisher Publisher of the study RQ1 D4 Venue Name
of the publishing venue D5 Publication Type Journal, conference,
workshop, and book chapter D6 Authors' Affiliation Affiliation of the
authors D7 Purpose of using Agents Purpose of using agents for code
generation in the study RQ2 D8 Benchmark and Metrics Benchmarks and
metrics used for testing agents performance in the study RQ3 D9 Large
Language Models Large language model used for agents RQ4 D10 Challenges
Agents' challenges regarding code generation in the study RQ5 D11
Solutions Solutions for the agents' challenges in the study RQ6 D12
Future Research Trend Potential future research trend for agents in the
study RQ7

    • Step 4: Full-Text Screening:                                          status in peer-reviewed venues, and the extent to which
        For peer-reviewed studies, we reviewed the full                     the findings could be generalized to multi-agent systems
        texts of the 122 papers shortlisted during the ab-                  for code generation. The quality assessment was performed
        stract screening stage. After applying the inclusion                after the study selection process to ensure a consistent and
        and exclusion criteria to the full-text assessments, we             thorough evaluation of all 74 included studies. Across the
        selected 33 papers for final data extraction. For grey              included peer-reviewed studies, quality scores ranged from
        literature, we conducted a full-text review of the                  0 (poor) to 0.5 (average) and 1 (excellent). Most included
        174 articles selected during the title screening stage,             studies achieved moderate to high quality scores, suggesting
        applying the criteria defined in Table 3. Based on this             that the synthesized findings are based on methodologically
        assessment, we identified 39 relevant studies: 18 blog              sound evidence.
        posts, nine arXiv papers, five technical reports, two                   Unlike peer-reviewed publications, grey literature is
        YouTube videos, two news articles, two media posts,                 not formally peer-reviewed, which results in less quality
        and one handbook.                                                   control. To assess the credibility and quality of grey liter-
                                                                            ature sources and to determine their inclusion, we followed

Snowballing: In Phase 2, we applied a snowballing tech- the guidelines
proposed by Garousi et al. \[14\]. As shown nique, following the general
principles outlined by Wohlin in Table 4, the evaluation considers
factors such as author \[18\], to expand our set of primary studies.
This involved and source credibility, research objectives, data
credibility, reviewing the reference lists of 33 selected peer-reviewed
novelty, impact, and the level of outlet control. Each source studies
(backward snowballing) and identifying new studies was initially
evaluated by the first author using the defined that cited these papers
(forward snowballing). The snow- criteria, applying either a binary
scale or a three-point Likert balling process was conducted in August
2025. Through scale as appropriate. The second and third authors then
this process, we identified an additional 34 studies through conducted
independent reviews of these evaluations. Any backward snowballing and
seven studies through forward disagreements were resolved through
discussion. The final snowballing. In total, 74 studies were included
for data decision was based on the average score, and grey literature
extraction and analysis (41 from snowballing and 33 from sources with a
score below 0.5 on a scale from 0 to 1 were database searches). For grey
literature, we also applied excluded. We finally applied the quality
assessment to the both backward and forward snowballing, which was con-
39 selected studies, excluding two studies and retaining 37 ducted in
November 2025. In total, three articles were studies for the subsequent
data extraction phase. identified and included in the final set of
publications: two obtained through backward snowballing and one through
2.3. Data Extraction forward snowballing. Initially, we collected 2,356
unique studies (1,874 white literature and 482 grey literature sources);
the selection Quality Assessment of Selected Studies: For peer- process
resulted in 114 final studies (74 white literature and reviewed studies,
we evaluated the quality of the selected 40 grey literature sources), as
presented in Figure 1. studies by following the guidelines proposed by
Dybå et al. The data extraction form was developed based on a \[19\].
First, we developed a checklist (Table 4) consisting of predefined set
of data items (see Table 5), each aligned with specific evaluation
questions to ensure the relevance of the the RQs presented in Table 1.
To minimize potential bias and studies to our research topic. Each
response was rated using a ensure a shared understanding, the authors
jointly discussed five-point Likert scale, ranging from 0 (poor) to 4
(excellent). and cross-verified the extracted results. As shown in Table
5, The assessment considered each study's focus on LLM- data items
D1--D6 capture the general characteristics of the based agents for code
generation, the clarity and structure of primary studies, whereas data
items D7--D12 are directly its research design, the availability and
strength of empirical mapped to RQ2--RQ7. A description of each data
item is pro- evidence (e.g., experiments or case studies), the quality
of vided in Table 5, and all extracted data were systematically
reporting (including discussion of limitations), publication organized
and analyzed using Excel spreadsheets.

Rasheed et al.: Preprint submitted to Elsevier Page 6 of 34  LLM-Based
Multi-Agent Systems for Code Generation

2.4. Data Analysis code generation and analyze the benchmarks and
language In this study, we employed a mixed-methods approach models most
commonly used in agent-based systems. to analyze the extracted data,
using descriptive analysis to Section 3.4 summarizes the challenges
faced by LLM- summarize quantitative results and thematic analysis to
syn- based agent systems and the corresponding solutions pro- thesize
qualitative findings. Quantitative data correspond- posed in the
literature for code generation tasks. Finally, Sec- ing to data items
D1, D2, D3, D4, D5, D6, D8, and D9 tion 3.5 outlines the directions for
future research identified were analyzed using descriptive statistics
\[20\] to provide an across the reviewed studies. overview of the study
characteristics. The remaining data consisted of qualitative
information, such as reasons for 3.1. Demographics of Peer-Reviewed and
Grey adopting agents, identified challenges and their proposed
Literature (RQ1) solutions, and directions for future research. These
qualita- 3.1.1. Yearly Distribution of Papers tive data were examined
using a thematic analysis-inspired Figure 2a shows the annual
distribution of peer-reviewed coding approach to organize the data into
categories and and grey literature studies. Peer-reviewed studies were
col- subcategories relevant to the research questions, informed by
lected from five databases between January 2022 and June the guidelines
presented in \[21\]. The analysis was conducted 2025. No studies on
LLM-based agents for code genera- through the following steps: tion were
identified in 2022. Although the first agent-based systems were
introduced in 2022, they did not target code • Data Overview: All
included studies were reviewed generation tasks. In 2023, a total of 11
studies were pub- multiple times to develop a thorough understanding of
lished, comprising seven conference papers and four journal their
content. During this process, we systematically articles. As shown in
Figure 2a, there was a notable increase identified and documented key
information related to in research activity in 2024, with 42 studies
published. Of the purpose of using agents (D7), reported challenges
these, 29 were conference papers, 11 were journal articles, and proposed
solutions (D10--D11), and future re- and two were workshop papers. By
June 2025, 21 studies had search trends (D12). been published, including
11 conference papers, nine journal articles, and one symposium paper. •
Initial Code Generation: The next step involved Grey literature was
collected from three sources be- developing an initial coding scheme
based on the tween January 2022 and September 2025. We did not find
information extracted for the above mentioned data any paper between
2022 and 2023 that specifically focused items. on LLM-based agent
systems for code generation. While • Emerging Themes: In this phase, a
two-stage analy- broader concepts of autonomous agents and LLMs were sis
was conducted. Initially, the identified codes were emerging during this
period, their specialized application reviewed to explore their nature
and interrelation- to automated SE and code generation tasks had not yet
ships. Then, related codes were grouped into subcat- attracted attention
within the scope of our review. As shown egories and broader thematic
categories representing in Figure 2a, we found six papers for 2024,
which shows the higher-level concepts across the studies. start of a
growing research focus on LLM-based agents for code generation. These
papers consist of one research article • Analytical Review: After the
analysis of the extracted and five blog posts. In 2025, we witnessed a
peak in research data, all authors collaboratively engaged in the re-
activity, with 34 papers. This period shows a more diverse view and
refinement of the coded data, including range of publication types,
including 11 research articles, six the identified types, subcategories,
and categories. technical reports, twelve blog posts, two videos, two
posts, Through iterative discussions, some themes were re- one technical
handbook, and one newsroom article. vised, merged, or removed to improve
conceptual clarity and ensure consistency across the analysis. 3.1.2.
Study Types For peer-reviewed studies, Figure 2b presents the dis- •
Theme Definition: Finally, clear definitions were de- tribution of the
selected studies by publication type. Con- veloped for each finalized
theme. The terminology and ference papers form the largest share of the
publications, naming conventions were carefully refined to improve with
a total of 47 studies. Journal articles follow with 24 clarity,
readability, and alignment with the objectives publications, indicating
their role as venues for more detailed of the study. and carefully
reviewed research. This distribution suggests that conferences are more
commonly used to report recent 3. Results developments, due to faster
review processes and quicker sharing of results. Workshops and
symposiums account for In this section, we present the results of the
MLR, smaller numbers, with two and one publications, respec- derived
from the analysis of selected literature. Section 3.1 tively, suggesting
that these venues are used less frequently, reports the demographic
information of both peer-reviewed possibly because they focus on more
specialized topics. and grey literature, including publication year,
publisher or For grey literature, blogs account for 17 of the 40
organization, and authors' affiliations. Sections 3.2 and 3.3 selected
studies, highlighting the active role of industry examine the reasons
for adopting LLM-based agents for

Rasheed et al.: Preprint submitted to Elsevier Page 7 of 34  LLM-Based
Multi-Agent Systems for Code Generation

                                                                                            Peer-Reviewed and Grey Literatures: Demographic Details
                                                                       r-
                                                                   Pee wed
                                                                     vie
                                                                  Re
                             50                                  56.76%
                                                                                                y                             100                                                                            100
                                                                                            Gre ure
                                                                   2                           rat
                                                                                           Lite




                                                                                                      Number of Publicaions




                                                                                                                                                                                     Number of Publicaions
                                                                                                                                                             (63.51 %)
                             40                                                            85.0%                              50                                                                             50
                                                                   11
                                                                                             1                                                                       (32.43 %)
     Number of Publicaions




                                                                                                                                                                                                                   (42.5%)
                                                                                             2                                20                                                                             20
                             30                                                     r-
                                                                                 Pee wed                                                                       47                                                            (27.5%)
                                                                                  vie        2                                                    (2.70 %)                                                                               (15.0%)
                                                                                Re                                            10
                                                                                                                                      (1.35 %)
                                                                                                                                                                          24
                                                                                                                                                                                                             10      17
                                                                                                                                                                                                                                                              (5.0%)    (5.0%)
                                                                                             1                                                                                                                                                       (2.5%)                      (2.5%)
                                                                                28.38%                                                              2
                                                                                                                                                                                                                                11
                                                                                                                                                                                                                                             6
                                                       r-                                                                                1                                                                                                             1        2         2        1
                             20                     Pee wed                          1
                                                                                             6
                                                     vie
                                                   Re              29         y
                                                                         Gre ure                                                                                                                                             Research    Technical
                                                                                                                                                                                                                    Blog                             Handbook Youtube
                                                                             rat
                                                                                                                                     Symposium Workshop      Conference   Journal                                                                                        Post     News
                                                   14.86%               Lite         9                                                 Paper    Paper          Articles   Articles
                                                                                                                                                                                                                              Articles    Report               Vedios
                                                                                            10
                                                                        15.0%
                                                     4                                                                                       4                                                                                       Blogs                              Youtube
                             10                                                                                                               Journal Article
                                                                          1
                                                                                                                                              Conference Proceedings                                                                 Research Articles                  News
                                                     7                              11      12
                                               4                          5                                                                                                                                                          Technical Reports                   Post
                                    00    0                 0                                                                  4             4Symposium Paper
                                                                                                                                                                                                                                     Handbook
                              0                                                                                                                  Workshop Paper
                                                      3             4       4         5
                                  202
                                     2
                                         202
                                               2
                                                   202    202
                                                             3   202     202       202     202
                                                                                                 5




                                                   a) Years of Publications                                                    b) Frequency and Types of Peer Reviewed Papers                                                c) Frequency and Types of Grey Literatures




                                                          Figure 2: Demographic distribution of peer-reviewed and grey literature studies

Table 6 indicates that, while formal academic research on LLM-
Distribution of peer-reviewed and grey literature based agents for code
generation is growing, a large share of Category Paper IDs % innovation
continues to be driven by industry practice and Peer-Reviewed Studies
informal technical communication channels. Peer-reviewed P1, P2, P3, P4,
P5, P6, P7, P8, 64.91 P9, P10, P11, P12, P13, P14, 3.1.3. Organizational
Affiliations P15, P16, P17, P18, P19, P20, For peer-reviewed studies,
the organizational affilia- P21, P22, P23, P24, P25, P26, tions of the
selected studies were analyzed to examine the P27, P28, P29, P30, P31,
P32, distribution of research contributions across sectors. The P33,
P34, P35, P36, P37, P38, majority of papers (54) are affiliated with
academic in- P39, P40, P41, P42, P43, P44, stitutions. Studies
affiliated with industry account for 11 P45, P46, P47, P48, P49, P50,
publications, forming a smaller portion of the overall dataset. P51,
P52, P53, P54, P55, P56, This distribution is influenced by the focus of
this MLR on P57, P58, P59, P60, P61, P62, academic databases, where
studies originating from industry P63, P64, P65, P66, P67, P68, are less
frequently indexed. Publications with mixed affilia- P69, P70, P71, P72,
P73, P74, tions, involving both academic and industry organizations,
Grey Literature Grey Literature G1, G2, G3, G4, G5, G6, G7, G8, 35.09
account for nine studies. This relatively small number in- G9, G10, G11,
G12, G13, G14, dicates that collaboration between academia and industry
G15, G16, G17, G18, G19, G20, remains limited, while also highlighting
an opportunity for G21, G22, G23, G24, G25, G26, stronger cross-sector
cooperation in future research. G27, G28, G29, G30, G31, G32, For grey
literature, organizational affiliations were ex- G33, G34, G35, G36,
G37, G38, amined to identify the sources through which non--peer- G39,
G40, reviewed contributions are shared. The selected studies are
associated with eleven distinct organizations. ArXiv emerges as the most
widely used publication platform, practitioners and developers in
documenting agent-based contributing 12 papers, while Medium hosts three
papers code generation techniques. Additionally, 12 studies are and
serves as an important channel for both independent research articles
hosted on arXiv. As shown in Figure 2c, the practitioners and
industry-affiliated technical experts. Sev- remaining sources include
five technical reports, along with eral major technology and AI-focused
organizations also one technical handbook, one newsletter, one social
media contribute to this body of work, including IBM, Microsoft, post,
and two video-based demonstrations. This distribution NVIDIA, and
Anthropic, each providing technical reports or research-oriented
insights. In addition, specialized platforms

Rasheed et al.: Preprint submitted to Elsevier Page 8 of 34  LLM-Based
Multi-Agent Systems for Code Generation

and companies such as LangChain, Unit42, and Marimo agent performance by
extending functional capabilities and provide practitioner-focused
resources, while community- reducing hallucinated outputs. driven
platforms such as freeCodeCamp and World of AI Furthermore, four studies
(3.5%) highlight autonomous further support knowledge sharing and
practical adoption. execution as a key reason, indicating that agents
can in- Together, these organizations represent a diverse ecosystem
dependently plan and execute tasks with minimal human supporting the
advancement of research and practice in intervention. Similarly, four
studies (3.5%) identify future- agent-based systems for code generation.
oriented development as a motivating factor, suggesting that future
software development will increasingly be shaped Takeaway 1. Research on
LLM-based agent sys- by integration, automation, and AI-driven
assistance, with tems for code generation received attention from some
sources viewing intelligent agents as a pathway toward academia in 2024
and from industry in 2025. Across Artificial General Intelligence (AGI).
Adaptability is high- all 114 studies, 57.02% are affiliated with
academia, lighted in two studies (1.8%) as a key reason for adopting
35.09% with industry, and 7.89% involve mixed aca- LLM-based agent
systems. demic--industry collaborations. Most peer-reviewed Overall, the
distribution of motivations indicates that studies appear in conference
venues, while the grey current research on LLM-based multi-agent systems
for code literature is largely industry-driven and mostly pub-
generation is primarily driven by performance improvement lished as
blogs. and the management of complex tasks through decomposi- tion. This
suggests that multi-agent architectures are mainly positioned as a
technical mechanism for enhancing accuracy, 3.2. Reasons (RQ2)
efficiency, and workflow coordination. In contrast, motiva- In this
study, 29 out of 114 studies (25.4%) highlight tions such as
adaptability, autonomous execution, and long- 36 reasons for utilizing
LLM-based agent systems for code term future-oriented development appear
less frequently, generation. Through thematic analysis, we categorized
the indicating that these aspects are still emerging rather than
findings of this RQ into nine main categories (see Table central to the
field. The pattern reflects a research land- 7). These categories are
operational efficiency and practical scape that prioritizes measurable
performance gains, while scalability, complex task handling, performance
enhance- broader considerations related to adaptability and sustained
ment, context management, external tool integration, team autonomy
receive comparatively limited empirical attention. collaboration,
autonomous execution, adaptability, and fu- ture trends. Takeaway 2. The
studies indicate that multi-agent Among the identified reasons,
performance enhance- systems are primarily chosen to enhance perfor-
ment is the most frequently reported category, highlighted mance, manage
complex tasks, and improve scala- by 12 out of 114 studies (10.5%),
indicating that multi-agent bility and efficiency, while also supporting
tool in- systems improve code quality, accuracy, and efficiency.
tegration, adaptability, and structured development. Handling complex
tasks is the second most frequently Overall, they address the
limitations of single-model reported reason, identified in nine studies
(7.9%). These approaches by improving coordination, reliability, studies
highlight that decomposing complex programming and the handling of
complex software workflows. problems into smaller, coordinated sub-tasks
enables agents to manage complex workflows more effectively. Seven stud-
ies (6.1%) report operational efficiency and practical scal- 3.3.
Benchmark and Model Distribution ability as a key reason for utilizing
agent-based systems. (RQ3-RQ4) This includes faster code development,
cost efficiency, par- In this study, we analyzed the benchmarks and
evalu- allel task processing, improved error handling, and enhanced
ation metrics employed by both academia and industry to practical
applicability. assess the performance of LLM-based agent systems for Six
studies (5.3%) identify team collaboration as a key code generation. In
our analysis, 52 out of 114 studies reason, showing that cooperation
among multiple agents in (45.61%) utilized benchmarks to evaluate the
agents' capa- decentralized settings can improve problem-solving quality
bilities in code generation tasks. We identified a total of 37 and
overall system performance. These studies further report benchmarks
across the 52 studies, which were adopted in that team collaboration
enables task specialization and coor- both peer-reviewed and grey
literature to evaluate different dination among agents, leading to more
efficient handling of aspects of agent-based generated code generation.
As shown complex software development activities. Context manage- in
Table 8, we have categorized these benchmarks into seven ment is
highlighted in three studies (2.6%), demonstrating main groups:
function-level code generation, repository- that agents can effectively
maintain and utilize contextual level benchmarks, programming contest
and multi-task eval- information across long and complex development
tasks. uation, agent-oriented benchmarks, security benchmarks,
Similarly, four studies (3.5%) highlight external tool inte-
domain-specific benchmarks, and evaluation metrics. We gration,
reporting that agents connected to various external also provide the
size of each benchmark dataset and its tools and services enhance their
overall capabilities. These primary language. Below, we describe each
category in studies indicate that integrating external tools improves
detail and discuss the papers in which they are applied.

Rasheed et al.: Preprint submitted to Elsevier Page 9 of 34  LLM-Based
Multi-Agent Systems for Code Generation

Table 7 Purpose of choosing an LLM-based multi-agent system for code
generation Category Open Coding Paper IDs Accelerate the
development-to-deployment pipeline G2 Computing-driven automation for
faster, quality software delivery P11 Parallel execution of sub-tasks to
reduce dependency and improve efficiency G4 Operational Efficiency and
Practical Scalability Cost-effective software generation using agent
frameworks P29, P43 Automatic error detection and self-debugging during
code generation P5 Structured, interactive, task-oriented environments
for agent execution P7 Collaborative multi-agent problem-solving for
complex tasks G3, P33, P43 Agents simulate iterative processes and
handle complex engineering tasks P3 Autonomous handling of
unpredictable, multi-step tasks G4 Complex Task Handling LLM-agents
effectively solve complex tasks P5 Autonomously operate, manage, and
scale for complex processes G30 Agents simulate iterative processes and
handle complex engineering tasks P3 Dynamic adaptation improves code
quality and efficiency for complex tasks P18 Performance scaling through
multi-agent coordination G4, P57, P70, P71 Improved code quality through
agent refinement and self-debugging P33, P58 Reduction of human effort
via autonomous agents G17 Performance Enhancement Enhanced user
experience through adaptive interaction G30 Autonomous agents improve
and mimic human workflows P54, G3, P33 Agents are prominent in complex
software development G16 Automatic management of long-term context and
memory G2 Context Management Scaling token usage and parallel reasoning
via separate contexts G4 Agents maintain context across long, complex
interactions G3 Integration with external tools and systems (APIs,
databases, web services) G2, G3 External Tool Integration Agents connect
to external tools which enhance performance G3 Human--agent and
agent--agent collaboration for task distribution P53 Collaborative
multi-agent autonomy for complex software management P10, P14, P47 Team
Collaboration Improve collaboration through intuitive, need-aware
outputs G30 Autonomous agents collaboratively solve problems in
decentralized settings P21 Autonomous planning and execution of
multi-step tasks G3 Autonomous Execution Agents autonomously plan and
adapt multi-step tasks G22, G28 Autonomous task handling through
agent-driven decomposition P53 Role-specific agents enabling
adaptability and collective intelligence P18 Adaptability LLM-powered
agents generalize and adoptable across diverse tasks P50 LLM-based
agents as a pathway toward AGI G19, P55 Future Trends Gain research
attention due to their capability of handling complex tasks P47 Future
software development will be shaped by AI-agent driven assistance P10

    Function-level code generation benchmarks are the                         increases evaluation difficulty by introducing more chal-

most widely used category, highlighting the strong focus on lenging test
cases and execution conditions. HumanEval- evaluating functional
correctness at the level of individual Fix focuses on program repair and
contains 164 bug-fixing programming tasks. As shown in Table 8, this
category tasks derived from the original HumanEval problems. Hu-
includes 14 benchmarks, namely HumanEval \[22\], MBPP manEval+ expands
the benchmark by generating multiple \[23\], HumanEval-X \[24\],
HumanEval-ET \[25\], HumanEval- harder variants for each original task,
resulting in 164 × 80 Fix \[26\], HumanEval+ \[27\], xCodeEval \[28\],
MBPP-ET more challenging problem instances. \[29\], MBXP \[30\], PSB2
\[31\], ODEX \[32\], JuICe \[33\], Similarly, MBPP is another widely
adopted benchmark, MultiPL-E \[34\], and EvalPlus \[27\]. Among these,
Hu- used in 18 studies, due to its diverse collection of Python manEval
is the most frequently adopted benchmark. As programming problems and
its ease of integration into evalu- illustrated in Table 8, 29 selected
studies employed the ation pipelines. The MBPP benchmark contains 974
Python HumanEval benchmark to assess the accuracy of agent- programming
tasks. Its extended variants are also used to based systems, making it
the most widely used benchmark evaluate agent-based systems: MBPP-ET,
adopted by five in the literature. HumanEval was one of the earliest
bench- studies, retains the same number of tasks but introduces marks
specifically designed for evaluating AI-based code more complex
evaluation settings, while MBXP, used in two generation and measures
functional correctness using unit studies, extends MBPP to support
cross-language evaluation tests \[22\]. As shown in Table 8, the
HumanEval benchmark and contains over 1,000 programming tasks. consists
of 164 Python programming tasks. Its extended The remaining five
benchmarks: PSB2, ODEX, JuICe, variants, HumanEval-X and HumanEval-ET,
were used in MultiPL-E, and EvalPlus, were each utilized in one study.
two and four papers, respectively. HumanEval-X extends PSB2, introduced
in 2021, consists of 100 programming the original benchmark to multiple
programming languages, tasks designed to evaluate basic problem-solving
capabil- including Python, Java, C++, JavaScript, and Go, while ities.
ODEX contains 945 programming tasks focused on retaining the same set of
164 tasks. HumanEval-ET further diverse code generation scenarios. JuICe
includes approx- imately 1,200 programming problems aimed at evaluating

Rasheed et al.: Preprint submitted to Elsevier Page 10 of 34  LLM-Based
Multi-Agent Systems for Code Generation

instruction-following and reasoning abilities. MultiPL-E ex- Python,
C++, and Java, and focuses on evaluating algorith- tends HumanEval to a
multilingual setting and includes mic reasoning and correctness under
strict execution con- 164 tasks across languages such as Python, Java,
C++, straints. Its evaluation split, CodeContests-Test, was utilized
JavaScript, and Go. Finally, EvalPlus is an enhanced eval- by one study
and serves as a held-out test set for unbiased uation benchmark that
extends both HumanEval and MBPP assessment, containing the same 165
problems with unseen by introducing stronger and more detail test cases.
test cases across the same set of programming languages.
Repository-level benchmarks capture evaluations that Similarly,
LiveCodeBench and VsplotBench were utilized move beyond isolated
function synthesis and instead focus by two studies each to assess
agent-based code generation on on large codebases and practical
development tasks. These dynamic, task-oriented benchmarks that
highlight real-time benchmarks are designed to assess an agent's ability
to evaluation and performance across diverse programming understand,
modify, debug, and repair real-world software tasks. repositories.
Commonly used benchmarks in this category The remaining benchmarks:
CoNaLa, Galeras, and include SWE-Bench \[35\], SWE-Bench Lite \[35\],
and SWE- MathQA, were each used by one study. The CoNaLa bench- Bench
Secret \[36\], and CrossCodeEval \[37\]. In our review, mark consists of
2,879 natural language--to--code pairs, fo- SWE-Bench was employed by
six studies to evaluate agent- cusing on Python code generation from
concise textual de- based code generation and repair systems. SWE-Bench
is scriptions. Galeras is a multi-task programming benchmark a
repository-level benchmark constructed from real-world designed to
evaluate general-purpose code reasoning and GitHub issues and pull
requests, primarily focusing on synthesis, containing over 1,000
algorithmic programming Python-based repositories. It contains 2,294
real-world soft- tasks, primarily in Python. Finally, MathQA includes
29,837 ware issues, each paired with test cases that validate whether
math word problems that require symbolic reasoning and the generated
patch correctly resolves the issue. programmatic solution generation,
typically evaluated using A lighter variant, SWE-Bench Lite, was adopted
by Python-based programs. four studies. This benchmark consists of a
subset of 300 Agent-oriented and multi-agent benchmarks are de- issues
selected from SWE-Bench and is designed to reduce signed to explicitly
evaluate autonomous and collaborative evaluation cost while preserving
task diversity and difficulty. agent behavior beyond isolated code
generation accuracy. SWE-Bench Secret, which was utilized by one study,
is These benchmarks assess higher-level agent capabilities primarily
used for unbiased evaluation and leaderboard- such as tool usage,
planning, coordination, reasoning over based assessment and focuses on
Python repository repair long horizons, and interaction with
environments, which are tasks. CrossCodeEval benchmark, used in one
study, eval- central to agent-based SE systems. Representative bench-
uates cross-distribution performance by testing models on marks in this
category include MLAgentBench \[43\], Agent- code tasks that differ from
their training distributions and Bench \[44\], CodeAgentBench \[45\],
CodeRAG-Bench \[46\], includes over 1,000 programming problems across
multiple and AgentDojo \[47\]. In our review, MLAgentBench was
programming languages. used in three studies to evaluate agents on
machine learn- Programming contest and multi-task benchmarks are
ing--oriented code generation and experimentation tasks. widely used to
evaluate the problem-solving, reasoning, MLAgentBench focuses on
end-to-end ML workflows, in- and code synthesis capabilities of
LLM-based agents un- cluding data preprocessing, model training,
evaluation, and der diverse and often complex constraints. As shown in
debugging. The benchmark consists of a collection of real- Table 8, this
category includes APPS \[38\], CodeContests world machine learning tasks
rather than isolated program- \[39\], CodeContests-Test \[39\],
LiveCodeBench \[40\], Vsplot- ming problems and is specifically designed
for Python-based Bench, CoNaLa \[41\], Galeras \[42\], and MathQA
\[30\], all of machine learning environments. which consist of
multi-task programming or reasoning prob- AgentBench, utilized by two
studies, contains 45 tasks lems designed to reflect competitive or
real-world problem- covering eight task categories, including tool
usage, reason- solving scenarios. ing, coding, data analysis, and web
interaction. AgentBench Among the benchmarks, APPS is the most
frequently supports multi-step decision-making and evaluates both task
used benchmark, appearing in six studies. APPS was intro- success and
intermediate agent behaviors, making it suitable duced in 2022 and
contains 10,000 programming problems for assessing general agent
competence beyond code correct- collected from competitive programming
platforms. This ness. CodeAgentBench was utilized by three studies to
eval- benchmark is primarily evaluated using Python, making it uate
agent-based code generation systems operating in struc- suitable for
assessing code generation performance across tured development
workflows. This benchmark focuses on both simple and complex problems.
multi-step coding tasks, such as planning, implementation, The
CodeContests benchmark was used in two stud- debugging, and refinement,
primarily in Python. Finally, ies to evaluate agent-based code
generation in competitive CodeRAG-Bench and AgentDojo were each employed
by programming settings. Developed by DeepMind, CodeCon- one study.
CodeRAG-Bench evaluates agent performance in tests contains 165
programming problems, each paired with retrieval-augmented code
generation scenarios, measuring extensive test cases and reference
solutions. The bench- how effectively agents retrieve, integrate, and
reason over mark supports multiple programming languages, including
external knowledge sources during code synthesis. Agent- Dojo is an
interactive agent benchmark consisting of nearly

Rasheed et al.: Preprint submitted to Elsevier Page 11 of 34  LLM-Based
Multi-Agent Systems for Code Generation

Table 8 Benchmarks used to test the agent based system generated code,
including dataset sizes, language coverage, and study frequency SNo
Category Benchmark / Metric Approx. Dataset Size Primary Language(s) \#
Papers Paper IDs Function-level Code Generation Benchmarks 1 HumanEval
\[22\] 164 problems Python 29 P1, P2, P7, P10 P19, P20, P23, P24 P25,
P31, P36, P38, P40 P48, P50, P54, P57, P59 P60, P62, P66, P67, P68 P73,
G1, G12, G16, G29 G38 Function-level code generation 2 MBPP \[23\] 974
problems Python 18 P1, P10, P19 P20, P25, P36, P38, P40 P54, P59, P60,
P62, P66 P68, P73, G12, G29, G38 3 HumanEval-X \[24\] 164 problems ×
multiple Python, Java, C++, Go, 2 P6, P36 languages JavaScript 4
HumanEval-ET 164 problems (extended Python 3 P6, P36, G12 tests) 5
MBPP-ET \[29\] 974 problems (extended Python 5 P10, P19, P40, P66, G12
tests) 6 MBXP \[30\] ∼1,000 problems Python + 10 other languages 2 P8 7
PSB2 \[31\] 25 problems Python 1 P6 8 ODEX \[32\] 945 problems Python 1
P8 9 JuICe \[33\] 3.7K instances Python 1 P8 10 MultiPL-E \[34\] unknown
problems × mul- 18 languages (Python, Java, 1 P8 tiple languages C++,
JavaScript, Go, etc.) 11 EvalPlus \[27\] Extension of HumanEval Python 1
P8 and MBPP 12 HumanEvalFix \[26\] 164 bug-fix tasks Python 2 P45, P49
13 HumanEval+ \[27\] 164×80 problems (harder Python 1 P45 tests) 14
xCodeEval \[28\] 7.5K unique problems 11 languages 1 P25
Repository-level and real-world software engineering benchmarks 15
SWE-Bench \[35\] 2,294 real-world issues Python 6 P2, P8, P12, P45, P55
Repository-level benchmarks P67 16 SWE-Bench Lite \[35\] 300 issues
Python 4 P2, P55, P68, P72 17 SWE-Bench Secret \[36\] Not publicly
disclosed Python 1 P68 18 CrossCodeEval \[37\] 1,200 problems Python 1
P8 Programming contest and multi-task benchmarks 19 APPS \[38\] 10,000
problems Python 6 P10, P19, P25, P60, P67 P73 20 CodeContests \[39\]
13,000 problems Mixed 2 P25, P73 21 Multi-task benchmarks LiveCodeBench
\[40\] Task-based (variable size) Mixed 2 P8, G29 22 VsplotBench
Task-based (variable size) Mixed 2 P8, G40 23 CoNaLa \[41\] 2,379
training + 500 test Python 1 P67 24 Galeras \[42\] unknown problems
Python 1 P67 25 MathQA \[30\] unknown problems 0 programming languages 1
P8 Agent-oriented and multi-agent benchmarks 26 MLAgentBench \[43\]
Task-based (no fixed size) Python 3 P3, P41, P52 27 AgentBench \[44\]
Scenario-based Mixed 2 P3, P49 28 Multi-agent evaluation CodeAgent Bench
\[45\] Task-based Python 2 P23 29 CodeRAG-Bench \[46\] Task-based Python
1 P12 30 AgentDojo \[47\] Scenario-based Mixed 1 P58 Security evaluation
benchmarks 31 RedCode \[48\] 500 problems Python 1 P8 32 Security
benchmarks LLMSecEval \[49\] Task-based Python 1 P20 Domain-specific
benchmarks 33 VerilogEval \[50\] 156 problems Verilog 1 P9
Domain-specific evaluation 34 VerilogEval-Human v2 \[51\] 156 problems
(new task Verilog 2 P44, P51 formats) Other benchmarks 35 CoderEval
\[52\] ∼256 tasks Python, Java 1 P10 36 Other evaluation benchmarks
CoverBench -- -- 1 P31 37 DA-Code \[53\] 500 complex tasks Mixed 1 P74
Metrics (not benchmarks 38 Pass@k Metric (no dataset) -- 1 P2, P3, P7,
P10, P20 39 Logical error rate Metric -- 1 P20 40 Metrics (not
benchmarks) Code quality score Metric -- 1 P20 41 Vulnerable@k Metric --
1 P20 42 Secure@k Metric -- 1 P20

100 tool-based tasks, designed to assess agent safety, tool In our
review, RedCode and LLMSecEval were each control, and robustness in
realistic execution environments. used in one study to evaluate
security-aware code genera- Security benchmarks focus on evaluating
security is- tion. RedCode focuses on detecting and repairing security
sues such as code vulnerabilities and safety risks. Unlike
vulnerabilities in generated code and contains hundreds of general code
generation benchmarks, these benchmarks as- vulnerability-focused
programming tasks, primarily target- sess whether agents can produce
secure code, avoid vul- ing Python and C/C++. The LLMSecEval benchmark
is de- nerabilities, and handle malicious inputs. Representative signed
to evaluate LLM behavior under malicious or unsafe benchmarks in this
category include RedCode \[48\] and code generation scenarios, including
prompt injection, in- LLMSecEval \[49\]. secure API usage, and
vulnerability propagation. It consists of a set of security-sensitive
coding tasks and evaluates both

Rasheed et al.: Preprint submitted to Elsevier Page 12 of 34  LLM-Based
Multi-Agent Systems for Code Generation

Table 9 Frequency of LLM usage for multi-agent system development Model
Company Source Papers Paper IDs GPT-3.5 (incl. Turbo, davinci) 15 P1,
P6, P10, P23, P31, P33, P36, P48, P55, P60, P65, P21, P40, P30, G12
GPT-4 (incl. Turbo) OpenAI 17 P1, P3, P9, P10, P23, P30, P31, P38, P40,
P48, P55, P60, P65, P40, P21, P5, G16 Closed-Source GPT-4o 9 P5, P9,
P19, P22, P26, P60, G2, G18, G38 GPT-4o-mimi 1 P8, G2 GPT-4.1 1 G40
Claude (all versions) Anthropic 9 P8, P23, P31, P55, P60, G4, G38, G39,
G40 Gemini / Gemini-Pro Google 3 P3, P22, G38 Grok 3 xAI 2 G38, G39
Llama 2 (7B, 13B, 70B) 6 P23, P33, P55, P60, G29, P21 Llama 3 / 3.1 (8B,
70B, 405B) Meta 7 P1, P6, P9, P33, P48, G29, P55 CodeLlama 4 P3, P9,
P60, P21 Mixtral 2 P3, P9 Mistral AI Mistral Large 1 P1, P9 Open-Source
DeepSeek Coder DeepSeek 2 P9, P60 CodeT5 Salesforce 1 P1, P8 CodeGemma
7B Google 1 P9 Qwen 2.5-32B Alibaba 1 G29 SWE-Llama (7B, 13B) Meta 1 P55

functional correctness and security compliance, primarily in soundness,
and the maintainability of generated code. To Python. evaluate
security-related properties, Vulnerable@k and Se- Domain-specific
benchmarks are designed to evalu- cure@k quantify the probability of
generating vulnerable or ate agent-based code generation systems within
specialized secure code, respectively. Together, these metrics provide a
application domains, where correctness and reliability de- quantitative
and fine-grained evaluation of agent-based code pend on domain knowledge
and strict syntactic or semantic generation performance beyond
benchmark-level results. constraints. In this category, the reviewed
studies primarily Overall, the distribution of benchmarks shows a strong
employ VerilogEval \[50\] and VerilogEval-Human v2 \[51\], concentration
on function-level evaluation, particularly Hu- which focus on hardware
description language (HDL) code manEval and MBPP, which are the most
frequently used generation. benchmarks in the literature. This suggests
that most stud- VerilogEval, used in one study, evaluates the ability of
ies focus on the functional correctness of isolated coding LLM-based
agents to generate syntactically and functionally tasks as the main
measure of agent performance. In con- correct Verilog code for hardware
design tasks. It consists of trast, repository-level, agent-oriented,
security, and domain- hundreds of Verilog programming problems that
assess logic specific benchmarks are used less frequently, indicating
that correctness, signal dependencies, and module-level behav-
large-scale integration, long-horizon reasoning, and real- ior.
VerilogEval-Human v2, adopted by two studies, extends world reliability
receive comparatively less attention. Al- VerilogEval by incorporating
human-annotated problem de- though recent agent-oriented benchmarks
attempt to eval- scriptions and more challenging design tasks, providing
a uate planning, tool use, and collaborative behaviors, their more
realistic evaluation of agent performance in hardware- limited use
suggests that evaluation practices have not fully oriented code
generation. adapted to the increasing architectural complexity of multi-
agent systems. Furthermore, the reliance on pass@k as the 3.3.1. Metrics
primary metric reinforces a focus on correctness-based eval- In addition
to benchmarks, we identified five evaluation uation. Overall, these
patterns indicate that benchmarking metrics used in existing studies to
quantitatively measure the practices in the field remain centered on
controlled and mea- accuracy and quality of code generated by LLM-based
agent surable correctness, with slower progress toward evaluating
systems. As summarized in Table 8, the pass@k metric was broader
real-world SE capabilities. utilized in five studies, while the other
four metrics were each employed in one study. For code generation
specific evaluation, the Pass@k metric measures the probability that at
least one correct solution will appear among the top-k generated
outputs. Ad- ditional metrics, including logical error rate and code
quality score, are used to assess semantic correctness, structural

Rasheed et al.: Preprint submitted to Elsevier Page 13 of 34  LLM-Based
Multi-Agent Systems for Code Generation

Takeaway 3. Our review identifies 37 evaluation Takeaway 4. We identify
usage of 83 LLMs across benchmarks used across 52 studies. HumanEval is
the studies, with a clear preference for closed- the most frequently
adopted benchmark (29 studies), source models (57 uses) over open-source
models followed by MBPP, indicating a strong reliance on (26 uses) in
agent-based code generation. The Ope- unit-test--based evaluation of
functional correctness. nAI GPT series dominates model usage, indicating
The benchmarks are grouped into seven categories its widespread adoption
for executing LLM-based reflecting differences in task scope and
evaluation agents. Among open-source alternatives, Meta's settings.
Additionally, five commonly used evalua- Llama family is the most
commonly adopted, reflect- tion metrics are reported, including pass@k
and its ing growing interest in customizable and self-hosted variants,
which primarily measure functional cor- agent architectures. rectness
and code accuracy. 3.4. Challenges and Solutions (RQ5-RQ6) 3.3.2.
Identified Models This section presents the identified challenges and
their In this research, we analyzed the LLMs used in selected
corresponding solutions derived from the analysis of the re- academic
and industrial studies for implementing agent- viewed literature. Based
on the review, we identified 12 key based systems. As shown in Table 9,
we identified 83 in- categories of challenges and their proposed
solutions, which stances of LLM usage across the selected studies, as
several are summarized in Table 10. More detailed descriptions of
studies employed more than one model in their experiments. the
challenges and their proposed solutions can be found in Of these
instances, 57 correspond to closed-source models, the replication
package \[13\]. while 26 correspond to open-source models. As shown in
Table 9, the analysis indicates a clear pref- 3.4.1. Correctness and
Reliability Challenges erence for closed-source models, particularly
those provided In this category, we report challenges affecting the cor-
by OpenAI, which are the most frequently used in agent- rectness and
reliability of agent-based systems for code based code generation
research. Specifically, OpenAI mod- generation. In total, 26 out of 114
studies (22.81%) report els from the GPT series were utilized 43 times,
reflecting correctness and reliability challenges in agent-based systems
their widespread adoption due to their strong reasoning for code
generation. The leading challenges include halluci- capabilities, mature
APIs, and extensive support for tool nations (10 studies, 8.77%), low
accuracy (7 studies, 6.14%), integration and agent orchestration.
orchestration failure (5 studies, 4.39%), lack of high-level Among
open-source models, Meta's Llama is the most planning (4 studies,
3.51%), agent dependency (3 studies, commonly adopted, with 17 instances
of usage across dif- 2.63%), code inconsistency (2 studies, 1.75%), and
legacy ferent versions, including Llama 2 and Llama 3. These code
challenges (1 study, 0.88%). models are particularly favored in research
that prioritizes To address hallucination challenges, solutions include
open-source ecosystems, self-hosted agent architectures, integrating
iterative human feedback into the agent execution and greater control
over deployment and customization. loop, incorporating feedback control
mechanisms inspired Other open-source models include Mixtral, used three
times, by back-pressure principles, embedding systematic error- DeepSeek
and Grok-3, each used in two studies, and Qwen checking mechanisms into
agent workflows, and integrating 2.5-32B, used in one study. Overall,
this distribution reflects automated verification tools to detect
syntactic and structural a diverse but less concentrated usage landscape
compared to issues in generated code (2 studies, 1.75%). To improve
closed-source alternatives. the accuracy of an agent-based system,
iterative refinement Overall, the results show a clear reliance on
closed- and feedback-driven mechanisms are proposed to improve source
models, particularly OpenAI's GPT series, in agent- accuracy by enabling
agents to correct and enhance outputs based code generation research.
While these models are over multiple steps, while Reinforcement Learning
(RL)- often selected for their strong performance, stable APIs, based
approaches further improve reliability by decoupling and advanced
reasoning capabilities, their use may raise reasoning from tool
execution, and optimizing planning and concerns related to data privacy,
security, and dependency decision-making (4 studies, 3.51%). on
proprietary platforms. In contrast, open-source models To mitigate agent
orchestration failure, structured com- are used less frequently and in a
more distributed manner, munication protocols are introduced to replace
unrestricted suggesting that reproducible and self-hosted agent ecosys-
natural language exchanges with well-defined, machine- tems are still
emerging. While open-source models may readable message formats,
reducing coordination errors in not consistently match the performance
levels reported for multi-agent systems (2 studies, 1.75%). Schema-based
com- leading closed-source models, they offer advantages in terms
munication protocols built on standardized interfaces further of
deployment control, cost efficiency, and improved data improve
coordination reliability (2 studies, 1.75%), while privacy. dynamic
communication structures and the assignment of explicit responsibility
for components such as files, services, or processes help prevent
conflicts and non-terminating in- teractions (1 study, 0.88%).

Rasheed et al.: Preprint submitted to Elsevier Page 14 of 34  LLM-Based
Multi-Agent Systems for Code Generation

Table 10 Identified challenges and their proposed solutions for
LLM-based multi-agent systems for code generation Category Challenge
Subcategory Study ID (Challenge) Solution Study ID (Solution)
Schema-based communication protocols P50, G21 Agent Orchestration
Failure P54, P55, P29, G38, G2 Structured communication protocols P50,
G21 Dynamic communication structures P50 P6, P11, P18, P29, Integrating
systematic error checking mechanism P24 Hallucination Challenge P38,
P41, P47, P65, Integrating feedback control mechanisms P13 Correctness
and Reliability G8, G30 Integrating automated verification tools P13
Code Inconsistency P2, P20 Adopting hybrid approach P56, P20 Challenges
with Agents Monitoring mechanisms G10 Dependency Challenge G8, G10, G30
Validation layers G30 P12, P20, P18, P19, Integrating RL into agents G35
Low Accuracy P40, G39, G35 Iterative feedback driven mechanisms P57,
P19, P40 Legacy Code G19 Code modernization G19 Lack of High-Level
Planning P1, P65, P72, P48 Proposed hierarchical planning approach P48
Isolated environment P58, P49, G10 Code Vulnerabilities P31, P58, G32
Control testing G10, P58 Security and Monitoring mechanisms G36 Code
Attacks G32, G36, P37 External tool integration G36 Privacy Risk
Open-source model control G13 Data Leakage G11, G13, G32 Data loss
prevention (DLP) mechanisms G32 Privacy P58, G2, G9, G10 Security
benchmarks P58 P8, P12, P18, P38, Computational Cost G2, G5, G15, G39,
G27 Utilizing small language models G23 Computational and Lightweight
agents P40 Resource Constraints Maintenance Overhead G29, G10 Model
simplification G23 Communication Overhead G20, G30, G31, P40
Orchestration mechanisms P37, G9 G5, G8, G15, P24, Context and Memory
Limited Context Window P27, P42, P12, P65 External environment memory
P23, P59 Limitations Short-Term Memory G6, P37, P64 Explicit memory
mechanisms G6, P37 P17, P62, P70, P12, Limited Real-World Evaluation
P53, P23 Repository Level Evaluation P17, P70 Benchmark Challenges
Limited Language Scope P12 Cross-Lingual Benchmark P17 Security Risk
P12, P68 Secure Benchmark P58, P17 No Human Intervention P7 Hybrid
verification approach P65 Non-Deterministic Behavior G7, G9 Iterative
verification cycle P57, P65 Verification Challenges Limited
Self-Reflection P54, P72 Symbolic reasoning P11, P65 Lack of Task
Validation P6, P65, P69, P72, G21 Integrating traditional tools into AI
for validation P65 Prompt Sensitivity P29, P6, P47, G8 Agents'
multi-step reasoning P42 Prompt Design Challenges Prompt Dependency P19
Automatic prompt generation P29 Developer Prompt Interpretation
Challenge P16 Human involvement in agent discussion P29

    To address the challenge of a lack of high-level plan-                                 strengthening architectural governance, inter-agent account-

ning, collaborative frameworks and hierarchical planning ability, and
validation-aware design. approaches support high-level reasoning,
improve task de- composition, and reduce error propagation in complex
work- 3.4.2. Security and Privacy Risk flows (2 studies, 1.75%). Code
inconsistency is mitigated In this category, we report the security
risks that threaten through hybrid approaches that combine LLMs with en-
the confidentiality, integrity, and safe execution of code gineered
system components and traditional non-AI tech- produced or executed by
agent-based systems. In total, 11 niques, introducing dedicated agents
to reason over code im- out of 114 studies (9.65%) report
security-related challenges plementations and detect inconsistencies
between intended in agent-based code generation. The leading challenges
are behavior and actual code (2 studies, 1.75%). To address the privacy
risks (4 studies, 3.51%), followed by code vulnera- agent dependency
challenge, agent monitoring mechanisms bilities (3 studies, 2.63%), code
attacks (3 studies, 2.63%), are employed as a practical solution (1
study, 0.88%). In and data leakage (3 studies, 2.63%). To mitigate these
chal- addition, incorporating validation layers, fallback strategies,
lenges, the most commonly reported solutions include iso- and interface
checks is suggested to manage updates, dep- lated execution environments
(3 studies, 2.63%), monitoring recations, and breaking changes in APIs,
libraries, and ex- mechanisms across configuration files and generated
code (1 ecution frameworks, thereby improving system reliability
studies, 0.88%), and data protection measures such as DLP, against tool
changes and failures (1 study, 0.88%). Finally, audit logging, and
secret/credential management (1 studies, legacy code challenges are
mitigated through intelligent 0.88%). Other proposed solutions include
deploying agents maintenance solutions that assist in modernizing
codebases locally using open-source models to reduce data exposure (1
and recommending updates to libraries and dependencies, studies, 0.88%),
integrating external security tools to detect ensuring alignment with
contemporary software develop- suspicious patterns, and using
security-focused benchmarks ment standards (1 study, 0.88%). and
operational safeguards to evaluate and constrain risky Overall, the
reported challenges reveal that correctness agent behaviors in
controlled settings (2 studies, 1.75%). In and reliability issues in
agent-based systems are not iso- summary, the evidence indicates that
security risks are a lated model failures but systemic weaknesses
emerging from recurring barrier to real-world deployment, and the
reported the interaction between reasoning, coordination, and execu-
solutions primarily emphasize containment, monitoring, and tion layers.
The existing studies recommend that improving controlled evaluation
rather than complete prevention. reliability in agent-based systems for
code generation re- quires moving beyond scaling model capability and
instead

Rasheed et al.: Preprint submitted to Elsevier Page 15 of 34  LLM-Based
Multi-Agent Systems for Code Generation

3.4.3. Computational and Resource Constraints code generation. In this
study, seven out of 114 stud- This category reports resource allocation
challenges that ies (6.14%) highlight challenges associated with
existing limit the ability of agent-based systems to efficiently manage
benchmarks. These challenges include limited real-world computational
resources during code generation tasks. A evaluation benchmarks (6
studies, 5.26%), limited language total of 15 out of 114 studies
(13.16%) highlight challenges scope (1 study, 0.88%), and benchmark
security issues related to high resource allocation in multi-agent
systems. (2 studies, 1.75%). To mitigate challenges with existing The
leading challenges include computational cost (9 stud- benchmarks,
SWE-bench \[35\], LiveCodeBench \[40\], and ies, 7.89%), communication
overhead (4 studies, 3.51%), CoderEval \[52\] are proposed as steps
toward repository- and maintenance overhead (2 studies, 1.75%). To
mitigate level, real-world, and context-aware evaluation frameworks,
these challenges, Small Language Models (SLMs) are sug- enabling
evaluation in more realistic software development gested for agent
development and execution in code and scenarios (2 studies, 1.75%). In
addition, benchmarks such software development tasks to reduce
computational costs (1 as HumanEval-X \[24\], MBXP \[30\], MultiPL-T
\[34\], and study, 0.88%). Furthermore, optimized orchestration mech-
xCodeEval \[28\] extend traditional code generation tasks be- anisms are
proposed to manage task dependencies, agent yond a single programming
language, enabling cross-lingual interactions, and monitoring and
control processes in order and multilingual evaluation of model
performance (1 study, to reduce communication overhead (2 studies,
1.75%). In 0.88%). To further address security-related challenges in
addition, a lightweight multi-agent framework is proposed existing
benchmarks, REDCODE \[48\] is proposed to assess for complex workflows
or code generation, enabling targeted the ability of models to recognize
and handle unsafe code feedback and local test validation, thereby
reducing token by providing high-quality, safety-oriented scenarios and
test usage and avoiding unnecessary LLM calls during software cases (2
studies, 1.75%). development workflows (1 study, 0.88%). These findings
indicate that existing benchmarks remain Overall, the reported
challenges suggest that resource insufficient for comprehensively
evaluating agent-based sys- allocation limitations in agent-based
systems are not only tems. The reported solutions highlight ongoing
efforts to- a matter of computational expense, but reflect architec-
ward more realistic, multilingual, and safety-aware bench- tural
inefficiencies in coordination, communication, and task mark designs to
better reflect practical code generation sce- management. The findings
highlight that sustainable agent- narios. However, there remains a need
for benchmarks and based code generation depends on balancing capability
with evaluation metrics that more comprehensively capture the
computational efficiency through structured orchestration, complexity,
variability, and dynamic nature of real-world modular design, and
resource-aware execution mechanisms. software development workflows.

3.4.4. Context and Memory Limitations 3.4.6. Verification Challenges In
this category, we report memory-related challenges In this category, we
report agent verification challenges, that limit the ability of
LLM-based agent systems to main- where limitations in verification
mechanisms prevent the tain, retrieve, and utilize information across
multi-step code reliable validation of agent-generated code and agent
inter- generation workflows. In total, 11 out of 114 studies (9.65%)
actions. In total, nine out of 114 studies (7.89%) report chal- report
memory challenges in LLM-based agent systems for lenges related to
agent-based code verification and propose code generation and propose
corresponding solutions. The corresponding solutions. The reported
challenges include reported challenges include limited context windows
(8 stud- non-deterministic or inconsistent agent behavior (2 studies,
ies, 7.02%) and short-term memory limitations (3 studies, 1.75%), lack
of human intervention (1 study, 0.88%), limited 2.63%). To mitigate
these challenges, the reported solutions ability of agents to
self-reflect (2 studies, 1.75%), and lack primarily focus on extending
and supporting agent mem- of task validation (5 studies, 4.39%). To
address these chal- ory. External memory environments are used to store
and lenges, symbolic reasoning tools are integrated into agents retrieve
information beyond the model's internal context (2 to validate logical
assumptions in generated code (2 studies, studies, 1.75%). Additionally,
explicit memory mechanisms 1.75%). In addition, a hybrid approach that
combines agents are integrated to allow agents to store, reflect on, and
reuse with traditional software analysis techniques is proposed to
previously generated information during task execution (2 automatically
detect code defects and logic inconsistencies studies, 1.75%). Overall,
the findings indicate that mem- (1 study, 0.88%). Furthermore, a
self-adaptive multi-agent ory limitations remain a fundamental
bottleneck for agent- framework is proposed to iteratively refine agent
behaviors based systems in large and complex code generation tasks. and
interactions through testing and feedback-driven model The reported
solutions suggest that augmenting agents with updates, progressively
improving code quality (1 study, external and explicit memory mechanisms
is important for 0.88%). supporting scalability and information reuse
across multi- The findings highlight that improving the agent verifi-
step workflows. cation process by implementing hybrid verification
mecha- nisms, enhanced self-reflection, and feedback-driven adap- 3.4.5.
Benchmark Challenges tation is important to enhance agent reliability
and code In this category, we report challenges related to the quality.
evaluation and benchmarking of agent-based systems for

Rasheed et al.: Preprint submitted to Elsevier Page 16 of 34  LLM-Based
Multi-Agent Systems for Code Generation

3.4.7. Prompt Engineering Challenges Scalability is highlighted as a key
future direction, with Prompt engineering is an important aspect of LLM-
studies highlighting the need for scalable and token-efficient based
agents, as it directly influences how agents interpret agent execution
to support large and complex codebases. instructions and generate code.
In total, six out of 114 studies This points toward future work
exploring approaches such (5.26%) report prompt engineering challenges,
including as partial code representations, incremental updates, and
prompt sensitivity (4 studies, 3.51%), prompt dependency (1 selective
context retrieval to reduce token consumption and study, 0.88%), and
developer prompt interpretation (1 study, computational overhead (4
studies, 3.51%). In addition, 0.88%). To mitigate these challenges,
prompt strategies are adaptive scalability mechanisms that dynamically
adjust the proposed to enhance agents' multi-step reasoning, enabling
number of agents, memory usage, and coordination strate- better
interpretation of instructions and reducing errors in gies based on task
complexity and available resources are complex code generation tasks (1
study, 0.88%). In addition, identified as important directions for
further investigation (4 incorporating human involvement into agent
discussions studies, 3.51%). Agent orchestration is identified as an im-
during the code generation process is suggested to improve portant
future direction, focusing on structuring agent inter- understanding,
guide decision-making, and reduce errors (1 actions through hierarchical
coordination, summarization, study, 0.88%). and memory compression to
enable efficient collaboration In summary, the findings indicate that
prompt engi- while limiting excessive context usage (4 studies, 3.51%).
In neering challenges affect agent reliability and correctness,
addition, future work indicates the need for improving agent
particularly in complex code generation tasks. The proposed
communication through intelligent and adaptive orchestra- solutions take
a step forward toward improving instruction tion mechanisms to reduce
redundant interactions and un- interpretation and reducing errors, but
remain limited in necessary exchanges while preserving code generation
qual- scope and generalizability. ity, including adaptive communication
control where agents selectively decide when and what to communicate
based on Takeaway 5. The reviewed studies highlight seven task context,
roles, and shared state (3 studies, 2.63%). major challenges in
agent-based systems for code Edge deployment is identified as an
emerging fu- generation, which present significant barriers to real-
ture direction, with studies suggesting the exploration of world
deployment. The reported solutions highlight lightweight and
resource-efficient agent execution to sup- a range of mitigation
strategies, including real-time port operation in constrained or
low-connectivity environ- agent monitoring mechanisms, the use of
sandboxed ments, while potentially improving privacy, latency, and
environments, adoption of local and small language accessibility (1
study, 0.88%). Parallel processing repre- models, integration of data
protection measures such sents an important area for further
investigation, as enabling as DLP, optimized orchestration mechanisms,
and the simultaneous execution of multiple models and tools techniques
to improve accuracy and reliability. To- within structured execution
flows can improve efficiency, gether, these solutions reflect ongoing
efforts to make controllability, and reliability, while challenges
related to agent-based code generation systems more practical
coordination and synchronization remain to be addressed (1 and
deployable in real-world settings. study, 0.88%). In addition, the
fine-tuning and optimization of multi-agent systems require further
research to support dynamic agent generation, workflow tuning, and
iterative 3.5. Future Research Directions (RQ7) learning with human
oversight and feedback, enabling a This section presents the identified
future work for LLM- better balance between performance, computational
cost, based multi-agent systems for code generation, derived from and
latency (5 studies, 4.43%). Runtime stability remains the analysis of
the selected studies. Based on the review, we a critical issue, with
future work needed to develop more identified six main categories of
future research directions, reliable and sandbox-agnostic communication
and execution which are summarized in Table 11. More detailed descrip-
monitoring mechanisms between agent controllers and exe- tions can be
found in the replication package \[13\]. cution environments (1 study,
0.88%). Finally, reinforcement learning integration offers opportunities
for improving co- 3.5.1. Advancing Agent Architecture and Optimization
ordination and decision-making in multi-agent systems by In this
category, we report future directions focused on leveraging
task-specific reward signals to guide execution, advancing agent system
architecture and optimization to reduce error propagation, and improve
logical consistency support more efficient, scalable, and robust
agent-based code in generated programs (1 study, 0.88%). generation. In
total, 15 out of 114 studies (13.16%) highlight Overall, these
directions highlight that advancing agent architectural and
optimization-oriented directions aimed at system architecture and
optimization is essential for im- improving the design, execution, and
deployment of agent- proving the scalability, efficiency, reliability,
and practical based systems. These directions encompass improvements
deployability of agent-based code generation systems. in agent
scalability, orchestration mechanisms, edge de- ployment, parallel
processing, fine-tuning and optimization 3.5.2. Secure Agents for Future
Development strategies, runtime stability, and the integration of
reinforce- In total, eight out of 114 studies (7.02%) highlight fu- ment
learning to enhance coordination and decision-making. ture research
directions aimed at enhancing the security of

Rasheed et al.: Preprint submitted to Elsevier Page 17 of 34  LLM-Based
Multi-Agent Systems for Code Generation

Table 11 Identified future research directions for LLM-based agent
systems for code generation Category Sub-Category Details Study ID
Scalability Token-efficient execution and adaptive resource management
P10, P24, P52, G28 Agent orchestration Intelligent and adaptive
communication control P7, P20, P50 Edge deployment Lightweight and
resource-efficient agent execution G13 Advanced Agent Architecture
Parallel processing Coordinated parallel execution of models and tools
P24 and Optimization Fine-tuning and optimization Workflow tuning and
iterative learning P20, P74, P42, P48, P49 Runtime stability
Sandbox-agnostic communication and execution monitoring P49
Reinforcement learning integration Learning-based optimization and
adaptive control G11 Context-aware agents Context understanding and
explainable reasoning P24, P4, P74, P2 Integrate methods such as
differential privacy, federated learning, and homomorphic encryption)
Integrate privacy preserving Ensuring compliance with privacy
regulations (e.g., GDPR, CCPA) P52, P53, P63, P66, P74, Secure Agents
Permission allocation Agent permission allocation and trust management
P4, P25, P36 Enhanced Security Expanding assessment criteria and use of
isolated environment Multi-modal memory for cross-modal interaction in
Multi-modal memory LLM agents Smarter Memory G14, G13, P24, P52 Scalable
memory management Scalable memory through efficient LLM role management
Enhanced contextual models Advancing memory-augmented for large-scale
code Multi-model benchmark Multi-modal benchmark construction P9, P17,
P36, P43, P23, Advanced Benchmarks Secure benchmark Safety, security,
and reliability benchmarks P67, G28, G16 Agent communication Agent
communication and collaboration benchmarks P5, P24, P49, P12, P36,
Multi-Model Integration Multi-modal agent architectures Expanding
multi-modal LLM agents with human feedback G11, G13 Human--AI
Collaboration Human in loop with agents Human-in-the-loop feedback and
decision support P1, P2, P12, P30, G10, G28

agents. Enhancing the security of agents requires special-
representations with scalable, adaptive management mech- ized agents to
handle security-critical and non-functional anisms, enabling more
effective reasoning over complex, requirements, enabling context-aware
delegation of security- multi-modal information and large codebases.
sensitive tasks within sandboxed environments without dis- rupting
developer workflows (5 studies, 4.39%). In addition, 3.5.4. Advanced
Benchmarks privacy-preserving collaboration is identified as an impor-
In total, eight out of 114 studies (7.02%) highlight future tant
direction, calling for the integration of techniques such research
required for advanced benchmarks. These include as differential privacy
and secure computation to protect multi-modal benchmark construction,
where benchmarks sensitive data during agent interactions (1 study,
0.88%). incorporate structured multi-modal inputs to provide a more
Permission allocation and trust management are identified as in-depth
assessment of cross-modal reasoning and genera- key directions,
suggesting controlled collaboration mecha- tion abilities (2 studies,
1.75%). In addition, future bench- nisms such as role-based access and
trust-aware coordination marks should focus on real-world tasks and
incorporate to reduce security risks in multi-agent systems (2 studies,
evaluations of safety, security, and reliability (2 studies, 1.75%).
1.75%). Furthermore, advanced benchmarks should assess In summary, the
findings indicate that advancing agent collaborative capabilities among
multiple agents, including security requires systematic integration of
specialized secu- coordination efficiency, communication effectiveness,
task rity roles, controlled access mechanisms, and privacy-aware
decomposition quality, reduction in human effort, as well as
architectures to support safe and trustworthy deployment in logical
correctness, control flow, and structural reasoning (4 real-world SE
contexts. studies, 3.51%). These findings highlight the need for more
realistic and multi-dimensional benchmark designs. Such 3.5.3. Smarter
Memory Mechanisms benchmarks are essential for systematically evaluating
agent In total, four out of 114 studies (3.51%) highlight smarter
performance beyond isolated tasks and for advancing robust, memory
mechanisms as a key future direction for agent- collaborative, and
reliable agent-based systems. based systems. These research directions
include multi- modal and structured memory systems that store multi-
3.5.5. Multi-Model Agent Systems modal data alongside summaries,
entities, relationships, and In this study, seven out of 114 studies
(6.14%) report procedural knowledge derived from documents, code, and
that future research should focus on multi-modal agent ar- interactions
(2 studies, 1.75%). In addition, scalable memory chitectures, where
agents can process and understand text, management is identified as an
important research direction, images, audio, and video by integrating
vision--language suggesting the exploration of adaptive mechanisms that
dy- models with other modality-specific components, such as namically
expand or compress memory and computational browser-based visual
perception and code-driven processing resources based on task demands
and agent activity (2 stud- of structured files (e.g., XLSX).
Furthermore, expanding ies, 1.75%). Furthermore, enhanced contextual
models that multi-modal LLM-based agents by incorporating human combine
larger context windows with memory-augmented feedback mechanisms
represents a promising direction for architectures are highlighted to
support reasoning over large advancing engineering design automation and
complex soft- and complex codebases, enabling the capture of long-range
ware development tasks. The interest in multi-modal agent dependencies
and hierarchical reasoning across multiple architectures suggests an
emerging shift from text-only code levels of abstraction (1 study,
0.88%). Overall, the findings generation toward more context-aware and
environment- highlight that advancing agent memory systems can be
integrated systems. achieved by integrating multi-modal and structured
memory

Rasheed et al.: Preprint submitted to Elsevier Page 18 of 34  LLM-Based
Multi-Agent Systems for Code Generation

3.5.6. Human-AI Collaboration This difference in focus further
highlights the priorities In this study, six out of 114 studies (5.26%)
report that of the two sectors, with industry concentrating more on a
key future research direction is to strengthen human--AI
deployment-related risks, while academia focuses on techni-
collaboration in LLM-based agent systems by integrating cal validation
and performance evaluation. Furthermore, this human feedback and
external knowledge into the decision- study highlights the limited
collaboration between academia making process, enabling agents to handle
routine analysis and industry. Only 7.89% of the studies involve
collabora- and implementation while humans provide guidance, vali- tion
between academic and industrial institutions, whereas dation, and
high-level decision-making. Future systems are 57.02% of the studies are
affiliated with academia and therefore likely to adopt hybrid models in
which agents 35.09% with industry. This distribution shows that,
although perform routine analysis and implementation tasks, while both
academia and industry are actively contributing to this humans provide
oversight, contextual understanding, and area, collaboration between
them remains limited. strategic decision-making, indicating a shift
toward collab- Implications:For researchers, the findings highlight that
orative rather than purely autonomous development work- strengthening
collaboration between academia and industry flows. would improve the
realism of experimental designs and improve the practical relevance of
research outcomes and de- Takeaway 6. This study categorizes future
research ployment contexts. In addition, for practitioners, the growth
on LLM-based agent systems for code generation of peer-reviewed research
provides a structured and increas- into six key areas, highlighting
major challenges and ingly well-organized body of knowledge, offering
clearer opportunities for real-world deployment. These com- insights
into publication trends, research focus areas, and the prise improving
reliability, security, memory mecha- ongoing development of LLM-based
multi-agent systems nisms, benchmarking, human--AI collaboration, and
for code generation across both academic and industrial multi-model
systems. Addressing these is essential domains. to move agent-based code
generation from experi- mental prototypes to practical, production-ready
SE 4.1.2. Reasons to use Agents (RQ2) tools. For this RQ, we analyzed
the studies to understand the reasons for using multi-agent systems for
code generation. As shown in Table 7, we categorized the identified rea-
sons into the following nine categories: performance en- 4. Results
Discussion and Analysis hancement, complex task handling, operational
efficiency In this section, we first discuss the results, which are and
practical scalability, team collaboration, context man- organized around
the research questions to interpret the key agement, external tool
integration, autonomous execution, findings and identify existing gaps
as well as implications for adaptability, and future-oriented
development. Overall, the future research (Section 4.1). Then, in
Section 4.2, we pro- results suggest that organizations and researchers
are lever- vide an analysis of the current state of research and
practice aging agent architectures to address the limitations observed
on LLM-based multi-agent systems for code generation. in single-model
approaches, particularly in managing com- plexity, scalability, and
real-world deployment demands. As 4.1. Results Discussion mentioned in
studies such as \[10\], \[45\], \[54\], and \[55\], 4.1.1. Demography
(RQ1) collaborative and tool-augmented agent systems improve To
understand both academic and industry perspectives performance,
contextual awareness, and execution reliability on LLM-based multi-agent
systems for code generation, we compared to standalone LLMs. These
studies also high- included both peer-reviewed and grey literature. As
shown light that the growing interest in autonomous agents for in Figure
2, 42 studies were published by academia in the software development
process represents a step forward 2024, while only six studies were
published by industry. toward more structured and production-ready
AI-assisted This indicates that LLM-based multi-agent systems were
programming solutions. explored more actively by academia than by
industry during Implications: For practitioners, the findings suggest
that that year. In contrast, we observed a substantial increase in
adopting agent-based systems can provide strategic advan- industry
contributions in 2025, with 34 studies published by tages in managing
complex development tasks, improving industry compared to 21 studies
from academia. This pattern productivity, and enhancing system
performance. However, suggests that the topic was initially driven by
academic successful implementation requires careful architectural de-
research, with industry engagement gaining momentum at a sign, workflow
integration, and control mechanisms to en- later stage. This may
indicate that the challenges associated sure reliability and
cost-effectiveness in real-world envi- with multi-agent systems, such as
security, reliability, and ronments. For researchers, the results
highlight that multi- trustworthiness, have limited their adoption in
real-world agent systems improve performance compared to single-
industrial settings or resulted in comparatively lower initial agent
models; however, further investigation is required to interest from
industry. In addition, the analysis shows that understand how agent
architectures can systematically en- industry publications more
frequently highlight security- hance coordination, adaptability, and
scalability in SE tasks. related aspects, whereas academic studies more
commonly The challenges of agent-based systems, as highlighted in focus
on correctness and reliability in agent-based systems.

Rasheed et al.: Preprint submitted to Elsevier Page 19 of 34  LLM-Based
Multi-Agent Systems for Code Generation

Section 3.4, should be further investigated and explored to performance,
reliability, and applicability in software de- improve their reliability
and practical applicability. velopment tasks. As illustrated in Table 9,
most reviewed studies rely on closed-source models, with OpenAI's GPT
4.1.3. Benchmarks and Models (RQ3-RQ4) series being the most frequently
adopted. Open-source mod- Benchmarks play an important role in
evaluating the els, including Llama, Mixtral, and DeepSeek, are also em-
code generation capabilities of LLM-based agent systems. ployed;
however, their adoption remains comparatively lim- In this study, we
identified 37 benchmarks that have been ited. These results align with
prior work showing that closed- utilized to assess LLM-based agents in
software develop- source models, such as the GPT family, often
outperform ment tasks. Among these, HumanEval \[22\] is the most
open-source alternatives on benchmarks and integration frequently used
benchmark by both academia and industry, tasks \[58\], \[59\]. However,
as reported in the above findings, while MBPP \[23\] is the second most
commonly adopted the use of closed-source models introduces challenges
re- benchmark. These results align with prior studies, which lated to
security risks, potential data leakage, and increased highlight
HumanEval and MBPP as two of the earliest operational costs (see Section
3.4). In contrast, open-source standardized benchmarks for code
generation, contribut- models reduce security risks by enabling
deployment in ing to their widespread adoption due to their simplicity,
local, isolated environments, while also improving data con-
well-defined evaluation protocols, and unit-test--based as- trol,
enhancing transparency, and lowering overall costs. sessment of
functional correctness \[56\], \[57\]. However, Implications: For
practitioners, the findings suggest recently developed benchmarks such
as SWE-bench and that, although closed-source models offer strong
perfor- LiveCodeBench aim to evaluate agent performance in mance, high
efficiency, and ease of integration, their adop- more realistic,
repository-level, and context-rich settings, tion in real-world systems
requires careful consideration of but their adoption remains limited
compared to traditional security risks, data privacy, and cost
constraints. In contrast, unit-test--based benchmarks. Detailed
information about the open-source models are recommended for practical
deploy- identified benchmarks, including their evaluation focus and ment
scenarios where security, data control, and privacy are usage context,
is provided in Table 8. critical, particularly when models can be
deployed in local or Implications: For practitioners, the findings
suggest that isolated environments. For researchers, these findings
high- reported benchmark performance may not directly translate light
that future research should systematically assess open- to real-world
software development scenarios, where factors source models in realistic
and secure deployment settings, such as code quality, maintainability,
security, and system- while also exploring techniques to narrow the
performance level behavior are critical. As a result, practitioners
should gap and preserve data control and reproducibility. interpret
benchmark results with caution when considering the adoption of
agent-based code generation systems and 4.1.4. Challenges and Solutions
(RQ5-RQ6) carefully assess whether the evaluated benchmarks reflect
While LLM-based multi-agent systems demonstrate their intended
deployment context. strong potential to accelerate code generation,
improve soft- For researchers, our analysis highlights several ware
development efficiency, and support complex tasks benchmark-related
challenges that require further such as multi-file and modular software
architectures, they investigation. Existing benchmarks often have
limited also face significant challenges. These challenges include
real-world representativeness, lack scalability to large or security and
privacy risks, agent reliability and correctness long-horizon tasks,
involve high computational costs, and issues, high computational and
resource costs, limitations provide insufficient evaluation of
multi-agent collaboration in long-term memory handling, verification
difficulties, and and coordination. These limitations reduce the ability
the lack of realistic real-world evaluation benchmarks. The of current
benchmarks to measure the capabilities of reviewed studies propose
solutions to mitigate these lim- LLM-based agent systems accurately. To
address these itations, as summarized in Section 3.4. These challenges
issues, we discussed advanced benchmarking directions in are key
empirical findings of this study, as they highlight Section 3.5.4, where
we propose that future research should critical gaps in the practical
deployment of LLM-based focus on developing realistic, open-ended, and
task-diverse agents. As mentioned in the literature \[60, 61, 62, 10,
63\], benchmarks that better reflect industrial SE practices. In current
agent systems are primarily adopted for prototype- addition, there is a
need for multi-modal benchmark designs level development; however, their
applicability in real-world that incorporate code, documentation,
issue-tracking deployment scenarios remains limited. This indicates
that, data, and execution environments. Researchers should despite
promising experimental results, existing agent-based also prioritize
agent-centric evaluation criteria, such as systems currently lack the
level of reliability and scalability collaboration efficiency, behavior
under failure, adaptability required for use in production environments.
Overall, these to changing requirements, and long-term task completion,
findings suggest that advancing LLM-based agents beyond to support more
systematic and meaningful evaluation of experimental settings requires
greater attention to system- LLM-based agent systems. level design,
evaluation, and validation. At a systems level, Models are a
foundational component of LLM-based the concentration of challenges
around reliability, security, agent systems, as their capabilities
directly influence agent orchestration, memory management, and
evaluation sug- gests that many current limitations arise less from
model

Rasheed et al.: Preprint submitted to Elsevier Page 20 of 34  LLM-Based
Multi-Agent Systems for Code Generation

capability and more from gaps in engineering infrastructure 4.1.5.
Future Trends and architectural standardization. This indicates that the
field This study provides evidence-based insights into the is shifting
from a model-centric phase, focused mainly on real-world applicability
of agent-based code generation sys- improving reasoning performance, to
a systems engineering tems and highlights several promising directions
for future phase, where coordination stability, verification pipelines,
development, as discussed in detail in Section 3.5. We cost governance,
and secure deployment become key chal- have summarized the key emerging
trends that are likely lenges. Consequently, the progress of multi-agent
systems to shape the next generation of LLM-based agent systems. will
depend less on stronger underlying models and more on These include the
integration of multiple models within the development of well-defined
design patterns, standard- agent architectures, enhanced security and
privacy consid- ized orchestration strategies, and reproducible
evaluation erations for agents, the development of smarter and scal-
frameworks that support production-level deployment. able memory
systems, the development of more advanced, Implications: For
practitioners, the findings of this study realistic, and multi-modal
benchmarking approaches, im- suggest that the practical deployment of
agent-based systems proved mechanisms for agent monitoring and
orchestra- requires careful implementation through appropriate design
tion, stronger human--AI collaboration frameworks, and the choices that
balance security, cost, and reliability, rather than adoption of more
effective and cost-efficient fine-tuning relying solely on model
capability. In industrial settings, strategies. These directions
indicate that the field is moving the adoption of LLM-based agents
should be accompanied beyond isolated architectural experimentation
toward the by proper security controls, including isolated sandboxed
development of more integrated agent ecosystems. While execution
environments, real-time monitoring mechanisms, continued improvements in
model capability remain rele- data loss prevention (DLP) techniques to
mitigate sensitive vant, future progress will depend more strongly on
how ef- data leakage, and systematic review of AI-generated code.
fectively model performance is combined with orchestration From a system
design perspective, practitioners should in- logic, memory
infrastructure, security controls, and evalua- corporate explicit memory
management strategies, such as tion pipelines within unified system
designs. This suggests external memory stores or retrieval-based
mechanisms, to that the next stage of development requires stronger
archi- support long-horizon tasks and maintain contextual con- tectural
alignment and clearer standardization, particularly sistency, as well as
effective agent orchestration solutions, in benchmarking practices,
coordination mechanisms, and including role-based coordination, task
decomposition, and deployment governance. controlled inter-agent
communication, to reduce error prop- Implications: For practitioners,
these directions provide agation and improve overall system reliability.
To address guidance for the responsible and effective adoption of agent-
cost-related constraints, this study recommends the use of based code
generation systems in real-world settings. They smaller language models
and local deployments where fea- highlight the importance of moving
beyond experimental sible, alongside hybrid human--agent workflows to
reduce prototypes toward scalable and production-ready solutions,
coordination complexity and ongoing maintenance over- while maintaining
appropriate oversight and governance head. Finally, to improve agent
accuracy and reliability mechanisms. For researchers, these directions
outline a in real-world environments, practitioners are encouraged
forward-looking research agenda that encourages the sys- to integrate
continuous monitoring, automated validation, tematic advancement of
agent architectures and evaluation and human-in-the-loop review
mechanisms throughout the methodologies, ensuring that future
developments are more software development lifecycle. powerful,
reliable, trustworthy, and deployable in practical For researchers, the
findings of this study highlight the settings. need for further
empirical investigations into the security and reliability of LLM-based
agent systems, particularly to 4.2. Current State of Research and
Practice assess attack surfaces, vulnerability propagation, and the This
subsection synthesizes evidence from both aca- effectiveness of
mitigation strategies in realistic software demic literature and grey
literature to characterize the cur- development scenarios. Future
research should also focus rent state of research and practice in
LLM-based multi-agent on improving agent scalability by reducing
communication system for code generation. We move beyond performance
overhead, enhancing orchestration strategies, and systemat- comparisons
and assess the systemic maturity of the research ically balancing
performance gains against computational ecosystem. Using the evidence
synthesized across RQ2-- and resource costs. In addition, empirical
studies that evalu- RQ7, we examine whether LLM-based multi-agent shows
ate resource--performance trade-offs in real-world industrial the
characteristics of a mature ecosystem or remains in an settings are
necessary to support the development of more earlier developmental
phase. efficient and sustainable agent-based systems. Finally, to
Industry--academia alignment: The reviewed studies strengthen agent
verification and evaluation, researchers are indicate that multi-agent
systems are proposed to address encouraged to develop advanced
benchmarking frameworks complex programming and SE tasks. As synthesized
in RQ2, that assess agent performance under realistic, long-horizon,
both academic and industrial sources highlight the handling and
multi-agent conditions reflective of real-world SE work- of complex
tasks, team collaboration, and reasoning depth flows. as key motivations
for adopting multi-agent architectures.

Rasheed et al.: Preprint submitted to Elsevier Page 21 of 34  LLM-Based
Multi-Agent Systems for Code Generation

However, regarding RQ3, we found that 29 studies used Hu- 64, 65, 2\],
which describe multi-agent systems as research- manEval and 18 studies
used MBPP as primary evaluation driven prototypes that have not yet
reached production-ready benchmarks. These benchmarks are designed for
function- deployment maturity. level code generation and relatively
small programming From a systemic perspective, this phase is character-
tasks. They involve short problem descriptions, isolated ized by high
architectural heterogeneity, absence of agreed functions, and limited
contextual reasoning. This creates a benchmark standards beyond
function-level tasks, strong structural misalignment between research
ambition and eval- dependence on evolving proprietary models, and
limited uation practice. While multi-agent systems are positioned as
deployment-oriented validation. These characteristics are solutions for
complex SE challenges, their performance is typical of a
pre-standardization ecosystem transitioning largely assessed on
simplified benchmark tasks. from exploratory prototyping toward early
consolidation, In addition, a research--deployment misalignment is ev-
rather than a fully mature and stabilized research domain. ident.
Academic evaluations primarily focus on functional For the ecosystem to
progress toward systemic maturity, correctness, whereas industrial
adoption requires security several structural developments are
necessary. First, evalua- validation, compliance assurance, and cost
control. These tion practices must better reflect real-world SE
complexity. structural tensions indicate that evaluation practices have
In addition, security assessment should become an integral not yet
evolved to match real-world deployment conditions. component of
evaluation, including the incorporation of safe These gaps suggest that
the research ecosystem has not yet execution constraints. Controlled and
secure agent environ- fully aligned with industrial realities. ments are
particularly important when autonomous agents Reproducibility and model
dependence: interact with external tools or repositories.
Reproducibility is another important indicator of systemic Furthermore,
moving toward a more mature multi-agent maturity. Our results from RQ3
show that 32 studies ecosystem requires operational transparency and
deploy- utilized earlier model versions, such as GPT-3.5 or GPT-4. ment
awareness. Clear documentation of model versions, As a result,
experiments conducted with these earlier prompts, architectural
configurations, and system-level co- model configurations cannot be
exactly reproduced under ordination mechanisms is essential to support
consistent current conditions. This creates a temporal reproducibility
validation across different environments. In multi-agent set- challenge,
where reported results become difficult to verify tings, coordination
strategies often increase computational or replicate as the underlying
language models evolve. overhead, making scalability and resource
management Additionally, the dependence on closed-source models central
concerns for practical adoption. A mature system limits experimental
transparency and comparability across should therefore incorporate
systematic reporting of com- studies. Since these models are controlled
by external putational demands, latency characteristics, and deployment
providers, researchers and practitioners cannot fully access
constraints, ensuring that performance claims extend beyond model
parameters or guarantee stable behavior over time. accuracy metrics to
reflect real-world implementation con- A mature research ecosystem
typically supports stable ditions. Finally, the development of
multi-model and hetero- baselines, controlled evaluation environments,
and the geneous agent systems may contribute to greater maturity.
ability to reproduce experiments independently. When Many current
systems rely on a single underlying language results depend on evolving
external APIs, long-term model with role-based prompting. Future systems
may in- replication becomes challenging for both academic corporate
specialized models for planning, coding, security researchers and
industrial teams attempting to validate validation, and testing within
controlled environments. Such or adopt proposed systems. In industrial
settings, structured integration could improve reliability and align
reproducibility is essential for internal validation, auditing, more
closely with real-world SE practices. and compliance processes. The
absence of standardized Overall the evidence across benchmarks (RQ3),
model reporting of prompts, model versions, and experimental usage
patterns (RQ4), identified challenges (Section 3.4), configurations
further weakens reproducibility and makes and future research directions
(RQ7) suggests that the field cross-study comparison difficult. These
conditions suggest exhibits strong innovation momentum but limited
structural that the field remains in a stage of rapid experimentation
consolidation. Architectural experimentation is widespread, rather than
methodological stabilization. yet standardized coordination patterns
have not stabilized. This pattern reflects an
innovation--standardization ten- Evaluation practices remain narrow
relative to system ambi- sion, where rapid model evolution and
experimentation tions. Reproducibility is limited by frequent model
changes outpace the establishment of stable baselines, standardized and
incomplete reporting. These signals collectively indicate reporting
practices, and long-term reproducibility norms. that LLM-based
multi-agent system has not yet reached full Pathways toward systemic
maturity: The combined ecosystem-level maturity, but rather represents
an evolving evidence from benchmark usage, models reproducibility domain
undergoing structural negotiation between research practices, industry
misalignment, and the existing challenges exploration and emerging
deployment demands. highlighted in Section 3.4 indicates that
multi-agent systems By addressing these structural challenges, the field
are currently in an advanced prototyping or early consoli- can
transition from innovation-driven experimentation to- dation phase. This
finding aligns with previous studies \[10, ward a more stable,
reproducible, production-ready, and deployment-aware research ecosystem.

Rasheed et al.: Preprint submitted to Elsevier Page 22 of 34  LLM-Based
Multi-Agent Systems for Code Generation

5.  Threats to Validity • Domain-Specific Threats to Internal Validity.
    This domain introduces additional technical threats to in- We
    followed the guidelines proposed by Runeson et al. ternal validity.
    Many primary studies rely on API- \[66\] to identify and discuss
    potential threats to the validity based proprietary LLMs whose
    architectures, train- of the study. This section is structured into
    four categories: ing data, and internal configurations are not pub-
    construct validity, internal validity, external validity, and licly
    disclosed. The black-box nature of these sys- conclusion validity.
    tems limits transparency in experimental settings and may complicate
    accurate interpretation of reported re- 5.1. Internal validity
    sults. Furthermore, variations in evaluation protocols, According to
    the Runeson et al. \[66\], internal validity such as differences in
    prompt design, temperature set- concerns factors that may affect the
    correctness of data tings, pass@k calculation methods, and tool
    integra- extraction and analysis performed on the selected studies.
    In tion strategies, may introduce inconsistencies across this MLR,
    threats to internal validity may arise at different studies. These
    methodological variations may affect stages of the research process.
    the comparability and interpretation of performance • Study Search:
    There is a risk of missing relevant outcomes synthesized in this
    review. and important academic and industrial studies during 5.2.
    External validity the search process, which requires careful
    attention. External validity concerns the extent to which the study
    To reduce this risk, we applied an integrated use of results can be
    generalized \[66\]. To strengthen external va- primary search and
    snowballing techniques, as de- lidity, we established a detailed
    study protocol that clearly scribed in Section 2.2. To maximize the
    retrieval of defines the research methodology. The study includes
    both primary studies during the initial search phase, we
    peer-reviewed and grey literature published between January refined
    the search string through pilot searches and 2022 and June 2025,
    collected from five academic databases multiple iterations in
    collaboration with the second and three additional sources. These
    sources cover research and third authors. The finalized search
    string was then on LLM-based agents for code generation and are
    summa- applied to the selected databases, enabling an effective
    rized in Table 2. and well-defined search across both academic and
    As shown in Table 9, many studies evaluated earlier industrial
    sources. GPT models (e.g., GPT-3.5 and Codex/Davinci). Given the •
    Study Selection: As this study includes both peer- rapid evolution
    of LLMs, where models are continuously reviewed and grey literature,
    the screening and selec- updated, fine-tuned, or replaced, the
    reported performance tion process was particularly critical. To
    address this and behavioral characteristics may not generalize to
    newer concern, we defined a structured study screening and versions.
    Consequently, findings derived from earlier model selection
    procedure, which is summarized in Table 3. generations may not fully
    transfer to more recent or sub- To reduce personal bias, we first
    conducted an initial stantially modified LLMs. Furthermore, several
    industrial screening of the studies, followed by a qualitative
    studies rely on proprietary datasets, internal development
    assessment of the selected papers. Throughout this environments, or
    organization-specific workflows, which process, the first two
    authors performed the screening may limit the generalizability of
    reported productivity gains, in accordance with the criteria
    explicitly specified in reliability improvements, or scalability
    claims to other con- Table 3. texts, programming languages, or
    organizational settings.

    • Data Extraction: In an MLR, data extraction can be 5.3. Construct
    validity challenging due to the possibility of researcher bias.
    Construct validity refers to the extent to which a mea- To mitigate
    this concern, we designed a standardized surement or instrument
    accurately represents and captures data extraction form (see
    Table 5) to support consis- the theoretical concept or construct it
    is intended to measure tent data collection. The initial data
    extraction was car- \[18\]. In this study, construct validity
    primarily concerns ried out by the first author, after which the
    second and the potential subjectivity involved in the analysis of
    the third authors reviewed the results. Any discrepancies selected
    studies. To mitigate this risk, data extraction was were discussed
    and resolved collaboratively. conducted independently by the first
    author, after which the second and third authors reviewed the
    extracted data. Any • Data Analysis: In this study, both qualitative
    and disagreements were resolved through discussion, following
    quantitative methods were applied to analyze the col- the
    recommendations of Kitchenham's guidelines \[15\]. In lected data.
    Biases introduced during data analysis addition, the quality of each
    selected study was evaluated in may affect the interpretation of the
    results. To mitigate accordance with the assessment protocol
    proposed by Dybå this risk, we employed an open coding technique and
    Dingsøyr \[19\]. derived from Blair et al. \[67\]. In addition, the
    data analysis was reviewed by the second and third authors, 5.4.
    Conclusion validity and any disagreements were discussed and
    resolved. Conclusion validity refers to the reliability of the
    conclu- sions derived from the results \[18\]. In this study,
    potential

Rasheed et al.: Preprint submitted to Elsevier Page 23 of 34  LLM-Based
Multi-Agent Systems for Code Generation

threats to conclusion validity include the possible omission As the
field matured, several studies in 2024 shifted the of relevant studies.
To reduce this risk, we adhered to es- focus toward specific SE
sub-domains, particularly software tablished best practices, such as
defining a rigorous search testing and automated program repair. Wang et
al. \[76\] protocol and conducting pilot searches and pilot data selec-
reviewed 102 studies that investigated the use of LLMs in tion, as
recommended by Keele et al. \[68\]. Furthermore, software testing,
finding that tasks such as test case gen- to strengthen the reliability
of the conclusions, the authors eration and program repair are among the
most common collaborated closely to interpret the findings and agree on
applications. Focusing specifically on code repair, Zhang the final
conclusions jointly. et al. \[81\] presented the first systematic
literature review dedicated to the application of LLMs in automated
program repair, synthesizing evidence from 189 relevant papers and 6.
Related Work highlighting the remaining challenges as well as directions
In this section, we discuss the literature relevant to our for future
research. study. Section 6.1 summarizes studies investigating the use In
early 2025, Zheng et al. \[77\] presented a comprehen- of LLMs in SE,
whereas Section 6.2 examines research on sive review of 123 studies to
examine the current integration LLM-based agent systems within the SE
domain. of LLMs within SE and to assess whether LLMs effectively support
SE tasks. Their work provided an overview of how 6.1. Large Language
Models for Software LLMs are incorporated into SE workflows by
organizing Engineering SE tasks into multiple categories and discussing
represen- Several surveys and literature reviews have examined tative
application scenarios. The study highlighted both the the integration
and application of LLMs in SE, synthesiz- strengths and limitations of
existing approaches and identi- ing current advancements, identifying
open challenges, and fied persistent challenges, including performance
variability, outlining emerging research trends \[69, 70, 71, 72, 73,
74, insufficient evaluation of code-oriented models, and the 75, 76, 77,
78, 76, 79, 80, 81, 82\]. For example, Zheng need for task-specific
model customization. More recently, et al. \[70\] presented one of the
earliest survey papers in Husein et al. \[75\] conducted a systematic
literature review 2023, which reviewed and assessed 134 studies focusing
on on the use of LLMs for code completion, a fundamental code-related
LLMs. Their analysis examined the relation- SE task aimed at improving
developer productivity through ship between general purpose and code
specialized models context-aware code prediction. Their analysis of 23
primary and evaluated their performance across a wide range of studies
demonstrated that LLMs can significantly enhance SE tasks, providing
detailed insights into the capabilities code completion performance,
while also revealing open and limitations of LLMs in this domain. In the
same year, challenges and outlining directions for future research. Fan
et al. \[72\] presented a survey that summarized existing research and
highlighted open research challenges related 6.2. Large Language
Model-Based Agents in to the application of LLMs to technical problems
faced in Software Engineering SE. Additionally, Hou et al. \[73\]
conducted a systematic LLM-based multi-agent systems interact and
coordinate literature review on LLMs for SE, in which they analyzed to
support collaborative decision-making in complex tasks 395 research
articles and categorized the different LLMs that \[83\]. In this domain,
several literature reviews and surveys have been employed across various
SE tasks. have been conducted to synthesize existing research on In
2024, the volume of research on LLMs for SE in- LLM-based agents and
their role in SE. For instance, in creased substantially, indicating a
growing interest in both 2024, Jin et al. \[3\] examined the evolution
of agent-based general and task-specific applications of LLMs. Building
systems by identifying key components such as planning, on an earlier
survey, Hou et al. \[69\] conducted a large- memory, tool usage, and
feedback mechanisms. In the same scale review of studies published
between 2017 and 2023, year, Li et al. \[84\] surveyed LLM-based
multi-agent sys- examining how different types of LLMs have been applied
tems and proposed a unified workflow-oriented structure across a wide
range of SE tasks. Their analysis covered data composed of five core
components, while also summarizing processing pipelines, optimization
strategies, and applica- their applications in problem-solving and world
simulation tion domains, while also identifying key challenges, open and
discussing the key challenges in this area. Together, research gaps, and
future research directions. At a broader these studies provided a
structured view of agent architec- level, Gormez et al. \[79\] presented
a systematic mapping tures and coordination mechanisms in LLM-based
systems. study that characterized the application landscape of LLMs
Building on these efforts, Wang et al. \[12\] extended the in SE, with
particular attention to their capabilities and discussion in 2025 by
offering a broader overview of agent limitations, including issues
related to non-determinism and paradigms across the SE lifecycle,
situating LLM-based hallucinations. Similarly, Albuquerque et al. \[80\]
conducted agents within established research traditions and outlining a
systematic mapping study of 19 selected studies, identi- emerging
opportunities and challenges. Additionally, Xi et fying 23 LLMs, 13
utilization strategies, 15 challenges, and al. \[85\] presented a survey
of LLM-based agents, cover- 14 mitigation mechanisms associated with the
use of LLMs ing architectural frameworks, application scenarios, and the
in programming workflows, thereby providing a structured emergence of
agent societies, while also identifying open overview of current
practices. research problems and future research directions.

Rasheed et al.: Preprint submitted to Elsevier Page 24 of 34  LLM-Based
Multi-Agent Systems for Code Generation

    As discussed above, research activity continued to grow           reached its peak in 2024, with 42 papers, while the

throughout late 2024 and into 2025, leading to the pub- grey literature
peaked in 2025 with 33 sources, in- lication of more comprehensive and
specialized surveys, dicating a growing and continuing research interest
including those by He et al. \[10\] and Liu et al. \[2\]. These in
LLM-based multi-agent systems. In peer-reviewed studies synthesized an
expanding body of academic studies studies, publications are largely
dominated by Google on role-based collaboration, agent orchestration
strategies, Scholar--indexed venues (39.2%), with conferences evaluation
methodologies, and scalability challenges. In par- serving as the
primary avenue for publications. Sim- allel, more focused reviews, such
as that by Dong et al. \[86\], ilarly, in the grey literature,
Google-based sources examined the application of agentic systems to
programming also dominate, representing approximately 65% of the tasks,
comparing single-agent and multi-agent approaches collected studies. for
code synthesis, debugging, and automated program re- pair. • This MLR
identifies several motivations for adopting LLM-based multi-agent
systems in code generation 6.3. Conclusive Summary and categorizes them
into nine groups: operational Existing reviews primarily synthesize
peer-reviewed efficiency and practical scalability, handling complex
academic literature and typically adopt a broad SE or general tasks,
performance enhancement, context manage- LLM perspective. Most surveys
treat code generation as one ment, external tool integration, team
collaboration, of many application areas and do not examine it in depth
autonomous execution, adaptability, and pathways to- as a primary task
within multi-agent system architectures. ward AGI and emerging future
trends. These findings Moreover, there is a clear lack of studies that
systematically are important for both researchers and practitioners,
incorporate grey literature to explore industrial perspectives as they
clarify the key drivers behind the adoption of on agent-based code
generation. As a result, practitioner- multi-agent approaches and inform
the design of more driven innovations, industrial tool designs,
implementation effective and scalable agentic systems. strategies, and
real-world deployment experiences receive • We have identified 37
benchmarks that are used to limited attention in prior reviews. This gap
restricts the evaluate the performance of LLM-based agents for field's
understanding of how multi-agent architectures for code generation.
Among these, HumanEval is the code generation are actually engineered,
evaluated, and most frequently adopted benchmark, used 29 times to
adopted in practice. By explicitly focusing on LLM-based assess
agent-based system performance, followed by multi-agent systems for code
generation and systematically MBPP, which was used 18 times. Table 8
provides integrating both academic and grey literature, this MLR a
detailed overview of benchmark usage across the provides a broader and
more practice-oriented synthesis of reviewed studies. We have also
highlighted the open practical challenges, emerging patterns, and
adoption trends, challenges associated with existing benchmarks, in-
thereby advancing the current understanding of the field. cluding
limited coverage of real-world scenarios and insufficient evaluation of
security and privacy aspects. 7. Conclusions In addition, we analyzed
the models employed across the selected studies to better understand
current exe- This MLR presents the current state of research on cution
practices. We found that closed-source models LLM--based multi-agent
systems for code generation from were used 57 times, whereas open-source
models were both academic and industrial perspectives. The primary
adopted 26 times in the selected studies, indicating a objective of this
study was to examine the motivations for strong reliance on proprietary
models for agent execu- employing multi-agent systems in code
generation, identify tion. Among these, the OpenAI GPT series emerged
commonly used benchmarks for evaluating agent perfor- as the most widely
used family of models, appearing mance, and analyze the models adopted
by academia and 43 times across the reviewed literature, reflecting its
industry to execute multi-agent systems. In addition, this central role
in current agent-based code generation MLR synthesizes the key
challenges associated with multi- research. agent systems, along with
their proposed solutions in the literature. We also highlight emerging
trends and future • In this study, we have identified and categorized
seven research directions for further investigation. To address the key
challenges associated with LLM-based multi- research questions outlined
in Table 1, we analyzed a total agent systems for code generation. These
challenges of 114 studies, including 74 peer-reviewed publications and
include correctness and reliability challenges with 40 sources from the
grey literature. The key findings of this agents, security and privacy
risks, computational and MLR include: resource constraints, context and
memory limitations, benchmark challenges, verification, and prompt de- •
The findings of this MLR present several insights sign challenges. We
have also summarized the mitiga- into the demographics of the reviewed
peer-reviewed tion strategies and proposed solutions discussed in the
and grey literature, including publishers, publication literature (see
Section 3.4). These findings highlight types, and authors' and
organizational affiliations. The yearly distribution of peer-reviewed
publications

Rasheed et al.: Preprint submitted to Elsevier Page 25 of 34  LLM-Based
Multi-Agent Systems for Code Generation

      the need for more reliable agent architectures, im-             via multi-plan exploration and feedback-driven refine-
      proved evaluation methodologies, and stronger safe-             ment. In Proceedings of the 39th IEEE/ACM Interna-
      guards to support the reliable and secure deployment            tional Conference on Automated Software Engineer-
      of agentic systems in real-world SE scenarios.                  ing, pages 1319–1331, 2024.
    • In this MLR, we identify future research directions,        P2 Yuntong Zhang, Haifeng Ruan, Zhiyu Fan, and Abhik
      which are categorized into six areas aimed at fur-             Roychoudhury. Autocoderover: Autonomous program
      ther investigating and improving LLM-based multi-              improvement. In Proceedings of the 33rd ACM SIG-
      agent systems for code generation. These directions            SOFT International Symposium on Software Testing
      include advanced agent architectures, secure and re-           and Analysis, pages 1592–1604, 2024.
      liable agents, the development of smarter memory
                                                                  P3 Shubham Gandhi, Manasi Patwardhan, Lovekesh Vig,
      mechanisms for agents, advanced benchmarks, multi-
                                                                     and Gautam Shroff. BudgetMLAgent: A cost-effective
      model integration within agentic frameworks, and
                                                                     LLM multi-agent system for automating machine
      human–AI collaboration. Together, these directions
                                                                     learning tasks. In Proceedings of the 4th International
      provide a roadmap for advancing the efficiency and
                                                                     Conference on AI-ML Systems, pages 1–9, 2024.
      practical applicability of agentic systems in software
      development.                                                P4 Peya Mowar, Yi-Hao Peng, Jason Wu, Aaron Stein-
                                                                     feld, and Jeffrey P. Bigham. CodeA11y: Making AI
    The findings of this MLR will benefit researchers by             coding assistants useful for accessible web develop-

providing an overview of the current state of research on ment. In
Proceedings of the 2025 CHI Conference on LLM-based multi-agent systems
for code generation and by Human Factors in Computing Systems, pages
1--15, identifying open research challenges for further investiga- 2025.
tion, as discussed in Section 3.5. In addition, the insights identified
from this study support knowledge transfer to P5 Chen-Chia Chang,
Chia-Tung Ho, Yaguang Li, Yi- practitioners by providing a clear
overview of existing chal- ran Chen, and Haoxing Ren. DRC-Coder:
Automated lenges, proposed solutions, and emerging trends in LLM- DRC
checker code generation using LLM autonomous based agentic frameworks
for code generation. We highlight agent. In Proceedings of the 2025
International Sym- the importance of practitioners considering these
findings posium on Physical Design, pages 143--151, 2025. when
designing, deploying, and maintaining agent-based systems, particularly
with respect to security, scalability, P6 Anastasiia Grishina, Vadim
Liventsev, Aki Härmä, reliability, and cost in real-world software
development con- and Leon Moonen. Fully autonomous programming texts.
using iterative multi-agent debugging with large lan- guage models. ACM
Transactions on Evolutionary Learning, 5(1):1--37, 2025. Acknowledgment
P7 Jie Wu and Fatemeh H. Fard. HumanEvalComm: This project was co-funded
by the MAISA project Benchmarking the communication competence of
(2025--2027), funded by Business Finland, which represents code
generation for LLMs and LLM agents. ACM a collaboration between academia
and eight leading Finnish Transactions on Software Engineering and
Method- companies. ology, 34(7):1--42, 2025. P8 Hao Ding, Ziwei Fan,
Ingo Guehring, Gaurav Data availability Gupta, Wooseok Ha, Jun Huan,
Linbo Liu, Behrooz To facilitate replication and validation of this
study, we Omidvar-Tehrani, Shiqi Wang, and Hao Zhou. Rea- have publicly
released the dataset \[13\]. soning and planning with large language
models in code development. In Proceedings of the 30th ACM Declaration
of AI Assistance SIGKDD Conference on Knowledge Discovery and Data
Mining, pages 6480--6490, 2024. During the preparation of this
manuscript, the author(s) used ChatGPT to assist with grammar
refinement, sentence P9 Nathaniel Pinckney, Christopher Batten, Mingjie
Liu, restructuring, and formatting improvements. Following the Haoxing
Ren, and Brucek Khailany. Revisiting Ver- use of this tool, the
author(s) carefully reviewed and revised ilogEval: A year of
improvements in large-language the content and assume full
responsibility for the final ver- models for hardware code generation.
ACM Trans- sion of the publication. actions on Design Automation of
Electronic Systems, 2025.

Selected Studies P10 Yihong Dong, Xue Jiang, Zhi Jin, and Ge Li. Self-
collaboration code generation via ChatGPT. ACM P1 Huan Zhang, Wei Cheng,
Yuhan Wu, and Wei Hu. Transactions on Software Engineering and Method- A
pair programming framework for code generation ology, 33(7):1--38, 2024.

Rasheed et al.: Preprint submitted to Elsevier Page 26 of 34  LLM-Based
Multi-Agent Systems for Code Generation

P11 Mark Marron. Toward programming languages for P20 Xingyuan Bai,
Shaobin Huang, Chi Wei, and Rui reasoning: Humans, symbolic systems, and
AI agents. Wang. Collaboration between intelligent agents and In
Proceedings of the 2023 ACM SIGPLAN Inter- large language models: A
novel approach for enhanc- national Symposium on New Ideas, New
Paradigms, ing code generation capability. Expert Systems with and
Reflections on Programming and Software, pages Applications, 269:126357,
2025. 136--152, 2023. P21 Rafael Barbarroxa, Luis Gomes, and Zita Vale.
Bench- P12 Meghana Puvvadi, Sai Kumar Arava, Adarsh Santo- marking large
language models for multi-agent sys- ria, Sesha Sai Prasanna Chennupati,
and Harsha Vard- tems: A comparative analysis of AutoGen, CrewAI, han
Puvvadi. Coding agents: A comprehensive survey and TaskWeaver. In
International Conference on Prac- of automated bug fixing systems and
benchmarks. In tical Applications of Agents and Multi-Agent Sys- 2025
IEEE 14th International Conference on Commu- tems, pages 39--48, 2024.
nication Systems and Network Technologies (CSNT), pages 680--686, 2025.
P22 Buvaneswari A. Ramanan, Manzoor A. Khan, and Abhinav Rao. ASPIRE: A
Multi-Agent Framework for P13 Jingzhi Gong, Vardan Voskanyan, Paul
Brookes, Fan Execution-Free Code Analysis and Repair. In 2024 Wu, Wei
Jie, Jie Xu, Rafail Giavrimis, Mike Basios, IEEE International
Conference on Big Data (Big- Leslie Kanthan, and Zheng Wang. Language
models Data), pages 8811--8813, 2024. for code optimization: Survey,
challenges and future directions. arXiv preprint arXiv:2501.01277, 2025.
P23 Kechi Zhang, Jia Li, Ge Li, Xianjie Shi, and Zhi Jin. CodeAgent:
Enhancing Code Generation with P14 Levent Dinçkal. Large language
model-based au- Tool-Integrated Agent Systems for Real-World Repo-
tonomous agents: Trends and directions. AIPA's In- level Coding
Challenges. In Proceedings of the 62nd ternational Journal on Artificial
Intelligence: Bridging Annual Meeting of the Association for
Computational Technology, Society and Policy, 1(1):13--24, 2024.
Linguistics (ACL 2024), pages 13643--13658, 2024. P15 Junda He,
Christoph Treude, and David Lo. LLM- P24 Samuel Holt, Max Ruiz Luyten,
and Mihaela van Based Multi-Agent Systems for Software Engineering: der
Schaar. L2MAC: Large Language Model Auto- Literature Review, Vision, and
the Road Ahead. ACM matic Computer for Extensive Code Generation. In
Transactions on Software Engineering and Methodol- The Twelfth
International Conference on Learning ogy, 34(5):1--30, 2025.
Representations (ICLR 2024), 2024. P16 Peter Robe, Sandeep K. Kuttal,
Jake AuBuchon, and P25 Md. Ashraful Islam, Mohammed Eunus Ali, and Md.
Jacob Hart. Pair programming conversations with Rizwan Parvez. MapCoder:
Multi-Agent Code Gen- agents vs. developers: challenges and
opportunities eration for Competitive Problem Solving. In Proceed- for
SE community. In Proceedings of the 30th ACM ings of the 62nd Annual
Meeting of the Association Joint European Software Engineering
Conference and for Computational Linguistics (ACL 2024), pages Symposium
on the Foundations of Software Engineer- 4912--4944, 2024. ing, pages
319--331, 2022. P26 S. Akilesh, Rajeev Sekar, Om Kumar C. U., Prakalya
P17 Kaixin Wang, Tianlin Li, Xiaoyu Zhang, Chong D., and Suguna M.
Multi-Agent hierarchical workflow Wang, Weisong Sun, Yang Liu, and Bin
Shi. Soft- for autonomous code generation with Large Language ware
Development Life Cycle Perspective: A Survey Models. In 2025 IEEE
International Students' Confer- of Benchmarks for Code Large Language
Models and ence on Electrical, Electronics and Computer Science Agents.
arXiv preprint arXiv:2505.05283, 2025. (SCEECS), pages 1--5, 2025. P18
Rolando Ramírez-Rueda, Edgard Benítez-Guerrero, P27 Yusen Zhang, Ruoxi
Sun, Yanfei Chen, Tomas Pfister, Carmen Mezura-Godoy, and Everardo
Bárcenas. Rui Zhang, and Sercan Arik. Chain of agents: Large
Transforming Software Development: A Study on the language models
collaborating on long-context tasks. Integration of Multi-Agent Systems
and Large Lan- Advances in Neural Information Processing Systems, guage
Models for Automatic Code Generation. In 37:132208--132237, 2024. 2024
12th International Conference in Software Engi- neering Research and
Innovation (CONISOFT), pages P28 Zhuofan Shi, Chunxiao Xin, Tong Huo,
Yuntao Jiang, 11--20, 2024. Bowen Wu, Xingyue Chen, Wei Qin, Xinjian Ma,
Gang Huang, Zhenyu Wang, and others. A fine-tuned P19 Haolin Jin, Zechao
Sun, and Huaming Chen. RGD: large language model based molecular
dynamics Multi-LLM based agent debugger via refinement and agent for
code generation to obtain material thermo- generation guidance. In 2024
IEEE International Con- dynamic parameters. Scientific Reports,
15(1):10295, ference on Agents (ICA), pages 136--141, 2024. 2025.

Rasheed et al.: Preprint submitted to Elsevier Page 27 of 34  LLM-Based
Multi-Agent Systems for Code Generation

P29 Lei Wang, Chen Ma, Xueyang Feng, Zeyu Zhang, and Xiangliang Zhang.
Large Language Model Based Hao Yang, Jingsen Zhang, Zhiyuan Chen, Jiakai
Tang, Multi-agents: A Survey of Progress and Challenges. Xu Chen, Yankai
Lin, and others. A survey on large In Proceedings of the Thirty-Third
International Joint language model based autonomous agents. Frontiers
Conference on Artificial Intelligence (IJCAI 2024), of Computer Science,
18(6):186345, 2024. pages 8048--8057, 2024. P30 Zeeshan Rasheed,
Muhammad Waseem, Malik Ab- P39 Carlos E. Jimenez, John Yang, Alexander
Wettig, dul Sami, Kai-Kristian Kemell, Aakash Ahmad, Anh Shunyu Yao,
Kexin Pei, Ofir Press, and Karthik R. Nguyen Duc, Kari Systä, and Pekka
Abrahamsson. Narasimhan. SWE-bench: Can Language Models Re- Autonomous
agents in software development: A vision solve Real-world GitHub Issues?
In The Twelfth In- paper. In International Conference on Agile Software
ternational Conference on Learning Representations Development, pages
15--23, 2024. (ICLR 2024), 2024. P31 Thiem Nguyen Ba, Binh Nguyen Thanh,
and Viet- P40 Dong Huang, Jie M. Zhang, Michael Luck, Qing- Trung Tran.
CoverNexus: Multi-agent LLM System for wen Bu, Yuhao Qing, and Heming
Cui. Agent- Automated Code Coverage Enhancement. In Interna- Coder:
Multi-agent-based code generation with it- tional Symposium on
Information and Communica- erative testing and optimisation. arXiv
preprint tion Technology, pages 472--484, 2024. arXiv:2312.13010, 2023.
P32 Dawei Yuan, Guocang Yang, and Tao Zhang. P41 Qian Huang, Jian Vora,
Percy Liang, and Jure UI2HTML: Utilizing LLM agents with chain of
Leskovec. Benchmarking large language models as AI thought to convert UI
into HTML code. Automated research agents. In NeurIPS 2023 Foundation
Models Software Engineering, 32(2):1--24, 2025. for Decision Making
Workshop, 2023. P33 Kaiyan Chang, Wenlong Zhu, Kun Wang, Xinyang P42
Xingyao Wang, Yangyi Chen, Lifan Yuan, Yizhe He, Nan Yang, Zhirong Chen,
Dantong Jin, Cangyuan Zhang, Yunzhu Li, Hao Peng, and Heng Ji.
Executable Li, Yunhao Zhou, Yan Hao, and others. A data-centric code
actions elicit better LLM agents. In Proceedings chip design agent
framework for Verilog code gener- of the Forty-first International
Conference on Machine ation. ACM Transactions on Design Automation of
Learning (ICML), 2024. Electronic Systems, 2025. P43 Qingyun Wu, Gagan
Bansal, Jieyu Zhang, Yiran Wu, P34 Haoyuan Wu, Zhuolun He, Xinyun Zhang,
Xufeng Beibin Li, Erkang Zhu, Li Jiang, Xiaoyun Zhang, Yao, Su Zheng,
Haisheng Zheng, and Bei Yu. Shaokun Zhang, Jiale Liu, and others.
AutoGen: En- ChatEDA: A Large Language Model Powered Au- abling next-gen
LLM applications via multi-agent tonomous Agent for EDA. IEEE
Transactions on conversations. In Proceedings of the First Conference
Computer-Aided Design of Integrated Circuits and on Language Modeling,
2024. Systems, 43(10):3184--3197, 2024. P44 Chia-Tung Ho, Haoxing Ren,
and Brucek Khailany. P35 Chen Qian, Wei Liu, Hongzhang Liu, Nuo Chen,
VerilogCoder: Autonomous Verilog coding agents Yufan Dang, Jiahao Li,
Cheng Yang, Weize Chen, with graph-based planning and abstract syntax
tree Yusheng Su, Cong Xin, and others. ChatDev: Com- (AST)-based
waveform tracing tool. In Proceedings municative agents for software
development. In Pro- of the AAAI Conference on Artificial Intelligence,
ceedings of the 62nd Annual Meeting of the Associ- 39(1):300--307, 2025.
ation for Computational Linguistics (Volume 1: Long Papers), pages
15174--15186, 2024. P45 John Yang, Carlos E. Jimenez, Alexander Wettig,
Kilian Lieret, Shunyu Yao, Karthik Narasimhan, and P36 Hanbin Wang,
Zhenghao Liu, Shuo Wang, Ganqu Ofir Press. SWE-Agent: Agent-computer
interfaces en- Cui, Ning Ding, Zhiyuan Liu, and Ge Yu. Intervenor: able
automated software engineering. Advances in Prompting the coding ability
of large language models Neural Information Processing Systems,
37:50528-- with the interactive chain of repair. In Findings of 50652,
2024. the Association for Computational Linguistics: ACL 2024, pages
2081--2107, 2024. P46 Islem Bouzenia, Premkumar T. Devanbu, and Michael
Pradel. RepairAgent: An Autonomous, LLM-Based P37 Robert Feldt, Sungmin
Kang, Juyeon Yoon, and Shin Agent for Program Repair. In 47th IEEE/ACM
Inter- Yoo. Towards autonomous testing agents via conver- national
Conference on Software Engineering (ICSE sational large language models.
In 2023 IEEE/ACM 2025), pages 2188--2200, 2025. International Conference
on Automated Software En- gineering (ASE), pages 1688--1693, 2023. P47
Victor Dibia, Jingya Chen, Gagan Bansal, Suff Syed, Adam Fourney, Erkang
Zhu, Chi Wang, and Saleema P38 Taicheng Guo, Xiuying Chen, Yaqi Wang,
Ruidi Amershi. AUTOGEN STUDIO: A No-Code Devel- Chang, Shichao Pei,
Nitesh V. Chawla, Olaf Wiest, oper Tool for Building and Debugging
Multi-Agent

Rasheed et al.: Preprint submitted to Elsevier Page 28 of 34  LLM-Based
Multi-Agent Systems for Code Generation

      Systems. In Proceedings of the 2024 Conference on          P56 Gang Fan, Xiaoheng Xie, Xunjin Zheng, Yinan Liang,
      Empirical Methods in Natural Language Processing:              and Peng Di. Static code analysis in the AI era: An
      System Demonstrations, pages 72–79, 2024.                      in-depth exploration of the concept, function, and
                                                                     potential of intelligent code analysis agents. arXiv

P48 Guohao Li, Hasan Hammoud, Hani Itani, Dmitrii preprint
arXiv:2310.08837, 2023. Khizbullin, and Bernard Ghanem. CAMEL: Commu-
nicative agents for "mind" exploration of large lan- P57 Yue Hu, Yuzhu
Cai, Yaxin Du, Xinyu Zhu, Xiangrui guage model society. Advances in
Neural Information Liu, Zijie Yu, Yuchen Hou, Shuo Tang, and Siheng
Processing Systems, 36:51991--52008, 2023. Chen. Self-Evolving
Multi-Agent Collaboration Net- works for Software Development. In The
Thirteenth P49 Xingyao Wang, Boxuan Li, Yufan Song, Frank F.
International Conference on Learning Representa- Xu, Xiangru Tang,
Mingchen Zhuge, Jiayi Pan, Yueqi tions (ICLR 2025), 2025. Song, Bowen
Li, Jaskirat Singh, Hoang H. Tran, Fuqiang Li, Ren Ma, Mingzhang Zheng,
Bill Qian, P58 Chengquan Guo, Xun Liu, Chulin Xie, Andy Zhou, Yi Yanjun
Shao, Niklas Muennighoff, Yizhe Zhang, Zeng, Zinan Lin, Dawn Song, and
Bo Li. RedCode: Binyuan Hui, Junyang Lin, Robert Brennan, Hao Risky Code
Execution and Generation Benchmark Peng, Heng Ji, and Graham Neubig.
OpenHands: An for Code Agents. In Advances in Neural Information Open
Platform for AI Software Developers as Gener- Processing Systems
(NeurIPS 2024), 2024. alist Agents. In The Thirteenth International
Confer- P59 Haolin Jin, Linghan Huang, Haipeng Cai, Jun Yan, ence on
Learning Representations (ICLR 2025), 2025. Bo Li, and Huaming Chen.
From LLMs to LLM- P50 Weize Chen, Yusheng Su, Jingwei Zuo, Cheng Yang,
based Agents for Software Engineering: A Survey Chenfei Yuan, Chi-Min
Chan, Heyang Yu, Yaxi Lu, of Current, Challenges and Future. arXiv
preprint Yi-Hsin Hung, Chen Qian, and others. AgentVerse:
arXiv:2408.02479, 2024. Facilitating Multi-Agent Collaboration and
Exploring P60 Xiangru Tang, Yuliang Liu, Zefan Cai, Yanjun Shao,
Emergent Behaviors. In The Twelfth International Junjie Lu, Yichi Zhang,
Zexuan Deng, Helan Hu, Conference on Learning Representations (ICLR),
Kaikai An, Ruijun Huang, Shuzheng Si, Chen Sheng, 2024. Haozhe Zhao,
Liang Chen, Tianyu Liu, Yin Fang, P51 Yujie Zhao, Hejia Zhang, Hanxian
Huang, Zhong- Yujia Qin, Wangchunshu Zhou, Yilun Zhao, Zhiwei ming Yu,
and Jishen Zhao. Mage: A multi-agent en- Jiang, Baobao Chang, Arman
Cohan, and Mark Ger- gine for automated RTL code generation. In 2025
stein. ML-Bench: Evaluating Large Language Models 62nd ACM/IEEE Design
Automation Conference for Code Generation in Repository-Level Machine
(DAC), pages 1--7, 2025. Learning Tasks. OpenReview preprint, 2025. P52
Yuheng Cheng, Ceyao Zhang, Zhengwen Zhang, Xi- P61 Anonymous.
SWE-PolyBench: A multi-language angrui Meng, Sirui Hong, Wenhao Li,
Zihao Wang, benchmark for repository level evaluation of coding Zekai
Wang, Feng Yin, Junhua Zhao, and others. agents. Submitted to The
Fourteenth International Exploring large language model based
intelligent Conference on Learning Representations (under agents:
Definitions, methods, and prospects. arXiv review), 2025. preprint
arXiv:2401.03428, 2024. P62 Kaiyuan Liu, Youcheng Pan, Yang Xiang,
Daojing P53 Junda He, Christoph Treude, and David Lo. LLM- He, Jing Li,
Yexing Du, and Tianrun Gao. ProjectE- Based Multi-Agent Systems for
Software Engineering: val: A Benchmark for Programming Agents Auto-
Literature Review, Vision, and the Road Ahead. ACM mated Evaluation on
Project-Level Code Generation. Transactions on Software Engineering and
Methodol- In Findings of the Association for Computational Lin- ogy,
34(5):1--30, 2025. guistics: ACL 2025, pages 20205--20221, 2025. P54
Sirui Hong, Mingchen Zhuge, Jonathan Chen, Xiawu P63 Niels Mündler, Mark
Niklas Müller, Jingxuan He, and Zheng, Yuheng Cheng, Jinlin Wang, Ceyao
Zhang, Martin T. Vechev. SWT-Bench: Testing and Validating Zili Wang,
Steven Ka Shing Yau, Zijuan Lin, and Real-World Bug-Fixes with Code
Agents. In Advances others. MetaGPT: Meta programming for a multi- in
Neural Information Processing Systems (NeurIPS agent collaborative
framework. In The Twelfth In- 2024), 2024. ternational Conference on
Learning Representations P64 Chen Qian, Yufan Dang, Jiahao Li, Wei Liu,
Zihao (ICLR), 2023. Xie, Yifei Wang, Weize Chen, Cheng Yang, Xin P55
Dong Chen, Shaoxin Lin, Muhan Zeng, Daoguang Cong, Xiaoyin Che, Zhiyuan
Liu, and Maosong Sun. Zan, Jian-Gang Wang, Anton Cheshkov, Jun Sun, Hao
Experiential Co-Learning of Software-Developing Yu, Guoliang Dong, Artem
Aliev, and others. Coder: Agents. In Proceedings of the 62nd Annual
Meeting of Issue resolving with multi-agent and task graphs. the
Association for Computational Linguistics (ACL arXiv preprint
arXiv:2406.01304, 2024. 2024), pages 5628--5640, 2024.

Rasheed et al.: Preprint submitted to Elsevier Page 29 of 34  LLM-Based
Multi-Agent Systems for Code Generation

P65 Samdyuti Suri, Sankar Narayan Das, Kapil Singi, on Empirical Methods
in Natural Language Process- Kuntal Dey, Vibhu Saujanya Sharma, and
Vikrant ing (EMNLP 2024), pages 13487--13521, 2024. Kaulgud. Software
Engineering Using Autonomous Agents: Are We There Yet? In 38th IEEE/ACM
In- G1 Yoichi Ishibashi and Yoshimasa Nishimura. Self- ternational
Conference on Automated Software Engi- organized agents: A LLM
multi-agent framework to- neering (ASE 2023), pages 1855--1857, 2023.
ward ultra large-scale code generation and optimiza- tion. arXiv
preprint arXiv:2404.02183, 2024. P66 Dong Huang, Qingwen Bu, Jie M.
Zhang, Michael G2 GetStream. Best 5 Frameworks to Build Multi-Agent
Luck, and Heming Cui. AgentCoder: Multi-Agent- AI Applications. Online
article, 2025. Available at: ht based Code Generation with Iterative
Testing and Op- tps://getstream.io/blog/multiagent-ai-frameworks/.
timisation. arXiv preprint arXiv:2312.13010, 2023. G3 Jagadeesan Ganesh.
Mastering LLM AI Agents: Build- P67 Xunzhu Tang, Kisub Kim, Yewei Song,
Cedric ing and Using AI Agents in Python with Real-World Lothritz, Bei
Li, Saad Ezzini, Haoye Tian, Jacques Use Cases. Medium blog post, 2025.
Available at: Klein, and Tegawendé F. Bissyandé. CodeAgent: Au-
https://medium.com/@jagadeesan.ganesh/masterin tonomous Communicative
Agents for Code Review.
g-llm-ai-agents-building-and-using-ai-agents-in-p In Proceedings of the
2024 Conference on Empirical
ython-with-real-world-use-cases-c578eb640e35. Methods in Natural
Language Processing (EMNLP 2024), pages 11279--11313, 2024. G4 Anthropic
Engineering. How We Built Our Multi- Agent Research System. Technical
blog post, 2025. P68 Godsfavour Kio. SWE-bench-secret: Automating AI
Available at: https://www.anthropic.com/engineer Agent Evaluation for
Software Engineering Tasks. ing/multi-agent-research-system. University
of Waterloo, 2025. G5 SuperAnnotate. Multi-Agent LLMs in 2025. Blog
post, P69 Niels Mündler, Mark Niklas Müller, Jingxuan He, and 2025.
Available at: https://www.superannotate.com/bl Martin T. Vechev. Code
agents are state of the art og/multi-agent-llms. software testers. In
ICML 2024 Workshop on LLMs and Cognition, 2024. G6 Solace. Long-Term
Memory in Agentic AI Systems. Blog post, 2025. Available at:
https://solace.com P70 Jirat Pasuksmit, Wannita Takerngsaksiri,
Patanamon /blog/long-term-memory-agentic-ai-systems/. Thongtanunam,
Chakkrit Tantithamthavorn, Ruix- iong Zhang, Shiyan Wang, Fan Jiang,
Jing Li, Evan G7 LangChain. How and When to Build Multi-Agent Sys- Cook,
Kun Chen, and others. Human-In-The-Loop tems. Technical blog post, 2025.
Available at: https: Software Development Agents: Challenges and Future
//blog.langchain.com/how-and-when-to-build-multi Directions. In 2025
IEEE/ACM 22nd International -agent-systems/. Conference on Mining
Software Repositories (MSR), G8 Prompting Guide. LLM Agents. Research
guide arti- pages 756--757, 2025. cle, 2025. Available at:
https://www.promptingguide.a P71 Junwei Liu, Kaixin Wang, Yixuan Chen,
Xin i/research/llm-agents. Peng, Zhenpeng Chen, Lingming Zhang, and G9
Deepchecks. How Multi-Agent LLMs Differ from Tra- Yiling Lou. Large
language model-based agents ditional LLMs. Blog post, 2025. Available
at: https: for software engineering: A survey. arXiv preprint
//www.deepchecks.com/how-multi-agent-llms-diffe arXiv:2409.02977, 2024.
r-from-traditional-llms/. P72 Chunqiu Steven Xia, Yinlin Deng, Soren
Dunn, and G10 Bito. AI Agent vs LLM: Understanding the Differ- Lingming
Zhang. Demystifying LLM-based software ences. Blog post, 2025. Available
at: https://bito.a engineering agents. Proceedings of the ACM on Soft-
i/blog/ai-agent-vs-llm/. ware Engineering, 2(FSE):801--824, 2025. G11
LabelYourData. Multi-Agent LLMs: Concepts and P73 Md. Ashraful Islam,
Mohammed Eunus Ali, and Md. Workflow. Blog post, 2025. Available at:
https://la Rizwan Parvez. CodeSim: Multi-Agent Code Genera-
belyourdata.com/articles/multi-agent-llm. tion and Problem Solving
through Simulation-Driven Planning and Debugging. In Findings of the
Associ- G12 Ruwei Pan, Hongyu Zhang, and Chao Liu. ation for
Computational Linguistics: NAACL 2025, CodeCoR: An LLM-Based
Self-Reflective Multi- pages 5113--5139, 2025. Agent Framework for Code
Generation. arXiv preprint arXiv:2501.07811, 2025. P74 Yiming Huang,
Jianwen Luo, Yan Yu, Yitong Zhang, Fangyu Lei, Yifan Wei, Shizhu He,
Lifu Huang, Xiao G13 freeCodeCamp.org. The Open Source LLM Agent Liu,
Jun Zhao, and Kang Liu. DA-Code: Agent Data Handbook. Online handbook,
2025. Available at: ht Science Code Generation Benchmark for Large Lan-
tps://www.freecodecamp.org/news/the-open-source-l guage Models. In
Proceedings of the 2024 Conference lm-agent-handbook/.

Rasheed et al.: Preprint submitted to Elsevier Page 30 of 34  LLM-Based
Multi-Agent Systems for Code Generation

G14 Microsoft. AI Agents in Azure Cosmos DB. Microsoft G25 Business
Wire. Reply Launches Silicon Shoring, an Learn documentation, 2025.
Available at: https://le AI Powered Software Delivery Model to Optimise
arn.microsoft.com/en-us/azure/cosmos-db/ai-agents. and Automate the
Entire Software Development Life Cycle. News release, 2025. Available
at: https://www. G15 Xue-Guang. LLMs for Multi-Agent Cooperation. Blog
businesswire.com/news/home/20250515940305/en/Rep post, 2025. Available
at: https://xue-guang.com/pos
ly-Launches-Silicon-Shoring-an-AI-Powered-Softwar t/llm-marl/.
e-Delivery-Model-to-Optimise-and-Automate-the-Ent G16 Zeeshan Rasheed,
Malik Abdul Sami, Kai-Kristian ire-Software-Development-Life-Cycle.
Kemell, Muhammad Waseem, Mika Saari, Kari G26 InfoQ. LlamaFirewall Adds
Agent Protection with Systä, and Pekka Abrahamsson. Codepori: Large-
Malware Scanning. News article, 2025. Available at: scale system for
autonomous software develop-
https://www.infoq.com/news/2025/05/llamafirewall-a ment using
multi-agent technology. arXiv preprint gent-protection/.
arXiv:2402.01411, 2024. G27 MarkTechPost. Democratizing AI: Implementing
a G17 Anurag Mishra. Future of Coding: Multi-Agent LLM Multimodal
LLM-Based Multi-Agent System with No- Framework Using LangGraph. Medium
blog post, Code Platforms for Business Automation. News arti- 2025.
Available at: https://medium.com/@anuragmi cle, 2025. Available at:
https://www.marktechpost.com
shra_27746/future-of-coding-multi-agent-llm-frame
/2025/01/10/democratizing-ai-implementing-a-multi
work-using-langgraph-092da9493663.
modal-llm-based-multi-agent-system-with-no-code-p G18 Micheline
Bénédicte Moumoula, Serge Lionel latforms-for-business-automation/.
Nikiema, Albérick Euraste Djire, Abdoul Kader G28 Sourena Khanzadeh.
AgentMesh: A Cooperative Kabore, Jacques Klein, and Tegawendé F.
Multi-Agent Generative AI Framework for Bissyandé. Beyond Language
Barriers: Multi-Agent Software Development Automation. arXiv preprint
Coordination for Multi-Language Code Generation. arXiv:2507.19902, 2025.
arXiv e-prints, 2025. G29 Yiping Jia, Zhen Ming Jiang, Shayan Noei, and
G19 JetBrains AI. The Future of AI in Software Develop- Ying Zou.
MemoCoder: Automated Function Syn- ment. Blog post, 2025. Available at:
https://blog.jet thesis using LLM-Supported Agents. arXiv preprint
brains.com/ai/2025/07/the-future-of-ai-in-softwar arXiv:2507.18812,
2025. e-development/. G30 IBM. AI Agents vs AI Assistants. IBM Think
article, G20 Tahir Balarabe. The Difference Between AI Assistants 2025.
Available at: https://www.ibm.com/think/topics and AI Agents --- and Why
It Matters. Medium blog /ai-agents-vs-ai-assistants. post, 2025.
Available at: https://medium.com/@tahirb
alarabe2/the-difference-between-ai-assistants-and G31 IBM Research.
Large Language Models Revolution-
-ai-agents-and-why-it-matters-03b5ace6055a. ized AI. LLM Agents Are
What's Next. Research blog post, 2025. Available at:
https://research.ibm.com/b G21 AugmentCode. Why Multi-Agent LLM Systems
Fail log/what-are-ai-agents-llm. and How to Fix Them. Web guide article,
2025. Avail- able at: https://www.augmentcode.com/guides/why-mul G32
Unit 42, Palo Alto Networks. AI Agents Are Here. So
ti-agent-llm-systems-fail-and-how-to-fix-them. Are the Threats. Security
blog post, 2025. Available at:
https://unit42.paloaltonetworks.com/agentic-a G22 Center for Security
and Emerging Technology. Multi- i-threats/. modality, Tool Use, and
Autonomous Agents. Online article, 2025. Available at:
https://cset.georgetown. G33 YouTube. Qwen 3 Coder Plus: BEST Agentic
Cod- edu/article/multimodality-tool-use-and-autonomou ing LLM! Insanely
Powerful, Fast, & Free! (Open s-agents/. Source). Video, 2025. Available
at: https://www.yo utube.com/watch?v=JuU1JQL6S2w. G23 NVIDIA Developer.
How Small Language Models Are Key to Scalable Agentic AI. Blog post,
2025. G34 YouTube. The Best Local AI Agent for Python. Video, Available
at: https://developer.nvidia.com/blog/ 2025. Available at:
https://www.youtube.com/watch?v=
how-small-language-models-are-key-to-scalable-age NIBprn5cEZA. ntic-ai/.
G35 Dayu Wang, Jiaye Yang, Weikang Li, Jiahui Liang, G24 AI Multiple. 8
AI Code Models Benchmarked: LMC- and Yang Li. Reducing Cognitive
Overhead in Tool Eval. Online article, 2025. Available at: https://rese
Use via Multi-Small-Agent Reinforcement Learning.
arch.aimultiple.com/ai-code-editor/. arXiv preprint arXiv:2508.08882,
2025.

Rasheed et al.: Preprint submitted to Elsevier Page 31 of 34  LLM-Based
Multi-Agent Systems for Code Generation

G36 Pillar Security. New Vulnerability in GitHub Copi- \[9\] M. A.
Islam, M. E. Ali, M. R. Parvez, Codesim: Multi-agent code lot and
Cursor: How Hackers Can Weaponize Code generation and problem solving
through simulation-driven planning Agents. Security blog post, 2025.
Available at: https: and debugging, in: L. Chiruzzo, A. Ritter, L. Wang
(Eds.), Findings of the Association for Computational Linguistics: NAACL
2025, //www.pillar.security/blog/new-vulnerability-in-g Albuquerque, New
Mexico, USA, April 29 - May 4, 2025, Association
ithub-copilot-and-cursor-how-hackers-can-weaponi for Computational
Linguistics, 2025, pp. 5113--5139. doi:10.18653/V ze-code-agents.
1/2025.FINDINGS-NAACL.285. URL
https://doi.org/10.18653/v1/2025.findings-naacl.285 G37 Ars Technica.
Research AI Model Unexpectedly Mod- \[10\] J. He, C. Treude, D. Lo,
Llm-based multi-agent systems for soft- ified Its Own Code to Extend
Runtime. News article, ware engineering: Literature review, vision, and
the road ahead, 2024. Available at: https://arstechnica.com/informat ACM
Transactions on Software Engineering and Methodology 34 (5) (2025)
1--30. ion-technology/2024/08/research-ai-model-unexpec \[11\] M.
Mohammadi, Y. Li, J. Lo, W. Yip, Evaluation and benchmarking
tedly-modified-its-own-code-to-extend-runtime/. of llm agents: A survey,
in: Proceedings of the 31st ACM SIGKDD Conference on Knowledge Discovery
and Data Mining V. 2, 2025, pp. G38 Aofan Liu, Haoxuan Li, Bin Wang, Ao
Yang, and Hui 6129--6139. Li. RA-Gen: A Controllable Code Generation
Frame- \[12\] Y. Wang, W. Zhong, Y. Huang, E. Shi, M. Yang, J. Chen, H.
Li, work Using ReAct for Multi-Agent Task Execution. Y. Ma, Q. Wang, Z.
Zheng, Agents in software engineering: Survey, arXiv preprint
arXiv:2510.08665, 2025. landscape, and vision, Automated Software
Engineering 32 (2) (2025) 70. G39 Abhishek Kodati, Foutse Khomh, and
Ashkan Sami. \[13\] Z. Rasheed, Llm-based multi-agent systems for code
generation: A multi-vocal literature review (Feb. 2026).
doi:10.5281/zenodo.18763 MAC: Multi-Agent LLM Coder Is All You Need.
SSRN 362. Working Paper 5887028. URL
https://doi.org/10.5281/zenodo.18763362 \[14\] V. Garousi, M. Felderer,
M. V. Mäntylä, Guidelines for including grey G40 Yuansheng Ni, Songcheng
Cai, Xiangchao Chen, literature and conducting multivocal literature
reviews in software Jiarong Liang, Zhiheng Lyu, Jiaqi Deng, Kai Zou,
engineering, Information and software technology 106 (2019) 101-- Ping
Nie, Fei Yuan, Yue Xiang, et al. VisCoder2: 121. Building Multi-Language
Visualization Coding \[15\] B. Kitchenham, O. P. Brereton, D. Budgen, M.
Turner, J. Bailey, S. Linkman, Systematic literature reviews in software
engineering-- Agents. arXiv preprint arXiv:2510.23642, 2025. a
systematic literature review, Information and software technology 51 (1)
(2009) 7--15. \[16\] C. Schardt, M. B. Adams, T. Owens, S. Keitz, P.
Fontelo, Utilization References of the pico framework to improve
searching pubmed for clinical ques- \[1\] L. Belzner, T. Gabor, M.
Wirsing, Large language model assisted tions, BMC medical informatics
and decision making 7 (1) (2007) 16. software engineering: prospects,
challenges, and a case study, in: In- \[17\] P. Brereton, B. A.
Kitchenham, D. Budgen, M. Turner, M. Khalil, ternational Conference on
Bridging the Gap between AI and Reality, Lessons from applying the
systematic literature review process within Springer, 2023,
pp. 355--374. the software engineering domain, Journal of systems and
software \[2\] J. Liu, K. Wang, Y. Chen, X. Peng, Z. Chen, L. Zhang, Y.
Lou, Large 80 (4) (2007) 571--583. language model-based agents for
software engineering: A survey, \[18\] C. Wohlin, Guidelines for
snowballing in systematic literature studies arXiv preprint
arXiv:2409.02977 (2024). and a replication in software engineering, in:
Proceedings of the 18th \[3\] H. Jin, L. Huang, H. Cai, J. Yan, B. Li,
H. Chen, From llms to llm- international conference on evaluation and
assessment in software based agents for software engineering: A survey
of current, challenges engineering, 2014, pp. 1--10. and future, arXiv
preprint arXiv:2408.02479 (2024). \[19\] T. Dybå, T. Dingsøyr, Empirical
studies of agile software devel- \[4\] S. Hong, X. Zheng, J. Chen, Y.
Cheng, J. Wang, C. Zhang, opment: A systematic review, Information and
software technology Z. Wang, S. K. S. Yau, Z. Lin, L. Zhou, et al.,
Metagpt: Meta 50 (9-10) (2008) 833--859. programming for multi-agent
collaborative framework, arXiv preprint \[20\] C. Wohlin, M. Höst, K.
Henningsson, Empirical research methods in arXiv:2308.00352 (2023). web
and software engineering, in: Web engineering, Springer, 2006, \[5\] C.
Qian, W. Liu, H. Liu, N. Chen, Y. Dang, J. Li, C. Yang, W. Chen,
pp. 409--430. Y. Su, X. Cong, et al., Chatdev: Communicative agents for
software \[21\] G. Terry, N. Hayfield, V. Clarke, V. Braun, et al.,
Thematic analysis, development, in: Proceedings of the 62nd Annual
Meeting of the The SAGE handbook of qualitative research in psychology 2
(17-37) Association for Computational Linguistics (Volume 1: Long
Papers), (2017) 25. 2024, pp. 15174--15186. \[22\] M. Chen, J. Tworek,
H. Jun, Q. Yuan, H. P. d. O. Pinto, J. Ka- \[6\] D. Huang, J. M. Zhang,
M. Luck, Q. Bu, Y. Qing, H. Cui, Agentcoder: plan, H. Edwards, Y. Burda,
N. Joseph, G. Brockman, et al., Multi-agent-based code generation with
iterative testing and optimi- Evaluating large language models trained
on code, arXiv preprint sation, arXiv preprint arXiv:2312.13010 (2023).
arXiv:2107.03374 (2021). \[7\] M. A. Islam, M. E. Ali, M. R. Parvez,
Mapcoder: Multi-agent code \[23\] J. Austin, A. Odena, M. Nye, M. Bosma,
H. Michalewski, D. Dohan, generation for competitive problem solving,
in: L. Ku, A. Martins, E. Jiang, C. Cai, M. Terry, Q. Le, et al.,
Program synthesis with large V. Srikumar (Eds.), Proceedings of the 62nd
Annual Meeting of the language models, arXiv preprint arXiv:2108.07732
(2021). Association for Computational Linguistics (Volume 1: Long
Papers), \[24\] Q. Peng, Y. Chai, X. Li, Humaneval-xl: A multilingual
code gen- ACL 2024, Bangkok, Thailand, August 11-16, 2024, Association
for eration benchmark for cross-lingual natural language generalization,
Computational Linguistics, 2024, pp. 4912--4944. doi:10.18653/V1/ arXiv
preprint arXiv:2402.16694 (2024). 2024.ACL-LONG.269. \[25\] F. Lin, D.
J. Kim, et al., Soen-101: Code generation by emulating URL
https://doi.org/10.18653/v1/2024.acl-long.269 software process models
using large language model agents, arXiv \[8\] J. Yang, C. E. Jimenez,
A. Wettig, K. Lieret, S. Yao, K. Narasimhan, preprint arXiv:2403.15852
(2024). O. Press, Swe-agent: Agent-computer interfaces enable automated
\[26\] B. Szalontai, B. Márton, B. Pintér, T. Gregorics, Investigating
repro- software engineering, Advances in Neural Information Processing
ducibility challenges in llm bugfixing on the humanevalfix bench-
Systems 37 (2024) 50528--50652. mark, Software 4 (3) (2025) 17.

Rasheed et al.: Preprint submitted to Elsevier Page 32 of 34  LLM-Based
Multi-Agent Systems for Code Generation

\[27\] J. Liu, C. S. Xia, Y. Wang, L. Zhang, Is your code generated by
chatgpt \[47\] E. Debenedetti, J. Zhang, M. Balunovic, L.
Beurer-Kellner, M. Fis- really correct? rigorous evaluation of large
language models for code cher, F. Tramèr, Agentdojo: A dynamic
environment to evaluate generation, arXiv preprint arXiv:2305.01210
(2023). prompt injection attacks and defenses for llm agents, Advances
in \[28\] M. A. M. Khan, M. S. Bari, X. L. Do, W. Wang, M. R. Parvez, S.
Joty, Neural Information Processing Systems 37 (2024) 82895--82920.
xcodeeval: A large scale multilingual multitask benchmark for code
\[48\] C. Guo, X. Liu, C. Xie, A. Zhou, Y. Zeng, Z. Lin, D. Song,
understanding, generation, translation and retrieval, arXiv preprint B.
Li, Redcode: Risky code execution and generation benchmark for
arXiv:2303.03004 (2023). code agents, Advances in Neural Information
Processing Systems 37 \[29\] N. Huynh, B. Lin, Large language models for
code generation: A (2024) 106190--106236. comprehensive survey of
challenges, techniques, evaluation, and ap- \[49\] C. Tony, M. Mutas, N.
E. D. Ferreyra, R. Scandariato, Llmseceval: plications, arXiv preprint
arXiv:2503.01245 (2025). A dataset of natural language prompts for
security evaluations, in: \[30\] B. Athiwaratkun, S. K. Gouda, Z. Wang,
X. Li, Y. Tian, M. Tan, W. U. 2023 IEEE/ACM 20th International
Conference on Mining Software Ahmad, S. Wang, Q. Sun, M. Shang, et al.,
Multi-lingual evaluation Repositories (MSR), IEEE, 2023, pp. 588--592.
of code generation models, arXiv preprint arXiv:2210.14868 (2022).
\[50\] M. Liu, N. Pinckney, B. Khailany, H. Ren, Verilogeval: Evaluat-
\[31\] T. Helmuth, P. Kelly, Psb2: the second program synthesis
benchmark ing large language models for verilog code generation, in:
2023 suite, in: Proceedings of the Genetic and Evolutionary Computation
IEEE/ACM International Conference on Computer Aided Design Conference,
2021, pp. 785--794. (ICCAD), IEEE, 2023, pp. 1--8. \[32\] Z. Wang, S.
Zhou, D. Fried, G. Neubig, Execution-based evaluation \[51\] N.
Pinckney, C. Batten, M. Liu, H. Ren, B. Khailany, Revisiting for
open-domain code generation, in: Findings of the Association for
verilogeval: A year of improvements in large-language models for
Computational Linguistics: EMNLP 2023, 2023, pp. 1271--1290. hardware
code generation, ACM Transactions on Design Automation \[33\] R. Agashe,
S. Iyer, L. Zettlemoyer, Juice: A large scale distantly of Electronic
Systems (2025). supervised dataset for open domain context-based code
generation, \[52\] H. Yu, B. Shen, D. Ran, J. Zhang, Q. Zhang, Y. Ma, G.
Liang, arXiv preprint arXiv:1910.02216 (2019). Y. Li, Q. Wang, T. Xie,
Codereval: A benchmark of pragmatic code \[34\] F. Cassano, J. Gouwar,
D. Nguyen, S. Nguyen, L. Phipps-Costin, generation with generative
pre-trained models, in: Proceedings of the D. Pinckney, M.-H. Yee, Y.
Zi, C. J. Anderson, M. Q. Feldman, et al., 46th IEEE/ACM International
Conference on Software Engineering, Multipl-e: A scalable and extensible
approach to benchmarking neural 2024, pp. 1--12. code generation, arXiv
preprint arXiv:2208.08227 (2022). \[53\] Y. Huang, J. Luo, Y. Yu, Y.
Zhang, F. Lei, Y. Wei, S. He, \[35\] C. E. Jimenez, J. Yang, A. Wettig,
S. Yao, K. Pei, O. Press, L. Huang, X. Liu, J. Zhao, et al., Da-code:
Agent data science K. Narasimhan, Swe-bench: Can language models resolve
real-world code generation benchmark for large language models, arXiv
preprint github issues?, arXiv preprint arXiv:2310.06770 (2023).
arXiv:2410.07331 (2024). \[36\] G. Kio, Swe-bench-secret: Automating ai
agent evaluation for soft- \[54\] R. Shu, N. Das, M. Yuan, M. Sunkara,
Y. Zhang, Towards effective ware engineering tasks (2025). genai
multi-agent collaboration: Design and evaluation for enterprise \[37\]
Y. Ding, Z. Wang, W. Ahmad, H. Ding, M. Tan, N. Jain, M. K.
applications, arXiv preprint arXiv:2412.05449 (2024). Ramanathan, R.
Nallapati, P. Bhatia, D. Roth, et al., Crosscodeeval: \[55\] Y.
Talebirad, A. Nadiri, Multi-agent collaboration: Harnessing the A
diverse and multilingual benchmark for cross-file code comple- power of
intelligent llm agents, arXiv preprint arXiv:2306.03314 tion, Advances
in Neural Information Processing Systems 36 (2023) (2023). 46701--46723.
\[56\] Z. Yu, Y. Zhao, A. Cohan, X.-P. Zhang, Humaneval pro and mbpp
pro: \[38\] D. Hendrycks, S. Basart, S. Kadavath, M. Mazeika, A. Arora,
E. Guo, Evaluating large language models on self-invoking code
generation, C. Burns, S. Puranik, H. He, D. Song, et al., Measuring
coding arXiv preprint arXiv:2412.21199 (2024). challenge competence with
apps, arXiv preprint arXiv:2105.09938 \[57\] D. G. Paul, H. Zhu, I.
Bayley, Benchmarks and metrics for evaluations (2021). of code
generation: A critical review, in: 2024 IEEE International \[39\] Z.
Wang, S. Liu, Y. Sun, H. Li, K. Shen, Codecontests+: High-quality
Conference on Artificial Intelligence Testing (AITest), IEEE, 2024, test
case generation for competitive programming, arXiv preprint pp. 87--94.
arXiv:2506.05817 (2025). \[58\] M. T. R. Laskar, X.-Y. Fu, C. Chen, S.
B. Tn, Building real-world \[40\] N. Jain, K. Han, A. Gu, W.-D. Li, F.
Yan, T. Zhang, S. Wang, A. Solar- meeting summarization systems using
large language models: A Lezama, K. Sen, I. Stoica, Livecodebench:
Holistic and contamination practical perspective, arXiv preprint
arXiv:2310.19233 (2023). free evaluation of large language models for
code, arXiv preprint \[59\] A. Kulkarni, M. Chakraborty, Blue sky:
Reducing performance gap arXiv:2403.07974 (2024). between commercial and
open-source llms, in: Proceedings of the \[41\] P. Yin, B. Deng, E.
Chen, B. Vasilescu, G. Neubig, Learning to 2025 SIAM International
Conference on Data Mining (SDM), SIAM, mine aligned code and natural
language pairs from stack overflow, in: 2025, pp. 335--338. Proceedings
of the 15th international conference on mining software \[60\] C.
Sypherd, V. Belle, Practical considerations for agentic llm systems,
repositories, 2018, pp. 476--486. arXiv preprint arXiv:2412.04093
(2024). \[42\] D. Rodriguez-Cardenas, D. N. Palacio, D. Khati, H. Burke,
D. Poshy- \[61\] A. Yehudai, L. Eden, A. Li, G. Uziel, Y. Zhao, R.
Bar-Haim, A. Co- vanyk, Benchmarking causal study to interpret large
language models han, M. Shmueli-Scheuer, Survey on evaluation of
llm-based agents, for source code, in: 2023 IEEE International
Conference on Software arXiv preprint arXiv:2503.16416 (2025).
Maintenance and Evolution (ICSME), IEEE, 2023, pp. 329--334. \[62\] G.
Liang, Q. Tong, Llm-powered ai agent systems and their applica- \[43\]
Q. Huang, J. Vora, P. Liang, J. Leskovec, Mlagentbench: Evaluating tions
in industry, arXiv preprint arXiv:2505.16120 (2025). language agents on
machine learning experimentation, arXiv preprint \[63\] K. Wang, G.
Zhang, Z. Zhou, J. Wu, M. Yu, S. Zhao, C. Yin, arXiv:2310.03302 (2023).
J. Fu, Y. Yan, H. Luo, et al., A comprehensive survey in llm (- \[44\]
X. Liu, H. Yu, H. Zhang, Y. Xu, X. Lei, H. Lai, Y. Gu, H. Ding, agent)
full stack safety: Data, training and deployment, arXiv preprint K. Men,
K. Yang, et al., Agentbench: Evaluating llms as agents, arXiv
arXiv:2504.15585 (2025). preprint arXiv:2308.03688 (2023). \[64\] S.
Han, Q. Zhang, W. Jin, Z. Xu, Llm multi-agent systems: Challenges \[45\]
K. Zhang, J. Li, G. Li, X. Shi, Z. Jin, Codeagent: Enhancing code and
open problems, arXiv preprint arXiv:2402.03578 (2024). generation with
tool-integrated agent systems for real-world repo- \[65\] H. Elhashemy,
Y. Lotfy, Y. Tang, Bridging the prototype-production level coding
challenges, arXiv preprint arXiv:2401.07339 (2024). gap: A multi-agent
system for notebooks transformation, in: 2025 \[46\] Z. Z. Wang, A.
Asai, F. F. Xu, Y. Xie, G. Neubig, D. Fried, et al., 40th IEEE/ACM
International Conference on Automated Software Coderag-bench: Can
retrieval augment code generation?, in: Findings Engineering Workshops
(ASEW), IEEE, 2025, pp. 299--302. of the Association for Computational
Linguistics: NAACL 2025, 2025, pp. 3199--3214.

Rasheed et al.: Preprint submitted to Elsevier Page 33 of 34  LLM-Based
Multi-Agent Systems for Code Generation

\[66\] P. Runeson, M. Höst, Guidelines for conducting and reporting case
1 (1) (2024) 9. study research in software engineering, Empirical
software engineer- \[85\] Z. Xi, W. Chen, X. Guo, W. He, Y. Ding, B.
Hong, M. Zhang, J. Wang, ing 14 (2009) 131--164. S. Jin, E. Zhou, et
al., The rise and potential of large language model \[67\] E. Blair, A
reflexive exploration of two qualitative data coding tech- based agents:
A survey, Science China Information Sciences 68 (2) niques, Journal of
Methods and Measurement in the Social Sciences (2025) 121101. 6 (1)
(2015) 14--29. \[86\] Y. Dong, X. Jiang, J. Qian, T. Wang, K. Zhang, Z.
Jin, G. Li, A \[68\] S. Keele, et al., Guidelines for performing
systematic literature re- survey on code generation with llm-based
agents, arXiv preprint views in software engineering (2007).
arXiv:2508.00083 (2025). \[69\] F. Quin, D. Weyns, M. Galster, C. C.
Silva, A/b testing: a systematic literature review, Journal of Systems
and Software (2024) 112011. \[70\] Z. Zheng, K. Ning, Y. Wang, J. Zhang,
D. Zheng, M. Ye, J. Chen, A survey of large language models for code:
Evolution, benchmarking, and future trends, arXiv preprint
arXiv:2311.10372 (2023). \[71\] I. Ozkaya, Application of large language
models to software engi- neering tasks: Opportunities, risks, and
implications, IEEE Software 40 (3) (2023) 4--8. \[72\] A. Fan, B.
Gokkaya, M. Harman, M. Lyubarskiy, S. Sengupta, S. Yoo, J. M. Zhang,
Large language models for software engineering: Survey and open
problems, in: 2023 IEEE/ACM International Conference on Software
Engineering: Future of Software Engineering (ICSE-FoSE), IEEE, 2023,
pp. 31--53. \[73\] X. Hou, Y. Zhao, Y. Liu, Z. Yang, K. Wang, L. Li, X.
Luo, D. Lo, J. Grundy, H. Wang, Large language models for software
engineer- ing: A systematic literature review, ACM Transactions on
Software Engineering and Methodology (2023). \[74\] Q. Zhang, T. Zhang,
J. Zhai, C. Fang, B. Yu, W. Sun, Z. Chen, A critical review of large
language model on software engineering: An example from chatgpt and
automated program repair, arXiv preprint arXiv:2310.08879 (2023). \[75\]
R. A. Husein, H. Aburajouh, C. Catal, Large language models for code
completion: A systematic literature review, Computer Standards &
Interfaces 92 (2025) 103917. \[76\] J. Wang, Y. Huang, C. Chen, Z. Liu,
S. Wang, Q. Wang, Software testing with large language models: Survey,
landscape, and vision, IEEE Transactions on Software Engineering 50 (4)
(2024) 911--936. \[77\] Z. Zheng, K. Ning, Q. Zhong, J. Chen, W. Chen,
L. Guo, W. Wang, Y. Wang, Towards an understanding of large language
models in software engineering tasks, Empirical Software Engineering 30
(2) (2025) 50. \[78\] J. Shi, Z. Yang, D. Lo, Efficient and green large
language models for software engineering: Literature review, vision, and
the road ahead, ACM Transactions on Software Engineering and Methodology
34 (5) (2025) 1--22. \[79\] M. K. Görmez, M. Yılmaz, P. M. Clarke, Large
language models for software engineering: A systematic mapping study,
in: European Conference on Software Process Improvement, Springer, 2024,
pp. 64--79. \[80\] B. V. L. d. Albuquerque, A. F. S. d. Cunha, L. Souza,
S. W. M. Siqueira, R. P. d. Santos, Generating and reviewing programming
codes with large language models: A systematic mapping study, in:
Proceedings of the 20th Brazilian Symposium on Information Systems,
2024, pp. 1--10. \[81\] Q. Zhang, C. Fang, Y. Xie, Y. Ma, W. Sun, Y.
Yang, Z. Chen, A systematic literature review on large language models
for automated program repair, arXiv preprint arXiv:2405.01466 (2024).
\[82\] L. Cao, S. Li, Y. Fan, D. Li, C. Zhong, Towards the next
generation of software: Insights from grey literature on ai-native
applications, CoRR abs/2509.13144 (2025). arXiv:2509.13144,
doi:10.48550/ARXIV .2509.13144. URL
https://doi.org/10.48550/arXiv.2509.13144 \[83\] T. Guo, X. Chen, Y.
Wang, R. Chang, S. Pei, N. V. Chawla, O. Wiest, X. Zhang, Large language
model based multi-agents: A survey of progress and challenges, in:
Proceedings of the Thirty-Third Interna- tional Joint Conference on
Artificial Intelligence, IJCAI 2024, Jeju, South Korea, August 3-9,
2024, ijcai.org, 2024, pp. 8048--8057. URL
https://www.ijcai.org/proceedings/2024/890 \[84\] X. Li, S. Wang, S.
Zeng, Y. Wu, Y. Yang, A survey on llm-based multi- agent systems:
workflow, infrastructure, and challenges, Vicinagearth

Rasheed et al.: Preprint submitted to Elsevier Page 34 of 34 
