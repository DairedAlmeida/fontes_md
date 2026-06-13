A Tool for Supporting Round-Trip Engineering with the Ability to Avoid
Unintended Design Changes

           Takahiro Yamazaki1 , Takafumi Tanaka2 , Atsuo Hazeyama3                                                a
                                                                                                                      and Hiroaki Hashiura4   b
                                        1 Graduate School of Engineering, Nippon Institute of Technology,

                                           4-1 Gakuendai, Miyashiro, Minami-Saitama, Saitama, Japan
                          2 College of Engineering, Tamagawa University, 6-1-1 Tamagawagakuen, Tokyo, Japan
              3 Dept. of Information Science, Tokyo Gakugei University, 4-1-1 Nukuikitamachi, Koganei, Tokyo, Japan
                                        4 Faculty of Advanced Engineering, Nippon Institute of Technology,

                                           4-1 Gakuendai, Miyashiro, Minami-Saitama, Saitama, Japan

Keywords: UML, Traceability, Round-Trip Engineering, Object-Oriented
Design.

Abstract: It is difficult to maintain consistency between artifacts in a
round-trip engineering project, such as an agile development method. In
such software development projects, there is a method using traceability
links as a method for maintaining consistency between artifacts. A
method for creating traceability links from design artifacts to programs
has been proposed in the past. However, few studies have proposed
traceability links from source code to UML artifacts. Round-trip
engineering could involve the developer making changes to the source
code and applying those changes to the UML artifacts. The larger the
system, the more difficult it becomes to apply changes to the UML
artifact. We believe that traceability from the program to UML artifacts
effectively addresses this problem. In this paper, we propose a
traceability link method for programs to design artifacts, develop a
tool for supporting the method, evaluate its effectiveness, and identify
the difficulties for developers in manually modifying class diagrams.

1 INTRODUCTION 1. As the size of the design document increases, it
becomes more difficult for the developer to main- In recent years, agile
development methods, e.g. tain consistency and integrity. Scrum
(Schwaber, 1995) are widely used to produce 2. The records and contents
of modifications are software products in a short period. These methods
stored only by the person in charge of the modifi- are expected to be
utilized to reduce discrepancies in cation, and other members can not
grasp the con- perceptions with clients regarding artifacts. To use
tents, which makes development and maintenance these techniques, it is
necessary to develop the soft- difficult. ware by repeatedly going
between design and coding (round-trip engineering) (Sendall and Küster,
2004). 3. Since people's memories typically fade over time, For example,
suppose that a developer creates a pro- the situation may arise where it
is unclear where totype of a program based on a design document and the
changes should be applied (Rempel and presents it to a customer. The
customer requests im- Mader, 2017). provements, which the developers
then reflect on the This study aims to solve the three aforementioned
design documents and programs. The project pro- problems by focusing on
round-trip engineering in the gresses through a series of iterations. On
the other two processes of design and programming in the de- hand, the
repetitive back-and-forth between design velopment process.
Specifically, the tool extracts dif- and coding, as described above, may
lead to consis- ferences between design artifacts and elements in the
tency loss and integrity among artifacts. If this situa- source code,
and it highlights them on the design arti- tion is left unchecked, the
following additional prob- facts to encourage modification of the
artifacts. In ad- lems may arise. dition, the modification rates of
fully automated tools and semi-automated methods are compared when per-
a https://orcid.org/0000-0001-6583-1521 forming the task of reflecting
changes in the source b https://orcid.org/0000-0002-6325-4177 code to
the class diagram to meet certain require-

                                                                                                                                                  125

Yamazaki, T., Tanaka, T., Hazeyama, A. and Hashiura, H. A Tool for
Supporting Round-Trip Engineering with the Ability to Avoid Unintended
Design Changes. DOI: 10.5220/0011667500003402 In Proceedings of the 11th
International Conference on Model-Based Software and Systems Engineering
(MODELSWARD 2023), pages 125-132 ISBN: 978-989-758-633-0; ISSN:
2184-4348 Copyright c 2023 by SCITEPRESS -- Science and Technology
Publications, Lda. Under CC license (CC BY-NC-ND 4.0) MODELSWARD 2023 -
11th International Conference on Model-Based Software and Systems
Engineering

