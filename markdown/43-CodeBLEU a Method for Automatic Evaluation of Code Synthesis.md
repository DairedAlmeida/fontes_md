                                                        CodeBLEU: a Method for Automatic Evaluation of Code Synthesis
                                                                Shuo Ren1 , Daya Guo2 , Shuai Lu3 , Long Zhou4 , Shujie Liu4 ,
                                                          Duyu Tang4 , Neel Sundaresan4 , Ming Zhou4 , Ambrosio Blanco4 , Shuai Ma1
                                                  1
                                                      SKLSDE Lab, Beihang University; Beijing Advanced Innovation Center for Big Data and Brain Computing
                                                                            2
                                                                              Sun Yat-sen University 3 Peking University 4 Microsoft
                                                            1
                                                              {shuoren, mashuai}@buaa.edu.cn 2 guody5@mail2.sysu.edu.cn 3 lushuai96@pku.edu.cn
                                                                   4
                                                                     {Long.Zhou, shujliu, dutang, neels, mingzhou, ambrob}@microsoft.com

arXiv:2009.10297v2 \[cs.SE\] 27 Sep 2020

                                                                     Abstract                                 recently proposed computational accuracy (Lachaux et al.
                                                                                                              2020), evaluates whether the hypothesis function generates
                                           Evaluation metrics play a vital role in the growth of an area      the same outputs as the reference given the same inputs.
                                           as it defines the standard of distinguishing between good and
                                           bad models. In the area of code synthesis, the commonly used
                                                                                                                 However, the above evaluation approaches still face many
                                           evaluation metric is BLEU or perfect accuracy, but they are        drawbacks. First, the n-gram accuracy does not take into
                                           not suitable enough to evaluate codes, because BLEU is orig-       account the grammatical and logical correctness, resulting
                                           inally designed to evaluate natural language, neglecting im-       in favoring candidates with high n-gram accuracy and seri-
                                           portant syntactic and semantic features of codes, and perfect      ous logical errors. Second, the perfect accuracy is too strict,
                                           accuracy is too strict thus it underestimates different outputs    and underestimates different outputs with the same semantic
                                           with the same semantic logic. To remedy this, we introduce a       logic. Third, the computational accuracy is weak in univer-
                                           new automatic evaluation metric, dubbed CodeBLEU. It ab-           sality and practicability, since it should be designed for dif-
                                           sorbs the strength of BLEU in the n-gram match, and further        ferent programming languages, as well as specific compilers
                                           injects code syntax via abstract syntax trees (AST) and code       and the desired computing resource.
                                           semantics via data-flow. We conduct experiments by evaluat-
                                           ing the correlation coefficient between CodeBLEU and qual-
                                                                                                                 In order to deal with that, in this paper, we propose a new
                                           ity scores assigned by the programmers on three code syn-          evaluation metric CodeBLEU, considering information from
                                           thesis tasks, i.e., text-to-code, code translation, and code re-   not only the shallow (n-gram) match, but also the syntactic
                                           finement. Experimental results show that, our proposed Code-       match and the semantic match. More specifically, the n-gram
                                           BLEU can achieve a better correlation with programmer as-          match assigns different weights for different n-grams, the
                                           signed scores compared with BLEU and accuracy.                     syntactic match considers the abstract syntax tree (AST) in-
                                                                                                              formation in the evaluation score by matching the sub-trees,
                                                                                                              and the semantic match uses data-flow structure to measure
                                                               1    Introduction                              the semantic similarity. CodeBLEU is a weighted combina-
                                         A suitable evaluation metric is important to push forward            tion of the original BLEU, the weighted n-gram match, the
                                         the research of an area, such as BLEU (Papineni et al. 2002)         syntactic AST match, and the semantic data-flow match.
                                         and ROUGE (Lin 2004) for machine translation and text                   We conduct massive experiments to evaluate the effec-
                                         summarization. Along with the rapid progress of code syn-            tiveness of CodeBLEU and the correlation coefficient be-
                                         thesis such as text-to-code synthesis, code translation and          tween CodeBLEU scores and human evaluation scores in
                                         code change prediction (Karaivanov, Raychev, and Vechev              three code synthesis tasks including text-to-code synthe-
                                         2014; Oda et al. 2015; Barone and Sennrich 2017; Chen,               sis, code translation, and code refinement. Experimental re-
                                         Liu, and Song 2018; Kanade et al. 2019; Husain et al. 2019;          sults demonstrate that CodeBLEU can significantly differen-
                                         Feng et al. 2020; Dinella et al. 2020; Lachaux et al. 2020),         tiate the systems’ performance and achieve better correlation
                                         different automatic evaluation methods for code synthesis            with the quality scores given by programmers than the pop-
                                         are leveraged, including n-gram accuracy (Karaivanov, Ray-           ularly used BLEU. We hope that our proposed CodeBLEU
                                         chev, and Vechev 2014), perfect accuracy (Chen, Liu, and             can accelerate the R&D cycle of code synthesis tasks.
                                         Song 2018), and computational accuracy (Lachaux et al.
                                         2020). The n-gram accuracy (e.g. 4-gram BLEU) is the most                             2    Why not BLEU?
                                         popular evaluation method for code synthesis (Karaivanov,            In this section we will briefly introduce BLEU, and analyze
                                         Raychev, and Vechev 2014; Barone and Sennrich 2017),                 its merits and demerits when applying it to code synthesis.
                                         based on the token overlapping between the hypothesis and
                                         the reference. The perfect accuracy calculates the percent-          2.1   BLEU for Machine Translation
                                         age of the predicted target programs that are exactly the
                                                                                                              Machine translation, which uses computers to realize au-
                                         same as the ground truth (Chen, Liu, and Song 2018). The
                                                                                                              tomatic translation between languages, is first proposed by
                                         Copyright c 2021, Association for the Advancement of Artificial      Warren Weaver as early as 1949 (Weaver 1955). Since then,
                                         Intelligence (www.aaai.org). All rights reserved.                    machine translation quality has not significantly improved

