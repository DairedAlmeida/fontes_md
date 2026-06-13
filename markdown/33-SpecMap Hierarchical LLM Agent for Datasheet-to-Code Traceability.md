                                             SpecMap: Hierarchical LLM Agent for Datasheet-to-Code
                                                Traceability Link Recovery in Systems Engineering
                                                                      Vedant Nipane       Pulkit Agrawal       Amit Singh
                                                                                          H2LooP.ai


                                                                                            Abstract
                                                  Establishing precise traceability between embedded systems datasheets and their corresponding

arXiv:2601.11688v1 \[cs.SE\] 16 Jan 2026

                                              code implementations remains a fundamental challenge in systems engineering, particularly for low-
                                              level software where manual mapping between specification documents and large code repositories is
                                              infeasible. Existing Traceability Link Recovery (TLR) approaches primarily rely on lexical similarity
                                              and information retrieval techniques, which struggle to capture the semantic, structural, and symbol-
                                              level relationships prevalent in embedded systems software. We present a hierarchical datasheet-to-code
                                              mapping methodology that employs large language models (LLMs) for semantic analysis while explic-
                                              itly structuring the traceability process across multiple abstraction levels. Rather than performing
                                              direct specification-to-code matching, the proposed approach progressively narrows the search space
                                              through repository-level structure inference, file-level relevance estimation, and fine-grained symbol-
                                              level alignment. The method extends beyond function-centric mapping by explicitly covering macros,
                                              structs, constants, configuration parameters, and register definitions commonly found in systems-level
                                              C/C++ codebases. We evaluate the approach on multiple open-source embedded systems repositories
                                              using manually curated datasheet-to-code ground truth. Experimental results show substantial im-
                                              provements over traditional information-retrieval-based baselines, achieving up to 73.3% file mapping
                                              accuracy. The hierarchical decomposition significantly reduces computational overhead, lowering total
                                              LLM token consumption by 84% and end-to-end runtime by approximately 80%. This methodology
                                              supports automated analysis of large embedded software systems and enables downstream applications
                                              such as training data generation for systems-aware machine learning models, standards compliance
                                              verification, and large-scale specification coverage analysis.



                                         1    Introduction
                                         Modern systems engineering faces a critical challenge in establishing precise mapping between embedded
                                         systems datasheets and their code implementations. This problem is particularly acute in embedded
                                         systems, IoT devices, and standards-compliant implementations where understanding the relationship
                                         between datasheet specifications and actual code becomes essential for maintenance, verification, and
                                         development processes. The complexity of this challenge has grown significantly as embedded systems
                                         become more sophisticated and datasheet documents become more detailed.
                                             Consider a typical embedded systems project implementing communication protocols from hardware
                                         datasheets. The datasheet specification may contain hundreds of sections describing protocols, interfaces,
                                         data structures, and behavioral requirements. The corresponding implementation spans thousands of files
                                         across complex directory hierarchies in GitHub repositories, making manual datasheet-to-code mapping
                                         virtually impossible to maintain accurately over time. This disconnect between datasheet specification and
                                         implementation creates significant challenges for code understanding, embedded systems maintenance, and
                                         development team knowledge transfer.

SpecMap 2

1.1 Problem Statement and Formal Definition Definition 1
(Datasheet-to-Code Mapping Problem): Given a datasheet document S
consisting of sections S = {s1 , s2 , ..., sn } and a code repository R
containing folders F = {f1 , f2 , ..., fm }, files F iles = {f ile1 , f
ile2 , ..., f ilek }, and code symbols E = {e1 , e2 , ..., el }, the
datasheet-to-code mapping problem seeks to establish a function M : S →
P(E) that maps each datasheet section to a subset of relevant code
symbols, where P(E) denotes the power set of E.

Definition 2 (Hierarchical Mapping): A hierarchical mapping is a
composition of functions M = M4 ◦ M3 ◦ M2 ◦ M1 where: • M1 : S → P(F )
maps datasheet sections to relevant folders

• M2 : S × P(F ) → P(F iles) maps sections and folders to relevant files

• M3 : S × P(F iles) → P(E) maps sections and files to code symbols

