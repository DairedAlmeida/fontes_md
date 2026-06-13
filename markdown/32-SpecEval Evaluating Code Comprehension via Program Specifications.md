                                         SpecEval: Evaluating Code Comprehension in Large
                                         Language Models via Program Specifications
                                         LEZHI MA, Nanjing University, China
                                         SHANGQING LIU, Nanyang Technological University, Singapore

arXiv:2409.12866v1 \[cs.SE\] 19 Sep 2024

                                         LEI BU, SHANGRU LI, and YIDA WANG, Nanjing University, China
                                         YANG LIU, Nanyang Technological University, Singapore
                                         Large Language models (i.e. LLMs) have achieved impressive performance in automated software engineering.
                                         Extensive efforts have been made to evaluate the abilities of code LLMs in various aspects, with an increasing
                                         number of benchmarks and evaluation frameworks proposed. Apart from the most sought-after capability
                                         of code generation, the capability of code comprehension is being granted growing attention. Nevertheless,
                                         existing works assessing the code comprehension capability of LLMs exhibit varied limitations. For example,
                                         evaluation frameworks like CRUXEval and REval usually focus on code reasoning tasks over a certain input
                                         case. It leads to a limited range of execution traces covered, resulting in a loss in code semantics examined
                                         and the inability to assess the comprehensive understanding of LLMs concerning the target program.
                                            To tackle the aforementioned challenges, we propose SpecEval, a novel black-box evaluation framework to
                                         evaluate code comprehension in LLMs via program specifications. Inspired by the idea that specifications can
                                         act as a comprehensive articulation of program behaviors concerning all possible execution traces, we employ
                                         formalized program specifications to represent program semantics and perform comprehensive evaluations. In
                                         particular, four specification-related tasks are designed meticulously to assess the capability of LLMs from basic
                                         to advanced levels. Moreover, counterfactual analysis is conducted to study the performance variance of LLMs
                                         under semantics-preserving perturbations, and progressive consistency analysis is performed to study the
                                         performance consistency of LLMs over a series of tasks with sequential dependence. Systematic experiments
                                         are conducted on six state-of-the-art LLMs. Extensive experimental results present a below-satisfactory
                                         performance of LLMs on specification-related tasks, revealing the limitations of existing LLMs in terms of
                                         articulating program semantics. The counterfactual analysis and progress consistency analysis also reveal the
                                         sensitivity of LLMs towards semantic-preserving perturbations and limited progressive consistency across the
                                         progressive tasks. Our experimental results and analysis underscore future directions for enhancement.
                                         CCS Concepts: • General and reference → Empirical studies; • Theory of computation → Program
                                         specifications.
                                         Additional Key Words and Phrases: Large language models, Program Semantics, Program Specifications

                                         1   INTRODUCTION
                                         Automated software engineering, encompassing areas such as code generation [12, 35], program
                                         repair [44, 63], and code summarization [40, 66], has persistently remained a prominent research
                                         focus in both academic and industrial practice. Early research in this field adopted traditional
                                         techniques, such as template-based [18, 19] and retrieval-based [24, 66] methods, to address these
                                         issues. However, due to technology and data availability constraints, these methods often struggled
                                         to deliver satisfactory performance. With the rise and advancement of deep learning technologies, an
                                         increasing number [65], Transformer [57], and GNNs [62], have been applied to this field. Extensive
                                         research on program semantics learning with advanced neural network models drives significant
                                         progress and advancements in various SE applications. Program semantics are the essence of
                                         a program, programs with identical semantics may have different expressions. Consequently,

                                         Authors’ addresses: Lezhi Ma, lezhima@hotmail.com, Nanjing University, Nanjing, Jiangsu, China; Shangqing Liu, liu.
                                         shangqing@ntu.edu.sg, Nanyang Technological University, Singapore, Singapore; Lei Bu, bulei@nju.edu.cn; Shangru Li,
                                         shangruli1013@gmail.com; Yida Wang, wangyida2002@hotmail.com, Nanjing University, Nanjing, Jiangsu, China; Yang
                                         Liu, yangliu@ntu.edu.sg, Nanyang Technological University, Singapore, Singapore.

2 Lezhi Ma, Shangqing Liu, Lei Bu, Shangru Li, Yida Wang, and Yang Liu

numerous studies \[48, 55, 67\] have explored different techniques,
including tree-based and graph- based approaches, to improve the neural
networks in learning program semantics. Recently, large language models
(LLMs) \[1, 23, 37, 43, 45, 50, 56, 60\] have impressed the community
with their outstanding performance, vastly surpassing previous
techniques in various software development applications. In the
meantime, a wide range of software development tools \[20, 29\] powered
by these models have significantly increased the productivity of
software developers. Behind the rapid advancement of these LLMs,
compared to earlier techniques such as graph-based approaches that
explicitly incorporated code semantics into model training to help the
model comprehend program semantics, LLMs usually treat the code snippet
as pure text and rely on the straightforward pre-training techniques
i.e., next-token prediction to train on a massive amount of code corpus.
As a result, it raises a question i.e., does the simple next-token
pertaining technique truly enable models to comprehend the complex
semantics of code? Numerous benchmarks, such as HumanEval \[12\], MBPP
\[5\], and SWE-bench \[30\], are proposed to evaluate the coding
capacity of LLMs. Although these benchmarks can, to some extent, reflect
the code generation capabilities of different models, using the
criterion of whether the generated code passes test cases is still
insufficient to determine whether the models genuinely understand the
code \[64\]. To conduct a more in-depth analysis, CRUXEval \[22\] and
REval \[11\] define certain program execution tasks, such as code
coverage prediction and output prediction, to assess the code reasoning
capabilities of LLMs by comparing the model's generated results with
actual program runtime outcomes. Nevertheless, the dynamic execution
results of a program depend on variations in its input, making it
challenging to ensure that a comprehensive set of inputs can cover all
possible execution traces 1 . It leads to limited program inputs
invoking limited execution traces for a program and cannot
comprehensively reflect the full program semantics. Some probing
techniques \[26, 39, 59\] are adopted to analyze the code understanding,
such as code syntax and semantic knowledge. They typically require
access to a model's intermediate vector representations for
corresponding inputs to investigate whether the model has learned
specific attributes. As these techniques usually require direct access
to the model, they are not feasible for black-box models such as GPT-3.5
and GPT-4. These challenges inspire us to explore other forms of
representation for program semantics, which are required to articulate
program behaviors in multiple granularities. Formalized program
specifications encompass precise claims that describe the intended or
actual program behaviors in formal languages. By specifying the
constraints on program variables or the transition of program states,
the strong program specifications can effectively articulate program
semantics, accurately capturing program behaviors either generally or in
detail. Moreover, the correctness of formal specifications can be
effectively validated by corresponding specification verifiers \[2, 15,
31\]. It also overcomes the limitations of using natural languages, such
as code summaries, to describe the functionality of code, which cannot
be automatically verified. Inspired by these ideas, we propose SpecEval,
a novel black-box evaluation framework featuring the representation of
program semantics in the form of formal program specifications. We
define multiple specification-related tasks for subject LLMs to
complete. These tasks require LLMs to demonstrate an understanding of
code by summarizing the code behavior and generating formalized
statements. By leveraging automated procedures for determining the
correctness of specifications, the assessment can be conducted
rigorously and efficiently. In particular, four tasks with sequential
dependencies are designed, including Judgement, Selection, Infilling,
and Generation. In the Judge- ment task, LLMs are required to evaluate
the correctness of the given specifications for the code.

1 The execution trace refers to the transitions of program states \[49\]
where the states are defined as the set of all program

variables including their types and values. SpecEval: Evaluating Code
Comprehension in Large Language Models via Program Specifications 3

The Selection task involves selecting the most appropriate candidate
specification for the target program. The Infilling task requires LLMs
to complete partially provided specifications by filling in the correct
sub-expressions. Finally, the Generation task challenges LLMs to
generate correct specifications entirely from scratch. For each task, we
further introduce counterfactual analysis to cast code comprehension as
the problem of determining how controlled input code changes result in
model output changes by the semantic-preserving perturbations, with
mutation operators including Def-use Break, If-else Flip, Independent
Swap, Name Random, and Name Shuffle. Moreover, for each kind of
perturbation, Progressive Consistency Analysis is conducted with the
well-designed metric Progressive Consistency Score to examine the
consistency performance of LLMs over these tasks with progressive
dependencies, enabling the framework to assess the code comprehension
capacities of LLMs from the shallow to the deep. To construct the
framework, we collect 204 Java programs with verifiable ground-truth
specifica- tions in JML \[32\] style from existing datasets, including
Frama-C-Problems \[21\], the Java category of SV-COMP Benchmark \[54\],
and a dataset collected by Ma et al.\[38\]. Test cases for these
programs are also generated to assist the specification validation
process. We conduct experiments on six large language models, including
state-of-the-art code LLMs and general LLMs, for a systematic comparison
between the popular models. Experiment results show that LLMs still have
a long way to go before they can fully articulate program semantics with
formal specifications, with less than satisfactory performance in most
specification-related tasks. Also, Counterfactual Analysis discloses the
sensitivity of LLMs to different extents towards semantic-preserving
perturbations. Additionally, Progressive Consistency Analysis suggests
that the reasoning ability of LLMs does not work in a progressive manner
as humans do. In summary, the main contributions of our work include:

• A novel black-box evaluation framework assessing the program semantics
learning abilities of LLMs, featuring the representation of program
semantics in the form of formalized specifications. Four tasks with
progressive difficulties and Counterfactual analysis are designed to
study the performance of LLMs from multiple aspects. • An adapted
benchmark \[6\] based on existing datasets \[21, 38, 44, 54\],
consisting of 204 Java programs, along with ground-truth specifications,
test cases for dynamic validation, and five semantics-equivalent
variants, is released to facilitate follow-up research. • A thorough
evaluation of six state-of-the-art code LLMs and general LLMs, revealing
the lim- itations of LLMs concerning the expression of program semantics
with formal specifications, underscoring the directions for future
enhancement of LLMs.