ments. We will identify whether there is a difference lected at runtime
to the design. In contrast, this study in the acceptance of
modifications to class diagrams aims to meet requirements by preventing
inconsisten- when the modification process requires changes to be cies
between artifacts and avoiding unintended design made to the class
diagram for implementation reasons changes. or other reasons, or when
programmers make changes In addition, Arima et al.(Arima et al., 2021)
to the code without consulting development members. stated that human
maintenance of artifacts is time- consuming, labor-intensive, and
correction omissions occur. To solve these problems, they proposed RE- 2
RELATED WORK TUSS, which maintains traceability between UML di- agrams
and source code in realtime. They focused on This section mainly
introduces research on traceabil- the time difference in maintaining
traceability when ity. Yoshida et al.(Yoshida et al., 2020) focused on
the using RETUSS and when using only Enterprise Ar- process of
implementation source codes from a de- chitect(EA) (Sparx Systems Pty
Ltd., 2022) and a text editor. Their studies have evaluated the degree
to sign artifacts created by a non-native English speaker. which
traceability can be ensured, but have not con- They used Java
Annotations (Oracle America, Inc., ducted a quantitative evaluation by
comparing it with 2021) to create traceability links for the different
el- manual work, as will be done here. ement names in the UML diagram
and source code. Aung et al.(Aung et al., 2020) conducted a sys-
However, they only created traceability links from de- tematic
literature review related to automatic trace- sign artifacts to
programs. Their tool can not be used ability link recovery approaches
with a focus on for round-trip engineering because it can not create
Change Impact analysis(CIA). Their review indicated traceability links
from programs to design artifacts. Yu et al.(Yu et al., 2021) focused on
Informa- that few traceability studies focused on designing and tion
Retrieval(IR)-based traceability assurance be- testing impact analysis
sets, they stated that this is tween design artifacts and source code.
They stated presumably due to the small data set. We believe that
vocabulary mismatch between natural and pro- one of the reasons for the
paucity of studies covering gramming languages affects the accuracy of
traceabil- design artifacts is that modern software development ity.
They proposed a method that combines IR tech- projects based on agile
methodologies omit compre- niques with common database statements
between the hensive documentation traceability to design artifacts, two
artifacts. Their method has been shown to have which has not been
discussed recently, is important as higher Precision and F-Measure
values than Vector agile development becomes more popular. Space
Model(VSM), one of the IR techniques, in Rosca and Domingues (Rosca and
Domingues, traceability assurance experiments. 2021) compared the
performance of round-trip engi- Jongeling et al.(Jongeling et al., 2021)
proposed neering in three modeling tools. The three tools being
model-source code synchronization in model-based compared are Papyrus,
Modelio and Visual Paradigm. development round-trips. The tool
identifies where The three tools showed a success rate of more than the
source code has been modified and then outputs 80% in direct measurement
metrics such as the num- the differences between the model and the
source ber of methods used. They states that qualitative as- code to XML
to show the developer where the sessments are needed to complement
quantitative as- changes have been made. In contrast to their study,
sessments. It is important that developers are able to our study has
advantages. That study shows the dif- use round-trip engineering tools
and still make the in- ferences directly in the modeling tool, which
reduces tended changes. the time and effort required to compare the
model to the source code. Ciccozzi and Sjodin (Ciccozzi et al., 2011)
state 3 PROPOSED METHOD the following in MDE in embedded systems. They
state that data outside of system functionality (e.g., This study
proposes a method for creating traceability memory usage) is difficult
to predict and that the links from programs to design artifacts. The
method results obtained by execution should be reflected in deals with
the class diagram as a design artifact, and the design artifact. To
address this problem, they the source code written in Java. proposed the
Back-Annotation model for propagat- 1. The tool extracts differences
between source code ing non-system function data to design artifacts.
The and class diagram. difference with this study is the purpose of
propaga- tion. The Back-Annotation model was intended to 2. The tool
suggests to developers how to fix the dif- satisfy requirements by
feeding back information col- ferences.

