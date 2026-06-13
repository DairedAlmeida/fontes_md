                                                     Reflections on the Reproducibility of Commercial LLM
                                                     Performance in Empirical Software Engineering Studies
                                                        Florian Angermeir                                      Maximilian Amougou                                            Mark Kreitz
                                                     angermeir@fortiss.org                                        amougou@fortiss.org                              mark.kreitz@unibw.de
                                                fortiss and Blekinge Institute of                                       fortiss                             University of the Bundeswehr Munich
                                                          Technology                                               Munich, Germany                                    Munich, Germany
                                               Munich and Karlskrona, Germany
                                                          and Sweden

                                                           Andreas Bauer                                         Matthias Linhuber                                          Davide Fucci

arXiv:2510.25506v3 \[cs.SE\] 17 Nov 2025

                                                     andreas.bauer@bth.se                                    matthias.linhuber@tum.de                                 davide.fucci@bth.se
                                                Blekinge Institute of Technology                           Technical University of Munich                       Blekinge Institute of Technology
                                                      Karlskrona, Sweden                                         Munich, Germany                                      Karlskrona, Sweden

                                                         Fabiola Moyón C.                                           Daniel Mendez                                         Tony Gorschek
                                                   fabiola.moyon@siemens.com                                  daniel.mendez@bth.se                                  tony.gorschek@bth.se
                                                            Siemens AG                                 Blekinge Institute of Technology and                  Blekinge Institute of Technology and
                                                         Munich, Germany                                               fortiss                                               fortiss
                                                                                                       Karlskrona and Munich, Sweden and                     Karlskrona and Munich, Sweden and
                                                                                                                     Germany                                               Germany

                                         Abstract                                                                                CCS Concepts
                                         Large Language Models have gained remarkable interest in indus-                         • General and reference → Empirical studies; • Software and
                                         try and academia. The increasing interest in LLMs in academia is                        its engineering; • Computing methodologies → Artificial intel-
                                         also reflected in the number of publications on this topic over the                     ligence;
                                         last years. For instance, alone 78 of the around 425 publications at
                                         ICSE 2024 performed experiments with LLMs. Conducting empir-                            Keywords
                                         ical studies with LLMs remains challenging and raises questions                         Reproducibility, Large Language Models, Empirical Software Engi-
                                         on how to achieve reproducible results, for both researchers and                        neering, Artefact Evaluation
                                         practitioners. One important step towards excelling in empirical
                                         research on LLM and their application is to first understand to                         ACM Reference Format:
                                         what extent current research results are eventually reproducible                        Florian Angermeir, Maximilian Amougou, Mark Kreitz, Andreas Bauer,
                                         and what factors may impede reproducibility. This investigation is                      Matthias Linhuber, Davide Fucci, Fabiola Moyón C., Daniel Mendez, and Tony
                                                                                                                                 Gorschek. 2026. Reflections on the Reproducibility of Commercial LLM Per-
                                         within the scope of our work.
                                                                                                                                 formance in Empirical Software Engineering Studies. In 2026 IEEE/ACM
                                            We contribute an analysis of the reproducibility of LLM-centric                      48th International Conference on Software Engineering (ICSE ’26), April 12–18,
                                         studies, provide insights into the factors impeding reproducibility,                    2026, Rio de Janeiro, Brazil. ACM, New York, NY, USA, 13 pages. https:
                                         and discuss suggestions on how to improve the current state. In                         //doi.org/10.1145/3744916.3773207
                                         particular, we studied the 85 articles describing LLM-centric studies,
                                         published at ICSE 2024 and ASE 2024. Of the 85 articles, 18 provided
                                         research artefacts and used OpenAI models. We attempted to repli-
                                                                                                                                 1     Introduction
                                         cate those 18 studies. Of the 18 studies, only five were sufficiently                   Large Language Models (LLMs) such as GPT, Gemini, and LLaMA
                                         complete and executable. For none of the five studies, we were able                     have shown impressive capabilities for various software engineer-
                                         to fully reproduce the results. Two studies seemed to be partially                      ing tasks [1, 2, 3]. Reflecting this trend, the Software Engineering
                                         reproducible, and three studies did not seem to be reproducible.                        (SE) research community has increasingly explored the use of LLMs
                                         Our results highlight not only the need for stricter research artefact                  as both a subject of research and as tools for research [4, 5]. This
                                         evaluations but also for more robust study designs to ensure the                        trend is also evident in significant funding initiatives of more than
                                         reproducible value of future publications.                                              1$ billion across the European Union1 , United States2 , and China,
                                                                                                                                 leading to research increasingly centered around, or enabled by
                                                                                                                                 LLMs. In this work, when we refer to LLMs, we mean autoregressive
                                                                                                                                 models (e.g., GPT, LLaMA, Mistral), as opposed to language models
                                         This work is licensed under a Creative Commons Attribution 4.0 International License.   like BERT or T5, which are pretrained for different purposes.
                                         ICSE ’26, Rio de Janeiro, Brazil
                                         © 2026 Copyright held by the owner/author(s).
                                                                                                                                 1 https://digital-strategy.ec.europa.eu/en/policies/genai4eu
                                         ACM ISBN 979-8-4007-2025-3/2026/04
                                         https://doi.org/10.1145/3744916.3773207                                                 2 https://www.nsf.gov/news/nsf-partners-kick-nairr-pilot-program

ICSE '26, April 12--18, 2026, Rio de Janeiro, Brazil Angermeir et al.

A key characteristic of LLMs is their non-deterministic nature,
introduction to Bayesian bootstrapping, the ACM badges, and our which
manifests in different outputs for identical repeated queries online
material enabling reproducibility. to the same model. This
non-determinism in combination with the lack of profound understanding
of the factors influencing output 2.1 Definitions performance, along
with the rapidly evolving models, raises ques- We adopt the definitions
of the ACM \[15\]: tions about the reproducibility of LLM-centric
empirical SE studies. Several recent studies highlighted the
difficulties of reproducing Reproducibility: "The measurement can be
obtained with stated findings of LLM-centric empirical studies, in SE
\[6, 7, 8\], but also precision by a different team using the same
measurement pro- in other disciplines such as political science \[9\],
and medicine \[10\]. cedure, the same measuring system, under the same
operating Some empirical studies explicitly acknowledge the unlikeliness
of conditions, in the same or a different location on multiple trials.
reproduction of their findings: "Please note that due to the non- For
computational experiments, this means that an indepen- deterministic
nature of LLMs, it is unlikely that exact replication dent group can
obtain the same result using the author's own of our results will be
possible. However, similar results should be artifacts." obtainable."
\[11\]. At this point, one could argue that already existing
Replicability: "The measurement can be obtained with stated pre- deep
learning methods face the same reproduction issues given cision by a
different team, a different measuring system, in their inherent
non-determinism. We agree that existing research a different location on
multiple trials. For computational ex- addressed reproducibility in deep
learning---e.g., \[12\]. However, the periments, this means that an
independent group can obtain reproducibility of LLMs-centric studies
faces additional challenges the same result using artifacts which they
develop completely such as predominant usage of proprietary models,
frequent model independently." updates without transparent changes,
higher degree of configura- In our work, as we aim to repeat studies
that entail commercial bility, and strong dependence on prompt
engineering. LLMs, several variables do not resonate with the ACM's
defini- To this day, substantial resources have been invested into LLM-
tion of reproducibility, but also do not qualify for the definition
centric research--not only financially, but also in terms of environ- of
replicability, such as changes to LLMs, and imperfect replica- mental
impact and academic attention. If those research results can tion
packages. However, the two terms have not been uniformly not be reliably
reproduced, these studies risk becoming time-bound defined in the
research communities, even contradicting each other artefacts providing
a snapshot of the technology capabilities rather \[16, 17\], while some
authors argue that no distinction should be than building blocks of
cumulative scientific knowledge. This con- made between them \[18, 19\].
Given the grey area we interact in cern is exacerbated by the historical
lack of replication culture in and our motivation to validate the
results, we will---unless other- SE, despite improvements in recent
years \[13, 14\]. wise specified---use the terms interchangeably to
refer to our act of To tackle this challenge in the long term, it is
important to first repeating the studies and analysing the obtained
results. understand the state of reproducibility of LLM-centric
empirical Software Engineering studies and indicators towards enhanced
or degraded reproducibility. This is in the scope of our study presented
2.2 Non-Determinism & Reproducibility in this paper. In particular, we
aim to answer the following research Assuming that reproduction serves
as a means to uncover the true questions: effects of a subject being
studied, a high confirmatory reproduction RQ1 To what extend are
LLM-centric SE studies reproducible? rate of research findings is
desirable. However, the confirmatory RQ2 Which factors impede the
reproduction of LLM-centric em- reproduction rate of research findings
has historically been low in pirical SE studies? software engineering
\[14\], but also in more mature fields such as RQ3 How well do the ACM
artefact badges reflect the state of psychology \[20, 21\]. In the
context of LLMs, various studies have reproducibility of LLM-centric SE
studies? acknowledged the importance and issues with replicability
(e.g., \[22, 6\]) even to the point of acknowledging potential
non-replicability As a basis for our investigations, we analyse this at
the exam- due to non-determinism, such as \[11\]. ple of publications
presented at the International Conference on Given that non-determinism
strongly contributes to the power Software Engineering (ICSE) and
Automated Software Engineering of Large Language Models, evaluating the
performance of an LLM (ASE), both in their 2024 edition, considering the
diversity of topics in the light of non-determinism plays a vital role.
To this day, we in their programs and research methods applied, but also
due to the know some of the variables that influence non-determinism,
such high ambition with respect to rigour, relevance, and validity. It
is as temperature \[23\], prompting style \[7\], or hardware \[24\].
Despite also important for us to note that our ambition is not to
criticise in- partly contradictory investigations such as \[25\] and
\[26\], it remains dividual contributions, let alone individual
researchers. We believe unclear to what extent each factor influences
non-determinism \[23\]. that their work was guided by what may generally
be considered This inherent non-determinism of LLMs impacts the
robustness of to be of high scientific standard and, thus, allows us to
critically its performance \[27, 28, 26\], hence it impacts their
reproducibility. reflect upon the overall state of reproducibility of
LLM-centric SE To estimate the non-determinism of LLMs, recent research
fo- research in the community and how to improve it. cuses on
quantifying the uncertainty associated with LLMs when performing tasks.
To do so, research distinguishes between epis- 2 Background temic (lack
of knowledge) and aleatoric (multiple solutions possible) In this
section, we define the relevant terms, discuss LLMs inherent
uncertainties. There have been various approaches proposed to esti-
non-determinism and implications for reproducibility, give a brief mate
uncertainties \[29\], such as \[30\] or \[31\]. However, the inherent
Reflections on the Reproducibility of Commercial LLM Performance in
Empirical Software Engineering Studies ICSE '26, April 12--18, 2026, Rio
de Janeiro, Brazil

