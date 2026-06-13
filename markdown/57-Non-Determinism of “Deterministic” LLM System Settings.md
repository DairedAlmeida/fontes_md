    Non-Determinism of “Deterministic” LLM System Settings in Hosted
                             Environments

Berk Atil1 \* , Sarp Aykent2 , Alexa Chittams2 , Lisheng Fu2 , Rebecca
J. Passonneau1 , Evan Radcliffe2 , Guru Rajan Rajagopal2 , Adam Sloan2 ,
Tomasz Tudrej2 , Ferhan Ture2 , Zhe Wu2 , Lixinyu Xu2 , Breck Baldwin2 1
Penn State University, 2 Comcast AI Technologies

           Correspondence: {bka5352,rjp49}@psu.edu; breckbaldwin@gmail.com

                       Abstract                                Cubero et al., 2024), or manufacturing optimization
                                                               (Du et al., 2025), to name a few. In tandem with
    LLM (large language model) users of hosted                 these high stakes uses, there has been increasing
    providers commonly notice that outputs can
                                                               attention to reliability (e.g., for Out-of-Distribution
    vary for the same inputs under settings expected
    to be deterministic. While it is difficult to              behavior (Liu et al., 2024; Du et al., 2022)), along-
    get exact statistics, recent reports on specialty          side other aspects of LLM trustworthiness (Shrid-
    news sites and discussion boards suggest that              har et al., 2024; Chen and Mueller, 2024). Uncer-
    among users in all communities, the majority               tainty in LLM output is an aspect of performance
    of LLM usage today is through cloud-based                  that could either degrade or bolster trust, depending
    APIs. Yet the questions of how pervasive non-              on the level of transparency. The laudable practice
    determinism is, and how much it affects perfor-
                                                               of testing on benchmark datasets to demonstrate
    mance results, have not to our knowledge been
    systematically investigated. We apply five API-
                                                               progress is counterbalanced by the frequent lack of
    based LLMs configured to be deterministic to               uncertainty measures. Despite known uncertainty
    eight diverse tasks across 10 runs. Experiments            across different training runs of a model, it has be-
    reveal accuracy variations of up to 15% across             come standard to report LLM results from a single
    runs, with a gap of up to 70% between best pos-            run (Hendrycks et al., 2021; Suzgun et al., 2023;
    sible performance and worst possible perfor-               Wang et al., 2024; Gema et al., 2024; Rein et al.,
    mance. No LLM consistently delivers the same               2023), possibly due to cost and computational time
    outputs or accuracies, regardless of task. We
                                                               restrictions. Benchmark results reported without
    speculate about the sources of non-determinism
    such as input buffer packing across multiple               measures of uncertainty (e.g., confidence intervals)
    jobs. To better quantify our observations, we              therefore undermines reliability. In this paper, we
    introduce metrics focused on quantifying de-               examine another factor that introduces variance
    terminism, TARr@N for the total agreement                  in benchmark results: non-determinism in hosted
    rate at N runs over raw output, and TARa@N                 LLMs.
    for total agreement rate of parsed-out answers.
                                                                   Many users of LLMs gain access to models
    Our code and data will be publicly available at
    https://github.com/breckbaldwin/llm-stability.
                                                               that are hosted through APIs. It is difficult to get
                                                               exact statistics, but recent information from spe-

