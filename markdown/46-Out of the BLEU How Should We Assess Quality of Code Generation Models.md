                                              Out of the BLEU: How Should We Assess Quality of the Code
                                                                 Generation Models?
                                                                         Mikhail Evtikhiev                                                                  Egor Bogomolov
                                                                      JetBrains Research                                                                   JetBrains Research
                                                                      Republic of Cyprus                                                                   Republic of Cyprus
                                                                mikhail.evtikhiev@jetbrains.com                                                      egor.bogomolov@jetbrains.com

                                                                          Yaroslav Sokolov                                                                  Timofey Bryksin
                                                                            JetBrains                                                                      JetBrains Research

arXiv:2208.03133v2 \[cs.SE\] 10 May 2023

                                                                            Germany                                                                        Republic of Cyprus
                                                                 yaroslav.sokolov@jetbrains.com                                                      timofey.bryksin@jetbrains.com

                                         ABSTRACT                                                                                      ACM Reference Format:
                                         In recent years, researchers have created and introduced a signifi-                           Mikhail Evtikhiev, Egor Bogomolov, Yaroslav Sokolov, and Timofey Bryksin.
                                                                                                                                       2023. Out of the BLEU: How Should We Assess Quality of the Code Genera-
                                         cant number of various code generation models. As human eval-
                                                                                                                                       tion Models?. In Proceedings of ACM Conference (Conference’17). ACM, New
                                         uation of every new model version is unfeasible, the community                                York, NY, USA, 17 pages. https://doi.org/10.1145/nnnnnnn.nnnnnnn
                                         adopted automatic evaluation metrics such as BLEU to approximate
                                         the results of human judgement. These metrics originate from the
                                         machine translation domain and it is unclear whether they are ap-
                                         plicable for the code generation tasks and how well they agree with
                                                                                                                                       1    INTRODUCTION
                                         the human evaluation on this task. There are also other metrics,                              Code generation systems are a way to make the process of writing
                                         CodeBLEU and RUBY, developed to estimate the similarity of code,                              source code easier and more accessible. In a common formulation,
                                         that take into account the properties of source code. However, for                            such systems take an intent—description in a natural language—as
                                         these metrics there are hardly any studies on their agreement with                            an input and produce a snippet of code that implements the intent.
                                         the human evaluation. Despite all that, minimal differences in the                            Proper code generation is a long-standing problem [1] that, if im-
                                         metric scores have been used in recent papers to claim superiority                            plemented well, would aid in education, simplify drafting program
                                         of some code generation models over the others.                                               implementations for non-programmers, and attract new program-
                                             In this paper, we present a study on the applicability of six                             mers who may have limited programming experience in a given
                                         metrics—BLEU, ROUGE-L, METEOR, ChrF, CodeBLEU, and RUBY—                                      language [2]. Therefore, having a strong code generation model
                                         for evaluation of code generation models. We conduct a study on                               could be very beneficial for the software development industry.
                                         two different code generation datasets and use human annotators                                  Currently, there are many various code generating models [2–6]
                                         to assess the quality of all models run on these datasets. The results                        and several datasets [7–13] on which these models are evaluated.
                                         indicate that for the CoNaLa dataset of Python one-liners, none                               The code generation models are usually assessed with either ac-
                                         of the metrics can correctly emulate human judgement on which                                 curacy, BLEU metric [14], or CodeBLEU metric [15]. Originally,
                                         model is better with > 95% certainty if the difference in model                               BLEU was created to evaluate the quality of machine translation
                                         scores is less than 5 points. For the HearthStone dataset, which con-                         for natural language processing, and it was empirically validated to
                                         sists of classes of a particular structure, a difference in model scores                      be correlated with the human judgments of the translation quality
                                         of at least 2 points is enough to claim the superiority of one model                          for natural language texts. However, no such validation exists for
                                         over the other. Our findings suggest that the ChrF metric is a better                         the code generation task. Moreover, for the closely related code
                                         fit for the evaluation of code generation models than the commonly                            migration problem, Tran et al. [16] have shown that the BLEU re-
                                         used BLEU and CodeBLEU. Yet, finding a metric for code generation                             sults are only weakly correlated with the human judgment. For the
                                         that closely agrees with humans requires additional work.                                     related code summarization problem, Roy et al. [17] have shown
                                                                                                                                       that BLEU metric is a less reliable indicator of human judgement
                                                                                                                                       than other metrics, such as METEOR or ChrF.
                                                                                                                                          We identify three possible problems with the application of the
                                                                                                                                       BLEU metric for the code generation task, that, to the best of our
                                         Permission to make digital or hard copies of all or part of this work for personal or         knowledge, have hardly been addressed [15, 16]:
                                         classroom use is granted without fee provided that copies are not made or distributed
                                         for profit or commercial advantage and that copies bear this notice and the full citation         • It is unclear whether existing metrics are suitable for the
                                         on the first page. Copyrights for components of this work owned by others than ACM                  assessment of the code generation models.
                                         must be honored. Abstracting with credit is permitted. To copy otherwise, or republish,
                                         to post on servers or to redistribute to lists, requires prior specific permission and/or a       • It is unclear how significant the metrics scores are and how
                                         fee. Request permissions from permissions@acm.org.                                                  big the difference in the scores should be to claim one model’s
                                         Conference’17, July 2017, Washington, DC, USA                                                       superiority over the other.
                                         © 2023 Association for Computing Machinery.
                                         ACM ISBN 978-x-xxxx-xxxx-x/YY/MM. . . $15.00                                                      • It is unclear how well the metrics correlate with the human
                                         https://doi.org/10.1145/nnnnnnn.nnnnnnn                                                             judgement for existing code generation datasets.

Conference'17, July 2017, Washington, DC, USA Mikhail Evtikhiev, Egor
Bogomolov, Yaroslav Sokolov, and Timofey Bryksin

In our study, we consider two different datasets. The CoNaLa HearthStone
dataset if the score difference is less than two dataset \[12\] is a
dataset of questions posted on Stack Overflow1 points. Of all metrics we
considered, ChrF and ROUGE-L are with solutions in Python. The solutions
are short and generally are the best-performing metrics for the code
generation task. one line long. Card2code Hearthstone \[10\] is a
dataset dedicated to generating classes that are descriptions of the
cards used in the Hearthstone game. The classes are rigid and most of
the class This paper is structured as follows. In Section 2, we describe
structures are identical for every snippet. For each of the datasets,
the code generation problem, briefly describe the metrics we use we
consider several machine learning models for code generation. for
assessing generated code, and describe a similar study by Roy For the
CoNaLa dataset, we compare the results of five different et al. \[17\]
that targeted the code summarization problem. In Sec- models: 1) CoNaLa
baseline \[12\], 2) Codex \[2\], 3) TranX without tion 3, we compare
usage of automated metrics with test-based pretraining \[5\], 4) TranX
with pretraining, and 5) TranX with pre- evaluation, and outline
possible issues with the current usage of training and reranking \[6\].
While being publicly available, the se- automated metrics. In Section 4,
we describe the methodology lected models greatly vary in quality and
complexity, which allows of our study: outline the study pipeline,
explain our choice of for judgement on the relation between the models'
quality, metric datasets and models, research questions, our approach to
answer- values, and human assessment. For the Hearthstone dataset, we
ing them. In Section 5, we present our results and answer the RQs
compare the results of two models that were previously evaluated
presented in the previous section. In Section 6, we summarize our on
this dataset: NL2Code \[3\] and GCNN \[4\]. findings to provide the
guidelines for the practitioners who want To address the problem of the
applicability of automated metrics, to use autmoated metrics to assess
code generation models, and we carry out paired bootstrap resampling
\[18\]. We consider BLEU, present the directions for the future work. In
Section 7, we address METEOR, ROUGE-L, ChrF, CodeBLEU, and RUBY
\[14--16, 19--21\] the threats to the validity of our study. In Section
8, we summa- metric scores of the models. rize our paper. In Appendix A
we describe the metrics we study To address the problem of correlation
between human assess- in more details. Finally, our replication package
can be found at ment and computer metric scores, we carry out a human
evaluation https://github.com/JetBrains-Research/codegen-metrics. of the
generated snippets. Software developers evaluated whether the suggested
snippets were helpful in solving the posed problem on the scale from 0
to 4. For the CoNaLa dataset, 12 developers took part in the evaluation
and we got on average 4.5 grades from 2 BACKGROUND different developers
per snippet. For the Hearthstone dataset, there were four graders, and
every grader evaluated the entire dataset. 2.1 Code Generation The
amount of grades per snippet we collect is not enough to Code generation
is a long-standing problem \[1\], and a good code analyze the metrics
performance on the snippet level, as Mathur generation model could
decrease the barrier for writing code, au- et al. \[22\] argued it is
necessary to have 15 grades per snippet to tomate some of the routine
tasks engineers have, and help non- provide a stable score. Thus, we
focus on the comparison of models programmers create programming
solutions for their problems. at the corpus level. The available set of
ML models is not large This problem is also related to other
applications of machine learn- enough to study the significance of
difference in metric scores: for ing to code. In the greater context of
code-related tasks, code gener- example, for the CoNaLa dataset there
only are five original models, ation is a task complementary to code
summarization and is closely and thus only ten different pairs of models
to compare. To provide related to code migration and code completion. a
statistical analysis of corpus-level score differences, we augment The
development of deep learning has enabled the successful the original set
of models with a set of synthetic models. In it, we application of
various neural models to the code generation problem. replace a part of
some model predictions with predictions that have In particular, Ling et
al. \[10\] suggested a sequence-to-sequence a higher or lower human
assessment score, following Roy et al. \[17\]. model to generate code
from natural language descriptions. Yin et Our findings and
contributions are the following: al. \[3\] and Rabinovich et al. \[23\]
modified the standard decoder that • We find that the existing metrics
are not suitable for assess- generates a sequence of tokens to enforce
grammar rules by first ing code generation, as for every dataset and
every metric, generating an abstract syntax tree and then converting it
into code. metrics disagree with the human judgement in more than Sun et
al. \[4\] suggested replacing recurrent neural networks with 5% of the
cases. grammar-based structural convolutional neural networks. Unlike •
We find that the difference in metric scores of two models of recurrent
neural networks, convolutional neural networks can track less than two
points on a 0--100 scale is statistically insignif- the context even
between distant regions of the analyzed data. In icant in more than 5%
of the cases. This finding does not contrast, recurrent neural networks
are not capable of tracking depend on the human evaluation and shows it
is necessary the context when relevant pieces of information are far
apart, also to test for statistical significance when reporting increase
in known as the long dependency problem \[24, 25\]. Wei et al. \[26\]
metric scores of less than two points. suggested dual training of code
generation and code summarization • We find that, when taking human
assessment into account, models to enhance the quality of both models.
all metrics are unreliable on the CoNaLa dataset if the score In
contrast to recurrent neural networks, models based on the difference is
less than five points, and are unreliable on the Transformer
architecture \[27\] process the whole sequence simul- taneously, which
is more efficient both in terms of computational 1 Stack Overflow:
https://stackoverflow.com/ speed and capturing the dependencies between
distant tokens. Out of the BLEU: How Should We Assess Quality of the
Code Generation Models? Conference'17, July 2017, Washington, DC, USA

