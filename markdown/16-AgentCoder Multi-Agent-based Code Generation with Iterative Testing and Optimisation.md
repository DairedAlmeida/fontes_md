                                                             AgentCoder: Multi-Agent-based Code Generation with
                                                                     Iterative Testing and Optimisation
                                                   Dong Huang1 , Qingwen Bu2 , Jie M. Zhang3 , Michael Luck4 and Heming Cui1
                                                                          1
                                                                            The University of Hong Kong
                                                                         2
                                                                           Shanghai Jiao Tong University
                                                                             3
                                                                               King’s College London
                                                                               4
                                                                                 University of Sussex
                                                    {dhuang, heming}@cs.hku.hk, qwbu01@sjtu.edu.cn, jie.zhang@kcl.ac.uk,
                                                                          Michael.Luck@sussex.ac.uk

arXiv:2312.13010v1 \[cs.CL\] 20 Dec 2023

                                                                 Abstract                              for these LLMs is code generation for downstream tasks,
                                                                                                       where they play a vital role in aiding developers in creat-
                                             The advancement of natural language processing
                                                                                                       ing software [Feng et al., 2020; Wang et al., 2021; Wang
                                             (NLP) has been significantly boosted by the devel-
                                                                                                       et al., 2023b; Nijkamp et al., 2023b; Nijkamp et al., 2023a;
                                             opment of transformer-based large language mod-
                                                                                                       Li et al., 2023b]. Through extensive pretraining on substan-
                                             els (LLMs). These models have revolutionized
                                                                                                       tial code-related datasets, such as publicly available data on
                                             NLP tasks, particularly in code generation, aiding
                                                                                                       GitHub, these code LLMs acquire intricate contextual un-
                                             developers in creating software with enhanced ef-
                                                                                                       derstanding that can be effectively applied to diverse code-
                                             ficiency. Despite their advancements, challenges
                                                                                                       related tasks.
                                             in balancing code snippet generation with effec-
                                             tive test case generation and execution persist. To          In recent times, numerous efforts have been made to im-
                                             address these issues, this paper introduces Multi-        prove the effectiveness of code generation models by incor-
                                             Agent Assistant Code Generation (AgentCoder),             porating in-context learning and its variations [Wang et al.,
                                             a novel solution comprising a multi-agent frame-          2022; Dong et al., 2023b; Wei et al., 2022; Le et al., 2023;
                                             work with specialized agents: the programmer              Huang et al., 2023; Zhang et al., 2023b; Chen et al., 2023b;
                                             agent, the test designer agent, and the test execu-       Madaan et al., 2023], where an important optimization path
                                             tor agent. During the coding procedure, the pro-          is self-refinement. For example, Zhang et al. proposed Self-
                                             grammer agent will focus on the code generation           Edit to enhance the performance of LLMs in code generation.
                                             and refinement based on the test executor agent’s         In particular, Self-Edit runs the code generation model’s gen-
                                             feedback. The test designer agent will generate test      erated code against test cases that are manually written by
                                             cases for the generated code, and the test executor       developers. If the function fails to pass these test cases, Self-
                                             agent will run the code with the test cases and write     Edit prompts the code generation model to refine the function
                                             the feedback to the programmer. This collaborative        using the provided error messages with its fault-aware code
                                             system ensures robust code generation, surpassing         editor. Nevertheless, Self-Edit requires that developers write
                                             the limitations of single-agent models and tradi-         test cases to verify the correctness of the generated function.
                                             tional methodologies. Our extensive experiments           This requirement can be particularly demanding and chal-
                                             on 9 code generation models and 12 enhancement            lenging for users who lack expertise in the specific domain,
                                             approaches showcase AgentCoder’s superior per-            which potentially impedes the effectiveness of the self-editing
                                             formance over existing code generation models             process.
                                             and prompt engineering techniques across various             To overcome this challenge, Huang et al. introduced Code-
                                             benchmarks. For example, AgentCoder achieves              CoT, which adopts a step-by-step strategy for code genera-
                                             77.4% and 89.1% pass@1 in HumanEval-ET and                tion, tasking the code generation model to generate both the
                                             MBPP-ET with GPT-3.5, while SOTA baselines                function and the corresponding test cases. CodeCoT also es-
                                             obtain only 69.5% and 63.0%.                              tablishes a connection with a terminal interface, instructing
                                                                                                       the code generation model to self-refine the code based on
                                                                                                       the error messages returned by the terminal. This approach
                                         1   Introduction                                              not only reduces the burden on developers in terms of writing
                                         In recent years, the landscape of natural language process-   test cases but also ensures that the generated code undergoes
                                         ing (NLP) has been dramatically transformed by transformer-   software testing and refinement.
                                         based large language models (LLMs). These models, no-            Although CodeCoT makes substantial strides in enhanc-
                                         tably exemplified by the GPT-x series [Brown et al., 2020b;   ing the effectiveness of code generation models, the tests and
                                         OpenAI, 2023] developed by OpenAI, have consistently set      code are generated within the same conversation. In other
                                         the benchmark for performance across a wide array of stan-    words, the code generation and test generation processes are
                                         dard NLP tasks. One of the most pivotal applications          not independent. This practice brings constraints that arise

