      Under review as a conference paper at ICLR 2026

000 001 D O L ARGE L ANGUAGE M ODELS R ESPECT C ON - 002 TRACTS ? E
VALUATING AND E NFORCING C ONTRACT- 003 004 A DHERENCE IN C ODE G
ENERATION 005 006 Anonymous authors 007 Paper under double-blind review
008 009 010 011 A BSTRACT 012 013 Prevailing code generation benchmarks,
such as HumanEval+ and MBPP+, pri- 014 marily evaluate large language
models (LLMs) with pass@k on functional correct- 015 ness using
well-formed inputs. However, they ignore a crucial aspect of real-world
016 software: adherence to contracts---the preconditions and validity
constraints that 017 dictate how ill-formed inputs must be rejected.
This critical oversight means that 018 existing benchmarks fail to
measure, and models consequently fail to generate, truly robust and
reliable code snippets. We introduce PACT, a program assessment 019 and
contract-adherence evaluation framework, to bridge this gap. PACT is the
first 020 framework designed to systematically evaluate and enhance
contract-adherence 021 in LLM-generated code snippets alongside
functional correctness. PACT's contri- 022 butions are threefold: First,
it provides a comprehensive test-suite corpus focused 023 on contract
violations, extending HumanEval+ and MBPP+. Second, it enables a 024
systematic analysis of code generation under varied prompting
conditions. This 025 analysis demonstrates that augmenting prompts with
contract-violating test cases 026 significantly enhance a model's
ability to respect contracts compared to using con- 027 tract
description alone. Finally, it introduces novel metrics to rigorously
quantify 028 contract adherence in both test generation and code
generation. By revealing criti- 029 cal errors that conventional
benchmarks overlook, PACT provides the rigorous and interpretable
metrics to evaluate the robustness of LLM-generated code snippets 030 in
both functionality and contract-adherence. 031 032 033 034 1 I
NTRODUCTION 035 036 Test case generation is particularly crucial since
it validates correctness, reveals corner cases, and 037 supports
automated evaluation. Traditional approaches such as random testing (Cha
et al., 2015), 038 symbolic execution (King, 1976; Yoon & Cha, 2024;
Cadar et al., 2008), and search-based software 039 testing (Harman &
McMinn, 2010; Formica et al., 2024; Burnim & Sen, 2008) have laid the
ground- work. Then, various large language model (LLM)-driven methods
have recently been investigated, 040 including zero-shot prompting (Chen
et al., 2021a; Jaremko et al., 2025), coverage-guided test gen- 041
eration (Ryan et al., 2024; Lemieux et al., 2023; Sapozhnikov et al.,
2024), mutation-informed gen- 042 eration (Dakhel et al., 2024; Cajica
et al., 2021), slicing-based decomposition (Wang et al., 2024), 043 and
satisfiability modulo theories (SMT) solver-based test generation
(Peleska et al., 2011; Cadar 044 et al., 2008). 045 Yet current test
case generation approaches (Srivastava & Payer, 2021; Yoon & Cha, 2024)
and the 046 resulting benchmarks (Chen et al., 2021a) still judge the
quality of both test cases and programs 047 exclusively through pass@k
(Chen et al., 2021a). In practice, real-world software is governed by
048 contracts (Meyer, 1992)---the preconditions and input validation
rules that restrict valid inputs and 049 define expected behavior for
ill-formed ones. As a black-box metric, pass@k measures correct- 050
ness only via input-output correspondence on well-formed inputs, which
are test cases that have 051 already been filtered to comply with these
contracts. Consequently, evaluating code snippets solely 052 by
well-formed input-output correspondence without considering contracts
leads to an inaccurate 053 assessment, as it overlooks whether the
generated code snippets enforce pre-conditions and input validation
checks explicitly stated or implicitly included in the specification
(Liu et al., 2023).

                                                        1

Under review as a conference paper at ICLR 2026

054 Typically, most coding competitions such as International Collegiate
Programming Contest 1 (ICPC) 055 or International Olympiad in
Informatics 2 provide specifications that state the constraints to 056
consider when implementing the function for the task. This description
includes not only the 057 functional goal---such as computing a sum or
sorting a list---but also a set of explicit con- 058 tracts, such as
input bounds, type restrictions, and required error-handling behaviors.
These 059 contracts often phrased in natural language or implied via
examples, act as contracts that de- 060 scribe the valid input space and
define the expected behavior under edge or invalid con- 061 ditions.
Figure 1 provides a clear illustration, showing how a simple functional
task de- 062 scription contains hidden contracts that are often
overlooked. For instance, a function de- 063 signed to find duplicate
values in a list of numbers, has_dup(nums), has an implicit con- tract
that the input must be a list containing only integers. A correct
implementation should 064 therefore include specific assertions---such
as assert isinstance(nums, list) and 065 assert all(isinstance(x, int)
for x in nums)---to verify the input's type before 066 proceeding with
the functional logic. If such checks are omitted, the program may appear
correct 067 on well-formed inputs like \[1, 2, 3\]. However, it will
fail to reject ill-formed inputs like 'a' 068 or \['2', 2\], thus
failing to reflect the intended specification. Ignoring these contracts
in code 069 generation poses serious reliability and safety issues. For
instance, a module might silently accept 070 an invalid input, such as a
negative number where a positive one is expected. By doing so, it can
071 propagate a hidden fault by passing a nonsensical result to another
part of the system. This chain 072 reaction often leads to logical
errors that are extremely difficult to trace back to their original
source. 073 Therefore, contracts are not optional safeguards 074 but
integral parts of the specification that de- 075 fine the boundary of
valid behavior. Without 076 them, even code snippets that appear func-
077 tionally correct cannot be trusted to operate 078 safely and
reliably. Empirical studies reveal that 079 LLM-generated code snippets
frequently over- 080 look these contracts and often fails to guard
against ill-formed inputs that violate them. As 081 a result, a
generated code may incorrectly pass 082 tests that it should fail,
creating the illusion of 083 correctness under default test cases. This
shows 084 that many seemingly correct solutions in fact 085 ignore
contractual requirements, underscoring 086 that contract adherence is a
fundamental neces- 087 sity for trustworthy code generation. 088 We
introduce PACT, a program assessment 089 and contract-adherence
evaluation framework, 090 to bridge this gap. The main focus of PACT 091
is twofold: first, to construct high-quality 092 contract-violating test
cases, and second, to 093 use them for a systematic analysis of
contract- 094 aware code generation. For test case genera- 095 tion, our
approach leverages an SMT solver to Figure 1: PACT's contract-violating
test uncovers 096 systematically explore diverse combinations of an
implicit constraint that conventional functional 097 contract
violations, moving beyond simplistic, tests miss, proving the need for
contract-aware single-violation tests. evaluation. 098 099 For example,
for a function with the contracts 100 assert isinstance(r, float),
assert r \> 0, and assert h \> 0, our method can 101 generate an input
such as r = -2.5 and h = 5. This test case is guaranteed to satisfy the
type 102 contract for r and the positivity contract for h, while
precisely violating only the positivity contract 103 for r. By pruning
logically inconsistent combinations in advance, the solver ensures that
only feasi- ble and semantically valid test cases are generated. For our
analysis of code generation, we then use 104 105 106 1 107 ICPC website:
https://icpc.global/ 2 IOI website: https://ioinformatics.org/

                                                            2

Under review as a conference paper at ICLR 2026