• M4 : S × P(E) → P(E) × Status validates mapping and determines
implementation status Definition 3 (Code Symbol Types): Code symbols e ∈
E are categorized into types T = {f unctions, macros, structs,
constants, enums, typedef s}, where each element e has an associated
type type(e) ∈ T . The datasheet-to-code mapping problem manifests
across multiple dimensions that existing approaches fail to address
adequately: Scale and Hierarchical Relationships: The mapping problem is
inherently hierarchical, requiring analysis at multiple levels of
granularity - from datasheet sections to repository folders, to
implementation files, to specific code symbols. This hierarchical nature
demands systematic decomposition rather than direct mapping approaches.
Diverse Code Artifacts: Embedded systems implementation involves various
code artifacts beyond simple functions: configuration parameters and
constants, data structure definitions (structs, typedefs, enums),
preprocessor macros and compile-time definitions, protocol message
formats and state machines, and hardware abstraction interfaces.
Traditional function-focused approaches miss critical implementation
components in systems-level programming. Dynamic Evolution: Embedded
systems repositories continuously evolve with new features, bug fixes,
and refactoring. Manual mapping quickly becomes outdated, requiring
automated approaches that can track not just what is implemented, but
also what is missing or partially implemented relative to datasheet
specifications.

1.2 Limitations of Existing Approaches Current datasheet-to-code mapping
approaches suffer from fundamental limitations:

• Manual Processes: Traditional approaches rely on expert analysis,
which is time-consuming, error-prone, and does not scale to large
embedded systems codebases

• Limited Scope: Most tools focus on function-level mapping, overlooking
macros, constants, and data structures critical to datasheet
specification implementation

• Lack of Context: Simple keyword matching fails to capture semantic
relationships between datasheet requirements and code implementations

• No Gap Analysis: Existing tools identify what exists but not what is
missing relative to datasheet specifications SpecMap 3

The remainder of this paper is organized as follows: Section 2 reviews
related work, Section 3 presents the baseline approaches evaluated,
Section 4 describes the proposed methodology, Section 5 presents
experimental results, Section 6 discusses applications, and Section 7
concludes with future directions.

2 Related Work The problem of establishing mapping between software
specifications and implementations has been ex- tensively studied in
software engineering research, particularly in the area of Traceability
Link Recovery (TLR). This section reviews existing approaches and
positions the proposed methodology within the broader context of
automated code understanding and specification-to-code mapping.
Traditional code understanding research has focused on establishing
relationships between different software artifacts throughout the
development lifecycle. Early foundational work identified the chal-
lenges of maintaining links between requirements and implementation
artifacts, laying the groundwork for automated code mapping approaches.
Subsequent work explored automated mapping recovery using information
retrieval techniques, demonstrating the potential for automated
approaches but highlighting limitations in precision and recall.
Information retrieval (IR) techniques have been widely applied to
traceability link recovery and code mapping tasks. Vector Space Models
(VSM) and Latent Semantic Indexing (LSI) have been used to establish
semantic links between requirements and code. More recent work has
explored the use of topic modeling techniques such as Latent Dirichlet
Allocation (LDA) for code mapping. However, recent research by Wang et
al. \[1\] has shown that traditional textual similarity approaches for
TLR have reached their limits, demonstrating that purely text-based
methods are insufficient for accurate traceability link recovery. Their
comprehensive analysis reveals that LLM-based approaches can
significantly outperform traditional textual similarity methods, provide
empirical evidence supporting the use of LLMs. Building on this insight,
hybrid approaches combining information retrieval and machine learning
have emerged as promising solutions. Guo et al. \[2\] proposed a hybrid
method that integrates information retrieval techniques with machine
learning for improved traceability link recovery, demonstrating better
performance than purely IR-based approaches. However, these approaches
typically focus on high-level document similarity rather than the
fine-grained, hierarchical mapping required for precise specification-
to-code understanding. Static analysis tools have long been used for
code understanding and analysis. Tools like commercial static analysis
platforms, Doxygen \[3\], and various AST-based analyzers provide
structural information about codebases. However, these tools typically
lack the semantic understanding necessary to map natural language
specifications to code implementations. Recent work has explored
combining static analysis with natural language processing for improved
code understanding. The application of machine learning techniques to
software engineering problems has gained significant attention. Deep
learning models have been applied to code summarization, code
generation, and bug detection. However, the specific problem of
hierarchical specification-to-code mapping has received limited
attention in the machine learning literature. The evolution of neural
language models has significantly advanced code understanding
capabilities. Early transformer-based models like CodeBERT \[4\] and
GraphCodeBERT \[5\] established the foundation, while recent large
language models \[6\] have demonstrated even stronger performance on
code understanding tasks. The findings by Wang et al. \[1\] show that
LLM-based approaches significantly outperform traditional textual
similarity methods for TLR provide strong empirical support for
leveraging LLMs in specification- to-code mapping tasks. However, the
application of LLMs to hierarchical specification-to-code mapping with
comprehensive code coverage remains largely unexplored. While existing
research has advanced traceability link recovery and code understanding,
key gaps re- SpecMap 4

main. Most approaches attempt direct mapping without considering
software hierarchy, focus only on functions rather than diverse code
artifacts, and lack systematic gap identification. Our methodology ad-
dresses these limitations through a hierarchical approach that leverages
LLMs for semantic understanding while maintaining comprehensive code
coverage.