Nowadays, we observe rapid progress in the quality of code gen- The
authors also constructed a synthetic dataset to illustrate that eration
models due to gigantic Transformer-based models such as BLEU may yield
similar results for the models whose quality differs Codex \[2\],
AlphaCode \[28\], and CodeParrot.2 from the perspective of the human
grader. To address this issue, the Table 1 summarizes types of neural
networks and metrics used authors devised a new metric RUBY, which takes
code structure into by the researchers in the papers discussed above.
account. The metric compares program dependency graphs (PDG) of the
reference and the candidate; if a PDG is impossible to build, 2.2
Evaluation of Code Generation Models it falls back to comparing abstract
syntax trees (AST), and if an AST To be able to track improvements of a
model, it is necessary to eval- is also impossible to build, the metric
compares the weighted string uate its performance. Human assessment is
the gold standard for edit distance between the (tokenized) reference 𝑅
and candidate most machine translation or machine generation problems.
How- sequences. ever, manual assessment is also very expensive and slow,
and it CodeBLEU. Ren et al. \[15\] suggested a new metric called Code-
is impractical to do human evaluation for each generated sample BLEU to
evaluate the quality of generated code for code generation, during the
model development. Thus, it is crucial to have an easy code translation,
and code refinement tasks. CodeBLEU is a com- to compute metric to
evaluate the output of a model. posite metric with the scores being
weighted average of 4 different The code generation task is no
different. The evaluation ap- sub-metrics treating code differently: as
a data-flow graph, as an proaches for code generation can be split into
three categories: abstract syntax tree, and as text. For text, CodeBLEU
provides two different submetrics, one of which treats all tokens as
being equally (1) Metrics from the machine translation domain;
important, and another gives higher weight to the keywords. (2) Metrics
developed to compare code snippets; (3) Running and testing the
generated code. 2.2.3 Test-based evaluation. The impressive performance
of recent Further, we discuss all three in detail. large-scale models
\[2, 28\] allows the use of evaluation techniques 2.2.1 Metrics from
machine translation. As Table 1 shows, the qual- which are closer to
practical applications: actually running the ity of code generation
models is typically assessed by the BLEU generated code on pre-written
unit-tests and checking whether it metric score \[14\] or accuracy. The
BLEU (BiLingual Evaluation solves the posed problem. For example, the
authors of Codex \[2\] also Understudy) metric is a metric that was
originally developed for present a dataset called HumanEval which
consists of programming the automatic quality evaluation of
machine-translated texts. The tasks and tests validating the correctness
of the generated code. BLEU metric is a corpus-level metric based on the
modified 𝑛-gram While this approach is reasonable, we argue that for now
it will precision measure with a length penalization for the candidate
not fully replace existing evaluation techniques that rely on the
sentences that are shorter than the reference ones. usage of automated
metrics. In order to apply test-based evalua- Researchers also consider
other machine translation metrics: tion, researchers need carefully
created datasets for each particular code generation setting.
Additionally, the studied models should • ROUGE-L \[19\] is a
recall-oriented metric that looks for the pass large enough number of
tests in order to robustly distinguish longest common subsequence
between the reference and the between them. candidate. • METEOR \[29\]
is a mixed recall-precision metric that also penalizes candidates for
not having adjacent unigrams that 2.3 Study of Metrics for Code
Summarization are adjacent in the reference example. The automated
metrics are used for a variety of other code-related • ChrF \[21\] is a
character n-gram F-score metric, where preci- generation tasks such as
code translation, code summarization, or sion and recall in the F-score
computation are averaged over code refinement \[13\]. Recently, Roy et
al. \[17\] studied the applica- 1- to 6-grams of characters. bility of
automated metrics for the code summarization task, which In addition to
the aforementioned metrics, researchers often is closely related to code
generation. For this task, metrics such as report Accuracy as an
additional metric. While it supports the fact BLEU are used widely as
proxies of human evaluation. The authors that one model is superior to
another, it is rarely used as the primary show that there is no
statistically significant difference between the metric in the
generation tasks due to being too strict and less robust. models with
corpus scores different by less than 1.5 points accord- Thus, we do not
analyze Accuracy in our study, as we focus on ing to any of the
considered metrics. Moreover, all the metrics the metrics used for
direct model comparison. authors considered are not reliable proxies of
human evaluation if 2.2.2 Metrics designed for code. the difference in
corpus scores is less than two points according to RUBY. The RUBY metric
was suggested by Tran et al. \[16\] as an the metrics. Of all the
metrics considered by Roy et al., METEOR, alternative to the natural
languages metrics. Indeed, even though ChrF, and BERTScore show the best
agreement with the human BLEU (like METEOR and ROUGE-L) was originally
created for the judgement on the corpus level. As Roy et al. do an
extensive study assessment of machine translation models for natural
languages, it of the metric performance for a task that is closely
related to the is widely used for assessing code generation, code
migration, and code generation, we adopt many of the methods they
employed in code summarization models. Tran et al. \[16\] conducted an
empirical our research. study on BLEU to check its suitability in the
context of the code 2.3.1 Dataset and labeling. Roy et al. use the Java
code summa- migration task. In their paper, they show that the BLEU
metric rization dataset of LeClair et al. \[30\]. They randomly sample
383 has a rather weak correlation of 0.583 with the human assessment.
snippets from it and generate five summaries with different models. 2
CodeParrot's page on HuggingFace:
https://huggingface.co/codeparrot/codeparrot Human annotators then
evaluate the five generated summaries and Conference'17, July 2017,
Washington, DC, USA Mikhail Evtikhiev, Egor Bogomolov, Yaroslav Sokolov,
and Timofey Bryksin

                                                Table 1: Comparison of various code generation papers

                                       Paper                   NN type                      Metrics                    Year
                              Barone et al. [11]         NMT                   BLEU                                    2017
                              Chen et al. [2]            Transformer           BLEU, Pass@k                            2021
                              CodeParrot                 Transformer           Pass@k                                  2021
                              AlphaCode [28]             Transformer           Evaluation on Codeforces                2022
                              Ling et al. [10]           RNN                   BLEU, Accuracy                          2016
                              Lu et al. [13]             RNN, Transformer      BLEU, Accuracy, CodeBLEU                2021
                              Rabinovich et al. [23]     RNN                   BLEU, Accuracy, F1                      2017
                              Ren et al. [15]            PBSMT, Transformer    BLEU, Accuracy, CodeBLEU                2020
                              Sun et al. [4]             CNN, RNN              Accuracy, BLEU                          2019
                              Wei et al. [26]            RNN                   BLEU, Percentage of valid code          2019
                              Yin et al. [3]             RNN                   BLEU, Accuracy                          2017
                                                                               Execution accuracy,
                              Yin et al. [5]             RNN                                                           2018
                                                                               exact match accuracy
                              Yin et al. [6]             RNN                   BLEU, Accuracy                          2019

the reference summary on a five-point Likert scale to assess the them.
Then, they add them to the five original models and do a conciseness,
fluency, and content adequacy of each summary. They pairwise comparison
into several different buckets based on the also assign a Direct
Assessment (DA) score on a 0--100 scale that statistical significance of
the metric score difference as well as of reflects their opinion about
the general quality of a summary. Only the difference magnitude. The
bucket can be defined, for example, the Direct Assessment score is used
to analyze the relative metric for statistically significant metric
differences between two and five. performance. For each of these pairs,
Roy et al. also calculate the significance of the difference in their
corresponding human DA scores. The 2.3.2 Corpus-level metric assessment.
The corpus-level assessment effectiveness of a corpus-level metric can
then be determined by of metrics applicability by Roy et al. pursues two
slightly different looking at the agreement between the metric score and
human goals. First, the authors are interested in whether the metrics
are assessment score. For a reliable automatic evaluation metric, one
capable of distinguishing the quality of the existing models. To expects
to find a one-to-one correspondence between significant do that, they
carry out randomized significance testing on the differences in metric
scores and human assessment scores. 383-snippet dataset to find that out
of five models considered in Using the pairwise comparison approach, Roy
et al. are able to the study, the difference in scores of the best five
models is not analyze the following: statistically significant. It is
important to highlight that this lack of statistical difference was
found solely from the metric scores and • They find for how many pairs
in a given bucket the two does not rely on human labelling. models in
the pair are significantly different, according to The second goal for
the corpus-level metric assessment is to find each metric. This allows
to deduct what difference in the whether the commonly used corpus-level
metrics reflect human metric scores of two models outputs is necessary
to expect quality assessments of generated summaries. There is a
relative so that the two models will also be significantly different
shortage of available machine learning models (Roy et al. used five from
the metric's point of view. code summarization models in their study).
Thus, it is impossible to • For each bucket and for every metric, they
consider the study directly what difference in metric scores is
necessary to claim group of pairs, in which one model is significantly
better that one model is better than the other according to humans --
there than the other according to the metric. Then, for each pair, are
not enough pairs of models to get enough data on the differences they
check whether the two models in it are also significantly in model
scores. However, if there were many more independent different,
according to the human assessment. This allows models, the researchers
would have to label much more model them to study the Type-I error of
each metric and check how outputs, increasing the cost and laboriousness
of the study. In order it changes from bucket to bucket. to get more
diversity in metric scores without increasing the number • For each
bucket and for every metric, they consider the of summaries to label,
Roy et al. use synthetic models. group of pairs, in which the two models
are not significantly A synthetic model is a model that yields a set of
summaries different, according to the metric. Then, for each pair from
based on one of the five original models, with a varying proportion this
group, they check whether the two models in it are of summaries replaced
by the predictions of the other models. In significantly different,
according to the human assessment. particular, to create a synthetic
model that improves the original This allows them to study the Type-II
error of each metric model A by 1%, the authors replace 1% of the
summaries predicted and check how it changes from bucket to bucket. by
the model by the better predictions of other models. The quality From
this analysis, Roy et al. find that automatic evaluation of the
prediction is assessed according to the human DA score. metrics are not
able to accurately capture the differences in summa- Roy et al. create a
set of synthetic models and then select 100 of rization quality between
two approaches when the metric difference Out of the BLEU: How Should We
Assess Quality of the Code Generation Models? Conference'17, July 2017,
Washington, DC, USA

is less than two points. METEOR, BERTScore, and ChrF perform the to the
correct solution. For example, for a problem "Get rid of None best in
terms of Type-I and Type-II error rate. BLEU has the highest values in
dictionary d" and two pieces of code presented below the Type-I error
rate regardless of the magnitude of the difference. first piece is much
closer to the right solution, even though it still does not pass the
tests. 2.3.3 Snippet-level analysis. Roy et al. also consider the metric
performance for the snippet level. In principle, snippet-level metric 1.
print(dict((k,v) for k,v in d.items() if v))) result analysis can
provide an advantage over corpus-level analysis 2. list(d.values()) by
tracking fine-grained performance of the models. To carry out Thus, it
is important to be able to evaluate the quality of generated the
snippet-level analysis, Roy et al. use the Direct Assesment code
snippets even if they do not pass the tests, as developers might
Relative Ranking technique, which compares the pairwise relative find
some generated snippets easier to fix and integrate into their scores of
two snippets \[31\]. This technique relies on the Direct code.
Assessment scoring and cannot be applied to the annotations on the
five-point scale. 3.2 Are Existing Metrics Suitable for Code Generation?
3 MOTIVATION Machine translation metrics were developed for natural
languages Metrics are used during the validation phase of a machine
learn- and do not take into account the properties of programming lan-
ing pipeline and to compare different models. However, if human guages.
The usage of such metrics might be sub-optimal for the assessment is the
golden standard, the used metric should align code generation assessment
due to several factors. with the human judgement as closely as possible.
For example, in machine translation, there is an annual contest between
various 3.2.1 Differences between programming and natural languages.
Pro- metrics, with the best metric being the one that emulates human
gramming languages have a strict syntactic structure, while the
judgement the best \[31, 32\]. natural language structure is more
relaxed. For example, while Even if some metric (such as BLEU) has been
used in the past to swapping two groups of tokens in a natural language
sentence of- emulate human judgement, it may be beneficial to consider
other ten does not strongly affect its meaning, such a transformation
will metrics which may have better correlation with human assessments.
often make a code snippet invalid. Secondly, machine translation A
similar situation has emerged in the natural language generation: (MT)
metrics measure the lexical precision of the model output, even though
BLEU was initially adopted to this domain, it was later while for the
generated code we want to assess its functionality. shown that
word-overlap based metrics (such as BLEU) have very It is possible to
make MT metrics somewhat more code-friendly, low correlation with human
judgement in certain natural language e.g., it is possible to rename all
the variables in the candidate and generation tasks such as dialog
response generation \[33\]. the references according to their order of
appearance, removing the In the rest of this section, we discuss in
detail why studying spurious mismatch due to the different naming
conventions. Yet, the automated metrics for code generation is important
and which some issues cannot be apparently addressed without taking code
questions are worth being answered in this regard. structure into
account. It is therefore plausible that a metric that will take into
account the code snippets' structure and syntax will 3.1 Metrics and
Test-based Evaluation be a better proxy of the human assessment. With
the recent introduction of HumanEval \[2\], a dataset that allows 3.2.2
BLEU has been outperformed in other tasks. Human assess- running and
testing generated Python code in a close-to-practical ment is the best
option for evaluating quality of a code generation setting, it might
seem that the usage of automated metrics will soon model and is
considered to be ground truth in metrics evaluation in become obsolete.
However, we think that it will not be the case in many different tasks,
see e.g. \[34\]. However, as human evaluation is the near future. very
expensive, it is obviously impossible to have every new output Firstly,
collecting test-based evaluation datasets requires signifi- of the model
evaluated by a group of programmers. A priori, it is un- cant human
effort to develop a set of tasks as well as cover them clear whether
BLEU or any other metric scores are correlated well with tests. Given
that the code generation task can be formulated with the human
assessment for the code generation task. Original differently and
applied to different languages and domains, each papers for machine
translation metrics \[14, 19--21\] include studies particular case
requires a separate manually crafted evaluation sys- that show a high
correlation between the metrics scores and the tem. Thus, the usage of
automated metrics is helpful when adopting human judgement for the
machine translation task. However, a code generation in new domains.
review by Reiter \[34\] shows that the BLEU--human correlations are
Secondly, training and inferencing very large models such as poor for
natural language generation tasks and BLEU should only Codex is both
costly and technically challenging \[2\]. For this reason, be used to
evaluate machine translation NLP systems. an important direction of
research is the development of smaller For the closely related problem
of code migration, it was shown code generation models which cannot yet
achieve the quality com- that the correlation between BLEU scores and
human grades is parable to large Transformer-based counterparts. For
smaller mod- 0.583, which is rather weak \[16\]. There is also a study
on the metric- els, evaluation frameworks like HumanEval would lead to
poor human correlation for BLEU, accuracy, and CodeBLEU metrics \[15\],
metric scores, and their robustness for model comparison in this which
has shown that the CodeBLEU metric is better correlated with case
remains an open question. human opinion than accuracy or BLEU. However,
this study did Finally, even if two models generate code that does not
pass any not consider other metrics. Finally, Roy et al. \[17\] did an
extensive tests, it still might be possible to say which piece of code
is closer study on the applicability of the automated metrics for the
code Conference'17, July 2017, Washington, DC, USA Mikhail Evtikhiev,
Egor Bogomolov, Yaroslav Sokolov, and Timofey Bryksin

