                                             Event-Driven Inconsistency Detection Between UML Class and
                                                                 Sequence Diagrams
                                                                     Luan Lazzari                                                          Kleinner Farias
                                                           luanlazzari@edu.unisinos.br                                           kleinnerfarias@unisinos.br
                                                       Universidade do Vale do Rio dos Sinos                                Universidade do Vale do Rio dos Sinos
                                                      São Leopoldo, Rio Grande do Sul, Brazil                              São Leopoldo, Rio Grande do Sul, Brazil

                                         ABSTRACT                                                                    The Harmony Validator tool (Table 1) was conceived to address
                                         Modeling is a central and demanding activity in software engi-          an ongoing challenge in model-driven engineering, i.e., the auto-
                                         neering that requires skills such as abstraction, consistency main-     matic detection of inconsistencies across UML diagrams [22, 23]. As

arXiv:2511.07742v1 \[cs.SE\] 11 Nov 2025

                                         tenance, and precise communication. These skills are difficult to       software systems evolve, disagreements often arise between struc-
                                         master and even harder to teach effectively. Educators and students     tural (class) and behavioral (sequence) diagrams, leading to concep-
                                         often struggle to understand and manage inconsistencies that arise      tual mismatches that compromise model integrity. Manual valida-
                                         during the modeling process. To address this challenge, we present      tion of these relationships is error-prone and time-consuming, par-
                                         Harmony Validator, a tool integrated as a plugin for the Papyrus        ticularly in collaborative modeling environments. Existing tools typ-
                                         modeling environment, designed to automatically detect and re-          ically detect inconsistencies through post-hoc or batch verification,
                                         port inconsistencies in UML models, including class and sequence        providing limited real-time support [16, 26]. Harmony Validator
                                         diagrams. The tool adopts an event-driven architecture that contin-     fills this gap through an event-driven architecture that continu-
                                         uously monitors modeling actions and notifies users of emerging         ously monitors modeling actions and reports inconsistencies as
                                         inconsistencies in real time. This approach enhances awareness of       they occur. This design supports both students and practitioners in
                                         model integrity and supports the iterative refinement of design ar-     identifying, interpreting, and resolving inconsistencies early in the
                                         tifacts. The paper describes the architecture, detection mechanisms,    modeling process, reducing cognitive load [2, 20] and enhancing
                                         and usage scenarios of Harmony Validator. It also includes a case       design correctness.
                                         study conducted with students in a software engineering course to           Users employ the Harmony Validator within the Papyrus1 mod-
                                         evaluate the perceived usefulness and benefits of UML modeling in       eling environment to create and refine UML class and sequence
                                         teaching and learning. Our results indicate that Harmony Validator      diagrams while the tool continuously monitors model changes
                                         fosters a better understanding of model consistency and promotes        and automatically detects inconsistencies such as undefined oper-
                                         reflective learning practices in software modeling education.           ations, broken associations, or mismatched messages. Real-time
                                                                                                                 notifications highlight the affected elements, prompting immedi-
                                         KEYWORDS                                                                ate user attention and fostering iterative correction and design
                                                                                                                 coherence. In educational settings, Harmony Validator has been
                                         Event-driven architecture; EDA; UML models; Model Inconsisten-          used in laboratory sessions to train students in identifying and
                                         cies                                                                    resolving inconsistencies, improving modeling fluency and aware-
                                                                                                                 ness of inter-diagram dependencies. Built on robust foundations
                                         1    INTRODUCTION                                                       in model validation and event-driven systems, the tool extends
                                                                                                                 Papyrus—based on the Eclipse Modeling Framework2 (EMF) and in-
                                         High-quality documentation significantly increases the success of
                                                                                                                 tegrates Apache Kafka3 for efficient event handling. Implemented
                                         software projects [4, 14, 19, 24]. This is particularly evident for
                                                                                                                 in Java language and deployed via Docker containers, Harmony
                                         visual documentation based on the Unified Modeling Language
                                                                                                                 Validator ensures interoperability, reproducibility, and scalability,
                                         (UML) [18], which remains a central artifact in both academia and
                                                                                                                 enabling its seamless integration into both academic experiments
                                         industry [10, 11]. UML diagrams foster shared understanding, en-
                                                                                                                 and industrial modeling workflows.
                                         courage design discussions, and support reasoning about system
                                                                                                                     The Harmony Validator distinguishes itself from existing ap-
                                         structure and behavior [8, 19]. Recent evidence shows that UML
                                                                                                                 proaches [15, 16, 21] in three main ways: (i) It introduces an event-
                                         is regaining attention as a standard medium for documenting and
                                                                                                                 driven, continuous-monitoring paradigm, enabling real-time incon-
                                         communicating software design decisions [19]. In educational set-
                                                                                                                 sistency detection rather than relying on static, batch-oriented
                                         tings, UML enhances the teaching of abstraction, decomposition,
                                                                                                                 validation; (ii) It performs bi-directional consistency checking be-
                                         and communication skills. In industry, consistent UML documen-
                                                                                                                 tween structural and behavioral UML diagrams, ensuring semantic
                                         tation [5, 6, 25] improves knowledge transfer across teams and
                                                                                                                 alignment between class definitions and interaction flows; and (iii)
                                         contributes to software maintainability and quality [1, 9]. Empirical
                                                                                                                 It was designed as both a pedagogical and research-oriented tool,
                                         findings demonstrate that developers achieve higher functional
                                                                                                                 supporting empirical investigations into modeling practices while
                                         correctness and introduce fewer defects during maintenance when
                                                                                                                 also assisting practitioners in maintaining model integrity.
                                         UML models are up-to-date and consistent [1, 4, 8, 17]. These stud-
                                         ies reinforce the importance of inconsistency detection to sustain      1 Papyrus: https://eclipse.dev/papyrus/index.html
                                         the reliability of UML models and to preserve their benefits for        2 Eclipse Modeling Framework: https://eclipse.dev/emf/

                                         software comprehension and evolution.                                   3 Apache Kafka: https://kafka.apache.org/