126  A Tool for Supporting Round-Trip Engineering with the Ability to
Avoid Unintended Design Changes

3.  The developer selects the appropriate modifica- tion from the
    suggested ones and modifies the class diagram. The authors believe
    that in the round-trip engi- neering addressed in this study,
    developers will en- counter the problem of inconsistency between
    class diagrams and source code. Two issues are discussed Figure 1:
    An example of displaying candidates for correc- tion on a class
    diagram. here as examples: first, developers miss inconsisten- cies
    between artifacts due to visual checks; second, minor specification
    changes during round-trip engi- neering. The former is the problem
    of developers being un- able to maintain detailed consistency
    between class diagrams and source code once the scale of develop-
    ment exceeds a certain level. Such a problem occurs, for example,
    when a developer mistakes the "e" as "a" in the "Scanner" class.
    Although "Scannar" is not a correct English word, it is easy to
    overlook such mis- takes since consistent use of such a name in a
    program will not cause program execution problems. The lat- ter
    problem occurs when a developer finds a design error during
    programming and corrects it. To give a concrete example, a class
    "Input" that specializes in input is created in the design stage,
    and then in the programming stage, it is realized that it is better
    to create this class as an input/output class, so the pro- gram
    specification is changed and the class name in the program is also
    changed to "InOut" to match the actual situation. In such cases, a
    high-level decision is required as to whether the design should be
    changed in the priority of the program or whether the design should
    be modified to maintain the original program Figure 2: An example of
    consistency issues between a class structure. diagram and source
    code. Based on these two points, the proposed method uses a
    semi-automatic modification approach to main- A) Redundant: Elements
    exist in the class diagram tain consistency and integrity between
    the class dia- but not in a source code (e.g. the red box in Fig-
    gram and the source code, in which a tool presents a ure 2). list of
    proposed modifications, and the developer se- B) Missing: Elements
    exist in the source code but not lects one of them. This also allows
    the developer to in a class diagram (e.g. the blue box in Figure 2).
    use a modification other than the suggested candidate C)
    Conflicting: Elements having the same name but (e.g., to change both
    the design and the program). Ex- with conflicting qualifiers or
    types (e.g. the green isting modeling tools often cannot integrate
    with other box in Figure 2). tools or provide feedback to developers
    on problems (Agner and Lethbridge, 2017) Therefore, we decided to
    implement such a function in our modeling tool. 3.2 How to Indicate
    Differences Figure 1 shows an image of the presentation of candi-
    Between a Class Diagram and date modifications to a class diagram.
    Source Code 3.1 Differences in Type Definitions This section
    describes how to indicate the differences described in the previous
    section. In this method, dif- The consistency issues a between class
    diagram and ferences are indicated to the developer in red letters
    source code, which are treated in this study, are di- on the class
    diagram. Missing differences that can not vided into the following
    three categories according to be shown on the class diagram are
    indicated in the di- the state in which there is a difference
    between them. alog. An example of a presentation to users is shown

                                                                                                                            127

    MODELSWARD 2023 - 11th International Conference on Model-Based
    Software and Systems Engineering