summarization problem, to find that the de-facto standard BLEU 4
METHODOLOGY metric is one of the worst metrics for assessing code
summarization The problems we list in Section 3 have motivated us to
pose the models out of the six metrics they considered. following
research questions: All these observations highlight that the
applicability of a partic- RQ1 Does the performance of the considered
models differ signif- ular metric strongly depends on the problem. Thus,
using a metric icantly on the corpus level? that successfully works for
one problem for another problem may RQ2 How significant are the results
of automated metrics and how be unwarranted. big should be the
difference in corpus-level metric scores of 3.2.3 Translation from
metrics to human assessment. It is unclear two models to claim that one
model is better (according to the that an increase in a metric score is
linearly related to the increase given metric) than the other with
predefined significance? of the "true" quality of the code snippet. For
an illustration, let us RQ3 How well do the corpus-level metric scores
reflect the human consider one of the tasks in the CoNaLa dataset:
assessment of generated code? Task: concatenate a list of strings \['a',
'b', 'c'\] Inspired by the work of Roy et al. \[17\] described in detail
in baseline model solution: set(\['a','b','b'\]) Section 2.3, the
pipeline of our approach is as follows: best-tranx-rerank solution:
''''''.join(\['a','b','c'\]) 1. We collect the models' output on the
datasets we consider. Even though the baseline snippet fails to solve
the task question 2. We evaluate automated metrics on the generated code
snip- (and didn't even manage to reproduce the list of strings that need
pets, getting every metric score for every generated snippet. to be
concatenated), it has a relatively high BLEU score of 48.09. 3. We carry
out a human evaluation of the generated snippets The second snippet
successfully solves the problem and has a BLEU (described below in more
details), collecting a set of human score of 100. grades for every
generated snippet. Now, let us consider hypothetical outputs of two
different mod- 4. Using the obtained set of human grades, we get the
"ground els A and B. Both outputs have BLEU 50, but for model A every
truth" human grade by aggregating the grades together with candidate has
BLEU 50 and is of quality similar to the one above, the M-MSR algorithm
\[35\], getting a single grade for each while for model B, half of the
candidates have BLEU zero and the snippet evaluated by the experts. We
use the realization of other half have BLEU 100. In this case, it may be
argued that model the M-MSR algorithm by Ustalov et al. \[36\]. B is
better than model A, even if they have close corpus-level BLEU 5. Using
the models' output, we create synthetic models by scores: given the
example above, model A can generate hardly rel- replacing some of the
predictions with the predictions that evant code snippets all the time,
while model B generates perfect received higher or lower human
assessment score. For ex- code in half of the cases. ample, to get a
synthetic tranx-annot model with 1% of If the dependency between human
assessment and metric values predictions improved, we consider its
outputs and replace is not linear, we cannot simply average the metric
values over all the 1% of its worst predictions with the best
predictions available snippets to reflect the human assessment of the
model. In addition, from other models. The quality of a prediction is
derived there might be other reasons why BLEU scores and human scores
from the human assessment score. might not correlate well, and it is
necessary to study the correlation 6. For every pair of both synthetic
and non-synthetic models between the two to be able to infer the
knowledge how to interpret evaluated on the same dataset, we carry out
paired bootstrap BLEU scores and assess the models' quality from them.
resampling. We do that to find the statistical significance of the claim
that one of the models is better than the other 3.3 Do We Use Automated
Metrics Correctly? according to the metric scores. We use a 95%
threshold The common way of using automated metrics to assess models to
claim a statistically significant difference between the is to report a
single corpus-level number \[3, 5, 13, 23\]. While this models. approach
is simple and might be very practical during the training 7. For each
dataset evaluated by humans and for every pair process, it is unclear
how the raw difference in metric scores can of models evaluated on it,
we carry out paired bootstrap be translated into statements on the
statistical significance of the resampling on the ground truth grades.
We use the statistical difference. test results to check with what
statistical significance we In the code generation domain, comparison of
different models is can infer that one of the models is better than the
other usually done by simply comparing their BLEU or CodeBLEU scores,
according to the human opinion. averaged over the entire test dataset
(see e.g., \[3, 5, 13, 23\]). However, 8. Following Mathur et al. \[22\]
and Roy et al. \[17\], we carry out a when an improvement from e.g., the
BLEU score of 29 to the BLEU pairwise model comparison of human
assessment and corpus score of 30 is claimed, it is rarely supported by
data on the statistical level metrics for CoNaLa and Hearthstone
datasets. We start significance of the improvement. As Roy et al. \[17\]
have shown, for by computing the difference in corpus-level metric
scores for the closely related code summarization task, small
differences in all pairs of models evaluated over the given dataset. We
then metric scores are statistically insignificant, it is possible that
the divide these model pairs into several buckets according to the same
phenomenon exists for code generation. difference in the metric scores;
we also have an extra bin for Therefore, it is important to study how
big the difference between the pairs which metrics cannot distinguish.
For each of the the metric scores of two models for a particular dataset
should be pairs in every bin, we check if the human evaluation agrees to
claim that one of the models is better than the other with the with the
metric evaluation, i.e., whether humans distinguish desired confidence.
the pair of models or not. Out of the BLEU: How Should We Assess Quality
of the Code Generation Models? Conference'17, July 2017, Washington, DC,
USA

Generate Computing Evaluating Aggregating Creating Bootstrap on
Bootstrap on Assessing code metrics by humans human grades synthetic
models metrics human grades metrics

                                      Figure 1: A high-level description of the pipeline of our approach.

It would be interesting to carry out a comparative analysis of metrics •
The best performing models evaluated on the CoNaLa dataset on the
snippet level. However, Mathur et al. \[22\] argued that it is have BLEU
scores around 30, allowing to have generated necessary to collect at
least 15 human assessments per snippet in test snippets of both high and
low quality. For example, the order to provide a stable score and
analyze metrics performance best model evaluated on the Docstrings
dataset has BLEU on the snippet level. As we were able to collect four
grades per 12.1, which corresponds to a majority of the snippets being
snippet for the Hearthstone dataset and 4.5 grades per snippet for low
quality, making it harder for human graders to reliably the CoNaLa
dataset, we opt not to analyze metric performance on distinguish between
them. the snippet level. • The CoNaLa snippets are generally very short,
with the absolute majority of them being a single line of code. It
limits 4.1 Datasets and Models the possible usability of the CodeBLEU
and RUBY metrics In our study, we consider two different datasets:
CoNaLa \[12\] and that take code structure into account. Card2code
Hearthstone \[10\]. We focus on the datasets contain- We evaluate five
models on the CoNaLa dataset. One of the ing general Python code,
leaving the non-Python datasets such as models we consider is the
baseline CoNaLa model \[12\], another is Spider (containing SQL) \[7\]
and JuICe (containing Jupyter Note- Codex \[2\], and three others are
Transformer-based tranX models. books) \[37\] out of the scope. We also
leave out the CodeXGLUE The tranx-annot model was trained on the main
CoNaLa dataset; dataset \[13\], since the code to text problems in
CodeXGLUE dataset best-tranx was also pretrained on the larger
automatically-mined come from the Concode dataset \[38\], which is
focused on the Java version of CoNaLa before being trained on the main
CoNaLa dataset; code. Given the high popularity the CodeXGLUE dataset
has gained best-tranx-rerank is the enhanced version of the second model
as of late, it would be interesting to extend our research later to that
uses reranking postprocessing (i.e., reranking the 𝑛-best predic- this
dataset. tions to increase the quality of the output). For each of these
models, For both datasets, we use the models suggested by authors in we
use the standard setup as provided in the replication package. previous
works. We employ the original implementations, hyper- Finally, we run
Codex \[2\], specifically, its davinci version, in the parameters,
and---if possible---the original trained weights or the Q&A mode.
Following the authors' recommendations, we do not code generated by the
model as provided by the authors. fine-tune Codex on the CoNaLa training
part and rather provide it with three code snippets as examples. That
is, each code snippet 4.1.1 CoNaLa. The CoNaLa dataset was collected by
Yin et al. \[39\] is generated via OpenAI Q&A API for Python code
generation, and consists of 2,879 examples (split into 2,379 training
and 500 test and three intent-snippet pairs are provided as the
examples. It is examples), crawled from Stack Overflow and then manually
curated important to highlight that the exact setup of the models (such
by human annotators. In addition to the main dataset, Yin et al. also as
hyperparameter choice or configuration) is not crucial for our provide a
large automatically-mined dataset that consists of Stack study, since we
do not try to estimate which model is objectively Overflow "how to"
questions as training intents and contiguous better, but focus on
studying the metrics evaluation of the outputs lines from code blocks in
answers as candidate implementations of code generating models. Thus,
the only non-trivial requirement for the intent. This dataset has more
than a hundred thousand the outputs should satisfy is that different
models should produce examples. Some of the models that we consider use
it for training. snippets of varying quality for the same problem
formulation (so The CoNaLa dataset has the following features: that it
is possible to create synthetic models of significantly different • The
CoNaLa dataset has a sound variety of intents that cover quality). many
methods used in Python (as compared to, e.g., the Card2Code dataset
\[10\], which is dedicated to the generation 4.1.2 Card2Code
Hearthstone. Card2Code is a pair of datasets de- of classes with very
rigid structure). rived from the collectible trading card games Magic
the Gathering • Intents in the CoNaLa dataset are detailed and written
in and Hearthstone; in our research, we focus on the Hearthstone natural
language, which distinguishes it from, e.g., the Doc- dataset as it is
more popular among the researchers. The Hearth- strings \[11\] dataset,
where the intents are rather short and stone dataset contains 665 pairs
of Hearthstone card descriptions in many cases a human programmer would
have problems and corresponding Python snippets. Each snippet is a class
im- with writing the correct code given only the intent. plementation
that can be used in the Hearthbreaker Hearthstone • There is a
relatively rich choice of the publicly available simulator \[40\] to
describe the card's logic. The dataset is split into models that were
evaluated on this dataset (as compared to 533 training pairs, 66
validation pairs, and 66 test pairs. The Hearth- the other datasets),
enabling us to have more comparisons. stone dataset has the following
features: Conference'17, July 2017, Washington, DC, USA Mikhail
Evtikhiev, Egor Bogomolov, Yaroslav Sokolov, and Timofey Bryksin

      • As the intents are the descriptions of Hearthstone cards that     4.3    RQ2: Significance of the Automated
        should adhere to the Hearthbreaker notation, the generated               Metrics’ Scores
        code has a relatively rigid structure.
                                                                          To address RQ2, we consider the significance of difference in metric
      • The code generation problem is very peculiar: every task
                                                                          scores for various pairs of the models. We expect that the signifi-
        requires the model to generate a class. The snippets have very
                                                                          cance of difference in metric scores will vary with the difference in
        similar outline, and the difference between various snippets
                                                                          scores (so that for a pair of models with BLEU scores of 20 and 80,
        is limited: each snippet is a class inherited from one of three
                                                                          it is more likely that one of the models will be better than the other,
        parent classes (MinionCard, SpellCard and WeaponCard).
                                                                          as compared to the pair of models with BLEU scores of 29.5 and 30).
        Almost every snippet has exactly two methods: a constructor
                                                                          Thus, we follow Roy et al. [17] and split the pairs of models into the
        and a method with the name depending on the parent class
                                                                          bins according to the difference in the scores. The bin composure
        (use for SpellCard, create_weapon for WeaponCard). Thus,
                                                                          ([0, 1), [1, 2) etc.) is slightly different for Hearthstone and CoNaLa
        the generality of the conclusions we may infer from the
                                                                          dataset. It was determined empirically to have similar number of
        results is limited.
                                                                          pairs in every bin. We strive to have a comparable number of pairs
      • The generated code is relatively long and complex, allowing
                                                                          in every bin in order to have a significant number of pairs in every
        application of the CodeBLEU and RUBY metrics that take
                                                                          bin, so that it is possible to draw statistically robust conclusions.
        the underlying code structure into account.
                                                                              We augment our set of original ML models with the synthetic
                                                                          models built according to the approach of Roy et al. [17]. We build
                                                                          the synthetic models’ outputs from the outputs of real models.
                                                                          There are several reasons why we use synthetic models:

There are only two publicly available models that are evaluated on the
Hearthstone dataset. One of the models is a syntactic neu- (1) There is
a relative scarcity of available models. In the best ral model NL2code
\[3\], and another is a grammar-based structural case of the CoNaLa
dataset, we only have five models of var- convolutional neural network
GCNN \[4\]. For NL2code, we use the ious quality, which may not provide
enough data to assess outputs of the model provided by the authors, and
for GCNN we use the metrics applicability. The usage of syntactic models
al- standard setup as provided in the replication package, but limit
lows us to cover a much more diverse range of metric values training to
30 epochs since the standard setup of 1000 epochs (as without training
many new models. written in the replication package) was unfeasible with
our com- (2) Even if there was a great variety of models so that there
putational resources. The pre-trained Codex model was evidently would be
enough data points for proper metric comparison, familiar with the
dataset since it provided reference snippets as an it would require
immense investment in labeling the data. For output, so we did not
consider it. In particular, without a tight limit example, in this
research, we study outputs of 85 models in on the number of generated
tokens, Codex successfully generated total (which includes both original
and synthetic models) just several classes from the testing dataset in a
single run. This suggests for the CoNaLa dataset, with each of the
outputs consisting that Codex is capable of reproducing entire files
that it has seen of 472 snippets. If all 85 models were independent, it
would during training, including the ones from the Hearthstone dataset.
require people experienced in Python to label more than To check the
significance of the difference in the metric scores, 40,000 snippets. As
we deem it necessary to collect at least we use paired bootstrap
resampling \[18\] for the metric scores of three scores for every
snippet, such a procedure would be the models evaluated on the test part
of the dataset. prohibitively hard or expensive. (3) Improving or
worsening the model scores results in a set of synthetic models with the
metric and human scores relatively close to each other. This allows us
to compare many models with relatively close scores and check the
significance of 4.2 RQ1: Corpus-level Model Performance relatively small
differences in them. This is relevant to the To address RQ1, we compare
the significance of metric score differ- researchers and practitioners,
since the improvements over ences on the corpus level. For the metrics
which define corpus-level the state-of-the-art models often come in
small increments. scores as an aggregate of snippet-level scores, it is
possible to use techniques such as Wilcoxon sign-rank test \[41\] to
compare the 4.3.1 Building Synthetic Models. We create a synthetic model
by models. However, there are metrics like BLEU which are corpus-
starting with the outputs of some of the original models and re- level
by design, so that simple averaging of per-snippet scores over placing
X% of its worst-rated snippets with the best-rated snippet the corpus
does not give corpus-level metric score (see appendix A.1 for the
problem. The quality of the snippet is assessed according to for more
details). Thus, the Wilcoxon test is not applicable in this the human
evaluation scores. If the picked snippet is already the case. This
restricts us to using randomized significance testing best-rated
snippet, it is skipped. The reverse procedure is applied for comparing
corpus level scores, which is a common practice in for synthetically
worsened models. We continue the replacement the machine translation
community \[42\]. According to Graham et procedure until X% of snippets
is changed or there are no more al. \[42\], there is little practical
difference between using bootstrap, snippets left to change. paired
bootstrap and approximate randomization to test signifi- Following Roy
et al. \[17\], we consider eight different proportions cance. We choose
paired bootstrap resampling to test significance. for the replacements:
replacing 1%, 3%, 5%, 10%, 15%, 20%, 25%, and To test for statistical
significance, we take 1000 bootstrap samples. 30% of the generated
snippets. Our replacement proportions are Out of the BLEU: How Should We
Assess Quality of the Code Generation Models? Conference'17, July 2017,
Washington, DC, USA

identical to those of Roy et al. with a slight variation: we replace 3%
2: The snippet is somewhat helpful, it requires significant changes of
the dataset instead of 2% replaced by Roy et al. This procedure
(compared to the size of the snippet), but is still useful. yields 5×8×2
= 80 synthetic models for CoNaLa and 2×8×2 = 32 3: The snippet is
helpful but needs to be slightly changed to synthetic models for the
Hearthstone dataset. Then, we add the solve the problem. original models
and deduplicate them by throwing out models with 4: The snippet is very
helpful, it solves the problem. fully identical outputs. This leaves us
with 81 models for CoNaLa The graders did not have to evaluate all
snippets in the dataset and and 29 models for Hearthstone that we use
for our analysis in RQ2. could stop at any moment. We consider all
pairwise combinations of the models (both synthetic and original) and do
the paired difference test for every metric. 4.4.3 The CoNaLa Dataset.
For the CoNaLa dataset, there were 2,860 snippets to evaluate: 5×472
snippets generated by the models 4.4 RQ3: Agreement Between Metrics and
plus 500 reference snippets (for some of the intents the dataset Human
Evaluation contains more than one reference snippet). 16 participants
took To address RQ3, we assess the degree of agreement between the part
in our survey, and on average, we received 4.49 grades per human
assessment and metric scores on the corpus level. In order to
model-generated snippet. Figure 2 shows the distribution of the do so,
we carry out corpus-level significance tests to check whether number of
grades. Three of the graders have less than two years of the metric and
the human prediction agree for every pair of models. experience with
Python, six have two to three years of experience, Similarly to the
previous research question, we utilize both original and seven are
programming in Python for four or more years. We and synthetic models we
used in RQ2. have recruited graders from the ranks of our colleagues and
through posts in our scientific Twitter accounts. At the moment of
grading, 4.4.1 Bins for the Corpus-level Assessment. There are several
op- all the graders were doing research in the computer science software
tions for disagreement between human assessors and a metric for
engineering domain. a given pair of models A and B: • When A is better
than B according to the metric, but the models are equivalent according
to human assessors (Type-I error). 1000 • When models A and B are
equivalent according to the metric, but one of the models is better
according to human assessors 800 (Type-II error). Number of snippets

      • When model A is better than model B according to the metric,
                                                                                                     600
        but according to the human assessors, model B is better than
        model A (Type-I error).
                                                                                                     400

We consider all pairwise combinations of the models (both synthetic and
original) and do paired difference tests for the human and the 200
metric assessments. Using the aggregated human scores as ground truth,
we quantify Type-I and Type-II errors of the metric. As we 0 expect that
the probability of a metric to make an error for a pair 3 4 5 6 7 8 9 10
of models depends on the difference of the models' scores, we Number of
graders who graded the snippet

divide the data on the metric errors into several bins. The NS bin
corresponds to the cases where the difference in the model scores Figure
2: Distribution of the number of grades per snippet. is insignificant,
according to a given metric. All errors in this bin are Type-I errors.
Other bins correspond to the cases where the difference in the model
scores is significant, according to the metric. The bin composure for
RQ3 is identical to the one we choose for 4.4.4 The Hearthstone Dataset.
Similarly to the CoNaLa dataset, the RQ2. we also ran a survey in which
programmers evaluated code snippets. The snippets were presented one by
one along with the Hearth- 4.4.2 Human Evaluation. To get the human
assessment of the con- stone card images, and the graders assessed
whether the snippet sidered models, we created a survey, in which we
asked program- represents the card correctly. Figure 3 shows an example
of a card mers to evaluate code snippets. The snippets were presented
one by image along with the corresponding code snippet. one and were
randomly chosen out of the combined pool of snippets There were 198
snippets to evaluate: 2 × 66 snippets generated generated by the models
and reference snippets. The graders did by the models plus 66 reference
snippets. Four participants took not know the origin of each snippet.
The graders rated the snippets part in the survey, every participant has
graded all the snippets. on the scale from 0 to 4, with the following
grade descriptions: Two of the participants had three or more years of
experience of 0: The snippet is not at all helpful, it is irrelevant to
the problem. playing Hearthstone, and two other participants have
studied the 1: The snippet is slightly helpful, it contains information
rel- rules through videos and manuals. One of the graders had 1.5 years
evant to the problem, but it is easier to write the solution of
experience with Python, two had two years of experience, and from
scratch. one was programming in Python for four years. Conference'17,
July 2017, Washington, DC, USA Mikhail Evtikhiev, Egor Bogomolov,
Yaroslav Sokolov, and Timofey Bryksin

    class Archmage(MinionCard ) :                                        1,000 resamplings; 𝑋 −𝑍
                                                                                              +𝑌 should be read as “95% of the resampled
        def __init__ (self) :                                            models yielded score in the [𝑋 − 𝑍, 𝑋 + 𝑌 ] range”.
            super().__init__("Archmage", 6,                                 The BLEU metric failed to recognize the difference in qual-
            CHARACTER_CLASS.ALL, CARD_RARITY.COMMON)                     ity between Codex and best-tranx-rerank, and between Codex
                                                                         and best-tranx. The RUBY metric failed to recognize the differ-
         def create_minion (self, player) :                              ence in quality between any of the following three models: base-
             return Minion(4, 7, spell_damage = 1)                       line, tranx-annot, and best-tranx. The CodeBLEU metric failed
                                                                         to recognize the difference in quality between any of the two
                                                                         models from the following ones: tranx-annot, best-tranx, and
                                                                         best-tranx-rerank models. For the five original models evaluated
                                                                         on the CoNaLa dataset the differences in either BLEU, RUBY, or
                                                                         CodeBLEU scores are not always statistically significant. This is
                                                                         important, since currently code generation models are evaluated
                                                                         with either CodeBLEU or BLEU, and the model scores are often
                                                                         provided without any data on the statistical significance.
                                                                         5.1.2 The Hearthstone Dataset. For the Hearthstone dataset, we
                                                                         only evaluate two different models available: a syntactic neural
                                                                         model NL2Code [3] and a grammar-based structural convolutional
                                                                         neural network (GCNN) [4]. We compute BLEU, ROUGE-L, ME-
                                                                         TEOR, ChrF, CodeBLEU, and RUBY scores for the outputs of these
                                                                         models, getting scores for each of the test snippets. The format
                                                                         in which we report the scores is the same as the format in which
                                                                         we presented CoNaLa scores. We trained the GCNN model for 30
                                                                         epochs, as there was no recommended number of epochs in the
                                                                         original paper [4], and the default value of 1,000 epochs is unfea-
                                                                         sible. This may be the reason why the GCNN model we trained
                                                                         performs relatively worse than NL2Code contrary to the results of

Figure 3: The Archmage card and the corresponding code the original
paper \[4\]. snippet According to the ROUGE-L, METEOR, and BLEU metrics,
the NL2Code model is better than GCNN with \> 95% confidence, see Table
5.