challenges of these approaches render their application infeasi- 2.4
Reproduction Framework ble for replication purposes. First, many
approaches are bound to As our work faces the risk of getting outdated
fast, we aim to pro- one perspective, like quantifying hallucinations.
Second, these ap- vide our work in a reproducible fashion, potentially
for future meta- proaches may involve modifying the original task (e.g.,
through analysis. For that purpose, we developed a simple reproduction
iterative prompting like in \[30\]). Finally, the uncertainty varies
framework that enables direct execution of the analysed studies. across
different models \[31\] and tasks. It appears to be unrealistic to The
framework has been built by five of the authors. It is based develop a
comprehensive function for estimating non-determinism. on
containerisation to ensure platform independence and version This
renders statistical power estimations---such as determining
stability---to the extent possible. Each reproduced study is integrated
how many times an experiment with an LLM must be run to achieve in a way
that the research artefacts are downloaded on demand, and, a reliable,
statistically significant result---only possible in small and if
necessary, modified transparently by the reproduction framework. highly
controlled setups. This limitation poses a significant threat to This
has two advantages. First, we do not infringe intellectual prop- the
validity of reproduction studies that seek comparability across erty
(e.g., if authors did not publish the artefacts with a license), and
multiple studies. second, the changes are transparent, hence they can be
verified---or In addition to intrinsic factors of non-determinism,
extrinsic challenged. The reproduction framework is openly available
here time-related factors have a critical impact on LLM performance,
\[38\]. in at least two ways. First, LLMs evolve rapidly over time
through regular updates, leading to different model versions, such as
those 2.5 ACM Badges reflected in OpenAI's minor versioning system
(e.g., gpt-4o-2024- 05-13 is a minor version of the gpt-4o-model). This
change in model ACM offers three major types of badges \[15\]: The
artifacts available, versions can impact the consistency of LLMs
performance, depend- artifacts evaluated, and results validated badges.
The available badge ing on the individual task and context. Academic
literature \[32, signifies that the associated artefacts are archived
permanently. The 33\], as well as literature by model providers \[34\],
acknowledge this evaluated badges are for those papers that provide
artefacts to the time-related factor. For example, OpenAI tries to
mitigate negative reviewers for critical review of the artefacts
documentation, consis- performance impacts through their own and
community-sponsored tency, completeness, and exercisability. Finally,
the results validated benchmarks. However, those benchmarks cannot cover
the broad badges are for those papers, whose results have been
successfully variety of LLM tasks defined in the research community.
Second, confirmed in a separate study. The review process for each of
those for time-dependent tasks in which information gets outdated fast,
badges is not prescribed by ACM, and its interpretation is to some older
models may provide less relevant information, resulting in extent left
open to those chairing individual venues. For example decreased
performance. It remains unclear how the general perfor- ICSE 2021
deviated from ACM's requirements3 . mance of a fixed version of a model
evolves over time, particularly for LLMs of commercial providers. For
instance, OpenAI claims 3 Methodology that a "pinned model is stable,
meaning that we won't make changes We analysed, through a critical
review \[39\] and reproduction anal- that impact the outputs" \[34\].
However, it has yet to be evidently ysis, LLM-centric empirical software
engineering studies from the shown to what extent this promise holds in
practice. highly influential software engineering conferences:
International Conference on Software Engineering 2024 and Automated
Software Engineering 2024. We reproduced studies where feasible and pro-
vided a reproduction package at \[40\]. Figure 1 provides a visual 2.3
Baysian Bootstrap summary of our research approach. The Bayesian
bootstrap \[35\] is a method to generate insights into data without
knowing its underlying distribution. It does so by 3.1 Literature Review
simulating multiple random draws from a potential distribution We
conducted a literature review in the form of a critical review over the
existing data. It differs insofar from non-parametric boot- as described
by Ralph and Baltes \[39\] to identify relevant articles straping as it
does not resample the data, but rather weights the containing LLM
replication packages. individual data. For a general introduction and
visualisation, con- sider the original publication by Rubin \[35\] or
this blogpost by Article sources. As sources for articles, we choose the
proceed- Bååth \[36\]. In our work, we focus on the analysis of the
confidence ings of ICSE 2024 \[41\], as the representative conference
for the intervals over the data instead of on a specific statistic, as
is done software engineering community. Given the resource intensity of
traditionally in the Bayesian bootstrap. For that purpose, we follow
this research, we decided against conferences with focus on specific the
procedure described in \[37\]. We run the procedure 10.000 times aspects
of software engineering such as MSR or ICSME. and calculate the mean for
percentiles over all estimations to obtain We also did not consider the
proceedings of previous years, as the final percentile value. We do this
analysis for the following they did not contain relevant studies at
scale and due to concerns percentiles: 2.5th, 5th, 10th, 25th, 50th,
75th, 90th, 95th, 97.5th. This about the timeliness of those results.
For the same timeliness reason allows us to set the originally-reported
values into perspective of we did not opt for journals, which have a
longer review cycle. At the values obtained through reproduction,
allowing us to make the time this study was conducted, the ICSE
proceedings for 2025 statements within a 95% interval, within which we
consider the reproduction to be likely. Outside this 95% interval, we
perceive 3
https://conf.researchr.org/track/icse-2021/icse-2021-Artifact-Evaluation#Call-For-
the reproduction as unlikely. Artifact-Submissions ICSE '26, April
12--18, 2026, Rio de Janeiro, Brazil Angermeir et al.

                                                                    motivates   reviewed the 109 articles and identified 31 articles that were out of
                    ICSE                                    ASE
                                                                                our scope, resulting in 78 relevant articles.
        425 articles                                           314 articles        Later, we complemented the low number of suitable articles from
                                                                                ICSE with those from ASE in an iterative process. In this iterative
                   Search                                  Search
                                                                                process, we did not aim for completeness, but instead focused on
                                                               108 articles
                                                                                selected articles with an ACM artefact badge, to strengthen our
                                                                                critical review [39] while adding the angle of automation, espe-
                                                       Exclusion: no            cially to strengthen the results of RQ3. Here we operated under
        109 articles
                                                       artifact badge           the assumption, that ACM badges would guarantee a high artefact
                                                               7 articles       quality, hence signal a higher readiness for reproduction. Whether
                                                                                this holds true is to be seen in Section 4. This process resulted in
            Manual Exclusion                          Manual Exclusion          seven relevant ASE articles.
          78 articles                                          7 articles          Data Extraction. We iteratively extracted all relevant metadata of
                                                                                articles, as well as the published research artefacts, to select suitable
               Extract data
                                                                                articles and collected them into a spreadsheet. This includes the
          78 articles                                                           following information: (a) conducted LLM experiment, (b) contains
                     7 articles                                                 ACM artefact badge, (c) LLM name, (d) availability of research
          Inclusion/Exclusion:                                                  artefact/data, (e) performs a comparison between LLMs, (f) defines
             OpenAI usage                                                       temperature, (g) report top-p, top-k, (h) report prompts, (i) handles
          63 articles                                                           context window limitations, and (j) detailed model version.
                     6 articles
              Seemingly fit                                                        Exclusion of Articles. As the extraction revealed, over 70% of the
            for reproduction                                                    articles utilised LLMs provided by OpenAI as the primary model
          13 articles                                                           or as a benchmark model. Complemented with the motivation to
                      5 articles                                                provide a unified setup that facilitates reproduction, validation, and
            Reproduction by                                                     extension of our work, we excluded all articles that did not use
             five researcher                                                    OpenAI’s models. Although this limits the generalisability of our
                                                                                findings to a single model provider, it aligns with the focus of our
                                                                                research—commercial LLMs. Additionally, OpenAI models were

5 articles fit for reproduction used by a significant portion of the
analysed articles. Next, we excluded all articles that did not provide a
research Figure 1: Summary of Research Approach artefact or data. Over
two-thirds of the articles either lacked a reference to a research
artefact at all or were incomplete so that the retrieval of artefacts
was not possible. This encouraged us to had not been published, hence
newer studies were not available for perform a second iteration, with
articles published at ASE, where analysis. we additionally excluded
articles without an ACM artefact badge Of ICSE 2024, we considered the
following tracks for this study: to counter the issue of missing or
incomplete artefacts resulting research, companion, nier, seis, and
seip. Due to the low number of in a total of 85 articles, of which 69
used OpenAI models. From available and executable research artefacts, we
also included the those 69 articles, 18 seemed to provide complete and
executable proceedings of ASE 2024 \[42\], as ASE is the top venue for
automated research artefacts and data at first inspection. We call those
fit for software engineering, which aligns well with the notion of LLMs
reproduction. as automation and tooling. Search Query & Filtering. To
identify relevant articles, we searched 3.2 Analysis through the 425
ICSE articles directly via the proceedings PDFs We perform the analysis
from three different perspectives, each using keywords in the title,
abstract, and author keywords. For laid out in the following. the
keywords, we iteratively defined a set of keywords based on our
experience of identifying relevant literature during our earlier RQ1.
For RQ1, we used the 18 articles that seemed fit for re- contributions
to the LLM guidelines \[43\]. This left us with a final set production.
To that end, a team of five researchers developed a of the following
keywords: genai, llm, large language model, prompt, framework to
systematically execute replication code for analysing chain-of-thought,
chain of thought, zero-shot, zero shot, few-shot, and reproducing
research artefacts. To ensure platform indepen- few shot, llama, claude,
mistral, gemini, openai, gpt. The automatic dence, we provide a stable
environment by containerising all study search resulted in 109 articles.
We reviewed a sample of the au- experiments. The containerised version
of the experiments makes tomatically excluded articles to ensure no
relevant literature was its dependencies explicit, where missing
dependencies were sup- missed. To cover as much empirical research as
possible, the initial plemented with suitable versions. Each of the five
authors indepen- exclusion focused on (1) non-empirical research, and
(2) research dently analysed the repeatability of at least two of the 18
studies with non-autoregressive LLMs (e.g., BERT). Two authors manually
adhering to the following process: Reflections on the Reproducibility of
Commercial LLM Performance in Empirical Software Engineering Studies
ICSE '26, April 12--18, 2026, Rio de Janeiro, Brazil

