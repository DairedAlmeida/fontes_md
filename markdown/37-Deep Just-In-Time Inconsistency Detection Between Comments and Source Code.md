                                     The Thirty-Fifth AAAI Conference on Artificial Intelligence (AAAI-21)

Deep Just-In-Time Inconsistency Detection Between Comments and Source
Code Sheena Panthaplackel1 , Junyi Jessy Li2 , Milos Gligoric3 , Raymond
J. Mooney1 1 Department of Computer Science 2 Department of Linguistics
3 Department of Electrical and Computer Engineering The University of
Texas at Austin spantha@cs.utexas.edu, jessy@austin.utexas.edu,
gligoric@utexas.edu, mooney@cs.utexas.edu

                            Abstract                                       rameter constraints (Zhou et al. 2017), null values and
                                                                           exceptions (Tan et al. 2012), locking (Tan et al. 2007),

Natural language comments convey key aspects of source interrupts (Tan,
Zhou, and Padioleau 2011)). Some have code such as implementation,
usage, and pre- and post- conditions. Failure to update comments
accordingly when the also addressed the notion of coherence between
comments corresponding code is modified introduces inconsistencies, and
code as a text similarity problem with traditional ma- which is known to
lead to confusion and software bugs. In chine learning models that
leverage bag-of-words tech- this paper, we aim to detect whether a
comment becomes in- niques (Corazza, Maggio, and Scanniello 2018; Cimasa
consistent as a result of changes to the corresponding body of et
al. 2019). In contrast, we design an approach that gen- code, in order
to catch potential inconsistencies just-in-time, eralizes across types
of inconsistencies and captures deeper i.e., before they are committed
to a code base. To achieve this, comment/code relationships.
Furthermore, prior research we develop a deep-learning approach that
learns to correlate a has predominantly focused on detecting
inconsistencies that comment with code changes. By evaluating on a large
corpus already reside in a software project, within the code repos- of
comment/code pairs spanning various comment types, we itory. We refer to
this as post hoc inconsistency detection show that our model outperforms
multiple baselines by sig- nificant margins. For extrinsic evaluation,
we show the use- since it occurs potentially many commits after the
inconsis- fulness of our approach by combining it with a comment up-
tency has been introduced. date model to build a more comprehensive
automatic com- Ideally, these inconsistencies should be detected before
ment maintenance system which can both detect and resolve they ever
enter the repository (e.g., during code review) inconsistent comments
based on code changes. since they pose a threat to the development cycle
and reli- ability of the software until they are found. Because incon-
sistent comments generally arise as a consequence of de- 1 Introduction
velopers failing to update comments immediately following Comments serve
as a critical communication medium for code changes (Wen et al. 2019),
we aim to detect whether a developers, facilitating program
comprehension and code comment becomes inconsistent as a result of
changes to the maintenance tasks (Buse and Weimer 2010; de Souza, An-
accompanying code, before these changes are merged into a quetil, and de
Oliveira 2005). Code is highly-dynamic in na- code base. We refer to
this as just-in-time inconsistency de- ture, with developers constantly
making changes to address tection, as it allows catching potential
inconsistencies right bugs and feature requests. Many code changes
require recip- before they can materialize. rocal updates to the
accompanying comments to keep them Detecting inconsistencies immediately
following code in sync; however, this is not always done in practice
(Wen changes allows us to utilize information from the version et
al. 2019; Fluri et al. 2009; Ratol and Robillard 2017; Jiang of the code
before the changes, for which the comment is and Hassan 2006; Zhou et
al. 2017; Tan et al. 2007). Out- consistent. By considering how the
changes affect the rela- dated comments which inaccurately portray the
code they tionship the comment holds with the code, we can determine
accompany adversely affect the software development cycle whether the
comment remains consistent after the changes. by causing confusion (Wen
et al. 2019; Jiang and Hassan For instance, in Figure 1(a), the comment
describes the re- 2006; Tan et al. 2007; Zhou et al. 2017) and
misguiding de- turn type of nodeIds() as an array. When the method is
velopers, hence making code vulnerable to bugs (Jiang and modified to
return a Set instead of an array, the comment no Hassan 2006; Tan et
al. 2007; Ibrahim et al. 2012). There- longer describes the correct
return type, making it inconsis- fore, it is desirable to have systems
that can automatically tent. Such analysis is not possible in post hoc
inconsistency detect such inconsistencies and alert developers.
detection since the exact code changes that triggered incon- Previous
work has explored heuristic-based approaches sistency cannot be easily
pinpointed, making it difficult to for automatically detecting specific
types of inconsisten- align the comment with relevant parts of the code.
cies (e.g., identifier naming (Ratol and Robillard 2017), pa- Moreover,
due to challenges in crafting data extraction Copyright c 2021,
Association for the Advancement of Artificial rules (Tan et al. 2007;
Tan, Zhou, and Padioleau 2011) and Intelligence (www.aaai.org). All
rights reserved. annotating substantial amounts of data (Corazza,
Maggio,

                                                                     427

of comments paired with code changes in the corresponding methods,
encompassing multiple types of method comments and consisting of 40,688
examples that are extracted from (a) Inconsistent 1,518 open-source Java
projects.1 (3) We demonstrate the value of inconsistency detection in a
comprehensive auto- matic comment maintenance system, and we show how
our approach can support such a system.

                                                                                                   2    Task
                         (b) Consistent                                  Our task is to determine whether a comment is inconsistent,
                                                                         or semantically out of sync with the corresponding method.

Figure 1: In the example from the Apache Ignite project Most
inconsistencies result from developers making code shown in Figure 1(a),
the existing comment becomes incon- changes without properly updating
the accompanying com- sistent upon changes to the corresponding method,
and in ments. Suppose Mold from the consistent comment/method the
example from the Alluxio project shown in Figure 1(b), pair (C, Mold )
is modified to M . If C is not in sync with M the existing comment
remains consistent after code changes. and is not updated, it will
become inconsistent once M is committed. We frame this problem in two
distinct settings, with the task being constant across both: determine
whether and Scanniello 2018), prior post hoc work relies on a lim- C is
inconsistent with M . ited set of examples and projects. In contrast, we
build a • Post hoc: Here, only the existing version of the com- large
corpus for just-in-time inconsistency detection by min- ment/method pair
is available; the code changes that trig- ing commit histories of
software projects for code changes gered the inconsistency are unknown.
with and without corresponding comment updates. Few approaches exploit
code changes for inconsistency • Just-in-time: Here, the goal is to
catch inconsistencies detection and these rely on task-specific rules
(Sadu 2019), before they are committed. Unlike the post hoc setting,
hand-engineered surface features (Liu et al. 2018; Malik Mold is
available, allowing us to analyze the changes be- et al. 2008), and
bag-of-words techniques (Liu et al. 2018). tween Mold and M . Instead,
we learn salient characteristics of these inputs In line with most prior
work in inconsistency detec- through a deep-learning framework that
encodes their syn- tion (Corazza, Maggio, and Scanniello 2018; Tan et
al. 2007, tactic structures. Namely, we use recurrent neural networks
2012; Khamis, Witte, and Rilling 2010), we focus on iden- (RNNs) and
gated graph neural networks (GGNNs) (Li et al. tifying inconsistencies
in comments comprising API docu- 2016) to learn contextualized
representations of the com- mentation for Java methods. API
documentation consists of ment and code changes and multi-head attention
(Vaswani a main description and a set of tag comments.2 While some et
al. 2017) to relate these representations in order to discern have
considered treating the full documentation as a sin- how the code
changes affect the comment. We also study gle comment (Corazza, Maggio,
and Scanniello 2018), we how manual features can complement our neural
approach. choose to perform inconsistency detection at a more fine-
Furthermore, on its own, an inconsistency detection sys- grained level,
analyzing individual comment types within tem can only flag comments
that developers failed to update. this documentation. Furthermore, in
contrast to previous Actually amending them to reflect code changes
requires studies tailored to a specific tag (Zhou et al. 2017; Tan
significant developer effort. Approaches for automatically et al. 2012)
or specific keywords and templates (Tan et al. updating comments based
on code changes have been re- 2007; Tan, Zhou, and Padioleau 2011), we
simultaneously cently proposed (Panthaplackel et al. 2020b; Liu et
al. 2020). consider multiple comment types with diverse characteris-
However, they do not handle cases in which an update is not tics.
Namely, we address inconsistencies in the @return needed, such as in
Figure 1(b). While the type of the key tag comment, which describes a
method's return type, and argument is modified, its purpose is unchanged
(i.e., it still the @param tag comment, which describes an argument of
represents the key to be checked in PROPERTIES). Based on the method.
Additionally, we examine inconsistencies in the our user study
(Panthaplackel et al. 2020b), such cases de- less-structured summary
comment, derived from the first teriorated the overall quality of the
system. As a form of sentence of the main description. extrinsic
evaluation, we evaluate the utility of our approach by integrating it
with this comment update model, to build a more comprehensive automatic
comment maintenance sys- 3 Architecture tem that detects and resolves
inconsistencies. We aim to determine whether C is inconsistent by under-
To summarize, our main contributions are as follows: standing its
semantics and how it relates to M (or changes (1) We develop a deep
learning approach for just-in-time inconsistency detection that
correlates a comment with 1 Data and implementation are available at
https://github.com/ changes in the corresponding body of code and which
out- panthap2/deep-jit-inconsistency-detection. performs the post hoc
setting as well as several baselines. 2
https://docs.oracle.com/javase/8/docs/technotes/tools/ (2) For training
and evaluation, we construct a large corpus windows/javadoc.html

                                                                   428

Figure 2: High-level architecture of our approach.

                                                                       Figure 4: AST-based code edit representation (Medit ) cor-
                                                                       responding to Figure 1(b), with removed nodes in red and
                                                                       added nodes in green.

Figure 3: Sequence-based code edit representation (Medit ) corresponding
to Figure 1(b), with removed tokens in red and added tokens in green. to
be the vector representation of the full comment, and we feed it through
fully-connected and softmax layers (Figure 2 (6)). This leads to the
final prediction (Figure 2 (7)). between Mold and M ). We show an
overview of our ap- 3.1 Sequence Code Encoder proach in Figure 2. First,
the comment encoder, a Bi- GRU (Cho et al. 2014), encodes the sequence
of tokens in In the just-in-time setting, we represent the changes
between C (Figure 2 (1)). When learning a representation for a given
Mold and M with an edit action sequence, Medit . We have token, the
forward and backward BiGRU passes, in princi- previously shown that
explicitly defining edits in such a way ple, provide context of other
tokens in C. However, this in- outperforms having the model implicitly
learn them (Pan- formation can get diluted, especially when there are
long- thaplackel et al. 2020b). Each action consists of an action range
dependencies, and the relevant context can also vary type (Insert,
Delete, Keep, ReplaceOld, ReplaceNew) across tokens. To address this, we
update these representa- that applies to a span of tokens, as shown in
Figure 3. We tions from the comment encoder with more context about
encode Medit with a BiGRU. Because Mold is unavailable how they relate
to the other tokens through multi-head self- in the post hoc setting, we
cannot construct an edit action attention (Vaswani et al. 2017) (Figure
2 (2)). Next, we learn sequence. So, we encode the sequence of tokens in
M . code representations with a code encoder (Figure 2 (3)), which can
be a sequence encoder (cf. §3.1) or an abstract 3.2 AST Code Encoder
syntax tree (AST) encoder (cf. §3.2). To better exploit the syntactic
structure of code, we leverage Since the essence of the task comes down
to whether its abstract syntax tree (AST). Following prior work in other
C accurately reflects M , we must capture the relationship tasks
(Fernandes, Allamanis, and Brockschmidt 2019; Yin between C and M (or
changes between Mold and M ). et al. 2019), we encode ASTs and AST edits
using gated Prior work does this by computing comment/code similar-
graph neural networks (GGNNs) (Li et al. 2016). For the ity through
lexical overlap rules (Ratol and Robillard 2017; post hoc setting, we
encode T , an AST-based representa- Sadu 2019), which do not work well
when different terms tion corresponding to M . In the just-in-time
setting, we in- have similar meanings, and cosine similarity between
vector stead encode Tedit , an AST-based edit representation. We
representations, which have been found to perform poorly use GumTree
(Falleri et al. 2014), to compute AST node on their own (Liu et
al. 2018; Cimasa et al. 2019). Fur- edits between Told (corresponding to
Mold ) and T , identify- thermore, this notion of similarity is only
appropriate for ing inserted, deleted, kept, replaced, and moved nodes.
We the summary comment which provides an overview of the merge the two,
forming a unified representation, by consol- corresponding method as a
whole. More specialized com- idating identical nodes, as shown in Figure
4. ment types like @return and @param describe only spe- GGNN encoders
for T and Tedit use parent (public → cific parts of the method.
Therefore, their representations MethodDeclaration) and child
(MethodDeclaration → may not be very similar to the representation of
the full public) edges. Like prior work (Fernandes, Allamanis, and
method. In contrast, we learn the relationship between com- Brockschmidt
2019), we add "subtoken nodes" for identi- ments and code by computing
multi-head attention between fier leaf nodes to better handle previously
unseen identi- each hidden state of the comment encoder and the hidden
fier names. To integrate these new nodes, we add subnode states of the
code encoder (Figure 2 (4)). (toString → to), supernode (to → toString),
next subn- We combine the context vectors resulting from both atten- ode
(to → string), and previous subnode (string → to) tion modules to form
enhanced representations of the tokens edges. When encoding Tedit , we
also include an aligned in C, which carry context from other parts of C
as well as edge type between nodes in the two trees that correspond the
code. These are then passed through another BiGRU en- to an update
(String and PropertyKey). Additionally, we coder (Figure 2 (5)). We take
the final state of this encoder learn edit embeddings for each action
type. To identify how

                                                                 429

Train Valid Test Total partition and comment type, to construct a
balanced dataset. @return 15,950 1,790 1,840 19,580 Statistics of our
final dataset are shown in Table 1. @param 8,640 932 1,038 10,610
Comments are tokenized based on space and punctuation. Summary 8,398
1,034 1,066 10,498 We parse methods into sequences using javalang.3 Com-
Full 32,988 3,756 3,944 40,688 Projects 829 332 357 1,518 ment and code
sequences are subtokenized (e.g., camel- Case → camel, case; snake case
→ snake, case), as done Table 1: Data partitions. in prior work (Alon et
al. 2019; Fernandes, Allamanis, and Brockschmidt 2019), to capitalize on
composability and bet- ter address the open vocabulary problem in
learning from source code (Cvitkovic, Singh, and Anandkumar 2019). a
node is edited (or not edited), we concatenate the corre- sponding edit
embedding to its initial representation that is fed to the GGNN. 5
Models We outline baseline, post hoc, and just-in-time inconsistency 4
Data detection models.

By detecting inconsistencies at the time of code change, 5.1 Baselines
we can extract automatic supervision from commit histo- Lexical overlap:
A comment often has lexical overlap with ries of open-source Java
projects. Namely, we compare con- the corresponding method. We include a
rule-based just-in- secutive commits, collecting instances in which a
method time baseline, OVERLAP(C, deleted), which classifies C as is
modified. We extract the comment/method pairs from inconsistent if at
least one of its tokens matches a code token each version: (C1 , M1 ),
(C2 , M2 ). In prior work, we iso- belonging to a Delete or ReplaceOld
span in Medit . late comment updates made based on code changes through
Corazza, Maggio, and Scanniello (2018): This post hoc cases in which C1
6=C2 (Panthaplackel et al. 2020b). By as- bag-of-words approach
classifies whether a comment is co- suming that the developer updated
the comment because herent with the method that it accompanies using an
SVM it would have otherwise become inconsistent as a result with TF-IDF
vectors corresponding to the comment and of code changes, we take C1 to
be inconsistent with M2 , method. We simplify the original data
pre-processing, but consequently leading to a positive example, with
C=C1 , validate that the performance matches the reported numbers. Mold
=M1 , and M =M2 . For negative examples, we addition- CodeBERT BOW: We
develop a more sophisticated bag- ally examine cases in which C1 =C2 and
assume that if the of-words baseline that leverages CodeBERT (Feng et
al. existing comment would have become inconsistent, the de- 2020)
embeddings. These embeddings were pretrained on a veloper would have
updated it. Following this process, we large corpus of natural
language/code pairs. In the post hoc collect @return, @param, and
summary comment exam- setting, we consider CodeBERT BOW(C, M ), which
com- ples. We additionally incorporate 7,239 positive @return putes the
average embedding vectors of C and M . These examples from our prior
work (Panthaplackel et al. 2020b) vectors are concatenated and fed
through a feedforward net- which studies @return comment updates. work.
In the just-in-time setting, we compute the average While convenient for
data collection, the assumptions we embedding vector of Medit rather
than M , and we refer to make do not always hold in practice. For
instance, if C1 is this baseline as CodeBERT BOW(C, Medit ). refactored
without altering its meaning, we would assign a Liu et al. (2018): This
is a just-in-time approach for de- positive label because C1 6=C2 ,
despite it actually being con- tecting whether a block/line comment
becomes inconsis- sistent. Because such cases of comment improvement are
not tent upon changes to the corresponding code snippet. Their within
the scope of our work, we adopt previously proposed task is slightly
different as block/line comments describe heuristics (Panthaplackel et
al. 2020b) to reduce the number low-level implementation details and
generally pertain to of instances in which the comment and code changes
are un- only a limited number of lines of code, relative to API related.
The negative label is also noisy since C1 =C2 when a comments. However,
we consider it as a baseline since it developer fails to update comments
in accordance with code is closely related. They propose a random forest
classifier changes, pointing to the problem we are addressing in this
which leverages features which capture aspects of the code paper. We
minimize such cases by limiting to popular, well- changes (e.g., whether
there is a change to a while state- maintained projects (Jarczyk et
al. 2014). For more reliable ment), the comment (e.g., number of
tokens), and the rela- evaluation, we curate a clean sample of 300
examples (cor- tionship between the comment and code (e.g., cosine simi-
responding to 101 projects) from the test set, consisting of larity
between representations in a shared vector space). We 50 positive and 50
negative examples of each comment type. re-implemented this approach
based on specifications in the In line with prior work (Ren et al. 2019;
Movshovitz- paper, as their code was not publicly available. We
disregard Attias and Cohen 2013), we consider a cross-project setting 9
(of 64) features that are not applicable in our setting. with no overlap
between the projects from which examples are extracted in
training/validation/test sets. From our data 5.2 Our Models collection
procedure, we obtain substantially more negative Post hoc: We consider
three models, with different ways of examples than positive ones, which
is not surprising be- encoding the method. S EQ(C, M ) encodes M with a
GRU, cause many changes do not require comment updates (Wen 3 et
al. 2019). We downsample negative examples, for each
https://pypi.org/project/javalang/

                                                                  430

Cleaned Test Sample Full Test Set Model P R F1 Acc P R F1 Acc OVERLAP(C,
deleted) 77.7 72.0 74.7 75.7 74.1 62.8 68.0 70.4 Corazza, Maggio, and
Scanniello (2018) 65.1 46.0 53.9 60.7 63.7 47.8 54.6 60.3 Baselines
CodeBERT BOW(C, M ) 66.2 70.4 67.9 66.9 68.9 73.2 70.7 69.8 CodeBERT
BOW(C, Medit ) 65.5 80.9 72.3 69.0 67.4 76.8 71.6 69.6 Liu et al. (2018)
77.6 74.0 75.8 76.3 77.5 63.8 70.0 72.6 S EQ(C, M ) 58.9 68.0 63.0 60.3
60.6 73.4 66.3 62.8 Post hoc G RAPH(C, T ) 60.6 70.2 65.0 62.2 62.6 72.6
67.2 64.6 H YBRID(C, M , T ) 53.7 77.3 63.3 55.2 56.3 80.8 66.3 58.9 S
EQ(C, Medit ) 83.8 79.3 81.5 82.0 80.7 73.8 77.1 78.0 Just-In-Time G
RAPH(C, Tedit ) 84.7 78.4 81.4 82.0 79.8 74.4 76.9 77.6 H YBRID(C, Medit
, Tedit ) 87.1 79.6 83.1 83.8 80.9 74.7 77.7 78.5 S EQ(C, Medit ) +
features 91.3 82.0 86.4 87.1 88.4 73.2 80.0 81.8 Just-In-Time + features
G RAPH(C, Tedit ) + features 85.8 87.1 86.4 86.3 83.8 78.3 80.9 81.5 H
YBRID(C, Medit , Tedit ) + features 92.3 82.4 87.1 87.8 88.6 72.4 79.6
81.5

Table 2: Results for baselines, post hoc, and just-in-time models.
Differences in F1 and Acc between just-in-time vs. baseline models,
just-in-time vs. post hoc models, and just-in-time + features
vs. just-in-time models are statistically significant.

G RAPH(C, T ) encodes T with a GGNN, and H YBRID(C, nificantly
underperform all just-in-time models, including M , T ) uses both.
Multi-head attention in H YBRID(C, M , the simple rule-based baseline.
This demonstrates the benefit T ) is computed with the hidden states of
the two encoders of performing inconsistency detection in the
just-in-time set- separately and then combined. ting, in which the code
changes that trigger inconsistency are Just-In-Time: To allow fair
comparison with the post hoc available. Additionally, by encoding the
syntactic structures setting, these models are identical in structure to
the models of the comment and code changes, our just-in-time models
described above except that Medit is used instead of M . outperform this
rule-based baseline as well as all other base- Just-In-Time + features:
Because injecting explicit knowl- lines and post hoc approaches. While
the H YBRID(C, Medit , edge can boost the performance of neural models
(Chen Tedit ) model achieves slightly higher scores (on the basis et
al. 2017; Xuan, Hieu, and Le 2018), we investigate adding of F1 and
accuracy) than S EQ(C, Medit ) and G RAPH(C, comment and code features
to our approach. These are com- Tedit ), the differences are not
statistically significant. puted at the token/node-level and
concatenated with embed- Our just-in-time models outperform the
rule-based and dings before being passed to encoders. Features are
derived feature-based baselines, without any hand-engineered rules from
prior work on comments and code (Panthaplackel et al. or features.
However, by incorporating surface features into 2020a,b), including
linguistic (e.g., POS tags) and lexical our just-in-time models, we can
further boost performance (e.g., comment/code overlap) features. (by
statistically significant margins). This suggests that our approach can
be used in conjunction with task-specific 5.3 Model Training rules (Tan
et al. 2007; Tan, Zhou, and Padioleau 2011; Tan Models are trained to
minimize negative log likelihood. et al. 2012; Ratol and Robillard 2017)
and feature sets (Liu We use 2-layer BiGRU encoders (hidden dimension
64). et al. 2018) to build improved systems for specific domains. GGNN
encoders (hidden dimension 64) are rolled out for Furthermore, in Table
3, we analyze the performance of 8 message-passing steps, also use
hidden dimension 64. We the three just-in-time + features models with
respect to indi- initialize comment and code embeddings, of dimension
64, vidual comment types. While these models are trained on all with
pretrained ones (Panthaplackel et al. 2020b). Edit em- comment types
together without explicitly tailoring it in any beddings are of
dimension 8. Attention modules use 4 atten- way to handle them
differently, they are still able to achieve tion heads. We use a dropout
rate of 0.6. Training ends if the reasonable performance across types.
validation F1 does not improve for 10 epochs. 7 Extrinsic Evaluation 6
Intrinsic Evaluation We further evaluate how our approach could be used
to build We report common classification metrics: precision (P), re- a
comprehensive just-in-time comment maintenance system call (R), and F1
(w.r.t. the positive label) and accuracy (Acc), which first determines
whether a comment, C, has become averaged across 3 random restarts. We
also perform signifi- inconsistent upon code changes to the
corresponding method cance testing (Berg-Kirkpatrick, Burkett, and Klein
2012). (Mold → M ), and then automatically suggests an update if In
Table 2, we report results for baselines, post hoc and this is the case.
To do this, we combine the inconsistency de- just-in-time inconsistency
detection models. In the post hoc tection approach with our previously
proposed comment up- setting, we find that our three models can achieve
higher date model (Panthaplackel et al. 2020b) which updates com- F1
scores than the bag-of-words approach proposed by ments based on code
changes. For training and evaluating Corazza, Maggio, and Scanniello
(2018); however, they un- this combined system, we have two sets of
comment/method derperform the CodeBERT BOW(C, M ) baseline and sig-
pairs from consecutive commits for each example in our cor-

                                                                   431

Cleaned Test Sample Full Test Set Model P R F1 Acc P R F1 Acc S EQ(C,
Medit ) + features 88.5∗ 72.0∗ 79.4∗ 81.3∗ 87.6∗ 73.3∗ 79.8∗ 81.4∗
@return G RAPH(C, Tedit ) + features 81.2 77.3 79.1∗ 79.7 82.2 79.3 80.6
80.9∗ H YBRID(C, Medit , Tedit ) + features 88.7∗ 72.0 ∗ 79.4∗ 81.3∗
87.3∗ 73.7∗ 79.8∗ 81.4∗ S EQ(C, Medit ) + features 90.0 95.3 92.5 92.3†
92.2 88.3† 90.2 90.4 @param G RAPH(C, Tedit ) + features 96.5 92.0 94.2
94.3 94.5 89.0† 91.7 91.9 H YBRID(C, Medit , Tedit ) + features 94.6
89.3 91.8 92.0† 93.3 85.9 89.4 89.9 S EQ(C, Medit ) + features 96.0 78.7
86.5§ 87.7 84.7§ 58.3 69.0 73.9§ Summary G RAPH(C, Tedit ) + features
80.8 92.0 86.0§ 85.0 76.0 66.4 70.6 72.5 H YBRID(C, Medit , Tedit ) +
features 93.7 86.0 89.5 90.0 85.0§ 57.0 68.1 73.5§

Table 3: Evaluating performance with respect to different types of
comments. Scores are averaged across 3 random restarts, and scores for
which the difference in performance is not statistically significant are
shown with identical symbols.

pus. Recall from our data collection procedure that we ex- 7.2 Results
tracted pairs of the form (C1 , M1 ), (C2 , M2 ), where C=C1 , We report
precision, recall, F1, and accuracy for detection. Mold =M1 , and M =M2
. We now introduce Cnew =C2 , the As we have done previously
(Panthaplackel et al. 2020b), gold comment for M . If C is consistent
with M , C=Cnew . we evaluate update through exact match (xMatch) as
well as metrics used to evaluate text generation (BLEU-4 (Pa- 7.1
Evaluation Method pineni et al. 2002) and METEOR (Banerjee and Lavie
2005)) and text editing tasks (SARI (Xu et al. 2016) and The GRU-based S
EQ 2S EQ update model encodes C and a GLEU (Napoles et al. 2015)). In
Table 4, we compare per- sequential representation of the code changes
(Medit ). Using formances of combined inconsistency detection and update
attention (Luong, Pham, and Manning 2015) and a pointer systems on the
cleaned test sample. As reference points, we network (Vinyals,
Fortunato, and Jaitly 2015) over learned also provide scores for a
system which never updates (i.e., representations of the inputs, a
sequence of edit actions always copies C as Cnew ) and Panthaplackel et
al. (2020b), (Cedit ) is generated, identifying how C should be edited
which is designed to always update (and only copy C if an to form the
updated comment (Cnew ). This model also em- invalid edit action
sequence is generated). ploys the same linguistic and lexical features
as the just-in- Since our dataset is balanced, we can get 50% exact
match time + features models. The model is trained on only cases by
simply copying C (i.e., never updating). In fact, this in which C has to
be updated and is not designed to ever can even beat Panthaplackel et
al. (2020b) on xMatch, ME- copy the existing comment. We consider three
different con- TEOR, BLEU-4, SARI, and GLEU. This underlines the im-
figurations for adding inconsistency detection in this model: portance
of first determining whether a comment needs to Update w/ implicit
detection: We augment training of the be updated, which can be addressed
with our inconsistency update model with negative examples (i.e., C does
not need detection approach. On the majority of the update metrics, to
be updated). The model implicitly does inconsistency de- both of these
underperform the other three approaches (Up- tection by learning to copy
C for such cases. Inconsistency date w/ implicit detection, Pretrained
update + detection, and detection is evaluated based on whether it
predicts Cnew =C. Jointly trained update + detection). SARI is
calculated by Pretrained update + detection: The update model is Pan-
averaging N-gram F1 scores for edit operations (add, delete, thaplackel
et al. (2020b), trained on only positive examples. and keep). So, it is
not surprising that the Update w/ implicit At test time, if the
detection model classifies C as inconsis- detection baseline, which
learns to copy, performs fewer ed- tent, we take the prediction of the
update model. Otherwise, its, consequently underperforming on this
metric. Because we copy C, making Cnew =C. We consider three of the pre-
Panthaplackel et al. (2020b) is designed to always edit, it trained
just-in-time detection models. can perform well on this metric; however,
the majority of Jointly trained update + detection: We jointly train the
in- the pretrained and jointly trained systems can beat this.
consistency detection and update models on the full dataset The Update
w/ implicit detection baseline, which does not (including positive and
negative examples). We consider include an explicit inconsistency
detection component, per- three of our just-in-time detection
techniques. The update forms relatively well with respect to the update
metrics, but model and detection model share embeddings and the com- it
performs poorly on detection metrics. Here, we use gener- ment encoder
for all three, and for the sequence-based and ating C as the prediction
for Cnew as a proxy for detecting hybrid models, the code sequence
encoder is also shared. inconsistency. It achieves high precision, but
it frequently During training, loss is computed as the sum of the update
copies C in cases in which it is inconsistent and should be and
detection components. For negative examples, we mask updated, hence
underperforming on recall. The pretrained the loss of the update
component since it does not have to and jointly trained approaches
outperform this model by learn to copy C. At test time, if the detection
component wide statistically significant margins across the majority of
predicts a negative label, we directly copy C and otherwise metrics,
demonstrating the need for inconsistency detection. take the prediction
of the update model. We do not observe a significant difference between
the

                                                                 432

Update Metrics Detection Metrics xMatch METEOR BLEU-4 SARI GLEU P R F1
Acc Never Update 50.0 67.4 72.1 24.9 68.2 0.0 0.0 0.0 50.0 Panthaplackel
et al. (2020b) 25.9 60.0 68.7 42.0∗ 67.4 54.0 95.6 69.0 57.1 Update w/
implicit detection 58.0 72.0 74.7 31.5 72.7 100.0 23.3 37.7 61.7
Pretrained update + detection S EQ(C, Medit ) + features 62.3† 75.6∗
77.0∗ 42.0∗ 76.2 91.3∗ 82.0§ 86.4∗ 87.1§¶ G RAPH(C, Tedit ) + features
59.4 74.9§ 76.6† 42.5k 75.8∗† 85.8 87.1 86.4∗ 86.3† H YBRID(C, Medit ,
Tedit ) + features 62.3† 75.8†k 77.2 42.3† 76.4 92.3 82.4§ 87.1† 87.8∗k
Jointly trained update + detection S EQ(C, Medit ) + features 61.4∗
75.9k 76.6† 42.4†k 75.6† 88.3† 86.2 87.2† 87.3§k G RAPH(C, Tedit ) +
features 60.8 75.1§ 76.6† 41.8∗ 75.8∗ 88.3† 84.7∗ 86.4∗ 86.7†¶ H
YBRID(C, Medit , Tedit ) + features 61.6∗ 75.6∗† 76.9∗ 42.3† 75.9∗ 90.9∗
84.9∗ 87.8 88.2∗

Table 4: Results on joint inconsistency detection and update on the
cleaned test sample. Scores for which the difference in performance is
not statistically significant are shown with identical symbols.

pretrained and jointly trained systems. The pretrained mod- not require
such extensive feature engineering. Although els achieve slightly higher
scores on most update metrics and their task is slightly different, we
consider their approach as the jointly trained models achieve slightly
higher scores on a baseline. Stulova et al. (2020) concurrently present
a pre- the detection metrics; however, these differences are small
liminary study of an approach which maps a comment to the and often
statistically insignificant. Overall, we find that our AST nodes of the
method signature (before the code change) approach can be useful for
building a real-time comment using BOW-based similarity metrics. This
mapping is used maintenance system. Since this is not the focus of our
paper to determine whether the code changes have triggered a but rather
merely a potential use case, we leave it to future comment
inconsistency. Our model instead leverages the full work for developing
more intricate joint systems. method context and also learns to map the
comment directly to the code changes. Malik et al. (2008) predict
whether a 8 Related Work comment will be updated using a random forest
classifier utilizing surface features that capture aspects of the method
Code/Comment Inconsistencies: Prior work analyze how that is changed,
the change itself, and ownership. They do inconsistencies emerge (Fluri
et al. 2009; Jiang and Hassan not consider the existing comment since
their focus is not 2006; Ibrahim et al. 2012; Fluri, Wursch, and Gall
2007) and inconsistency detection; instead, they aim to understand the
the various types of inconsistencies (Wen et al. 2019); but, rationale
behind comment updating practices by analyzing they do not propose
techniques for addressing the problem. useful features. Sadu (2019)
develops at approach which Post Hoc Inconsistency Detection: Prior work
propose locates inconsistent identifiers upon code changes through
rule-based approaches for detecting pre-existing inconsis- lexical
matching rules. While we find such a rule-based ap- tencies in specific
domains, including locks (Tan et al. 2007), proach (represented by our
OVERLAP(C, deleted) baseline) interrupts (Tan, Zhou, and Padioleau
2011), null excep- to be effective, a learned model performs
significantly better. tions for method parameters (Zhou et al. 2017; Tan
et al. Svensson (2015) builds a system to mitigate the damage of 2012),
and renamed identifiers (Ratol and Robillard 2017). inconsistent
comments by prompting developers to validate The comments they consider
are consequently constrained a comment upon code changes. Comments that
are not val- to certain templates relevant to their respective domains.
idated are identified, indicating that they may be out of date We
instead develop a general-purpose, machine learning and unreliable. Nie
et al. (2019) present a framework for approach that is not catered
towards any specific types of maintaining consistency between code and
todo comments inconsistencies or comments. Corazza, Maggio, and Scan- by
performing actions described in such comments when niello (2018) and
Cimasa et al. (2019) address a broader code changes trigger the
specified conditions to be satisfied. notion of coherence between
comments and code through text-similarity techniques, and Khamis, Witte,
and Rilling (2010) determine whether comments, specifically @return 9
Conclusion and @param comments, conform to particular format. We We
developed a deep learning approach for just-in-time in- instead capture
deeper code/comment relationships by learn- consistency detection
between code and comments by learn- ing their syntactic and semantic
structures. Rabbi and Sid- ing to relate comments and code changes.
Based on evalua- dik (2020) propose a siamese network for correlating
com- tion on a large corpus consisting of multiple types of com-
ment/code representations. In contrast, we aim to correlate ments, we
showed that our model substantially outperforms comments and code
through an attention mechanism. various baselines as well as post hoc
models that do not con- Just-In-Time Inconsistency Detection: Liu et
al. (2018) sider code changes. We further conducted an extrinsic eval-
detect inconsistencies in a block/line comment upon changes uation in
which we demonstrated that our approach can be to the corresponding code
snippet using a random forest used to build a comprehensive comment
maintenance sys- classifier with hand-engineered features. Our approach
does tem that can detect and update inconsistent comments.

                                                                   433

Acknowledgments Cvitkovic, M.; Singh, B.; and Anandkumar, A. 2019. Open
Vocab- ulary Learning on Source Code with a Graph-Structured Cache. In
This work was supported by the Bloomberg Data Science International
Conference on Machine Learning, 1475--1485. Fellowship and a Google
Faculty Research Award. de Souza, S. C. B.; Anquetil, N.; and de
Oliveira, K. M. 2005. A Ethics Statement Study of the Documentation
Essential to Software Maintenance. In International Conference on Design
of Communication: Docu- Through this work, we aim to reduce
time-consuming con- menting & Designing for Pervasive Information, 6875.
fusion and vulnerability to software bugs by keeping devel- Falleri,
J.-R.; Morandat, F.; Blanc, X.; Martinez, M.; and Monper- opers informed
with up-to-date-documentation, in order to rus, M. 2014. Fine-Grained
and Accurate Source Code Differenc- consequently help improve developers
productivity and soft- ing. In International Conference on Automated
Software Engineer- ware quality. Buggy software and incorrect API usage
can ing, 313324. result in significant malfunctions in many everyday
opera- tions. Maintaining comment/code consistency can help pre- Feng,
Z.; Guo, D.; Tang, D.; Duan, N.; Feng, X.; Gong, M.; Shou, L.; Qin, B.;
Liu, T.; Jiang, D.; and Zhou, M. 2020. CodeBERT: vent such
negative-impact events. A Pre-Trained Model for Programming and Natural
Languages. However, over-reliance on such a system could result in ArXiv
abs/2002.08155. developers giving up identifying and resolving
inconsistent comments themselves. By presuming that the system de-
Fernandes, P.; Allamanis, M.; and Brockschmidt, M. 2019. Struc- tects
all inconsistencies and all of these are properly ad- tured Neural
Summarization. In International Conference on dressed, developers may
also take the available comments Learning Representations. for granted,
without carefully analyzing their validity. Be- Fluri, B.; Wursch, M.;
and Gall, H. C. 2007. Do Code and Com- cause the system may not catch
all types of inconsisten- ments Co-Evolve? On the Relation Between
Source Code and cies, this could potentially exacerbate rather than
resolve Comment changes. In Working Conference on Reverse Engineer- the
problem of inconsistent comments. Our system is not ing, 7079. intended
to serve as an infallible safety net for poor software Fluri, B.;
Würsch, M.; Giger, E.; and Gall, H. C. 2009. Analyzing engineering
practices but rather as a tool that complements the Co-Evolution of
Comments and Source Code. Software Quality good ones, working alongside
developers to help deliver re- Journal 17(4): 367394. liable,
well-documented software in a timely manner. Ibrahim, W. M.; Bettenburg,
N.; Adams, B.; and Hassan, A. E. 2012. On the Relationship between
Comment Update Practices References and Software Bugs. Journal of
Systems and Software 85(10): Alon, U.; Brody, S.; Levy, O.; and Yahav,
E. 2019. code2seq: Gen- 22932304. erating Sequences from Structured
Representations of Code. In Jarczyk, O.; Gruszka, B.; Jaroszewicz, S.;
Bukowski, L.; and International Conference on Learning Representations.
Wierzbicki, A. 2014. GitHub Projects. Quality Analysis of Open-
Banerjee, S.; and Lavie, A. 2005. METEOR: An Automatic Metric Source
Software. In International Conference on Social Informat- for MT
Evaluation with Improved Correlation with Human Judg- ics, 80--94.
ments. In Workshop on Intrinsic and Extrinsic Evaluation Mea- Jiang, Z.
M.; and Hassan, A. E. 2006. Examining the Evolution sures for Machine
Translation and/or Summarization, 65--72. of Code Comments in
PostgreSQL. In International Workshop on Berg-Kirkpatrick, T.; Burkett,
D.; and Klein, D. 2012. An Em- Mining Software Repositories, 179180.
pirical Investigation of Statistical Significance in NLP. In Joint
Khamis, N.; Witte, R.; and Rilling, J. 2010. Automatic Quality As-
Conference on Empirical Methods in Natural Language Process- sessment of
Source Code Comments: The JavadocMiner. In Natu- ing and Computational
Natural Language Learning, 995--1005. ral Language Processing and
Information Systems, 68--79. Buse, R. P. L.; and Weimer, W. R. 2010.
Learning a Metric for Code Readability. IEEE Transactions on Software
Engineering 36(4): Li, Y.; Tarlow, D.; Brockschmidt, M.; and Zemel, R.
S. 2016. Gated 546--558. Graph Sequence Neural Networks. In
International Conference on Learning Representations. Chen, R.-C.;
Yulianti, E.; Sanderson, M.; and Croft, W. B. 2017. On the Benefit of
Incorporating External Features in a Neural Ar- Liu, Z.; Chen, H.; Chen,
X.; Luo, X.; and Zhou, F. 2018. Au- chitecture for Answer Sentence
Selection. In SIGIR Conference on tomatic Detection of Outdated Comments
During Code Changes. Research and Development in Information Retrieval,
10171020. In Annual Computer Software and Applications Conference, 154--
163. Cho, K.; van Merriënboer, B.; Gulcehre, C.; Bahdanau, D.; Bougares,
F.; Schwenk, H.; and Bengio, Y. 2014. Learning Phrase Liu, Z.; Xia, X.;
Yan, M.; and Li, S. 2020. Automating Just-In- Representations using RNN
Encoder--Decoder for Statistical Ma- Time Comment Updating. In
International Conference on Auto- chine Translation. In Conference on
Empirical Methods in Natural mated Software Engineering, To Appear.
Language Processing, 1724--1734. Luong, T.; Pham, H.; and Manning, C. D.
2015. Effective Ap- Cimasa, A.; Corazza, A.; Coviello, C.; and
Scanniello, G. 2019. proaches to Attention-based Neural Machine
Translation. In Con- Word Embeddings for Comment Coherence. In Euromicro
Confer- ference on Empirical Methods in Natural Language Processing,
ence on Software Engineering and Advanced Applications (SEAA),
1412--1421. 244--251. Malik, H.; Chowdhury, I.; Tsou, H.-M.; Jiang, Z.
M.; and Hassan, Corazza, A.; Maggio, V.; and Scanniello, G. 2018.
Coherence of A. E. 2008. Understanding the Rationale for Updating a
Functions Comments and Method Implementations: A Dataset and an Empir-
Comment. In International Conference on Software Maintenance, ical
Investigation. Software Quality Journal 26(2): 751777. 167--176.

                                                                     434

Movshovitz-Attias, D.; and Cohen, W. W. 2013. Natural language Vinyals,
O.; Fortunato, M.; and Jaitly, N. 2015. Pointer Net- models for
predicting programming comments. In Annual Meeting works. In Advances in
Neural Information Processing Systems, of the Association for
Computational Linguistics, 35--40. 2692--2700. Napoles, C.; Sakaguchi,
K.; Post, M.; and Tetreault, J. 2015. Wen, F.; Nagy, C.; Bavota, G.; and
Lanza, M. 2019. A Large-Scale Ground Truth for Grammatical Error
Correction Metrics. In An- Empirical Study on Code-Comment
Inconsistencies. In Interna- nual Meeting of the Association for
Computational Linguistics and tional Conference on Program
Comprehension, 5364. the International Joint Conference on Natural
Language Process- Xu, W.; Napoles, C.; Pavlick, E.; Chen, Q.; and
Callison-Burch, C. ing, 588--593. 2016. Optimizing Statistical Machine
Translation for Text Simpli- Nie, P.; Rai, R.; Li, J. J.; Khurshid, S.;
Mooney, R. J.; and Gligoric, fication. Transactions of the Association
for Computational Lin- M. 2019. A Framework for Writing Trigger-Action
Todo Com- guistics 4: 401--415. ments in Executable Format. In Joint
European Software Engi- Xuan, H. N. T.; Hieu, V. C.; and Le, A.-C. 2018.
Adding Exter- neering Conference and Symposium on the Foundations of
Soft- nal Features to Convolutional Neural Network for Aspect-based ware
Engineering, 385396. Sentiment Analysis. In Conference on Information
and Computer Panthaplackel, S.; Gligoric, M.; Mooney, R. J.; and Li, J.
J. 2020a. Science, 53--59. Associating Natural Language Comment and
Source Code Entities. In AAAI Conference on Artificial Intelligence.
Yin, P.; Neubig, G.; Allamanis, M.; Brockschmidt, M.; and Gaunt, A. L.
2019. Learning to Represent Edits. In International Confer-
Panthaplackel, S.; Nie, P.; Gligoric, M.; Li, J. J.; and Mooney, R. J.
ence on Learning Representations. 2020b. Learning to Update Natural
Language Comments Based on Code Changes. In Annual Meeting of the
Association for Compu- Zhou, Y.; Ruihang, G.; Taolue, C.; Zhiqiu, H.;
Sebastiano, P.; and tational Linguistics, 1853--1868. Harald, G. 2017.
Analyzing APIs Documentation and Code to De- tect Directive Defects. In
International Conference on Software Papineni, K.; Roukos, S.; Ward, T.;
and Zhu, W.-J. 2002. BLEU: Engineering, 2737. a Method for Automatic
Evaluation of Machine Translation. In Annual Meeting of the Association
for Computational Linguistics, 311--318. Rabbi, F.; and Siddik, M. S.
2020. Detecting Code Comment In- consistency Using Siamese Recurrent
Network. In International Conference on Program Comprehension - Early
Research Achieve- ments, 371375. Ratol, I. K.; and Robillard, M. P.
2017. Detecting Fragile Com- ments. International Conference on
Automated Software Engineer- ing 112--122. Ren, X.; Xing, Z.; Xia, X.;
Lo, D.; Wang, X.; and Grundy, J. 2019. Neural Network-Based Detection of
Self-Admitted Tech- nical Debt: From Performance to Explainability.
Transactions on Software Engineering and Methodology 28: 1--45. Sadu, A.
2019. Automatic Detection of Outdated Comments in Open Source Java
Projects. Master's thesis, Universidad Politécnica de Madrid. Stulova,
N.; Blasi, A.; Gorla, A.; and Nierstrasz, O. 2020. Towards Detecting
Inconsistent Comments in Java Source Code Automati- cally. In
International Working Conference on Source Code Anal- ysis and
Manipulation, 65--69. Svensson, A. 2015. Reducing outdated and
inconsistent code com- ments during software development: The comment
validator pro- gram. Master's thesis, Uppsala University. Tan, L.; Yuan,
D.; Krishna, G.; and Zhou, Y. 2007. /*iComment: Bugs or Bad Comments?*/.
In Symposium on Operating Systems Principles, 145--158. Tan, L.; Zhou,
Y.; and Padioleau, Y. 2011. aComment: Mining Annotations from Comments
and Code to Detect Interrupt Related Concurrency Bugs. In International
Conference on Software Engi- neering, 11--20. Tan, S. H.; Marinov, D.;
Tan, L.; and Leavens, G. T. 2012. @tCom- ment: Testing Javadoc Comments
to Detect Comment-Code Incon- sistencies. In International Conference on
Software Testing, Verifi- cation and Validation, 260--269. Vaswani, A.;
Shazeer, N.; Parmar, N.; Uszkoreit, J.; Jones, L.; Gomez, A. N.; Kaiser,
Ł.; and Polosukhin, I. 2017. Attention is All you Need. In Conference on
Neural Information Processing Systems, 5998--6008.

                                                                          435