5 RESULTS We find that even for the non-synthetic models we consider on
the 5.1 RQ1: Corpus-level Model Performance CoNaLa and Hearthstone
dataset, the improvement in metric scores may be superficial and
statistically insignificant. This highlights 5.1.1 The CoNaLa Dataset.
The test part of the CoNaLa dataset the necessity to test the
significance of the improvement in models' consists of 500 reference
snippets, but some of the intents ap- quality for the code generation
task. pear more than once, so in total, there are 472 unique intents.
Different references corresponding to the same intent, were ac- counted
for as parts of the references corpus. We consider five 5.2 RQ2:
Significance of the Automated different models trained on the CoNaLa
dataset: baseline CoNaLa Metrics' Scores (baseline), tranX trained on
the main dataset (tranx-annot), the 5.2.1 The CoNaLa Dataset. In Table
3, we present the data on the best version of tranX by Yin et al. \[5\]
with pretraining on the non- significance of differences in model
scores. For every pair of models, cleaned version of CoNaLa and without
reranking (best-tranx), we compute the difference in their scores,
according to each of the the best version of tranX with the same
pretraining and rerank- metrics we consider and check whether the
difference is significant, ing (best-tranx-rerank) \[6\], and Codex
\[2\]. We compute BLEU, according to the paired bootstrap resampling
procedure. Every ta- ROUGE-L, METEOR, ChrF, CodeBLEU, and RUBY scores
for the ble cell contains the number of model pairs that correspond to
the outputs of these models (getting scores for each of the test snip-
metric and difference mentioned in the row and column, respec- pets).
Table 2 shows metric values for all the models on the CoNaLa tively. For
example, there were 192 pairs of models with a difference dataset. in
BLEU scores in the \[0, 2) range, for which this difference was
Alongside the automated metrics, we report the aggregated as-
significant. We split the possible scores into four different bins---
sessor scores (see row Human in Table 2). We convert all the metrics
\[0, 2), \[2, 5), \[5, 10), \[10, 100)---and put every pair of models
into to the 0--100 scale by multiplying with an appropriate factor: we
the corresponding bin. The results show that with the exception of
multiply assessor scores by 25 and multiply automated metric scores the
BLEU metric, if the difference in metric scores of two models by 100, if
the metric scores are in the \[0, 1\] span. Together with the is larger
than two points, then it is possible to claim with at least scores, we
report confidence intervals for each of the metrics. The 95% confidence
that the difference is significant. The data on the confidence intervals
were computed with the aid of bootstrap over confidence of the
difference significance can be obtained directly Out of the BLEU: How
Should We Assess Quality of the Code Generation Models? Conference'17,
July 2017, Washington, DC, USA

                                                        Table 2: Metric results for the CoNaLa dataset.

                                                   baseline        tranx-annot            best-tranx         best-tranx-rerank             Codex
                           BLEU                   12.37+−11..59
                                                             46       28.58+−33..18
                                                                                 06       31.48+−32..01
                                                                                                     98          33.14+−22..91
                                                                                                                            94           33.04+−33..24
                                                                                                                                                    14
                           ROUGE-L                36.51+−11..41
                                                             46       49.22+−11..79
                                                                                 69       51.47+−11..87
                                                                                                     90          52.83+−11..96
                                                                                                                            84           56.52+−22..25
                                                                                                                                                    29
                           ChrF                   17.51+−11..26
                                                             26       28.30+−11..66
                                                                                 79       31.14+−11..89
                                                                                                     85          32.67+−21..10
                                                                                                                            95           42.84+−22..68
                                                                                                                                                    54
                           METEOR                 28.43+−11..54
                                                             54       44.03+−22..18
                                                                                 03       46.55+−22..28
                                                                                                     30          48.32+−22..43
                                                                                                                            38           50.66+−22..66
                                                                                                                                                    49
                           RUBY                   43.32+−11..99
                                                             84       43.52+−11..92
                                                                                 93       44.81+−22..00
                                                                                                     00          46.26+−21..03
                                                                                                                            97           57.70+−22..24
                                                                                                                                                    24
                           CodeBLEU               30.97+−11..67
                                                             47       33.02+−11..57
                                                                                 62       34.07+−11..67
                                                                                                     63          34.33+−11..69
                                                                                                                            65           46.58+−22..64
                                                                                                                                                    47

                           Human                  8.74+−11..80
                                                            64        26.69+−32..44
                                                                                 91       35.22+−33..23
                                                                                                     28          40.10+−33..70
                                                                                                                            39           59.85+−33..50
                                                                                                                                                    50


                       Table 3: Significance for the corpus-level metrics score difference on the CoNaLa dataset.

                                                    Delta: [0, 2)                 Delta: [2, 5)            Delta: [5, 10)           Delta: [10, 100)
                                              Significant          NS           Significant     NS        Significant    NS         Significant     NS
                         BLEU                        192           398             732           42          893          0            1064          0
                         ROUGE-L                     252           296             736           0           1023         0            1014          0
                         ChrF                        253           212             633           1           922          0            1300          8
                         METEOR                      195           324             699           7           914          0            1182         48
                         RUBY                        235           437             828           9           972          0             840          0
                         CodeBLEU                    382           474             895           6           857          0             707          0

                                   Table 4: Corpus-level metrics disagreement rate on the CoNaLa dataset.

                            Delta: [0, 2)                 Delta: [2, 5)               Delta: [5, 10)          Delta: [10, 100)             Delta: NS             Total
                                                                                                                                                               mismatch
                       Mismatches       Pairs        Mismatches        Pairs      Mismatches      Pairs     Mismatches      Pairs     Mismatches       Pairs
         BLEU              2.7%             187          15.1%            747         12.0%        890         0.6%         1070         85.5%         427      17.95%
         ROUGE-L           6.7%             254          12.0%            740         3.7%         1016          0          1018         72.0%         293      10.69%
         ChrF              5.2%             248          16.2%            627         2.8%         923           0          1305         64.7%         218      8.49%
         METEOR            4.7%             190          14.8%            694         9.3%         914           0          1187         81.5%         336      14.18%
         RUBY              6.6%             213          21.0%            837         4.7%         965           0           838         85.9%         468      19.21%
         CodeBLEU          6.0%             382          9.4%             896         5.8%         842           0           715         80.9%         486      16.53%


     Table 5: Metric results for the Hearthstone dataset.                                       model pairs, for which the difference in scores was not statistically
                                                                                                significant. The results also show that if the difference in scores of
                                     gcnn               nl2code                                 two models is less than two points, it is impossible to claim that one
                                                                                                of the models is better without carrying out additional statistical
               BLEU               69.20+−66..52
                                             29       74.52+−66..20
                                                                 03                             tests. Moreover, if the difference in BLEU scores is less than five
               ROUGE-L            84.71+−33..53
                                             50       86.54+−33..05
                                                                 18                             points, additional statistical tests are necessary to claim that the
               ChrF               80.76+−44..21       80.60+−33..87                             difference is significant.
                                             35                  78
               METEOR             75.18+−55..72
                                             60       79.64+−54..35
                                                                 98                             5.2.2 The Hearthstone Dataset. Table 6 presents the dependence
               RUBY               85.82+−33..71       85.56+−33..48                             between the difference in model scores according to the metrics and
                                             74                  69
                                                                                                their ability to determine which model is better with at least 95%
               CodeBLEU           71.59+−65..24
                                             84       72.35+−55..73
                                                                 57                             confidence. The results show that for the Hearthstone dataset, the
               Human              65.53+−66..44       68.18+−55..68                             difference in scores of less than two points according to any metric
                                             44                  68                             makes it impossible to claim that one of the models is significantly
                                                                                                better without additional statistical tests. For the adopted by the
                                                                                                community BLEU and CodeBLEU metrics—and only for them—it is

from the table: for every bin-metric pair the confidence is given
impossible to claim that one of the models is significantly better if by
𝑆/(𝑆 + 𝑁 𝑆). Here 𝑆 is the number of model pairs, for which the
difference in model scores is less than four points. Similarly to the
difference in scores was significant, and 𝑁 𝑆 is the number of our
results on the CoNaLa dataset, this finding highlights that the
Conference'17, July 2017, Washington, DC, USA Mikhail Evtikhiev, Egor
Bogomolov, Yaroslav Sokolov, and Timofey Bryksin

                    Table 6: Significance for the corpus-level metrics score difference on the Hearthstone dataset.

                                                   Delta: [0, 1)                  Delta: [1, 2)                  Delta: [2, 4)            Delta: [4, 100)
                                                 Significant       NS           Significant        NS          Significant     NS        Significant    NS
                          BLEU                       30             91              16             56              98           16          128             0
                          ROUGE-L                    58            138              67             35              137           0           0              0
                          ChrF                       71            134              90             33              99            0           8              0
                          METEOR                     21            144              22             33              159           8           48             0
                          RUBY                       60            164              76             73              62            0           0              0
                          CodeBLEU                   31            243              22            102              24           13           0              0

                                Table 7: Corpus-level metrics disagreement rate on the HearthStone dataset.

                            Delta: [0, 1)                 Delta: [1, 2)                  Delta: [2, 4)              Delta: [4, 100)             Delta: NS             Total
                                                                                                                                                                    mismatch
                        Mismatches      Pairs       Mismatches        Pairs        Mismatches        Pairs       Mismatches      Pairs     Mismatches       Pairs
         BLEU               3.7%            27         0.0%                16        24.4%                98        27.3%         128         81.9%         166      45.1%
         ROUGE-L            1.6%            64         7.7%                65        0.0%                137                       0          50.3%         169      20.9%
         ChrF               1.4%            73         27.2%               92        0.0%                 99         0.0%          8          59.5%         163      28.3%
         METEOR             5.9%            17         0.0%                22        18.9%               159        22.9%         48          74.6%         189      42.1%
         RUBY               2.6%            39         4.5%               110        3.0%                 66                       0          62.7%         220      33.6%
         CodeBLEU          15.2%            33          0.0               22         0.0%                 24                       0          75.0%         356      62.5%

small difference in the metric scores should be reported together number
of model pairs that correspond to the metric mentioned with the
statistical tests that prove the significance of the difference. in the
respective row and difference mentioned in the column. For example,
there were 187 pairs of models with a difference in BLEU Our findings
for the significance of the metric scores improvement scores in the \[0,
2) range, for which this difference was significant. extend the
observations we made in the previous section. We find The "Mismatches"
column lists the number of model pairs for which that for none of the
metrics we consider a score improvement of less the metric assessment
disagrees with the human evaluation. For than two points is sufficient
to claim a statistically signficant im- example, out of 187 model pairs
with a difference in BLEU scores provement without additional tests.
Moreover, the sufficient score in the \[0, 2) range for which the
difference was significant, for 2.7% improvement to claim a
statistically significant improvement for the the metric assessment did
not agree with the human assessment. community-adopted BLEU and CodeBLEU
metrics is even higher. For the disagreement rate of the corpus-level
metrics with the aggregated human scores, we can see the following:

5.3 RQ3: Agreement Between Metrics and 1. The metrics are not reliable
in determining that the difference Human Evaluation between the models
is not significant with an error rate being 5.3.1 The CoNaLa Dataset. We
also carry out human evaluation of above 60% for every metric we
consider, see column Delta: the CoNaLa dataset and compare it with the
results of automated NS. metrics. We computed the "ground truth" human
grade according 2. When the difference in metric scores is less than 5
points, no to the M-MSR algorithm suggested by Ma et al. \[35\]. metric
is reliable enough to emulate the human judgement For the non-synthetic
models, various metrics show different with at least 95% precision.
results in recognizing the significance of difference in the outputs' 3.
For the \[5, 10) bin of the metric scores difference only RUBY, quality
of the models. The human ground truth we obtained from ChrF and ROUGE-L
metrics are able to emulate the human the collected grades shows that
all the differences in the model judgement with at least 95% precision,
see column Delta: scores are significant. The ranking of the models is
as follows: Codex \[5, 10). \> best-tranx-rerank \> best-tranx \>
tranx-annot \> baseline. 4. It is possible to argue that out of the
metrics we consider, The results of the ChrF, ROUGE-L, and METEOR
metrics agree BLEU is the worst in emulating human judgement: even with
the human judgement (see Table 2), while BLEU, RUBY, and though it has
the second-highest total mismatch rate, it is CodeBLEU disagree with the
assessors for at least one pair of mod- the worst-performing metric for
the models with a score els. difference of more than five points, see
row BLEU. It is also We present the comparison of human assessment to
the auto- the only metric that sometimes disagrees with the human mated
metrics on the synthetic models in Table 4. Every column judgement for
the pair of models that have a score difference contains data on pairs
of models with statistically significant dif- of more than 10 points.
ference in the metric scores in the given range. The Delta: NS 5. RUBY
and CodeBLEU metrics, which were developed for column contains all pairs
of models, for which the difference in assessing code, do not perform
significantly better than the scores was not statistically significant.
Every table cell contains the metrics originating from the machine
translation domain. Out of the BLEU: How Should We Assess Quality of the
Code Generation Models? Conference'17, July 2017, Washington, DC, USA

       Moreover, they are among the least reliable in terms of total                  be explained by the bin selection that is different from the
       mismatch rate, see column Total mismatch.                                      one chosen for the CoNaLa dataset. Unfortunately, the bin
    6. All metrics have the highest incidence of Type-I errors for                    selection similar to the one done for the CoNaLa dataset
       the [2, 5) bin, that then decreases with the increase in scores                would be even less informative: for most of the metrics, the
       difference, see column Delta: [2, 5). This can be explained                    bins [5, 10) and [10, 100) would be virtually empty as the
       by the high mismatch rate in the NS bin, which consists of                     two non-synthetic models available for this dataset have
       pairs of models with generally small difference in scores. If                  relatively close quality.
       we do not consider the NS bin separately and aggregate the              The general recommendation for practitioners based on the col-
       results according to the difference in pairs of models scores,          lected results is that a difference of metric scores of at least two
       the highest error rate is for the [0, 2) bin, similarly to the          points is necessary to claim with at least 95% certainty that one
       results of Roy et al. [17].                                             model is better than the other on the Hearthstone dataset, if the hu-