(1) Access the research artefact and verify if the code and data RQ2.
    For RQ2, we took two perspectives. A meta-analytical one, are
    complete for reuse according to the ACM definition of and an
    experimental one. For the meta-analytic perspective, we reusability
    \[15\], this rendered 13 articles ill-suited for repro- analysed the
    data extracted from all 85 articles to understand the duction.
    general reasons for non-reproducibility. In the experimental one,

(2) Execute the research artefact as it is, document challenges, we took
    the 18 articles that provided a research artefact and aimed and
    address any hurdles, provided that the modifications do to
    understand the factors that directly impact reproducibility during
    not impact the experiment's functionality. We will discuss
    reproduction. these alterations in the Threats to Validity section.
    For the meta-analytic perspective, we first analysed the availabil-

(3) Create automation tasks for the research artefacts within ity and
    completeness of research artefacts and data as the prerequi- the
    framework. sites for reproducibility. For a deeper analysis, we
    oriented ourselves

(4) Multiple executions of replication artefacts within the frame- on
    the guidelines 5.2, 5.3, and 5.4 of the LLM guidelines for software
    work. engineering \[43\]. Specifically, we investigated the
    reporting of the

(5) Document observations. model versions, the temperature as well as
    top-p/top-k parameters as representatives for the model
    configuration (guideline 5.2). As To minimise researcher bias and
    ensure functional correctness, representative for guideline 5.3, we
    investigated the description portability, and understandability,
    each study's integration and of context window considerations as
    part of a mindful architec- modification were reviewed by another
    co-author before being in- ture to ensure robust reuse. Finally, we
    checked whether prompts tegrated into the framework. This code
    review was facilitated by were reported in the article, or where not
    feasible, described in initial meetings of all authors involved in
    the reproduction pro- prompt templates (guideline 5.4). Those
    characteristics do not cover cess. Those meetings led to a mutual
    understanding regarding the the LLM guidelines in their entirety,
    but provide first insights into process and the review criteria
    among the authors. The reviews the current state of practice,
    especially under the hypothesis, that focused on the correctness of
    the automation, containerisation, adherence to those guidelines will
    improve reproducibility. Two portability to other environments, and
    the clarity of interventions, authors collaboratively extracted
    those characteristics. comments, results and documentation. We
    documented the changes We approached the experimental perspective
    from two angles. transparently in our supplementary online material
    \[40\]. The first angle investigated the existence of the before
    described As we discussed in Section 2, estimating the required
    number characteristics in the research artefacts of the 18 articles.
    The second of artefact runs per study to ensure statistical
    significance is not angle was fed by the issues faced during the
    reproduction attempts feasible. However, we can attempt to repeat
    each experiment run in RQ1. Each author independently documented the
    issues faced until its prediction interval is below a certain
    threshold \[24\]. While during the reproduction attempts.
    Afterwards, those issues were this approach is suitable for
    individual studies, it can become com- discussed among the authors
    and aggregated for reporting. putationally expensive in the context
    of multiple studies. This is RQ3. For RQ3, we examined the
    association between ACM arte- due to the high costs associated with
    each experimental run, which fact badges and the reproducibility
    attempts of the 18 articles. For can reach up to \$600, as noted in
    \[44\]. Hence, we chose to adopt a that purpose, two authors coded
    all articles based on their assigned more practical approach. Each
    study was conducted up to 30 times badges: Artifacts Available v1.1,
    Artifacts Evaluated - Functional v1.1, or until we reached a cost of
    \$500. Although it may not be statisti- and Artifacts Evaluated -
    Reusable v1.1. Informed by the outcomes cally significant, we
    consider 30 repetitions to be a sufficiently large of the
    reproduction efforts from RQ1, and the analysis of factors sample
    size to make a practical statement about the likelihood of impeding
    reproduction, we drew conclusions on whether the badge successfully
    reproducing the research results. The cost cap of \$500 types
    reliably signaled reproducibility. was dictated by the budget for
    the research, taking into considera- The resulting data for all
    analyses are available in the online tion the number of executable
    studies. The costs were monitored material \[40\]. through the
    OpenAI API dashboard. This cost cap impacted one study (\[45\]). We
    report the reproduction costs for each study in 4 Results Section 4.
    We have not contacted the authors of the studies for replication to
    assist in recovering artefacts and replicating results. For ICSE
    2024, the search yielded 109 articles. Of those 109 articles, Help
    by the original authors could introduce potential bias \[46\] and 78
    performed experiments with LLMs. At ASE 2024, 108 articles
    contradict our aim of independently replicating results. performed
    experiments with LLMs. Of those, seven articles were After
    reproduction, we analyse the results from two perspectives: awarded
    an ACM artefact badge. Hence, we analysed a total of 85
    descriptively and using Bayesian bootstrapping. As descriptive anal-
    articles. Of those 85 articles, 69 employed OpenAI services as their
    ysis, we report the difference between LLM performance metrics base
    model or for comparison. In total, 43 of 85 articles compared
    observed by us and reported in the articles. Furthermore, we pro-
    multiple LLMs. Figure 2 depicts the top 10 models used in the 85
    vide a full list and a graphical representation of all reproduced
    papers, highlighting again the dominance of OpenAI services in
    metrics in our online material \[40\]. To account for the inherent
    academia as per 2024. uncertainty in the LLM's performance, we
    employ a version of Bayesian bootstrapping focused on confidence
    intervals \[37\] as 4.1 RQ1: To what extend are LLM-centric SE
    described in Section 2.3. We apply Bayesian bootstrapping on the
    studies reproducible? observed metrics to understand whether the
    originally reported Out of 69 studies using OpenAI services, only
    five studies were metrics are likely in light of the observed
    metrics. fit for reproduction. Below, we briefly introduce each,
    identify ICSE '26, April 12--18, 2026, Rio de Janeiro, Brazil
    Angermeir et al.

           gpt-4                                                           23
                                                                                     prompts on code summarisation tasks with six different program-
                                                                                     ming languages. As a baseline, BM25 prompting is used, which is
         gpt-3.5-turbo                                                  17
                                                                                     a few-shot prompting approach leveraged by exemplars that are
         gpt-3.5                                          14                         "semantically close" to the target [48]. All augmentations combined

    text-davinci-003 8 on top of BM25 form the presented ASAP method.
    chatgpt 7 Variables impacting reproduction: Most of the study was
    per- starcoder 6 formed on the deprecated code-davinci-002 model.
    Thus, this part, which, e.g., included the experiments on the
    individual impact of codegen 5 each augmentation, cannot be
    reproduced. However, a comparison code-davinci-002 5 between
    different LLMs is made, evaluating the effectiveness of the gpt-2 3
    ASAP method for summarisations of Java, Python, and PHP code.
    gpt-4-0613 3 Of the three models used, only gpt-3.5-turbo is still
    available. The authors did not state a specific model version,
    neither in the paper 5 10 15 20 25 nor in the research artefact. We
    used gpt-3.5-turbo-0125 for repro- \# Occurences duction.
    Furthermore, no explicit instructions on how to run the experiments
    with the ASAP method were given. We assumed to run it by enabling
    the feature flag for all augmentations. Lastly, versions Figure 2:
    Top 10 LLMs Employed in the Analyzed 85 Articles. for the
    dependencies in the code were not stated, causing issues with
    deprecated functions. These could be solved by installing older
    versions of the affected libraries. Results: We ran 30 repetitions
    of the experiment, which amounted reproducibility-impacting
    variables, and summarise our findings. to approximately \$30. Table
    1 shows that none of the results re- Details on the factors
    rendering the remaining 64 studies unfit for ported by \[47\] are
    within our 95% intervals. Our data shows that the reproduction can
    be found under RQ2. code summarisation of gpt-3.5-turbo for the
    baseline task (BM25) Reproduction of \[45\]. The study by Pan et
    al. \[45\] investigated the significantly outperforms the reported
    results for Java and Python, capabilities of LLMs to translate code
    from one programming lan- while falling behind in PHP. The ASAP
    method still slightly out- guage to other programming languages.
    They tested seven LLMs for performs the baseline in Java. However,
    the results have drastically their performance of correct
    translation over five datasets. Given the changed for Python and
    PHP, where it is now underperforming. size of the experiment---and
    the associated costs---we ran a subset The strong changes indicate
    that the possibly newer version of of those experiments: We repeated
    their experiments of translating gpt-3.5-turbo we used requires
    different prompting than the one from Python and Go to the other
    programming languages over the used in the original experiments.
    dataset CodeNet (see Table 2 in the original study). Given that each
    Summary: None of the results that use available models could be
    experiment repetition costs approximately \$30, we decided to run
    reproduced within our experiments. 15 repetitions, amounting to a
    total of approximately \$450. The results and the generated evidence
    can be observed in our online Reproduction of \[49\]. The study of
    Siddiq et al. \[49\] evaluated the material \[40\]. capabilities of
    LLMs to generate regular expressions from natural Variables
    impacting reproduction: The paper did not come with language prompts
    and assessed the functional correctness and secu- a pre-built
    run-time for all five programming languages. Using the rity (i.e.,
    resistance to ReDoS attacks) of generated regexes. For each versions
    mentioned in their paper, we containerised a run-time of- prompt,
    the authors tested regexes generated by four LLMs. They fered for
    review in our online material \[40\]. Additionally, no minor
    evaluated the generated regexes using four metrics (exact match,
    version for the employed model (GPT-4) was specified, impeding a
    DFA-equivalence@k, and pass@k, vulnerable@k). The results and direct
    reproduction. We used gpt-4-0613. the generated evidence can be
    observed in our online material \[40\]. Results: For the translation
    from Python to other programming We repeated the experiment 30
    times, amounting to approximately languages, Pan et al. reported an
    average successful translation \$30. ratio of 79.9%. Given the
    average successful translation ratios we Variables impacting
    reproduction: Text-DaVinci-003 was al- obtained in our 15 runs, we
    calculated a 95% interval range from ready deprecated when we
    started our experiment. Although the 45.6% to 55.3%. For the
    translation from Go to other programming paper specifies that the
    June 2023 version of GPT-3.5-Turbo was languages, we arrived at a
    95% interval ranging from 50.1% to 54.5% used, this was not
    indicated in the released code. Hence, we used the with an
    originally reported value of 85.5% of average successful current
    model gpt-3.5-turbo-0125. In addition, the artefact lacked
    translations. The maximum average successful translation ratio we
    the evaluation code. We could reconstruct the evaluation based on
    saw for Python and Go was 56% and 55%. the provided documentation
    using the default configurations. We Summary: For the experiments we
    repeated, we could not only not were not able to reconstruct the
    metric unparseable. The changes reproduce the results, but are far
    off with our results as becomes are transparent in the online
    material \[40\]. apparent from the \[45\]-section of Table 1.
    Results: Five of the originally reported values are likely to be
    reproducible (see \[49\] of Table 1 for two examples) with the
    follow- Reproduction of \[47\]. The study by Ahmed et al. \[47\]
    evaluates ing minimum/maximum values: DFA-EQ@3 Refined
    (11.55/15.49), the effect of three different automatic semantic
    augmentations for vul@1𝑅𝑒𝑠𝑐𝑢𝑒 (0.25/0.45), vul@3𝑅𝑒𝑠𝑐𝑢𝑒 (0.83/1.41),
    vul@10𝑅𝑒𝑠𝑐𝑢𝑒 (1.31 Reflections on the Reproducibility of Commercial
    LLM Performance in Empirical Software Engineering Studies ICSE '26,
    April 12--18, 2026, Rio de Janeiro, Brazil

/2.36), vul@10𝑅𝑒𝐷𝑜𝑆𝐻𝑢𝑛𝑡𝑒𝑟 (8.77/11.40). The small windows between
sub-datasets. As these are 32 combinations, we will here only give
minimum and maximum observed values speak for the stability a summary of
the reproducibility results. For 25 of the 32 combina- of the results.
The remaining 21 of the originally reported values tions, the originally
reported values were within the 95% ranges we were outside of the
calculated 95% interval. For those values that found in 30 repetitions.
For two combinations (HPC-ED, Apache- could not be reproduced, we saw at
least the same trends, such as a ED, OpenStack-ED), the reported values
were close (0.995, 0.999, performance increase between DFA-EQ@1 and
DFA-EQ@10. 0.993) to the observed minimum/maximum values (0.996, 1.0,
0.992), Summary: The majority of the results are unlikely to be repro-
and for five combinations (Windows-ED, Android-ED, MAC-GA, ducible.
MAC-ED), the reported values are unlikely to be reproducible as they
were below the values we observed (0.857 vs. 0.862, 0.955 vs.
Reproduction of \[50\]. The study by Zhou et al. \[50\] investigated
0.966, 0.857 vs. 0.912, 0.881 vs. 0.897). the effectiveness of large
language models---specifically GPT-3.5 Summary: The majority of the
original results are likely to be and GPT-4---in detecting
vulnerabilities in C/C++ code for differ- reproducible. Those original
results that seem not reproducible ent prompts and configurations. They
compared these models to were still close to the originally reported
values as depicted in the a state-of-the-art baseline (CodeBERT) using
in-context learning. \[51\]-section of Table 1. They performed their
experiments twice to account for variability in model output. We
reproduced a subset of their configurations. RQ1 Summary We ran their
experiment 30 times for 8 different prompt configura- tions using
GPT-3.5. Amounting to approximately \$36. Of 69 studies, only five were
fit for reproduction. None of Variables impacting reproduction: Three
configurations were those five studies could be completely reproduced.
Two out of scope for the reproduction due to unhandled context length
studies could be partially reproduced, and three studies limitations and
lacking error handling (configuration A54, A4 k=3, could not be
reproduced. A4 k=5). As GPT-4 was only applied to half of the test set
due to cost constraints in the original paper, we omit its reproduction
here. The artefacts had several general code issues, dependency versions
were 4.2 RQ2: Which factors impede the not specified, and prompt
configurations were injected manually, reproduction of LLM-centric
empirical SE which we automated. The model version was not specified.
Thus, studies? we employed gpt-3.5-turbo-0125. All changes, the results,
and the We look at the factors from two perspectives. First, from a
meta- generated evidence are transparently documented in our online
analytical perspective, and second, from an experimental perspec-
material \[40\]. tive. For the meta-analysis, we look at all 85
articles. For the ex- Results: Two-thirds of the original results seem
to be reproducible. perimental one, we focus on the 18 articles that
seemed fit for However, we saw vast differences in stability for the
metrics. While reproduction. some metrics were consistently in a 3%
range, others were found Of the 85 articles, 35 did not provide their
code or data. For in a 10-30% range. For example, the metric precision
for the con- another 15 articles, those research artefacts were
incomplete to figuration P+A4 K=1 had a minimum observed value of 50%
and the point of no recovery. Those two factors rendered 50 articles a
maximum value of 82.35%. In contrast to that, the metric accu-
non-reproducible. Strictly following ACM's definitions, this does racy
for the same configuration had a minimum value of 50% and not imply
non-replicability. If a paper describes the method and a maximum value
of 54.15%. Those ranges are also represented setup in detail enough, a
replication might still be feasible. Of the in the \[50\]-section of
Table 1. Given those varieties in the value 85 articles, 8 did not state
the models used, describing them in a ranges observed during the 30
experimental executions, the claim of generic fashion as "LLM" or
"ChatGPT", "LLM-based". Such works reproducibility---even though in
accordance with ACM's definition--- can, of course, not be replicated.
Of the 85 articles, 29 reported the has to be taken with a grain of salt
here. temperature configuration of their models, and only 14 reported
Summary: The majority of the results are likely to be reproducible. on
the configuration of other parameters, such as top-p and top-k.
Reproduction of \[51\]. The research of Xiao et al. \[51\] proposes At
the same time, only 22 articles described the context window a LLM-based
log parser. They tested their approach on two large- size limitations
and how they were handled. Finally, 50 articles scale datasets against
other state-of-the-art parsers. Among others, reported on the prompts,
either detailing the prompts or explaining they measure the parser's
performance over multiple metrics. For the prompt templates, if the
prompts were dynamic or too long to the reproduction, we focus on the
LogHub-2k dataset experiments report entirely. (Table 1 of the original
article). The reason is that 1. the dataset was In the experimental
investigation we evaluated those articles, that already in the provided
research artefact, and 2. loading the other seemed fit for reproduction
and that used OpenAI services. This dataset would have required
modifying the container as it lacked resulted in 18 articles \[52, 53,
50, 49, 54, 47, 55, 56, 45, 57, 58, 59, 60, needed libraries. We
repeated the experiments 30 times, amounting 61, 62, 44, 51, 63\]. Of
those articles, ten did not define the minor to approximately \$40. The
results and the generated evidence can version of the LLM used in the
research artefact. Three did not be observed in our online material
\[40\]. configure the temperature of the model. Ten did configure top-p
Variables impacting reproduction: The research artefact does and top-k.
The context window was only handled by 5 of 18 research not generate one
of the metrics (MLA), hence we could not repro- artefacts. duce this
metric. During reproduction, we ran into various issues for almost all
of Results: In total, we reproduced two metrics (GA, ED) over 16 the 18
articles. Those issues are listed in Table 2. The biggest issue ICSE
'26, April 12--18, 2026, Rio de Janeiro, Brazil Angermeir et al.