in Figure 2. The differences offered by the proposed tool are defined as
follows: I Stereotype: Interface, Abstract II Class Name III Field:
Modifier, Element Name, Type IV Method: Modifier, Element Name, Return
Value Type V Parameter: Parameter Name, Type Figure 3: An overview of
the tool implementation. 3.3 Storing Correction History As exemplified
in Section 3, modifications to artifacts require a high degree of
judgment, so discussions are held among developers. After discussions
among the developers, either the "Conversion button" or the "Close
button" in the dialog shown in Figure 2 can be selected. When the
conversion button is selected, the process of saving the dialog state is
executed. The reason for storing the dialog content is that by storing
the correction history, it is possible to reuse the crite- ria for
making changes when similar problems occur among developers. Correction
histories to be stored are as follows: 1. What types of correction
method the user has cho- Figure 4: A meta-model used by the proposed
tool. sen (check box status). 3) When KIfU receives the notification in
2), it de- 2. A detailed description of the difference. As an tects the
difference between the source code stored example, the text of the
dialog shown in Figure 2 in the database in 1) and the class diagram
being is saved. edited in KIfU. Elements of the source code and 3.
Timestamps of when the dialog was opened and class diagram are stored as
strings in the follow- closed. ing form. 'ClassNamne!FieldName or
Method- If the Close button is selected, the tool closes the dia-
Name}Type or modifier.' The detection work uses log without saving the
information. Java's String.equals to exhaustive search. 4) KIfU displays
the differences detected in 3) on the class diagram (Figure 2). 4 TOOL
IMPLEMENTATION 5) KIfU presents a list of modifications (Figure 1) to
the developer based on the differences. The devel- The proposed method
uses Eclipse for writing source oper can automatically modify the class
diagram code and KIfU(Tanaka et al., 2018) for UML model- by selecting
the appropriate checkboxes. ing tool. The tool supporting this method
consists of a The list of modifications presented by the tool is plug-in
part of Eclipse and an extension part of KIfU. generated based on the
element names and according Figure 3 and Figure 4 show an overview of
the tool to the following rules for each type of difference be- and a
meta-model used by the tool, respectively. tween artifacts described in
section 3.1. The specific processing steps of the tool are de- scribed
below: a) Redundant: Deleting redundant elements from the class
diagram. 1) When the Eclipse plug-in detects that a change has been made
to the source code, using parser, b) Missing: Adding missing elements to
the class di- elements are extracted from the source code and agram.
stored in a database. c) Conflicting: Modifiers and types are changed to
2) The Eclipse plug-in notifies KIfU using match the corresponding
source code. JeroMQ(Trevorbernard, 2021) when 1) is completed.

128  A Tool for Supporting Round-Trip Engineering with the Ability to
Avoid Unintended Design Changes