from the potential trade-off between excelling in code gen- tion but
also fortifies the overall testing process. AgentCoder, eration and
maintaining the effectiveness of test case gener- therefore, markedly
advances code generation effectiveness ation: as the model achieves high
performance in generat- across various software development scenarios.
Addition- ing code snippets, there may be a corresponding decrease in
ally, its modular design provides the flexibility and scalability the
effectiveness of test case generation \[Chen et al., 2023a; crucial for
adapting to technological advancements. Agents Zhang et al., 2023a\].
This trade-off scenario occurs due to within AgentCoder can be
individually updated or replaced the model's limited resources and its
focus on optimizing with more sophisticated models, maintaining the
framework's one aspect of the code generation process, which might in-
technological edge. This adaptability positions AgentCoder advertently
compromise the quality of other tasks \[Chen et as a robust and evolving
solution in the ever-changing land- al., 2023a; Zhang et al., 2023a\].
In addition, the tests gener- scape of software development. ated
immediately following the code in one conversation can Our main
contributions are as follows: be biased and affected by the code, losing
objectivity and di- • We propose AgentCoder, a novel multi-agent
framework versity in the testing (See Tab. 5). for code generation that
contains three agents, i.e., the In this paper, we address the
above-mentioned problems programmer agent, the test designer agent, and
the test by proposing Multi-Agent-based Code Generation, namely executor
agent. AgentCoder. AgentCoder contains three different agents, i.e., the
programmer agent, the test designer agent, and the test ex- • We conduct
extensive evaluation which demonstrates ecutor agent. The programmer
agent interacts with advanced that AgentCoder outperforms SOTA
strategies. For ex- code generation models to create code based on
coding re- ample, AgentCoder obtains 77.4% and 89.1% pass@1 quirements.
The test designer agent designs diverse and com- in HumanEval-ET and
MBPP-ET datasets, while SOTA prehensive test cases with code generation
models indepen- baselines obtain only 69.5% and 63.0%. dently based on
the coding requirements. The test executor • Our framework's modular
design offers adaptability and agent interacts with both the programmer
agent and the test scalability, allowing for future enhancements and
inte- designer agent: it executes the tests from the test designer
gration with advanced models, positioning AgentCoder agent against the
code generated by the programmer agent as a resilient solution in the
evolving landscape of auto- and then provides test execution results to
the programmer mated code generation. agent. Once the feedback is
obtained by the test executor agent from the local environment (i.e.,
local terminal), it will 2 Related Work check whether the feedback
contains error information (e.g., runtime error and assertion error). If
all test cases pass the 2.1 Large Language Model for Code Generation
generated code, the test executor agent will report the code Recently,
large language models have been widely used in snippets to the human
developer, else the test executor agent code generation tasks. Various
architectures have been ex- will feed the feedback to the programmer
agent and then re- plored in these models, some notable examples being
Code- quire it to fix the bug reported in the feedback. Then the it-
BERT \[Feng et al., 2020\], PLBART \[Ahmad et al., 2021\], eration will
continue once the feedback is all test cases pass and CodeGPT \[Zan et
al., 2022\]. These models are pre- the code snippets or the iteration
budget is done, and then the trained on code corpora to develop a deep
understanding of code snippets will report to the human developer even
if the code syntax, semantics, and idiomatic constructs. Some in- code
is still buggy. novative approaches integrate structured representations
to Our extensive experiments with 9 code generation mod- enhance their
comprehension of the complexities in code. els and 12 enhancement
approaches demonstrate that Agent- For example, GraphCodeBERT \[Guo et
al., 2020\] incorpo- Coder significantly improves the effectiveness of
existing rates graph-based representations, while CodeT5+ \[Wang et code
generation models, outperforming all the baseline ap- al., 2023b\]
combines the encoder-decoder paradigm with the proaches. In particular,
AgentCoder obtains an average of structural essence of code. These
enhancements aim to give 91.5% / 84.1% pass@1 on all the datasets with
GPT-4 / GPT- the models a more fine-grained understanding of code rela-
3.5, while the state-of-the-arts obtain only 75.5% / 75.3%. On tionships
and dependencies beyond just syntactic patterns. A HumanEval-ET and
MBPP-ET, AgentCoder obtains 77.4% current trend is the construction of
large-scale models (e.g., and 89.1% pass@1, while SOTA baselines obtain
only 69.5% Codex \[Chen et al., 2021b\] and CodeGen \[Nijkamp et al.,
and 63.0%. 2023b\]) with billions of parameters, which have illustrated
The effectiveness of AgentCoder hinges on the collabo- the performance
of SOTA in code generation tasks. Another rative synergy between its
agents. The programmer agent way is to directly use foundation models
(e.g., GPT-3.5-turbo, excels in crafting quality code snippets, while
the test de- GPT-4) to generate code functions, which have been evalu-
signer agent designs varied and challenging test cases. The ated for
their effectiveness in generating functional code. test executor agent
critically evaluates the code using these test cases, ensuring both
functionality and reliability. Such 2.2 Enhancing Code Generation
through collaboration fosters a dynamic feedback loop, facilitating
Self-Refinement progressive enhancements. AgentCoder overcomes the con-
Recent advancements in code generation have led to the de- straints
inherent in single-agent code generation models by velopment of
innovative methods that aim to enhance the allocating distinct tasks to
different agents. This division not quality and reliability of code
produced by Large Language only balances the focus between code and test
case genera- Models (LLMs). A notable contribution in this realm is the
concept of self-refinement, as proposed by Madaan et al.. code to the
user and finish the iteration. Otherwise, the test This approach
involves the LLM iteratively refining its own executor agent will return
the test execution error messages to generated code, leading to
significant improvements in code the programmer agent The iteration then
continues, with the quality. Another approach is the Self-Debugging
technique programmer agent regenerating code snippets to address the
introduced by Chen et al.. This method involves testing the issues
identified in the feedback, and the test executor agent generated code
against user-provided test cases. In scenar- re-executes the new code
and provides new feedback to the ios where such test cases are
unavailable, the model engages programmer agent, until the test executor
agent finds that the in direct debugging by explaining the code, thus
addressing code passes all the tests. potential issues. Complementing
these methods, Huang et al. introduced CodeCoT, employing a Self-Exam
Chain of 3.2 Programmer agent: code completion with Thought (CoT)
process. This technique guides the model to Chain-of-Thought instruction
generate code alongside test cases, particularly useful when In our
framework, The programmer agent is powered by external test cases are
not available. CodeCoT adds an addi- LLMs. It needs to consider two
scenarios, i.e., code gener- tional layer of logical reasoning to the
code generation pro- ation and code refinement. Specifically, as shown
in Fig. 1, cess. However, it's important to note that while this method
during the code generation stage, the human developer will can identify
syntax errors, functional errors may still go un- require the programmer
agent to generate code snippets to detected as both the code and its
test cases are generated by complete specific tasks, the programmer
agent employs a the same model. Building upon these concepts, \[Dong et
al., Chain-of-Thought approach to simulate the typical program- 2023b\]
proposed the Self-Collaboration model, which divides ming process,
methodically breaking down the task into the LLM's role into three
distinct agents: an analyst, a coder, smaller, manageable steps. The
Chain-of-Thought process is and a tester. This model uniquely focuses on
analyzing the instructed to contain four steps, i.e., program
definition, ap- code by feeding it directly into the tester component.
How- proach selection, pseudocode creation, and code generation. ever, a
potential limitation arises as the tester, being the same Take coding
task Check if in given list of numbers, are any LLM as the coder, might
erroneously assess erroneous code two numbers closer to each other than
given threshold as an as correct. example, during the initial code
generation, the programmer agent will try to understand and clarify the
given task. In this 2.3 Multi-agent Collaboration case, interpreting the
requirement to identify pairs of numbers A multi-agent system (MAS) is a
framework where multiple in a list that are within a specified threshold
of each other. autonomous agents interact with each other. These agents,
Then, the programmer agent will decide on an algorithm or which can be
software programs or robots, operate in a shared method to solve the
problem. This could involve choosing environment and can communicate,
cooperate, compete, or an efficient way to compare each pair of numbers
in the list. negotiate with one another. Each agent in a multi-agent
sys- Next, during the pseudocode creation stage, the programmer tem has
its own capabilities, goals, and perceptions, and they agent will
develop a step-by-step guide or pseudocode for the work either
independently or together to achieve complex solution, ensuring a
logical flow of operations. Finally, in the goals or solve problems.
code generation stage, the programmer agent will translate The
integration of LLMs within multi-agent collaboration the pseudocode into
executable code in the desired program- systems represents a
cutting-edge area of research in deep ming language. learning community.
For example, HuggingFace proposes Since code snippets generated by the
programmer agent HuggingGPT to solve complex AI tasks with HuggingFace
may sometimes contain errors, such as syntax or runtime er- models.
Zhang et al. propose ProAgent to address robotic rors, these issues can
prevent the test cases from being fully tasks by analyze the current
context, anticipate teammates' passed during validation. To address
these errors, the feed- intentions and formulate its own strategies
based on the above back, along with the code requirements, is fed back
to the reasoning. Chen et al. propose VisualGPT to utilize vision
programmer agent. The feedback will then require the pro- PLM to address
image captioning tasks. grammer agent to regenerate and refine the code
snippets, thereby improving the original code. The refinement process 3
Methodology is iterative, similar to the first time's four steps in the
code generation, with the programmer agent continuously enhanc- 3.1
Overview ing the code based on feedback until it meets the necessary The
framework of AgentCoder and its pipeline are illus- standards and
successfully passes all test cases. trated in Fig. 1. The process begins
by inputting tasks/code generation requirements into the code generation
agent (i.e., 3.3 Test designer agent: generating basic, edge, Agent#1:
the programmer agent). Subsequently, the test case and large scale tests
generator (i.e., Agent#2: the test designer agent) is tasked The test
designer agent is also powered by LLMs. It is a cru- with generating
test cases, which are used to evaluate the cor- cial component of our
AgentCoder's framework to provide rectness of the code snippets produced
by the programmer reliable feedback for the programmer agent to optimise
the agent. The code snippets and test cases are collected by the code
iteratively. We carefully designed the prompts for the test executor
agent (i.e., Agent#3) and executed in the local test designer agent to
satisfy the following three expectations: environment to obtain
feedback. If the test executor agent 1) to generate basic test cases, 2)
to cover edge test cases, and finds that code snippets pass all test
cases, it will return the 3) to cover large-size inputs. The first
aspect expects that  The Human Developer Code Requirements Code Snippets
Completion the code snippet: "I got the ready-to- "I want to build a def
has_close_elements(numbers, threshold) -\> bool: from typing import List
for idx, elem in enumerate(numbers): use code !" program that ⋯" def
has_close_elements(numbers, threshold) -\> bool: for idx2, elem2 in
enumerate(numbers): """ Check if in given list of numbers, are any two
if idx != idx2: numbers closer to each other than given threshold.
distance = abs(elem - elem2) \>\>\> has_close_elements(\[1.0, 2.0,
3.0\], 0.5) if distance \< threshold:

                                                                 Code Requirement
                                                                                     False
                                                                                                                                                                 return True
                                                                                        >>> has_close_elements([1.0, 2.8, 3.0, 4.0, 5.0,
                                                                                                                                                   return False

Programs

                                                                                     2.0], 0.3) True """
                Code Developing Agents
                                                                                                                                                                                                               “Test Executor”         Yes
                            Agent#1                                                                             “Programmer”                         Test Cases
                                Code                                                                                                                                                                       Passed the validation?
                                                                                                                                                ### 1. Basic Test Cases:
                              Generation                                                                                                        assert has_close_elements([1.0, 2.0, 3.0], 0.5) == False                               No
                                                                                                                                                assert has_close_elements([1.0, 1.4, 3.0], 0.5) == True

                                               Report Messages
                            Agent#2                                                                           “Test Designer”
              Environment




                                                                                                                                                ### 2.Edge Cases:
                              Test Case                                                                                                         assert has_close_elements([], 0.5) == False
                                                                                                                                                assert has_close_elements([1.0], 0.5) == False
                              Generation                                                   Feedback Info                                        assert has_close_elements([1.0, 1.0], 0) == True

                            Agent#3                                                  File "PATH/has_close_elements.py", line 13                 ### 3.Large Numbers:                                           Error Feedback
                                                                                        >>> has_close_elements([1.0, 2.0, 3.0], 0.5)            large_list = [i * 0.1 for i in range(10000)]
                                                                                        ^^
                               Execution                                             SyntaxError: invalid syntax
                                                                                                                                                assert has_close_elements(large_list, 0.0999) == False        Test Cases + Error Message




                                                                                    Figure 1: Pipeline of our AgentCoder approach.