Table 1: Example Metrics from the Five Reproduced Studies. In Bold, the
Percentiles Closest to the Originally Reported Values; in Red, the
Original Values Falling Outside the 95% Interval of Reproduced Values.

Study Configuration/Metric Original Value 2.5th 10th 25th 50th 75th 90th
97.5th Pan et al. \[45\] Successful Transl. from Python 79.9 45.585
48.445 50.611 51.883 52.699 53.864 55.272 Successful Transl. from Go
85.5 50.118 50.388 50.812 51.652 52.838 53.702 54.520 Ahmed et
al. \[47\] Java ASAP 16.96 18.954 19.016 19.128 19.239 19.302 19.437
19.627 Python ASAP 16.38 14.505 14.655 14.857 15.033 15.194 15.338
15.487 PHP ASAP 19.99 16.615 16.667 16.712 16.817 16.906 16.964 17.012
Siddiq et al. \[49\] vul@1𝑅𝑒𝑠𝑐𝑢𝑒 0.28 0.250 0.262 0.289 0.306 0.347
0.393 0.428 vul@10𝑅𝑒𝑠𝑐𝑢𝑒 1.84 1.334 1.418 1.481 1.640 1.941 2.111 2.272
DFA-EQ@1 Original 11.8 7.524 7.691 7.818 8.170 8.650 8.995 9.164
vul@3𝑅𝑒𝐷𝑜𝑆𝐻𝑢𝑛𝑡𝑒𝑟 Original 6.20 5.117 5.273 5.446 5.622 5.802 6.022 6.090
Zhou et al. \[50\] P+A4 K=1 Precision 75.2 53.10 61.42 65.59 70.38 74.69
78.23 81.49 P+A4 K=1 Accuracy 51.8 50.3 51.17 51.77 52.27 52.77 53.15
53.82 P+A5 K=5 Recall 47.2 46.73 47.47 49.17 50.97 52.60 52.60 56.50
Xiao et al. \[51\] Proxifier GA 1.000 1.0 1.0 1.0 1.0 1.0 1.0 1.0 Hadoop
ED 0.953 0.952 0.953 0.953 0.953 0.953 0.953 0.953 OpenStack GA 0.968
0.971 0.985 0.989 0.99 0.99 0.99 0.99 Mac ED 0.881 0.896 0.898 0.899
0.900 0.901 0.902 0.902