The general recommendation for the practitioners, based on the man
judgement is considered to be the golden truth. The ROUGE-L results of
our study, is that a difference of metric scores of at least metric is
the best-performing metric for the assessment of code five points is
necessary to claim with at least 95% certainty that generation models on
this dataset, with ChrF being the second best. one model is better than
the other on the CoNaLa dataset, if the human judgement is considered to
be the golden truth. ChrF and 6 STUDY IMPLICATIONS ROUGE-L are the
best-performing metrics for the assessment of In this work, we study the
applicability of various automated met- code generation models among the
metrics we consider. rics --- BLEU, ROUGE-L, METEOR, ChrF, RUBY, and
CodeBLEU --- for evaluation of the code generation models. 5.3.2 The
Hearthstone Dataset. We also conducted the human as- Based on the
results, we deduce the following recommendations sessment of the
Hearthstone dataset. Similarly to CoNaLa dataset, to the practitioners.
First, the metric scores should be reported to- we computed the "ground
truth" human grade according to the gether with the data on the
significance of the difference in scores. M-MSR algorithm. For the
non-synthetic models, human graders Second, the difference in metric
scores of less than two points is not are not able to decide with \> 95%
confidence that NL2Code is enough to claim that one model is better than
the other, even if the better than GCNN, and the same is true for the
CodeBLEU, ChrF, difference is statistically significant. Third, despite
BLEU and Code- and RUBY metrics. BLEU being the most popular metrics for
assessing code generation For the disagreement rate of the corpus-level
metrics with the models, we recommend using ChrF as a standard metric
for the code aggregated human scores on the synthetic models, we can see
the generation tasks. We also believe that the community will benefit
following: from a new metric that will be tailored for assessing the
code gen- 1. The metrics are not reliable in determining that the
difference eration task. In order to support the development of such a
metric, between the models is not significant. The relative error rate,
we make the collected human assessment scores open-source for however,
is slightly better than the one observed for the both of the studied
datasets and encourage other researchers to use CoNaLa dataset: ChrF and
ROUGE-L exhibit the error rate them in their work. Finally, we strongly
encourage the practitioners of less than 60%, see column Delta: NS. who
develop code generation models to publish the outputs of their 2. The
total mismatch rate for the Hearthstone dataset is worse models, as it
is close to impossible to observe small, but significant than the one
observed for the CoNaLa dataset, see column improvements in code
generation without the possibility to carry Total mismatch. The reason
for that may be that we only out statistical tests on both old and new
model outputs. have two models available for the dataset, and their
metric scores are relatively close. As all synthetic models were gen-
6.1 Future work erated from these two, it is not surprising that the
synthetic Using the observations we made above, we see the following
direc- models' scores are also rather close and it is hard for the tions
of future work: metrics to discriminate between models. The first is
extending this study with other programming lan- 3. None of the metrics
is reliable enough to discriminate be- guages, datasets, and code
generation models. The obtained data tween the models with a score
difference of less than two should then be used to assess the
applicability of various metrics for points with \> 95% precision, see
column Delta: \[1, 2). the particular dataset and or programming
languages. While such 4. Once again, the BLEU metric performs poorly:
its total mis- an assessment is costly and long, it would allow
comparison of code match rate is among the worst, and, together with
METEOR, generation models with greater certainty. The best course of
action these are the only two metrics which failed to discriminate would
also include full human assessment of the code generation well between
the models with a score difference of more models as it is done for
e.g., machine translation \[43\]. A particular than two points, see row
BLEU. challenge for labelling dataset would be to collect more than 15
5. RUBY and CodeBLEU, metrics developed for assessing code, assessments
per code snippet. According to the findings of Mathur do not perform
significantly better than the metrics originat- et al. \[22\], this
would allow to assess the quality of various models ing from the machine
translation domain. Moreover, they on the snippet level and track the
details of the improvements. are among the worst metrics in terms of
total mismatch rate. The second is creating new metrics for assessing
the quality of 6. There is no clear trend for the Type-I error incidence
across code generation models. Considering the relative success of ML-
all the metrics, unlike it is for the CoNaLa dataset. This can enhanced
metrics for natural language processing tasks \[31, 32\] and
Conference'17, July 2017, Washington, DC, USA Mikhail Evtikhiev, Egor
Bogomolov, Yaroslav Sokolov, and Timofey Bryksin

for code summarization \[17\], we surmise that a promising direc- may
affect the grades they assign to the snippets. To ameliorate tion for a
new metric would be an analog of BERTScore \[44\], that this problem and
to follow the standard survey practices \[17\], we would use embeddings
from a large language model to compute the shuffled the presented
snippets, and added the correct snippets, so similarity score between
the reference and the candidate snippets. that the graders did not know
which snippet is correct or not, in order to smear the possible learning
effect across the outputs of 7 THREATS TO VALIDITY different models. We
believe that while all the threats to validity listed above are 7.1
External threats tangible, we have taken all the necessary measures to
mitigate them, In this paper, we treat external validity threats as the
shortcomings and our results are valid and usable for the community.
that may affect generalizability of our study to other situations. First
of all, our research is based on two Python datasets: a dataset 8
CONCLUSION of Python one-liners and a peculiar Card2Code \[10\] dataset,
for which the models are supposed to generate classes with very spe- In
this study, we examine the current practice of assessing the qual- cific
structure. It would be interesting to explore other datasets; ity of
code generation models with a single corpus-level score based
unfortunately, there is a limited choice of existing datasets, and on
automated metrics. In particular, we check whether such evalu- very few
models that can be run on a particular dataset are usually ation yields
statistically significant results and correlates well with publicly
available. The most interesting dataset that was left out- the human
judgement. We consider six metrics---BLEU, ROUGE-L, side the scope of
this paper is Docstrings \[11\]. Unfortunately, the METEOR, ChrF,
CodeBLEU, and RUBY---for code generation mod- existing models trained on
it perform rather poorly. In particular, els evaluated on two different
Python datasets: CoNaLa \[12\] and the best available model has a BLEU
score of 12.1 \[16\], which means Hearthstone \[10\]. that the expected
human grades for its output would be rather poor. We find that even
without taking into account human assessment The dataset selection
threat is closely related to the model selec- results, the improvement
of a corpus-level metric score by less than tion threat. For every
dataset we looked over, except for CoNaLa, 2 points might not be enough
to warrant a statistically significant there is a relative shortage of
available models; in particular, we ran improvement in quality without
additional statistical tests. When all models that were publicly
available for the Hearthstone dataset. we also consider the results of
human assessment, we find that We contacted the authors of the models
that were not open-sourced, for some datasets, even an improvement in
score by less than 5 but unfortunately got no reply. It is possible that
different model points may not correspond to a statistically significant
improvement selection would yield different results. according to the
human judgement. Among the metrics we study, All the datasets we use
have code snippets written in Python. ChrF turns out to be the closest
to human assessment. However, it While most of the existing public
datasets for code generation cannot be considered the "perfect" metric
for code generation and indeed have code in Python, generation of code
in other languages finding such a metric requires further work. is an
important task and the choice of the language might affect In the future
work, we aim to extend our studies to other code the results of a study
like ours. generation datasets and models, and carry out a more
extensive hu- All the external threats to validity are related to the
sampling man assessment that would allow to check the model improvement
bias issue. While we cannot know for sure, if the results of our at the
snippet level rather than at the corpus level. study hold for other
programming languages and other Python datasets, the fact that the
popular metrics weakly correlate with REFERENCES \[1\] R. Balzer, A 15
year perspective on automatic programming, IEEE Transactions human
judgement for the studied datasets suggests that it might on Software
Engineering (11) (1985) 1257--1268. also be the case for others. Thus,
we need an extensive evaluation \[2\] M. Chen, J. Tworek, H. Jun, Q.
Yuan, H. P. d. O. Pinto, J. Kaplan, H. Edwards, of code generation
metrics to robustly compare models. Y. Burda, N. Joseph, G. Brockman, et
al., Evaluating large language models trained on code, arXiv preprint
arXiv:2107.03374 (2021). \[3\] P. Yin, G. Neubig, A syntactic neural
model for general-purpose code generation, 7.2 Internal threats arXiv
preprint arXiv:1704.01696 (2017). \[4\] Z. Sun, Q. Zhu, L. Mou, Y.
Xiong, G. Li, L. Zhang, A grammar-based structural In this paper, we
consider internal validity threats to be shortcom- cnn decoder for code
generation, in: Proceedings of the AAAI Conference on ings that affect
the trustworthiness of the causal relationship being Artificial
Intelligence, Vol. 33, 2019, pp. 7055--7062. \[5\] P. Yin, G. Neubig,
Tranx: A transition-based neural abstract syntax parser for tested.
Internal threats to the validity of our study are related to semantic
parsing and code generation, arXiv preprint arXiv:1810.02720 (2018). the
selection of the human graders. One of the possible threats \[6\] P.
Yin, G. Neubig, Reranking for neural semantic parsing, in: Proceedings
of the is the small average number of grades available per snippet. It
is 57th Annual Meeting of the Association for Computational Linguistics,
2019, pp. 4553--4559. possible that due to the limited number of
developers who have \[7\] T. Yu, R. Zhang, K. Yang, M. Yasunaga, D.
Wang, Z. Li, J. Ma, I. Li, Q. Yao, S. Roman, participated in the
evaluation, the human grades we derived are et al., Spider: A
large-scale human-labeled dataset for complex and cross-domain different
from the "true" human grades for the analyzed snippets. semantic parsing
and text-to-sql task, arXiv preprint arXiv:1809.08887 (2018). \[8\] Y.
Oda, H. Fudaba, G. Neubig, H. Hata, S. Sakti, T. Toda, S. Nakamura,
Learning This issue, unfortunately, is common to many studies which use
to generate pseudo-code from source code using statistical machine
translation human assessments. The number of human grades we collected
(t), in: 2015 30th IEEE/ACM International Conference on Automated
Software Engineering (ASE), IEEE, 2015, pp. 574--584. per snippet is no
less than in the other studies which use human \[9\] R. Agashe, S. Iyer,
L. Zettlemoyer, Juice: A large scale distantly supervised dataset
assessment for code \[16, 17\], and our results are in line with the for
open domain context-based code generation, arXiv preprint
arXiv:1910.02216 findings of Roy et al. \[17\] studying metrics for code
summarization. (2019). \[10\] W. Ling, E. Grefenstette, K. M. Hermann,
T. Kočiskỳ, A. Senior, F. Wang, A related issue is biased graders. A
grader may have their own P. Blunsom, Latent predictor networks for code
generation, arXiv preprint preference in coding style or usage of
particular technologies that arXiv:1603.06744 (2016). Out of the BLEU:
How Should We Assess Quality of the Code Generation Models?
Conference'17, July 2017, Washington, DC, USA