until the automatic evaluation metric (BLEU) is proposed in weighted
combination of four parts as shown in Figure 1: 2002 (Papineni et
al. 2002). The appearance of BLEU makes it possible to automatically
train and optimize the machine CodeBLEU =α · BLEU + β · BLEUweight (1)
translation systems and speeds up the research process of +γ ·
Matchast + δ · Matchdf machine translation. BLEU measures how well a
candidate translation matches where BLEU is calculated by standard BLEU
(Papineni a set of translation references by calculating the percentage
et al. 2002), BLEUweight is the weighted n-gram match, ob- of n-grams
overlapped between them. Besides, the brevity tained by comparing the
hypothesis code and the reference penalty is introduced to punish the
candidates with a very code tokens with different weights (Sec. 3.1),
Matchast is short length, so it is hard for the MT system to cheat the
the syntactic AST match, exploring the syntactic informa- evaluation
metric by finding a way to change the output that tion of code (Sec.
3.2), and Matchdf is the semantic data- the BLEU score goes up, but the
translation quality doesn't. flow match, considering the semantic
similarity between the hypothesis and the reference (Sec. 3.3). The
weighted n- gram match and the syntactic AST match are used to mea- 2.2
Code vs Natural Language sure grammatical correctness, and the semantic
data-flow Although the BLEU achieves great success in the evaluation
match is used to calculate logic correctness. of machine translation and
greatly encourages the research in this area, BLEU is not suitable for
the evaluation of code 3.1 Weighted N-Gram Match synthesis without
considering the characteristics of the pro- The original BLEU compares
n-grams between the candi- gramming language. A natural language is any
language that date and the reference, and calculates the ratio of
matched has evolved naturally in humans through use and repetition,
n-grams. Compared with natural languages which a huge but code is
artificially designed to produce various kinds of vocabulary and a free
word order, programming languages output. There are three big
differences between them. are manually designed and have only a few
keywords such (1) Limited keywords vs. millions of words. Different as
"int", "public" and so on. Applying the traditional BLEU from natural
languages with a huge vocabulary, code is de- directly to code synthesis
will ignore the importance of the signed by humans and uses a small
number of keywords, i.e., keywords. Hence, we introduce the weighted
n-gram match the reserved words of programming languages. Intuitively,
to assign different weights for different n-grams, so that the keywords
are more important than other words and the key- keywords may have
higher weights, as shown in Figure 1. words match should gain a higher
score. The weighted n-gram match precision is computed as: (2) Tree
structure vs. sequential structure. Humans usually speak and write from
left to right, and the current l µin · Countclip (C(i, i + n)) P P
mainstream models usually process natural languages as a C∈Candidates
i=1 sequence (Zhou et al. 2019), such as end-to-end neural ma- pn = l
(2) chine translation (Sutskever, Vinyals, and Le 2014; Bah- P P µin ·
Count(C 0 (i, i + n)) danau, Cho, and Bengio 2014; Vaswani et al. 2017).
In con- C 0 ∈Candidates i=1 trast, code has a natural tree structure and
needs to be com- piled according to their abstract syntax tree
(Rabinovich, where n means the length of the n-gram, C(i, i + n) is
Stern, and Klein 2017). Therefore, how to evaluate the syn- the n-gram
from the position i to the position i + n, and tactic structure of code
becomes particularly important. Countclip (C(i, i + n)) is the maximum
number of n-grams (3) Unique instructions vs. ambiguous semantic. Word
co-occurring in a candidate code and a set of reference sense
disambiguation is a basic research problem in natu- codes. µin denotes
the weights of different keywords or n- ral language processing, because
natural languages usually gram. In this paper, µin of the keywords is 5
times the have ambiguous and variable semantic. However, code de-
weights of other tokens. Next, following the brevity penalty sign is
required to be unique, standardized and systematic, of original BLEU, we
also compute the brevity penalty BP: with unique and fixed instructions.
This feature makes it pos- ( sible to evaluate the semantics of the
code. 1 if c \> r BP = 1−r/c In summary, code is significantly different
from natural e if c ≤ r languages, and BLEU is not suitable for code
synthesis eval- uation only considering the token match and ignoring the
where c is the length of the candidate code and r is the ef- importance
of keywords, syntactic accuracy, and semantic fective reference corpus
length. The weighted n-gram match correctness. Therefore, we propose a
new evaluation metric score is calculated as: CodeBLEU, which will be
introduced in the following. N X BLEUweight = BP · exp( wn logpn ) (3) 3
CodeBLEU n=1

In order to pay attention to the keywords, leverage the tree In our
paper, the keywords are only considered in the uni- structure and
consider the semantic logic information, we grams, so N and wn are equal
to 1. Note that a keywords list propose a new evaluation metric CodeBLEU
defined as the is predefined for each programming language. Figure 1:
The proposed CodeBLEU, a weighted syntactic and semantic BLEU for code
synthesis evaluation, consists of the original BLEU, the weighted n-gram
match, the syntactic AST match, and the semantic data-flow match.

3.2 Syntactic AST Match codes have the same AST and their tokens are
highly over- In addition to the sequence-level matching, we also con-
lapped. Therefore, we also consider the semantic informa- sider the
syntactic information in CodeBLEU by matching tion in CodeBLEU. We use
data-flow (Guo et al. 2020) to the tree structure. Different from
natural language, program- represent a source code as a graph, in which
nodes represent ming language has natural tree structures, such as the
ab- variables and edges represent where the value of each vari- stract
syntax tree (AST). AST is a tree representation of the able comes from.
Unlike AST, data-flows of the two codes abstract syntactic structure of
programming languages. We are different in Figure 2 since their return
values come from can obtain all the sub-trees of the tree-sitter parsing
result1 , x and y respectively. Such a semantic graph can be used to
then calculate the accuracy by comparing the candidate and measure the
semantic match between the candidate and the reference sub-trees. In
AST, each node denotes a construct reference. occurring in the source
code. The leaves of AST represent the names of the function and all the
variables. However, we just want to use the syntactic structure of the
codes, and the naming is not important, thus we leave out all the leave
nodes in the original AST trees. As shown in the middle part of Figure
1, we extract all the sub-trees of the candidate and the reference ASTs
respec- tively. Then we calculate the syntactic AST match score as:
Figure 2: BLEU: 95.47; Matchast : 100. Matchast = Countclip (Tcand
)/Count(Tref ) (4) Based on the above, there are three steps to compute
the semantic data-flow match score. where Count(Tref ) is the total
number of the reference sub- Step 1: Obtain the data-flow graphs for the
candidate and trees, and Countclip (Tcand ) is the number of the candi-
the reference. Based on AST, we first utilize the leaves to date
subtrees that are matched the reference. This score can identify
variable sequence, denoted as V = {v0 , v1 , ..., vm }. evaluate code
quality from a syntactic perspective, because We then take each variable
as a node of the graph and a grammatical errors such as token missing,
data type errors directed edge  = hvi , vj i from vi to vj refers that
the value can be captured by the difference between their ASTs. of j-th
variable comes from i-th variable. The graph G(C) = 3.3 Semantic
Data-flow Match (V ; E) is used to represent relations among variables
of the code C, as shown by the red arrows in Figure 1. In programming
languages, the semantic of source code Step 2: Normalize data-flow
items. For simplicity and is highly relevant to the dependency relations
among vari- unity, we ignore the variable position and normalize their
ables. Taking Figure 2 as an example, the function is to names. We
collect all the variables in the data-flow items calculate the mean
value of an array. Although the dif- and rename them var i, where i is
the order of the variables ference between the candidate and the
reference is subtle appearing in all data-flow items. (return y → return
x), their semantics are completely dif- Step 3: Calculate the semantic
data-flow match score as: ferent. However, the weighted n-gram match and
the syntac- Matchdf = Countclip (DFcand )/Count(DFref ) (5) tic AST
match still give a high score since the two pieces of where Count(DFref
) is the total number of the refer- 1
https://github.com/tree-sitter/tree-sitter ence data-flows, and
Countclip (DFcand ) is the number of matched candidate data-flows.

                                                                    Figure 4: Example 2. BLEU: 68.14; CodeBLEU: 83.97.

Figure 3: Example 1. BLEU: 75.43; CodeBLEU: 69.73. BLEU score is only
75.71, which underestimates the quality of the candidate. With CodeBLEU,
we have the weight n- 3.4 Two Examples gram match score of 76.46, the
syntactic AST match score Here we will give two toy examples to show how
to calculate of 100 and the semantic data-flow match score of 100, the
CodeBLEU. Meanwhile, we show the qualitative advantages final CodeBLEU
score being 88.04, which makes up for the of CodeBLEU compared with the
traditional BLEU score. underestimation of BLEU. From the two examples,
we find that in some typical Example 1 The output candidate of a code
synthesis sys- scenarios, CodeBLEU gives more reasonable scores than tem
and the according reference are shown in Figure 3. BLEU to evaluate the
code synthesis output. In the exper- In this example, there are four
differences between the iment section, we will give the quantitative
analysis, further candidate and the reference, which are stressed with
the red showing the effectiveness of CodeBLEU. color. They are (1) the
conversion type of the return value ("float" vs. "int"); (2) the
variable naming ("c" vs. "d"); (3) the type of a constant ("0.0" and
"0"); (4) the missing token 4 Experiments ("}") in the candidate. This
toy example is designed based We conduct experiments on three code
synthesis tasks, i.e., on the background that the data type, the
variable naming text-to-code (Java), code translation (from Java to C#)
and and the token missing tend to cause problems in reality. code
refinement (Java). Previous work of these tasks uses The CodeBLEU is
calculated as follows: (1) First, we cal- BLEU or perfect accuracy
(exactly match) for evaluation. In culate the n-gram match score (BLEU,
which is 75.43) given this paper, we will take the proposed CodeBLEU as
the eval- the candidate and the reference. (2) Then, we calculate the
uation metric to see if CodeBLEU is more reasonable. For weighted n-gram
match score for it. The weight assigned to each task, we calculate the
Pearson correlation coefficient to the keywords "public, static, int,
return, double" in the ref- check the correlation between the scores
given by our pro- erence are 4 times more than that of the rest tokens.
The posed CodeBLEU and the scores assigned by programmers resulting
score is 74.91, lower than the BLEU score, pe- (human evaluation
scores). In the following subsections, we nalizing the keyword error
("float" vs. "int"). (3) The num- will first introduce the three tasks
we used. Then we will ber of all sub-trees of the reference AST
generated by tree- give details of our experiment settings. Next, the
experimen- sitter is 21 and the hit number for the candidate is 13, so
tal results will be shown and discussed. Finally, we will do the
syntactic AST match score is 13/21 ∗ 100 = 61.90(%). an ablation study
and investigate the influence of different The data type errors in the
candidate are penalized by the components of CodeBLEU to the final
results. AST mismatch. (4) Three data-flows can be extracted from the
reference AST, which are "\[('var 0', 'comesFrom', \[\]), 4.1 Task
Introduction ('var 0', 'comesFrom', \['var 0'\])\], ('var 0',
'comesFrom', \['var 0'\])\]", corresponding to the three variables "d"
in the The three tasks we choose for the experiment are text-to-
reference. The first "d" comes from no parent because it is in code,
code translation, and code refinement. the parameter list. The second
and the third "d" come from the first "d". The variable names are
normalized and their Text-to-code Text-to-code (Iyer et al. 2018) is the
task of positions are ignored according to Section 3.3. However,
generating class member functions given the function doc- we can only
extract two data-flows from the candidate AST umentation and the
programmatic context. The inputs are , i.e., "\[('var 0', 'comesFrom',
\[\]), ('var 0', 'comesFrom', the natural language documentation, and
the class environ- \['var 0'\])\]" corresponding to the two "d"s in this
code. The ment the code resides in. The environment comprises two
variable "c" is used before declaration so no data-flow is ex- lists of
entities: (1) class member variable names with their tracted for it.
Therefore the data-flow match score is 2/3 ∗ data types, and (2) member
function names together with 100 = 66.67(%). With α, β, γ, δ = 0.25,
0.25, 0.25, 0.25, their return types. The output is a piece of code of
the desired the final CodeBLEU score is 69.73, which is lower than class
member function. We use the same dataset released by BLEU because
CodeBLEU penalizes the keyword and se- Iyer et al. (2018), which
consists of 100k training samples, mantic errors for the programming
languages. 2k validation samples and 2k test samples. Example 2 As shown
in Figure 4, in this example, there Code Translation Code translation
aims to migrate legacy is no difference between the candidate and the
reference ex- software from one programming language in a platform to
cept for the names of the local variables ("c" vs. "d"). In another.
Following Nguyen, Nguyen, and Nguyen (2015) the real scenario, the
candidate is correct without doubt, and and Chen, Liu, and Song (2018),
we conduct experiments a human expert would give a score of 100.
However, its on a dataset crawled from several open-source projects,
i.e.,  Task Text-to-code Code translation Code refinement Sys1 Seq2Seq
PBSMT LSTM Sys2 Seq2Action+MAML1 Transformer Transformer Sys3 GPT22
Transformer+CodeBERT4 Transformer+CodeBERT4 Sys4 CodeGPT3 Human -

