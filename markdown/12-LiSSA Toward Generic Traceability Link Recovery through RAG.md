LiSSA: Toward Generic Traceability Link Recovery through
Retrieval-Augmented Generation Dominik Fuchß , Tobias Hey , Jan Keim ,
Haoyu Liu , Niklas Ewald , Tobias Thirolf , Anne Koziolek KASTEL -
Institute of Information Security and Dependability Karlsruhe Institute
of Technology (KIT), Karlsruhe, Germany {dominik.fuchss, hey, jan.keim,
haoyu.liu, koziolek}@kit.edu niklas.ewald@alumni.kit.edu,
tobias.thirolf@student.kit.edu

Abstract---There are a multitude of software artifacts which
requirements to requirements \[1\], \[21\]--\[23\], or architecture need
to be handled during the development and maintenance documentation to
architecture models \[7\]. However, the ap- of a software system. These
artifacts interrelate in multiple, proaches' performances vary depending
on the tasks. Often, complex ways. Therefore, many software engineering
tasks are enabled --- and even empowered --- by a clear understanding of
approaches do not achieve the necessary performance to be artifact
interrelationships and also by the continued advancement used in
practice \[21\], \[24\], \[25\]. of techniques for automated artifact
linking. Large Language Models (LLMs) offer promising capabil- However,
current approaches in automatic Traceability Link ities regarding
natural language understanding. Furthermore, Recovery (TLR) target
mostly the links between specific sets of LLMs have already proven to be
effective in a variety of soft- artifacts, such as those between
requirements and code. Fortu- nately, recent advancements in Large
Language Models (LLMs) ware engineering tasks, including code generation
\[26\]--\[29\], can enable TLR approaches to achieve broad
applicability. Still, code summarization \[30\]--\[32\], or API
recommendation \[33\]. it is a nontrivial problem how to provide the
LLMs with the In particular, LLMs could lead to a generic approach for
specific information needed to perform TLR. TLR. Nevertheless, LLMs face
the challenge that they do not In this paper, we present LiSSA, a
framework that har- know the project and its context. In particular, an
LLM cannot nesses LLM performance and enhances them through Retrieval-
Augmented Generation (RAG). We empirically evaluate LiSSA on handle the
complete content of a larger software project due three different TLR
tasks, requirements to code, documentation to the project's size and
limited input lengths. Fortunately, the to code, and architecture
documentation to architecture models, processing can be augmented by
retrieval techniques, called and we compare our approach to
state-of-the-art approaches. retrieval-augmented generation (RAG)
\[34\]. Here, the first step Our results show that the RAG-based
approach can signifi- is retrieving relevant artifacts based on
information retrieval cantly outperform the state-of-the-art on the
code-related tasks. However, further research is required to improve the
perfor- (IR) techniques. The LLM then generates the answer using mance
of RAG-based approaches to be applicable in practice. the retrieved
artifacts. In this paper, we propose using RAG with LLMs to perform
Index Terms---Traceability Link Recovery, Large Language TLR between
various artifacts. Our RAG-based approach for Models,
Retrieval-Augmented Generation TLR is called LiSSA (Linking Software
System Artifacts). We focus on three different TLR tasks that cover
diverse settings I. I NTRODUCTION to generate insights about the
performance of RAG-based In the complex task of software development,
developers approaches for TLR: tracing requirements to code, tracing and
other stakeholders handle numerous artifacts, such as re- architecture
documentation to code, and tracing architecture quirements, code,
documentation, and models. Consequently, documentation to architecture
models. success in development depends, in part, on understanding The
example project in Figure 1 illustrates these tasks. how software
artifacts interrelate. To deal with the interre- The project contains
requirements, some classes from the lations of these artifacts,
researchers and practitioners actively source code, the component-based
architecture, and a part of investigate the creation and recovery of
so-called trace links the documentation of a system that provides and
processes between these artifacts. Traceability Link Recovery (TLR)
images. We consider the four artifacts as different sources identifies
correspondences between elements in artifacts and of information about
the system. The requirements contain makes them explicit. Thus, TLR
helps to reduce the com- the need for a REST API, that is implemented in
the code plexity of many development tasks, such as change impact as
RestFacade. Thus, there is this trace link between the analysis \[1\],
\[2\], bug localization \[3\], and maintenance \[4\], \[5\]. requirement
and the code file. Additionally, the component Moreover, trace links can
also be used to identify inconsisten- diagram shows the database
component that is realized in code cies between artifacts \[6\], \[7\].
Typically, automated approaches as the package db. This results in a
trace link between the are task-specialized, i.e., they are designed to
recover specific architecture and the code. Lastly, the documentation
describes types of trace links, such as requirements to code
\[8\]--\[14\], the use of a REST interface to process the images. This
defines documentation to code \[15\], issues to commit \[16\]--\[20\],
trace links from the documentation to the code and to the  we present
our RAG-based approach LiSSA. In Section IV, Requirements Architecture
we discuss the evaluation of retrieval-augmented LLMs for TLR and their
performance on three established TLR tasks. The system The meta-data
Component: Afterward, we discuss our findings and their implications for
shall use a shall be stored Database practice and research in Section V.
Lastly, we conclude the REST API. in the DB. paper in Section VI.
Component: Source Code Image II. R ELATED W ORK package db Processing In
this section, we focus on the state-of-the-art in the dif- Image
DbConnection ferent TLR tasks and discuss the various existing
approaches. Documentation We also cover recent advances in using LLMs
for TLR.

    RestFacade                 DbDriver                                       A. Traceability Link Recovery
                                                      We use REST
                                                        to process               In the following, we discuss the state-of-the-art approaches

