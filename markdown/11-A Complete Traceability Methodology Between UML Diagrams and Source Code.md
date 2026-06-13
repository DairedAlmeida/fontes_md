https://doi.org/10.31449/inf.v46i1.3306 Informatica 46 (2022) 27--47 27

A Complete Traceability Methodology Between UML Diagrams and Source Code
Based on Enriched Use Case Textual Description Wiem Khlif, Dhikra Kchaou
and Nadia Bouassida E-mail: Wiem.khlif@gmail.com,
Dhikra.Kchaou@fsegs.rnu.tn, nadia.bouassida@isimsf.rnu.tn Sfax
University, Mir@cl Laboratory, Tunisia

Keywords: traceability, UML diagrams, use case, enriched textual
description, control structure.

Received: September 9, 2020

       Abstract: Traceability in software development proves its importance in many domains like change
       management, customer's requirements satisfaction, model slicing, etc. Existing traceability techniques
       trace either between requirement and design or between requirement and code. However, none of the
       existing approaches achieved reliable results when dealing with traceability between requirements,
       design models and source code. In this paper, we propose an improvement and an extension of our design
       traceability approach in order to tackle the traceability between design, requirement and code. The fine-
       tuning of our methodology stems from considering an expanded textual description. A pre-treatment step
       is added in order to divide the textual description of system functionalities into different parts, each of
       which represents a specific goal. In fact, the extension consists in extracting an expanded textual
       description from a natural language text in order to trace between related elements belonging to
       requirement, design and code while using an information retrieval technique. The proposed method is
       based on different scenarios (nominal, alternatives and errors), particularly on concepts related to control
       structures to establish the traceability between artefacts. Furthermore, we implemented our method in a
       tool allowing the evaluation of its performance. The evaluation is performed on real existing applications
       that consist in comparing results found by our approach with results found by experts. Our method
       achieves an average precision of 0.84 and a recall of 0.91 in traceability between requirement, design
       and code. Besides its promising performance outcomes, our automated method has the merit of generating
       a traceability report describing the correspondence between different artefacts.
       Povzetek: Prispevek opisuje novo metodo za sledenje povezavam med UML diagrami in izvirno kodo.


                                                              instance, in the context of change impact analysis, a

1 Introduction change in one iteration often leads to changes in the
following iterations. Certainly, the major challenge when Traceability
quality is defined as the degree to which developing a requirement
change consists in creating existing artefacts of a software development
project are traceability links between heterogeneous artefacts traceable
as mandated by the project's traceability produced at different
abstraction levels \[2\]. For example, stakeholders. The Unified
Modelling Language (UML) is adding data and actions in a use case (UC)
description used for specifying, constructing, and documenting these
leads to add the corresponding methods and attributes in artefacts. It
is composed of a set of diagrams grouping the class diagram and in the
code. In fact, tracing change structural and semantic dependencies
between UML inter-UML diagrams into the source code is crucial to
elements \[1\]. Based on the unified process, UML maintain the
consistency and coherence. However, diagrams are produced iteratively
and incrementally from creating accurate and complete traceability is
costly and use case diagram (UCD) to code. An iteration generates a
remains a practical challenge \[2\]. In fact, we focus in this baseline
that comprises a partially complete version of the paper on determining
traceability by considering final system. Each one results in an
increment, which is a structural and behavioural aspects. Furthermore,
it is release of the system that contains added or improved crucial to
keep traceability between UML models since it functionality compared
with the previous release. Each allows checking the conformance between
safety iteration goes through five activities that specify what
requirements and design decisions through model slicing. needs to be
done: requirements, analysis, design, Thus, traceability definition is
used to extract design slices implementation and test. Requirements are
modelled by that filter out irrelevant design details and keep (UCD) and
their textual descriptions while the design is information to inspect
compliance between requirements modelled through UML diagrams (class,
sequence, etc.). and design \[3, 4\]. The recent literature on
traceability These diagrams are strongly related either within one shows
two trends of approaches: those centred on iteration or between
iterations and consequently the lack traceability inter-UML models \[4,
5, 6, 7, 8, 9\], and those of traceability between them makes any change
difficult based on traceability from requirement and design to code and
expensive. Determining and keeping traceability \[10, 11, 12, 13, 14,
15\]. The first type of approaches between UML models is important for
many reasons. For 28 Informatica 46 (2022) 27--47 W. Khlif et al.

