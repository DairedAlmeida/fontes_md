                                              R2Code: A Self-Reflective LLM Framework for
                                                   Requirements-to-Code Traceability
                                                             Yifei Wang                                 Jacky Keung                                  Xiaoxue Ma
                                                   Dept of Computer Science                     Dept of Computer Science                   Dept of Electronic Engineering
                                                 City University of Hong Kong                  City University of Hong Kong                   and Computer Science
                                                      Hong Kong, China                              Hong Kong, China                     Hong Kong Metropolitan University
                                                 ywang4748-c@my.cityu.edu.hk                    Jacky.Keung@cityu.edu.hk                         Hong Kong, China
                                                                                                                                                kxma@hkmu.edu.hk

                                                           Zhenyu Mao                                Kehui Chen                                     Yishu Li*
                                                  Dept of Computer Science                   Dept of Computer Science                    Dept of Electronic Engineering

arXiv:2604.22432v1 \[cs.SE\] 24 Apr 2026

                                                City University of Hong Kong               City University of Hong Kong                     and Computer Science
                                                     Hong Kong, China                            Hong Kong, China                      Hong Kong Metropolitan University
                                               zhenyumao2-c@my.cityu.edu.hk                kehuichen2-c@my.cityu.edu.hk                        Hong Kong, China
                                                                                                                                               sliy@hkmu.edu.hk


                                            Abstract—Accurate requirement-to-code traceability is crucial      code elements that are likely to implement it. However, main-
                                         for software maintenance. However, existing IR- and embedding-        taining traceability in evolving codebases remains challenging:
                                         based methods are heavily dependent on lexical similarity, often      manual tracing is labor-intensive and difficult to scale, and
                                         yielding incomplete or inconsistent links across projects and
                                         languages and incurring high cost from long-context retrieval and     prior studies report that traceability maintenance may consume
                                         prompting. This paper presents R2Code, an LLM-based semantic          a substantial portion of overall development effort [4], [5].
                                         traceability framework designed to improve trace link accuracy           Traditional information retrieval (IR) techniques, such as
                                         while reducing inference cost. R2Code integrates three com-           TF-IDF, BM25, VSM, LSI [6], and WMD [7], have long
                                         ponents: 1) a decomposition-enhanced Bidirectional Alignment          been used for automated trace link recovery. These methods
                                         Network (BAN) that aligns four-layer requirement semantics with
                                         corresponding code structures to support cross-level semantic         compute similarity from lexical overlap or term statistics,
                                         matching; 2) a Self-Reflective Consistency Verification (SRCV)        enabling efficient retrieval but limiting their ability to capture
                                         module that conducts explanation-guided consistency checking          deeper semantics [8]. Consequently, they often struggle with
                                         to calibrate link reliability; and 3) a Dynamic Context-Adaptive      (i) surface-level matching without semantic understanding [8],
                                         Retrieval (DCAR) mechanism that adjusts retrieval granularity         (ii) semantic and structural mismatches between high-level
                                         and filters contexts using semantic-overlap weighting for efficient
                                         context utilization. Experiments on five public datasets spanning     requirement descriptions and low-level code implementations
                                         multiple domains and two programming languages demonstrate            [9], and (iii) missing explicit verification of semantic coher-
                                         that R2Code consistently outperforms the strongest baselines,         ence in inferred links, which can lead to false positives.
                                         achieving an average F1 gain of 7.4%, while reducing token               Recent efforts explored large language models (LLMs)
                                         consumption by up to 41.7% through adaptive context control.          for requirements traceability, leveraging their reasoning and
                                            Index Terms—Requirements traceability, LLMs, Semantic
                                         alignment, Self-reflection, Context-adaptive retrieval.
                                                                                                               code understanding to go beyond keyword matching and
                                                                                                               infer requirement-to-code links [10]. Existing studies are pre-
                                                                                                               liminary, often relying on direct prompting or lightweight
                                                                  I. I NTRODUCTION
                                                                                                               retrieval-augmented pipelines without traceability-specific de-
                                            Requirements-to-Code Traceability maintains explicit links         cision mechanisms [11], [12], while emerging work on engi-
                                         among heterogeneous software artifacts such as requirements,          neering LLM-based systems also points to the need for more
                                         design documents, source code, and test cases [1]. It links           structured, protocol-driven designs [13]. In real-world settings,
                                         high-level, free-text documentation (e.g., requirements and           traceability requires (i) structured alignment between multi-
                                         design documents) to the source code elements that implement          layer requirement semantics and code logic, and (ii) cost-
                                         those requirements [2]. Such links support change impact              effective context construction, as naively expanding context
                                         analysis and program comprehension, and they influence the            increases token cost and noise [14], which may degrade accu-
                                         effort required to maintain and evolve software systems [3]. In       racy, efficiency, and robustness across projects and languages.
                                         practice, because traceability links are often missing or were           The core challenge of requirement-to-code traceability is
                                         not consistently recorded, an analyst may start from a natural-       to bridge the semantic and structural gap between human-
                                         language requirements document and retrieve a ranked list of          oriented requirement intent and program-level operational be-
                                                                                                               havior, robustly across domains and programming languages,
                                           * Corresponding author: Yishu Li.                                   while controlling the cost of context construction for LLM

