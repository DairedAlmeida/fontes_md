                                         Larger Is Not Always Better: Leveraging Structured
                                          Code Diffs for Comment Inconsistency Detection
                                                            Phong Nguyen                                    Anh M. T. Bui∗                      Phuong T. Nguyen
                                           Hanoi University of Science and Technology        Hanoi University of Science and Technology        University of L’Aquila
                                                        Hanoi, Vietnam                                   Hanoi, Vietnam                           L’Aquila, Italy
                                              phong.nhv210669@sis.hust.edu.vn                       anhbtm@soict.hust.edu.vn                  phuong.nguyen@univaq.it



                                            Abstract—Ensuring semantic consistency between source code
                                         and its accompanying comments is crucial for program com-

arXiv:2512.19883v2 \[cs.SE\] 24 Dec 2025

                                         prehension, effective debugging, and long-term maintainability.
                                         Comment inconsistency arises when developers modify code
                                         but neglect to update the corresponding comments, potentially
                                         misleading future maintainers and introducing errors. Recent
                                         approaches to code–comment inconsistency (CCI) detection lever-
                                         age Large Language Models (LLMs) and rely on capturing
                                         the semantic relationship between code changes and outdated
                                         comments. However, they often ignore the structural complexity
                                         of code evolution, including historical change activities, and
                                         introduce privacy and resource challenges. In this paper, we
                                         propose a Just-In-Time CCI detection approach built upon the
                                         CodeT5+ backbone. Our method decomposes code changes into
                                         ordered sequences of modification activities such as replacing,
                                         deleting, and adding to more effectively capture the correlation
                                         between these changes and the corresponding outdated com-
                                                                                                                      Fig. 1: A CCI example in JITDATA [11].
                                         ments. Extensive experiments conducted on publicly available
                                         benchmark datasets–JITDATA and CCIBENCH–demonstrate that
                                         our proposed approach outperforms recent state-of-the-art mod-     a fixed snapshot of the repository [7], [8]. However, such
                                         els by up to 13.54% in F1-Score and achieves an improvement        approaches are limited in handling the inherently evolving
                                         ranging from 4.18% to 10.94% over fine-tuned LLMs including
                                         DeepSeek-Coder, CodeLlama and Qwen2.5-Coder.
                                                                                                            nature of software systems, where comments may become
                                            Index Terms—code comment inconsistency, large language          outdated only after subsequent code modifications. To better
                                         models, code change, code evolution.                               cope with this dynamic setting, research has gradually shifted
                                                                                                            toward Just-in-time (JIT) detection, where models operate over
                                                                   I. I NTRODUCTION                         sequences of commits and leverage code changes to identify
                                            Code comments are essential documentation artifacts in          potential mismatches [9]–[11]. A wide range of techniques
                                         software development, enabling developers to communicate           have been explored for this task, ranging from heuristic-
                                         a program’s functionality, design rationale, and intended us-      based approaches [12] to deep learning models [11], [13]–
                                         age [1]. Well-maintained comments have been shown to en-           [16], and more recently LLM-based methods [9], [17]. Despite
                                         hance developers’ comprehension of complex systems and             these advances, most existing approaches still treat code diffs
                                         facilitate more efficient software maintenance.However, as         as flattened token sequences, which obscures the distinction
                                         software systems evolve through continuous modifications and       between added and deleted regions. As a result, current models
                                         feature extensions, developers often fail to update correspond-    struggle to capture the fine-grained correlation links between
                                         ing comments, leading to code–comment inconsistency (CCI),         specific edits and the comment, limiting their ability to reason
                                         where comments no longer align with the underlying imple-          about semantic drift introduced by code changes.
                                         mentation [2]–[4]. Such inconsistencies can mislead future            In this paper, we propose CARL-CCI, a just-in-time ap-
                                         maintainers, hinder debugging, and ultimately increase the         proach to CCI detection, drawing on different code-change
                                         likelihood of software defects [5], [6]. For instance, Figure1     activities to infer the correlation between code modifications
                                         illustrates a CCI scenario in JITDATA where a method was           and old comments so as to identify inconsistencies. We analyze
                                         modified to handle AtmosphereRequest objects, yet the old          code diffs and annotate each edit with its corresponding ac-
                                         comment incorrectly claims it works with HttpServletRequest.       tivity including <replace>, <add>, or <delete>. Rather
                                            Early studies on CCI detection focused on identifying in-       than treating changes as a monolithic token sequence, we tag
                                         consistencies between static code and comments by analyzing        each token span with its activity label and feed the resulting
                                                                                                            sequence, together with the comment, into a cross-encoder.
                                           *Corresponding author                                            This design highlights correlation connections between spe-