1 Introduction cialty news sites and discussion boards suggests that
among users in all communities, the major- Large Language Models (LLM)
perform well on ity of LLM usage today is through cloud-based many types
of Natural Language Processing (NLP) APIs.1 Many users of LLM APIs
presumably ex- or NLP-related tasks, including question answer- pect
model output to be deterministic when temper- ing (Robinson and Wingate,
2023), diverse types of ature=0. While some users may have observed a
reasoning (Qiao et al., 2023), and code generation degree of
non-determinism in this setting, there is (Jiang et al., 2024b). Their
general applicability has little if any quantification of this variance.
Through- resulted in their widespread adoption for diverse, out the
paper, we refer to this behavior of output high-stakes societal
functions, such as information gathering in medicine (Shool et al.,
2025) or law 1 E.g.: https://www.prnewswire.com/news-releases/study-
(Niklaus et al., 2024), financial planning (de Zarzà i
finds-72-of-enterprises-plan-to-ramp-spending-on-genai-in-
2025-302484025.html?utm_source=chatgpt.com; \* Berk Atil completed this
work during his internship at
https://konghq.com/resources/reports/ai-and-api-adoption- Comcast AI
Technologies challenges.

                                                             135
             Proceedings of the 5th Workshop on Evaluation and Comparison of NLP Systems, pages 135–148
                          December 23, 2025 ©2025 Association for Computational Linguistics

Figure 1: Percentage difference between maximum and minimum accuracy in
10 runs per model, for 5 models on 8 tasks with zero-shot and few-shot
settings.

variance despite zero temperature as instability or shot and few-shot (3
for BBH, 5 for MMLU non-determinism. We demonstrate an alarming as in
the standard settings). degree of variation across equivalent input runs
• Correlation analyses of instability with accu- with a varied
collection of high performing API- racy, input length, and output
length. based LLMs2 under presumed deterministic set- • Experiments on
locally run LLMs that demon- tings. Our findings of up to 15%
differences in strate the desired stability. accuracy across runs
demonstrate there is far too much uncertainty in a realm where robust
engineer- • Data from runs and source code.3 ing is the expectation. To
quantify the problem of instability when tem- 2 Related Work perature=0,
we measure it in three LLM families To the best of our knowledge, no
work systemati- (GPT, Llama, and Mixtral) on diverse tasks from cally
investigates LLM instability given the same two common benchmarks:
Massive Multitask Lan- inputs and configurations (zero-shot and
few-shot) guage Understanding (MMLU) (Hendrycks et al., with maximally
deterministic hyperparameters for 2021) and BIG-Bench Hard (BBH) (Suzgun
et al., hosted LLMs. However, there is relevant work on 2023). Figure 1
depicts differences between max- both robustness of evaluation results
in general, imimum and minimum accuracies in multiple runs, and on
instability of hosted LLMs. Biderman et al. showing that the degree of
instability changes (2024) introduce a standard evaluation toolkit for
across model families, model sizes, tasks and set- LLMs and suggest best
practices for reproducibil- tings. Therefore, performance instability
can doubt- ity, but do not discuss instability. Works on the less impact
the ranking performance of systems. robustness of machine learning (ML)
models with Our specific contributions include: trivial changes to the
input include (Sehwag et al., 2019; Freiesleben and Grote, 2023;
Hancox-Li, • Quantification of LLM system instability over 2020; Rauber
et al., 2017). The (Song et al., 2024) 8 tasks randomly selected from
two common paper, which mentions instability, analyzes the ef-
benchmarks: BBH and MMLU. fect of temperature, sampling strategy,
repetition • Two metrics, TARr@N (total agreement rate penalty, and
alignment algorithms on performance for raw data across N runs) and
TARa@N evaluation. Findings include that LLMs have some (total agreement
rate for parsed answer across variance in the output that should be
taken into ac- N runs) for LLM system instability to capture count in
evaluation benchmarks. However, they use the variability in answer
accuracy and in the a temperature of 1, thereby introducing the
variabil- output word spans. ity that our study seeks to minimize.
Ouyang et al. • Comparison across settings, including zero- (2025)
present an instability analysis of a single 2 model, ChatGPT, with
varying temperatures on the API-based LLMs refer to the usage of LLMs
through 3 APIs such as OpenAI API or Together API.
https://github.com/breckbaldwin/llm-stability

                                                       136

Task Description Size Options BBH: navigation does path end at start 250
2 BBH: ruin names humorous edit of a band or movie title 250 4 BBH:
geometric shapes shape given SVG format 250 10 BBH: logical deduct. 3
objects order of 3 objects given constraints 250 3 MMLU: h. s. Europ.
hist. identical 165 4 MMLU: college math identical 100 4 MMLU: prof.
accounting identical 282 4 MMLU: public rel. media theory, crisis mgmt.,
etc. 110 4

Table 1: Eight tasks from BBH and MMLU with brief descriptions, and
numbers of examples and answer options.

one task of code generation. Lastly, Holtzman et al. 4.2 Models (2020)
mention freedom in text generation which We chose five top performing
models from different might lead to different outputs for the same
inputs, families and with varying sizes: GPT-3.5 Turbo but they do not
talk about the parameters that affect (Brown et al., 2020), GPT-4o
(OpenAI et al., 2024), this behaviour. Llama-3-70B-Instruct (Meta,
2024), Llama-3-8B- 3 Datasets Instruct (Meta, 2024), and
Mixtral-8x7B-Instruct (Jiang et al., 2024a). To ensure that our
investigation of instability in- cludes diverse NLP tasks, we selected
tasks from 4.3 Metrics two widely used multiple-choice benchmarks: Be-
To quantify instability, we report three metrics yond the Imitation Game
Benchmark Hard (BBH) based on accuracy that capture accuracy extremes
(Suzgun et al., 2023), with 27 diverse tasks from within a set of runs
in a given experimental condi- mathematics, commonsense reasoning and
other tion (model × dataset; see below). We also report domains;
Measuring Massive Multitask Language median accuracy; we do not report
means and stan- Understanding (MMLU) (Hendrycks et al., 2021), dard
deviations because the distributions in runs with 57 tasks across
disciplines including the hu- for a given condition are not normal (see
below). manities, social sciences, and STEM areas. To bal- Additionally,
we present two key metrics that are ance diversity against computational
resources, we variants of Total Agreement Rate@N (TAR@N): randomly
selected four subtasks from each bench- the percentage of test set
questions across N runs mark. Table 1 lists the tasks we selected,
number of where generated answers are all identical, regard- examples,
and number of multiple-choice options. less of whether the answer was
correct. This gives 4 Methods six measures per condition:

The subsections here discuss the LLM temperature 1. TARr@N (TAR@N for
the raw model re- parameter, the models we chose, and our metrics.
sponse) LLM responses are string equivalent. 4.1 Controlling LLM
Determinism 2. TARa@N (TAR@N for the parsed answer) The parsed answers
are the same, e.g., "The The temperature hyperparameter controls the de-
answer is a)" is the same as "a) is the answer." gree of determinism.
Equation 1 shows the prob- 3. The best possible accuracy over N runs
ability of word i where T is temperature ∈ \[0, 1\] (BestAcc), which is
the maximum possible and yi is the LLM logit: yi eT accuracy that could
be extracted from N runs. PN yj (1) For each question, if there is a run
in which j=1 e T the answer is correct, that question is marked
Theoretically, when T = 0, the LLM should pro- as correctly answered.
duce the same output given the same prompt, and 4. The worst possible
accuracy over N runs T can be raised to diversify outputs. As shown in
(WorstAcc), which is the minimum possible Figure 1, utilization of LLMs
through APIs leads accuracy that could be extracted from N runs. to
variable output at T = 0. For each question, if there is a run in which
the 137  the number of examples for few-shot, we use the standard
settings of 3-shot for BBH tasks, and 5- shot for MMLU tasks. All runs
use the same compute infrastructure, in- puts, and configurations.
However, we should note that we do not have any control of the compute
infrastructure on the API-side. We set tempera- ture at 0, top-p at 1,
and we fix the seed. We use OpenAI API for GPT models and togetherAPI
for open-sourced models. All experiments are done in February 2025 (the
exact dates are provided on Github). For the local run that we talk
about in Sec- tion 7.1 was done using Huggingface and Pytorch Figure 2:
Accuracy over 20 identical runs on college on Nvidia A6000 without any
optimization. math, temperature=0, top-p=1. Median in blue, mean in Our
eight datasets, five base models and two set- black with dashed 5% and
95% quantiles. tings (zero/few-shot) yield eighty conditions. For each
condition, we performed ten runs. answer is incorrect, that question is
marked as incorrectly answered. 6 Results 5. Maximum-minimum accuracy
difference Here, we report our two types of results. Overall across N
runs (max-min-diff). Note that be- results on the instability measures
show that all cause it represents the largest gap in N runs, five models
have a high degree of instability with it is not the same as the
difference between respect to both the raw output and the task accura-
BestAcc and WorstAcc. cies. The correlation analyses show that
instability 6. Median accuracy over N runs. increases with output
length, and that lower in- stability correlates with median accuracy for
the The TARr@N score is very strict, since any charac- few-shot setting.
ter variation will result in a disagreement. Thus in principle, it is
possible for the same set of runs to 6.1 Instability Results have 100%
TARa@N and 0% TARr@N. Figure 1 summarizes the extremes observed across
To examine the distributional behavior of accu- our eight datasets for
the five models in zero-shot racy scores, we did 20 few-shot runs of
GPT-4o and few-shot settings. The y-axis is the percentage and
Llama-3-70b on college math, two of the more difference between the
minimum and maximum unstable conditions. The results in Figure 2 clearly
accuracies (max-min-diff) in ten runs for each con- show non-normal
distributions, with mean and me- dition. Notably, there are 5-15%
differences on dian values far from the mode. A Kolmogorov- some tasks.
Smirnov normality test (Massey Jr, 1951) rejected The top of Table 2
reports BestAcc, median ac- the normal hypothesis with a p-value \< 10−9
. curacy and WorstAcc in the few-shot conditions for 4.4 Correlation
Analyses our five models (zero-shot results show a similar degree of
non-determinism, with varying consis- In addition to reporting measures
of instability, we tency across conditions, see Table 3 in Appendix also
investigate how independent the measures are A.2). The lower half of the
table reports TARa@10 using Spearman's rank correlation test. As part of
and TARr@10. When there is a gap between this analysis, we include
median input length and BestAcc and WorstAcc \> 10, there is often very
median output length as possible correlates. low TARr@10 (e.g., GPT3.5
on geometric shapes, logical deduction, ruin names; GPT4o on public 5
Experimental Conditions relations, European history professional
account- For our investigation of instability, we perform ex- ing,
college math). Notably, TARr@10 is typically periments on models without
fine-tuning in both fairly low, and there is a lot of variation across
mod- zero-shot and few-shot prompting (without Chain- els and datasets.
Unsuprisingly, TARa@10 can of-Thought (CoT) (Wei et al., 2022)).
Regarding be much higher than TARr@10, following from 138  Task gpt3.5
gpt4o llama8b llama70b mixtral8-7b BestAcc, Median Accuracy, WorstAcc
navigation 96.8, 95.6, 93.2 98.8, 98.8, 98.4 82.0, 80.2, 78.0 95.2,
94.6, 93.6 84.4, 79.0, 71.6 geo. shapes 72.4, 59.6, 46.8 82.4, 68.4,
53.6 49.2, 40.6, 32.8 67.2, 57.0, 47.2 54.4, 27.8, 08.8 logical deduct.
88.8, 81.6, 75.2 100., 100., 99.6 95.6, 90.2, 81.2 98.0, 96.4, 95.2
87.6, 75.0, 64.0 public rel. 75.5, 69.1, 65.5 80.0, 76.4, 73.6 63.6,
61.8, 61.8 67.3, 60.5, 53.6 58.2, 48.2, 36.4 Europ. hist. 83.6, 81.2,
78.2 89.1, 81.5, 72.1 74.5, 67.0, 59.4 61.8, 50.3, 41.2 65.5, 51.5, 35.8
ruin names 72.0, 58.0, 44.8 93.2, 90.8, 88.4 68.4, 66.8, 64.4 89.2,
87.2, 84.4 78.8, 67.6, 55.6 prof. account 52.5, 50.9, 48.9 89.0, 74.5,
57.8 48.2, 45.4, 44.0 78.0, 67.2, 55.3 67.0, 39.0, 13.1 college math
39.0, 38.0, 34.0 88.0, 69.0, 44.0 50.0, 22.5, 04.0 85.0, 54.5, 22.0
75.0, 31.5, 03.0 TARa@10, TARr@10 navigation 96.4, 46.0 99.6, 46.0 96.0,
86.0 98.4, 64.0 84.8, 50.0 geo. shapes 62.8, 25.2 63.2, 00.0 58.8, 27.6
66.4, 18.0 12.0, 02.4 logical deduct. 84.4, 34.8 99.6, 36.8 85.2, 50.0
97.2, 49.6 74.8, 16.4 public rel. 87.3, 82.7 92.7, 37.3 96.4, 73.6 81.8,
17.3 62.7, 10.9 Europ. hist. 94.5, 70.9 81.2, 09.1 82.4, 07.3 73.3, 22.4
55.2, 23.6 ruin names 66.0, 05.6 95.2, 00.0 88.4, 47.6 94.4, 10.8 70.4,
24.8 prof. account 91.1, 76.6 66.7, 04.6 89.0, 52.1 69.5, 00.0 23.4,
00.7 college math 89.0, 76.0 50.0, 00.0 22.0, 00.0 25.0, 00.0 07.0, 00.0