inference \[15\]. This motivates a framework that can explicitly
typically follow a common pipeline: (i) represent each require- align
requirement and code semantics and selectively use ment and each code
entity as a textual artifact (e.g., derived the most relevant context
for decision-making, enabling more from requirement descriptions and
code identifiers/comments); reliable and efficient trace decisions in
practice. (ii) compute a relevance score s(r, c) from term statistics or
To address these challenges, we present R2Code, an LLM- vector-space
similarity; and (iii) rank candidate code entities based framework for
requirements-to-code traceability that c ∈ C for a given requirement r,
or convert scores into binary targets three core objectives:
effectiveness, robustness, and links via thresholding \[24\].
efficiency. R2Code bridges requirement--code mismatches via
Representative IR baselines in traceability include TF-IDF explicit
cross-level semantic alignment, improves link relia- and Vector Space
Model (VSM) variants, as well as BM25- bility through self-reflective
consistency checking, and reduces style ranking functions \[27\], which
estimate relevance from inference cost by constructing compact evidence
with context- term-frequency statistics (e.g., TF, IDF, and length
normaliza- adaptive retrieval. We evaluate R2Code on five public
datasets tion) \[27\]. Latent Semantic Indexing (LSI) projects documents
spanning multiple domains and two programming languages, into a
low-dimensional latent space via matrix factorization, demonstrating
consistent F1 improvements over strong IR, capturing co-occurrence
patterns beyond surface term overlap dense retrieval, and RAG-based
baselines while substantially \[28\]. Word Mover's Distance (WMD) and
related distance- reducing token consumption. based measures compute
document similarity using distances The main contributions of this paper
include: in a word-embedding space, enabling softer semantic matching •
Framework. We propose an end-to-end evidence-to- than exact term overlap
\[29\]. decision framework for requirement-to-code traceability Early
traceability research instantiated the IR paradigm with with three key
designs: bidirectional semantic align- a range of relevance models.
Marcus and Maletic leveraged ment, explanation-guided confidence
calibration, and LSI to recover documentation-to-code links by ranking
candi- cost-aware adaptive evidence construction. date code artifacts in
a latent semantic space \[30\]. Sundaram • Empirical study. We conduct
an extensive evaluation et al. evaluated VSM with alternative
term-weighting schemes on five public datasets across multiple domains
and two (e.g., TF-IDF/Okapi) alongside LSI across multiple datasets
programming languages, comparing against strong IR, \[31\]. Oliveto et
al. analyzed the overlap and equivalence of dense retrieval, and
RAG-based baselines, and demon- candidate links produced by IR
techniques \[32\]. And Hey et al. strate consistent F1 gains with
substantial reductions in explored WMD-based semantic distance for
traceability link token consumption. identification \[7\]. II.
BACKGROUND AND R ELATEDW ORK C. Neural Retrieval and LLM-based Methods
A. Requirements-to-Code Traceability: Task Overview Requirements-to-code
traceability aims to establish and Beyond classical IR, a large body of
work formulates maintain explicit links between natural-language
requirement trace link recovery with neural retrieval models that learn
statements and the source code entities (e.g., files, classes, or
semantic representations of requirements and code artifacts methods)
that implement them \[16\], \[17\]. Such requirement-- \[33\], \[34\]. A
common approach is the bi-encoder (dual- implementation links provide
essential support for software encoder) architecture, which encodes a
requirement r and a maintenance and evolution tasks, including change
impact code entity c independently into dense vectors and computes
analysis, program comprehension \[18\]. In practice, however, similarity
(e.g., dot product or cosine similarity) for ranking trace links are
frequently missing, outdated, or inconsistent \[35\]. This design
enables efficient nearest-neighbor search over in evolving codebases
\[19\], which motivates automated tech- large candidate sets and is
often used as a first-stage retriever. niques for trace link recovery
\[20\]. In addition, cross-encoder or interaction-based models are
Formally, given a set of requirements R = {r1 , . . . , rm } sometimes
adopted as rerankers: they jointly encode (r, c) and and a set of code
entities C = {c1 , . . . , cn }, the goal is to predict a relevance
score, typically trading off higher inference recover a trace link set L
⊆ R × C that approximates a cost for more fine-grained matching \[36\].
ground-truth set L∗ \[21\]. Prior work formulates the task in Neural
retrieval for traceability often leverages pretrained two modes:
ranking, which returns a ranked list of candidate Transformer encoders
to represent requirement text and tex- code entities for each
requirement, and classification \[22\], tualized code artifacts \[34\].
Requirements are encoded as which predicts whether a requirement--code
pair constitutes sentences or short documents, while code entities are
repre- a valid link under a similarity or confidence threshold \[23\].
sented using identifiers, comments, and related textual signals;
Accordingly, evaluation reports Precision, Recall, and F1 for
code-pretrained models can further improve the capture of link
prediction \[24\], and may also report ranking-based metrics
programming-language semantics \[37\], \[38\]. These encoders (e.g.,
MAP/MRR) when retrieval quality is emphasized \[25\]. can be fine-tuned
with supervision from known trace links to improve artifact-level
similarity estimation \[39\]. Similar to B. Classical IR-based Methods
IR pipelines, neural approaches support both top-k ranked Classical
information retrieval (IR) approaches are widely retrieval and
threshold-based link prediction under standard used as baselines for
automated trace link recovery \[26\]. They evaluation settings \[33\],
\[34\].  More recently, LLM-based methods have been explored semantic
representations, and then uses BAN to perform top- for traceability by
leveraging their reasoning capabilities to down and bottom-up alignment
to compute an initial matching model requirement-to-code relationships
and generate natural- score sBAN (r, c). language rationales for
predicted links \[40\], \[41\]. A common Self-Reflective Consistency
Verification (SRCV). To im- pattern is retrieval-assisted inference: a
retriever (IR or neural) prove reliability, SRCV generates an
explanation for a pre- first selects a small set of candidate code
entities, and the LLM dicted link and verifies its consistency with the
requirement. then performs link assessment, sometimes with explanation
The verification result calibrates the initial score, yielding the
generation or verification-style prompting, to output the final final
confidence sfinal (r, c) for link decision-making. decision \[42\],
\[43\]. In this way, LLMs serve as a semantic Dynamic Context-Adaptive
Retrieval (DCAR). DCAR decision module on top of retrieved evidence,
complementing governs evidence construction for LLM inference by
adapting retrieval-centric approaches \[44\]. retrieval granularity and
filtering context based on semantic overlap. It aims to provide compact
yet informative context to D. Research Gap downstream reasoning,
improving efficiency without sacrific- ing link quality. Prior work on
requirements-to-code trace link recovery offers strong baselines, yet
key gaps remain when jointly B. Problem Formulation optimizing accuracy,
robustness, and efficiency \[11\], \[45\]. (i) Effectiveness:
Cross-level mismatch. Classical IR and This work considers the
requirements-to-code traceability neural retrieval approaches largely
operationalize traceability problem between a set of natural-language
requirements and as text similarity scoring (lexical matching, latent
semantic a source code corpus. Let projection, or dense embeddings),
which supports ranking but R = {r1 , . . . , rm } does not explicitly
capture the correspondence between high- level requirement intent and
distributed implementation logic denote the requirement set, and in
code. (ii) Robustness: Uncalibrated confidence. Retrieval- centric
pipelines typically output similarity scores without an C = {c1 , . . .
, cn } explicit mechanism to verify semantic coherence, limiting in-
terpretability and allowing spurious matches to propagate. (iii) denote
the set of code entities, where each c ∈ C can be a Efficiency: Evidence
cost. Recent LLM-based studies often file, class, or method. The goal is
to recover a ground-truth rely on direct prompting or lightweight
retrieval-augmented link set pipelines whose outcomes are sensitive to
evidence selection L∗ ⊆ R × C, and presentation \[10\], \[42\]. Static
or overly broad context increases inference cost and introduces
irrelevant information, where (r, c) ∈ L∗ indicates that c (fully or
partially) imple- while overly narrow context may omit crucial
implementation ments r. Given this definition, a traceability approach
defines cues \[14\]. These limitations motivate traceability designs
that a scoring function integrate structured alignment, calibrated
confidence, and cost- s : R × C → \[0, 1\] aware evidence construction.
and produces predicted links by thresholding: III. M ETHODOLOGY L̂ = {(r,
c) \| r ∈ R, c ∈ C, s(r, c) ≥ θ}, A. Overview where θ ∈ \[0, 1\] is a
decision threshold. Fig. 1 summarizes the R2Code workflow. Given a
require- We model requirements-to-code traceability as a pa- ment r and
a codebase C, R2Code ranks candidate code rameterized
evidence-to-decision mapping that assigns each entities and outputs
trace links with calibrated confidence requirement--code pair a matching
score and an auxiliary scores. R2Code adopts a two-stage scoring
process: it derives explanation for validation. For each pair (r, c),
the framework structured semantic representations of requirements and
code outputs an alignment score sBAN (r, c), a calibrated confidence and
computes an alignment score sBAN (r, c) via bidirectional sfinal (r, c),
and an explanation E(r, c) describing the rationale semantic alignment
(Sec. III-B), then refines it into a calibrated for accepting or
rejecting the link. Overall, R2Code can be confidence sfinal (r, c)
through self-verification (Sec. III-C). viewed as a parameterized
mapping R2Code also generates an explanation E(r, c) to support hu- man
validation. In parallel, a context-adaptive retrieval mech- fΘ : (R, C)
→ {(r, c, sBAN (r, c), sfinal (r, c), E(r, c)) anism (Sec. III-D)
selects compact and relevant evidence for \| r ∈ R, c ∈ C}, LLM
inference, reducing redundant context while preserving salient signals.
R2Code comprises three components: where Θ denotes the framework
configuration. sfinal (r, c) is Decomposition-Enhanced BAN (HSD+BAN).
R2Code designed to approximate the unknown traceability relation first
applies HSD to decompose each requirement and sum- encoded in L∗ , while
E(r, c) provides interpretable support marize each candidate code entity
into comparable multi-layer for downstream verification.  Fig. 1: R2Code
Traceability Workflow

