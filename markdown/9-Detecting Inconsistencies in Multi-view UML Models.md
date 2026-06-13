International Journal of Computer Science and Software Engineering
(IJCSSE), Volume 5, Issue 12, December 2016 ISSN (Online): 2409-4285
www.IJCSSE.org Page: 260-264

                        Detecting Inconsistencies in Multi-view UML Models
                               Vanessa Weber1, Kleinner Farias2, Lucian Gonçales3, Vinícius Bischoff4

        1, 2, 3, 4
                     Interdisciplinary Graduate Program in Applied Computing (PIPCA), University of Vale do Rio dos Sinos
                                          (UNISINOS), São Leopoldo, Rio Grande do Sul, Brazil

1 weber.nessa@gmail.com, 2kleinnerfarias@unisinos.br,
3lucianjosegoncales@gmail.com, 4viniciusbischoff@gmail.com

                                 ABSTRACT                                 However, at some point they need to consider both
       Inconsistencies in conflicting multi-view UML models can be        aspects to fully understand design decisions for creating
       major obstacles to the quality and productivity of software        an overview of the overall architecture. To do this,
       development. In the current literature it can be observed that     developers must obtain information from UML class
       some tools were developed to support the detection of              and sequence diagrams. Unfortunately, the diagrams end
       inconsistencies, but none of them are still consolidated. In
       addition, many of these tools only evaluate syntactic
                                                                          up suffering from conflict problems due to contradicting
       inconsistencies, not considering semantic ones. The tools          modifications realized in parallel in overlapping model
       available are often unable to detect syntactic and semantic        elements. This means that modifications made in the
       inconsistencies in conflicting multi-view UML models. To           UML class diagram can generate a mismatch with
       address this issue, we propose DIUML, a tool that includes: (i)    model elements in the UML sequence diagram.
       detection of inconsistencies in multi-view UML models              Therefore, developers have to lead with design models
       through design metrics; (ii) detection of syntactic and semantic   with inconsistencies. Empirical studies (e.g., [3, 9])
       inconsistencies, indicating objects and classes affected by        report that inconsistencies in multi-view UML design
       them; and (iii) evaluation of the severities of each type of       models can harm the correct understanding of design
       inconsistency detected. Our preliminary evaluation indicated
       that DIUML was able to detect inconsistencies in multi-view
                                                                          decision, leading to misinterpretation of them. In [1], the
       UML models with 337 elements from 10 different                     authors report that the lower quality of UML models is
       combinations of UML class and sequence diagrams.                   correlated with lower quality of the source code.
                                                                          To overcome these issues, this paper presents the
       Keywords: Inconsistencies Detection, Multi-view UML                DIUML, a tool that detects inconsistencies in multi-view
       Models, Tool.                                                      UML models. Developers and system analysts can
                                                                          benefit from using DIUML when performing software
                                                                          maintenance tasks for implementing change requests, or
       1. INTRODUCTION                                                    even developing new features. Detecting inconsistencies
                                                                          in multi-view UML models, developers will be able to
       Unified Modeling Language (UML) is the de facto                    seek solutions to the inconsistency problem, rather than
       standard for object-oriented software modeling [3, 4, 12]          taking into account improper representations of design
       and has been widely used to represent design projects              decisions, which can lead to misinterpretations.
       through a multi-view approach. According to [12], the              To detect inconsistencies in conflicting multi-view UML
       UML seeks to advance the state of the industry by                  models, the novelty of DIUML is the detection of
       allowing the interoperability of the visual object-                inconsistencies in multi-view UML models through
       oriented modeling tool. To do this, the UML                        design metrics [18, 19], the detection of syntactic and
       specification provides a set of human-readable notation            semantic inconsistencies, indicating objects and classes
       elements, as well as rules for combining them into                 affected by them, and the evaluation of the severities of
       various types of diagrams, considering structural and              each type of inconsistency detected. The DIUML is
       behavioral aspects of the software system under                    implemented in C # through Visual Studio and runs as
       development.                                                       an executable. Preliminary results of the use of DIUML
       In collaborative software development, for example,                indicated that it was able to detect inconsistencies in
       virtual teams can simultaneously work on partial views             UML models with 337 elements of 10 different UML
       of a general architecture by editing structural aspects,           class and sequence Diagrams. These results indicate that
       e.g., manipulating UML class diagrams [15, 16, 17],                our tool can improve the quality and productivity of
       while team members can edit behavioral aspects, e.g.,              software      development       by      mitigating      the
       modifying UML sequence.                                            misinterpretation problem of design decisions caused by
                                                                          undetected inconsistencies.