the test designer agent design test cases that cover the fun- the
reported error. damental functionality of the code. These tests are
designed to ensure that the code performs as expected under normal 4
Evaluation conditions. For instance, in a task that involves sorting a
list, In this section, we conduct experiments to answer the follow- the
basic test cases verify that the list is sorted correctly for ing
research questions: typical inputs. The second aspect ensure that the
code per- forms well under edge scenarios, which are critical for eval-
• RQ1: How does AgentCoder perform in code genera- uating the code's
behavior under extreme or unusual condi- tion? tions. These tests are
designed to challenge the code with • RQ2: How do different agents
contribute to the effec- boundary conditions, unexpected inputs, and
rare scenarios, tiveness of AgentCoder? to help in identifying potential
bugs or weaknesses in the code • RQ3: How do code refinement iterations
affect Agent- that might not be evident during basic testing. For
example, Coder's effectiveness? using an empty list or a list with
extremely large numbers to test the sorting algorithm. Finally, the test
designer agent will • RQ4: How accurate are the tests generated by the
test also generate test cases with large scale values to assess the
designer agent? code's performance and scalability (e.g., testing the
sorting • RQ5: How adequate are the tests generated by the test
algorithm with a list of millions of elements). This involves designer
agent? testing the code under high-load conditions to ensure that it •
RQ6: Is it necessary to separate the programmer and test maintains its
functionality and performance. designer roles with two agents? 3.4 Test
executor agent: code validation and 4.1 Experiment Setup feedback
Integration Datasets In this paper, we evaluate AgentCoder's effec-
Distinct from the programmer agent and test designer agent tiveness with
two widely used code generation datasets, i.e., that are powered by
LLMs, the test executor agent in our HumanEval \[Chen et al., 2021b\]
and MBPP \[Austin et al., framework is implemented through a Python
script interact- 2021\], and their enhanced versions, i.e., HumanEval-ET
and ing with a local environment and the other two agents. As il-
MBPP-ET \[Dong et al., 2023a\]. These datasets are pivotal for lustrated
in Fig. 1, the test executor agent plays a pivotal role assessing the
performance and capabilities of code generation in the final stage of
the code generation process. Upon receiv- models. HumanEval and
HumanEval-ET focus on a range of ing code snippets and test cases
generated by the programmer programming challenges, offering a diverse
set of problems to and test designer agent, the test executor agent
validates these test the model's problem-solving skills and
adaptability. On code snippets along with the test cases in a local
environment. the other hand, MBPP and MBPP-ET provide a comprehen- The
execution simulates a real-world application of the code, sive
collection of Python programming problems, designed ensuring that the
testing is as realistic as possible. The test to evaluate the model's
proficiency in Python syntax and its executor agent closely monitors the
return information from ability to handle a variety of coding scenarios.
The enhanced the execution environment (i.e., the terminal). This
involves versions, HumanEval-ET and MBPP-ET, include additional
analyzing the output and determining whether the code snip- test cases
and scenarios, making them more challenging and pets successfully pass
all the test cases. If all test cases are better suited for evaluating
advanced models such as Agent- passed, it returns the code to the human
developer. Other- Coder. Using these datasets, we aim to provide a
thorough wise, if the execution results contain error information (e.g.,
and rigorous assessment of AgentCoder's capabilities in code assertion
and syntax errors), the test executor agent will then generation,
showcasing its strengths, and identifying areas for return the error
information to the programmer agent to fix potential improvement.
Baselines To illustrate the effectiveness of AgentCoder, in are more
challenging for the generated code to pass. We this paper, we compare
AgentCoder with several Large Lan- can observe that the base LLMs and
the baseline optimisation guage Models (LLMs), including open-source and
closed- approaches perform significantly worse on the the enhanced
source ones, such as AlphaCode \[Li et al., 2022\], In- versions.
However, AgentCoder's performance on these en- coder \[Fried et al.,
2022\], CodeGeeX \[Zheng et al., 2023\], hanced versions is comparative
to the original version, which StarCoder \[Li et al., 2023b\],
CodeGen-Mono \[Nijkamp et al., is another superiority of AgentCoder.
This is because the test 2023b\], CodeX \[Brown et al., 2020a\],
GPT-3.5-turbo, and designer agent generates rigorous tests to ensure
that the gen- GPT4 \[OpenAI, 2023\]. These models vary in architecture,
erated code is indeed reliable. training methodologies, and application
scopes. Addition- ally, we compare AgentCoder with state-of-the-art
(SOTA) code generation methods that are based on LLMs but with 4.3 RQ2:
How do different agents contribute to various optimisation strategies,
including Few-shot learning, the effectiveness of AgentCoder?
Chain-of-Thought \[Wei et al., 2022\], ReAct \[Yao et al., 2022\],
Reflexion \[Shinn et al., 2023\], ToT \[Yao et al., 2023\], As
illustrated in Fig. 1, AgentCoder contains three agents, RAP \[Hao et
al., 2023\], Self-Edit \[Zhang et al., 2023b\], Self- i.e., the
programmer agent, the test designer agent, and the Planing \[Jiang et
al., 2023\], Self-Debugging \[Chen et al., test executor agent, where
the programmer agent focuses 2023b\], Self-Collaboration \[Dong et al.,
2023b\], SCOT \[Li on generating code snippets based on the code
generation et al., 2023a\], CodeCoT \[Huang et al., 2023\], and INTER-
requirements and feedback information. The test designer VENOR \[Wang et
al., 2023a\]. These methods have been agent focuses on generating test
cases, which are used to eval- shown to significantly enhance the
performance of LLMs in uate the correctness of the code snippets
produced by the pro- complex problem-solving scenarios. grammer. The
test executor agent combines the code snippets Metric To quantify the
effectiveness of AgentCoder and and test cases and executes in a local
environment to obtain baseline strategies, we use pass@1 as the
evaluation metric feedback. To analyze how each agent contributes to
Agent- for the evaluation, the most widely adopted metric in the lit-
Coder's effectiveness, we evaluate AgentCoder's effective- erature of
automatic code generation \[Chen et al., 2021c\]. ness with four
scenarios, i.e., the programmer agent itself, the programmer + test
designer agent, where we feed the function 4.2 RQ1: How does AgentCoder
perform? and test cases into the programmer agent and require it to an-
Setup AgentCoder is a multi-agent-based code generation alyze whether it
needs to refine the code to pass all test cases, framework that can be
applied to any LLM. In our exper- and the programmer + test executor
agent, where we directly iments, we evaluate the effectiveness of
AgentCoder with run the function with the prompt provided test cases
(e.g., four state-of-the-art LLMs, i.e., GPT-3.5-turbo, GPT4, PaLM
doctest in HumanEval tasks). Coder, and Claude (Claude-instant-1). The
evaluation results The evaluation results are shown in Tab. 2. We can
ob- of AgentCoder and baselines are shown in Tab. 1. We can ob- serve
that first, with the assistant of other agents, e.g., the serve that
AgentCoder obtain SOTA performance compared test designer and the test
executor agent, the pass@1 will to the base LLM models and all the
baseline optimisation ap- increase compared with the result of only the
programmer. proaches in both the HumanEval and MBPP datasets, includ-
For example, once we utilize the programmer and the test de- ing their
enhanced versions. signer agent, the pass@1 increases from the 61.0% to
64.0%, Specifically, if we focus on the improvement that Agent- which is
similar to previous self-refine tasks that require the Coder achieves
over the base LLMs, take GPT-3.5-turbo as LLM self-debug/analyze whether
the previous answer (e.g., an example, GPT-3.5-turbo obtains 57.3%
pass@1 in the Hu- math reasoning) is correct. However, as mentioned
before, manEval dataset, while AgentCoder obtains 79.9%. For GPT- the
bug code snippets can be classified as correct by its gen- 4, the mean
pass@1 of AgentCoder is 91.5% across all the erated code generation
model, which causes programmer + datasets, 32.7% improvement over the
baseline zero-shot test designer agent not to obtain the SOTA
performance (e.g., GPT-4 model. For PaLM Coder, Claude-instant-1, and
GPT- 79.9% in AgentCoder). Next, we evaluate the performance 4-turbo,
the mean improvement of AgentCoder over the base of the programer + test
executor agent, we can observe that it models are 32.7%, 42.8%, 32.8%,
respectively. obtains 64.6% and 69.3% pass@1 in HumanEval and MBPP, When
comparing AgentCoder with the baseline optimisa- which is also higher
than the programmer agent which obtains tion methods, AgentCoder
demonstrates superiority over all 61.0% and 47.9%. The key reason is
that test executor agent of them. For example, for MBPP-ET with
GPT-3.5-turbo, will detect some bugs in the code with the test cases
provided AgentCoder has 89.1% pass@1, while CodeCoT, the second- by the
prompt (e.g., doctest's test cases in the HumanEval). best approach,
achieves only 63.0%. On average, the pass@1 However, since the test
cases provided by the prompt only of AgentCoder is 84.1%, 8.8%
improvement over the state- have two to three in the HumanEval and MBPP,
it contains of-the-art. The key reason for AgentCoder obtains higher a
large gap between the dataset and its ET version. For ex- performance
compared with CodeCoT is that during the test ample, with the extract
test cases, the pass@1 decreases from case generation, CodeCoT simply
generates a few test cases 64.6% to 55.5% in HumanEval-ET and 69.3% to
51.4% in to analyze code behavior, while AgentCoder considers multi-
MBPP-ET. However, in AgentCoder, with the test designer ple different
scenarios. agent in the multi-agent, the pass@1 only decreases from The
enhanced versions of the datasets (i.e., HumanEval- 79.9% to 77.4% in
HumanEval-ET and 89.9% to 89.1% in ET and MBPP-ET) contain more
comprehensive tests and MBPP-ET. Table 1: End-to-end results of
AgentCoder and baseline approaches for HumanEval, HumanEval-ET, MBPP,
and MBPP-ET datasets. The baseline results are cited from its paper
report, and we use "-" to indicate the cases where the results are
absent. For the last three rows, no baseline optimisation approaches
report effectiveness on these LLMs, therefore, we report the results of
only AgentCoder.

                              Models                           HumanEval     HumanEval-ET       MBPP   MBPP-ET    Mean

                                                              Base LLMs (zero-shot prompting)
                              AlphaCode (1.1B)                    17.1             -             -        -       17.1
                              Incoder (6.7B)                      15.2            11.6          17.6     14.3     14.7
                              CodeGeeX (13B)                      18.9            15.2          26.9     20.4     20.4
                              StarCoder (15.5B)                   34.1            25.6          43.6     33.4     34.2
                              CodeGen-Mono (16.1B)                32.9            25.0          38.6     31.6     32.0
                              CodeX (175B)                        47.0            31.7          58.1     38.8     43.9
                              CodeX (175B)+CodeT                  65.8            51.7          67.7     45.1     57.6
                              GPT-3.5-turbo                       57.3            42.7          52.2     36.8     47.3
                              PaLM Coder                          43.9            36.6          32.3     27.2     35.0
                              Claude-instant-1                    31.1            28.1          26.9     19.9     26.5
                              GPT-4-turbo                         57.9            48.8          63.4     47.5     54.4
                              GPT-4                               67.6            50.6          68.3     52.2     59.7
                                                    Optimisation Approaches (based on GPT-3.5-turbo)
                              Few-Shot                            67.7            54.9          65.8     48.3     59.2
                              CoT                                 44.6            37.2          46.1     34.8     40.7
                              ReAct                               56.9            49.4          67.0     45.9     54.8
                              Reflexion                           68.1            50.6          70.0     47.5     59.1
                              ToT                                 54.4            42.7          65.8     40.8     50.9
                              RAP                                 63.1            52.4          71.4     46.7     58.4
                              Self-Edit                           62.2            54.3          56.4     45.9     54.7
                              Self-Planing                        65.2            48.8          58.6     41.5     53.5
                              Self-debugging                      61.6            45.8          60.1     52.3     55.0
                              Self-Collaboration                  74.4            56.1          68.2     49.5     62.1
                              INTERVENOR                          75.6            54.8          69.8     47.1     61.8
                              CodeCoT                             79.3            69.5          89.5     63.0     75.3
                              AgentCoder (ours)                   79.9            77.4          89.9     89.1     84.1
                                                        Optimisation Approaches (based on GPT-4)
                              Reflexion                           91.0             -            77.1      -       84.1
                              Self-Debugging                       -               -            80.6      -       80.6
                              Self-Collaboration                  90.2            70.7          78.9     62.1     75.5
                              MetaGPT                             85.9             -            87.7      -       86.8
                              AgentCoder (ours)                   96.3            86.0          91.8     91.8     91.5
                                                     Optimisation Approaches (based on other LLMs)
                              AgentCoder (PaLM Coder)             64.0            55.5          75.9     75.5     67.7
                              AgentCoder (Claude-instant-1)       67.7            57.9          76.3     75.1     69.3
                              AgentCoder (GPT-4-turbo)            89.6            76.2          91.4     91.4     87.2

4.4 RQ3: How do code refinement iterations affect 4.5 RQ4: Are the test
cases generated by the test AgentCoder's effectiveness? designer agent
accurate? As we mentioned before, the test designer agent focuses on
generating test cases to analyze whether the code has bugs As
illustrated in Fig. 1, AgentCoder will refine code snippets and plays a
crucial role in AgentCoder. However, once the based on the feedback
information provided by the test ex- test cases are incorrect (e.g.,
with incorrect test oracles), ecutor agent. In this experiment, we
evaluate how refinement the problematic feedback will mislead the
programmer agent iterations affect AgentCoder's effectiveness.
Specifically, we and decrease AgentCoder's effectiveness. Therefore,
this re- analyze AgentCoder's effectiveness with its result for each re-
search question investigates how reliable the test designer finement
iteration. The evaluation results are shown in Tab. 3, agent is in
generating accurate tests to aid the programmer where - means we do not
conduct experiments for it since the agent. We evaluate the accuracy of
the test cases under the pass@1 is already close to 100%. We can observe
that first, HumanEval and MBPP's canonical solution1 on GPT-3.5- with
more iterations, the pass@1 will increase for all experi- turbo. The
tests that pass the code canonical solution are ments. For example, in
AgentCoder (GPT-3.5-turbo), we can correct, and vice versa. To
demonstrate the effectiveness and observe that when we increase the
number of iterations from superiority of the test designer agent in
AgentCoder, we com- 1 to 5, the pass@1 of HumanEval and HumanEval-ET in-
pare the accuracy of the tests generated by AgentCoder, the creases from
74.4% to 79.9% and 73.2% to 77.4%. We can default zero-shot
GPT-3.5-turbo model, as well as CodeCoT also observe these behaviors for
the MBPP and MBPP-ET where the tests are generated at the same time with
the code. datasets, where the pass@1 increases from 84.1% to 89.9% and
80.3% to 89.1% when we increase the number of itera- 1 Each coding task
in the datasets has a canonical solution, which tions from 1 to 5. is
the ground truth for code generation.  Table 2: How AgentCoder's agents
contribute to its effectiveness.

                                      Agents                    HumanEval          HumanEval-ET         MBPP      MBPP-ET
                            programmer agent only                     61.0              52.4             47.9         35.0
                       programmer + test designer agent               64.0              54.3             62.3         45.9
                       programmer + test executor agent               64.6              55.5             69.3         51.4
                                 AgentCoder                           79.9              77.4             89.9         89.1

Table 3: Pass@1 of AgentCoder with different number of iterations Table
5: Code line coverage of the generated test cases. In our ex- on
GPT-3.5-turbo. periment, we follow CodeCoT to calculate the code line
coverage with the first five / all test cases provided by the test
designer agent Iterations HumanEval HumanEval-ET MBPP MBPP-ET for each
function. 1 74.4 73.2 84.1 80.3 2 75.6 73.2 86.4 85.6 Models HumanEval
MBPP 3 76.2 75.0 87.9 87.6 GPT-3.5-turbo 67.1 / 70.2 58.4 / 61.3 4 78.7
76.8 88.7 88.7 5 79.9 77.4 89.9 89.1 CodeCoT 74.7 / 77.2 79.3 / 82.9
AgentCoder 84.7 / 87.5 85.3 / 89.5

               Table 4: Accuracy of the generated test cases
                                                                             4.7     RQ6: Is it necessary to separate the
                                                                                     programmer and test designer roles with two
                   Models         HumanEval        MBPP
                                                                                     agents?
               GPT-3.5-turbo           47.0         57.2
                                                                             As shown in Fig. 1, AgentCoder requires separate agents for
                 CodeCoT               67.1         79.0
                                                                             generating code and tests (i.e., the programmer agent and the
                AgentCoder             87.8         89.9
                                                                             test designer agent). Both agents are powered by LLMs. An
                                                                             alternative way is to let a single agent first generate code and
                                                                             then generate tests, within the same conversation. This re-

The evaluation results are shown in Tab. 4. First, we ob- search
question investigates whether requiring one agent to serve that the test
case accuracy of the test designer agent in finish two tasks, i.e., code
generation and test case genera- AgentCoder is 87.8% and 89.9% in
HumanEval and MBPP tion, is as effective as using separate agents.
datasets, while GPT-3.5-turbo obtains only 47.0% and 57.2%. In addition,
we observe that the test designer agent in Agent- Table 6: Comparison
results of pass@1 for Single-agent and Multi- Coder is also more
accurate than CodeCoT in test genera- agents (AgentCoder). tion. For
example, on HumanEval, the accuracy is 87.8% v.s. 67.1% for AgentCoder
and CodeCoT. The superiority of Models HumanEval HumanEval-ET MBPP
MBPP-ET AgentCoder demonstrates the effectiveness of the prompt en-
Single Agent 71.3 61.6 79.4 59.1 gineering strategies we designed for
the test designer agent. Multiple Agent 79.9 77.4 89.9 89.1

                                                                                The evaluation results are shown in Tab. 6 and Tab. 7.

4.6 RQ5: How adequate are AgentCoder's test We can observe that first,
the pass@1 of the single agent cases in terms of code coverage? is lower
than the multiple agent results. For example, the pass@1 of the single
agent only has 71.3% and 79.4% for Hu- This research question explores
the adequacy of the test cases manEval and MBPP datasets, while the
Multi-gent (Agent- generated by the test designer agent in terms of code
cov- Coder) obtains 79.9% and 89.9% for HumanEval and MBPP erage.
Specifically, we evaluate how many lines of code in datasets. We also
observe that the test case accuracy for the the canonical solution are
covered by the test cases gener- single agent is also lower than the
multiple agent (Agent- ated by the original GPT-3.5-turbo, CodeCoT, and
Agent- Coder). Specifically, the single agent only obtains 61.0% Coder.
The evaluation results were illustrated in Tab. 5, where and 51.8% in
HumanEval and MBPP datasets, while the we can observe that the tests
generated by AgentCoder is the highest. For example, AgentCoder obtains
84.7 / 87.5% Table 7: Accuracy of tests for Single-agent and
Multi-agents (Agent- and 85.3 / 89.5% code coverage compared with
CodeCoT, Coder). which only obtains 74.7 / 77.2% and 79.3 / 82.9%, on
the two datasets when we calculate the code line coverage with the
Models HumanEval MBPP first five / all tests generated by each strategy.
The results fur- Single Agent 61.0 51.8 ther demonstrate the
effectiveness of the prompt engineering Multiple Agent 87.8 89.9
strategies we adopt for the test designer agent. Multi-agents
(AgentCoder) obtains 87.8% and 89.9% in Hu- \[Brown et al., 2020a\] Tom
B. Brown, Benjamin Mann, Nick manEval and MBPP. These results
demonstrate the necessity Ryder, Melanie Subbiah, Jared Kaplan, Prafulla
Dhari- of using multiple agents to collaborate in code generation, wal,
Arvind Neelakantan, Pranav Shyam, Girish Sas- an observation that is
also supported by the theory of con- try, Amanda Askell, Sandhini
Agarwal, Ariel Herbert- ventional multi-agent systems \[Xi, 2020; Chen
et al., 2023a; Voss, Gretchen Krueger, T. J. Henighan, Rewon Child,
Zhang et al., 2023a\]. Aditya Ramesh, Daniel M. Ziegler, Jeff Wu,
Clemens Winter, Christopher Hesse, Mark Chen, Eric Sigler, Ma- 5
Conclusion teusz Litwin, Scott Gray, Benjamin Chess, Jack Clark, In this
paper, we propose AgentCoder, which contains mul- Christopher Berner,
Sam McCandlish, Alec Radford, Ilya tiple agents to improve the code
generation effectiveness of Sutskever, and Dario Amodei. Language models
are few- code generation models. AgentCoder contains three agents, shot
learners. ArXiv, abs/2005.14165, 2020. i.e., the programmer, test
designer, and test executor agent. \[Brown et al., 2020b\] Tom B. Brown,
Benjamin Mann, Nick During the code generation procedure, the programmer
agent Ryder, Melanie Subbiah, Jared Kaplan, Prafulla Dhari- will first
generate code snippets and then the test designer wal, Arvind
Neelakantan, Pranav Shyam, Girish Sastry, agent will generate test cases
for the code snippets. Next, the Amanda Askell, et al. Language models
are few-shot test executor agent will test the code snippets with test
cases learners. arXiv preprint arXiv:2005.14165, 2020. in the local
environment. Once the feedback of the local en- \[Chen et al., 2021a\]
Jun Chen, Han Guo, Kai Yi, Boyang Al- vironment contains an error
message, the test executor agent bert Li, and Mohamed Elhoseiny.
Visualgpt: Data-efficient will feed it into the programmer and test
designer agent to adaptation of pretrained language models for image
cap- require them fix the error information. Throughout our eval-
tioning. 2022 IEEE/CVF Conference on Computer Vision uations, AgentCoder
demonstrated SOTA performance, out- and Pattern Recognition (CVPR),
pages 18009--18019, performing existing LLMs and prompt engineering
methods 2021. in a variety of coding scenarios. For example, AgentCoder
increases the pass@1 from 79.3% and 76.3% to 79.9% and \[Chen et al.,
2021b\] Mark Chen, Jerry Tworek, Heewoo Jun, 89.1% for HumanEval and
MBPP datasets. Qiming Yuan, Henrique Ponde de Oliveira Pinto, Jared
Kaplan, Harri Edwards, Yuri Burda, Nicholas Joseph, 6 Limitations Greg
Brockman, et al. Evaluating large language models trained on code. arXiv
preprint arXiv:2107.03374, 2021. We discuss the limitations of our work
that could hope- fully inspire future research in this avenue. First,
the back- \[Chen et al., 2021c\] Mark Chen, Jerry Tworek, Heewoo Jun,
bone models we investigated are closed-source state-of-the- Qiming Yuan,
Henrique Ponde, Jared Kaplan, Harrison art LLMs from OpenAI. As we
noticed that there is a huge Edwards, Yura Burda, Nicholas Joseph, Greg
Brockman, performance gap between current closed-source and open- Alex
Ray, Raul Puri, Gretchen Krueger, Michael Petrov, source LLMs, utilizing
AgentCoder with current open-source Heidy Khlaaf, Girish Sastry, Pamela
Mishkin, Brooke LLMs (e.g., CodeT5+, WizardCoder) may require the fine-
Chan, Scott Gray, Nick Ryder, Mikhail Pavlov, Alethea tuning process to
make sure the agent LLMs can play the Power, Lukasz Kaiser, Mohammad
Bavarian, Clemens roles in our setup. Therefore, we encourage future
research Winter, Philippe Tillet, Felipe Petroski Such, David W. on open
source LLMs to further evaluate AgentCoder's effec- Cummings, Matthias
Plappert, Fotios Chantzis, Eliza- tiveness. Second, AgentCoder requires
multiple interaction beth Barnes, Ariel Herbert-Voss, William H. Guss,
Alex processes with the programmer agent, which will increase Nichol,
Igor Babuschkin, S. Arun Balaji, Shantanu Jain, the overhead of code
generation for both time and API fee. Andrew Carr, Jan Leike, Joshua
Achiam, Vedant Misra, So we encourage future studies to decrease the
interaction Evan Morikawa, Alec Radford, Matthew M. Knight, Miles times.
Finally, as shown in Tab. 4, the test designer agent Brundage, Mira
Murati, Katie Mayer, Peter Welinder, Bob in the AgentCoder can not make
sure all test cases are cor- McGrew, Dario Amodei, Sam McCandlish, Ilya
Sutskever, rect, which means that some code snippets generated by the
and Wojciech Zaremba. Evaluating large language models programmer agent
may then revises to an error version. In trained on code. ArXiv,
abs/2107.03374, 2021. the future, we will try to quantify the revised
functions and \[Chen et al., 2023a\] Weize Chen, Yusheng Su, Jingwei
Zuo, investigate how to avoid these behaviors. Cheng Yang, Chenfei Yuan,
Cheng Qian, Chi-Min Chan, Yujia Qin, Ya-Ting Lu, Ruobing Xie, Zhiyuan
Liu, References Maosong Sun, and Jie Zhou. Agentverse: Facilitating
\[Ahmad et al., 2021\] Wasi Uddin Ahmad, Saikat multi-agent
collaboration and exploring emergent behav- Chakraborty, Baishakhi Ray,
and Kai-Wei Chang. iors in agents. ArXiv, abs/2308.10848, 2023. Unified
pre-training for program understanding and \[Chen et al., 2023b\] Xinyun
Chen, Maxwell Lin, Nathanael generation. ArXiv, abs/2103.06333, 2021.
Schärli, and Denny Zhou. Teaching large language models \[Austin et al.,
2021\] Jacob Austin, Augustus Odena, to self-debug. ArXiv,
abs/2304.05128, 2023. Maxwell Nye, Maarten Bosma, Henryk Michalewski,
\[Dong et al., 2023a\] Yihong Dong, Ji Ding, Xue Jiang, Zhuo David
Dohan, Ellen Jiang, Carrie J. Cai, Michael Terry, Li, Ge Li, and Zhi
Jin. Codescore: Evaluating code gener- Quoc V. Le, and Charles Sutton.
Program synthesis with ation by learning code execution. ArXiv,
abs/2301.09043, large language models. ArXiv, abs/2108.07732, 2021.
2023. \[Dong et al., 2023b\] Yihong Dong, Xue Jiang, Zhi Jin, and Thomas
Wang, Olivier Dehaene, Mishig Davaadorj, Joel Ge Li. Self-collaboration
code generation via chatgpt. Lamy-Poirier, João Monteiro, Oleh
Shliazhko, Nicolas ArXiv, abs/2304.07590, 2023. Gontier, Nicholas Meade,
Armel Zebaze, Ming-Ho Yee, \[Feng et al., 2020\] Zhangyin Feng, Daya
Guo, Duyu Tang, Logesh Kumar Umapathi, Jian Zhu, Benjamin Lipkin, Nan
Duan, Xiaocheng Feng, Ming Gong, Linjun Shou, Muhtasham Oblokulov,
Zhiruo Wang, Rudra Murthy, Ja- Bing Qin, Ting Liu, Daxin Jiang, and Ming
Zhou. Code- son Stillerman, Siva Sankalp Patel, Dmitry Abulkhanov, BERT:
A pre-trained model for programming and natural Marco Zocca, Manan Dey,
Zhihan Zhang, Nourhan languages. In Findings of the Association for
Computa- Fahmy, Urvashi Bhattacharyya, W. Yu, Swayam Singh, tional
Linguistics: EMNLP 2020, pages 1536--1547, On- Sasha Luccioni, Paulo
Villegas, Maxim Kunakov, Fedor line, November 2020. Association for
Computational Lin- Zhdanov, Manuel Romero, Tony Lee, Nadav Timor, Jen-
guistics. nifer Ding, Claire Schlesinger, Hailey Schoelkopf, Jana Ebert,
Tri Dao, Mayank Mishra, Alexander Gu, Jen- \[Fried et al., 2022\] Daniel
Fried, Armen Aghajanyan, Jessy nifer Robinson, Carolyn Jane Anderson,
Brendan Dolan- Lin, Sida I. Wang, Eric Wallace, Freda Shi, Ruiqi Zhong,
Gavitt, Danish Contractor, Siva Reddy, Daniel Fried, Wen tau Yih, Luke
Zettlemoyer, and Mike Lewis. Incoder: Dzmitry Bahdanau, Yacine Jernite,
Carlos Muñoz Ferran- A generative model for code infilling and
synthesis. ArXiv, dis, Sean M. Hughes, Thomas Wolf, Arjun Guha, Leandro
abs/2204.05999, 2022. von Werra, and Harm de Vries. Starcoder: may the
source \[Guo et al., 2020\] Daya Guo, Shuo Ren, Shuai Lu, Zhangyin be
with you! ArXiv, abs/2305.06161, 2023. Feng, Duyu Tang, Shujie Liu, Long
Zhou, Nan Duan, \[Madaan et al., 2023\] Aman Madaan, Niket Tandon,
Prakhar Jian Yin, Daxin Jiang, and M. Zhou. Graphcodebert: Gupta, Skyler
Hallinan, Luyu Gao, Sarah Wiegreffe, Uri Pre-training code
representations with data flow. ArXiv, Alon, Nouha Dziri, Shrimai
Prabhumoye, Yiming Yang, abs/2009.08366, 2020. Sean Welleck, Bodhisattwa
Prasad Majumder, Shashank \[Hao et al., 2023\] Shibo Hao, Yi Gu, Haodi
Ma, Joshua Ji- Gupta, Amir Yazdanbakhsh, and Peter Clark. Self- ahua
Hong, Zhen Wang, Daisy Zhe Wang, and Zhiting Hu. refine: Iterative
refinement with self-feedback. ArXiv, Reasoning with language model is
planning with world abs/2303.17651, 2023. model. ArXiv, abs/2305.14992,
2023. \[Nijkamp et al., 2023a\] Erik Nijkamp, Hiroaki Hayashi, \[Huang
et al., 2023\] Dong Huang, Qi Bu, and Heming Cui. Caiming Xiong, Silvio
Savarese, and Yingbo Zhou. Code- Codecot and beyond: Learning to program
and test like a gen2: Lessons for training llms on programming and nat-
developer. ArXiv, abs/2308.08784, 2023. ural languages. ICLR, 2023.
\[Nijkamp et al., 2023b\] Erik Nijkamp, Bo Pang, Hiroaki \[Jiang et al.,
2023\] Xue Jiang, Yihong Dong, Lecheng Hayashi, Lifu Tu, Huan Wang,
Yingbo Zhou, Silvio Wang, Qiwei Shang, and Ge Li. Self-planning code
gener- Savarese, and Caiming Xiong. Codegen: An open large ation with
large language model. ArXiv, abs/2303.06689, language model for code
with multi-turn program synthe- 2023. sis. ICLR, 2023. \[Le et al.,
2023\] Hung Le, Hailin Chen, Amrita Saha, Akash \[OpenAI, 2023\] OpenAI.
Gpt-4 technical report. ArXiv, Gokul, Doyen Sahoo, and Shafiq R. Joty.
Codechain: abs/2303.08774, 2023. Towards modular code generation through
chain of self-revisions with representative sub-modules. ArXiv, \[Shinn
et al., 2023\] Noah Shinn, Federico Cassano, Beck abs/2310.08992, 2023.
Labash, Ashwin Gopinath, Karthik Narasimhan, and Shunyu Yao. Reflexion:
Language agents with verbal re- \[Li et al., 2022\] Yujia Li, David H.
Choi, Junyoung Chung, inforcement learning. 2023. Nate Kushman, Julian
Schrittwieser, Rémi Leblond, Tom, Eccles, James Keeling, Felix Gimeno,
Agustin Dal \[Wang et al., 2021\] Yue Wang, Weishi Wang, Shafiq Joty,
Lago, Thomas Hubert, Peter Choy, Cyprien de, Mas- and Steven C.H. Hoi.
Codet5: Identifier-aware unified son d'Autume, Igor Babuschkin, Xinyun
Chen, Po- pre-trained encoder-decoder models for code understand- Sen
Huang, Johannes Welbl, Sven Gowal, Alexey, ing and generation. In EMNLP,
2021. Cherepanov, James Molloy, Daniel Jaymin Mankowitz, \[Wang et al.,
2022\] Xuezhi Wang, Jason Wei, Dale Schuur- Esme Sutherland Robson,
Pushmeet Kohli, Nando de, Fre- mans, Quoc Le, Ed Huai hsin Chi, and
Denny Zhou. Self- itas, Koray Kavukcuoglu, and Oriol Vinyals.
Competition- consistency improves chain of thought reasoning in lan-
level code generation with alphacode. Science, 378:1092 guage models.
ArXiv, abs/2203.11171, 2022. -- 1097, 2022. \[Wang et al., 2023a\]
Hanbin Wang, Zhenghao Liu, Shuo \[Li et al., 2023a\] Jia Li, Ge Li,
Yongming Li, and Zhi Jin. Wang, Ganqu Cui, Ning Ding, Zhiyuan Liu, and
Ge Yu. Structured chain-of-thought prompting for code genera-
Intervenor: Prompt the coding ability of large language tion. 2023.
models with the interactive chain of repairing. ArXiv, \[Li et al.,
2023b\] Raymond Li, Loubna Ben Allal, Yang- abs/2311.09868, 2023. tian
Zi, Niklas Muennighoff, Denis Kocetkov, Cheng- \[Wang et al., 2023b\]
Yue Wang, Hung Le, Akhilesh Deepak hao Mou, Marc Marone, Christopher
Akiki, Jia Li, Jenny Gotmare, Nghi DQ Bui, Junnan Li, and Steven CH
Chim, Qian Liu, Evgenii Zheltonozhskii, Terry Yue Zhuo, Hoi. Codet5+:
Open code large language models  for code understanding and generation.
arXiv preprint A Appendix arXiv:2305.07922, 2023. A.1 Response Setup
\[Wei et al., 2022\] Jason Wei, Xuezhi Wang, Dale Schuur- To ensure that
the output of each agent follows our re- mans, Maarten Bosma, Ed Huai
hsin Chi, F. Xia, Quoc Le, quirements for the execution of the test
executor agent, and Denny Zhou. Chain of thought prompting elicits rea-
we will require each agent's output follow the architecture soning in
large language models. ArXiv, abs/2201.11903, of '''py\[Code\]''' and
'''py\[TestCases\]''', where the 2022. \[Code\] and \[TestCases\] will
be in the '''py'''. With this \[Xi, 2020\] Lin Xi. Pareto Multi-task
Learning and Its Appli- format, the test executor agent can directly
obtain \[Code\] and cations. PhD thesis, City University of Hong Kong,
2020. \[TestCases\] by removing the other sentences before and after
\[Yao et al., 2022\] Shunyu Yao, Jeffrey Zhao, Dian Yu, Nan these code
blocks, ensuring an accurate and focused analysis. Du, Izhak Shafran,
Karthik Narasimhan, and Yuan Cao. A.2 Case Illustration for CodeCoT and
React: Synergizing reasoning and acting in language mod- els. ArXiv,
abs/2210.03629, 2022. AgentCoder To provide a comprehensive illustration
for CodeCoT and \[Yao et al., 2023\] Shunyu Yao, Dian Yu, Jeffrey Zhao,
Izhak AgentCoder, we provide two code and tests generation exam-
Shafran, Thomas L. Griffiths, Yuan Cao, and Karthik ples for HumanEval
and MBPP datasets from Fig. 2 to Fig. 5. Narasimhan. Tree of thoughts:
Deliberate problem solv- We can observe that AgentCoder can generate
more fine- ing with large language models. ArXiv, abs/2305.10601,
grained tests for the generated code. For example, Agent- 2023. Coder
will consider the code execution results when the input \[Zan et al.,
2022\] Daoguang Zan, Bei Chen, Dejian Yang, list does not contain
element (Fig. 3 and Fig. 5), which can Zeqi Lin, Minsu Kim, Bei Guan,
Yongji Wang, Weizhu improve code snippet reliability for edge behaviors.
Chen, and Jian-Guang Lou. CERT: Continual pre-training on sketches for
library-oriented code generation. In The A.3 Case Illustration on
HumanEval dataset using 2022 International Joint Conference on
Artificial Intelli- AgentCoder gence, 2022. We also provide each agent's
prompt and response exam- \[Zhang et al., 2023a\] Ceyao Zhang, Kaijie
Yang, Siyi Hu, ple (Fig. 6 to Fig. 10) to illustrate AgentCoder's
workflow. Zihao Wang, Guanghe Li, Yi Eve Sun, Chen Zhang, Zhaowei Zhang,
Anji Liu, Song-Chun Zhu, Xiaojun A.4 Case Illustration of the
programmer + test Chang, Junge Zhang, F. Yin, Yitao Liang, and Yaodong
executor agent Yang. Proagent: Building proactive cooperative ai with We
illustrate the pipeline of the programmer + the test execu- large
language models. ArXiv, abs/2308.11339, 2023. tor agent in Fig. 11.
\[Zhang et al., 2023b\] Kechi Zhang, Zhuo Li, Jia Li, Ge Li, and Zhi
Jin. Self-edit: Fault-aware code editor for code A.5 Case Illustration
of the programmer + test generation. ArXiv, abs/2305.04087, 2023.
designer \[Zheng et al., 2023\] Qinkai Zheng, Xiao Xia, Xu Zou, Yux- We
illustrate the pipeline of the programmer + the test de- signer agent in
Fig. 12. iao Dong, Shanshan Wang, Yufei Xue, Zi-Yuan Wang, Lei Shen,
Andi Wang, Yang Li, Teng Su, Zhilin Yang, and Jie Tang. Codegeex: A
pre-trained model for code genera- tion with multilingual evaluations on
humaneval-x. ArXiv, abs/2303.17568, 2023. HumanEval Task 1 Code
Generation from typing import List

def has_close_elements(numbers: List\[float\], threshold: float) -\>
bool: """ Check if in given list of numbers, are any two numbers closer
to each other than given threshold. \>\>\> has_close_elements(\[1.0,
2.0, 3.0\], 0.5) False \>\>\> has_close_elements(\[1.0, 2.8, 3.0, 4.0,
5.0, 2.0\], 0.3) True """

CodeCoT from typing import List

def has_close_elements(numbers: List\[float\], threshold: float) -\>
bool: """ Check if in given list of numbers, are any two numbers closer
to each other than given threshold. \>\>\> has_close_elements(\[1.0,
2.0, 3.0\], 0.5) False \>\>\> has_close_elements(\[1.0, 2.8, 3.0, 4.0,
5.0, 2.0\], 0.3) True """ for i in range(len(numbers)): for j in
range(i + 1, len(numbers)): if numbers\[i\] - numbers\[j\] \<=
threshold: return True return False

AgentCoder from typing import List

def has_close_elements(numbers: List\[float\], threshold: float) -\>
bool: """ Check if in given list of numbers, are any two numbers closer
to each other than given threshold. \>\>\> has_close_elements(\[1.0,
2.0, 3.0\], 0.5) False \>\>\> has_close_elements(\[1.0, 2.8, 3.0, 4.0,
5.0, 2.0\], 0.3) True """ for i in range(len(numbers)): for j in
range(i + 1, len(numbers)): if abs(numbers\[i\] - numbers\[j\]) \<=
threshold: return True return False

      Figure 2: A case illustration of CodeCoT and AgentCoder generated code for HumanEval task.

HumanEval Task 1 Tests Generation from typing import List

def has_close_elements(numbers: List\[float\], threshold: float) -\>
bool: """ Check if in given list of numbers, are any two numbers closer
to each other than given threshold. \>\>\> has_close_elements(\[1.0,
2.0, 3.0\], 0.5) False \>\>\> has_close_elements(\[1.0, 2.8, 3.0, 4.0,
5.0, 2.0\], 0.3) True """

CodeCoT

# Testing the function with various cases

assert not has_close_elements(\[1.0, 2.0, 3.0\], 0.5) \# No two numbers
are closer than 0.5, should return False

assert has_close_elements(\[1.0, 1.4, 2.5, 3.6\], 0.5) \# 1.0 and 1.4
are closer than 0.5, should return True

assert not has_close_elements(\[\], 1.0) \# Empty list, should return
False

assert has_close_elements(\[0.1, 0.15, 0.3\], 0.06) \# 0.1 and 0.15 are
closer than 0.06, should return True

assert not has_close_elements(\[10, 20, 30, 40\], 5) \# No two numbers
are closer than 5, should return False

AgentCoder \# Basic Cases \# Test 1: Standard list with some close
elements assert has_close_elements(\[1.0, 2.5, 3.5, 5.0\], 1.0) == True

# Test 2: Standard list with no close elements

assert has_close_elements(\[1.0, 3.0, 5.0, 7.0\], 1.5) == False

# Edge Cases

# Test 1: Empty list

assert has_close_elements(\[\], 1.0) == False

# Test 2: List with all elements the same

assert has_close_elements(\[3.0, 3.0, 3.0\], 0.0) == True

# Test 3: Very small threshold

assert has_close_elements(\[1.0, 1.01, 2.0\], 0.005) == False

# Test 4: List with only two elements

assert has_close_elements(\[1.0, 2.0\], 1.5) == True

# Large Cases

large_list = \[i \* 0.1 for i in range(100000)\] \# Creates a list \[0,
0.1, 0.2, ..., 9999.9\]

