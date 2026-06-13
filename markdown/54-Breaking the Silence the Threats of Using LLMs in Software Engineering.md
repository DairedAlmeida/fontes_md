                                               Breaking the Silence: the Threats of Using LLMs in Software
                                                                       Engineering
                                                                June Sallou                                               Thomas Durieux                              Annibale Panichella
                                                                  TU Delft                                                     TU Delft                                      TU Delft
                                                             The Netherlands                                                The Netherlands                              The Netherlands
                                                            J.Sallou@tudelft.nl                                           thomas@durieux.me                           A.Panichella@tudelft.nl
                                         Abstract
                                         Large Language Models (LLMs) have gained considerable traction
                                         within the Software Engineering (SE) community, impacting vari-

arXiv:2312.08055v1 \[cs.SE\] 13 Dec 2023

                                         ous SE tasks from code completion to test generation, from program
                                         repair to code summarization. Despite their promise, researchers
                                         must still be careful as numerous intricate factors can influence the
                                         outcomes of experiments involving LLMs. This paper initiates an
                                         open discussion on potential threats to the validity of LLM-based
                                         research including issues such as closed-source models, possible
                                         data leakage between LLM training data and research evaluation,
                                         and the reproducibility of LLM-based findings. In response, this
                                         paper proposes a set of guidelines tailored for SE researchers and
                                         Language Model (LM) providers to mitigate these concerns. The                                   Figure 1: ChatGPT’s detailed answers about a specific bug in
                                         implications of the guidelines are illustrated using existing good                              Defects4J.
                                         practices followed by LLM providers and a practical example for
                                                                                                                                         control. This intricacy underscores the need to thoroughly examine
                                         SE researchers in the context of test case generation.
                                                                                                                                         the validity of research findings when LLMs are involved.
                                                                                                                                            For instance, consider the evaluation of LLMs using well-known
                                         CCS Concepts
                                                                                                                                         projects such as those included in Defects4J [24]. Although ChatGPT-
                                         • Software and its engineering → Empirical software val-                                        3.5, as a general-purpose chatbot, is not fine-tuned for specific
                                         idation; • Computing methodologies → Machine learning; •                                        SE tasks, it possesses precise knowledge of the bugs within these
                                         General and reference → Evaluation.                                                             projects (see Figure 1). Thus, when OpenAI models are employed
                                         ACM Reference Format:                                                                           for tasks like patch generation [42], fault localization [40], or test
                                         June Sallou, Thomas Durieux, and Annibale Panichella. 2024. Breaking the                        generation [35] for Defects4J, they have superior performance com-
                                         Silence: the Threats of Using LLMs in Software Engineering. In Proceedings                      pared to an unknown code [34]. This foreknowledge arises from the
                                         of the 46th International Conference on Software Engineering (ICSE ’24). ACM,                   pre-trained process, as ChatGPT has been trained on a large variety
                                         New York, NY, USA, 5 pages.                                                                     of datasets, including scientific papers (though the specifics are not
                                                                                                                                         fully disclosed). This raises severe concerns about the threats to
                                         1     Introduction                                                                              both construct (training and evaluating on the same dataset) and
                                         In recent years, the utilization of Large Language Models (LLMs) has                            external (do the results hold for unknown projects/code?) validity.
                                         gained substantial traction within the Software Engineering (SE)                                   This paper aims to initiate a community-wide discussion and
                                         community. Equipped with language understanding and generation                                  raise awareness of these issues to facilitate collective progress.
                                         capabilities, these models have impacted various SE research and                                Specifically, we focus on three key threats to validity: 1 Using
                                         practice aspects. From code generation to bug detection and natural                             closed-source LLMs and their implications w.r.t. data privacy and
                                         language interactions with codebases, LLMs have played a pivotal
                                                                                                                                         the models’ evolution unpredictability. 2 The blurry separation
                                         role in recent SE advancements [20, 26, 29, 34, 41].
                                                                                                                                         between training, validation, and test sets and the corresponding
                                            Despite their promise, researchers must tread cautiously when
                                         making claims about the effectiveness of their approaches. The                                  potential explicit/implicit data leakage. 3 Reproducibility of the
                                         outcomes of experiments involving LLMs can be influenced by                                     published research outcomes over time, due to the non-stochastic
                                         numerous intricate factors that can be challenging to discern or                                nature of LLMs answers, the non-transparent releases of new model
                                                                                                                                         versions, and the lack of complete traceability.
                                         Permission to make digital or hard copies of all or part of this work for personal or
                                                                                                                                            While recent papers acknowledge some of these concerns (e.g., [23,
                                         classroom use is granted without fee provided that copies are not made or distributed           34, 44]), we highlight the necessity for further empirical method-
                                         for profit or commercial advantage and that copies bear this notice and the full citation       ologies—such as code obfuscation, multiple independent prompts
                                         on the first page. Copyrights for components of this work owned by others than the
                                         author(s) must be honored. Abstracting with credit is permitted. To copy otherwise, or          or queries, and metadata provision—to alleviate and address these
                                         republish, to post on servers or to redistribute to lists, requires prior specific permission   concerns. Therefore, we present an initial set of guidelines aimed
                                         and/or a fee. Request permissions from permissions@acm.org.                                     at mitigating these threats, specifically targeting SE researchers
                                         ICSE 2024, April 2024, Lisbon, Portugal
                                         © 2024 Copyright held by the owner/author(s). Publication rights licensed to ACM.               and Language Model (LM) providers. While we provide a list of
                                                                                                                                         actionable suggestions, we emphasize the importance of the wide