tackles the traceability within a set of models elements, functionality
(use case). After that, each part is specified particularly from
requirements modelled by a UCD to by using an enriched template that
encapsulates the design diagrams \[6\]. For instance, \[16\] deals with
semantic information pertinent to the functional and traceability
between software architectural models and behavioural aspects. In this
work, we enrich the used extra-functional results such as performance
and security. textual description template \[6\] by basic control
structures Kchaou et al., \[6\] present traces between requirements
(BCS) (loop, if, switch, etc.) and a set of key words (e.g. modeled by a
UCD and UML design diagrams. On the PARALLEL expressing how activities
are carried out) other hand, \[4\] illustrates the traceability between
Use which take into account many important concepts in the Case Maps and
UML diagrams and \[8\] identifies the design and code. This template is
used for the traceability between requirement and design models
requirements specification as a mean to document a UC. modeled with
SysML. The second type of traceability Compared to the presented
template in \[6\], the enriched approaches defines links between
different models one provides more comprehensive traceability. For
(requirements, design, test cases, etc.) and source code. instance, in
\[6\], the proposed approach does not determine These works differ in
terms of the used techniques. These which UC corresponds to which
function in the code. In traceability approaches use exclusively either
information addition, it does not focus on details in alternative
retrieval techniques \[17, 18, 19\], a meta-model \[20\], behavioural
elements such as control structures. The Natural Language Processing
(NLP) techniques \[21\] or second phase of our method "Traceability
process inter- machine learning techniques \[22\]. However, none of the
UML diagrams" is composed of traceability rules existing approaches
deals with traceability between identification and similarity
calculation. Traceability rules requirements, design models and source
code by covering detect the relationships between requirements and
design all the concepts that can be determined in all levels models.
They distinguish between two traceability levels: (control structures,
how activities are carried out, etc). structural and semantic.
Structural traceability determines That is, the so-far proposed
approaches neglect additional structural relationships between UML
diagrams. Semantic semantic and/or structural information that can be
traceability, which discriminates our method, is useful by extracted.
The lack of this information may reduce the considering that use case
diagrams and their textual scope of possible analyses that can be made
and possible descriptions are based on a well-structured text. It
searches traceability links that may be found. In addition, in the the
meaning of words contained in these descriptions and literature,
traceability from requirement and design to the their synonyms to find
similarities with terms used in the source code is based generally on
the class diagram, which rest of UML diagrams. We note that the semantic
does not produce all necessary information such as control traceability
between the enriched textual description structure. Consequently, class
diagrams allow engineers to associated to a UC and other diagrams is
based on an understand its structure but it does not show the behavior
information retrieval technique. More specifically, it uses of the
software \[5\]. To understand its behaviour, dynamic the Latent Semantic
Indexing (LSI) similarity measure to models are needed, such as
sequence, activity or state estimate the similarity between
corresponding elements. transitions diagrams \[1\]. Moreover, while the
existing The choice of this measure is based on evaluations approaches
use a semantic technique to compute presented in \[6\] which showed that
LSI is better suited to similarities between different artifacts based
on specific measure the semantic similarity. In its third phase, our and
common terms (e.g., actors, actions, etc), they do not method determines
the traceability from requirement and cover all kinds of terms like
behavioral elements (Parallel, design to code. It allows keeping
traceability links from alternative, loop, etc.), type of result,
functional call, etc. requirements into design and code by adding
implementation details. To do so, it uses the traceability In this
paper, we first show how the approach, initially process from
requirement to code which applies the presented in \[6\], that traces
the elements of design defined traceability rules specific to details in
the source diagrams, can be improved, fine-tuned and automated in code
and calculates the similarity between the selected order to discover
correlated structural and semantic fragment in the textual description
of a UC and code. information and to trace between different UML To show
the advantages and limits of our method, we diagrams, and between these
diagrams and the source conduct an experimental evaluation thanks to
TRADIAC code. So, we have improved our previous work by (TRAceability
for UML DIAgrams and Code) tool, which defining an Enriched Textual
Description (ETD) of a UC. implements all of the method phases. For the
herein The latter is extracted from a text written in a natural
presented evaluation, we applied a set of measurements language and
describing a software. In addition, the (precision, recall, F-measure)
to examine the conformity defined ETD allows tracing between the design
and code. degree between corresponded elements generated by our Unlike
existing works (e.g. \[4, 8, 21\], we propose a method with the
corresponded elements where traceability method called TRADIAC Quality
(TRAceability for is evaluated by experts. This experimentation aims at
UML DIAgrams and Code) that proceeds in three phases: proving that these
models have similar quality values. For "Pre-processing Natural
language", "Traceability Inter- these quantitative evaluations, we used
two case studies UML diagrams" and "Traceability from requirement and
related to different domains. Our method shows an design to code". The
"Pre-processing" phase receives as average precision of 84,1%, and an
average recall of 91%. input the whole textual description of a software
written in The results showed the efficiency of our method in terms
natural language. Then, the textual description is split into of finding
correct traceability reports. parts that achieve a specific goal
expressing each one a A Complete Traceability Methodology Between UML
Diagrams and... Informatica 46 (2022) 27--47 29

     The remainder of this paper is organized as follows:        second phase, “Maintenance” consists on updating the

Section 2 overviews existing works that define traceability traceability
relations associated with the changed model relationships between
requirement and other diagrams, element. A prototype called Trace
Maintainer has been and from requirement and design to code. Section 3
implemented to evaluate the approach. presents our method in two
subsections: the first In \[32\], an approach is presented to specify
semantic subsection presents the pre-processing phase and the
relationships between system-level requirements, enriched textual
description to document use cases based functional specifications, and
architectures in terms of on basic control structures. The second
subsection is their subsystem specifications. This approach is based on
composed of two parts: the first one identifies the logic predicate to
present artifacts and their relations at traceability rules to
facilitate first the transition from the different abstraction levels
(Requirements, specification requirement to design level by deriving
other diagrams, and architecture). The logical representation of each
particularly dynamic diagrams, and then derive code. The artifact is
used by the authors to formalize relationships second part illustrates
the LSI similarity which determines between these artifacts.
traceability between UML diagrams. To show the Adopting an abstract
approach in defining traceability improvements gained by applying the
traceability rules, between software requirements and UML design, \[20\]
we evaluate in section 4 our method and we consider proposes FUTOR (From
Uml TO Requirement) guideline, threats to validity of the study and the
results. Section 5 which includes meta-model and process step. The meta-
presents the tool support and illustrates the method model expresses
relationships between requirements and through an example. Finally,
Section 6 summarizes the the UML model at the meta-level. For each meta-
presented work and outlines its extensions. requirement, the author adds
a "REQTYPE" attribute to decide which UML diagram shall be used for the
2 Related work traceability. Steps of the FUTOR guideline include: (1)
writing requirements (2) annotate the requirement (3) start Several
works cope with traceability based on different software design based on
requirements, (4) check the axes: covered artefacts (e.g. Horizontal
vs. vertical) \[17, traceability between requirements and UML models.
This 24, 25\] representing the purpose of the traceability
(e.g. approach neglects information existing between finding
inconsistency among artefacts, impact analysis, requirements presented
as textual documents and UML knowing the dependencies among artefacts,
reuse) \[25, 26, diagrams at the instance level. 27, 28\], challenges
and solutions \[14, 29, 30, 31\], etc. In addition, \[8\] proposes a
hybrid approach that As highlighted in the introduction, existing
combines graphs and information retrieval techniques to traceability
approaches adopt either horizontal or vertical identify the requirement
change impact on design models approaches. Horizontal traceability
determines artifact modeled with Systems Modeling Language (SysML).
dependencies at the same abstraction level (requirement, This approach
is limited to traceability between or design or code), while vertical
traceability traces requirements modeled with SysML and behavioral
artifacts between different models at different abstraction diagram
modeled with the activity diagram. In addition, levels. In this paper,
we focus on vertical traceability many behavioral aspects in the
activity diagrams are not which is classified into two categories: The
first one assigned like Join node, Fork node, etc. focuses on
traceability inter-UML models (requirement For the purpose of reuse,
\[33\] depicts an approach that and design) and the second one
determines traceability derives systematically a standard functional
model from a between requirements, UML models and code. use case
diagram, a structure diagram and a transition diagram. By decomposing
the existing functional model 2.1 Traceability inter-UML models into
model components, traceability links are recovered Traceability
inter-UML models approaches tackles the based on guidelines that allow a
mapping of model traceability within UML diagrams elements, particularly
components to non-functional requirements. This from requirements to
design diagrams. approach is limited to use cases names without
referring Adopting this type of approach, \[4\] considers the to use
case descriptions. traceability relationships between Use Case Maps
Adopting an Information Retrieval (IR) technique to (UCMs) and UML
diagrams. The proposed approach identify traceability between
requirement and design, \[34\] generates UML diagrams from UCMs notation
to describe proposes a method that uses graphs to model the structural
the system at high abstraction level. This work neglects dependencies.
The Information Retrieval technique is several concepts that relate UML
diagrams such as used to handle the semantic traceability between the
use repetitive and conditional treatment. case documentation and the
sequence diagram. This In \[14\], the authors present an approach that
supports approach is based on a structural textual description of a the
automatic maintenance of traceability relations use case to express
requirements. However, this between requirements, analysis and design
models of a description lacks structural controls which are used in
software systems expressed in UML. It followed two UML behavioural
diagrams. major phases: Recognition phase and maintenance. The On the
other hand, \[6\] proposes a method that uses first phase consists in
capturing elementary changes to graphs to model the structural
dependencies and an model elements and recognizing the compound
information retrieval technique to handle the semantic development
activity applied to the model element. The traceability between the use
case documentation and the sequence diagrams. This approach is based on
a structural 30 Informatica 46 (2022) 27--47 W. Khlif et al.

textual description of a use case diagram to express between issues
(i.e. new requests), commits (change set), requirements; however, this
description lacks structural and source code files. They train a
classifier to identify controls which are used frequently in the UML
missing issue tags in commit messages to generate behavioural diagrams.
In fact, it is not possible to trace missing links. between behavioural
elements in design and control Besides, in the purpose of supporting
traceability structures in code functions such as loop, switch, etc.
between requirement and source code, \[40\] introduces a Additionally,
the limitation of this approach lies in its solution for automating the
evolution of bidirectional trace incapability to determine the nature of
functions/ methods links between source code classes or methods and that
corresponds to a use a case textual description. requirements. The
solution depends on a set of heuristics Furthermore, several approaches
adopt a Natural coupled with refactoring detection tools and
informational language processing approach (NLP). For instance, \[35\]
retrieval algorithms to detect predefined change scenarios determines
basic elements of a class diagram from natural that occur across
contiguous versions of a software language requirements. Requirements
are presented in system. English and the designed tool (Natural language
To trace between requirements documents, UML Processing for Class NLPC)
applies NLP methods to class diagrams, and source code, \[41\] \[42\]
use graph and analyze the given input. Natural language text is XML
format to capture links between artifact elements. semantically analyzed
to obtain classes, data members and Based on a set of policies, \[38\]
\[39\] describe an member functions. NLPC uses pre-processing, Part of
approach which allows maintaining traceability of Speech (POS) Tagging,
Class Identification, Attribute and evolving architecture to
implementation links. They Function identification to plot the classes.
develop a tool "ArchTrace" which maintain existing \[5\] extracts class
diagrams from natural language traceability link. These links have to be
created manually requirements using NLP techniques such as WordNet, by
the developers or by a traceability recovery method. In OpenNLP parser,
class extraction engine, etc. Moreover, addition, the authors
distinguish between four classes of the authors proposed a system based
on rules to extract rules depending on the level where the change
occurs. For details related to the object oriented concepts like
instance, architectural element evolution policies trigger
generalization, association and dependency from natural when an
architect makes modifications to an architecture. language requirements
specification. An example of an architectural policy is illustrated in
the Furthermore, \[35\] adopts a NLP approach to show case of creating a
new version of an architectural element that natural language
requirements are semantically \[39\]. This new version of this element
should inherit all analysed to obtain classes, data members and member
traceability links from its ancestor based on a copy of all functions.
traceability links from its previous version. Based on a combination
between NLP and artificial By referring to machine learning techniques,
\[22\] neural networks, \[36\] proposes a new approach to presents a
process to recover traceability links between automatically identify
actors and actions in a natural Java programs entities and elements in a
use case diagram. language based requirements description of a system.
This solution, which is called LEarning and ANAlyzing They used an NLP
parser with a general architecture for Requirements Traceability
(LeanArt), combines program text engineering, producing lexicons,
syntaxes, and analysis, run-time monitoring, and machine learning to
semantic analyses. An artificial neural networks (ANN) search
similarities between the names and values of was developed using five
different use cases, producing program entities, and the elements names
of use case different results due to their complexity and linguistic
diagrams. This work is only based on traceability between formation. use
case name and source code. Nonetheless, it does not take into account
the different scenarios that can be found 2.2 Traceability from
requirement and in a use case textual description. design to code
Likewise, \[14\] proposes an approach called TRAIL (TRAceability lInk
cLassifier) that applies Traceability Besides traceability inter UML
models, the vertical Link Recovery (TLR) as a binary classification
problem traceability approaches tackle also the relationships for
automating traceability maintenance. It uses between requirement, design
and code \[20, 37, 38, 39\]. historically collected traceability
information (i.e., In this context, to support traceability between
existing traceability links between pairs of artifacts) to requirement
and source code, \[20\] proposes a meta-model train a machine learning
classifier which is then able to based approach that defines
traceability links between classify the link between any new or existing
pair of different artifacts (requirements, test cases, etc.) and
artifacts as valid (i.e., the two artifacts are related) or source code.
The authors propose an editor to visualize invalid (i.e., the two
artifacts are unrelated) \[29\]. To traceability between the source code
stored as an Abstract determine the validity of the link between two
artifacts, Syntax Tree (AST) and other possible artifacts. However,
TRAIL introduces three types of features: IR Ranking, the use of an AST
causes foreign problems like the Query Quality, and Document Statistics.
existence of syntax errors and comments in the source \[43\] proposes a
neural network architecture that code which loses traceability links.
utilizes word embedding and Recurrent Neural Network In \[37\], the
focus is on the traceability between (RNN) technique to automatically
generate trace links. requirement and source code in the context of
version Word embedding learns word vectors that represent control
system. Specifically, the authors study the link knowledge of the domain
corpus and RNN uses these  A Complete Traceability Methodology Between
UML Diagrams and... Informatica 46 (2022) 27--47 31

word vectors to learn the sentence semantics of Based on NLP techniques,
\[25\] defines an enhanced requirements artifacts. The authors use an
existing training framework of software artefact traceability management
set of validated trace links from the domain to train the which is
implemented in the "SATAnalyzer" tool. NLP RNN to predict the likelihood
of a trace link existing techniques are used to extract information from
artefacts between two software artifacts. For each artifact
(i.e. produced during software development process. The tool
requirement, source code file, etc.), each word is replaced supports the
traceability between requirements, UML by its associated vector
representation learned in the word class diagrams, and corresponding
Java code. \[15\] extends embedding training phase and then sequentially
fed into the SAT-Analyzer tool to consider traceability among the RNN.
The final output of RNN is a vector that other stages of development
life cycle such as testing and represents the semantic information of
the artifact. The deployment with enhanced visualization suitable for
tracing network then compares the semantic vectors of DevOps practices
and continuous integration. two artifacts and outputs the probability
that they are In order to evaluate their graph-based traceability
linked. approach, \[46, 47\] use also the SAT-Analyser tool with a IR
techniques are used also to define traceability "Sale system Point"
case. They present phases such as between models and the source code.
\[17, 18, 19\] use the software artefact identification, data
preprocessing, data Latent semantic indexing (LSI) to recover
traceability extraction and traceability establishment methodologies
between different artifacts. For instance, \[17\] uses LSI to presented
with a graph. The tool traces software recover traceability links
between software artefacts requirement artifact in natural language,
only UML class produced during the different phases of a development
diagram as design artefact and the Java source code project (use case
diagrams, interaction diagrams, test cases artifact. The traceability
graph construction is based on and code). \[7\] utilizes comments and
identifier names similarity algorithms (Jaro Winkler Distance and within
the source code to match them with sections of Levenshtein Distance)
between requirements, classes, corresponding documents. \[13\]
establishes traceability methods, attributes and the relationships
inheritance, between requirement and other software elements (code
association and generalization. elements, API documentation, and
comments) by taking Using a model-based approach, \[25, 48\] derive a
into account the change frequency, and the semantic quality model to
present traceability (Traceability similarity (TF-IDF) between the
requirement description Assessment Model (TAM)) that specifies per
element and the software element. (class, link, path) the acceptable
state (Traceability Gate) In order to improve IR-based traceability
recovery, and unacceptable deviations (Traceability Problem) from \[44\]
combines IR techniques with closeness analysis. this state. The authors
describe how both, the acceptable Specifically, the work quantifies and
utilizes the states and the unacceptable deviations can be detected to
"closeness" for each call and data dependency between systematically
assess their project's traceability. In order two classes to improve
rankings of traceability candidate to improve the previous works, \[2\]
defines a system lists. In \[45\], the authors propose an improvement of
the allowing to ensure that the software delivered meets all previous
approach by introducing user feedback into the requirements and thus
avoids failures by using data closeness analysis on call and data
dependencies in code. traceability management. Specifically, the
approach iteratively asks users to verify In summary, existing works
tackled the traceability a chosen candidate link based on the quantified
functional either between UML diagrams at the same abstraction
similarity for each code dependency (which they called level (or similar
notations) or between UML models closeness) and the generated
Information Retrieval values. (requirements, design, etc.) and the
source code, at The verified link is then used as the input to re-rank
the different abstraction levels. However, none of the existing
unverified candidate links. approaches deal with traceability between
requirements presented with an enriched template that covers the whole

Figure 1: The proposed method for tracing UML code based on textual
description of use cases. 32 Informatica 46 (2022) 27--47 W. Khlif et
al.

concepts, design models and source code. In addition, all the similarity
between the selected fragment in UC and the traceability techniques
\[49, 50\] rely on either the structural code. and/or semantic
information. For example, \[20, 21, 41\] determine traceability between
heterogeneous terms 3.1 Natural language pre-processing existing in
models (text in requirements, classes name, The most important challenge
we are facing when trying methods name, etc.). These works are purely
structure- to generate the enriched format from the textual based; they
ignore the remaining aspects of UML description is the complexity of
natural language. diagrams elements, which do affect the traceability
Consequently, we used natural language processing between them. concepts
that are syntax parsing. The purpose of the proposed method focus on The
syntax parsing consists in obtaining a structured enriching the
requirement template presented in \[6\] to representation of the
software knowledge. Therefore, the cope with the control structures and
orient our traceability. software analyst has first to clean the textual
description Furthermore, it combines both structural and semantic by
using the Stanford CoreNLP tool \[51\] and second to aspects in order to
determine the traceability between all organize it according to a
specific template's structure. elements at different abstraction levels
and detects the Stanford CoreNLP tool is used to obtain a more
relationships between the requirements, design (modelled manageable and
readable text. The tool relies on the with sequence (SD), class (CD),
activity (AD) and state following methods: transition (STD) diagrams
(first phase), and the source − Tokenization is the task of breaking a
character code (second phase). sequence up into pieces (words/phrases)
called tokens, and perhaps at the same time throw away 3 A new
traceability method certain characters such as punctuation marks \[52\].
Figure 1 depicts our method for determining vertical − Filtering aims to
remove some stop words from the traceability. It followed three major
phases: "Pre- text. Words, which have no significant relevance and
processing Natural language", "traceability inter-UML can be removed
from the documents \[53\]. diagrams" phase and "traceability from
requirement and − Lemmatization considers the morphological analysis
design to code" phase. of the words, i.e. grouping together the various
The "Pre-processing Natural language" phase during inflected forms of a
word so they can be analysed as which the software analyst receives a
textual description a single item. of a software written in a natural
language. The description − Stemming aims at obtaining stem (root) of
derived is cleaned based on simple NLP technique (i.e. Stanford words.
Stemming algorithms are indeed language CoreNLP tool) \[51\]. Then, the
software analyst uses the dependent \[54\]. output to identify the goals
that are used to divide the − Part of Speech Tagging tags for each word
(whether textual description into different parts. The proposed the word
is a noun, verb, adjective, etc.), then finds decomposition guides and
improves the generation of the most likely parse tree for a piece of
text. description parts and the corresponding fragments related The
cleaned file is then used to identify the goals. By goal, to design
diagrams in a more systematic, rigorous, and we mean a collection of
functionalities that are related to consistent way. For each description
part, the software describe a functional process of the software. Each
goal analyst prepares its textual description according to a will
correspond to a textual description of a use case. specific template. To
handle this requirement, we define To guide and improve the generation
of a software in an enriched template that can be written in a specific
a more systematic way, the software analyst associates to format. The
template is used to generate its corresponding each textual description
of a part, a template that is XML file. The second phase, "Traceability
inter-UML described by a set of linguistic patterns. The template is
diagrams" receives the produced file which will be easy to understand
and validated by stakeholders. It covers considered as the input to the
traceability process. the semantic, behavioural, functional and
organizational The latter is composed of traceability rules information.
It is composed of three blocks (See Table 1). identification and
similarity calculation between the The first block gives an executive
summary of the selected fragment in the use case and its corresponding
in textual description block in terms of the name of the UC, UML design
diagrams (class, sequence, activity and state purpose of the use case
and actors. The second block transition). This process uses the
identification of describes the main, alternative, and error scenarios.
The traceability rules and semantic traceability results. The use case
description contains also pre-condition for identification of
traceability rules explicitly represents the execution, post-condition
(success/failure), and relationships (structural aspect) among the
diagrams' relationships with parts successors. These scenarios elements.
It is based on an ontology for the semantic respect a linguistic syntax
pattern: analysis of the textual description template. To identify the
semantic traceability between the structured textual
`<NumAction>`{=html}`<From Actor>`{=html}`<To Actor>`{=html} \<Type of
documentation and UML design diagrams, traceability Result\>
`<Action Description>`{=html} `<In-Parameter>`{=html}\<Out- process
inter-UML diagrams apply the LSI technique. Parameter\>
`<IsConsidered>`{=html}`<IsIgnored>`{=html} `<IsNegative>`{=html} The
third phase is based on the traceability process Table 1 depicts the
expanded description template from requirement to code which apply the
traceability with alternative behavioral elements based on control rules
defined in the first phase on the code and calculate structures such as
IF-THEN statement and iterative A Complete Traceability Methodology
Between UML Diagrams and... Informatica 46 (2022) 27--47 33

elements, e.g. `<for>`{=html}`<number of iterations>`{=html}). In
addition, `<IsNegative>`{=html} the extended template expresses how the
actions are //parallel actions Parallel executed: in a parallel
`<Parallel>`{=html}, or sequence way
`<NumAction>`{=html}`<From              Actor>`{=html}`<To         Actor>`{=html}\<Type
of `<Sequential>`{=html}, etc. Besides the common elements, we Result
\>`<Action            Description>`{=html}`<In-Parameter>`{=html}`<Out-
proposed an extension of the UC textual description with                     Parameter>`{=html}`<IsConsidered>`{=html}
`<IsIgnored>`{=html} `<IsNegative>`{=html} behavioral elements and
keywords, such as:
`<NumAction>`{=html}`<From Actor>`{=html}`<To Actor>`{=html}`<Type of Result >`{=html}`<Action
                                                                             Description>`{=html}`<In-Parameter>`{=html}`<Out              Parameter>`{=html}
`<IsConsidered>`{=html} − `<In-Parameter>`{=html} and
`<Out-Parameter>`{=html} expressing the `<IsIgnored>`{=html}
`<IsNegative>`{=html} input and output of the action. // Functional call
− `<Type of Result >`{=html} which determines if the result has
Functional Call a simple value or it represents an entity. In the case
of
`<NumAction>`{=html}`<From Actor>`{=html}`<To Actor>`{=html}`<Type of Result>`{=html}
`<Action
                                                                             Description>`{=html}
`<In-Parameter>`{=html} `<Out-Parameter>`{=html} `<IsConsidered>`{=html}
a simple value, it can be represented as an attribute.
`<IsIgnored>`{=html} `<IsNegative>`{=html} However, in the case of an
entity, it can be End transformed to a class in the class diagram.
***Alternative scenario*** − `<From Actor>`{=html}`<To Actor>`{=html}
which represents the SA1 Begin\<Event, condition\> sender and receiver
of the action. begin at \<Num "action number"\> \<Return "action
number"\> − `<If>`{=html}`<Else if>`{=html}`<Else>`{=html}represents a
choice or behaviour List of actions alternatives. //sequential actions −
`<Parallel>`{=html} expresses parallel execution of the actions.
`<NumAction>`{=html}`<From Actor>`{=html}`<To Actor>`{=html}`<Type of Result>`{=html}
`<Action      Description>`{=html}
`<In-Parameter>`{=html}`<Out-Parameter>`{=html} − `<For>`{=html}
`<number of iterations>`{=html} represents the loop
`<IsConsidered>`{=html} `<IsIgnored>`{=html}`<IsNegative>`{=html} which
is repeated a number of times. //parallel actions − `<Loop>`{=html}: an
iterative behaviour that englobes one or
`<NumAction>`{=html}`<From Actor>`{=html}`<To Actor>`{=html}`<Type of Result>`{=html}
several actions. `<Action      Description>`{=html}
`<In-Parameter>`{=html}`<Out-Parameter>`{=html} `<IsConsidered>`{=html}
`<IsIgnored>`{=html}`<IsNegative>`{=html} − `<Break>`{=html} represents
an exceptional situation
`<NumAction>`{=html}`<From Actor>`{=html}`<To Actor>`{=html}`<Type of Result>`{=html}
corresponding to a scenario of rupture.
`<Action      Description>`{=html}
`<In-Parameter>`{=html}`<Out-Parameter>`{=html} −
`<Functional Call>`{=html} is an action that calls another
`<IsConsidered>`{=html} `<IsIgnored>`{=html}`<IsNegative>`{=html} action
or use case. //alternative control structure in the first level
`<IF>`{=html}`<condition>`{=html} − `<IsIgnored>`{=html} reflecting that
the actions types can be
`<NumAction>`{=html}`<From             Actor>`{=html}`<To         Actor>`{=html}\<Type
of considered insignificant and are implicitly ignored. Result
\>`<Action Description>`{=html}`<In-Parameter>`{=html}`<Out Parameter>`{=html}
− `<IsConsidered>`{=html} determines which actions should be
`<IsConsidered>`{=html} `<IsIgnored>`{=html} `<IsNegative>`{=html}
considered within this textual description, meaning End IF //iterative
control structure in the first level that any other action will be
ignored. `<Loop>`{=html}\<Min Number of Iterationxfcyws, Max Number of −
`<IsNegative>`{=html} describes actions of traces that are Iterations \>
defined to be negative (invalid). Negative traces occur
`<NumAction>`{=html}`<From Actor>`{=html}`<To Actor>`{=html}`<Type of result >`{=html}\<Action
when the system has failed. It can represent an
Description\>`<In-Parameter>`{=html}`<Out-Parameter>`{=html}`<IsConsidered>`{=html}
`<IsIgnored>`{=html} `<IsNegative>`{=html} exception. End Loop End SA1
The added behavioral elements and keywords are SA2 organized according
to the use case scenario. The main Begin\<Event, condition\> scenario
contains sequential or parallel actions. It can also begin at \<Num
"action number"\> \<Return "action number"\> contain a functional call;
while the alternative and error List of actions // Loop nested in an
alternative control structures scenario are based on conditional (opt,
If Else, etc.) or \< IF\>`<condition>`{=html} iterative (Loop) control
structures that can be expressed in `<NumAction>`{=html}
`<From       Actor>`{=html}`<To       Actor>`{=html}\<Type of one or
more levels (nested levels). For instance, it is result
\>`<Action                  Description>`{=html}`<In-
possible to determine an iterative block nested in a                                 Parameter>`{=html}`<OutParameter>`{=html}`<IsConsidered>`{=html}
`<IsIgnored>`{=html} `<IsNegative>`{=html} conditional block and vice
versa. These control structure `<Else>`{=html} types can be followed by
parallel or sequence blocs. `<Loop>`{=html}\<Min Number of Iterations,
Max Number of Iterations \> Name of the Use Case
(UC):`<unique name assigned to a use case>`{=html} `<NumAction>`{=html}
`<From       Actor>`{=html}`<To      Actor>`{=html}\<Type of Purpose of
the use case:\< a summary of a UC purpose\> result
\>`<Action      Description>`{=html}`<In-      Parameter>`{=html} \<Out
Actors:`<Primary actor>`{=html}: actor that initiates the use case\>
Parameter\>`<IsConsidered>`{=html} `<IsIgnored>`{=html}
`<IsNegative>`{=html} `<Secondary actor>`{=html}: actor that participate
within the use case\> End Loop Pre-condition for
execution:`<A list of conditions that must be true to      End IF
 initialize the UC>`{=html} `<Functional Call>`{=html} Post-condition
(success/failure):\<state of the system if the goal is
`<NumAction>`{=html}
`<From Actor>`{=html}`<To Actor>`{=html}`<Type of Result >`{=html}`<Action
 achieved/abandoned>`{=html} Description\> `<In-Parameter>`{=html}
`<Out-Parameter>`{=html} `<IsConsidered>`{=html} Relationships:
`<include>`{=html}: `<UC in relation with this UC by include>`{=html}
`<IsIgnored>`{=html} `<IsNegative>`{=html} `<Extend>`{=html}: \< use
cases in relation with this use case by "extend"\> End
`<Super use case>`{=html}:
`<list of subordinate uses cases of this use case>`{=html} End SA2
`<Sub use case>`{=html}:
`<list of all uses cases that specialize this use case>`{=html} ***Error
scenario*** Begin SE1// Treat the error and return to the action ***Main
scenario*** `<steps of the scenario to goal>`{=html} Begin\<Event,
condition\> Begin begin at \<Num "action number"\> \<Return "action
number"\> //sequential actions List of actions
`<NumAction>`{=html}`<From Actor>`{=html}`<To Actor>`{=html}
`<Type of Result>`{=html} \<Action `<NumAction>`{=html}
`<From       Actor>`{=html}`<To       Actor>`{=html}`<Type     of
 Description>`{=html} `<In-Parameter>`{=html}`<Out-Parameter>`{=html}
Result \>`<Action                  Description>`{=html}\<In-
`<IsConsidered>`{=html}`<IsIgnored>`{=html} 34 Informatica 46 (2022)
27--47 W. Khlif et al.

       Parameter><OutParameter><IsConsidered>     <IsIgnored>    −   SD: an object corresponding to each participant
       <IsNegative>                                                  (actor) in the SD.

End SE1 End Use case − CD: a class corresponding to each participant in
the Critical situations of execution of the activity CD. Special
requirement: `<non Functional requirement>`{=html}\<Project − AD: a
swimlane having the actor name which requirement and constraints\>
performs a group of activities. − STD: the actor has no corresponding in
the STD. Table 1: Enriched textual description of a use case. − Code: a
class in the code. R4: For each action in the use case scenario, there
is: 3.2 Traceability process − SD: a message in a SD having a synonym
name. In this subsection, we define traceability rules which are − CD: a
method in a class corresponding to the action. applicable to the first
and second phase of our method. − AD: an executable node represented by
'Action' They are used to determine correspondences between the having
the same name and the same parameters. requirement modeled with the use
case diagram based on − STD: If the action in a textual description
respects the the enriched textual description and design diagrams
renaming pattern: « Action verb + Object \| Nominal modeled with SD, CD,
AD and STD. Group », then the state will be : object + past participle.
3.2.1 Traceability rules − Code: a method in the code having the synonym
R1: For each `<In-Parameter>`{=html} and `<Out-Parameter>`{=html} name,
the same parameters. expressing the input and output of the action,
there is: R5: For each pre-condition/post-condition of the use case −
SD: an object in a sequence diagram. scenario, there is: − CD: a class
corresponding to each parameter, and an − SD: a
precondition/post-condition of the first message attribute corresponding
to an argument. sent by an object in the sequence diagram. − AD: an
object node that corresponds to InputPin and − AD: a guard of the
corresponding action \[55\] OutputPin. We note that InputPin and
OutptPin can be − STD: a pre-condition associated to a transition which
related to the same or more than one objectNode. is necessary to define
a state. − Code: a class corresponding to `<In parameter>`{=html} and an
− Code: a precondition under which a method may be attribute
corresponding to an argument. called and expected to produce correct
results \[56\]. R2: For each action's sequence in a use case, there is:
We note that the precondition and the post-condition have − SD: a
sequence of sent or received message which no corresponding in the class
diagram. preserves the action order in the scenario. R6: For each
parallel scenario (PARALLEL), there is: − AD: a sequence of ordered
activities. − SD: a parallel combined fragment in a sequence − STD: a
sequence of ordered states in the state diagram. diagram. If the action
in a STD respects the renaming − AD: a set of parallel actions between a
fork node and pattern: « Action verb + DataObject\| NominalGroup a join
node. », then the state of the action will be: Data object + − STD: a
fork pseudo state vertices and a join state. past participle. − Code: a
multi-threaded program in java. − Code: a sequence of lines of code that
respect the We note that the parallelism is not expressed in the CD.
ordered actions. R6 is illustrated in Table 2. We note that this rule
cannot be expressed in the CD. R7: For each alternative scenario in a
use case where R3: For each actor expressing the sender and the receiver
instructions begin with alternative behavioural elements of the action
in the use case scenario, there is: (IF-THEN Statement ELSE Statement),
there is:

             Use case                 Sequence Diagram      Activity Diagram    State transition             Code
                                                                                   diagram

PARALLEL \< public class `<NumAction>`{=html}`<Pre-condition>`{=html}
myClassimplements Runnable{
`<From Actor>`{=html}`<To Actor>`{=html}\<Action Thread UnThread ;
Type\>`<Type of Result >`{=html}\<Action MyClass ( ) Description\>
`<In-Parameter>`{=html} \<Out- {//..initialisation Parameter\>
`<IsConsidered>`{=html} of myClass constructor UnThread = new Thread (
`<IsIgnored>`{=html}`<IsNegative>`{=html} this , "thread secondaire" );
`<NumAction>`{=html}`<Pre-condition>`{=html}
`<From Actor>`{=html}`<To Actor>`{=html}\<Action UnThread.start(); }
Type\>`<Type of Result >`{=html}\<Action public void run ( ) {
//....second thread Description\> `<In-Parameter>`{=html}
`<Out-                                                                 actions here
 Parameter>`{=html} `<IsConsidered>`{=html} }}
`<IsIgnored>`{=html}`<IsNegative>`{=html}\>

                                                  Table 2: R6 illustration.

A Complete Traceability Methodology Between UML Diagrams and...
Informatica 46 (2022) 27--47 35

                  Use case                   Sequence Diagram       Activity Diagram     State transition
                                                                                                                   Code
                                                                                            diagram
    <IF><condition>
    <NumAction><Pre-condition> <From
    actor><To actor><Action Type><Type of
    result ><Action Description> <In-
                                                                                                            If (condition)
    Parameter> <Out-Parameter>
                                                                                                            {
    <IsConsidered> <IsIgnored><IsNegative>
                                                                                                            operation 1;
    <Else >
                                                                                                            else
    <NumAction><Pre-condition> <From
                                                                                                            operation 2;
    actor><To actor><Action Type><Type of
                                                                                                            }
    result ><Action Description> <In-
    Parameter> <Out-Parameter>
    <IsConsidered><IsIgnored> <IsNegative>
    END
                                                  Table 3: R7 illustration.

− SD: an ALT combined fragment with the interaction edge which is
related to a final node in the alternative operator "ALT" and two
alternative interactions in a scenario SD. − STD: a decision point
leading to 1 state and one final − AD: a decision node with two outgoing
edges with state (Transition to terminate pseudostate). guards in the
activity diagram or a conditional node is R7.4: For each error scenario
in a use case where a structured activity that represents an exclusive
instructions begin with the alternative behavioral elements choice
between two alternatives. `<IF>`{=html}`<condition>`{=html} Return,
there is: − STD: a decision point leading to two different states − SD:
a break combined fragment in a sequence in the state transition diagram.
diagram which can be used to express an error − Code: a basic control
structure corresponding to "IF scenario. condition THEN treatment 1 ELSE
treatment2". − AD: an interruptible region which contains activity R7 is
illustrated in Table 3. nodes in the error scenario R7.1: For each
alternative Scenario where instructions − STD: a decision point leading
to 1 state and one final begin with the alternative behavioral elements
(`<if >`{=html} state (Transition to terminate pseudostate). A break
condition
`<else if >`{=html}.....`<else if>`{=html}...`<else>`{=html}...),
(SWITCH), can be also expressed by an Exit point pseudostate there is:
which is an exit point of a state machine or composite − SD: an Alt
Combined Fragments: Interaction operator state. "alt" with more than two
alternatives in a SD. The exit point is typically used if the process is
not − AD: a decision node with more than two outgoing completed but has
to be escaped for some error or other edges in an activity diagram.
issue. − STD: a decision point leading to n different states in R7.4 is
illustrated in Table 4. a STD or a conditional node is a structured
activity R8: For each alternative/error Scenario in a use case that
represents an exclusive choice among some where instructions begin with
the iterative behavioural number of alternatives. elements
(`<For>`{=html}\<\[num of iterations\]\>...), there is: − Code: a basic
control structure corresponding to − SD: a loop combined fragment in a
sequence diagram. switch. − AD: a decision node with one of the outgoing
edges R7.2: For each alternative scenario in a use case where is a
precedent activity in an activity diagram. instructions begin with the
alternative behavioral elements − STD: a reflective transition or
transition path. (`<if >`{=html} condition `<then>`{=html} treatment.),
there is: − Code: a basic control structure corresponding to For- − SD:
an opt combined fragment in a sequence diagram. do, DO while
(post-test), While do (pre-test). We recall that the opt (optional)
operator is a non- R8 is illustrated in Table 5. alternative (otherwise)
test statement. R9: For each functional call (an action that calls
another − AD: a decision node with two outgoing edges: one to action or
use case), there is: execute an action and the second is related to the
final − SD: a ref fragment expressing the reference to an activity in
the activity diagram. interaction in another sequence diagram. − STD: a
decision point leading to one state and one − AD: a call Behaviour: An
activity is invoked by using final state. the 'Call Behavior Action'
node, which means that the − Code: a basic control structure
corresponding to "IF invoked activity is defined in more details in
another condition THEN treatment". AD. R7.3: For each alternative
scenario in a use case where − STD: A Composite state which encloses
refinements instructions contain the alternative behavioral elements of
the given state. We note that the composite state (`<if >`{=html}
condition `<break>`{=html}) in an iterative bloc, there is: corresponds
to the object that can realize the − SD: a break combined fragment in a
loop fragment functional call or an entry point of a state machine or
that belongs to a sequence diagram composite state which allows you to
specify an − AD: a decision node which one is related to a final
activity that occurs when you enter the state. activity by an outgoing
edge and another outgoing 36 Informatica 46 (2022) 27--47 W. Khlif et
al.

                  Use case               Sequence Diagram           Activity Diagram         State transition            Code
                                                                                                diagram
     <IF><condition>
     <NumAction><Pre-condition>                                                                                             If
     <From actor><To actor><Action                                                                                  (condition1)
     Type><Type of result ><Action                                                                                      operation
     Description> <In-Parameter>                                                                                         1;
     <Out-Parameter> <IsConsidered>                                                                                       Else
     <IsIgnored><IsNegative>                                                                                               return;
     <Else>
     return

                                                   Table 4: R7.4 illustration.
                     Use case                Sequence Diagram      Activity Diagram          State transition            Code
                                                                                                diagram
     <For><Min Number of Iterations,                                                                            For(i=1, i<=5,i++)
     Max Number of Iterations >                                                                                      operation 1;
     <NumAction><Pre-condition> <From
     actor><To actor><Action Type><Type of                                                                           }
     result ><Action Description> <In-
     Parameter> <Out-Parameter>
     <IsConsidered> <IsIgnored>
     <IsNegative>
     End For

                                                    Table 5: R8 illustration.

