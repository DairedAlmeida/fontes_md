                                                                                                                                                                                         1




                                             A Survey on Code Generation with LLM-based Agents
                                                       Yihong Dong*, Xue Jiang*, Jiaru Qian*, Tian Wang, Kechi Zhang, Zhi Jin, and Ge Li

                                              Abstract—Code generation agents powered by large language models (LLMs) are revolutionizing the software development paradigm.
                                              Distinct from previous code generation techniques, code generation agents are characterized by three core features. 1) Autonomy:
                                              the ability to independently manage the entire workflow, from task decomposition to coding and debugging. 2) Expanded task scope:
                                              capabilities that extend beyond generating code snippets to encompass the full software development lifecycle (SDLC). 3) Enhancement
                                              of engineering practicality: a shift in research emphasis from algorithmic innovation toward practical engineering challenges, such
                                              as system reliability, process management, and tool integration. This domain has recently witnessed rapid development and an
                                              explosion in research, demonstrating significant application potential. This paper presents a systematic survey of the field of LLM-
                                              based code generation agents. We trace the technology’s developmental trajectory from its inception and systematically categorize its
                                              core techniques, including both single-agent and multi-agent architectures. Furthermore, this survey details the applications of LLM-
                                              based agents across the full SDLC, summarizes mainstream evaluation benchmarks and metrics, and catalogs representative tools.

arXiv:2508.00083v1 \[cs.SE\] 31 Jul 2025

                                              Finally, by analyzing the primary challenges, we identify and propose several foundational, long-term research directions for the future
                                              work of the field.

                                              Index Terms—Code Generation; Software Development; Large Language Models; LLM-based Agent; Multi-agent System

                                                                                                                ✦



                                         1    I NTRODUCTION                                                       and rapidly become one of the most promising application
                                                                                                                  directions for LLM technology.
                                         Code generation aims to automatically transform human                        Although LLM-based code generation techniques have
                                         intentions expressed in certain specifications into executable shown excellent performance in generating standalone pro-
                                         computer programs, serving as a fundamental approach grams [7–9], their single-response mode exposes significant
                                         to improving software productivity. Early research in code limitations when handling complex, engineering-oriented
                                         generation primarily adopted program synthesis meth- software development tasks. Native LLMs lack the ability
                                         ods [1], deriving verifiably correct programs through formal to autonomously decompose tasks, interact with real devel-
                                         specifications. However, due to the difficulty of writing opment environments, validate generated code, and imple-
                                         specifications, this approach was long confined to well- ment continuous self-correction mechanisms. As a result,
                                         defined specific tasks. To enhance generalization capa- they struggle to independently complete software devel-
                                         bilities, research subsequently shifted toward data-driven opment tasks that require cross-file context understanding,
                                         paradigms based on deep learning, treating code gener- dynamic debugging, and iterative optimization. To address
                                         ation as a probabilistic sequence learning problem [2, 3]. these problems, LLM-based code generation agents have
                                         Nevertheless, code snippets generated by such methods been proposed, which use LLMs as the brain to construct
                                         often had limited functionality and frequently contained code agents capable of autonomous planning, action, obser-
                                         syntactic or semantic errors, leading to compilation or ex- vation, and iterative optimization [10–12]. They are capable
                                         ecution failures. Consequently, automated program writing of simulating the complete workflow of human program-
                                         has long been considered an extremely challenging task. mers, including analyzing requirements, writing code, run-
                                         This situation fundamentally changed with the emergence ning tests, diagnosing errors, and applying fixes [13, 14].
                                         of Large Language Models (LLMs) [4–6]. Although LLM This comprehensive capability enables them to handle com-
                                         technology originated from natural language processing, it plex programming tasks that exceed the limitations of in-
                                         has also demonstrated remarkable potential in code gen- dividual LLMs, thereby producing higher-quality and more
                                         eration tasks. This is primarily attributed to the massive reliable software outputs. Such advancements represent a
                                         code contributions from open-source communities repre- critical step toward achieving higher levels of automation in
                                         sented by GitHub in the vast pre-training corpora, enabling software development. This pursuit is closely aligned with
                                         models to master the syntax and semantics of program- the historical evolution of software engineering. Over time,
                                         ming languages as well as programming algorithms and development paradigms have shifted from individual pro-
                                         paradigms. Benefiting from this, the field of code generation gramming to team-based collaborative development. This
                                         has ushered in unprecedented development opportunities transition has been driven by the growing complexity of
                                                                                                                  software systems and the corresponding need for a clear
                                                                                                                  division of labor.
                                         • Version: v1 (July 20, 2025).                                               LLM-based code generation has been extensively dis-
                                         • GitHub link: https://github.com/JiaruQian/awesome-llm-based-agent4code
                                         • * The authors contribute equally to this work.                         cussed  and surveyed, while systematic research on code
                                         • The authors are mainly with the School of Computer Science, Peking     generation agents remains insufficient. To stimulate explo-
                                             University, Beijing, China;                                          ration in this field, we emphasize three core distinctions be-
                                             Contact e-mail: dongyh, jiangxue@stu.pku.edu.cn;
                                                                                                                  tween code generation agents and previous code generation

2

techniques. First is autonomy. Traditional code generation covering key
technologies, evaluation methods, deployed models assist human
developers through code completion tools, and various applications
throughout the software or function generation in a passive manner. In
contrast, code development lifecycle, aiming to provide a solid
knowledge generation agents can actively manage and execute develop-
foundation for researchers in this field. We understand that ment
workflows from requirements to implementation \[15-- there have been
previous English survey articles on LLM- 17\]. This paradigm transforms
the role of the developer based agents for software engineering
\[37--40\], which focus from code writer to task definer, process
supervisor, and on classifying technologies from an application perspec-
final result reviewer. The second distinction is the expansion tive.
However, we believe that despite varying application of code generation
task scope. Previous code generation scenarios, the underlying technical
methods are common. research typically involved tasks with clear
boundaries and Therefore, this work differs from existing surveys in two
well-defined specifications, such as completing code lines ways: First,
we classify and introduce from a method- based on context and generating
function bodies based on ological perspective, providing relatively
in-depth technical function signatures \[18\]. Code generation agents,
however, references for research and development of code generation can
cover most tasks in software development, includ- agents; Second, given
the rapid development of this field, ing handling ambiguous requirements
\[19\], implementing we focus on integrating the latest research
advances and entire project coding \[15--17\], testing and refactoring
pro- challenges faced. grams \[20--22\], and iterative optimization
based on real- The structure of this paper is organized as follows: We
time feedback \[11\]. Finally, there is a shift in research focus first
introduce relevant background knowledge, technolog- from algorithmic
innovation to engineering practice. Early ical development, and core
concepts. Then, we deeply ex- code generation research focused primarily
on improving plore key technologies of code generation agents (covering
algorithmic accuracy, such as enhancing model architectures both
single-agent and multi-agent systems); subsequently, or optimizing
training methods to pursue higher code syn- we discuss specific
applications and evaluation methods of tactic correctness and semantic
matching \[3, 23--25\]. The these code generation agents in software
development and research focus of code generation agents has
significantly catalog representative tools in the market; finally, the
article shifted toward engineering implementation, including how
analyzes current challenges in the field and prospects for to ensure
agent reliability \[12, 26\], how to manage com- future directions,
providing a summary of the entire work. plex workflows \[17, 27\], and
how to enable agents to efficiently invoke external tools \[28, 29\].
These problems 2 L ITERATURE C OLLECTION AND T ECHNOLOGI - have expanded
from pure model generation capabilities to CAL D EVELOPMENT T REND A
NALYSIS system design, process management, and human-computer
collaboration, entering territories closer to classical software 2.1
Literature Collection engineering. To ensure the completeness and
comprehensiveness of the Today, LLM-based code generation agents are
pro- research, this study employed systematic literature retrieval
foundly impacting software development. Tools represented methods to
collect all relevant high-quality literature as by Claude Code and
Cursor can already preliminarily com- comprehensively as possible. This
research selected author- plete end-to-end software development through
multi-agent itative academic databases, including ACM Digital Library,
collaborative division of labor, typically with lower time IEEE Xplore,
SpringerLink, Google Scholar, DBLP Com- and cost than human teams. Vibe
Coding has become a puter Science Bibliography, and China National
Knowledge popular programming practice, where developers use nat-
Infrastructure (CNKI), to conduct literature retrieval, ensur- ural
language prompts to describe problems and provide ing the
comprehensiveness and authority of the retrieval them to specialized
LLMs for software development, which scope. The literature retrieval
time span covered from 2022 then generate software \[30\]. However, some
important prob- to June 2025, encompassing important development stages
lems remain unresolved. First, integrating code generation and the
latest advances in this research field. agents with real development
environments faces numer- We adopted a bilingual retrieval strategy in
both Chi- ous difficulties. Actual software projects often contain large
nese and English. The Chinese and English search key- and private
codebases, customized build processes, internal word combination was
"('Code Generation' OR 'Software API calling specifications, and
unwritten team conventions. Development') AND ('LLM' OR 'Large Language
Model' How to enable agents to efficiently understand and utilize OR
'Large Model' OR 'Language Model') AND ('Agent' OR this non-public,
highly contextualized information is a criti- 'Multi-agent' OR
'Agentic')". The retrieval fields covered cal challenge that must be
solved for their transition from titles, abstracts, keywords, and index
terms. To ensure lit- general demonstrations to professional tools.
Then, code erature quality, the retrieval scope was limited to top-tier
generated by agents often contains logical defects, perfor-
international academic conferences and journals in software mance
pitfalls, or security vulnerabilities that are difficult to engineering
and artificial intelligence recommended by the cover with unit tests
\[31--36\], forcing developers to invest China Computer Federation
(CCF), including ICSE, ISSTA, unexpected effort in code review and
manual repairs. ASE, FSE, TOSEM, TSE, ACL, ICML, ICLR, AAAI, and other
Facing opportunities and challenges, we need more at- international
top-tier conferences and journals, as well as tention to the research
and development of code generation CCF-A Chinese journals such as
Journal of Computer Re- agents. To this end, this survey comprehensively
reviews search and Development, Journal of Software, Science China
relevant literature, introduces concepts and knowledge of Information
Sciences, and Chinese Journal of Computers. LLM-based code generation
agents, and systematically re- Additionally, given the rapid development
of this field, views the latest advances in code generation agents,
mainly to track the latest research developments, this study also col- 
3