# Test with a threshold where we know the outcome

# Since the list is in increments of 0.1, a threshold of 0.05 should return False

assert has_close_elements(large_list, 0.05) == False

# Test with a larger threshold where we expect a True result

# With a threshold of 0.15, adjacent elements (0.1 apart) will be within the threshold

assert has_close_elements(large_list, 0.15) == True

     Figure 3: A case illustration of CodeCoT and AgentCoder generated tests for HumanEval task.

MBPP Example Task Code Generation

Write a python function to check whether the given array is monotonic or
not.

CodeCoT

def is_Monotonic(array): """ Check whether the given array is monotonic
or not. :param array: List of integers :return: True if the array is
monotonic, False otherwise """ increasing = decreasing = True

    for i in range(1, len(array)):
        if array[i] > array[i - 1]:
            decreasing = False
        elif array[i] < array[i - 1]:
            increasing = False

    return increasing or decreasing

AgentCoder

def is_Monotonic(arr): """ Check whether the given array is monotonic or
not. Args: arr (list): Input list of integers Returns: bool: True if the
array is monotonic, False otherwise """

    # Check if array is increasing or decreasing
    increasing = decreasing = True

    for i in range(len(arr)-1):
        if arr[i] > arr[i+1]:
            increasing = False
        if arr[i] < arr[i+1]:
            decreasing = False

    # Check if either increasing or decreasing flag is True
    return increasing or decreasing




       Figure 4: A case illustration of CodeCoT and AgentCoder generated code for MBPP task.