3 Baseline Approaches and Comparative Analysis This section presents the
baseline approaches evaluated to establish performance benchmarks and
identify limitations that motivated the development of the proposed
hierarchical methodology. The evaluation process involved iterative
improvements: starting with external grep-based tools, developing an
improved BM25 + vector embeddings approach, and finally creating the
hierarchical methodology presented in this work.

3.1 Traditional Text-Based Search Methods Traditional text-based search
methods represent the most straightforward approach to specification-to-
code mapping, utilizing grep implementation (mgrep \[7\]) to locate
specification-relevant code through direct keyword matching. The
technical implementation involves manual extraction of key terms from
specification sections, followed by pattern matching across repository
files using optimized grep variants. The system processes results by
selecting top-K matches per query with file:line-range extraction and
automated retrieval of matching code blocks from identified locations.
This approach offers significant advantages in terms of fast execution
speed, simple implementation requirements, and minimal compu- tational
overhead, making it particularly effective for direct keyword matching
scenarios where obvious correspondences exist between specification
terminology and code identifiers. However, the fundamental limitations
of purely syntactic matching without semantic understanding severely
constrain the effectiveness of traditional text-based methods. The
approach lacks hierarchical organization capabilities and fails to
consider contextual relationships within software architecture, result-
ing in high false positive rates due to keyword ambiguity. When
specification terms appear in multiple contexts throughout a codebase,
grep-based methods cannot distinguish between functionally relevant
matches and coincidental keyword occurrences, leading to mappings that
are syntactically correct but semantically inappropriate for the
intended specification requirements.

3.2 BM25 + Vector Embeddings Approach To address the semantic
limitations of traditional grep methods, an improved baseline approach
was de- veloped using a hybrid scoring system that combines BM25 \[8\]
keyword matching with semantic vector embeddings \[9\] to map
documentation chunks directly to code symbols. The technical
architecture employs a sophisticated multi-stage pipeline beginning with
PDF processing tools for converting specifications to clean markdown
through HTML intermediation, followed by semantic chunking using sliding
window em- beddings with change-point detection to identify coherent
document segments. Code analysis is performed through LSP server
integration, which leverages language server protocol \[10\]
capabilities to extract com- prehensive symbol definitions including
functions, classes, and types with their associated source code context.
The system utilizes a dual-storage architecture combining LanceDB \[11\]
for vector-based seman- tic search operations and Kuzu graph database
\[12\] for maintaining symbol relationship information, while BM25
indexes provide efficient keyword-based pre-filtering capabilities. The
approach employs a weighted combination of keyword relevance and
semantic similarity scores that integrates multiple similarity signals
through a computationally efficient search strategy. The seman- tic
chunking process utilizes sliding window embeddings to create coherent
document segments, applying SpecMap 5

change-point detection algorithms to identify natural boundaries in
specification content. Symbol repre- sentation employs embedding models
including e5-large-v2 \[13\] (1024-dimensional) with L2 normalization
for cosine similarity calculations. The hybrid scoring system combines
BM25 keyword relevance with keyword overlap similarity and vector
similarity using Jaccard coefficients. The search strategy imple- ments
a two-stage filtering approach: BM25 pre-filtering identifies the top
200 candidate symbols based on keyword relevance, followed by vector
search refinement to select the final top 50 results, significantly
reducing computational overhead while maintaining search quality. This
hybrid approach demonstrates significant improvements over traditional
grep methods through its effective multi-modal analysis capabilities,
scalable pre-filtering mechanisms, and enhanced semantic un- derstanding
of code-specification relationships. The integration of vector
embeddings enables the system to capture semantic similarities that
extend beyond exact keyword matches, while the BM25 component en- sures
that relevant terminology is appropriately weighted in the matching
process. The two-stage filtering strategy provides computational
efficiency by reducing the search space before expensive vector
operations, while batch processing and caching mechanisms for BM25
indexes enable scalable deployment across large repositories. The
flexible scoring system architecture allows for domain-specific weight
adjustments, and the comprehensive metadata storage supports rich
contextual analysis of matching results. Despite these advances, the
BM25 + embeddings approach has fundamental limitations. Vector av-
eraging dilutes semantic coherence when multiple technical concepts are
combined into single chunks, causing the averaged representation to lose
precise meaning and produce topically related but functionally
inappropriate matches. Meanwhile, BM25 keyword matching fails to capture
semantic relationships and contextual nuances, making it unable to
distinguish between similar terms used in different functional contexts.
The approach's primary weakness is its inability to leverage software
repository structure, where folder organization and architectural layers
provide crucial mapping context. While it improves semantic under-
standing over grep methods, it treats all code symbols as equivalent
entities, ignoring their position within the architecture hierarchy.
This becomes problematic in complex scenarios where component
relationships are essential for identifying correct implementations at
appropriate abstraction levels, resulting in matches that are
semantically related but architecturally inappropriate.