Luan Lazzari and Kleinner Farias

          Code metadata item                                       Description
          Current code version                                     V1.0
          Permanent link to code/repository used for this code     https://github.com/luanlazz/uml-harmony-validator-service
          version                                                  https://github.com/luanlazz/uml-harmony-validator-plugin
          Legal Code License                                       MIT License
          Code versioning system used                              git
          Software code languages, tools, and services used        Java, Kafka, Redis
          Compilation requirements, operating environments         Docker, Java 17, Apache Maven 3.5+
          and dependencies
          Link to developer documentation/manual               https://github.com/luanlazz/uml-harmony-validator-
                                                               service/blob/master/readme.md https://github.com/luanlazz/uml-
                                                               harmony-validator-plugin/blob/main/README.md
          Support email for questions                          luanlazzari@gmail.com
                                            Table 1: Description of the source code metadata.

This study is structured as follows: Section 2 describe the pro- 2.2
Software functionalities posed tool, outlining its architecture,
functionalities and practi- The Harmony Validator provides a set of
major functionalities de- cal use case. Section 3 presents an practical
usage example of the signed to support inconsistency detection and
enhance user aware- proposed tool. Section 4 outlines the impact of the
proposed tool. ness during modeling activities: Finally, Section 5
introduces some concluding remarks and future (1) Real-time
inconsistency detection: Continuously monitors plans. user actions in
Papyrus and detects inconsistencies between UML class and sequence
diagrams as they occur. (2) Event-driven notification system: Uses an
asynchronous event 2 SOFTWARE DESCRIPTION bus to deliver immediate
alerts through the modeling inter- 2.1 Software architecture face when
inconsistencies are found. (3) Distributed microservice architecture:
Each component runs Figure 1 presents an overview of the Harmony
Validator archi- independently in Docker containers, ensuring
scalability tecture, which follows an event-driven architectural style
\[3, 12, 13\]. and modular deployment. The system is divided into two
main modules: the Client App and (4) Data caching and aggregation:
Employs Redis for caching the Docker Host environment. This separation
ensures modularity, detected inconsistencies and aggregating results,
reducing scalability, and ease of deployment across different platforms.
computation time for recurring analyses. In Figure 1(A), the Client App
corresponds to a plugin integrated (5) Seamless integration with
Papyrus: Provides an intuitive into the Papyrus modeling environment,
where users perform UML panel that allows users to inspect inconsistency
details and modeling activities. Within Papyrus, the Harmony Validator
adds navigate to affected elements within the modeling environ- a custom
panel that continuously monitors and reports inconsisten- ment. cies
detected in the UML model. The Harmony Validator interface presents
feedback to the user through visual indicators that identify These
functionalities collectively enable developers and learn- affected
elements and diagrams. This integration enables users to ers to maintain
high levels of model consistency while improving maintain focus on
modeling tasks while receiving real-time feed- comprehension of
inter-diagram dependencies. back on inconsistencies. In Figure 1(B), the
Docker Host contains a set of services de- 2.3 Sample use case ployed as
independent containers, connected through an asynchro- A typical use
case involves a user editing a UML class and sequence nous Event Bus.
The event-driven layer is responsible for receiving diagram in Papyrus.
As the user introduces changes---for instance, and processing model
modification events. The Model Reader Ser- renaming an operation or
modifying an association---the Harmony vice retrieves the updated model
data from Papyrus and publishes Validator automatically detects these
modifications through the the modification events to the system. The
Inconsistency Service Model Reader Service. Events are published to the
Event Bus, trigger- subscribes to these events, analyzes the model
state, and identifies ing the Inconsistency Service to re-evaluate the
affected diagrams. If inconsistencies across UML diagrams. Detected
inconsistencies are a mismatch or undefined reference is identified, the
system caches then cached using Redis for quick retrieval and aggregated
notifi- the result and notifies the user through the Papyrus panel. The
user cations. All communication between the client and backend follows
can then click the inconsistency message to navigate directly to the an
HTTP pattern implemented through an API Gateway/BFF problematic element,
correct the model, and immediately see the (Backend for Frontend)
module, which mediates requests from inconsistency resolved. This
feedback loop exemplifies the tool's the desktop client to the
microservices running in Docker. This ability to support reflective
modeling practices and to reinforce the architecture promotes decoupling
between components, supports understanding of consistency rules during
both educational and parallel modeling scenarios, and allows for
seamless scalability. industrial modeling activities. Event-Driven
Inconsistency Detection Between UML Class and Sequence Diagrams