− Code: a call of a class or a method. In the second step, LSI applies
singular value decomposition (SVD) to the A matrix which consists in
R10: For each action that represents an invalid decomposing the A matrix
into three matrices: the U, S interaction/exception
`<IsNegative>`{=html}, there is: and V. One component matrix describes
the original row − SD: A Negative combined fragment in the sequence
entities as vectors of derived orthogonal factor values, diagram which
defines invalid traces. another describes the original column entities
in the same − AD: An event representing an error (exception) that way,
and the third is a diagonal matrix containing scaling interrupts the
flow or a break which are most values such that when the three
components are matrix- commonly used to model exception handling.
multiplied, the original matrix is re-constructed. The third − STD: a
transition to an error state. This error state step represents the
dimensionality reduction, which may be terminal, i.e. aborts further
event handling. consists in computing Uk, Sk, Vk and VkT. For instance,
− Code: a basic control structure corresponding to implementing a rank 2
Approximation (K=2) by keeping "Exception". This corresponds to a
try-catch. the first two columns of U and V and the first two columns
R11: For each action that should be considered and rows of S. The fourth
step consists in finding the new (respectively ignored) within the
scenario, there is: document vector coordinates in this reduced 2- − SD:
messages that are considered as significant dimensional space. Rows of V
hold eigenvector values. (respectively insignificant) within the
"consider" These are the coordinates of individual document vectors.
(respectively ignore) combined fragment. The fifth step finds the new
query vector coordinates in − AD: considered (respectively ignored)
messages are the reduced 2-dimensional space as follows: shown in the
activity diagram. q = qT UkSk-1 (2) − STD: The states corresponding to
the considered (respectively ignored) actions. Finally, the last step
ranks documents in order to − Code: The method should be considered
(ignored) as decrease the order of query-document cosine similarities
significant in the code. using the following equation: 𝑞.𝑑 sim (q,d)=
\|𝑞\| (3) \|𝑑\| 3.2.2 Similarity calculation Based on the proposed
rules, we apply the similarity The document which has a higher score is
closer to measure "Latent Semantic Indexing" (LSI) which is the query
vector than the other vectors. defined to the traceability process
inter-UML diagrams We note that, in this paper, LSI is used to compute
and to the traceability process from requirement to code. similarities
between the selected fragment in a use case The first step in
calculating the LSI is to assign term and the corresponding ones in
other UML diagrams (SD, weights and construct the term-document matrix A
and CD, AD and STD), and then the corresponding fragment query matrix.
The m by n document-matrix A is presented in the code while in \[6\] the
LSI is used only to compute as follows where: similarities between
actions in UC and messages in sequence diagrams. The choice of LSI
amongst other aij= wij= term weights (1) similarity measures is
justified by its capacity in retrieving hidden, semantic relations
between terms when searching A Complete Traceability Methodology Between
UML Diagrams and... Informatica 46 (2022) 27--47 37

