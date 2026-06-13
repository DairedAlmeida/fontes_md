                       CrystalBLEU: Precisely and Efficiently Measuring
                                   the Similarity of Code
                                    Aryaz Eghbali                                                                     Michael Pradel
                      aryaz.eghbali@iste.uni-stuttgart.de                                                        michael@binaervarianz.de
                            University of Stuttgart                                                               University of Stuttgart
                              Stuttgart, Germany                                                                    Stuttgart, Germany

ABSTRACT ACM Reference Format: Recent years have brought a surge of work
on predicting pieces Aryaz Eghbali and Michael Pradel. 2022.
CrystalBLEU: Precisely and Ef- ficiently Measuring the Similarity of
Code. In 37th IEEE/ACM Interna- of source code, e.g., for code
completion, code migration, program tional Conference on Automated
Software Engineering (ASE '22), October repair, or translating natural
language into code. All this work faces 10--14, 2022, Rochester, MI,
USA. ACM, New York, NY, USA, 12 pages. https: the challenge of
evaluating the quality of a prediction w.r.t. some
//doi.org/10.1145/3551349.3556903 oracle, typically in the form of a
reference solution. A common evaluation metric is the BLEU score, an
n-gram-based metric orig- inally proposed for evaluating natural
language translation, but 1 INTRODUCTION adopted in software engineering
because it can be easily computed The desire to automate repetitive
software development tasks has on any programming language and enables
automated evaluation at led to a surge in techniques for predicting
pieces of code of vary- scale. However, a key difference between natural
and programming ing sizes. Many of these techniques build on the huge
amounts languages is that in the latter, completely unrelated pieces of
code of available source code to learn some kind of predictive model,
may have many common n-grams simply because of the syntactic e.g., using
deep neural networks \[39\]. Code prediction techniques verbosity and
coding conventions of programming languages. We include code completion
\[4, 22, 23, 26, 46\], code translation be- observe that these trivially
shared n-grams hamper the ability of tween programming languages \[32,
33, 43\], automated program the metric to distinguish between truly
similar code examples and repair \[11, 12, 16, 24, 49\], predicting code
from natural language de- code examples that are merely written in the
same language. This scriptions of the desired functionality \[15, 21,
27, 44, 47\], injecting paper presents CrystalBLEU, an evaluation metric
based on BLEU, bugs and vulnerabilities into existing code \[34, 37\],
and predicting that allows for precisely and efficiently measuring the
similarity of test oracles and test cases \[6\]. The amount of predicted
code dif- code. Our metric preserves the desirable properties of BLEU,
such fers across techniques, ranging from a few tokens, over multi-line
as being language-agnostic, able to handle incomplete or partially
statements, to entire code files. incorrect code, and efficient, while
reducing the noise caused by A commonality of all these techniques is
the need for a metric trivially shared n-grams. We evaluate CrystalBLEU
on two datasets to evaluate the quality of the predicted code. One of
the most from prior work and on a new, labeled dataset of semantically
equiv- popular ways to address this need is the BLEU score. BLEU, which
alent programs. Our results show that CrystalBLEU can distinguish stands
for "bilingual evaluation understudy", has originally been similar from
dissimilar code examples 1.9--4.5 times more effec- introduced in
natural language processing as a way to automate tively, when compared
to the original BLEU score and a previously the evaluation of machine
translation \[36\]. Because BLEU can be proposed variant of BLEU for
code. easily adopted to any language that can be tokenized, including
any programming language, and because BLEU enables automated CCS
CONCEPTS evaluation at scale, it has become popular also for evaluating
code • General and reference → Metrics; Evaluation; • Software and
prediction techniques. While surveying recent papers in software its
engineering → Software notations and tools; • Computing engineering, we
find at least 21 papers published since 2015 that methodologies →
Machine learning. use BLEU as a metric to evaluate code prediction. The
basic idea of BLEU is to compare a prediction against one or more
reference solutions by computing the overlap between KEYWORDS n-grams,
i.e., contiguous sequences of code tokens. Figure 1 illus- BLEU,
Evaluation, Metric trates this idea for comparing two predicted
hypotheses against a reference solution. These pieces of code are
slightly modified examples taken from a dataset of programs submitted to
an online Permission to make digital or hard copies of all or part of
this work for personal or classroom use is granted without fee provided
that copies are not made or distributed environment for competitive
programming practice, where sub- for profit or commercial advantage and
that copies bear this notice and the full citation sets of programs are
labeled as semantically equivalent. The figure on the first page.
Copyrights for components of this work owned by others than the
highlights some of the matching n-grams by showing them in the author(s)
must be honored. Abstracting with credit is permitted. To copy
otherwise, or republish, to post on servers or to redistribute to lists,
requires prior specific permission same color. For example, the four
tokens in "());" occur in both the and/or a fee. Request permissions
from permissions@acm.org. hypotheses and the reference code, and hence
are a shared 4-gram. ASE '22, October 10--14, 2022, Rochester, MI, USA
BLEU summarizes the similarity between the code pieces based on © 2022
Copyright held by the owner/author(s). Publication rights licensed to
ACM. ACM ISBN 978-1-4503-9475-8/22/10. . . \$15.00 this and other shared
n-grams, giving a higher score when more
https://doi.org/10.1145/3551349.3556903 n-grams are shared between a
hypothesis and the reference.  ASE '22, October 10--14, 2022, Rochester,
MI, USA Aryaz Eghbali and Michael Pradel

1 // Reference : n-grams, CrystalBLEU analyzes a corpus of code and
identifies 2 import java . util .\*; 3 public class Main { n-grams that
occur frequently across many examples. While con- 4 public static void
main ( String \[\] args ) { ceptually simple, we find this change to
significantly improve the 5 Scanner in = new Scanner ( System . in );
ability of the metric to distinguish between semantically similar and 6
int t = in . nextInt () ; dissimilar code. Similar to BLEU, CrystalBLEU
relies only on syn- 7 in . nextLine () ; tactic similarities and uses
them as a proxy for estimating semantic 8 while ( t -- \> 0 ) {
similarity. As a way to quantify the improvement in differentiating 9
System . out.println( new StringBuffer ( in . nextLine () ). reverse
semantically similar and dissimilar code, we formulate in a novel ());
meta-metric called distinguishability. In a nutshell, distinguishabil-
10 } 11 } ity measures how much more similar code examples known to be
12 } semantically equivalent are compared to code examples that are 13
// Hypothesis 1: equivalent to the reference not equivalent to each
other. 14 import java . util . Scanner ; 15 public class Main { We
evaluate our work with three datasets. One dataset is the 16 public
static void main ( String argv \[\] ) { Concode dataset \[21\], which
consists of more than 100,000 pairs of 17 int num_of_tests = 0; Java
code and natural language descriptions. We use this dataset 18 Scanner
in = new Scanner ( System . in ); to show a case for which BLEU is not a
suitable metric when com- 19 num_of_tests = Integer . parseInt ( in .
nextLine () ); paring models, while CrystalBLEU can provide useful
comparison. 20 for ( int i =0; i \< num_of_tests ; i ++ ) { 21
StringBuilder rev_str = new StringBuilder ( in . nextLine () ); Another
dataset is BigCloneBench \[45, 51\], which consists of more 22 System .
out.println( rev_str . reverse ()); than 1.7 million pairs of clone and
non-clone programs in Java. We 23 } also use a new dataset of Java and
C++ programs with labels that in- 24 } dicate sets of semantically
equivalent programs from ShareCode.io, 25 } 26 // Hypothesis 2: not
equivalent to the reference which consists of more than 6,000 Java and
more than 20,000 C++ 27 import java . util . Scanner ; programs. These
two datasets allow us to evaluate similarity met- 28 public class Main {
rics on objective ground truths. We compare CrystalBLEU against 29
public static void main ( String \[\] args ) { two baselines: the
original BLEU score \[36\] and CodeBLEU \[41\], a 30 Scanner in = new
Scanner ( System . in ); previously proposed variant of BLEU for code.
Our results show 31 while ( in . hasNext () ) that CrystalBLEU provides
higher distinguishability than both base- 32 System . out.println( in .
nextInt () + in . nextInt ()); lines, i.e., it is more effective at
distinguishing semantically similar 33 } 34 } code from code merely
written in the same language. Despite these 35 benefits, the running
time of CrystalBLEU and BLEU are similar, making our metric attractive
for large-scale and even online evalu- Figure 1: Example of Java
programs. ation of code similarity, e.g., as part of a loss function for
training a machine learning model. In our example from Fig. 1, the BLEU
score for Hypothesis 1 and The example not only illustrates how BLEU
works, but also high- the Reference is 0.48, and for Hypothesis 2 and
the Reference it is lights an important weakness of applying the metric
to code. In 0.55. However, we expect to get a higher similarity score
for the contrast to natural languages, programming languages are syntac-
equivalent pair, which is not the case in this example. The example
tically verbose in the sense that the grammar prescribes various shows
how trivially shared n-grams can mislead the BLEU score to n-grams to be
shared across completely unrelated code examples. report a higher
similarity for dissimilar code pieces than for similar For example, the
2-gram ") {", which is shared between all three ones. In contrast to
BLEU, the CrystalBLEU score for Hypothesis 1 examples in Fig. 1, is
simply the result of the grammar, but does and the Reference is 0.24,
and for Hypothesis 2 and the Reference it not imply any semantic
similarity. Beyond syntax verbosity, com- is 0.0. That is, CrystalBLEU
more accurately represents the semantic mon coding conventions and
widely used APIs create even more (dis)similarities than BLEU. n-grams
shared across unrelated code, such as the shared 4-grams Prior work has
also highlighted weaknesses of applying BLEU "out.println(" in the
example. We call this phenomenon trivially to code and proposed two
alternative metrics, RUBY \[48\] and Code- shared n-grams, i.e., n-grams
that occur across code written in the BLEU \[41\]. They exploit the fact
that code has a well-defined struc- same language without implying any
deeper relationship or se- ture, in the form of an AST, and well-defined
relationships between mantic similarity. Because BLEU handles every
n-gram the same, code elements, in the form of data-flow and
control-flow depen- trivially shared n-grams hamper the metric's ability
to distinguish dencies. However, both approaches are only applicable
when it is actually similar code examples from examples merely written
in possible to compute an abstract syntax tree and semantic dependen-
the same language. cies of the analyzed code pieces. Because code
prediction techniques This paper presents CrystalBLEU, a metric to
precisely and ef- often output isolated code fragments, e.g., catch
blocks \[54\], and ficiently evaluate code similarity despite trivially
shared n-grams. because the predicted code may contain syntactic and
semantic The approach is an extension of BLEU that removes trivially
shared mistakes, calculating ASTs and dependencies may not be possible.
n-grams before computing the n-gram overlap between two pieces Even when
that is possible, relying on program analysis means of code. Trivially
shared n-grams can vary between programming that a separate
implementation is required for each programming languages and domains of
programs. To identify trivially shared CrystalBLEU: Precisely and
Efficiently Measuring the Similarity of Code ASE '22, October 10--14,
2022, Rochester, MI, USA

language and that the metrics are less efficient than BLEU and Crys- The
modified n-gram precision values for all 𝑛 ∈ {1, . . . , 𝑚𝑎𝑥𝑁 } talBLEU.
Finally, RUBY and CodeBLEU partially build upon BLEU, are combined using
the weighted geometric mean to mitigate the and hence, also suffer from
trivial n-gram matches. The CodeBLEU exponential drop for larger 𝑛. To
decrease the calculation errors score for Hypothesis 1 and the Reference
from Fig. 1 is 0.51, and and avoid underflows, the weighted geometric
mean is calculated for Hypothesis 2 and the Reference it is 0.57, which
means the using the weighted arithmetic mean over the logs of the
modified equivalent pair receives a higher score than the non-equivalent
precision values and exponentiated at the end, as shown in Eq. (1).
pair. In \[36\] and all the papers mentioned in this study, the weighted
In summary, this paper contributes the following: arithmetic mean is
calculated using equal weights. To avoid favoring • The observation that
the most common n-grams in program- hypotheses that are shorter than
their reference sentences, which ming languages appear relatively more
often than the most gives a higher modified precision, a penalty is
multiplied with this common n-grams in natural languages, and that they
ap- result, called the brevity penalty. This penalty is calculated over
pear in many different programs regardless of their semantic the whole
corpus, to avoid punishing hypothesis sentences for not similarity.
being of equal length to their corresponding references. Therefore, • A
meta-metric, called distinguishability, to measure the ef- for each
hypothesis sentence, the length of the reference sentence fectiveness of
code similarity metrics at distinguishing se- that is closest to the
length of the hypothesis is added to a sum, 𝑟 . mantically equivalent
code from code merely written in the The total length of the hypothesis
corpus is denoted as 𝑐. If 𝑟 \< 𝑐, same language. then the brevity
penalty is 1, otherwise, it is 𝑒 1−𝑟 /𝑐 . In our example, • A new metric
for evaluating code similarity, called Crystal- since the first
hypothesis is longer than the reference, the brevity BLEU, which ignores
trivially shared n-grams when compar- penalty is one, i.e., no penalty,
but because the second hypothesis ing two pieces of code. is shorter
than the reference, the brevity penalty is 𝑒 1−77/58 . • Empirical
evidence that, compared to BLEU, CrystalBLEU To summarize, the BLEU
score is calculated with the following achieves higher
distinguishability, while being as efficient formula as the original
metric. We also show that CrystalBLEU helps 𝑚𝑎𝑥𝑁 ! 𝑟 ∑︁ avoid drawing
misleading conclusions about neural code 𝐵𝐿𝐸𝑈 = 𝑒𝑥𝑝 𝑚𝑖𝑛(1 − , 0) + 𝑤𝑖
log 𝑝𝑖 , (1) 𝑐 prediction models. 𝑖=1 where, 𝑤𝑖 is the weight and 𝑝𝑖 is
the modified precision of 𝑖-grams. 2 BACKGROUND Since the BLEU score is
calculated using the geometric mean 2.1 BLEU Score of the modified
precision values. If at least one of the modified precision values is
zero, the BLEU score is also zero. To mitigate The bilingual evaluation
understudy, commonly referred to as BLEU, this rapid drop, some
smoothing techniques have been proposed \[9\]. was proposed by Papineni
et al. \[36\] as an inexpensive metric to evaluate the quality of
translated natural language text. It is cal- 2.2 BLEU on Code culated by
first computing the modified precision of n-grams, for 𝑛 ∈ {1, 2, . . .
, 𝑚𝑎𝑥𝑁 }. Then, the weighted geometric mean of these In recent years
research in automated code generation has increased, modified precision
values, times a brevity penalty, yields the BLEU and with that increase
comes the need for evaluation metrics. One of score, a number in \[0,
1\]. To be self-contained, we briefly explain the commonly used metrics
for code similarity is BLEU, since it can how BLEU is computed with the
assistance of the example in Fig. 1, handle different programming
languages ranging from VHDL \[25\], and refer readers to Papineni et
al. \[36\] and NLTK's implementation custom languages \[31\], and UI
tags \[10\], to more conventional of BLEU1 for more details. languages
like Java \[15, 27, 47, 52, 54\], C++ \[17, 43\], and Python \[29, Given
a corpus of hypotheses and their reference sentences 30, 44\]. Another
appeal of BLEU lies in its applicability to any piece (one or more
reference sentences per hypothesis sentence), the of code, regardless of
syntactic correctness or completeness. It has modified precision of
n-grams, for a fixed value of 𝑛, is computed as been used to assess a
variety of code sizes such as code on the follows. First, for each
n-gram a clipped count is calculated, which right-hand side of
assignments \[25\], single statements \[52\], single is the minimum of
the number of occurrences of that n-gram in the lines of code \[13,
35\], sequences of API calls \[15, 27, 47\], blocks of hypothesis
sentence and the maximum number of occurrences in code \[54\], full
methods \[21, 32, 33\], and full classes \[44\]. the reference
sentences. For the example in Fig. 1, ") {" appears Applying BLEU to
source code raises the question what a sen- once in Hypothesis 1 and
twice in the reference, so the clipped tence is. In natural language,
one sentence from the hypothesis count for this 2-gram is two. The
3-gram "for ( int" appears corpus is associated with one sentence from
each corresponding once in Hypothesis 1 and the 3-gram "hasNext()"
appears once reference, but for source code there exists no such obvious
associa- in Hypothesis 2 but none of them appear in the reference, which
tion. Therefore, BLEU is commonly applied to code by considering make
their clipped counts zero. Second, for each 𝑛 ∈ {1, . . . , 𝑚𝑎𝑥𝑁 } an
entire source code snippet as one sentence. these clipped counts are
summed for all n-grams in each hypothesis sentence and summed over all
hypothesis sentences in the corpus. 3 APPROACH Then, this sum is divided
by the sum of all n-gram counts of all the This section presents the
CrystalBLEU metric for measuring the hypothesis sentences, hence the
name modified precision. similarity of code in a precise and efficient
way. We start by motivat- ing our work through the observation that
natural languages and 1
https://www.nltk.org/\_modules/nltk/translate/bleu_score.html
programming languages differ in that the latter has a higher number ASE
'22, October 10--14, 2022, Rochester, MI, USA Aryaz Eghbali and Michael
Pradel

                                                                         Table 1: Top common 2-grams and 4-grams of Java and Eng-
                                                                         lish languages.
                                      Code              Predictive
                                     corpus               model
                                                                                      2-grams     % of 2-grams                         4-grams       % of 4-grams
                                                                                         ) ;                 5.49                ) ; } }                     1.34
                                  Reference                 Hypothesis                   ( )                 4.75           ( ) { return                     1.29
                                                                                         ) {                 3.83                ( ) ; }                     1.14
                                                                                         ; }                 3.81                ) ) ; }                     1.12
                 Trivially
                  shared                                                    Java    ; import                 2.75           ) ; } public                     1.00
                 n-grams                                                                 ) )                 1.73                ( ) ) ;                     0.94
                                              CrystalBLEU                           } public                 1.27             ) { this .                     0.68
                                                                                    { return                 1.24        ; } public void                     0.61
                                                                                         } }                 1.07   ; } @Override public                     0.54
                                         Similarity score                                ) .                 0.99               ) { if (                     0.54
                                                                                        of the               2.31                    ” , he said             0.56
                                                                                         , and               1.45                     , he said ,            0.32
                Figure 2: Overview of the approach.                                     in the               1.31                  , of course ,             0.31
                                                                                             ”.              1.01                       ” , I said           0.29
                                                                         English          , the              0.85                   ” , she said             0.29
                                                                                        to the               0.85                     , he said .            0.27

of trivially shared n-grams (Section 3.1). We then describe a novel ."
0.64 "."I 0.22 meta-metric, called distinguishability, for assessing to
what extent ", 0.63 he said , " 0.21 a code similarity metric
distinguishes between semantically similar on the 0.57 " ? asked . 0.19
, but 0.53 , I said . 0.19 code and code merely written in the same
language (Section 3.2). Finally, we present the CrystalBLEU metric,
which addresses the problem of trivially shared n-grams in a way that
increases distin- relationship beyond the fact that they print
something. Another guishability compared to BLEU (Section 3.3). example
would be the main function in languages like C++ and Figure 2 shows an
overview of the approach for computing Java, where the signature and the
name are in most cases fixed. CrystalBLEU. The core idea is to identify
trivially shared n-grams To validate our hypothesis that trivially
shared n-grams are a in a representative corpus of code, e.g., the
corpus used to train programming language-specific phenomenon, we
present three the predictive model, and to then account for the n-grams
while experiments. comparing a reference code example to the hypothesis
predicted by the model. Most frequent n-grams. Table 1 illustrates the
phenomenon with examples from English and Java. The English language
data is 3.1 Trivially Shared N-grams extracted from the Brown dataset2 ,
which is commonly used in the Natural languages and programming
languages share many com- area of natural language processing. As a Java
corpus, we use the monalities \[18\], an observation exploited in
various approaches that Java-small dataset3 , which consists of
open-source projects. The adapt techniques from natural language
processing to code \[1, 39\]. table shows the ten most frequent 2-grams
and 4-grams in Java In particular, these similarities have motivated the
use of BLEU on code and English text. Next to the n-grams, the table
also shows code. However, we observe an important difference between the
the percentage of all occurrences that a specific n-gram contributes.
two kinds of languages, which affects the adoption of BLEU to code: The
percentages of the most frequent are clearly higher for Java Code
examples written in the same programming language trivially than for
English, showing that common n-grams contribute a larger share various
n-grams, irrespective of how semantically similar two share in Java. For
example, the five most common 2-grams in Java code examples are. We call
such n-grams trivially shared n-grams. each contribute more than 2.5% of
all 2-grams in Java, whereas even Trivially shared n-grams are mainly
due to two reasons. The the single-most common 2-gram in English
contributes less than first reason is that the syntax of a programming
language often 2.5%. enforces multiple tokens to appear together. For
example, in many Distribution of frequent n-grams. To further validate
our hypoth- programming languages the structure of a "for" loop is fixed
and esis that trivially shared n-grams are particularly prevalent in
pro- causes several n-grams to appear no matter what exactly the loop is
gramming languages, we extend our measurement of the frequen- about,
such as "for (" or ") {". Grammar-induced, trivially shared n- cies of
common n-grams in both natural language and code corpora grams are
particularly common in programming languages because beyond the top 10
examples shown in Table 1. Figure 3 shows the they have a well defined
grammar and an often verbose syntax. This frequencies of the top
occurring n-grams in English and Java, using is inherently different
from natural languages, where the grammar the same datasets as above.
The chart axes are in log scale to show is more relaxed and enforces
minimal syntactical notations. the fact that a few most occurring
n-grams in programming lan- The second reason for trivially shared
n-grams are common guages are much more frequent than the most occurring
n-grams coding conventions and popular APIs, which cause similar code in
natural languages, but for the less frequent n-grams (i.e. the tails
fragments to appear across various programs. For example, all Java
programs with a "System.out.println(...);" statement share sev- 2
Available in NLTK's data at http://www.nltk.org/nltk_data/.

eral n-grams of different sizes, without having any strong semantic 3
Used in Alon et al. \[3\] and available at
https://github.com/tech-srl/code2seq/#datasets.  CrystalBLEU: Precisely
and Efficiently Measuring the Similarity of Code ASE '22, October
10--14, 2022, Rochester, MI, USA

                       10 1                                                                                                                                       English

same-length n-grams)

                                                                                                                                                                  Java

Frequency (share of

                       10 2

                       10 3

                       10 4

                       10 5
                                  100 101 102 103                    100 101 102 103                  100 101 102 103                      100 101 102 103
                                    Most occurring 1-grams             Most occurring 2-grams           Most occurring 3-grams               Most occurring 4-grams

Figure 3: Frequency of the most common Java n-grams (blue, from
Java-small dataset) and English n-grams (red, from Brown dataset). Both
plot axes use log scale to better visualize the differences.

                                                                                                curves for English and French languages are on top of each other
                            600                                                                 (the red and blue curve with the highest peak), but have a small
                                                                             English            difference in their distribution (the mean for English is 0.08 and the
                            500                                              French             mean for French in 0.10).
                                                                             Python
                            400                                              Java
          Number of pairs




                                                                             C/C++              How do n-grams that are common across a corpus influence the
                            300                                                                 BLEU score? Because the metric does not differentiate between n-
                                                                                                grams based on their frequency, each n-gram contributes equally to
                            200                                                                 the computed similarity. That is, the more n-grams trivially match
                                                                                                even for completely unrelated code examples, the less precisely
                            100                                                                 can BLEU represent whether two code examples are semantically
                              0                                                                 similar or dissimilar. The idea behind CrystalBLEU is to mitigate
                                  0.0    0.2         0.4      0.6      0.8        1.0           this effect by focusing on more informative n-gram matches.
                                               Ratio of shared n-grams

Figure 4: Ratio of shared n-grams in English, French, Python, 3.2
Distinguishability Java, and C/C++. Before describing how CrystalBLEU
addresses the challenge of trivially shared n-grams, the following
presents a way to measure how precisely any code similarity metric
represents semantic sim- of the distribution) it is the opposite. We see
that there are tens ilarities. To this end, we exploit the fact that
code, in contrast to of n-grams in Java that appear many times (much
more than the natural language, provides an unambiguous oracle for
semantic most common n-grams of the English language), while less com-
equivalence through its execution semantics. Intuitively, a metric mon
n-grams in the English language appear more than the less should report
a higher similarity for code examples that have the common n-grams in
Java. In other words, common n-grams occur same execution behavior,
while reporting a lower similarity for more frequently in Java than in
English. code examples with different behavior. N-grams shared by
randomly selected pairs. As a third experiment, We formulate this
intuition into the notion of the distinguishabil- we randomly select
code or text examples in the same language ity of a similarity metric as
follows. Suppose a similarity metric 𝑚 and compute how many n-grams they
share, as shown in Fig. 4. and set 𝐶 of source code examples. The metric
is given a set of pairs, In addition to the datasets used above, we also
show results for where each pair consists of a set of reference code
examples and French using the Europarl French-English dataset4 , Python
using a hypothesis to evaluate against the references. For example, the
the Python150k dataset5 , and C/C++ using the POJ-104 dataset6 .
references in such a pair may be one or more known to be correct We
observe that, on average, two random programs share more code snippets
and the hypothesis is a code snippet predicted by n-grams than two
random pieces of natural language text. This some model. Formally, 𝑚 : P
(P (𝐶) ×𝐶)) → R ≥0 , where P denotes means that given two pieces of
code, regardless of their semantic the power set, and R ≥0 is the set of
non-negative real-valued scores similarity, they are expected to have
more n-grams in common than the metric may compute. two pieces of text
in a natural language like English. Note that the Further suppose the
set 𝐶 of source code examples is composed of a disjoint set of
equivalence classes 𝐶 1, 𝐶 2, . . . , 𝐶𝑛 that represent se- 4 Available
at https://www.statmt.org/europarl/ 5 Available at
https://www.sri.inf.ethz.ch/py150 mantically equivalent code examples.
That is, 𝐶 1 ∪𝐶 2 ∪· · ·∪𝐶𝑛 = 𝐶, 6 Available at
https://github.com/microsoft/CodeXGLUE/tree/main/Code-Code/Clone- and
for each 𝑖 ∈ {1, . . . , 𝑛}, all programs in 𝐶𝑖 are equivalent to
detection-POJ-104 each other but not equivalent to any program in 𝐶 𝑗
for 𝑗 ≠ 𝑖. Given ASE '22, October 10--14, 2022, Rochester, MI, USA Aryaz
Eghbali and Michael Pradel

these sets, a metric has high distinguishability if it yields high simi-
Concode is trained on. Throughout this paper we use 𝑘 = 500 for larity
scores for code examples within an equivalence class, called our
experiments and explain this decision in detail in Section 4.6.
intra-class similarity, but low similarity scores for code examples from
different equivalence classes, called inter-class similarity: Input: 𝑆:
counts of k most occurring n-grams, hyps: list Definition 3.1
(Distinguishability). Let Pairsintra and Pairsinter be of tokenized
hypotheses, refs: list of tokenized inputs to a metric 𝑚 where
references, options: other BLEU options like Pairsintra = {(𝐶𝑖  {𝑐𝑎 },
𝑐𝑎 ) \| 𝑐𝑎 ∈ 𝐶𝑖 } weights, smoothing methods, etc. Output: CrystalBLEU
score Pairsinter = {(𝐶 𝑗 , 𝑐𝑎 ) \| 𝑐𝑎 ∈ 𝐶𝑖 , 𝑖 ≠ 𝑗 } 1 numerator,
denominator ← \[0...0\] for 𝑖, 𝑗 ∈ {1, . . . , 𝑛}. The
distinguishability 𝑑 of 𝑚 is: 2 for (ref, hyp) in (refs, hyps) do
𝑚(Pairsintra ) 3 for 𝑖 ∈ \[1..maxN \] do 𝑑= 𝑚(Pairsinter ) 4 numeratori
, denominatori ← numeratori , denominatori + Based on this definition,
distinguishability is higher when the modified_precision(ref , hyp, 𝑖,
𝑆) intra-class similarity is higher, and lower when the inter-class sim-
ilarity is higher. Distinguishability is always a positive number. 5 end
A metric that returns random similarity scores would have an ex- 6 end

pected distinguishability of one. Distinguishability above one means 7
bp ← brevity_penalty(refs, hyps)

the metric can distinguish similar from dissimilar code examples, 8 for
𝑖 ∈ \[1..maxN \] do where higher distinguishability means the metric is
more precise 9 𝑝𝑖 ← numeratori /denominatori at this task. 10 end Since
the number of intra-class pairs is quadratic in the number 11 if
smoothing then of programs in each class and the number of inter-class
pairs is 12 apply smoothing quadratic in the number of total programs,
computing the similarity 13 end metrics for all intra- and inter-class
pairs may become impractical 14 for 𝑖 ∈ \[1..maxN \] do for large code
corpora. Instead, we use a sampling-based approxima- 15 𝑠𝑖 ← weighti ∗
𝑝𝑖 tion of distinguishability that randomly samples 𝑁 intra-class pairs
16 end and 𝑁 inter-class pairs, and then computes distinguishability for
Í 17 score ← bp ∗ exp( 𝑖 𝑠𝑖 ) them. We use this approximation of
distinguishability for datasets 18 return score that have a large number
of program pairs, with 𝑁 = 1, 000 as a 19 Function
modified_precision(ref , hyp, 𝑖, 𝑆) is default. 20 refCounts ← n-grams
of length 𝑖 from each ref and 3.3 CrystalBLEU their number of
occurrences We now present the CrystalBLEU metric, which in contrast to
BLEU, 21 hypCount ← n-grams of length 𝑖 from hyp and their increases
distinguishability by accounting for trivially shared n- number of
occurrences grams. The basic idea behind the metric is surprisingly
simple: At 22 remove any n-grams from refCounts and hypCount first, we
identify trivially shared n-grams. Then, we compute a that is in 𝑆, or
divide refCounts and hypCount by the revised BLEU score that accounts
for the trivially shared n-grams. logarithm of counts in 𝑆 The following
explain the full algorithm in more detail. To be self 23 for ngram ∈
hypCount do contained, we also describe those parts that are the same as
in the 24 clipped_countngram ← original BLEU calculation.
min(hypCountngram, max (refCountsngram )) 3.3.1 Identifying Trivially
Shared N-grams. It has been observed in 25 end Í many domains that the
more frequent an n-gram, word, or phrase is, 26 numerator ← 𝑖
clipped_counti the less information it conveys when appearing in a
document. For Í 27 denominator ← max (1, hypCount) example, this
observation is the basis for term frequency--inverse 28 return
numerator, denominator document frequency (TFIDF), which is commonly
used as a weight- 29 end ing factor in information retrieval methods. To
identify trivially shared n-grams in a corpus of code examples, we also
exploit the Algorithm 1: CrystalBLEU. Differences to BLEU are high-
frequency of an n-gram occurring in the corpus. lighted. Concretely,
before applying CrystalBLEU to a code corpus, we compute all n-grams,
along with their frequencies, in this corpus. 3.3.2 CrystalBLEU
Algorithm. Once the set 𝑆 of the most common Then, we gather the 𝑘 most
common n-grams in set 𝑆, where 𝑘 is a n-grams are computed, the next
step is to decrease their impact on parameter of the algorithm.
CrystalBLEU heuristically considers the computation of the BLEU score.
To calculate the BLEU score, this set 𝑆 as trivially shared n-grams. For
example, when using as mentioned in Section 2, the first step is to
calculate the modified CrystalBLEU to compute how accurately Concode
\[21\] predicts precision of n-grams for the hypotheses. We implement
and evalu- functions, we compute 𝑆 based on the corpus of functions that
ate two approaches for considering trivially shared n-grams in this
CrystalBLEU: Precisely and Efficiently Measuring the Similarity of Code
ASE '22, October 10--14, 2022, Rochester, MI, USA

step. One approach is to completely remove all n-grams in 𝑆 from Table
2: Distinguishability of different code similarity met- the modified
precision calculations. Another, more complex process rics (higher is
better). is to apply weights proportional to the inverse frequency of
the most common n-grams. We empirically observe both approaches to
Language BLEU CodeBLEU CrystalBLEU provide similar effects on the
computed similarity metrics and on ShareCode Java 2.47 1.44 6.50
distinguishability, and hence, focus on the first, simpler approach
ShareCode C++ 2.82 N/A 8.29 in the remainder of the paper. BigCloneBench
1.44 1.18 2.77 Algorithm 1 shows the pseudo-code of CrystalBLEU and how
it differs with BLEU. The complete code is available as part of our
artifact. The important difference to BLEU is in line 22, where the
algorithm removes n-grams in 𝑆 (or decreases their weight) from are some
of the most common n-grams in the Java language part those considered
when computing the modified precision. After the of this dataset.
modified precisions of n-grams are computed, they are summed up
BigCloneBench: Clone and non-clone pairs. This dataset contains and then
the brevity penalty, weights, and smoothing method are more than 1.7
million inter-project pairs of Java programs, each applied to obtain the
final score, as in the original BLEU score. labeled with "clone" or "not
clone". Because of the labeling process, Our implementation of
CrystalBLEU extends the NLTK imple- it contains clone types one to four.
The data is split into train mentation of BLEU. Specifically, we use the
corpus BLEU evaluation (∼901k), validation (∼415k), and test (∼415k)
sets. It is available on (corpus_bleu method). the CodeXGLUE
repository.9 4 EVALUATION Concode: Code generation task. This dataset,
which originates In this section we answer the following research
questions with from Iyer et al. \[21\], is extracted from the CodeXGLUE
repository. empirical evidence. It contains pairs of Java code and
natural language descriptions of RQ1: How well does CrystalBLEU
distinguish between similar and the code. The task for which this
dataset is curated for is predicting dissimilar code? a function, given
a natural language description that also contains RQ2: Can CrystalBLEU
avoid misleading results provided by BLEU? some context information. The
dataset contains 100,000 training RQ3: How efficient is computing
CrystalBLEU? data points, and we have the predictions of a neural model
and RQ4: How sensitive is CrystalBLEU to the number 𝑘 of trivially
ground truth for 100 test data points. Because of reproducibility shared
n-grams? issues we were not able to obtain the predictions for the full
test set. 4.1 Baselines 4.3 RQ1: Distinguishing Similar and Dissimilar
For RQ1 to RQ3, we compare our CrystalBLEU metric to the exist- ing BLEU
metric \[36\], as it is widely used on code, and to Code- Code BLEU
\[41\], because it is a recently proposed alternative to BLEU We measure
the ability of CrystalBLEU and the baseline metrics to specifically
designed for code. As an implementation of BLEU, we distinguish
semantically equivalent from semantically non-equivalent use the vanilla
implementation provided by NLTK. The CodeBLEU code examples in two ways.
Section 4.3.1 uses our novel distin- implementation is extracted from
the CodeXGLUE repository7 . guishability metric. Section 4.3.2 applies
CrystalBLEU and other metrics in a simple, threshold-based classifier
that predicts whether 4.2 Datasets two examples are equivalent.
ShareCode: Semantically equivalent, human-written code. The We perform
these experiments on the two datasets that pro- first dataset is a
collection of solutions to programming challenges. vide equivalent and
non-equivalent code pairs, i.e., ShareCode and We include this dataset
because it provides us with sets of diverse BigCloneBench. For
ShareCode, we use the equivalency classes yet semantically equivalent
code snippets. The dataset is from Share- inherent to the dataset,
i.e. two programs are considered equivalent, Code8 , an online coding
competition website that offers program- and hence, considered to be
intra-class (Definition 3.1), if they solve ming problems and an online
judge. The online judge runs the code the same task. For BigCloneBench,
we assume pairs of clone pro- submitted by programmers on comprehensive
test suites and ac- grams as edges representing intra-class relations
and non-clones cepts only those solutions that pass all tests. Because
the accepted as edges showing inter-class relations. code pieces in a
problem set pass all tests, we consider them to 4.3.1 Distinguishability
Metric. Table 2 shows the distinguisha- be semantically equivalent. The
semantically equivalent pairs can bility of CrystalBLEU, BLEU, and
CodeBLEU for the two datasets. be any of the four clone types, but the
labeling criteria is only We find CrystalBLEU to achieve a clearly
higher distinguishability functionality. We use the Java and C++
submissions of ShareCode, than the two baseline metrics. For example, on
the ShareCode Java and remove problems with fewer than five accepted
solutions. In and C++ programs, CrystalBLEU outperforms BLEU by a factor
of total, there are 6,958 code pieces in this dataset, which cover 278
2.6x and 2.9x, respectively. Compared to CodeBLEU, CrystalBLEU
programming problems. N-grams "= 0;", ".out.println", and "i++" achieves
a more than 4x higher distinguishability on the ShareCode 7
https://github.com/microsoft/CodeXGLUE/tree/main/Code-Code/code-to-code-
trans/evaluator/CodeBLEU 9
https://github.com/microsoft/CodeXGLUE/tree/main/Code-Code/Clone-detection-
8 https://sharecode.io/ BigCloneBench ASE '22, October 10--14, 2022,
Rochester, MI, USA Aryaz Eghbali and Michael Pradel

                      0.25                                                         threshold, we calculate the average similarity score 𝑠 equiv of all
                                                              BLEU                 equivalent and the similarity score 𝑠 nonEquiv of all non-equivalent
                                                              CrystalBLEU
                      0.20                                                         pairs in a training set, and then use the means of these two val-
                                                                                   ues as the threshold. Table 3 shows the results of such a classifier

Similarity score

                                                                                   on ShareCode and BigCloneBench. Comparing BLEU and Crys-
                      0.15                                                         talBLEU shows that CrystalBLEU’s ability to better distinguish
                                                                                   non-equivalent from equivalent pairs translates into a classifier
                      0.10                                                         with higher accuracy and higher F1 score. For example, the accu-
                                                                                   racy at identifying clones and non-clones increases from 0.66 with
                                                                                   BLEU to 0.82 with CrystalBLEU. Higher recall for BLEU comes from
                      0.05                                                         the fact that BLEU tends to overestimate the similarity of pairs, be-
                                                                                   cause of the trivially shared n-grams. This overestimation of BLEU
                      0.00                                                         results in more positive predictions and fewer negative predictions
                             Not clone Clone            Not clone Clone            compared to CrystalBLEU, which in turn results in higher recall
                                                                                   and lower precision. Note that these results are not intended to

Figure 5: Average and 95% confidence interval of BLEU and compete with
state of the art clone detection techniques, which CrystalBLEU scores
for each class in the BigCloneBench test achieve even higher accuracy,
but instead serve to illustrate the set. benefits of CrystalBLEU over
BLEU.

Table 3: Code clone detection task results for BLEU- and Finding 1:
CrystalBLEU is clearly more effective at distin- CrystalBLEU-based
models. guishing equivalent from non-equivalent code pairs compared to
the existing BLEU and CodeBLEU metrics, providing a more ShareCode
BigCloneBench precise code similarity metric.

                             BLEU     CrystalBLEU        BLEU     CrystalBLEU

TP 2,789 2,131 29,305 26,064 4.4 RQ2: Avoiding Misleading Results FP
2,253 531 113,668 44,397 TN 21,147 22,869 244,928 314,199 The noise
caused by trivially shared n-grams might affect BLEU FN 811 1,469 27,515
30,756 and cause misleading conclusions when comparing different tech-
niques that predict code. The following shows an example of such
Accuracy 0.88 0.92 0.66 0.82 a misleading result and that CrystalBLEU
avoids it. To this end, Precision 0.55 0.80 0.20 0.37 we use Concode
\[21\], which generates code from a natural lan- Recall 0.77 0.59 0.52
0.46 guage text using a neural model. As a hypothetical competitor to F1
score 0.64 0.68 0.20 0.37 Concode, we create an artificial dummy model
designed to appear to be as good as Concode, while actually producing
clearly worse code than Concode. We assume that this dummy model knows
Java dataset. As there is no C++ support in CodeBLEU, the distin- how
many tokens are in the expected code, some of the correct guishability
of the C++ part is not available for CodeBLEU. Overall, tokens, and the
trivially shared n-grams in this domain. The model these experiments
show that CrystalBLEU is much more effective generates its output as
follows: Until the length of the prediction at distinguishing equivalent
from non-equivalent code examples. is shorter than the correct solution,
with 82% probability add a 4.3.2 Threshold-based Classification. As
another way to answer trivially shared n-gram to the beginning of the
prediction. With RQ1, we assess the ability of CrystalBLEU and other
metrics to probability 1 − 0.82, append a token from the correct
solution to decide whether two code examples are equivalent. To
illustrate the the end of the prediction. The probability of 82% is
chosen to yield idea, Figure 5 shows the mean and the 0.95 confidence
interval of a dummy model that achieves exactly the same BLEU score as
the BLEU and CrystalBLEU scores for pairs of non-clones and clones
Concode model. This means that the dummy model is generating in the
BigCloneBench dataset. The figure shows that, while both code that in
most cases starts with large section of nonsensical but metrics return
lower similarity scores for non-clones than for clones, common tokens,
followed by a small piece of correct code. Because the differences are
more accentuated with CrystalBLEU. First, the most of the code predicted
by the dummy model simply consists of relative difference between
non-clones and clones is higher for trivially shared n-grams, its
predictions clearly do not succeed in CrystalBLEU than for BLEU. Second,
the confidence intervals of the task of predicting code for a given
natural language description. CrystalBLEU are less overlapping, which is
a result of its higher Fig. 6 shows the results of evaluating Concode's
neural model distinguishability. and the dummy with BLEU and
CrystalBLEU. By design, the BLEU Motivated by these observations, we
design a simple, threshold- score of both models are very similar, i.e.,
BLEU may lead to the based classifier that predicts whether two code
pieces are equiv- wrong conclusion that the two models are equally
successful. In alent based on their similarity score. If the similarity
score of a contrast, CrystalBLEU shows that the neural model is 1.2x
better pair is above some threshold, the classifier predicts the pair to
be than the dummy model. Following the algorithm suggested by
equivalent, and to be non-equivalent otherwise. To determine the Riezler
and Maxwell III \[42\] we perform a statistical test to verify
CrystalBLEU: Precisely and Efficiently Measuring the Similarity of Code
ASE '22, October 10--14, 2022, Rochester, MI, USA

                                                                          Table 4: Running times (in milliseconds per 100 pairs of code
                      0.16                               Neural Model     pieces) of BLEU, CodeBLEU, and CrystalBLEU.
                                                         Dummy Model
                      0.14
                      0.12                                                                                 BLEU      CodeBLEU         CrystalBLEU

Similarity score

                      0.10                                                ShareCode Java Intra-class      1036.9           5382.3               953.6
                                                                          ShareCode Java Inter-class       868.9           3848.3               743.6
                      0.08                                                BigCloneBench Intra-class         83.5           1445.1                85.7
                      0.06                                                BigCloneBench Inter-class         81.5           1269.4                81.7
                                                                          Concode Java                      14.2            133.8                13.6
                      0.04
                      0.02                                                Table 5: Preprocessing time (in seconds) of CrystalBLEU on
                      0.00                                                different datasets.
                               BLEU                     CrystalBLEU

Figure 6: Similarity scores of the neural and dummy models. Dataset
Number of tokens Preprocessing time (s) ShareCode Java 580K 4.8
ShareCode C++ 1.8M 19.9 BigCloneBench 2.6M 22.3 the significance of the
differences for both BLEU and CrystalBLEU. Concode (tokenized) 2.6M 4.1
Setting the null hypothesis as "the dummy model is as good as the neural
model", we obtain p-values of 0.22 for BLEU and 0.01 for CrystalBLEU.
This rejects the null hypothesis for CrystalBLEU, but Our results show
that CrystalBLEU can be used at scale without not for BLEU, showing that
CrystalBLEU helps distinguish the two degradation in running time
performance. The preprocessing time models, whereas BLEU shows them to
be the same. of under one minute is also acceptable for almost all use
cases, as it is a one-time calculation. Finding 2: CrystalBLEU can avoid
misleading results, e.g., In terms of memory usage, CrystalBLEU first
extracts a list of caused by a model that predicts trivially shared
n-grams in- all n-grams and then stores a dictionary of n-grams and
their fre- stead of solving the actual task. quencies. The length of the
list of all n-grams is at most 𝑚𝑎𝑥𝑁 2 times the number of tokens, which
is in the same order as the input corpus. Moreover, the dictionary
storing the frequencies has fewer 4.5 RQ3: Scalability entries than the
list of all n-grams. Overall, for our largest sample One of the most
important selling points of BLEU is its running corpus, the whole Python
process uses at most 920MB of memory. speed. It is so fast that it is
even used as an online metric \[8\]. Hence, CrystalBLEU can be used for
all use cases in code that BLEU We conduct a set of experiments to
evaluate the running time of has been used for previously. CrystalBLEU
and compare it to BLEU and CodeBLEU. For these experiments we use a
regular laptop running a 64 bit Ubuntu 20.04, Finding 3: CrystalBLEU is
as efficient as BLEU, allowing for with an Intel Core i7 CPU (8 x 1.8
GHz) and 16 GB of RAM. We large-scale evaluations of code similarity in
little time. use Python 3.9's "time.process_time" method for all time
measure- ments. The running time for the CrystalBLEU score calculations
depend 4.6 RQ4: Parameter Choice on the size of set 𝑆. Table 4 shows the
running times of BLEU, Choosing a suitable parameter 𝑘 for CrystalBLEU
is important as CodeBLEU, and CrystalBLEU for different datasets with
\|𝑆 \| = 𝑘 = it affects the core competence of this new metric. This
parameter 500. In the two variants of CrystalBLEU we present in this
paper, also affects the running time of CrystalBLEU. However, there is a
the one that ignore the trivial n-grams gets faster when the size of
sizable range of suitable 𝑘s for each task and language pair by design,
𝑆 increases, but the one that divides the n-grams counts by their that
yields benefits over BLEU. CrystalBLEU score decreases by frequency in
the sample corpus gets slower with an increase in the increasing 𝑘 down
to the point where it reaches 0, where all n-grams size of 𝑆. matched
are in set 𝑆. Therefore, increasing 𝑘 causes an increase in We also
measure the preprocessing time required to obtain the n-
distinguishability, as shown in Fig. 8. Our analysis shows the best gram
counts on a sample corpus from each dataset. For ShareCode, performance
of CrystalBLEU on complete Java and C++ programs we use a sample of all
programs in the dataset. It takes less than 5 with 100 ≤ 𝑘 ≤ 1000. The
empirical results match the intuitive seconds to process a sample corpus
of 580K tokens, and less than choice of 𝑘 from frequencies of n-grams,
which is that n-grams 30 seconds for a corpus of 2.6M tokens. that
appear more frequently convey less information regarding Table 5 shows
the preprocessing time required for CrystalBLEU similarity. In Fig. 7,
from 100 to 1000 most common n-grams the to gather the most common
n-grams from a code corpus. It is worth curve becomes more flat than for
more common n-grams, while the emphasizing that the preprocessing phase
is only needed to be done main decrease in the inter-class scores are
also in the same range once for a task-language pair. in Fig. 8. So
choosing the right 𝑘 for each task-language pair can be ASE '22, October
10--14, 2022, Rochester, MI, USA Aryaz Eghbali and Michael Pradel

                                                                                                                                                 Table 6: Comparison of BLEU and alternative metrics.

Frequency (share of all n-grams)

                                                                               0.04
                                                                                                                                             Property                    BLEU CodeBLEU RUBY CrystalBLEU
                                                                               0.03                                                          Language-agnostic             ✓          x            x            ✓
                                                                                                                                             Handle incomplete and         ✓          x            x            ✓
                                                                               0.02                                                          partially incorrect code
                                                                                                                                             Efficient                     ✓          x           x             ✓
                                                                               0.01                                                          High distinguishability       x          x          N/A            ✓

                                                                               0.00
                                                                                       100            101        102         103             5    THREATS TO VALIDITY
                                                                                                      Most occurring n-grams
                                                                                                                                             Our analysis is limited to three datasets, and all experiments are
                                                                                                                                             on the Java and C++ languages. We select the languages due their

Figure 7: Frequency plot of most common n-grams in the popularity in the
relevant literature, and the availability of data. Java language. Our
datasets cover a wide range of programs in terms of domain and size.
Nevertheless, our findings may not generalize to other datasets, and
other programming languages may be more or less CrystalBLEU score
Distinguishability CrystalBLEU score Distinguishability

                                                                                             CrystalBLEU                                     affected by the effects shown in our experiments.
                                                                               102           BLEU
                                                                                                                                             6    RELATED WORK
                                                                               101
                                                                                                                                                Studies of BLEU in NLP. Since its invention in 2002 [36], BLEU has
                                                                                                                                             become extremely popular in natural language processing (NLP),
                                                                                                                                             but also received some criticism. Callison-Burch et al. [7] question
                                                                               0.4                                           intra-class     how well BLEU matches the actual translation quality of machine
                                                                                                                             inter-class     translation systems and recommend to use it only for systems that
                                                                               0.2                                                           use similar translation strategies. Reiter [40] provide a systematic
                                                                                                                                             review of papers that use BLEU in NLP and criticize using BLEU
                                                                               0.0                                                           as the only metric, as well as using BLEU in domains other than
                                                                                10                                                           machine translation. Post [38] discusses potential problems that
                                                                                             CrystalBLEU                                     may arise from different variants of BLEU, and the lack of details in
                                                                                 6           BLEU                                            many papers about which variant is used. Babych and Hartley [5]
                                                                                 4
                                                                                 3                                                           study the effects of applying weights to words based on the TF-IDF
                                                                                 2                                                           of each word when calculating BLEU. Although their approach is
                                                                                                                                             similar to ours, their goal is to increase the correlation of translation
                                                                                                                                             adequacy with human judgment. On the other hand, our approach
                                                                               0.2                                           intra-class     applies to all n-grams (not just 1-grams), and the goal is to increase
                                                                                                                             inter-class     distinguishability. Lin and Hovy [28] studies some shortcomings
                                                                               0.1                                                           of BLEU in natural language summarization and proposes an al-
                                                                                                                                             ternative. They show that the uni-gram co-occurrence correlates
                                                                               0.0                                                           well with human judgement, but the BLEU score performs poorly
                                                                                      100       101        102       103    104        105   in some cases. Graham [14] presents a detailed analysis of different
                                                                                                                 k                           variants of ROUGE and BLEU with regards to their correlation with
                                                                                                                                             the human judgement. One of the settings used is removing stop

Figure 8: Distinguishability of CrystalBLEU vs BLEU based on words,
which is a special case of removing common n-grams. the value of 𝑘 for
Java programs in the ShareCode dataset (top 2 charts) and the
BigCloneBench dataset (bottom 2 charts). Alternative Metrics for Code.
Recent work also criticizes the use of BLEU for code-related tasks. One
line of work \[48\] studies how BLEU relates to a human judgment of code
similarity in the context of code translation between programming
languages. The work done using the frequency plot of a sample corpus to
find the range by Tran et al. \[48\], and also a more recent paper by
Ren et al. \[41\], where the frequencies drop to low values. propose
alternative metrics to assess code similarity. Tran et al. \[48\] also
study BLEU on code, focusing on a specific application Finding 4: The
choice of the number 𝑘 of trivially shared domain, code migration, and
on comparing BLEU against a human- n-grams to consider influences the
results of CrystalBLEU, but created oracle of semantic similarity. Both
metrics rely on parsing there is a relatively large range of reasonable
values. the code, which only works if the code to evaluate is
syntactically well-formed. CrystalBLEU: Precisely and Efficiently
Measuring the Similarity of Code ASE '22, October 10--14, 2022,
Rochester, MI, USA

To summarize the differences in features that are important for
ACKNOWLEDGMENTS similarity metrics in this domain, Table 6 shows to what
extent the This work was supported by the European Research Council
(ERC, existing metrics, i.e. BLEU \[36\], RUBY \[48\], and CodeBLEU
\[41\], grant agreement 851895), and by the German Research Foundation
and our approach provide the following five desirable properties. within
the ConcSys and DeMoCo projects. We thank Amir Saboury First, an ideal
metric should be language-agnostic, a property BLEU for providing us
with the ShareCode dataset. and CrystalBLEU provide by relying only on
tokenization, but not on any form of deeper program analysis. Second, a
metric should REFERENCES be able to handle incomplete and partially
incorrect code, as such \[1\] Miltiadis Allamanis, Earl T Barr,
Premkumar Devanbu, and Charles Sutton. 2018. code may be predicted by
the evaluated techniques. RUBY and A survey of machine learning for big
code and naturalness. ACM Computing CodeBLEU fail to provide this
property as they must parse code into Surveys (CSUR) 51, 4 (2018), 81.
\[2\] Uri Alon, Shaked Brody, Omer Levy, and Eran Yahav. 2019. code2seq:
Generating an AST. Third, the metric should be efficient enough to be
applied Sequences from Structured Representations of Code. In 7th
International Con- to large code corpora or as an online metric as used
in Chakraborty ference on Learning Representations, ICLR 2019, New
Orleans, LA, USA, May 6-9, 2019.
https://openreview.net/forum?id=H1gKYo09tX et al. \[8\], a property that
is more difficult to maintain when relying \[3\] Uri Alon, Meital
Zilberstein, Omer Levy, and Eran Yahav. 2018. A General on more semantic
program analysis. Fourth, the metric should Path-Based Representation
for Predicting Program Properties. In PLDI. evaluate well with human
judgment. Finally, the metric should \[4\] Gareth Ari Aye and Gail E.
Kaiser. 2020. Sequence Model Design for Code Completion in the Modern
IDE. CoRR abs/2004.05249 (2020). arXiv:2004.05249 provide high
distinguishability, which CrystalBLEU does, as shown
https://arxiv.org/abs/2004.05249 in our evaluation. Note that the
implementation of RUBY was not \[5\] Bogdan Babych and Tony Hartley.
2004. Extending the BLEU MT evaluation publicly available, so we were
not able to assess its distinguishability. method with frequency
weightings. In Proceedings of the 42nd Annual Meeting of the Association
for Computational Linguistics (ACL-04). 621--628. However, the existence
of other features were deduced from the \[6\] Patrick Bareiß, Beatriz
Souza, Marcelo d'Amorim, and Michael Pradel. 2022. Code paper.
Generation Tools (Almost) for Free? A Study of Few-Shot, Pre-Trained
Language Models on Code. CoRR abs/2206.01335 (2022).
https://doi.org/10.48550/arXiv. There is a related approach in the
previous work by Ren et al. \[41\], 2206.01335 arXiv:2206.01335 called
"weighted n-gram matching", which is assigning weights to \[7\] Chris
Callison-Burch, Miles Osborne, and Philipp Koehn. 2006. Re-evaluation
the n-grams to affect the importance of some n-grams. However, in Role
of Bleu in Machine Translation Research. In EACL 2006, 11st Conference
of the European Chapter of the Association for Computational
Linguistics, Proceedings of weighted n-gram matching they assign higher
weights, i.e. higher the Conference, April 3-7, 2006, Trento, Italy,
Diana McCarthy and Shuly Wintner focus, on keywords, and only 1-gram
keywords, which are prede- (Eds.). The Association for Computer
Linguistics. https://www.aclweb.org/ fined for each language. These
weights are higher than the normal anthology/E06-1032/ \[8\] Saikat
Chakraborty, Miltiadis Allamanis, and Baishakhi Ray. 2018. Tree2Tree
Neu- weights for other n-grams. This type of weight assignment is the
ral Translation Model for Learning Source Code Changes. CoRR
abs/1810.00314 opposite of our approach, and shows worse
distinguishability com- (2018). arXiv:1810.00314
http://arxiv.org/abs/1810.00314 \[9\] Boxing Chen and Colin Cherry.
2014. A systematic comparison of smoothing pared to our approach.
techniques for sentence-level bleu. In Proceedings of the Ninth Workshop
on Statistical Machine Translation. 362--367. Other Uses of BLEU Score.
Beyond the use on code discussed \[10\] Chunyang Chen, Ting Su, Guozhu
Meng, Zhenchang Xing, and Yang Liu. 2018. in this paper, BLEU has been
used to evaluate natural language From ui design image to gui skeleton:
a neural machine translator to bootstrap prediction technique in
software engineering, such as code sum- mobile gui implementation. In
Proceedings of the 40th International Conference on Software
Engineering. 665--676. marization \[2, 53\], log message generation
\[19\], and comment gen- \[11\] Zimin Chen, Steve Kommrusch, Michele
Tufano, Louis-Noël Pouchet, Denys eration \[20\]. Wan et al. \[50\]
propose an actor and critic-style deep Poshyvanyk, and Martin Monperrus.
2019. SequenceR: Sequence-to-Sequence Learning for End-to-End Program
Repair. IEEE TSE (2019). reinforcement learning technique to predict a
comment from code, \[12\] Elizabeth Dinella, Hanjun Dai, Ziyang Li,
Mayur Naik, Le Song, and Ke Wang. which uses BLEU as a feedback metric
during learning. Our study 2020. Hoppity: Learning Graph Transformations
to Detect and Fix Bugs in focuses on evaluating code prediction, not on
natural language. Programs. In 8th International Conference on Learning
Representations, ICLR 2020, Addis Ababa, Ethiopia, April 26-30, 2020.
OpenReview.net. https://openreview. net/forum?id=SJeqs6EFvB 7 CONCLUSION
\[13\] Yangruibo Ding, Baishakhi Ray, Premkumar Devanbu, and Vincent J
Hellen- doorn. 2020. Patching as Translation: the Data and the Metaphor.
arXiv preprint This paper presents CrystalBLEU, a BLEU-based metric to
evalu- arXiv:2008.10707 (2020). ate source code similarity at scale,
regardless of the programming \[14\] Yvette Graham. 2015. Re-evaluating
automatic summarization with BLEU and 192 shades of ROUGE. In
Proceedings of the 2015 conference on empirical methods language. Our
metric is as fast and easy-to-use as BLEU, while con- in natural
language processing. 128--137. sidering an inherent difference between
source code and natural \[15\] Xiaodong Gu, Hongyu Zhang, Dongmei Zhang,
and Sunghun Kim. 2016. Deep language, namely the presence of trivially
shared n-grams. We show API learning. In FSE. 631--642.
https://doi.org/10.1145/2950290.2950334 \[16\] Rahul Gupta, Soham Pal,
Aditya Kanade, and Shirish K. Shevade. 2017. DeepFix: through
experiments on different languages and datasets that Crys- Fixing Common
C Language Errors by Deep Learning. In Proceedings of the Thirty-
talBLEU outperforms existing metrics in its ability to distinguish First
AAAI Conference on Artificial Intelligence, February 4-9, 2017, San
Francisco, semantically equivalent from non-equivalent pairs of code. We
en- California, USA, Satinder P. Singh and Shaul Markovitch (Eds.). AAAI
Press, 1345--1351.
http://aaai.org/ocs/index.php/AAAI/AAAI17/paper/view/14603 vision
CrystalBLEU to provide a more precise metric for future \[17\] Jacob
Harer, Onur Ozdemir, Tomo Lazovich, Christopher P. Reale, Rebecca L.
evaluations of techniques that predict source code. Moreover, our
Russell, Louis Y. Kim, and Sang Peter Chin. 2018. Learning to Repair
Soft- ware Vulnerabilities with Generative Adversarial Networks. In
Advances in novel meta-metric, distinguishability, will support the
development Neural Information Processing Systems 31: Annual Conference
on Neural In- of even better code similarity metrics. formation
Processing Systems 2018, NeurIPS 2018, 3-8 December 2018, Mon- tréal,
Canada. 7944--7954. http://papers.nips.cc/paper/8018-learning-to-repair-
software-vulnerabilities-with-generative-adversarial-networks DATA
AVAILABILITY \[18\] Abram Hindle, Earl T. Barr, Zhendong Su, Mark Gabel,
and Premkumar T. De- The implementation of CrystalBLEU and scripts used
for exper- vanbu. 2012. On the naturalness of software. In 34th
International Conference on Software Engineering, ICSE 2012, June 2-9,
2012, Zurich, Switzerland. 837--847. iments presented in this paper are
publicly available at https:// \[19\] Thong Hoang, Hong Jin Kang, David
Lo, and Julia Lawall. 2020. CC2Vec: Dis- github.com/sola-st/crystalbleu.
tributed Representations of Code Changes. In ICSE. ASE '22, October
10--14, 2022, Rochester, MI, USA Aryaz Eghbali and Michael Pradel

\[20\] Xing Hu, Ge Li, Xin Xia, David Lo, and Zhi Jin. 2018. Deep code
comment Evaluation of Code Synthesis. arXiv preprint arXiv:2009.10297
(2020). generation. In Proceedings of the 26th Conference on Program
Comprehension, ICPC \[42\] Stefan Riezler and John T Maxwell III. 2005.
On some pitfalls in automatic 2018, Gothenburg, Sweden, May 27-28, 2018,
Foutse Khomh, Chanchal K. Roy, and evaluation and significance testing
for MT. In Proceedings of the ACL workshop Janet Siegmund (Eds.). ACM,
200--210. https://doi.org/10.1145/3196321.3196334 on intrinsic and
extrinsic evaluation measures for machine translation and/or \[21\]
Srinivasan Iyer, Ioannis Konstas, Alvin Cheung, and Luke Zettlemoyer.
2018. summarization. 57--64. Mapping Language to Code in Programmatic
Context. In Proceedings of the \[43\] Baptiste Rozière, Marie-Anne
Lachaux, Lowik Chanussot, and Guillaume Lam- 2018 Conference on
Empirical Methods in Natural Language Processing, Brussels, ple. 2020.
Unsupervised Translation of Programming Languages. In Advances Belgium,
October 31 - November 4, 2018. 1643--1652. https://www.aclweb.org/ in
Neural Information Processing Systems 33: Annual Conference on Neural
In- anthology/D18-1192/ formation Processing Systems 2020, NeurIPS 2020,
December 6-12, 2020, virtual, \[22\] Rafael-Michael Karampatsis, Hlib
Babii, Romain Robbes, Charles Sutton, and Hugo Larochelle, Marc'Aurelio
Ranzato, Raia Hadsell, Maria-Florina Balcan, Andrea Janes. 2020. Big
code != big vocabulary: open-vocabulary models for and Hsuan-Tien Lin
(Eds.). https://proceedings.neurips.cc/paper/2020/hash/ source code. In
ICSE '20: 42nd International Conference on Software Engineering,
ed23fbf18c2cd35f8c7f8de44f85c08d-Abstract.html Seoul, South Korea, 27
June - 19 July, 2020, Gregg Rothermel and Doo-Hwan Bae \[44\] Zeyu Sun,
Qihao Zhu, Lili Mou, Yingfei Xiong, Ge Li, and Lu Zhang. 2019. A (Eds.).
ACM, 1073--1085. https://doi.org/10.1145/3377811.3380342 Grammar-Based
Structural CNN Decoder for Code Generation. In The Thirty- \[23\]
Seohyun Kim, Jinman Zhao, Yuchi Tian, and Satish Chandra. 2021. Code
Predic- Third AAAI Conference on Artificial Intelligence, AAAI 2019, The
Thirty-First tion by Feeding Trees to Transformers. In IEEE/ACM
International Conference on Innovative Applications of Artificial
Intelligence Conference, IAAI 2019, The Ninth Software Engineering
(ICSE). AAAI Symposium on Educational Advances in Artificial
Intelligence, EAAI 2019, \[24\] Claire Le Goues, Michael Pradel, and
Abhik Roychoudhury. 2019. Automated Honolulu, Hawaii, USA, January 27 -
February 1, 2019. 7055--7062. https://doi. program repair. Commun. ACM
62, 12 (2019), 56--65. https://doi.org/10.1145/
org/10.1609/aaai.v33i01.33017055 3318162 \[45\] Jeffrey Svajlenko,
Judith F Islam, Iman Keivanloo, Chanchal K Roy, and Moham- \[25\]
Jaeseong Lee, Pengyu Nie, Junyi Jessy Li, and Milos Gligoric. 2020. On
the mad Mamun Mia. 2014. Towards a big data curated benchmark of
inter-project Naturalness of Hardware Descriptions. In Joint Meeting on
European Software code clones. In 2014 IEEE International Conference on
Software Maintenance and Engineering Conference and Symposium on the
Foundations of Software Engineering. Evolution. IEEE, 476--480.
530--542. \[46\] Alexey Svyatkovskiy, Shao Kun Deng, Shengyu Fu, and
Neel Sundaresan. 2020. \[26\] Jian Li, Yue Wang, Michael R. Lyu, and
Irwin King. 2018. Code Completion with IntelliCode compose: code
generation using transformer. In ESEC/FSE '20: 28th Neural Attention and
Pointer Networks. In Proceedings of the 27th International ACM Joint
European Software Engineering Conference and Symposium on the Joint
Conference on Artificial Intelligence (Stockholm, Sweden) (IJCAI'18).
AAAI Foundations of Software Engineering, Virtual Event, USA, November
8-13, 2020, Press, 4159--25. Prem Devanbu, Myra B. Cohen, and Thomas
Zimmermann (Eds.). ACM, 1433-- \[27\] Xiaochen Li, He Jiang, Yasutaka
Kamei, and Xin Chen. 2018. Bridging semantic 1443.
https://doi.org/10.1145/3368089.3417058 gaps between natural languages
and APIs with word embedding. IEEE Transac- \[47\] Yanfei Tian, Xu Wang,
Hailong Sun, Yi Zhao, Chunbo Guo, and Xudong Liu. 2018. tions on
Software Engineering (2018). Automatically Generating API Usage Patterns
from Natural Language Queries. \[28\] Chin-Yew Lin and Eduard Hovy.
2003. Automatic evaluation of summaries In 2018 25th Asia-Pacific
Software Engineering Conference (APSEC). IEEE, 59--68. using n-gram
co-occurrence statistics. In Proceedings of the 2003 human lan- \[48\]
Ngoc M. Tran, Hieu Tran, Son Nguyen, Hoan Nguyen, and Tien N. Nguyen.
guage technology conference of the North American chapter of the
association for 2019. Does BLEU score work for code migration?. In
Proceedings of the 27th computational linguistics. 150--157.
International Conference on Program Comprehension, ICPC 2019, Montreal,
QC, \[29\] Hui Liu, Mingzhu Shen, Jiaqi Zhu, Nan Niu, Ge Li, and Lu
Zhang. 2020. Deep Canada, May 25-31, 2019, Yann-Gaël Guéhéneuc, Foutse
Khomh, and Federica Learning Based Program Generation from Requirements
Text: Are We There Sarro (Eds.). IEEE / ACM, 165--176.
https://doi.org/10.1109/ICPC.2019.00034 Yet? IEEE Transactions on
Software Engineering (2020). \[49\] Michele Tufano, Jevgenija
Pantiuchina, Cody Watson, Gabriele Bavota, and \[30\] Xinyue Liu,
Xiangnan Kong, Lei Liu, and Kuorong Chiang. 2018. TreeGAN: Denys
Poshyvanyk. 2019. On learning meaningful code changes via neural
Syntax-Aware Sequence Generation with Generative Adversarial Networks.
machine translation. In Proceedings of the 41st International Conference
on Software ArXiv e-prints (2018). arXiv:1808.07582 Engineering, ICSE
2019, Montreal, QC, Canada, May 25-31, 2019. 25--36. https: \[31\] Ali
Mesbah, Andrew Rice, Emily Johnston, Nick Glorioso, and Edward
Aftandilian. //dl.acm.org/citation.cfm?id=3339509 2019. DeepDelta:
learning to repair compilation errors. In Proceedings of the \[50\] Yao
Wan, Zhou Zhao, Min Yang, Guandong Xu, Haochao Ying, Jian Wu, and 2019
27th ACM Joint Meeting on European Software Engineering Conference and
Philip S. Yu. 2018. Improving automatic source code summarization via
deep Symposium on the Foundations of Software Engineering. 925--936.
reinforcement learning. In Proceedings of the 33rd ACM/IEEE
International Confer- \[32\] Anh Tuan Nguyen, Trong Duc Nguyen, Hung
Dang Phan, and Tien N. Nguyen. ence on Automated Software Engineering,
ASE 2018, Montpellier, France, September 2018. A Deep Neural Network
Language Model with Contexts for Source Code. 3-7, 2018, Marianne
Huchard, Christian Kästner, and Gordon Fraser (Eds.). ACM, In SANER.
397--407. https://doi.org/10.1145/3238147.3238206 \[33\] Anh Tuan
Nguyen, Tung Thanh Nguyen, and Tien N Nguyen. 2015. Divide-and- \[51\]
Wenhan Wang, Ge Li, Bo Ma, Xin Xia, and Zhi Jin. 2020. Detecting Code
Clones conquer approach for multi-phase statistical migration for source
code (t). In with Graph Neural Network and Flow-Augmented Abstract
Syntax Tree. In 2020 2015 30th IEEE/ACM International Conference on
Automated Software Engineering IEEE 27th International Conference on
Software Analysis, Evolution and Reengi- (ASE). IEEE, 585--596. neering
(SANER). IEEE, 261--271. \[34\] Yu Nong, Yuzhe Ou, Michael Pradel, Feng
Chen, and Haipeng Cai. 2022. Gener- \[52\] Cody Watson, Michele Tufano,
Kevin Moran, Gabriele Bavota, and Denys Poshy- ating Realistic
Vulnerabilities via Neural Code Editing: An Empirical Study. In vanyk.
2020. On Learning Meaningful Assert Statements for Unit Test Cases. In
ACM Joint Meeting on European Software Engineering Conference and
Symposium ICSE. on the Foundations of Software Engineering (ESEC/FSE).
\[53\] Jian Zhang, Xu Wang, Hongyu Zhang, Hailong Sun, and Xudong Liu.
2020. \[35\] Yusuke Oda, Hiroyuki Fudaba, Graham Neubig, Hideaki Hata,
Sakriani Sakti, Retrieval-based Neural Source Code Summarization. In
ICSE. Tomoki Toda, and Satoshi Nakamura. 2015. Learning to Generate
Pseudo-Code \[54\] Jian Zhang, Xu Wang, Hongyu Zhang, Hailong Sun,
Yanjun Pu, and Xudong Liu. from Source Code Using Statistical Machine
Translation (T). In 30th IEEE/ACM 2020. Learning to Handle Exceptions.
In IEEE/ACM International Conference on International Conference on
Automated Software Engineering, ASE 2015, Lincoln, Automated Software
Engineering (ASE). NE, USA, November 9-13, 2015. 574--584. \[36\]
Kishore Papineni, Salim Roukos, Todd Ward, and Wei-Jing Zhu. 2002. BLEU:
a method for automatic evaluation of machine translation. In Annual
Meeting on Association for Computational Linguistics (ACL). 311--318.
\[37\] Jibesh Patra and Michael Pradel. 2021. Semantic bug seeding: a
learning-based approach for creating realistic bugs. In ESEC/FSE '21:
29th ACM Joint European Software Engineering Conference and Symposium on
the Foundations of Software Engineering, Athens, Greece, August 23-28,
2021, Diomidis Spinellis, Georgios Gousios, Marsha Chechik, and
Massimiliano Di Penta (Eds.). ACM, 906--918.
https://doi.org/10.1145/3468264.3468623 \[38\] Matt Post. 2018. A Call
for Clarity in Reporting BLEU Scores. In Proceedings of the Third
Conference on Machine Translation: Research Papers. 186--191. \[39\]
Michael Pradel and Satish Chandra. 2022. Neural software analysis.
Commun. ACM 65, 1 (2022), 86--96. https://doi.org/10.1145/3460348 \[40\]
Ehud Reiter. 2018. A Structured Review of the Validity of BLEU.
Computational Linguistics 44, 3 (2018), 393--401. \[41\] Shuo Ren, Daya
Guo, Shuai Lu, Long Zhou, Shujie Liu, Duyu Tang, Ming Zhou, Ambrosio
Blanco, and Shuai Ma. 2020. CodeBLEU: a Method for Automatic 