Figure 1: Event-driven architecture of the Harmony Validator. (A) Client
App integrated with Papyrus modeling environment. (B) Docker Host
containing model reader, inconsistency detection, and event bus
services.

3 ILLUSTRATIVE EXAMPLES Validator automatically registers the
modifications through the Figure 2 illustrates the main functionalities
of the Harmony Validator event bus, ensuring immediate propagation of
changes to the incon- tool embedded in the Papyrus modeling environment.
Part (A) sistency detection service. Finally, Part (D) highlights the
Harmony shows the Project Explorer, where users organize and access
Validator Panel, where the results of the analysis are presented.
multiple UML projects and diagrams. In this example, the project The
panel lists all detected inconsistencies, their type, location, and
AvaliationQuestions contains a set of UML class and sequence dia-
associated consistency rule. In the illustrated example, six incon-
grams used for teaching and experimentation. Harmony Validator
sistencies were identified, including a message without a name operates
in the background, continuously monitoring changes to and an undefined
operation. Users can click on each entry to nav- these diagrams.
Whenever a model element is added, modified, or igate directly to the
affected element, view detailed descriptions, removed, the system
triggers an event that is analyzed by the event- and correct the
detected inconsistencies. This interactive feedback driven architecture
described previously. This real-time monitoring loop demonstrates how
the Harmony Validator integrates real- ensures that inconsistencies are
promptly detected and reported time detection, visualization, and
corrective guidance to promote without interrupting the modeling
workflow. high-quality UML modeling practices. Part (B) depicts the
modeling canvas, where the user edits the UML diagrams. In this
workspace, developers can create and 4 IMPACT manipulate classes,
associations, and behavioral interactions. The The Harmony Validator
tool creates new opportunities for re- Harmony Validator automatically
identifies inconsistencies that search and practice in model-driven
engineering. Empirical ev- arise during these edits---for example,
operations that are invoked idence suggests a renewed use of UML models
in open-source in a sequence diagram but not defined in the
corresponding class projects hosted on platforms such as GitHub, where
visual and diagram. This continuous analysis exemplifies the tool's
primary textual representations coexist through tools like PlainUML
\[19\]. functionality: maintaining semantic and structural consistency
be- Harmony Validator supports the construction of consistent class
tween UML views. The modeler can work naturally in the diagram and
sequence diagrams, providing a foundation for automatically editor,
while the tool's backend services detect and store data about
transforming them into textual UML representations (e.g., pUML)
inconsistencies, enabling transparent, proactive validation during using
large language models (LLMs). This opens an innovative re- design
activities. search direction for leveraging consistent visual models to
automat- Part (C) presents the modeling palette, which provides mod-
ically generate, refine, and synchronize textual and code-based rep-
eling elements such as Class, Association, and Enumeration. As
resentations. Such integration between consistency-validated UML users
drag and drop new elements into the diagram, the Harmony diagrams and
AI-driven code generation promotes more traceable,  Luan Lazzari and
Kleinner Farias