3.3 Example Results Comparison To illustrate the differences between
baseline approaches and the hierarchical methodology, this section
presents example results from the same specification query:
"Introduction / Initialization" (Section 1) with query terms "NCI
interface DH NFCC NFCEE logical connection RF interface".

Source Repository: NXP NFC Linux Implementation \[14\]

Expected Output: src/service, src/halimpl → service/nfc_service.c,
halimpl/phTmlNfc_i2c.c → nfcService_Init(), phTmlNfc_I2COpen()

3.3.1 mgrep Results Analysis Expected: System initialization functions
in service layer Found: Runtime notification handling in HAL extension
layer The mgrep approach demonstrates fundamental limitations in
distinguishing between functionally dif- ferent code contexts despite
keyword similarity. While the method was expected to identify
initialization functions such as nfcService_Init() within service layer
components, it instead located runtime logic functions like
phNxpNciHal_NfcDep_rsp_ext() in HAL extension code. This represents a
critical layer SpecMap 6

mismatch where service layer components were expected but Hardware
Abstraction Layer extension code was found, along with a behavioral
context mismatch between expected startup/initialization behavior and
actual P2P priority logic and RF interface detection during runtime. The
file location discrepancy further illustrates this issue, with the
expected service/nfc_service.c replaced by halimpl/pn54x/hal/
phNxpNciHal_ext.c. The root cause of these failures lies in keyword
matching without semantic under- standing of functional requirements,
leading to identification of code containing relevant terms but serving
entirely different purposes within the system architecture.

3.3.2 BM25 + Vector Embeddings Results Analysis Expected: High-level
service initialization functions Found: Low-level I2C hardware
configuration functions The BM25 + vector embeddings approach, while
demonstrating improved semantic understanding over grep methods, still
exhibits significant abstraction level mismatches that highlight the
limitations of direct chunk-to-symbol mapping strategies. The method was
expected to identify service-level APIs such as nfcService_Init() but
instead located hardware-level configuration functions like
phTmlNfc_i2c_open\_ and_configure(), representing a fundamental
abstraction level disconnect. The functional scope diverged from
expected comprehensive system initialization to specific I2C bus setup
and pin configuration, while the component layer shifted from the
intended service layer to Transport Mapping Layer (TML) com- ponents.
The implementation focus similarly deviated from expected behavioral
initialization logic to hardware interface setup and device reset
sequences. This pattern of results demonstrates that while semantic
understanding improved over grep methods, the direct chunk-to-symbol
mapping approach still lacked sufficient hierarchical context to
distinguish between different abstraction levels within the software
architecture, leading to technically accurate but functionally
inappropriate mapping.

3.3.3 Hierarchical Methodology Results Analysis Expected: src/service,
src/halimpl → service/nfc_service.c, halimpl/phTmlNfc_i2c.c →
nfcService_Init(), phTmlNfc_I2COpen() Found: src/service, src/halimpl →
service/nfc_service.c, halimpl/phTmlNfc_i2c.c → nfcService_Init(),
phTmlNfc_I2COpen() The hierarchical methodology demonstrates strong
accuracy across most levels of the specification-to- code mapping
process, achieving close alignment between expected and found results
with minor varia- tions. The approach correctly identified both service
and hardware implementation folders, demonstrating proper understanding
of the dual-layer architecture required for NFC initialization. The file
mapping pre- cision located the primary files containing initialization
logic at appropriate abstraction levels, specifically
service/nfc_service.c for high-level service coordination and
halimpl/phTmlNfc_i2c.c for hardware abstraction layer implementation,
though some secondary initialization functions were found in related
files within the same architectural layers. At the function level, the
methodology successfully identified the core initialization functions
nfcService_Init() and phTmlNfc_I2COpen(), along with some addi- tional
initialization-related functions that provide supporting functionality
for the specified requirements. The hierarchical approach maintained
understanding of system architecture from service layer to hard- ware
abstraction, preserving the contextual relationships that enable
accurate mapping across multiple architectural levels, with minor drift
occurring in the selection of specific supporting functions within the
correct architectural context. SpecMap 7