C. HSD+BAN: Decomposition and Alignment TABLE I: Requirement--Code Layer
Mapping R2Code begins by converting both requirements and code
Requirement layer Code layer What it captures Intent Ir Function intent
Fc goal / responsibility entities into structured semantic
representations, so that match- Actions Ar Control flow CFc operations /
logic steps ing is performed over aligned semantic dimensions rather
Conditions Cr Variable effects V Ec constraints / state changes than raw
text alone. Specifically, the framework applies Hi- Outputs Or Return
states RSc expected results / outputs erarchical Semantic Decomposition
(HSD) to obtain a four- layer requirement representation and a
four-layer code repre- sentation, and then uses a Bidirectional
Alignment Network "actions": \["record request metadata", " persist log
entry"\], (BAN) to compute an initial alignment score sBAN (r, c) via
"conditions": \["for every received request" complementary top-down and
bottom-up reasoning. \], a) Requirement semantic decomposition: For each
re- "outputs": \["a stored log entry that can be quirement r, HSD
decomposes its semantics into four dimen- queried later"\] sions:
intent, actions, conditions, and outputs }

                    Sr = (Ir , Ar , Cr , Or ).                (1)        b) Code semantic decomposition: For each code entity c
                                                                    (with textual view Tc ), HSD constructs a corresponding four-

Here, Ir denotes the intent, Ar = {ai } the required actions, layer
representation Cr = {ci } the conditions and constraints, and Or = {oi }
the expected outputs. Sc = (Fc , CFc , V Ec , RSc ), (2) Given
requirement text Tr , we prompt the LLM to produce Sr in a structured
JSON format with the corresponding fields where Fc captures the
function's intent, CFc = {cfi } (intent, actions, conditions, outputs).
We cap represents control-flow structures (e.g., branches and loops),
each list at 5 concise phrases and set temperature = 0 for V Ec = {vei }
denotes variable effects and state changes, deterministic parsing. and
RSc = {rsi } encodes return values or final states. Example
(simplified): For "The system shall log all re- Table I summarizes the
four-layer correspondence between quests", the output is: requirement
and code semantics used in BAN. { c) Bidirectional Alignment Network
(BAN): BAN esti- "intent": \["Maintain an audit trail for mates the
semantic correspondence between Sr and Sc through incoming requests"\],
two complementary directions. Top-down alignment focuses on requirement
satisfaction by assessing whether the code b) Consistency Reflection:
SRCV then evaluates whether covers the requirement's intent and
expectations: the explanation is consistent with the original
requirement text 1 by scoring: sTD = sim(Ir , Fc ) + sim(Ar , CFc ) 4 
(3) Cons(r, E) = LLMjudge (r, E) ∈ \[0, 1\], (7) + sim(Cr , V Ec ) +
sim(Or , RSc ) . Bottom-up alignment evaluates implementation fidelity
by To compute Cons(r, E), the backbone LLM is prompted to verifying that
the code's logic aligns with the requirement: assess whether the
generated explanation E(r, c) is consistent 1 with the original
requirement text Tr . The judge must return sBU = sim(Fc , Ir ) +
sim(CFc , Ar ) JSON in the following schema: 4  (4) + sim(V Ec , Cr ) +
sim(RSc , Or ) . { "consistent": \<"yes" \| "no"\>, sim(x, y) ∈ \[0, 1\]
is operationalized as a normalized seman- "score": `<float>`{=html}, tic
alignment score produced by the backbone LLM under "reasons":
\[`<string>`{=html}, ...\] a fixed prompt and a constrained output
schema. For each } semantic layer pair (x, y) (e.g., (Ir , Fc ), (Ar ,
CFc )), the LLM performs structured joint reasoning to assess whether y
seman- We define Cons(r, E) ∈ \[0, 1\] as the numeric field "score",
tically supports x, and returns a normalized confidence score. which is
used for confidence calibration in Eq. (9). To ensure consistency and
interpretability of the alignment As a lightweight auxiliary signal,
SRCV can additionally process, the output is constrained to a structured
JSON format. compute a term-level overlap between the requirement and
Concretely, the LLM must return JSON in the following the explanation:
schema: \|Terms(r) ∩ Terms(E)\| { Overlap(r, E) = . (8) \|Terms(r) ∪
Terms(E)\| "score": `<float>`{=html}, "coverage": \<"covered" \|
"partially_covered" In our framework, Overlap(r, E) is treated only as
supportive \| "not_covered"\>, evidence rather than a primary decision
factor. "evidence": \[`<string>`{=html}, ...\] } c) Score Adjustment:
Finally, SRCV calibrates the BAN score using the consistency signal: The
numeric field "score" is directly used as sim(x, y). The  remaining
fields are optional and used only for interpretability sfinal = Adjust
sBAN , Cons(r, E) . (9) and error analysis. High consistency slightly
strengthens confidence, moderate The final BAN score combines the two
directions: consistency applies a mild penalty, and low consistency
trig- sBAN (r, c) = α sTD + (1 − α) sBU , (5) gers a stronger penalty.
Importantly, SRCV is not a separate predictive model; it is a confidence
calibration layer that where α ∈ \[0, 1\] balances requirement
satisfaction (top-down reduces false positives caused by hallucinated
connections verification) and implementation fidelity (bottom-up valida-
while preserving links supported by coherent reasoning. tion). The
resulting sBAN (r, c) serves as the initial alignment score and is
passed to the next stage for confidence calibration E. DCAR: Dynamic
Context-Adaptive Retrieval via self-verification (Section III-D). DCAR
controls evidence construction for LLM inference by D. SRCV:
Self-Reflective Consistency Verification adapting retrieval granularity
and filtering noisy context on a BAN provides an initial semantic
alignment score per-requirement basis. Rather than using a fixed
retrieval win- sBAN (r, c) for each requirement--code pair. However,
LLM- dow for all requirements, DCAR (i) builds compact, reusable based
alignment may still exhibit over-confident links when summaries for code
units, (ii) allocates a requirement-specific the model forms plausible
but unsupported associations. SRCV retrieval budget, and (iii) retains
only the most relevant items introduces a lightweight self-verification
step that uses the as input evidence for downstream reasoning. model's
own explanation as evidence and calibrates the con- a) Code
Summarization (Cached): To avoid repeatedly fidence of sBAN accordingly,
producing the final score sfinal . sending full code into the LLM, DCAR
generates a compact a) Explanation Generation: Given (r, c) and sBAN (r,
c), summary for each code unit c (e.g., file/class/function) with SRCV
first asks the LLM to generate an explicit justification: text Tc : E(r,
c) = LLMgen (r, c, sBAN ), (6) Summary(c) = (Fc , Dc , CCc , γc ), (10)