2 MOTIVATION AND RELATED WORK 2.1 Program Specification Program
specification refers to precise statements that define a program's
intended or actual behav- iors, either in its entirety or in specific
components. According to the language adopted, program specifications
can be categorized into natural language specifications and formalized
specifications. Natural language specifications primarily encompass
software documentation and code comments. Another significant portion of
program specifications is articulated using formal languages, such as
mathematical expressions \[31, 32\] to specify the constraints governing
a program's behavior, and automata \[36, 52\] to describe the
transitions of program states. Compared with natural language,
formalized specifications are rigorous and unambiguous. Program
specifications have been widely adopted in a variety of software
engineering tasks, such as requirement engineering \[4, 51\], software
testing \[41, 42\], and model checking \[8, 10\]. 4 Lezhi Ma, Shangqing
Liu, Lei Bu, Shangru Li, Yida Wang, and Yang Liu 4 Anon.

              148         1    //@ requires s != null;
              149         2    //@ ensures \result <==> (\forall int i; 0 <= i && i < s.length(); s.charAt(i) ==
              150              ↩→ s.charAt(s.length() - 1 - i));

              151
                          3    public static boolean isPalindrome(String s) {
                          4        int n = s.length();
              152
                          5        //@ maintaining 0 <= i && i <= s.length();
              153         6        //@ maintaining (\forall int j; 0 <= j && j < i; s.charAt(j) == s.charAt(n - 1 - j));
              154         7        //@ decreases n - i;
              155         8        for(int i = 0; i < n; i++) {
              156
                          9            if(s.charAt(i) != s.charAt(n - 1 - i)) {
                          10               return false;
              157
                          11           }
              158         12       }
              159         13       return true;
              160         14   }
              161
                Fig. 1. Example Java program isPalindrome and corresponding ground-truth specification written in JML
    Fig. 1. 162
            An example     program
                style (highlighted       and corresponding ground-truth JML specification (highlighted in blue).
                                   in blue).
              163

In SpecEval, 164 we mainly Together, focusmentioned the specifications
on formal specifications above constitute writtenofin a detailed
articulation theJava semanticsModeling of the Language (JML)
\[32\]166describing the Foractual behaviors of Javaas a programs. One
and example program 165 target program. the method isPalindrome whole,
preconditions postconditions specifyisPalindrome its overall
requirements and functionalities. For the internal implementation of
isPalindrome, and corresponding 167 ground-truth specifications are
illustrated in Fig. 1. The program aims to check loop invariants reveal
the pattern followed by local variables when they are updated. whether
a169givenIt isinput 168 stringthats formalized worth noting is a
palindrome string, are program specifications i.e.,more a string
rigorous that reads and formal, the same forward eliminat- and backward.
170 ingThe specifications ambiguity compared withare instrumented
specifications in natural within language. the program Moreover, in
formalized the form program of comments specifications can thoroughly
articulate program semantics. Program semantics essentially lies
starting with 171 //@. Generally, the specifications involved can be
divided in the variance of program states, usually defined by the set of
variable values. By specifying into three categories: 172 •
Preconditions 173 the constraints (line 1), on program variables
described or the transition in requires of program statements, states,
the strong specifying program the constraints on input specifications
are rich in semantic information and can accurately capture program
behaviors. variables 174 175 that In must addition, be the met before
correctness of the formal corresponding specifications can becode (i.e.
effectively isPalindrome validated. A good here) number is executed. •
Postconditions 176 (line 2), described of specification verifiers \[2,
14, in29\] is proposed ensures statements, to automatically specifying
the properties check the consistency betweenof the returned the given
specifications and the target program. Consequently, compared with
natural language value that always 177 specifications,holdtheafter the
corresponding correctness codecan of program specifications is be
executed. automatically verified. 178 • Loop Invariants 179 (lines 5, 6,
and 7), described in maintaining statements, specifying the con-
straints180on the local variables that always hold each time before the
loop body is executed. 2.2 Program Semantics Comprehension of LLMs 181
Program semantics are the core of a program, and only when code models
can effectively learn these Together, 182 the specifications semantics
can theymentioned provide reliableabove supportconstitute and
assuranceaindetailed articulation software development. of the Recently,
semantics of the there target program. 183 hasFor beenthe method a surge
in the impact of LLMs, playing isPalindrome asa asignificant whole,role
preconditions anddevelopment in various software postconditions specify
scenarios. In light of the critical role of code semantics, a
substantial body of research has attempted its overall185requirements
andLLMs functionalities. For the internal implementation of
isPalindrome, 184 to evaluate whether genuinely comprehend code through
various analytical techniques. loop invariants 186 Areveal the pattern
typical technique involvesfollowed using probingby analysis local
variables \[24, 38, 55\] towhen explore their whethervalues are updated.
code models have learned specific code attributes from the trained code
datasets. Specifically, it leverages the It is worth 187 188 noting that
formalized program specifications are more transformation of code
semantic information, such as data flow, into high-dimensional vector
rigorous, eliminating ambiguity compared189withrepresentations
specifications in the in natural latent language. space. This enables
anMoreover, examination offormalized program whether the model
specifications can truly under- thoroughly 190 articulate program stands
the semantics semantics. of the code. Yet, theyProgram semantics are
usually required essentially to access lies in the evolution of the
model's intermediate 191 vector representations for analysis, which is
not feasible for black-box commercial models such as program states, 192
which GPT-3.5 andareGPT-4.usually Moreover,defined by the some popular
codeset of variable generation values. benchmarks suchBy specifying as
HumanEval \[11\],the constraints on program 193 variables MBPP \[5\], or
andthe transition SWE-bench \[28\] areof proposed program states, the to
evaluate thecoding strong program capacity of LLMs. specifications Yet,
the are rich criterion to judge whether the generated code can pass test
cases is insufficient to articulate the in semantic194 195 information
model's and understanding can of accurately the code. capture program
behaviors. In addition, the correctness of formal 196 specifications can
be effectively validated. A good number of specification verifiers \[2,
15, 31\] is proposed , Vol.to automatically 1, No. 1, Article .
Publicationcheck the 2024. date: September consistency between the given
specifications and the target program. Consequently, compared with
natural language specifications, the correctness of program
specifications can be automatically verified.

2.2 Program Semantics Comprehension of LLMs Program semantics are the
core of a program, and only when code models can effectively learn these
semantics can they provide reliable support and assurance in software
development. Recently, there has been a surge in the impact of LLMs,
playing a significant role in various software development scenarios. In
light of the critical role of code semantics, a substantial body of
research has attempted to evaluate whether LLMs genuinely comprehend
code through various analytical techniques. A typical technique involves
using probing analysis \[26, 39, 59\] to explore whether code models
have learned specific code attributes from the trained code datasets.
Specifically, it leverages the transformation of code semantic
information, such as data flow, into high-dimensional vector SpecEval:
Evaluating Code Comprehension in Large Language Models via Program
Specifications 5

representations in the latent space. This enables an examination of
whether the model truly under- stands the semantics of the code. Yet,
they are usually required to access the model's intermediate vector
representations for analysis, which is not feasible for black-box
commercial models such as GPT-3.5 and GPT-4. Moreover, some popular code
generation benchmarks such as HumanEval \[12\], MBPP \[5\], and
SWE-bench \[30\] are proposed to evaluate the coding capacity of LLMs.
Yet, the criterion to judge whether the generated code can pass test
cases is insufficient to articulate the model's understanding of the
code. The latest research REval \[11\] proposed a framework to evaluate
the code reasoning ability of LLMs by inferring the program runtime
behaviors. Inspired by CRUXEval \[22\], REval proposed four evaluation
tasks, including Code Coverage Prediction, Program State Prediction,
Execution Path Prediction, and Output Prediction for evaluation. In
particular, Code Coverage Prediction requires LLMs to predict whether a
statement will be executed given a certain input. Program State
Prediction requires LLMs to reason about the type and value of a
specific variable. Execution Path Prediction requires LLMs to predict
the next statement executed under certain circumstances, and Output
Prediction requires LLMs to generate the program's output directly from
the given input. It should be emphasized that in each of the four tasks
mentioned, LLMs are provided with one specific input respectively. For a
deterministic program, one specific input can only result in one
particular trace of program state transition, i.e. the execution trace.
This observation leads to the fact that for each independent task
assigned, LLMs are only reasoning about program behaviors within one
specific execution trace, whereas there exists an infinite number of
execution traces (corresponding to the infinite number of inputs) within
the program state space other than the one being examined. Nevertheless,
program semantics is not only about the program behaviors during one
specific execution but also about the general pattern of program state
transition adaptable to all potential program states. The set of program
behaviors for all potential program states and execution traces
constitutes full program semantics. This indicates that the practice
employed by REval could cause a loss in the program semantics examined
by its tasks, since REval can only supply a limited number of evaluation
tasks and inputs, leaving the other program behaviors in an infinite
number of execution traces uncovered. To tackle the issues mentioned
above, a new carrier to articulate program semantics is neces- sary. As
described in Section 2.1, specifications can thoroughly articulate the
program semantics. Compared to the perspectives of existing works,
specifications can describe the abstract patterns between program
variables that should be adaptable to all possible execution traces. For
instance, the post-condition on line 2 illustrated in Fig. 1 articulates
a precise constraint on the input string s and the return value
`\result`{=tex}. The constraint is correct, yet general, i.e., all pairs
of possible input strings and corresponding return values must satisfy
this constraint. Because the specification works for all possible
inputs, it acts as an abstract pattern for all possible execution traces
since each valid execution trace must be triggered by a specific input.
Proceeding from this idea, we propose SpecEval, a black-box evaluation
framework for LLMs featuring the representation of program semantics in
the form of formal program specifications. The defined
specification-related tasks can evaluate the comprehension of LLMs
concerning the comprehensive program semantics. By requesting LLMs to
complete these tasks, their capabilities to comprehend code can be
evaluated by assessing the quality of the generated specifications.

3 METHODOLOGY In this section, we aim to present a detailed introduction
to our framework, SpecEval. We first provide an overview of SpecEval,
then describe the evaluation tasks in our framework. For each task, we
further introduce the counterfactual analysis, framing code
comprehension as the challenge of assessing how controlled input code
modifications, through semantic-preserving perturbations, lead 6 Lezhi
Ma, Shangqing Liu, Lei Bu, Shangru Li, Yida Wang, and Yang Liu

                                                                                           Counterfactual Analysis
                                                                                          original   variant1   variant2


                          Spec Correctness Judgement            Def-use Break            original    variant1   variant2
                                                                 If-else Flip
                           Spec Candidates Selection
                                                              Independent Swap
                                                                                                                LLM
                             Specification Infilling
                                                                Name Random
                                                                                          judge select     infill generate
        Program
           &               Specification Generation             Name Shuffle
      Specification
                      Progressive Evaluation Tasks            Semantic-preserving         judge select     infill generate
                                                                 Perturbations

                                                                                       Progressive Consistency Analysis

                                 Fig. 2. Overview of the evaluation framework SpecEval.

to changes in the model's output. Moreover, for each type of
perturbation, we perform Progressive Consistency Analysis to evaluate
the consistency of LLM performance across tasks of increasing diffi-
culty. This framework enables a comprehensive assessment of the code
comprehension capabilities of LLMs, ranging from superficial to deeper
levels of understanding.

3.1 Overview Fig. 2 demonstrates the overview of our framework, which is
characterized by employing formalized program specifications to
represent program semantics. We generally adopt the typical architecture
of existing black-box evaluations \[11, 22\], where several evaluation
tasks are assigned to the LLMs. The ability of LLMs is evaluated by
assessing their performance in these tasks. In our frameworks, four
tasks related to program specifications are designed, including
Specification Correctness Judgement, Specification Candidates Selection,
Specification Infilling, and Specification Generation. For each task, we
design five semantic-preserving perturbations performed on the programs
and the corresponding ground-truth specifications to create variants
with equivalent semantics. Counterfactual analysis is conducted based on
the original and mutants, allowing us to study the performance variance
of LLMs against semantic-preserving perturbations. Progressive
consistency analysis is performed for each type of perturbation to
evaluate the consistency of LLM performance on a series of tasks with
sequential dependencies in between.

