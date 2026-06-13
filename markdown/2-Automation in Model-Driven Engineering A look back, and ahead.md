                                         Automation in Model-Driven Engineering: A look back, and ahead

                                         LOLA BURGUEÑO∗ , ITIS Software, University of Malaga, Spain
                                         DAVIDE DI RUSCIO∗ , University of L’Aquila, Italy
                                         HOUARI SAHRAOUI∗ , DIRO, Université de Montréal, Canada
                                         MANUEL WIMMER∗ , Johannes Kepler University Linz, Austria
                                         Model-Driven Engineering (MDE) provides a huge body of knowledge of automation for many diﬀerent engineering tasks, especially

arXiv:2405.18539v2 \[cs.SE\] 10 Feb 2025

                                         those involving transitioning from design to implementation. With the huge progress made in Artiﬁcial Intelligence (AI), questions
                                         arise about the future of MDE, such as how existing MDE techniques and technologies can be improved or how other activities that
                                         currently lack dedicated support can also be automated. However, at the same time, it has to be revisited where and how models
                                         should be used to keep the engineers in the loop for creating, operating, and maintaining complex systems. To trigger dedicated
                                         research on these open points, we discuss the history of automation in MDE and present perspectives on how automation in MDE
                                         can be further improved and which obstacles have to be overcome in both the medium and long-term.

                                         ACM Reference Format:
                                         Lola Burgueño, Davide Di Ruscio, Houari Sahraoui, and Manuel Wimmer. 2018. Automation in Model-Driven Engineering: A look
                                         back, and ahead. J. ACM 37, 4, Article 111 (August 2018), 24 pages. https://doi.org/XXXXXXX.XXXXXXX


                                         1 Introduction
                                         Bézivin deﬁned the term Model-Driven Engineering (MDE) in 2005 as follows: “MDE is a software engineering method-
                                         ology which uses formal models, i.e., models which are machine-readable and processable, to produce executable software
                                         systems semi-automatically” [24]. The main idea behind formal models is to provide abstractions of software systems
                                         to manage their complexity. Based on these abstractions, as they are machine-readable and even processable, automa-
                                         tion techniques are provided, e.g., to generate executable software [167], which was the main focus 20 years ago in
                                         the pioneering phases of MDE. However, other automation concerns soon emerged and have been studied, such as
                                         analysing models by transforming them into formal domains such as model checkers. Model-to-model transforma-
                                         tions have been used for this purpose. Model-to-code transformations have been developed to automate the transition
                                         from design models to code-based implementations. To complete the picture, code-to-model transformations have
                                         been used to reverse engineer existing software systems such as legacy systems. A comprehensive study on diﬀerent
                                         transformation intents is provided in [127].
                                            Soon the community realized that transformations are complex software systems themselves [171]. Hence, signiﬁ-
                                         cant research eﬀorts have been spent developing model transformation languages to develop automation support in
                                         ∗ All the authors contributed equally to this research.


                                         Authors’ Contact Information: Lola Burgueño, ITIS Software, University of Malaga, Spain, lolaburgueno@uma.es; Davide Di Ruscio, University of
                                         L’Aquila, Italy, davide.diruscio@univaq.it; Houari Sahraoui, DIRO, Université de Montréal, Canada, sahraouh@iro.umontreal.ca; Manuel Wimmer, Jo-
                                         hannes Kepler University Linz, Austria, manuel.wimmer@jku.at.

                                         Permission to make digital or hard copies of all or part of this work for personal or classroom use is granted without fee provided that copies are not
                                         made or distributed for proﬁt or commercial advantage and that copies bear this notice and the full citation on the ﬁrst page. Copyrights for components
                                         of this work owned by others than the author(s) must be honored. Abstracting with credit is permitted. To copy otherwise, or republish, to post on
                                         servers or to redistribute to lists, requires prior speciﬁc permission and/or a fee. Request permissions from permissions@acm.org.
                                         © 2018 Copyright held by the owner/author(s). Publication rights licensed to ACM.
                                         Manuscript submitted to ACM


                                         Manuscript submitted to ACM                                                                                                                           1

2 Burgueño, Di Ruscio, Sahraoui, and Wimmer

terms of transformations. In parallel, language engineering approaches
based on metamodeling techniques \[6\] have been emerging, which allow
for the eﬃcient and eﬀective development of modeling languages and
accompanying modeling tool support such as model editors, validators,
and storage facilities. These infrastructures enabled the de- velopment
of domain-speciﬁc modeling languages (DSMLs) \[55\] in addition to
general-purpose modeling languages such as UML. By having abstractions
as models combined with automation support, the promise of MDE is to
allow engineers to focus on the problem domain, i.e., which systems
should be realized, rather than on the solution domain, i.e., how the
system is realized. Achieving this promise involves addressing several
challenges, which have been discussed in various studies. In \[74\], the
authors discuss challenges associated with modeling languages, e.g., how
to engineer DSMLs, achieving separation of concerns to deal with
complexity, and model manipulation/management mostly supported by
transformations. In \[136\], the authors discuss how MDE may be used
even beyond software, raising the need for interdisciplinary modeling
support, e.g., for socio-technical systems. The latter requires model
integration, consistency, and strong tool support. Finally, in a more
recent work \[38\], the authors discuss important aspects of MDE, such
as foundational, social, community, domain, and tool aspects. However,
we are not aware of any report explicitly focusing on the automation
aspect of MDE and how this aspect will develop toward 2030. It is
important to close this gap as with the recent and expected advances of
AI, the current automation techniques and technologies of MDE are highly
impacted as well, and new ones may be developed to support additional
tasks in the software engineering process that are not targeted by
existing technologies. Thus, a discussion on the role of models, MDE
methodologies, and engineers in this new era is required to frame the
potential future of MDE. This is also of paramount importance for the
further adoption of MDE in diﬀerent domains. Previous studies have
reported successful adoptions of MDE for particular domains (e.g., see
\[47, 60, 92, 116, 122, 140, 163, 186\]). However, challenges and needs
for the adoption of MDE have been reported \[87, 90\] recently, which
may be tackled with improved automation capabilities such as improving
the interoperability of MDE tools as well as providing sophisticated
model management support to allow for agile processes. Moreover, for
successful adoption, it is essential to rely on high-quality models (in
terms of completeness, correctness, and consistency with the systems
realized) that evolve to reach high automation levels \[87\]. Of course,
reaching these high-quality levels requires additional eﬀorts, which may
be mitigated by the application of AI in the future. To tackle these
challenges, important questions have to be answered, such as which
phases can be additionally automated, e.g., should we directly go from
natural language requirements to code, or is there still, mainly because
of the enhanced AI capabilities, a sweet spot for using models in such
highly automated processes? Can we now ease and automate the modeling
process itself and reach, at the same time, a higher degree of
automation in the synthesis process, such as code generation? These
questions are important for the foundations of MDE, but at the same
time, also for recent application areas such as low-code/no-code
development \[162\] and digital twin engineering \[183\]. This article
pursues two primary objectives. The ﬁrst is to conduct a retrospective
analysis of how automation needs in Model-Driven Engineering (MDE) have
historically been addressed through the application of various enabling
tech- nologies. The second objective is to explore future perspectives
on MDE automation. These forward-looking considera- tions are inﬂuenced
by two key factors. First, the evolution and transformation of existing
paradigms, such as the rapid advancements in machine learning and
artiﬁcial intelligence, are redeﬁning the potential for automation.
Second, the emergence of novel paradigms, like quantum computing or
neuromorphic computing, presents unprecedented oppor- tunities to
rethink the scope and scale of automation in MDE. Additionally, the
growing emphasis on non-functional concerns, including security,
sustainability, and ethical considerations, introduces new dimensions to
how automation Manuscript submitted to ACM Automation in Model-Driven
Engineering: A look back, and ahead 3

solutions are envisioned and implemented. It is important to highlight
that future perspectives on automation are not merely responses to the
limitations of previous approaches. Instead, they are driven by the
creation of new opportu- nities arising from the continuous evolution of
technology and the emergence of cutting-edge paradigms. This dual focus
on past achievements and future possibilities aims to inspire innovative
directions for advancing automation in MDE. To achieve these objectives,
we began by surveying key activities in MDE that require automation
(Section 2.1). Sub- sequently, we identiﬁed the primary technologies
that have enabled varying degrees of automation for these activities and
gathered illustrative examples of representative work (Section 2.2).
While we collected a substantial body of work, it is important to note
that we did not conduct a systematic literature review, as this would
extend beyond the scope of our article. The third step involved
synthesizing our ﬁndings by mapping tasks to automation technologies,
thereby completing the overall picture (Section 2.3). For the
exploration of future automation perspectives until 2030, we ex- amined
both challenges and opportunities across four critical dimensions:
advancements in artiﬁcial intelligence, the role of human factors, the
diversity of application domains, users, and modeling interfaces, and
the growing importance of non-functional concerns such as security and
sustainability (Sections 3.1 to 3.4).

2 Achievements in Automation In this section, we present the evolution
of MDE automation over the years. We divide it into two subsections:
Sec- tion 2.1 presents the activities and MDE that require automation,
and Section 2.2 presents the primary technologies that have enabled such
automation together with examples of them..

2.1 Targeted Automation Activities1 In this section, we categorize and
discuss the activities that have been targeted for automation within the
MDE ﬁeld, organizing them according to the categories outlined in the
contents of a Model-Based Software Engineering Body of Knowledge \[44\].
It should be noted that while these basic tasks serve as foundational
components, they can be composed into more complex automation pipelines
for diﬀerent purposes.

2.1.1 Modeling. The task of modeling itself, i.e., creating models as
abstractions of software and systems, has been the target of automation
for many years. In particular, speciﬁc eﬀorts have been put into
approaches for the creation of DSLs and DSVLs, for instance, using
frameworks and tools such as JetBrains MPS2 or the Eclipse Modeling
Framework (EMF)3 . Modeling tools have also helped improve MDE workﬂows
and reduce the manual eﬀort required. Examples of these tools are
Papyrus4 and MagicDraw5 . Other modeling activities that over the years
have been the target of automation are model generation \[164\], model
search \[123\], model completion \[52\] and model classiﬁcation \[138\].
A long-lasting line of work to automate the execution of models, which
is worth emphasizing, has been heavily addressed by researchers working
on mod- els@runtime \[21\], where the models of a system need to be
up-to-date while the system is running at the same time that is used to
adapt the runtime behavior. This line of work is a prominent example of
having automated modeling in use.

1 Note that we will refer to activities as activities or as tasks
indiﬀerently. 2 https://www.jetbrains.com/mps 3
https://eclipse.dev/modeling/emf 4 https://eclipse.dev/papyrus 5
https://www.magicdraw.com

                                                                                               Manuscript submitted to ACM

4 Burgueño, Di Ruscio, Sahraoui, and Wimmer

2.1.2 Model Quality Management. Signiﬁcant eﬀorts have been made to
automate activities to ﬁnd defects, faults, and failures in models and
modeling processes. Numerous model validation and veriﬁcation techniques
exist that automate quality checks, such as correct syntax, semantics,
structure, behavior, etc., of models to ensure that any inconsistencies
or errors are detected and rectiﬁed at the model level and as soon as
possible. For instance, model checking has been automated through
algorithms that check the temporal behavior of a software or system
model against certain properties or speciﬁcations, ensuring they meet
speciﬁed requirements or constraints, and there are numerous languages
and mature tools available \[23, 88, 118\]. Automated testing techniques
based on models (a.k.a. model-based testing) have been developed, too,
where models are used to generate test cases automatically (e.g.,
\[147\]). Traditionally, this method has helped identify potential
problems early in the development process, signiﬁcantly reducing cost
and eﬀort in the testing phase. Moreover, in recent years, model-based
testing automation has gained relevance due to the rise of digital twins
\[25\], which impose the need for streamlining testing, and the adoption
of new development methodologies such as agile, continuous development,
integration, and delivery \[95\] where the process of executing test
cases and analyzing the results needs to be automated in continuous
integration/continuous deployment (CI/CD) pipelines.

2.1.3 Model-based execution. It is necessary to have executable models
\[111\] and simulation facilities for testing, debugging, or analysis
purposes. In this regard, executable UML models are popular and usually
use action languages to deﬁne the behavior of the system (e.g., SOIL
\[166\], or FUML6 ). Over the years, the automation of model-based
execution, simulation, and co-simulation have seen numerous ad-
vancements, moving from manual processes that required human
intervention---e.g., to set up simulations and adjust parameters based
on expert knowledge and observations---to highly automated processes and
tools. For instance, there has been the standardization of an Action
Language as part of the OMG UML Speciﬁcation for the execution of UML
models \[142\] and tools for simulation such as Modelica7 , which are
widely used by system engineers. There is also available a series of
interpreters for modeling languages, both graphical and textual, many of
them fully integrated into modeling environments, e.g., as in the case
of the USE approach \[78\]. Furthermore, there have been eﬀorts to come
up with model execution support by developing dedicated interpreters for
domain-speciﬁc modeling languages, e.g., see initiatives such as GeMOC
(Globalization of Modeling Languages)8 focusing on the development of
technologies and methodologies to generate dedicated execution-oriented
tools for models such as model testing and debugging capabilities based
on the deﬁned operational semantics of the modeling languages.

2.1.4 Model Transformations. Model transformations constitute a
fundamental aspect of MDE and serve as the back- bone for automating the
transition from high-level abstractions to executable code, simulations,
or other models. These are perhaps the most exploited automation and
automated activity in MDE, where, among other uses, models are auto-
matically transformed into executable code in various programming
languages. They can be classiﬁed into model-to- model transformations
(M2M), model-to-text (M2T) transformations, and text-to-model (T2M)
transformations \[111\]. M2M transformations receive a model as input
and provide another model as output (e.g., a BPMN model can be trans-
formed into a Petri Net model). M2T transformations provide the ability
to autogenerate text from models, contributing