5 EXPERIMENT Table 1: Number of scales for each problem. Problem1
Problem2 \# Classification Evaluation experiments were conducted to
determine (Calculator) (Task Management) if the method can prevent
unintended changes. In 1 of Classes 12 12 2 of Fields 17 27 the
experiment, the correction rate (the rate at which 3 of Methods 40 34
inserted defects were corrected in accordance with 4 of Parameters 26 54
the prepared requirements) of inconsistency between class diagram and
source code were investigated for Table 2: Number of defects in each
defect type. two correction tasks: Comparison Experiment 1. Par-
Problem1 and 2 \# Classification ticipants manually fix problems both
with and with- Match to Match to out implementation convenience.
Comparison Exper- Class Diagram Source Code iment 2. Comparison of
correction rates the between 1 Missing 6 2 automatic correction tool and
the manual method. 2 Redundant 6 2 3 Conflicting 6 2 Participants are
fourth-year undergraduate students 4 Total Defects 18 6 from Nippon
Institute of Technology who enrolled 5 of Class 1 0 in the department of
Information Systems and Me- 6 of Field 7 2 dia Design, and five graduate
school students from the 7 of Method 7 2 Graduate School of Engineering,
Nippon Institute of 8 of Parameter 3 2 9 Total Elements 18 6 Technology.
All participants have basic UML knowl- edge and Java programming
experience at an under- Comparison Experiment 2 compares the modifi-
graduate level. cation rate when the automatic modification tool re- The
procedure of the experiment is described be- verse engineers the code
and reflects the changes in low. First of all, participants are given an
assignment the class diagram with the results of Comparison Ex- that
consists of a class diagram and Java source code. periment 1. Comparison
Experiment 2 uses the same Certain defects are inserted into the
assignment be- problem as Comparison Experiment 1. IBM Rhap- forehand to
cause limitation between the source code sody (IBM Corporation, 2020)
was used as the auto- and the class diagram. In addition, we adjusted
the matic correction tool. number of elements in the assignment and the
num- ber of inserted defects to equalize the complexity and difficulty
level. These are shown in Tables 1 and Ta- bles 2, respectively. In this
experiment, the number 6 RESULTS AND DISCUSSION of defects for which
source code changes must be Two Research Questions(RQs) were established
to accepted is six or less. This is because we believed evaluate the
experiment. that in actual development, design artifacts should be
sufficiently discussed to meet the requirements that RQ-1. What
differences appear in the manual when there would be only a few
situations in which changes given situations are different? would be
accepted. RQ-2. What are the characteristics of an automated The
procedure for Comparison Experiment 1 is as correction tool versus a
manual correction follows. First, participants are given an assignment
process? consisting of a class diagram, Java source code and a
requirement document for each problem. This is Refernece Table 3 to
answer the RQ. Accuracy is the the common part of problems 1 and 2. The
differ- percentage of correct decisions to accept or reject. ence
between problems 1 and 2 is that in problem 1, Precision is the
percentage of defects that actually the reason for the changes made to
the code is given; needed to be accepted out of those judged to be ac-
in problem 2, the reason for the changes made to the ceptable. Recall is
the percentage of defects that need code is not given. Problem 1 is a
situation where to be accepted and that are accepted. The results of the
programmer has a reason for wanting to make aggregating these values are
shown in Tables 4, 5 changes to the artifacts for programming reasons
and and 6 respectively. The results of the calculations are discusses
whether the changes meet the requirements. shown in Table 7 and Table 8.
Problem 2 posits a situation in which a programmer Table 3: Mixture
matrix in manual work. makes changes without consulting the members of
the Participants team, therefore without their permission/agreement. IBM
Rhapsody We also asked the participants to describe on the tool Accept
Reject any reasons for acceptance/rejection. Inserted Defect TP FN
Actually No Defect FP TN

                                                                                                                                    129

MODELSWARD 2023 - 11th International Conference on Model-Based Software
and Systems Engineering

       Table 4: Result with implementation limitation.               The results for Missing items have the smallest
             #   Data item     TP   FP FN TN                    differences for any of the items. This is because it is
             1    Missing      17   30   1     24               normal to assume that if careful discussions are made
             2   Redundant     16   18   2     27               during design, there will be nothing missing in that
             3   Conflicting   13   21   5     33               design artifact, and the designer’s desire is to have the
             4     Class         flaw question                  product made as designed, even if the implementer’s
             5     Field       17 29     1     34               convenience in involved. As an example, suppose
             6    Method       12 15     6     39
             7   Parameter     36 15     2     12               there is a class that sorts a list, and the implemen-
                                                                tor wants to add an instance field, tmp, for sorting.
      Table 5: Result without implementation limitation.        However, the designer’s thinking assumes that it is not
            #    Data item     TP   FP   FN   TN                necessary to add extra variables by using the standard
            1     Missing      14   31    4   23                library’s sort(), etc., rather than creating a sorting al-
            2    Redundant      9   20    9   34                gorithm on his own, which would easily lead to a re-
            3    Conflicting    8   30   10   24                jection decision that does not add any new elements.
            4      Class        0    5    0    4                Therefore, it can be said that implementation conve-
            5      Field       10   34    8   29                nience has no effect on missing elements. In con-
            6     Method       12   31    6   32
            7    Parameter     10   12    8   15
                                                                trast, the results for redundant items have large differ-
                                                                ences in all items. The participant confirmed imple-
    First, we answer about RQ1 using Table 7 of the             mentation limitation such as ”not used during the im-