\[11\] A. V. M. Barone, R. Sennrich, A parallel corpus of python
functions and docu- \[36\] D. Ustalov, N. Pavlichenko, V. Losev, I.
Giliazev, E. Tulin, A General-Purpose mentation strings for automated
code documentation and code generation, arXiv Crowdsourcing
Computational Quality Control Toolkit for Python, in: The preprint
arXiv:1707.02275 (2017). Ninth AAAI Conference on Human Computation and
Crowdsourcing: Works-in- \[12\] P. Yin, B. Deng, E. Chen, B. Vasilescu,
G. Neubig, Learning to mine aligned code Progress and Demonstration
Track, HCOMP 2021, 2021. arXiv:2109.08584. and natural language pairs
from stack overflow, in: International Conference URL
https://www.humancomputation.com/assets/wips_demos/HCOMP_2021\_ on
Mining Software Repositories, MSR, ACM, 2018, pp. 476--486. doi:https:
paper_85.pdf //doi.org/10.1145/3196398.3196408. \[37\] R. Agashe, S.
Iyer, L. Zettlemoyer, JuICe: A large scale distantly supervised \[13\]
S. Lu, D. Guo, S. Ren, J. Huang, A. Svyatkovskiy, A. Blanco, C. Clement,
D. Drain, dataset for open domain context-based code generation, in:
Proceedings of the D. Jiang, D. Tang, et al., Codexglue: A machine
learning benchmark dataset for 2019 Conference on Empirical Methods in
Natural Language Processing and the code understanding and generation,
arXiv preprint arXiv:2102.04664 (2021). 9th International Joint
Conference on Natural Language Processing (EMNLP- \[14\] K. Papineni, S.
Roukos, T. Ward, W.-J. Zhu, Bleu: a method for automatic evalua-
IJCNLP), Association for Computational Linguistics, Hong Kong, China,
2019, tion of machine translation, in: Proceedings of the 40th annual
meeting of the pp. 5436--5446. doi:10.18653/v1/D19-1546. Association for
Computational Linguistics, 2002, pp. 311--318. URL
https://aclanthology.org/D19-1546 \[15\] S. Ren, D. Guo, S. Lu, L. Zhou,
S. Liu, D. Tang, M. Zhou, A. Blanco, S. Ma, \[38\] S. Iyer, I. Konstas,
A. Cheung, L. Zettlemoyer, Mapping language to code in Codebleu: a
method for automatic evaluation of code synthesis, arXiv preprint
programmatic context, arXiv preprint arXiv:1808.09588 (2018).
arXiv:2009.10297 (2020). \[39\] P. Yin, B. Deng, E. Chen, B. Vasilescu,
G. Neubig, Learning to mine aligned \[16\] N. Tran, H. Tran, S. Nguyen,
H. Nguyen, T. Nguyen, Does bleu score work for code and natural language
pairs from stack overflow, in: 2018 IEEE/ACM 15th code migration?, in:
2019 IEEE/ACM 27th International Conference on Program international
conference on mining software repositories (MSR), IEEE, 2018, pp.
Comprehension (ICPC), IEEE, 2019, pp. 165--176. 476--486. \[17\] D. Roy,
S. Fakhoury, V. Arnaoudova, Reassessing automatic evaluation metrics
\[40\] earthbreaker -- open source hearthstone simulator,
https://github.com/danielyule/ for code summarization tasks, in:
Proceedings of the 29th ACM Joint Meeting on hearthbreaker, accessed:
2022-06-06. European Software Engineering Conference and Symposium on
the Foundations \[41\] F. Wilcoxon, Individual comparisons by ranking
methods, in: Breakthroughs in of Software Engineering, 2021,
pp. 1105--1116. statistics, Springer, 1992, pp. 196--202. \[18\] B.
Efron, Estimating the error rate of a prediction rule: improvement on
cross- \[42\] Y. Graham, N. Mathur, T. Baldwin, Randomized significance
tests in machine validation, Journal of the American statistical
association 78 (382) (1983) 316--331. translation, in: Proceedings of
the Ninth Workshop on Statistical Machine Trans- \[19\] C.-Y. Lin,
Rouge: A package for automatic evaluation of summaries, in: Text lation,
2014, pp. 266--274. summarization branches out, 2004, pp. 74--81. \[43\]
L. Barrault, O. Bojar, M. R. Costa-Jussa, C. Federmann, M. Fishel, Y.
Graham, \[20\] S. Banerjee, A. Lavie, Meteor: An automatic metric for mt
evaluation with im- Findings of the 2019 conference on machine
translation (wmt19), Association for proved correlation with human
judgments, in: Proceedings of the acl workshop Computational Linguistics
(ACL), 2019. on intrinsic and extrinsic evaluation measures for machine
translation and/or \[44\] T. Zhang, V. Kishore, F. Wu, K. Q. Weinberger,
Y. Artzi, Bertscore: Evaluating summarization, 2005, pp. 65--72. text
generation with bert, arXiv preprint arXiv:1904.09675 (2019). \[21\] M.
Popović, chrf: character n-gram f-score for automatic mt evaluation, in:
Pro- \[45\] B. Chen, C. Cherry, A systematic comparison of smoothing
techniques for ceedings of the Tenth Workshop on Statistical Machine
Translation, 2015, pp. sentence-level bleu, in: Proceedings of the ninth
workshop on statistical ma- 392--395. chine translation, 2014,
pp. 362--367. \[22\] N. Mathur, T. Baldwin, T. Cohn, Tangled up in bleu:
Reevaluating the eval- \[46\] M. Post, A call for clarity in reporting
bleu scores, arXiv preprint arXiv:1804.08771 uation of automatic machine
translation evaluation metrics, arXiv preprint (2018). arXiv:2006.06264
(2020). \[47\] Rouge 1.5.5 perl script,
https://github.com/andersjo/pyrouge/tree/master/tools/ \[23\] M.
Rabinovich, M. Stern, D. Klein, Abstract syntax networks for code
generation ROUGE-1.5.5, accessed: 2022-05-19. and semantic parsing,
arXiv preprint arXiv:1704.07535 (2017). \[48\] M. Popović, chrf
deconstructed: beta parameters and n-gram weights, in: Pro- \[24\] S.
Hochreiter, J. Schmidhuber, Long short-term memory, Neural computation
ceedings of the First Conference on Machine Translation: Volume 2,
Shared Task 9 (8) (1997) 1735--1780. Papers, 2016, pp. 499--504. \[25\]
Y. Bengio, P. Simard, P. Frasconi, Learning long-term dependencies with
gradient descent is difficult, IEEE transactions on neural networks 5
(2) (1994) 157--166. \[26\] B. Wei, G. Li, X. Xia, Z. Fu, Z. Jin, Code
generation as a dual task of code sum- A METRICS COMPUTATION marization,
in: Advances in Neural Information Processing Systems, 2019, pp.
6563--6573. A.1 BLEU \[27\] A. Vaswani, N. Shazeer, N. Parmar, J.
Uszkoreit, L. Jones, A. N. Gomez, L. u. Kaiser, I. Polosukhin, Attention
is all you need, in: I. Guyon, U. V. Luxburg, BLEU metric is based on
the modified 𝑛-gram precision measure S. Bengio, H. Wallach, R. Fergus,
S. Vishwanathan, R. Garnett (Eds.), Advances with a length penalization
for the candidate sentences that are in Neural Information Processing
Systems, Vol. 30, Curran Associates, Inc., 2017. URL
https://proceedings.neurips.cc/paper/2017/file/ shorter than the
reference ones. The BLEU score is determined by
3f5ee243547dee91fbd053c1c4a845aa-Paper.pdf the following formula: \[28\]
Y. Li, D. Choi, J. Chung, N. Kushman, J. Schrittwieser, R. Leblond, T.
Eccles, J. Keel- ! ing, F. Gimeno, A. D. Lago, T. Hubert, P. Choy, C.
d. M. d'Autume, I. Babuschkin, 𝑁 ∑︁ X. Chen, P.-S. Huang, J. Welbl, S.
Gowal, A. Cherepanov, J. Molloy, D. J. Mankowitz, 𝐵𝐿𝐸𝑈 = 𝐵𝑃 · exp 𝑤𝑛 log
𝑝𝑛 ; 𝐵𝑃 = min(1, 𝑒 1−𝑟 /𝑐 ), (1) E. S. Robson, P. Kohli, N. de Freitas,
K. Kavukcuoglu, O. Vinyals, Competition-level 𝑛=1 code generation with
alphacode (2022). doi:10.48550/ARXIV.2203.07814. URL
https://arxiv.org/abs/2203.07814 where 𝐵𝑃 is the brevity penalty with 𝑟
being the length of the refer- \[29\] M. Denkowski, A. Lavie, Meteor
universal: Language specific translation evalua- tion for any target
language, in: Proceedings of the ninth workshop on statistical ence and
𝑐 being the candidate translation length. 𝑝𝑛 corresponds machine
translation, 2014, pp. 376--380. to the weighted overlap between the bag
of n-grams (repeated \[30\] A. LeClair, C. McMillan, Recommendations for
datasets for source code summa- terms are allowed up to the maximal
number of repeats across the rization, arXiv preprint arXiv:1904.02660
(2019). \[31\] Q. Ma, J. Wei, O. Bojar, Y. Graham, Results of the wmt19
metrics shared task: references). If 𝑆𝑟𝑒 𝑛 and 𝑆 𝑛 are bags of n-grams
for the reference 𝑓 𝑐𝑎𝑛 Segment-level and strong mt systems pose big
challenges, in: Proceedings of the and the candidate correspondingly,
then Fourth Conference on Machine Translation (Volume 2: Shared Task
Papers, Day 1), 2019, pp. 62--90. 𝑛 ∩ 𝑆𝑛 \[32\] Q. Ma, O. Bojar, Y.
Graham, Results of the wmt18 metrics shared task: Both 𝑆𝑟𝑒 𝑓 𝑐𝑎𝑛
characters and embeddings achieve good performance, in: Proceedings of
the 𝑝𝑛 = (2) third conference on machine translation: shared task
papers, 2018, pp. 671--688. 𝑛 𝑆𝑟𝑒 \[33\] C.-W. Liu, R. Lowe, I. V.
Serban, M. Noseworthy, L. Charlin, J. Pineau, How not to 𝑓 evaluate your
dialogue system: An empirical study of unsupervised evaluation metrics
for dialogue response generation, arXiv preprint arXiv:1603.08023
(2016). Finally, 𝑤𝑛 are the weights for various n-gram contributions;
the \[34\] E. Reiter, A structured review of the validity of bleu,
Computational Linguistics standard weights are 𝑤 1 = . . . = 𝑤 4 = 14 ,
𝑤𝑛\>4 = 0. The original 44 (3) (2018) 393--401. BLEU implementation
\[14\] is a corpus-level metric, as it accounts \[35\] Q. Ma, A.
Olshevsky, Adversarial crowdsourcing through robust rank-one matrix
completion, arXiv preprint arXiv:2010.12181 (2020). for the
micro-average precision. That is, to compute the precision one has to
sum the numerators and the denominators for each Conference'17, July
2017, Washington, DC, USA Mikhail Evtikhiev, Egor Bogomolov, Yaroslav
Sokolov, and Timofey Bryksin