Figure 2: Illustrative example of the Harmony Validator integrated into
Papyrus. (A) Project Explorer for model organization. (B) UML diagram
editor showing model elements. (C) Modeling palette with available UML
elements. (D) Harmony Validator panel displaying detected
inconsistencies and corresponding rules.

verifiable, and maintainable software artifacts, thereby extending 5
CONCLUSIONS AND FUTURE WORK the reach of empirical research on UML's
resurgence in open-source This paper presented the Harmony Validator, an
event-driven ecosystems. tool integrated into the Papyrus environment to
detect and manage From a research perspective, Harmony Validator
advances ex- inconsistencies in UML class and sequence diagrams through
real- perimental studies in software modeling by enabling fine-grained
time feedback and automated analysis. Its distributed, microservice-
analysis of how inconsistencies emerge and are resolved during based
architecture ensures scalability, modularity, and efficient modeling
activities. The tool's event-driven logging infrastructure event
processing, while bridging modeling and verification to main- records
real-time user interactions, allowing researchers to explore tain
consistent, reliable UML artifacts. Beyond its technical con- new
questions about cognitive load \[2, 7\], decision-making, and the
tribution, Harmony Validator advances education, research, and
effectiveness of automated feedback in maintaining model quality.
industrial practice: it helps students understand and correct model-
These data can be used to design and reproduce experiments on ing
inconsistencies, enables researchers to collect empirical data on how
users respond to different types of inconsistencies or how modeling
behavior, and improves productivity and model integrity automated
validation influences modeling performance. Moreover, in professional
workflows. By combining modern architectural the combination of Harmony
Validator's architecture and its po- patterns with intelligent feedback,
the tool enhances the quality, tential for data analytics paves the way
for adaptive modeling traceability, and maintainability of UML models.
Future extensions environments where intelligent assistants or LLMs
reason over will broaden diagram support, refine detection rules, and
incorpo- event streams to suggest corrective actions, anticipate
conflicts, rate learning-based mechanisms, reinforcing Harmony
Validator's and support the co-creation of consistent UML design models.
role as a foundation for intelligent, context-aware modeling envi- In
practice, Harmony Validator improves the daily work of ronments that
foster human--AI collaboration in software design. both educators and
developers. In academic environments, it as- Future developments of the
Harmony Validator will focus on sists instructors in demonstrating the
principles of consistency extending its applicability, intelligence, and
integration capabilities. and integrity in UML design, allowing students
to immediately Planned enhancements include adding new consistency rules
and visualize inconsistencies and learn corrective modeling behaviors
supporting a broader range of UML diagrams, such as activity, com-
through practice. In industrial settings, the tool enhances modeling
ponent, and state machine diagrams, to enable more comprehensive
workflows by automating consistency checks, reducing manual validation
coverage. The tool will also incorporate machine learn- review effort,
and increasing the overall reliability of model-driven ing and large
language model components to suggest corrective development pipelines.
Event-Driven Inconsistency Detection Between UML Class and Sequence
Diagrams