for similar terms between queries extracted from a the source code
however parallelism in JAVA can be fragment in the UC and the documents
containing the implemented using different ways (fork/join framework,
information in other UML diagrams. In fact, LSI does not threads,
Agregate operations, etc.). Source code in the rely on words but rather
on concepts; that is, words having used projects uses the aggregate
operations and parallel same contexts can be revealed similar. This
propriety streams to express parallelism and our method uses expresses
the difference between LSI and other IR threads to detect parallelism.
This is why parallel techniques. Henceforth, the similarity measure can
be fragments are not traced and we found some false properly calculated
between queries and documents even negatives. when they do not share
enough words. The true positives and the false negatives are equal to
the total number of actual corresponding elements. All the 4
Traceability evaluation false negatives are corresponding elements
associated to elements in UC textual description diagram that have The
evaluation phase expresses the performance of the corresponding impacts
on other UML diagrams which are proposed method revealed by two steps:
experimental not detected. evaluation and result interpretation. The
first step in the evaluation phase compares corresponded elements
generated by our method with the corresponded elements 4.2 Threats to
validity where traceability is evaluated by experts. Particularly, we
This section discusses the potential issues that may present two UML
projects containing a set of UML threaten the validity of our study,
including the internal diagrams (including use cases and their textual
and external validity \[57\]. descriptions) and the source code
(projects are The internal validity threats in the case of traceability
implemented using JAVA language) to five experts identification are
related to user requirements \[58\]. They having years of experience
studying and developing UML are related to three issues: The first issue
is due to the use projects. The expert should determine traceability by
of the enriched textual description of a use case which may detecting
the corresponding elements. The solution not always be available. The
second problem is addressed presented by these experts was compared with
our when there is a diversity of requirements description. In solution
(constructed by our tool). The projects source this case, which one can
be used to describe the functional codes are available as well as their
design (i.e. UML requirements? diagrams). Table 6 provides some
information about these Furthermore, if the functional requirements are
projects. Besides, for experimental evaluation purposes, clearly stated,
then our method generates well matched we refer to the recall and
precision measures: elements; otherwise, the quality of the derived
traceability Precision = TP/(TP+FP) (4) elements is not guaranteed in
terms of dependencies Recall = TP/(TP+FN) (5) between elements. The
third issue is related to the impact where: of an error-prone generation
of UML diagrams and code. − True positive (TP) is the number of existing
real This case may lead to inconsistency between the corresponded
elements generated by our tool; requirement, design models and source
code. − False Positive (FP) is the number of non existing real The
external validity threats deal with the possibility corresponded
elements generated by our tool; to generalize this study results to
other case studies. The − False Negative (FN) is the number of existing
real limited number of case studies used to illustrate the corresponded
elements not generated by our tool. proposed approach could not
generalize the results. In addition, the traceability between all levels
increases the 4.1 Evaluation results and interpretation detection and
localization of consistency errors. High scores for both ratios show
that our traceability approach returns both accurate corresponding
elements of 5 TRADIAC tool UML diagram (high precision) and the majority
of all To facilitate the application of our method, we have relevant
corresponding elements (high recall). It means developed a tool for
determining the traceability at that the generated traceability links
cover the whole different abstraction levels, named TRADIAC Quality
domain precisely in accordance to the experts' (TRAceability for UML
DIAgrams and Code). Our tool is perspective. implemented as an EclipseTM
plug-in \[59\]. It is composed As illustrated in Table 7, precision,
whose average is of four main modules (see Figure 2): Pre-processing
0.84, indicates that we found some false positive Natural language,
Traceability inter-UML diagrams, corresponding elements (i.e. incorrect
detected Traceability from requirement to code, and traceability
corresponding elements). The false positives evaluator. corresponding
elements are not significant value when we compare them to the true
positives found by our method. 5.1 Pre-processing natural language The
recall, whose average value is 0.91, expresses that module there are
also some false negatives corresponding elements (i.e. true
corresponding elements are not The pre-processing engine is composed of
the cleaner and detected). These false negatives can be explained by the
the XML generator. fact that our method uses "threads" to detect
parallelism in 38 Informatica 46 (2022) 27--47 W. Khlif et al.

     PROJECT         #Use       #               #                   5.1.1    Cleaner
      NAME           cases   CLASSES         METHODS       KLOC
                                                                    The cleaner uses as input the textual description of the