hypothesis-reference pair before the division. It is possible to define
We use the implementation of ROUGE-L from the rouge-score sentenceBLEU
metric to score individual hypothesis (as is done by, package, which
yields results identical to the original Perl script \[47\]. e.g., Roy
et al. \[17\]) by considering each hypothesis and references as an
independent corpus. One, however, has to remember that the A.3 ChrF
average of sentenceBLEU over the whole dataset is not necessarily ChrF
is an F-measure character-based metric first suggested by equal to the
BLEU evaluated on the dataset. Popovic \[21\]. It was originally
proposed for automatic evaluation BLEU values range from 0 to 1, with
higher scores corresponding of machine translation output. As a
character-based metric, ChrF to better n-grams precision. However,
practitioners often multiply doesn't depend on tokenization rules. It
takes every character into BLEU scores by a factor of 100 in their model
quality reports. The account, except for spaces. To compute ChrF in its
standard defini- default implementation of the BLEU metric gives zero
score to the tion, one has first to compute character-level precision
and recall candidates which have zero overlap in 4-grams with the
reference. 𝑐ℎ𝑟𝑃𝑘 , 𝑐ℎ𝑟𝑅𝑘 for character 𝑘-grams, where 1 ≤ 𝑘 ≤ 6. The
total This restriction may penalize the candidate sentences of mediocre
n-gram precision and recall 𝐶ℎ𝑟𝑃, 𝐶ℎ𝑟𝑅 is the arithmetical average
quality too hard (e.g. for a seven-token reference a candidate that of
𝑐ℎ𝑟𝑃𝑘 , 𝑐ℎ𝑟𝑅𝑘 respectively. Finally, ChrF is computed as guessed 6
tokens right, but missed the token #4 will get score zero). Several
smoothing algorithms have been suggested to avoid these (1 + 𝛽 2
)𝐶ℎ𝑟𝑃𝐶ℎ𝑟𝑅 situations, a systematic comparison of smoothing techniques
for 𝐶ℎ𝑟 𝐹 𝛽 = (3) 𝐶ℎ𝑟𝑅 + 𝛽 2𝐶ℎ𝑟𝑃 the sentence-level BLEU for the machine
translation task can be found in the paper of Chen et al. \[45\]
Standard ChrF definition that we use sets 𝛽 = 2, as this choice of 𝛽 In
our study, we use the reference BLEU implementation from yields the best
results in the machine translation tasks \[48\]. thesacrebleu package
\[46\]. We use the reference implementation of ChrF from the sacrebleu
package. A.2 ROUGE-L ROUGE-L is a metric from the ROUGE family of
metrics first sug- A.4 METEOR gested by Lin \[19\]. It was originally
suggested for assessing quality METEOR was created as a metric for
machine translation evalua- of short text summaries, but then was
adopted for other tasks. The tion \[20\]. There are several versions of
the metric that have slightly basic notion for the ROUGE-L computation
is the longest common different computation rules. In our computations
we have used the subsequence (of hypothesis and reference). The common
subse- latest version of the metric -- METEOR 1.5 \[29\]. Its
computation quence between two sequences 𝑋 = \[𝑥𝑖 \], 𝑌 = \[𝑦 𝑗 \] is a
sequence consists of the following steps: \[𝑧𝑙 \] that is a subsequence
of both 𝑋, 𝑌 . The longest common subse- quence is then simply a common
subsequence of maximal length. • Creating alignment between the
hypothesis and the refer- This allows us to define precision, recall and
the ROUGE-L metric ence strings. The alignnment between the hypothesis
and for hypothesis 𝐻 and reference 𝑅 as the reference strings is a
mapping between the unigrams of these strings, such that every unigram
in each string maps 𝐿𝐶𝑆 (𝐻, 𝑅) to zero or one unigrams in the other
string. The alignment 𝑅𝑙𝑐𝑠 (𝐻, 𝑅) = 𝑙𝑒𝑛(𝑅) is created in several stages
with different rules for the uni- 𝐿𝐶𝑆 (𝐻, 𝑅) gram matching in each
stage. In the first stage, two words 𝑃𝑙𝑐𝑠 (𝐻, 𝑅) = are matched if and
only if they are identical. In the second 𝑙𝑒𝑛(𝐻 ) stage, they are
matched if they are identical after Porter (1 + 𝛽 2 )𝑃𝑙𝑐𝑠 𝑅𝑙𝑐𝑠 𝑅𝑂𝑈 𝐺𝐸𝐿
(𝐻, 𝑅) = stemming. In the third stage, two words are matched if they
𝑅𝑙𝑐𝑠 + 𝛽 2 𝑃𝑙𝑐𝑠 are synonyms according to the WordNet database. Finally,
𝛽 is the parameter that determines recall weight, in our evaluation two
phrases are matched if they are listed as paraphrases in we use 𝛽 = 1
(equal weight of precision and recall). The possible the corresponding
language table. The mappings are applied values range from 0 to 1, but
similarly to BLEU and other metrics iteratively, and the final alignment
is the largest subset of all the corpus-level scores are often
multiplied by 100 to simplify the matches built using the beam search.
To determine the final perception. The ROUGE-L is commonly used as a
snippet-level alignment, the following criteria in order of the
importance metric \[17\]. This means that to obtain corpus-level ROUGE-L
score are applied: one has to average snippet-level scores. For a simple
example, let -- The number of covered words across the both sentences us
consider a reference and two hypothesis: should be maximized. -- The
number of chunks should be minimized. A chunk is a 𝑅 : police killed the
gunman contiguous series of matches that has identical ordering 𝐻 1 :
police kill the gunman in both sentences. 𝐻 2 : the gunman killed police
-- The sum of absolute distances between match start indices The longest
common subsequence between 𝑅, 𝐻 1 is 3 tokens long in the two sentences
should be minimized. This is to break (first, third and fourth token),
and the longest common subsequence ties by preferring to align phrases
that occur at similar between 𝑅, 𝐻 2 is 2 tokens long (either first and
second, or third and positions in both sentences. fourth token). Thus
𝑅𝑂𝑈 𝐺𝐸𝐿 (𝐻 1, 𝑅) = 0.75, 𝑅𝑂𝑈 𝐺𝐸𝐿 (𝐻 2, 𝑅) = • After the alignment has
been built, the words in the hypoth- 0.5. esis and reference are split
into content and function words Out of the BLEU: How Should We Assess
Quality of the Code Generation Models? Conference'17, July 2017,
Washington, DC, USA

       according to a special function word list. For each of the ap-           the observation that the more abstract metrics have better corre-
       plied matchers one should count the number of content and                lation with the human judgement. As Tran et al. do not provide a
       function words covered by matches of this type. Then one                 reference implementation of RUBY, in our study we use our own
       calculates weighted precision and recall 𝑃, 𝑅 using matcher              implementation of the RUBY metric.
       weights and content-function word weight. From 𝑃, 𝑅 one
       then computes the weighted harmonic mean 𝐹𝑚𝑒𝑎𝑛 . Finally,                A.6     CodeBLEU
       to penalize gaps and differences in the word order, one com-             The CodeBLEU metric as suggested by Ren et al. [15] is given by
       putes a fragmentation penalty using the total number of
                                                                                           𝐶𝑜𝑑𝑒𝐵𝐿𝐸𝑈 = 0.1 · 𝐵𝐿𝐸𝑈 + 0.1 · 𝐵𝐿𝐸𝑈 𝑤 +                     (8)
       matched words and number of chunks. The METEOR score
       is finally computed from 𝐹𝑚𝑒𝑎𝑛 and fragmentation penalty.                                       + 0.4 · 𝑀𝑎𝑡𝑐ℎ𝑎𝑠𝑡 + 0.4 · 𝑀𝑎𝑡𝑐ℎ𝑑 𝑓 ,            (9)

We use the implementation of METEOR from the sacrerouge where: package,
which makes use of the original script and provides a • BLEU is the
usual BLEU metric. Python wrapper for it. • 𝐵𝐿𝐸𝑈 𝑤 is the BLEU metric
computed over unigrams only with keywords given 5 times higher weights.
In another A.5 RUBY words, 𝐵𝐿𝐸𝑈 𝑤 is a precision for unigrams with BLEU
brevity The metric is defined as penalty. For example, for Python
reference for x in lst and hypothesis for x of 𝐵𝐿𝐸𝑈 𝑤 = 𝑒 −1/3 12 6 . 
  𝐺𝑅𝑆 (𝑅, 𝐶) if PDGs are applicable, • 𝑀𝑎𝑡𝑐ℎ𝑎𝑠𝑡 is the syntactic AST
match. To compute this sub- (4)   𝑅𝑈 𝐵𝑌 (𝑅, 𝐶) = 𝑇 𝑅𝑆 (𝑅, 𝐶) if ASTs
are applicable, metric, one first has to build the AST for both
reference and otherwise hypothesis, and extract all sub-trees from both
ASTs. To  𝑆𝑇 𝑆 (𝑅, 𝐶)  track the syntactic structure, authors
disregard the values  Here PDG stands for the program dependence graph
and AST stands in the leave nodes. 𝑀𝑎𝑡𝑐ℎ𝑎𝑠𝑡 is then given by 𝑀𝑎𝑡𝑐ℎ𝑎𝑠𝑡 =
for the abstract syntax tree, 𝑅 corresponds to the reference and 𝐶
𝐶𝑜𝑢𝑛𝑡𝑐𝑙𝑖𝑝 (𝑇ℎ𝑦𝑝 )/𝐶𝑜𝑢𝑛𝑡 (𝑇𝑟𝑒 𝑓 ), where 𝐶𝑜𝑢𝑛𝑡 (𝑇𝑟𝑒 𝑓 ) is the to-
corresponds to the candidate. 𝐺𝑅𝑆 (𝑅, 𝐶) measures the similarity tal
number of sub-trees in reference AST and 𝐶𝑜𝑢𝑛𝑡𝑐𝑙𝑖𝑝 (𝑇𝑐𝑎𝑛𝑑 ) between two
program dependence graphs for 𝑅, 𝐶 as is the number of sub-trees in
hypothesis AST that are matched 𝐺𝐸𝐷 (𝑃𝐷𝐺𝑅 , 𝑃𝐷𝐺𝐶 ) by sub-trees in the
reference. 𝐺𝑅𝑆 (𝑅, 𝐶) = 1 − , (5) 𝑠𝑖𝑧𝑒 (𝑃𝐷𝐺𝑅 ) + 𝑠𝑖𝑧𝑒 (𝑃𝐷𝐺𝐶 ) • 𝑀𝑎𝑡𝑐ℎ𝑑 𝑓
is the semantic data-flow match that considers the semantic similarity
between the hypothesis and the reference where 𝐺𝐸𝐷 (𝑃𝐷𝐺𝑅 , 𝑃𝐷𝐺𝐶 ) is the
edit distance between PDG of by comparing the data-flow graphs of the
reference and the the reference code and PDG of the candidate code. 𝑠𝑖𝑧𝑒
(𝑔) is the hypothesis. The sub-metric is computed in several steps as
sum of number of vertices and edges of the graph 𝑔. 𝐺𝐸𝐷 (𝑎, 𝑏) follows:
is computed as the minimum number of graph edit operations 1. Build the
data-flow graph for the reference and the hy- to transform one graph
into another with the allowed graph edit pothesis. To do that, one first
has to get the variable se- operations on vertexes and edges being
insertion, deletion, and quence 𝑉 = {𝑣 0, 𝑣 1, . . . , 𝑣𝑚 } from the
AST. Each variable substitution. then becomes a node of the data-flow
graph, and directed In the case the PDG is not available for the
candidate snippet, the edges 𝜖 = ⟨𝑣𝑖 , 𝑣 𝑗 ⟩ signify that the value of
𝑗-th variable next fallback option is 𝑇 𝑅𝑆 (𝑅, 𝐶), which measures the
similarity comes from the 𝑖-th variable. The graph 𝐺 = (𝑉 , 𝐸) is the
between the ASTs for the reference and the candidate snippet as
data-flow graph. 𝑇 𝐸𝐷 (𝐴𝑆𝑇𝑅 , 𝐴𝑆𝑇𝐶 ) 2. Normalize data-flow items. To do
that, one has to collect 𝑇 𝑅𝑆 (𝑅, 𝐶) = 1 − , (6) 𝑠𝑖𝑧𝑒 (𝐴𝑆𝑇𝑅 ) + 𝑠𝑖𝑧𝑒
(𝐴𝑆𝑇𝐶 ) all the variables in the data-flow items and rename them where
𝑠𝑖𝑧𝑒 (𝑇 ) is the number of nodes in the AST, and 𝑇 𝐸𝐷 (𝑎, 𝑏) is 𝑣𝑎𝑟𝑖 ,
where 𝑖 is the order of the variable appearance in all the edit distance
between the ASTs of the reference code 𝐴𝑆𝑇𝑅 and data-flow items. the
candidate code 𝐴𝑆𝑇𝐶 . TED is given by the minimum number 3. Calculate
the semantic data-flow match score as 𝑀𝑎𝑡𝑐ℎ𝑑 𝑓 = of the editing
operations on the AST nodes (that include addition, 𝐶𝑜𝑢𝑛𝑡𝑐𝑙𝑖𝑝 (𝐷𝐹ℎ𝑦𝑝
)/𝐶𝑜𝑢𝑛𝑡 (𝐷𝐹𝑟𝑒 𝑓 ), where 𝐶𝑜𝑢𝑛𝑡 (𝐷𝐹𝑟𝑒 𝑓 ) deletion, replacement and
movement) that make 𝐴𝑆𝑇𝑅 and 𝐴𝑆𝑇𝐶 is the total number of the reference
data-flows and identical. 𝐶𝑜𝑢𝑛𝑡𝑐𝑙𝑖𝑝 (𝐷𝐹𝑐𝑎𝑛𝑑 ) is the number of the
matched candi- Finally, the last fallback option for RUBY, that can
always be date data-flows. computed, is the string similarity function
𝑆𝑇 𝑆 (𝑅, 𝐶) that is defined Ren et al. compared CodeBLEU with BLEU and
accuracy. As as CodeBLEU was not compared to other automatic metrics
apart 𝑆𝐸𝐷 (𝑆𝑅 , 𝑆𝐶 ) from BLEU and accuracy, we need to carry out
further assessment. 𝑆𝑇 𝑆 (𝑅, 𝐶) = 1 − , (7) In our study, we use our own
implementation of the CodeBLEU 𝑚𝑎𝑥 (𝑙𝑒𝑛𝑔𝑡ℎ(𝑆𝑅 ), 𝑙𝑒𝑛𝑔𝑡ℎ(𝑆𝐶 )) metric.
where 𝑆𝐸𝐷 (𝑆𝑅 , 𝑆𝐶 ) is the string edit distance between the reference
sequence 𝑆𝑅 and candidate sequence 𝑆𝐶 . It measures the number of token
deletion/addition actions the user must make to transform the candidate
code into the reference one; 𝑙𝑒𝑛𝑔𝑡ℎ(𝑡) is the length of the sequence 𝑡.
Tran et al. motivate this choice of metric by 