108 these precisely targeted test cases to evaluate how different
prompting strategies guide an LLM to 109 produce implementations that
properly enforce the intended contracts. 110 111 In summary, current
benchmarks overlook contract violations, thereby inflating the
perception 112 of correctness. Addressing this limitation, we propose
the PACT framework. PACT extends Hu- manEval+ and MBPP+ to generate test
cases focused on contract violations and introduces novel 113 metrics to
quantify contract adherence. 114 115 116 117 2 R ELATED WORK 118 119 120
2.1 AUTOMATED T EST AND C ODE G ENERATION 121 122 Automated test and
code generation have deep roots in traditional software engineering.
Early 123 test case generation was typically categorized into black-box
methods like random and mutational 124 fuzzing (Godefroid et al., 2005;
Claessen & Hughes, 2000), white-box techniques such as symbolic
execution (He et al., 2021; Cha et al., 2022; Godefroid et al., 2008),
and grey-box approaches like 125 coverage-guided fuzzing (Choi et al.,
2019; Stephens et al., 2016; She et al., 2024; Qian et al., 126 2022).
Similarly, early code generation relied on methods like probabilistic
grammar-based frame- 127 works (Bielik et al., 2016) and specialized
language models (Feng et al., 2020). The advent of the 128 Transformer
architecture marked a paradigm shift, establishing LLMs as the dominant
approach in 129 both fields (Chen et al., 2021b). The development of
modern Code LLMs now typically involves 130 pre-training on code
corpora, followed by instruction tuning (Ouyang et al., 2022) and
refinement 131 through more advanced techniques like reinforcement
learning with execution feedback (Gehring 132 et al., 2025). However,
despite these advancements, the primary goal has remained the
enhancement 133 of functional correctness, typically measured by pass@k
on benchmarks with well-formed inputs. 134 135 136 2.2 C ONTRACTS 137
138 The Design by Contract (DbC) paradigm (Meyer, 1992) argues that
software reliability depends on 139 explicitly stated preconditions,
postconditions, and invariants, with run-time assertions as the en- 140
forcement mechanism. However, mainstream automated testing and existing
test-generation bench- 141 marks (Wang et al., 2025; Jain et al., 2025)
often overlook latent defects from missing contract 142 checks. While
related work on failure-inducing test cases (Zhang et al., 2024; Zhong
et al., 2025) 143 is effective at causing general exceptions, this is
not the same as verifying adherence to the pre- 144 cise semantics of a
given contract. For instance, for a function that requires a list of
positive num- bers, a generic failure-inducing test might use None to
cause a TypeError, but this does not 145 verify the specific rule that
all numbers must be positive. In contrast, a contract-aware test like
146 \[10, 20, -5\] is designed to be caught precisely by an assertion
checking for positive values. 147 This distinction highlights the need
for systematic methods that can precisely target formal contract 148
specifications rather than just triggering arbitrary errors. 149 150 151
2.3 SMT S OLVER 152 153 SMT (Satisfiability Modulo Theories) solvers are
powerful engines for determining the satisfiabil- 154 ity of complex
logical formulas across various theories, such as arithmetic and strings
(Barrett & 155 Tinelli, 2018). They typically interface using SMT-LIB, a
standardized formal language, with Z3 156 being a widely adopted
implementation in automated testing (de Moura & Bjørner, 2008). Tradi-
157 tionally, techniques like symbolic execution have employed SMT
solvers to find inputs that satisfy 158 path constraints, focusing on
functional coverage over well-formed inputs. In this paradigm, con- 159
straints are used as admission checks to filter out invalid data rather
than as explicit targets for 160 evaluation. In contrast, our framework
leverages SMT solvers to systematically generate ill-formed 161 inputs
that precisely violate formalized contracts, allowing us to rigorously
test for robustness. A detailed example of how we formulate contracts is
provided in Appendix D.

                                                        3

Under review as a conference paper at ICLR 2026

162 3 T HE N EED FOR C ONTRACT-AWARE E VALUATION 163 164 3.1 W HY C
ONTRACTS M ATTER : B LIND S POTS IN C URRENT B ENCHMARKS 165 166 Recent
studies on code and test case generation (Korraprolu et al., 2025; Sung
et al., 2025; Li 167 et al., 2022) have dominantly relied on pass@k to
evaluate functional correctness. While effective, 168 these metrics,
along with approaches that target failure-inducing inputs (Peng et al.,
2018), share a 169 common limitation: they primarily operate within the
bounds of a program's legal input space Dyck 170 et al. (2023). This
practice has led to a critical blind spot in popular benchmarks such as
HumanEval+ 171 and MBPP+. By design, these benchmarks explicitly filter
out and discard any test case that violates 172 a program's
pre-conditions (Austin et al., 2021). Consequently, the evaluation
process certifies that 173 a program behaves correctly on well-formed
inputs, but it fails entirely to assess the program's 174 robustness
against ill-formed ones. This results in an incomplete and often
inflated assessment of 175 code quality, praising solutions that may be
superficially correct but are fundamentally fragile. 176 This is where
the software contracts become essential. As explained in Section 1,
contracts are 177 the rules that define the boundary of valid behavior.
They are not optional safeguards but a core 178 component of trustworthy
software that specifies how a program must identify and reject invalid
179 data. By ignoring contract adherence, existing benchmarks overlook a
crucial dimension of software 180 reliability. 181 182 3.2 C
ONTRACT-BASED T EST PARADIGM 183 184 Merely enlarging a single pool of
valid inputs cannot reveal whether a model understands the bound- 185
ary of the specification it needs to satisfy. The main focus, therefore,
lies in constructing contract- 186 violating test cases, which
systematically explore the extent to which models enforce contract
rules. 187 A contract-violating test case is an input that violates one
or more predicates from a set of contracts while satisfying the
remaining specification. The reference implementation is augmented with
run- 188 time assertions for every predicate in the contract set, and a
candidate program passes such a test 189 only when it raises an error
consistent with this augmented reference. Introducing contract-violating
190 inputs uncovers false negatives that purely functional tests
overlook and provides a rigorous measure 191 of whether a program
properly enforces contractual rules. 192 193 3.3 TASK S ETUP 194 195
Each benchmark task consists of a natural language description, a set of
contracts, and a functional 196 implementation. We use HumanEval+ and
MBPP+, where contract predicates are stroed as assertion 197 literals
outside the prompt and reference code. Our task concerns
contract-violating test generation 198 and contract-aware code
generation. For test generation, we automatically construct a compact
set 199 of contract-violating test cases that target specific contract
rules and remain feasible with respect 200 to the remaining rules for
each benchmark task. These tests are used for evaluating whether LLM-
201 generated code appropriately follows contracts. For contract-aware
code generation, we generate 202 code under two prompt conditions, where
the first condition is a contract specification (CS) prompt, 203 which
includes the functional description and a natural language paraphrase of
the contracts. The 204 second condition is an example-augmented
specification (EAS) prompt, which is augmented with the
contract-violating test cases. 205 206 207 4 M ETHODOLOGY 208 209 We
propose PACT, a program assessment and contract-adherence evaluation
framework designed to 210 systematically evaluate and enhance the
ability of LLMs to generate contract-compliant code. This 211 framework
consists of two main stages. First, we generate contract-violating test
cases to rigorously 212 assess whether LLM-generated code snippets
enforces both functional specifications and explicit 213 contracts.
Second is the systematic analysis of code generation, where we use these
test cases under 214 different prompting conditions to evaluate a
model's contract awareness in detail. Unlike prior ap- 215 proaches that
rely solely on functionality-based evaluation, PACT extends the
evaluation paradigm with contract-violation tests, enabling a more
precise and reliable analysis of contract adherence.

                                                        4

Under review as a conference paper at ICLR 2026

216 217 218 219 220 221 222 223 224 225 226 227 228 Figure 2: Running
example of PACT for code generation. 229 230 231 4.1 C ONTRACT-V
IOLATING T EST-C ASE G ENERATION 232 233 Direct LLM-based generation is
inadequate for contract-aware test case construction. It must con- 234
sider all subsets of the contract set when producing violating inputs.
If a task has n contracts, the number of non empty violation
combinations is 2n − 1. Direct prompting often misses required 235
combinations and yields contradictory inputs that violate unintended
contracts and fails to ensure 236 feasibility under the specification.
LLMs also lack a built in mechanism to verify that exactly the 237
targeted contracts are violated while all others hold. We design an
SMT-based approach to make 238 these checks accurate and efficient. Our
generation procedure is a two-step pipeline for contract- 239 aware test
case generation. First, an inference model translates natural language
contracts into an 240 Algebraic Data Type (ADT) program. This ADT format
is the critical component: it provides a 241 rigid, formal schema for
the complex and often nested constraints found in contracts. This
ensures 242 that the subsequently generated rules for an SMT solver are
syntactically valid and semantically 243 precise. Second, given the ADT,
the SMT solver constructs contract violation test cases (CVTs) by 244
breaking one or more specified contracts while ensuring that all
remaining contracts are satisfied. 245 The solver validates
satisfiability for each candidate combination and extracts concrete
models--- specific assignments of values that satisfy the constraints---
to instantiate inputs for every valid case. 246 We provide a running
example of this procedure in Appendix D. 247 248 249 4.2 C ONTRACT M
ETRICS FOR T EST C ASE 250 Unlike standard test cases for functional
correctness, test cases for contracts should be the nega- 251 tive
samples, violating the contracts and triggering the corresponding
assertions. As the concept of 252 contract-violating test cases is
different from the standard, we design metrics to analyze whether the
253 generated test cases appropriately correspond to input contracts.
254 255 Let A = {a1 , . . . , an } be the set of all contract assertions
and T = {t1 , . . . , tm } be the generated 256 test cases. Ft ⊆ A is
the set of violated assertions when executing a test case t ∈ T .
Finally, Tneg ⊆ T represents the set of test cases that successfully
violated at least one contract. 257 258 259 Assert Violation Coverage
(AVC) AVC quantifies the coverage of assert statements that are suc- 260
cessfully violated by all the test cases. 261 \|{ai \| ∃t ∈ Tneg : ai ∈
Ft }\| 262 AV C = . n 263 264 The value of 1.0 for AVC ensures that all
contract assertions are captured by the test cases. Lower 265 values
expose the unexplored regions of the contracts from the test cases. 266
267 Target Specificity (TS) TS evaluates the precision of each test case
by measuring how accurately 268 it violates its intended set of target
contracts. To formalize this, we first define V ⊆ A as the set 269 of
contracts that a given test case t ∈ Tneg is intended to violate. We
then measure the alignment between this intended set Vt and the actually
violated set Ft using the Jaccard Index. The final TS

                                                           5

Under review as a conference paper at ICLR 2026