6 https://www.omg.org/spec/FUML 7 https://modelica.org 8
https://gemoc.org

Manuscript submitted to ACM Automation in Model-Driven Engineering: A
look back, and ahead 5

signiﬁcantly to software development automation, where the models serve
as the primary artifact and, from them, tex- tual artifacts are
automatically generated \[110\] such as code (e.g., C# code from UML
state machines), documentation, or other artifacts (such as JSON ﬁles
for data exchange). T2M transformations are used to reverse engineer
code in models, as well as other purposes such as documentation
generation \[191\] (for example, to convert legacy code into a software
architecture model). At the same time, model transformations have
enabled and pushed forward automation in software engineering; they have
also been the target of automation. This automation leverages speciﬁc
languages, execution engines, tools, and frameworks, as described below.
One of the primary means of automating model transformations is through
dedicated transformation languages. These languages provide constructs
that describe how model elements must be mapped to their equivalent
elements. Examples of such languages include ATL \[96\], QVT \[141\],
ETL \[115\], and Hen- shin \[4\] to name just a few---for a survey see
\[97\]. Transformation engines9,10 \[46, 58, 185\] are specialized
software components that execute the transformation rules deﬁned in a
transformation language against source models to generate target ones.
These engines manage the com- plexities of navigating model structures,
applying transformation rules, resolving dependencies, and ensuring the
in- tegrity of the generated models. Transformation engines can be
standalone tools or integrated into broader MDE platforms, providing a
seamless experience from model editing to transformation. Model
transformations must be well-integrated with the software development
environment for automation to be truly eﬀective. This includes providing
user-friendly interfaces for deﬁning and managing transformations. Such
integration enables developers to incorporate model transformations
seamlessly into their workﬂows, automating repetitive tasks and
facilitating more agile and iterative development processes. Some eﬀorts
include the Epsilon Play- ground \[114\] and AToMPM \[180\], among
others.

2.1.5 Model Management. Model management involves diﬀerent activities,
which we discuss in the following. Auto- mated model evolution involves
strategies for evolving models to reﬂect changes in requirements or
design. Automation can be achieved through predeﬁned transformation
rules or templates that apply changes across models, ensuring con-
sistency and reducing manual eﬀort. Languages such as Epsilon \[114\] or
ATL \[96\] support automated transformations that facilitate model
evolution. When metamodels evolve, models that conform to those
metamodels may become invalid and must be adapted to remain consistent
with the new version of the metamodel \[85\]. Automated model migration
is needed to update models. So far, this has been achieved in numerous
ways, for instance, by means of model transformations \[161, 174\] or
with dedicated languages such as Epsilon Flock \[158\]. Maintaining
models to ensure their accuracy and relevance over time can be automated
through continuous integra- tion tools that integrate model changes, run
automated validations, and report inconsistencies or errors. Automated
testing frameworks for models also contribute to maintenance by ensuring
that model updates do not break existing functionalities. Since models
are software artifacts, version control systems are beneﬁcial for
keeping up with current develop- ment needs. Given the diﬀerent nature
of models w.r.t. code, approaches to deal with models are needed. For
instance, EMFStore \[112\] or Connected Data Objects (CDO)11 provide
automated support for model versioning.

9 https://projects.eclipse.org/projects/modeling.mmt.qvt-oml 10
https://wiki.eclipse.org/ATL/EMFTVM 11 https://www.eclipse.org/cdo

                                                                                              Manuscript submitted to ACM

6 Burgueño, Di Ruscio, Sahraoui, and Wimmer

    Automated model diﬃng tools compare and identify diﬀerences between model versions. EMF Compare12 is an

example of a tool that provides automated support for model comparison,
highlighting diﬀerences and conﬂicts within models developed using EMF
(Eclipse Modeling Framework)13 . Merging model changes, especially in
collaborative environments or when reconciling parallel development
eﬀorts, require sophisticated automation to handle conﬂicts and ensure
model integrity. Tools like EMF Compare14 also sup- port automated model
merging by providing strategies and user interfaces to resolve conﬂicts
and integrate changes from diﬀerent model versions seamlessly.
Refactoring models is the process of restructuring the model while not
modifying its original functionality or be- havior. This process can be
automated using model transformation languages and refactoring
libraries. Tools and frameworks, such as Epsilon \[114\] or EMF Refactor
\[5\], provide automated support for model refactoring.

2.2 Automation-Enabling Techniques From the very beginnings of MDE,
automation emerged as a fundamental pillar. Numerous works have employed
direct approaches based on heuristics to automate or semi-automate
certain activities directly on the models' representations. Other works
have relied on established automation technologies to achieve this
automation. In the remainder of this section, we discuss four families
of these technologies: formal methods, search-based techniques,
extensional and inten- sional knowledge engineering approaches, and
artiﬁcial intelligence.

2.2.1 Formal Methods. Due to their rigor and precision, formal methods
have been utilized to specify, analyze, and verify various MDE
artifacts. The literature is abundant with contributions on the
application of formal methods for automating various MDE tasks. However,
we limit ourselves to a few examples of their most common uses. The ﬁrst
family of applications targets the analysis and veriﬁcation of UML
models. This involves techniques such as model checking \[86\],
constraint satisfaction problem solving \[66\], Boolean satisﬁability
\[173\], and rewriting logic \[65\]. Another family of application of
formal methods concerns the generation of models for metamodel or
transformation testing. Here again, a variety of techniques have been
explored, including typed graph transformation \[3\], equivalence
partitioning \[48\], and satisﬁability modulo theories \[169\], to name
a few. A third noteworthy family, although few works have covered it, is
model completion. Its automation is achieved, for example, through
ﬁrst-order logic using Alloy \[170\]. Formal methods have also been
applied to deﬁne the operational semantics of modeling languages, e.g.,
by using Maude and graph transformations \[70, 151\]. Formal methods
have also been employed for model version- ing \[181, 193\], including
diﬃng and merging, which have been managed in terms of graph
modiﬁcations and graph transformations. Although formal methods have
contributed to explicitly modeling automation problems and provided
eﬀective solu- tions for some MDE task automation, their use is limited
by several issues. The most well-known challenge is scalability. Formal
methods often struggle when applied to large and complex models due to
the computational cost of techniques like model checking and constraint
solving. Moreover, certain MDE tasks, such as creative or exploratory
modeling, are not easily automatable using solely formal methods.
Finally, despite their potential, tools supporting formal methods often
lack a direct integration with mainstream MDE environments, which
hampers seamless workﬂows.

12 https://eclipse.dev/emf/compare 13 https://eclipse.dev/modeling/emf
14 https://eclipse.dev/emf/compare

Manuscript submitted to ACM Automation in Model-Driven Engineering: A
look back, and ahead 7

2.2.2 Search-based Techniques. These techniques have emerged as valuable
tools for automating various MDE activi- ties. This line of research
views the automation of many MDE tasks as optimization problems, which
can be eﬀectively tackled using search-based methods \[33\]. One of the
earliest applications of this concept was in the domain of model
transformations, particularly using examples of input-output models.
Researchers utilized search-based techniques for model diﬃng based on
refactoring detection\[102\], model merging \[131\], and to perform
model transformations \[103\] and even to learn transformation rules
\[10, 71\]. Moreover, search-based techniques have been instrumental in
generating test suites to validate these transforma- tions. Test cases,
often in the form of input-output models, are generated to ensure the
correctness of the transforma- tions \[93\]. Additionally, model samples
play a crucial role in testing metamodels. Search-based techniques have
been employed to either generate those model samples \[80\] or to
perform model selection \[18\] to ensure the robustness and eﬀectiveness
of metamodels. In cases where metamodel descriptions lack
well-formedness rules, these rules can be recovered from examples of
both valid and invalid models. Genetic programming techniques have been
utilized for this purpose, aiding in the reﬁnement of metamodels \[19\].
Another signiﬁcant application of search-based techniques in MDE is
repairing modeling artifacts. The evolution of metamodels can invalidate
many associated artifacts due to their dependency on the type systems
deﬁned within the metamodels. Evolutionary algorithms have been employed
to repair models \[104\], OCL constraints \[17\], and model
transformations \[105\]. Similarly and independently from the evolution,
search-based approaches have been used to repair errors in MDE artifacts
such as transformations \[187\]. In the realm of design space
exploration (DSE), where ﬁnding the best design instance for a given
problem is chal- lenging, search-based techniques have shown invaluable
capabilities. DSE, framed as an optimization problem, involves exploring
alternative models to identify those that meet speciﬁc criteria \[1\].
The relation between MDE and search-based techniques is also a tale of
cross-fertilization. Indeed, MDE contributed to enriching search
techniques through improved encoding of optimization problems and their
subsequent resolution, e.g., \[28, 41, 62, 94\]. In summary,
search-based techniques have facilitated the automation of various MDE
tasks by oﬀering algorithms not only to solve speciﬁc instances but also
to learn actionable knowledge that can be leveraged to streamline these
tasks. However, this family of techniques has also several limitations.
Tasks involving large search spaces are chal- lenging to manage and
often result in suboptimal solutions, particularly when determining the
appropriate search parameters is diﬃcult. Furthermore, the eﬀectiveness
of search-based techniques heavily relies on the quality of the
objective functions guiding the search. Deﬁning suitable, measurable,
and well-balanced objectives within the context of MDE can be a
signiﬁcant challenge. Lastly, the solutions generated by search-based
techniques may overﬁt speciﬁc problem instances, reducing their
reusability and limiting their generalization to other MDE scenarios.

2.2.3 Extensional and Intensional Knowledge. The automation or
semi-automation of a task requires knowledge that can be operationalized
through software tools. This knowledge may include elements that enable
the direct execution of the task. It can also be exploited within a
complex automation process. In the context of MDE, knowledge often
appears extensionally in some kind of repositories, particularly in the
form of sets of artifacts such as models \[153\] or transformations15 .
It can also be intentionally represented, typically through ontologies.

15 https://eclipse.dev/atl/atlTransformations

                                                                                                Manuscript submitted to ACM

8 Burgueño, Di Ruscio, Sahraoui, and Wimmer

    Among the artifacts within MDE, model sets have been extensively leveraged to provide support in modeling tasks.

These collections of models are employed via search engines to propose
models or model fragments aligning with speciﬁc criteria articulated by
modelers, either in textual or pre-deﬁned partial model forms \[14, 29,
124\]. The alternative category of knowledge, termed intensional,
integrated into MDE task automation, encompasses ontologies. These
structures provide organized descriptions of real-world objects, which
can be utilized for crafting domain-speciﬁc languages or models \[175\].
Due to their inherent semantics, ontologies also serve in model
veriﬁcation and debugging processes \[134, 190\], or for model matching
\[98\]. Additionally, ontologies can be harnessed through design
patterns to automate the creation of meta-models or models \[6, 143\].
Lastly, the integration of extensional and intensional knowledge can
enhance automation eﬀorts. For instance, on- tologies can streamline
search requests and responses within model repositories \[154\].
Capturing and formalizing the knowledge required for automation, whether
as artifacts or ontologies, is a complex and resource-intensive task.
Automation solutions that rely on both types of knowledge are often
highly domain- speciﬁc, limiting their generalizability and requiring
signiﬁcant eﬀort to adapt the knowledge for use in new domains. The
eﬀectiveness of extensional knowledge depends greatly on the quality,
quantity, and relevance of the artifacts in the repository. Currently,
existing repositories are often restricted to speciﬁc formalisms, such
as UML class dia- grams, making it challenging to assess the quality and
representativeness of the artifacts. Additionally, maintaining large
collections of models or transformations can become burdensome, with
ensuring that repositories remain consis- tent and up-to-date posing a
signiﬁcant challenge. Finally, although ontologies provide semantic
richness, designing and maintaining them for complex domains is both
time-intensive and requires specialized expertise in knowledge
engineering.

2.2.4 Artificial Intelligence. Like many other disciplines, artiﬁcial
intelligence has been extensively used as an automa- tion technology for
MDE. From the early days of MDE until now, rule-based systems have been
employed to automate model transformations, utilizing either
general-purpose rule languages such as NéOpus \[149\] or speciﬁcally
dedicated ones like ATL \[96\]. Soon after, the notion of supporting
modelers in writing transformation rules emerged. Machine learning
techniques were applied to derive transformation rules from examples
using supervised learning \[188\] or unsupervised learning \[64\]. More
recently, with advancements in machine learning research, considerable
eﬀort has been dedicated to assisting in metamodeling and modeling
activities. This includes the utilization of techniques such as GNNs
\[63\] and LSTM \[195\]. Furthermore, research has been focused on model
transformations using reinforcement learning \[68\] and LSTM archi-
tectures \[43\]. Various machine learning algorithms have also been
applied for metamodel classiﬁcation \[138\] and model classiﬁcation
\[126\], as well as for model repair \[11\] and model generation
\[126\]. However, these initiatives often face challenges due to the
diﬃculty of training machine learning models, particularly given the
scarcity of data. The remarkable power of Large Language Models (LLMs)16
has partially alleviated this problem. Thus, automating several modeling
tasks with little or no training data became possible. However, the
eﬀectiveness of using LLMs for this purpose varies, as Camara et
al. \[50\] highlight. Ben Chaaben et al. explored the application of
LLMs for static and dynamic domain-model completion \[52\]. Model
generation with LLMs has also garnered signiﬁcant interest among
researchers, encompassing diverse model types such as goal models \[54\]
and static domain models \[56\].