results of Comparison Experiment 1. Regarding the plementation phase"
and determined that it would be Precision rate, the value for both the
elemental species more effective to remove variables and functions that
and the defective species was about 10% higher for were not used during
development in order to facili- the one with implementation limitation.
It is interest- tate understanding of the overall system during sub- ing
to note that the highest value is 50% and about sequent maintenance
work. In this experiment, par- half of the corrective work is erroneous
corrections, ticipants were given implementation convenience as a even
if there is an implementation limitation. This material for comparison,
but the results may change shows that implementation convenience can
have a if participants are given other materials (such as ac- bad effect
on designers, causing them to make poor tually having them discuss with
someone). It must decisions. Regarding the Recall rate, the correction
also be discussed whether the implementation conve- rate was about 25%
higher for those with clues. The nience given was appropriate. Recall
results show that there is a significant differ- Next, we answer the
question about RQ2 using the ence in the impact of implementation
limitation on results of Comparison Experiment 2. Comparative re- the
redundant or conflicting, parameters and fields. sults are shown in
Table 8. One of the characteristics As for the Recall, it must be taken
into account that of the fully automated system is that it has a 100%
the difference in values can be drastic because of the recall rate,
which means that nothing can be missed. small number that must be
accepted. Finally, for the In contrast, the precision rate is low at
30%. This is F-values, the sum of the defective species and the el- due
to the fact that changes were made to unnecessary emental species
differed by about 15% each. The ac- parts of the class diagram. When
looking at F-Values, curacy is higher when there in implementation
limita- manual work is about more than 50% more accurate, tion left by
the programmer, with a difference of 20% while automatic correction
tools are about more than with respect to conflicting items, redundant
items, and 40% accurate. Thus, it can be said that manual work fields
items. In contrast, those that do not have a is better at making the
intended corrections. How- strong effect of opinion on implementation
are Miss- ever, the result is that the fewer changes that must be ing
items, at 8%. applied to the class diagram relative to the number of
elements that have been modified, the more likely Table 6: Results of
IBM Rhapsody(IBM Corporation, it is that the automatic modification tool
will make 2020). changes to the class diagram that the developer did \#
Data item TP FP FN TN not intend. 1 Missing 4 12 0 0 IBM Rhapsody has
the function to perform round- 2 Redundant 4 10 0 0 trip. We believe
there are two caveats to the de- 3 Conflicting 4 12 0 0 veloper's use of
modeling tools to conduct round- 4 Class 0 1 0 0 trip. The first caveat
is the way the tool shows the 5 Field 4 14 0 0 6 Method 4 13 0 0
elements. When using List as a field in the IBM 7 Parameter 4 6 0 0
Rhapsody used in the experiment, the List field is

130  A Tool for Supporting Round-Trip Engineering with the Ability to
Avoid Unintended Design Changes

                               Table 7: Result of with implementation limitation and without.
                                        Accuracy            Precision            Recall           F-value
                                     With   Without      With    Without     With   Without    With   Without
                     Missing        56.9%    51.4%      36.2%     31.1%     94.4%    77.8%    52.3%    44.4%
                    Redundant       68.3%    59.7%      47.1%     31.0%     88.9%    50.0%    61.5%    38.3%
                    Conflicting     63.9%    44.4%      38.2%     21.1%     72.2%    44.4%    50.0%    28.6%
                   Total Defects    61.8%    51.9%      38.7%     27.7%     85.2%    57.4%    53.2%    37.3%
                      of Field      63.0%    48.1%      37.0%     22.7%     94.4%    55.6%    53.1%    32.3%
                    of Method       63.0%    54.3%      33.3%     27.9%     66.7%    66.7%    44.4%    39.3%
                   of Parameter     62.2%    55.6%      51.6%     45.5%     88.9%    55.6%    65.3%    50.0%
                  Total Elements    62.8%    51.9%      39.8%     28.1%     83.3%    59.3%    53.9%    38.1%

                          Table 8: Result of with implementation limitation and IBM Rhapsody.
                              Accuracy                  Precision                   Recall                  F-value
                       With    IBM Rhapsody      With    IBM Rhapsody        With   IBM Rhapsody     With    IBM Rhapsody
        Missing       56.9%        25.0%        36.2%         25.0%         94.4%      100.0%       52.3%        40.0%
       Redundant      68.3%        28.6%        47.1%         28.6%         88.9%      100.0%       61.5%        44.4%
       Conflicting    63.9%        25.0%        38.2%         25.0%         72.2%      100.0%       50.0%        40.0%
      Total Defects   61.8%        26.1%        38.7%         26.1%         85.2%      100.0%       53.2%        41.4%
         of Field     63.0%        22.2%        37.0%         22.2%         94.4%      100.0%       53.1%        36.4%
       of Method      63.0%        23.5%        33.3%         23.5%         66.7%      100.0%       44.4%        38.1%
      of Parameter    62.2%        40.0%        51.6%         40.0%         88.9%      100.0%       65.3%        57.1%
     Total Elements   62.8%        26.1%        39.8%         26.1%         83.3%      100.0%       53.9%        41.4%