actions, anticipate modeling errors, and automatically generate tex-
Syntactic and Semantic Gap. Journal Universal Computing Science 15, 11
(2009), tual UML representations, reinforcing its synergy with tools
such as 2225--2253. \[18\] OMG. 2017. UML: Infrastructure specification.
PlainUML. From a research perspective, Harmony Validator will
https://www.omg.org/spec/UML/2.5.1/PDF. continue to serve as a platform
for empirical studies that analyze \[19\] Joseph Romeo, Marco Raglianti,
Csaba Nagy, and Michele Lanza. 2025. UML is Back. Or is it?
Investigating the Past, Present, and Future of UML in Open user
behavior, cognitive processes, and learning patterns during Source
Software. In 2025 IEEE/ACM 47th International Conference on Software
modeling tasks. Furthermore, its containerized architecture will
Engineering (ICSE). 692--692. facilitate integration into continuous
development environments, \[20\] Matheus Segalotto, Willian Bolzan, and
Kleinner Farias. 2023. Effects of Mod- ularization on Developers'
Cognitive Effort in Code Comprehension Tasks: A allowing future
collaborations with industry partners to deploy the Controlled
Experiment. In XXXVII Brazilian Symposium on Software Engineering. tool
at scale in real-world software modeling pipelines. 206--215. \[21\]
Bastien Sultan and Ludovic Apvrille. 2024. AI-driven consistency of
SysML diagrams. In ACM/IEEE 27th International Conference on Model
Driven Engineering 6 ACKNOWLEDGMENT Languages and Systems. 149--159.
\[22\] Damiano Torre, Yvan Labiche, Marcela Genero, and Maged Elaasar.
2018. A This work was partially supported by the Conselho Nacional de
systematic identification of consistency rules for UML diagrams. Journal
of Desenvolvimento Científico e Tecnológico (CNPq) under Grant Systems
and Software 144 (2018), 121--142. \[23\] Damiano Torre, Yvan Labiche,
Marcela Genero, Maged Elaasar, and Claudio 312320/2025-6. Menghi. 2020.
UML consistency rules: a case study with open-source UML models. In 8th
International Conference on Formal Methods in Software Engineering.
130--140. REFERENCES \[24\] Eirik Tryggeseth. 1997. Report from an
experiment: Impact of documentation \[1\] Erik Arisholm, Lionel C
Briand, Siw Elisabeth Hove, and Yvan Labiche. 2006. on maintenance.
Empirical Software Engineering 2, 2 (1997), 201--207. The impact of UML
documentation on software maintenance: An experimental \[25\] Vanessa
Weber, Kleinner Farias, Lucian Gonçales, and Vinícius Bischoff. 2016.
evaluation. IEEE Transactions on Software Engineering 32, 6 (2006),
365--381. Detecting inconsistencies in multi-view UML models.
International Journal of \[2\] Willian Bolzan and Kleinner Farias. 2025.
Investigating EEG microstate analy- Computer Science and Software
Engineering 5, 12 (2016), 260. sis in cognitive software engineering
tasks: A systematic mapping study and \[26\] Hao Wu. 2017. MaxUSE: a
tool for finding achievable constraints and conflicts taxonomy. Comput.
Surveys (2025). for inconsistent UML class diagrams. In International
Conference on Integrated \[3\] Hebert Cabane and Kleinner Farias. 2024.
On the impact of event-driven ar- Formal Methods. Springer, 348--356.
chitecture on performance: An exploratory study. Future Generation
Computer Systems 153 (2024), 52--69. \[4\] Wojciech J Dzidek, Erik
Arisholm, and Lionel C Briand. 2008. A realistic empirical evaluation of
the costs and benefits of UML in software maintenance. IEEE Transactions
on Software Engineering 34, 3 (2008), 407--432. \[5\] Kleinner Farias.
2016. Empirical evaluation of effort on composing design models. arXiv
preprint arXiv:1610.09012 (2016). \[6\] Kleinner Farias, Alessandro
Garcia, and Carlos Lucena. 2012. Evaluating the impact of aspects on
inconsistency detection effort: a controlled experiment. In Model Driven
Engineering Languages and Systems: 15th International Conference, MODELS
2012, Innsbruck, Austria, September 30--October 5, 2012. Proceedings 15.
Springer, 219--234. \[7\] Lucian José Gonçales, Kleinner Farias, and
Bruno C da Silva. 2021. Measuring the cognitive load of software
developers: An extended Systematic Mapping Study. Information and
Software Technology 136 (2021), 106563. \[8\] Lucian José Gonçales,
Kleinner Farias, Toacy Cavalcante De Oliveira, and Murilo Scholl. 2019.
Comparison of software design models: an extended systematic mapping
study. ACM Computing Surveys (CSUR) 52, 3 (2019), 1--41. \[9\] Rodi
Jolak, Maxime Savary-Leblanc, Manuela Dalibor, Juraj Vincur, Regina
Hebig, Xavier Le Pallec, Michel Chaudron, Sébastien Gérard, Ivan
Polasek, and Andreas Wortmann. 2022. The influence of software design
representation on the de- sign communication of teams with diverse
personalities. In 25th International Conference on Model Driven
Engineering Languages and Systems. 255--265. \[10\] Ed Júnior, Kleinner
Farias, and Bruno Silva. 2021. A Survey on the Use of UML in the
Brazilian Industry. In XXXV Brazilian Symposium on Software Engineering.
275--284. \[11\] Ed Wilson Júnior, Kleinner Farias, and Bruno da Silva.
2022. On the use of UML in the brazilian industry: A survey. Journal of
Software Engineering Research and Development 10 (2022), 10--1. \[12\]
Luan Lazzari and Kleinner Farias. 2023. Event-driven architecture and
REST architectural style: An exploratory study on modularity. Journal of
applied research and technology 21, 3 (2023), 338--351. \[13\] Luan
Lazzari and Kleinner Farias. 2023. Uncovering the hidden potential of
event-driven architecture: A research agenda. arXiv preprint
arXiv:2308.05270 (2023). \[14\] Timothy C Lethbridge, Janice Singer, and
Andrew Forward. 2003. How software engineers use documentation: The
state of the practice. IEEE software 20, 6 (2003), 35--39. \[15\]
Luciano Marchezan, Wesley K. G. Assunçao, Edvin Herac, Saad Shafiq, and
Alexander Egyed. 2024. Exploring Dependencies Among Inconsistencies to
Enhance the Consistency Maintenance of Models. In 2024 IEEE
International Conference on Software Analysis, Evolution and
Reengineering (SANER). 147--158. \[16\] Luciano Marchezan, Marcel
Homolka, Andrei Blokhin, Wesley K. G. Assunção, Edvin Herac, and
Alexander Egyed. 2024. A tool for collaborative consistency checking
during modeling. In ACM/IEEE 27th International Conference on Model
Driven Engineering Languages and Systems. 655--659. \[17\] Kleinner SF
Oliveira, Karin Koogan Breitman, and Toacy Cavalcante de Oliveira. 2009.
A Flexible Strategy-Based Model Comparison Approach: Bridging the 