270 score is the average of these individual precision scores across all
negative test cases: 271 272 1 X \|Ft ∩ Vt \| TS = . 273 \|Tneg \| \|Ft
∪ Vt \| t∈Tneg 274 275 A score of 1.0 indicates perfect precision, where
every test case violates exactly the set of contracts it 276 was
designed to. Lower scores reveal a discrepancy, indicating that test
cases either failed to trigger 277 their intended violations or caused
unintended, collateral violations. 278 279 4.3 C ONTRACT-AWARE C ODE G
ENERATION 280 281 This section details our methodology for
systematically evaluating and enhancing the ability of 282 LLMs to
generate code snippets that robustly enforces contracts. To achieve a
fine-grained un- 283 derstanding of a model's contract awareness, we
investigate its performance under two distinct 284 prompting strategies.
Frist, we establish a baseline condition, Contract Specification (CS).
For 285 this strategy, we use a powerful Commercial LLM to naturally
integrate the contract rules from the HumanEval+ and MBPP+ datasets into
the main text of the prompt. This creates a comprehen- 286 sive prompt
that describes both the functional goal and its contractual constraints
in natural lan- 287 guage. Second, we introduce an enhanced condition,
which we term Example-Augmented Speci- 288 fication (EAS). This strategy
builds upon the CS prompt by augmenting it with a single, precisely 289
targeted contract- violating test cases for each described contract.
This provides a concrete example 290 of what constitutes a violation,
intended to guide the model toward more robust code generation. 291 To
measure the impact of these prompting strategies, we assess the
generated code snippets using a 292 comprehensive suite of metrics for
both functional correctness and contract adherence. Functional 293
correctness is measured using the standard pass@k metric over a set of
valid test cases. Contract 294 adherence is evaluated from two
perspectives: runtime enforcement using test cases and static align- 295
ment of the generated code snippets with the ground-truth contracts, as
detailed in Section 4.4. 296 297 4.4 C ONTRACT M ETRIC FOR C ODE G
ENERATION 298 299 For the evaluation of the generated code snippets, we
employ pass@k to measure functional correct- 300 ness on valid inputs
and use AVC to measure the correctness of the generated contract
assertions. 301 We also design two additional metrics to more precisely
evaluate contract-aware code generation. 302 303 Let A = {a1 , . . . ,
an } be the set of ground-truth contract assertions, and let Â = {â1 , .
. . , âm } 304 be the set of assertions extracted from the LLM-generated
code. Let M ⊆ A × Â be the set of 305 pairs (ai , âj ) where the
ground-truth contract ai and the generated assertion âj are determined
to be semantically equivalent. 306 307 308 Assertion Alignment Recall
(AAR) AAR measures the model's ability to implement all required
contracts without omission. It is the proportion of ground-truth
contracts that are successfully cov- 309 ered by at least one assertion
in the generated code, functioning as a recall metric. 310 311 \|{ai ∈ A
\| ∃âj ∈ Â : (ai , âj ) ∈ M }\| 312 AAR = . n 313 314 A high AAR score
indicates that an output code ensures that all required contract
specifications are 315 generated. 316 317 Assertion Alignment Precision
(AAP) AAP measures the accuracy of the generated assertions, 318
penalizing irrelevant or hallucinated ones. It is the proportion of
generated assertions that correspond 319 to a valid ground-truth
contract, functioning as a precision metric. 320 \|{âj ∈ Â \| ∃ai ∈ A :
(ai , âj ) ∈ M }\| 321 AAP = . m 322 323 A high AAP score indicates that
the code does not contain assertions of unnecessary or incorrect checks.

                                                           6

Under review as a conference paper at ICLR 2026

324 5 E XPERIMENTAL SETTINGS 325 326 5.1 DATASETS 327 328 Our study
utilizes H UMAN E VAL + and MBPP+ benchmarks (Liu et al., 2023), which
are enriched 329 with assertion-level contracts. However, these
benchmarks have a critical limitation for evaluat- 330 ing code
robustness: the contract specifications are neither included in the
model prompts, nor are 331 contract-violating inputs included in the
official test suites. This evaluation setup exclusively tests 332 for
functional correctness on well-formed inputs, leading to an inflated
perception of code qual- 333 ity. We construct a supplementary dataset
containing contract-violating test cases, as described in 334 Section
4.1. 335 336 5.2 C ANDIDATE M ODELS 337 338 We utilize o4-mini as our
primary test case generator. For our code generation experiments, we 339
evaluate a set of open-source models including gemma-3-12B-it (gemma-3),
Deepseek-R1-Distill- 340 Qwen-14B (DeepSeek-R1), Qwen3-14B (Qwen-3), and
Phi-4-reasoning-plus (Phi-4-plus). 341 342 6 E MPIRICAL S TUDIES 343 344
Our empirical study is structured over three research questions (RQs)
designed to evaluate the PACT 345 framework from multiple perspectives.
The evaluation is conducted on HumanEval+ and MBPP+. 346 We begin by
assessing the quality and precision of the CVTs generated by PACT (RQ1).
Next, 347 we investigate whether providing these concrete test cases is
more effective for eliciting contract- 348 awareness than using abstract
natural language descriptions alone (RQ2). Finally, we analyze the 349
resulting trade-off between the enforced contract adherence and the
functional correctness of the 350 generated code snippets (RQ3). 351 352
Table 1: Evaluation results of the test case generation on HumanEval+
and MBPP+. 353 354 Benchmark Method AVC (↑) TS (↑) AVG (↑) 355 o4-mini
97.14% 75.60% 86.37% 356 HumanEval+ o4-mini + SMT Solver 95.53% 85.81%
90.67% 357 o4-mini 94.67% 69.11% 81.89% MBPP+ 358 o4-mini + SMT Solver
93.50% 84.54% 89.02% 359 360 361 6.1 RQ1: H OW E FFECTIVE IS PACT IN G
ENERATING H IGH -Q UALITY C ONTRACT- 362 V IOLATING T EST C ASES ? 363
364 Our first research question investigates the effectiveness of our
proposed framework, PACT, in gen- 365 erating high-quality CVTs. A naive
baseline approach, which we refer to as o4-mini in Table 1, 366 uses an
LLM o4-mini for direct test case generation from given contracts. This
method is of- 367 ten inadequate, as it disregards dependencies among
contracts and produces logically inconsistent 368 violations, making it
difficult to precisely verify individual contract predicates. 369 In
contrast, PACT (o4-mini+ SMT Solver) employs a more robust two-stage
approach. First an 370 LLM converts contracts into rules for an SMT
solver. Subsequently, an SMT solver uses these rules 371 to generate
test cases. This process guarantees the generation of logically sound
test cases that are 372 precisely targeted to violate a specific subset
of contracts while adhering to the rest. 373 The empirical results in
Table 1 validate the superiority of PACT. While both methods achieve 374
high AVC scores, PACT significantly outperforms the direct generation in
TS, achieving over 10%p 375 increases on both HumanEval+ and MBPP+. This
demonstrates that our two-stage approach suc- 376 cessfully give test
cases precisely for intended contracts. The baseline's slightly higher
AVC is an 377 expected outcome, as direct generation often triggers a
wide range of assertion errors indiscrimi- nately, artificially
inflating coverage. PACT, on the other hand, focuses on valid, targeted
violations.

                                                         7

Under review as a conference paper at ICLR 2026