Table 1: The systems we choose for each task. Note that "Human" in this
table means the output is given by human program- ming experts. 1 (Guo
et al. 2019); 2 Fine-tune with GPT-2 (Radford et al. 2019); 3
Pre-trained GPT-2 with the Java data of Codesearchnet (Husain et
al. 2019) and then fine-tuning; 4 Fine-tune with CodeBERT (Feng et
al. 2020).

Lucene2 , POI3 , JGit4 , and Antlr5 . Those projects have both
Text-to-code Java and C# implementation. We paired the methods in the
two languages based on their file names and method names. System BLEU
Acc (100%) CodeBLEU Human score After removing duplication, the total
number of method Sys1 12.02 3.05 18.04 1.888 pairs is 11.8k, and we
split 0.5k pairs from them as the de- Sys2 16.82 10.50 21.71 1.99
velopment set and another 1k pairs for test. We will release Sys3 21.18
17.35 24.95 2.558 the code translation dataset with our scripts. Sys4
26.45 20.10 30.96 3.125 Code translation Code Refinement Code refinement
aims to automatically fix bugs in the code, which can contribute to
reducing the System BLEU Acc (100%) CodeBLEU Human score cost of
bug-fixing for developers. We use the dataset re- Sys1 44.53 13.2 45.71
3.25 leased by Tufano et al. (2019). The source is buggy Java Sys2 54.84
31.75 61.14 3.771 functions while the target is the according fixed
ones. Their Sys3 80.18 60.2 82.74 4.036 dataset contains two subsets (
i.e. small and medium) based Sys4 81.14 63.5 84.75 4.252 on the code
length. For the small dataset, the function num- Code refinement bers of
training, development and test samples are 46,680, 5,835 and 5,835. For
the medium dataset, the function num- System BLEU Acc (100%) CodeBLEU
Human score bers are 52,364, 6,545 and 6,545 respectively. Sys1 90.35
3.00 80.81 1.378 Sys2 91.40 7.01 82.16 1.545 4.2 Settings Sys3 92.80
17.6 83.85 2.022 For each task, we prepare 3 to 4 standard systems as
shown in Table 1. We randomly choose 500 samples from each test Table 2:
The results of all baselines of the given three tasks set for
evaluation. As for human evaluation, we have a group evaluated by BLEU,
accuracy (exactly match), CodeBLEU of human judges consisting of 10
people who are familiar and human evaluation scores. with Java and C#.
The humans judge our four systems on a subset of 50 samples extracted
randomly from our test set. We pair each input with its 4 outputs,
resulting in a total of • Is the difference in CodeBLEU metric reliable?
200 pairs of the given inputs and the output codes. We pre- • What is
the variance of the CodeBLEU score? pare a UI software with these
input-output pairs randomly ordered to disperse the 4 outputs of each
input. All judges • Is CodeBLEU more correlated with human scores than
use this same software and see the pairs in the same order. BLEU and
accuracy? They rated each output from 1 (very bad) to 5 (very good). To
answer these questions, first, following Papineni et al. (2002), we
divided the test set into 20 blocks of 25 sentences 4.3 Results each,
and computed CodeBLEU on these blocks individ- Main Results The main
results are shown in Table 2. ually. We thus have 20 samples of these
metrics for each In this table, we calculate BLEU scores, perfect
accuracy, system. We computed the means, variances, and paired t-
CodeBLEU and human evaluation scores for all systems of statistics for
them, which is displayed in Table 3. each task on the selected test set.
Note that the former three From Table 3, as expected, these two sets of
results are metrics are ranging from 0 to 100 and the last one is
ranging close for each system and differ only by small finite block from
1 (very bad) to 5 (very good). We find that some of the size effects.
Since a paired t-statistic of 1.7 or above is 95% systems are very close
in terms of BLEU and CodeBLEU significant, the differences between the
systems' scores are scores. Hence, some questions are raised.
statistically very significant. The reported variance on 25- sentence
blocks serves as an upper bound to the variance of 2
http://lucene.apache.org/ sizeable test sets like the 500 sentence
corpus. Therefore, 3 http://poi.apache.org/ we conclude that the
difference in the CodeBLEU metric is 4 https://github.com/eclipse/jgit/
reliable, and the variance of it is within a reasonable range. 5
https://github.com/antlr/ Next, we compare the correlation of BLEU,
accuracy and  Text-to-code Code translation Code refinement System Mean
StdDev t Mean StdDev t Mean StdDev t Sys1 17.93 1.8 - 44.62 5.2 - 79.21
5.6 - Sys2 20.67 2.9 7.4 60.04 5.8 30 81.04 5.8 2.1 Sys3 23.92 3.4 7
81.55 6.1 38 82.52 6.4 3.4 Sys4 30.13 4.2 12 83.26 6.7 5.2 - - -