Table 2: BestAcc, Median Accuracy, WorstAcc on top; TARa@10, TARr@10 on
bottom, for the few-shot conditions (3 for BBH, 5 for MMLU, see section
5). Results are in terms of percentages.

the fact that TARr@N is a very strict metric (see and output length are
median word counts split above). by space, calculated over the input and
output of Figure 3 shows the TARr@10 for each task each LLM experiment
setup. We split the words by and model in a few-shot setting (for
zero-shot space instead of using a particular tokenizer. scores, see
Figure 12 in Appendix A.2). GPT-3.5 The results show a strong to
moderate nega- Turbo has lower TARr@10 (less instability) than tive
correlation between the output length and other models, and Llama-3-70B
often has very low TARa@10, as well as between the output length
TARr@10. and TARr@10 in few-shot/zero-shot settings. Note Figure 4 shows
TARa@10 for each condition in this is also consistent with the positive
correlation a few-shot setting (see Figure 11 in Appendix A.2 of output
length with max-min-diff. These corre- for zero-shot). While the TARa@10
results show lations mean that as an LLM's output length in- less
instability than TARr@10, they are still far creases, the instability of
the output increases, re- from perfect and show task-specific results.
The sulting in more diverse natural language responses high scores for
the navigation task indicate that as well as in the actual multiple
choice answer pre- leaderboards on this task can be expected to be
diction. The strong negative correlation between more reliable. On the
other hand, the more scat- LLM output length and instability could
motivate tered results for the college math and professional those using
LLMs in hosted environments to re- accounting tasks indicate that
results reported on strict the max generation tokens to control the in-
these tasks are not as robust. stability. We also see a strong positive
correlation between median accuracy and TARa@10 in the 6.2 Correlation
Analyses few-shot setting. This indicates that when the LLM We perform a
Spearman rank correlation analysis is more accurate it becomes more
deterministic on all pairs of the following metrics: TARa@10, for
multiple choice selections. Additionally, in TARr@10, max-min-diff,
median accuracy, median the few-shot setting, there is a moderate
negative input length, and median output length. Heat map correlation
between the output length and median results are shown in Figure 5 for
the few-shot and accuracy, which indicates that restricting max gen-
zero-shot prompted models. Here we define accu- eration tokens may
improve both determinisim and racy as the median accuracy over the 10
runs with accuracy. This is in parallel with the findings in the same
model and dataset setup. Input length (Zhang et al., 2024). 139 Figure
3: TARr@10 for each model in the few-shot setting. Dataset colors have
been chosen to distinguish them by relatively challenging (increasingly
dark red hues) versus relatively easy (increasingly dark blue hues).