we faced was non-obvious missing artefacts, such as individual RQ2
Summary scripts missing, and the importing of non-existent modules. The
second most occurring issue was unspecified dependency versions. The
main factors impeding the reproduction of LLM- For some articles, this
issue was fixable. For others, this resulted centric empirical SE
studies are missing or incomplete in dependency conflicts. General code
issues were another reason artefacts, missing details in reporting,
dependency ver- for reproduction failure. Those were reflected in the
usage of unas- sion issues, and, the only commercial LLM-specific
factor: signed variables and hardcoded paths. Also, a major cause for
repro- deprecated models. duction failure was the deprecation of LLMs.
In at least four studies, we faced the issue of deprecated models,
which, of course, we could not solve. Other issues were incomplete or
missing documentation on how to reproduce the results, non-executable
artefacts, lack- 4.3 RQ3: How well do the ACM artefact badges ing error
handling---especially for long-running experiments---and deprecated
external API points. reflect the state of reproducibility of LLM-centric
SE studies? In total, of the analysed 85 articles, 18 were assigned an
ACM badge. Among those articles, we found two types of badges: Arti-
facts Available v1.1 and the Artifacts Evaluated - Reusable v1.1. Of the
ICSE papers, all 11 had the available and the reusable badge. At ASE,
seven papers had the available badge, and 4 the reusable badge. None of
the articles had an Artifacts Evaluated - Functional Table 2: Factors
Impeding Reproduction of the 18 Articles v1.1 badge, which is the
precursor to the reusable badge \[15\]. Of That Seemed Fit for
Reproduction the three articles with only the Artifacts Available v1.1
badge, one resource did not provide the artefact anymore, as the
repository Factor Articles expired, and one article was incomplete.
Those results are in tune with ACM's description of this badge. ACM does
not mandate com- Incomplete Artefacts \[63, 44, 61, 62, 57, 54\]
pleteness, nor a specific repository provider. Furthermore, ACM
Dependency Version Issues \[63, 57, 60, 55, 50, 47\] only explicitly
mandates a permanent accessibility plan for data, General Code Issues
\[63, 62, 56, 50, 60\] ignoring code as a research artefact. Deprecated
Models \[52, 60, 56, 49, 47\] Of the 16 papers that were assigned the
Artifacts Evaluated - Reusable Incomplete Documentation \[61, 58, 57,
47\] v1.1 badge, four articles provided incomplete artefacts, three were
Non-Executable Artefacts \[59, 55\] non-functional, and one did not
provide sufficient documentation Lacking Error Handling \[53, 50\] for
reproduction. Those results contradict ACM's requirements for Deprecated
External API \[52\] this badge. ACM mandates completeness,
exerisability, consistency, Reflections on the Reproducibility of
Commercial LLM Performance in Empirical Software Engineering Studies
ICSE '26, April 12--18, 2026, Rio de Janeiro, Brazil

and documentation to the level that it facilitates the reuse and re-
perform a comparison with open source models, potentially risking
purposing of research artefacts. This is clearly not the case for half
model accessibility issues in the long term. of the papers with the
Artifacts Evaluated - Reusable v1.1 badge. In the background, we
mentioned the promise of commercial model providers, such as OpenAI, to
keep models of a fixed version stable. RQ3 Summary It would have been an
interesting analysis, whether this promise holds true. However, we can
not make any claims given the few One year after the artefacts have been
evaluated and approaches that actually set the minor version for the
used models awarded with the Artifacts Evaluated - Reusable v1.1 badges,
(see Table 3). half of them do not fulfill (anymore) the requirements
set up by ACM. This suggests that ACM artefact badges are Table 3:
Characteristics of Reproduced Studies. not a reliable indicator of
reproducibility.

                                                                                                                          [45]     [47]     [49]     [50]     [51]

5 Discussion Reproducible No No No Part Part In this section, we
critically reflect on our results and their impli- ACM Artefact
Evaluated Yes No Yes No Yes cations for LLM-centric empirical studies.
Afterwards, we provide Minor Version Set No Yes No No Yes
recommendations for authors, venues, and funding agencies. Model
Comparison Yes Yes Yes Yes No Metric for LLMs No No Yes No No 5.1
Critical Reflection In the following, we discuss the factors coinciding
with enhanced and degraded reproducibility, the value of LLM-centric
empirical The value of LLM-centric empirical studies. Given that we
started studies in light of our results, why to perform a reproduction
study our replication efforts with 69 articles describing LLM-centric
em- despite constant evolution of the technology under investigation,
pirical research using OpenAI services, a partial reproduction of and
the relevance of ACM artefact badges for the reproducibility of only two
articles is alarming. More alarming than the low num- LLM-centric
empirical research. ber of replications is the low number of executable
studies, i.e., studies for which we could run the code successfully.
With only Which factors influence reproducibility of LLM-centric
studies? five studies, this leaves 64 studies in a non-reproducible
state. We Intuitively, certain characteristics of LLM studies should
coincide could argue that those studies can still provide tangible
value, e.g., with enhanced reproducibility. Examples would be an ACM
artefact by giving general guidance or by reporting on some key insights
evaluated badge, the minor version of the LLM being fixed, compar- by
the authors; this goes, however, under the assumption that the ison with
multiple models or metrics that are developed to evaluate authors would
describe their study setup in sufficient detail which LLMs (e.g.,
pass@k). However, during our attempts of reproduc- is not the case. Of
all studies, eight failed to even name the em- tion, we could not find
any of those characteristics to be related ployed models, simply
referring to ChatGPT or to LLM. Only a to improved reproducibility, as
reported in Table 3. However, from third of all studies reported on the
temperature of their models and the factors impeding replication (see
Table 2), we can deduce the even less (16%) reported on evaluation
parameters such as top-p factors influencing degraded reproducibility.
Those factors are most or top-k. Furthermore, only one in four studies
discussed the as- often not linked to LLMs, but general issues in
reproducibility that pect of context window size, not only hindering
reproduction, but are discussed in research already, such as incomplete
artefacts \[12, also demonstrating a large threat to validity to the
available study 64\], incomplete documentation \[65\], or general code
issues \[66, results. Conversely, more than half of all studies reported
on the 67\]. We will not discuss those factors in further detail, as the
re- employed prompts, contributing at least in part to their replicabil-
search community already offers a plethora of advice here (e.g., \[68,
ity. In terms of reproducibility, LLM-centric empirical SE studies
69\]). This highlights, that the reproducibility of LLM-centric studies
show similar issues as qualitative studies. However, the difference
largely suffers from the same issues as other empirical software is that
for qualitative studies, we will rarely be able to reproduce engineering
studies. The only factor directly linked to LLMs was (or simulate) the
exact context with the same subject configuration the usage of
deprecated models, an issue exclusive to commercial as the baseline
studies; this restriction, we argue, does not hold models. We
acknowledge that authors have little control over the for LLM-centric
empirical studies. Therefore, we can only spec- deprecation of models.
However, the risk of model deprecation has ulate that researchers need
significantly more guidance. This is to be a consideration during the
study design phase. Following especially important when---as a research
community---we aim and the definition of the open source AI by the
open-source initiative claim to set the same standards with respect to
scientific rigour \[70\], the hurdles towards deprecation for open
source models are and relevance for LLM-centric empirical studies as we
do for other higher, and such models do not frequently get discontinued
as studies. opposed to commercial models. One way of dealing with model
deprecation of commercial providers could hence be the compari- ACM
Badges and Reproducibility. Our findings raise questions son with
open-source models. Four of the five studies we reviewed about the
long-term validity and relevance of the ACM artefact compared different
models. However, analysing whether this com- badges. Just one year after
the evaluation, half of the artefacts with parison actually improves
replicability is out of scope of this article. an Artifacts Evaluated -
Resuable v1.1 badge failed to meet ACM Nevertheless, on a bigger
picture, half of the 85 articles did not requirements, rendering its
long-term validity debatable. Given that ICSE '26, April 12--18, 2026,
Rio de Janeiro, Brazil Angermeir et al.