3.2 Evaluation Tasks and Metrics We designed four tasks related to
formal program specifications. These tasks not only request LLMs to
summarize abstract semantic information into formalized statements but
also require them to comprehend the given specifications and take
appropriate actions based on their understanding. 3.2.1 Specification
Correctness Judgement. Specifications possess correctness, defined by
their consistency with program behaviors. A correct specification is
about constraints that always hold for all program states in its scope.
We denote the actual correctness of the candidate specification 𝑠 as a
function Cr : 𝑆 → {true, false}, which takes a value of Cr(𝑠) = true if
𝑠 is correct and Cr(𝑠) = false otherwise. In this task, subject LLM is
exploited to decide the correctness of a given candidate specification
on a target program. The correct candidates are extracted from the
ground-truth specifications of the target program, and the incorrect
candidates are obtained by modifying essential components within the
ground-truth specification, including replacing variable names with
other variables in the same scope, altering variable operators, and
swapping statement predicates (i.e., between `\forall `{=tex}and
`\exists`{=tex}). Each component of interest is decided randomly whether
it will be modified, with equal probabilities (at 50%) of being modified
or staying unchanged. At least one modification is performed to ensure
the specification is not exactly the same. SpecEval: Evaluating Code
Comprehension in Large Language Models via Program Specifications 7

• Task Formalism. Given a target program 𝑃, and a candidate
specification 𝑠, a judgment task 𝑡 ∈ 𝑇 is a 2-tuple (𝑃, 𝑠), where the
subject model M : 𝑇 → {true, false} is required to decide whether the
given specification is correct for the target program. • Evaluation
Metrics. In this task, Accuracy measures the percentage of correctly
judged specifi- cations. The Accuracy for this task can be calculated by
the following formula: 1 ∑︁ 𝐴𝑐𝑐𝑢𝑟𝑎𝑐𝑦 = I(M (𝑃, 𝑠) = Cr(𝑠)) \|𝑇 \| (𝑃, 𝑠 )
∈𝑇

where I : {true, false} → {0, 1} is the indicator function that returns
1 if and only if the given boolean expression takes a value of 𝑡𝑟𝑢𝑒.

3.2.2 Specification Candidates Selection. Specifications possess varying
degrees of strength. While weaker specifications such as ensures true
can still pass the verification and should be considered correct, they
often describe only trivial information about the program. In contrast,
stronger specifications provide a more comprehensive expression of the
program's semantics. Therefore, in this task, we consider both the
correctness and strength when constructing candidates for the given
target program. In particular, four candidate specifications are
provided to subject LLM, which is required to choose the most
appropriate (i.e., correct and strongest) one for the given target
program. The most appropriate candidate (denoted as 𝑠)ˆ in four
candidates is extracted from the ground-truth specifications for the
target program. Other candidates have an equal chance of being modified
specifications or trivial specifications. The former is obtained by
modifying the ground-truth specification with the same logic mentioned
in Section 3.2.1. The latter is randomly chosen from a set of
pre-defined simple specifications that are too weak to be incorrect,
such as ensures true. • Task Formalism. Given a target program 𝑃, and a
set of four candidate specifications 𝑆 = {𝑠 1, 𝑠 2, 𝑠 3, 𝑠 4 }, a
selection task 𝑡 ∈ 𝑇 is a 2-tuple (𝑃, 𝑆), where the subject model M : 𝑇
→ 𝑆 is required to return the most appropriate candidate within 𝑆 for
the target program. • Evaluation Metrics. In this task, Accuracy
measures the percentage of correctly selected specifications. The
Accuracy for this task can be calculated by the following formula. 1 ˆ ∑︁
𝐴𝑐𝑐𝑢𝑟𝑎𝑐𝑦 = I(M (𝑃, 𝑆) = 𝑠) \|𝑇 \| (𝑃, 𝑆 ) ∈𝑇

3.2.3 Specification Infilling. In this task, an uncompleted
specification (partially masked with a placeholder) is provided to the
subject LLM, which is required to fill in the placeholder with
appropriate sub-expressions according to the given target program so
that the final specification can pass the verifier. The uncompleted
specification is acquired by randomly masking specific components of the
ground-truth specifications with placeholders. At most, one placeholder
is inserted once. The components of interest include array index,
variable and method names, and boundary constraints of
`\forall `{=tex}and `\exists `{=tex}statements, which can be identified
by parsing specifications into Abstract Syntax Trees. • Task Formalism.
Given a target program 𝑃, and an uncompleted specification 𝑠, an
infilling task 𝑡 ∈ 𝑇 is a 2-tuple (𝑃, 𝑠), where the subject model M : 𝑇
→ 𝑆 is required to fill in the placeholder of 𝑠 according to the target
program and return the filled-in version of 𝑠. • Evaluation Metrics. In
this task, we use #Pass and Accuracy for measurement. #Pass denotes the
number of programs 𝑃 for which the specification infilled by model M are
correct. Accu- racy measures the percentage of correctly infilled
specifications. Denoting the correctness of 8 Lezhi Ma, Shangqing Liu,
Lei Bu, Shangru Li, Yida Wang, and Yang Liu

    specification 𝑠 as Cr(𝑠), the Accuracy for this task can be calculated as:
                                              1 ∑︁
                                𝐴𝑐𝑐𝑢𝑟𝑎𝑐𝑦 =               I(Cr(M (𝑃, 𝑠)))
                                             |𝑇 |
                                                 (𝑃, 𝑠 ) ∈𝑇

3.2.4 Specification Generation. In this task, the subject LLM is
provided with a program 𝑃 with no instrumented specifications. The LLM
is exploited to generate a set of specifications 𝑆 from scratch,
describing the general behaviors and functionalities of the target
program as closely as possible. The generated specifications are
required to include pre/post-conditions for all methods and loop
invariants for all loops involved in the target program. • Task
Formalism. Given a target program 𝑃 ∈ P, the subject model M : P → 2𝑆 is
required to generate an appropriate set of specifications 𝑆 for 𝑃. •
Evaluation Metrics. In this task, Precision and Recall are adopted to
measure the performance of LLMs. Precision measures the percentage of
correct specifications that can pass the verifier over all the generated
specifications for the target program 𝑃. Recall measures the percentage
of correctly generated ground-truth specifications (i.e., correct and
strongest) over all the ground-truth specifications for the target
program 𝑃. Í 𝑠 ∈ M (𝑃 ) I(Cr(𝑠)) Í ˆ 𝑠 ∈ M (𝑃 ) I(𝑠 ∈ 𝑆 𝑃 ) 𝑃𝑟𝑒𝑐𝑖𝑠𝑖𝑜𝑛(𝑃)
= 𝑅𝑒𝑐𝑎𝑙𝑙 (𝑃) = \|M (𝑃)\| \|𝑆ˆ𝑃 \| where 𝑆ˆ𝑃 denotes the set of all
ground-truth specifications for program 𝑃. Correspondingly, the average
precision and recall on the set P of all programs in the benchmark can
be calculated as: 1 ∑︁ 1 ∑︁ 𝐴𝑣𝑔𝑃𝑟𝑒𝑐𝑖𝑠𝑖𝑜𝑛 = 𝑃𝑟𝑒𝑐𝑖𝑠𝑖𝑜𝑛(𝑃) 𝐴𝑣𝑔𝑅𝑒𝑐𝑎𝑙𝑙 = 𝑅𝑒𝑐𝑎𝑙𝑙
(𝑃) \|P\| 𝑃 ∈P \|P\| 𝑃 ∈P Apart from precision and recall, we also use
#Pass metric to denote the number of programs 𝑃 for which all
specifications generated by model M can pass the verifier.

3.3 Counterfactual Analysis Counterfactual Analysis is a specific
technique conducted by observing the variance in the model performance
after changing the model inputs in a particular way \[58\]. In SpecEval,
for each kind of the designed evaluation task in Section 3.2, we
respectively adopt some typical semantic-preserving perturbations to
analyze the performance of LLMs on the task. 3.3.1 Semantic-preserving
Perturbations. To eliminate potential bias, the perturbations should be
performed while adhering to the following criteria. • Consistency with
the original program. The perturbations should not alter the overall
behaviors and functionalities of the program. The perturbed program and
the original program should perform exactly the same behaviors if
treated as black boxes. • Consistency with the original specifications.
All specifications for the original program should also be adaptable to
the perturbed program without significant structural or semantic modifi-
cations. Trivial modifications that have no semantic effects are
allowed, such as altering the variable names involved according to
specific patterns. The perturbation should not reduce the program points
of interest (e.g. methods and loops) where specifications should be
generated. • Consistency with the evaluation tasks. The perturbed
programs should still be adaptable to all the tasks designed for the
original program. The perturbations should not alter the problems or the
corresponding answers (i.e., ground truth) involved in the tasks.
Similar to the previous rule, trivial modifications such as the variable
name modification can be performed on the prompts engaged in the tasks
if necessary. SpecEval: Evaluating Code Comprehension in Large Language
Models via Program Specifications 9

Fig. 3. Illustrations for the semantic-preserving perturbations,
including the original program, corresponding specifications, and all
perturbed programs. The code and specifications modified by the
perturbations are highlighted in blue.

Following prior research \[27\], we adopted five different types of
semantic-preserving perturba- tions that meet the criteria above,
including Def-use Break, If-else Flip, Independent Swap, Name random,
and Name shuffle. • Def-use Break. Def-use chain refers to the
relationship between the definitions of a certain variable (where it is
assigned with a value, e.g., x = 0) and its subsequent uses (where its
value is accessed, e.g., func(x)). The Def-use Break perturbation aims
to break the def-use chains within target programs. This is done by
assigning the value of a variable var1 to a newly introduced variable
var2 and altering all subsequent uses of var1 to var2. In our
implementations, the variable name for var2 consists of five random
letters or digits. For instance, in the program shown in Fig. 3, a new
variable PZYcz inherits the value of variable num1, and replaces the
latter in the remaining part of the program. Similar modifications are
performed on variable num2 and local variable temp. Since the newly
introduced variable completely supersedes the role of the original
variable, the semantic-preserving feature of this perturbation is
guaranteed. • If-else Flip. This perturbation swaps the branches of an
if-else statement. This is done by replacing the content of the two
branches with each other and negating the branch condition. Obviously,
such perturbation does not affect the semantics of the original program.
• Independent Swap. For ease of handling, we adopt a safe definition for
independent statements. For two adjacent statements 𝑆 1 and 𝑆 2 in the
same basic block, denote the sets of variables defined and used by
statement 𝑆𝑖 as 𝑉𝑖 and 𝑉𝑖𝑢𝑠𝑒 respectively. If the following three
conditions are 𝑑𝑒 𝑓