MBPP Example Task Tests Generation

Write a python function to check whether the given array is monotonic or
not.

CodeCoT

# Self-examination with test cases

assert isMonotonic(\[1, 2, 3, 4, 5\]) == True \# Increasing sequence,
should return True assert isMonotonic(\[5, 4, 3, 2, 1\]) == True \#
Decreasing sequence, should return True assert isMonotonic(\[1, 2, 2, 3,
2\]) == False \# Non-monotonic sequence, should return False

AgentCoder

# Basic test cases

assert isMonotonic(\[1, 2, 3, 4, 5\]) == True \# Increasing sequence
assert isMonotonic(\[5, 4, 3, 2, 1\]) == True \# Decreasing sequence
assert isMonotonic(\[1, 2, 2, 3, 2\]) == False \# Non-monotonic sequence

# Edge test cases

assert isMonotonic(\[1\]) == True \# Single-element sequence assert
isMonotonic(\[\]) == True \# Empty sequence assert isMonotonic(\[1, 2\])
== True \# Two-element increasing sequence assert isMonotonic(\[2, 1\])
== True \# Two-element decreasing sequence assert isMonotonic(\[1, 1, 1,
1, 1\]) == True \# All elements are equal, considered monotonic assert
isMonotonic(\[1, 1, 1, 2, 1\]) == False \# Mixed values, not monotonic