getImg(id: int) connect(conn) the images. for the three types of TLR
tasks we consider: requirements to code, documentation to code, and
architecture documentation to architecture models. Fig. 1. Example
Project with Requirements, an Architecture Diagram, Natural 1)
Requirements to Code: A significant amount of research Language
Documentation, and Source Code in TLR focuses on the relationship
between requirements and code. Within this context, methods from natural
language Image Processing component in the architecture. processing
serve as fundamental components of various ap- We select these three
different TLR tasks to empirically proaches. Notably, vector space
models, latent semantic in- evaluate LiSSA on a variety of artifact
types and trace links. dexing and latent dirichlet allocation are
frequently employed Moreover, these tasks have been actively researched
in the past techniques \[8\]--\[12\]. These models consider semantic
simi- and datasets are available to evaluate TLR performance. larity
between requirements and code to bridge the semantic This motivates us
to ask RQ1: Is a generic RAG-based TLR gap and recover trace links. To
measure similarity, important approach better than task-specific,
state-of-the-art approaches? features such as common terms between
artifacts and semantic vectors of artifacts are primarily considered.
Moreover, as recent research indicates that Chain-of-thought (CoT)
prompting can be more effective than other zero-shot However, developers
might use different terms to refer to prompts in certain scenarios
\[35\], we want to further explore the same concept across different
artifacts \[37\]. This might how the performance is affected by these
LLM prompting result in mismatched vocabulary, making trace links hard
to techniques. Thus, we ask RQ2: Is CoT prompting more recover. To
address this problem, Gao et al. \[14\], \[38\] use effective than a
simple classification prompt? co-occurring term pairs (biterms) from
both requirements and code to enrich the artifact texts from both sides.
The idea is RAG heavily depends on the ability to retrieve relevant that
biterms indicate the consensus between the artifacts. information, i.e.,
(parts of) artifacts. Consequently, we investi- Hey et al. \[13\] show
that a more fine-grained interpretation gate the impact of different
preprocessing techniques for this of artifacts could improve recovery
results. Their approach retrieval; and since related research shows that
fine-grained FTLR uses sentences from requirements and methods from
mappings can improve the performance of TLR tasks \[13\], code files as
units for the similarity mapping, rather than the we ask RQ3: Does
retrieval and mapping on a fine-grained, whole requirements and source
code files. FTLR represents the sub-artifact level improve the TLR
performance compared to semantics of the fine-grained elements through
word embed- mapping on an artifact level? Furthermore, we investigate
dings. Moreover, they discovered that selecting the appropriate RQ4:
Does RAG improve the TLR performance compared information is crucial for
enhancing the performance of the ap- to embedding-based IR TLR? proach.
Hey et al. also show that the relevant information can We make the
following contributions: be derived automatically with an LLM-based
classifier \[39\]. C1: We provide LiSSA, an RAG-based approach for TLR
The consensus of these approaches is the ambition to between different
types of software artifacts. The ap- semantically understand the
artifacts to bridge the semantic proach, datasets, and results are
publicly available in our gap. LLMs promise deep language understanding
of the input replication package \[36\]. text, making them a plausible
alternative for TLR. C2: We evaluate the performance of LiSSA on three
different Another option to bridge the semantic gap is using transitive
TLR tasks and compare it to state-of-the-art approaches. links between
artifacts. The underlying idea is that intermedi- C3: We investigate the
influence of prompt techniques and ate artifacts can find implicit
tracing relationships \[40\]. preprocessing on the performance of LiSSA.
Nishikawa et al. \[41\] generate trace links between two The remainder
of this work is structured as follows: In artifact types, A and B, by
utilizing an intermediate artifact Section II, we present related work
and discuss the state- type C. They use a vector space model to create
trace links of-the-art for different TLR tasks. Afterward, in Section
III, between artifacts of types A and C and between artifacts of types B
and C. Artifacts from A and B that both trace to the Knowledge same
artifact of type C are considered connected. 0..1 parent - identifier
Moran et al. \[40\] introduced COMET, a Bayesian inference- Element -
type based method for TLR. The method involves three stages: -
granularity - content initially combining multiple text similarity
metrics to generate preliminary trace links, then incorporating
developer feedback to refine these links, and finally utilizing
information from Artifact transitive links to enhance the results.
However, when there are multiple transitive paths between Fig. 2. Data
Model: Knowledge, Elements, and Artifacts artifact pairs, it remains a
challenge how to aggregate them. This challenge is explored by Rodriguez
et al. \[42\]. Their ap- proach aggregates multiple paths using one of
three methods: model element. ArDoCo then traces these clusters to the
model the maximum score, the sum, or a weighted sum. Rodriguez et
elements. Their dataset for this task is publicly available \[48\].
al. found that an optimal transitive technique requires specific B.
Using LLMs for TLR: Prompting and RAG tuning for each project and
possibly for different trace paths Until now, LLMs have only rarely been
employed for TLR. within a project. Lin et al. \[16\] fine-tune a
CodeBERT LLM for the task of Transitive links can also help within a
single artifact recovering trace links between issues and commits.
However, type like code. Panichella et al. \[43\] showed the benefits
their approach requires initial trace links from a project for of
including call and inheritance dependencies for TLR. fine-tuning.
Therefore, they tackle a different kind of TLR Kuang et al. \[44\] then
demonstrated that data dependencies problem than our approach. provide
complementary information to call dependencies that Recently, Rodriguez
et al. \[35\] studied the application of are beneficial for linking
requirements to code. The idea is that prompt engineering on TLR. They
showed the LLM's ability "close" methods are probably linked to similar
requirements. to comprehend domain-specific knowledge such as acronyms.
2) Documentation to Code: The second type of TLR task is Furthermore,
they showed that small modifications of prompts the recovery of trace
links between documentation and code. In can result in differences in
TLR results. their study on recovering trace links between code and
manual In contrast to our approach, neither the work by Ro- pages,
Antoniol et al. \[8\] found that programmers often use driguez et
al. nor other existing approaches explore the ap- meaningful names for
program items. As such, they use a uni- plication of RAG for different
TLR tasks. Since TLR handles gram language model and a Bayesian
classifier and compared large amounts of data, it can be expensive or
even impossible it to a vector space model. Marcus and Maletic \[9\]
apply latent due to size restrictions to process all data naively.
Therefore, semantic indexing, achieving higher precision and recall.
retrieval-augmented generation \[34\] is one possible approach The
approach TransArC by Keim et al. \[15\] uses a to make TLR applicable to
large datasets. component-based architecture model as an intermediate
arti- Moreover, we focus on the application of prompting tech- fact to
recover trace links between architecture documentation niques and
different preprocessing instead of prompt engineer- and code. This
transitive approach yields improved results ing. Finally, we also apply
our approach to different TLR tasks by combining TLR approaches that
need to bridge smaller to evaluate its applicability on various TLR
tasks. semantic gaps. Because architecture models are not always
present, they also provide a baseline for their performance III. T HE L
I SSA A PPROACH without using the intermediate artifact, namely
ArDoCode. In this section, we present the LiSSA approach and discuss 3)
Documentation to Models: The third type of TLR task its different
components. The approach uses multiple steps to is the recovery of trace
links between documentation and recover trace links between different
artifacts. As input, LiSSA architecture models. For this task,
Cleland-Huang et al. \[45\] takes a set of artifacts, e.g.,
requirements, documentation, or propose enhancement strategies to
maximize recall and pre- architecture models. The output of LiSSA is a
set of trace links cision, while maintaining a high recall. To achieve
this, they between the elements within the artifacts or between
artifacts, discover that links that have a medium probability (a.k.a.
low e.g., sentences to source code files or text files to code files.
confidence links) are hard to distinguish between true and false links,
resulting in bad performance. To mitigate this problem, A. Preprocessing
& Embedding they propose the usage of hierarchical information and
logical LiSSA distinguishes artifacts, elements, and knowledge.
groupings of artifacts to enhance precision. Their relationship is shown
in Figure 2. We define artifacts as For tracing documentation to
Business Process Model and the inputs that can be processed by LiSSA.
Artifacts consist Notation (BPMN), Lapena et al. found that both the
linguistic of the original content of files and have a specific artifact
particularities \[46\] of BPMN models and their execution type. Elements
are the traceable units of the artifacts and, traces \[47\] can help
recovering lost links. thus, are mainly the parts that are used to
create the trace Keim et al. \[7\] propose ArDoCo for TLR of
architecture links. Besides their identifier, type, and content, they
also documentation to component-based architecture models. They have a
granularity. This granularity is used to define the use heuristics to
identify word clusters that could define a level of abstraction of the
trace links. Furthermore, elements  Artifacts Preprocessing Type:
uml:Component, Name: FileStorage Source Code Interface Realization:
IFileStorage Code-like Operation: getFiles, Operation: storeFile
Requirements Artifacts Uses: FileSystem

Architecture Embedding NL Artifacts Fig. 4. Example textual
representation of a model element Docs

Architecture Model-like Vector Models Artifacts Store Preprocessors in
Detail: In the following, we present the preprocessors of LiSSA that we
identified as relevant for the Fig. 3. Preprocessing & Embedding of
Artifacts (NL for Natural Language) artifacts of the given TLR tasks.
The decision is informed by the datasets from related work (cf. Section
II). a) None: The first preprocessor does not change the can have a
parent. The child-parent relationship is directly artifact and only
creates the embedding. This means that no reflected by the granularity
of the elements. For example, splitting is done, and the whole artifact
is used as one element. a sentence (child) is part of a text file
(parent). Knowledge One issue in this preprocessing is that artifacts
might be longer defines all data that can be used by LiSSA to create
trace than the maximum input size of the embedding model or the links.
It is defined by an identifier, a type, and its content. LLM. To deal
with this, we cap the artifacts w.r.t. the input In this work, we regard
both the contents of the artifacts and size of the models. In the
future, this issue might dissolve with their elements as knowledge. We
have kept this base class models that support increased maximum input
sizes. knowledge intentionally general because we designed LiSSA b)
Sentence: The second way of preprocessing is tailored as an extensible
framework. Most important, knowledge does to text-based natural language
artifacts. The artifact can be not need to be artifacts or elements.
This makes it possible to split into sentences and each sentence is then
defined as an enrich prompts with information that is not (directly)
part of element. This way, the approach supports fine-grained trace
them. It also enables more sophisticated retrieval techniques links
between sentences and other elements. and ensures the extensibility of
the framework. c) Chunk(N): When preprocessing text-based artifacts
After loading the relevant artifacts, the approach first pre- like
source code, one method to split is chunking. This means processes the
artifacts. As shown in Figure 3, the approach the text is divided into
chunks of a given size N . For source currently distinguishes three
types of artifacts: Natural lan- code, this chunking can also be
tailored to the programming guage artifacts, code artifacts, and model
artifacts. language by splitting the text at language-dependent keywords
Natural language artifacts describe text-based artifacts that to create
chunks of approximately the desired size. In our mainly consist of
written natural language text. Examples evaluation, we also assess the
impact of different chunk sizes. include requirements and documentation.
These artifacts are d) Method: A second way to split source code is to
typically preprocessed by splitting them into lines, sentences, split it
based on method declarations. Methods including their paragraphs, or
arbitrary chunks of text. body, signature, and documentation define a
unit that shall Code artifacts define artifacts that are written in a
program- fulfill a certain task. Consequently, the preprocessor splits
ming language. This could either be source code, test code, the code
before each method definition, including its method or shell scripts.
Code artifacts are preprocessed based on their documentation like
Javadoc. The underlying idea is to treat programming language. For this
paper, we focus on Java code methods as meaningful, atomic units and not
possibly split in since the obtained datasets from related work mostly
contain the middle of a method. The resulting elements could also be
Java code. The approach extracts elements of the code artifacts used to
generate trace links on the method level. by splitting the code based on
methods, classes, or files. e) Models (Feature Extraction): Compared to
the other Model artifacts like architecture models are instances of a
kinds of artifacts, we preprocess models differently. Models certain
metamodel. In our case, we focus on UML component are instances of a
certain metamodel. In our case, we focus diagrams that are used to
describe the architecture of a soft- on UML component models based on
the Eclipse Modeling ware system. We select these models because they
are used by Framework (EMF). The model preprocessor is tailored to this
one of the state-of-the-art approaches, allowing us to compare specific
type of model and extracts features from a given model our approach to
them. Model artifacts are preprocessed by instance. The extractor
identifies components, interfaces, their extracting the elements like
components and interfaces. operations (methods), and their dependencies
(realizations and In general, the approach preprocesses elements from
the usages). These extracted features are used to create a textual
different artifact types by transforming them into a textual rep-
representation of a model element (component or interface) resentation
that can be used for retrieval. As shown in Figure 3, that can be used
for the retrieval process. The creation of after transformation, LiSSA
uses embedding models to create the textual representation is based on
templates that are filled a vector representation of each element. The
embeddings of with the information of extracted features. Figure 4 shows
an elements from artifacts are stored in a vector store. example of the
textual representation of a model element.  Target Preprocessing Target
Vector Store Artifact (Target) Elements (Target Elements) Embedding
Retrieval Source Preprocessing Source Finding similar k Target Element
Artifact (Source) Elements elements Candidates

        Mapping        Prompting                Aggregation                 Trace Links

               Fig. 5. Overview of the Retrieval & Mapping. Data is in orange, prompting is in blue, and other processing is in white.