16 Note that a model in AI and a software model do not refer to the same
type of model. In the AI ﬁeld, a model is the result of analyzing
datasets to ﬁnd patterns and make predictions (e.g., it could be a
trained neural network or a statistical model). To avoid confusion, in
this work, each time we refer to an AI model, we always refer to it with
a precise name (e.g., AI model, ML model, Language model, ...) and never
as "model" alone. When we use "model" alone, it always refers to a
software model. Manuscript submitted to ACM Automation in Model-Driven
Engineering: A look back, and ahead 9

                                                                                                             Enabling Technologies
                            Activities
                                                                   Direct     Formal Methods   Know. Eng.      Traditional AI* Search Techniques   Deep Learning** LLMs
                              Model generation                    [35, 81]+      [8, 168]+                         [126]            [1, 93]+                       [54, 56]
                              Model search                       [15, 128]+                       [124]

Modeling Model completion \[32, 117\]+ \[170, 177\]+ \[29, 45\]+ \[137\]
\[63\] \[52, 184\] Models at runtime \[22, 73\]+ \[40, 165\]+ \[20,
83\]+ \[67, 109\] Model classiﬁcation \[13, 160\]+ \[126, 138\] \[139\]
Analysis / Veriﬁcation \[16, 130\]+ \[79, 151\]+ \[134\] \[11, 192\]+
Model quality management Testing / Debugging \[9, 145\]+ \[7, 86\]+
\[190\] \[18, 80\]+ \[125, 148\]+ \[49\] Model transformations \[26,
58\]+ \[27, 75\]+ \[98, 159\]+ \[68\] \[10, 103\]+ \[43, 119\] \[39,
100\] Model based execution \[57, 135\]+ \[70, 151\]+ Model
(co-)evolution \[84, 161\]+ \[120, 182\]+ \[104, 106\]+ \[101\] Model
migration and maintenance \[85, 158\]+ \[77\] \[12\] Model management
Model versioning / diﬀ / merge \[36, 113\]+ \[181, 193\]+ \[98\] \[102,
131\]+ Model refactoring \[146, 179\]+ \[26, 132\]+ \[76, 133\]+ \*
Excluding Search-based Techniques \*\* Excluding LLMs Table 1. Overview
of MDE activities and enabling technologies.

Unlike other ﬁelds, the MDE research community has yet to fully
capitalize on the potential of AI and, in particu- lar, deep learning
(DL) and large language models (LLMs) for automation, largely due to
several inherent challenges. One major obstacle is the scarcity,
fragmentation, and inconsistency of MDE-speciﬁc datasets, which are
essential for eﬀectively training and ﬁne-tuning DL models. Moreover,
MDE involves diverse, highly structured artifacts closely tied to
domain-speciﬁc languages (DSLs). Adapting DL architectures to
accommodate this diversity and to work seam- lessly with domain-speciﬁc
representations remains an unresolved challenge. Another signiﬁcant
obstacle in leverag- ing LLMs for MDE tasks lies in the challenge of
crafting eﬀective prompts to extract relevant knowledge from the LLMs
and mapping this knowledge accurately to the DSLs in which it must be
represented. This complexity is com- pounded by the reliance of MDE
practitioners on well-established toolchains. Integrating DL and
LLM-based solutions into these ecosystems is challenging, particularly
when existing tools are not designed to address the unique demands of
MDE-speciﬁc tasks.

2.3 Mapping between Activities and Enabling Technologies The aim of this
subsection is to present a mapping between the previously presented
modeling activities and the enabling technologies. This mapping does not
intend to be exhaustive by any means but wants to present illustrative
examples. Table 117 shows activities in its rows and technologies in its
columns (the column "Direct" contains examples of approaches providing
automation support directly for the model representations without moving
to an already existing automation space). Each cell contains a maximum
of two exemplary works, appended with a '+' if the state of the art is
more extensive and includes further works. Cells with only one work mean
that we could not ﬁnd more examples for that activity and technology.
Empty cells mean that we could not ﬁnd any example. Table 1 gives a
summary of how automation-enabling technologies have been used for
various MDE tasks.18 Many techniques, including direct programming,
formal methods, and search methodologies have been extensively employed
to automate various MDE tasks. To a lesser extent, the MDE community has
leveraged, on the one hand, model sets, and ontologies and, on the other
hand, other AI techniques to automate some distinct activities. On
another note, in recent years, there has been a surge in interest and
adoption of deep learning-based approaches for MDE. However, the
scarcity of large-scale datasets for model training or reﬁnement has
hindered their widespread use.

17 Since a metamodel is a model (in particular, a model of a model),
some of these activities apply to both models and metamodels. For the
sake of brevity, we only refer to models. 18 Table 1 is inevitably
non-exhaustive and merely intended to reﬂect the kinds of activities and
available supporting approaches.

                                                                                                                                          Manuscript submitted to ACM

10 Burgueño, Di Ruscio, Sahraoui, and Wimmer

     The utilization of Language Model-based systems and other cutting-edge technologies in this realm is still in its

nascent stages. To date, the primary focus has been on model generation
and completion tasks within MDE workﬂows. Nonetheless, this landscape
presents numerous untapped research directions for further exploration
and reﬁnement of deep learning approaches in MDE. To capitalize on these
opportunities, there is a pressing need to prioritize the creation of
expansive datasets tailored speciﬁcally for MDE tasks, as highlighted in
Section 3. By doing so, researchers and practitioners can unlock the
full potential of deep learning methodologies in automating and
enhancing various tasks of MDE. Looking ahead, LLMs are poised to become
a pivotal research domain in automating MDE tasks. However, their
application extends beyond mere model generation or completion tasks. A
vast scope exists for creative exploration and utilization of LLMs in
diverse MDE activities, heralding a new era of innovation and eﬃciency
in software engineering practices.

3 Perspectives and Challenges Building upon the introductory concepts
discussed earlier, this section provides an overview of perspective
topics that hold signiﬁcance in the medium to long term for automation
in MDE. We foresee a vast potential for automation within MDE, driven by
advancements in AI, particularly in generative AI and LLMs. In exploring
the future prospects of MDE and its automation possibilities, it is
crucial to acknowledge the challenges ahead. Challenges include
integrating au- tomation tools, ensuring compatibility, and maintaining
interoperability among diverse modeling languages and envi- ronments.
Additionally, developing intuitive modeling tools and addressing ethical
considerations in interdisciplinary domains pose signiﬁcant problems to
be investigated, as discussed below. The distinction between
perspectives and challenges may not always be clear-cut and may overlap.
While discussing envisioned advancements, we see some of them as
potential obstacles for automation that must be overcome.

3.1 AI and MDE As with many disciplines, AI signiﬁcantly enhances the
potential for automating tasks. In the past decade, considerable
advances have been made, particularly in natural language and code
models. MDE is ideally positioned to beneﬁt from both types of LLMs, as
it uniquely represents software at a high level of abstraction while
also translating these abstractions into operational implementations.
However, these opportunities come with many challenges, as AI models
have not been speciﬁcally designed for these uses, unlike code models,
whose design is aligned with coding tasks. In this section, we discuss
these opportunities and challenges.

Combination of symbolic and non-symbolic AI : Integrating symbolic AI
techniques---such as logic reasoning and rule- based systems---with
non-symbolic approaches like neural networks and deep learning presents
signiﬁcant opportuni- ties for advancing automation in MDE. By
harnessing the complementary strengths of these paradigms, researchers
can develop hybrid AI systems that excel in tasks requiring both
symbolic reasoning and pattern recognition. For in- stance, combining
symbolic reasoning with neural networks allows MDE tools to interpret
and manipulate models according to logical constraints, while leveraging
the scalability and adaptability of neural networks for data-driven
tasks. Additionally, generative AI tools can synthesize domain-speciﬁc
or context-aware models, further enhancing the eﬀectiveness and
applicability of MDE tools.

Emancipation from formal languages with LLMs: Creating domain-speciﬁc
modeling languages is a critical endeavor that requires collaboration
among various roles, including language and domain experts. This process
involves several Manuscript submitted to ACM Automation in Model-Driven
Engineering: A look back, and ahead 11

key steps: developing concrete syntaxes, deﬁning formal semantics, and
constructing supportive modeling environ- ments. However, the language
development process often presents challenges, such as reﬁning language
deﬁnitions to meet evolving user requirements or address unforeseen
issues. Additionally, the resulting languages may not always be
user-friendly for domain experts. LLMs oﬀer a promising solution for the
early evaluation of these languages. By specifying their semantics in
natural language, LLMs can facilitate preliminary analysis and
stakeholder interactions, helping to ensure that the language aligns
with user needs. This approach can be further extended by using natural
language to represent diﬀerent aspects of a domain and allowing LLMs to
manage ambiguity in these representations for subsequent development
tasks. Moving from general LLMs to task-speciﬁc AI agents: In the
traditional MDE context, a platform typically refers to a speciﬁc
technology stack or execution environment. However, with the growing
adoption of LLMs, the concept of a platform broadens to encompass a
collaborative ecosystem of multiple language models operating within a
multi-agent system. We anticipate a paradigm shift toward the widespread
use of task-speciﬁc AI agents powered by LLMs. These specialized agents
are designed to handle various model management tasks, including model
evolution, comparison, domain modeling, training and test data
generation, and model completion \[89\]. Orchestration of automated MDE
tasks: Building on the previous point, applying modeling concepts and
tools involves performing various tasks, such as model transformations,
validation, and code generation. Despite the availability of
domain-speciﬁc languages like Wires \[152\], there remains a need for
higher-level automation strategies that can, starting from user
requirements, orchestrate low-level automated tasks while remaining
ﬂexible enough to support dif- ferent modeling languages, tools, and
environments. Furthermore, achieving seamless integration of these
automated processes requires overcoming compatibility issues and
ensuring interoperability between diverse automation tools and
frameworks. Model management automation with AI approaches: AI-driven
techniques can signiﬁcantly enhance model manage- ment processes by
improving the semantic understanding and context-aware manipulation of
models. By applying AI to tasks such as model diﬀerencing, merging, and
versioning, MDE can achieve higher eﬃciency and reliability in handling
evolving model artifacts. For instance, AI algorithms can analyze the
semantics of models to detect and resolve---or propose solutions
for---conﬂicts during model merging, reducing manual eﬀort and
minimizing errors in model integration. AI to improve reuse in MDE:
Unlike in the realm of code, the level of artifact reuse in MDE remains
low. This can be partly attributed to the limited presence of explicit
semantics associated with these artifacts and the vast and ambigu- ous
vocabulary often employed. However, the ability of LLMs to grasp the
meaning of representations unlocks new possibilities for reuse. This
includes enhanced model search, model completion, and even the
generation of model transformations. Template-based code generation
combined with AI-based code generation: While template-based methods
provide trans- parency and control over the generated code, AI-based
approaches oﬀer adaptability and potential for optimizing code
generation based on diverse requirements and contexts \[194\].
Researchers can develop code generation techniques by exploring hybrid
approaches that combine the strengths of both paradigms. Also, for
emerging platforms, an impor- tant research challenge is how code
generation facilities can be provided as reference applications from
which code generation schemes may be abstracted. This challenges both
paradigms, which may be mitigated by having hybrid code generators that
can resort to human-deﬁned templates combined with AI-based code
injections to balance the required human eﬀorts as well as the demand
for large sets of reference applications. Manuscript submitted to ACM 12
Burgueño, Di Ruscio, Sahraoui, and Wimmer

Scarcity of datasets and benchmarks: The scarcity of high-quality
datasets hinders the advancement of AI-driven au- tomation in MDE and
benchmarks for training and evaluating AI models. Unlike domains such as
natural language processing or computer vision, where large-scale
datasets are readily available, MDE lacks comprehensive datasets that
capture a diverse range of modeling tasks and application domains
\[129\]. In addition, concerns about data privacy and the ethical use of
data further complicate the acquisition and sharing of modeling
datasets. Addressing these chal- lenges requires collaboration between
researchers, practitioners, and stakeholders to curate datasets, deﬁne
evaluation metrics, and establish best practices for data collection and
sharing in MDE contexts \[49, 156\]. The advent of LLMs presents new
opportunities for the creation of datasets in various domains. With the
ability to generate human-like text and simulate expert knowledge, LLMs
oﬀer a cost-eﬀective alternative to traditional human labeling methods.
For instance, LLMs can automatically generate labeled datasets for MDE
tasks such as model clas- siﬁcation or sentiment analysis. Additionally,
LLMs can serve as judges to evaluate the quality and accuracy of tasks
performed by other LLMs, thereby facilitating continuous improvement and
reﬁnement of AI-driven systems.

3.2 Human Factors and MDE Models enable communication among
stakeholders, software engineers, and ﬁnal users. Models and MDE also
increase the productivity of software development teams thanks to the
(partial) automation of the development process \[34\]. When using
models, humans have goals and expectations, which should be met as both
the success of their projects as well as the modeling disciple depend on
this. Therefore, special attention should be paid to how humans
understand and interact with models. As MDE processes are being
automated and the ﬁeld is evolving, exploration of how these changes
aﬀect humans needs to be explored. It is also worth noting that Liebel
et al. have reported that "there is an underrepresentation of research
focusing on human factors in modeling" \[121\]. In the following, we
discuss the opportunities and challenges that the latest advances in MDE
are bringing to the ﬁeld. Teaching MDE: Given the rapid evolution of
technology and MDE, teaching MDE needs to be adapted to the fast evolv-
ing needs. Educators must prepare students not just to be proﬁcient
modelers, but to be architects of highly complex software and systems
that leverage automation and MDE techniques to meet the demands of
industry and society \[38\]. Incorporating new technologies into the
teaching of MDE can signiﬁcantly improve the learning experience. For
in- stance, the use of simulation tools, multidimensional visualization
software, and other interactive applications can provide a more
immersive and engaging learning experience. Teaching people how to
prompt for MDE automation: Despite advances in AI and automation, human
experience remains indispensable to designing complex systems and
formulating eﬀective prompts for AI models. In the case of MDE, these
prompts or pipelines of prompts) need to take into consideration
diﬀerent aspects of MDE artifacts such as syntax, semantics, abstraction
level, etc. (e.g., \[157, 172\] deal with these problems). Teaching
people how to prompt eﬀectively for MDE involves imparting knowledge and
skills in understanding system requirements, deﬁning clear objectives,
and structuring and designing prompts to elicit desired responses from
AI models. Thus, human expertise is essential for ensuring the accuracy,
relevance, and ethical considerations of AI-generated outputs.
Combination of physical/biological/social/software aspects in complex
systems: Integrating physical, biological, social, and software aspects
into the same system presents a multifaceted challenge that requires a
comprehensive approach to modeling and abstraction. MDE stands as an
ideal integration vehicle for managing these heterogeneous aspects by
providing a uniﬁed framework for representing and analyzing complex
systems. Digital twins, which are virtual replicas of physical entities
or systems, oﬀer a powerful abstraction mechanism for simulating and
analyzing the Manuscript submitted to ACM Automation in Model-Driven
Engineering: A look back, and ahead 13