the review processes are not standardised and no insights on the
Recommendations for Authors. In 2024, Wagner et al. \[73\] high-
individual evaluations are available, we can not clearly attribute
lighted the need for guidance on the reporting of LLM-centric empir- the
observed discrepancies to the review process or to changes to ical
studies. Addressing this gap, Baltes et al. published comprehen- the
research artefacts over time, which would not be in scope of sive
guidelines in 2025 \[43\]. For software engineering researchers at the
awarded artefact badge. We can further operate under the as- the
intersection with other fields, it might prove valuable to check
sumption of appropriate initial artefact evaluation processes. At the
for additional guidance in those fields. For instance, the healthcare
same time, a preliminary analysis of artefacts showed that most of field
addressed the need for reporting guidance in their TRIPOD- the reviewed
artefacts have not been changed since the conferences LLM Guidelines
\[74\]. As there exists extensive guidance on the in 2024. Of course,
only findings are only representative for ICSE planning, execution, and
reporting of LLM-centric empirical stud- and ASE 2024, however given
their role in the SE community, we ies, covering many of the challenges
we reported in this paper, we are confident to argue for the need for a
more standardised and will not provide further recommendations.
transparent review process to improve the overall reproducibility of
studies. So far, this does not seem to be intended by ACM who "\[...\]
Recommendations for Venues. Over the last years, we have seen believe
that it is still too early to establish more specific guidelines venues
including both, conferences and journals putting more em- for artifact
and replicability review" \[15\]. phasis on research artefacts. However,
in light of the challenges we As the review process of artefacts is
resource-intensive, one way encountered, we suggest not only
incentivising the disclosure of the to reduce reviewer effort would be
an automatic pre-screening of full research artefacts, but also working
towards a state where the artefacts. We do not go as far as to suggest
the automation of the disclosure is mandatory within the boundaries of
what is possible replication process itself, as even OpenAI admitted
that LLMs do (e.g., considering work rooted in sensitive data). This
increased not excel at that task yet \[71\]. However, a source of
inspiration transparency must not only include code and data, but also a
com- could be the recently introduced PaperCheck \[72\], which offers
the plete Software Bill of Materials. This recommendation is consistent
tooling to scan scientific publications for adherence to best prac- with
prevailing research on reproducibility. As discussed, the re- tices. A
similar approach for research artefacts could provide both quirements
for artefact evaluation laid out by ACM do not seem to authors and
reviewers with low-effort insights into improvement suffice to ensure
long-term reproducibility. Hence, we, as a research potentials.
community, should rethink the criteria laid out and the guidance given
towards artefact evaluation. This goes hand in hand with the strong
recommendation to set the same standards for scientific The Value of a
Reproducibility Study in a Fast-Paced Research rigour, reproducibility,
and replicability as for other study types. Field. Finally, one question
we deem relevant is to which extent a We cannot continue to treat
LLM-centric studies separately, on the reproducibility study in such a
fast-paced research field can provide basis of it being a "new"
technology. valuable insights (also considering the blurry notion of
what can be Recommendations for Funding Agencies. In the same spirit as
seen as valuable). As we discussed in the background, new models we make
our recommendations for the future of our venues, we might improve
overall on the benchmarks defined by the model also expect funding
agencies to have the same scientific rigour vendors, but it is unclear
how those updates impact individual---by requirements for LLM-centric
research as for other research. We the research community---defined
tasks. We are not reproducing believe that funding agencies can shape
the long-term value of the results of model vendors on their benchmarks,
but the model LLM-centric research by putting an emphasis on long-term
accessi- performance on tasks defined by the research community. If the
bility, extending their mandatory practices towards open science, models
improved on all those tasks, we could see a reproducible also to
reproducibility, and by supporting the research community value in the
currently published studies as a lower bound to the to improve the
surrounding processes. One step towards such an potential of LLMs.
However, as our results for \[47\] and \[45\] indicate, improvement
could be providing automation support in the assess- this is not the
case. ment of research artefacts to lower the effort for reviewers and,
The reproduced studies were published just one year ago; hence, thus,
enabling higher quality outcomes in artefact disclosure and they
represent the current state of knowledge. Despite the progress the peer
review processes. in the research field of AI focusing on LLMs, the
general insights should remain the same. If the results of studies that
are just one year old no longer hold true, we must question the
sustainability 6 Threats to Validity of such research. This is even more
critical when considering that We discuss the threats to validity of
this study in terms of internal studies presented at conferences are
typically part of larger research validity, external validity, and
reliability, following the guidelines programmes contributing to the
body of knowledge long-term, and of Runeson and Höst \[75\]. often
include contributions of individual PhD endeavours. Internal Validity
First, we can only draw statistically signifi- cant conclusions if the
sample size adequately accounts for the non-determinism of LLMs. As
discussed in Section 2, this was not 5.2 Recommendations feasible, and
we resorted to 30 repetitions as an approximation In the following, we
provide recommendations for authors, venues, to the real distribution.
Second, most research artefacts required and funding agencies to improve
the reproducibility of LLM-centric manual intervention. Those
interventions ranged from recovering empirical studies. dependency
versions to code reconstructions, each with its own Reflections on the
Reproducibility of Commercial LLM Performance in Empirical Software
Engineering Studies ICSE '26, April 12--18, 2026, Rio de Janeiro, Brazil

risk of introducing unintentional researcher bias. We minimized
divergent results. The most common reproduction challenges were this
threat by only reconstructing if the necessary documentation missing or
incomplete artefacts, dependency version issues, general was available
and additionally verified---where possible, the func- code issues, and
deprecated model access. We could--due to the tionality with data
provided in the research artefact. Finally, the low number of
reproducible studies--not identify factors positively Bayesian bootstrap
only considers observed values, potentially mis- influencing
reproducibility. Even the presence of ACM artefact representing extreme
behaviours of LLMs. In our experiments, this badges--intended to signal
reliability--was no indicator of actual did not emerge as an issue.
Nevertheless, we performed the descrip- reproducibility. tive analysis
and provided all results transparently in our online These results
suggest that despite a growing interest in LLM- material \[40\]. based
research in SE, the research field suffers from fundamental External
Validity Several factors in our sampling process con- issues with
reproducibility, similar to qualitative studies. This under- strain the
generalisability of our study. mines both the scientific value of
current LLM-based publications First, we included only studies utilising
OpenAI LLMs, thereby and the long-term relevance of their findings.
limiting applicability to models from other providers (e.g., An- To
address this, we offer recommendations for authors, venues, thropic,
Google, Meta), which may differ in architecture, availability, and
funding agencies. We encourage authors to rigorously docu- or versioning
strategies. ment all experimental data and share complete, versioned
artefacts, Second, we only sampled studies from two conference proceed-
aligned with relevant guidelines for the respective research do- ings,
where the low number of successful study reproductions can mains. For
venues, we advocate an independent reassessment of not be generalised to
other artefacts published in different venues. artefact evaluation
criteria--beyond ACM's current standards--and Third, budgetary
constraints limited the number of tasks repro- a stronger emphasis on
promoting artefact sharing. Finally, we be- duced per study. Alternative
task selections could yield different lieve that funding agencies can
contribute to improving LLM-based performance outcomes, further
impacting generalisability. research by prioritising reproducibility and
long-term accessibility Reliability As we saw in Table 1, reproductions
could result of research artefacts. in high variability between
different repetitions with up to 30% As the SE research field continues
to evolve rapidly through differences in metrics. Those variabilities
indicate that a larger LLMs, reproducibility must not be treated as
optional. We must put sample size might provide more reliable findings.
At the same time, the same standards on LLM-centric research, as we
claim for other this variability demonstrates the overall difficulties
in reproducing research types. Without structural improvements, we risk
building the original values. a body of knowledge that cannot be tested
and consequently not The reproduction of relevant studies was assigned
to five of the be trusted. authors, with each researcher conducting the
replication individu- ally, potentially introducing a researcher bias.
To mitigate this bias, Acknowledgments another author independently
reviewed the results before finalising This work was funded by the KKS
foundation through the SERT Re- the conclusions on the specific research
artefact. search Profile project (research profile grant 2018/010) at
Blekinge The literature search process was adjusted due to the low
number Institute of Technology. of suitable articles from ICSE and
efficiency reasons. While this represents a deviation from the original
research plan, its adaption Data availability was necessary to increase
the sample size from 13 ICSE articles The datasets generated during this
study are published at: \[40\]. The to 18 ICSE and ASE articles for
reproduction attempts. While the reproduction framework is available at
\[38\]. exclusion of articles from ASE without an artefact badge
provides a drastic reduction, it contributed to the feasibility of the
research References within the allocated resources while strengthening
the sample size \[1\] Zibin Zheng, Kaiwen Ning, Qingyuan Zhong, Jiachi
Chen, Wenqing Chen, from 11 ICSE articles to 18 ICSE and ASE articles
for the ACM Lianghong Guo, Weicheng Wang, and Yanlin Wang. 2024. Towards
an under- artefact badge analysis thus increasing the reliability of the
results standing of large language models in software engineering tasks.
Empirical Software Engineering, 30, 2, 50.
doi:10.1007/s10664-024-10602-0. of RQ3. \[2\] Jingfeng Yang, Hongye Jin,
Ruixiang Tang, Xiaotian Han, Qizhang Feng, Haom- ing Jiang, Shaochen
Zhong, Bing Yin, and Xia Hu. 2024. Harnessing the power of llms in
practice: a survey on chatgpt and beyond. ACM Trans. Knowl. Discov.
Data, 18, 6, Article 160, (Apr. 2024), 32 pages. doi:10.1145/3649506. 7
Conclusion \[3\] Junjie Wang, Yuchao Huang, Chunyang Chen, Zhe Liu, Song
Wang, and Qing In this study, we investigated the reproducibility of
LLM-centric Wang. 2024. Software testing with large language models:
survey, landscape, and vision. IEEE Transactions on Software
Engineering, 50, 4, 911--936. doi:10.11 empirical SE studies involving
commercial Large Language Models 09/TSE.2024.3368208. (LLMs). We
performed a critical review combined with a repro- \[4\] Xinyi Hou et
al. 2024. Large language models for software engineering: a duction
study. To that end, we reviewed 85 articles from ICSE and systematic
literature review. ACM Trans. Softw. Eng. Methodol., 33, 8, Article 220,
(Dec. 2024), 79 pages. doi:10.1145/3695988. ASE 2024, identifying 69
articles that used OpenAI's services. Of \[5\] Angela Fan, Beliz
Gokkaya, Mark Harman, Mitya Lyubarskiy, Shubho Sen- those, 18 articles
included research artefacts and appeared suitable gupta, Shin Yoo, and
Jie M. Zhang. 2023. Large language models for software engineering:
survey and open problems. In 2023 IEEE/ACM International Con- for
reproduction. Ultimately, only five studies were fit for repro- ference
on Software Engineering: Future of Software Engineering (ICSE-FoSE),
duction. Through our self-developed reproduction framework, we 31--53.
doi:10.1109/ICSE-FoSE59343.2023.00008. reproduced each of those five
studies with up to 30 repetitions. \[6\] June Sallou, Thomas Durieux,
and Annibale Panichella. 2024. Breaking the silence: the threats of
using llms in software engineering. In Proceedings of the Our findings
reveal that none of the five studies could be fully 2024 ACM/IEEE 44th
International Conference on Software Engineering: New Ideas reproduced.
Two were partially reproducible, and three yielded ICSE '26, April
12--18, 2026, Rio de Janeiro, Brazil Angermeir et al.

       and Emerging Results (ICSE-NIER’24). Association for Computing Machinery,              [29]   Hsiu-Yuan Huang, Yutong Yang, Zhaoxi Zhang, Sanwoo Lee, and Yunfang
       Lisbon, Portugal, 102–106. isbn: 9798400705007. doi:10.1145/3639476.3639764.                  Wu. 2024. A survey of uncertainty estimation in llms: theory meets practice.