satisfied simultaneously: (1) 𝑉1 ∩ 𝑉2 = ∅ (2) 𝑉1𝑢𝑠𝑒 ∩ 𝑉2 = ∅ (3) 𝑉1 ∩
𝑉2𝑢𝑠𝑒 = ∅, then the 𝑑𝑒 𝑓 𝑑𝑒 𝑓 𝑑𝑒 𝑓 𝑑𝑒 𝑓

two statements are considered independent from each other and can be
swapped. For instance, in the original program shown in Fig. 3,
statements on line 4 and line 5 constitute a pair of independent
statements. Swapping such pairs of statements will not disrupt the
original data flow and is semantic-preserving. • Name Random. This
perturbation assigns randomly generated names to all program variables
and methods. Consistent with Def-use Break, the generated names consist
of five random letters or digits. Altering the variable name of a
program does not affect program semantics, given that the altered
variable names do not conflict with others. The corresponding variable
names in the specifications also need to be changed accordingly. 10
Lezhi Ma, Shangqing Liu, Lei Bu, Shangru Li, Yida Wang, and Yang Liu

• Name Shuffle. The idea of this perturbation is the same with Name
random but is done by reshuffling all the variable names within the
original program rather than generating new names. The corresponding
specifications are changed accordingly. Similarly, the perturbation does
not affect the original program semantics. It is worth noting that for
some of the perturbations, the specifications involved in the original
program should be mutated simultaneously. For instance, Name Random and
Name Shuffle alter all the variable names in the original program, where
the specifications should be mutated following the same pattern since
the variable names are involved in the specifications as well. If-else
Flip perturbation may change the positions of some specifications within
the target if-else branch, so the specifications involved need to be
migrated. Such modifications to specifications pose no impact on their
semantics. Additionally, task prompts involving specifications have to
be mutated as well, keeping them equivalent to the original tasks, such
as the candidate specifications used in the prompt in Specification
Correctness Judgement and Specification Candidate Selection tasks. 3.3.2
Evaluation Metrics. We adopt different metrics for different tasks for
counterfactual analysis. For the task of Judgement, Selection, and
Infilling, we adopt Jaccard Distance to measure the impact of
perturbations on the task as 𝐽 = 1 − \|P ∩ P′ \|/\|P ∪ P′ \| , where P
and P′ refer respectively to the set of original and perturbed programs
that an LLM can successfully handle for one kind of perturbation in
Section 3.3.1. The programs in P ∩ P′ refer to the LLM successfully
handles both the original and the perturbed versions, indicating that
its performance is consistent on these programs, without being
interfered by the perturbation, whereas other programs in P ∪ P′ witness
a varied performance on different versions. The Jaccard Distance
measures the impact of perturbations by calculating the percentage of
inconsistently-performing programs. A high distance indicates a strong
impact that the corresponding perturbation poses. For the task of
Generation, since it is quantitatively measured by precision and recall,
we define Average Variance to measure the impact of perturbations for
this task. For a specific type of perturbation in Section 3.3.1, the
Average Variance of metric 𝑚 where 𝑚 ∈ {𝑃𝑟𝑒𝑐𝑖𝑠𝑖𝑜𝑛, 𝑅𝑒𝑐𝑎𝑙𝑙 } can be
calculated as follows: 1 ∑︁ 𝑣𝑚 = \|𝑚(𝑃 ′ ) − 𝑚(𝑃)\| 𝑤ℎ𝑒𝑟𝑒 P = {(𝑃, 𝑃 ′ )
\| 𝑚(𝑃) \> 0 ∨ 𝑚(𝑃 ′ ) \> 0} \|P\| ′ (𝑃,𝑃 ) ∈P

(𝑃, 𝑃 ′ ) denotes pairs of the original program and the perturbed
program. Note that we only consider (𝑃, 𝑃 ′ ) where either 𝑃 or 𝑃 ′
achieve a non-zero value of 𝑚. The average variance of precision and
recall is denoted as 𝑣 𝑝𝑟𝑒𝑐 and 𝑣𝑟𝑒𝑐 , respectively.

3.4 Progressive Consistency Analysis Progressive Consistency describes
the degree to which a model can sustain its performance across a
sequence of interrelated tasks. \[11\] Intuitively, for a series of
sequentially related tasks, models that fail with the preliminary tasks
should tend to fail the advanced follow-up tasks as well. The essence of
progressive consistency lies in the sequential dependencies within the
series of tasks. The completion of follow-up tasks should partially rely
on the knowledge obtained from previous tasks or the ability to complete
previous tasks. Given a series of tasks designed with the criterion
above, we can evaluate the performance consistency between these tasks
to assess whether the models comprehend the code progressively. 3.4.1
Sequential Dependencies Between Evaluation Tasks. Concerning the four
evaluation tasks described in Section 3.2, the sequential dependency in
between mainly lies in the ability to complete them. Each follow-up task
relies partially on the ability to complete its previous task. SpecEval:
Evaluating Code Comprehension in Large Language Models via Program
Specifications 11

• From Judgement to Selection. The selection task essentially requires
models to judge the correct- ness and strength of all given candidates
respectively and choose the correct and strongest one based on the
judgments. • From Selection to Infilling. To complete an infilling task,
the models have to comprehend the specification to fill in, analyze the
semantics of the missing parts, select the most appropriate code
patterns in the program, and convert them to formalized specifications.
• From Infilling to Generation. Essentially, the specification
generation tasks require multiple rounds of infilling without additional
contexts for completion. Generating strong specifications requires a
thorough understanding of LLMs concerning the semantics of the target
program.

With the intuitions above, we can confirm the sequential dependency
existing between the evalua- tion tasks in SpecEval.

3.4.2 Evaluation Metrics. To quantitatively evaluate the consistency
described above, we design a specialized metric, Progressive Consistency
Score, or PCS for short, for evaluation. The core idea of PCS is to
measure how many tasks in a row the model can handle. Due to the
sequential dependency described in Section 3.4.1, we expect the models
to handle tasks consecutively given that their semantics learning
abilities towards sequential tasks with progressive difficulties are
leveraged in a progressive manner as well. We denote the results of the
four tasks concerning the same program 𝑃 as a sequence 𝑅(𝑃) = \[𝑟 1, 𝑟
2, 𝑟 3, 𝑟 4 \], where 𝑟𝑖 ∈ {true, false} denotes whether the model
succeeds in the 𝑖-th task. For Judgement, Selection, and Infilling, the
tasks are considered successful if the answer equals the ground truth or
passes verification. For Generation, we adopt softened criteria and view
those trials with 𝑃𝑟𝑒𝑐𝑖𝑠𝑖𝑜𝑛(𝑃) \> 0 as successful generations since
positive precision indicates some correct specifications (that can pass
the verifier) generated and partial semantics comprehended by LLM.
Specifically, the PCS for program 𝑃 (denoted as PCS(𝑃)) can be
calculated as follows:

• If the model successfully handles all four tasks, i.e., 𝑅(𝑃) = \[true,
true, true, true\], it receives a full score of PCS(𝑃) = 1. • If the
model handles three tasks in a row, i.e., 𝑅(𝑃) = \[true, true, true,
false\] or 𝑅(𝑃) = \[false, true, true, true\], it receives a half score
of PCS(𝑃) = 0.5. • If the model handles two tasks in a row, for
instance, 𝑅(𝑃) = \[true, true, false, false\] or 𝑅(𝑃) = \[true, false,
true, true\], it receives a quarter score of PCS(𝑃) = 0.25. • If the
model can only handle no consecutive tasks such as 𝑅(𝑃) = \[true, false,
false, true\] or fails to handle any task, we recognize that no
consistency is shown between the tasks, and it receives a score of
PCS(𝑃) = 0.

Correspondingly, the average Progressive Consistency Score for the set P
of all programs in the 1 Í benchmark can be calculated as PCS = \|P\| 𝑃
∈P PCS(𝑃). It can be observed that PCS is defined based on the number of
consecutive tasks handled by the model. Higher scores indicate more
tasks consecutively handled and intuitively higher progressive
consistency in the model's performance. Additionally, considering the
difficulty of completing all four tasks, the score obtained is designed
to grow exponentially from 0.25 to 1 as the number of consecutively
handled tasks increases. Compared to the Incremental Consistency Score
(ICS) designed by Chen et al. \[11\] to evaluate the reasoning ability
concerning program runtime behaviors, PCS considers more potential
consistency between all the tasks, especially the follow-up ones. For
instance, 𝑅(𝑃) = \[false, true, true, true\] receives an ICS of 0,
whereas the score is 0.5 for PCS, since such performance still
demonstrates consistency between the follow-up tasks. We assume that the
consistency between the latter tasks is meaningful despite the failure
in preliminary tasks and relevant inconsistency. 12 Lezhi Ma, Shangqing
Liu, Lei Bu, Shangru Li, Yida Wang, and Yang Liu

4 EXPERIMENTAL SETUP 4.1 Benchmark Construction We construct a benchmark
that includes programs and corresponding ground-truth specifications for
evaluation. Concerning the specification language, we adopt the Java
Modeling Language (JML) \[32\] for Java programs for evaluation since
they can be conveniently validated by Open- JML \[15\]. We use the
released datasets by the latest two research of LLM-based specification
generation \[38, 61\] for evaluation. One work by Ma et al. \[38\]
utilizes two datasets, SpecGenBench and the Java Category of SV-COMP
Benchmark \[54\]. The former contains 120 Java programs with
manually-written strong specifications and the latter is widely adopted
in the evaluation of software verification tools. For SpecGenBench, we
extract 117 programs from the dataset along with corresponding
specifications, whereas 3 programs are discarded due to incompatibility
with OpenJML. For the Java Category of SV-COMP Benchmark, as these
programs are without corresponding specifications, we manually craft
them following the similar procedure adopted in the construction of
SpecGenBench \[38\]. Extensive efforts have been conducted to manually
write these specifications, and we have succeeded in 47 programs from
SV-COMP that are compatible with OpenJML, and the written specifications
can fully specify the program semantics. Another work \[61\] leverages
another dataset, Frama-C-Problems \[21\], which contains 47 C programs
and corresponding ACSL \[7\] specifications. To cater to Java style, we
manually rewrote the programs in Java and altered the specifications to
JML-style. 40 programs that can be equivalently translated into Java
programs. Others are discarded due to specific features (i.e., pointers)
of the C programming language that cannot be trivially translated. All
specifications have been cross-validated by three experts in formal
methods and program- ming, where the semantics of the specifications and
corresponding programs are compared. The specifications will be
re-formulated until their strength is confirmed by all the experts. This
is to ensure high quality within the specifications and ability to
describe the behaviors and functionalities of the target program
thoroughly. Additionally, all specifications are also ensured to be
verifiable, i.e., able to pass the verification of the verifier (namely
OpenJML \[15\] in our work), so the correctness of the specifications
can be guaranteed. Eventually, 204 programs are collected for
evaluation. During the experiment, we adopt dynamic validation supported
by specification verifiers to check the correctness of the
specifications generated by subject LLMs (i.e., to calculate Cr(𝑠)
mentioned in Section 3.2 for a given specification 𝑠). A specification
is considered correct (i.e., Cr(𝑠) = true) if it maintains its
consistency with the target program during a runtime execution process,
where test cases are utilized to invoke the target programs. To this
end, test cases are also prepared for each program. Similar to the
preparation of ground-truth specifications, we inherit existing test
cases in the original programs if there are or employ experts to
manually craft them otherwise. The experts are required to cover as many
branches as possible with the written test cases. False specifications
(those in Section 3.2.1 and Section 3.2.2) are generated to test whether
the test cases can disprove them, and more test cases should be crafted
if they failed. Each program receives, on average, 15.10 test cases,
with an average branch coverage of 95.54% and line coverage of 93.34%.
The average LoC (Lines of Code) and CC (Cyclomatic Complexity) of
programs in the benchmark are 20.06 and 6.34, respectively. Detailed
statistics of the benchmark are provided on our website \[6\].