International Journal of Computer Science and Software Engineering
(IJCSSE), Volume 5, Issue 12, December 2016 261 V. Weber et. al

The remainder of the paper is organized as follows. diagram, it can be
said that there is an inconsistency Section 2 outlines the main concepts
that are going to be of this type. used and discussed throughout the
paper. Section 3 • Object not instantiated in CD (CnCD): when for
briefly compares this work with others, presenting some an object
instantiated in the sequence diagram there is differences and
commonalities. Section 4 presents the no corresponding class in the UML
class diagram, it proposed DIUML tool. Section 5 discusses the design
results in this type of inconsistency. and implementation details.
Section 6 presents a scenario of use of the proposed tool. Section 7
presents • Message in the wrong direction (ED): this type of some
concluding remarks and future work. inconsistency occurs when an object
in an UML sequence diagram calls a method of a wrong object. This is a
case where the message name does not 2. BACKGROUND match its method.

We have identified two broad categories of inconsistencies, such as: (1)
syntactical inconsistencies 3. RELATED WORKS that arise when project
models are not in accordance with the metamodel language; and (2)
semantic Researchers and practitioners have widely recognized
inconsistencies where the meaning of the model element that metrics can
be used as indicator to identify does not correspond to the actual
design model. Current inconsistencies and measure the degree of
literature has identified a number of inconsistencies incompleteness of
UML models \[8\]. Thus, design (e.g., \[8, 9\]), which have also been
used in previous metrics can help to measure design models by empirical
studies reported in \[9\]: quantifying key features, mainly ones
previously defined in UML metamodel. However, design metrics • Abstract
classes in the sequence diagram have not been used for supporting the
detection of (CaSD): the UML metamodeling \[12\] makes it clear
inconsistencies of UML models. Instead, authors have that abstract
classes should not be represented in the focused on using syntactic
\[13\], and semantic \[5\] facets sequence diagram, since single
instances of concrete to verify inconsistencies on design models only.
classes are represented in the following diagram Moreover, there is a
lack of automated methods for carefully to represent the method call
exchanged checking the inconsistencies of multi-view UML between them.
This is due to abstract classes cannot models, before developers use
them in production be instantiated, so objects derived from abstract
environment. In \[11\] authors propose a tool that takes classes can not
be produced \[8\]. into account multi-view models for verifying
inconsistencies. But, in practice, the current literature is • Unnamed
message (EnN): each message sequence still limited to techniques that
check inconsistencies in diagram must have a specific name; otherwise,
it is UML class diagram \[14\], or in UML sequence diagram impossible to
define which methods should be called \[10\], not both. in the class
diagram \[6, 8\]. In \[20, 21\], the authors present a literature review
about • Message without method (EcM): objects in the model comparison,
highlighting the main techniques in sequence diagram of message exchange
to execute the current literature. In \[22\], the authors come up with,
scenarios. These messages are actually calling in turn, a technique to
compare UML model aided by method, which must be defined in the class
diagram ontologies. \[6\]. To sum up, little has been done to detect the
• Multiple class definitions with the same name inconsistencies using
well-established design metrics. Therefore, to the best of our
knowledge, this work is the (Cm): When a class is instantiated more than
once first to (1) consider metrics for detecting the with the same name
in the same or different diagrams inconsistencies of UML models, and (2)
provide a tool in a single UML model. that execute the inconsistency
detection automatically. • Definitions of multiple objects with the same
name (Om): for inconsistency of this type, we can see more than one
object with the same name in the 4. DIUML TOOL same sequence diagram.
The process of detecting inconsistencies in UML models • Class not
instantiated in SD (CnSD): when there of DIUML has two premises. The
first includes the is an object instantiated in the UML sequence
detection of inconsistencies in multi-view UML models diagram for all
the classes present in the class through metrics and algorithms using
mathematical logic. The second classifies each type of inconsistencies 
International Journal of Computer Science and Software Engineering
(IJCSSE), Volume 5, Issue 12, December 2016 262 V. Weber et. al