# Large input

large_input = \[i for i in range(1, 100001)\] \# An increasing sequence
of 100,000 elements assert isMonotonic(large_input) == True \# Should be
considered monotonic

# Create a large decreasing sequence

large_decreasing_input = \[i for i in range(100000, 0, -1)\] \# A
decreasing sequence of 100,000 elements assert
isMonotonic(large_decreasing_input) == True \# Should be considered
monotonic

       Figure 5: A case illustration of CodeCoT and AgentCoder generated tests for MBPP task.

AgentCoder: Programmer Prompt **Instruction**: You are a software
programmer.

**Task**: As a programmer, you are required to complete the function
`has_close_elements`. This function should check if any two numbers in a
given list are closer to each other than a specified threshold. Use a
Chain-of- Thought approach to break down the problem, create pseudocode,
and then write the final code in Python. Ensure that your code is
efficient, readable, and well-commented.

**Input Code Snippet**:

``` python
from typing import List

def has_close_elements(numbers: List[float], threshold: float) -> bool:
  """
  Check if in given list of numbers, are any two numbers closer to each other than given threshold.

  >>> has_close_elements([1.0, 2.0, 3.0], 0.5)
  False
  >>> has_close_elements([1.0, 2.8, 3.0, 4.0, 5.0, 2.0], 0.3)
  True
  """
  # TODO: Implement the logic to determine if any two numbers are closer than the threshold
  pass

# Add your code here to complete the function
```