Car rental 9 98 252 108 software written in a natural language. It
cleaned the file system Customer 7 65 124 96 using the Stanford CoreNLP
tool. The cleaned file is used Relationships by the software analyst to
define manually goals. Then, system the latter associates each goal to
its corresponding textual description part. Table 6: Characteristics of
the studied projects. In order to illustrate the functioning of this
module, Evaluation TP FP FN Precision= Recall=TP/ we apply it to the
"make a reservation" textual description. Measures TP/(TP+FP) (TP+FN)
For instance, Figure 3 illustrates the goal definition and its Results
62 9 5 0.84 0.91 description. The software analyst creates the enriched
Table 7: Evaluation results. template corresponding to each textual
description part. Table 8 illustrates enriched textual description for
the use case "UC-ETD" "make a reservation" from a car rental system
\[60\].

                                                                    5.1.2    XML generator
                                                                         XML generator takes as input the enriched textual
                                                                    description of UC introduced by the user. The purpose
                                                                    interface of "UC-ETD" is presented in Fig. 4. It is
                                                                    composed respectively of five tabs illustrating the
                                                                    identification purposes "identification purpose", the
                                                                    nominal scenario "Main Scenario", the alternative
                                                                    scenario (s) "Alternative Scenario", the error scenario (s)
                                                                    "Error scenario (s)" and the generator of the XML file
                                                                    corresponding to the textual description. The
                                                                    "identification purpose" tab contains the name of the UC,
                                                                    its purpose, the primary and secondary list of the actors,
                                                                    the pre-condition and the post-condition of the UC in the
                                                                    textual description and the use case's relationships:
                                                                    include, extend and generalize. The list expresses use
                                                                    cases in relation with the corresponding one by “include”,

Figure 2: Software architecture of TRADICAC Quality use cases in
relation with the corresponding use case by Tool. "extend", subordinate
uses cases of the super UC and the list of all uses cases that
specialize the sub use case. The Goals: The purpose is to make a
reservation by a three other tabs express the details of the different
UC customer from a car rental branch. scenarios being documented. The
last tab expresses the Textual description: The use case begins when a
XML file corresponding to the textual description of the customer
decides to make a reservation and introduce himself in the car rental
branch to an available Clerk. The whole UC. In the rest of the section,
we detail these tabs clerk asks the customer for his/her ID and
introduces it. through the use case "make a reservation" from the case
The system checks if the customer is a person who study "Car Rental"
\[60\]. The enriched textual description has had contact with EU-Rent.
If he/she exists, the system for the use case "make a reservation" is
presented in Table verifies that the customer is not in the black list
otherwise 8 describing the purpose (See Figure 4) of the UC, Figure it
introduces a new EU-rent costumer/driver. The clerk 5, Figure 6 and
Figure 7 presenting respectively the main, introduces the reservation
ID, the period desired and alternative and error scenarios, and Figure 8
illustrates the countries planned to visit. He specifies and verifies
the corresponding XML file based on the enriched template of period
validity and that there is no overlap with other the "make a
reservation" UC. customer reservations and 3) the availability of the
specified car model for the period indicated. − Addition a nominal
scenario NS: The "Main If there are no cars to rent corresponding to the
desired Scenario" (see Figure 5) shows the list of actions in model in
the selected period, the system displays an error the main scenario
which can be classified on two message to the user and suggests if it is
possible to change blocs: sequential or parallel actions. Each bloc the
reservation period or the car type. The clerk asks the indicates how
these actions are executed. customer to validate the reservation. It is
composed of seven columns representing If the customer validates the
reservation, the clerk respectively: a) NumAction that indicates an
creates the reservation agreement and offers a discount to automatic
number identifying an action, b) Fom actor the customer. The rental is
confirmed and a new rental and c)To actor which allows to specify who is
agreement is created with the indicated parameters. responsible for the
action, d)Type of result which Figure 3: Goal definition. determines if
the result is a simple value or it represents an entity, and e)Action
description representing a field specifying the action text, f) In- A
Complete Traceability Methodology Between UML Diagrams and...
Informatica 46 (2022) 27--47 39