cific edits and the comment via the explicit change-activity
rectification. However, JITDATA was constructed using heuris- signal.
The upper section of Figure 1 depicts a CCI example; tic rules,
resulting in substantial label noise that undermines diffs are
highlighted with red for deletions and green for the reliability of
model evaluation and limits the consistency additions. In the lower
part, activity labels are applied to token of learned representations.
spans and highlighted in yellow. Using the CodeT5+ model To address this
issue, Zhong et al. constructed CCIBENCH as backbone, we propose a
label-aware contrastive learning \[10\], a higher-quality benchmark
created via syntactic cleaning framework that more effectively captures
the semantics of and ensemble validation using state-of-the-art LLMs
including code diffs and their comments. In contrast to self-supervised,
GPT-4o \[22\], Claude3.5-Sonnet \[23\], and LLaMA 3.1- monolithic
contrastive objectives, our approach uses ground- 405B \[24\]. CCIBench
mitigates noisy labels and offers a more truth labels to attract
same-label samples and repel different- dependable basis for both
detection and repair tasks. label ones, producing a more organized and
discriminative Despite these developments, most existing models still
representation space for distinguishing inconsistent from con- process
code diffs as single flattened sequences, without sistent comments.
explicitly distinguishing added from deleted code segments The main
contributions of our work are as follows. \[9\], \[11\], \[25\]. This
limitation prevents them from capturing • We redesign code-diff
representations to embed an activ- the correlation relationships between
specific edits and their ity label within each token span, allowing us
to probe the corresponding comments, thereby hindering fine-grained in-
correlation relationship between edits and comments. consistency
detection. • We introduced CARL-CCI, a just-in-time approach to III. P
ROPOSED A PPROACH code comment inconsistency detection that builds on
top of the CodeT5+ model and leverages label-aware In this section, we
introduce CARL-CCI--Contrastive contrastive learning to enhance
representations of code Activity-aware Representation Learning for CCI
detection. diffs and comments. Figure 2 outlines two components: (i) a
pre-processing module • By conducting extensive experiments on two
popular that extracts code diffs and re-formats them with edit labels,
benchmarks, we observed consistent improvements over and (ii) a
cross-encoder that jointly encodes the concatenated previous approaches;
moreover, relative to fine-tuned code-diff/comment pair to capture
fine-grained correlations LLMs, our method delivers stronger performance
for between specific edits and comments, going beyond global detecting
inconsistent comments. similarity of prior works \[9\], \[11\]. To make
these interactions • We published the replication package, including
code and discriminative, we employ label-aware contrastive learning,
data to facilitate future research \[18\]. which pulls together
consistent pairs and pushes apart in- Structure. In Section II, we
review the related work. Sec- consistent ones, shaping a structured
embedding space for tion III explains in detail the proposed approach.
The empirical consistency classification. evaluation to study the
performance of CARL-CCI is pre- A. Activity-Labeled Code-Diff
Representation sented in Section IV. Afterward, in Section V, we report
and analyze the experimental results. Finally, Section VI sketches Given
a code snippet S and its comment C, we define a future work, and
concludes the paper. function I(·, ·) as follows. ( II. R ELATED W ORK 0
if C accurately captures the semantics of S, I(S, C) = Research on
code--comment inconsistency (CCI) detection 1 otherwise. spans two
primary settings: post-hoc and Just-in-time (JIT). In line with prior
work \[9\], \[11\], \[13\], \[15\], we assume Early post-hoc studies
focused on identifying inconsisten- that comment updates indicate a
preceding code change would cies in existing repositories by analyzing
static code--comment have caused inconsistency. Accordingly, the
pre-change pair is pairs. These efforts mainly relied on rule-based
heuristics taken as consistent, i.e., I(St , Ct ) = 0. After a code
update, (e.g., lexical overlap \[12\], identifier matching \[19\]) or
shallow St → St+1 , the task is to judge whether the unchanged learning
techniques such as similarity-based models using comment Ct has become
inconsistent. Given Sdiff denotes the TF--IDF or word embeddings \[7\],
\[8\]. However, these post- code diffs between St and St+1 , the CCI
detection is then hoc approaches are limited by their inability to
account for the formulated as follows. evolving nature of code. (
Motivated by practical needs, research has shifted toward 1 if Ct does
not match the semantics of St+1 , I(Sdiff , Ct ) = JIT detection, which
leverages commit-level code changes to 0 otherwise. identify
inconsistencies at the moment they are introduced. Panthaplackel et
al. introduced the JITDATA dataset and We reformulate code-diff
sequences using four edit ac- the DeepJIT framework \[11\], establishing
the first large- tions---A DD, D EL, K EEP, and R EPLACE---and insert
tags to scale benchmark for commit-level CCI detection. Subsequent mark
each edit span. An example of reformulated code diffs work explored
stronger architectures, including transformer- is depicted in Figure 1.
A code-diff sequence Sdiff is now based models \[20\], \[21\] and
LLM-based systems such as represented as a mixture of four kinds of edit
span as follows. C4RLLaMA \[9\], which support both detection and
comment • `<Add>`{=html} tokens `<EndAdd>`{=html}  Training Process
In-Batch Pairwise Similarity Matrix

                                                                                                                                             S1C1      S1C2   S1C3      …         S1Cn

                                                                                                                                             S2C1      S2C2   S2C3      …         S2Cn




                                                                                                             Sdiff Vector
                                                                                                                                             S3C1      S3C2   S3C3      …         S3Cn
                                                                                                                                      +
               Mining Code Histories
                                                                   Sdiff                                                                        …       …       …       …          …

                   Code St+1
                                                                                                                                             SnC1      SnC2   SnC3      …         SnCn




                                                                                                             Comment Vector
                                                                                           Encoder                                                                       +          ℒ"$%&'()& = ℒ*%+$,"# + 𝛼ℒ,-.
                                       +

                    Code St                                Sold            Snew          Feed-Forward                                                                    y!
                                           Code Diffs
                                                                                  +                                                                                      p! = P((S! , C! )|y! = 1)                 +
                                                                                         Self-Attention                           +
                                                                   +                                                                                          predict
                                                                                         Normalization                                                                       y!
                                                                                                                                                                                    ℒ!"#




                                                                                                             Sold ⨁ Snew Vector

Code Repo Comment Ct Code-Diff Decomposition ×12 Pre-trained CodeT5+
Classification Head

                                                                                                                                               update



                                                    Fig. 2: The overall architecture of our proposed approach.

• `<Del>`{=html} tokens `<EndDel>`{=html} that predicts inconsistency.
We fine-tune the encoder and • `<Keep>`{=html} tokens `<EndKeep>`{=html}
classification head end-to-end using the binary cross-entropy •
`<ReplaceOld>`{=html} tokens `<ReplaceNew>`{=html} tokens LBCE (as in
Equation 1). `<EndReplace>`{=html} 1 X LBCE (B) = − (yi log(pi ) + (1 −
yi )log(1 − pi )) (1) In order to capture the correlation relationship
between \|B\| i∈B different kinds of code diffs and S comments, we
decompose S Sdiff into two parts: Sdiff = Sold Snew Sunchanged where:
where B is the training batch, \|B\| denotes the number of training
samples in batch, yi represents the ground-truth label • Sold =
{Del-tokens ∪ ReplaceOld-tokens} of sample i (yi ∈ {0, 1}) and pi is the
model's predicted • Snew = {Add-tokens ∪ ReplaceNew-tokens}
inconsistency probability for that sample. • Sunchanged = {Keep-tokens}
2) Label-Aware Contrastive Learning: To better encode Under the
assumption that I(St , Ct ) = 0, we reformulate the semantics of
consistent and inconsistent pairs, we adopt the detection objective as:
supervised (label-aware) contrastive learning: same-label pairs ( are
aligned, different-label pairs are repelled, producing 0 if f (Sold , Ct
) = 0 ∧ f (Snew , Ct ) = 0, I(Sdiff , Ct ) = a more separable
representation. Concretely, we extend 1 if f (Sold , Ct ) = 1 ∧ f (Snew
, Ct ) = 0. InfoNCE \[26\]: (i) for label = 0 (consistent pairs), we use
where f (·, ·) denotes a learned relevance function measuring InfoNCE to
bring the matched diff--comment pair closer; (ii) semantic alignment
between code edits and the comment. for label = 1 (inconsistent pairs),
we incorporate a negative- Decomposing the code-diff sequence guides the
model toward push term \[27\] to drive mismatched pairs apart. local,
fine-grained edit--comment relations, yielding more in- Given a training
batch B, we compute a pairwise similarity terpretable and resilient
inconsistency detection than holistic between every comment ci and code
diff sj as in Equation 2. formulations. ci · s j exp(simij ) simij = ,
pij = P . (2) B. Contrastive and Activity-Aware Representation Learning
τ exp(simik ) k∈B for CCI where simij is the similarity between the i-th
comment and 1) Cross-Encoding Code Diffs and Comments: We use the j-th
code diff, pij is the row-wise softmax probability and CodeT5+ as the
backbone, employing its encoder to jointly τ is the temperature in
contrastive learning. encode code-diff/comment pairs. For a given code
diff and its The training batch B is divided into two subsets, let
associated comment (Sdiff , C), the encoder input is constructed BC =
{pairi \|labeli = 0} and BI = {pairj \|labelj = 1}. Two as follows.
supervised contrastive loss components are formulated as in x = Sold ⊕
Snew ⊕ C ⊕ Sdiff Equations 3 and 4. Action-tagged edit spans allow the
cross-encoder to capture 1 X edit--comment correlations, letting it
focus attention on the LInfoNCE = − log pii (3) \|BC \| i∈BC edits most
pertinent to the comment. By concatenating the vector representations of
the code diff 1 X Lneg = − log(1 − pjj ) (4) and the comment, we obtain
a joint input to the classifier \|BI \| j∈BI  The contrastive loss,
composed of these two components, TABLE I: Statistics of the JITDATA and
CCIBENCH datasets. is defined as follows. Dataset Comment Type Train
Validation Test Total Lcontrast = LInfoNCE + αLneg , α ≥ 0, (5) @return
15,950 1,790 1,840 19,580 @param 8,640 932 1,038 10,610 JITDATA where α
is a weighting coefficient that controls the con- Summary 8,398 1,034
1,066 10,498 tribution of the inconsistent-pair term. The overall
training All 32,988 3,756 3,944 40,688 objective is then given in
Equation 6. @return 9,188 1,092 1,088 11,368 @param 6,004 620 646 7,270
CCIBENCH Ltotal = LCE + λLcontrast , λ ≥ 0. (6) Summary 2,970 356 396
3,722 All 18,162 2,068 2,130 22,360 where λ sets the proportion of the
contrastive component in the total loss. IV. E VALUATION D.
Implementation Details A. Research Question CARL-CCI relies on the
encoder of pre-trained Our study explores the following research
questions. CodeT5p-220M model. Our model is trained with a batch size of
32 and a learning rate of 1 × 10−5 , using a ▷ RQ1 : How effective is
the proposed model compared to ex- contrastive temperature of τ = 0.08.
Training continues for isting baselines? We evaluate the effectiveness
of CARL-CCI up to 20 epochs with early stopping based on the F1. in
comparison with state-of-the-art approaches. Specifically, Fine-tuning
the selected LLMs is performed using QLoRA we select three recent
baseline models, including: with 4-bit NF4 quantization, where only
low-rank adapter • DeepJIT \[11\] employs deep learning architectures to
weights are updated while the base model remains frozen. capture
information from code diffs and comments. We apply a LoRA configuration
with rank r = 32, scaling • C4RLLaMA \[9\] fine-tunes CodeLLaMA and
leverages factor lora_alpha = 16, dropout lora_dropout =
chain-of-thought reasoning to improve both CCI detection 0.1, and
adapters inserted into q_proj, k_proj, v_proj, and comment
rectification. o_proj, gate_proj, up_proj, and down_proj. All the •
CCI-Solver \[10\] uses the pre-trained UniXcoder to selected LLMs are
fine-tuned and evaluated on an NVIDIA detect inconsistencies. H100 GPU,
whereas our proposed model is trained and tested Additionally, we
fine-tune several code-oriented on a more modest NVIDIA T4 GPU. models,
including DeepSeek-Coder \[28\], Qwen2.5-Coder \[29\], and CodeLLaMA
\[30\]. Specifically, V. R ESULTS AND D ISCUSSION we use the
deepseek-coder-6.7b-instruct, A. RQ1 : How effective is the proposed
model compared to Qwen2.5-Coder-7B-Instruct, and CodeLlama-7b- existing
baselines? Instruct-hf variants. Table II shows the performance of three
baseline models, ▷ RQ2 : How does each component of CARL-CCI contribute
three LLMs and our approach on two benchmarks JITDATA to the final
performance? We evaluate the contribution of and CCIBENCH. It can be
observed that CARL-CCI con- each component by ablating key modules--such
as the activity- sistently outperforms the others across all evaluation
met- labeled code diff representation and the label-aware contrastive
rics. Specifically, on JITDATA it reaches 90.89% F1 on the loss--and
measuring the resulting performance changes. full test set and 93.56% on
the validated subset, achieving B. Benchmark Datasets an improvement of
5.45%, 6.63% and 10.90% comparing We conduct experiments on two
benchmark datasets widely to CCISolver \[10\], CR4LLama \[9\] and
DeepJIT \[11\]. used in CCI research: JITDATA \[11\] and CCIBENCH
\[10\]. Although all three baselines encode code diffs with action
JITDATA contains 40,688 code-diff/comment pairs collected labels,
CARL-CCI goes further by also separating tokens into from 1,518
open-source Java projects, while CCIBENCH is a old/new spans rather than
mixing all edits. This enables the cleaned and higher-quality derivative
of this dataset. Following model to focus on specific modifications
(additions and dele- prior work, all experiments will be performed on
the full tions) and highlight the mismatched semantics of inconsistent
test set and on the validated test set which is constructed comments.
The results achieved by CARL-CCI on CCIBENCH by manually selecting 300
verified instances from the test set are consistent but exhibit
considerable improvement. As a to support more reliable evaluation.
Table I summarizes the noise-removal subset of JITDATA, all the models
achieved dataset statistics of two benchmarks. higher performance on
CCIBENCH. As can be seen in Table II, CARL-CCI attains 93.38% F1 on the
full test and 95.62% on C. Evaluation Metrics the validated subset,
exceeding CCI-Solver by 4.29% and Following prior work, we evaluate
performance using 3.71%, gaining an increasing of 5.31% and 5.51%
comparing Accuracy, Precision, Recall, and F1-Score as in to C4RLLama.
prior work \[9\]--\[11\]. Accuracy reflects overall correctness, We then
evaluate recent LLMs by fine-tuning them for Precision and Recall
measure correctness and coverage CCI detection on the same
code-diff/comment training data. of positive predictions, and F1 is
their harmonic mean. The results show that CARL-CCI, built on a small
model  TABLE II: Performance of CARL-CCI comparing to baseline models on
JITDATA and CCIBENCH.

      Dataset        Approach                               Full Test Set                            Validated Test Set
                                              Accuracy     Precision    Recall     F1     Accuracy     Precision   Recall    F1
                     DeepJIT [11]               82.15        82.85       81.08    81.96    89.00        89.26      88.67    88.96
                     C4RLLama [9]               86.24        86.20       84.30    85.24    87.82        89.67      85.33    87.45
                     CCISolver [10]             86.48        87.24       85.17    86.19    88.74        87.67      88.67    88.17
      JITDATA
                     DeepSeek-Coder [28] 81.33               78.34       86.61    82.27    82.00        79.63      86.00    82.69
                     Qwen2.5-Coder [29] 86.10                88.91       82.50    85.59    87.67        91.85      82.67    87.02
                     CodeLlama [30]      79.79               74.42       90.77    81.79    80.00        74.45      91.33    82.04
                     CARL-CCI                   91.18        94.31       89.67    90.89    93.67        95.17      92.00    93.56
                     DeepJIT [11]               87.32        88.41       85.92    87.15    89.67        89.40      90.00    89.70
                     C4RLLama [9]               89.16        88.24       89.10    88.67    87.82        92.67      88.67    90.63
                     CCISolver [10]             89.92        89.84       89.25    89.54    90.95        92.67      91.74    92.20
      CCIBENCH
                     DeepSeek-Coder [28] 83.99               79.48       91.64    85.12    84.67        80.23      92.00    85.71
                     Qwen2.5-Coder [29] 88.87                91.48       85.72    88.51    90.33        92.91      87.33    90.03
                     CodeLlama [30]      83.01               77.74       92.48    84.48    83.67        77.90      94.00    85.20
                     CARL-CCI                   93.43        94.01       92.77    93.38    95.67        96.60      94.77    95.62

                                      TABLE III: Ablation Study on JITDATA and CCIBENCH.

     Dataset        Model / Setting                          Full Test Set                           Validated Test Set
                                               Accuracy     Precision    Recall    F1     Accuracy     Precision   Recall    F1
                    CARL-CCI w/o AL and CL       87.55        88.11      86.82    87.46     89.67        90.48      88.67   89.56
                    CARL-CCI w/o AL              88.06        89.81      85.85    87.79     88.67        89.73      87.33   88.51
     JITDATA
                    CARL-CCI w/o CL              91.08        93.94      88.03    90.74     93.33        95.14      91.33   93.20
                    CARL-CCI                     91.18        94.31      89.67    90.89     93.67        95.17      92.00   93.56
                    CARL-CCI w/o AL and CL       89.34        88.44      90.52    89.47     89.33        88.31      90.67   89.47
                    CARL-CCI w/o AL              90.19        89.85      90.61    90.23     91.00        89.68      92.67   91.15
     CCIBENCH
                    CARL-CCI w/o CL              93.10        93.55      92.58    93.06     94.00        93.42      94.67   94.04
                    CARL-CCI                     93.43        94.01      92.77    93.38     95.67        96.60      94.67   95.62

(CodeT5+, 110M parameters), outperforms all LLMs tested, with the full
model on the full test set, F1 decreases by 3.92% including
DeepSeek-Coder (7B), Qwen2.5-Coder (7B), on JITDATA and 4.37% on
CCIBENCH when omitting both and CodeLLaMA (7B) on both benchmark
datasets. For components. Incorporating only contrastive loss (CARL-CCI
example, considering F1-Score, CARL-CCI achieves an im- w/o AL )
slightly improves the performance. Regarding the F1- provement of
11.13%, 6.19% and 10.48% on JITDATA Score on CCIBENCH, the model
achieves an increasing of and an increasing of 10.54%, 5.50% and 9.70%
on 0.85% on the full test set and 1.88% on the validated test CCIBENCH,
comparing to CodeLLaMA, Qwen2.5-Coder set comparing to the lowest
configuration. However, when and DeepSeek-Coder, respectively. Among the
LLMs, we omit the contrastive loss and retain only activity labeling
Qwen2.5-Coder performs best, reaching nearly 87% F1 and (CARL-CCI w/o CL
), performance remains comparable to the indicating substantial promise
over current LLM baselines. full configuration across both datasets and
all metrics. For instance, on the full test set, F1 improves by 4.01% on
Answer to RQ1 . CARL-CCI demonstrates superior performance CCIBENCH and
3.75% on JITDATA relative to the lowest- across both datasets,
surpassing both prior works and recent fine- performing setup. A similar
pattern holds on the validated set, tuned LLMs, establishing itself as
the leading approach for Just- with gains of 5.11% on CCIBENCH and 4.06%
on JITDATA. in-time CCI detection. This demonstrates that the
decomposition of code-diff se- B. RQ2 : How does each component of
CARL-CCI contribute quence into old and new token spans enables the
model to to the final performance? more effectively detect inconsistent
comments. Overall, the We examine three ablation study configurations:
(i) using results validate that both modules complement each other to
CARL-CCI without activity labeling and contrastive loss; (ii) achieve
robust just-in-time inconsistency detection. using CARL-CCI without
activity labeling; and (iii) using CARL-CCI without contrastive loss. As
can be seen in Ta- ble III, eliminating both components (activity
labeling and the contrastive loss) produces the lowest performance.
Compared  Answer to RQ2 . The most consequential factor is the explicit
R EFERENCES decomposition of code diffs into old and new modifications;
other component, the label-aware contrastive loss further reinforce
\[1\] Y. Padioleau, L. Tan, and Y. Zhou, "Listening to programmers ---
performance. taxonomies and characteristics of comments in operating
system code," 2009 IEEE 31st International Conference on Software
Engineering, pp. 331--341, 2009. C. Threats to Validity \[2\] F. Wen, C.
Nagy, G. Bavota, and M. Lanza, "A large-scale empirical study on
code-comment inconsistencies," 2019 IEEE/ACM 27th Inter- national
Conference on Program Comprehension (ICPC), pp. 53--64, 1) Internal
Validity: Our approach is based on the assump- 2019. tion that each
code--comment pair before a code change is \[3\] B. Fluri, M. Würsch, E.
Giger, and H. C. Gall, "Analyzing the co- consistent. If this assumption
does not hold, incorrect super- evolution of comments and source code,"
Software Quality Journal, vision signals may be introduced during
training. We evaluated vol. 17, pp. 367--394, 2009. \[4\] L. Tan, D.
Yuan, G. Krishna, and Y. Zhou, "/*icomment: bugs or bad the proposed
approach and other baselines on JITDATA and comments?*/," in Symposium
on Operating Systems Principles, 2007. its noise-removal version,
CCIBENCH. Although CCIBENCH has \[5\] Z. M. J. Jiang and A. Hassan,
"Examining the evolution of code been carefully cleaned to remove most
mislabeled samples, comments in postgresql," in IEEE Working Conference
on Mining Software Repositories, 2006. a few noisy records may still
remain, as some parts of the \[6\] W. M. Ibrahim, N. Bettenburg, B.
Adams, and A. Hassan, "On the cleaning process involved LLMs, which are
not fully error- relationship between comment update practices and
software bugs," J. free \[10\]. Syst. Softw., vol. 85, pp. 2293--2304,
2012. \[7\] A. Corazza, V. Maggio, and G. Scanniello, "Coherence of
comments 2) External Validity: One threat to external validity is and
method implementations: a dataset and an empirical investigation," that
our evaluation is limited to benchmark datasets with Software Quality
Journal, vol. 26, pp. 751 -- 777, 2016. about 33,000 training
examples---small relative to the broader \[8\] A. Cimasa, A. Corazza, C.
Coviello, and G. Scanniello, "Word em- beddings for comment coherence,"
2019 45th Euromicro Conference on code--comment space. In addition, the
data covers only Java Software Engineering and Advanced Applications
(SEAA), pp. 244--251, projects, which may constrain generalizability.
Nonetheless, 2019. because Java is widely used in code--comment
research, we \[9\] G. Rong, Y. Yu, S. Liu, X. Tan, T. Zhang, H. Shen,
and J. Hu, "Code comment inconsistency detection and rectification using
a large language contend that the core principles of our approach
readily model," 2025 IEEE/ACM 47th International Conference on Software
transfer to other programming languages. Engineering (ICSE),
pp. 1832--1843, 2025. \[10\] R. Zhong, Y. Huo, W. Gu, J. Kuang, Z.
Jiang, G. Yu, Y. Li, D. Lo, and M. R. Lyu, "Ccisolver: End-to-end
detection and repair of method-level VI. C ONCLUSION AND F UTURE W ORK
code-comment inconsistency," ArXiv, vol. abs/2506.20558, 2025. \[11\] S.
Panthaplackel, J. J. Li, M. Gligorić, and R. J. Mooney, "Deep just- In
this paper, we present CARL-CCI for automated just- in-time
inconsistency detection between comments and source code," in AAAI
Conference on Artificial Intelligence, 2020. in-time code--comment
inconsistency detection. Our method \[12\] I. K. Ratol and M. P.
Robillard, "Detecting fragile comments," 2017 combines a decomposition
of code diffs into activity-labeled 32nd IEEE/ACM International
Conference on Automated Software En- spans with label-aware contrastive
learning in a bimodal align- gineering (ASE), pp. 112--122, 2017. \[13\]
Z. Liu, H. Chen, X. Chen, X. Luo, and F. Zhou, "Automatic detection ment
framework. Experiments on JITDATA and CCIBENCH of outdated comments
during code changes," 2018 IEEE 42nd Annual show that CARL-CCI
outperforms recent baselines and rep- Computer Software and Applications
Conference (COMPSAC), vol. 01, resentative fine-tuned LLMs, underscoring
the benefits of pp. 154--163, 2018. \[14\] M. Allamanis, E. T. Barr, P.
T. Devanbu, and C. Sutton, "A survey pairing effective components with a
compact model. For future of machine learning for big code and
naturalness," ACM Computing work, we will pursue larger and more diverse
datasets, study Surveys (CSUR), vol. 51, pp. 1 -- 37, 2017. scalability
across programming languages, and extend the \[15\] Z. Liu, X. Xia, D.
Lo, M. Yan, and S. Li, "Just-in-time obsolete comment detection and
update," IEEE Transactions on Software Engineering, approach to
multilingual code and more complex real-world vol. 49, pp. 1--23, 2023.
code--comment settings. \[16\] S. Xu, Y. Yao, F. Xu, T. Gu, J. Xu, and
X. Ma, "Data quality matters: A case study of obsolete comment
detection," 2023 IEEE/ACM 45th International Conference on Software
Engineering (ICSE), pp. 781--793, ACKNOWLEDGMENT 2023. \[17\] Y. Zhang,
"Detecting code comment inconsistencies using llm and This paper has
been partially supported by the MOSAICO program analysis," in Companion
Proceedings of the 32nd ACM Inter- national Conference on the
Foundations of Software Engineering, 2024, project (Management,
Orchestration and Supervision of AI- pp. 683--685. agent COmmunities for
reliable AI in software engineering) \[18\] A. Authors, "Larger Is Not
Always Better: Leveraging Structured Code that has received funding from
the European Union under Diffs for Comment Inconsistency Detection."
Hugging Face, 2026. \[Online\]. Available:
https://huggingface.co/CARLCCI-repo/CARLCCI the Horizon Research and
Innovation Action (Grant Agree- \[19\] Y. Zhou, R. Gu, T. Chen, Z.
Huang, S. Panichella, and H. C. Gall, ment No. 101189664). The work has
been also partially "Analyzing apis documentation and code to detect
directive defects," supported by the European Union--NextGenerationEU
through 2017 IEEE/ACM 39th International Conference on Software
Engineer- ing (ICSE), pp. 27--37, 2017. the Italian Ministry of
University and Research, Projects PRIN \[20\] T. Steiner and R. Zhang,
"Code comment inconsistency detection with 2022 PNRR "FRINGE:
context-aware FaiRness engineer- bert and longformer," ArXiv,
vol. abs/2207.14444, 2022. ING in complex software systEms" grant
n. P2022553SL. \[21\] Z. Xu, S. Guo, Y. Wang, R. Chen, H. Li, X. Li, and
H. Jiang, "Code We acknowledge the Italian "PRIN 2022" project TRex-SE:
comment inconsistency detection based on confidence learning," IEEE
Transactions on Software Engineering, vol. 50, pp. 598--617, 2024.
"Trustworthy Recommenders for Software Engineers," grant \[22\] OpenAI,
"GPT-4o," https://openai.com/index/hello-gpt-4o/, 2024, ac-
n. 2022LKJWHC. cessed: 2024-06-18. \[23\] Anthropic, "Claude 3.5:
Sonnet," https://www.anthropic.com/news/ claude-3-5-sonnet, 2024,
accessed: 2024-07-10. \[24\] AI@Meta, "Llama 3 model card,"
https://github.com/meta-llama/llama3/ blob/main/MODEL CARD.md, 2024,
accessed: 2024. \[25\] A. Dau, J. Guo, and N. D. Q. Bui, "Docchecker:
Bootstrapping code large language model for detecting and resolving
code-comment incon- sistencies," in Conference of the European Chapter
of the Association for Computational Linguistics, 2023. \[26\] A.
Radford, J. W. Kim, C. Hallacy, A. Ramesh, G. Goh, S. Agarwal, G.
Sastry, A. Askell, P. Mishkin, J. Clark, G. Krueger, and I. Sutskever,
"Learning transferable visual models from natural language supervi-
sion," in International Conference on Machine Learning, 2021. \[27\] Q.
Chen, R. Zhang, Y. Zheng, and Y. Mao, "Dual contrastive learn- ing: Text
classification via label-aware data augmentation," ArXiv, vol.
abs/2201.08702, 2022. \[28\] DeepSeek-AI, Q. Zhu, D. Guo, Z. Shao, D.
Yang, P. Wang, R. Xu, Y. Wu, Y. Li, H. Gao, S. Ma, W. Zeng, X. Bi, Z.
Gu, H. Xu, D. Dai, K. Dong, L. Zhang, Y. Piao, Z. Gou, Z. Xie, Z. Hao,
B.-L. Wang, J.-M. Song, D. Chen, X. Xie, K. Guan, Y. mei You, A. Liu, Q.
Du, W. Gao, X. Lu, Q. Chen, Y. Wang, C. Deng, J. Li, C. Zhao, C. Ruan,
F. Luo, and W. Liang, "Deepseek-coder-v2: Breaking the barrier of
closed-source models in code intelligence," ArXiv, vol. abs/2406.11931,
2024. \[29\] B. Hui, J. Yang, Z. Cui, J. Yang, D. Liu, L. Zhang, T. Liu,
J. Zhang, B. Yu, K. Dang, A. Yang, R. Men, F. Huang, S. Quan, X. Ren, X.
Ren, J. Zhou, and J. Lin, "Qwen2.5-coder technical report," ArXiv, vol.
abs/2409.12186, 2024. \[30\] B. Rozière, J. Gehring, F. Gloeckle, S.
Sootla, I. Gat, X. Tan, Y. Adi, J. Liu, T. Remez, J. Rapin, A.
Kozhevnikov, I. Evtimov, J. Bitton, M. P. Bhatt, C. tian Cantón Ferrer,
A. Grattafiori, W. Xiong, A. D'efossez, J. Copet, F. Azhar, H. Touvron,
L. Martin, N. Usunier, T. Scialom, and G. Synnaeve, "Code llama: Open
foundation models for code," ArXiv, vol. abs/2308.12950, 2023. 