ICSE 2024, April 2024, Lisbon, Portugal Sallou, et al.

SE community to follow our initial steps and build a more compre-
generated by Codex \[15\], originating from its training set. Schäfer
hensive list of threats to validity and research methods to address et
al. \[34\] investigated the performances of three LLMs (Codex, them,
ultimately advancing the field while ensuring the reliability ChatGPT3.5
\[28\], and CodeGen \[27\]) in generating unit tests for and validity of
LLM-based research contributions. Java programs. They reported
remarkable performance discrepan- To illustrate the practical
application of our guidelines, we demon- cies between the HumanEval
\[12\] (\>69% branch coverage) and the strate their implementation in
the context of test case generation ---a SF110 \[21\] (2% branch
coverage) datasets. We remark that the for- well-established SE task
\[21, 30\]--- using ChatGPT 3.5 on two buggy mer is available on GitHub
\[12\] while the latter is is not (available code snippets from
Defects4J \[24\]. We provide a full replication on SourceForge instead).
package \[13\] including (1) the implementation of our guidelines,
Additionally, previous studies in metamorphic testing \[8, 17, 43, and
(2) the results of our analysis. Finally, we highlight existing 45\]
have demonstrated how semantic-preserving changes to code good practices
from LLMs providers that align with our guidelines. snippets can
effectively deceive LLMs. These approaches create new data points that
differ from the original ones by at least one 2 Threats to Validity for
LLMs metamorphic change, increasing the likelihood that LLMs will not
This section opens the discussion related to LLM-based research
recognize the code snippets seen during pre-training. within the SE
research community. Data leakage due to fine-tuning. LMs applied to
specific SE tasks require parameter tuning via supervised learning,
adjusting 2.1 Closed-Source Models parameters using labeled datasets
specific to the task. Despite ef- A significant portion of the LLMs
community heavily relies on forts to separate training, validation, and
test sets, ensuring clear closed-source models, as evidenced by the
prevalence of ChatGPT- distinctions is not guaranteed. In practice,
different projects might related papers at this year's ICSE conference.
This dependence have common dependencies and use the same pre-defined
APIs. stems from factors such as the models' effectiveness,
availability, For instance, within the Java ecosystem, numerous
libraries/tools and cost-effectiveness. To put this into perspective,
deploying an often rely on common dependencies like Log4j, Apache
Commons, open-source LLM model comparable to ChatGPT, like the Falcon
Spring, GSon, and others. Consequently, a scenario of data leakage 180B
model, would incur a monthly cost of \$29,495 on AWS.1 can arise if the
LLM is trained on "project A" that employs a specific However, the
utilization of closed-source models introduces sig- API, and the
resulting model is subsequently used to fix the usage nificant threats
to the validity of the research approach. of the same API in another
project within the test set. Model Evolution Unpredictability. One
primary concern arises from the lack of control over the evolution of
these closed- 2.3 Reproducibility source models. New models may be
released into production \[33\], Several concerns can be raised w.r.t
the reproducibility of the LLMs and notable changes in the output of
OpenAI models have been outputs. The ability to obtain identical results
following the same observed \[14\]. Such changes can occur during or
after the research procedure by external parties is proven to be
challenging. approach has been presented, potentially making the
presented Output Variability. LLMs exhibit variability in their outputs,
results obsolete. Moreover, this concern is also particularly pro- even
when using identical input. Running the same prompt several nounced for
incremental works that use LLM. Indeed, distinguish- times may not
result in identical output, rendering the usage of ing whether the
improvements claimed in the new contribution are LLMs non-deterministic.
Examples of such phenomena have been the result of changes to the LLMs'
models or due to the novelty of described in the literature, including
other application domains, the contribution becomes a complex task. such
as the medical domain \[19\]. We also experimented with an Privacy
Implications. Another significant aspect of concern example in software
engineering involving a code generation task. is privacy. Closed-source
models often lack transparency, making In this use case, we demonstrate
that running a prompt to generate it difficult to assess the privacy
implications associated with their Python code multiple times results in
different responses from the usage \[5\] as well as potential copyright
infringements. GPT-3.5 model. To avoid data contamination, we get
inspiration from the methodology outlined by Chen et al. \[14\]. We use
a coding 2.2 Implicit Data Leakage challenge from the LeetCode \[2\]
platform as the prompt, employing LLMs are trained on vast textual
datasets such as Wikipedia, GitHub, the same prompt twice in two
separate sessions2 on the same day and StackOverflow \[15, 36\] and
derive their understanding of se- (September 12th, 2023). During these
sessions (whose chat links mantics and contextual word relationships
from this diverse data. are provided as footnotes), we observe distinct
codes generated These models contain millions (e.g., BERT) to billions
(e.g., ChatGPT- by GPT-3.5, with varying function operations reasoning,
variable 4 and LLaMA) of parameters, which undergo a series of iterative
names, and initialization values or expressions. optimizations during
pre-training that minimize the loss function. Time-Based Output Drift.
Furthermore, there is no assurance Data leakage due to pre-training.
Pre-training in unsuper- that the results will remain consistent over
time. As discussed in vised or semi-supervised learning does not tailor
models for specific Section 2.1, many LLMs are closed-source, and there
are no estab- software engineering tasks they will be later evaluated on
after lished practices akin to regression testing to account for output
parameter re-tuning. Nonetheless, questions can be raised whether
variability. Running the same prompt at a later time (e.g., days or LLMs
potentially memorize existing code samples used for evalu- months) may
lead to a drift in the outcome due to potential retrain- ation, instead
of generating new, unseen code \[22\]. For instance, ing between
sessions, reinforcement learning between sessions, or prior studies
\[11, 23, 25, 32\] highlighted vulnerabilities in code 2 first session:
https://chat.openai.com/share/a0c7ef5c-74ce-466b-a1d5-5f44e03a626d, 1
Visited on 7-Dec-2023, 8x A100 80GB on
https://aws.amazon.com/ec2/instance-types/ second
session:https://chat.openai.com/share/6566acff-12eb-470a-a043-3e2294cf6406
Breaking the Silence: the Threats of Using LLMs in Software Engineering
ICSE 2024, April 2024, Lisbon, Portugal