Figure 4: TARa@10 for each task in the few-shot setting. Models colors
have been chosen to distinguish them by relatively low performing
(increasingly dark red hues) versus relatively high performing
(increasingly dark blue hues).

In addition to general correlations, we also look of 100% for TARa@10
and TAR@10, the same at correlation maps per model to see how general
values for BestAcc and WorstAcc, and 0% differ- findings apply to each.4
We find that all models are ence in the minimum and maximum values
across more stable when they generate shorter responses. all tasks. Our
results show that zero temperature Notably, Mixtral and Llama-3 models
are more is far from deterministic for API usage of LLMs. stable when
they are more accurate in the few-shot The TARr@10 scores show that
hosted LLMs are setting, but the effect varies in the zero-shot setting.
not stable at the string level in the T = 0 setting, Last but not least,
in the few-shot setting GPT-3.5 while the TARa@10 scores show they are
far more is more stable when the input is longer, but this deterministic
at the parsed answer level. String effect shows up less in the zero-shot
setting. variation does not affect a human reader much be- cause we can
extract the same answer even if the 7 Discussion output format is
different, but a downstream sys- Theoretically, at 0 temperature the
LLMs should tem that needs to parse the LLM response can be be
deterministic given the same input, with values affected significantly
when the format or pattern is different. This should be taken into
account when 4 These correlation map figures are in Appendix A.1.

                                                             140