B. Retrieval Prompt 1: KISS As shown in Figure 5, the next step after
preprocessing the artifacts is the retrieval. The retrieval step is
responsible for Question: Here are two parts of software development
finding the Top-k most similar elements for a given source artifacts.
element in the vector store containing the target elements. For {source
type}: '''{source content}''' the comparison of embeddings, the approach
uses the cosine {target type}: '''{target content}''' similarity of
vectors. These most similar elements are then Are they related? used as
target element candidates. Only these candidates can Answer with 'yes'
or 'no'. be potential targets of a trace link for the given source
element. Because the source elements are used to retrieve the target
Prompt 2: Chain-of-thought elements, the retrieval step defines the
direction of the TLR task. We call A to B TLR (e.g., Requirements to
Code TLR) Below are two artifacts from the same software system. when A
is the source artifact and B is the target artifact. Is there a
traceability link between (1) and (2)? Give In summary, the retrieval
step takes the elements from your reasoning and then answer with 'yes'
or 'no' en- a preprocessed source artifact, creates the embeddings, and
closed in `<trace>`{=html} `</trace>`{=html}. identifies for each source
element the Top-k most similar (1) {source type}: '''{source content}'''
target elements as candidates. The preprocessing steps strongly (2)
{target type}: '''{target content}''' influence the retrieval because
the retrieval defines the possible mappings between elements. For
example, in requirements to code TLR with the sentence preprocessor for
requirements and the method preprocessor for code, the candidate
mappings are and the CoT prompt. The KISS prompt is a simple classifi-
between single sentences and single methods. cation prompt that gives
the LLM the freedom to interpret its task. The CoT prompt is a zero-shot
prompt that is more C. Mapping complex and requires the LLM to reason
about the elements. After the retrieval comes the mapping process. The
mapping We detail these prompts in the following. takes a source element
and its respective target element candi- a) KISS Prompt: The KISS prompt
is a simple zero-shot dates and uses an LLM to classify which of the
target element prompt (see Prompt 1). The prompt first defines the
software candidates belong to the source element. The approach then
development domain. Afterward, the prompt states the types aggregates
the identified mappings to create trace links on the of elements and
their contents. Lastly, the prompt contains a desired level of
abstraction. Consequently, the whole mapping yes-or-no question if the
source element belongs to the target process consists of two steps:
prompting and aggregation. element candidate. In the LLM's response, the
approach looks 1) Prompting: In the prompting step, the source element
for the term yes. If found, the approach traces the source and the
target element candidates are combined to create element to the target
element. prompts for the LLM. The LLM's responses are then used b) CoT:
The second prompt is the CoT prompt (see to decide, for each candidate,
if the source element belongs Prompt 2). This prompt also is a zero-shot
prompt. It starts to the target element, and, therefore, if there should
be a trace with the setting of the context by defining that the LLM gets
link. The approach supports different prompting techniques. two
artifacts from a software system. Afterward, the prompt The prompting
relies on the granularity of the source and contains the same yes-or-no
question as the KISS prompt. target elements. For example, if there is
requirements to code In contrast to the KISS prompt, the prompt asks the
LLM TLR and the approach uses the sentence preprocessor for to provide
reasoning. Lastly, the prompt defines the output requirements and the
method preprocessor for code, then the format and provides the source
and target elements. Again, LLM classifies if a sentence belongs to a
method. the approach looks at the output of the LLM and if the LLM We
base our prompts on the work of Rodriguez et al. \[35\]. approves, the
approach again traces the source element to the Based on their work, we
derive two prompts: the KISS prompt target element. The reasoning itself
is disregarded.  TABLE I TABLE II OVERVIEW OF DATASET FOR R EQUIREMENTS
TO C ODE TLR. IT M ARKS N UMBER OF A RTIFACTS P ER T YPE AND N UMBER OF
T RACE L INKS IN I TALIAN AND EN E NGLISH NATURAL L ANGUAGE D
ESCRIPTIONS , AND THE G OLD S TANDARD F OR E ACH A RCHITECTURE T
RACEABILITY TL S TANDS F OR T RACE L INK P ROJECT. AD STANDS FOR
ARCHITECTURE DOCUMENTATION .

                                    Language        # of Artifacts         Artifact Type                 MS      TS      TM    BBB       JR

Dataset Domain NL Programming Req Code TL AD Sentences 37 43 198 85 13
Architecture Model Elements 23 19 16 24 6 SMOS Education IT Java 67 100
1044 Source Code Files 97 205 832 547 1,979 eTour Tourism EN Java 58 116
308 iTrust Healthcare EN Java 131 226 286 AD to Model Trace Links 29 27
51 52 18 Dronology (RE) Aerospace EN Java, Python 99 423 602 AD to Code
Trace Links 50 707 7,610 1,295 8,240 Dronology (DD) Aerospace EN Java,
Python 211 423 740

                                                                          However, the Dronology dataset contains different types of

2)  Aggregation: The final step of the mapping is the natural language
    artifacts, such as requirements (RE) and de- aggregation. In this
    step, the traced pairs of source and target sign definitions (DD).
    We use their summary and description, elements are combined to trace
    links that match the defined as well as their relationship to tasks
    and code, to derive level of abstraction. The following example
    illustrates this: two ground truths: A mapping from requirements to
    code Based on the configured preprocessors, the prompting step has
    and a mapping from design definition, similar to low-level traced
    sentences of requirements and methods of code classes. requirements,
    to code. The desired granularity for trace links is requirement file
    to 2) Tracing Architecture Documentation to Architecture code file.
    The aggregator creates the trace links if there is at Models: For
    tracing architecture documentation to architecture least one
    correspondence between a sentence of a requirement models, we use
    the ArDoCo dataset \[7\], \[48\]. The dataset file and a method of a
    certain class. By doing so, the aggregator contains component-based
    architecture models, their docu- can output the trace links on the
    desired level of abstraction. mentation, and the gold standard for
    documentation to model IV. E VALUATION trace links for five
    projects. The projects are MediaStore (MS), TeaStore (TS), TEAMMATES
    (TM), BigBlueButton In this section, we present the evaluation of
    our approach. (BBB), and JabRef (JR). Again, the projects cover a
    variety of We evaluate the performance of our approach on the three
    domains (media, micro-services, education, web conferencing,
    different TLR tasks and compare it to state-of-the-art ap- and
    reference management). Table II gives an overview of the proaches.
    Therefore, we discuss the used datasets, metrics, artifacts in the
    dataset. The artifacts of all projects are written used models,
    baselines, and the performance of our RAG- in English. We use these
    projects to evaluate our approach based approach. We also perform
    significance tests to provide against the state-of-the-art. a
    statistical analysis of the results. Finally, we address the
    potential threats to validity. We provide all our results and 3)
    Tracing Documentation to Code: For tracing documen- datasets in our
    replication package \[36\]. tation to code, we use the dataset
    provided in TransArC's repli- cation package \[52\]. The dataset
    expands the ArDoCo dataset A. Datasets by the corresponding code for
    the five projects and a gold To reduce the bias of the creation of a
    new dataset, we use standard for architecture documentation to code
    trace links. existing datasets from the literature. As already
    discussed, this We use the projects BigBlueButton, MediaStore, and
    TeaStore is one factor in our selection of the respective TLR tasks.
    to compare our approach to the state-of-the-art approaches.