not drawn in the class diagram. When List is used ful in determining
acceptance or non-acceptance. as a field in the IBM Rhapsody used in
this experi- Safwan and Servant (Safwan and Servant, 2019) ment, the
information is expressed as a relation to the subdivides the rationale
for a developer's code package in which the List is stored, rather than
be- commits into 15 pieces. Of the 15 elements, the ing drawn as a List
field in the class diagram. The tool can already propose Location and
Modifica- developer must search through a number of associa- tion in
this method. We believe that other items tions to ensure that the List
field is consistent between should also be communicated to the designer
to the code and the class diagram. IBM Rhapsody has a improve the
acceptance decision function to record the history of round trips in
text 2. Only project scale and simple defects can be ad- form, allowing
developers to check where changes dressed: In this method, all elements
in the class have been made. But it is not possible to visualize the
diagram and source code are searched in order to differences on the
model in this method. The second detect differences. If the tool targets
thousands caveat is when multiple developers make changes to or tens of
thousands of artifacts, it is expected to the same artifact. If two
developers make changes to take an enormous amount of time to detect
dif- the same source code, the modeling tool will reflect ferences. A
method is needed to identify the dif- the second developer's changes in
the model. Both ference locations, as in Jongeling et al.(Jongeling
changes made by the first person and the second per- et al., 2021). This
method can only handle simple son have implementation ramifications, and
the tool differences such as the element type of a class. should decide
what to reflect in the model based on Class relationships such as
inheritance, multiplic- discussions among the developers, rather than
imme- ity, etc. must also be addressed. diate reflection.

                                                                    8       CONCLUSION

7 THREATS TO VALIDITY In this study, we have developed a tool that
shows 1. Description of Intended Change: Although this developers the
differences between source code and study assumes that programmers leave
written class diagram. A comparison of the correction rates reasons for
changes they want to make to the of semi-automatic and fully automatic
tools in con- source code, we received comments from exper- ducted. The
results quantitatively showed that the au- imental collaborators that
the reasons for changes tomatic correction tool does not overlook and
accepts they made to the code were difficult to understand. defects that
do not need to be accepted. In contrast, We believe this is a burdensome
task for the de- semi-automatic corrections, on the other hand, can
signer to read the text and extract information use-

                                                                                                                              131

MODELSWARD 2023 - 11th International Conference on Model-Based Software
and Systems Engineering