Figure 5: Spearman correlation matrices for pairs of metrics in the
few-shot (left) and zero-shot (right) settings.

using hosted LLMs. many of the models are close-sourced (GPT-3-5,
TARa@10 values are much more consistent than GPT-4o), and all are hosted
behind APIs we don't TARr@10, yet still lead to high instablity of up
control, we can only speculate about the reason to 15%, as shown in
Figure 1. One caveat is that for this behavior. In order to support this
line of our answer extraction system has many hard-coded reasoning, we
ran Llama3-8b on our local GPUs parts, which reduces the generality of
the system. without any optimizations, yielding deterministic Therefore,
we have no guarantee that raw outputs results. This indicates that the
models and GPUs will lead to the exactly the same results for our
themselves are not the source of non-determinism. various accuracy
metrics, if the experiments are Additionally, we fine-tuned GPT-3.5
using two- repeated. fold cross validation. Although the results indi-
Theoretically, the maximum-minimum accuracy cate that fine-tuning helps
reduce instability, we hy- difference (max-min-diff) should be 0%. All
LLMs pothesize that a fine-tuned model cannot be shared here demonstrate
considerable variation on this across users and as such, our tasks were
the only metric. Mixtral-8x7b on college math is 72% (75% ones being
run. Hence, fine-tuning itself may not - 3%) for a particularly bad
example on suggesting be the only reason for reduced instability. a
truly random element in the generative process Non-deterministic AI
brings new challenges to driving the minimum value to 0%. This instabil-
developers, especially in commercial applications: ity lowers confidence
in the reliability of reporting only a single number in LLM benchmarks.
We • The usage of unit tests for AI functions is encourage reporting
maximum-minimum scores limited because of non-determinism. across runs
to have a more robust comparison of LLM systems. • Low stability might
also increase the potential for inexplicable errors that are very
different 7.1 Implications for Practical Engineering from human mistakes
such as responding as "none of the above" when the task is a multiple
Although the use of multiple GPUs introduces choice selection. some
randomness (Nvidia, 2024; Dror et al., 2019), it can be eliminated by
setting random seeds, so • Instability of the format of the outputs can
that AI models are deterministic given the same result in downstream
parser failures. input. In that case, performance errors could be
attributed to the model's generalization capability • One of the most
important effects is in sys- (e.g., under-/over-fitting). However,
engineering tem complexity that has to handle gracefully optimizations
to run LLMs faster, such as contin- "usually correct but this time
wrong" results. uous batching, chunk prefilling, or prefix caching,
Zipfian distributions are commonly seen in might lead to
non-deterministic behavior. Since applied AI systems where the frequency
of an 141  input/category is inversely related to its rank Tom Brown,
Benjamin Mann, Nick Ryder, Melanie in count sorted order f requency ∝
1/rank). Subbiah, Jared D Kaplan, Prafulla Dhariwal, Arvind Neelakantan,
Pranav Shyam, Girish Sastry, Amanda Testing tends to concentrate on the
frequent Askell, and 1 others. 2020. Language models are events,
potentially resulting in user confidence few-shot learners. Advances in
neural information that the resulting system is stable for the com-
processing systems, 33:1877--1901. mon inputs. However, the lack of
stability Jiuhai Chen and Jonas Mueller. 2024. Quantifying shown here
undermines the entire foundation uncertainty in answers from any
language model of this confidence, especially if mistakes are and
enhancing their trustworthiness. In Proceedings costly. of the 62nd
Annual Meeting of the Association for Computational Linguistics (Volume
1: Long Papers), 8 Conclusion pages 5186--5200, Bangkok, Thailand.
Association for Computational Linguistics. We have made a systematic
analysis of the deter- minism of hosted LLMs with the temperature hy-
Irene de Zarzà i Cubero, Joaquim de Curtò i Díaz, Gemma Roig, and Carlos
T Calafate. 2024. Opti- perparameter value that should maximize it. Our
mized financial planning: Integrating individual and results show that
such systems can be highly non- cooperative budgeting models with llm
recommenda- deterministic with T = 0. Furthermore, we find tions. AI,
5(1):91--114. that these LLMs rarely produce the same response Rotem
Dror, Segev Shlomov, and Roi Reichart. 2019. ten times given the same
input; the parsed answer Deep dominance - how to properly compare deep
is often more stable. Note that the observation neural models. In
Proceedings of the 57th Annual that instability results are not normally
distributed Meeting of the Association for Computational Lin- guistics,
pages 2773--2785, Florence, Italy. Associa- makes it more difficult to
measure the resulting tion for Computational Linguistics. uncertainty.
Lastly, instability is highly variable across tasks for the same model,
and across models Kaze Du, Bo Yang, Keqiang Xie, Nan Dong, Zheng- ping
Zhang, Shilong Wang, and Fan Mo. 2025. Llm- for the same task. manuf: An
integrated framework of fine-tuning large Other questions about
instability remain to be language models for intelligent decision-making
in explored. For instance, how can we reduce the in- manufacturing.
Advanced Engineering Informatics, stability of hosted LLM systems during
training 65:103263. or inference time (e.g., adding a meta prompt to
Xuefeng Du, Zhaoning Wang, Mu Cai, and Sharon Li. indicate the model is
only allowed to answer with 2022. Towards unknown-aware learning with
virtual a single letter)? Second, how can the instability outlier
synthesis. In International Conference on of hosted LLM systems be taken
into account in Learning Representations (ICLR). business products?
Third, how should we commu- Timo Freiesleben and Thomas Grote. 2023.
Beyond nicate with decision-makers about instability? Last
generalization: a theory of robustness in machine but not least, more
analysis could be done to see if learning. Synthese, 202(4):109. there
is any correlation between the stability and Aryo Pradipta Gema, Joshua
Ong Jun Leang, Giwon specific types of errors, such as false positives
and Hong, Alessio Devoto, Alberto Carlo Maria Mancino, false negatives.
Rohit Saxena, Xuanli He, Yu Zhao, Xiaotang Du, Mohammad Reza Ghasemi
Madani, and 1 others. 2024. Are we done with MMLU? arXiv preprint
Limitations arXiv:2406.04127. Our experiments are limited to 8 datasets
and mul- Leif Hancox-Li. 2020. Robustness in machine learning tiple
choice questions. Further, we only experi- explanations: does it matter?
In Proceedings of the mented with 5 LLM systems. However, given the 2020
Conference on Fairness, Accountability, and overal pattern we have
observed, we believe that the Transparency, FAT\* '20, page 640--647,
New York, NY, USA. Association for Computing Machinery. findings likely
apply to other datasets and LLMs. Dan Hendrycks, Collin Burns, Steven
Basart, Andy Zou, Mantas Mazeika, Dawn Song, and Jacob Steinhardt.
References 2021. Measuring massive multitask language under- standing.
In International Conference on Learning Stella Biderman, Hailey
Schoelkopf, Lintang Sutawika, Representations. Leo Gao, Jonathan Tow,
Baber Abbasi, Alham Fikri Aji, Pawan Sasanka Ammanamanchi, Sidney Black,
Ari Holtzman, Jan Buys, Li Du, Maxwell Forbes, and Jordan Clive, and 1
others. 2024. Lessons from the Yejin Choi. 2020. The curious case of
neural text de- trenches on reproducible evaluation of language mod-
generation. In International Conference on Learning els. arXiv preprint
arXiv:2405.14782. Representations. 142 Albert Q. Jiang, Alexandre
Sablayrolles, Antoine Jonas Rauber, Wieland Brendel, and Matthias
Bethge. Roux, Arthur Mensch, Blanche Savary, Chris 2017. Foolbox: A
python toolbox to benchmark Bamford, Devendra Singh Chaplot, Diego de
las the robustness of machine learning models. arXiv Casas, Emma Bou
Hanna, Florian Bressand, Gi- preprint arXiv:1707.04131. anna Lengyel,
Guillaume Bour, Guillaume Lam- ple, Lélio Renard Lavaud, Lucile
Saulnier, Marie- David Rein, Betty Li Hou, Asa Cooper Stickland, Anne
Lachaux, Pierre Stock, Sandeep Subramanian, Jackson Petty, Richard
Yuanzhe Pang, Julien Di- Sophia Yang, and 7 others. 2024a. Mixtral of
experts. rani, Julian Michael, and Samuel R. Bowman. 2023. Preprint,
arXiv:2401.04088. Gpqa: A graduate-level google-proof q&a bench- mark.
Preprint, arXiv:2311.12022. Juyong Jiang, Fan Wang, Jiasi Shen, Sungju
Kim, and Sunghun Kim. 2024b. A survey on large lan- Joshua Robinson and
David Wingate. 2023. Leveraging guage models for code generation. arXiv
preprint large language models for multiple choice question
arXiv:2406.00515. answering. In The Eleventh International Conference on
Learning Representations. Bo Liu, Li-Ming Zhan, Zexin Lu, Yujie Feng,
Lei Xue, and Xiao-Ming Wu. 2024. How good are LLMs Vikash Sehwag, Arjun
Nitin Bhagoji, Liwei Song, at out-of-distribution detection? In
Proceedings of Chawin Sitawarin, Daniel Cullina, Mung Chiang, the 2024
Joint International Conference on Compu- and Prateek Mittal. 2019.
Analyzing the robustness tational Linguistics, Language Resources and
Eval- of open-world machine learning. In Proceedings of uation
(LREC-COLING 2024), pages 8211--8222, the 12th ACM Workshop on
Artificial Intelligence Torino, Italia. ELRA and ICCL. and Security,
AISec'19, page 105--116, New York, NY, USA. Association for Computing
Machinery. Frank J Massey Jr. 1951. The Kolmogorov-Smirnov test for
goodness of fit. Journal of the American Sina Shool, Sara Adimi, Reza
Saboori Amleshi, Ehsan statistical Association, 46(253):68--78. Bitaraf,
Reza Golpira, and Mahmood Tara. 2025. A systematic review of large
language model (llm) eval- Meta. 2024. Introducing Meta Llama 3: The
most uations in clinical medicine. BMC Medical Informat- capable openly
available LLM to date. https://ai. ics and Decision Making, 25(1):117.
meta.com/blog/meta-llama-3. Kumar Shridhar, Koustuv Sinha, Andrew Cohen,
Tianlu Joel Niklaus, Veton Matoshi, Matthias Stürmer, Ilias Wang, Ping
Yu, Ramakanth Pasunuru, Mrinmaya Chalkidis, and Daniel Ho. 2024.
MultiLegalPile: A Sachan, Jason Weston, and Asli Celikyilmaz. 2024.
689GB multilingual legal corpus. In Proceedings The ART of LLM
refinement: Ask, refine, and trust. of the 62nd Annual Meeting of the
Association for In Proceedings of the 2024 Conference of the North
Computational Linguistics (Volume 1: Long Papers), American Chapter of
the Association for Computa- pages 15077--15094, Bangkok, Thailand.
Association tional Linguistics: Human Language Technologies for
Computational Linguistics. (Volume 1: Long Papers), pages 5872--5883,
Mexico City, Mexico. Association for Computational Lin- Nvidia. 2024.
Floating point and ieee 754 compliance guistics. for nvidia gpus.
https://docs.nvidia.com/cuda/ floating-point/index.html. Yifan Song,
Guoyin Wang, Sujian Li, and Bill Yuchen Lin. 2024. The good, the bad,
and the greedy: Eval- OpenAI, Josh Achiam, Steven Adler, Sandhini
Agarwal, uation of LLMs should not ignore non-determinism. Lama Ahmad,
Ilge Akkaya, Florencia Leoni Ale- arXiv preprint arXiv:2407.10457. man,
Diogo Almeida, Janko Altenschmidt, Sam Alt- man, Shyamal Anadkat, Red
Avila, Igor Babuschkin, Mirac Suzgun, Nathan Scales, Nathanael Schärli,
Se- Suchir Balaji, Valerie Balcom, Paul Baltescu, Haim- bastian
Gehrmann, Yi Tay, Hyung Won Chung, ing Bao, Mohammad Bavarian, Jeff
Belgum, and Aakanksha Chowdhery, Quoc Le, Ed Chi, Denny 262 others.
2024. GPT-4 technical report. Preprint, Zhou, and Jason Wei. 2023.
Challenging BIG-bench arXiv:2303.08774. tasks and whether
chain-of-thought can solve them. In Findings of the Association for
Computational Lin- Shuyin Ouyang, Jie M. Zhang, Mark Harman, and
guistics: ACL 2023, pages 13003--13051, Toronto, Meng Wang. 2025. An
empirical study of the non- Canada. Association for Computational
Linguistics. determinism of ChatGPT in code generation. ACM Transactions
on Software Engineering and Method- Yubo Wang, Xueguang Ma, Ge Zhang,
Yuansheng Ni, ology, 34(2). Abhranil Chandra, Shiguang Guo, Weiming Ren,
Aaran Arulraj, Xuan He, Ziyan Jiang, and 1 others. Shuofei Qiao, Yixin
Ou, Ningyu Zhang, Xiang Chen, 2024. MMLU-pro: A more robust and
challenging Yunzhi Yao, Shumin Deng, Chuanqi Tan, Fei Huang, multi-task
language understanding benchmark. arXiv and Huajun Chen. 2023. Reasoning
with language preprint arXiv:2406.01574. model prompting: A survey. In
Proceedings of the 61st Annual Meeting of the Association for Compu-
Jason Wei, Xuezhi Wang, Dale Schuurmans, Maarten tational Linguistics
(Volume 1: Long Papers), pages Bosma, Fei Xia, Ed Chi, Quoc V Le, Denny
Zhou, 5368--5393, Toronto, Canada. Association for Com- and 1 others.
2022. Chain-of-thought prompting elic- putational Linguistics. its
reasoning in large language models. Advances 143  in neural information
processing systems, 35:24824-- 24837. Yusen Zhang, Sarkar Snigdha
Sarathi Das, and Rui Zhang. 2024. Verbosity ̸= veracity: Demystify ver-
bosity compensation behavior of large language mod- els. Preprint,
arXiv:2411.07858.