adjustments based on user feedback. Chen et al. \[14\] explored this
without requiring access to the entire model. Toward this direction,
time-based output drift in terms of accuracy for two versions of OpenAPI
has recently released a beta feature 4 that allows users to GPT models
over a three-month interval. They show that, over a set fixed seeds
during prompting, although deterministic answer is range of tasks and
application domains, the overall accuracy of out- not fully guaranteed
due to different back-end settings. puts decreases, accompanied by a
remarkable mismatch in answers. Use an archiving system. In addition to
the Versioning Infor- In particular, for code generation, the mismatch
is evaluated at 20% mation, we advocate for the usage of a general
archiving system, to for GPT-3.5 and 50% for GPT-4 between March 2023
and June 2023. ensure that external parties can reproduce the
observations made Moreover, the number of executable outputs drops from
52% to 10% by LLMs. It should be noted that some efforts are already
being for GPT-3.5, and from 22% to 2% for GPT-4.0 for the same period.
made in that direction. We can cite the HuggingFace platform \[1\],
Traceability. Another critical concern associated with the wide- which
provides pre-trained models for download with information spread
adoption of LLMs is the lack of traceability. Currently, con- about the
model training, file versioning, and datasets. Zenodo \[3\] necting the
output of LLMs to specific prompts, along with 'con- is another example
of storing and making versioned models and figuration' details such as
the version of the used LLM, the date of datasets accessible and
reusable, which is commonly used in the the query, and other
specifications, can be a challenging task. research community. However,
the use of such platforms is not yet a regular and consistent practice.
Moreover, a dedicated LLM 3 Discussion and Guidelines platform is still
missing, as LLM sizes are generally large, posing In this section, we
present initial guidelines and methodologies challenges for downloading
or uploading addressing the mentioned threats. While we provide a list
of action- able suggestions as opening steps, we encourage the SE
community 3.2 Guidelines for SE Researchers to work toward establishing
standards and expectations at the same This section outlines guidelines
for SE researchers. Along with pre- level as those commonly applied with
traditional AI techniques. We senting guidelines, we exhibit their
practical applicability through organize the guidelines according to the
actors they involve: the a showcase example, using ChatGPT3.5 to
generate JUnit test cases LLM providers, and the SE researchers using
LLMs. for two buggy programs in the Defect4j dataset \[24\], Chart-11
and Math-5. The prompts with the collected answers, data analysis, and
3.1 Guidelines for LLM Providers metadata are available in our
replication package \[13\]. 3.1.1 Closed-Source Models We foresee two
main strategies to 3.2.1 Reproducibility To address the threats to the
reproducibility address this category of threats to validity: of
LLMs-based approaches, we proposed the following guidelines: Enhance
model transparency. LLM providers should priori- Assess output
variability. Due to output variability, running tize transparency by
furnishing comprehensive information about the LLMs' inference only once
is insufficient to ensure reproducibil- their models. This should
encompass details on the model's creation ity. Therefore, we argue in
favor of conducting multiple replication process and the methodology
used for data selection during train- runs and using variability metrics
during the evaluation. For our ing. Furthermore, providers should share
statistics and data-point showcase example, we queried ChatGPT3.5 ten
times over different information to shed light on the model's training
dataset. Ideally, an days using the same prompts (see our replication
package) and API service could be established, enabling users to verify
if a partic- targeting only the buggy methods (i.e., no the entire
classes). We ular data source was included in the model's training or
validation then analyzed the resulting branch coverage and test
execution datasets. Such a service would not only enhance transparency
but results. For Math-5, we report an average branch coverage of 70%
could also serve privacy and copyright verification purposes. for the
tested Java method with a large variability (interquartile Use
versioning information. Providers should provide their range or IQR) of
27.5%. We also observe variability in the number model version, and they
should adopt a versioning nomenclature of generated tests (between 5 and
7) and number of failing tests that distinguishes major revisions from
minor updates. This enables (between 1 and 2). For Chart-11, the
generated tests achieve 71% of users to discern the significance of
model version changes. branch coverage for the tested Java method, with
20% IQR. ChatGPT 3.1.2 Data Leakage In light of concerns regarding
closed-source also generates between 1 and 5 failing tests for this
method. models, LLM providers should provide services that allow
researchers Provide execution metadata. Associated with the LLMs infer-
to verify which projects and sources were considered during pre- ence
results, we argue that relevant additional data should be made training.
A positive example is CodeBERT, whose provides do accessible and
considered during the evaluation of LLMs. Such in- not disclose
pre-training code but enable verification of included formation
includes, but is not limited to: (i) Model information: To projects for
pre-training through the train split data.3 reproduce the LLMs' results
and evaluation, information concern- ing the model is necessary (e.g.,
version, seed, etc.). Furthermore, 3.1.3 Reproducibility We propose two
methods to address this: Use the model itself should be accessible to
enable its use, at least in a fixed random seed. LLM providers should
ensure the inclusion a black box manner. (ii) Prompts: The exact inputs
(queries) used of a settable random seed during the inference of LLMs,
render for the inference and evaluation of the LLMs. (iii) Date of LLMs
the inference deterministic for each specific case. This practice query:
The date is relevant data to share to address the time-based would help
address the variability of output concerning traceability output drift
(that can happen because of retraining of models, or re- and
reproducibility. In the case of closed-source LLMs, a dedicated
inforcement learning from past human feedback and interactions). API
could be made accessible, allowing the user to set the seed (iv) Output
variability metrics and associated assessment package: 3
https://huggingface.co/datasets/code_search_net 4
https://platform.openai.com/docs/guides/text-generation/reproducible-outputs
ICSE 2024, April 2024, Lisbon, Portugal Sallou, et al.