3.3.4 Comparative Analysis Drift Score Definition: The drift score
measures how far the mapped results deviate from the expected structure
across multiple levels: folder organization, file selection, and
function type appropriateness. A score of 0.0 indicates perfect
alignment with expected results, while higher scores indicate greater
structural deviation from the target mapping. The drift score quantifies
the distance between expected and actual mapping across folder
structure, file selection, and functional appropriateness.

      Method                   Layer Match        Function Type        Drift Score     Expected Match
      mgrep                   HAL Extension        Runtime Logic            2.5                 ×
      BM25 + Embeddings       Transport Layer     Hardware Config           1.5                 ×
      Hierarchical            Service + HAL         Initialization          0.3                 ✓

               Table 1: Code-level comparison of baseline method results with mapping drift scores

    Key Insights: Baseline methods consistently found semantically related code but at wrong abstrac-

tion levels or functional contexts, resulting in significant mapping
drift from expected results. The mgrep approach found keyword matches in
runtime logic rather than initialization code, achieving a drift score
of 2.5 due to incorrect file location, function type, and architectural
layer mismatches. The BM25 approach improved semantic understanding but
focused on hardware configuration rather than service initializa- tion,
resulting in a drift score of 1.5 with better architectural proximity
but still incorrect functional context. The hierarchical approach
successfully navigated from specification intent to implementation
through systematic decomposition, achieving minimal drift (0.3) with
minor variations in specific function selection while maintaining proper
context across software architecture layers. The drift metric provides a
measurable assessment of mapping accuracy beyond simple binary
success/failure evaluation.

4 Proposed Methodology This section presents the hierarchical mapping
methodology that systematically decomposes the specification- to-code
mapping problem into manageable, sequential phases. Each step operates
at a different level of granularity, enabling precise and scalable
analysis while leveraging the natural organization of software
repositories. The methodology is implemented as a deterministic,
multi-stage analysis pipeline, where each stage restricts the search
space for subsequent stages.

4.1 Methodology Overview The proposed approach addresses the limitations
identified in existing methods through a hierarchical decomposition
strategy. The methodology consists of four sequential steps:

    1. Folder Discovery: Mapping specification sections to relevant repository folders

    2. File Discovery: Identifying specific files within relevant folders

    3. Code Symbol Discovery: Extracting specific code symbols from relevant files

    4. Validation & Gap Analysis: Validating mapping and identifying implementation gaps

This decomposition enables the system to leverage repository structure
and organization for improved accuracy while maintaining comprehensive
coverage of all code artifacts. SpecMap 8

Algorithm 1 Hierarchical Specification-to-Code Mapping Require:
Specification S = {s1 , s2 , ..., sn }, Repository R Ensure: Mapping M :
S → P(E), Status assessments 1: Generate repository structure
documentation DR 2: for each section si ∈ S (parallel execution) do 3:
Fi ← FolderDiscovery(si , DR ) 4: F ilesi ← FileDiscovery(si , Fi ) 5:
Ei ← CodeElementDiscovery(si , F ilesi ) 6: end for 7: for each section
si ∈ S (sequential execution) do 8: (Ei′ , statusi ) ← Validate(si , Ei
, contexti−1 ) 9: M (si ) ← Ei′ 10: end for 11: return M , {status1 ,
status2 , ..., statusn }

4.2 Step 1: Folder Discovery Objective: Identify which folders in the
repository are likely to contain implementations relevant to each
specification section.

Formal Definition: Given a specification section si and repository
structure documentation DR , the folder discovery function is defined
as: M1 (si , DR ) = {fj ∈ F : similarity(si , desc(fj )) \> θ1 } (1)
where desc(fj ) represents the generated description of folder fj and θ1
is the similarity threshold.

Key Techniques: • Adaptive Chunking: Dynamic processing of large
repositories with parallel chunk analysis • Parent-Child Filtering:
Automatic removal of redundant folder relationships, preferring most
specific folders • Refinement Selection: Final filtering step to select
most relevant folders from multiple candidates

4.3 Step 2: File Discovery Objective: Within identified folders,
determine which specific files contain relevant implementations.

Formal Definition: Given a specification section si and relevant folders
Fi = M1 (si , DR ), the file discovery function is: M2 (si , Fi ) = {f
ilek ∈ F iles : f ilek ∈ f older(Fi ) ∧ relevance(si , f ilek ) \> θ2 }
(2) where f older(Fi ) returns all files within folders Fi and θ2 is the
relevance threshold.

Implementation: The system employs on-demand structure generation to
create comprehensive file documentation. For each relevant folder,
LLM-based analysis using models such as Gemini 2.5 Flash \[15\]
generates folder_structure.md files containing detailed descriptions of
each file's purpose and functional- ity. A caching mechanism avoids
regenerating existing structure files, while thread-safe processing
handles concurrent folder analysis efficiently. SpecMap 9

4.4 Step 3: Code Symbol Discovery Objective: Within relevant files,
identify specific code symbols (functions, macros, structs, constants)
that implement specification requirements.