\[7\] Laurène Vaugrante, Mathias Niepert, and Thilo Hagendorff. 2024. A
looming arXiv:2410.15326. replication crisis in evaluating behavior in
language models? evidence and \[30\] Yasin Abbasi Yadkori, Ilja
Kuzborskij, András György, and Csaba Szepesvári. solutions.
arXiv:2409.20303. 2024. To believe or not to believe your llm.
arXiv:2406.02543. \[8\] Moritz Staudinger, Wojciech Kusa, Florina Piroi,
Aldo Lipani, and Allan Han- \[31\] Huan Ma, Jingdong Chen, Guangyu Wang,
and Changqing Zhang. 2025. Esti- bury. 2024. A reproducibility and
generalizability study of large language mating llm uncertainty with
logits. arXiv:2502.00290. models for query generation. In Proceedings of
the 2024 Annual International \[32\] Wanqin Ma, Chenyang Yang, and
Christian Kästner. 2024. (why) is my prompt ACM SIGIR Conference on
Research and Development in Information Retrieval in getting worse?
rethinking regression testing for evolving llm apis. In Proceed- the
Asia Pacific Region (SIGIR-AP 2024). Association for Computing
Machinery, ings of the IEEE/ACM 3rd International Conference on AI
Engineering - Software Tokyo, Japan, 186--196. isbn: 9798400707247.
doi:10.1145/3673791.3698432. Engineering for AI (CAIN '24). Association
for Computing Machinery, Lisbon, \[9\] Christopher Barrie, Alexis
Palmer, and Arthur Spirling. 2024. Replication for Portugal, 166--171.
isbn: 9798400705915. doi:10.1145/3644815.3644950. language models
problems, principles, and best practice for political science. \[33\]
Lingjiao Chen, Matei Zaharia, and James Zou. 2023. How is chatgpt's
behavior URL: https://arthurspirling. org/documents/BarriePalmerSpirling
TrustMeBro. pdf. changing over time? (2023).
https://arxiv.org/abs/2307.09009. \[10\] Satheesh Krishna, Nishaant
Bhambra, Robert Bleakney, and Rajesh Bhayana. \[34\] OpenAI. 2025.
Function calling and other api updates. https://web.archive.org 2024.
Evaluation of reliability, repeatability, robustness, and confidence of
/web/20250602043150/https://openai.com/index/function-calling-and-othe
gpt-3.5 and gpt-4 on a radiology board--style examination. Radiology,
311, 2, r-api-updates/. Archived on June 2, 2025; originally published
June 13, 2023. e232715. (June 2025). \[11\] Muhammad A. A. Pirzada,
Giles Reger, Ahmed Bhayat, and Lucas C. Cordeiro. \[35\] Donald B Rubin.
1981. The bayesian bootstrap. The annals of statistics, 130--134. 2024.
Llm-generated invariants for bounded model checking without loop \[36\]
Rasmus Bååth. 2015. The non-parametric bootstrap as a bayesian model.
(2015). unrolling. In Proceedings of the 39th IEEE/ACM International
Conference on Au-
https://web.archive.org/web/20250703153242/https://www.sumsar.net/blog
tomated Software Engineering (ASE '24). Association for Computing
Machinery, /2015/04/the-non-parametric-bootstrap-as-a-bayesian-model/.
Sacramento, CA, USA, 1395--1407. isbn: 9798400712487.
doi:10.1145/3691620.3 \[37\] Monica Musio and Monica L. Targhetta. 2006.
Bayesian bootstrap confidence 695512. intervals for population quantiles
and empirical comparisons. (2006). \[12\] Chao Liu, Cuiyun Gao, Xin Xia,
David Lo, John Grundy, and Xiaohu Yang. \[38\] Florian Angermeir,
Maximilian Amougou, Mark Kreitz, Andreas Bauer, and 2021. On the
reproducibility and replicability of deep learning in software Matthias
Linhuber. 2025. Angrymeir/llm-replikit: 1.0 (1.0). (2025). doi:10.5281
engineering. ACM Trans. Softw. Eng. Methodol., 31, 1, Article 15,
(Oct. 2021), 46 /zenodo.17589278. pages. doi:10.1145/3477535. \[39\]
Paul Ralph and Sebastian Baltes. 2022. Paving the way for mature
secondary \[13\] Margarita Cruz, Beatriz Bernárdez, Amador Durán, José
A. Galindo, and Anto- research: the seven types of literature review. In
Proceedings of the 30th ACM nio Ruiz-Cortés. 2020. Replication of
studies in empirical software engineering: Joint European Software
Engineering Conference and Symposium on the Foun- a systematic mapping
study, from 2013 to 2018. IEEE Access, 8, 26773--26791. dations of
Software Engineering (ESEC/FSE 2022). Association for Computing
doi:10.1109/ACCESS.2019.2952191. Machinery, Singapore, Singapore,
1632--1636. isbn: 9781450394130. doi:10.1145 \[14\] Fabio Q. Silva,
Marcos Suassuna, A. César França, Alicia M. Grubb, Tatiana B.
/3540250.3560877. Gouveia, Cleviton V. Monteiro, and Igor Ebrahim
Santos. 2014. Replication \[40\] Florian Angermeir, Maximilian Amougou,
Mark Kreitz, Andreas Bauer, Matthias of empirical studies in software
engineering research: a systematic mapping Linhuber, Davide Fucci,
Fabiola Moyón C., Daniel Mendez, and Tony Gorschek. study. Empirical
Softw. Engg., 19, 3, (June 2014), 501--557. doi:10.1007/s10664-0 2025.
Online material: reflections on the reproducibility of commercial llm
12-9227-7. performance in empirical software engineering studies.
(2025). doi:10.5281/zen \[15\] ACM Publications Board. 2020. Artifact
review and badging -- current. (2020). odo.17590506.
https://www.acm.org/publications/policies/artifact-review-and-badging-cur
\[41\] ICSE '24: Proceedings of the IEEE/ACM 46th International
Conference on Software rent. Engineering. Lisbon, Portugal, (2024).
Association for Computing Machinery. \[16\] Engineering National
Academies of Sciences, Medicine, et al. 2019. Repro- isbn:
9798400702174. ducibility and replicability in science.
doi:10.17226/25303. \[42\] Vladimir Filkov, Baishakhi Ray, and Minghui
Zhou, (Eds.) Proceedings of the \[17\] Cleyton V.C. de Magalhães, Fabio
Q.B. da Silva, Ronnie E.S. Santos, and Marcos 39th IEEE/ACM
International Conference on Automated Software Engineering, Suassuna.
2015. Investigations about replication of empirical studies in software
ASE 2024, Sacramento, CA, USA, October 27 - November 1, 2024, (2024).
ACM. engineering: a systematic mapping study. Information and Software
Technology, isbn: 979-8-4007-1248-7. doi:10.1145/3691620. 64, 76--101.
doi:https://doi.org/10.1016/j.infsof.2015.02.001. \[43\] Sebastian
Baltes et al. 2025. Guidelines for empirical studies in software engi-
\[18\] Odd Erik Gundersen. 2021. The fundamental principles of
reproducibility. neering involving large language models. (2025). arXiv:
2508.15503. Philosophical Transactions of the Royal Society A, 379,
2197, 20200210. \[44\] Dharun Anandayuvaraj, Matthew Campbell, Arav
Tewari, and James C Davis. \[19\] Steven N Goodman, Daniele Fanelli, and
John PA Ioannidis. 2016. What does 2024. Fail: analyzing software
failures from the news using llms. In Proceedings research
reproducibility mean? Science translational medicine, 8, 341. doi:10.11
of the 39th IEEE/ACM International Conference on Automated Software
Engineer- 26/scitranslmed.aaf5027. ing (ASE '24). Association for
Computing Machinery, Sacramento, CA, USA, \[20\] Open Science
Collaboration. 2015. Estimating the reproducibility of psycholog-
506--518. isbn: 9798400712487. doi:10.1145/3691620.3695022. ical
science. Science, 349, 6251. doi:10.1126/science.aac4716. \[45\] Rangeet
Pan et al. 2024. Lost in translation: a study of bugs introduced by
large \[21\] Ulrich Schimmack. 2020. A meta-psychological perspective on
the decade language models while translating code. In Proceedings of the
IEEE/ACM 46th of replication failures in social psychology. Canadian
Psychology/Psychologie International Conference on Software Engineering
(ICSE '24) Article 82. Associa- Canadienne, 61, 4, 364.
doi:10.1037/cap0000246. tion for Computing Machinery, Lisbon, Portugal,
13 pages. isbn: 9798400702174. \[22\] Michael Lissack and Brenden
Meagher. 2024. Bridging the gap: a framework for
doi:10.1145/3597503.3639226. responsible integration of large language
models in scientific research. SSRN \[46\] Daniel Amador dos Santos,
Eduardo Santana de Almeida, and Iftekhar Ahmed. Electronic Journal,
(Sept. 2024). doi:10.2139/ssrn.4949795. 2022. Investigating replication
challenges through multiple replications of an \[23\] Yifan Song, Guoyin
Wang, Sujian Li, and Bill Yuchen Lin. 2024. The good, the experiment.
Information and Software Technology, 147, 106870. doi:https://doi.o bad,
and the greedy: evaluation of llms should not ignore non-determinism.
rg/10.1016/j.infsof.2022.106870. arXiv:2407.10457. \[47\] Toufique
Ahmed, Kunal Suresh Pai, Premkumar Devanbu, and Earl Barr. 2024. \[24\]
Robert E Blackwell, Jon Barry, and Anthony G Cohn. 2024. Towards repro-
Automatic semantic augmentation of language model prompts (for code sum-
ducible llm evaluation: quantifying uncertainty in llm benchmark scores.
marization). In Proceedings of the IEEE/ACM 46th International
Conference on arXiv:2410.03492. Software Engineering (ICSE '24) Article
220. Association for Computing Ma- \[25\] Benedetta Donato, Leonardo
Mariani, Daniela Micucci, and Oliviero Riganelli. chinery, Lisbon,
Portugal, 13 pages. isbn: 9798400702174. doi:10.1145/3597503 2025.
Studying how configurations impact code generation in llms: the case of
.3639183. chatgpt. In 2025 IEEE/ACM 33rd International Conference on
Program Compre- \[48\] Noor Nashid, Mifta Sintaha, and Ali Mesbah. 2023.
Retrieval-based prompt se- hension (ICPC), 442--453.
doi:10.1109/ICPC66645.2025.00055. lection for code-related few-shot
learning. In 2023 IEEE/ACM 45th International \[26\] Shuyin Ouyang, Jie
M. Zhang, Mark Harman, and Meng Wang. 2025. An Conference on Software
Engineering (ICSE), 2450--2462. doi:10.1109/ICSE48619.2 empirical study
of the non-determinism of chatgpt in code generation. ACM 023.00205.
Trans. Softw. Eng. Methodol., 34, 2, Article 42, (Jan. 2025), 28 pages.
doi:10.1145 \[49\] Mohammed Latif Siddiq, Jiahao Zhang, Lindsay Roney,
and Joanna C. S. San- /3697010. tos. 2024. Re(gex\|dos)eval: evaluating
generated regular expressions and their \[27\] Berk Atil, Alexa
Chittams, Liseng Fu, Ferhan Ture, Lixinyu Xu, and Breck Bald- proneness
to dos attacks. In Proceedings of the 2024 ACM/IEEE 44th International
win. 2024. Llm stability: a detailed analysis with some surprises.
arXiv:2408.04667. Conference on Software Engineering: New Ideas and
Emerging Results (ICSE- \[28\] Eugene Klishevich, Yegor Denisov-Blanch,
Simon Obstbaum, Igor Ciobanu, NIER'24). Association for Computing
Machinery, Lisbon, Portugal, 52--56. isbn: and Michal Kosinski. 2025.
Measuring determinism in large language models 9798400705007.
doi:10.1145/3639476.3639757. for software code review. arXiv:2502.20747.
Reflections on the Reproducibility of Commercial LLM Performance in
Empirical Software Engineering Studies ICSE '26, April 12--18, 2026, Rio
de Janeiro, Brazil

\[50\] Xin Zhou, Ting Zhang, and David Lo. 2024. Large language model
for vulnera- \[65\] Jesús M. González-Barahona and Gregorio Robles.
2012. On the reproducibil- bility detection: emerging results and future
directions. In Proceedings of the ity of empirical software engineering
studies based on data retrieved from 2024 ACM/IEEE 44th International
Conference on Software Engineering: New Ideas development repositories.
Empirical Softw. Engg., 17, 1--2, (Feb. 2012), 75--89. and Emerging
Results (ICSE-NIER'24). Association for Computing Machinery,
doi:10.1007/s10664-011-9181-9. Lisbon, Portugal, 47--51. isbn:
9798400705007. doi:10.1145/3639476.3639762. \[66\] Ana Trisovic, Matthew
K. Lau, Thomas Pasquier, and Mercè Crosas. 2022. A \[51\] Yi Xiao,
Van-Hoang Le, and Hongyu Zhang. 2024. Demonstration-free: towards
large-scale study on research code quality and execution. Scientific
Data, 60. more practical log parsing with large language models. In
Proceedings of the doi:10.1038/s41597-022-01143-6. 39th IEEE/ACM
International Conference on Automated Software Engineering \[67\] Zara
Hassan, Christoph Treude, Michael Norrish, Graham Williams, and Alex
(ASE '24). Association for Computing Machinery, Sacramento, CA, USA,
153-- Potanin. 2025. Characterising reproducibility debt in scientific
software: a 165. isbn: 9798400712487. doi:10.1145/3691620.3694994.
systematic literature review. Journal of Systems and Software, 222,
112327. \[52\] Yuchao Huang, Junjie Wang, Zhe Liu, Yawen Wang, Song
Wang, Chunyang doi:https://doi.org/10.1016/j.jss.2024.112327. Chen,
Yuanzhe Hu, and Qing Wang. 2024. Crashtranslator: automatically re-
\[68\] Christopher S. Timperley, Lauren Herckis, Claire Le Goues, and
Michael Hilton. producing mobile application crashes directly from stack
trace. In Proceedings 2021. Understanding and improving artifact sharing
in software engineering of the IEEE/ACM 46th International Conference on
Software Engineering (ICSE research. Empirical Softw. Engg., 26, 4,
(July 2021), 41 pages. doi:10.1007/s10664 '24) Article 18. Association
for Computing Machinery, Lisbon, Portugal, 13 -021-09973-5. pages. isbn:
9798400702174. doi:10.1145/3597503.3623298. \[69\] Julian Frattini,
Lloyd Montgomery, Davide Fucci, Michael Unterkalmsteiner, \[53\]
Francesco Sovrano, Michaël Lognoul, and Alberto Bacchelli. 2024. An
empirical Daniel Mendez, and Jannik Fischbach. 2024. Requirements
quality research study on compliance with ranking transparency in the
software documentation artifacts: recovery, analysis, and management
guideline. Journal of Systems of eu online platforms. In Proceedings of
the 46th International Conference on and Software, 216, 112120.
doi:https://doi.org/10.1016/j.jss.2024.112120. Software Engineering:
Software Engineering in Society (ICSE-SEIS'24). Associa- \[70\] Open
Source Initiative. 2024. The open source ai definition. Version 1.0.
(2024). tion for Computing Machinery, Lisbon, Portugal, 46--56. isbn:
9798400704994. https://opensource.org/ai/open-source-ai-definition.
doi:10.1145/3639475.3640112. \[71\] Giulio Starace et al. 2025.
Paperbench: evaluating ai's ability to replicate ai \[54\] Shyamal
Mishra and Preetha Chatterjee. 2024. Exploring chatgpt for toxicity
research. (2025). https://arxiv.org/abs/2504.01848. detection in github.
In Proceedings of the 2024 ACM/IEEE 44th International \[72\] Lisa
DeBruine and Daniel Lakens. 2025. papercheck: Check Scientific Papers
for Conference on Software Engineering: New Ideas and Emerging Results
(ICSE- Best Practices. R package version 0.0.0.9049.
https://github.com/scienceverse/p NIER'24). Association for Computing
Machinery, Lisbon, Portugal, 6--10. isbn: apercheck. 9798400705007.
doi:10.1145/3639476.3639777. \[73\] Stefan Wagner, Marvin Muñoz Barón,
Davide Falessi, and Sebastian Baltes. \[55\] Yiu Wai Chow, Luca Di
Grazia, and Michael Pradel. 2024. Pyty: repairing static 2025. Towards
evaluation guidelines for empirical studies involving llms. In type
errors in python. In Proceedings of the IEEE/ACM 46th International
Confer- 2025 IEEE/ACM International Workshop on Methodological Issues
with Empirical ence on Software Engineering (ICSE '24) Article 87.
Association for Computing Studies in Software Engineering (WSESE),
24--27. doi:10.1109/WSESE66602.2025 Machinery, Lisbon, Portugal, 13
pages. isbn: 9798400702174. doi:10.1145/35975 .00011. 03.3639184. \[74\]
Jack Gallifant et al. 2025. The tripod-llm reporting guideline for
studies using \[56\] Mingyang Geng, Shangwen Wang, Dezun Dong, Haotian
Wang, Ge Li, Zhi Jin, large language models. Nature Medicine, 31, 1,
60--69. Xiaoguang Mao, and Xiangke Liao. 2024. Large language models are
few-shot \[75\] Per Runeson and Martin Höst. 2009. Guidelines for
conducting and reporting summarizers: multi-intent comment generation
via in-context learning. In case study research in software engineering.
Empirical Software Engineering, (ICSE '24) Article 39. Association for
Computing Machinery, Lisbon, Portugal, 14, 2, 131--164.
doi:10.1007/s10664-008-9102-8. 13 pages. isbn: 9798400702174.
doi:10.1145/3597503.3608134. \[57\] Wenzhang Yang, Linhai Song, and
Yinxing Xue. 2024. Rust-lancet: automated ownership-rule-violation
fixing with behavior preservation. In Proceedings of the IEEE/ACM 46th
International Conference on Software Engineering (ICSE '24) Article 85.
Association for Computing Machinery, Lisbon, Portugal, 13 pages. isbn:
9798400702174. doi:10.1145/3597503.3639103. \[58\] Yun Peng, Shuzheng
Gao, Cuiyun Gao, Yintong Huo, and Michael Lyu. 2024. Domain knowledge
matters: improving prompts with fix templates for re- pairing python
type errors. In Proceedings of the IEEE/ACM 46th International
Conference on Software Engineering (ICSE '24) Article 4. Association for
Com- puting Machinery, Lisbon, Portugal, 13 pages. isbn: 9798400702174.
doi:10.114 5/3597503.3608132. \[59\] Hao Yu et al. 2024. Codereval: a
benchmark of pragmatic code generation with generative pre-trained
models. In Proceedings of the IEEE/ACM 46th Interna- tional Conference
on Software Engineering (ICSE '24) Article 37. Association for Computing
Machinery, Lisbon, Portugal, 12 pages. isbn: 9798400702174.
doi:10.1145/3597503.3623316. \[60\] Minaoar Hossain Tanzil, Junaed
Younus Khan, and Gias Uddin. 2024. Chatgpt in- correctness detection in
software reviews. In Proceedings of the IEEE/ACM 46th International
Conference on Software Engineering (ICSE '24) Article 180. Associa- tion
for Computing Machinery, Lisbon, Portugal, 12 pages. isbn:
9798400702174. doi:10.1145/3597503.3639194. \[61\] Yifan Liao, Ming Xu,
Yun Lin, Xiwen Teoh, Xiaofei Xie, Ruitao Feng, Frank Liaw, Hongyu Zhang,
and Jin Song Dong. 2024. Detecting and explaining anomalies caused by
web tamper attacks via building consistency-based normality. In Pro-
ceedings of the 39th IEEE/ACM International Conference on Automated
Software Engineering (ASE '24). Association for Computing Machinery,
Sacramento, CA, USA, 531--543. isbn: 9798400712487.
doi:10.1145/3691620.3695024. \[62\] Cong Wu, Jing Chen, Ziwei Wang,
Ruichao Liang, and Ruiying Du. 2024. Seman- tic sleuth: identifying
ponzi contracts via large language models. In Proceedings of the 39th
IEEE/ACM International Conference on Automated Software Engineer- ing
(ASE '24). Association for Computing Machinery, Sacramento, CA, USA,
582--593. isbn: 9798400712487. doi:10.1145/3691620.3695055. \[63\] Ziyou
Jiang, Lin Shi, Guowei Yang, and Qing Wang. 2024. Patuntrack: auto-
mated generating patch examples for issue reports without tracked
insecure code. In Proceedings of the 39th IEEE/ACM International
Conference on Auto- mated Software Engineering (ASE '24). Association
for Computing Machinery, Sacramento, CA, USA, 1--13. isbn:
9798400712487. doi:10.1145/3691620.3694982. \[64\] Jesus M.
Gonzalez-Barahona and Gregorio Robles. 2023. Revisiting the repro-
ducibility of empirical software engineering studies based on data
retrieved from development repositories. Information and Software
Technology, 164, 107318.
doi:https://doi.org/10.1016/j.infsof.2023.107318. 