Name of the UC : `<Make a reservation >`{=html} Purpose:
`<A customer makes a reservation from an EU-Rent branch >`{=html}
Principal Actors : \< Clerk \> , `<Secondary actor>`{=html} : \<
Customer\> Pre-condition for execution:\< when a customer decides to
make a reservation and inform the clerk\> Post-condition (success): \<
The rental is confirmed and a new rental agreement is created with the
indicated characteristics\> Post-condition (failure):
`<The indicated characteristics are not satisfied and a rental is canceled>`{=html}
Relationships: `<include>`{=html}: \< Offer discount\>\< Offer special
advantages\> `<Extend>`{=html}: \< -- \>; `<Super use case>`{=html}: \<
--\>; `<Sub use case>`{=html}: \<--\> Begin ***Normal scenario***
`<steps of the scenario of the trigger to goal>`{=html} Begin NS
\<NumAction 1\> \< From Actor Clerk \>\< To Actor Customer\> \< Type of
Result Simple: Integer\> \< Action Description Asks the custumer for
hisID \> \<In-Parameter: IDCustomer \>
`<Out-Parameter IDCustomer >`{=html}\< IsConsidered 1\>\< IsIgnored
0\>\< IsNegative 0\> \<NumAction 2\> \< From Actor The Clerk \>\< To
Actor The Customer \> \< Type of Result Simple: Boolean\>\< Action
Description Checks if the customer is a person who had contact with
EU-Rent\> `<In-Parameter IDcustomer >`{=html}
`<Out-Parameter Exists: Yes>`{=html} \< IsConsidered 1\>\< IsIgnored
0\>\< IsNegative 0\> \<NumAction 3\>\< From Actor Customer\> \< To Actor
clerk\>\< Type of Result Entity\>\< Action Description Tells information
about the reservation to the clerk\>\<In-Parameter Reservation
(IDRes,StartResDat, End ResDat, DepartureCity, Arrival city)\>
\<Out-Parameter Reservation (IDRes , StartResDat, End ResDat,
Departure/Arrival City, registration number car ) \>\< IsConsidered
1\>\< IsIgnored 0\>\<IsNegative 0\> \<NumAction 4\> \< From Actor Clerk
\>\< To Actor The reservation\> \< Type of Result Entity\>\< Action
Description Introduces the reservation ID, the period desired and
countries planned to visit \>\<In-Parameter IDRes, StartResDat, End
ResDat, DepartureCity, Arrival city, registration number car
\>\<Out-Parameter Reservation (IDRes, StartResDat, End ResDat,
Departure/ArrivalCity, registration number car )\> \< IsConsidered 1\>\<
IsIgnored 0\>\< IsNegative 0\> \<NumAction 5\> \< From Actor The Clerk
\>\< To Actor The
reservation\>`<Type of Result Simple: boolean>`{=html}\<Verify that the
period is correct, that there is no overlap with other reservations of
the customer and the availability of the specified car model for the
period indicated\> \<In-Parameter: Reservation\>
`<Out-Parameter availability car >`{=html} \< IsConsidered 1\>\<
IsIgnored 0\>\< IsNegative 0\> `<Parallel>`{=html} \<NumAction 6\>\<
From Actor The Clerk \>\< To Actor The agreement\> \< Type of Result
Entity\>\< Action Description Create the reservation agreement
\>\<In-Parameter rental agreement: ID customer, price, ID reservation\>
`<Out-Parameter Rental agreement >`{=html}\< IsConsidered 1\>\<
IsIgnored 0\>\< IsNegative 0\> \<NumAction 7\> \< From Actor The Clerk
\>\< To Actor The agreement\>\< Type of Result Entity\>\< Action
Description Offer a discount to the customer \>\<In-Parameter Discount
rental agreement : Discount,ID agreement, ID customer\>
`<Out-Parameter Discount rental agreement >`{=html}\< IsConsidered 1\>\<
IsIgnored 0\>\< IsNegative 0\> End ***Alternative scenario*** AS1 Begin
\<Event, begin at Num 2 in SN\> `<IF>`{=html}\< the customer does not
exists \> \<NumAction 1\> \< From Actor Clerk \>\< To Actor customer\>
\< Type of Result Customer (name, ID, birthdate, address, phone)\>\<
Action Description Introduce a new customer\> \<In-Parameter Customer
(name, ID, birthdate, address, telephone)\>
`<Out-Parameter Customer >`{=html} \< IsConsidered 1\>\< IsIgnored 0\>\<
IsNegative 0\> `<Else >`{=html} \<restart at num 3 in SN\> End AS1 AS2
\<begin at Num 3 in SN\> `<Do>`{=html} \<NumAction 1\>\< From Actor
clerk
\>`<To Actor reservation>`{=html}`<Type of Result Simple>`{=html}\<
Action Description Specifies the period \>`<In Parameter
period >`{=html} `<Out-Parameter period >`{=html}\< IsConsidered 1\>\<
IsIgnored 0\>\< IsNegative 0\> \<NumAction 2\> \< From Actor
clerk\>`<To Actor reservation>`{=html}
`<Type of Result correct yes/no>`{=html}\< Action Description Verify the
period\>\] \[`<In-
Parameter period>`{=html}\]
\[`<Out-Parameter correct yes/no >`{=html}\]\< IsConsidered 1\>\<
IsIgnored 0\> \< IsNegative 0\> `<While>`{=html}\<period is correct
&does not overlaps with other reservations \> \<restart at Num "6" in
SN\> End AS2 AS3 \<begin at Num 5 in SN\>
`<Opt>`{=html}`<needs confirmation>`{=html} \<NumAction 6\> \< From
Actor Clerk
\>`<To Actor Customer>`{=html}`<Type of Result Simple: Boolean >`{=html}
`<Action Description Asks the customer
if he validates the reservation>`{=html}
`<In-Parameter Reservation>`{=html}`<Out-Parameter IsValidated >`{=html}\<
IsConsidered 1\>\< IsIgnored 0\>\< IsNegative 0\> \<restart at Num "6"
in SN\> End AS3 \*\*\* Error scenario \*\*\* ES1 \<begin at Num "5"\>
`<IF>`{=html}`<There is no cars to rent having the desired model in the selected period>`{=html}
\<NumAction 6\> \< From Actor The system \>\< To Actor The Clerk \>\<
Type of Result Entity \>\< Action Description displays an error message
to the user and suggests if it is possible to change the reservation
period or the car type \>\<In-Parameter: Car model, period \>
`<Out-Parameter Error
message>`{=html} \< IsConsidered 0\> \< IsIgnored 0\> \< IsNegative 1\>
Return End

                          Table 8: Enriched textual description for the use case “make a reservation”.

40 Informatica 46 (2022) 27--47 W. Khlif et al.

Figure 4: UC-ETD "make a reservation" purpose interface.

Figure 5: Main scenario of the "make a reservation" use case. A Complete
Traceability Methodology Between UML Diagrams and... Informatica 46
(2022) 27--47 41

     Parameter expressing the input of the action g)Out              on the "Add Parallel Actions" button or "Add
     Parameter expressing the output of the action, and h)           Sequential Actions" in the corresponding bloc.
     boolean value corresponding to each state of the            −   Addition of an alternative scenario and /or errors:
     action that can be Considered, IsIgnored, IsNegative.           Figure 6 and Figure 7 illustrate, respectively, the
     To add a nominal scenario in a specified bloc, click            alternative and error scenarios. Each alternative or
                                                                     error scenario is composed of two blocks where the

Figure 6: Alternative scenario of the "make a reservation" use case.

Figure 7: Error scenario of the "make a reservation" use case. 42
Informatica 46 (2022) 27--47 W. Khlif et al.

      user enters the following information: The first bloc      concepts which we added in the UC textual description
      contains the scenario title, guard condition of the        (e.g., parallel, sequence, loop, conditional, break, etc.).
      event triggering the scenario, the start action at the     For instance, the designer needs to trace the ‘parallel’
      alternative scenario level and the return action number    fragment in the enriched textual description by checking
      if it exists. We note that the alternative scenario may    the list of parallel fragments which are available in a list
      contain conditional and/or iterative control structures.   box as shown in Figure 9. Next, we apply the similarity
      In addition, it is possible to depict nested blocs. For    measure LSI between the XML of the selected parallel
      instance, an iterative control structures can be nested    fragment and the related UML diagrams; and the source
      in an alternative control structures and vice versa.       code based on the defined traceability rules.
      Besides, each bloc includes the list of actions
      executed in a parallel or sequential way. For each         5.2.2    Similarity calculator
      action, the user enters the corresponding information      The similarity calculator uses the XML files to determine
      as presented in the nominal scenario (from a to h).        the traceability inter-UML diagrams where the module
      To add a new alternative scenario, click on the "Add       computes the similarity between the selected fragment and
      Conditional Control Structures" button or "add             other UML diagrams (CD, AD, STD and SD), and the
      Iterative Control Structures". Similarly, to add an        traceability between UML diagrams and code where the
      error scenario, click on the "Add Error Structures"        module detects the corresponding elements between the
      button.                                                    UML diagrams and the code.

After entering the enriched textual description of the make We offer to
the designer a pairwise traceability (two a reservation use case, the
XML generator module by two) from the use case diagram to the other
diagrams. produces the XMI document as illustrated in Figure 8. To For
instance, when the designer chooses Use case- generate the XML file
corresponding to the obtained XMI sequence, the system calculates the
similarity between the document, this module uses the standard template
of Star parallel fragment in the use case diagram and each parallel UML
definition. For example, we present as follows the fragment in the
sequence diagrams. To end this purpose, generated XML file corresponding
to the documentation the similarity calculator determines the score of
of the "Make a reservation" use case of our "Car rental" resemblances
between the fragment elements in the case study. enriched description
and all the corresponding parallel fragments in the sequence diagram
(i.e., actor/action in a 5.2 Traceability process module use case
diagram and object/message in the sequence diagrams). The traceability
module is composed of two engines: The fragment having a higher score is
considered as applicability of traceability rules and calculation the
most similar one. To decide upon the obtained score similarity. value,
the constant threshold of 0.70 is widely used in the literature \[17\].
Consequently, we assume that a similarity 5.2.1 Applicability of
Traceability rules value greater than or equal to 0.7 indicates a high
In the traceability detection module, the user firstly similarity
between fragments. Otherwise, the designer imports the UML project. In
this step, the designer should verify the quality of the corresponding
UML- chooses a UC from a list of use cases. Then, the designer diagrams.
Besides, we calculate in the same manner the can choose a specific
fragment to be traced from the similarity between the selected fragment
in the use case selected UC. The presented fragments represent specific
and the source code.

Figure 8: The generated XML file corresponding to the documentation of
the "Make a reservation" use case. A Complete Traceability Methodology
Between UML Diagrams and... Informatica 46 (2022) 27--47 43

Figure 9: Traceability detection interface.

Figure 10: Traceability inter-UML Diagram.

     Table 9 presents the correspondence between control       −   Studying the possibility to derive the implementation