4.2 Studied LLMs In this work, we selected six state-of-the-art and
popular LLMs for evaluation. • GPT-3.5-Turbo \[45\], a general LLM
developed by OpenAI \[46\], able to understand and generate natural
language or code. We adopt gpt-3.5-turbo-0125, the latest model in the
GPT-3.5 family during the experiment, for evaluation. SpecEval:
Evaluating Code Comprehension in Large Language Models via Program
Specifications 13

• GPT-4-Turbo \[1\], the latest general LLM developed by OpenAI, with
the most state-of-the-art performance among all general LLMs currently.
• Llama 2 \[56\], an open-source general LLM developed by Meta AI \[3\].
We adopt Llama-2-7b-chat for evaluation. • CodeLlama \[50\], an
open-source code LLM based on the architecture of Llama 2. We adopt
CodeLlama-7b-Instruct for evaluation. • Deepseek-Coder \[23\], an
open-source code LLM employing the same architecture as DeepSeek LLM
\[9\]. We adopt the version deepseek-coder-6.7b-instruct for evaluation.
• Magicoder \[60\], an open-source code LLM fine-tuned with
OSS-Instruct, a novel high-quality code instruction data. The version
employed in the evaluation is Magicoder-S-DS-6.7B. The selected models
have been applied to a wide variety of code-related tasks in existing
works \[12, 16, 34\]. They also exhibit diversities over multiple
dimensions, ranging from general LLMs to code LLMs, open-source models
to closed-source models, and foundation models to fine-tuned models. Due
to the computing resource limit, only 7B versions of open-source LLMs
are selected.

4.3 Prompt Format and Model Configurations In terms of the prompts
provided to LLMs, we generally adopt a unified prompt structure for each
task and all the subject LLMs in the experiments. The structure mainly
consists of four components. Initially, a system message is appended to
the context to inform the model of its basic role. The few-shot
prompting technique is then adopted, where several pairs of example
requests and replies are provided to the LLM, assisting the LLM in
learning the task requirements and desired output format. Afterward, a
description of the target task (i.e., the current task that the LLM is
expected to answer) is appended to the context. Up to this point, the
context constitutes a complete query and is sent to the LLM, which
learns necessary information from the context and completes the task
within its reply. The template prompts for different tasks are provided
on our website \[6\]. For the open-source models mentioned in Section
4.2, we deploy a local server to execute the models and process relevant
queries, running on a Linux Server equipped with one H800 GPU with 80GB
memory. The source code and model weights of all open-source models can
be accessed at corresponding HuggingFace \[28\] repositories. For the
closed-source models (i.e., GPT-3.5 and GPT- 4), we access them through
the API provided by OpenAI \[47\]. Following the settings of previous
works \[17, 33\], we adopt greedy decoding \[13\] for all subject LLMs
to make the results reproducible. Generally, the models are configured
as top_k=1 and temperature=0 under greedy decoding. The max context
length is set to 2048 tokens, leaving abundant space for the LLMs to
generate detailed results. Other parameters are kept consistent with
default model settings.

5 EXPERIMENTAL RESULTS We aim to answer the following research questions
through evaluation: • RQ1: How is the performance of LLMs on
specification-related tasks generally? This gives us an overall scenario
for the performance of LLMs on each task. • RQ2: How is the performance
of LLMs against semantic-preserving perturbations? This evaluates the
impact of the perturbations through Counterfactual Analysis. • RQ3: Can
LLMs maintain performance consistency over progressive tasks? It
assesses the consistency of LLMs over different tasks through
Progressive Consistency Analysis.

5.1 RQ1: Overall Performance Table 1 shows the overall performance of
each model on four tasks for all versions of programs (including
original and five perturbed variants). 14 Lezhi Ma, Shangqing Liu, Lei
Bu, Shangru Li, Yida Wang, and Yang Liu

Table 1. Performance of all models on each task and perturbation
category. Acc.: Average Accuracy, AvgPrec.: Average Precision, AvgRec:
Average Recall in percentages. #Pass: the number of programs handled
with all test cases passed. Judgement Selection Infilling Generation
Judgement Selection Infilling Generation Category LLM Category LLM Acc.
Acc. Acc. #Pass AvgPrec. AvgRec. #Pass Acc. Acc. Acc. #Pass AvgPrec.
AvgRec. #Pass GPT-3.5 64.71 67.65 23.53 48 54.05 37.80 79 GPT-3.5 67.65
61.27 27.45 56 53.37 38.47 77 GPT-4 81.37 89.71 11.27 23 32.90 22.75 54
GPT-4 78.92 86.27 14.22 29 24.28 16.91 34 Llama 50.00 30.88 7.84 16
24.01 15.88 21 Def-use Llama 54.41 24.02 5.39 11 20.98 16.02 16 Original
CodeLlama 57.84 29.41 17.65 36 43.70 26.05 61 Break CodeLlama 62.25
28.92 15.69 32 35.32 23.04 43 Deepseek-coder 57.35 61.27 17.65 36 43.38
31.37 55 Deepseek-coder 60.29 59.80 10.29 21 40.79 29.99 46 Magicoder
44.12 39.71 31.86 65 53.22 34.95 67 Magicoder 53.43 45.59 31.86 65 48.44
35.44 54 GPT-3.5 68.14 65.20 22.55 46 42.61 31.26 62 GPT-3.5 66.18 66.18
25.00 51 51.53 39.02 75 GPT-4 77.94 83.82 11.76 24 20.20 14.20 28 GPT-4
79.90 86.27 12.75 26 23.78 18.23 32 If-else Llama 49.51 24.51 8.82 18
28.59 21.71 23 Independent Llama 48.53 22.55 7.84 16 24.53 17.82 20 Flip
CodeLlama 63.24 30.88 13.24 27 38.28 27.79 43 Swap CodeLlama 65.69 35.29
14.71 30 36.26 25.38 42 Deepseek-coder 61.27 57.35 17.16 35 41.79 30.93
55 Deepseek-coder 55.88 59.80 18.14 37 42.07 31.03 55 Magicoder 55.88
50.00 32.35 66 47.33 35.95 53 Magicoder 58.82 43.14 35.29 72 44.35 32.85
52 GPT-3.5 63.24 54.90 24.02 49 48.49 37.16 74 GPT-3.5 68.14 66.67 20.59
42 41.43 30.99 57 GPT-4 76.96 81.37 10.78 22 25.55 18.57 40 GPT-4 76.96
84.31 12.75 26 29.52 21.26 46 Name Llama 56.37 25.00 10.78 22 22.79
16.45 20 Name Llama 49.02 26.96 7.35 15 28.88 19.77 31 Random CodeLlama
59.31 25.00 15.20 31 38.35 25.00 53 Shuffle CodeLlama 59.80 30.39 15.69
32 33.47 24.48 37 Deepseek-coder 55.88 61.27 18.63 38 37.54 28.32 45
Deepseek-coder 59.80 59.31 13.73 28 36.75 28.63 41 Magicoder 60.29 48.04
36.76 75 43.79 34.73 54 Magicoder 63.73 46.08 28.43 58 45.57 35.03 51

5.1.1 Comparison Between Tasks. For different tasks involved in the
experiments, the models showcase different levels of fulfillment. We
take the original category as the example for illustration. For the
Candidate Judgement task, the majority of models can achieve an accuracy
above 50%, with some excelling models achieving relatively high
accuracy, such as the 81.37% of GPT-4. For the Candidate Selection task,
the accuracy of most models shows some decline compared to that of
Judgement (from 57.84% to 29.41% of CodeLlama) or has no significant
variance (from 44.12% to 39.71% of Magicoder). When it comes to the
Specification Infilling task, we can witness a significant drop in the
performance of all models among all categories, ranging from 7.84% of
Llama to 31.86% of Magicoder. As for the Specification Generation task,
the average precision of most models ranges from 24.01% of Llama to
54.05% of GPT-3.5, whereas the average recall is relatively lower,
varying between 15.88% of Llama and 37.80% of GPT-3.5. The low recall of
all LLMs suggests that they can only generate limited specifications
with strength comparable to the ground truth, indicating a relatively
weak ability to summarize full program semantics into the form of formal
specifications. The tasks for the other five categories showcase similar
performance variance patterns as well. According to their performance,
the most straightforward task involved in the experiment is Judgement,
followed by Selection, then Generation, whereas the most challenging
task is Infilling. It is an interesting finding, and to our intuition,
the root cause of this phenomenon lies in the different aspects of
ability that are examined by different tasks. Judgement and Selection
are mainly about reading and understanding (i.e., "input")
specifications, where LLMs try to comprehend given specifications and
give relevant conclusions. On the contrary, Generation is about writing
and expressing (i.e., "output") specifications, where LLMs can freely
articulate code semantics they understand in the form of specifications.
The criteria for successful generation is to pass the verifier. Thus,
the written specifications may not be strong. The tasks mentioned above
examine two opposite aspects of ability concerning specifications.
Interestingly, Infilling lies somewhere in between, where LLMs write
partial specifications but cannot do it at any will. They have to
generate results within the structure defined by the target
specification to fill in, which are usually strong with sufficient
semantic expression. To this end, they have to read and understand the
given specification first; some may be difficult for them, and then,
based on their understanding, write the standard answers. Consequently,
the Infilling task examines both of the two aspects mentioned above
(i.e., "input" and "output") simultaneously, making it the most
difficult task of all. 5.1.2 Comparison Between Models. It can be
observed that different models are specialized in different tasks.
Regarding Judgement, GPT-4 outperforms all other models significantly
with leading accuracy across all categories, followed by GPT-3.5, of
which the accuracy is ranked second in all categories. The three code
LLMs involved in the experiments underperform the GPT family SpecEval:
Evaluating Code Comprehension in Large Language Models via Program
Specifications 15