Table 3: The mean, standard deviation and paired t-statistic of all
baselines of the given three tasks. The t-statistic compares each system
with the neighbor above it in the table.

                        Text-to-code Code trans Code ref

BLEU & human 0.967 0.940 0.923 Acc & human 0.912 0.968 0.999 0.977 0.970
0.979 CodeBLEU & human (+1.0) (+3.0) (+5.6)

Table 4: Comparison of the Pearson correlation coefficients between
human evaluation scores and three different met- rics. The numbers in
the brackets in the last row are the im- provements in percent compared
with BLEU.

CodeBLEU to human evaluation scores respectively. The Pearson
correlation coefficients are listed in Table 4. From the table, we see
CodeBLEU scores are more cor- related with human evaluation scores in
all the three tasks. The improvements are significant compared with the
tradi- Figure 5: BLEU and CodeBLEU predict human evaluation tional MT
metric BLEU. The results verify the effectiveness scores. (a)
Text-to-code; (b) Code translation. of our proposed metric. For
text-to-code and code transla- tion tasks, CodeBLEU scores are also more
correlated with Ablation Study To investigate the influence of the
differ- human scores than accuracy (Acc), but there is an exception ent
components of CodeBLEU, we conduct the following that the Acc is more
correlated for code refinement. This is experiment to calculate the
respective Pearson correlation because the data of refinement task is
just fixing small bugs between the human evaluation scores and the
scores given in a given Java function. The output is usually unique, and
by different components. The results are reported in Table 5. the humans
score the outputs based on the unique refine- ment way, so that the Acc
here correlates more with human evaluation scores. However, we also
believe that in the more Components Text-to-code Code trans Code ref
general code synthesis scenarios, CodeBLEU is more rea- BLEU 0.967 0.940
0.923 sonable in terms of the correlation with human scores. BLEUweight
0.960 0.934 0.985 Figure 5 shows the comparable regression results for
each Matchast 0.985 0.977 0.967 metric to human scores on the
text-to-code and code trans- Matchdf 0.978 0.974 0.983 lation tasks. The
R2 values of the linear regression are also CodeBLEU 0.977 0.970 0.979
shown in the figure. From the figure, we find CodeBLEU is more linearly
correlated with human evaluation scores than Table 5: The Pearson
correlation coefficients between dif- BLEU, which is consistent with the
results in Table 4. ferent components of CodeBLEU and humans. Based on
the above results and analysis, we conclude that: From the table, we
find that, for the text-to-code and code • The difference in CodeBLEU
metric is reliable. Code- translation tasks, the scores of the last two
components, BLEU is capable to differentiate code synthesis systems.
i.e., syntactic AST match and semantic data-flow match, are • CodeBLEU
is reliable, and its variance is within a reason- more relevant to human
evaluation scores compared with the able range. n-gram and weight n-gram
match scores. For the code refine- ment task, the scores given by the
weighted n-gram match • CodeBLEU is more correlated with human
evaluation and the semantic data-flow are more relevant to human eval-
scores than traditional BLEU scores on all the three tasks, uation. This
may be because many bugs in the refinement and more correlated than Acc
on the two tasks. training data are wrong variable naming or keywords
errors, while the weighted n-gram and semantic data-flow match
Combination α, β, γ, δ scores could evaluate them better. The above
result veri- \[1\] 0.40, 0.40, 0.10, 0.10 fies the effectiveness of our
three proposed components, i.e., \[2\] 0.35, 0.35, 0.15, 0.15 weighted
n-gram match, syntactic AST match and semantic \[3\] 0.30, 0.30, 0.20,
0.20 data-flow match, for code synthesis evaluation. Besides, the \[4\]
0.25, 0.25, 0.25, 0.25 results are inspiring for us to change the
hyper-parameters \[5\] 0.20, 0.20, 0.30, 0.30 α, β, γ, δ in Eq. (1) to
get better evaluation whose results \[6\] 0.15, 0.15, 0.35, 0.35 are
more correlated with humans. For example, to achieve \[7\] 0.10, 0.10,
0.40, 0.40 this, we can increase γ and δ to improve the weights of the
last two components in the final CodeBLEU scores. In the Table 6: The
settings of each combination in Figure 6. next section, we will conduct
experiments to investigate the influence of the four hyper-parameters. 5
Related Work 4.4 Influence of hyper-parameters As code artificial
intelligence receives more and more at- In the above subsection, we find
different components have tention (Allamanis et al. 2015; Yin and Neubig
2017; Al- a different influence on the final results of CodeBLEU lamanis
et al. 2018; Monperrus 2018; Alon et al. 2019; in terms of the
correlation with human evaluation scores. Svyatkovskiy et al. 2020), the
evaluation of code synthe- Therefore, we can change the weights of those
components sis becomes critical to promote its development. Although to
achieve a higher correlation between CodeBLEU and hu- there are several
automatic evaluation methods, which can man evaluation. We gradually
increase the weights of the be used to evaluate code synthesis
(Karaivanov, Raychev, last two components (as in Table 6) and record the
correla- and Vechev 2014; Chen, Liu, and Song 2018; Lachaux et al. tion
coefficients between CodeBLEU and human evaluation 2020), these
approaches still suffer from many weakness and scores for the three
tasks. The results are shown in Figure 6. are not suitable to evaluate
code. From the figure, we find that increasing the weights of The widely
used 4-gram BLEU (Papineni et al. 2002) the last two components improves
the correlation between evaluates the code quality by using the relative
over- CodeBLEU and human scores for all of the three tasks. lap between
the tokens in the hypothesis and reference The performance starts to
converge after the combination \[4\] (Karaivanov, Raychev, and Vechev
2014; Barone and Sen- and the combination \[7\], i.e., α, β, γ, δ = 0.1,
0.1, 0.4, 0.4, nrich 2017). Nevertheless, BLEU ignores the grammatical
achieves the best result among all the combinations in Fig- correctness
and logic correctness. The perfect accuracy (Ra- ure 6 (0.981, 0.975,
0.980 for the three tasks respectively). binovich, Stern, and Klein
2017; Chen, Liu, and Song 2018) Of course, \[7\] is not the best
combination all the time. For is too strict and it is an underestimation
of the true accuracy example, α, β, γ, δ = 0.1, 0.4, 0.1, 0.4 achieves
the better based on semantic equivalence. Additionally, the computa-
result (the correlation coefficient is 0.984) than the combi- tional
accuracy (Lachaux et al. 2020), evaluating whether nation \[7\] (the
correlation coefficient is 0.980) for the code the hypothesis function
generates the same outputs given refinement task. In spite of this, we
recommend to choose the same inputs by performing code, locks
universality and the combination \[7\] when calculating CodeBLEU for
gen- practicability. To overcome the limitation, our proposed sim- eral
code synthesis tasks, because the last two components ple and effective
CodeBLEU can not only consider the sur- are more likely to be more
correlated with human evaluation face match similar with the original
BLEU, but can also con- scores from the instinct given by Table 4. sider
the grammatical correctness and the logic correctness.

                                                                                         6    Conclusion
                                                                  In this paper, we propose a novel metric CodeBLEU for
                                                                  code synthesis evaluation. CodeBLEU evaluates the candi-
                                                                  date code pieces considering not only the shallow match, but
                                                                  also the syntactic match and the semantic match. The results
                                                                  of three real-world tasks, i.e. text-to-code, code translation
                                                                  and code refinement, demonstrate the rationality and effec-
                                                                  tiveness of CodeBLEU by analyzing the correlation with hu-
                                                                  man evaluation scores from different granularity. In the fu-
                                                                  ture work, we will delve more into the evaluation of syntac-
                                                                  tic and semantic match and try more tasks with CodeBLEU
                                                                  to show its practicality.