378 While PACT generates valid rules, providing a precise test for the
input contracts, there are still 379 errors. A case-specific analysis of
minor errors that occur even with well-formed rules is detailed in 380
Appendix A. 381 382 Table 2: Evaluation results of contract adherence in
code generation on HumanEval+. 383 384 Model Mode pass@1 (↑) AVC (↑) AAR
(↑) AAP (↑) AVG (↑) 385 CS 84.41% 24.85% 11.41% 14.04% 32.79% gemma-3
386 EAS 82.94% 91.02% 28.07% 27.77% 57.45% 387 CS 73.78% 44.12% 15.65%
16.97% 37.63% DeepSeek 388 EAS 71.77% 79.29% 27.62% 28.01% 51.67% 389 CS
78.92% 28.04% 13.17% 22.55% 35.67% Qwen3 390 EAS 77.83% 87.81% 31.53%
36.09% 58.31% 391 CS 72.23% 52.91% 18.78% 21.09% 41.25% Phi-4-plus 392
EAS 67.08% 69.50% 21.33% 20.06% 44.49% 393 394 Table 3: Evaluation
results of contract adherence in code generation on MBPP+. 395 396 Model
Mode pass@1 (↑) AVC (↑) AAR (↑) AAP (↑) AVG (↑) 397 CS 78.56% 57.99%
17.50% 17.93% 41.49% gemma-3 398 EAS 78.60% 95.57% 32.29% 31.82% 59.57%
399 CS 62.53% 64.20% 17.59% 17.57% 40.47% DeepSeek 400 EAS 60.15% 86.70%
28.23% 27.94% 45.47% 401 CS 72.41% 70.86% 21.09% 22.99% 46.84% Qwen3 402
EAS 72.63% 94.85% 31.54% 32.30% 57.83% CS 64.89% 67.33% 24.26% 24.65%
45.28% 403 Phi-4-plus EAS 63.76% 74.88% 29.20% 28.95% 49.20% 404 405 406
6.2 RQ2: A RE C ONCRETE T EST C ASES M ORE E FFECTIVE THAN A BSTRACT D
ESCRIPTIONS 407 FOR E LICITING C ONTRACT-AWARENESS ? 408 409 We compared
two prompting methods across various models in Tables 2 and 3. CS, our
baseline, 410 provides only an abstract natural language description of
the contracts. In contrast, EAS augments the CVTs, generated from
Section 4.1, to the CS prompt. 411 412 The results demonstrate that for
all of our base models, EAS is a more powerful method for eliciting 413
contract-aware code generation. EAS achieves 33.7%p, 11.3%p, and 9.4%p
improvements for AVC, 414 AAR, and AAP, respectively, over CS. For
models such as Qwen3, DeepSeek-R1, and Phi-4-plus, 415 switching from CS
to EAS leads to a dramatic improvement across all contract adherence
metrics. 416 This indicates that concrete examples of CVTs provide a
clear and unambiguous signal that forces the model to move beyond purely
functional logic. The increase in AAR and AAP indicates that the 417
models are correctly generating test cases required for assertion
checks, while the relatively huge 418 improvements in AVC show that the
resulting codes are more robust against a wider range of invalid 419
inputs. 420 421 Concrete examples of contract violations provide a
clear, unambiguous signal that forces the model 422 to move beyond
purely functional logic and implement the explicit enforcement of
contracts---the predefined agreements on how ill-formed inputs must be
rejected. For concrete examples of the code 423 snippets and their
corresponding LLM-generated test cases, please refer to Appendix B.
However, 424 this heightened focus on contract enforcement introduces a
notable trade-off, as the model may 425 generate more complex code that
impacts its performance on purely functional correctness metrics. 426
This trade-off is analyzed in further detail in the following section
RQ3. 427 428 6.3 RQ3: H OW D OES E NFORCING C ONTRACT A DHERENCE I MPACT
THE F UNCTIONAL 429 C ORRECTNESS OF G ENERATED C ODE ? 430 431 While the
RQ2 established that augmenting prompts with CVTs significantly enhances
a model's contract adherence, this section investigates the resulting
trade-off with respect to its functional

                                                        8

Under review as a conference paper at ICLR 2026

432 correctness. Our analysis reveals that a heightened focus on
contract enforcement often comes at 433 the cost of a measurable decline
in performance on standard functional correctness benchmarks. 434 This
trade-off can be attributed to a shift in the model's optimization
focus. When provided with 435 only a functional description, the LLM's
sole objective is to produce code snippets that passes 436
functionality-focused tests. However, when the prompt is augmented with
CVTs, the model must 437 simultaneously satisfy two competing
objectives: generating functionally correct logic and enforc- 438 ing
the specified contractual preconditions. This dual objective increases
the complexity of the code 439 generation task. The model is compelled
to allocate part of its reasoning capacity to interpreting and 440
implementing the contract rules, which can lead to subtle errors or
oversights in the core functional 441 logic. A concrete example of this
is presented in Appendix C. Consequently, while the resulting code
snippets is more robust and secure against invalid inputs, it may
exhibit a lower pass@1 rate 442 on test suites composed entirely of
valid, well-formed inputs. 443 444 In conclusion, our findings reveal an
inherent tension between contract adherence and functional 445
correctness in LLM-based code generation. The pursuit of robustness
through contract enforcement 446 comes at a tangible cost to
functionality. This trade-off highlights the critical need for advanced
447 training paradigms---such as the reinforcement learning with
multi-objective rewards proposed by PACT---capable of optimizing for
both objectives simultaneously. 448 449 450 7 C ONCLUSION 451 452 We
introduce PACT, the first framework to redefine code and test case
correctness by evaluat- 453 ing adherence to task specifications through
both functionality and contract-based behavior. While 454 prior
benchmarks assess only pass@k on well-formed inputs, PACT introduces a
comprehensive 455 paradigm with dual test suites---one for functionality
and one for contract violations---along with 456 specific metrics to
analyze contract awareness and uncover latent defects, enabling a more
prin- 457 cipled evaluation of code robustness. Our empirical evaluation
demonstrates the effectiveness of 458 PACT across multiple dimensions.
We first show that PACT's SMT-solver-based test case genera- 459 tion
method ensures more accurate CVTs than direct generation with over 10%p
better performance. Furthermore, our results reveal that augmenting
prompts with these CVTs is a highly effective strat- 460 egy for
generating robust and contract-aware code, achieving 18.13%p increase in
contract-specific 461 metrics and 12.8%p in total average. Our empirical
studies on various LLMs demonstrate the ef- 462 fectiveness of PACT,
achieving approximately , but also uncovers a critical trade-off between
this 463 enhanced contract adherence and a model's performance on
functional correctness. These findings 464 confirm that PACT provides a
more complete and realistic assessment of an LLM's contract-aware 465
code generation capabilities, moving beyond the limitations of existing
benchmarks. 466 467 468 8 F UTURE WORK DIRECTIONS 469 470 While this
work focuses on evaluating contract adherence, a natural next step is to
actively improve 471 it through advanced training methodologies. A
promising direction is to leverage the novel met- rics introduced in our
PACT framework as direct training signals. The novel metrics introduced
in 472 our PACT framework, such as the runtime metric Assert Violation
Coverage (AVC) and the static 473 metrics Assertion Alignment Recall
(AAR) and Precision (AAP), are particularly well-suited for 474 this
purpose and could be integrated into a multi-objective reward function
for RL. This approach 475 could enable models to learn to navigate the
trade-off between functional correctness and contract 476 adherence more
effectively, optimizing for both objectives simultaneously. 477 478 479
R EFERENCES 480 Jacob Austin, Augustus Odena, Maxwell I. Nye, Maarten
Bosma, Henryk Michalewski, David Do- 481 han, Ellen Jiang, Carrie J.
Cai, Michael Terry, Quoc V. Le, and Charles Sutton. Program synthesis
482 with large language models. CoRR, abs/2108.07732, 2021. 483 484
Clark W. Barrett and Cesare Tinelli. Satisfiability modulo theories. In
Edmund M. Clarke, 485 Thomas A. Henzinger, Helmut Veith, and Roderick
Bloem (eds.), Handbook of Model Check- ing, pp. 305--343. Springer,
2018.

                                                        9

Under review as a conference paper at ICLR 2026