where E(r, c) summarizes the claimed semantic correspon- where Fc is the
function/name signature, Dc is a short se- dence (e.g., which
requirement intents are supported by which mantic description of the
core behavior, CCc is the set of code behaviors). This step does not aim
at making the output invoked/dependent functions (call links), and γc ∈
\[0, 1\] is an "look reasonable"; rather, it externalizes the rationale
into a estimated code complexity. Summaries are cached and reused
verifiable object for subsequent checking. across requirements.  b)
Requirement Complexity: Given a requirement r with To address RQ2, we
evaluate R2Code on five public datasets text Tr , DCAR computes a
semantic complexity score: spanning different application domains and
two program- ming languages (Java and C#), including four CoEST Java
Γ(r) = w1 ϕlen (Tr )+w2 ϕact (Tr )+w3 ϕcond (Tr )+w4 ϕconn (Tr ),
datasets \[7\] and the RETRO.NET dataset for C# \[46\]. (11) To address
RQ3, we record token consumption, inference where ϕlen , ϕact , ϕcond ,
ϕconn capture requirement length, ac- latency, and estimated cost under
different retrieval strategies. tion density, conditional indicators,
and logical connectors, We compare fixed-window RAG \[47\] with the
proposed respectively. dynamic context-adaptive retrieval (DCAR) to
quantify the c) Adaptive Retrieval Window: Based on Γ(r), DCAR
cost--accuracy trade-off. sets a retrieval budget kr using a minimal
piecewise rule:  k0 , Γ(r) \< τ1 , B. Settings  kr = 2k0 , τ1 ≤ Γ(r)
\< τ2 , (12)  TABLE II: Dataset Statistics 3k0 , Γ(r) ≥ τ2 ,  Dataset
Lang. Description Req. Code Gold Links where k0 is the base retrieval
size and τ1 , τ2 are complexity iTrust Java Medical 335 1,818 1,156
thresholds. Simpler requirements retrieve a smaller set of eTour Java
Tourism 316 1,337 1,162 function-level summaries, while more complex
requirements SMOS Java Sensor 154 1,220 552 may expand retrieval to
include call-chain-related context via eANCI Java Admin. 66 316 74
RETRO.NET C# Library 66 118 301 CCc , so that distributed
implementations can be covered. d) Semantic Filtering: After retrieval,
DCAR further filters candidate contexts using a lightweight
semantic-overlap 1) Dataset: To ensure a robust and reproducible
evaluation signal computed between the requirement and each candidate's
of R2Code across diverse project domains and programming summary text:
languages, we conduct experiments on five public requirement- to-code
traceability datasets. As summarized in Table II, these \|Terms(r) ∩
Terms(Dci )\| Overlap(r, Dci ) = . (13) datasets cover medical systems,
tourism platforms, sensor \|Terms(r) ∪ Terms(Dci )\| networks, and
public administration, and span two program- Only items above a
threshold are retained, with a final cap on ming languages (Java and
C#). Each dataset contains natural- context size: language requirements,
the corresponding source code files, and manually curated ground-truth
traceability links. Cfinal = {ci \| Overlap(r, Dci ) ≥ θov }, \|Cfinal
\| ≤ kmax . 2) Model: R2Code is implemented with DeepSeek-V3.1- (14)
Terminus as the backbone LLM for hierarchical decomposi- The resulting
Cfinal constitutes the compact evidence passed tion, bidirectional
alignment, and consistency verification. We to the downstream LLM
decision stage. adopt DeepSeek-V3.1-Terminus because DeepSeek's JSON IV.
E XPERIMENT Output allows us to enforce schema-constrained structured
decomposition and normalized alignment scoring, enabling A. Research
Questions reliable parsing and downstream computation \[48\]. For the
This study evaluates R2Code through three research ques- baseline RAG
pipeline, dense retrieval is implemented using tions that reflect the
core objectives of the framework: effec-
sentence-transformers/all-mpnet-base-v2. Classical IR base- tiveness,
robustness, and efficiency. lines include BM25, TF-IDF, VSM, LSI, and
WMD, each • RQ1 (Effectiveness): How effectively does R2Code configured
with standard parameter settings. improve traceability accuracy compared
with baseline 3) Environment and Parameters: All experiments are con-
methods, and how do its key components contribute to ducted on an NVIDIA
A100 server using Python 3.9 and this improvement? PyTorch 2.0, with the
random seed fixed to 42. The backbone • RQ2 (Robustness): Does R2Code
maintain stable perfor- LLM uses temperature 0.0, top-p 0.95, and max
tokens 2048. mance across different project domains and programming IR
baselines follow commonly used configurations in standard languages?
toolkits. Within R2Code, BAN and SRCV use a fixed configu- • RQ3
(Efficiency): What efficiency gains does R2Code ration throughout all
experiments. For DCAR, we set kbase = 5 provide in terms of token usage
and inference cost? and cap dynamic expansion with kmax = 10 to bound
retrieval To address RQ1, we evaluate R2Code against traditional context
and cost. IR baselines (BM25, TF-IDF, VSM, LSI, WMD), a dense re- 4)
Evaluation Metrics: We evaluate traceability perfor- triever, and a
standard RAG+LLM pipeline on five benchmark mance from three
perspectives: (i) classification quality, re- datasets \[26\], \[42\].
We report precision, recall, and F1-score, ported with Precision,
Recall, and F1-score on predicted and include ranking metrics ( MRR, and
precision/recall@k) requirement--code links; (ii) ranking quality,
assessed by MRR to assess retrieval quality \[24\], \[25\]. We further
examine the along with Precision@k and Recall@k (k ∈ {5, 10}) to
contributions of key components by comparing R2Code with reflect the
quality of top-ranked candidates; and (iii) efficiency, its ablated
variants. measured by total input/output token consumption, the number
of LLM requests, and end-to-end runtime, with inference cost the full
configuration achieves the best balance among preci- estimated based on
per-token pricing for input and output sion, recall, and F1 on iTrust.
tokens. All results are averaged over requirements, and we Fig. 2
reports BAN's layer-wise alignment scores on iTrust report standard
deviations where appropriate. across four semantic layers. The Intent
layer achieves the highest alignment (0.814 in the combined setting),
suggesting V. R ESULTS that high-level goal matching provides a strong
traceability In this section, we present experimental results organized
signal. The alignment decreases for more fine-grained layers, by the
research questions in Section IV-A. We first report the with Actions
(0.781), Outputs (0.803), and Conditions (0.747), accuracy of R2Code on
the primary benchmark setting (iTrust) indicating increased semantic
variability when matching de- and analyze the contribution of key
components via ablation tailed requirement semantics to code. In
addition, the top- (RQ1). We then examine robustness by evaluating the
same down (R→Code) direction consistently yields higher align-
configuration across multiple datasets spanning different appli- ment
scores than bottom-up (Code→R), while the combined cation domains and
programming languages (RQ2). Finally, strategy offers a more balanced
signal across layers. we analyze efficiency in terms of token
consumption, runtime, and estimated cost, and quantify the
cost--accuracy trade-off under different retrieval strategies (RQ3). A.
Answer to RQ1: Effectiveness