3)  Tracing Requirements to Code: For tracing requirements Furthermore,
    we discuss challenges regarding large projects to code, we use a
    dataset from the replication package by like the two remaining
    projects of the dataset, JabRef and Hey \[49\]. We use the projects
    SMOS, eTour, and iTrust as TEAMMATES, separately. These projects are
    characterized these projects are used for the evaluation of the
    state-of-the-art by the fact that they have many architecture
    documentation to approaches FTLR and COMET. These projects were
    gathered code trace links. While the projects BigBlueButton (1295
    trace by the Center of Excellence for Software & Systems Trace-
    links), MediaStore (50 trace links), and TeaStore (707 trace ability
    (CoEST) \[50\] and cover different domains (education, links)
    contain on average up to 16.4 trace links per sentence tourism, and
    healthcare). Additionally, we use the Dronology of documentation,
    TEAMMATES contains 38.4 and JabRef dataset \[51\] (aerospace
    domain), and apply our approach and 633.8 trace links per sentence
    on average. The code artifacts FTLR on it. Table I shows the
    characteristics of these projects, of all projects are also written
    in English, and the gold standard such as the used natural (NL) and
    programming languages, covers only the Java and Shell script parts
    of their code. and the number of requirements, source code files,
    and trace links in the datasets. Note that all projects except for
    SMOS B. Metrics provide natural language descriptions in English.
    The SMOS To evaluate the performance of our approach, we use project
    has requirements and source code identifiers in Italian. commonly
    used metrics for TLR \[21\], \[53\]: precision, recall, For SMOS,
    eTour, and iTrust, we can use the information and Fβ -score. We use
    the F1 -score, as both precision and recall on traceability links
    between requirements and code directly. are essential for fully
    automated TLR. For semi-automatic TLR, where recall is more critical
    to avoid missing links, we best per-project optimized threshold
    configuration (FTLROPT ), also report the F2 -score. By doing so, we
    can compare our illustrating the upper boundary of FTLR's
    performance. This approach's performance to the reported results of
    the state-of- configuration only uses requirements filter based on
    use case the-art approaches. The information also gives us insights
    into templates and functional aspects, and no method comments future
    applications of an RAG-based approach for TLR. or call dependencies.
    For the baseline COMET \[40\], we also provide the results for the
    best per-project optimized C. Significance Tests configuration
    (COMETOPT ). The results for SMOS, eTour, and To provide a
    statistical analysis of the results, we perform iTrust are already
    part of the replication package by Hey \[49\]. significance tests.
    However, we have chosen not to test all Thus, we report these
    results for comparison. Dronology has configurations, for two
    reasons. One, payment for LLM ser- not been evaluated with FTLR so
    far, so we apply FTLR to it. vices is an added and non-negligible
    cost in the experiments. Unfortunately, we could not run and
    evaluate COMET on the And two, with a view to the practical
    application of LiSSA, it Dronology dataset. For the VSM and LSI
    baselines we make makes sense to test only the on-average best
    configuration. In use of the code provided by Gao et al. \[14\] in
    their replication practice, a ready-to-use solution would be
    required. Thus, we package. The code only produces ranked lists of
    target artifacts consider only the configuration that achieved the
    best average per source artifact without a fixed threshold for
    determining F1 -score. We use the two-sided Wilcoxon signed-rank
    test with the final trace links. Therefore, we again calculated the
    per- a significance level of α = 0.05. In order to test the
    significance project optimized F1 -scores (VSMOPT & LSIOPT ) by
    varying of the results, we run the experiment configuration 5
    additional the cutoff threshold between r0, 1s in 0.01 steps. The
    results, times with a different random seed each time. The full
    thus, again show the upper boundary of their performance.
    configuration is documented in the replication package \[36\]. 3)
    Tracing Documentation to Code: For this task, we compare our
    approach with the work of Keim et al. \[15\] D. Models (see also
    Section II-A2). Since we focus on the direct linking For the
    evaluation, we use OpenAI's recent models. We use of documentation
    to code, we do not compare to TransArC. text-embedding-3-large as
    the embedding model. We opted for TransArC uses intermediate
    artifacts and, thus, extra knowl- that model based on the datasets
    we used for the evaluation. edge that is not available for the
    direct linking approach. The datasets do not only contain English
    language artifacts Consequently, we use the best-known approach for
    direct but also artifacts in other languages. Furthermore, the
    vendor linking from Keim et al. --- ArDoCode. ArDoCode is based of
    the embedding model states that this model is their newest on
    heuristics that have been originally optimized for the and
    best-performing embedding model. TLR from documentation to
    architecture models. Nevertheless, For the Large Language Model for
    classification, we use ArDoCode achieved the best results for the
    direct TLR from GPT-4o (gpt-4o-2024-05-13) and GPT-4o mini
    (gpt-4o-mini- documentation to code, i.e., without using
    architecture models. 2024-07-18). OpenAI claims that GPT-4o is their
    most ad- We compare the results of our RAG-based approach directly
    vanced model. GPT-4o mini is OpenAI's most recent model with the
    results reported by Keim et al. at the time of writing that is
    potent, cheap, and fast. 4) Tracing Architecture Documentation to
    Architecture Models: For tracing between architecture documentation
    and E. Baselines architecture models, we compare our approach with
    the state- In order to evaluate the performance of our approach, we
    of-the-art approach ArDoCo \[7\]. ArDoCo is based on heuris- compare
    it to state-of-the-art approaches. tics and tailored to this TLR
    task (cf. Section II-A3). We again

4)  Retrieval-Only: A baseline approach for all our TLR compare our
    results directly with the results reported by the tasks is the
    retrieval-only approach. This approach does not authors of ArDoCo
    without any modifications. use the classifying LLM, but only the
    retrieval step of our approach. We then mock the classifier by
    always stating F. Results that a source element belongs to all found
    target element This section presents and discusses the evaluation.
    Our candidates. By doing so, we maximize the overall recall of
    replication package \[36\] contains all detailed results. the
    approach for a given amount of k target elements that 1) Tracing
    Requirements to Code: Table III shows the should be retrieved. This
    allows the analysis of what effects detailed results using GPT-4o.
    For the TLR from Requirements the classifier step has and whether
    the classifier is beneficial. to Code, we consider eleven different
    configurations. In the

5)  Tracing Requirements to Code: For tracing requirements first group,
    there are three configurations without prepro- to code, we compare
    our approach to the state-of-the-art cessing the artifacts. These
    three configurations compare the approaches FTLR and COMET. Both
    approaches have already effects of the different classifiers
    introduced in Section III-C, been discussed in Section II.
    Additionally, we compare our i.e., using no LLM at all, using Prompt
    1 (KISS prompt), and approach to a VSM and LSI baseline. For FTLR
    \[13\], \[39\], we using Prompt 2 (CoT prompt). provide the results
    of the best configuration with the originally The second group of
    results shows the effects of preprocess- defined thresholds. It uses
    method comments, call dependen- ing the input by reducing the
    requirements to sentences and cies, and filter based on use case
    templates and functional splitting the code into chunks. As chunk
    size, we define a value aspects. Additionally, we take a look at the
    results of the of 200 characters. This value should ensure a
    fine-grained  TABLE III R ESULTS F OR R EQUIREMENT- TO -C ODE TLR W
    ITH GPT-4 O & T OP -20 (P REP. FOR P REPROCESSOR , C LS . FOR C
    LASSIFIER , A RT. FOR A RTIFACTS )

                             SMOS                        eTour                        iTrust                                 Dronology (RE)                             Dronology (DD)

    Approach P R F1 F2 P R F1 F2 P R F1 F2 P R F1 F2 P R F1 F2 VSMOPT
    .430 .414 .422 .417 .557 .427 .483 .448 .208 .227 .217 .223 .844
    .087 .158 .106 .846 .071 .131 .087 LSIOPT .415 .430 .422 .427 .452
    .453 .453 .453 .251 .255 .253 .254 .333 .107 .162 .124 .757 .074
    .135 .090 COMETOPT .195 .572 .291 .413 .410 .468 .437 .455 .361 .231
    .282 .249 --- --- --- --- --- --- --- --- FTLR .444 .331 .380 .349
    .379 .633 .474 .558 .165 .339 .222 .280 .183 .161 .172 .165 .129
    .154 .140 .148 FTLROPT .314 .588 .409 .501 .505 .597 .548 .576 .234
    .241 .238 .240 .184 .170 .177 .173 .140 .147 .144 .146 Prep. Cls. No
    .325 .418 .366 .395 .216 .815 .342 .525 .058 .531 .105 .202 .128
    .420 .196 .288 .085 .482 .144 .249 None / None

            P1      .632   .184   .285   .214   .378   .711   .493   .604   .206   .493          .290     .385        .200        .372        .260     .317     .155        .442    .229         .322
            P2      .590   .195   .294   .226   .409   .734   .526   .633   .199   .451          .276     .360        .226        .344        .273     .311     .177        .380    .241         .309

    Chunk(200)

            No      .247   .546   .340   .439   .091   .815   .164   .315   .066   .563          .119     .225        .150        .331        .206     .266     .119        .424    .186         .281

    Sentence /

            P1      .327   .297   .311   .302   .136   .581   .220   .351   .152   .451          .227     .324        .198        .233        .214     .225     .193        .315    .239         .280
            P2      .344   .289   .314   .299   .140   .617   .228   .366   .143   .465          .219     .321        .216        .194        .205     .198     .217        .281    .245         .265
            +Art.   .333   .336   .335   .336   .138   .662   .229   .377   .153   .517          .236     .350        .225        .281        .250     .267     .199        .351    .254         .305
            No      .327   .541   .408   .479   .073   .597   .130   .245   .063   .598          .114     .221        .132        .282        .180     .230     .101        .369    .159         .241

    Sentence / Method

            P1      .475   .351   .403   .370   .107   .412   .169   .262   .184   .503          .269     .373        .215        .208        .211     .209     .203        .276    .234         .257
            P2      .479   .379   .423   .396   .107   .435   .172   .270   .171   .517          .257     .368        .209        .211        .210     .211     .197        .258    .224         .243
            +Art.   .486   .343   .402   .364   .109   .484   .178   .287   .168   .535          .256     .372        .203        .249        .224     .238     .190        .323    .239         .283

splitting, where also parts of the methods are transformed into TABLE IV
elements. In this setting, we evaluate four classifiers. Again, C
OMPARISON O F T HE AVERAGE A ND W EIGHTED AVERAGE Fβ -S CORES U SING
GPT-4 O A ND GPT-4 O MINI F OR R EQUIREMENT- TO -C ODE TLR we evaluate
the use of no LLM, the KISS prompt, and the CoT U SING T OP -20 R
ETRIEVAL prompt. Additionally, we evaluate how the provided elements
affect the performance of the approach. Therefore, we defined Avg. w.
Avg. a variant where the LLM is provided with the original artifact
Approach GPT-4o GPT-4o mini GPT-4o GPT-4o mini instead of the elements
from the retrieval. This means that we Prep. Cls. F1 F2 F1 F2 F1 F2 F1
F2 use the elements, i.e., parts of artifacts, to retrieve relevant No
.230 .332 .230 .332 .249 .332 .249 .332 None /

artifacts. The LLM then uses the whole artifact to decide. None

                                                                                                     P1           .312        .369       .247          .345      .288        .319    .260        .334

The final group shows the results where the preprocessor P2 .322 .368
.295 .356 .299 .319 .282 .315 for code is replaced with the method
preprocessor tailored to Chunk(200)

                                                                                                     No           .203        .305       .203          .305      .235        .332    .235        .332
                                                                                      Sentence /