Formal Definition: Given a specification section si and relevant files F
ilesi = M2 (si , Fi ), the code symbol discovery function is: M3 (si , F
ilesi ) = {ej ∈ E : ej ∈ elements(F ilesi ) ∧ semantic_match(si , ej )
\> θ3 } (3) where elements(F ilesi ) extracts all code symbols from
files F ilesi using static analysis, and semantic_match evaluates
semantic relevance.

Implementation: The system integrates Universal Ctags \[16\] for
reliable parsing of C/C++ code symbols, extracting functions, macros,
structs, constants, and enums with precise line number infor- mation.
The current implementation focuses on C/C++ codebases, leveraging
language-specific pars- ing capabilities for optimal accuracy. Automated
code summarization generates compact representa- tions preserving key
elements while significantly reducing token usage. Thread-safe
generation creates {filename}\_{ext}\_structure.md files with caching to
avoid redundant processing of previously analyzed files.

4.5 Step 4: Validation & Gap Analysis Objective: Validate the complete
mapping, determine implementation status, and identify gaps.

Formal Definition: The validation function processes mapping
sequentially to maintain context: M4 (si , Ei , contexti−1 ) = (Ei′ ,
statusi ) (4) where Ei′ ⊆ Ei represents the refined set of code symbols
and statusi represents the implementation status: statusi ∈
{Implemented, P artially_Implemented, N ot_Implemented, N ot_Applicable}
(5)

Figure 1: Flow diagram illustrating the hierarchical mapping process for
a single specification section, showing the systematic progression from
specification analysis through folder discovery, file identification,
and code symbol extraction to final validation.

5 Experimental Evaluation This section presents a comprehensive
evaluation of the proposed methodology through comparison with baseline
approaches. The evaluation demonstrates the progressive improvements
achieved through iterative development and provides empirical evidence
for the design decisions made throughout the development process.
SpecMap 10

                              Table 2: Comprehensive Performance Comparison

Method Confidence Elements Runtime Tokens File Exist. File Map. (%) per
Section (min) (M) (%) Acc. (%) mgrep N/A N/A N/A N/A 100.0 0.0 BM25 N/A
N/A N/A N/A 100.0 0.0 Gemini∗ 89.5 19.0 90 68.8 92.7 53.3 Gemini∗ +
H2LooP Toolchain (Structures) 90.4 15.9 21 49.0 93.3 63.3 Gemini∗ +
H2LooP Toolchain (Structures + Ctags) 90.1 16.4 24 17.7 95.3 56.7
Qwen3∗∗ + H2LooP Toolchain (Structures + Ctags) 84.1 11.6 10 3.2 96.3
66.7 Proposed (Full) 83.1 9.1 18 10.9 95.9 73.3

∗ Gemini 2.5 Flash ∗∗ Qwen3-Coder-30B-A3B-Instruct-FP8

5.1 Experimental Setup and Evaluation Metrics Dataset: The evaluation
was conducted on 154-156 specification sections across multiple embedded
sys- tems protocol repositories. The dataset was selected to represent
diverse specification types and imple- mentation patterns commonly found
in embedded systems development. Evaluation Metrics: Six primary metrics
were used to assess methodology performance:

      • Confidence Score: Average LLM-assigned confidence for mapped elements (0-1 scale)

      • Code Symbol Coverage: Average number of code symbols mapped per specification section

      • Runtime Performance: Total processing time in minutes for all specification sections

      • Token Consumption: Total number of LLM tokens consumed during mapping

      • File Existence Accuracy: Percentage of mapped files that actually exist in the repository

      • File Mapping Accuracy: Percentage of desired files correctly mapped for each section

5.2 Experimental Results The experimental evaluation demonstrates
significant improvements across all metrics. Table 2 summa- rizes the
performance comparison across seven approaches including baseline
methods, while the detailed performance trends are shown across all
evaluation metrics in the accompanying figures.

5.3 Discussion of Results Statistical vs. Semantic Approaches: The
baseline statistical approaches (mgrep, BM25) demon- strate perfect file
existence accuracy (100%) as they only reference files that actually
exist in the reposi- tory. However, they achieve zero file mapping
accuracy (0%) because they map semantically related but functionally
incorrect files. This highlights the fundamental limitation of
keyword-based and statistical similarity approaches. Structural Context
and Code Parsing: The addition of repository, folder and file level
structures (Iteration 2) provided the most significant runtime
improvement (76.7% reduction) by giving LLMs es- sential context for
accurate folder and file identification, eliminating exploratory
analysis. This improved file mapping accuracy from 53.3% to 63.3%, while
pre-validation confidence remained elevated at 90.4%. Ctags integration
(Iteration 3) resulted in the largest reduction in token consumption
(63.8% reduction) SpecMap 11

Figure 2: Runtime performance comparison showing processing efficiency
improvements through iterative method- ology development.