detected based on the level of severity (i.e., low, Code. 3. Procedure
defined to detect inconsistency. medium and high), thus supporting
decision making by 1. Case Type.Inconsistency.CnSD: developers and
system analysts. Case Type.Inconsistency.EnN: Case
Type.Inconsistency.CnCD: The detection of inconsistencies in multi-view
UML {Return "High";} models uses measures of well-established design 2.
Case Type.Inconsistency.EcM: metrics. These measures are computed using
the Case Type.Inconsistency.ED: SDMetrics 1 , a software design metrics
tool for UML Case Type.Inconsistency.CaSD: Return "Medium";} models. The
measures are stored in XML files. For a 3. Case Type.Inconsistency.Cm:
syntactic and semantic validation of the combination of Case
Type.Inconsistency.Om: UML class and sequence diagrams, the DIUML tool
{Return "Low";} stores the names of the elements (class or object), the
Thus, the tool implements the reading, validation and methods and
messages, the relationships between the interpretation of the XML files
and applies the eight elements, and the classes have the property
isAbstract types of algorithms to detect inconsistencies, thus equal to
true. Code 1 shows how this procedure is generating the final result of
the detection of computed. inconsistencies and classifying the
severities, in order to Code. 1. Reading logic of XML file variables
allow the interpretation of the data. Having the severity 1. Var class =
new Class(); of the inconsistencies at hand, developers can prioritize,
2. Var object = new object(); or even overlook the inconsistency
detected. 3. Class.Name = ElementClasse.Attribute("name"). Value; 4.
Class.Abstrata = bool.Parse(elementClasse.Attribute(
"isAbstract").Value); 5. Class.Id =
ClassClasse.Attribute("xmi.id").Value; 5. DESIGN AND IMPLEMENTATION 6.
Var relationships = elementClasse.Descendants(ns + DETAILS
"ModelElement.clientDependency").FirstOrDefault(); The DIUML tool
detects the two-macro types of Figure 1 shows a representation of the
DIUML design, inconsistencies in the multi-view models, i.e., syntactic
and how its main elements are related. The tool has two and semantic
inconsistencies. For the detection of inputs, i.e., UML class and
sequence diagrams, both are syntactic inconsistencies, simple metrics
such as XML files. These XML files can be generated from counters and
paired combinations were used. For the UML modeling tools by exporting
the diagrams used in detection of semantic inconsistencies, it was
required to XML. use the values of properties, such as names, methods,
messages and IDs. Once the XML files of the class and sequence diagrams
have been read, the tool applies, in a linear fashion, each of the
validations of algorithms for the different types of inconsistencies.
Code 2 shows how this validation is performed. Code. 2. Example of
procedure to detect inconsistency. 1. Public void
InconsistencyTypeCnCD() { 2. Var inconsistent = Sequence.Classes.Where(c
=\>! Class. Classes.Any(s =\> s.Name == c.Name)); 3. Foreach (var
inconsistent in inconsistent) { If (! Inconsistent.Insistencies.Any (i
=\> i == InconsistencyType .CnCD)) { 4.
Inconsistent.Insistencies.Add(Inconsistency Type. CnCD); }}} Code 2
identifies each object in the UML sequence Fig. 1. DIUML Design. diagram
and verifies if there is a class in the corresponding UML class diagram.
If the result is The above entries are processed by DIUML's engine to
different from 1 to 1, this type of inconsistency will be detect
inconsistencies in the multi-view UML models, present. Since the types
of inconsistencies in UML class comparing the data between the class and
sequence and sequence diagrams have been detected, the DIUML diagrams
provided. The DIUM was developed with the tool presents the results,
including an analysis of the Microsoft Visual Studio platform using the
C# language. severity of each type of inconsistency. Code 3 shows It
reads the XML files and stores in memory the data how the severity of
different types of inconsistencies collected. The tool can be run in
Windows or Linux was computed. platforms. After XML files have been
read, the DIUML 1 tool analyzes each type of inconsistency (listed in
SDMetrics: http://www.sdmetrics.com/  International Journal of Computer
Science and Software Engineering (IJCSSE), Volume 5, Issue 12, December
2016 263 V. Weber et. al

Section 2). The next step is to organize the detected inconsistencies in
a grid. Code 4 presents the procedure defined to generate a grid with
the list of inconsistencies detected. Code. 4. Procedure to display the
detected inconsistency in a grid. 1. Type = diagramType ==
diagramType.Class? "Class": "Object" 2. Name = class.Name 3.
Inconsistency = inconsistencyHelper.ObterInconsistency (inconsistency?
"NameInconsistencies") 4. Severity = inconsistencyHelper.obterGravity
(inconsistency? "High": "Medium": "Low")