Java source code. Similar to the previous group of results, we P1 .242
.296 .210 .309 .256 .288 .241 .331 P2 .242 .290 .236 .317 .257 .279 .261
.325 evaluate four classifiers and their performance. +Art. .261 .327
.243 .318 .277 .320 .263 .314 In the first group, as expected, the
configuration using no No .198 .283 .198 .283 .243 .321 .243 .321
Sentence /

LLM at all achieves the highest recall. This configuration Method

                                                                                                     P1           .257        .294       .211          .292      .285        .299    .256        .325

defines the upper bound for recall of a retrieval-augmented P2 .257 .297
.232 .295 .289 .305 .268 .307 TLR approach for a defined preprocessing.
The next two rows +Art. .260 .309 .238 .296 .288 .312 .267 .298 in the
table show the results for the two prompt types. Except Baselines F1 F2
F1 F2 for SMOS, the configurations using the two prompt types VSMOPT
.282 .256 .283 .257 outperform the no LLM configuration, both in F1
-score and F2 - LSIOPT .285 .270 .285 .268 FTLR .278 .300 .273 .277
score. In many cases, for GPT-4o, Prompt 2, the CoT prompt, FTLROPT .303
.327 .294 .329 outperforms the KISS prompt regarding F1 -score. On
average, this is our overall best configuration w.r.t. F1 -score. In the
second group with chunks consisting of 200 charac- ters, CoT prompts
outperform the KISS prompts. Furthermore, in the previous groups. This
indicates that there might be the table shows that the use of target
artifacts instead of target some characteristics in the projects that
affect the performance elements increases the performance of the
approach in F1 - of the approach. SMOS is the only project written in
Italian score and F2 -score. Nevertheless, this preprocessing performs
and, therefore, another configuration might be more suitable slightly
worse compared to the variant without preprocessing. for projects in
English. eTour's method comments are often In the third group with
method-chunking, the performance inconsistent with the code they
describe \[54\]. This may of the prompts varies between the projects.
Our overall best negatively impact the performance of the embedding, and
results in F1 -score and F2 -score for SMOS are achieved using
therefore, the retrieval. On eTour, we observe a decrease in this
preprocessing. For eTour, this preprocessing achieved the recall from
0.815 to 0.597 in the retrieval-only configurations, worst results. The
other projects are comparable to the results if considering methods as
elements to embed.  TABLE V TABLE VI P-VALUES OF THE W ILCOXON S IGNED
-R ANK T EST (T WO -S IDED ) FOR C OMPARISON O F T HE AVERAGE A ND W
EIGHTED AVERAGE Fβ -S CORES F 1{F 2 - SCORES OF R EQUIREMENT- TO -C ODE
TLR W ITH GPT-4 O , FOR S OFTWARE A RCHITECTURE D OCUMENTATION TO C ODE
TLR O N N ONE /N ONE /P2, A ND T OP -20. B OLD MARKS A SIGNIFICANT
DIFFERENCE T HE S MALLER P ROJECTS B IG B LUE B UTTON , T EA S TORE , M
EDIA S TORE (Ò OURS BETTER , Ó BASELINE BETTER ). DR STANDS FOR D
RONOLOGY. U SING GPT-4 O MINI A ND T OP -20 R ETRIEVAL

Approach SMOS eTour iTrust DR DR Avg. w. Avg. Approach Avg. w. Avg. RE
DD Preprocessor Classifier F1 F2 F1 F2 VSMOPT .03Ó .03Ò .03Ò .03Ò .03Ò
.03Ò .03Ò No LLM .209 .257 .240 .260 LSIOPT .03Ó .03Ò .03Ò .03Ò .03Ò
.03Ò .03Ò Sentence / Prompt 1 .212 .259 .243 .262 COMETOPT .09{.03Ó .03Ò
.84{.03Ò --- --- --- --- None Prompt 2 .217 .255 .249 .253 FTLR .03Ó
.03Ò .03Ò .03Ò .03Ò .03Ò .03Ò FTLROPT .03Ó .03Ó{.03Ò .03Ò .03Ò .03Ò .03Ò
.44{.03Ó No LLM .206 .238 .214 .204 Sentence / Prompt 1 .206 .238 .214
.204 Chunk(200) Prompt 2 .213 .241 .221 .203 No LLM .196 .230 .213 .206
Table IV provides an overview of the results for the two Sentence /
Prompt 1 .196 .228 .213 .205 models, GPT-4o and GPT-4o mini, in
comparison to FTLR, Chunk(1000) Prompt 2 .205 .237 .217 .203 VSM, and
LSI. We report the average and weighted average Baselines F1 F2 F1 F2
for the F1 -score and F2 -score. The overall best results regard-
ArDoCode .178 .302 .189 .318 ing both scores are achieved by our
approach without splitting the artifacts. The larger model outperforms
both the smaller model and the state-of-the-art approach on average and
on weighted average F1 -scores. Regarding, F2 -scores, the results mini,
the approach performs similarly to FTLR and performs show that, on
average, the best configuration is achieved by the comparable to GPT-4o.
In the end, we've spent approx. \$850 GPT-4o model using Prompt 1
without preprocessing. Except for the evaluation of this task with
GPT-4o (excluding the for the weighted average F2 -score using GPT-4o,
applying repetitions for the significance tests). GPT-4o mini only cost
classifiers improve our performance in both scores. There, the us
approx. \$30 for worse, but comparable results. best performance is
achieved by using no LLM. However, this 2) Tracing Documentation to
Code: In the second task, result is mainly influenced by the SMOS
project. we evaluate TLR from documentation to code. As discussed
Interestingly, for SMOS GPT-4o mini achieves an F1 - in Section IV-A3,
we use the TransArC dataset for this score of 0.425 using the KISS
prompt for Sentence-Method- evaluation. Since this task is defined as
tracing single sentences Preprocessing. Thereby, GPT-4o mini outperforms
GPT-4o for to code files, we always use the sentence preprocessor for
the this project. This means that for some projects, GPT-4o mini
documentation. Regarding code, we evaluate the configura- can outperform
the state-of-the-art and the larger GPT-4o. tions for no preprocessing,
small chunks with 200 characters, Overall, GPT-4o mini is comparable to
the state-of-the-art. and larger chunks with 1000 characters. We perform
significance tests for the best configuration of We first evaluate the
performance of the smaller projects the GPT-4o model (No preprocessing
and Prompt 2). The (BigBlueButton, MediaStore, and TeaStore). The
results for p-values of the significance test are shown in Table V. The
those using Top-20 retrieval are shown in Table VI. Similar results with
a significant difference between our results and to the evaluation of
requirements to code TLR, we report the baseline are marked in bold
font. If our result is better the results for the two different prompt
techniques and the than a baseline, we mark it with Ò. If a result is
worse, retrieval-only (No LLM) for each preprocessing configuration. we
mark it with Ó. On average, our approach is significantly On average, we
can see again that the combination of CoT and better than all
state-of-the-art approaches. However, the results no further
preprocessing achieves the best results regarding F1 . also show that
our on-average best prompt is not significantly For this configuration,
the Wilcoxon signed-rank test shows better for the SMOS dataset. Here,
we emphasize that this is that the F1 -scores of the averages are
significantly better than the only project of the dataset that contains
Italian language the baseline ArDoCode and the No LLM configuration
(both artifacts. The only non-significant differences occur for per- p "
0.031). The baseline ArDoCode is better in F2 -score due project
optimized baseline configurations. It may be expected to high recall.
However, the average precision is only 0.107. that the actual
performance of these approaches in practice For the smaller projects,
the approach already achieves similar is lower, exemplified by FTLR
vs. FTLROPT . The results for or even better results than the baseline.
F1 -score and F2 -score are similar. The only differences are
Nevertheless, we also uncover challenges for larger projects. for
COMETOPT on SMOS and iTrust as well as FTLROPT With large projects, the
retrieval is problematic: On the two on eTour and in weighted average.
In F2 -score LiSSA is largest projects JabRef and TEAMMATES, the best
retrieval- significantly better than the baselines on eTour and iTrust.
only configuration for Top-40 elements achieves a recall of In summary,
the approach LiSSA outperforms the state- 0.027 for JabRef and 0.061 for
TEAMMATES. Additionally, of-the-art approaches FTLR and COMET using
GPT-4o. In the bad retrieval for the large projects affects the weighted
contrast to the GPT-4o mini model, this comes with the average heavily:
the weighted average F1 -score of the best disadvantage of high costs.
Considering the results for GPT-4o configuration including the large
projects is 0.081 (without:  TABLE VII Considering the different
features, on average, the ap- C OMPARISON O F T HE AVERAGE A ND W
EIGHTED AVERAGE Fβ - SCORES proach's performance worsens with the number
of used fea- FOR A RCHITECTURE M ODEL TO A RCHITECTURE D OCUMENTATION
(M2D) AND A RCHITECTURE D OCUMENTATION TO A RCHITECTURE tures. We assume
that this is due to the kind of trace links. The M ODEL (D2M) TLR U SING
T OP -10 R ETRIEVAL A ND GPT-4 O MINI LLM has to decide if a component
belongs to a sentence. Too much information that might not be directly
related or that is Avg. w. Avg. unique to the component can negatively
influence ("distract") Approach D2M M2D D2M M2D the LLM. This then leads
to decreased precision. Features Cls. F1 F2 F1 F2 F1 F2 F1 F2 Overall,
our approach does not outperform the state-of-the- Name No .162 .305
.350 .505 .131 .259 .334 .466 art approach ArDoCo. P1 .173 .323 .357
.512 .140 .275 .340 .472 P2 .286 .467 .458 .589 .234 .404 .424 .534 G.
Threats to Validity Name, No .162 .305 .349 .504 .131 .259 .334 .466 In
this part, we discuss threats to validity and base this Interfaces P1
.169 .317 .355 .509 .138 .271 .339 .471 discussion on the guidelines by
Runeson et al. \[55\]. We also P2 .274 .447 .450 .586 .223 .383 .419
.534 consider the work by Sallou et al. \[56\] that focuses on threats
Name, No .161 .303 .341 .494 .130 .257 .322 .452 for experiments with
LLMs in software engineering. Interfaces, P1 .169 .315 .348 .501 .137
.269 .329 .458 Usages P2 .265 .435 .417 .554 .215 .373 .384 .499
Regarding construct validity, there is the threat that the datasets are
biased. To mitigate this threat, we use the same Baselines F1 F2 F1 F2
datasets as the state-of-the-art approaches. The datasets cover ArDoCo
.822 .814 .802 .806 different domains and project sizes. Nevertheless,
the datasets mostly contain open-source projects that may have other
characteristics compared to closed-source projects. In this 0.249).
Again, the best configuration in this case is the same work, we do not
focus on prompt engineering, i.e., we do not as for the smaller
projects: CoT prompt without preprocessing. extensively modify prompts
and compare their performance. In summary, our approach LiSSA achieves
significantly Consequently, a potential threat to the validity of our
results better results in F1 -score than state-of-the-art approaches on
regarding RQ1-4 is the selection of the prompts. However, smaller
projects. For larger projects, the performance of the we closely follow
the suggestions of Rodriguez et al. \[35\]. retrieval needs to improve.
Another threat is a biased selection of metrics. To diminish 3) Tracing
Architecture Documentation to Architecture this risk, we use commonly
used metrics in TLR research. Models: The final TLR task is recovering
trace links between Overall, we try to reduce potential confounding
factors that architecture documentation and architecture models. Because
could prevent us from effectively addressing our RQs. there are
comparably few model elements and few sentences, Considering internal
validity, there is the threat that other we additionally analyzed the
effect of the direction for TLR. factors might influence our
experiments. These could influence This means, we evaluate both, TLR for
Documentation to our interpretations and lead to wrong conclusions. To
mitigate Model (D2M) and TLR for Model to Documentation (M2D). this
threat, we follow established practices. We ensure that For both cases,
we use a retriever that retrieves the 10 most we use datasets and
projects from state-of-the-art approaches. similar target elements for
each source element. Since the TLR Furthermore, we clearly state the
origins of the projects and task requires a trace link between a
sentence and a model ground truths. This also reduces the risk of
selection bias. element (i.e., for this TLR task, a component), we used
the Since the datasets mostly consist of open-source projects, they
sentence preprocessor to split the documentation. still might vary in
quality. The quality and consistency within We evaluate the effect of
the prompt type and the effect of one project can affect the performance
of the approach. the features that are extracted from the model
preprocessor. Regarding external validity, there are various threats.
First, The results of the evaluation are shown in Table VII. On we only
evaluate the approach on a limited number of projects average, the CoT
prompt outperforms the KISS prompt and and a limited number of TLR
tasks. The results can vary for using retrieval-only in both scores.
other projects and other TLR tasks. To reduce this threat, we For the
D2M TLR task, the displayed F1 -score comes from use established
datasets and projects from different domains a very high recall of
almost 1.0 but a very low precision. and sizes. Second, we evaluate the
approach with only one When examining the flipped task, the recall
decreases, while embedding model and two LLMs. To mitigate this threat,
the precision increases substantially. Nevertheless, the results we use
state-of-the-art models. The third threat is the use of vary on the
projects. We assume that this is mainly caused Closed Source Models for
evaluation. Since we do not know by the retrieval. The retrieval always
tries to select the Top- the training data of the models, we cannot
ensure that there is k most similar target elements. Considering M2D
TLR, this no data leakage. In order to mitigate this threat, we provide
means that for each component in the model, the approach our code, the
prompts, embeddings, and the responses of the retrieves the Top-k most
similar sentences. Nevertheless, the LLMs in our replication package
\[36\] to ensure transparency. value k might depend on the project and
also the direction of The fourth threat is the non-determinism of the
LLMs. To the TLR task. Depending on the project, the assumption that a
mitigate this threat, we set the temperature of the LLMs to 0 component
is described in at most k sentences can be fulfilled. to reduce the
randomness of LLMs.  With the aforementioned evaluation on established
datasets VI. C ONCLUSION using established metrics, we address the
reliability of our This paper presents a novel approach for Traceability
research. Therefore, we do not introduce a threat regarding Link
Recovery (TLR) using Large Language Models (LLMs) the manual creation of
the datasets. Nevertheless, the gold with Retrieval-Augmented Generation
(RAG). The benefit of standard might be imperfect, as they are manually
created. To our RAG-based approach Linking Software System Artifacts
improve reliability, we also base our prompts on the literature. (LiSSA)
is its applicability to various TLR tasks. LiSSA uses V. D ISCUSSION & F
UTURE W ORK preprocessors to prepare artifacts according to their type
to create traceable elements of the source and target artifacts. In this
section, we analyze our results on RAG-based TLR The approach then uses
the embeddings of these elements to concerning challenges, impediments,
and implications in both retrieve similar target elements for each
source element. LiSSA research and practice. We also provide a brief
overview of then generates prompts for the LLM to classify if source and
planned future improvements. target elements are related. If classified
as related, the approach One challenge is defining trace links so that
LLMs can aggregates the elements to finally create the trace links.
effectively interpret them. Terms such as "related" or "trace- To answer
our research questions, we evaluate LiSSA on es- ability link" can be
too ambiguous for LLMs and might need tablished datasets and compare it
to state-of-the-art approaches further refinement. Another challenge
involves optimizing for three different TLR tasks. the retrieval
process, which sets the upper limit for recall. Regarding RQ1, which
examines the performance of RAG- A significant issue arises when a
single sentence maps to based TLR compared to state-of-the-art, our
evaluation shows hundreds of code files, as observed in larger projects
like that our RAG-based approach significantly outperforms state-
JabRef. In such cases, a high number of elements must be of-the-art
approaches for requirements to code TLR. For retrieved to ensure all
relevant code files are included, pushing smaller projects, the RAG
approach achieves significantly bet- the retrieval process to its
limits. To address this, we suggest ter F1 -scores than the
state-of-the-art approach for documen- focusing on improved retrieval
techniques. Possible solutions tation to code TLR. However, the approach
underperforms for to enhance the process include dynamic thresholds,
alternative larger projects. For TLR from documentation to architecture
data structures for retrieval, or artifact summarization. models, LiSSA
does not outperform the state-of-the-art. Our results show that the
performance in F1 -score and F2 -score of the proposed RAG-based TLR
does not yet en- For RQ2 about the effectiveness of CoT prompting, we
able fully automated TLR in practical applications; even for find that
CoT prompting outperforms simple classification semi-automated settings
(F2 -score), the performance remains prompts in F1 -score. This is
consistent with the findings by insufficient for practice \[21\].
Nevertheless, state-of-the-art Rodriguez et al. \[35\]. approaches
perform worse on code-related TLR tasks. Looking at the different
preprocessing techniques and the RAG presents several opportunities to
improve perfor- impact of fine-grained mappings (RQ3), we show that the
mance: Future research could focus on prompt engineering, preprocessing
of artifacts is, on average, not beneficial. In on incorporating more
context, and on exploring advanced particular, the preprocessing does
not improve the performance RAG techniques. Our framework, LiSSA, serves
as a foun- of the TLR from requirements to code. However, the best-
dation here. LiSSA already outperforms code-related TLR ap- performing
approach is project-dependent. proaches, though it does not yet address
these future directions. Regarding RQ4 that investigates the effects of
the clas- Therefore, we see significant potential for RAG in these
tasks. sification step, we showed that, on average, a LLM-based In the
future, we aim to expand our LiSSA approach in classification improves
the performance over retrieval-only in several ways. Our findings show
that our current fine-grained all considered TLR tasks for both scores.
mappings do not enhance performance, motivating us to ex- In summary,
this research contributes to the field of trace- plore more advanced
aggregation techniques. For example, we ability by providing a novel
RAG-based approach for TLR plan to adapt methods like majority voting
from FTLR \[13\] tasks. We provide insights into how different prompt
types to improve the aggregation step. Moreover, there is a clear and
preprocessing techniques influence the performance. Our need for more
sophisticated preprocessing methods for code. findings open up new
research directions for the application of Sentences in architecture
documentation can map to hundreds LLMs to TLR tasks. To ensure
replicability, transparency, and of code files, because they refer to
higher-level structures extensibility, we provide the source code of
LiSSA, the used such as packages. To address this, we intend to
investigate datasets, and our results as part of our replication package
\[36\]. summarization techniques and clustering methods for code We aim
to facilitate further research in this field and want to preprocessing.
Lastly, we aim to improve the classification enable other researchers to
build upon our work. process during the prompting step. Currently, the
decision to ACKNOWLEDGEMENTS create a trace link is based solely on the
LLM's classification. In the future, we will explore incorporating the
LLM's reason- This work was funded by Core Informatics at KIT (KiKIT)
ing into this decision-making process. We also plan to enhance of the
Helmholtz Assoc. (HGF) and the German Research prompts by integrating
additional contextual information, such Foundation (DFG) - SFB 1608 -
501798263 and supported by as project-specific or domain-specific
knowledge. KASTEL Security Research Labs. Thanks to our textician.  R
EFERENCES Engineering, ser. ICSE '18. New York, NY, USA: Association for
Computing Machinery, May 2018, pp. 834--845. \[Online\]. Available:
\[1\] D. Falessi, J. Roll, J. L. Guo, and J. Cleland-Huang, "Leveraging
https://doi.org/10.1145/3180155.3180207 historical associations between
requirements and source code to identify \[18\] L. Dong, H. Zhang, W.
Liu, Z. Weng, and H. Kuang, "Semi-supervised impacted classes," IEEE
Transactions on Software Engineering, vol. 46, pre-processing for
learning-based traceability framework on real-world no. 4, pp. 420--441,
2020. software projects," in Proceedings of the 30th ACM Joint European
\[2\] J. L. C. Guo, J.-P. Steghöfer, A. Vogelsang, and J. Cleland-Huang,
Software Engineering Conference and Symposium on the Foundations
"Natural Language Processing for Requirements Traceability," May of
Software Engineering, ser. ESEC/FSE 2022. New York, NY, 2024,
arXiv:2405.10845 \[cs\]. \[Online\]. Available: http://arxiv.org/abs/
USA: Association for Computing Machinery, Nov. 2022, pp. 570--582.
2405.10845 \[Online\]. Available:
https://doi.org/10.1145/3540250.3549151 \[3\] M. Rath, D. Lo, and P.
Mäder, "Analyzing requirements and traceability \[19\] M. Izadi, P. R.
Mazrae, T. Mens, and A. van Deursen, "An information to improve bug
localization," in Proceedings of the 15th empirical study on data
leakage and generalizability of link International Conference on Mining
Software Repositories, ser. MSR prediction models for issues and
commits," 2023. \[Online\]. Available: '18. New York, NY, USA:
Association for Computing Machinery, https://arxiv.org/abs/2211.00381
2018, p. 442--453. \[Online\]. Available:
https://doi.org/10.1145/3196398. \[20\] P. R. Mazrae, M. Izadi, and A.
Heydarnoori, "Automated recovery of 3196415 issue-commit links
leveraging both textual and non-textual data," in 2021 \[4\] P. Mäder
and A. Egyed, "Assessing the effect of requirements trace- IEEE
International Conference on Software Maintenance and Evolution ability
for software maintenance," in 2012 28th IEEE International (ICSME),
2021, pp. 263--273. Conference on Software Maintenance, 2012. \[21\] J.
H. Hayes, A. Dekhtyar, and S. K. Sundaram, "Advancing Candidate \[5\]
------, "Do developers benefit from requirements traceability when Link
Generation for Requirements Tracing: The Study of Methods," evolving and
maintaining a software system?" Empirical Software IEEE Trans. Softw.
Eng., vol. 32, no. 1, pp. 4--19, Jan. 2006. Engineering, vol. 20,
pp. 413--441, 2015. \[22\] J. Guo, J. Cheng, and J. Cleland-Huang,
"Semantically Enhanced \[6\] J. Grundy, J. Hosking, and W. Mugridge,
"Inconsistency management for Software Traceability Using Deep Learning
Techniques," in 2017 multiple-view software development environments,"
IEEE Transactions IEEE/ACM 39th International Conference on Software
Engineering on Software Engineering, vol. 24, no. 11, pp. 960--981,
Nov. (ICSE), May 2017, pp. 3--14, iSSN: 1558-1225. \[Online\].
Available: 1998, conference Name: IEEE Transactions on Software
Engineering. https://ieeexplore.ieee.org/abstract/document/7985645
\[Online\]. Available: https://ieeexplore.ieee.org/document/730545
\[23\] A. Schlutter and A. Vogelsang, "Improving Trace Link Recovery
Using \[7\] J. Keim, S. Corallo, D. Fuchß, and A. Koziolek, "Detecting
inconsis- Semantic Relation Graphs and Spreading Activation," in
Requirements tencies in software architecture documentation using
traceability link Engineering: Foundation for Software Quality, F.
Dalpiaz and P. Spole- recovery," in 2023 IEEE 20th International
Conference on Software tini, Eds. Cham: Springer International
Publishing, 2021, pp. 37--53. Architecture (ICSA), Mar. 2023,
pp. 141--152. \[24\] Y. Shin, J. H. Hayes, and J. Cleland-Huang,
"Guidelines for Benchmark- \[8\] G. Antoniol, G. Canfora, G. Casazza, A.
De Lucia, and E. Merlo, ing Automated Software Traceability Techniques,"
in 2015 IEEE/ACM "Recovering traceability links between code and
documentation," IEEE 8th International Symposium on Software and Systems
Traceability, May Transactions on Software Engineering, vol. 28, no. 10,
pp. 970--983, Oct. 2015, pp. 61--67. 2002. \[Online\]. Available:
http://ieeexplore.ieee.org/document/1041053/ \[25\] G. Antoniol, J.
Cleland-Huang, J. H. Hayes, and M. Vierhauser, "Grand \[9\] A. Marcus
and J. Maletic, "Recovering documentation-to-source- Challenges of
Traceability: The Next Ten Years," arXiv:1710.03129 code traceability
links using latent semantic indexing," in 25th \[cs\], Oct. 2017.
\[Online\]. Available: http://arxiv.org/abs/1710.03129 International
Conference on Software Engineering, 2003. Proceedings., \[26\] X. Du, M.
Liu, K. Wang, H. Wang, J. Liu, Y. Chen, J. Feng, C. Sha, May 2003,
pp. 125--135, iSSN: 0270-5257. \[Online\]. Available: X. Peng, and Y.
Lou, "Evaluating large language models in class-level
https://ieeexplore.ieee.org/document/1201194 code generation," in
Proceedings of the IEEE/ACM 46th International \[10\] H. U. Asuncion, A.
U. Asuncion, and R. N. Taylor, "Software trace- Conference on Software
Engineering, ser. ICSE '24. New York, NY, ability with topic modeling,"
in 2010 ACM/IEEE 32nd International USA: Association for Computing
Machinery, 2024. \[Online\]. Available: Conference on Software
Engineering, vol. 1, May 2010, pp. 95--104.
https://doi.org/10.1145/3597503.3639219 \[11\] M. Gethers, R. Oliveto,
D. Poshyvanyk, and A. D. Lucia, "On inte- \[27\] S. Gao, X.-C. Wen, C.
Gao, W. Wang, H. Zhang, and M. R. Lyu, "What grating orthogonal
information retrieval methods to improve traceability makes good
in-context demonstrations for code intelligence tasks with recovery," in
2011 27th IEEE International Conference on Software llms?" in 2023 38th
IEEE/ACM International Conference on Automated Maintenance (ICSM),
Sep. 2011, pp. 133--142. Software Engineering (ASE), 2023, pp. 761--773.
\[12\] A. Mahmoud and N. Niu, "On the role of semantics in automated
\[28\] F. Mu, L. Shi, S. Wang, Z. Yu, B. Zhang, C. Wang, S. Liu, and Q.
Wang, requirements tracing," Requirements Eng, vol. 20, no. 3,
pp. 281--300, "Clarifygpt: A framework for enhancing llm-based code
generation via Sep. 2015. requirements clarification," Proc. ACM Softw.
Eng., vol. 1, no. FSE, jul \[13\] T. Hey, F. Chen, S. Weigelt, and W. F.
Tichy, "Improving Traceability 2024. \[Online\]. Available:
https://doi.org/10.1145/3660810 Link Recovery Using Fine-grained
Requirements-to-Code Relations," \[29\] A. Singha, B. Chopra, A. Khatry,
S. Gulwani, A. Z. Henley, V. Le, in 2021 IEEE International Conference
on Software Maintenance and C. Parnin, M. Singh, and G. Verbruggen,
"Semantically aligned Evolution (ICSME), 2021, pp. 12--22. question and
code generation for automated insight generation," 2024. \[14\] H. Gao,
H. Kuang, K. Sun, X. Ma, A. Egyed, P. Mäder, G. Rong, \[Online\].
Available: https://arxiv.org/abs/2405.01556 D. Shao, and H. Zhang,
"Using Consensual Biterms from Text Structures \[30\] D. Nam, A.
Macvean, V. Hellendoorn, B. Vasilescu, and B. Myers, of Requirements and
Code to Improve IR-Based Traceability Recovery," "Using an llm to help
with code understanding," in Proceedings of the in Proceedings of the
37th IEEE/ACM International Conference on IEEE/ACM 46th International
Conference on Software Engineering, ser. Automated Software Engineering,
Oct. 2022, pp. 1--1. ICSE '24. New York, NY, USA: Association for
Computing Machinery, \[15\] J. Keim, S. Corallo, D. Fuchß, T. Hey, T.
Telge, and A. Koziolek, 2024. \[Online\]. Available:
https://doi.org/10.1145/3597503.3639187 "Recovering Trace Links Between
Software Documentation And \[31\] T. Ahmed, K. S. Pai, P. Devanbu, and
E. Barr, "Automatic semantic Code," in Proceedings of the IEEE/ACM 46th
International Conference augmentation of language model prompts (for
code summarization)," on Software Engineering, ser. ICSE '24. New York,
NY, USA: in Proceedings of the IEEE/ACM 46th International Conference
Association for Computing Machinery, 2024. \[Online\]. Available: on
Software Engineering, ser. ICSE '24. New York, NY, USA:
https://doi.org/10.1145/3597503.3639130 Association for Computing
Machinery, 2024. \[Online\]. Available: \[16\] J. Lin, Y. Liu, Q. Zeng,
M. Jiang, and J. Cleland-Huang, https://doi.org/10.1145/3597503.3639183
"Traceability Transformed: Generating more Accurate Links with \[32\] M.
Geng, S. Wang, D. Dong, H. Wang, G. Li, Z. Jin, X. Mao, and Pre-Trained
BERT Models," in Proceedings of the 43rd International X. Liao, "Large
language models are few-shot summarizers: Multi-intent Conference on
Software Engineering, ser. ICSE '21. Madrid, comment generation via
in-context learning," in Proceedings of the Spain: IEEE Press,
Nov. 2021, pp. 324--335. \[Online\]. Available: IEEE/ACM 46th
International Conference on Software Engineering, ser.
https://doi.org/10.1109/ICSE43902.2021.00040 ICSE '24. New York, NY,
USA: Association for Computing Machinery, \[17\] M. Rath, J. Rendall, J.
L. C. Guo, J. Cleland-Huang, and P. Mäder, 2024. \[Online\]. Available:
https://doi.org/10.1145/3597503.3608134 "Traceability in the wild:
automatically augmenting incomplete trace \[33\] Q. Huang, Z. Wan, Z.
Xing, C. Wang, J. Chen, X. Xu, and Q. Lu, links," in Proceedings of the
40th International Conference on Software "Let's chat to find the apis:
Connecting human, llm and knowledge graph  through ai chain," in 2023
38th IEEE/ACM International Conference on A. Egyed, "Can method data
dependencies support the assessment Automated Software Engineering
(ASE), 2023, pp. 471--483. of traceability between requirements and
source code?" Journal of \[34\] P. Lewis, E. Perez, A. Piktus, F.
Petroni, V. Karpukhin, N. Goyal, Software: Evolution and Process,
vol. 27, no. 11, pp. 838--866, H. Küttler, M. Lewis, W.-t. Yih, T.
Rocktäschel, S. Riedel, 2015, eprint:
https://onlinelibrary.wiley.com/doi/pdf/10.1002/smr.1736. and D. Kiela,
"Retrieval-augmented generation for knowledge- \[Online\]. Available:
https://onlinelibrary.wiley.com/doi/abs/10.1002/smr. intensive nlp
tasks," in Advances in Neural Information Processing 1736 Systems, H.
Larochelle, M. Ranzato, R. Hadsell, M. Balcan, and \[45\] J.
Cleland-Huang, R. Settimi, C. Duan, and X. Zou, "Utilizing H. Lin, Eds.,
vol. 33. Curran Associates, Inc., 2020, pp. 9459-- supporting evidence
to improve dynamic requirements traceability," 9474. \[Online\].
Available: https://proceedings.neurips.cc/paper files/ in 13th IEEE
International Conference on Requirements Engineering
paper/2020/file/6b493230205f780e1bc26945df7481e5-Paper.pdf (RE'05),
Aug. 2005, pp. 135--144, iSSN: 2332-6441. \[Online\]. \[35\] A. D.
Rodriguez, K. R. Dearstyne, and J. Cleland-Huang, "Prompts Available:
https://ieeexplore.ieee.org/document/1531035 matter: Insights and
strategies for prompt engineering in automated \[46\] R. Lapena, F.
Perez, C. Cetina, and O. Pastor, "Leveraging software traceability," in
2023 IEEE 31st International Requirements BPMN particularities to
improve traceability links recovery among Engineering Conference
Workshops (REW), 2023, pp. 455--464. requirements and BPMN models,"
Requirements Engineering, vol. 27, \[36\] D. Fuchß, T. Hey, J. Keim, H.
Liu, N. Ewald, T. Thirolf, no. 1, pp. 135--160, Mar. 2022. \[Online\].
Available: https://doi.org/10. and A. Koziolek, "Replication Package:
LiSSA: Toward Generic 1007/s00766-021-00365-1 Traceability Link Recovery
through Retrieval-Augmented Generation," \[47\] R. Lapena, F. Perez, O.
Pastor, and C. Cetina, "Leveraging execution Jan. 2025. \[Online\].
Available: https://doi.org/10.5281/zenodo.14714706 traces to enhance
traceability links recovery in BPMN models," \[37\] T. Dasgupta, M.
Grechanik, E. Moritz, B. Dit, and D. Poshyvanyk, Information and
Software Technology, vol. 146, p. 106873, Jun. 2022. "Enhancing Software
Traceability by Automatically Expanding Corpora \[Online\]. Available:
https://www.sciencedirect.com/science/article/pii/ with Relevant
Documentation," in 2013 IEEE International Conference S0950584922000398
on Software Maintenance, Sep. 2013, pp. 320--329, iSSN: 1063-6773.
\[48\] D. Fuchß, S. Corallo, J. Keim, J. Speit, and A. Koziolek,
"Establishing \[Online\]. Available:
https://ieeexplore.ieee.org/document/6676903 a benchmark dataset for
traceability link recovery between software \[38\] H. Gao, H. Kuang, W.
K. G. Assunção, C. Mayr-Dorn, G. Rong, architecture documentation and
models," in Software Architecture. ECSA H. Zhang, X. Ma, and A. Egyed,
"Triad: Automated traceability 2022 Tracks and Workshops, T. Batista, T.
Bureš, C. Raibulet, and recovery based on biterm-enhanced deduction of
transitive links H. Muccini, Eds. Cham: Springer International
Publishing, 2023, pp. among artifacts," in Proceedings of the IEEE/ACM
46th International 455--464. Conference on Software Engineering, ser.
ICSE '24. New York, NY, \[49\] T. Hey, "Fine-grained Traceability Link
Recovery (FTLR)," Sep. 2023. USA: Association for Computing Machinery,
2024. \[Online\]. Available: \[Online\]. Available:
https://doi.org/10.5281/zenodo.8367392
https://doi.org/10.1145/3597503.3639164 \[50\] Center of Excellence for
Software & Systems Traceability (CoEST) \[39\] T. Hey, J. Keim, and S.
Corallo, "Requirements Classification for Trace- Datasets. \[Online\].
Available: http://sarec.nd.edu/coest/datasets.html ability Link
Recovery," in 2024 IEEE 32nd International Requirements \[51\] J.
Cleland-Huang, M. Vierhauser, and S. Bayley, "Dronology: an Engineering
Conference (RE), Jun. 2024, pp. 155--167. incubator for cyber-physical
systems research," in Proceedings of the \[40\] K. Moran, D. N. Palacio,
C. Bernal-Cárdenas, D. McCrystal, 40th International Conference on
Software Engineering: New Ideas D. Poshyvanyk, C. Shenefiel, and J.
Johnson, "Improving the and Emerging Results, ser. ICSE-NIER '18. New
York, NY, USA: effectiveness of traceability link recovery using
hierarchical bayesian Association for Computing Machinery, 2018,
pp. 109--112. \[Online\]. networks," in Proceedings of the ACM/IEEE 42nd
International Available: https://doi.org/10.1145/3183399.3183408
Conference on Software Engineering, ser. ICSE '20. New York, NY, \[52\]
J. Keim, S. Corallo, D. Fuchß, T. Hey, T. Telge, and A. Koziolek, USA:
Association for Computing Machinery, Jun. 2020, pp. 873--885.
"Replication Package for ICSE24 paper"Recovering Trace Links \[Online\].
Available: https://doi.org/10.1145/3377811.3380418 Between Software
Documentation And Code"," Jan. 2024. \[Online\]. \[41\] K. Nishikawa, H.
Washizaki, Y. Fukazawa, K. Oshima, and R. Mibe, Available:
https://doi.org/10.5281/zenodo.10598371 "Recovering transitive
traceability links among software artifacts," in \[53\] J.
Cleland-Huang, O. Gotel, A. Zisman et al., Software and systems 2015
IEEE International Conference on Software Maintenance and traceability.
Springer, 2012, vol. 2, no. 3. Evolution (ICSME), Sep. 2015,
pp. 576--580. \[Online\]. Available: \[54\] T. Hey, "Automatische
Wiederherstellung von Nachverfolgbarkeit zwi-
https://ieeexplore.ieee.org/document/7332517 schen Anforderungen und
Quelltext," Ph.D. dissertation, Karlsruher \[42\] A. D. Rodriguez, J.
Cleland-Huang, and D. Falessi, "Leveraging in- Institut für Technologie
(KIT), 2023. termediate artifacts to improve automated trace link
retrieval," in 2021 \[55\] P. Runeson and M. Höst, "Guidelines for
conducting and reporting case IEEE International Conference on Software
Maintenance and Evolution study research in software engineering,"
Empirical Software Engineer- (ICSME), 2021, pp. 81--92. ing, vol. 14,
no. 2, p. 131, 2008. \[43\] A. Panichella, C. McMillan, E. Moritz, D.
Palmieri, R. Oliveto, \[56\] J. Sallou, T. Durieux, and A. Panichella,
"Breaking the silence: D. Poshyvanyk, and A. D. Lucia, "When and How
Using Structural the threats of using llms in software engineering," in
Proceedings Information to Improve IR-Based Traceability Recovery," in
2013 17th of the 2024 ACM/IEEE 44th International Conference on Software
European Conference on Software Maintenance and Reengineering,
Engineering: New Ideas and Emerging Results, ser. ICSE-NIER'24.
Mar. 2013, pp. 199--208. New York, NY, USA: Association for Computing
Machinery, 2024, p. \[44\] H. Kuang, P. Mäder, H. Hu, A. Ghabi, L.
Huang, J. Lü, and 102--106. \[Online\]. Available:
https://doi.org/10.1145/3639476.3639764 