A Appendix A.1 Correlation Matrices Per Model A.2 Zero-shot Results

                                                      144

Figure 6: Spearman correlation matrices for GPT-4o for pairs of metrics
in the few-shot (left) and zero-shot settings (right).

Figure 7: Spearman correlation matrix for GPT-3.5-turbo between metrics
in few-shot setting (on the left) and zero-shot setting (on the right).

                                                        145

Figure 8: Spearman correlation matrix for Llama-8b between metrics in
few-shot setting (on the left) and zero-shot setting (on the right).

Figure 9: Spearman correlation matrix for Llama-70b between metrics in
few-shot setting (on the left) and zero-shot setting (on the right).

                                                       146

Figure 10: Spearman correlation matrix for Mixtral-8x7b between metrics
in few-shot setting (on the left) and zero-shot setting (on the right).

Task gpt3.5 gpt4o llama8b llama70b mixtral8-7b Accuracy Results
navigation 67.2, 64.8, 61.6 94.8, 92.0, 88.8 88.4, 73.0, 54.0 94.0,
88.0, 78.4 66.0, 57.6, 48.0 geo. shapes 16.8, 15.2, 13.6 76.0, 56.8,
30.4 24.4, 18.8, 12.0 44.4, 21.6, 6.4 29.6, 27.0, 24.8 logical deduct.
52.8, 50.8, 48.8 100.0, 98.6, 96.0 72.4, 62.8, 55.6 95.6, 92.2, 87.6
70.0, 59.6, 49.6 public rel. 66.4, 65.0, 61.8 81.8, 75.5, 66.4 28.2,
25.0, 19.1 39.1, 26.4, 13.6 57.3, 46.8, 35.5 Europ. hist. 75.2, 74.5,
72.7 76.4, 65.2, 55.2 38.8, 34.2, 30.3 41.2, 27.9, 19.4 66.1, 56.1, 45.5
ruin names 67.2, 65.6, 65.2 85.2, 83.2, 80.0 54.8, 50.6, 45.6 67.6,
60.0, 51.2 38.0, 34.4, 30.4 prof. account 60.3, 53.2, 47.5 84.0, 72.0,
58.5 36.2, 29.1, 25.5 54.6, 38.7, 24.8 42.9, 28.9, 20.2 college math
54.0, 32.0, 15.0 85.0, 59.0, 41.0 55.0, 34.0, 17.0 77.0, 58.0, 40.0
57.0, 31.5, 13.0 TAR Results navigation 94.4, 94.4 91.6, 15.2 65.2, 9.2
83.2, 4.8 77.6, 3.2 geo. shapes 91.6, 91.6 45.6, 0.8 60.4, 31.2 39.2,
5.6 90.4, 83.6 logical deduct. 92.8, 90.4 96.8, 7.6 80.4, 37.6 92.0,
16.4 74.4, 14.0 public rel. 92.7, 86.4 83.6, 38.2 82.7, 46.4 56.4, 0.9
61.8, 10.0 Europ. hist. 94.5, 94.5 74.5, 17.0 77.6, 41.2 53.9, 6.1 63.6,
19.4 ruin names 95.6, 97.2 93.6, 27.6 86.8, 26.8 79.2, 11.6 82.4, 20.8
prof. account 81.9, 49.3 71.3, 4.3 77.0, 44.0 57.8, 2.1 48.2, 4.3
college math 46.0, 10.0 50.0, 0.0 45.0, 3.0 54.0, 0.0 29.0, 2.0

Table 3: BestAcc, Median Accuracy, WorstAcc on top; TARa@10, TARr@10 on
bottom, for the zero-shot conditions. Results are in terms of
percentages.

                                                     147

Figure 11: TARa@10 for each task in the zero-shot setting. Model colors
have been chosen to distinguish them by relatively low performing
(increasingly dark red hues) versus relatively high performing
(increasingly dark blue hues).

Figure 12: TARr@10 for each model in the zero-shot setting. Dataset
colors have been chosen to distinguish them by relatively challenging
(increasingly dark red hues) versus relatively easy (increasingly dark
blue hues).

                                                      148