6.  SCENARIO OF USE To run DIUML, we need to provide the UML class and
    Fig. 3. DIUML Sequence Diagram. sequence diagrams in XML format, as
    described in section 5. Input files do not need to be in a specific
    After the tool has been started, the DIUML shows the location on the
    machine because the tool allows the screen shown in Figure 4, in
    which the user must inform search the files using the explorer
    standard. The required the two diagrams that will be evaluated.
    entries are the Class and Sequence Diagrams in XML format, which can
    be generated by the UML modeling tool itself, such as Astah Pro
    \[3\] or Enterprise Architect \[11\]. The tool does not need to be
    installed on the user's computer and does not require any database
    configuration, since it is an executable file. This makes it easy to
    use on different computers and environments, such as Windows and
    Linux operating systems. The DIUML does not require any settings or
    parameter changes. The user just locates and run the executable
    file, namely DIUML.exe. Fig. 4. DIUML Files Selector. To illustrate
    the use of the tool, the XML files of the Class and Sequence
    Diagrams presented in Figure 2 and When the user selects the
    "Importar" option, the tool Figure 3 will be read and analyzed:
    automatically reads the XML files and stores in the local memory.
    Once the reading and detection of the inconsistencies is done, the
    tool presents the screen shown in Figure 5, i.e., a grid with the
    elements in which inconsistencies were found and which
    inconsistencies were detected, as well as the severity of each type
    of inconsistency.

                                                                                            Fig. 5. DIUML Output.
                   Fig. 2. DIUML Class Diagram.

     International Journal of Computer Science and Software Engineering
    (IJCSSE), Volume 5, Issue 12, December 2016 264 V. Weber et. al

7.  CONCLUSIONS AND FUTURE WORK \[11\] R. E. Lopez-Herrejon, A. Egyed,
    "Detecting inconsistencies in multi-view models with variability."
    This article presented the DIUML, a tool to detect In: Kühne, T.,
    Selic, B., Gervais, M.-P., Terrier, F. (Eds.), European Conference
    on Modelling inconsistencies in multi-view UML models. Our initial
    Foundations and Applications. 2010. Paris, France, pp. results
    indicated that DIUML was able to properly 217-232. detect the
    inconsistencies explained in Section 2, \[12\] OMG, 2015. UML:
    Infrastructure specification, providing concrete evidence of tool
    usefulness. As a version 2.5. URL future work, we seek to adjust the
    tool so that the code http://www.omg.org/spec/UML/2.5/PDF of
    detection of inconsistencies can become incremental \[13\] A.
    Reder, A. Egyed, "Computing repair trees for and allow the
    configuration of new types of resolving inconsistencies in design
    models." In: inconsistencies. Proceedings of the 27th IEEE/ACM
    International Conference on Automated Software Engineering.
    ASE 2012. ACM, New York, NY, USA, pp. 220-229. \[14\] S. S.
    Satish, S. R. Shashikant, V. K. Sambhe, R. B.