486 Pavol Bielik, Veselin Raychev, and Martin T. Vechev. PHOG:
probabilistic model for code. In 487 Maria-Florina Balcan and Kilian Q.
Weinberger (eds.), Proceedings of the 33nd International 488 Conference
on Machine Learning, ICML 2016, New York City, NY, USA, June 19-24,
2016, vol- 489 ume 48 of JMLR Workshop and Conference Proceedings,
pp. 2933--2942. JMLR.org, 2016. URL 490
http://proceedings.mlr.press/v48/bielik16.html. 491 492 Jacob Burnim and
Koushik Sen. Heuristics for scalable dynamic test generation. In 23rd
IEEE/ACM International Conference on Automated Software Engineering (ASE
2008), 15-19 September 493 2008, L'Aquila, Italy, pp. 443--446. IEEE
Computer Society, 2008. 494 495 Cristian Cadar, Daniel Dunbar, and
Dawson R. Engler. KLEE: unassisted and automatic generation 496 of
high-coverage tests for complex systems programs. In Richard Draves and
Robbert van Re- 497 nesse (eds.), 8th USENIX Symposium on Operating
Systems Design and Implementation, OSDI 498 2008, December 8-10, 2008,
San Diego, California, USA, Proceedings, pp. 209--224. USENIX 499
Association, 2008. 500 Román Jaramillo Cajica, Raul Ernesto
Gonzalez-Torres, and Pedro Mejı́a-Alvarez. Automatic gen- 501 eration of
test cases from formal specifications using mutation testing. In 18th
International 502 Conference on Electrical Engineering, Computing
Science and Automatic Control, CCE 2021, 503 Mexico City, Mexico,
November 10-12, 2021, pp. 1--6. IEEE, 2021. 504 Sang Kil Cha, Maverick
Woo, and David Brumley. Program-adaptive mutational fuzzing. In 2015 505
IEEE Symposium on Security and Privacy, SP, pp. 725--741, 2015. 506 507
Sooyoung Cha, Seongjoon Hong, Jiseong Bak, Jingyoung Kim, Junhee Lee,
and Hakjoo Oh. En- 508 hancing dynamic symbolic execution by
automatically learning search heuristics. IEEE Trans. 509 Software Eng.,
48(9):3640--3663, 2022. 510 Mark Chen, Jerry Tworek, Heewoo Jun, Qiming
Yuan, Henrique Pondé de Oliveira Pinto, Jared 511 Kaplan, Harri Edwards,
Yuri Burda, Nicholas Joseph, Greg Brockman, Alex Ray, Raul Puri, 512
Gretchen Krueger, Michael Petrov, Heidy Khlaaf, Girish Sastry, Pamela
Mishkin, Brooke Chan, 513 Scott Gray, Nick Ryder, Mikhail Pavlov,
Alethea Power, Lukasz Kaiser, Mohammad Bavarian, 514 Clemens Winter,
Philippe Tillet, Felipe Petroski Such, Dave Cummings, Matthias Plappert,
Fo- 515 tios Chantzis, Elizabeth Barnes, Ariel Herbert-Voss, William
Hebgen Guss, Alex Nichol, Alex 516 Paino, Nikolas Tezak, Jie Tang, Igor
Babuschkin, Suchir Balaji, Shantanu Jain, William Saunders, 517
Christopher Hesse, Andrew N. Carr, Jan Leike, Joshua Achiam, Vedant
Misra, Evan Morikawa, 518 Alec Radford, Matthew Knight, Miles Brundage,
Mira Murati, Katie Mayer, Peter Welinder, Bob 519 McGrew, Dario Amodei,
Sam McCandlish, Ilya Sutskever, and Wojciech Zaremba. Evaluating large
language models trained on code. Preprint, arXiv:2107.03374, 2021a. 520
521 Mark Chen, Jerry Tworek, Heewoo Jun, Qiming Yuan, Henrique Ponde de
Oliveira Pinto, Jared 522 Kaplan, Harri Edwards, Yuri Burda, Nicholas
Joseph, Greg Brockman, Alex Ray, Raul Puri, 523 Gretchen Krueger,
Michael Petrov, Heidy Khlaaf, Girish Sastry, Pamela Mishkin, Brooke
Chan, 524 Scott Gray, Nick Ryder, Mikhail Pavlov, Alethea Power, Lukasz
Kaiser, Mohammad Bavarian, 525 Clemens Winter, Philippe Tillet, Felipe
Petroski Such, Dave Cummings, Matthias Plappert, Fo- 526 tios Chantzis,
Elizabeth Barnes, Ariel Herbert-Voss, William Hebgen Guss, Alex Nichol,
Alex Paino, Nikolas Tezak, Jie Tang, Igor Babuschkin, Suchir Balaji,
Shantanu Jain, William Saunders, 527 Christopher Hesse, Andrew N. Carr,
Jan Leike, Josh Achiam, Vedant Misra, Evan Morikawa, Alec 528 Radford,
Matthew Knight, Miles Brundage, Mira Murati, Katie Mayer, Peter
Welinder, Bob Mc- 529 Grew, Dario Amodei, Sam McCandlish, Ilya
Sutskever, and Wojciech Zaremba. Evaluating large 530 language models
trained on code, 2021b. URL https://arxiv.org/abs/2107.03374. 531 532
Jaeseung Choi, Joonun Jang, Choongwoo Han, and Sang Kil Cha. Grey-box
concolic testing on 533 binary code. In Joanne M. Atlee, Tevfik Bultan,
and Jon Whittle (eds.), Proceedings of the 41st 534 International
Conference on Software Engineering, ICSE 2019, Montreal, QC, Canada, May
25- 31, 2019, pp. 736--747. IEEE / ACM, 2019. 535 536 Koen Claessen and
John Hughes. Quickcheck: a lightweight tool for random testing of
haskell 537 programs. In Martin Odersky and Philip Wadler (eds.),
Proceedings of the Fifth ACM SIGPLAN 538 International Conference on
Functional Programming (ICFP '00), Montreal, Canada, September 539
18-21, 2000, pp. 268--279. ACM, 2000. doi: 10.1145/351240.351266. URL
https://doi. org/10.1145/351240.351266.

                                                     10

Under review as a conference paper at ICLR 2026

540 Arghavan Moradi Dakhel, Amin Nikanjam, Vahid Majdinasab, Foutse
Khomh, and Michel C. Des- 541 marais. Effective test generation using
pre-trained large language models and mutation testing. 542 Information
& Software Technology, 171:107468, 2024. 543 544 Leonardo Mendonça de
Moura and Nikolaj S. Bjørner. Z3: an efficient SMT solver. In C. R. 545
Ramakrishnan and Jakob Rehof (eds.), Tools and Algorithms for the
Construction and Analysis 546 of Systems, 14th International Conference,
TACAS 2008, Held as Part of the Joint European 547 Conferences on Theory
and Practice of Software, ETAPS 2008, Budapest, Hungary, March 29- 548
April 6, 2008. Proceedings, volume 4963 of Lecture Notes in Computer
Science, pp. 337--340. Springer, 2008. doi:
10.1007/978-3-540-78800-3 24. URL https://doi.org/10.1007/ 549
978-3-540-78800-3_24. 550 551 Florian Dyck, Cedric Richter, and Heike
Wehrheim. Robustness testing of software verifiers. In 552 Carla
Ferreira and Tim A. C. Willemse (eds.), Software Engineering and Formal
Methods - 21st 553 International Conference, SEFM 2023, Eindhoven, The
Netherlands, November 6-10, 2023, Pro- 554 ceedings, volume 14323 of
Lecture Notes in Computer Science, pp. 66--84. Springer, 2023. 555 556
Zhangyin Feng, Daya Guo, Duyu Tang, Nan Duan, Xiaocheng Feng, Ming Gong,
Linjun Shou, Bing 557 Qin, Ting Liu, Daxin Jiang, and Ming Zhou.
Codebert: A pre-trained model for programming and 558 natural languages,
2020. 559 Federico Formica, Tony Fan, and Claudio Menghi. Search-based
software testing driven by auto- 560 matically generated and manually
defined fitness functions. ACM Trans. Softw. Eng. Methodol., 561
33(2):40:1--40:37, 2024. 562 563 Jonas Gehring, Kunhao Zheng, Jade
Copet, Vegard Mella, Quentin Carbonneaux, Taco Cohen, and 564 Gabriel
Synnaeve. Rlef: Grounding code llms in execution feedback with
reinforcement learning, 565 2025. 566 567 Patrice Godefroid, Nils
Klarlund, and Koushik Sen. DART: directed automated random testing. In
Vivek Sarkar and Mary W. Hall (eds.), Proceedings of the ACM SIGPLAN
2005 Conference on 568 Programming Language Design and Implementation,
Chicago, IL, USA, June 12-15, 2005, pp. 569 213--223. ACM, 2005. 570 571
Patrice Godefroid, Adam Kiezun, and Michael Y. Levin. Grammar-based
whitebox fuzzing. In Rajiv 572 Gupta and Saman P. Amarasinghe (eds.),
Proceedings of the ACM SIGPLAN 2008 Conference on 573 Programming
Language Design and Implementation, Tucson, AZ, USA, June 7-13, 2008,
pp. 574 206--215. ACM, 2008. 575 576 Mark Harman and Phil McMinn. A
theoretical and empirical study of search-based testing: Local, global,
and hybrid search. IEEE Transactions on Software Engineering,
36(2):226--247, 2010. 577 578 Jingxuan He, Gishor Sivanrupan, Petar
Tsankov, and Martin T. Vechev. Learning to explore paths 579 for
symbolic execution. In Yongdae Kim, Jong Kim, Giovanni Vigna, and Elaine
Shi (eds.), CCS 580 '21: 2021 ACM SIGSAC Conference on Computer and
Communications Security, Virtual Event, 581 Republic of Korea, November
15 - 19, 2021, pp. 2526--2540. ACM, 2021. 582 583 Kush Jain, Gabriel
Synnaeve, and Baptiste Rozière. Testgeneval: A real world unit test
genera- 584 tion and test completion benchmark. In The Thirteenth
International Conference on Learning 585 Representations, ICLR 2025,
Singapore, April 24-28, 2025. OpenReview.net, 2025. 586 Julia Jaremko,
Dagmar Gromann, and Michael Wiegand. Revisiting implicitly abusive
language 587 detection: Evaluating llms in zero-shot and few-shot
settings. In Owen Rambow, Leo Wanner, 588 Marianna Apidianaki, Hend
Al-Khalifa, Barbara Di Eugenio, and Steven Schockaert (eds.), Pro- 589
ceedings of the 31st International Conference on Computational
Linguistics, COLING 2025, Abu 590 Dhabi, UAE, January 19-24, 2025,
pp. 3879--3898. Association for Computational Linguistics, 591 2025. 592
593 James C. King. Symbolic execution and program testing.
Communications of the ACM, 19(7): 385--394, 1976.

                                                     11

Under review as a conference paper at ICLR 2026

594 Brahma Reddy Korraprolu, Pavitra Pinninti, and Y. Raghu Reddy. Test
case generation for re- 595 quirements in natural language - an LLM
comparison study. In Jitendra Chhabra, Lov Kumar, 596 Sridhar
Chimalakonda, Paddy Krishan, and Sangharatna Godboley (eds.),
Proceedings of the 597 18th Innovations in Software Engineering
Conference, ISEC 2025, Kurukshetra, India, Febru- 598 ary 20-22, 2025,
pp. 9:1--9:5. ACM, 2025. doi: 10.1145/3717383.3717389. URL https: 599
//doi.org/10.1145/3717383.3717389. 600 Caroline Lemieux, Jeevana Priya
Inala, Shuvendu K. Lahiri, and Siddhartha Sen. Codamosa: Es- 601 caping
coverage plateaus in test generation with pre-trained large language
models. In 45th 602 IEEE/ACM International Conference on Software
Engineering, ICSE 2023, Melbourne, Aus- 603 tralia, May 14-20, 2023,
pp. 919--931. IEEE, 2023. doi: 10.1109/ICSE48619.2023.00085. URL 604
https://doi.org/10.1109/ICSE48619.2023.00085. 605 606 Yujia Li, David H.
Choi, Junyoung Chung, Nate Kushman, Julian Schrittwieser, Rémi Leblond,
607 Tom Eccles, James Keeling, Felix Gimeno, Agustin Dal Lago, Thomas
Hubert, Peter Choy, Cy- prien de Masson d'Autume, Igor Babuschkin,
Xinyun Chen, Po-Sen Huang, Johannes Welbl, Sven 608 Gowal, Alexey
Cherepanov, James Molloy, Daniel J. Mankowitz, Esme Sutherland Robson,
Push- 609 meet Kohli, Nando de Freitas, Koray Kavukcuoglu, and Oriol
Vinyals. Competition-level code 610 generation with alphacode. CoRR,
abs/2203.07814, 2022. doi: 10.48550/ARXIV.2203.07814. 611 URL
https://doi.org/10.48550/arXiv.2203.07814. 612 613 Jiawei Liu, Chunqiu
Steven Xia, Yuyao Wang, and Lingming Zhang. Is your code generated by
614 chatgpt really correct? rigorous evaluation of large language models
for code generation. In Ad- vances in Neural Information Processing
Systems 36: Annual Conference on Neural Information 615 Processing
Systems 2023, NeurIPS, 2023. 616 617 Bertrand Meyer. Applying "design by
contract". Computer, 25(10):40--51, 1992. 618 Long Ouyang, Jeff Wu, Xu
Jiang, Diogo Almeida, Carroll L. Wainwright, Pamela Mishkin, Chong 619
Zhang, Sandhini Agarwal, Katarina Slama, Alex Ray, John Schulman, Jacob
Hilton, Fraser Kel- 620 ton, Luke Miller, Maddie Simens, Amanda Askell,
Peter Welinder, Paul Christiano, Jan Leike, 621 and Ryan Lowe. Training
language models to follow instructions with human feedback, 2022. 622
URL https://arxiv.org/abs/2203.02155. 623 624 Jan Peleska, Elena
Vorobev, and Florian Lapschies. Automated test case generation with
smt-solving and abstract interpretation. In Mihaela Gheorghiu Bobaru,
Klaus Havelund, Gerard J. Holzmann, 625 and Rajeev Joshi (eds.), NASA
Formal Methods - Third International Symposium, NFM 2011, 626 Pasadena,
CA, USA, April 18-20, 2011. Proceedings, volume 6617 of Lecture Notes in
Computer 627 Science, pp. 298--312. Springer, 2011. 628 629 Hui Peng,
Yan Shoshitaishvili, and Mathias Payer. T-fuzz: Fuzzing by program
transformation. In 630 2018 IEEE Symposium on Security and Privacy, SP
2018, Proceedings, 21-23 May 2018, San 631 Francisco, California, USA,
pp. 697--710. IEEE Computer Society, 2018. 632 Ruixiang Qian, Quanjun
Zhang, Chunrong Fang, and Lihua Guo. Investigating coverage guided 633
fuzzing with mutation testing. In Internetware 2022: 13th Asia-Pacific
Symposium on Internet- 634 ware, Hohhot, China, June 11 - 12, 2022,
pp. 272--281. ACM, 2022. 635 Gabriel Ryan, Siddhartha Jain, Mingyue
Shang, Shiqi Wang, Xiaofei Ma, Murali Krishna Ra- 636 manathan, and
Baishakhi Ray. Code-aware prompting: A study of coverage-guided test
gen- 637 eration in regression setting using LLM. Proceedings of the ACM
on Software Engineering, 1 638 (FSE):951--971, 2024. 639 640 Arkadii
Sapozhnikov, Mitchell Olsthoorn, Annibale Panichella, Vladimir
Kovalenko, and Pouria 641 Derakhshanfar. Testspark: Intellij idea's
ultimate test generation companion. In Proceedings of 642 the 2024
IEEE/ACM 46th International Conference on Software Engineering:
Companion Pro- ceedings, ICSE Companion 2024, Lisbon, Portugal, April
14-20, 2024, pp. 30--34. ACM, 2024. 643 644 Dongdong She, Adam Storek,
Yuchong Xie, Seoyoung Kweon, Prashast Srivastava, and Suman 645 Jana.
FOX: coverage-guided fuzzing as online stochastic control. In Bo Luo,
Xiaojing Liao, Jun 646 Xu, Engin Kirda, and David Lie (eds.),
Proceedings of the 2024 on ACM SIGSAC Conference 647 on Computer and
Communications Security, CCS 2024, Salt Lake City, UT, USA, October
14-18, 2024, pp. 765--779. ACM, 2024.

                                                      12

Under review as a conference paper at ICLR 2026

648 Prashast Srivastava and Mathias Payer. Gramatron: effective
grammar-aware fuzzing. In Cristian 649 Cadar and Xiangyu Zhang (eds.),
ISSTA '21: 30th ACM SIGSOFT International Symposium on 650 Software
Testing and Analysis, Virtual Event, Denmark, July 11-17, 2021,
pp. 244--256. ACM, 651 2021. 652 653 Nick Stephens, John Grosen,
Christopher Salls, Andrew Dutcher, Ruoyu Wang, Jacopo Corbetta, 654 Yan
Shoshitaishvili, Christopher Kruegel, and Giovanni Vigna. Driller:
Augmenting fuzzing 655 through selective symbolic execution. In 23rd
Annual Network and Distributed System Secu- rity Symposium, NDSS 2016,
San Diego, California, USA, February 21-24, 2016. The Internet 656
Society, 2016. 657 658 Sicheol Sung, Aditi, Dogyu kim, Yo-Sub Han, and
Sang-Ki Ko. Logicase: Effective test case genera- 659 tion from logical
description in competitive programming. CoRR, abs/2505.15039, 2025. doi:
10. 660 48550/ARXIV.2505.15039. URL
https://doi.org/10.48550/arXiv.2505.15039. 661 Wenhan Wang, Chenyuan
Yang, Zhijie Wang, Yuheng Huang, Zhaoyang Chu, Da Song, Lingming 662
Zhang, An Ran Chen, and Lei Ma. TESTEVAL: benchmarking large language
models for test 663 case generation. In Luis Chiruzzo, Alan Ritter, and
Lu Wang (eds.), Findings of the Association 664 for Computational
Linguistics: NAACL 2025, Albuquerque, New Mexico, USA, April 29 - May 4,
665 2025, pp. 3547--3562. Association for Computational Linguistics,
2025. 666 667 Zejun Wang, Kaibo Liu, Ge Li, and Zhi Jin. HITS:
high-coverage llm-based unit test generation via 668 method slicing. In
Proceedings of the 39th IEEE/ACM International Conference on Automated
669 Software Engineering, ASE, pp. 1258--1268, 2024. 670 Jaehan Yoon and
Sooyoung Cha. Featmaker: Automated feature engineering for search
strategy of 671 symbolic execution. Proc. ACM Softw. Eng.,
1(FSE):2447--2468, 2024. doi: 10.1145/3660815. 672 URL
https://doi.org/10.1145/3660815. 673 674 Jiyang Zhang, Yu Liu, Pengyu
Nie, Junyi Jessy Li, and Milos Gligoric. exlong: Generating excep- 675
tional behavior tests with large language models, 2024. 676 Linghan
Zhong, Samuel Yuan, Jiyang Zhang, Yu Liu, Pengyu Nie, Junyi Jessy Li,
and Milos Glig- 677 oric. A tool for generating exceptional behavior
tests with large language models. In Proceed- 678 ings of the 33rd ACM
International Conference on the Foundations of Software Engineering, 679
FSE Companion '25, pp. 1193--1197. ACM, June 2025. doi:
10.1145/3696630.3728608. URL 680
http://dx.doi.org/10.1145/3696630.3728608. 681 682 683 A C ASE S TUDY: L
OGICAL C ONTRADICTIONS IN D IRECT LLM T EST C ASE 684 G ENERATION 685
686 HumanEval In Figure 3 shown in the code snippet, this task includes
three sequential contracts: 687 assert 0 checks if the input is a list,
assert 1 verifies that all elements in the list are strings, 688 and
assert 2 ensures that all strings consist only of digits. A critical
dependency exists between 689 these contracts. Specifically, assert 2
can only be evaluated if assert 1 is satisfied, because the 690
isdigit() method is only valid for string types. A test case designed to
violate assert 1 while 691 satisfying assert 0 and assert 2 would
therefore be a logically contradictory combination, as a non-string
element would cause a TypeError before assert 2 could be checked.
Despite this, 692 a direct LLM generation approach often produces such
invalid combinations. For instance, when 693 tasked to generate test
cases, the LLM produces inputs such as \[123, "456"\], \["789", \[0\]\],
694 and \["456", false\]. These examples fail to isolate a specific
contract violation. This highlights 695 a fundamental weakness of the
approach, as the LLM tends to generate simplistic contract-violation 696
test cases that fail to respect the logical relationships among
contracts. 697 698 Mbpp In Figure 4 shown in the code snippet, this task
includes four main contracts, which can be 699 grouped by their
dependency. The initial contracts, assert 0 and assert 1, perform type
check- 700 ing to verify that both inputs are of a numeric type, such as
an integer or a floating-point number. 701 The subsequent contracts,
assert 2 and assert 3, check numeric properties, such as ensuring the
numbers are positive or fall within a specific range. A critical
dependency exists between these

                                                      13

Under review as a conference paper at ICLR 2026

702 groups of contracts. Specifically, the numeric property checks in
assert 2 and assert 3 can 703 only be evaluated if the type checks in
assert 0 and assert 1 are satisfied. For example, a 704 non-numeric type
like a string or null cannot be evaluated for properties like being
positive. 705 Therefore, creating a contract-violation test case that
violates the initial type contracts (assert 0 706 or assert 1) while
simultaneously satisfying the subsequent property contracts (assert 2
and 707 assert 3) is a logical impossibility. Despite this, a direct LLM
generation approach often pro- 708 duces such logically flawed
combinations. For instance, when tasked to generate test cases, the 709
LLM produces inputs such as \["abc", null\], \[null, "abc"\], \[\[1\],
{"x":1}\], and 710 \[{"r":1}, \[2\]\]. Crucially, while these examples
successfully violate the initial type contracts, 711 they all inherently
fail to satisfy assert 2 and assert 3, yet they are generated as if such
a combination were possible. This highlights a fundamental weakness of
the approach, as the LLM 712 tends to generate simplistic
contract-violation test cases that fail to respect the logical
relationships 713 among contracts. 714 715 HumanEval/113 716 717 def odd
count(lst): 718 assert type(lst) == list, "invalid inputs" \# \$
CONTRACT \$ 719 assert all(isinstance(s, str) for s in lst), "invalid
inputs" \# \$ 720 CONTRACT \$ 721 assert all(s.isdigit() for s in lst),
"invalid inputs" \# \$ 722 CONTRACT \$ 723 ans, template = \[\], "the
number of odd elements in the string i of 724 the input." 725 for s in
lst: 726 odd cnt = len(list(filter(lambda ch: int(ch) % 2 == 1, s))) 727
ans.append(template.replace("i", str(odd cnt))) return ans 728 729 """
730 Contract List: 731 assert 0: assert type(lst) == list, "invalid
inputs 732 assert 1: assert all(isinstance(s, str) for s in
lst),"invalid inputs assert 2: assert all(s.isdigit() for s in lst),
"invalid inputs 733""" 734 735 736 Figure 3: Code and contracts for
HumanEval. 737 738 739 740 B C ASE S TUDY: C ONTRACT E NFORCEMENT UNDER
D IFFERENT 741 P ROMPTING C ONDITIONS 742 743 We present a direct
comparison of code snippets that the DeepSeek model generated for the
744 MBPP/11 task under two prompting conditions. This comparison
illustrates why providing CVTCs 745 is more effective than relying on
natural language descriptions alone. 746 Figure 5 shows the code
snippets produced when the model received only the natural language 747
prompt. The prompt contains enough information to infer all necessary
contracts. It specifies two 748 explicit contracts, namely that the
first input must be a non empty string and that the second in- 749 put
must be a string of length one.It also implies two type contracts that
both inputs must be 750 strings. The generated code snippet correctly
implements the explicit length based contracts with 751 assert len(s) \>
0 and assert len(char) == 1. However, it omits the implicit type 752
checks and treats the word "string" as descriptive context rather than a
strict precondition. As a result, the function fails to enforce the
contracts under non string inputs. 753 754 In contrast, Figure 6
displays the output when the prompt was augmented with concrete CVTCs
such 755 as remove_Occ(2.0, 3.0). These test cases provide an
unambiguous and executable signal that non string inputs are invalid and
must be rejected. The model generates a more robust implemen-

                                                         14

Under review as a conference paper at ICLR 2026

756 MBPP/731 757 758 import math 759 def lateralsurface cone(r,h): 760
761 assert isinstance(r, (int, float)), "invalid inputs" \# \$ CONTRACT
\$ 762 assert isinstance(h, (int, float)), "invalid inputs" \# \$
CONTRACT \$ assert r \> 0, "invalid inputs" \# \$ CONTRACT \$ 763 assert
h \> 0, "invalid inputs" \# \$ CONTRACT \$ 764 l = math.sqrt(r \* r + h
\* h) 765 return math.pi \* r \* l 766 767 """ Contract List: 768 assert
0: assert isinstance(r, (int, float)), "invalid inputs 769 assert 1:
assert isinstance(h, (int, float)),"invalid inputs 770 assert 2: assert
r \> 0, "invalid inputs 771 assert 3: assert h \> 0,"invalid inputs 772
""" 773 774 775 Figure 4: Code and contracts for MBPP. 776 777 778 779
tation that now includes the crucial isinstance(s, str) and
isinstance(char, str) 780 assertions. 781 782 This comparison shows that
natural language descriptions may contain all required information, yet
783 their inherent ambiguity can prevent the model from adhering to the
contract. CVTCs make these implicit contracts explicit and enforceable.
They compel the model to produce code snippet that is 784 more
comprehensive and adheres to the intended contracts. 785 786 787 788
MBPP/11 789 790 """ 791 Write a python function that removes the first
and last occurrence of 792 a given character from the string; the first
input must be a non- empty string and the second input must be a string
of length one. 793 """ 794 795 def remove Occ(s, char): 796 assert
len(s) \> 0, "First input must be a non-empty string." 797 assert
len(char) == 1, "Second input must be a string of length one." 798 799
first = s.find(char) 800 last = s.rfind(char) 801 802 if first == -1:
return s 803 804 return s\[:first\] + s\[first+1:last\] + s\[last+1:\]
805 806 807 Figure 5: Code generated by DeepSeek with the contract
specification (CS) prompt. 808 809

                                                     15