**Instructions**: 1. **Understand and Clarify**: Make sure you
understand the task. If necessary, write down what the function should
do. 2. **Algorithm/Method Selection**: Decide on the most efficient way
to compare the numbers in the list to find if any two are within the
threshold. 3. **Pseudocode Creation**: Write down the steps you will
follow in pseudocode. This should outline how you will iterate through
the list and compare the numbers. 4. **Code Generation**: Translate your
pseudocode into executable Python code. Remember to test your function
with the provided examples and any additional cases you think are
relevant.

                                  Figure 6: AgentCoder programmer prompt example.

AgentCoder: Programmer Response As a software developer, I'll follow the
Chain-of-Thought approach outlined in the prompt to complete the
`has_close_elements` function. Let's break it down into the four steps:

1.  **Understand and Clarify**:

    -   The task is to write a function that checks if any two numbers
        in a given list are closer to each other than a specified
        threshold.
    -   The function should return `True` if such a pair exists,
        otherwise `False`.

2.  **Algorithm/Method Selection**:

    -   A straightforward way to solve this would be to compare each
        number with every other number in the list.
    -   We can use a nested loop where each number is compared to every
        number that comes after it in the list.
    -   The absolute difference between each pair will be calculated and
        compared to the threshold.

3.  **Pseudocode Creation**:

        function has_close_elements(numbers, threshold):
            loop through each number in the list (i)
               for each number, loop through the remaining numbers in the list (j)
                 if the absolute difference between numbers[i] and numbers[j] is less than or equal to the threshold
                     return True
            if no such pair is found, return False

4.  **Code Generation**:

    -   Now, I'll translate the pseudocode into Python code.

Here's the complete function:

``` python
from typing import List

def has_close_elements(numbers: List[float], threshold: float) -> bool:
  """
  Check if in given list of numbers, are any two numbers closer to each other than given threshold.

      >>> has_close_elements([1.0, 2.0, 3.0], 0.5)
      False
      >>> has_close_elements([1.0, 2.8, 3.0, 4.0, 5.0, 2.0], 0.3)
      True
      """
      # Loop through each number in the list
      for i in range(len(numbers)):
        # For each number, loop through the remaining numbers
        for j in range(i + 1, len(numbers)):
            # If the absolute difference is less than or equal to the threshold, return True
            if abs(numbers[i] - numbers[j]) <= threshold:
               return True

      # If no such pair is found, return False
      return False
```

                                  Figure 7: AgentCoder programmer response example.