8.  ACKNOWLEDGMENTS Shelke, G. Kocharekar, "A minimum cardinality
    consistency-checking algorithm for UML class This work was funded by
    CNPq Universal Project diagrams." In: International Conference and
    Workshop 14/2013 (grant number 480468/2013-3), Brazil. on Emerging
    Trends in Technology. ICWET '10. 2010 pp. 222-223. \[15\] K.
    Farias, A. Garcia, J. Whittle, C. Lucena, "Analyzing REFERENCES the
    Effort of Composing Design Models of Large-Scale Software in
    Industrial Case Studies". 16th International \[1\] A. Nugroho, B.
    Flaton, M. Chaudron, "Empirical Conference on Model-Driven
    Engineering Languages analysis of the relation between level of
    detail in UML and Systems (MODELS'13), pp. 639-655, Miami, models
    and defect density". In: 11th international USA, September 2013.
    conference on Model Driven Engineering Languages \[16\] E.
    Guimarães, A. Garcia, K. Farias, "On the Impact of and Systems.
    Springer, 2008, pp. 600-614. Obliviousness and Quantification on
    Model \[2\] Astah Pro. Available on \<http://www.astah.net/edition
    Composition Effort". 29th Symposium On Applied s/professional\>.
    Computing (SAC.14), Gyeongju, Korea, March, 2014. \[3\] M.
    Chaudron, W. Heijstek, A. Nugroho, "How \[17\] K. Farias, A.
    Garcia, J. Whittle, C. Chavez, C. Lucena, effective is UML
    modeling?". Software and Systems "Evaluating the Effort of Composing
    Design Models: Modeling 2012, Vol. 11, n. 4, pp. 571-580. A
    Controlled Experiment". 15th International \[4\] W. J. Dzidek, E.
    Arisholm, L. C. Briand, 2008. "A Conference on Model-Driven
    Engineering Languages realistic empirical evaluation of the costs
    and benefits and Systems (MODELS'12), Vol. 7590, pages 676- of UML
    in software maintenance". IEEE Transactions 691, Innsbruck,
    Austria, 2012. on Software Engineering, 2008, vol. 34, n. 3,
    pp. 407- \[18\] K. Farias, A. Garcia, J. Whittle, "On the
    Quantitative 432. Assessment of Class Model Compositions: An
    \[5\] A. Egyed, "Automatically detecting and tracking Exploratory
    Study". In: Empirical Studies of Model- inconsistencies in software
    design models". IEEE Driven Engineering (ESMDE'08) co-located
    Transactions on Software Engineering. 2011. Vol. 37 MODELS'08, Vol.
    1, pp. 1-10, Toulouse, France, n. 2, pp. 188-204. 2008. \[6\] K.
    Farias, A. Garcia, J. Whittle, C. Chavez, C. Lucena, \[19\] K.
    Farias, A. Garcia, C. Lucena, "Effects of Stability "Evaluating the
    effort of composing design models: a on Model Composition Effort: an
    Exploratory Study". controlled experiment". Software & Systems
    Journal on Software and Systems Modeling, Vol. 13, Modeling, 2015,
    vol. 14, n. 4, pp. 1349-1365. No. 4, pages 1473--1494, 2014. \[7\]
    Enterprise Architect. \<http://www.sparxsystems.com/ \[20\] L.
    Gonçales, K. Farias, M. Scholl, T. C. Oliveira, M. products/ea/\>
    Veronez, "Model Comparison: a Systematic Mapping \[8\] C. Lange,
    "Assessing and improving the quality of Study". 27th International
    Conference on Software modeling a series of empirical studies about
    the UML" Engineering and Knowledge Engineering, pages 546-
    Ph.D. thesis, Technische Universiteit Eindhoven, 551, Pittsburgh,
    PA, USA, July, 2015. Eindhoven. 2007. \[21\] L. Gonçales, K.
    Farias, M. Scholl, M. Veronez, T. C. \[9\] C. Lange, M. Chaudron,
    "Effects of defects in UML Oliveira, "Comparison of Design Models: A
    models: an experimental investigation." In: 28th Systematic Mapping
    Study". International Journal of international Conference on
    Software Engineering. Software Engineering and Knowledge
    Engineering, 2006. Shanghai, China, pp. 401-411. Vol. 25, pages
    1765-1770, 2015. \[10\] X. Li, J. Lilius, T. Centre, C. Science,
    "Checking \[22\] K. Oliveira, K. Breitman, T. Oliveira, "Ontology
    Aided compositions of UML sequence diagrams for timing Model
    Comparison". 14th IEEE International inconsistency". In: 7th
    Asia-Pacific Software Conference on Engineering of Complex Computer
    Engineering Conference (APSEC). 2000. pp. 154-161. Systems
    (ICECCS'09), pp. 78-83, Potsdam, Germany, 2009. 