Under review as a conference paper at ICLR 2026

810 MBPP/11 811 812 """ 813 Write a python function that removes the
first and last occurrence of 814 a given character from the string; the
first input must be a non- 815 empty string and the second input must be
a string of length one. 816 \# Contract Test Cases: 817 \>\>\> remove
Occ(2.0, 3.0) 818 "AssertionError: invalid input" 819 \>\>\> remove
Occ(5.0, 4.0) 820 "AssertionError: invalid input" 821 \>\>\> remove
Occ('', 2.0) "AssertionError: invalid input" 822 \>\>\> remove
Occ(2.0,'') 823 "AssertionError: invalid input" 824 """ 825 826 def
remove Occ(s, char): assert isinstance(s, str) and len(s) \> 0, "invalid
input" 827 assert isinstance(char, str) and len(char) == 1, "invalid
input" 828 829 first occ = s.find(char) 830 last occ = s.rfind(char) 831
if first occ == -1: 832 return s 833 834 return s\[:first occ\] +
s\[first occ+1:last occ\] + s\[last occ+1:\] 835 836 837 Figure 6: Code
generated by DeepSeek with the example-augmented specification (EAS)
prompt. 838 839 840 841 C C ASE S TUDY: C ONTRACT A DHERENCE VS . F
UNCTIONAL C ORRECTNESS 842 843 844 A case study from the HumanEval/142
task provides a concrete example of the trade-off between 845 contract
adherence and functional correctness. The figures 7--9 compare the
ground-truth implemen- 846 tation (golden label), the code generated
from a contract natural language prompt (CS), and the code 847 generated
from a prompt augmented with contract-violating test cases (CVTs). 848
Figure 8 displays the code generated from the NL-only prompt, which
describes both functional re- 849 quirements and contractual
constraints. It fails to translate the natural language contract
descriptions 850 into the necessary assertions, it successfully
generates code snippets that passes all standard func- 851 tionality
tests. This outcome suggests the model prioritized achieving functional
correctness---even 852 developing a logic for handling multiples of
12---at the complete expense of implementing the re- 853 quired
robustness checks, leaving the code snippets vulnerable to invalid
inputs. 854 In contrast, Figure 9 shows the code generated when the
prompt was augmented with CVTCs. Here, 855 the model successfully
implements the necessary assertions, demonstrating strong contract
adher- 856 ence. However, this heightened focus on contract enforcement
directly compromises its functional 857 correctness. The model generates
a flawed conditional logic that explicitly excludes common multi- 858
ples of 3 and 4. For an index like 0 or 12, the code incorrectly
defaults to the else block, failing to 859 square the number as required
by the specification in the Golden Label (Figure 7). 860 This example
clearly illustrates the trade-off. When compelled to handle the dual
objectives of im- 861 plementing contracts and functional logic, the
model's reasoning capacity is divided. The added 862 complexity of
enforcing contracts leads to a critical oversight in the core functional
logic, result- 863 ing in code snippet that is robust but functionally
incorrect. This underscores the inherent tension between these two
competing objectives in LLM-based code generation.

                                                        16