discover and accept changes necessitated by imple- Rempel, P. and Mader,
P. (2017). Preventing defects: The mentation reasons, but implementation
reasons can impact of requirements traceability completeness on also
work in the wrong direction. We investigated the software quality. IEEE
Transactions on Software En- difference in correction rates in
semi-automatic cor- gineering, 43(8):777--797. rection work with and
without implementation con- Rosca, D. and Domingues, L. (2021). A
systematic com- parison of roundtrip software engineering approaches
venience. A characteristic result was that the value of applied to UML
class diagram. Procedia Computer Missing made no difference in the
revision decision Science, 181:861--868. whether there was an
implementation convenience or Safwan, K. A. and Servant, F. (2019).
Decomposing the not. In the future, we will focus on saving the change
rationale of code commits: The software developer's history. Currently,
we have been able to create a func- perspective. In 2019 27th ACM Joint
Meeting on Eu- tion to save the change history on the tool. The eval-
ropean Software Engineering Conference and Sym- uation method, the
content of the stored information, posium on the Foundations of Software
Engineer- and the reuse of the reasons will be discussed. ing, ESEC/FSE
2019, page 397--408, New York, NY, USA. Association for Computing
Machinery. Schwaber, K. (1995). Scrum development process: Ad- vanced
development methods. In OOPSLA'95 Work- ACKNOWLEDGEMENTS shop on
Business Object Design and Implementation, pages 117--134. This work was
supported by JSPS KAKENHI Grant Sendall, S. and Küster, J. (2004).
Taming model round- Numbers 21K12179. trip engineering. In Proceedings
of Workshop on Best Practices for Model-Driven Software Develop- ment
(satellite event of the 19th Annual ACM Confer- ence on Object-Oriented
Programming, Systems, Lan- REFERENCES guages, and Applications (OOPSLA
2004)), Vancou- ver (Canada). Agner, L. T. W. and Lethbridge, T. C.
(2017). A survey of Sparx Systems Pty Ltd. (2022). Enterprise Architect.
https: tool use in modeling education. In 2017 ACM/IEEE
//sparxsystems.com/products/ea/. 20th International Conference on Model
Driven En- Tanaka, T., Hashiura, H., Hazeyama, A., Komiya, S., Hi-
gineering Languages and Systems (MODELS), pages rai, Y., and Kaneko, K.
(2018). Learners self checking 303--311. and its effectiveness in
conceptual data modeling ex- Arima, K., Katayama, T., Kita, Y., Yamaba,
H., Aburada, ercises. IEICE Transactions on Information and Sys- K., and
Okazaki, N. (2021). Extension of the func- tems, E101.D(7):1801--1810.
tion to ensure real-time traceability between UML se- Trevorbernard
(2021). Java-ZeroMQ. https://zeromq.org/ quence diagram and Java source
code on RETUSS. languages/java/. Advances in Artificial Life Robotics,
2:254--258. Yoshida, Y., Hashiura, H., Tanaka, T., Hazeyama, A., and
Aung, T. W. W., Huo, H., and Sui, Y. (2020). A liter- Takase, H. (2020).
A proposed method for recov- ature review of automatic traceability
links recovery ering traceability linksbetween documents and codes for
software change impact analysis. In 28th Interna- written in different
languages. In The RISP Interna- tional Conference on Program
Comprehension, ICPC tional Workshop on Nonlinear Circuits, Communica-
'20, page 14--24, New York, NY, USA. Association tions and Signal
Processing 2020 (NCSP 20), pages for Computing Machinery. 1--4.
Ciccozzi, F., Cicchetti, A., and Sjodin, M. (2011). Towards Yu, L., Li,
Y., Feng, Y., and Qi, C. (2021). Traceabil- a round-trip support for
model-driven engineering of ity method between design documents and
source embedded systems. In 2011 37th EUROMICRO Con- codes based on SQL
dependency. In 2021 20th In- ference on Software Engineering and
Advanced Ap- ternational Symposium on Distributed Computing and
plications, pages 200--208. Applications for Business Engineering and
Science IBM Corporation (2020). IBM Engineering Systems De- (DCABES),
pages 144--147. sign Rhapsody 9.0.1. https://www.ibm.com/products/
systems-design-rhapsody. Jongeling, R., Bhatambrekar, S., Lofberg, A.,
Cicchetti, A., Ciccozzi, F., and Carlson, J. (2021). Identifying man-
ual changes to generated code: Experiences from the industrial
automation domain. In 2021 ACM/IEEE 24th International Conference on
Model Driven En- gineering Languages and Systems (MODELS), pages 35--45.
Oracle America, Inc. (2021). Annotations -- the Java language
specification, Java SE 17 edi- tion.
https://docs.oracle.com/javase/specs/jls/se17/ html/jls-9.html#jls-9.7.

132 