Information concerning the assessment of output variability would Code
clone detection. Given the current low transparency enable the user to
understand the risk regarding consistency in of closed-source LLMs,
tracing the projects used for pre-training using the LLM in question.
Providing the package containing the is challenging, if not impossible.
However, researchers can use prompts and results used during this
evaluation would help to well-established code clone detection
techniques \[4\] to check if the ensure reproducibility. (v) Scope of
reproducibility: To ensure the generated code (e.g., test cases) is
similar to code seen in online trusted and controlled usage of LLMs,
information about the scope repositories (e.g., manually-written test
cases). in which the model has been trained or assessed should be
disclosed, Check for common dependencies. To prevent implicit data
including the application domains and studied use cases. leakage between
training, evaluation, and test sets (for task-specific We provide an
example of metadata (written using the JSON evaluation), researchers
should (1) cross-compare the external de- format) for the showcase of
this paper in our replication material. pendencies between projects
belonging to different sets, (2) use code cloning techniques to assess
whether similar code (e.g., API 3.2.2 Data Leakage A few recommendations
can be made to tackle uses) appear between different projects from the
different sets. the crucial concerns about the potential data leakage:
Assess LLMs on metamorphic data. Metamorphic testing is 3.2.3
Closed-Source Models Perform comparative analysis. Re- active research
for the model robustness \[8, 17, 45\]. Metamorphic searchers are
encouraged to run experiments using both open- testing generates new
data samples (code) by applying metamorphic source and closed-source
LLMs. This comparative approach can transformations to the validation or
test sets. These new snippets provide additional insights into the
strengths and limitations of maintain semantic and behavioral
equivalence with the original each. Notably, the open-source LLM
community has witnessed an code, yet exhibit structural differences
(e.g., distinct Abstract Syntax expansion in availability, with models
like llama2 \[37\] and Falcon Trees). Prior studies have shown that
CodeBERT and code2vec are 180B \[7\] emerging as viable options. llama2
models, in particular, not robust, i.e., they produce different (worse)
results when obfus- offer the advantage of running on consumer-grade
devices. cating the variable names \[17\], introducing unused variables
\[45\], Framework Facilitation. To streamline the evaluation process
replacing tokens with plausible alternatives \[16\], and wrapping-up
across multiple models, researchers can leverage frameworks such
expressions in identity-lambda functions \[8, 9\]. as ONNX 5 . ONNX
simplifies the transition between various models, Therefore, we advise
researchers to complement the analysis enhancing the efficiency and
consistency of experimentation. of the LLMs performance with new data
samples generated with metamorphic testing. The selection of metamorphic
transforma- 4 Conclusion and Future Work tions should align with the
specific task at hand. For example, code In this article, we have
initiated a discussion about the usage of obfuscation (for method/class
names) should not hinder the ability LLMs in SE contributions, along
with the challenges and threats to of LLMs to generate unit tests or
patches successfully. Instead, iden- validity they bring. We have
identified three primary challenges: tifier names are crucial for
NLP-related tasks (e.g., method name the reliance on closed-source LLMs,
potential data leakages, and prediction), and other metamorphic
transformations should be ap- concerns about reproducibility. To
mitigate these, we propose an plied (e.g., wrapping up expressions in
identity-lambda functions). initial set of guidelines. We aim to
encourage an ongoing dialogue To show the practicability of this
guideline, we have applied within the community to navigate these
challenges effectively. code metamorphic transformations to the Java
methods of Math-5 It is essential to continue reflecting and staying
critical about and Chart-11. In particular, we (1) removed the javadoc
and (2) the usage of LLMs in SE. We must collectively define guidelines
renamed the method under test and its input parameters. For re- and
expectations within our community. We believe the conversa- naming, we
did not use randomly generated string but opted for tion should be
spread by organizing panels with different experts synonyms and English
words (e.g., changing the method name and stakeholders. We should also
monitor the evolution of good reciprocal() in complementary() for
Math-5) to maintain the practices in the literature and maintain
community guidelines. naturalness of the transformed code \[43\]. While
we do not observe We emphasize the importance of disseminating
evaluation expec- a significant difference in terms of branch coverage
achieved for tations from the SE to the ML community, fostering mutual
under- Chart-11 (𝑝-value=0.79 according to the Wilcoxon test) between
standing of evolving practices. It's noteworthy that metrics drawn the
original and transformed code, we report a small negative ef- from
Natural Language Processing (NLP) studies (e.g., counting the fect size
(𝐴ˆ12 =0.63) w.r.t. the number of failing tests (larger for the number
of compiling unit tests generated by LLMs as done in \[6, 38\])
transformed code). The difference we obtained for Math-5 on the ob- do
not adequately reflect the well-established performance metrics fuscated
code is much more significant. While ChatGPT constantly for SE tasks
that do not have an NLP focus (e.g., see the existing generated tests
for the original program with a branch coverage standards for assessing
unit test generation tools \[10, 18, 31\]). of 71%, it struggled to
generate any meaningful tests on the trans- We strongly believe that
breaking the silence as a community formed code. In particular, ChatGPT
always created non-compiling will enhance the validity and reliability
of our LLM-based contribu- tests with clear examples of hallucination
\[34, 46\], i.e., invoking tions and the SE community in general. The
goal is to ultimately methods/constructors that were never included in
the prompts. advance the field while ensuring high research quality and
high Use different sources. As shown by Schäfer et al. \[34\], LLMs
methodological standards (considering different aspects, including
achieve much worse results on projects from SourceForge com- data
privacy \[5\], carbon footprint \[39\], etc.). pared to GitHub. Hence,
we recommend researchers gather soft- ware projects and data from
multiple sources. 5 https://onnx.ai/ Breaking the Silence: the Threats
of Using LLMs in Software Engineering ICSE 2024, April 2024, Lisbon,
Portugal