AgentCoder: Test Designer Prompt **Role**: As a tester, your task is to
create comprehensive test cases for the incomplete `has_close_elements`
function. These test cases should encompass Basic, Edge, and Large Scale
scenarios to ensure the code's robustness, reliability, and scalability.

**Input Code Snippet**:

``` python
from typing import List

def has_close_elements(numbers: List[float], threshold: float) -> bool:
  """
  Check if in given list of numbers, are any two numbers closer to each other than given threshold.

  >>> has_close_elements([1.0, 2.0, 3.0], 0.5)
  False
  >>> has_close_elements([1.0, 2.8, 3.0, 4.0, 5.0, 2.0], 0.3)
  True
  """
```

**1. Basic Test Cases**: - **Objective**: To verify the fundamental
functionality of the `has_close_elements` function under normal
conditions.

**2. Edge Test Cases**: - **Objective**: To evaluate the function's
behavior under extreme or unusual conditions.

**3. Large Scale Test Cases**: - **Objective**: To assess the function's
performance and scalability with large data samples.

**Instructions**: - Implement a comprehensive set of test cases
following the guidelines above. - Ensure each test case is
well-documented with comments explaining the scenario it covers. - Pay
special attention to edge cases as they often reveal hidden bugs. - For
large-scale tests, focus on the function's efficiency and performance
under heavy loads.

                                   Figure 8: AgentCoder tester prompt example.

AgentCoder: Test Designer Response As a tester responding to the prompt,
I will create and execute a series of Basic, Edge, and Large Scale Test
Cases for the `has_close_elements` function to ensure its robustness and
reliability. Let's begin:

**1. Basic Test Cases:**

``` python
# Test 1: Standard list with some close elements
assert has_close_elements([1.0, 2.5, 3.5, 5.0], 1.0) == True

# Test 2: Standard list with no close elements
assert has_close_elements([1.0, 3.0, 5.0, 7.0], 1.5) == False
```

**2. Edge Test Cases:**

``` python
# Test 1: Empty list
assert has_close_elements([], 1.0) == False

# Test 2: List with all elements the same
assert has_close_elements([3.0, 3.0, 3.0], 0.0) == True

# Test 3: Very small threshold
assert has_close_elements([1.0, 1.01, 2.0], 0.005) == False

# Test 4: List with only two elements
assert has_close_elements([1.0, 2.0], 1.5) == True
```

**3. Large Scale Test Cases:**

For large-scale testing, I'll focus on the function's performance with a
significantly large list. Due to the constraints of this platform, I'll
conceptualize the test case:

``` python
# Large Scale Test 1: List with 100,000 elements in a predictable pattern
large_list = [i * 0.1 for i in range(100000)] # Creates a list [0, 0.1, 0.2, ..., 9999.9]

# Test with a threshold where we know the outcome
# Since the list is in increments of 0.1, a threshold of 0.05 should return False
assert has_close_elements(large_list, 0.05) == False

# Test with a larger threshold where we expect a True result
# With a threshold of 0.15, adjacent elements (0.1 apart) will be within the threshold
assert has_close_elements(large_list, 0.15) == True
```

                                 Figure 9: AgentCoder test designer response example.

AgentCoder: Test Executor from codegeex.benchmark.execution import
check_correctness def process_humaneval_test(sample, problems,
example_test=False,language=language, test_case=True): task_id =
sample\["task_id"\] task_id = problems.index(sample) prompt =
sample\["prompt"\] code = sample\["completion"\] \# Pre-process for
different languages if language == "python" or language == "py":
test_case = sample\["test_list"\] tests = "" for test in test_case:
tests+="`\n`{=tex}"+test test_string = code + "`\n`{=tex}" + tests
return test_string

def preprocess_data(task): if
f"`py" in task["completion"]:       task["completion"] = task["completion"][task["completion"].find(f"`py")
+len(f"`py"):]       task["completion"] = task["completion"][:task["completion"].find("`")\]
elif"`" in task["completion"]:       task["completion"] = task["completion"][task["completion"].find("`")
+3:\] task\["completion"\] =
task\["completion"\]\[:task\["completion"\].find("\`\`\`")\] return task

def test_report(dataset,lg): correct = 0 for i in
tqdm(range(len(dataset))):

    dataset[i]["full_code"] = process_humaneval_test(dataset[i], dataset,

example_test=False,language=lg,test_case=False) result =
check_correctness(dataset\[i\]\["task_id"\],dataset\[i\],lg,5,"./tmp")
if result\["passed"\]==True: correct+=1 dataset\[i\]\["report_passed"\]
= result\["passed"\] dataset\[i\]\["report_result"\] =
result\["result"\] print("==============Start Report
Testing==============") correct_percent = correct/len(dataset)\*100
print(f"test_report, {correct_percent:0.2f}") return dataset

def test_agent(dataset,lg): correct = 0 for i in
tqdm(range(len(dataset))): dataset\[i\]\["full_code"\] =
process_humaneval_test(dataset\[i\], dataset,
example_test=False,language=lg,test_case=False) result =
check_correctness(dataset\[i\]\["task_id"\],dataset\[i\],lg,5,"./tmp")
if result\["passed"\]==True: correct+=1 dataset\[i\]\["result"\] =
result\["result"\] dataset\[i\]\["passed"\] = result\["passed"\]
print("============Start Agent Testing=================")
print("test_agent",correct) return dataset

model_list =
\["gpt-3.5-turbo","palm-2-codechat-bison","claude-instant-1","gpt-4-1106-preview","gpt-4"\]
language = \["py"\] for model_name in model_list:
print(f"=================={model_name}================") epoch = 5 path
= AgentCoderProgrammerSaveResultPath with open(path,"r") as f: dataset =
json.load(f) for current_epoch in range(epoch): with
open(f"./dataset/{model_name}\_{current_epoch}.json", "w") as f:
json.dump(dataset, f) test_report(dataset,lg) test_agent(dataset,lg)
dataset = call_completion(dataset,model_name,lg)

                                    Figure 10: AgentCoder test executor script.

Programmer+Test Designer **Role**: As a programmer, you are required to
complete the function `has_close_elements`. This function should check
if any two numbers in a given list are closer to each other than a
specified threshold. Use a Chain-of-Thought approach to break down the
problem, create pseudocode, and then write the final code in Python.
Ensure that your code is efficient, readable, and well-commented.

**Input Code Snippet**:

``` python
from typing import List

def has_close_elements(numbers: List[float], threshold: float) -> bool:
  '''
  Check if in given list of numbers, are any two numbers closer to each other than given threshold.

  >>> has_close_elements([1.0, 2.0, 3.0], 0.5)
  False
  >>> has_close_elements([1.0, 2.8, 3.0, 4.0, 5.0, 2.0], 0.3)
  True
  '''
  for i in range(len(numbers)):
      for j in range(i + 1, len(numbers)):
        if abs(numbers[i] - numbers[j]) <= threshold:
            return True
  return False

# Test 1: Standard list with some close elements
assert has_close_elements([1.0, 2.5, 3.5, 5.0], 1.0) == True

# Test 2: Standard list with no close elements
assert has_close_elements([1.0, 3.0, 5.0, 7.0], 1.5) == False

# Test 1: Empty list
assert has_close_elements([], 1.0) == False

# Test 2: List with all elements the same
assert has_close_elements([3.0, 3.0, 3.0], 0.0) == True

# Test 3: Very small threshold
assert has_close_elements([1.0, 1.01, 2.0], 0.005) == False

# Test 4: List with only two elements
assert has_close_elements([1.0, 2.0], 1.5) == True

# Large Scale Test 1: List with 100,000 elements in a predictable pattern
large_list = [i * 0.1 for i in range(100000)] # Creates a list [0, 0.1, 0.2, ..., 9999.9]

# Test with a threshold where we know the outcome
# Since the list is in increments of 0.1, a threshold of 0.05 should return False
assert has_close_elements(large_list, 0.05) == False

# Test with a larger threshold where we expect a True result
# With a threshold of 0.15, adjacent elements (0.1 apart) will be within the threshold
assert has_close_elements(large_list, 0.15) == True
```

**Instructions**: 1. **Understand and Clarify**: Make sure you
understand the task. If necessary, write down what the function should
do. 2. **Algorithm/Method Selection**: Decide on the most efficient way
to compare the numbers in the list to find if any two are within the
threshold. 3. **Pseudocode Creation**: Write down the steps you will
follow in pseudocode. This should outline how you will iterate through
the list and compare the numbers. 4. **Code Generation**: Translate your
pseudocode into executable Python code. Remember to test your function
with the provided examples and any additional cases you think are
relevant.

                                    Figure 11: Programmer + test executor example.

Programmer+Test Executor import doctest

# Function definition as a string

text = """ from typing import List

def has_close_elements(numbers: List\[float\], threshold: float) -\>
bool: ''' Check if in given list of numbers, are any two numbers closer
to each other than given threshold.

> > > has_close_elements(\[1.0, 2.0, 3.0\], 0.5) False
> > > has_close_elements(\[1.0, 2.8, 3.0, 4.0, 5.0, 2.0\], 0.3) True '''
> > > for i in range(len(numbers)): for j in range(i + 1, len(numbers)):
> > > if abs(numbers\[i\] - numbers\[j\]) \<= threshold: return True
> > > return False """

# Execute the function definition

exec(text)

# Run doctest

if **name** == "**main**": doctest.testmod()

                                    Figure 12: Programmer + test designer example.