behavior of interconnected systems. By leveraging digital twins, MDE can
facilitate the design and optimization of integrated systems across
diverse domains \[31\], ranging from healthcare to sustainable smart
cities. Emergence of non-traditional interface devices: Integrating
speech interfaces, gesture recognition, and other non-traditional input
modalities in MDE tools can democratize software development by allowing
a broader range of stakeholders to participate in modeling activities
\[69, 144\]. By providing intuitive and accessible interfaces, such as
voice commands or touch-based interactions, MDE tools can lower entry
barriers for users with diverse backgrounds and abilities. More- over,
non-traditional interface devices facilitate collaboration and
communication among distributed teams, allowing users to interact with
models in real time and co-create solutions collaboratively. To this
end, interdisciplinary work at the intersection of the ﬁelds of
human-machine interaction and software engineering research \[99\].
Democratizing the usage of task-speciﬁc AI agents: To enable the usage
of task-speciﬁc AI agents, it is necessary to devise low-code platforms
that prioritize human-centric design, that is, that allow users to take
advantage of task- speciﬁc AI agents seamlessly. Such platforms can
facilitate broader participation in MDE activities across domains and
expertise levels by providing intuitive interfaces for coordinating
diverse AI models, empowering users from diﬀerent backgrounds and
expertise to interact eﬀortlessly with AI agents. In addition, low-code
platforms can serve as orchestrators for deploying and managing AI
agents, allowing users to customize and extend automation capabilities
according to their speciﬁc requirements and preferences. Feedback-driven
MDE: MDE tools and processes will need built-in feedback mechanisms.
This feedback could come from engineers, stakeholders, or the system
itself (in the form of real-time data) and could be sporadic or
continuous. Tools, processes, and teams should not disregard feedback.
New methodologies are needed to work in new environ- ments where
automated feedback integration is supported \[108\]. A straightforward
scenario is Digital Twins. For instance, Digital Twins can be used for
product development, where design and engineering teams can investigate
a broader range of design possibilities early in development, saving
money, resources, and time. In such a scenario, the engineering
processes must be adapted to collect and react to the outputs/feedback
received by the Digital Twin, and engineering teams must have
methodologies put in place. Automated and semi-automated decision-making
in MDE: As software and systems grow in complexity and the de- mands for
faster delivery increase, automating decision-making processes becomes
necessary to improve eﬃciency and quality. On a purely technical level,
automated decision-making will help choose the best transformation lan-
guages, model checkers, AI algorithms, execution models, etc.
Furthermore, it would ensure that decisions are made consistently
throughout the life of a project and by diﬀerent teams. It would also
prevent human error in repetitive decision-making processes (e.g., tools
enhanced with automated support could exploit data and human-deﬁned
objec- tives to make or suggest optimal decisions).

3.3 Diversity of Application Domains, Users, and Modeling Interfaces MDE
has been extensively explored for classical software systems such as
embedded systems, cyber-physical sys- tems, Web-based systems,
distributed systems, etc. The literature also discusses that MDE shows
diﬀerent adoption levels \[186\] in such domains due to organizational
or technical opportunities/challenges. However, in recent years, we also
face several new computing paradigms emerging such as quantum computing,
neuromorphic computing, extreme parallel computing, intensive
data-driven computing, etc. In the future, it has to be explored if
MDE-based automation is also possible and beneﬁcial for these new
computing paradigms or if new MDE modeling interfaces are required for
these emerging computing paradigms before MDE can be applied to them
eﬀectively. In addition, new interaction Manuscript submitted to ACM 14
Burgueño, Di Ruscio, Sahraoui, and Wimmer

possibilities based on emerging technologies are possible with models,
which opens innovative ways how models are constructed, maintained, and
used in diverse contexts and users, going beyond what is known nowadays
from typical standalone desktop-based modeling editors. In the
following, we discuss several opportunities and challenges in this
respect. Management of ever-increasing diversity of languages and tools:
MDE has seen a proliferation of domain-speciﬁc mod- eling languages and
tools, which has led to a diverse range of technologies. However, this
diversity has posed chal- lenges for generic automation as each modeling
language has its own syntax, semantics, and transformations. Despite
successes in standardizing the syntax of models, e.g., see the
standardized metamodeling language MOF19 which is frequently used for
MDE technologies, the MDE ﬁeld still needs more industry-relevant
standards, especially concern- ing semantics, transformations, and model
interchange formats. Moreover, the rise of low-code/no-code platforms
makes this issue even more diﬃcult as adherence to existing standards
becomes increasingly sporadic \[162\]. Thus, it is imperative to develop
standardized interfaces, transformation mechanisms, and model
interchange formats to ensure interoperability and tooling support
across diﬀerent formalisms, languages, and technologies. This
perspective is even more challenged by also supporting new computing
paradigms which may require completely new standards or the extensive
adaptation of existing ones. Multi-modal modeling tools: Despite
signiﬁcant advancements in modeling tools, many existing tools in MDE
are tai- lored towards expert users (who know the intrinsics of the
modeling languages and associated tools very well) but lack intuitive
interfaces for non-specialists. This poses challenges for automation and
democratizing the adoption of MDE methodologies across diverse domains
and user communities \[162\]. Improving the accessibility \[107\] and
usability \[53\] of modeling tools requires incorporating user-centered
design principles, conducting usability studies, and providing
comprehensive documentation and training materials. Additionally,
ensuring compatibility and interoperability be- tween diﬀerent modeling
tools and environments is essential for facilitating seamless
collaboration and exchange of models among users with varying expertise
levels. This is also of paramount importance for supporting emerging
computing paradigms \[2\] and novel human-computer interaction paradigms
\[178\], as it would allow to involve ex- perts from diﬀerent
disciplines which have to be supported in the best possible way to let
them participate in the development process. Again, the trade-oﬀ between
having a smooth modeling process and having high quality models has to
be explored in this setting to ensure a good level of automation.

3.4 Modeling and non-functional concerns Non-functional requirements
play a pivotal role in software engineering, impacting aspects of
software quality beyond functional correctness. In the context of MDE,
the research community has been focusing on diﬀerent quality aspects,
such as the performance of model transformations \[82\], scalability of
model management tools \[37\], and maintainabil- ity of modeling
artifacts to enhance their reuse possibilities \[91\]. Managing the
(co-)evolution of modeling artifacts has also been the subject of
intense research \[161\], and only recently, the introduction of
alternative modeling means, e.g., virtual reality \[176\] or augmented
reality \[51\], has also been an interesting research topic. Critical
concerns, such as security, are well-recognized in modern software
systems due to the increasing threats posed by cyber-attacks and
vulnerabilities in complex systems. At the same time, newer emerging
concerns, such as sustainability, are rapidly gaining importance as
software systems evolve, and it is necessary to ensure they meet the
demands of energy eﬃ- ciency, resource optimization, and environmental
impact reduction. Both of these concerns require research eﬀorts in 19
https://www.omg.org/mof

Manuscript submitted to ACM Automation in Model-Driven Engineering: A
look back, and ahead 15

the MDE community, which has provided signiﬁcant results in the
automation of various software engineering and development tasks. Thus,
it is necessary to devise techniques and tools to make MDE automation
approaches aware of security and sustainability concerns. In the
following, as examples of existing critical concerns and emerging ones,
we emphasize research challenges and future directions related to
managing security and sustainability in the context of MDE automation.

Security management: A critical future research direction in MDE
automation is the management of security aspects of complex software
systems in critical ﬁelds like IoT and cyber-physical systems. In this
respect, MDE plays a crucial role because it can enable dynamic security
adaptations, threat modeling, and the generation of test cases for
security policies. Recently, Riegler et al. \[150\] proposed a
model-driven approach to manage multi-modal system architectures,
allowing for automated mitigation strategies through conﬁgurable mode
switches. A dedicated language for modeling mitigation strategies
enables such automation. However, advances in model-based security
veriﬁcation, co-evolution, and access control policies will be essential
for enhancing both system security and the security of MDE tools
themself. As generative AI technologies become more prevalent in
supporting software engineering tasks, it is increasingly important to
develop techniques and tools that ensure code security, which is
obtained through model-based generators. Thus, research eﬀorts are
needed to integrate security checks and validation techniques within MDE
automation tools. One promising direction is the exploration of model
alignment techniques, which can help reﬁne outputs generated by LLMs in
line with user expectations. For instance, Ganqu C. et al. \[59\]
proposed an approach to align LLM outputs with human preferences,
learned from human feedback. Applying similar model-alignment strategies
could enhance the code generation capabilities of LLMs by detecting and
ﬂagging malicious or security-sensitive code. This feedback loop would
prevent the generation of such unsafe code in future iterations.

Sustainability management: Empirical evidence from the industry
highlights the challenges posed by limited support for managing large
models, which hampers the broader adoption of MDE in industrial
applications \[90\]. The size of these models can also negatively aﬀect
runtime performance, causing delays during MDE operations such as model
transformations \[155\]. Signiﬁcant research has been conducted on
improving scalability to address these issues, with solutions like the
Gremlin framework speciﬁcally designed to mitigate these limitations
\[61\]. Moreover, recent work has highlighted the persistent performance
challenges in model transformations \[42\] and suggested potential
enhance- ments through static analysis \[58\]. Despite these advances,
energy consumption has been largely neglected in discus- sions around
MDE scalability. With data centers projected to consume 10% of global
electricity by 2030 \[189\], there is a growing recognition of the
importance of energy eﬃciency by academia and industry \[72\].

4 Conclusion MDE has proven its utility over time, primarily due to its
remarkable capabilities in abstraction and automation. These features
have signiﬁcantly streamlined the development process, from
conceptualizing ideas to their implementation. This article delves into
the various facets of MDE activities and the diverse technologies that
have been deployed to automate these activities. The evolution of MDE is
closely intertwined with the emergence of cutting-edge technologies,
such as deep learn- ing and large language models. These advancements
have revolutionized automation in MDE activities, paving the way for
enhanced eﬃciency and eﬀectiveness in software development. In addition
to oﬀering extraordinary automa- tion capabilities for MDE, these
emerging technologies create new opportunities for this paradigm to play
new roles in development processes. One signiﬁcant aspect to consider is
the democratization of AI techniques. The power of Manuscript submitted
to ACM 16 Burgueño, Di Ruscio, Sahraoui, and Wimmer

abstraction and automation provided by MDE allows non-specialists to
leverage AI capabilities seamlessly. This de- mocratization can lead to
more widespread adoption of advanced technologies and contribute to
innovation across industries. Moreover, MDE's potential extends beyond
traditional software development. It can be leveraged to build complex
and hybrid systems that integrate physical, biological, social, and
software components. Such systems are becoming increasingly crucial in
modern societies, where interconnectedness and integration are
paramount. It is im- portant to remark that a critical gap in current
MDE research is the limited availability of artifacts, such as datasets,
benchmarks, and systematic evaluations, to validate tools, technologies,
and methodologies, see e.g., \[30\] for a recent study. This gap becomes
even more signiﬁcant with the increasing adoption of AI for MDE
automation, where empir- ical evidence is essential to demonstrate the
eﬀectiveness, reliability, and scalability of AI-driven approaches.
Future research should prioritize the creation of open datasets,
developing standardized benchmarks, and establishing rigor- ous
evaluation frameworks to ensure the practical applicability of MDE
automation in diﬀerent settings.

Acknowledgment This work was partially funded by the Spanish Government
(Ministerio de Ciencia e Innovación--Agencia Estatal de Investigación)
under projects PID2021-125527NB-I00, TED2021-130523B-I00; by the
Universidad de Málaga under project JA.B1-17 PPRO-B1-2023-037; and by
the NSERC grant RGPIN-2019-07168. Additionally, this work was partially
supported by the following Italian research projects: EMELIOT (PRIN
2020, grant n. 2020W3A5FY) and TRex SE (PRIN 2022, grant n. 2022LKJWHC).
Additional support was provided by the European Union NextGenerationEU
through the Italian Ministry of University and Research for the MATTERS
project, funded under the cascade scheme of the SERICS program (CUP
J33C22002810001), Spoke 8, within the Italian PNRR Mission 4, Component
2, as well as the FRINGE project (PRIN 2022 PNRR, grant n. P2022553SL).