Table 2. Impact of all types of perturbations concerning different
models and tasks. DUB: Def-use Break. IEF: If-else Flip. IDS:
Independent Swap. NMR: Name Random. NMS: Name Shuffle. 𝐽 𝑗𝑢𝑑 : Jaccard
Distance for Judgement. 𝐽𝑠𝑒𝑙 : Jaccard Distance for Selection. 𝐽𝑖𝑛𝑓 :
Jaccard Distance for Infilling. 𝑣 𝑝𝑟𝑒𝑐 : Average Variance of Precision.
𝑣𝑟𝑒𝑐 : Average Variance of Recall. Model Metric DUB IEF IDS NMR NMS
Overall Model Metric DUB IEF IDS NMR NMS Overall 𝐽 𝑗𝑢𝑑 0.153 0.110 0.065
0.144 0.165 𝐽 𝑗𝑢𝑑 0.323 0.337 0.362 0.358 0.348 𝐽𝑠𝑒𝑙 0.120 0.107 0.101
0.163 0.141 𝐽𝑠𝑒𝑙 0.303 0.263 0.239 0.366 0.277 0.818 0.825 0.860 0.714
0.805 0.535 0.484 0.586 0.594 0.657 GPT-4 0.455 GPT-3.5 0.419 𝐽𝑖𝑛𝑓 𝐽𝑖𝑛𝑓
𝑣 𝑝𝑟𝑒𝑐 0.630 0.699 0.775 0.623 0.719 𝑣 𝑝𝑟𝑒𝑐 0.490 0.499 0.445 0.495
0.527 𝑣𝑟𝑒𝑐 0.518 0.523 0.586 0.460 0.539 𝑣𝑟𝑒𝑐 0.399 0.399 0.345 0.422
0.422 Avg. 0.448 0.453 0.477 0.421 0.474 Avg. 0.410 0.396 0.395 0.447
0.446 𝐽 𝑗𝑢𝑑 0.457 0.496 0.511 0.534 0.493 𝐽 𝑗𝑢𝑑 0.275 0.248 0.250 0.340
0.235 𝐽𝑠𝑒𝑙 0.845 0.798 0.840 0.837 0.854 𝐽𝑠𝑒𝑙 0.413 0.292 0.308 0.458
0.373 0.962 0.828 0.667 0.848 0.852 0.612 0.535 0.500 0.759 0.583 Llama
0.609 CodeLlama 0.409 𝐽𝑖𝑛𝑓 𝐽𝑖𝑛𝑓 𝑣 𝑝𝑟𝑒𝑐 0.536 0.527 0.533 0.538 0.542 𝑣
𝑝𝑟𝑒𝑐 0.500 0.447 0.488 0.455 0.502 𝑣𝑟𝑒𝑐 0.346 0.364 0.349 0.338 0.337
𝑣𝑟𝑒𝑐 0.326 0.339 0.325 0.314 0.345 Avg. 0.629 0.603 0.580 0.619 0.616
Avg. 0.425 0.372 0.374 0.465 0.408 𝐽 𝑗𝑢𝑑 0.389 0.376 0.362 0.396 0.374 𝐽
𝑗𝑢𝑑 0.526 0.563 0.521 0.521 0.523 𝐽𝑠𝑒𝑙 0.236 0.284 0.210 0.252 0.230
𝐽𝑠𝑒𝑙 0.597 0.524 0.580 0.579 0.529 Deepseek 0.643 0.709 0.596 0.679
0.720 0.632 0.511 0.425 0.571 0.570 0.441 Magicoder 0.485 𝐽𝑖𝑛𝑓 𝐽𝑖𝑛𝑓
-Coder 𝑣 𝑝𝑟𝑒𝑐 0.517 0.506 0.488 0.492 0.501 𝑣 𝑝𝑟𝑒𝑐 0.434 0.418 0.452
0.463 0.450 𝑣𝑟𝑒𝑐 0.399 0.426 0.413 0.402 0.422 𝑣𝑟𝑒𝑐 0.319 0.348 0.345
0.355 0.371 Avg. 0.437 0.460 0.414 0.444 0.449 Avg. 0.502 0.473 0.465
0.498 0.489

on this task. Regarding Selection, a similar pattern can be observed
across all categories, where GPT-4 is way ahead, followed by GPT-3.5,
then the three code LLMs. It is also worth noting that Llama and
CodeLlama, two models with the same architecture, suffer from
significant performance declines in Selection tasks compared to
Judgement among all categories. As described in Section 5.1.1, Judgement
and Selection are mainly about reading and understanding specifications.
This indicates that GPT-4 and GPT-3.5 showcase impressive ability
regarding the comprehension of specifications. Nevertheless, the ranking
varies significantly when it comes to the latter two tasks. In terms of
Infilling, the best-performing model is Magicoder, the only model
achieving an accuracy above 30% across 5 out of 6 categories. The
following model is GPT-3.5, another model that can keep an accuracy
above 20% among all categories. Other models demonstrate a relatively
lower performance, with accuracy below 20% in all categories. In terms
of Generation, the leading model is GPT-3.5, with the highest average
precision and recall over 4 out of 6 categories, along with the highest
#Pass over all 6 categories. The second-best model is Magicoder, able to
surpass GPT-3.5 in 2 out of 6 categories concerning precision and
recall. Thus, we can find that, despite the excelling performance of the
closed-source GPT models by OpenAI, it is still possible for open-source
models like Magicoder to achieve comparable or even better performance
with a much smaller model scale under the assistance of fine-tuning with
high-quality code data corpora.

      Answer to RQ1: LLMs showcase a limited ability to articulate program semantics with
      formal specifications. The best-performing task is Judgement, followed by Selection, then
      Generation, and the most challenging task is Infilling. Notably, Magicoder exhibit leading
      performance in Infilling and Generation, indicating the possibility for small-scale LLMs to
      surpass large-scale ones.

5.2 RQ2: Counterfactual Analysis The Jaccard Distances and Average
Variances of different models on different tasks are listed in Table 2.
As described in Section 3.3, both denote the perturbations' impact. A
Higher Jaccard 16 Lezhi Ma, Shangqing Liu, Lei Bu, Shangru Li, Yida
Wang, and Yang Liu

            Table 3. Progressive Consistency Score of each model on all perturbation categories.
                    Model        Original Def-use Break   If-else Flip Independent Swap   Name Random   Name Shuffle
                   GPT-3.5        0.276       0.272         0.263           0.266            0.240         0.237
                    GPT-4         0.262       0.260         0.229           0.248            0.238         0.243
                    Llama         0.124       0.121         0.127           0.120            0.135         0.124
                  CodeLlama       0.169       0.174         0.159           0.182            0.159         0.169
                Deepseek-Coder    0.218       0.193         0.214           0.223            0.208         0.206
                  Magicoder       0.214       0.237         0.249           0.246            0.257         0.238

Distance or Average Variance indicates a higher impact imposed by the
perturbation. Generally, all models exhibit performance variance to
different degrees, indicating that the semantics LLMs learn are
interfered with by the perturbations. It can be observed that the impact
of perturbations varies differently among different tasks, and the
impact tends to be stronger in the tasks where the models underperform.
For instance, as described in Section 5.1, GPT-4 significantly
outperforms all the other models in terms of Judgement and Selection
task, where GPT-4 also possesses the lowest 𝐽 𝑗𝑢𝑑 and 𝐽𝑠𝑒𝑙 , showing
performance consistency over all types of perturbations on these two
tasks. Also, the performance of all models showcases a significant
decline in the Infilling tasks, and correspondingly, the 𝐽𝑖𝑛𝑓 metrics of
all models are also significantly higher than that of other tasks. The
models that perform relatively better in Infilling, such as Magicoder
and GPT-3.5, also showcase stronger resistance against the perturbations
with relatively lower 𝐽𝑖𝑛𝑓 . We further measure the average impact of
different perturbations on each model across 5 tasks. It is calculated
by the average of all impact metrics of each perturbation across 5
tasks. The Avg. row presents the average impact of different
perturbations in Table 2. We can observe that different models are
sensitive to different types of perturbations. For instance, GPT-4 is
sensitive to Independent Swap (i.e., IDS in Table 2) and Name shuffle
(i.e., NMS), with an exceptionally high variance of 0.477 and 0.474 in
these categories. GPT-3.5 is relatively sensitive to Name Random (i.e.,
NMR) and Name shuffle, Deepseek-Coder is relatively weak at If-else Flip
(i.e., IEF), and Magicoder is relatively weak at Def-use Break (i.e.,
DUB). Concerning the average impact on all models, Name Random achieves
the highest average impact of 0.482, followed by Name Shuffle, with an
average impact of 0.480. These two types of perturbations showcase the
most decisive influence on model outputs. The following perturbation is
Def-use Break, with a slightly lower impact of 0.475. The other two
types of perturbation, If-else Flip and Independent Swap, exhibit a
relatively lower impact of 0.460 and 0.451, respectively. We also
calculated the overall impact of all perturbations on each model
(presented in the columns starting with Overall in Table 2). Across all
subject LLMs, CodeLlama showcases minimal performance variance against
all types of perturbations, with the average impact on it being 0.409.
The following model is GPT-3.5, with a slightly higher performance
variance of 0.419. In general, the two leading models exhibit better
resistance against perturbations. Other models demonstrate higher
performance variance and more sensitivity to the perturbations.

      Answer to RQ2: All LLMs exhibit sensitivities of different levels towards the perturbations,
      indicating that perturbations can interfere with the semantics learned. The impact of
      perturbations varies differently among different tasks, with a tendency to be stronger in
      the tasks where the models underperform.

5.3 RQ3: Progressive Consistency Analysis The Progressive Consistency
Scores (PCS) of each model on all perturbation categories are presented
in Table 3. Generally, all LLMs achieve a relatively low PCS under 0.3,
indicating that all LLMs exhibit SpecEval: Evaluating Code Comprehension
in Large Language Models via Program Specifications 17