Figure 3: Token consumption comparison illustrating computational cost
optimization achieved by the proposed methodology.

through compact code representation, while maintaining mapping accuracy
through reliable code symbol extraction. However, pre-validation
confidence remained high at 90.1%, indicating potential calibration
issues. Model Selection Optimization: The transition to
Qwen3-Coder-30B-A3B-Instruct-FP8 (Iteration 4) achieved the lowest token
consumption among evaluated configurations with 81.9% token reduction
and 58.3% runtime improvement, demonstrating the value of
domain-specific, self-hosted models for code SpecMap 12

Figure 4: File mapping accuracy comparison showing the percentage of
desired files that were correctly mapped. Statistical approaches (mgrep,
BM25) achieve perfect file existence but zero mapping accuracy, while
the hierarchical approach demonstrates progressive improvement.

analysis tasks. This significant token reduction is partly attributed to
switching from Gemini 2.5 Flash, which is a thinking model that involves
internal reasoning processes, to Qwen3. File mapping accuracy improved
to 66.7% while maintaining high file existence accuracy (96.3%). This
iteration showed improved confidence calibration with a pre-validation
confidence of 84.1%, closer to realistic levels compared to earlier
Gemini-based approaches. Validation Quality Enhancement: Sequential
validation (Iteration 5) introduces controlled over- head (80% runtime
increase from Iteration 4) but provides essential gap analysis and
implementation status assessment, transforming the system from discovery
to comprehensive analysis. This achieves the highest file mapping
accuracy (73.3%) while maintaining excellent file existence accuracy
(95.9%). The validation step improves confidence calibration, with the
final methodology achieving a more realistic confidence score of 83.1%
compared to pre-validation confidence levels that exhibited inflated
estimates (89.5-90.4% for Gemini-based approaches, 84.1% for Qwen3).

5.4 Performance Summary The proposed methodology demonstrates
substantial improvements across all evaluation metrics, estab- lishing
its effectiveness for practical specification-to-code mapping
applications. The methodology achieves an average confidence score of
83.1% through rigorous validation processes, indicating high reliability
in generated mappings while maintaining comprehensive coverage with an
average of 9.1 precisely mapped code symbols per specification section.
The efficiency improvements are particularly noteworthy, with the
methodology achieving an 84% reduction in computational overhead,
decreasing token consumption from 68.8 million to 10.9 million tokens
compared to baseline approaches. Simultaneously, processing time is
reduced by 80%, from 90 minutes to 18 minutes, making the approach
viable for large-scale industrial applications. These efficiency gains
are achieved without compromising accuracy, as evidenced by the 95.9%
file existence accuracy and 73.3% file mapping accuracy that
significantly outperforms statistical approaches which achieve 0%
SpecMap 13

mapping accuracy despite perfect file existence scores.

6 Applications and Impact The proposed methodology addresses
specification-to-code traceability challenges across multiple domains in
software development and AI research. The systematic mapping between
specification requirements and code implementations creates
high-quality, structured datasets valuable for training code
understanding and generation models. These training pairs capture
semantic relationships between natural language descriptions and code
artifacts, enabling more accurate AI systems for automated code
analysis, docu- mentation generation, and specification-driven
development. With 83.1% confidence while maintaining broad coverage, the
approach provides a solid foundation for constructing training datasets
that advance code intelligence systems. Organizations developing
standards-compliant software can leverage this approach for systematic
veri- fication of specification coverage and regulatory compliance. The
gap analysis component identifies missing implementations, partial
coverage areas, and compliance gaps with precise granularity, supporting
crit- ical certification processes in automotive, aerospace, and medical
device industries where specification adherence is mandatory. The
methodology enables auditors and compliance teams to trace requirements
from high-level specifications down to specific code symbols, providing
clear evidence of implementation completeness. The mapping capability
provides a systematic method for understanding large, complex codebases
through their specification requirements, addressing significant
challenges in software maintenance and evolution. This proves
particularly valuable for legacy system analysis where original
documentation may be incomplete, enabling development teams to
reconstruct relationships between intended functionality and actual
implementation. The approach supports knowledge transfer by creating
comprehensive map- pings that help new team members understand system
architecture and implementation patterns, while enhancing code review
processes by providing specification context for changes.