References \[1\] Hani Abdeen, Dániel Varró, Houari Sahraoui, András
Szabolcs Nagy, Csaba Debreceni, Ábel Hegedüs, and Ákos Horváth. 2014.
Multi-objective optimization in rule-based design space exploration. In
Proc. of the 29th ACM/IEEE International Conference on Automated
Software Engineering (ASE'14). 289--300. \[2\] Shaukat Ali and Tao Yue.
2020. Modeling Quantum programs: challenges, initial results, and
research directions. In Proc. of the 1st ACM SIGSOFT International
Workshop on Architectures and Paradigms for Engineering Quantum
Software, APEQS@ESEC/SIGSOFT FSE. ACM, 14--21. \[3\] Kyriakos
Anastasakis, Behzad Bordbar, Geri Georg, and Indrakshi Ray. 2010. On
challenges of model transformation from UML to Alloy. Softw. Syst.
Model. 9, 1 (2010), 69--86. \[4\] Thorsten Arendt, Enrico Biermann,
Stefan Jurack, Christian Krause, and Gabriele Taentzer. 2010. Henshin:
Advanced Concepts and Tools for In- Place EMF Model Transformations. In
Proc. of the 13th International Conference on Model Driven Engineering
Languages and Systems (MODELS'10) (LNCS, Vol. 6394). Springer, 121--135.
\[5\] Thorsten Arendt and Gabriele Taentzer. 2012. Integration of smells
and refactorings within the Eclipse modeling framework. In Proc. of the
5th Workshop on Refactoring Tools (WRT'12). ACM, 8--15. \[6\] Colin
Atkinson and Thomas Kühne. 2003. Model-Driven Development: A
Metamodeling Foundation. IEEE Softw. 20, 5 (2003), 36--41. \[7\] Aren A.
Babikian, Oszkár Semeráth, Anqi Li, Kristóf Marussy, and Dániel Varró.
2022. Automated generation of consistent models using qualitative
abstractions and exploration strategies. Softw. Syst. Model. 21, 5
(2022), 1763--1787. \[8\] Aren A. Babikian, Oszkár Semeráth, and Dániel
Varró. 2020. Automated generation of consistent graph models with
ﬁrst-order logic theorem provers. In Proc. of the International
Conference on Fundamental Approaches to Software Engineering (FASE),
Vol. 12076. Springer, 441--461. \[9\] Mojtaba Bagherzadeh, Nicolas Hili,
and Juergen Dingel. 2017. Model-level, platform-independent debugging in
the context of the model-driven development of real-time systems. In
Proc. of the 11th Joint Meeting on Foundations of Software Engineering
(ESEC/FSE'17). ACM, 419--430. \[10\] Islem Baki and Houari Sahraoui.
2016. Multi-step learning and adaptive search for learning complex model
transformations from examples. ACM Transactions on Software Engineering
and Methodology (TOSEM) 25, 3 (2016), 1--37. \[11\] Angela Barriga,
Rogardt Heldal, Adrian Rutle, and Ludovico Iovino. 2022. PARMOREL: a
framework for customizable model repair. Software and Systems Modeling
21, 5 (2022), 1739--1762.

Manuscript submitted to ACM Automation in Model-Driven Engineering: A
look back, and ahead 17

\[12\] Angela Barriga, Lawrence Mandow, José-Luis Pérez-de-la-Cruz,
Adrian Rutle, Rogardt Heldal, and Ludovico Iovino. 2020. A comparative
study of reinforcement learning techniques to repair models. In
Companion Proc. of the ACM/IEEE 23rd International Conference on Model
Driven Engineering Languages and Systems (MODELS'20). ACM, 47:1--47:9.
\[13\] Francesco Basciani, Juri Di Rocco, Davide Di Ruscio, Ludovico
Iovino, and Alfonso Pierantonio. 2016. Automated Clustering of Metamodel
Repositories. In Advanced Information Systems Engineering. Springer,
342--358. \[14\] Francesco Basciani, Juri Di Rocco, Davide Di Ruscio,
Ludovico Iovino, and Alfonso Pierantonio. 2018. Exploring model
repositories by means of megamodel-aware search operators.. In Proc. of
the MODELS Workshops. 793--798. \[15\] Francesco Basciani, Juri Di
Rocco, Davide Di Ruscio, Ludovico Iovino, and Alfonso Pierantonio. 2018.
Exploring model repositories by means of megamodel-aware search
operators. In Proc. of MODELS 2018 Workshops (CEUR Workshop Proceedings,
Vol. 2245). CEUR-WS.org, 793--798. \[16\] Francesco Basciani, Juri Di
Rocco, Davide Di Ruscio, Ludovico Iovino, and Alfonso Pierantonio. 2019.
A tool-supported approach for assessing the quality of modeling
artifacts. J. Comput. Lang. 51 (2019), 173--192. \[17\] Edouard Batot,
Wael Kessentini, Houari Sahraoui, and Michalis Famelis. 2017.
Heuristic-based recommendation for metamodel---ocl coevolution. In Proc.
of the ACM/IEEE 20th International Conference on Model Driven
Engineering Languages and Systems (MODELS'17). IEEE, 210--220. \[18\]
Edouard Batot and Houari Sahraoui. 2016. A generic framework for
model-set selection for the uniﬁcation of testing and learning MDE
tasks. In Proceedings of the ACM/IEEE 19th International Conference on
Model Driven Engineering Languages and Systems (MODELS). 374--384.
\[19\] Edouard R Batot and Houari Sahraoui. 2022. Promoting social
diversity for the automated learning of complex MDE artifacts. Software
and Systems Modeling 21, 3 (2022), 1159--1178. \[20\] Nelly Bencomo,
Amel Belaggoun, and Valérie Issarny. 2013. Dynamic decision networks for
decision-making in self-adaptive systems: a case study. In Proc. of the
8th International Symposium on Software Engineering for Adaptive and
Self-Managing Systems (SEAMS'13). IEEE, 113--122. \[21\] Nelly Bencomo,
Sebastian Götz, and Hui Song. 2019. Models@run.time: a guided tour of
the state of the art and research challenges. Softw. Syst. Model. 18, 5
(2019), 3049--3082. \[22\] Nelly Bencomo, Paul Grace, Carlos A.
Flores-Cortés, Danny Hughes, and Gordon S. Blair. 2008. Genie:
supporting the model driven development of reﬂective, component-based
adaptive systems. In Proc. of the 30th International Conference on
Software Engineering (ICSE'08). ACM, 811--814. \[23\] Johan Bengtsson,
Kim Guldstrand Larsen, Fredrik Larsson, Paul Pettersson, and Wang Yi.
1995. UPPAAL - a Tool Suite for Automatic Veriﬁcation of Real-Time
Systems. In Proc. of the DIMACS/SYCON Workshop on Veriﬁcation and
Control of Hybrid Systems, Hybrid Systems III: Veriﬁcation and Control
(LNCS, Vol. 1066). Springer, 232--243. \[24\] Jean Bézivin. 2005. On the
uniﬁcation power of models. Softw. Syst. Model. 4, 2 (2005), 171--188.
\[25\] Jason Bickford, Douglas L. Van Bossuyt, Paul T. Beery, and
Anthony G. Pollman. 2020. Operationalizing digital twins through
model-based systems engineering methods. Syst. Eng. 23, 6 (2020),
724--750. \[26\] Enrico Biermann, Karsten Ehrig, Christian Köhler,
Günter Kuhns, Gabriele Taentzer, and Eduard Weiss. 2006. EMF Model
Refactoring based on Graph Transformation Concepts. Electron. Commun.
Eur. Assoc. Softw. Sci. Technol. 3 (2006). \[27\] Enrico Biermann,
Claudia Ermel, and Gabriele Taentzer. 2008. Precise semantics of EMF
model transformations by graph transformation. In Proc. of the 11th
International Conference on Model Driven Engineering Languages and
Systems (MODELS'08). Springer, 53--67. \[28\] Robert Bill, Martin Fleck,
Javier Troya, Tanja Mayerhofer, and Manuel Wimmer. 2019. A local and
global tour on MOMoT. Softw. Syst. Model. 18, 2 (2019), 1017--1046.
\[29\] Bojana Bislimovska, Alessandro Bozzon, Marco Brambilla, and Piero
Fraternali. 2014. Textual and Content-Based Search in Repositories of
Web Application Models. ACM Trans. Web 8, 2, Article 11 (2014). \[30\]
Alexander Boll, Nicole Vieregg, and Timo Kehrer. 2024. Replicability of
experimental tool evaluations in model-based software and systems
engineering with MATLAB/Simulink. Innov. Syst. Softw. Eng. 20, 3 (2024),
209--224. \[31\] Francis Bordeleau, Benoit Combemale, Romina Eramo, Mark
van den Brand, and Manuel Wimmer. 2020. Towards Model-Driven Digital
Twin Engineering: Current Opportunities and Future Challenges. In
Systems Modelling and Management. Springer, 43--54. \[32\] Matthias
Born, Christian Brelage, Ivan Markovic, Daniel Pfeiﬀer, and Ingo Weber.
2008. Auto-completion for Executable Business Process Models. In Proc.
of the Business Process Management Workshops (LNBIP, Vol. 17). Springer,
510--515. \[33\] Ilhem Boussaïd, Patrick Siarry, and Mohamed
Ahmed-Nacer. 2017. A survey on search-based model-driven engineering.
Automated Software Engineering 24 (2017), 233--294. \[34\] Marco
Brambilla, Jordi Cabot, and Manuel Wimmer. 2017. Model-Driven Software
Engineering in Practice. Morgan & Claypool Publishers. \[35\] Erwan
Brottier, Franck Fleurey, Jim Steel, Benoit Baudry, and Yves Le Traon.
2006. Metamodel-based Test Generation for Model Transformations: an
Algorithm and a Tool. In Proc. of the 17th International Symposium on
Software Reliability Engineering (ISSRE'06). IEEE, 85--94. \[36\] Cédric
Brun and Alfonso Pierantonio. 2008. Model diﬀerences in the eclipse
modelling framework. UPGRADE, the European Journal for the Informatics
Professional 9 (2008), 29--34. \[37\] Hugo Bruneliere, Florent Marchand
de Kerchove, Gwendal Daniel, Sina Madani, Dimitris S. Kolovos, and Jordi
Cabot. 2020. Scalable model views over heterogeneous modeling
technologies and resources. Softw. Syst. Model. 19, 4 (2020), 827--851.
\[38\] Antonio Bucchiarone, Jordi Cabot, Richard F. Paige, and Alfonso
Pierantonio. 2020. Grand challenges in model-driven engineering: an
analysis of the state of the research. Softw. Syst. Model. 19, 1 (2020),
5--13. \[39\] Thomas Buchmann. 2024. Prompting Bidirectional Model
Transformations - The Good, The Bad and The Ugly. In Proc. of MODELS'24
(Companion). ACM. Manuscript submitted to ACM 18 Burgueño, Di Ruscio,
Sahraoui, and Wimmer

\[40\] Márton Búr, Gábor S. Szilágyi, András Vörös, and Dániel Varró.
2018. Distributed Graph Queries for Runtime Monitoring of Cyber-Physical
Systems. In Proc. of the 21st International Conference on Fundamental
Approaches to Software Engineering (FASE'18) (LNCS, Vol. 10802).
Springer, 111--128. \[41\] Alexandru Burdusel, Steﬀen Zschaler, and
Daniel Strüber. 2018. MDEoptimiser: A search based model engineering
tool. In Proc. of the 21st ACM/IEEE International Conference on Model
Driven Engineering Languages and Systems (MODELS'18) - Companion
Proceedings. ACM, 12--16. \[42\] Loli Burgueño, Jordi Cabot, and
Sébastien Gérard. 2019. The future of model transformation languages: An
open community. Journal of Object Technology 18, 3 (2019). \[43\] Loli
Burgueño, Jordi Cabot, Shuai Li, and Sébastien Gérard. 2022. A generic
LSTM neural network architecture to infer heterogeneous model
transformations. Softw. Syst. Model. 21, 1 (2022), 139--156. \[44\] Loli
Burgueño, Federico Ciccozzi, Michalis Famelis, Gerti Kappel, Leen
Lambers, Sébastien Mosser, Richard F. Paige, Alfonso Pierantonio, Arend
Rensink, Rick Salay, Gabriele Taentzer, Antonio Vallecillo, and Manuel
Wimmer. 2019. Contents for a Model-Based Software Engineering Body of
Knowledge. Softw. Syst. Model. 18, 6 (2019), 3193--3205. \[45\] Loli
Burgueño, Robert Clarisó, Sébastien Gérard, Shuai Li, and Jordi Cabot.
2021. An NLP-Based Architecture for the Autocompletion of Partial Domain
Models. In Proc. of CAiSE 2021, Vol. 12751. Springer, 91--106. \[46\]
Loli Burgueño, Manuel Wimmer, and Antonio Vallecillo. 2016. A
Linda-based platform for the parallel execution of out-place model
transforma- tions. Inf. Softw. Technol. 79 (2016), 17--35. \[47\]
Constantin Buschhaus, Arkadii Gerasimov, Jörg Christian Kirchhof, Judith
Michael, Lukas Netz, Bernhard Rumpe, and Sebastian Stüber. 2024. Lessons
learned from applying model-driven engineering in 5 domains: The success
story of the MontiGem generator framework. Science of Computer
Programming 232 (2024), 103033. \[48\] Jordi Cabot, Robert Clarisó, and
Daniel Riera. 2007. UMLtoCSP: a tool for the formal veriﬁcation of
UML/OCL models using constraint program- ming. In Proc. of the 22nd
IEEE/ACM International Conference on Automated Software Engineering
(ASE). ACM, 547--548. \[49\] Javier Cámara, Lola Burgueño, and Javier
Troya. 2024. Towards standarized benchmarks of LLMs in software modeling
tasks: a conceptual framework. Software and Systems Modeling (2024),
1--10. \[50\] Javier Cámara, Javier Troya, Lola Burgueño, and Antonio
Vallecillo. 2023. On the assessment of generative AI in modeling tasks:
an experience report with ChatGPT and UML. Software and Systems Modeling
22, 3 (2023), 781--793. \[51\] Rubén Campos-López, Esther Guerra, Juan
de Lara, Alessandro Colantoni, and Antonio Garmendia. 2023. Model-Driven
Engineering for Aug- mented Reality. Journal of Object Technology 22, 2
(2023), 2:1--15. The 19th European Conference on Modelling Foundations
and Applications (ECMFA 2023). \[52\] Meriem Ben Chaaben, Lola Burgueño,
and Houari Sahraoui. 2023. Towards using few-shot prompt learning for
automating model completion. In Proc. of the IEEE/ACM 45th International
Conference on Software Engineering: New Ideas and Emerging Results
(ICSE-NIER). 7--12. \[53\] Shalini Chakraborty and Grischa Liebel. 2024.
Modelling guidance in software engineering: a systematic literature
review. Softw. Syst. Model. 23, 1 (2024), 249--265. \[54\] Boqi Chen,
Kua Chen, Shabnam Hassani, Yujing Yang, Daniel Amyot, Lysanne Lessard,
Gunter Mussbacher, Mehrdad Sabetzadeh, and Dániel Varró. 2023. On the
Use of GPT-4 for Creating Goal Models: An Exploratory Study. In 2023
IEEE 31st International Requirements Engineering Conference Workshops
(REW). 262--271. \[55\] Kai Chen, Janos Sztipanovits, and Sandeep Neema.
2005. Toward a semantic anchoring infrastructure for domain-speciﬁc
modeling languages. In Proc. of the 5th ACM International Conference On
Embedded Software (EMSOFT'05), Wayne H. Wolf (Ed.). ACM, 35--43. \[56\]
Kua Chen, Yujing Yang, Boqi Chen, José Antonio Hernández López, Gunter
Mussbacher, and Dániel Varró. 2023. Automated Domain Modeling with Large
Language Models: A Comparative Study. In Proc. of the ACM/IEEE 26th
International Conference on Model Driven Engineering Languages and
Systems (MODELS'23). IEEE, 162--172. \[57\] Benoît Combemale, Olivier
Barais, and Andreas Wortmann. 2017. Language Engineering with the GEMOC
Studio. In Proc. of the IEEE International Conference on Software
Architecture Workshops (ICSA'17). IEEE, 189--191. \[58\] Jesús Sánchez
Cuadrado, Loli Burgueño, Manuel Wimmer, and Antonio Vallecillo. 2022.
Eﬃcient Execution of ATL Model Transformations Using Static Analysis and
Parallelism. IEEE Transactions on Software Engineering 48, 4 (2022),
1097--1114. \[59\] Ganqu Cui, Lifan Yuan, Ning Ding, Guanming Yao,
Bingxiang He, Wei Zhu, Yuan Ni, Guotong Xie, Ruobing Xie, Yankai Lin,
Zhiyuan Liu, and Maosong Sun. 2024. UltraFeedback: Boosting Language
Models with Scaled AI Feedback. arXiv:2310.01377 \[cs.CL\]
https://arxiv.org/abs/2310.01377 \[60\] Gwendal Daniel and Jordi Cabot.
2024. Applying model-driven engineering to the domain of chatbots: The
Xatkit experience. Science of Computer Programming 232 (2024), 103032.
\[61\] Gwendal Daniel, Frédéric Jouault, Gerson Sunyé, and Jordi Cabot.
2017. Gremlin-ATL: a scalable model transformation framework. In Proc.
of the 32nd IEEE/ACM International Conference on Automated Software
Engineering (ASE). IEEE, 462--472. \[62\] Joachim Denil, Maris Jukss,
Clark Verbrugge, and Hans Vangheluwe. 2014. Search-Based Model
Optimization Using Model Transformations. In Proc. of the 8th
International Conference on System Analysis and Modeling: Models and
Reusability (SAM'14) (LNCS, Vol. 8769). Springer, 80--95. \[63\] Juri Di
Rocco, Claudio Di Sipio, Davide Di Ruscio, and Phuong T Nguyen. 2021. A
GNN-based recommender system to assist the speciﬁcation of metamodels
and models. In Proc. of the ACM/IEEE 24th International Conference on
Model Driven Engineering Languages and Systems (MODELS'21). 70--81.
Manuscript submitted to ACM Automation in Model-Driven Engineering: A
look back, and ahead 19

\[64\] Xavier Dolques, Marianne Huchard, and Clémentine Nebut. 2009.
From transformation traces to transformation rules: Assisting model
driven engineering approach with formal concept analysis. Supplementary
Proceedings of ICCS 9 (2009), 15--29. \[65\] Francisco Durán. 2022.
Rewriting Logic and Maude for the Formalization and Analysis of DSMLs,
and the Prototyping of MDSE Tools. Journal of Object Technology 21, 4
(2022), 4:1--12. \[66\] Karsten Ehrig, Jochen Malte Küster, and Gabriele
Taentzer. 2009. Generating instance models from meta models. Softw.
Syst. Model. 8, 4 (2009), 479--500. \[67\] Martin Eisenberg, Daniel
Lehner, Radek Sindelár, and Manuel Wimmer. 2022. Towards Reactive
Planning with Digital Twins and Model-Driven Optimization. In Proc. of
the 11th International Symposium on Leveraging Applications of Formal
Methods, Veriﬁcation and Validation (ISoLA'22). Part IV (LNCS, Vol.
13704). Springer, 54--70. \[68\] Martin Eisenberg, Hans-Peter Pichler,
Antonio Garmendia, and Manuel Wimmer. 2021. Towards Reinforcement
Learning for In-Place Model Transformations. In Proc. of the 24th
International Conference on Model Driven Engineering Languages and
Systems (MODELS'21). IEEE, 82--88. \[69\] Nadia Elouali, José Rouillard,
Xavier Le Pallec, and Jean-Claude Tarby. 2013. Multimodal interaction: a
survey from model driven engineering and mobile perspectives. J.
Multimodal User Interfaces 7, 4 (2013), 351--370. \[70\] Gregor Engels,
Jan Hendrik Hausmann, Reiko Heckel, and Stefan Sauer. 2000. Dynamic Meta
Modeling: A Graphical Approach to the Operational Semantics of
Behavioral Diagrams in UML. In Proc. of the 3th International Conference
on The Uniﬁed Modeling Language, Modeling Languages and Applications
(UML'00) (LNCS, Vol. 1939). Springer, 323--337. \[71\] Martin Faunes,
Houari Sahraoui, and Mounir Boukadoum. 2013. Genetic-programming
approach to learn model transformation rules from examples. In Theory
and Practice of Model Transformations, ICMT. 17--32. \[72\] Alcides
Fonseca, Rick Kazman, and Patricia Lago. 2019. A manifesto for
energy-aware software. IEEE Software 36, 6 (2019), 79--82. \[73\]
François Fouquet, Grégory Nain, Brice Morin, Erwan Daubert, Olivier
Barais, Noël Plouzeau, and Jean-Marc Jézéquel. 2012. An Eclipse
Modelling Framework Alternative to Meet the Models@Runtime Requirements.
In Proc. of the 15th International Conference on Model Driven
Engineering Languages and Systems (MODELS'12) (LNCS, Vol. 7590).
Springer, 87--101. \[74\] Robert B. France and Bernhard Rumpe. 2007.
Model-driven Development of Complex Software: A Research Roadmap. In
International Conference on Software Engineering, ISCE 2007, Workshop on
the Future of Software Engineering, FOSE. IEEE Computer Society, 37--54.
\[75\] Loïc Gammaitoni and Pierre Kelsen. 2019. F-Alloy: a relational
model transformation language based on Alloy. Softw. Syst. Model. 18, 1
(2019), 213--247. \[76\] Adnane Ghannem, Marouane Kessentini, Mohammad
Salah Hamdi, and Ghizlane El-Boussaidi. 2018. Model refactoring by
example: A multi- objective search based software engineering approach.
J. Softw. Evol. Process. 30, 4 (2018). \[77\] Holger Giese and Robert
Wagner. 2006. Incremental Model Synchronization with Triple Graph
Grammars. In Proc. of the International Conference on Model Driven
Engineering Languages and Systems (MODELS), Vol. 4199. 543--557. \[78\]
Martin Gogolla, Fabian Büttner, and Mark Richters. 2007. USE: A
UML-based speciﬁcation environment for validating UML and OCL. Sci.
Comput. Program. 69, 1-3 (2007), 27--34. \[79\] Martin Gogolla, Frank
Hilken, and Khanh-Hoang Doan. 2018. Achieving model quality through
model validation, veriﬁcation and exploration. Comput. Lang. Syst.
Struct. 54 (2018), 474--511. \[80\] Juan José Cadavid Gómez, Benoit
Baudry, and Houari Sahraoui. 2012. Searching the boundaries of a
modeling space to test metamodels. In Proc. of the IEEE Fifth
International Conference on Software Testing, Veriﬁcation and
Validation. 131--140. \[81\] Pablo Gómez-Abajo, Esther Guerra, and Juan
de Lara. 2016. Wodel: a domain-speciﬁc language for model mutation. In
Proc. of the 31st Annual ACM Symposium on Applied Computing. ACM,
1968--1973. \[82\] Raﬀaela Groner, Peter Bellmann, Stefan Höppner,
Patrick Thiam, Friedhelm Schwenker, and Matthias Tichy. 2023. Predicting
the Performance of ATL Model Transformations. In Proc. of the 2023
ACM/SPEC International Conference on Performance Engineering (ICPE '23).
ACM, 77--89. \[83\] Thomas Hartmann, Assaad Moawad, François Fouquet,
and Yves Le Traon. 2019. The next evolution of MDE: a seamless
integration of machine learning into domain modeling. Softw. Syst.
Model. 18, 2 (2019), 1285--1304. \[84\] Markus Herrmannsdoerfer. 2011.
COPE -- A Workbench for the Coupled Evolution of Metamodels and Models.
In Software Language Engineering (LNCS, Vol. 6563). Springer, 286--295.
\[85\] Markus Herrmannsdoerfer and Daniel Ratiu. 2009. Limitations of
Automating Model Migration in Response to Metamodel Adaptation. In Proc.
of the International Conference on Model Driven Engineering Languages
and Systems (MODELS'09) Workshops and Symposia (LNCS, Vol. 6002).
Springer, 205--219. \[86\] Frank Hilken, Martin Gogolla, Loli Burgueño,
and Antonio Vallecillo. 2018. Testing models and model transformations
using classifying terms. Softw. Syst. Model. 17, 3 (2018), 885--912.
\[87\] Jörg Holtmann, Grischa Liebel, and Jan-Philipp Steghöfer. 2024.
Processes, methods, and tools in model-based engineering - A qualitative
multiple- case study. J. Syst. Softw. 210 (2024), 111943. \[88\] Gerard
J. Holzmann. 2004. The SPIN Model Checker - primer and reference manual.
Addison-Wesley. \[89\] Sirui Hong, Xiawu Zheng, Jonathan Chen, Yuheng
Cheng, Jinlin Wang, Ceyao Zhang, Zili Wang, Steven Ka Shing Yau, Zijuan
Lin, Liyang Zhou, et al. 2023. Metagpt: Meta programming for multi-agent
collaborative framework. arXiv preprint arXiv:2308.00352 (2023). \[90\]
John Hutchinson, Jon Whittle, and Mark Rounceﬁeld. 2014. Model-driven
engineering practices in industry: Social, organizational and managerial
factors that lead to success or failure. Science of Computer Programming
89 (2014), 144--161. Manuscript submitted to ACM 20 Burgueño, Di Ruscio,
Sahraoui, and Wimmer

\[91\] Arsene Indamutsa, Juri Di Rocco, Lissette Almonte, Davide Di
Ruscio, and Alfonso Pierantonio. 2024. Advanced discovery mechanisms in
model repositories. Softw. Pract. Exp. 54, 11 (2024), 2214--2248. \[92\]
Phillip James, Faron Moller, and Filippos Pantekis. 2024. OnTrack:
Reﬂecting on domain speciﬁc formal methods for railway designs. Science
of Computer Programming 233 (2024), 103057. \[93\] Atif Aftab Jilani,
Muhammad Zohaib Iqbal, and Muhammad Uzair Khan. 2014. A search based
test data generation approach for model transfor- mations. In Proc. of
the 7th International Conference on Theory and Practice of Model
Transformations (ICMT). Springer, 17--24. \[94\] Stefan John, Jens
Kosiol, Leen Lambers, and Gabriele Taentzer. 2023. A graph-based
framework for model-driven optimization facilitating impact analysis of
mutation operator properties. Softw. Syst. Model. 22, 4 (2023),
1281--1318. \[95\] Robbert Jongeling, Jan Carlson, and Antonio
Cicchetti. 2019. Impediments to Introducing Continuous Integration for
Model-Based Development in Industry. In Proc. of the 45th Euromicro
Conference on Software Engineering and Advanced Applications (SEAA'19).
IEEE, 434--441. \[96\] Frédéric Jouault, Freddy Allilaire, Jean Bézivin,
and Ivan Kurtev. 2008. ATL: A model transformation tool. Science of
Computer Programming 72, 1-2 (2008), 31--39. \[97\] Naﬁseh Kahani,
Mojtaba Bagherzadeh, James R. Cordy, Juergen Dingel, and Dániel Varró.
2019. Survey and classiﬁcation of model transformation tools. Softw.
Syst. Model. 18, 4 (2019), 2361--2397. \[98\] Gerti Kappel, Elisabeth
Kapsammer, Horst Kargl, Gerhard Kramler, Thomas Reiter, Werner
Retschitzegger, Wieland Schwinger, and Manuel Wim- mer. 2006. Lifting
Metamodels to Ontologies: A Step to the Semantic Integration of Modeling
Languages. In Proc. of the 9th International Conference on Model Driven
Engineering Languages and Systems (MODELS'06) (LNCS, Vol. 4199).
Springer, 528--542. \[99\] Pariya Kashﬁ, Robert Feldt, and Agneta
Nilsson. 2019. Integrating UX principles and practices into software
development organizations: a case study of inﬂuencing events. Journal of
Systems and Software 154 (2019), 37--58. \[100\] Gabriel Kazai and
Ronnie Osei. 2024. Model Transformations with LLMs. Master's thesis.
Mälardalen University.
https://urn.kb.se/resolve?urn=urn:nbn:se:mdh:diva-68131 \[101\] Zohra
Kaouter Kebaili, Djamel Eddine Khelladi, Mathieu Acher, and Olivier
Barais. 2024. An Empirical Study on Leveraging LLMs for Metamodels and
Code Co-evolution. Journal of Object Technology 23, 3 (July 2024),
1--14. Proc. of the 20th European Conference on Modelling Foundations
and Applications (ECMFA 2024). \[102\] Marouane Kessentini, Usman
Mansoor, Manuel Wimmer, Ali Ouni, and Kalyanmoy Deb. 2017. Search-based
detection of model level changes. Empir. Softw. Eng. 22, 2 (2017),
670--715. \[103\] Marouane Kessentini, Houari Sahraoui, and Mounir
Boukadoum. 2008. Model transformation as an optimization problem. In
Proc. of the Interna- tional Conference on Model Driven Engineering
Languages and Systems (MODELS). Springer, 159--173. \[104\] Wael
Kessentini and Vahid Alizadeh. 2022. Semi-automated metamodel/model
co-evolution: a multi-level interactive approach. Software and Systems
Modeling 21, 5 (2022), 1853--1876. \[105\] Wael Kessentini, Houari
Sahraoui, and Manuel Wimmer. 2018. Automated co-evolution of metamodels
and transformation rules: A search-based approach. In Proc. of the 10th
International Symposium on Search-Based Software Engineering (SSBSE).
Springer, 229--245. \[106\] Wael Kessentini, Manuel Wimmer, and Houari
Sahraoui. 2018. Integrating the Designer in-the-loop for Metamodel/Model
Co-Evolution via Interactive Computational Search. In Proc. of the 21th
ACM/IEEE International Conference on Model Driven Engineering Languages
and Systems (MODELS'18). ACM, 101--111. \[107\] Hourieh Khalajzadeh and
John Grundy. 2025. Accessibility of low-code approaches: A systematic
literature review. Information and Software Technology 177 (2025),
107570. \[108\] Jörg Kienzle, Benoît Combemale, Gunter Mussbacher, Omar
Alam, Francis Bordeleau, Lola Burgueño, Gregor Engels, Jessie Galasso,
Jean-Marc Jézéquel, Bettina Kemme, Sébastien Mosser, Houari A. Sahraoui,
Maximilian Schiedermeier, and Eugene Syriani. 2022. Global Decision
Making Over Deep Variability in Feedback-Driven Software Development. In
37th IEEE/ACM International Conference on Automated Software Engineering
(ASE). ACM, 178:1--178:6. \[109\] Cody Kinneer, David Garlan, and Claire
Le Goues. 2021. Information Reuse and Stochastic Search: Managing
Uncertainty in Self-\* Systems. ACM Trans. Auton. Adapt. Syst. 15, 1
(2021), 3:1--3:36. \[110\] John Klein. 2015. Model Driven Engineering:
Automatic Code Generation and Beyond. Carnegie Mellon University,
Software Engineering Institute's Insights (blog).
https://insights.sei.cmu.edu/blog/model-driven-engineering-automatic-code-generation-and-beyond/
Accessed: 2024- Mar-5. \[111\] A.G. Kleppe, J.B. Warmer, and W. Bast.
2003. MDA Explained: The Model Driven Architecture : Practice and
Promise. Addison-Wesley. \[112\] Maximilian Koegel and Jonas Helming.
2010. EMFStore: a model repository for EMF models. In Proc. of the 32nd
ACM/IEEE International Conference on Software Engineering - Volume 2
(ICSE'10). ACM, 307--308. \[113\] Maximilian Koegel, Markus
Herrmannsdoerfer, Yang Li, Jonas Helming, and Jörn David. 2010.
Comparing State- and Operation-Based Change Tracking on Models. In Proc.
of the 14th IEEE International Enterprise Distributed Object Computing
Conference (EDOC'10). IEEE, 163--172. \[114\] Dimitris S. Kolovos and
Antonio García-Domínguez. 2022. The Epsilon Playground. In Companion
Proc. of the 25th International Conference on Model Driven Engineering
Languages and Systems (MODELS'22). ACM, 131--137. \[115\] Dimitrios S.
Kolovos, Richard F. Paige, and Fiona A. C. Polack. 2008. The Epsilon
Transformation Language. In Proc. of the Int. Conference on Model
Transformations (ICMT'08) (LNCS, Vol. 5063). Springer, 46--60.

Manuscript submitted to ACM Automation in Model-Driven Engineering: A
look back, and ahead 21

\[116\] Ivan Kurtev, Jozef Hooman, Mathijs Schuts, and Daan van der
Munnik. 2024. Model based component development and analysis with ComMA.
Science of Computer Programming 233 (2024), 103067. \[117\] Tobias
Kuschke, Patrick Mäder, and Patrick Rempel. 2013. Recommending
Auto-completions for Software Modeling Activities. In Proc. of the 16th
International Conference on Model-Driven Engineering Languages and
Systems (MODELS'13). Springer, 170--186. \[118\] Marta Z. Kwiatkowska,
Gethin Norman, and David Parker. 2011. PRISM 4.0: Veriﬁcation of
Probabilistic Real-Time Systems. In Proc. of the 23rd International
Conference on Computer Aided Veriﬁcation (CAV'11), Vol. 6806. Springer,
585--591. \[119\] Kevin Lano and Qiaomu Xue. 2023. Code Generation by
Example Using Symbolic Machine Learning. SN Comput. Sci. 4, 2 (2023),
170. \[120\] Tihamer Levendovszky, Daniel Balasubramanian, Anantha
Narayanan, Feng Shi, Christopher P. van Buskirk, and Gabor Karsai. 2014.
A semi- formal description of migrating domain-speciﬁc models with
evolving domains. Softw. Syst. Model. 13, 2 (2014), 807--823. \[121\]
Grischa Liebel, Jil Klünder, Regina Hebig, Christopher Lazik, Inês
Nunes, Isabella Graßl, Jan-Philipp Steghöfer, Joeri Exelmans, Julian
Oertel, Kai Marquardt, Katharina Juhnke, Kurt Schneider, Lucas Gren,
Lucia Happe, Marc Herrmann, Marvin Wyrich, Matthias Tichy, Miguel
Goulão, Rebekka Wohlrab, Reyhaneh Kalantari, Robert Heinrich, Sandra
Greiner, Satrio Adi Rukmono, Shalini Chakraborty, Silvia Abrahão, and
Vasco Amaral. 2024. Human factors in model-driven engineering: future
research goals and initiatives for MDE. Softw. Syst. Model. 23, 4
(2024), 801--819. \[122\] Grischa Liebel, Nadja Marko, Matthias Tichy,
Andrea Leitner, and Jörgen Hansson. 2018. Model-based engineering in the
embedded systems domain: an industrial survey on the state-of-practice.
Softw. Syst. Model. 17, 1 (2018), 91--113. \[123\] José Antonio
Hernández López and Jesús Sánchez Cuadrado. 2020. MAR: a structure-based
search engine for models. In Proc. of the ACM/IEEE 23rd International
Conference on Model Driven Engineering Languages and Systems
(MODELS'20), Eugene Syriani, Houari A. Sahraoui, Juan de Lara, and
Silvia Abrahão (Eds.). ACM, 57--67. \[124\] José Antonio Hernández López
and Jesús Sánchez Cuadrado. 2022. An eﬃcient and scalable search engine
for models. Software and Systems Modeling 21, 5 (2022), 1715--1737.
\[125\] José Antonio Hernández López and Jesús Sánchez Cuadrado. 2023.
Generating Structurally Realistic Models With Deep Autoregressive
Networks. IEEE Trans. Software Eng. 49, 4 (2023), 2661--2676. \[126\]
José Antonio Hernández López, Riccardo Rubei, Jesús Sánchez Cuadrado,
and Davide Di Ruscio. 2022. Machine learning methods for model
classiﬁcation: a comparative study. In Proc. of the 25th International
Conference on Model Driven Engineering Languages and Systems (MODELS).
165--175. \[127\] Levi Lúcio, Moussa Amrani, Juergen Dingel, Leen
Lambers, Rick Salay, Gehan M. K. Selim, Eugene Syriani, and Manuel
Wimmer. 2016. Model transformation intents and their properties. Softw.
Syst. Model. 15, 3 (2016), 647--684. \[128\] Daniel Lucrédio, Renata P.
de M. Fortes, and Jon Whittle. 2008. MOOGLE: A model search engine. In
Proc. of the International Conference on Model driven engineering
languages and systems (MODELS'08). Springer, 296--310. \[129\] José
Antonio Hernández López, Javier Luis Cánovas Izquierdo, and Jesús
Sánchez Cuadrado. 2024. ModelSet: A labelled dataset of software models
for machine learning. Science of Computer Programming 231 (2024),
103009. \[130\] Zhiyi Ma, Xiao He, and Chao Liu. 2013. Assessing the
quality of metamodels. Frontiers of Computer Science 7, 4 (2013),
558--570. \[131\] Usman Mansoor, Marouane Kessentini, Philip Langer,
Manuel Wimmer, Slim Bechikh, and Kalyanmoy Deb. 2015. MOMM:
Multi-objective model merging. J. Syst. Softw. 103 (2015), 423--439.
\[132\] Tom Mens. 2005. On the Use of Graph Transformations for Model
Refactoring. In Proc. of the International Summer School on Generative
and Transformational Techniques in Software Engineering (GTTSE'05)
(LNCS, Vol. 4143). Springer, 219--257. \[133\] Chihab eddine Mokaddem,
Houari Sahraoui, and Eugene Syriani. 2018. Recommending model
refactoring rules from refactoring examples. In Proc. of the 21th
ACM/IEEE International Conference on Model Driven Engineering Languages
and Systems (MODELS'18). 257--266. \[134\] Konstantinos Mokos, George
Meditskos, Panagiotis Katsaros, Nick Bassiliades, and Vangelis
Vasiliades. 2010. Ontology-based model driven engineering for safety
veriﬁcation. In Proc. of the 36th EUROMICRO Conference on Software
Engineering and Advanced Applications (SEAA). 47--54. \[135\]
Pierre-Alain Muller, Franck Fleurey, and Jean-Marc Jézéquel. 2005.
Weaving Executability into Object-Oriented Meta-languages. In Proc. of
the 8th International Conference on Model Driven Engineering Languages
and Systems (MODELS'13) (LNCS, Vol. 3713). Springer, 264--278. \[136\]
Gunter Mussbacher, Daniel Amyot, Ruth Breu, Jean-Michel Bruel, Betty H.
C. Cheng, Philippe Collet, Benoît Combemale, Robert B. France, Rogardt
Heldal, James H. Hill, Jörg Kienzle, Matthias Schöttle, Friedrich
Steimann, Dave R. Stikkolorum, and Jon Whittle. 2014. The Relevance of
Model-Driven Engineering Thirty Years from Now. In Proc. of the 17th
International Conference on Model-Driven Engineering Languages and
Systems (MODELS'14) (LNCS, Vol. 8767). Springer, 183--200. \[137\]
Andrey Nechypurenko, Egon Wuchner, Jules White, and Douglas C. Schmidt.
2007. Applying Model Intelligence Frameworks for Deployment Problem in
Real-Time and Embedded Systems. In Proc. of the International Conference
on Model Driven Engineering Languages and Systems (MOD- ELS'07).
Springer, 143--151. \[138\] Phuong T Nguyen, Juri Di Rocco, Davide Di
Ruscio, Alfonso Pierantonio, and Ludovico Iovino. 2019. Automated
classiﬁcation of metamodel repositories: a machine learning approach. In
Proc. of the ACM/IEEE 22nd International Conference on Model Driven
Engineering Languages and Systems (MODELS'19). 272--282. \[139\] Phuong
Thanh Nguyen, Davide Di Ruscio, Alfonso Pierantonio, Juri Di Rocco, and
Ludovico Iovino. 2021. Convolutional neural networks for enhanced
classiﬁcation mechanisms of metamodels. J. Syst. Softw. 172 (2021).
\[140\] Padmalata Nistala, Asha Rajbhoj, Vinay Kulkarni, Sapphire
Noronha, and Ankit Joshi. 2024. An industrial experience report on
model-based, AI-enabled proposal development for an RFP/RFI. Science of
Computer Programming 233 (2024), 103058. Manuscript submitted to ACM 22
Burgueño, Di Ruscio, Sahraoui, and Wimmer

\[141\] OMG. 2005. MOF QVT Final Adopted Speciﬁcation. Object Management
Group. OMG doc. ptc/05-11-01. \[142\] OMG. 2017. Action Language for
Foundational UML (Alf). Object Management Group.
https://www.omg.org/spec/ALF/1.1/PDF. \[143\] Ana Pescador and Juan de
Lara. 2016. DSL-maps: from requirements to design of domain-speciﬁc
languages. In Proc. of the 31st IEEE/ACM International Conference on
Automated Software Engineering. 438--443. \[144\] Elena Planas, Gwendal
Daniel, Marco Brambilla, and Jordi Cabot. 2021. Towards a model-driven
approach for multiexperience AI-based user interfaces. Softw. Syst.
Model. 20, 4 (2021), 997--1009. \[145\] Saheed Popoola, Dimitrios S.
Kolovos, and Horacio Hoyos Rodriguez. 2016. EMG: A Domain-Speciﬁc
Transformation Language for Synthetic Model Generation. In Proc. of the
9th International Conference on Theory and Practice of Model
Transformations ( ICMT'16@STAF) (LNCS, Vol. 9765). Springer, 36--51.
\[146\] Ivan Porres. 2003. Model Refactorings as Rule-Based Update
Transformations. In Proc. of the 6th International Conference on The
Uniﬁed Modeling Language, Modeling Languages and Applications (UML'03)
(LNCS, Vol. 2863). Springer, 159--174. \[147\] A. Pretschner, W.
Prenninger, S. Wagner, C. Kühnel, M. Baumgartner, B. Sostawa, R. Zölch,
and T. Stauner. 2005. One evaluation of model-based testing and its
automation. In Proc. of the 27th International Conference on Software
Engineering (ICSE'05). ACM, 392--401. \[148\] Abbas Rahimi, Massimo
Tisi, Shekoufeh Kolahdouz Rahimi, and Luca Berardinelli. 2023. Towards
Generating Structurally Realistic Models by Generative Adversarial
Networks. In Proc. of the ACM/IEEE International Conference on Model
Driven Engineering Languages and Systems (MODELS'23'). IEEE, 597--604.
\[149\] Nicolas Revault, Houari A Sahraoui, Gilles Blain, and
Jean-François Perrot. 1995. A Metamodeling technique: The METAGEN
system. In Proceed- ings of TOOLS, Vol. 16. 127--139. \[150\] Michael
Riegler, Johannes Sametinger, Michael Vierhauser, and Manuel Wimmer.
2023. A model-based mode-switching framework based on security
vulnerability scores. Journal of Systems & Software 200 (2023). \[151\]
José Eduardo Rivera, Francisco Durán, and Antonio Vallecillo. 2009.
Formal Speciﬁcation and Analysis of Domain Speciﬁc Models Using Maude.
Simul. 85, 11-12 (2009), 778--792. \[152\] José Eduardo Rivera, Daniel
Ruiz-González, Fernando López-Romero, and José María Bautista. 2009.
Wires\* : A Tool for Orchestrating Model Transformations. In Proc. of
the XIV Jornadas de Ingeniería del Software y Bases de Datos (JISBD'09).
158--161. \[153\] Gregorio Robles, Truong Ho-Quang, Regina Hebig, Michel
RV Chaudron, and Miguel Angel Fernandez. 2017. An extensive dataset of
UML models in GitHub. In Proc. of the IEEE/ACM 14th International
Conference on Mining Software Repositories (MSR'17). 519--522. \[154\]
Karina Robles, Anabel Fraga, Jorge Morato, and Juan Llorens. 2012.
Towards an ontology-based retrieval of UML Class Diagrams. Information
and Software Technology 54, 1 (2012), 72--86. \[155\] Esteban Robles
Luna, José Matías Rivero, Matias Urbieta, and Jordi Cabot. 2014.
Improving the scalability of Web applications with runtime
transformations. In Proc. of the 14th International Conference on Web
Engineering (ICWE). Springer, 430--439. \[156\] Juri Di Rocco, Davide Di
Ruscio, Ludovico Iovino, and Alfonso Pierantonio. 2015. Collaborative
Repositories in Model-Driven Engineering. IEEE Softw. 32, 3 (2015),
28--34. \[157\] Juri Di Rocco, Davide Di Ruscio, Claudio Di Sipio,
Phuong T. Nguyen, and Riccardo Rubei. 2024. On the use of Large Language
Models in Model-Driven Engineering. arXiv:2410.17370 \[cs.SE\]
https://arxiv.org/abs/2410.17370 \[158\] Louis M. Rose, Dimitrios S.
Kolovos, Richard F. Paige, Fiona A. C. Polack, and Simon M. Poulding.
2014. Epsilon Flock: a model migration language. Softw. Syst. Model. 13,
2 (2014), 735--755. \[159\] Stephan Roser and Bernhard Bauer. 2005.
Ontology-Based Model Transformation. In Proc. of the Satellite Events at
the MODELS 2005 (LNCS, Vol. 3844). Springer, 355--356. \[160\] Riccardo
Rubei, Juri Di Rocco, Davide Di Ruscio, Phuong T. Nguyen, and Alfonso
Pierantonio. 2021. A Lightweight Approach for the Automated
Classiﬁcation and Clustering of Metamodels. In Companion Proc. of the
ACM/IEEE International Conference on Model Driven Engineering Languages
and Systems Companion (MODELS'21). IEEE, 477--482. \[161\] Davide Di
Ruscio, Ludovico Iovino, and Alfonso Pierantonio. 2012. Coupled
Evolution in Model-Driven Engineering. IEEE Softw. 29, 6 (2012), 78--84.
\[162\] Davide Di Ruscio, Dimitrios S. Kolovos, Juan de Lara, Alfonso
Pierantonio, Massimo Tisi, and Manuel Wimmer. 2022. Low-code development
and model-driven engineering: Two sides of the same coin? Softw. Syst.
Model. 21, 2 (2022), 437--446. \[163\] Andrey Sadovykh, Bilal Said,
Dragos Truscan, and Hugo Bruneliere. 2024. An iterative approach for
model-based requirements engineering in large collaborative projects: A
detailed experience report. Science of Computer Programming 232 (2024),
103047. \[164\] Rijul Saini, Gunter Mussbacher, Jin L. C. Guo, and Jörg
Kienzle. 2022. Automated, interactive, and traceable domain modelling
empowered by artiﬁcial intelligence. Softw. Syst. Model. 21, 3 (2022),
1015--1045. \[165\] Lucas Sakizloglou, Sona Ghahremani, Matthias
Barkowsky, and Holger Giese. 2022. Incremental execution of temporal
graph queries over runtime models with history and its applications.
Softw. Syst. Model. 21, 5 (2022), 1789--1829. \[166\] Marcel Schäfer and
Martin Gogolla. 2020. Enhancing development and consistency of UML
models and model executions with USE studio. In Companion Proc. of the
ACM/IEEE 23rd International Conference on Model Driven Engineering
Languages and Systems (MODELS'20). ACM, 14:1-- 14:5. \[167\] Douglas C.
Schmidt. 2006. Guest Editor's Introduction: Model-Driven Engineering.
Computer 39, 2 (2006), 25--31.

Manuscript submitted to ACM Automation in Model-Driven Engineering: A
look back, and ahead 23

\[168\] Sven Schneider, Leen Lambers, and Fernando Orejas. 2017.
Symbolic model generation for graph properties. In Proc. of the
International Conference on Fundamental Approaches to Software
Engineering (FASE) (LNCS, Vol. 10202). Springer, 226--243. \[169\]
Oszkár Semeráth, Aren A. Babikian, Anqi Li, Kristóf Marussy, and Dániel
Varró. 2020. Automated generation of consistent models with structural
and attribute constraints. In Proc. of the ACM/IEEE 23rd International
Conference on Model Driven Engineering Languages and Systems
(MODELS'20). ACM, 187--199. \[170\] Sagar Sen, Benoit Baudry, and Hans
Vangheluwe. 2010. Towards Domain-speciﬁc Model Editors with Automatic
Model Completion. Simul. 86, 2 (2010), 109--126. \[171\] Shane Sendall
and Wojtek Kozaczynski. 2003. Model Transformation: The Heart and Soul
of Model-Driven Software Development. IEEE Softw. 20, 5 (2003), 42--45.
\[172\] Claudio Di Sipio, Riccardo Rubei, Juri Di Rocco, Davide Di
Ruscio, and Ludovico Iovino. 2024. On the use of LLMs to support the
development of domain-speciﬁc modeling languages. In Companion Proc. of
MODELS'24. ACM, 596--601. \[173\] Mathias Soeken, Robert Wille, Mirco
Kuhlmann, Martin Gogolla, and Rolf Drechsler. 2010. Verifying UML/OCL
models using Boolean satisﬁability. In 2010 Design, Automation & Test in
Europe Conference & Exhibition (DATE 2010). IEEE, 1341--1344. \[174\]
Jonathan Sprinkle and Gabor Karsai. 2004. A domain-speciﬁc visual
language for domain model evolution. J. Vis. Lang. Comput. 15, 3-4
(2004), 291--307. \[175\] Steﬀen Staab, Tobias Walter, Gerd Gröner, and
Fernando Silva Parreiras. 2010. Model driven engineering with ontology
technologies. In Reasoning Web International Summer School. 62--98.
\[176\] Martin Stancek, Ivan Polasek, Tibor Zalabai, Juraj Vincur, Rodi
Jolak, and Michel Chaudron. 2024. Collaborative software design and
modeling in virtual reality. Inf. Softw. Technol. 166, C (March 2024),
17 pages. \[177\] Friedrich Steimann and Bastian Ulke. 2013. Generic
Model Assist. In Proc. of the 16th International Conference on
Model-Driven Engineering Languages and Systems (MODELS'13) (LNCS, Vol.
8107). Springer, 18--34. \[178\] Sagar Sunkle, Krati Saxena, Ashwini
Patil, and Vinay Kulkarni. 2022. AI-driven streamlined modeling:
experiences and lessons learned from multiple domains. Softw. Syst.
Model. 21, 3 (2022), 1--23. \[179\] Gerson Sunyé, Damien Pollet, Yves Le
Traon, and Jean-Marc Jézéquel. 2001. Refactoring UML Models. In Proc. of
the 4th International Conference on The Uniﬁed Modeling Language,
Modeling Languages and Applications (UML'01) (LNCS, Vol. 2185).
Springer, 134--148. \[180\] Eugene Syriani, Hans Vangheluwe, Raphael
Mannadiar, Conner Hansen, Simon Van Mierlo, and Hüseyin Ergin. 2013.
AToMPM: A Web-based Modeling Environment. In Companion Proc. of the 16th
International Conference on Model Driven Engineering Languages and
Systems (MODELS'13) (CEUR Workshop Proceedings, Vol. 1115). CEUR-WS.org,
21--25. \[181\] Gabriele Taentzer, Claudia Ermel, Philip Langer, and
Manuel Wimmer. 2014. A fundamental approach to model versioning based on
graph modiﬁcations: from theory to implementation. Softw. Syst. Model.
13, 1 (2014), 239--272. \[182\] Gabriele Taentzer, Florian Mantz, and
Yngve Lamo. 2012. Co-transformation of Graphs and Type Graphs with
Application to Model Co-evolution. In Proc. of the International
Conference on Graph Transformations (ICGT) (LNCS, Vol. 7562). Springer,
326--340. \[183\] Fei Tao, He Zhang, Ang Liu, and Andrew YC Nee. 2018.
Digital twin in industry: State-of-the-art. IEEE Transactions on
Industrial Informatics 15, 4 (2018), 2405--2415. \[184\] Christof
Tinnes, Alisa Welter, and Sven Apel. 2024. Leveraging Large Language
Models for Software Model Completion: Results from Industrial and Public
Datasets. arXiv:2406.17651 \[cs.SE\] https://arxiv.org/abs/2406.17651
\[185\] Massimo Tisi, Salvador Martínez Perez, and Hassene Choura. 2013.
Parallel Execution of ATL Transformation Rules. In Proc. of the 16th
Interna- tional Conference on Model-Driven Engineering Languages and
Systems ( MODELS'13) (LNCS, Vol. 8107). Springer, 656--672. \[186\]
Antonio Vallecillo. 2015. On the industrial adoption of model driven
engineering. Is your company ready for MDE? International Journal of
Information Systems and Software Engineering for Big Companies 1, 1
(2015), 52--68. \[187\] Zahra VaraminyBahnemiry, Jessie Galasso, Khalid
Belharbi, and Houari Sahraoui. 2021. Automated Patch Generation for
Fixing Semantic Er- rors in ATL Transformation Rules. In Proc. of the
ACM/IEEE 24th International Conference on Model Driven Engineering
Languages and Systems (MODELS'21). 13--23. \[188\] Dániel Varró and
Zoltán Balogh. 2007. Automating model transformation by example using
inductive logic programming. In Proc. of the 2007 ACM Symposium on
Applied Computing. 978--984. \[189\] Roberto Verdecchia, Patricia Lago,
Christof Ebert, and Carol De Vries. 2021. Green IT and green software.
IEEE Software 38, 6 (2021), 7--15. \[190\] Tobias Walter, Fernando Silva
Parreiras, and Steﬀen Staab. 2014. An ontology-based framework for
domain-speciﬁc modeling. Software & Systems Modeling 13, 1 (2014),
83--108. \[191\] Chao Wang, Hong Li, Zhigang Gao, Min Yao, and Yuhao
Yang. 2010. An automatic documentation generator based on model-driven
techniques. International Conference on Computer Engineering and
Technology, Proceedings (ICCET) 4 (2010). \[192\] Viola Wenz, Arno
Kesper, and Gabriele Taentzer. 2021. Detecting Quality Problems in Data
Models by Clustering Heterogeneous Data Values. In Companion Proc. of
the ACM/IEEE International Conference on Model Driven Engineering
Languages and Systems (MODELS'23). IEEE, 150--159. \[193\] Bernhard
Westfechtel. 2014. Merging of EMF models - Formal foundations. Softw.
Syst. Model. 13, 2 (2014), 757--788. \[194\] Martin Weyssow, Aton
Kamanda, and Houari Sahraoui. 2024. CodeUltraFeedback: An LLM-as-a-Judge
Dataset for Aligning Large Language Models to Coding Preferences. arXiv
preprint arXiv:2403.09032 (2024).

                                                                                                                        Manuscript submitted to ACM

24 Burgueño, Di Ruscio, Sahraoui, and Wimmer

\[195\] Martin Weyssow, Houari Sahraoui, and Eugene Syriani. 2022.
Recommending metamodel concepts during modeling activities with
pre-trained language models. Software and Systems Modeling 21, 3 (2022),
1071--1089.

Manuscript submitted to ACM This figure "acm-jdslogo.png" is available
in "png" format from:

        http://arxiv.org/ps/2405.18539v2