References Proceedings of the 2014 International Symposium on Software
Testing and Analysis (San Jose, CA, USA) (ISSTA 2014). ACM, NY, USA,
437--440. \[1\] 2023. Hugging Face -- The AI community building the
future. https://huggingface. \[25\] Anjan Karmakar, Julian Aron Prenner,
Marco D'Ambros, and Romain Robbes. co \[Online; accessed 11.
Sept. 2023\]. 2022. Codex Hacks HackerRank: Memorization Issues and a
Framework for Code \[2\] 2023. LeetCode - The World's Leading Online
Programming Learning Platform. Synthesis Evaluation. arXiv (Dec. 2022).
https://doi.org/10.48550/arXiv.2212. https://leetcode.com \[Online;
accessed 12. Sept. 2023\]. 02684 arXiv:2212.02684 \[3\] 2023. Zenodo.
https://zenodo.org \[Online; accessed 11. Sept. 2023\]. \[26\] Caroline
Lemieux, Jeevana Priya Inala, Shuvendu K. Lahiri, and Siddhartha Sen.
\[4\] Qurat Ul Ain, Wasi Haider Butt, Muhammad Waseem Anwar, Farooque
Azam, 2023. CodaMosa: Escaping Coverage Plateaus in Test Generation with
Pre- and Bilal Maqbool. 2019. A systematic review on code clone
detection. IEEE Trained Large Language Models. In Proc. of the 45th
International Conference access 7 (2019), 86121--86144. on Software
Engineering (ICSE '23). IEEE Press, Melbourne, Victoria, Australia,
\[5\] Ali Al-Kaswan and Maliheh Izadi. 2023. The (ab)use of Open Source
Code to 919--931. https://doi.org/10.1109/ICSE48619.2023.00085 Train
Large Language Models. In 2023 IEEE/ACM 2nd International Workshop on
\[27\] Erik Nijkamp, Bo Pang, Hiroaki Hayashi, Lifu Tu, Huan Wang,
Yingbo Zhou, Natural Language-Based Software Engineering (NLBSE). Silvio
Savarese, and Caiming Xiong. 2022. Codegen: An open large language \[6\]
Saranya Alagarsamy, Chakkrit Tantithamthavorn, and Aldeida Aleti. 2023.
model for code with multi-turn program synthesis. arXiv preprint
arXiv:2203.13474 A3Test: Assertion-Augmented Automated Test Case
Generation. arXiv preprint (2022). arXiv:2302.10352 (2023). \[28\]
OpenAI. 2023. OpenAI. https://openai.com/ Accessed on September 14th,
2023. \[7\] Ebtesam Almazrouei, Hamza Alobeidli, Abdulaziz Alshamsi,
Alessandro Cappelli, \[29\] Ipek Ozkaya. 2023. Application of Large
Language Models to Software Engi- Ruxandra Cojocaru, Maitha Alhammadi,
Mazzotta Daniele, Daniel Heslow, Julien neering Tasks: Opportunities,
Risks, and Implications. IEEE Software 40, 3 (April Launay, Quentin
Malartic, Badreddine Noune, Baptiste Pannier, and Guilherme 2023), 4--8.
https://doi.org/10.1109/MS.2023.3248401 Penedo. 2023. The Falcon Series
of Language Models: Towards Open Frontier \[30\] Annibale Panichella,
Fitsum Meshesha Kifetew, and Paolo Tonella. 2015. Refor- Models. (2023).
mulating branch coverage as a many-objective optimization problem. In
2015 \[8\] Leonhard Applis, Annibale Panichella, and Ruben Marang. 2023.
Searching for IEEE 8th international conference on software testing,
verification and validation Quality: Genetic Algorithms and Metamorphic
Testing for Software Engineering (ICST). IEEE, 1--10. ML. In Proc. of
the Genetic and Evolutionary Computation Conference. 1490--1498. \[31\]
Sebastiano Panichella, Alessio Gambi, Fiorella Zampetti, and Vincenzo
Riccio. \[9\] Leonhard Applis, Annibale Panichella, and Arie van
Deursen. 2021. Assessing 2021. Sbst tool competition 2021. In 2021
IEEE/ACM 14th International Workshop Robustness of ML-Based Program
Analysis Tools using Metamorphic Program on Search-Based Software
Testing (SBST). IEEE, 20--27. Transformations. In 2021 36th IEEE/ACM
International Conference on Automated \[32\] H. Pearce, B. Tan, B.
Ahmad, R. Karri, and B. Dolan-Gavitt. 2023. Examining Zero- Software
Engineering (ASE). 1377--1381. Shot Vulnerability Repair with Large
Language Models. In 2023 IEEE Symposium \[10\] Andrea Arcuri and Lionel
Briand. 2014. A hitchhiker's guide to statistical tests on Security and
Privacy (SP). IEEE, Los Alamitos, CA, USA, 2339--2356. https: for
assessing randomized algorithms in software engineering. Software
Testing, //doi.ieeecomputersociety.org/10.1109/SP46215.2023.10179420
Verification and Reliability 24, 3 (2014), 219--250. \[33\] Luiza
Pozzobon, Beyza Ermis, Patrick Lewis, and Sara Hooker. 2023. On \[11\]
Owura Asare, Meiyappan Nagappan, and N Asokan. 2022. Is github's copi-
the Challenges of Using Black-Box APIs for Toxicity Evaluation in
Research. lot as bad as humans at introducing vulnerabilities in code?
arXiv preprint arXiv:2304.12397 \[cs.CL\] arXiv:2204.04741 (2022).
\[34\] Mohammed Latif Siddiq, Joanna Santos, Ridwanul Hasan Tanvir,
Noshin Ulfat, \[12\] Ben Athiwaratkun, Sanjay Krishna Gouda, Zijian
Wang, Xiaopeng Li, Yuchen Fahmid Al Rifat, and Vinicius Carvalho Lopes.
2023. Exploring the Effectiveness of Tian, Ming Tan, Wasi Uddin Ahmad,
Shiqi Wang, Qing Sun, Mingyue Shang, Large Language Models in Generating
Unit Tests. arXiv preprint arXiv:2305.00418 et al. 2022. Multi-lingual
evaluation of code generation models. arXiv preprint (2023).
arXiv:2210.14868 (2022). \[35\] Yutian Tang, Zhijie Liu, Zhichao Zhou,
and Xiapu Luo. 2023. ChatGPT vs \[13\] Authors. 2023.
https://github.com/LLM4SE/obfuscated-ChatGPT-experiments SBST: A
Comparative Assessment of Unit Test Suite Generation. arXiv preprint
\[14\] Lingjiao Chen, Matei Zaharia, and James Zou. 2023. How is
ChatGPT's behavior arXiv:2307.00588 (2023). changing over time? arXiv
preprint arXiv:2307.09009 (July 2023). arXiv:2307.09009 \[36\] Hugo
Touvron, Thibaut Lavril, Gautier Izacard, Xavier Martinet, Marie-Anne
\[15\] Mark Chen, Jerry Tworek, Heewoo Jun, Qiming Yuan, Henrique Ponde
de Oliveira Lachaux, Timothée Lacroix, Baptiste Rozière, Naman Goyal,
Eric Hambro, Faisal Pinto, Jared Kaplan, Harri Edwards, Yuri Burda,
Nicholas Joseph, Greg Brockman, Azhar, et al. 2023. Llama: Open and
efficient foundation language models. arXiv et al. 2021. Evaluating
large language models trained on code. arXiv preprint preprint
arXiv:2302.13971 (2023). arXiv:2107.03374 (2021). \[37\] Hugo Touvron,
Louis Martin, Kevin Stone, Peter Albert, Amjad Almahairi, Yas- \[16\]
Jürgen Cito, Isil Dillig, Vijayaraghavan Murali, and Satish Chandra.
2022. Coun- mine Babaei, Nikolay Bashlykov, Soumya Batra, Prajjwal
Bhargava, Shruti Bhos- terfactual explanations for models of code. In
Proceedings of the 44th International ale, et al. 2023. Llama 2: Open
foundation and fine-tuned chat models. arXiv Conference on Software
Engineering: Software Engineering in Practice. 125--134. preprint
arXiv:2307.09288 (2023). \[17\] Rhys Compton, Eibe Frank, Panos Patros,
and Abigail Koay. 2020. Embedding \[38\] Michele Tufano, Dawn Drain,
Alexey Svyatkovskiy, Shao Kun Deng, and Neel Java Classes with code2vec:
Improvements from Variable Obfuscation. In 2020 Sundaresan. 2020. Unit
test case generation with transformers and focal context. IEEE/ACM 17th
International Conference on Mining Software Repositories (MSR). arXiv
preprint arXiv:2009.05617 (2020). IEEE, New York, NY, USA, 243--253.
https://doi.org/10.1145/3379597.3387445 \[39\] Roberto Verdecchia, June
Sallou, and Luís Cruz. 2023. A systematic review of \[18\] Xavier
Devroey, Alessio Gambi, Juan Pablo Galeotti, René Just, Fitsum Kifetew,
Green AI. WIREs Data Mining and Knowledge Discovery 13, 4 (2023), e1507.
Annibale Panichella, and Sebastiano Panichella. 2023. JUGE: An
infrastructure https://doi.org/10.1002/widm.1507 for benchmarking Java
unit test generators. Software Testing, Verification and \[40\] Yonghao
Wu, Zheng Li, Jie M Zhang, Mike Papadakis, Mark Harman, and Reliability
33, 3 (2023), e1838. Yong Liu. 2023. Large Language Models in Fault
Localisation. arXiv preprint \[19\] Richard H. Epstein and Franklin
Dexter. 2023. Variability in Large Language arXiv:2308.15276 (2023).
Models' Responses to Medical Licensing and Certification Examinations.
Com- \[41\] Chunqiu Steven Xia, Yuxiang Wei, and Lingming Zhang. 2023.
Automated ment on "How Does ChatGPT Perform on the United States Medical
Licensing program repair in the era of large pre-trained language
models. In Proceedings of Examination? The Implications of Large
Language Models for Medical Education the 45th International Conference
on Software Engineering (ICSE 2023). Association and Knowledge
Assessment". JMIR Medical Education 9, 1 (July 2023), e48305. for
Computing Machinery. https://doi.org/10.2196/48305 \[42\] Chunqiu Steven
Xia and Lingming Zhang. 2023. Keep the Conversation Go- \[20\] Zhiyu
Fan, Xiang Gao, Martin Mirchev, Abhik Roychoudhury, and Shin Hwei ing:
Fixing 162 out of 337 bugs for \$0.42 each using ChatGPT. arXiv preprint
Tan. 2023. Automated Repair of Programs from Large Language Models. In
2023 arXiv:2304.00385 (2023). IEEE/ACM 45th International Conference on
Software Engineering (ICSE). IEEE, \[43\] Zhou Yang, Jieke Shi, Junda
He, and David Lo. 2022. Natural attack for pre-trained 1469--1481.
https://doi.org/10.1109/ICSE48619.2023.00128 models of code. In
Proceedings of the 44th International Conference on Software \[21\]
Gordon Fraser and Andrea Arcuri. 2011. EvoSuite: Automatic Test Suite
Gen- Engineering. 1482--1493. eration for Object-Oriented Software. In
Proceedings of the 19th ACM SIGSOFT \[44\] Wentao Ye, Mingfeng Ou,
Tianyi Li, Xuetao Ma, Yifan Yanggong, Sai Wu, Jie ESEC/FSE (Szeged,
Hungary) (ESEC/FSE '11). ACM, New York, NY, USA, 416--419. Fu, Gang
Chen, Junbo Zhao, et al. 2023. Assessing Hidden Risks of LLMs: An
https://doi.org/10.1145/2025113.2025179 Empirical Study on Robustness,
Consistency, and Credibility. arXiv preprint \[22\] Huseyin Atahan Inan,
Osman Ramadan, Lukas Wutschitz, Daniel Jones, Victor arXiv:2305.10235
(2023). Rühle, James Withers, and Robert Sim. 2021. Training Data
Leakage Analysis in \[45\] Noam Yefet, Uri Alon, and Eran Yahav. 2020.
Adversarial examples for models of Language Models. (February 2021).
https://www.microsoft.com/en-us/research/ code. Proc. of the ACM on
Programming Languages 4, OOPSLA (2020), 1--30.
publication/training-data-leakage-analysis-in-language-models/ \[46\]
Yue Zhang, Yafu Li, Leyang Cui, Deng Cai, Lemao Liu, Tingchen Fu,
Xinting \[23\] Kevin Jesse, Toufique Ahmed, Premkumar T Devanbu, and
Emily Morgan. 2023. Huang, Enbo Zhao, Yu Zhang, Yulong Chen, et
al. 2023. Siren's Song in the AI Large Language Models and Simple,
Stupid Bugs. arXiv preprint arXiv:2303.11455 Ocean: A Survey on
Hallucination in Large Language Models. arXiv preprint (2023). \[24\]
René Just, Darioush Jalali, and Michael D. Ernst. 2014. Defects4J: A
Database arXiv:2309.01219 (2023). of Existing Faults to Enable
Controlled Testing Studies for Java Programs. In 