limited consistency between the tasks involved in the experiments.
Considering the relatively low performance of all subject LLMs on the
third task Infilling mentioned in Section 5.1, this phenomenon is
reasonable. Underperformance on the third task indicates that LLMs can
only solve at most two tasks in a row for the majority of programs. The
model exhibiting the highest consistency is GPT-3.5, with an average PCS
above 0.25 among 4 out of 6 categories. The following model is GPT-4,
with a small step behind GPT-3.5 in terms of PCS. The PCS of the above
two models is around 0.25, indicating that most of the programs succeed
in handling two tasks consecutively. Deepseek-Coder and Magicoder form
the second tier, both achieving an average PCS above 0.2 in most
categories. Llama and CodeLlama achieve a relatively lower PCS below
0.2, exhibiting the least consistency among all models. This observation
shows that code LLMs do not necessarily exhibit better progressive
consistency than general LLMs, despite their performance on each task
mentioned in Section 5.1. Since GPT-4 and GPT-3.5 are closed-source
commercial LLMs trained with larger model scale and possibly more
immense data corpora, they exhibit better text comprehension and logical
reasoning abilities, which can be leveraged in our tasks, especially the
first task Judgement and the second task Selection. This leads to the
solid and excelling performance of these two models on the former two
tasks, guaranteeing a stable PCS above 0.25. Despite the impressive
abilities showcased by open-source models such as Magicoder in the
latter two tasks, Infilling and Generation, the tasks are relatively
more challenging and cannot be easily handled in a row. Limited
Progressive Consistency Scores can be earned through them, eventually
leading to the gap behind GPT-4 and GPT-3.5. In terms of consistency
across different categories, we can witness declines within 3\~4 out of
6 models for each perturbed category compared to Original category, but
usually not significant. Nevertheless, in the perturbations with the
strongest impact, i.e., Name Random and Name Shuffle, we can witness
some decline in the consistency of GPT-3.5 and GPT-4. However, Magicoder
achieves its highest PCS in Name Random across all categories,
indicating that the impact of perturbations on the performance
consistency varies across different models.

      Answer to RQ3: The LLMs exhibit limited progressive consistency, indicating that they
      are not reasoning in a progressive manner (top-down or bottom-up) as humans do. GPT-4
      and GPT-3.5 showcase a relatively better consistency due to their excelling performance in
      Judgement and Selection tasks. Future research remains focused on enhancing the perfor-
      mance of LLMs in tasks involving continuous and contextually linked reasoning.

6 DISCUSSION 6.1 Implication The potential implications of this work
cover a list of areas. Concerning the Evaluations on LLMs,
semantic-preserving perturbations are proved to have a non-negligible
impact on the performance of LLMs, which is worth attention when
designing further benchmarks or evaluation frameworks. The resistance
against perturbations should also be emphasized when developing new
language models. Regarding Code Comprehension with LLMs, the assistance
of program specifications in natural language or formal languages
deserves to be noted. In terms of Code Completion and Generation with
LLMs, the possibility can be explored concerning the utilization of
specifications to assist the quality assurance of LLM-generated code.
Concerning the Software Development process, the importance of all types
of specifications (including documents and comments) should not be
overlooked since they convey rich information about code and improve its
readability and maintainability. As for Education, it is possible that
program specifications in natural or formal languages can assist
students in understanding example code during the teaching process. 18
Lezhi Ma, Shangqing Liu, Lei Bu, Shangru Li, Yida Wang, and Yang Liu

6.2 Greedy Decoding for Model Generation Following previous works \[17,
33, 34\], we adopted greedy decoding (top_k=1 and temperature=0) for all
subject LLMs in the experiments. This is to guarantee the determinism in
the sampling process of LLMs and the reproducibility of the final
results. Nevertheless, some research within the same domain \[11, 22\]
adopted random sampling for evaluation, which is also a choice.
Currently, research has emerged to compare the performance of LLMs under
greedy decoding and other decoding strategies. Cobbe et al. \[14\] and
Hendrycks et al. \[25\] show that greedy decoding is preferred when math
reasoning problems are to solve. Song et al. \[53\] claim that greedy
decoding is generally more effective for most tasks, especially
reasoning tasks and coding problems. Since the specification-related
tasks involved in this work are generally about reasoning and
formulating formal statements, greedy decoding tends to be the more
suitable choice.

6.3 Threats to Validity Internal Threats. First, experimental results
may be affected by the prompts utilized to communi- cate with LLMs. We
follow the prompt structure of Chen et al. \[11\] when designing the
prompts. The effect of prompt strategies on the model performance will
be studied in future works. Second, the base datasets, based on which we
formulate the adapted benchmark, face potential data leakage when using
the LLMs for evaluation. For programs in Frama-C-Problems \[21\] and
SV-COMP \[54\], the ground-truth JML specifications involved are
manually crafted by experts without risks of data leakage. As for
SpecGenBench \[38\], the dataset was publicly released in March 2024,
whereas the versions of models we adopted were all released prior to
this point in time. Thus, using our selected LLMs for evaluation is
without data leakage issues. However, if the selected models are after
March 2024, there may be potential data leakage risks if the data is
used for training. External Threats. The potential threat lies in the
specification verifier. OpenJML \[15\] provides static verification and
runtime checking for validation. Static verification requires sufficient
support- ing information (i.e., other strong specifications) and fails
easily if not given enough, introducing serious bias. Therefore, runtime
checking, with more stability and reliability, is adopted instead.

7 CONCLUSION In this paper, we present SpecEval, a novel black-box
framework evaluating the code comprehen- sion ability in Large Language
Models via program specifications. Leveraging the feature that
specifications cover abundant execution traces and rich semantic
information, we adopt them as an effective representation of program
semantics. Four specification-related tasks with sequen- tial
dependencies are designed to assess the performance of LLMs.
Counterfactual Analysis and Progressive Consistency Analysis are adopted
to analyze the performance consistency of LLMs over different
dimensions. Experimental results show that LLMs showcase a limited
ability to fully articulate program semantics with formal
specifications. Counterfactual Analysis and Progressive Consistency
Analysis also reveal the inconsistency in their performance over
different dimensions.

REFERENCES \[1\] Josh Achiam, Steven Adler, Sandhini Agarwal, Lama
Ahmad, Ilge Akkaya, Florencia Leoni Aleman, Diogo Almeida, Janko
Altenschmidt, Sam Altman, Shyamal Anadkat, et al. Gpt-4 technical
report. arXiv preprint arXiv:2303.08774, 2023. \[2\] Wolfgang Ahrendt,
Bernhard Beckert, Daniel Bruns, Richard Bubel, Christoph Gladisch, Sarah
Grebing, Reiner Hähnle, Martin Hentschel, Mihai Herda, Vladimir
Klebanov, et al. The key platform for verification and analysis of java
programs. In Verified Software: Theories, Tools and Experiments: 6th
International Conference, VSTTE 2014, Vienna, Austria, July 17-18, 2014,
Revised Selected Papers 6, pages 55--71. Springer, 2014. \[3\] Meta AI.
Llama3.1, 2024. https://llama.meta.com/. SpecEval: Evaluating Code
Comprehension in Large Language Models via Program Specifications 19

\[4\] Hannani Aman and Rosziati Ibrahim. Reverse engineering: from xml
to uml for generation of software requirement specification. In 2013 8th
International Conference on Information Technology in Asia (CITA), pages
1--6. IEEE, 2013. \[5\] Jacob Austin, Augustus Odena, Maxwell Nye,
Maarten Bosma, Henryk Michalewski, David Dohan, Ellen Jiang, Carrie Cai,
Michael Terry, Quoc Le, et al. Program synthesis with large language
models. arXiv preprint arXiv:2108.07732, 2021. \[6\] Anonymous
Author(s). Speceval, 2024. https://sites.google.com/view/speceval/.
\[7\] Patrick Baudin, Jean-Christophe Filliâtre, Claude Marché, Benjamin
Monate, Yannick Moy, and Virgile Prevosto. Acsl: Ansi c specification
language. CEA-LIST, Saclay, France, Tech. Rep. v1, 2, 2008. \[8\] Dirk
Beyer, Matthias Dangl, and Philipp Wendler. Boosting k-induction with
continuously-refined invariants. In International Conference on Computer
Aided Verification, pages 622--640. Springer, 2015. \[9\] Xiao Bi, Deli
Chen, Guanting Chen, Shanhuang Chen, Damai Dai, Chengqi Deng, Honghui
Ding, Kai Dong, Qiushi Du, Zhe Fu, et al. Deepseek llm: Scaling
open-source language models with longtermism. arXiv preprint
arXiv:2401.02954, 2024. \[10\] Gianpiero Cabodi, Sergio Nocco, and
Stefano Quer. Strengthening model checking techniques with inductive
invariants. IEEE transactions on computer-aided design of integrated
circuits and systems, 28(1):154--158, 2008. \[11\] Junkai Chen, Zhiyuan
Pan, Xing Hu, Zhenhao Li, Ge Li, and Xin Xia. Evaluating large language
models with runtime behavior of program execution. arXiv preprint
arXiv:2403.16437, 2024. \[12\] Mark Chen, Jerry Tworek, Heewoo Jun,
Qiming Yuan, Henrique Ponde De Oliveira Pinto, Jared Kaplan, Harri
Edwards, Yuri Burda, Nicholas Joseph, Greg Brockman, et al. Evaluating
large language models trained on code. arXiv preprint arXiv:2107.03374,
2021. \[13\] Siheng Chen, Rohan Varma, Aliaksei Sandryhaila, and Jelena
Kovačević. Discrete signal processing on graphs: Sampling theory\<? pub
\_newline=""? IEEE transactions on signal processing, 63(24):6510--6523,
2015. \[14\] Karl Cobbe, Vineet Kosaraju, Mohammad Bavarian, Mark Chen,
Heewoo Jun, Lukasz Kaiser, Matthias Plappert, Jerry Tworek, Jacob
Hilton, Reiichiro Nakano, et al. Training verifiers to solve math word
problems. arXiv preprint arXiv:2110.14168, 2021. \[15\] David R Cok.
Openjml: Jml for java 7 by extending openjdk. In NASA Formal Methods:
Third International Symposium, NFM 2011, Pasadena, CA, USA, April 18-20,
2011. Proceedings 3, pages 472--479. Springer, 2011. \[16\] Yinlin Deng,
Chunqiu Steven Xia, Chenyuan Yang, Shizhuo Dylan Zhang, Shujing Yang,
and Lingming Zhang. Large language models are edge-case generators:
Crafting unusual programs for fuzzing deep learning libraries. In 2024
IEEE/ACM 46th International Conference on Software Engineering (ICSE),
pages 830--842. IEEE Computer Society, 2023. \[17\] Xueying Du, Mingwei
Liu, Kaixin Wang, Hanlin Wang, Junwei Liu, Yixuan Chen, Jiayi Feng,
Chaofeng Sha, Xin Peng, and Yiling Lou. Evaluating large language models
in class-level code generation. In Proceedings of the IEEE/ACM 46th
International Conference on Software Engineering, pages 1--13, 2024.
\[18\] Michael D Ernst, Jeff H Perkins, Philip J Guo, Stephen McCamant,
Carlos Pacheco, Matthew S Tschantz, and Chen Xiao. The daikon system for
dynamic detection of likely invariants. Science of computer programming,
69(1-3):35--45, 2007. \[19\] Cormac Flanagan and K Rustan M Leino.
Houdini, an annotation assistant for esc/java. In International
Symposium of Formal Methods Europe, pages 500--517. Springer, 2001.
\[20\] Github. Github copilot · your ai pair programmer, 2024.
https://github.com/features/copilot. \[21\] github. Frama-c. a
repository dedicated to problems related to verification of programs
using the tool frama-c, 2024.
https://github.com/manavpatnaik/frama-c-problems. \[22\] Alex Gu,
Baptiste Rozière, Hugh Leather, Armando Solar-Lezama, Gabriel Synnaeve,
and Sida I Wang. Cruxeval: A benchmark for code reasoning, understanding
and execution. arXiv preprint arXiv:2401.03065, 2024. \[23\] Daya Guo,
Qihao Zhu, Dejian Yang, Zhenda Xie, Kai Dong, Wentao Zhang, Guanting
Chen, Xiao Bi, Yu Wu, YK Li, et al. Deepseek-coder: When the large
language model meets programming--the rise of code intelligence. arXiv
preprint arXiv:2401.14196, 2024. \[24\] Shirley Anugrah Hayati, Raphael
Olivier, Pravalika Avvaru, Pengcheng Yin, Anthony Tomasic, and Graham
Neubig. Retrieval-based neural code generation. arXiv preprint
arXiv:1808.10025, 2018. \[25\] Dan Hendrycks, Collin Burns, Saurav
Kadavath, Akul Arora, Steven Basart, Eric Tang, Dawn Song, and Jacob
Steinhardt. Measuring mathematical problem solving with the math
dataset. arXiv preprint arXiv:2103.03874, 2021. \[26\] José Antonio
Hernández López, Martin Weyssow, Jesús Sánchez Cuadrado, and Houari
Sahraoui. Ast-probe: Recovering abstract syntax trees from hidden
representations of pre-trained language models. In Proceedings of the
37th IEEE/ACM International Conference on Automated Software
Engineering, pages 1--11, 2022. \[27\] Ashish Hooda, Mihai
Christodorescu, Miltos Allamanis, Aaron Wilson, Kassem Fawaz, and Somesh
Jha. Do large code models understand programming concepts? a black-box
approach. arXiv preprint arXiv:2402.05980, 2024. \[28\] HuggingFace.
Hugging face -- the ai community building the future., 2024.
https://huggingface.co/. \[29\] JeyBrains. Jetbrains ai service and
in-ide ai assistant, 2024. https://www.jetbrains.com/ai/. 20 Lezhi Ma,
Shangqing Liu, Lei Bu, Shangru Li, Yida Wang, and Yang Liu