Figure 6: The correlation coefficients between CodeBLEU References and
human scores with different hyper-parameters. The hyper-parameter
setting of each combination is in Table 6. Allamanis, M.; Barr, E. T.;
Devanbu, P.; and Sutton, C. 2018. A survey of machine learning for big
code and naturalness. ACM Computing Surveys (CSUR) 51(4): 1--37.
Allamanis, M.; Tarlow, D.; Gordon, A.; and Wei, Y. 2015. 74--81.
Barcelona, Spain: Association for Computational Bimodal modelling of
source code and natural language. In Linguistics. URL
https://www.aclweb.org/anthology/W04- International conference on
machine learning, 2123--2132. 1013. Alon, U.; Zilberstein, M.; Levy, O.;
and Yahav, E. 2019. Monperrus, M. 2018. Automatic software repair: a
bibliog- code2vec: Learning distributed representations of code. Pro-
raphy. ACM Computing Surveys (CSUR) 51(1): 1--24. ceedings of the ACM on
Programming Languages 3(POPL): Nguyen, A. T.; Nguyen, T. T.; and Nguyen,
T. N. 2015. 1--29. Divide-and-conquer approach for multi-phase
statistical mi- Bahdanau, D.; Cho, K.; and Bengio, Y. 2014. Neural ma-
gration for source code (t). In 2015 30th IEEE/ACM In- chine translation
by jointly learning to align and translate. ternational Conference on
Automated Software Engineering arXiv preprint arXiv:1409.0473 . (ASE),
585--596. IEEE. Barone, A. V. M.; and Sennrich, R. 2017. A parallel cor-
Oda, Y.; Fudaba, H.; Neubig, G.; Hata, H.; Sakti, S.; Toda, pus of
Python functions and documentation strings for au- T.; and Nakamura, S.
2015. Learning to generate pseudo- tomated code documentation and code
generation. arXiv code from source code using statistical machine
translation preprint arXiv:1707.02275 . (t). In 2015 30th IEEE/ACM
International Conference on Chen, X.; Liu, C.; and Song, D. 2018.
Tree-to-tree neural Automated Software Engineering (ASE), 574--584.
IEEE. networks for program translation. In Advances in neural Papineni,
K.; Roukos, S.; Ward, T.; and Zhu, W.-J. 2002. information processing
systems, 2547--2557. BLEU: a method for automatic evaluation of machine
trans- Dinella, E.; Dai, H.; Li, Z.; Naik, M.; Song, L.; and Wang, K.
lation. In Proceedings of the 40th annual meeting of the 2020. Hoppity:
Learning Graph Transformations to Detect Association for Computational
Linguistics, 311--318. and Fix Bugs in Programs. In International
Conference on Rabinovich, M.; Stern, M.; and Klein, D. 2017. Abstract
Learning Representations. syntax networks for code generation and
semantic parsing. Feng, Z.; Guo, D.; Tang, D.; Duan, N.; Feng, X.; Gong,
M.; arXiv preprint arXiv:1704.07535 . Shou, L.; Qin, B.; Liu, T.; Jiang,
D.; et al. 2020. Codebert: A Radford, A.; Wu, J.; Child, R.; Luan, D.;
Amodei, D.; and pre-trained model for programming and natural languages.
Sutskever, I. 2019. Language models are unsupervised mul- arXiv preprint
arXiv:2002.08155 . titask learners. OpenAI Blog 1(8): 9. Guo, D.; Ren,
S.; Lu, S.; Feng, Z.; Tang, D.; Liu, S.; Zhou, Sutskever, I.; Vinyals,
O.; and Le, Q. V. 2014. Sequence L.; Duan, N.; Yin, J.; Jiang, D.; et
al. 2020. GraphCode- to sequence learning with neural networks. In
Advances in BERT: Pre-training Code Representations with Data Flow.
neural information processing systems, 3104--3112. arXiv preprint
arXiv:2009.08366 . Svyatkovskiy, A.; Deng, S. K.; Fu, S.; and
Sundaresan, N. Guo, D.; Tang, D.; Duan, N.; Zhou, M.; and Yin, 2020.
IntelliCode Compose: Code Generation Using Trans- J. 2019. Coupling
Retrieval and Meta-Learning for former. arXiv preprint arXiv:2005.08025
. Context-Dependent Semantic Parsing. arXiv preprint Tufano, M.; Watson,
C.; Bavota, G.; Penta, M. D.; White, arXiv:1906.07108 . M.; and
Poshyvanyk, D. 2019. An empirical study on learn- Husain, H.; Wu, H.-H.;
Gazit, T.; Allamanis, M.; and ing bug-fixing patches in the wild via
neural machine trans- Brockschmidt, M. 2019. Codesearchnet challenge:
Eval- lation. ACM Transactions on Software Engineering and uating the
state of semantic code search. arXiv preprint Methodology (TOSEM) 28(4):
1--29. arXiv:1909.09436 . Vaswani, A.; Shazeer, N.; Parmar, N.;
Uszkoreit, J.; Jones, Iyer, S.; Konstas, I.; Cheung, A.; and
Zettlemoyer, L. 2018. L.; Gomez, A. N.; Kaiser, Ł.; and Polosukhin, I.
2017. At- Mapping Language to Code in Programmatic Context. In tention
is all you need. In Advances in Neural Information Proceedings of the
2018 Conference on Empirical Methods Processing Systems, 6000--6010. in
Natural Language Processing, 1643--1652. Weaver, W. 1955. Translation.
Machine translation of lan- Kanade, A.; Maniatis, P.; Balakrishnan, G.;
and Shi, K. guages 14(15-23): 10. 2019. Pre-trained contextual embedding
of source code. Yin, P.; and Neubig, G. 2017. A Syntactic Neural Model
for arXiv preprint arXiv:2001.00059 . General-Purpose Code Generation.
In Proceedings of the Karaivanov, S.; Raychev, V.; and Vechev, M. 2014.
Phrase- 55th Annual Meeting of the Association for Computational based
statistical translation of programming languages. In Linguistics (Volume
1: Long Papers), 440--450. Vancouver, Proceedings of the 2014 ACM
International Symposium on Canada: Association for Computational
Linguistics. New Ideas, New Paradigms, and Reflections on Program- Zhou,
L.; Zhang, J.; Zong, C.; and Yu, H. 2019. Sequence ming & Software,
173--184. generation: From both sides to the middle. In Proceedings
Lachaux, M.-A.; Roziere, B.; Chanussot, L.; and Lample, of IJCAI 2019.
G. 2020. Unsupervised Translation of Programming Lan- guages. arXiv
preprint arXiv:2006.03511 . Lin, C.-Y. 2004. ROUGE: A Package for
Automatic Evalu- ation of Summaries. In Text Summarization Branches Out,