Under review as a conference paper at ICLR 2026

864 HumanEval/142 865 866 def sum squares(lst): 867 assert type(lst) ==
list, "invalid inputs" \# \$ CONTRACT \$ 868 assert all(type(x) == int
for x in lst), "invalid inputs" \# \$ 869 CONTRACT \$ 870 ans = 0 871
for i, num in enumerate(lst): 872 if i % 3 == 0: 873 ans += num \*\* 2
874 elif i % 4 == 0: 875 ans += num \*\* 3 else: 876 ans += num 877
return ans 878 879 880 Figure 7: The ground-truth implementation,
correct in both functionality and contracts. 881 882 883 HumanEval/142
884 885 def sum squares(lst): 886 total = 0 887 for i in
range(len(lst)): 888 num = lst\[i\] 889 if i % 3 == 0 and i % 4 == 0:
total += num \*\* 2 890 elif i % 3 == 0: 891 total += num \*\* 2 892
elif i % 4 == 0: 893 total += num \*\* 3 894 else: total += num 895
return total 896 897 898 899 Figure 8: A functionally correct
implementation that fails to enforce contracts. 900 901 902 D F
ORMALIZING C ONTRACTS INTO SMT-LIB: T EMPLATE AND A C ASE 903 S TUDY 904
905 906 This section details the structure of the SMT-LIB template used
by our PACT framework. SMT- 907 LIB is a standardized, text-based
language used to interface with SMT solvers. It provides a formal 908
syntax for declaring variables, defining functions, and asserting
logical formulas, allowing complex 909 problems to be translated into a
format that a solver can systematically analyze for satisfiability. Our
910 framework leverages this language to translate nuanced, natural
language contracts into a formal representation that can be reasoned
about with logical precision. 911 912 Figure 10 shows the base template
we designed for this purpose. It is composed of several key 913
components, each serving a distinct role in the test generation process.
The placeholders within this 914 template are populated as follows: 915
916 • CANONICAL PYTHON-LIKE ADT: This fixed block defines a universal
data structure 917 for representing common Python types. This allows the
SMT solver to reason about various input types in a standardized way.

                                                        17