\[30\] Carlos E Jimenez, John Yang, Alexander Wettig, Shunyu Yao, Kexin
Pei, Ofir Press, and Karthik Narasimhan. Swe-bench: Can language models
resolve real-world github issues? arXiv preprint arXiv:2310.06770, 2023.
\[31\] Florent Kirchner, Nikolai Kosmatov, Virgile Prevosto, Julien
Signoles, and Boris Yakobowski. Frama-c: A software analysis
perspective. Formal aspects of computing, 27(3):573--609, 2015. \[32\]
Gary T Leavens, Albert L Baker, and Clyde Ruby. Jml: a java modeling
language. In Formal Underpinnings of Java Workshop (at OOPSLA'98), pages
404--420. Citeseer, 1998. \[33\] Changshu Liu, Shizhuo Dylan Zhang, and
Reyhaneh Jabbarvand. Codemind: A framework to challenge large language
models for code reasoning. arXiv preprint arXiv:2402.09664, 2024. \[34\]
Jiawei Liu, Chunqiu Steven Xia, Yuyao Wang, and Lingming Zhang. Is your
code generated by chatgpt really correct? rigorous evaluation of large
language models for code generation. arXiv preprint arXiv:2305.01210,
2023. \[35\] Jiawei Liu, Chunqiu Steven Xia, Yuyao Wang, and Lingming
Zhang. Is your code generated by chatgpt really correct? rigorous
evaluation of large language models for code generation. Advances in
Neural Information Processing Systems, 36, 2024. \[36\] David Lo and
Siau-Cheng Khoo. Quark: Empirical assessment of automaton-based
specification miners. In 2006 13th Working Conference on Reverse
Engineering, pages 51--60. IEEE, 2006. \[37\] Anton Lozhkov, Raymond Li,
Loubna Ben Allal, Federico Cassano, Joel Lamy-Poirier, Nouamane Tazi, Ao
Tang, Dmytro Pykhtar, Jiawei Liu, Yuxiang Wei, et al. Starcoder 2 and
the stack v2: The next generation. arXiv preprint arXiv:2402.19173,
2024. \[38\] Lezhi Ma, Shangqing Liu, Yi Li, Xiaofei Xie, and Lei Bu.
Specgen: Automated generation of formal program specifications via large
language models. arXiv preprint arXiv:2401.08807, 2024. \[39\] Wei Ma,
Shangqing Liu, Mengjie Zhao, Xiaofei Xie, Wenhang Wang, Qiang Hu, Jie
Zhang, and Yang Liu. Unveiling code pre-trained models: Investigating
syntax and semantics capacities. ACM Transactions on Software
Engineering and Methodology. \[40\] Paul W McBurney and Collin McMillan.
Automatic source code summarization of context for java methods. IEEE
Transactions on Software Engineering, 42(2):103--119, 2015. \[41\] Ali
Mesbah, Arie van Deursen, and Danny Roest. Invariant-based automatic
testing of modern web applications. IEEE Transactions on Software
Engineering, 38(1):35--53, 2012. doi: 10.1109/TSE.2011.28. \[42\]
Thi-Hanh Nguyen and Duc-Hanh Dang. Tc4mt: A specification-driven testing
framework for model transformations. International Journal of Software
Engineering and Knowledge Engineering, pages 1--39, 2023. \[43\] Erik
Nijkamp, Hiroaki Hayashi, Caiming Xiong, Silvio Savarese, and Yingbo
Zhou. Codegen2: Lessons for training llms on programming and natural
languages. arXiv preprint arXiv:2305.02309, 2023. \[44\] Amirfarhad
Nilizadeh, Gary T. Leavens, Xuan-Bach Le, Corina S. Pasareanu, and David
Cok. Exploring true test overfitting in dynamic automated program repair
using formal methods (in press). In 2021 14th IEEE Conference on
Software Testing, Validation and Verification (ICST). IEEE, 2021. \[45\]
OpenAI. Gpt-3.5, 2023. https://platform.openai.com/docs/models/gpt-3-5.
\[46\] OpenAI. Openai, 2024. https://openai.com/. \[47\] OpenAI. Api
reference - openai api, 2024.
https://platform.openai.com/docs/api-reference. \[48\] Dinglan Peng,
Shuxin Zheng, Yatao Li, Guolin Ke, Di He, and Tie-Yan Liu. How could
neural networks understand programs? In International Conference on
Machine Learning, pages 8476--8486. PMLR, 2021. \[49\] Gordon D Plotkin.
A structural approach to operational semantics. 1981. \[50\] Baptiste
Roziere, Jonas Gehring, Fabian Gloeckle, Sten Sootla, Itai Gat, Xiaoqing
Ellen Tan, Yossi Adi, Jingyu Liu, Tal Remez, Jérémy Rapin, et al. Code
llama: Open foundation models for code. arXiv preprint arXiv:2308.12950,
2023. \[51\] Sepehr Sharifi, Alireza Parvizimosaed, Daniel Amyot, Luigi
Logrippo, and John Mylopoulos. Symboleo: Towards a specification
language for legal contracts. In 2020 IEEE 28th international
requirements engineering conference (RE), pages 364--369. IEEE, 2020.
\[52\] Sharon Shoham, Eran Yahav, Stephen Fink, and Marco Pistoia.
Static specification mining using automata-based abstractions. In
Proceedings of the 2007 International Symposium on Software Testing and
Analysis, pages 174--184, 2007. \[53\] Yifan Song, Guoyin Wang, Sujian
Li, and Bill Yuchen Lin. The good, the bad, and the greedy: Evaluation
of llms should not ignore non-determinism. arXiv preprint
arXiv:2407.10457, 2024. \[54\] sosy lab. Sv-comp - international
competition on software verification, 2024.
https://sites.google.com/view/specgen. \[55\] Raymond Hendy Susanto and
Wei Lu. Semantic parsing with neural hybrid trees. In Proceedings of the
AAAI Conference on Artificial Intelligence, volume 31, 2017. \[56\] Hugo
Touvron, Louis Martin, Kevin Stone, Peter Albert, Amjad Almahairi,
Yasmine Babaei, Nikolay Bashlykov, Soumya Batra, Prajjwal Bhargava,
Shruti Bhosale, et al. Llama 2: Open foundation and fine-tuned chat
models. arXiv preprint arXiv:2307.09288, 2023. \[57\] A Vaswani.
Attention is all you need. Advances in Neural Information Processing
Systems, 2017. SpecEval: Evaluating Code Comprehension in Large Language
Models via Program Specifications 21

\[58\] Sahil Verma, John Dickerson, and Keegan Hines. Counterfactual
explanations for machine learning: A review. arXiv preprint
arXiv:2010.10596, 2:1, 2020. \[59\] Yao Wan, Wei Zhao, Hongyu Zhang,
Yulei Sui, Guandong Xu, and Hai Jin. What do they capture? a structural
analysis of pre-trained language models for source code. In Proceedings
of the 44th International Conference on Software Engineering, pages
2377--2388, 2022. \[60\] Yuxiang Wei, Zhe Wang, Jiawei Liu, Yifeng Ding,
and Lingming Zhang. Magicoder: Source code is all you need. arXiv
preprint arXiv:2312.02120, 2023. \[61\] Cheng Wen, Jialun Cao, Jie Su,
Zhiwu Xu, Shengchao Qin, Mengda He, Haokun Li, Shing-Chi Cheung, and
Cong Tian. Enchanting program specification synthesis by large language
models using static analysis and program verification. In International
Conference on Computer Aided Verification, pages 302--328. Springer,
2024. \[62\] Zonghan Wu, Shirui Pan, Fengwen Chen, Guodong Long, Chengqi
Zhang, and S Yu Philip. A comprehensive survey on graph neural networks.
IEEE transactions on neural networks and learning systems, 32(1):4--24,
2020. \[63\] Chunqiu Steven Xia, Matteo Paltenghi, Jia Le Tian, Michael
Pradel, and Lingming Zhang. Universal fuzzing via large language models.
arXiv preprint arXiv:2308.04748, 2023. \[64\] Zhou Yang, Zhipeng Zhao,
Chenyu Wang, Jieke Shi, Dongsun Kim, Donggyun Han, and David Lo.
Unveiling memorization in code models. In Proceedings of the IEEE/ACM
46th International Conference on Software Engineering, pages 1--13,
2024. \[65\] Yong Yu, Xiaosheng Si, Changhua Hu, and Jianxun Zhang. A
review of recurrent neural networks: Lstm cells and network
architectures. Neural computation, 31(7):1235--1270, 2019. \[66\] Jian
Zhang, Xu Wang, Hongyu Zhang, Hailong Sun, and Xudong Liu.
Retrieval-based neural source code summarization. In Proceedings of the
ACM/IEEE 42nd International Conference on Software Engineering, pages
1385--1397, 2020. \[67\] Yaqin Zhou, Shangqing Liu, Jingkai Siow,
Xiaoning Du, and Yang Liu. Devign: Effective vulnerability
identification by learning comprehensive program semantics via graph
neural networks. Advances in neural information processing systems, 32,
2019. 