structure fragments (OPT, ATL, WHILE, BREAK, ...) in diagrams from
textual description. the use case, activity, sequence, state transition
diagram − Determine the traceability from code to functional and code.
Figure 10 shows traceability between the requirements based on the
code-Requirement selected parallel fragment in the main scenario which
Traceability Matrix (CRTM) information. includes the 6th and the 7th
actions in the use case "make a reservation" and its corresponding one
in the sequence, References activity, class and state transition
diagrams as well as the source code. \[1\] Y.Wang, Formal description of
the UML architecture and extendibility, in: journal L'object: Software,
Databases, Networks, 2000, Vol.6, No.3. 6 Conclusion \[2\] P. Rempel, P.
Mader, Continuous Assessment of In this paper, we proposed a new method
that determines Software Traceability, in: 38th IEEE/ACM the
traceability at different abstraction levels. The Conference on Software
Engineering Companion, traceability is based on the mapping between an
enriched May, Austin, TX, USA, 2016, pp. 747-748, DOI: textual
description of a use case and UML diagrams (class,
http://dx.doi.org/10.1145/2889160.2892657 sequence, activity and state
transition diagrams) and between UML diagrams and the code. This \[3\]
L. Briand, D. Falessi, S. Nejati, M. Sabetzadeh, T. correspondence is
focused on the control structures Yue, Traceability and SysML Design
Slices to defined in the use case textual description and the Support
Safety Inspections: A Controlled combined fragment used in the sequence
diagrams. Experiment, Simula Research Laboratory, in: journal In our
future works, the following points will be taken of ACM Transactions on
Software Engineering and into consideration: Methodolog, February, 2014,
No.9. − Representing data in textual description to derive
https://doi.org/10.1145/2559978 directly the object and class diagram.
44 Informatica 46 (2022) 27--47 W. Khlif et al.

\[4\] A. Lawgali, Traceability of unified modeling Conference on
Software Maintenance and Evolution, language diagrams from use case
maps, in: Madrid, Spain, 2018, pp. 369-380. DOI: international Journal
of Software Engineering & 10.1109/ICSME.2018.00045 Applications (IJSEA),
Vol.7, No.6, November, 2016, \[15\] S. Palihawadana, C. H. Wijeweera, M.
G. T. N. pp.89-100. Sanjitha, V. Liyanage, I. Perera, D. Meedeniya, Tool
doi:10.5121/ijsea.2016.7607 support for traceability management of
software \[5\] V. Adhav, D. Ahire, A. Jadhav, D. Lokhande, Class
artefacts with DevOps practices, in: Proceedings of Diagram Extraction
from Textual Requirements the Moratuwa Engineering Research Conference,
Using NLP, in: Second International Conference on IEEE, 2017,
pp. 129-134. DOI: Computer Research and Development, (2015),
10.1109/MERCon.2017.7980469 vol.17, No 2, pp. 27-29. \[16\] C. Trubiani,
A. Ghabi, A. Egyed, Exploiting DOI: 10.1109/ICCRD.2010.71 traceability
uncertainty between software \[6\] D. Kchaou, N. Bouassida,
H.Ben-Abdallah, Uml architectural models and extra-functional results,
in: models change impact analysis using a text similarity Journal of
Systems and Software, Vol 125, March technique. In journal of IET
Software, Vol 11, Issue 2017, , 2017, pp.15-34. 1, No 2, February, 2017,
pp. 27-37. DOI: 10.1049/iet- https://doi.org/10.1016/j.jss.2016.11.032
sen.2015.0113 \[17\] A. D. Lucia, , F.Fasano, , R.Oliveto, , G.Tortora,
\[7\] P. Mader, O. Gotel, Towards automated traceability Recovering
traceability links in software artifact maintenance, in: Journal of
Systems and Software, management systems using information retrieval
vol. 85, no. 10, 2012, pp. 2205--2227. methods, in: ACM Transactions on
Software https://doi.org/10.1016/j.jss.2011.10.023 Engineering and
Methodology, Vol 16, No4, 2007, pp.13-63.
https://doi.org/10.1145/1276933.1276934 \[8\] S. Nejati, M. Sabetzadeh,
C. Arora, L.C.Briand, F.Mandoux, Automated change impact analysis \[18\]
M. Lormans, A. van Deursen, Can LSI help between sysml models of
requirements and design, in: Reconstructing Requirements Traceability in
Design Proceedings of the 24th ACM SIGSOFT International and Test? In:
Proceedings of the 10th European Symposium on Foundations of Software
Engineering, Conference on Software Maintenance and ACM, New York, USA,
2016, pp 242-253. Reengineering, IEEE Computer Society, 2006, pp.
https://doi.org/10.1145/2950290.2950293 47-56. DOI: 10.1109/CSMR.2006.13
\[9\] Min, H.S.: 'Traceability Guideline for Software \[19\] A. Marcus,
and J. I. Maletic, Recovering Requirements and UML Design'. in: Journal
of documentation-to-source-code traceability links Software Engineering
and Knowledge Engineering, using latent semantic indexing, in:
Proceedings of the 26, (01), 2016, pp. 87-113. 25th International
Conference on Software Engineering, IEEE Computer Society, Washington,
\[10\] M. Rahimi, J. Cleland-Huang, Evolving software USA, May, 2003,
pp.125--135. trace links between requirements and source code, in:
international journal of Empirical Software \[20\] M. Eyl, C. Reichmann,
and K. Müller-Glaser, Engineering, Vol. 23, 2018, pp.2198--2231. DOI:
Traceability in a Fine Grained Software
https://doi.org/10.1007/s10664-017-9561-x Configuration Management
System, in: international conference on software quality, LNBIP 269,
2017, pp. \[11\] G. Antoniol, G. Canfora, G. Casazza, A. De Lucia and
15--29. DOI: 10.1007/978-3-319-49421-0_2 E. Merlo, "Recovering
traceability links between code and documentation," in IEEE Transactions
on \[21\] A. Shanmugathasan, S., Ratnavel, S., Thiyagarajah, Software
Engineering, vol. 28, no. 10, pp. 970-983, V., Perera, I., Meedeniya,
D., Balasubramaniam, D.: Oct. 2002, doi: 10.1109/TSE.2002.1041053.
'Support for traceability management of software artefacts using Natural
Language Processing'. \[12\] A. Ghabi, A. Egyed, Exploiting traceability
Moratuwa Engineering Research Conf., 2016. pp. 18- uncertainty among
artifacts and code, The Journal of 23. Systems and Software, Vol. 108,
October 2015, pp. 178--192. http://dx.doi.org/10.1016/j.jss.2015.06.037
\[22\] M. Grechanik, KS. McKinley, DE. Perry, Recovering and using
use-case-diagram-to-source-code \[13\] A. Ghannem, H. Mohamed Salah, M.
Kessentini, traceability links, in: Proceedings of the 6th joint H.A.
Hany, Search-Based Requirements Traceability meeting of the European
software engineering Recovery: A Multi-Objective Approach, in: IEEE
conference and the ACM SIGSOFT symposium on Congress on Evolutionary
Computation (CEC), San The foundations of software engineering,
September, Sebastian, Spain, 5-8 June, 2017, 2007, pp.95--104, DOI:
10.1109/CEC.2017.7969440 https://doi.org/10.1145/1287624.1287640 \[14\]
C. Mills, C., J. Javier Escobar-Avila, S. Haiduc, \[23\] A. Cockburn, j.
Highsmith, Agile Software Automatic Traceability Maintenance via Machine
Development: The People Factor. EEE Computer, Learning Classification,
in: IEEE International Volume 34, 2001, pp. 131-133. A Complete
Traceability Methodology Between UML Diagrams and... Informatica 46
(2022) 27--47 45

\[24\] O. S. Dawood, A. E. K. Sahraoui, From Requirements 2018,
pp. 365-393. https://doi.org/10.1007/s10270- Engineering to UML using
Natural Language 017-0619-4 Processing -- Survey Study. European Journal
of \[33\] Yazawa, Y. , Ogata, S., Okano, K., Kaiya, H., Engineering
Research and Science, 2, (1), January, Washizaki, H.: 'Traceability Link
Mining - Focusing 2017, pp. 44-50. on Usability'.41st IEEE Annual
Computer Software \[25\] K. Swathine, N. Sumathi, Study on Requirement
and Applications Conference, Italy, 2, 2017, pp 286- Engineering and
Traceability Techniques in Software 287. Artefacts, in: international
Journal of Innovative \[34\] K.S. Divya, R. Subha, , S. Palaniswami,
Similar Research in Computer and Communication words identification
using naive and tf-idf method'. Engineering, Vol. 5, Issue 1, January
2017. DOI: Information Technology and Computer Science
10.15680/IJIRCCE.2017. 0501016 Journal, pp. 42-47, 2014. \[26\] H.
Kaiya, A. Hazeyama, S. Ogata, T. Okubo, N. \[35\] Kothari, P.R.:
'Processing Natural Language Yoshioka, H. Washizaki,Towards A Knowledge
Base Requirement to Extract Basic Elements of a Class'. for Software
Developers to Choose Suitable Journal of Applied Information Systems,
USA 3, (7), Traceability Techniques, in: Proceedings of the 23rd 2012,
pp. 39-42. International Conference on Knowledge-Based and Intelligent
Information & Engineering Systems, \[36\] A. T. Imam, A. A. Hroob , R.
A. Heisa, The use of 2019, pp. 1075-1084, artificial neural networks for
extracting actions and https://doi.org/10.1016/j.procs.2019.09.276
actors from requirements document'. journal of Information and Software
Technology, 2018, pp.1- \[27\] H. Kaiya, R.Satoa, A.Hazeyamab, S.Ogatac,
15. T.Okubod, T.Tanakae, N.Yoshiokaf, H. Washizakig, Preliminary
Systematic Literature Review of \[37\] Rath, M., Rendall, J., Guo, J.
L.C., Cleland-Huang, J., Software and Systems Traceability, in: 2th
Mader, P., 'Traceability in the Wild: Automatically International
Conference on Knowledge Based and Augmenting Incomplete Trace Links'.
IConf on Intelligent Information and Engineering of the 10th Software
Engineering, May 27-June 3, Sweden, 2018, European Conference on
Software Maintenance and pp. 834--845. Reengineering, IEEE Computer
Society, 2006, pp. \[38\] L. G. P. Murta, A. van der Hoek, C. M.
L.Werner, 47-56. DOI: 10.1109/CSMR.2006.13 Archtrace: policy-based
support for managing \[28\] C. Trubiani, A. Ghabi, A. Egyed, Exploiting
evolving architecture-to implementation traceability traceability
uncertainty between software links, in: 21st IEEE/ACM International
Conference on architectural models and extra-functional results, in:
Automated Software Engineering, Tokyo, Japan, Journal of Systems and
Software, Vol 125, March 2006, pp. 135--144. DOI: 10.1109/ASE.2006.16
2017, , 2017, pp.15-34. \[39\] L. G. P. Murta, A. van der Hoek, C. M.
L.Werner, https://doi.org/10.1016/j.jss.2016.11.032 Continuous and
automated evolution of architecture- \[29\] S. Maro, A. Anjorin, R.
Wohlrab, J.P. Steghöfer: to-implementation traceability links, in:
Automated Traceability maintenance: factors and guidelines, in: Software
Engineering Journal, vol. 15, no. 1, 2008, Proceedings of the 31st
IEEE/ACM International pp. 75--107. https://doi.org/10.1007/s10515-007-
Conference on Automated Software Engineering, 0020-6 Singapore,
September 3-7, 2016, pp. 414-425. \[40\] I. D. D. Rubasinghe, A.
Meedeniya, I. Perera, \[30\] S. Maro, J.P. Steghöfer, M. Staron,
Software Towards TraceabilityManagement in Continuous traceability in
the automotive domain: Challenges and Integration with SAT Analyser, in:
Proceedings of the solutions, in: Journal of Systems and Software, Vol
3rd International Conference on Communication, and 141, 2018, pp.85-110.
Information Processing, 2017, ACM, Tokyo. DOI:
https://doi.org/10.1016/j.jss.2018.03.060 10.1145/3162957.3162985 \[31\]
R.Wohlrab, J.-P. Steghöfer, E. Knauss, S. Maro, A. \[41\] I, Pete, D.,
Balasubramaniam, Handling the Anjorin: Collaborative Traceability
Management: Differential Evolution of Software Artefacts A Challenges
and Opportunities, in: 24th IEEE Framework for Consistency Management,
in: 22nd International Requirements Engineering Conference, IEEE
International Conference on Software Analysis Beijing, China, September
12-16, 2016, pp. 216-225. Evolution and Reengineering, 2015, pp.599-600,
doi: DOI: 10.1109/RE.2016.1 10.1109/SANER.2015.7081889 \[32\] M., Broy,
A logical approach to systems engineering \[42\] M. Grechanik, KS.
McKinley, DE. Perry, Recovering artifacts: semantic relationships and
dependencies and using use-case-diagram-to-source-code beyond
traceability - from requirements to functional traceability links, in:
Proceedings of the 6th joint and architectural views, in: journal of
Software and meeting of the European software engineering Systems
Modeling, pp.365-393, Vol.17, Issue 2, conference and the ACM SIGSOFT
symposium on The foundations of software engineering, September, 46
Informatica 46 (2022) 27--47 W. Khlif et al.

     2007, pp.95–104,                                         [51] C.D Manning, M. Surdeanu, J. Bauer, J.R Jenny Rose
     https://doi.org/10.1145/1287624.1287640                       Finkel, S. Bethard, D. McClosk, The Stanford
                                                                   CoreNLP Natural Language Processing Toolkit. In