7 Conclusion and Future Work This work advances automated
specification-to-code mapping through a decomposition approach that
systematically maps from specifications to folders, files, and code
symbols. The proposed methodology demonstrates significant improvements
in both accuracy and efficiency over existing approaches, achieving high
confidence while reducing computational overhead and processing time.
Key innovations include multi-level decomposition for precise analysis
and comprehensive code coverage extending beyond functions to include
macros, structs, constants, and configuration parameters. Experimental
evaluation across multiple embedded systems repositories shows
substantial improve- ments in mapping accuracy and computational
efficiency compared to baseline methods. The method- ology processes
specification sections with precisely mapped code symbols while
maintaining excellent file existence accuracy, providing a practical
solution for automated specification-to-code understanding. The
integration of LLM-based semantic analysis with automated structure
generation creates a robust framework that respects software
architecture principles while delivering precise results. Future
research directions include integration with development workflows for
real-time compliance monitoring within continuous integration pipelines,
enabling automated specification adherence verifica- tion during
development. The generated mapping datasets provide valuable training
data for specialized machine learning models, potentially leading to
more sophisticated understanding systems that combine structural
decomposition benefits with learned patterns from large-scale mapping
examples. SpecMap 14

    The methodology represents a significant advancement in automated software analysis, providing a scal-

able and practical solution for establishing traceability between
specifications and implementations. The approach demonstrates that
systematic decomposition combined with LLM-based semantic understand-
ing can overcome traditional text-based mapping limitations, enabling
effective analysis of specification- implementation relationships in
complex software systems.

References \[1\] Jinfeng Wang, Zhongxin Li, Xin Zeng, et
al. Traceability link recovery: How far are we? arXiv preprint
arXiv:2509.05585, 2024. Available at: https://arxiv.org/abs/2509.05585.

\[2\] Jin Guo, Jinghui Cheng, and Jane Cleland-Huang. Information
retrieval and machine learning hybrid method for traceability link
recovery. Information, 14(5):270, 2023. Available at: https://www.mdpi.
com/2078-2489/14/5/270.

\[3\] Dimitri van Heesch. Doxygen: Generate documentation from source
code. https://www.doxygen. nl/, 2024. Documentation generation tool.

\[4\] Zhangyin Feng, Daya Guo, Duyu Tang, Nan Duan, Xiaocheng Feng, Ming
Gong, Linjun Shou, Bing Qin, Ting Liu, Daxin Jiang, et al. Codebert: A
pre-trained model for programming and natural languages. In Findings of
the Association for Computational Linguistics: EMNLP 2020, pages 1536--
1547, 2020.

\[5\] Daya Guo, Shuo Ren, Shuai Lu, Zhangyin Feng, Duyu Tang, Shujie
Liu, Long Zhou, Nan Duan, Alexey Svyatkovskiy, Shengyu Fu, et
al. Graphcodebert: Pre-training code representations with data flow. In
International Conference on Learning Representations, 2021.

\[6\] Mark Chen, Jerry Tworek, Heewoo Jun, Qiming Yuan, Henrique Ponde
de Oliveira Pinto, Jared Ka- plan, Harri Edwards, Yuri Burda, Nicholas
Joseph, Greg Brockman, et al. Evaluating large language models trained
on code. arXiv preprint arXiv:2107.03374, 2021.

\[7\] Mixedbread AI. mgrep: A fast multi-pattern string search tool.
https://github.com/ mixedbread-ai/mgrep, 2024. High-performance grep
implementation.

\[8\] Stephen Robertson and Hugo Zaragoza. The probabilistic relevance
framework: Bm25 and beyond. Foundations and Trends in Information
Retrieval, 3(4):333--389, 2009.

\[9\] Tomas Mikolov, Kai Chen, Greg Corrado, and Jeffrey Dean. Efficient
estimation of word representa- tions in vector space. arXiv preprint
arXiv:1301.3781, 2013.

\[10\] Microsoft Corporation. Language server protocol.
https://microsoft.github.io/ language-server-protocol/, 2024. Official
Language Server Protocol Specification.

\[11\] LanceDB Team. Lancedb vector database recipes.
https://github.com/lancedb/ vectordb-recipes, 2024. Implementation
examples and documentation.

\[12\] Kuzu Team. Kuzu: An embedded graph database. https://kuzudb.com/,
2024. Graph database management system.

\[13\] Liang Wang, Nan Yang, Xiaolong Huang, et al. E5-large-v2: Text
embeddings by weakly-supervised contrastive pre-training.
https://huggingface.co/intfloat/e5-large-v2, 2022. Hugging Face Model
Repository. SpecMap 15

\[14\] NXP Semiconductors. Nxp nfc linux implementation.
https://github.com/NXPNFCLinux/linux\_ libnfc-nci, 2024. Apache License
2.0.

\[15\] Gemini Team. Gemini 2.5: Pushing the frontier with advanced
reasoning, multimodality, long context, and next generation agentic
capabilities. arXiv preprint arXiv:2507.06261, 2024. Google DeepMind.

\[16\] Universal Ctags Team. Universal ctags: A maintained ctags
implementation. https://github.com/ universal-ctags/ctags, 2024.
Accessed: 2024. 