lected high-quality works published on preprint platforms 3 BACKGROUND K
NOWLEDGE such as arXiv. This research further expanded the retrieval 3.1
Code Generation in Software Engineering scope through forward and
backward snowball searching Code generation \[9, 41, 42\] refers to the
process of auto- for each piece of literature. Through the above
retrieval matically converting structured or unstructured input in-
strategies, 447 candidate literature pieces were initially ob- formation
(i.e. natural language requirement descriptions, tained. system design
documents, existing code snippets, etc.) into We screened the retrieved
literature with five screen- source code. Its essence is to map abstract
intentions or ing criteria: (1) Exclude duplicately published papers and
task objectives to specific programming implementations, multiple
versions of similar content from the same research aiming to reduce
manual coding costs, improve develop- team to avoid content redundancy.
(2) Manually evaluate ment efficiency, and to some extent reduce human
errors, literature from preprint platforms like arXiv, retaining only
ultimately achieving the goal of software development au- works with
significant academic impact1 and innovation. tomation. This task
typically requires that the generated (3) Exclude books, dissertations,
and conference short pa- results are syntactically legal, semantically
consistent with pers, retaining only complete academic papers published
expectations, and capable of running correctly in the target in
authoritative journals and conferences. (4) Focus on environment.
technical innovation papers, excluding pure technical re- The complexity
and task diversity of modern software ports, empirical surveys, and
review literature. (5) Conduct development pose new requirements for
code generation in-depth content analysis and manual review of initially
technology to handle open and complex needs. Meanwhile, screened
literature, eliminating literature with low relevance the industry
urgently expects to comprehensively integrate to the research topic. The
above screening rules ensured code generation methods into development
processes to high quality and high relevance of the literature collec-
improve efficiency. Against this background, traditional tion: Rule (1)
avoided research content redundancy; Rules code generation techniques
encounter three fundamental (2)(3)(4) focused on core technological
breakthroughs and limitations \[43--45\]. First, they lack sufficient
contextual un- frontier developments in the field; Rule (5) ensured high
derstanding, rendering them ineffective in processing open- matching
between literature and research objectives. After ended or high-level
instructions. Second, their generative strict screening, 100
high-quality core literature pieces were capacity is limited, making it
challenging to produce logi- finally obtained, constituting the main
analysis objects of cally coherent and functionally complete code.
Third, they this research. exhibit poor generality and flexibility,
hindering their ability to adapt to diverse software development tasks.
In recent years, the emergence of large language models has opened 2.2
Technological Development Trend Analysis new avenues for addressing
these challenges. Figure 1 shows the distribution of papers related to
LLM- based code generation agents. Figure 1(a) shows statistics 3.2
Large Language Models on the number of related papers published in
different Large Language Models (LLMs) \[46--49\] are a class of pre-
years. From the data in Figure 1(a), it can be found that trained
language models based on deep learning technol- the number of papers
published in this field shows a year- ogy, primarily using the
Transformer model \[50\] as the core over-year increasing trend. Since
its emergence in 2023, code architecture. The basic idea is to learn
statistical patterns, se- generation agents have shown tremendous
potential, and mantic structures, and contextual relationships in
language subsequently, the attention and research enthusiasm from
through unsupervised pre-training on massive text corpora. academia and
industry have rapidly increased, with the The core task of LLMs is
typically conditional language number of related studies also growing
significantly. Fig- modeling, i.e., predicting subsequent tokens given
context, ure 1(b) lists statistics on the number of related papers pub-
formally expressed as maximizing conditional probability lished in
top-tier academic conferences or journals each year P (xt \|x1 , x2 , ·
· · , xt−1 ). This mechanism enables LLMs to since the emergence of code
generation agent technology. possess powerful language understanding and
generation Papers related to code generation agents appear not only in
capabilities. top-tier software engineering conferences and journals
(such In the field of code generation, since training data as ICSE, ASE,
FSE, ISSTA, TOSEM) but are also frequently contains a large amount of
high-quality open-source code accepted by mainstream conferences in
natural language libraries and programming documentation, LLMs can learn
processing and artificial intelligence (such as ACL, ICLR, and master
syntactic rules of multiple programming lan- NeurIPS, ICML, AAAI),
indicating that related research has guages as well as common
programming paradigms, while received widespread attention from multiple
disciplinary understanding the mapping relationship between natu-
fields. Additionally, due to the rapid technological develop- ral
language descriptions and code logic, thereby achiev- ment in this field
and certain lag in traditional paper review ing generation of executable
code from natural language cycles, many research results are published
as preprints on descriptions, or intelligent completion and refactoring
in arXiv, many of which have received high citation counts and existing
contexts. Typical code generation LLMs include have had important
impacts on field development. Codex \[51\], CodeLlama \[52\],
DeepSeek-Coder \[53\], and Qwen2.5-Coder \[54\], etc., which have been
widely applied in software engineering scenarios such as code
completion, 1. The citation count of the literature exceeds the citation
threshold for hot papers in the SCI computer science discipline during
the same test code generation, and bug fixing, demonstrating power-
period https://esi.clarivate.com/ThresholdsAction.action. ful code
generation and understanding capabilities.  4

                                                      , 6 6 7 $                                                                                                                 
                                                          $ 6 (                                                                                                                                     
                                                               7 2 6 ( 0   
                                                                       ) 6 (   
                                                                            ( 0 1 / 3                                                                                                                                   
                                                                                    $ $ $ ,                                                                                     




                                                                                                                           1 X P E H U  R I  S X E O L V K H G  S D S H U V
                                                                                            1 , 3 6   

                                                                                                     1 $ $ & /                                                                  

 D U ; L Y      , & 6 (           , & / 5      

                                                                                    , & 0 /                                                                                     
                                                                                                                                                                                                                   
                                                                                                                                                                                                                   - D Q    - X Q 
                                     $ & /                                                                                                                                                      < H D U
                      (a) Distribution of papers published by year                                                                                              (b) Distribution of papers published by conference or journal

                                       Fig. 1: Distribution of papers related to LLM-based code generation agents.


    In addition to basic language modeling capabilities,                                                               them to directly process unstructured text instructions, un-

LLMs also exhibit various important emergent abilities. First derstand
complex semantic intentions, and in the absence is planning capability,
where LLMs can generate natural of explicit supervisory signals,
autonomously organize and language plans to guide subsequent generation
\[55, 56\]. execute tasks by combining environmental perception, lan-
Second is tool usage capability, where LLMs can actively guage planning,
and tool invocation. Due to the complexity, invoke external tools based
on task requirements to en- modularity, and collaborative nature of
software engineer- hance problem-solving capabilities. By encapsulating
avail- ing, the code generation field was among the first to see able
tool API calls, existing work has been able to inte- applications of
LLM-based agents. grate various external tools, such as search engines
\[57\], LLM-based agents mainly include core components such calculators
\[58\], and compilers \[59\], etc., to further expand as planning,
memory, tool usage, and reflection. The plan- the capability boundaries
of LLMs. Third is environmen- ning component is responsible for task
decomposition, tal interaction capability, where LLMs have the ability
to breaking large tasks into smaller, manageable sub-goals, receive
feedback from external environments and execute thereby efficiently
handling complex tasks. The memory operations according to instructions,
enabling perception, component is divided into short-term memory and
long- decision-making, and action in dynamic environments. The term
memory, where short-term memory is implemented emergence of these
advanced capabilities has led to the through the context window of LLMs.
Through prompt en- creation of agents, enabling LLMs to evolve from
simple gineering \[64, 65\], information directly related to the current
text generation tools to agent systems capable of completing task is
placed into this working memory, thereby guiding more open and complex
tasks. the model's immediate reasoning and behavior. Long-term memory
breaks through the capacity limitations of context windows by
constructing external persistent knowledge 3.3 LLM-based Agents bases.
Current mainstream technical implementations adopt LLM-based Agents
\[60--63\] are a class of system archi- the Retrieval Augmented
Generation (RAG) \[66, 67\] frame- tectures that use LLMs as the core
reasoning engine, in- work, encoding massive information into
high-dimensional tegrating perception, memory, decision-making, and ac-
vectors and storing them in dedicated vector databases. tion modules to
enable models with autonomous task ex- When agents need to invoke
historical experience or domain ecution capabilities. Agents, as a
fundamental paradigm knowledge, they can quickly locate and extract
relevant in artificial intelligence, initially focused primarily on
information through efficient vector similarity retrieval al-
perception-decision-execution loops under reinforcement gorithms. The
reflection component allows agents to ex- learning frameworks,
emphasizing the interaction process amine, evaluate, and correct their
own generated content between models and environments and long-term
reward or existing data, thereby improving past action decisions
optimization. With the widespread success of LLMs in nat- and correcting
previous errors for continuous improvement. ural language reasoning
tasks, researchers began attempt- The tool usage component interacts
with external physical ing to use them as decision cores to construct
LLM-based or digital environments, enabling agents to transcend their
agents. The language modeling capability of LLMs enables native model
limitations. Language models themselves are  5

                                                            Self-Collaboration (4-15)

                                                            ChatDev (7-16)

                                                            WebAgent (7-24)             MapCoder (5-18)           CodeCoR (1-14)
          GPT-3 (5-28)             ChatGPT (11-3)
                                                            MetaGPT (8-1)               AgileCoder (6-16)         PatchPilot (2-4)

                                                            CodePlan (9-21)             OpenHands (7-23)          CodeSim (2-8)
           2020             2022
                                                            LATS (10-6)                 PairCoder (9-8)           SyncMind (2-10)

         Self-Planning (3-12)                   2023        Lemur (10-10)               HyperAgent (9-9)          AIDE (2-18)

           Self-Refine (3-30)                                                           AutoSafeCoder (9-16)      DARS (3-18)
                                       CodeAgent (1-14)
           Self-Debug (4-11)                                                            SWE-Search (10-26)        MARCO (5-6)
                                           CodePori (2-2)
               Self-Edit (5-6)                                                          CodeTree (11-7)           AdverIntent-Agent (5-19)
                                       CleanAgent (3-13)
                                                                          2024
           Self-Repair (6-16)                                                                                     SEW (5-24)
                                       RepairAgent (3-25)

                                                SoA (4-2)
                                                                                                 2025 (By June)
                                     AutoCodeRover (4-8)

                                              MARE (5-6)

                                         SWE-agent (5-6)

Fig. 2: Evolution of key technologies in LLM-based code generation
agents, where works not marked in yellow are important prerequisite
technologies.

closed systems with knowledge cutoff dates and lack the is essentially a
single, passive response process. Models ability to perform computations
or invoke external APIs. receive inputs, generate outputs based on their
pre-trained The tool usage module greatly enhances their action space
knowledge, and the entire process lacks active planning, by granting
agents permission to invoke external functions state maintenance, or
continuous interaction with external or APIs. environments. This limits
their performance when handling From the perspective of composition and
interaction complex, ambiguous, or multi-step collaborative software
complexity, agent systems can be divided into single-agent development
tasks. and multi-agent categories. LLM-based agents, on the other hand,
construct a dy- • Single Agent: Refers to an independent centralized
namic workflow with autonomy, interactivity, and itera- agent that
autonomously completes all tasks through tivity, integrating the
generation capabilities of LLMs into its inherent planning, tool usage,
and reflection capabil- an intelligent system capable of active
planning, execution, ities. There is no complexity of inter-agent
interaction. observation, and adjustment. In the field of code gener- •
Multi-Agent: Refers to systems composed of multi- ation, LLM-based
agents not only utilize the generation ple heterogeneous or homogeneous
agents. In multi- capabilities of LLMs but also endow them with
capabilities agent systems, goals are achieved through communica- for
task decomposition \[70, 71\], tool invocation (such as tion,
collaboration, and negotiation between agents. In compilers, API
documentation queries) \[72, 73\], and self- multi-agent systems,
role-based professional division of correction based on feedback (such
as execution errors, user labor is a common collaborative enhancement
strategy. feedback) \[74, 75\]. LLMs serve as reasoning engines in agent
By assigning specific roles to different agents (such as frameworks,
responsible for making decisions based on "analyst", "programmer",
"tester"), problems that far current environmental states and
determining next actions, exceed the capabilities of individual agents
in scale and thereby driving tasks to gradual completion. complexity can
be solved. 4 K EY T ECHNOLOGIES AND M ETHODS 3.4 Differences Between
LLMs and LLM-based Agents This chapter introduces the key technologies
and methods LLMs and LLM-based agents exhibit architectural and capa- of
LLM-based code generation agents, divided into two bility differences
when solving code generation tasks \[37\], main categories: single-agent
code generation methods and specifically: multi-agent code generation
systems. Single-agent methods The core advantage of LLMs lies in their
powerful con- form the foundation for building multi-agent systems. We
textual generation capabilities \[68, 69\], enabling them to will first
introduce three key technologies in single-agent efficiently predict and
output semantically coherent code systems, including planning and
reasoning techniques, tool snippets based on given inputs. However,
their operation integration and retrieval enhancement, and reflection
and  6

self-improvement mechanisms. In the multi-agent code gen- Building on
the above methods, PlanSearch \[56\] first for- eration systems section,
we will focus on collaboration malized the planning process as an
explicit search task, gen- mechanisms between agents, expanding from
three aspects: erating multiple sets of candidate plans and conducting
par- how to arrange workflows in code generation agent sys- allel
evaluation during the reasoning phase to find optimal tems, how to
achieve efficient information interaction and solutions within a larger
solution space. In terms of plan- management between agents, and how to
transform mul- ning structure, both CodeTree \[81\] and Tree-of-Code
\[82\] tiple agents into a more capable overall system through extended
previous linear structures to tree structures. Code- collaborative
optimization. We have organized the key tech- Tree organizes the code
generation process into a unified nologies and methods chronologically,
as shown in Figure 2. tree structure that explicitly models the
sequential stages of strategy exploration, solution generation, and
iterative refinement. By incorporating execution-based feedback at 4.1
Single-Agent Code Generation Methods each stage, it enables dynamic
scoring and heuristic-guided 4.1.1 Planning and Reasoning Techniques
pruning to efficiently navigate the large search space. Tree- Explicit
planning is widely recognized as one of the key of-Code explores
multiple potential paths through breadth- pathways to enhance the
structured reasoning capabilities of first generation strategies and
combines execution signals LLMs. Self-Planning \[10\] was the first
approach to system- for branch pruning. Subsequently, multi-stage guided
cod- atically introduce the planning phase into code generation ing
methods emphasize dividing the planning process into tasks. In this
framework, the model is required to first multi-stage control,
introducing hierarchical objectives and produce a sequence of high-level
solution steps prior to intermediate reward signals to alleviate goal
drift prob- generating any executable code. It then implements each lems
in end-to-end generation processes. Based on this, step according to the
predefined plan, enabling the decom- DARS \[83\] further adopts adaptive
tree structures to en- position of complex problems and mitigating the
overall hance the decision process, branching new planning paths
difficulty of code synthesis. at key decision nodes of original planning
paths based on Building on this foundation, CodeChain \[11\] introduced
code execution feedback, and dynamically selecting better clustering and
self-revision in the planning phase, guiding planning paths by combining
historical trajectories with the model to construct reusable modular
code through execution results. Additionally, for hardware tasks,
Verilog- multiple iterations. Subsequently, CodeAct \[76\] introduces
Coder \[84\] introduced graph-structured planning mecha- a unified
action space for the agent by representing all nisms and waveform
tracing tools based on abstract syntax actions as executable Python
code. By integrating a Python trees, supporting structural modeling and
semantic verifica- interpreter into the agent architecture, CodeAct
enables tion of Verilog code, demonstrating the adaptive potential
immediate code execution, real-time feedback from the of planning
paradigms in cross-modal and domain-specific environment, and dynamic
adjustment of actions through tasks. To address the challenge that
traditional search meth- multi-turn interactions. KareCoder \[77\]
achieves external ods are difficult to apply in non-serializable
environments, knowledge injection by integrating knowledge from li-
Guided Search \[85\] proposes two complementary strategies, braries into
the planning and reasoning process of LLMs. namely one-step lookahead
and trajectory selection. Both WebAgent \[78\] extended the planning
mechanism to web strategies are guided by a learned action-value
estimator, automation scenarios, introducing a structured three-stage
where the model predicts potential next-step outcomes to strategy:
instruction decomposition, HTML content sum- evaluate candidate actions,
and selects promising solution marization, and program synthesis. It
leverages LLMs to trajectories based on their empirical success rates.
This en- decompose natural language instructions into standard- ables
effective exploration without relying on environment ized
sub-instructions, extract task-relevant information from state
serialization. lengthy HTML documents, and generate executable Python In
summary, these methods reflect a shift from single- programs
accordingly. Meanwhile, CodePlan \[79\] intro- path to multi-path
exploration, and from linear to struc- duced multi-stage control flow
and combined with custom tured planning. They highlight the growing
importance control instructions, enabling the model to dynamically se-
of planning techniques in enhancing the effectiveness and lect
"generate" or "modify" operations during the reasoning flexibility of
single-agent code generation approaches. process. Enhancing the breadth
and diversity exploration capa- 4.1.2 Tool Integration and Retrieval
Enhancement bilities of candidate solutions is another important
direction Integrating external tools with LLMs is one of the keys for in
single-agent framework development. To this end, GIF- single agents to
break through their own generation capabil- MCTS \[80\] introduced Monte
Carlo Tree Search (MCTS) ity boundaries. Building on Toolformer \[58\],
ToolCoder \[72\] mechanisms into the code generation process, systemati-
proposed a code generation method that combines API cally exploring
multiple potential generation paths. This search tools with LLMs. To
achieve accurate tool invoca- method constructs decision trees through
multiple sampling tion, ToolCoder automatically annotates training data,
en- in each generation round, combined with execution feed- abling the
model to learn to use search tools to actively back to score and filter
each candidate branch, not only query APIs, effectively alleviating API
invocation errors expanding the solution space but also significantly
improv- caused by model hallucinations. ToolGen \[29\] integrated ing
the robustness and generalization capabilities of the automatic
completion tools into the code generation process model in
multi-solution tasks. As a representative reasoning of LLMs, solving
dependency problems in code generation enhancement strategy, GIF-MCTS
achieved a transition from (i.e., undefined variables and member errors)
through of- single-path planning to multi-path parallel reasoning. fline
model fine-tuning and online automatic completion  7

    Single-Agent Code Generation            Planning and Reasoning Techniques

           Create a quick-sort               Create a quick-sort                            Planned Path Generation
           algorithm in Python.              algorithm in Python.
                  Query                                                                    Candidate Branch Selection       Generating the
                                                      Query                   Agent                                          Optimal Plan


                                            Tool Integration and Retrieval Enhancement
            LLM-Based Agent
                                                                                                          Compiler      Online      Static
                                                                                External Tool                          Searching   Analysis
                                                                                 Integration

                                                              Agent                                      Step 1：Vector Database Retrieval
                                               Plan                                                      Step 2：Prompt Augmentation
       Planning    Tools    Reflection                                        Retrieval Augmented        Step 3：LLM-based Code Generation
                                                                                   Generation



        def QuickSort(nums):                Reflection and Self-Improvement The numbers should be
                                                                                      sorted in ascending order.
        ```                                                                                                          Autonomous Refinement
                                             def QuickSort(nums):
        Sort a list of numbers in
                                             ```                 √ Refined!
        ascending order using the
                                             Sort a list of numbers in
        QuickSort algorithm
                                             ascending order using the
        ```
                                             QuickSort algorithm
                                             ```                                                Agent
                  Output                                                                                               Failure Diagnosis
                                                  Generated Code


                                    Fig. 3: Overview of single-agent code generation methods

tool integration. To further enhance the ability of LLMs to
dependencies. To enable agents to no longer rely on pre- handle complex
requirements and complex dependencies registered function APIs and other
tools, CodeNav \[88\] au- in projects, CodeAgent \[28\] integrated five
programming tomatically indexes past real repositories based on require-
tools for the model (including website search, document ments during
code generation, importing relevant functions reading, code symbol
navigation, format checker, code in- and code blocks, and adjusting
based on execution result terpreter), supporting interaction with
software components feedback. Meanwhile, AUTOPATCH \[89\] applied RAG to
to achieve information retrieval, code implementation, and runtime
performance optimization problems, combining code testing functions. In
terms of tool feedback mecha- historical code examples with control flow
graph (CFG) nisms, ROCODE \[86\] introduces a closed-loop mechanism
analysis for context-aware learning, and optimizing code that integrates
code generation, real-time error detection, through contextual prompts
to models. Building on this, and adaptive backtracking. During the
generation process, to improve the structured expression capability of
retrieval ROCODE continuously monitors the compilation output contexts,
Knowledge Graph Based Repository-Level Code and automatically initiates
backtracking when syntax errors Generation \[90\] proposed representing
code repositories are detected. It further employs static program
analysis as knowledge graphs, improving retrieval quality from to
identify the minimal necessary modification scope, en- structural and
relational perspectives, achieving over 10% abling efficient and
targeted rewriting. To enhance step-by- improvement in project-level
code generation tasks, demon- step control of tool invocation, CodeTool
\[87\] introduced strating the importance of structure-aware retrieval
for high process-level supervision mechanisms, explicitly modeling
contextual accuracy. Furthermore, cAST \[91\] addressed the and
supervising each step of tool invocation processes, "chunking" problem
in RAG pipelines by proposing a improving the accuracy and robustness of
tool invocation, structured chunking mechanism based on abstract syntax
and efficiently integrating tool feedback into the generation trees
(AST), improving the syntactic completeness of code process through
incremental debugging strategies. retrieval through recursive
partitioning and semantic coher- In recent years, Retrieval-Augmented
Generation (RAG) ent block merging, significantly improving metrics such
as methods have also emerged as a form of external tool in- Recall and
Pass@1. vocation. RAG methods retrieve relevant information from In
specific domains, tool integration design exhibits knowledge bases or
code repositories before generation to stronger structural constraints
and domain coupling. construct richer contexts, thereby alleviating
limitations of AnalogCoder \[92\], facing analog circuit design tasks,
pro- knowledge, model hallucinations, and data security issues. posed
encapsulating simulator functions and language In this direction,
RepoHyper \[73\] established repository- models as "circuit library"
invocation interfaces, and de- level vector retrieval systems,
supporting the location of signed feedback enhancement and subcircuit
reuse mech- reusable code segments from large-scale code bases and
anisms, enabling the model to complete structurally rea- using them as
context for joint generation, effectively im- sonable circuit generation
without additional training. Sim- proving the control from the model
over long-distance ilarly, VerilogCoder \[84\] focused on hardware code
gen-  8

eration, achieving cross-stage logic verification and fine- explanatory
text to help the code model understand error grained control by
integrating syntax tree-level waveform causes and complete repairs
accordingly. tracing tools, maintaining consistency and adjustability of
To address issues of structural disorganization in com- generation in
complex hardware logic relationships. These plex programs, CodeChain
\[11\] introduces a modular self- vertical domain integration solutions
demonstrate the enor- revision framework that promotes structured and
main- mous potential of tool invocation in professional task mod-
tainable code generation. The method guides the model eling and provide
transferable insights for tool fusion design to iteratively refine code
by first identifying and cluster- in general scenarios. ing
representative sub-modules from initial outputs, and In summary, single
agents effectively expand their per- then leveraging these sub-modules
to enhance subsequent ception range and execution capabilities through
external generations. Through this iterative process, the model is tool
integration and retrieval enhancement, improving the encouraged to reuse
verified components, thereby improv- accuracy, efficiency, and
consistency of model generation, ing the modularity, logical coherence,
and correctness of the constructing tool invocation solutions from
general tasks to generated programs. Building on this, LeDeX \[96\]
enhances domain-specific tasks. the closed-loop self-debugging framework
by enabling the model to perform stepwise annotation and analysis of er-
4.1.3 Reflection and Self-Improvement roneous code, followed by
generating repair solutions and Reflection and self-improvement
mechanisms offer an ef- verifying their correctness through execution
results. Addi- fective approach for enhancing code generation in single-
tionally, LeDeX collects data generated during this iterative agent
systems. Unlike one-shot generation methods, these process to construct
high-quality training datasets. These approaches enable the model to
review its intermediate datasets are then used to fine-tune open-source
models, outputs, provide internal feedback, and iteratively refine
significantly improving their code repair capabilities. the code during
the generation process. By mimicking the Overall, current research has
formed a relatively clear human process of generating, evaluating, and
revising code, technical system in reflection and self-improvement mech-
they help improve the overall correctness and quality of the anisms:
from natural language-level self-feedback to auto- final output. matic
repair combined with execution results, to module- To address the
limitations of one-step generation, such level optimization based on
program structure and multi- as the frequent occurrence of bugs and
logical errors, Self- solution evaluation. These methods not only
improve the Refine \[74\] introduces an iterative refinement framework.
performance capabilities of single-agent systems in code After
generating an initial output, the model performs nat- generation tasks
but also provide support for subsequent ural language self-evaluation to
identify potential issues. in-depth research in test-time/inference-time
computational Based on this feedback, it revises the output to improve
scaling and multi-agent collaboration. quality. This approach requires
no additional training or supervision and has demonstrated strong
generality and 4.2 Multi-Agent Code Generation Systems effectiveness
across a range of tasks, including code gener- ation and logical
reasoning. Self-Iteration \[93\] builds upon 4.2.1 Multi-Agent System
Workflows prior reflection-based methods by addressing the problem
Multi-agent system workflows mainly include four of error accumulation
in complex code generation tasks. It types: pipeline-based labor
division, hierarchical planning- introduces a structured iterative
framework that integrates execution mechanisms, self-negotiation
circular optimiza- principles from software development, assigning roles
such tion, and self-evolving structural updates. as analyst, designer,
developer, and tester to guide the In the pipeline-based division of
labor paradigm, each generation process. In each iteration, the model
refines agent is responsible for a specific stage in the software
requirements, adjusts design, and revises code based on development
process and passes intermediate products to feedback from prior outputs.
This role-based approach helps the next agent for processing. The
process shows obvious the model identify flawed module structures and
progres- sequentiality. Self-Collaboration \[15\], which builds upon the
sively improve code readability and functional complete- traditional
waterfall model used in software engineering. ness. Addressing the
difficulty of model self-diagnosis in the It defines a classic
three-stage multi-agent process that in- absence of feedback conditions,
Self-Debug \[94\] introduced cludes "requirement analysis," "coding
implementation," ideas analogous to "rubber duck debugging", using few-
and "testing". In this process, agents work independently shot examples
to guide the model to perform line-by-line at each stage to complete
their respective tasks and pass explanation of its own generated code to
identify errors, the results to the subsequent stage. Building on this,
Agent- achieving automatic debugging and modification mecha- Coder
\[70\] also constructs a three-stage pipeline system nisms without
external feedback, significantly improving consisting of "programmer",
"test designer", and "test ex- accuracy and sample utilization
efficiency in multiple code ecutor" agents. This system effectively
improves the cor- tasks. Self-Edit \[75\] proposed a fault-aware code
editor that rectness and executability of code generation through struc-
can perform secondary editing on generated code by LLMs tured task
decomposition and test feedback. CodePori \[97\] after combining
execution feedback information, thereby introduces a set of agent roles,
including the manager, improving the accuracy of code generation for
numerous developer, finalizer, and verifier. In this framework, the
LLMs. Self-Repair \[95\] combines code models with feedback manager
agent is tasked with parsing natural language re- models for program
repair. The code model generates pro- quirements and decomposing the
tasks. Multiple developer grams based on user-provided specifications
and test cases. agents work in parallel to write code for different
modules, If the program fails tests, the feedback model generates
followed by multiple finalizer agents who refine the code.  9

                                                   Multi-Agent System Workflows
        Multi-Agent Code Generation
                                                     Pipeline-Based                          Hierarchical
       Set up a RESTful API in Flask with a                                                                               Low-level
                                                                                              High-level
       login endpoint and JWT authentication.      Planner       Editor      Executor                                     Execution
                                                                                            Task Planning

                       Query
                                                     Self-Negotiation                        Self-Evolving
                                                                                                                            Edit
                                                                                                            Self-Evolve
                                                      Code                Reflection &
                                                                                           Edit   Execute
                                                    Generation            Optimization                               Plan     Execute

                                                   Context Management and Memory Technologies
                Multi-Agent System                                           Blackboard Model
                                                                             Decoupled Modules
                                                                             Brain-Like Mechanism
                                                                             Dynamic Agent Numbers
                                                     Context                 Dual Collaboration                     Maintain
                                                   Information               Declarative Memory Modules        Contextual Memory
                      Context
         Workflow              Collaboration
                    Management
                                                   Collaborative Optimization

                                                                                   Collect Behavioral Data
      @app.route('/login', methods=['POST'])                                       Mutual Evaluation
      def login():
         # Validate user credentials                                               State Synchronization
         # Return JWT token on success                                             Group Discussion
                                                       Multi-Agent                                                          Optimize
                      Output                          Collaboration                                                       Collaboration


                                   Fig. 4: Overview of multi-agent code generation systems

Finally, the verifier agent performs integration testing to tion, code
testing, and refinement. FlowGen \[100\] simulates ensure the system's
functionality. Additionally, MAGIS \[98\] various classic software
engineering models (such as Wa- tackles repository maintenance tasks and
further expands terfall, TDD, Scrum), designing a four-layer agent
structure pipeline complexity. It models project managers, maintain- of
"requirement engineer", "architect", "developer", and ers, developers,
and quality assurance personnel in the "tester". The system gradually
advances development tasks GitHub development process as four agent
roles respec- through staged planning and goal verification. Its
flexibility tively. The system can complete GitHub Issue tracking, under
diverse development paradigms makes it a workflow assignment, and
repair, demonstrating feasibility in real framework with good
scalability. Building on this, SoA \[27\] project scenarios. Meanwhile,
HyperAgent \[71\] focuses on introduces dynamic agent scheduling
mechanisms. Based cross-language, cross-task code generation problems.
This on task complexity and resource usage, the system can framework
transforms natural language requirements into spontaneously expand or
contract the number of agents, runnable programs through collaboration
between planner, achieving efficient generation and management of large-
navigator, code editor, and executor agents. Meanwhile, it scale code
bases. This self-organizing structure improves introduces automatic tool
chain retrieval mechanisms to system robustness and adaptability,
particularly suitable for improve code generality and transferability.
The advantage code construction in heterogeneous task scenarios. Addi-
of this pipeline-based method lies in its clear structure tionally, MAGE
\[101\] is a multi-layer architecture system for and distinct
responsibilities, facilitating system design and RTL hardware code
generation. By decomposing high-level debugging. However, they would be
limited by serial de- goals into micro-operations and assigning them to
different pendencies when handling complex tasks and lack global agents,
MAGE not only demonstrates the generality of feedback. hierarchical
structures but also validates the transferability of this paradigm on
different types of code (such as Verilog). Unlike sequential pipelines,
the hierarchical planning- execution paradigm emphasizes task
decomposition by In more complex and uncertain tasks, self-negotiation
higher-level agents and specific implementation by lower- circular
optimization mechanisms center on negotiation, level agents. PairCoder
\[99\] simulates collaborative pair reflection, and self-feedback,
continuously improving code programmers, designing two collaborative
agents: Naviga- quality and robustness through multiple rounds of
interac- tor for planning and Driver for specific implementation. tion.
Some systems choose to have multiple agents evaluate, Navigator is
responsible for proposing promising solution optimize, and repair
candidate solutions in parallel or itera- methods, selecting the current
optimal solutions, and guid- tive ways. MapCoder \[102\] employs a cycle
of four special- ing next iterations based on execution feedback. Driver
ized agents that work together to recall relevant examples, follows the
guidance from Navigator for initial code genera- formulate a solution
plan, generate the corresponding code,  10

and then debug any errors. In each iteration, these agents playing
typically relies on the design of system prompts. collaborate to produce
code and identify defects for repair. The LLM behind each agent
understands its current tasks By repeating this process multiple times,
MapCoder steadily and responsibilities based on preset prompt
information. enhances solution quality and maintains stable performance
These prompts typically include task division, output re- on tasks that
require several steps. Subsequently, AutoSafe- quirements, input
formats, interface invocation methods, Coder \[103\] designed a
framework including coder, static and output formats. This mechanism not
only helps lan- analyzer, and fuzzer, where the coder continuously
revises guage models understand their current task roles but also code
based on feedback from static security detection by improves interaction
stability by limiting behavioral scope. the static analyzer and dynamic
security detection by the fuzzer. QualityFlow \[104\] organizes a team
of LLM agents 4.2.2 Context Management and Memory Technologies that
first generate unit tests, then apply an LLM-based Multi-agent systems
in code generation tasks frequently rely Quality Checker to imagine
whether the code and tests on sharing and referencing long-range
dependency informa- meet the requirements, and finally execute those
tests to tion such as task descriptions, historical modifications, and
confirm correctness. Meanwhile, CodeCoR \[12\] introduced intermediate
products. Therefore, how to effectively main- a "self-reflection"
scoring mechanism. The framework adds tain a writable, readable, and
scalable global context space is reflection agents between code
generation, testing, and re- an important factor determining system
upper limits. Self- pair stages to score and locate problems in
intermediate Collaboration \[15\] is the first system to introduce the
black- products. Then, the results are fed back to preceding agents
board model into code generation tasks. This method es- for the next
round optimization. This circular mechanism, tablishes an explicit
shared memory space for storing struc- based on self-supervised
feedback, effectively improved the tured information such as task
descriptions, intermediate adaptive capabilities of the model. For
high-performance generation results, and code revision records. All
agents can computing fields, MARCO \[105\] proposes a multi-agent read
or update blackboard content based on task types as code optimization
framework focusing on improving the needed and make subsequent decisions
accordingly, form- performance of LLM-generated code in parallelism,
mem- ing collaboration flows based on shared views. Compared to ory
efficiency, and architectural adaptability. The system traditional
unidirectional message passing, the blackboard separately sets code
generation agents and performance model significantly enhances
interaction flexibility between evaluation agents, continuously
optimizing code execution agents. efficiency through feedback loops.
Subsequently, L2MAC \[108\] draws inspiration from the As system
complexity increases, some work has begun von Neumann architecture,
designing decoupled instruction to further explore self-evolutionary
mechanisms of multi- registers and file storage modules. This system
introduces agent system structures, allowing systems to spontaneously
explicit control units to precisely control the scheduling and and
dynamically adjust structures and behavioral strategies. writing of
context content. It organizes context information SEW \[106\] proposed
workflow self-evolution mechanisms, by program units, effectively
breaking through the context where systems can dynamically reorganize
communication window limitations of language models. Therefore, L2MAC
paths and responsibility divisions based on collaboration ef- enables
generation tasks to span longer code structures and fectiveness between
agents and failure feedback. This mech- demonstrates good context
retention capabilities when han- anism no longer relies on manually set
fixed structures but dling large functions, multi-file projects, and
other complex achieves workflow-level adaptive adjustment through run-
situations. The Cogito \[109\] system further draws from the time
learning and reconstruction. EvoMAC \[107\], inspired three-stage
cognition-memory-growth model in neurobiol- by neural network training
processes, compares code gen- ogy and designs a brain-like context
organization mecha- eration results with target requirements to obtain
text-form nism. Its core idea is to divide context information into
three feedback from the environment. It designs an innovative structural
categories: short-term memory, long-term knowl- "text backpropagation"
mechanism to automatically adjust edge base, and evolutionary growth
units. Respectively, collaboration structures and behavioral strategies
between these three information categories are responsible for im-
agents. mediate state maintenance during task execution, accumu-
Additionally, in practical applications, multi-agent sys- lation of
common knowledge, and continuous enhancement tems often improve
collaboration effectiveness through of abstract capabilities. This
bionic memory system not only "role-playing" mechanisms. Role-playing
refers to adding enhances the hierarchical sense of context but also
provides specific identity settings in prompts, such as programmers,
agents with self-evolution and continuous learning capabili- testers,
project managers, or code reviewers. This mech- ties. Meanwhile, SoA
\[27\] introduces a self-organized multi- anism makes agent behavior
more consistent with corre- agent framework that automatically scales
the agent pool ac- sponding role responsibilities and thinking patterns.
The cording to task complexity. Each agent works within its own system
designs corresponding prompt strategies for each fixed-size context
window, while a central controller keeps role, enabling them to perform
their duties in collaboration subspaces of all agents structurally
aligned. By growing the and form clear division of labor processes. For
example, number of agents without increasing individual workloads,
agents in the ChatDev \[16\] system respectively play roles SoA prevents
information sparsity and confusion, enabling of programmers, reviewers,
and testers. MetaGPT \[17\] con- efficient and scalable generation of
large codebases. structs an agent team including roles such as product
man- Besides general technical innovations, some systems agers,
architects, project managers, and engineers, simulat- have also been
designed with more targeted context op- ing a complete software company
organizational structure. timization mechanisms combined with task
requirements. The implementation of the above workflows and role-
GameGPT \[110\] addresses the problem of frequent repetitive  11

information in multi-round game development tasks. It
software-development lifecycle, including automated code adopts a "dual
collaboration" mechanism to reduce redun- writing, debugging and repair,
test-code generation, refac- dant context retransmission, improving
context manage- toring and optimization, and even requirement
clarification. ment efficiency. CleanAgent \[111\] constructed a
declarative API memory module based on the Dataprep.Clean library, 5.1
Automated Code Generation and Implementation enabling the system to
extract domain knowledge from his- torical invocation trajectories and
reuse it for current tasks, Automated code generation and implementation
have be- demonstrating the combination of context mechanisms with come a
key technology for improving software engineer- domain knowledge. ing
efficiency and quality. With the help of code genera- tion agents,
researchers are gradually transforming a large 4.2.3 Collaborative
Optimization of Multi-Agents amount of repetitive code writing and
debugging work As multi-agent systems in code generation tasks have
devel- traditionally done manually into automated processes \[78, oped
increasingly mature, research has begun to focus on 106, 115, 117\].
Currently, the automation level of code gen- how to further improve
collaboration capabilities between eration has expanded from
function-level code generation agents. Such methods can be collectively
termed "collabo- to cross-module, multi-file incremental code evolution,
and rative optimization". To be specific, they introduce team- has
further developed into end-to-end project construction level
collaboration modeling mechanisms during training oriented toward
natural language requirements. to jointly optimize the behavior of
multiple agents, thereby Function-level code generation requires agents
to auto- improving overall performance metrics. Currently, collabo-
matically generate functionally correct code segments. Self- rative
optimization remains an emerging research direction Planning \[10\] is
the first work to enable agents to automat- with limited related methods
and immature technical sys- ically perform task decomposition and
formulate execution tems. steps to reduce the coding difficulty of
complex require- An early representative in this direction is Lingma
SWE- ments. CodeChain \[11\] achieves modular code generation GPT
\[112\]. Lingma SWE-GPT simulates real software de- using chain-based
self-revision mechanisms. FlowGen \[100\] velopment processes by
dividing tasks into three stages: configures a series of different
development process models, codebase understanding, fault localization,
and patch gener- enabling agents to implement software development modes
ation, with each stage corresponding to a sub-task agent. To such as the
waterfall model, test-driven development, and achieve collaborative
optimization between agents, Lingma agile development according to
different role sequences or SWE-GPT first collects behavioral data from
multiple-stage collaboration processes. PairCoder \[99\] adopts a pair
pro- agents, including reasoning processes, tool invocations, and
gramming mode, generating multiple code generation paths final results.
Then, it optimizes the entire system through through multi-round cycles
of agents. CodeTree \[81\] adopts supervised fine-tuning, thereby
improving multi-stage col- tree-structured search and verification
mechanisms, reduc- laboration quality and overall performance. ing
failure rates when handling complex code generation CodeCoR \[12\]
establishes a loop of generation, testing, tasks. CodeCoR \[12\] can
actively evaluate and reflect on the and repair across four dedicated
agents for prompts, code, quality of generated code and initiate
automatic correction test cases, and repair suggestions. During
training, each processes when errors occur. QualityFlow \[26\]
introduces agent produces multiple candidates and evaluates outputs
imagination execution mechanisms to achieve rapid quality from other
agents. Then, low-quality prompts, code snip- checking of generated
code, saving code execution time in pets, tests, and repair advice are
pruned based on these mu- real testing processes. CodeSim \[118\] and
MapCoder \[102\] tual assessments. This iterative feedback mechanism
sharp- simulate human development, improving correctness and ens
collaboration and yields more reliable code synthesis. efficiency in
long code generation and complex problem- Additionally, SyncMind \[113\]
takes a system-level view of solving processes. DARS \[83\] can
dynamically adjust gener- agent collaboration by tackling the common
issue of "out- ation results based on code execution feedback, achieving
a of-sync" states that arise when multiple agents update a higher 47%
Pass@1 rate on the SWE-Bench Lite benchmark shared codebase. It
introduces three complementary evalua- compared to previous linear
generation or random multi- tion dimensions to study how agents
recognize and recover sampling code generation methods. from state
drift. These multidimensional mechanisms enrich Repository-level code
generation requires agents to auto- our understanding of how to optimize
collaborative coding matically generate and maintain large, complex
codebases, workflows. including multiple modules and files. One type of
work To alleviate the problem of error propagation during col- focuses
on enabling agents to incrementally add function- laboration caused by
agent hallucinations, CANDOR \[114\] ality based on understanding
existing code structures and coordinates multiple agents, including
planners and re- module responsibilities. For example, AgileCoder
\[120\] and viewers. Specifically, CANDOR adopts group discussion
AgileAgent \[14\] progressively develop software systems by strategies
to generate accurate reference answers based on simulating human agile
development processes. Another consensus among multiple reviewer agents.
type of work hopes that agents can generate code from scratch based on
requirements. The Self-Collaboration \[15\] 5 A PPLICATIONS OF LLM-
BASED C ODE G ENERA - framework enables a single ChatGPT instance to
simulate TION AGENTS IN S OFTWARE D EVELOPMENT TASKS roles at different
stages of software development and in- Recent studies \[31, 75, 105,
115, 116\] show that code- corporates software development
methodologies, achieving generation agents have evolved well beyond
their tradi- project development without human intervention. Chat-
tional role. Today, they support multiple stages of the Dev \[16\]
reduces hallucination problems in generated code  12

                                                                           Self-Planning [10], LATS [115], Lemur [117], CodeChain [11], MapCoder [102],
                                                   Function-Level
                                                                                    FlowGen [100], PairCoder [99], CodeTree [81], CodeCoR [12],
                                                  Code Generation
                              Automated Code                                           QualityFlow [26], CodeSim [118], DARS [83], SEW [106]
                               Generation and
                             Implementation 5.1                                Self-Collabration[15], ChatDev[16], Webagent[78], MetaGPT[17],
                                                  Repository-Level
                                                                           CodePlan[79], CodeAgent[28], CodePoRi[13], GameGPT[110], CodeS[119],
                                                  Code Generation
                                                                                    SoA[27], ToolGen[29], AgileCoder[120], AgileAgent[14],

                                                       Self-Refine[74], Self-Debug[94], Self-Edit[75], Self-Repair[95], RepairAgent[121],
                                 Automated
                                                  AutoCodeRover[122], SWE-Agent[123], MAGIS[98], AutoSafeCoder[124], SWE-Search[125],
                               Debugging and
                                                  HyperAgent[71], SQLFixAgent[126], OrcaLoca[127], PatchPilot[128], Thinking-Longer[129],
                             Program Repair 5.2
                                                                      AdverIntentAgent[130], Nemotron-CORTEXA[131]

                                                  Automated Test           TestPilot[31], CANDOR[32], XUAT-Copilot[20], LogiAgent[21],

Applications of LLM-based Case Generation SeedMind\[35\], ACH\[36\] Code
Generation Agents Automated Test Code Generation5.3 Automated Execution
and AUITestAgent\[132\], HEPH\[133\] Analysis

                                                  Structural Code
                                                                           DataClump-Pipeline[22], iSMELL[134], EM-assist[135], HaskellAgent[136]
                             Automated Code         Refactoring
                             Refactoring and
                             Optimization 5.4     Code Performance
                                                                           AIDE[137], MARCO[105], LASSI-EE[33], SysLLMatic[34]
                                                    Optimization
                               Automated
                              Requirement         MARE[116], ClarifyGPT[19], TiCoder[138], SpecFix[139], InterAgent[140], HiLDe[141]
                             Clarification 5.5


          Fig. 5: Overview of applications of LLM-based code generation agents in software development tasks

by having multiple agents communicate through code snip- cessfully
automatically repairs 164 defects on Defects4J. pets during the
debugging phase. MetaGPT \[17\] simulates MAGIS \[98\] uses multi-agents
to simulate the planning real development teams executing multiple
development and coding phases in the GitHub Issue resolution process,
tasks, automatically allocating resources and scheduling improving the
GitHub Issue resolution rate to 13.94% on development sequences.
CodePoRi \[13\] uses multi-agents SWE-Bench. Similarly, HyperAgent
\[71\] uses multi-agents to simulate different roles in real software
development to cover the complete lifecycle from problem decomposition
processes, thereby generating relatively large-scale soft- to patch
verification, achieving leading performance at the ware systems at low
cost. GameGPT \[110\] achieves auto- time on multiple benchmarks,
including SWE-Bench-Lite, matic construction from natural language
descriptions to RepoExec, and Defects4J, with good cross-task and cross-
runnable games, enabling non-programmer users to quickly language
generalization capabilities. SQLFixAgent \[126\] can develop game
content through conversational interaction. capture deviations between
SQL statements and user inten- CodeS \[119\] overcomes structural
confusion and semantic tions, provide diverse repair candidates, and
select optimal incoherence problems that easily occur in end-to-end
large- repair solutions based on failure memories and similar scale code
generation by pre-generating repository structure repair histories.
AutoSafeCoder \[124\] uses dual feedback sketches. SoA \[27\] constructs
a multi-code generation agent from static security detection and fuzzing
dynamic security system that does not require manual central schedulers.
detection to guide agents in continuously revising code, Additionally,
some work focuses on improving the ability of reducing vulnerability
rates by approximately 13% on Se- agents to invoke external tools to
better operate codebases. curityEval and improving code security.
OrcaLoca \[127\] CodeAgent \[28\] integrates five programming tools,
enabling improves problem localization accuracy and overall repair code
generation agents to retrieve third-party dependencies effectiveness in
complex code repositories by introducing in multi-file structures and
implement function generation strategies such as priority scheduling,
action decomposition, and completion for inter-module calls. ToolGen
\[29\] con- and context pruning. PatchPilot \[128\] can use efficient
local- structs code generation agents with plugin capabilities that
ization strategies to quickly find vulnerable code lines and can
automatically select and invoke corresponding tools generate verifiable
repair patches with fewer invocations based on scenarios and functional
needs. and token consumption, reducing the cost of program re- pair.
Thinking-Longer \[129\] enables small-scale code gener- 5.2 Automated
Debugging and Program Repair ation agents to approach the vulnerability
repair capabilities of larger-scale agents by increasing thinking
complexity, Automated debugging and repair technology can effectively
achieving low-resource deployment of automated program reduce software
defects and improve system stability \[74, repair systems.
AdverIntentAgent \[130\] avoids overfitting 75, 94\]. The emergence of
code generation agents is driving problems in generated patches by
constructing adversarial automated program repair from the classic
"test-driven test cases for each possible program intention. Nemotron-
patch generation" toward a higher stage of "autonomous CORTEXA \[131\]
adopts diverse repair candidate mecha- defect diagnosis and semantic
repair" \[95, 122, 123, 125\]. nisms for Python program repair.
RepairAgent \[121\] provides 14 repair tools commonly used by
developers, guiding agent decisions and tool in- vocations through
finite state machines. This system suc-  13

5.3 Automated Test Code Generation 5.4 Automated Code Refactoring and
Optimization

With the popularization of code generation technology, the Automated
code refactoring and optimization help improve focus of software
development is shifting toward verifica- code maintainability and
runtime efficiency. LLM-based tion and testing. Moreover, the testing
phase has evolved agents can understand the semantics of existing code
and into a key aspect for managing and verifying large amounts combine
external tools such as static analysis, test feed- of generated code.
LLM-based code generation agents can back, and performance monitoring to
decide how to rewrite generate unit tests, integration tests, and
security test cases code \[105, 137\]. based on requirements, code, and
related documentation, as In structural code refactoring, Baumgartner et
al. \[22\] well as execute automated testing processes \[21, 31, 132,
132, propose a modular automated refactoring pipeline based 142\]. on
LLMs for detecting and repairing data clumps in GitHub repositories.
EM-Assist \[135\] designs plugins for overly long In unit testing,
traditional search methods like EvoSuite functions written by users in
Java and Kotlin, using LLMs typically rely on structural information and
code execution to provide extract method suggestions. iSMELL \[134\] can
paths, unable to understand function semantics, and can automatically
invoke multiple professional detection tools only attempt to collide
with boundaries through extensive for different types of code smell and
integrate tool detection coverage or heuristic exploration. In contrast,
LLMs can bet- results into LLMs to generate targeted refactoring sugges-
ter understand functional intentions and semantic bound- tions. Siddeeq
et al. \[136\] propose a multi-agent system aries. TestPilot \[31\] can
automatically generate test cases for automated Haskell code
refactoring, completing tasks for JavaScript APIs, achieving 52.8%
branch coverage on such as variable renaming, function extraction,
redundancy 25 npm packages and 1,684 API functions, improving 27%
elimination, module reorganization, and style unification. compared to
the feedback-driven tool Nessie. CANDOR \[32\] The system solves the
code refactoring difficulties brought can generate Java unit test cases
end-to-end, successfully by Haskell's pure functional characteristics.
surpassing EvoSuite in metrics such as line coverage. In In code
performance optimization, both LASSI-EE \[33\] integration testing,
XUAT-Copilot \[20\] can automatically and SysLLMatic \[34\] use LLMs to
analyze various per- complete the determination of test instruction
types, spe- formance and energy consumption metrics during code cific
parameter filling, and effect verification. The system runtime,
achieving improvements in software system per- achieves automated
integration testing for mobile payment formance and energy consumption
through multi-round applications such as WeChat Pay. LogiAgent \[21\]
integrates diagnosis and optimization. components for test scenario
generation, API request execu- tion and verification, and logic
notification. It overcomes the problem that traditional REST API testing
only focuses on 5.5 Automated Requirement Clarification detecting server
crashes and error codes. Meanwhile, this Requirement clarification aims
to eliminate ambiguity and system achieves automated detection of a
series of logic uncertainty in instructions to ensure accurate
understanding problems brought by business development and domain- of
the true intentions from the users. LLM-based code gen- specific
requirements. In security testing, LLM-based code eration agents can
handle ambiguous or incomplete natural generation agents can
automatically derive aggressive input language requirements and
gradually clarify them under patterns and boundary condition cases from
natural lan- user feedback guidance, thereby generating code that meets
guage documentation, interface definitions, and code struc- final
requirements \[116, 138\]. tures. SeedMind \[35\] automatically
generates high-quality Existing applications have evolved along a
develop- seed inputs through LLMs as starting points for gray-box mental
trajectory that progresses from static understanding fuzzing. The
framework can dynamically adjust generation of requirements to dynamic
dialogue-based clarification. strategies based on test feedback to
improve test coverage. This path includes the detection of ambiguity,
the proac- Meta's ACH \[36\] system generates mutants that conform tive
generation of clarification questions, and ultimately, to program
semantics through LLMs and judges mutant the collaborative control of
generation processes between equivalence, improving the efficiency of
mutation testing. humans and machines. ClarifyGPT \[19\] judges whether
Automated testing processes involve not only test case ambiguous
requirements exist by checking the consistency generation but also
execution, evaluation, and analysis. For of multiple generation results
from LLMs and obtains accu- example, AUITestAgent \[132\] can
automatically identify rate requirements through question-and-answer
with users. interactive instructions and execute full-process graphical
Furthermore, combining test-driven development concepts, user interface
operations and functional verification through TiCoder \[138\] guides
users to clarify natural language re- pure natural language testing
requirements. The HEPH quirements by automatically generating test
cases, thereby system from NVIDIA achieves verification of correctness
of improving code generation accuracy. SpecFix \[139\] can au-
C/C++-based embedded systems in various scenarios by tomatically guide
LLMs to make minimal modifications to analyzing requirement documents
and retrieving various re- original requirement texts to eliminate
unnecessary ambi- lated files, and guides the next round of test case
generation guity. However, due to lack of interaction with the outside
with coverage reports after each testing round. world, overall
effectiveness is limited by LLM capabilities. Although the automated
testing capabilities of LLM- InterAgent \[140\] verifies the
capabilities of LLM-based code based code generation agents have not yet
comprehensively generation agents in identifying unclear instructions,
ac- surpassed traditional tools, their semantic understanding tively
clarifying, and improving performance through in- advantages in covering
boundaries and discovering hidden teraction in complex tasks. The
framework ultimately finds errors deserve future in-depth exploration.
that under incomplete requirement conditions, most LLMs  14

perform poorly without active interaction but can effectively similarity
to objective, automatable code execution testing. obtain key information
when interactive, approaching per- It establishes a new gold standard
for the code generation formance under complete input conditions.
Additionally, field. Similarly, MBPP \[143\] dataset proposed by Google
HiLDe \[141\] enables human users to integrate personalized Research
focuses on entry-level Python programming tasks. requirements into key
decision positions of code generation In this benchmark, each problem
includes natural language by selecting subsequent code generation
results. descriptions, reference answers, and three assertion state-
ments for automatic testing, covering various problem types from
mathematical calculations to basic data processing. 6 E VALUATION M
ETHODS AND B ENCHMARKS Programming Contest Code Generation Benchmarks:
Evaluating code generation agents, particularly those used As the
capabilities of LLMs improve, code generation evalu- to solve complex
software engineering tasks, is a fundamen- ation gradually shifts from
simple function implementation tal and extremely challenging problem.
The core challenge to complex tasks requiring deeper logical reasoning
and lies in the fact that evaluation methods must go beyond algorithmic
design, such as programming contest problems. judging code syntax or
pass rates to deeply explore the Such tasks not only require models to
master program- problem-solving capabilities of agents in complex,
dynamic ming language syntax but also test their abilities to analyze
software development scenarios. This chapter provides a problems, design
algorithms, and organize complex logic. structured overview of existing
evaluation methods and The academic community has constructed several
high- benchmarks for code generation agents. These methods quality
programming contest benchmarks. Among them, have evolved significantly
over time. Initially, they focused APPS \[144\], CodeContests \[9\], and
LiveCodeBench \[145\] on assessing self-contained code snippets, such as
individ- are three most representative benchmarks. APPS collects ual
functions. Gradually, however, the focus has shifted 10,000 problems
from online evaluation websites such as toward evaluating the ability of
agents to perform multi- Codeforces and divides them into three
difficulty levels. step, interactive tasks within large and complex
software CodeContests contains 13,328 problems collected from real
repositories. This shift reflects the expanding boundaries of
programming contests, covering C++, Python, and Java code generation
capabilities in the field of software engi- languages. To avoid data
contamination risks \[146\], Live- neering. CodeBench continuously
maintains new programming con- test problems from LeetCode, AtCoder, and
CodeForces platforms, updating the dataset every few months. As of 6.1
Evaluation Benchmarks now, it includes 1,055 problems from May 2023 to
May 2025. The evaluation of code generation tasks heavily relies
Evaluation of these benchmarks typically uses test case pass on
standardized benchmark datasets. Early benchmarks rates as core metrics.
mainly focus on basic independent unit code generation Benchmarks for
Real Software Development Scenar- tasks, while newly developed
benchmarks in recent years ios: With the rapid development of code
generation agents, are committed to simulating real software development
research focus has shifted toward building autonomous tasks, emphasizing
the interaction, planning, and execution agents capable of executing
complex tasks in real software capabilities of agents in complex
environments. Existing projects. A series of benchmarks aimed at
simulating real evaluation benchmarks mainly include three major cate-
software engineering scenarios has emerged. A key charac- gories:
method/class-level, programming contest-level, and teristic of these
benchmarks is that they provide a complete benchmarks oriented toward
real software development software development environment. In this
environment, scenarios. agents are required to solve real-world tasks by
interacting Method/Class-level Code Generation Benchmarks: In with
codebases, command-line interfaces, debugging tools, the initial phase
of research on code generation agents, and other resources, simulating
the workflow of human evaluation primarily focused on independent and
clearly developers. For example, SWE-Bench \[147\] is a large-scale
specified programming tasks. The central aim was to de- GitHub Issues
resolution benchmark containing thousands termine whether models could
transform natural language of real GitHub Issues. The Issues are
collected from 12 descriptions into syntactically and functionally
correct code popular Python codebases, with task types covering defect
snippets. This line of work is typically referred to as method- repair
and new feature development. Due to the complexity level or class-level
code generation, in which models receive of the original dataset,
researchers have also constructed high-level functional requirements,
optionally accompanied two important derivative versions. One is
SWE-Bench-Lite, by method signatures, and are required to generate com-
which screens 300 more self-contained functional defect plete method
bodies. The benchmarks constructed during repair tasks for faster, more
focused evaluation. The other is this period provide methodological
foundations for later SWE-Bench-Verified, where OpenAI researchers
manually research targeting more complex tasks. They also establish
verify and screen instances from the original SWE-Bench, an evaluation
framework based on functional correctness, ultimately forming a test set
containing 500 high-quality which has been widely adopted in both
academic and instances. CodeAgentBench \[28\] contains 5 real Python
practical settings. software projects and 101 tasks, requiring models to
imple- Among numerous benchmarks, HumanEval \[51\], ment new functions
based on functional documentation and launched by OpenAI in 2021, has
milestone significance. It existing project code. Web-Bench \[148\]
covers multiple web borrows ideas from online programming platforms
(such project development tasks from scratch. This sequential, as
LeetCode), providing unit test cases for each problem. project-based
approach differs from other benchmarks like This benchmark shifts
evaluation standards from vague text CodeAgentBench and SWE-Bench,
focusing on evaluating  15

the long-term planning, memory, and sustained contex- minimal and
effective sequence of actions, avoiding redun- tual understanding
capabilities of agents across multiple dant operations. Some metrics
also evaluate the quality of steps in project development tasks. Aider
\[149\] contains intermediate steps, such as tool usage accuracy
\[147\]. This 225 high-difficulty educational programming exercises cov-
refers to whether the agent can select the correct tools and ering
multiple programming languages, requiring models use them with valid
parameters. or agents to implement corresponding functions based on
Other Software Quality Evaluation Metrics: As code instruction
documentation. Additionally, there are other generation agents become
more capable, evaluation cri- real project-oriented code generation
benchmarks, such as teria have gradually expanded to include
non-functional EvoCodeBench \[150\] and DevEval \[151\], which require
attributes that are essential to software quality, such as models to
generate target code that meets expectations security. Emerging
benchmarks, such as SEC-bench \[155\], given complete project contexts
and requirements. are designed to assess the ability of agents to repair
real- world security vulnerabilities. Comprehensive evaluation also
considers code quality \[156\], which involves several 6.2 Evaluation
Metrics aspects. Static analysis tools can be used to measure code Code
generation agent evaluation mainly includes the fol- readability and
complexity, for example, by calculating cy- lowing aspects: functional
correctness, process efficiency, clomatic complexity and lines of code
\[157\]. Maintainability and non-functional software quality. can be
assessed using metrics such as inter-module cou- Functional Correctness
Metrics: Functional correctness pling \[157\]. In addition, agents that
follow good engineering metrics are the most core dimension for
evaluating code practices are expected to update related test cases
during generation capabilities . They are typically measured by
development to maintain high test coverage \[158\]. executing generated
code and testing whether its output meets expectations. Pass@k \[51\] is
the most commonly used metric for calculating functional correctness.
For each prob- 7 D EPLOYED C ODE G ENERATION AGENT TOOLS lem, the model
independently generates k candidate code Several multi-agent code
generation tools have been de- samples, and if at least one sample can
pass all unit tests, the ployed and have produced widespread impact in
the cur- problem is considered successfully solved. Pass@k measures rent
market. We roughly categorize them into three types the probability of
success at least once in k attempts. To to show their evolutionary
trajectory: 1) Co-pilot: Human- eliminate sampling bias, the following
unbiased estimator machine close collaboration, serving as the co-pilot
of de- is typically used for calculation: velopers to assist programmers
in coding. 2) Collaborator: " \# Capable of understanding entire
codebase contexts and n−c k engaging in deep interactive collaboration
with developers. pass@k = Eproblems 1 − n 3) Autonomous Team: Aimed at
automating the entire k development process, where humans play more of a
client where n is the total number of samples generated for a or manager
role. Currently, emerging code generation agent single problem (n ≥ k ),
and c is the number of correct tools in the market embody this
evolutionary trajectory, samples passing tests. This metric simulates
scenarios where playing roles at different stages of programming
assistant, developers might generate multiple alternative solutions
collaborative partner, and autonomous development team. and select one
in actual work. Therefore, better reflecting GitHub Copilot \[159\]: As
an integrated programming the practical value of models compared to
Pass@1, which agent, GitHub Copilot has elevated programming assistance
only evaluates single generation. to new heights. Its technical core
lies in using Retrieval- Evaluation Metrics for Code Generation Agents:
In Augmented Generation (RAG) to dynamically construct recent years,
researchers have proposed specialized evalua- contexts and safely
execute tasks in cloud-based sandboxes tion metrics for code generation
agents. These metrics aim to powered by GitHub Actions. This
architecture enables deep evaluate agents from multiple dimensions,
including output integration into the GitHub ecosystem (such as Issues,
PRs), quality, efficiency, cost, and execution process. Among them, not
only assisting in coding but also automating workflows task success rate
\[147\] is a fundamental metric. It directly from requirements to code
commits. measures whether an agent can solve a given problem. For Devin
\[160\]: Devin was first released in early 2024, example, in SWE-bench,
task success is defined as whether promoted as the first AI software
engineer. It aims to the agent-generated patch passes all relevant test
cases. fully automate various complex software engineering tasks
However, task success rate alone cannot fully reflect the by empowering
LLM-based agents with the ability to use real-world performance of the
agent. Efficiency and cost terminal tools, code editors, and web
browsers, covering must also be taken into account. This includes the
API call the entire workflow from planning, execution, to debug- cost
and token consumption \[153\] required to complete a ging and
deployment. However, actual use revealed nu- task, which are directly
related to economic cost. It also merous problems with Devin, including
low success rates, includes latency from receiving a task to producing a
solu- frequent loops, and difficult-to-resolve hallucination issues.
tion, which affects user experience. In addition, local model This
indicates that current code generation agents still face deployment may
incur computational resource costs \[154\]. enormous difficulties when
handling various complex edge Besides final outputs, the execution
trajectory of the cases in real-world software engineering projects.
agent is also an important evaluation target. Trajectory ef- Cursor
\[161\]: Cursor is an AI-native standalone IDE ficiency reflects how
many steps the agent takes to complete and a deep practice of the
collaborative partner concept. the task. An efficient agent should reach
the goal through a Through deep customization of VS Code, it achieves a 
16

local-first agent architecture. Its key technology is persistent files,
modules, or documentation. Without well-organized vector embedding
indexing of codebases, achieving low- context, they may generate
inconsistent or incorrect code. latency global context awareness. This
enables its agents This problem becomes more severe in multi-step tasks,
to directly interact with local file systems and terminals, where key
information from earlier steps can be easily demonstrating efficient,
deep interaction and collaboration lost or misunderstood. While some
recent approaches try capabilities with developers when handling complex
code to improve this through retrieval or memory mechanisms, refactoring
tasks spanning multiple files. there is still no robust solution that
works reliably across Tongyi Lingma \[162\]: Tongyi Lingma is a
collaborative large and complex codebases. partner based on CodeQwen,
with its LingmaAgent frame- Handling Large-Scale, Complex Codebases and
work showing a unique technical approach. It constructs Project-Level
Dependencies: When processing real projects codebase knowledge graphs
and innovatively uses Monte containing massive files and complex
dependency relation- Carlo Tree Search (MCTS) for systematic navigation
and ships, existing code generation agents have limited capabil- fault
localization, achieving deep understanding of complex ities in
long-context modeling, cross-file dependency analy- software
repositories. This methodology enables it to per- sis, and overall
software architecture understanding, greatly form well in advanced
collaborative tasks such as multi-file limiting their application
effectiveness in large projects. dependency analysis and automated
program repair, rather Multimodal Understanding and Generation: Modern
than just simple code completion. software development is a multimodal
process, often in- Claude Code \[163\]: Claude Code is a terminal-native
volving non-textual information such as UI design sketches, programming
agent whose design significantly advances architecture diagrams, and
flowcharts. Current LLM-based toward the autonomous development team
direction. Its agents cannot fully understand and utilize multimodal in-
technical core is using ultra-long context windows of up formation for
code generation, which is particularly critical to 200K tokens for
holistic semantic understanding of entire in frontend development and
user interface implementation codebases. Combined with its hybrid
reasoning engine and tasks. This is one of the important research
directions for the extended thinking mode, it can autonomously plan and
future. execute complex code generation, refactoring, and debug- ging
tasks starting from highly abstract natural language re- quirements.
Therefore, Claude Code is pushing human roles 8.2 Robustness and
Updatability Challenges of Agent more toward requirement definition and
final supervision. Systems Error Cascading Within Agent Systems: In
multi-agent 8 C HALLENGES AND F UTURE D IRECTIONS systems, minor
deviations from upstream agents (e.g., an We discuss and summarize the
challenges currently faced by incorrect API call parameter) are used as
inputs for down- LLM-based code generation agents and future development
stream agents. If subsequent agents fail to identify and directions from
four dimensions. correct this error, they will make further decisions
based on the erroneous information. Such deviations are amplified 8.1
Limitations of Agent Core Capabilities level by level along the
collaboration chain, forming error Handling Domain-Specific Tasks:
Current LLM-based cascading effects that may ultimately lead to systemic
failure agents exhibit significant limitations when dealing with of
entire tasks. This error cascading effect is an important tasks
requiring deep domain knowledge and complex pro- factor threatening the
reliability of multi-agent systems. fessional reasoning. This problem is
particularly promi- Coordination and Management Complexity in Multi-
nent when tasks involve domain-specific terminology or Agent
Collaboration: As the number of agents in a sys- industry standards. Due
to the lack of structured domain tem increases, potential interaction
relationships between knowledge bases and specialized training, agents
can easily them grow exponentially, causing system complexity to rise
produce domain-related understanding biases. Moreover, sharply. Without
efficient coordination mechanisms, collab- they may also experience
logical collapse or even gener- oration among numerous autonomous agents
can easily fall ate hallucinations when handling problems beyond their
into chaos, causing problems like communication bottle- knowledge
boundaries. To break through this bottleneck, necks, responsibility
ambiguity and goal drift. Ultimately, effective domain knowledge
enhancement methods need to the chaotic collaboration will damage
overall system stabil- be explored. ity and task execution efficiency.
How to design a robust Intent Understanding and Context Awareness: Human
collaboration framework to effectively manage large-scale instructions
often have informal and ambiguous character- agent teams is a complex
systems engineering challenge. istics. When task objectives themselves
are vaguely defined Agent Knowledge Updates and Continuous Learn- or
depend on implicit contexts, agents without strong intent ing: Software
development environments are dynamically understanding capabilities are
prone to misunderstandings, evolving, but agents constructed through
one-time training leading to outputs that do not meet expectations.
Therefore, have fixed knowledge bases that inevitably become out- code
agent systems need to improve their intent reasoning dated. Agents need
capabilities to actively and continuously and context awareness
capabilities. Meanwhile, they need learn unique coding standards and
domain knowledge from to introduce interactive clarification mechanisms
to ensure specific projects. However, there is currently a lack of ef-
alignment with human goals. fective continuous learning mechanisms that
can efficiently Context Engineering: In practical scenarios, agents
often integrate new knowledge into agents while avoiding catas- face
scattered and incomplete information across multiple trophic forgetting.
17

8.3 Human-Agent Interaction, Trustworthiness, and assist with tasks such
as coding, debugging, and mainte- Cost Challenges nance. The end product
continues to be conventional soft- Reliability and Debuggability of
Agent Systems: The in- ware delivered as static artifacts. However, a
shift toward herent hallucination problem of LLMs easily causes them to
a new paradigm is emerging, where agents no longer serve generate
seemingly credible but actually false hallucination merely as supporting
tools but take on a more autonomous content, directly undermining the
reliability of agent sys- role in delivering complete task outcomes. In
this future tems. If agent systems cannot consistently and reliably pro-
paradigm, users interact with the system through high-level vide
accurate information, they will be extremely dangerous intent
descriptions rather than low-level code manipulation, in high-risk
scenarios (such as critical infrastructure control). and their role
evolves from that of software constructors Additionally, when agent
system behavior deviates from to providers of problem statements. The
agent system in- expectations, their complex internal decision chains
and terprets these intents, dynamically generates the necessary
non-deterministic outputs make debugging and repairing code, executes
actions internally, and directly returns results, problems difficult.
effectively offering software as a service on demand. This Flexibility
and Security in Tool Usage: To perform transformation imposes new and
significant demands on meaningful tasks, agents need access to external
tools such the autonomy, reliability, and ability of agents to complete
as compilers, test frameworks, and database interfaces. complex tasks in
an end-to-end manner. However, relying on a predefined and static
toolset limits the flexibility of agents and makes it difficult to
handle 9 C ONCLUSION diverse and evolving real-world scenarios. A key
challenge is to enable agents to move beyond these limitations by This
paper investigates code generation with LLM-based supporting flexible
and on-demand tool discovery and in- agents as a new paradigm in
software development. It high- tegration. Meanwhile, it is essential to
ensure the security lights three key features that set them apart from
traditional of the tool execution process to prevent unintended or code
generation methods: autonomy, broader task coverage, malicious behavior.
and engineering practicality. We review the development High Operating
Costs and Performance Bottlenecks: path of this technology and analyze
its core components Multi-agent systems improve problem-solving
capabilities from a methodological perspective. At the application
level, through multi-round collaborative interactions, but this typ- we
summarize typical use cases across the software de- ically comes at the
cost of high computational and time velopment lifecycle and list
representative tools that have expenses. Each interaction between agents
and each call to been deployed. We also discuss current technical
challenges, LLMs generates significant computational and time over-
including integration with development environments and head. When tasks
are complex and interaction rounds in- ensuring code quality, which
remain central problems for crease, total costs rise sharply, becoming a
major economic future research. and technical barrier limiting
large-scale deployment of Looking ahead, we are confident that with the
gradual multi-agent systems in real development scenarios. resolution of
existing challenges, code generation agents will fundamentally transform
the field of software engineer- ing. These agents promise to free
developers from repetitive 8.4 Evaluation System Completeness and
Software and tedious coding tasks, enabling them to focus more on
Paradigm Evolution creative problem formulation and system-level design.
We Inadequate Effectiveness and Comprehensiveness of Eval- sincerely
hope that this survey serves as a valuable resource uation Methods:
Existing evaluation methods for code gen- for peers in the community,
sparks further innovative think- eration systems have clear limitations.
They often focus ing, and contributes to the advancement and maturity of
this solely on metrics like test pass rates (e.g., Pass@k), while
promising technology. overlooking important factors such as human
cognitive load and the effort required for intervention in real
collaborative scenarios. This one-dimensional approach fails to capture
ACKNOWLEDGMENTS the practical utility of such systems. There is a
pressing We would like to thank Tianchi Xu and Mengren Zheng for need
for a more comprehensive evaluation framework that their contributions
to our early work. considers multiple aspects, including: (1) task
effectiveness and efficiency, (2) the quality of human-agent
interaction, (3) system security and interpretability, and (4) user
experience R EFERENCES and cognitive demands. Such a framework is
essential to \[1\] E. Kitzelmann, "Inductive programming: A survey of
support the development of code generation agents that are program
synthesis techniques," in International Work- not only effective but
also trustworthy and user-friendly in shop on Approaches and
Applications of Inductive Pro- real-world applications. gramming (AAIP),
2009, pp. 50--73. Software Paradigm Transformation: The current soft-
\[2\] W. Ling, E. Grefenstette, K. M. Hermann, T. Kočiskỳ, ware
development paradigm is characterized by a collab- A. Senior, F. Wang,
and P. Blunsom, "Latent predictor orative model in which human
developers work alongside networks for code generation," in Meeting of
the As- code generation agents. In this model, agents function as
sociation for Computational Linguistics (ACL), 2016, pp. advanced
productivity tools embedded within the tradi- 599--609. tional software
engineering workflow. Human developers \[3\] P. Yin and G. Neubig, "A
syntactic neural model for remain the central decision-makers,
leveraging agents to general-purpose code generation," in Meeting of the
18

       Association for Computational Linguistics (ACL), 2017,             C. Zhang, Z. Wang, S. K. S. Yau, Z. Lin, L. Zhou
       pp. 440–450.                                                       et al., “Metagpt: Meta programming for multi-agent

\[4\] H. Touvron, T. Lavril, G. Izacard, X. Martinet, M.-A.
collaborative framework," in International Conference Lachaux, T.
Lacroix, B. Rozière, N. Goyal, E. Hambro, on Learning Representations
(ICLR), 2023. F. Azhar et al., "LLaMA: Open and efficient founda- \[18\]
S. Lu, D. Guo, S. Ren, J. Huang, A. Svyatkovskiy, tion language models,"
2023. A. Blanco, C. Clement, D. Drain, D. Jiang, D. Tang \[5\] H.
Touvron, L. Martin, K. Stone, P. Albert, A. Alma- et al., "CodeXGLUE: A
machine learning benchmark hairi, Y. Babaei, N. Bashlykov, S. Batra, P.
Bhargava, dataset for code understanding and generation," in S. Bhosale
et al., "LLaMA 2: Open foundation and fine- Conference on Neural
Information Processing Systems tuned chat models," 2023. (NeurIPS)
Datasets and Benchmarks Track, 2021. \[6\] L. Ouyang, J. Wu, X. Jiang,
D. Almeida, C. Wain- \[19\] F. Mu, L. Shi, S. Wang, Z. Yu, B. Zhang, C.
Wang, wright, P. Mishkin, C. Zhang, S. Agarwal, K. Slama, S. Liu, and Q.
Wang, "ClarifyGPT: Empowering LLM- A. Ray et al., "Training language
models to follow based code generation with intention clarification,"
instructions with human feedback," in Conference on 2023. Neural
Information Processing Systems (NeurIPS), 2022, \[20\] Z. Wang, W. Wang,
Z. Li, L. Wang, C. Yi, X. Xu, pp. 27 730--27 744. L. Cao, H. Su, S.
Chen, and J. Zhou, "Xuat-copilot: \[7\] B. Roziere, J. Gehring, F.
Gloeckle, S. Sootla, I. Gat, Multi-agent collaborative system for
automated user X. E. Tan, Y. Adi, J. Liu, R. Sauvestre, T. Remez et al.,
acceptance testing with large language model," 2024. "Code LLaMA: Open
foundation models for code," \[21\] K. Zhang, C. Zhang, C. Wang, C.
Zhang, Y. Wu, 2023. Z. Xing, Y. Liu, Q. Li, and X. Peng, "Logiagent:
Auto- \[8\] Y. Wang, W. Wang, S. Joty, and S. C. Hoi, "CodeT5: mated
logical testing for rest systems with llm-based Identifier-aware unified
pre-trained encoder-decoder multi-agents," 2025. models for code
understanding and generation," in \[22\] N. Baumgartner, P. Iyenghar, T.
Schoemaker, and Conference on Empirical Methods in Natural Language E.
Pulvermüller, "Ai-driven refactoring: A pipeline for Processing (EMNLP),
2021, pp. 8696--8708. identifying and correcting data clumps in git
reposi- \[9\] Y. Li, D. Choi, J. Chung, N. Kushman, J. Schrit- tories,"
Electronics, vol. 13, no. 9, p. 1644, 2024. twieser, R. Leblond, T.
Eccles, J. Keeling, F. Gimeno, \[23\] M. Rabinovich, M. Stern, and D.
Klein, "Abstract A. Dal Lago et al., "Competition-level code generation
syntax networks for code generation and semantic with Alphacode,"
Science, vol. 378, no. 6624, pp. 1092-- parsing," in Meeting of the
Association for Computational 1097, 2022. Linguistics (ACL), 2017,
pp. 1139--1149. \[10\] X. Jiang, Y. Dong, L. Wang, Z. Fang, Q. Shang, G.
Li, \[24\] D. Guo, S. Ren, S. Lu, Z. Feng, D. Tang, S. Liu, Z. Jin, and
W. Jiao, "Self-planning code generation L. Zhou, N. Duan, A.
Svyatkovskiy, S. Fu et al., with large language models," ACM
Transactions on "GraphCodeBERT: Pre-training code representations
Software Engineering and Methodology, vol. 33, no. 7, with data flow,"
in International Conference on Learning pp. 1--30, 2024.
Representations, 2021. \[11\] H. Le, H. Chen, A. Saha, A. Gokul, D.
Sahoo, and \[25\] D. Guo, S. Lu, N. Duan, Y. Wang, M. Zhou, and S. Joty,
"CodeChain: Towards modular code genera- J. Yin, "UniXcoder: Unified
cross-modal pre-training tion through chain of self-revisions with
representa- for code representation," pp. 7212--7225, 2022. tive
sub-modules," in International Conference on Learn- \[26\] Y. Hu, Q.
Zhou, Q. Chen, X. Li, L. Liu, D. Zhang, ing Representations (ICLR),
2023. A. Kachroo, T. Oz, and O. Tripp, "Qualityflow: An \[12\] R. Pan,
H. Zhang, and C. Liu, "CodeCoR: An llm- agentic workflow for program
synthesis controlled by based self-reflective multi-agent framework for
code llm quality checks," 2025. generation," 2025. \[27\] Y. Ishibashi
and Y. Nishimura, "Self-organized agents: \[13\] Z. Rasheed, M. Waseem,
M. Saari, K. Systä, and A LLM multi-agent framework toward ultra large-
P. Abrahamsson, "Codepori: Large scale model for scale code generation
and optimization," 2024. autonomous software development by using multi-
\[28\] K. Zhang, J. Li, G. Li, X. Shi, and Z. Jin, "CodeAgent: agents,"
2024. Enhancing code generation with tool-integrated agent \[14\] S.
Manish, "An autonomous multi-agent llm frame- systems for real-world
repo-level coding challenges," work for agile software development,"
International in Meeting of the Association for Computational Linguis-
Journal of Trend in Scientific Research and Development, tics (ACL),
2024. vol. 8, no. 5, pp. 892--898, 2024. \[29\] R. Wang, X. Han, L. Ji,
S. Wang, T. Baldwin, and \[15\] Y. Dong, X. Jiang, Z. Jin, and G. Li,
"Self-collaboration H. Li, "Toolgen: Unified tool retrieval and calling
code generation via ChatGPT," ACM Transactions on via generation," in
International Conference on Learning Software Engineering and
Methodology, vol. 33, no. 7, Representations (ICLR), 2025. pp. 1--38,
2024. \[30\] R. Sapkota, K. I. Roumeliotis, and M. Karkee, "Vibe \[16\]
C. Qian, W. Liu, H. Liu, N. Chen, Y. Dang, J. Li, coding vs. agentic
coding: Fundamentals and practical C. Yang, W. Chen, Y. Su, X. Cong et
al., "Chatdev: implications of agentic AI," 2025. Communicative agents
for software development," in \[31\] M. Schäfer, S. Nadi, A. Eghbali,
and F. Tip, "Adaptive Meeting of the Association for Computational
Linguistics test generation using a large language model," 2023. (ACL),
2023, pp. 15 174--15 186. \[32\] Q. Xu, G. Wang, L. Briand, and K. Liu,
"A multi-agent \[17\] S. Hong, X. Zheng, J. Chen, Y. Cheng, J. Wang,
llm-based juit test generation with strong oracles,"  19

       2025.                                                                 pp. 1–45, 2024.

\[33\] M. T. Dearing, Y. Tao, X. Wu, Z. Lan, and V. Taylor, \[48\] W. X.
Zhao, K. Zhou, J. Li, T. Tang, X. Wang, Y. Hou, "Leveraging llms to
automate energy-aware refactor- Y. Min, B. Zhang, J. Zhang, Z. Dong et
al., "A survey ing of parallel scientific codes," 2025. of large
language models," 2023. \[34\] H. Peng, A. Gupte, R. Hasler, N. J.
Eliopoulos, C.- \[49\] H. Naveed, A. U. Khan, S. Qiu, M. Saqib, S.
Anwar, C. Ho, R. Mantri, L. Deng, K. Läufer, G. K. Thiru- M. Usman, N.
Akhtar, N. Barnes, and A. Mian, "A vathukal, and J. C. Davis,
"Sysllmatic: Large language comprehensive overview of large language
models," models are software system optimizers," 2025. ACM Transactions
on Intelligent Systems and Technology, \[35\] W. Shi, Y. Zhang, X. Xing,
and J. Xu, "Harnessing 2023. large language models for seed generation
in greybox \[50\] A. Vaswani, N. Shazeer, N. Parmar, J. Uszkoreit,
fuzzing," 2024. L. Jones, A. N. Gomez, Ł. Kaiser, and I. Polosukhin,
\[36\] C. Foster, A. Gulati, M. Harman, I. Harper, K. Mao, "Attention is
all you need," in Conference on Neural J. Ritchey, H. Robert, and S.
Sengupta, "Mutation- Information Processing Systems (NeurIPS), 2017.
guided llm-based test generation at meta," 2025. \[51\] M. Chen, J.
Tworek, H. Jun, Q. Yuan, H. P. D. O. \[37\] H. Jin, L. Huang, H. Cai, J.
Yan, B. Li, and H. Chen, Pinto, J. Kaplan, H. Edwards, Y. Burda, N.
Joseph, "From LLMs to LLM-based agents for software engi- G. Brockman et
al., "Evaluating large language models neering: A survey of current,
challenges and future," trained on code," 2021. 2024. \[52\] B. Rozière,
J. Gehring, F. Gloeckle, S. Sootla, I. Gat, \[38\] J. Liu, K. Wang, Y.
Chen, X. Peng, Z. Chen, L. Zhang, X. E. Tan, Y. Adi, J. Liu, R.
Sauvestre, T. Re- and Y. Lou, "Large language model-based agents for
mez, J. Rapin, A. Kozhevnikov, I. Evtimov, J. Bit- software engineering:
A survey," 2024. ton, M. Bhatt, C. C. Ferrer, A. Grattafiori, W. Xiong,
\[39\] J. He, C. Treude, and D. Lo, "Llm-based multi-agent A. Défossez,
J. Copet, F. Azhar, H. Touvron, L. Mar- systems for software
engineering: Literature review, tin, N. Usunier, T. Scialom, and G.
Synnaeve, "Code vision, and the road ahead," ACM Transactions on Llama:
open foundation models for code," 2024. Software Engineering and
Methodology, vol. 34, no. 5, \[53\] D. Guo, Q. Zhu, D. Yang, Z. Xie, K.
Dong, W. Zhang, pp. 1--30, 2025. G. Chen, X. Bi, Y. Wu, Y. Li et al.,
"Deepseek-coder: \[40\] Y. Wang, W. Zhong, Y. Huang, E. Shi, M. Yang, J.
Chen, When the large language model meets programming-- H. Li, Y. Ma, Q.
Wang, and Z. Zheng, "Agents in the rise of code intelligence," 2024.
software engineering: Survey, landscape, and vision," \[54\] B. Hui, J.
Yang, Z. Cui, J. Yang, D. Liu, L. Zhang, T. Liu, 2024. J. Zhang, B. Yu,
K. Lu et al., "Qwen2. 5-coder technical \[41\] A. Svyatkovskiy, S. K.
Deng, S. Fu, and N. Sundaresan, report," 2024. "Intellicode compose:
Code generation using trans- \[55\] J. Wei, X. Wang, D. Schuurmans, M.
Bosma, F. Xia, former," in ACM Joint Meeting on European Software E.
Chi, Q. V. Le, D. Zhou et al., "Chain-of-thought Engineering Conference
and Symposium on the Founda- prompting elicits reasoning in large
language mod- tions of Software Engineering, 2020, pp. 1433--1443. els,"
in Conference on Neural Information Processing \[42\] J. Herrington,
Code generation in action. Manning Systems (NeurIPS), 2022, pp. 24
824--24 837. Publications Co., 2003. \[56\] E. Wang, F. Cassano, C. Wu,
Y. Bai, W. Song, V. Nath, \[43\] B. A. Becker, P. Denny, J.
Finnie-Ansley, A. Luxton- Z. Han, S. Hendryx, S. Yue, and H. Zhang,
"Planning Reilly, J. Prather, and E. A. Santos, "Programming is in
natural language improves LLM search for code hard-or at least it used
to be: Educational opportuni- generation," in International Conference
on Learning ties and challenges of AI code generation," in ACM
Representations (ICLR), 2025. Technical Symposium on Computer Science
Education V. 1 \[57\] R. Nakano, J. Hilton, S. Balaji, J. Wu, L. Ouyang,
(SIGCSE), 2023, pp. 500--506. C. Kim, C. Hesse, S. Jain, V. Kosaraju, W.
Saun- \[44\] F. F. Xu, B. Vasilescu, and G. Neubig, "In-IDE code ders,
X. Jiang, K. Cobbe, T. Eloundou, G. Krueger, generation from natural
language: Promise and chal- K. Button, M. Knight, B. Chess, and J.
Schulman, lenges," ACM Transactions on Software Engineering and "WebGPT:
Browser-assisted question-answering with Methodology (TOSEM), vol. 31,
no. 2, pp. 1--47, 2022. human feedback," 2022. \[45\] N. Huynh and B.
Lin, "Large language models \[58\] T. Schick, J. Dwivedi-Yu, R. Dessı̀,
R. Raileanu, for code generation: A comprehensive survey of M. Lomeli,
E. Hambro, L. Zettlemoyer, N. Cancedda, challenges, techniques,
evaluation, and applications," and T. Scialom, "Toolformer: Language
models can 2025. teach themselves to use tools," in Conference on Neu-
\[46\] E. Kasneci, K. Seßler, S. Küchemann, M. Bannert, ral Information
Processing Systems (NeurIPS), 2023, pp. D. Dementieva, F. Fischer, U.
Gasser, G. Groh, 68 539--68 551. S. Günnemann, E. Hüllermeier et al.,
"ChatGPT for \[59\] L. Gao, A. Madaan, S. Zhou, U. Alon, P. Liu, Y.
Yang, good? on opportunities and challenges of large lan- J. Callan, and
G. Neubig, "Pal: Program-aided lan- guage models for education,"
Learning and Individual guage models," in International Conference on
Machine Differences, vol. 103, p. 102274, 2023. Learning (ICML), 2023.
\[47\] Y. Chang, X. Wang, J. Wang, Y. Wu, L. Yang, K. Zhu, \[60\] Z. Xi,
W. Chen, X. Guo, W. He, Y. Ding, B. Hong, H. Chen, X. Yi, C. Wang, Y.
Wang et al., "A survey on M. Zhang, J. Wang, S. Jin, E. Zhou et al.,
"The rise evaluation of large language models," ACM transac- and
potential of large language model based agents: tions on intelligent
systems and technology, vol. 15, no. 3, A survey," Science China
Information Sciences, vol. 68,  20

       no. 2, p. 121101, 2025.                                         [76] X. Wang, Y. Chen, L. Yuan, Y. Zhang, Y. Li, H. Peng,

\[61\] L. Wang, C. Ma, X. Feng, Z. Zhang, H. Yang, J. Zhang, and H. Ji,
"Executable code actions elicit better LLM Z. Chen, J. Tang, X. Chen, Y.
Lin et al., "A survey agents," in International Conference on Machine
Learning on large language model based autonomous agents," (ICML), 2024.
Frontiers of Computer Science, vol. 18, no. 6, p. 186345, \[77\] T.
Huang, Z. Sun, Z. Jin, G. Li, and C. Lyu, 2024. "Knowledge-aware code
generation with large lan- \[62\] T. Guo, X. Chen, Y. Wang, R. Chang, S.
Pei, N. V. guage models," in IEEE/ACM International Conference Chawla,
O. Wiest, and X. Zhang, "Large language on Program Comprehension (ICPC),
2024, pp. 52--63. model based multi-agents: A survey of progress and
\[78\] I. Gur, H. Furuta, A. Huang, M. Safdari, Y. Matsuo, challenges,"
2024. D. Eck, and A. Faust, "A real-world webagent with \[63\] Y. Cheng,
C. Zhang, Z. Zhang, X. Meng, S. Hong, planning, long context
understanding, and program W. Li, Z. Wang, Z. Wang, F. Yin, J. Zhao et
al., "Ex- synthesis," in International Conference on Learning Rep-
ploring large language model based intelligent agents: resentations
(ICLR), 2024. Definitions, methods, and prospects," 2024. \[79\] R.
Bairi, A. Sonwane, A. Kanade, V. D. C, A. Iyer, \[64\] L. Giray, "Prompt
engineering with ChatGPT: a guide S. Parthasarathy, S. Rajamani, B.
Ashok, and S. Shet, for academic writers," Annals of biomedical
engineering, "Codeplan: Repository-level coding using LLMs and vol. 51,
no. 12, pp. 2629--2633, 2023. planning," ACM on Software Engineering,
vol. 1, no. \[65\] J. White, Q. Fu, S. Hays, M. Sandborn, C. Olea, FSE,
pp. 675--698, 2024. H. Gilbert, A. Elnashar, J. Spencer-Smith, and D. C.
\[80\] N. Dainese, M. Merler, M. Alakuijala, and P. Martti- Schmidt, "A
prompt pattern catalog to enhance nen, "Generating code world models
with large lan- prompt engineering with chatgpt," 2023. guage models
guided by monte carlo tree search," \[66\] Y. Gao, Y. Xiong, X. Gao, K.
Jia, J. Pan, Y. Bi, Y. Dai, in Conference on Neural Information
Processing Systems J. Sun, H. Wang, and H. Wang, "Retrieval-augmented
(NeurIPS), 2024, pp. 60 429--60 474. generation for large language
models: A survey," \[81\] J. Li, H. Le, Y. Zhou, C. Xiong, S. Savarese,
and D. Sa- 2023. hoo, "Codetree: agent-guided tree search for code
\[67\] P. Lewis, E. Perez, A. Piktus, F. Petroni, V. Karpukhin,
generation with large language models," in Conference N. Goyal, H.
Küttler, M. Lewis, W.-t. Yih, of the Nations of the Americas Chapter of
the Association T. Rocktäschel et al., "Retrieval-augmented generation
for Computational Linguistics (NAACL), 2025. for knowledge-intensive nlp
tasks," in Conferecce on \[82\] Z. Ni, Y. Li, N. Yang, D. Shen, P. Lv,
and D. Dong, Neural Information Processing Systems (NeurIPS), 2020,
"Tree-of-Code: A tree-structured exploring frame- pp. 9459--9474. work
for end-to-end code generation and execution \[68\] J. Li, C. Tao, J.
Li, G. Li, Z. Jin, H. Zhang, Z. Fang, in complex task handling," 2024.
and F. Liu, "Large language model-aware in-context \[83\] V. Aggarwal,
O. Kamal, A. Japesh, Z. Jin, and learning for code generation," ACM
Transactions on B. Schölkopf, "DARS: Dynamic action re-sampling to
Software Engineering and Methodology, 2023. enhance coding agent
performance by adaptive tree \[69\] J. Wei, J. Wei, Y. Tay, D. Tran, A.
Webson, Y. Lu, traversal," 2025. X. Chen, H. Liu, D. Huang, D. Zhou et
al., "Larger \[84\] C.-T. Ho, H. Ren, and B. Khailany, "Verilogcoder:
language models do in-context learning differently," Autonomous Verilog
coding agents with graph-based 2023. planning and abstract syntax tree
(ast)-based wave- \[70\] D. Huang, J. M. Zhang, M. Luck, Q. Bu, Y. Qing,
form tracing tool," in AAAI Conference on Artificial and H. Cui,
"AgentCoder: Multi-agent-based code Intelligence (AAAI), vol. 39, no. 1,
2025, pp. 300--307. generation with iterative testing and optimisation,"
\[85\] K. Zainullina, A. Golubev, M. Trofimova, S. Polezhaev, 2023. I.
Badertdinov, D. Litvintseva, S. Karasik, F. Fisin, \[71\] H. N. Phan, T.
N. Nguyen, P. X. Nguyen, and N. D. S. Skvortsov, M. Nekrashevich, A.
Shevtsov, and Bui, "HyperAgent: Generalist software engineering B.
Yangel, "Guided search strategies in non- agents to solve coding tasks
at scale," 2024. serializable environments with applications to soft-
\[72\] K. Zhang, H. Zhang, G. Li, J. Li, Z. Li, and Z. Jin, ware
engineering agents," in International Conference "ToolCoder: Teach code
generation models to use API on Machine Learning (ICML), 2025. search
tools," 2023. \[86\] X. Jiang, Y. Dong, Y. Tao, H. Liu, Z. Jin, W. Jiao,
\[73\] H. N. Phan, H. N. Phan, T. N. Nguyen, and N. D. Bui, and G. Li,
"ROCODE: Integrating backtracking mech- "Repohyper: Better context
retrieval is all you need anism and program analysis in large language
models for repository-level code completion," 2024. for code
generation," in IEEE/ACM International Con- \[74\] A. Madaan, N. Tandon,
P. Gupta, S. Hallinan, L. Gao, ference on Software Engineering (ICSE),
2025, pp. 670-- S. Wiegreffe, U. Alon, N. Dziri, S. Prabhumoye, 670. Y.
Yang et al., "Self-refine: Iterative refinement with \[87\] Y. Lu, F.
Ye, J. Li, Q. Gao, C. Liu, H. Luo, N. Du, X. Li, self-feedback," in
Conference on Neural Information Pro- and F. Ren, "CodeTool: Enhancing
programmatic tool cessing Systems (NeurIPS), 2023, pp. 46 534--46 594.
invocation of LLMs via process supervision," 2025. \[75\] K. Zhang, Z.
Li, J. Li, G. Li, and Z. Jin, "Self-Edit: Fault- \[88\] T. Gupta, L.
Weihs, and A. Kembhavi, "CodeNav: aware code editor for code
generation," in Meeting Beyond tool-use to using real-world codebases
with of the Association for Computational Linguistics (ACL), llm
agents," 2024. 2023, pp. 769--787. \[89\] M. Acharya, Y. Zhang, K.
Leach, and Y. Huang, "Op-  21

      timizing code runtime performance through context-                fuzz testing,” 2024.
      aware retrieval-augmented generation,” in Interna-          [104] Y. Hu, Q. Zhou, Q. Chen, X. Li, L. Liu, D. Zhang,
      tional Conference on Program Comprehension (ICPC),                A. Kachroo, T. Oz, and O. Tripp, “QualityFlow: An
      2025, pp. 1–5.                                                    agentic workflow for program synthesis controlled by

\[90\] M. Athale and V. Vaddina, "Knowledge graph based LLM quality
checks," 2025. repository-level code generation," in IEEE/ACM Inter-
\[105\] A. Rahman, V. Cvetkovic, K. Reece, A. Walters, Y. Has- national
Workshop on Large Language Models for Code san, A. Tummeti, B. Torres,
D. Cooney, M. Ellis, and (LLM4Code), 2025, pp. 169--176. D. S.
Nikolopoulos, "MACRO: A multi-agent system \[91\] Y. Zhang, X. Zhao, Z.
Z. Wang, C. Yang, J. Wei, and for optimizing hpc code generation using
large lan- T. Wu, "cAST: Enhancing code retrieval-augmented guage
models," 2025. generation with structural chunking via abstract syn-
\[106\] S. Liu, J. Fang, H. Zhou, Y. Wang, and Z. Meng, "SEW: tax tree,"
2025. Self-evolving agentic workflows for automated code \[92\] Y. Lai,
S. Lee, G. Chen, S. Poddar, M. Hu, D. Z. Pan, generation," 2025. and P.
Luo, "AnalogCoder: Analog circuit design via \[107\] Y. Hu, Y. Cai, Y.
Du, X. Zhu, X. Liu, Z. Yu, Y. Hou, training-free code generation," in
AAAI Conference on S. Tang, and S. Chen, "Self-evolving multi-agent
Artificial Intelligence (AAAI), no. 1, 2025, pp. 379--387. collaboration
networks for software development," \[93\] T. Chang, S. Chen, G. Fan,
and Z. Feng, "A self- in International Conference on Learning
Representations iteration code generation method based on large lan-
(ICLR), 2025. guage models," in International Conference on Parallel
\[108\] S. Holt, M. R. Luyten, and M. van der Schaar, and Distributed
Systems (ICPADS), 2023, pp. 275--281. "L2MAC: Large language model
automatic computer \[94\] X. Chen, M. Lin, N. Schärli, and D. Zhou,
"Teaching for extensive code generation," 2023. large language models to
self-debug," in Meeting Of \[109\] Y. Li, J. Li, Q. Wang, M. Yang, H.
Kong, and The Association For Computational Linguistics (ACL), S. Wang,
"Cogito, ergo sum: A neurobiologically- 2023. inspired
cognition-memory-growth system for code \[95\] T. X. Olausson, J. P.
Inala, C. Wang, J. Gao, and generation," 2025. A. Solar-Lezama, "Is
self-repair a silver bullet for code \[110\] D. Chen, H. Wang, Y. Huo,
Y. Li, and H. Zhang, generation?" 2024. "Gamegpt: Multi-agent
collaborative framework for \[96\] N. Jiang, X. Li, S. Wang, Q. Zhou, S.
B. Hossain, game development," 2023. B. Ray, V. Kumar, X. Ma, and A.
Deoras, "Ledex: \[111\] D. Qi, Z. Miao, and J. Wang, "Cleanagent:
Automating Training LLMs to better self-debug and explain code," data
standardization with llm-based agents," 2024. in Conference on Neural
Information Processing Systems \[112\] Y. Ma, R. Cao, Y. Cao, Y. Zhang,
J. Chen, Y. Liu, (NeurIPS), 2024, pp. 35 517--35 543. Y. Liu, B. Li, F.
Huang, and Y. Li, "Lingma SWE- \[97\] Z. Rasheed, M. A. Sami, K.-K.
Kemell, M. Waseem, GPT: An open development-process-centric language M.
Saari, K. Systä, and P. Abrahamsson, "Codepori: model for automated
software improvement," 2024. Large-scale system for autonomous software
develop- \[113\] X. Guo, X. Wang, Y. Chen, S. Li, C. Han, M. Li, ment
using multi-agent technology," 2024. and H. Ji, "Syncmind: Measuring
agent out-of-sync \[98\] W. Tao, Y. Zhou, Y. Wang, W. Zhang, H. Zhang,
and recovery in collaborative software engineering," in Y. Cheng,
"Magis: LLM-based multi-agent framework International Conference on
Machine Learning (ICML), for github issue resolution," in Conference on
Neural 2025. Information Processing Systems (NeurIPS), vol. 37, 2024,
\[114\] Q. Xu, G. Wang, L. Briand, and K. Liu, "Hallucination pp. 51
963--51 993. to consensus: Multi-agent LLMs for end-to-end test \[99\]
H. Zhang, W. Cheng, Y. Wu, and W. Hu, "A pair pro- generation with
accurate oracles," 2025. gramming framework for code generation via
multi- \[115\] A. Zhou, K. Yan, M. Shlapentokh-Rothman, H. Wang, plan
exploration and feedback-driven refinement," in and Y.-X. Wang,
"Language agent tree search unifies IEEE/ACM International Conference on
Automated Soft- reasoning, acting, and planning in language models,"
ware Engineering (ASE), 2024, pp. 1319--1331. in International
Conference on Machine Learning (ICML), \[100\] F. Lin, D. J. Kim et al.,
"Soen-101: Code generation 2024, pp. 62 138--62 160. by emulating
software process models using large \[116\] D. Jin, Z. Jin, X. Chen, and
C. Wang, "MARE: Multi- language model agents," in International
Conference on agents collaboration framework for requirements en-
Software Engineering (ICSE), 2025, pp. 1527--1539. gineering," 2024.
\[101\] Y. Zhao, H. Zhang, H. Huang, Z. Yu, and J. Zhao, \[117\] Y. Xu,
H. Su, C. Xing, B. Mi, Q. Liu, W. Shi, B. Hui, "MAGE: A multi-agent
engine for automated RTL F. Zhou, Y. Liu, T. Xie et al., "Lemur:
Harmoniz- code generation," 2024. ing natural language and code for
language agents," \[102\] M. A. Islam, M. E. Ali, and M. R. Parvez,
"MapCoder: in International Conference on Learning Representations
Multi-agent code generation for competitive problem (ICLR), 2024.
solving," in Proceedings of the 62nd Annual Meeting \[118\] M. A. Islam,
M. E. Ali, and M. R. Parvez, "Codesim: of the Association for
Computational Linguistics (ACL), Multi-agent code generation and problem
solving 2024, pp. 4912--4944. through simulation-driven planning and
debugging," \[103\] A. Nunez, N. T. Islam, S. K. Jha, and P. Najafirad,
in Findings of the Association for Computational Linguis-
"Autosafecoder: A multi-agent framework for secur- tics, 2025. ing llm
code generation through static analysis and \[119\] D. Zan, A. Yu, W.
Liu, D. Chen, B. Shen, W. Li, Y. Yao,  22

      Y. Gong, X. Chen, B. Guan et al., “CodeS: Natural                  quirements oriented gui function testing,” 2024.
      language to code repository via multi-layer sketch,”         [133] https://developer.nvidia.com/blog/building-ai-
      2024.                                                              agents-to-automate-software-test-case-creation/.

\[120\] M. H. Nguyen, T. P. Chau, P. X. Nguyen, and N. D. \[134\] D. Wu,
F. Mu, L. Shi, Z. Guo, K. Liu, W. Zhuang, Bui, "AgileCoder: Dynamic
collaborative agents for Y. Zhong, and L. Zhang, "ismell: Assembling
llms software development based on agile methodology," with expert
toolsets for code smell detection and refac- in IEEE/ACM International
Conference on AI Foundation toring," in IEEE/ACM International
Conference on Au- Models and Software Engineering (FORGE), 2025,
pp. tomated Software Engineering (ICASE), 2024, pp. 1345-- 156--167.
1357. \[121\] I. Bouzenia, P. Devanbu, and M. Pradel, "Repaira- \[135\]
D. Pomian, A. Bellur, M. Dilhara, Z. Kurbatova, E. Bo- gent: An
autonomous, llm-based agent for program gomolov, A. Sokolov, T. Bryksin,
and D. Dig, "EM- repair," in International Conference on Software
Engineer- Assist: Safe automated extractmethod refactoring with ing
(ICSE), 2025, pp. 694--694. LLMs," in Companion Proceedings of the 32nd
ACM \[122\] Y. Zhang, H. Ruan, Z. Fan, and A. Roychoudhury,
International Conference on the Foundations of Software "AutoCodeRover:
Autonomous program improve- Engineering, 2024, pp. 582--586. ment," in
ACM SIGSOFT International Symposium on \[136\] S. Siddeeq, Z. Rasheed,
M. A. Sami, M. Hasan, Software Testing and Analysis (ISSTA), 2024,
pp. 1592-- M. Waseem, J. Rasku, M. Saari, K.-K. Kemell, and 1604. P.
Abrahamsson, "Distributed approach to haskell \[123\] J. Yang, C. E.
Jimenez, A. Wettig, K. Lieret, S. Yao, based applications refactoring
with llms based multi- K. Narasimhan, and O. Press, "Swe-agent: Agent-
agent systems," 2025. computer interfaces enable automated software
engi- \[137\] Z. Jiang, D. Schmidt, D. Srikanth, D. Xu, I. Kaplan,
neering," in Conference on Neural Information Processing D. Jacenko, and
Y. Wu, "AIDE: AI-driven exploration Systems (NeurIPS), 2024, pp. 50
528--50 652. in the space of code," 2025. \[124\] A. Nunez, N. T. Islam,
S. K. Jha, and P. Najafirad, \[138\] S. Fakhoury, A. Naik, G. Sakkas, S.
Chakraborty, and "Autosafecoder: A multi-agent framework for secur- S.
K. Lahiri, "LLM-based test-driven interactive code ing llm code
generation through static analysis and generation: User study and
empirical evaluation," fuzz testing," 2024. IEEE Transactions on
Software Engineering, 2024. \[125\] A. Antoniades, A. Örwall, K. Zhang,
Y. Xie, A. Goyal, \[139\] H. Jia, R. Morris, H. Ye, F. Sarro, and S.
Mechtaev, and W. Wang, "Swe-search: Enhancing software "Automated repair
of ambiguous natural language agents with monte carlo tree search and
iterative requirements," 2025. refinement," in International Conference
on Learning \[140\] S. Vijayvargiya, X. Zhou, A. Yerukola, M. Sap, and
Representations (ICLR), 2024. G. Neubig, "Interactive agents to overcome
ambiguity \[126\] J. Cen, J. Liu, Z. Li, and J. Wang, "SQLFixAgent: in
software engineering," 2025. Towards semantic-accurate text-to-SQL
parsing via \[141\] E. A. González, R. Rothkopf, S. Lerner, and N. Po-
consistency-enhanced multi-agent collaboration," in likarpova, "HILDE:
Intentional code generation via AAAI Conference on Artificial
Intelligence (AAAI), no. 1, human-in-the-loop decoding," 2025. 2025,
pp. 49--57. \[142\] K. Liu, Y. Liu, Z. Chen, J. M. Zhang, Y. Han, Y. Ma,
\[127\] Z. Yu, H. Zhang, Y. Zhao, H. Huang, M. Yao, K. Ding, Y. Dong, G.
Li, and G. Huang, "Llm-powered test case and J. Zhao, "Orcaloca: An llm
agent framework for generation for detecting bugs in plausible
programs," software issue localization," in International Conference
2024. on Machine Learning (ICML), 2025. \[143\] J. Austin, A. Odena, M.
I. Nye, M. Bosma, \[128\] H. Li, Y. Tang, S. Wang, and W. Guo,
"Patchpilot: A H. Michalewski, D. Dohan, E. Jiang, C. J. Cai, M. Terry,
stable and cost-efficient agentic patching framework," Q. V. Le, and C.
Sutton, "Program synthesis with large 2025. language models," 2021.
\[129\] Y. Ma, Y. Li, Y. Dong, X. Jiang, R. Cao, J. Chen, \[144\] D.
Hendrycks, S. Basart, S. Kadavath, M. Mazeika, F. Huang, and B. Li,
"Thinking longer, not larger: A. Arora, E. Guo, C. Burns, S. Puranik, H.
He, D. Song, Enhancing software engineering agents via scaling and J.
Steinhardt, "Measuring coding challenge com- test-time compute," 2025.
petence with APPS," in Neural Information Processing \[130\] H. Ye, A.
Z. Yang, C. Hu, Y. Wang, T. Zhang, and Systems (NeurIPS) Datasets and
Benchmarks Track, 2021. C. Le Goues, "Adverintent-agent: Adversarial
rea- \[145\] N. Jain, K. Han, A. Gu, W. Li, F. Yan, T. Zhang, soning for
repair based on inferred program intent," S. Wang, A. Solar-Lezama, K.
Sen, and I. Stoica, Proceedings of the ACM on Software Engineering,
vol. 2, "Livecodebench: Holistic and contamination free eval- no. ISSTA,
pp. 1398--1420, 2025. uation of large language models for code," in
Inter- \[131\] A. Sohrabizadeh, J. Song, M. Liu, R. Roy, C. Lee,
national Conference on Learning Representations (ICLR), J. Raiman, and
B. Catanzaro, "Nemotron-cortexa: En- 2025. hancing llm agents for
software engineering tasks \[146\] Y. Dong, X. Jiang, H. Liu, Z. Jin, B.
Gu, M. Yang, via improved localization and solution diversity," in and
G. Li, "Generalization or memorization: Data International Conference on
Machine Learning (ICML), contamination and trustworthy evaluation for
large 2025. language models," in ACL (Findings). Association for \[132\]
Y. Hu, X. Wang, Y. Wang, Y. Zhang, S. Guo, C. Chen, Computational
Linguistics, 2024, pp. 12 039--12 050. X. Wang, and Y. Zhou,
"Auitestagent: Automatic re- \[147\] C. E. Jimenez, J. Yang, A. Wettig,
S. Yao, K. Pei,  23

      O. Press, and K. R. Narasimhan, “Swe-bench: Can
      language models resolve real-world github issues?”
      in International Conference on Learning Representations
      (ICLR), 2024.

\[148\] K. Xu, Y. Mao, X. Guan, and Z. Feng, "Web-bench: A LLM code
benchmark based on web standards and frameworks," 2025. \[149\] P.
Gauthier, "Gpt code editing benchmarks,"
https://aider.chat/docs/benchmarks.html#the- benchmark, 2024, \[Accessed
21-01-2025\]. \[150\] J. Li, G. Li, X. Zhang, Y. Dong, and Z. Jin,
"Evocodebench: An evolving code generation bench- mark aligned with
real-world code repositories," 2024. \[151\] J. Li, G. Li, Y. Zhao, Y.
Li, H. Liu, H. Zhu, L. Wang, K. Liu, Z. Fang, L. Wang, J. Ding, X.
Zhang, Y. Zhu, Y. Dong, Z. Jin, B. Li, F. Huang, and Y. Li, "Deveval: A
manually-annotated code generation benchmark aligned with real-world
code repositories," 2024. \[152\] Y. Dong, J. Ding, X. Jiang, G. Li, Z.
Li, and Z. Jin, "Codescore: Evaluating code generation by learning code
execution," ACM Trans. Softw. Eng. Methodol., vol. 34, no. 3,
pp. 77:1--77:22, 2025. \[153\] J. Hu, W. Zheng, Y. Liu, and Y. Liu,
"Optimizing token consumption in llms: A nano surge approach for code
reasoning efficiency," 2025. \[154\] C. Zhao, C. Deng, C. Ruan, D. Dai,
H. Gao, J. Li, L. Zhang, P. Huang, S. Zhou, S. Ma, W. Liang, Y. He, Y.
Wang, Y. Liu, and Y. X. Wei, "Insights into deepseek- v3: Scaling
challenges and reflections on hardware for ai architectures," in
International Symposium on Computer Architecture (ISCA), 2025,
pp. 1731--1745. \[155\] H. Lee, Z. Zhang, H. Lu, and L. Zhang,
"Sec-bench: Automated benchmarking of llm agents on real-world software
security tasks," 2025. \[156\] K. Zhang, H. Zhang, G. Li, J. You, J. Li,
Y. Zhao, and Z. Jin, "Sealign: Alignment training for software
engineering agent," 2025. \[157\] S. Siddeeq, M. Waseem, Z. Rasheed, M.
M. Hasan, J. Rasku, M. Saari, H. Terho, K. Makela, K.-K. Kemell, and P.
Abrahamsson, "Llm-based multi-agent system for intelligent refactoring
of haskell code," 2025. \[158\] Z. Chen and L. Jiang, "Evaluating
software develop- ment agents: Patch patterns, code quality, and issue
complexity in real-world github scenarios," pp. 657-- 668, 2025. \[159\]
https://github.com/copilot. \[160\] https://devin.ai. \[161\]
https://www.cursor.com. \[162\] https://lingma.aliyun.com. \[163\]
https://www.anthropic.com/claude-code. 