\[43\] Guo, J., Cheng, J. Cleland-Huang, J.: 'Semantically Proceedings
of the 52nd Annual Meeting of the Enhanced Software Traceability Using
Deep Association for Computational Linguistics, June 22- Learning
Techniques'. Conf on Software 27, 2014, pp.55-60. Engineering, May 2017,
pp. 3-14. \[52\] J.J. Webster, C. Kit, Tokenization as the initial phase
\[44\] Kuang, H., Nie, J., Hu, H., Rempel, P., Lü, J., Egyed, in nlp. In
Proceedings of the 14th conference on A., Mäder, P. : 'Analyzing
Closeness of Code Computational linguistics, Association for
Dependencies for Improving IR-Based Traceability Computational
Linguistics, Volume 4, 1992, pp. Recovery'. Software Analysis Evolution
& 1106-1110. Reengineering, 2017, pp. 68-78. \[53\] H. Saif, M.
Fernandez, Y. He, H. Alani, On \[45\] Kuang, H., Gao, H., Hu, H., Ma, X.
, Lü, J., Mäder, stopwords, filtering and data sparsity for sentiment P.
, Egyed, A.: 'Using Frugal User Feedback with analysis of twitter'. In
LREC'14 Proceedings of the Closeness Analysis on Code to Improve
IR-Based Ninth International Conference on Language Traceability
Recovery'. IEEE/ACM 27th Inter. Conf. Resources and Evaluation, European
Language on Program Comprehension, pp. 369-379, 2019. Resources \[46\]
I. D. D. Rubasinghe, A. Meedeniya, I. Perera, Association, Reykjavik,
Iceland, May 26-31, 2014, Towards TraceabilityManagement in Continuous
pp. 810-817. Integration with SAT Analyser, in: Proceedings of the
\[54\] J.B. Lovins, Development of a stemming algorithm. 3rd
International Conference on Communication, and In Mechanical Translation
and Computational Information Processing, 2017, ACM, Tokyo. DOI:
Linguistics, Vol 11, No.1-2, March, June, 1968, pp.
10.1145/3162957.3162985 22-31. \[47\] I. D. D. Rubasinghe, A. Meedeniya,
I. Perera, \[55\] OMG-UML :OMG-UML, 2015. OMG Unified Software Artefact
Traceability Analyser: A Case- Modeling Language (OMG UML).
formal/2015-03- Study on POS System, in: Proceedings of the 6th 01.
\[Online\]. International Conference on Communications and Broadband
Networking, February 24 - 26, 2018, pp.1- \[56\] D. Bailey, Java
Structures: Data Structures in Java for 5, DOI:10.1145/3193092.3193094
the Principled Programmer, 2end edition, (2007) pp. 528, McGraw-Hill
Science/Engineering/Math. \[48\] H. Tufail, M. F. Masood, B. Zeb, F.
Azam, A Systematic Review of Requirement Traceability \[57\] C. Wohlin,
P. Runeson, M. Höst, M.C. Ohlsson, B. Techniques and Tools, in: 2nd
International Regnell, A. Wesslén 'Experimentation in Software
Conference on System Reliability and Safety Engineering: An
Introduction, 2000. (ICSRS), 20-22 December, Milan, Italy, 2017, DOI:
\[58\] N. Mustafa, Y. Labiche, D. Towey, Mitigating
10.1109/ICSRS.2017.8272863. Threats to Validity in Empirical Software
\[49\] O. Rahmaoui, K.Souali, M. Ouzzif, Improving Engineering: A
Traceability Case Study. 43rd Annual Software Development Process using
Data Computer Software and Applications Conference, Traceability
Management, in: international Journal of USA, July, 2019, pp. 324-329.
Recent Contributions from Engineering, Science & \[59\] Eclipse
Specification. 2011, Available from: IT, 2019, pp.52-58.
http://www.eclipse.org/ https://doi.org/10.3991/ijes.v7i1.10113. \[60\]
L. Frias, A. Queralt, A. Oliv, EU-Rent car rentals \[50\] K. Souali, O.
Rahmaoui, M. Ouzzif, An overview of specification. Technical report,
2003. traceability: Definitions and techniques. 4th IEEE Colloquium on
Information Science and Technology, Morocco, October, 2016, pp.789-793.
47

                                                                                                                                                                                                                       STATE
                                                                                                   USE CASE DIAGRAM                                ACTIVITY DIAGRAM                 SEQUENCE DIAGRAM                 TRANSITION                   Code

Informatica 46 (2022) 27--47

                                                                                                                                                                                                                      DIAGRAM
                                                                             <Opt><needs confirmation>
                                                                             <NumAction 6> < From Actor The Clerk ><To Actor
                                                                  OPT




                                                                             Customer><Type of Result Simple: Boolean > <Action                                                                                                   If (rentalconfirmed)
                                                                             Description Asks the customer if he/she wants to guarantee the                                                                                       { guaranteerental();
                                                                             reservation> <In-Parameter Reservation> <Out-Parameter
                                                                             IsValidated >< IsConsidered 1>< IsIgnored 0>< IsNegative 0>
                                                                             <restart at Num “6” in SN>
                                                                             Begin <Event, begin at Num 2 in SN>                                                                                                                  String username, pword;
                                                                                                                                                                                                                                  if (userObj.getType()
                                                                             <IF>< the customer does not exists>                                                                                                                  !=UserType.MEMBER)
                                                                             <NumAction 1> < From Actor The Clerk >< To Actor The                                                                                                  { introducecustumer();
                                                                             customer>< Type of Result Customer (name, ID, birthdate,                                                                                             else
                                                                                                                                                                                                                                  Confirmlogin();}
                                                                  ALT




                                                                             address, telephone)>< Action Description Introduce a new
                                                                             costumer> <In-Parameter Customer (name, ID, birthdate, address,
                                                                             telephone)> <Out-Parameter Customer >< IsConsidered 1><
                                                                             IsIgnored 0>< IsNegative 0>
                                                                             <Else > <restart at num 3 in SN>
                                                                             <begin at Num 3 in SN> <Do>
                                                                                                                                                                                                                                  Do
                                                                             <NumAction 1>< From Actor the clerk ><To Actor the                                                                                                   Specifyperiod();

A Complete Traceability Methodology Between UML Diagrams and...

                                                                             reservation><Type of Result Simple>< Action Description                                                                                              Verifyperiod();
                                                                             Specifies the period ><In-Parameter period > <Out-Parameter                                                                                          While (period is correct and does
                                                                                                                                                                                                                                  not overlaps with other
                                                                             period >< IsConsidered 1>< IsIgnored 0>< IsNegative 0>
                                                                  Do while




                                                                                                                                                                                                                                  reservations)
                                                                             <NumAction 2> < From Actor The clerk><To Actor The
                                                                             reservation><Type of Result correct yes/no>< Action Description
                                                                             Verify the period>] [<In-Parameter period>] [<Out-Parameter
                                                                             correct yes/no >]< IsConsidered 1>< IsIgnored 0>< IsNegative 0>
                                                                             <While><period is correct and does not overlaps with other
                                                                             reservations >
                                                                             <restart at Num “6” in SN>
                                                                             <Parallel>                                                                                                                                           public class rentalagreementThread
                                                                                                                                                                                                                                  implements Runnable {
                                                                              <NumAction 6>< From Actor The Clerk >< To Actor The                                                                                                 Thread rentalagreementThread;
                                                                             agreement> < Type of Result Entity>< Action Description Create                                                                                       Public rentalagreementThread (int
                                                                  PARALLEL




                                                                             the reservation agreement ><In-Parameter rental agreement: ID                                                                                        agreement, int IDloc, int IDMAT,
                                                                                                                                                                                                                                  date dat)
                                                                             customer, price, ID reservation> <Out-Parameter Rental                                                                                               {this.agreement= agreement;
                                                                             agreement >< IsConsidered 1>< IsIgnored 0>< IsNegative 0>                                                                                            This.idloc=IDloc;
                                                                                                                                                                                                                                  This.IDMAT;
                                                                             <NumAction 7> < From Actor The Clerk >< To Actor The                                                                                                 This.dat=dat;}
                                                                                                                                                                                                                                  rentalagreementThread = new Thread
                                                                             agreement>< Type of Result Entity>< Action Description Offer a                                                                                       ( this , " OfferDiscountthread");
                                                                             discount to the customer ><In-Parameter Discount rental                                                                                              UnThread.start(); }
                                                                             agreement : Discount,ID agreement, ID cusotmer> <Out-Parameter                                                                                       public void run ( ) {
                                                                                                                                                                                                                                  //....second thread actions here
                                                                             Discount rental agreement >< IsConsidered 1>< IsIgnored 0><                                                                                          public OfferPointsPayment(); }}
                                                                             IsNegative 0>
                                                                                      Table 9: Traceability between control structure fragments in the use case, Activity, sequence state transition diagrams and code

48 Informatica 46 (2022) 27--47 W. Khlif et al. 