TABLE III: Overall Performance on the iTrust Dataset Method F1 Recall
Prec. MRR P@10 R@10 BM25 0.6158 0.6084 0.6234 0.7234 0.5845 0.5234
TF-IDF 0.6068 0.6014 0.6123 0.7089 0.5712 0.5123 VSM 0.5928 0.5876
0.5981 0.6924 0.5568 0.4987 LSI 0.5684 0.5623 0.5746 0.6689 0.5321
0.4715 WMD 0.5910 0.5944 0.5876 0.6945 0.5523 0.3894 RAG-LLM 0.6949
0.6783 0.7123 0.8123 0.6823 0.6123 R2Code 0.7296 0.7050 0.7560 0.8550
0.7720 0.7060 Fig. 2: Layer-wise alignment scores of BAN on iTrust To
answer RQ1, we compare R2Code with classical IR \* Alignment score is
the mean LLM-derived sim(x, y) per layer pair over baselines and a
standard RAG+LLM pipeline on iTrust. As evaluated requirement--code
pairs in iTrust. shown in Table III, R2Code achieves the best overall
perfor- mance, reaching an F1-score of 0.7296 with 0.7560 precision Fig.
3 compares the SRCV consistency score distributions and 0.7050 recall.
Compared with the strongest baseline of positive and negative
requirement--code pairs on iTrust. The RAG+LLM (F1=0.6949), R2Code
improves F1 by +0.0341, positive pairs exhibit substantially higher
consistency scores, while also achieving higher ranking quality (MRR:
0.8550 while negative pairs are concentrated in the low-score region,
vs. 0.8123). Under practical top-k cutoffs, R2Code yields the indicating
that SRCV provides a discriminative validation highest P@10 (0.7720) and
R@10 (0.7060), indicating more signal. Using the predefined threshold
θconsistency = 0.7, most correct links can be surfaced earlier in the
ranked list. negative candidates can be suppressed while preserving
high- consistency positive links, supporting the effectiveness of TABLE
IV: Ablation Study on the iTrust Dataset SRCV for filtering spurious
matches. Ablation BAN SRCV DCAR F1 Prec. Recall B. Answer to RQ2:
Robustness Full ✓ ✓ ✓ 0.7296 0.7560 0.7050 -- BAN × ✓ ✓ 0.6949 0.7123
0.6783 TABLE V: Cross-Dataset Performance Consistency -- SRCV ✓ × ✓
0.6864 0.7873 0.6084 -- DCAR ✓ ✓ × 0.7112 0.8117 0.6329 Dataset Best
Baseline (F1) R2Code (F1) Gain BAN only ✓ × × 0.6859 0.7600 0.6250
iTrust 0.6949 0.7296 +5.0% SRCV only × ✓ × 0.6854 0.7234 0.6512 eTour
0.6812 0.7342 +7.8% DCAR only × × ✓ 0.6930 0.8122 0.6040 SMOS 0.6663
0.7201 +8.1% Note. ✓ indicates the component is enabled; × indicates it
is removed. eANCI 0.7058 0.7592 +7.6% RETRO 0.6580 0.7134 +8.4% Average
0.6812 0.7313 +7.4% Table IV reports the ablation results of R2Code on
iTrust. Std. Dev. 0.0176 0.0157 -- Removing BAN decreases the F1-score
from 0.7296 to 0.6949. Disabling SRCV results in a larger drop
(F1=0.6864), ac- To answer RQ2, Table V reports the cross-dataset per-
companied by a reduction in recall to 0.6084. When DCAR formance of
R2Code under a fixed configuration, evaluating is removed, the F1-score
remains close to the full model its robustness across five traceability
datasets with diverse (0.7112), while recall drops from 0.7050 to
0.6329. Overall, characteristics. For each dataset, we compare R2Code
against  expand to 23.4 candidate files. This pattern shows that DCAR
increases retrieval context for more complex requirements while keeping
the number of files included in the final prompt bounded by kmax=10. VI.
D ISCUSSION A. Finding 1: Effectiveness R2Code's effectiveness in RQ1 is
best understood not as "more retrieval" but as better decision-making
under noisy candidates: structured semantic alignment helps separate
true implementation evidence from lexical look-alikes, making the
top-ranked links more reliable for maintenance use. The abla- Fig. 3:
Discriminative consistency validation of SRCV tion results reveal
distinct and complementary roles. Removing \* SRCV consistency score
distributions for positive (ground-truth links) and BAN largely erases
the advantage, indicating that cross-layer negative (non-links)
requirement--code pairs on iTrust (n = 500 each). The alignment is the
primary source of improvement rather than dashed line indicates the
filtering threshold θconsistency = 0.7. incidental prompt effects.
Notably, removing SRCV can increase precision while the
strongest-performing baseline measured by F1-score. As substantially
hurting recall. This suggests SRCV does more shown in the table, R2Code
consistently outperforms the best than filter false positives, it
calibrates confidence so the system baseline on all datasets, achieving
relative F1-score gains does not become overly conservative and miss
valid links when ranging from 5.0% to 8.4%. The improvements are stable
evidence is partial or uneven. DCAR mainly improves evi- across
datasets, with an average gain of 7.4% and comparable dence coverage.
Removing it increases precision but reduces standard deviations between
the baseline and R2Code results, recall, indicating that dynamic
evidence construction retrieves indicating that the proposed approach
maintains consistent additional true links while also introducing
harder, borderline effectiveness without dataset-specific tuning.
candidates that BAN and SRCV help resolve. B. Finding 2: Robustness C.
Answer to RQ3: Efficiency R2Code shows robust improvements across
heterogeneous Table VI summarizes the efficiency and cost results on
project structures and transfers to the C# RETRO dataset under the
iTrust dataset. Traditional IR baselines (e.g., BM25 and the same fixed
configuration. This robustness is consistent with TF-IDF) incur zero LLM
API cost, but achieve substantially decomposition-based alignment: by
matching requirements lower F1-scores. Compared with the RAG+LLM
baseline, and code at corresponding semantic layers, the framework is
R2Code reduces total token consumption from 3.74M to less dependent on
shared vocabulary that may shift across do- 2.18M (−41.7%), including a
48.0% reduction in input tokens mains or languages. In addition, SRCV
contributes a domain- and a 21.6% reduction in output tokens. This
results in a lower agnostic calibration signal. Fig. 3 shows that
consistency estimated inference cost (\$463.16 to \$285.79, −38.3%) and
scores separate positive from negative pairs and that a single a shorter
end-to-end runtime (1,234.5s to 987.3s, −20.0%), threshold (θ = 0.7)
suppresses most negative candidates while while improving F1 from 0.6949
to 0.7296. preserving high-consistency positives. A remaining boundary
Table VI further reports the cost per correct traceability case involves
highly scattered implementations, where limited link. R2Code achieves
\$0.2472 per correct link with 1,156 context budgets may miss
intermediate evidence, suggesting true positives, whereas RAG+LLM
requires \$0.4027 per cor- more adaptive evidence expansion. rect link
for 1,150 true positives. These results indicate that R2Code delivers
higher traceability accuracy with lower per- C. Finding 3: Efficiency
link inference cost under the same evaluation setting. R2Code improves
efficiency not simply by "using fewer Table VII summarizes token
efficiency under fixed-window tokens," but by making the evidence budget
more selective retrieval and DCAR on the iTrust dataset for the
retrieval and task-aware. Compared with a fixed-window RAG+LLM
construction stage. DCAR reduces the average tokens per pipeline, it
reduces end-to-end runtime and estimated inference requirement--code
pair from 4,850 to 3,054, corresponding to cost while still improving
F1, indicating that traceability an approximate 37% reduction. In terms
of overall usage, total benefits more from compact, high-relevance
evidence than token consumption decreases from 2,483,200 to 1,563,216,
from indiscriminately expanding context. Table VII shows that indicating
that adaptive context selection can substantially DCAR expands retrieval
scope in a structured way by allo- lower token overhead under the same
evaluation setting. cating more candidate files to higher-complexity
requirements Table VII also reports how DCAR adjusts retrieval scope
(about 8.3 vs. 23.4 on average), while keeping the final prompt based on
requirement complexity, measured as the number bounded by (kmax=10).
This suggests a practical scaling of retrieved candidate files.
Low-complexity requirements re- implication: efficiency gains come from
removing irrelevant trieve an average of 8.3 candidate files, medium
complexity re- evidence and reserving broader context only for
requirements trieves 15.7 candidate files, and high-complexity
requirements that empirically need it.  TABLE VI: Efficiency and cost
summary on the iTrust dataset

           Model            F1      Input Tokens        Output Tokens     Runtime (s)    Cost (USD)        True Positives      Cost/TP (USD)
           BM25           0.6158                0                  0              0.2            0.00                  704              0.0000
           TF-IDF         0.6068                0                  0              0.5            0.00                  691              0.0000
           WMD            0.5910                0                  0              1.8            0.00                  680              0.0000
           RAG+LLM        0.6949        2,847,234            892,156          1,234.5          463.16                1,150              0.4027
           R2Code         0.7296        1,479,935            699,521            987.3          285.79                1,156              0.2472