Under review as a conference paper at ICLR 2026

918 HumanEval/142 919 920 def sum squares(lst): 921 assert
isinstance(lst, list), "AssertionError: invalid input" 922 for elem in
lst: 923 assert isinstance(elem, int), "AssertionError: invalid input"
924 total = 0 925 for index, num in enumerate(lst): 926 if index % 3 ==
0 and index % 4 != 0: 927 total += num \*\* 2 928 elif index % 4 == 0
and index % 3 != 0: 929 total += num \*\* 3 else: 930 total += num 931
return total 932 933 934 Figure 9: A robust implementation that enforces
contracts but fails on functionality. 935 936 937 • HELPER FUNCTIONS:
This section is populated with custom functions needed to define 938 the
contracts for a specific task. For example, a function to check if a
string contains only 939 digits would be defined here. 940 • INPUT: The
input variables for the function under test are declared here. 941 942 •
BASIC STRUCTURE: This section defines fundamental structural constraints
on the in- puts, such as ensuring a variable is a list composed of
integer values. 943 944 • CONTRACT DEFS: The specific logical rules of
each contract are translated into formal 945 predicates in this section.
946 • COMBINATION: This is the core logic for generating a test case. It
contains assertions 947 stating which contracts must be satisfied and
which must be violated. The SMT solver then 948 attempts to find a
concrete model that satisfies this exact combination of constraints. 949
Figure 12 shows the ground-truth Python implementation for the
HumanEval/11 task, which re- 950 quires a function that takes two binary
strings of equal length. The SMT-LIB formalization of these 951
requirements is shown in Figure 11. The three assert statements in the
Python code directly corre- 952 spond to the three formal contracts
defined in SMT-LIB: 953 954 • C0 verifies that both inputs are strings,
corresponding to the assertion assert 955 isinstance(a, str) and
isinstance(b, str). 956 • C1 ensures their lengths are equal,
corresponding to assert len(a) == len(b). 957 • C2 checks that they are
valid binary strings using a custom isBinaryString 958 helper function,
corresponding to assert set(a).issubset("0", "1") and 959
set(b).issubset("0", "1"). 960 961 The COMBINATION block determines the
goal of the test case generation. By choosing to as- 962 sert either the
contract itself, such as (assert (C0)), or its negation, such as (assert
(not 963 C0)), for each rule, this block can instruct the SMT solver to
find a test case for any desired com- 964 bination of contract
satisfactions and violations. The specific instance in the figure 11,
for example, 965 asserts the negation of all three contracts to generate
a test case that violates every precondition 966 simultaneously. 967 968
969 970 971

                                                        18

Under review as a conference paper at ICLR 2026

972 973 974 975 976 977 978 979 980 981 982 983 984 The SMT-LIB template
985 986 ADT BASE TEMPLATE = """ 987 (set-logic ALL) 988 ; ==== CANONICAL
PYTHON-LIKE ADT (DO NOT MODIFY) ==== 989 (declare-datatypes ((Value 0))
( 990 ((IntVal (ival Int)) 991 (FloatVal (fval Real)) 992 (StrVal (sval
String)) (BoolVal (bval Bool)) 993 (Nil) 994 (Cons (head Value) (tail
Value))) 995 )) 996 997 ; === ADD HELPER FUNCTIONS HERE ===
\<`<HELPER FUNCTIONS>`{=html}\> 998 999 ; === Inputs === 1000
\<`<INPUT>`{=html}\> 1001 1002 ; === BASIC STRUCTURE ===
\<`<BASIC STRUCTURE>`{=html}\> 1003 1004 ; === Contract predicates ===
1005 \<`<CONTRACT DEFS>`{=html}\> 1006 1007 ; === COMBINATION ===
\<`<COMBINATION>`{=html}\> 1008 1009 (check-sat) 1010 (get-model) 1011
""" 1012 1013 1014 Figure 10: The SMT-LIB template used for formalizing
contracts. 1015 1016 1017 1018 1019 1020 1021 1022 1023 1024 1025

                                                    19

Under review as a conference paper at ICLR 2026

1026 1027 1028 1029 1030 1031 1032 1033 The SMT-LIB template 1034 1035
ADT BASE TEMPLATE = """ 1036 (set-logic ALL) 1037 1038 ; ==== CANONICAL
PYTHON-LIKE ADT (DO NOT MODIFY) ==== 1039 (declare-datatypes ((Value 0))
( ((IntVal (ival Int)) 1040 (FloatVal (fval Real)) 1041 (StrVal (sval
String)) 1042 (BoolVal (bval Bool)) 1043 (Nil) 1044 (Cons (head Value)
(tail Value))) )) 1045 1046 ; === ADD HELPER FUNCTIONS HERE === 1047
(define-fun Safe Sval ((x Value)) String 1048 (ite (is-StrVal x) (sval
x) "")) 1049 (define-fun isBinaryString ((s Value)) Bool (and (is-StrVal
s) 1050 (str.in.re (Safe Sval s) (re.\* (re.union (str.to.re"0") (str.
1051 to.re "1")))))) 1052 1053 ; === Inputs === 1054 (declare-const a
Value) (declare-const b Value) 1055 1056 ; === BASIC STRUCTURE === 1057
1058 1059 ; === Contract predicates === (define-fun C0 () Bool (and
(is-StrVal a) (is-StrVal b))) 1060 (define-fun C1 () Bool (= (str.len
(Safe Sval a)) (str.len (Safe Sval 1061 b)))) 1062 (define-fun C2 ()
Bool (and (isBinaryString a) (isBinaryString b))) 1063 1064 ; ===
COMBINATION === (assert (not C0) 1065 (assert (not C1) 1066 (assert (not
C2) 1067 1068 (check-sat) 1069 (get-model) """ 1070 1071 1072 1073
Figure 11: An example of the SMT-LIB template populated for HumanEval/11
1074 1075 1076 1077 1078 1079

                                                    20

Under review as a conference paper at ICLR 2026

1080 1081 1082 1083 1084 1085 1086 1087 1088 1089 1090 1091 1092 1093
1094 1095 1096 1097 1098 1099 1100 HumanEval/11 1101 1102 from typing
import List 1103 1104 def string xor(a: str, b: str) -\> str: 1105
assert isinstance(a, str) and isinstance(b, str), "invalid inputs" 1106
\# \$ CONTRACT \$ 1107 assert len(a) == len(b), "invalid inputs" \# \$
CONTRACT \$ 1108 assert set(a).issubset({"0", "1"}) and
set(b).issubset({"0", "1"}) 1109 , "invalid inputs" \# \$ CONTRACT \$
1110 return "".join(str(int(a\[i\]) ˆ int(b\[i\])) for i in
range(len(a))) 1111 1112 1113 1114 Figure 12: The ground-truth
implementation in HumanEval/11 1115 1116 1117 1118 1119 1120 1121 1122
1123 1124 1125 1126 1127 1128 1129 1130 1131 1132 1133

                                                    21