TABLE VII: Retrieval-stage efficiency: Fixed RAG vs. achieving an
average relative F1 improvement of 7.4% and up DCAR on iTrust to 14.1%
on individual datasets. Meanwhile, R2Code reduces Metric Fixed RAG DCAR
total token consumption by up to 41.7%, and improves the cost per
correct link by up to 37.0%, demonstrating that better Tokens per pair
4,850 3,054 Total tokens 2,483,200 1,563,216 traceability quality can be
obtained with substantially lower inference overhead. Avg. retrieved
files (Low complexity) -- 8.3 Avg. retrieved files (Medium complexity)
-- 15.7 Future work will extend R2Code to larger-scale industrial Avg.
retrieved files (High complexity) -- 23.4 repositories and additional
software artifacts, such as design Note. Tokens are counted for
retrieval construction only (excluding documents, issue discussions, and
commits, to further evaluate BAN/SRCV). "Retrieved files" denote pre-cap
candidates (code entities). its applicability in more realistic
development settings. We also plan to strengthen robustness in
continuously evolving codebases by introducing incremental summary
refresh and VII. T HREATS TO VALIDITY more adaptive evidence expansion
for highly scattered im- plementations. In addition, we will explore
more controllable Internal validity. The reported results may be
influenced by decomposition and verification strategies to improve the
relia- implementation and configuration choices, such as the selected
bility and interpretability of trace decisions. Finally, we aim to LLM
backbone and the prompting protocol, which can affect investigate
multilingual traceability settings and broader cross- the
precision--recall--cost trade-off in LLM-assisted pipelines. project
scenarios to further enhance the generalization and To mitigate this
threat, we fix the experimental setup across practical adoption of the
proposed framework. all datasets (same backbone, prompting protocol, and
budgets) with deterministic decoding (e.g., temperature = 0) to reduce
ACKNOWLEDGMENT run-to-run variance, and we adopt a consistent setting
based on a small pilot sensitivity analysis of prompt and configuration
The work described in this paper is substantially sup- variants. In
addition, errors in LLM-generated intermediate ported by Hong Kong
Metropolitan University Research Grant representations may propagate to
alignment and calibration, (Project Reference No. RD/2025/1.21 and
No. RD/2025/1.24), particularly for ambiguous requirements or highly
dispersed and partially supported by the grant under the Research Grant
implementations. Council (Project Reference No. UGC/FDS16/E25/25).
External validity. The evaluation is conducted on public datasets with
varying artifact granularity and link sparsity, R EFERENCES which may
influence absolute effectiveness. Cost estimates are \[1\] B. Ramesh, C.
Stubbs, T. Powers, and M. Edwards, "Requirements derived from token
usage and runtime measured in a specific traceability: Theory and
practice," Annals of software engineering, environment, and may differ
under alternative infrastructures vol. 3, no. 1, pp. 397--415, 1997. or
pricing schemes. In evolving repositories, cached code \[2\] G.
Antoniol, G. Canfora, G. Casazza, A. De Lucia, and E. Merlo, "Recovering
traceability links between code and documentation: a summaries may also
become stale, motivating incremental retrospective," IEEE Transactions
on Software Engineering, 2025. update strategies for continuous
integration settings. \[3\] A. Ghabi and A. Egyed, "Code patterns for
automatically validating requirements-to-code traces," in Proceedings of
the 27th IEEE/ACM VIII. C ONCLUSION International Conference on
Automated Software Engineering, 2012, pp. 200--209. In this paper, we
proposed R2Code for requirements-to- \[4\] B. Ramesh, "Factors
influencing requirements traceability practice," code traceability,
aiming to improve effectiveness, enhance Communications of the ACM,
vol. 41, no. 12, pp. 37--44, 1998. \[5\] F. Tian, T. Wang, P. Liang, C.
Wang, A. A. Khan, and M. A. Babar, efficiency, and maintain robust
performance across hetero- "The impact of traceability on software
maintenance and evolution: A geneous projects. R2Code combines
structured semantic de- mapping study," Journal of Software: Evolution
and Process, vol. 33, composition, bidirectional alignment, confidence
calibration, no. 10, p. e2374, 2021. \[6\] Y. Lyu, H. Cho, P. Jung, and
S. Lee, "A systematic literature review of and context-adaptive evidence
construction to produce reli- issue-based requirement traceability,"
Ieee Access, vol. 11, pp. 13 334-- able trace links under limited
context budgets. Experiments 13 348, 2023. on five public datasets
(iTrust, eTour, SMOS, eANCI, and \[7\] T. Hey, F. Chen, S. Weigelt, and
W. F. Tichy, "Improving traceability link recovery using fine-grained
requirements-to-code relations," in 2021 RETRO.NET) show that R2Code
consistently outperforms IEEE International Conference on Software
Maintenance and Evolution classical IR baselines and LLM-based retrieval
pipelines, (ICSME). IEEE, 2021, pp. 12--22.  \[8\] J. L. Guo, J.-P.
Steghöfer, A. Vogelsang, and J. Cleland-Huang, "Natural \[28\] S.
Deerwester, S. T. Dumais, G. W. Furnas, T. K. Landauer, and language
processing for requirements traceability," in Handbook on R. Harshman,
"Indexing by latent semantic analysis," Journal of the Natural Language
Processing for Requirements Engineering. Springer, American society for
information science, vol. 41, no. 6, pp. 391--407, 2025, pp. 89--116.
1990. \[9\] T. Merten, D. Krämer, B. Mager, P. Schell, S. Bürsner, and
B. Paech, \[29\] M. Kusner, Y. Sun, N. Kolkin, and K. Weinberger, "From
word "Do information retrieval algorithms for automated traceability
perform embeddings to document distances," in Proceedings of the 32nd
effectively on issue tracking system data?" in International Working
International Conference on Machine Learning (ICML). PMLR, Conference on
Requirements Engineering: Foundation for Software 2015, pp. 957--966.
\[Online\]. Available: https://proceedings.mlr.press/ Quality. Springer,
2016, pp. 45--62. v37/kusnerb15.html \[10\] M. North, A.
Atapour-Abarghouei, and N. Bencomo, "Code gradients: \[30\] A. Marcus
and J. I. Maletic, "Recovering documentation-to-source-code Towards
automated traceability of llm-generated code," in 2024 IEEE traceability
links using latent semantic indexing," in 25th International 32nd
International Requirements Engineering Conference (RE). IEEE, Conference
on Software Engineering, 2003. Proceedings. IEEE, 2003, 2024,
pp. 321--329. pp. 125--135. \[11\] E. Alor, S. Khatoonabadi, and E.
Shihab, "Evaluating the use of llms for \[31\] S. K. Sundaram, J. H.
Hayes, A. Dekhtyar, and E. A. Holbrook, documentation to code
traceability," arXiv preprint arXiv:2506.16440, "Assessing traceability
of software engineering artifacts," Requirements 2025. engineering,
vol. 15, no. 3, pp. 313--335, 2010. \[12\] M. A. Zadenoori, J.
Dabrowski, W. Alhoshan, L. Zhao, and A. Ferrari, \[32\] R. Oliveto, M.
Gethers, D. Poshyvanyk, and A. De Lucia, "On the "Large language models
(llms) for requirements engineering (re): A equivalence of information
retrieval methods for automated traceability systematic literature
review," arXiv preprint arXiv:2509.11446, 2025. link recovery," in 2010
IEEE 18th International Conference on Program \[13\] Z. Mao, J. Keung,
F. Zhang, S. Liu, Y. Wang, and J. Li, "Towards en- Comprehension. IEEE,
2010, pp. 68--71. gineering multi-agent llms: A protocol-driven
approach," arXiv preprint \[33\] J. Guo, J. Cheng, and J. Cleland-Huang,
"Semantically enhanced soft- arXiv:2510.12120, 2025. ware traceability
using deep learning techniques," in 2017 IEEE/ACM \[14\] Y. Li, J.
Keung, Z. Yang, X. Ma, J. Zhang, and S. Liu, "Simac: 39th International
Conference on Software Engineering (ICSE). IEEE, simulating agile
collaboration to generate acceptance criteria in user 2017, pp. 3--14.
story elaboration," Automated Software Engineering, vol. 31, no. 2,
p. 55, \[34\] J. Lin, Y. Liu, Q. Zeng, M. Jiang, and J. Cleland-Huang,
"Traceability 2024. transformed: Generating more accurate links with
pre-trained bert mod- els," in 2021 IEEE/ACM 43rd International
Conference on Software \[15\] B. Wang, Z. Zou, X. Liang, H. Jin, and P.
Liang, "Hgnnlink: recovering Engineering (ICSE). IEEE, 2021,
pp. 324--335. requirements-code traceability links with text and
dependency-aware \[35\] N. Reimers and I. Gurevych, "Sentence-bert:
Sentence embeddings using heterogeneous graph neural networks,"
Automated Software Engineer- siamese bert-networks," arXiv preprint
arXiv:1908.10084, 2019. ing, vol. 32, no. 2, p. 55, 2025. \[36\] J.
Leonhardt, H. Müller, K. Rudra, M. Khosla, A. Anand, and A. Anand,
\[16\] J. Cleland-Huang, O. C. Gotel, J. Huffman Hayes, P. Mäder, and
"Efficient neural ranking using forward indexes and lightweight en- A.
Zisman, "Software traceability: trends and future directions," in
coders," ACM Transactions on Information Systems, vol. 42, no. 5, pp.
Future of software engineering proceedings. ACM, 2014, pp. 55--69.
1--34, 2024. \[17\] B. Ramesh and M. Jarke, "Toward reference models for
requirements \[37\] Z. Feng, "Codebert: A pre-trained model for
program-ming and natural traceability," IEEE transactions on software
engineering, vol. 27, no. 1, languages," arXiv preprint
arXiv:2002.08155, 2020. pp. 58--93, 2002. \[38\] D. Guo, S. Lu, N. Duan,
Y. Wang, M. Zhou, and J. Yin, "Unixcoder: \[18\] N. Niu, W. Wang, and A.
Gupta, "Gray links in the use of require- Unified cross-modal
pre-training for code representation," arXiv preprint ments
traceability," in Proceedings of the 2016 24th ACM SIGSOFT
arXiv:2203.03850, 2022. international symposium on foundations of
software engineering, 2016, \[39\] J. Tian, L. Zhang, and X. Lian, "A
cross-level requirement trace pp. 384--395. link update model based on
bidirectional encoder representations from \[19\] R. Rasiman, F.
Dalpiaz, and S. España, "How effective is automated transformers,"
Mathematics, vol. 11, no. 3, p. 623, 2023. trace link recovery in
model-driven development?" in International \[40\] D. Fuchß, T. Hey, J.
Keim, H. Liu, N. Ewald, T. Thirolf, and Working Conference on
Requirements Engineering: Foundation for A. Koziolek, "Lissa: toward
generic traceability link recovery through Software Quality. Springer,
2022, pp. 35--51. retrieval-augmented generation," in Proceedings of the
IEEE/ACM 47th \[20\] T. W. W. Aung, H. Huo, and Y. Sui, "A literature
review of automatic International Conference on Software Engineering.
ICSE, vol. 25, 2025. traceability links recovery for software change
impact analysis," in \[41\] Y. Wang, J. Keung, Z. Mao, J. Zhang, and Y.
Cao, "Chart2code-mola: Proceedings of the 28th International Conference
on Program Com- Efficient multi-modal code generation via adaptive
expert routing," arXiv prehension, 2020, pp. 14--24. preprint
arXiv:2511.23321, 2025. \[21\] Y. Zhang, C. Wan, and B. Jin, "An
empirical study on recovering \[42\] T. Hey, D. Fuchß, J. Keim, and A.
Koziolek, "Requirements traceability requirement-to-code links," in 2016
17th IEEE/ACIS International Con- link recovery via retrieval-augmented
generation," in International Work- ference on Software Engineering,
Artificial Intelligence, Networking and ing Conference on Requirements
Engineering: Foundation for Software Parallel/Distributed Computing
(SNPD). IEEE, 2016, pp. 121--126. Quality. Springer, 2025, pp. 381--397.
\[22\] B. Wang, H. Wang, R. Luo, S. Zhang, and Q. Zhu, "A systematic
map- \[43\] S. J. Ali, V. Naganathan, and D. Bork, "Establishing
traceability between ping study of information retrieval approaches
applied to requirements natural language requirements and software
artifacts by combining trace recovery." in SEKE, 2022, pp. 1--6. rag and
llms," in International Conference on Conceptual Modeling. \[23\] T.
Hey, J. Keim, and S. Corallo, "Requirements classification for trace-
Springer, 2024, pp. 295--314. ability link recovery," in 2024 IEEE 32nd
International Requirements \[44\] Y. Li, J. Keung, X. Ma, C. Y. Chong,
J. Zhang, and Y. Liao, "Llm- Engineering Conference (RE). IEEE, 2024,
pp. 155--167. based class diagram derivation from user stories with
chain-of-thought \[24\] J. H. Hayes, A. Dekhtyar, and J. Osborne,
"Improving requirements promptings," in 2024 IEEE 48th Annual Computers,
Software, and tracing via information retrieval," in Proceedings. 11th
IEEE Interna- Applications Conference (COMPSAC). IEEE, 2024, pp. 45--50.
tional Requirements Engineering Conference, 2003. IEEE, 2003, pp. \[45\]
Z. Mao, J. Keung, Y. Sun, Y. Wang, S. Liu, and J. Li, "Towards 138--147.
requirements engineering for genai-enabled software: Bridging respon-
\[25\] C. Zhang, Y. Wang, Z. Wei, Y. Xu, J. Wang, H. Li, and R. Ji,
"Ealink: sibility gaps through human oversight requirements," arXiv
preprint An efficient and accurate pre-trained framework for
issue-commit link arXiv:2511.13069, 2025. recovery," in 2023 38th
IEEE/ACM International Conference on Auto- \[46\] J. H. Hayes, A.
Dekhtyar, and J. Payne, "The requirements tracing on mated Software
Engineering (ASE). IEEE, 2023, pp. 217--229. target (retro). net
dataset," in 2018 IEEE 26th International Require- \[26\] M. Borg, P.
Runeson, and A. Ardö, "Recovering from a decade: a ments Engineering
Conference (RE). IEEE, 2018, pp. 424--427. systematic mapping of
information retrieval approaches to software \[47\] P. Lewis, E. Perez,
A. Piktus, F. Petroni, V. Karpukhin, N. Goyal, traceability," Empirical
Software Engineering, vol. 19, no. 6, pp. 1565-- H. Küttler, M. Lewis,
W.-t. Yih, T. Rocktäschel et al., "Retrieval- 1616, 2014. augmented
generation for knowledge-intensive nlp tasks," Advances in \[27\] S.
Robertson, H. Zaragoza et al., "The probabilistic relevance frame-
neural information processing systems, vol. 33, pp. 9459--9474, 2020.
work: Bm25 and beyond," Foundations and Trends® in Information \[48\]
DeepSeek, "Deepseek api guide: Json output," https://api-docs.deepseek.
Retrieval, vol. 3, no. 4, pp. 333--389, 2009. com/guides/json_mode,
accessed: 2026-02-05. 
