                                          Noname manuscript No.
                                          (will be inserted by the editor)




                                         Deep Learning Based Identification of Inconsistent
                                         Method Names: How Far Are We?

                                         Taiming Wang 1 · Yuxia Zhang 1,* · Lin
                                         Jiang 2 · Yi Tang 3 · Guangjie Li 3 ·
                                         Hui Liu 1,*



                                         Received: date / Accepted: date

arXiv:2501.12617v1 \[cs.SE\] 22 Jan 2025

                                         Abstract For any software system, concise and meaningful method names
                                         are critical for program comprehension and maintenance. However, for various
                                         reasons, the method names might be inconsistent with their corresponding im-
                                         plementations. Such inconsistent method names are confusing and misleading,
                                         often resulting in incorrect method invocations. To this end, a few intelligent
                                         deep learning-based approaches based on neural networks have been proposed
                                         to identify such inconsistent method names in the industry. Existing evalua-
                                         tions suggest that the performance of such DL-based approaches is promising.
                                         However, the evaluations are conducted with a perfectly balanced dataset
                                         where the number of inconsistent method names is exactly equivalent to that of
                                         consistent ones. In addition, the construction method of this balanced dataset
                                         is flawed, leading to false positives in this dataset. Consequently, the reported
                                         performance may not represent their efficiency in the field where most method
                                         names are consistent with their corresponding method bodies and only a small
                                         part of method names are inconsistent with corresponding method bodies. To
                                         this end, in this paper, we conduct an empirical study to assess the state-of-
                                         the-art DL-based approaches in the automated identification of inconsistent
                                         method names. We first build a new benchmark (dataset) by using both auto-
                                         matic identification from commit history and manual inspection by developers,
                                         aiming to reduce the number of false positives. Based on the benchmark, we
                                         evaluate five representative DL-based approaches to identifying inconsistent
                                           Yuxia Zhang
                                         E-mail: yuxiazh@bit.edu.cn
                                           Hui Liu
                                         E-mail: liuhui08@bit.edu.cn

                                         1 School of Computer Science & Technology, Beijing Institute of Technology, Bei-
                                         jing, China. E-mail: wangtaiming@bit.edu.cn, yuxiazh@bit.edu.cn, liuhui08@bit.edu.cn
                                         2 China Telecom Corporation Limited Beijing Research Institute, Beijing, China. E-mail:
                                         jiangl34@chinatelecom.cn
                                         3 Academy of Military Science of the People’s Liberation Army National Innovation Institute
                                         of Defense Technology, Beijing, China. E-mail: xtangee@hotmail.com, liguangjie er@126.com

2 Taiming Wang 1 et al.

method names (one is retrieval-based and four are generation-based). Our
evaluation results suggest that the performance of the evaluated
approaches is substantially reduced when we switch from the existing
balanced dataset to our new benchmark. Furthermore, to reveal where and
why the evaluated approaches work/fail, we conduct quantitative and
qualitative analyses of the evaluation results. Our analysis results
suggest that the evaluated approaches work well on methods with simple
bodies and short names, and retrieval-based approaches are especially
good at methods whose names start with popular first sub-tokens.
Retrieval-based approaches fail frequently because the adopted method
representation technique is not efficient enough. Another possible rea-
son for the failures is their unverified rationale, i.e., two methods
with similar bodies should have similar names. Generation-based
approaches frequently fail because of inaccurate similarity calculation
formulas and immature method name generation techniques. Through the
data analysis, we also propose two possible ways for better identifying
inconsistent method names by leveraging contrastive learning and LLMs.
Overall, our empirical study suggests that the state-of-the-art DL-based
approaches in inconsistent method name identifica- tion deserve
significant improvement before applying them to practical software
systems. Keywords Method Names · Neural Networks · Inconsistency
Checking · Empirical Study

1 Introduction

Identifiers, i.e., the names of software entities, make up approximately
70% of source code (Deissenboeck and Pizka 2006). Such identifiers play
an important role in program comprehension and software maintenance
(Allamanis et al. 2015; Butler et al. 2010; Lin et al. 2019). Therefore,
their quality is critical (Lawrie et al. 2006; Schankin et al. 2018; Lin
et al. 2017; Binkley et al. 2013; Liu et al. 2015). As an important type
of identifier, concise and meaningful method names can provide intuitive
information about the method behaviors (Allamanis et al. 2016;
Alsuhaibani et al. 2021). Developers often guess the functionalities of
methods according to the short and meaningful method names instead of
complex and lengthy implementations (method bodies) (Gethers et
al. 2011; Bavota et al. 2013; Deissenboeck and Pizka 2015). However,
naming a method properly is not an easy case for developers. Studies
suggest that naming software entities is one of the most difficult tasks
for programmers (Johnson 2018a,b). As a result, developers often write
poor (i.e., inconsistent) method names in programs due to a lack of
thesaurus, conflicting styles during collaboration, and improper code
cloning (Kim and Kim 2016). The improper (inaccurate) method names tend
to lead misunderstandings (Takang et al. 1996; Liblit et al. 2006;
Arnaoudova et al. 2016; Hofmeister et al. 2017; Arnaoudova 2010) and may
result in incorrect method invocation and software defects (Butler et
al. 2009; Amann et al. 2018; Abebe et al. 2011, 2012; Aghajani et
al. 2018). Furthermore, these naming issues could negatively affect
other software applications that Empirical Study on DL-based
Identification of Inconsistent Method Names. 3

rely on them (Allamanis et al. 2015). Many companies are paying
attention to naming conventions and coding standards (Allamanis et
al. 2014). Identifying inconsistent method names in software projects
could significantly improve the quality of the codebase and lower the
cost of project maintenance (Butler et al. 2009). Since consistency in
software engineering is well-understood to be consistent usage of naming
style, indentation, etc., inconsistency may exist between sets at
different levels, e.g., a collection of method names or just a method
with both name and body. To clarify the meaning of inconsistency and
avoid misunderstanding, here we define "inconsistent method names": An
inconsistent method name is a method name that cannot fully deliver the
semantic meaning of its corresponding method body, i.e., inconsistent
with its body, which could be misleading and result in possible software
defects. A few DL-based approaches have been proposed to identify
inconsistent method names (Høst and Østvold 2009; Liu et al. 2019;
Nguyen et al. 2020; Li et al. 2021b). Høst et al. (Høst and Østvold
2009) build the first mining-based approach that is specially designed
to identify inconsistent method names. With the increasing popularity of
deep learning techniques and the principle of software naturalness
(Hindle et al. 2016; Allamanis et al. 2018; Lin et al. 2019; Arima et
al. 2018; Ray et al. 2016), DL-based approaches have been proposed to
identify inconsistent method names (Liu et al. 2019; Nguyen et al. 2020;
Li et al. 2021b). Liu et al. (Liu et al. 2019) proposed an approach (we
noted it as IRM CC for convenience in the rest of the paper) that debugs
inconsistent method names by leveraging convolutional neural network
(CNN) (Matsugu et al. 2003), Word2vec (Mikolov et al. 2013), and
Paragraph2vec (Le and Mikolov 2014). It is the first approach that
combines deep learning techniques with information retrieval (IR)
techniques to solve the problem of inconsistent method name
identification and yields good performance. M NIRE proposed by Nguyen et
al. (Nguyen et al. 2020) is another DL-based approach. It first
generates a name for the target method and then determines whether the
name is inconsistent by comparing the similarity between the generated
name and the original one. M NIRE is the first generation-based approach
in the automated identification of inconsistent method names, and its
performance is even better than that of IRM CC. Li et al. (Li et
al. 2021a) proposed to identify inconsistent method names using a
DL-based classifier. DeepName, proposed by Li et al. (Li et al. 2021b),
and Cognac, proposed by Wang et al. (Wang et al. 2021a), leverage the
same strategy as M NIRE but incorporate more types of context to
identify inconsistent method names. Overall, the DL-based approaches
have obtained a promising performance. However, despite the promising
performance as reported, we still lack a comprehensive understanding of
the state-of-the-art DL-based approaches in the automated identification
of inconsistent method names. We notice that all the existing
evaluations employed a single testing dataset where the number of
inconsistent method names exactly equals that of consistent ones.
However, testing data in the field is significantly imbalanced because
most method names (especially those in high-quality projects) are
consistent with their corresponding method bodies (Liu et al. 2019). As
a result, the number of 4 Taiming Wang 1 et al.

inconsistent method names is significantly smaller than that of
consistent ones. It remains unknown whether replacing the existing
perfectly balanced testing dataset with a seriously imbalanced new
dataset will result in changes in the performance of the evaluated
approaches. In addition, the construction method of Liu et al. is flawed
because it cannot guarantee that the method name changes are associated
with the inconsistency between names and bodies (Wen et al. 2020, 2022;
Kim et al. 2023), leading to false positives in this dataset. Therefore,
a new benchmark is needed to evaluate the performance of DL- based
approaches in real-world scenarios and also to facilitate the
evaluations of subsequent approaches. Besides the unclear overall
performance of the state-of- the-art DL-based approaches on more
realistic testing datasets, it also remains unknown where and why such
DL-based approaches work or fail. These open questions are important for
both researchers and practitioners: They should know whether the
state-of-the-art DL-based approaches are accurate enough to be applied
in the field, and if not, how to improve them. To this end, in this
paper, to provide some practical guidelines in the future development of
DL-based approaches, we conduct an extensive empirical study on the
state-of-the-art DL-based approaches in the identification of
inconsistent method names on a large-scale test dataset (BenM ark)
including 2,443 inconsistent methods and 1,296,743 consistent ones. The
new dataset is constructed over 430 high-quality projects collected by
Liu et al. (Liu et al. 2019). We selected five representative DL-based
approaches, i.e., the approach proposed by Allamanis et al. (Allamanis
et al. 2016) (noted as CAN ), the approach proposed by Liu et al. (Liu
et al. 2019) (noted as IRM CC), M NIRE (Nguyen et al. 2020), Cognac
(Wang et al. 2021a), and GT N M (Liu et al. 2022) for the empirical
study. Our empirical study investigates the following research
questions:

-- RQ1: How do the selected DL-based approaches perform when switching
from within-project setting to cross-project setting? Motivation: To the
best of our knowledge, all the existing approaches are evaluated in a
within-project setting. However, although within-project can be useful
in some cases, it requires repetitious training of the models, which is
often time-consuming and resource-consuming. By contrast, in the
cross-project settings, users can train the model once and use this
model to predict any new test data, which significantly facilitates
usage. Therefore, we design this research question to investigate the
application of existing approaches in the popular cross-project setting.
Answering RQ1 would reveal whether the state-of-the-art DL-based
approaches can be used with cross-project settings and also achieve
promising performance. Answer: Switching from a within-project setting
to a cross-project setting slightly changes the performance of the
evaluated approaches. The evaluated approaches can achieve promising
performance in both cross-project settings and within-project settings.
Since cross-project pattern requires no repeated training, such
approaches could be used (by their potential users) more conveniently
without a substantial reduction in performance. Empirical Study on
DL-based Identification of Inconsistent Method Names. 5

-- RQ2: How do the selected DL-based approaches perform when changing
the ratio of inconsistent and consistent method names in testing data?
Motivation: Note that all the existing approaches are evaluated in a
dataset where the number of inconsistent method names exactly equals
that of consistent ones. However, consistent method names are more
popular than inconsistent ones in the field. Therefore, we design this
research question to investigate whether the existing approaches can
still achieve promising performance in a more realistic setting.
Answering RQ2 would reveal how the evaluated approaches will be impacted
by the ratio of inconsistent and consistent methods in testing data.
Answer: The performance of the evaluated approaches is impacted substan-
tially by the ratio of inconsistent and consistent method names.
Lowering the ratio of inconsistent method names results in a dramatic
decline in the precision of identifying inconsistent method names.
Existing DL-based approaches for method name consistency checking may
not work accurately in the field. -- RQ3: Where and why do the IR-based
approaches work or fail? Motivation: Since few related approaches have
been proposed since 2022, an empirical study is desperately needed to
motivate the design of more advanced approaches. Answering RQ3 would
reveal the strengths and weak- nesses of IR-based approaches and may
provide insights for further research aimed at improving their
performance. Answer: IR-based approach, i.e., IRM CC works better on
methods with simple bodies and methods whose names start with popular
sub-tokens. However, it fails because of two major reasons: 1) the
method body rep- resentation is not efficient, and 2) the hypothesis
(i.e., two methods with similar bodies should have similar names) does
not hold sometimes. -- RQ4: Where and why do the generation-based
approaches work or fail? Motivation: Since generation-based approaches
are the mainstream method for identifying inconsistent method names, it
is worth dedicat- ing more effort to analyzing their strengths and
weaknesses to further improve their performance. Answer:
Generation-based approaches, i.e., CAN , M NIRE , Cognac, and GT N M ,
work better on methods with simple bodies and short names. They
frequently fail because of the ineffective similarity calculation
formula and the immature method name generation techniques.

This paper makes the following contributions:

-- A new, clean benchmark, thoroughly inspected manually, that is large
and reflective of real-world scenarios for identifying inconsistent
method names. -- An extensive empirical study on the representative
DL-based approaches for automated identification of inconsistent method
names under different empirical settings. 6 Taiming Wang 1 et al.

-- Key insights that serve as take-away messages, which could be
valuable for the future development of advanced approaches. The rest of
this paper is structured as follows. We review related work in Section 2
and introduce the empirical settings, new dataset construction, and
hyperparameter tuning in Section 3. Sections 4-7 present the methods and
result analysis. Section 8 first discusses threats to validity and
limitations. Then a complementarity analysis is presented. Lastly, some
insights are also provided for subsequent research in this section.
Section 9 concludes the paper.

2 Related Work

Inconsistent names tend to lead to misunderstandings among develop- ers
(Takang et al. 1996; Liblit et al. 2006; Arnaoudova et al. 2016;
Hofmeister et al. 2017; Arnaoudova 2010) and may result in incorrect
method invocation and software defects (Butler et al. 2009; Amann et
al. 2018; Abebe et al. 2011, 2012; Aghajani et al. 2018). To identify
inconsistent method names, a few automatic approaches have been
proposed. The task of the identification of inconsistent method names is
to identify the method names that do not fully de- scribe the
functionality and semantics of their method bodies. The mainstream
methods include information retrieval-based approaches, i.e., retrieving
from a large code corpus, and generation-based approaches, i.e.,
generating a method name first, and then validating whether it is
consistent with method bodies. We will elaborate on the mainstream
approaches in the below subsections. There are also other approaches,
such as data mining-based approach (Høst and Østvold 2009) or
classifiers based on DNNs (Li et al. 2021a). However, since they are not
mainstream methods for identifying inconsistent method names, we did not
include them in the evaluation in this paper.

2.1 Empirical Studies on Identification of Inconsistent Method Names

Notably, some empirical studies that focus on the topic of inconsistent
method names are also presented (Minehisa et al. 2021; Kim et al. 2023).
Minehisa et al. (Minehisa et al. 2021) presented a comparative study of
the vectorization approaches used in inconsistency detection. This work
compares the compu- tational cost and the performance of four different
vectorization approaches, proving that Sent2Vec is the best approach
which can build a vectorization model 14 times faster than CNN without
sacrificing the performance of detect- ing inconsistent method names.
This work only focuses on the vectorization approaches used in the
approaches. By contrast, our work extensively evaluated the performance
of state-of-the-art approaches in different application scenarios and
investigated the reason why they succeed or fail. Kim et al. (Kim et al.
2023) also presented an empirical study similar to this paper. As far as
we know, it is the first work to propose to evaluate the approaches
designed to detect inconsistency between method names and bodies from a
different perspective Empirical Study on DL-based Identification of
Inconsistent Method Names. 7

based on code review. The authors first constructed a sample benchmark
by matching name changes with code reviews. Then they conducted an
empirical study on how state-of-the-art approaches perform on this
sample benchmark. In addition, they also identified potential biases in
the evaluation of SOTA techniques. The major difference between this
work and the work presented in this paper is two-fold: First, the
rationale of constructing a dataset is different. This work is from the
perspective of code review while our work is from a traditional
perspective of mining from commit histories combined with manual
inspection. Second, the perspective of data analysis is different. This
work conducted the data analysis from the perspective of the dataset,
indicating that the methods in their benchmark may provide additional
information for the correct identification. Besides the analysis based
on the dataset, our work further analyzed when and where the evaluated
approaches work or fail from different perspectives, e.g., length of
method names, initial tokens of method names, complexity of method
bodies, and the adopted vectorization techniques.

2.2 Information Retrieval-based Approaches

Liu et al. (Liu et al. 2019) proposed a DL-based approach to identify
inconsistent method names. To the best of our knowledge, this is the
first approach combining deep learning techniques with an information
retrieval mechanism for the automated identification of inconsistent
method names. In addition, Liu et al. (Liu et al. 2019) constructed the
first benchmark for the task of detecting inconsistent method names,
which are extensively used for the evaluations of the subsequent
approaches. Consequently, we presented it as a single category. It
converts the method bodies and names in training data into fixed- length
vectors by training the models through deep learning techniques, i.e.,
convolutional neural network (CNN) (Matsugu et al. 2003), Word2vec
(Mikolov et al. 2013), and Paragraph2vec (Le and Mikolov 2014). After
the training, the models that can convert method names and bodies into
vectors are obtained, and all the converted vectors of method names and
bodies in training data constitute the name vector space vsname and body
vector space vsbody , respectively. For a method \< M body, M name \> to
be tested, it first converts M body and M name into vectors using the
pre-trained model, then it searches the body vector space vsbody for
method bodies whose vectors are highly similar to that of M body and
collects the method names (noted as M N s1 ) associated with the
resulting method bodies. It also searches the name vector space vsname
for method names (noted as M N s2 ) that are both lexically and
semantically similar to M name. If M N s1 has no method name that shares
the same first sub-token with any method name in M N s2 , the test
method name will be identified as an inconsistent name. To evaluate the
proposed approach, Liu et al. (Liu et al. 2019) discovered the renaming
of methods by mining version control systems. Exactly half of the
renaming (randomly selected) was exploited to create positive items
(inconsistent method names) by extracting the elder 8 Taiming Wang 1 et
al.

version of the method names. The other half of the renaming was used to
create negative items (consistent method names) by extracting the new
version of the method names. Their evaluation of the resulting data
(noted as OriginalData in the rest of our paper) suggests that their
approach is accurate, with a precision of 56.8% an d a recall of 84.5%.
Besides, Liu et al. conducted a live study on active software projects,
and 73 out of 100 pull requests for renaming suggestions were accepted
by the developers, which proves the effectiveness of the proposed
approach.

2.3 Generation-based Approaches

The rationale of generation-based approaches is to first generate a
method name for a specific method body. Then they calculate the lexical
similarity between the generated method name and the original one.
Finally, a similarity threshold is adopted to identify whether the
original method name is consistent with its method body according to the
lexical similarity calculated above. There are three approaches (Nguyen
et al. 2020; Li et al. 2021b; Wang et al. 2021a) proposed with
evaluations on the task of identification of method name consistency. In
addition, there are many approaches designed for method name generation
without the evaluation of our task. For these approaches, we only
consider the latest one (Liu et al. 2022), and the pioneering one
(Allamanis et al. 2016) as the baselines in this paper. M NIRE proposed
by (Nguyen et al. 2020) is another DL-based approach. To the best of our
knowledge, this is the first generation-based approach to automated
identification of inconsistent method names. For a method \< M body, M
name \> to be tested, M NIRE first leverages a deep neural network to
generate a method name (noted Ng ) for the given method body M body.
Then it computes the lexical similarity between the generated method
name Ng and the original one M name based on the overlapping rate of
sub-tokens. If and only if the similarity Sim(Ng , M name) is smaller
than a threshold (0.94 in their evaluation), method name M name will be
regarded as inconsistent. One of the key contributions is that M NIRE
leverages additional contexts (e.g., the methods' parameter types,
return type, and the enclosing class name) besides the method body to
generate the method name. M NIRE was evaluated on the dataset
OriginalData created by Liu et al. (Liu et al. 2019). Their evaluation
results suggest that M NIRE outperforms baseline approaches by improving
precision from 56.8% to 62.7% and recall from 84.5% to 93.6%. Besides,
in the live study conducted by Nguyen et al., 31 out of 42 pull requests
for renaming suggestions were acknowledged by the developers. The
evaluation results indicate that M NIRE works well on the identification
of inconsistent method names. DeepName proposed by Li et al. (Li et
al. 2021b) is another DL-based ap- proach to the automated
identification of inconsistent method names. Different from existing
approaches, DeepName exploits tokens in the caller and callee method of
the method under test. Furthermore, they proposed a Non-copy Empirical
Study on DL-based Identification of Inconsistent Method Names. 9

mechanism to further improve the generic RNN-based encoder-decoder
models. As a result of the additional information and additional
mechanism, DeepName achieves an F-score of 81.0% and an accuracy of
75.8%. Cognac proposed by Wang et al. (Wang et al. 2021a) is the latest
DL- based approach for the automated identification of inconsistent
method names. Compared with DeepName, Cognac further leveraged prior
knowledge (i.e., probability) of sub-tokens appearing in different
contexts besides caller and callee method tokens. In addition, Cognac
leverages a customized pointer- generator network to incorporate the
prior knowledge. The evaluation results suggest Cognac achieves an
F-score of 80.6% and an accuracy of 76.6%. Notably, both evaluations are
based on the dataset OriginalData created by Liu et al. (Liu et
al. 2019). Allamanis et al. (Allamanis et al. 2016) proposed a DL-based
approach the generate method names. They leveraged a convolutional
attentional network to generate short and descriptive summaries (i.e.,
method names) for a piece of code snippets. As the first attempt, they
generate summary tokens based on the weights of the method body tokens
with the help of the attention mechanism and copy mechanism. To the best
of our knowledge, this is the first DL-based approach for the method
name generation. We take it into our evaluation because it is pioneering
and representative. GTNM proposed by Liu et al. (Liu et al. 2022) is
currently the state-of- the-art approach for method name generation.
GTNM is a transformer-based model that leverages the self-attention
mechanism to capture the rich semantic information of method bodies. It
initially leveraged the global context of the target method to generate
names. The global context includes in-file methods (i.e., other method
names in the same file with the target method) and cross-file methods
(i.e., the method names in the files imported by the file containing the
target method). They also incorporate documentation of methods as a type
of context. We conclude from the preceding analysis that there are some
effective approaches to automated identification of inconsistent method
names. However, the state-of-the-art DL-based approaches (Liu et
al. 2019; Nguyen et al. 2020; Li et al. 2021b; Wang et al. 2021a) have
adopted the same dataset and are only evaluated on the same evaluation
setting (i.e., within-project setting and balanced dataset with
equivalent inconsistent method names and consistent method names). Liu
et al. take these settings because all the testing methods they
extracted have two versions, i.e., the buggy version and the fixed
version. Liu et al. label the buggy version methods as inconsistent and
the fixed version methods as consistent, which results in a balanced
dataset. Nguyen et al. (Nguyen et al. 2020), Li et al. (Li et
al. 2021b), and Wang et al. (Wang et al. 2021a) use the same dataset and
setting to facilitate the comparison against IRM CC. However, it remains
unknown whether these DL-based approaches can achieve high accuracy in a
widely used setting (cross-project setting) on a more realistic dataset
(with a natural ratio of inconsistent method names), which motivates
this study. 10 Taiming Wang 1 et al.

                   Table 1: Overview of Existing Approaches.

     Name     Publication        Dataset          Accuracy   Classification   Selected
                             Self-built dataset                                  √
     CAN       ICML2016                              –        Generation
                                (11 projects)
                             Self-built dataset                                  √
     IRMCC     ICSE2019                            60.9%          IR
                               (430 projects)
                                                                                 √

M NIRE ICSE2020 Reuse Liu's Data 68.9% Generation DeepName ICSE2021
Reuse Liu's Data 75.8% Generation √ Cognac FSE2021 Reuse Liu's Data
76.6% Generation √ GTNM ICSE2022 Reuse Nguyen's Data -- Generation

3 Experimental Setup

3.1 Evaluated Approaches

An overview of the approaches that are designed to identify inconsistent
method names (or are capable of) is presented in Table 1. Notably, the
first two approaches were not named officially by their authors. For
simplicity's sake, we refer to the first one proposed by Allamanis et
al. (Allamanis et al. 2016), and the second approach proposed by Liu et
al. (Liu et al. 2019) as CAN , and IRM CC, respectively. Although CAN
and GT N M were not evaluated in the original paper, they are still
capable of identifying inconsistent method names. We take them into
evaluation due to their representativeness which is discussed in Section
2.3. Notably, although the implementation of DeepName is publicly
available (Li 2024), it cannot run smoothly. Moreover, we contacted the
authors and did not get feedback from them. Consequently, in this paper,
we select CAN (Allamanis et al. 2016), IRM CC (Liu et al. 2019), M NIRE
(Nguyen et al. 2020), Cognac (Wang et al. 2021a), and GT N M (Liu et
al. 2022) for evaluation.

3.2 Dataset

3.2.1 Reasons for Building BenMark

We first explain the reasons why constructing BenM ark is necessary. As
shown in Table 1, the state-of-the-art DL-based approaches (Liu et
al. 2019; Nguyen et al. 2020; Li et al. 2021b) are all evaluated on the
same dataset, created by (Liu et al. 2019). In this dataset, called
OriginalData (Liu 2024) for short in this paper, each instance in
OriginalData is a triplet, i.e., \< BuggyN ame, F ixedN ame, M ethodBody
\>. Liu et al. take half of the F ixedN ame and M ethodBody as
consistent methods, and the other half of the BuggyN ame and M ethodBody
as inconsistent methods for testing, resulting in a balanced dataset.
However, the ratio of inconsistent and consistent methods is extremely
imbalanced in real-world scenarios. To investigate how the ratio
Empirical Study on DL-based Identification of Inconsistent Method Names.
11

             Table 2: Statistics of Existing Dataset and BenMark.

                                        OriginalData        BenMark

                    #Methods(Inc)           1,402               2,443
                   #Methods(Con)            1,403             1,296,743
                   #Methods(Total)          2,805             1,299,186
                       Ratio                 1:1                1:531
                     a Inc represents inconsistent methods;
                     b Con represents consistent methods.

of inconsistent method names in testing data influences the performance
of the selected approaches, we have to construct a new test dataset
where the ratios of inconsistent and consistent methods are close to
that in real-world applications. In addition, as we can see from Table
2, the original test dataset, i.e., OriginalData, contains only 1,402
inconsistent methods and 1,403 consistent methods, which may lead to
unreliable evaluation results according to the findings of Liu et
al. (Liu et al. 2020). Constructing a substantially larger dataset could
be highly valuable for the evaluation. As is shown in Table 2, BenM ark
contains 2,443 inconsistent methods and 1,296,743 consistent methods,
and the ratio of inconsistent and consistent methods is 1:531, which
simultaneously solves the above-mentioned two problems. For the reasons
above, we build BenM ark by reusing the subject projects exploited by
existing DL-based approaches (Liu et al. 2019; Nguyen et al. 2020; Li et
al. 2021b; Wang et al. 2021a). There are 430 projects (i.e., GitHub
repositories) collected by Liu et al., and they are coming from four
well-known communities (namely Apache, Spring, Hibernate, and Google)
and have at least 100 commits, making sure that they have been
well-maintained. The list of project names and GitHub URLs can be found
in (Liu 2024). Detailed construction procedures are shown in Section
3.2.2.

3.2.2 Construction of BenMark

The construction of BenM ark includes two major steps, i.e., automatic
identi- fication and manual inspection. We first leveraged the basic
logic adopted by Liu et al. to automatically identify inconsistent and
consistent method names from projects' commit history. Since the
developers could rename a method for various reasons, the above
inconsistent method names obtained from renamings in commit history must
include noise. To reduce these noise data, we surveyed three developers
on how to pick out the genuine inconsistent method names and then
performed a manual inspection to maximally reduce the false positives.

Automatic Identification The automatic identification of inconsistent
and consistent method names are as follows: 12 Taiming Wang 1 et al.

-- Data cleaning. Following Liu et al. (Liu et al. 2019), we exclude
main methods, empty methods, constructor methods, example methods, and
methods with non-alphabetic names. -- Identifying inconsistent method
names. Following Liu et al. (Liu et al. 2019), we identify inconsistent
method names by mining the version control systems. If a method has been
renamed (while its body remains unchanged) in a commit and the method
remains untouched ever since then, we treat the elder name of the method
(i.e., before renaming) as an inconsistent name. Finally, we obtained
4,597 inconsistent methods. Note that Liu et al. filtered out the method
names whose first sub-tokens remain the same after renaming. While this
filtering is effective in avoiding false positives, it could also miss
some true cases. We removed this rule and further validated the data
manually. -- Identifying consistent method names. We only identify
consistent method names in a single snapshot (i.e., the last commit
version) of the application. A method in this snapshot is taken as
consistent if 1) the method body is not associated with any inconsistent
method names identified in the preceding step; 2) both the method body
and the method name are untouched during the last n commit versions. For
each subject project, n is a constant, i.e., the largest duration
between the creation time of a method and its first rename. The value of
n for each project can be found in the online appendix (Wang 2024).
Finally, we obtained 1,296,743 consistent methods.

Survey Inconsistent method names mined from commit histories could
involve various false positives because they can not guarantee the
method name changes are associated with the inconsistency between names
and bodies (Wen et al. 2020, 2022; Kim et al. 2023). To reduce the false
positives of the inconsistent method names obtained from the automatic
identification, we surveyed devel- opers to investigate how to
accurately identify genuine inconsistent method names based on renamings
mined from commit histories. To reduce the burden on developers, we
first conducted an initial inspection of the automatically identified
4,597 inconsistent method names and found three typical cases of false
positives: -- Typos correction, e.g., changing "getActoveWebflow" to
"getAc- tiveWebflow"; -- Format correction, e.g., changing "getTaskId"
to "getTaskID", or changing "reset" to " reset"; -- Add Trailing Number,
e.g., changing "getEventFilter" to "getEvent- Filter0"; These false
positives are not renamed due to the inconsistency between method names
and bodies. After the initial inspection, the number of inconsistent
method names is reduced to 4,102. From the remaining 4,102 inconsistent
method names, we randomly sampled 351 inconsistent methods for the
survey, with a confidence level of 95% and a Empirical Study on DL-based
Identification of Inconsistent Method Names. 13

margin of error of 5%. The participants we invited are three developers
working in internet companies, with three, four, and four years of Java
development experience, respectively. The questions posed to the
developers are listed as follows: -- First, you should determine whether
the given methods were renamed due to inconsistency between method names
and bodies based on your development experience. -- Second, during the
identification, you should try to state the reason be- hind your
judgment and summarize a criterion that can guide the manual
identification of inconsistent method names based on renaming instances.
Triplets \< BuggyN ame, F ixedN ame, M ethodBody \> are provided to the
developers, and the three developers were given one month to complete
the identification and provide a summary of their judgments. Following
this, two meetings, each lasting about one hour, were held to discuss
discrepancies and refine the judgment criteria. To assess the
reliability of the labeling process, we measure the inter-rater
agreement among the three developers by Cohen's kappa. The kappa value
is 0.62, indicating a substantial agreement and highlighting the
reliability of the identification. The results of the survey are
presented as follows: For the first question, we found that 237 out of
351 names were renamed due to the inconsistency between names and
bodies. However, the remaining 114 names were renamed but not associated
with inconsistency between names and bodies, i.e., false positives.
Three typical false positive cases are presented as follows: --
Synonyms. The changed parts (one or multiple sub-tokens) between BuggyN
ame and F ixedN ame are synonyms, e.g., "newDocument- Builder" is
renamed to "createDocumentBuilder" -- Abbreviations & Full Names. The
changed parts between BuggyN ame and F ixedN ame are a conversion
between abbreviations and full names, e.g., "readClassAndObject" is
renamed to "readClassAndObj". -- Different Word Orders. The differences
between BuggyN ame and F ixedN ame are only the word orders, e.g.,
"reservationSave" is renamed to "saveReservation". For the second
question, we adopted the thematic analysis (Cruzes and Dyba 2011) to
characterize how developers express the criteria for the identification
of genuine inconsistent method names and what are the possible
fine-grained types, according to the following process. (1) We first
read and analyzed all the answers to the second question to understand
how developers described the reason behind their judgments and
identified phrases that expressed the criteria. (2) We carefully reread
all the answers and identified phrases to generate initial codes and
organize them systematically. (3) After generating the initial codes, we
aggregated those with similar meanings and identified an initial theme
that represented each cluster. Following this step, all codes were
categorized under one of the initial themes, facilitating the
identification of any emergent cases. (4) We then reviewed the initial
set of themes to identify opportunities for 14 Taiming Wang 1 et al.

merging similar ones. By clarifying the essence of each theme, we
combined similar themes into a new overarching theme or incorporated a
theme as a sub-theme. (5) In the last step, we defined the final set of
themes. To minimize researcher bias, steps (1) to (4) described above
were conducted independently by the first two authors (Runeson and Höst
2009). Following this, a series of meetings was held to resolve
conflicts and finalize the assignment of themes (step 5). Finally, we
obtained two requirements to identify a genuine inconsistent method name
from a renaming refactoring mined from commit history: -- Misalignment
Between Names and Bodies: The BuggyN ame cannot comprehensively reflect
the functionality of the M ethodBody. This is a fundamental requirement
for identifying an inconsistent method name. -- Semantic Changes After
Renaming: BuggyN ame and F ixedN ame should have different semantic
meaning. This requirement further ensures developers intend to change
the semantics of the method names, validating the genuineness of the
inconsistent method names with endorsement from the original developer.
Among 237 cases that satisfy the above two criteria, we found three
fine- grained types of genuine inconsistent method names, and we call
them "Gen- eralize" type, "Narrow" type, and "Change" type, respectively
according to the types of semantic changes. Some typical examples of
these three types are presented in Listing 1: -- Generalize (22.4%), one
or multiple sub-tokens of BuggyN ame are removed, resulting in a more
generalized identifier, i.e., F ixedN ame. For example,
"getAbsoluteInitTime" is renamed to "getInitTime". -- Narrow (52.7%),
one or multiple sub-tokens are added to BuggyN ame, resulting in a more
descriptive identifier, i.e., F ixedN ame. For example, "getAddress" is
renamed to "getDestinationAddress". -- Change (24.9%), one or multiple
sub-tokens of BuggyN ame are changed into not related ones (not
generalized or narrowed), e.g., "getPropertyAs- signments" is renamed to
"createBuilder".

Manual Inspection With the above obtained judgment criterion, the first
and second authors manually inspected the remaining 3,751 inconsistent
meth- ods, independently. Any discrepancies were discussed through three
meetings (each meeting lasted for over two hours). The Cohen's kappa
coefficient is 0.75, indicating a substantial agreement between the two
authors. Finally, we obtained 2,443 genuine inconsistent method names
based on the renaming refactorings mined from commit histories in total.
It is worth noting that there are 1,414 (57.9%) inconsistent method
names belonging to the "Change" type, 192 (7.8%) inconsistent method
names belonging to the "Generalize" type, and 837 (34.3%) inconsistent
method names belonging to the "Narrow" type. The above findings to some
extent coincided with the results reported by Peruma et al. (Peruma et
al. 2018). Peruma et al. found that most rename refactorings narrow the
meaning of the identifiers where they are applied. Even  Empirical Study
on DL-based Identification of Inconsistent Method Names. 15

1 // Generalize \< getAbsoluteInitTime , getInitTime \> 2 public final
long getInitTime () { 3 return initTime ; 4 } 5 6 // Narrow \<
getAddress , getDestinationAddress \> 7 public I n e t S o c k e t A d d
r e s s g e t D e s t i n a t i o n A d d r e s s () { 8 return d e s t
i n a t i o n A d d r e s s ; 9 } 10 11 // Change \<
getPropertyAssignments , createBuilder \> 12 13 C l a s s I n t r o s p
e c t o r B u i l d e r createBuilder () { 14 return new C l a s s I n t
r o s p e c t o r B u i l d e r ( this ) ; 15 }

          Listing 1: Examples of Three Types of Inconsistent Method Names.



     though we have added several filtering to identify the renaming associated with
     inconsistency between names and bodies, there are still 34.3% renamings of
     the ”Narrow” type.
         Note that the consistent methods in BenM ark are too overwhelming, and
     manually checking every single method is practically infeasible. To assess the
     quality of the consistent methods in BenM ark and figure out the false positive
     rate, we randomly sampled methods from 1,296,743 consistent methods with a
     confidence level of 95% and a margin of error of 5%, resulting in a sampled
     dataset including 383 consistent methods. Two authors manually inspected
     each sampled method and identified whether the method names were consistent
     with their corresponding bodies. We obtained a perfect agreement (Cohen’s
     kappa coefficient 0.82) between the two authors. For the conflict cases, the two
     authors discussed until they reached a consensus. The final results suggested
     that 366/383=95.6% of the consistent methods are identical to the manually
     inspected results. That is to say, the false positive rate is only 4.4%.

     3.2.3 Construction of Training Data

     To maximize the performance of the baselines, we also filtered out the extremely
     complex methods as Liu et al. did. during the construction of training data.
     To facilitate the different empirical settings, we further constructed two sets of
     training data based on BenM ark:
      – CORPUS WP represents the training data for within-project setting.
      – CORPUS CP represents the training data for cross-project settings.
     Notably, the evaluated approaches request a large number of projects as a
     corpus for code retrieval (Liu et al. 2019), or for the training of method name
     generation models (Nguyen et al. 2020; Allamanis et al. 2016; Wang et al. 2021a;
     Liu et al. 2022). Neither of the evaluated approaches requests any labeling
     of the methods in the code corpus. To improve the reliability of the results

16 Taiming Wang 1 et al.

and conclusions, we perform 10-fold cross-validation experiments to
reduce the possible bias. The projects of each fold (10% of all the
projects) are used to identify inconsistent and consistent method names
for testing, and the projects of the other nine folds of data (90% of
all the projects) are used to construct training data, i.e., CORPUS CP.
That is to say, BenM ark contains 10 sets of data for training and
testing. We extract all the methods of the rest of 90% of the subject
projects at their latest snapshot, i.e., the submitted time of their
latest commits, following the state-of-the-art DL-based approaches (Liu
et al. 2019; Nguyen et al. 2020; Li et al. 2021b). For CORPUS WP, we
have to consider the timeline of testing and training data since it
makes no sense that new data are learned for predicting old data. To
this end, we construct the CORPUS WP by the following steps: First, we
collected the commits of testing data in the order of the timeline
(including inconsistent method names and consistent method names).
Second, we located the oldest commit, i.e., the commit that is submitted
the earliest among all the commits containing testing data. For
convenience, we call this commit commite . Finally, we collected
training data on the very commit before commite to mimic the real
scenarios. In addition, to avoid any data leakage, we carefully
eliminated all the methods included in the testing data from CORPUS WP
to make sure that there is no intersection between CORPUS WP and the
testing data.

3.2.4 Construction of Testing Data

To facilitate the RQ1 and RQ2, we further construct two new testing
datasets (we call BalancedData, N aturalData) based on BenM ark. Note
that these two datasets are constructed from each fold of BenM ark,
which means that there are 10 BalancedData and 10 N aturalData for all
the 10 folds of BenM ark respectively. Here are the construction
processes: -- N aturalData is constructed by reusing all the testing
data of BenM ark. This dataset is natural because we do not
intentionally control the ratio of inconsistent and consistent method
names. -- To investigate the performance of the evaluated approaches in
within-project setting and cross-project setting, we have to construct a
balanced dataset containing the same number of inconsistent and
consistent method names, i.e., BalancedData. BalancedData is constructed
by the following two steps. First, we reused all the inconsistent method
names in each fold of BenM ark (let the number of inconsistent method
names be Ni for each fold i), and such samples serve as positive items.
Second, we randomly sampled the same number of consistent method names
(i.e., Ni ) from the negative items in each fold of BenM ark, and such
samples serve as the negative items in the resulting testing data. To
ensure a fair sample, we made certain that the samples were evenly
distributed across projects. Specifically, we sampled consistent method
names based on the number of inconsistent method names in each project.
In other words, a project with more inconsistent method names should
sample a larger number of Empirical Study on DL-based Identification of
Inconsistent Method Names. 17

                    Table 3: Parameters Setting of IRM CC.

             Parameters of Paragraph2vec in IRM CC
                     Parameter           Value     Parameter       Value
                    Size of vector        300      Learning rate   0.025
                    Window size            4
             Parameters of Word2vec in IRM CC
                     Parameter           Value     Parameter       Value
                    Size of vector        300      Learning rate   0.001
                    Window size            4
             Parameters of IRM CC
                     Parameter           Value
                         k                 1


                      Table 4: Parameters Setting of CAN .

              Parameters of conv attention in CAN
                    Parameter          Value      Parameter        Value
                  Embedding size        128      Filters(layer1)     8
                 Window size(layer1)     24      Filters(layer2)     8
                 Window size(layer2)     29         Dropout         0.5
                 Window size(layer3)     10
              Parameters of copy attention in CAN
                    Parameter          Value      Parameter        Value
                  Embedding size        128      Filters(layer1)    32
                 Window size(layer1)     18      Filters(layer2)    16
                 Window size(layer2)     19         Dropout         0.4
                 Window size(layer3)      2

consistent method names. This dataset is balanced because the number of
inconsistent method names is the same as the number of consistent ones.
Subsequently, the resulting testing data, i.e., BalancedData, is
composed of Ni positive items and Ni negative items. Finally, the total
number of inconsistent method names in all 10 BalancedData equals P10
the number of inconsistent method names in the Benchmark., i.e., i=1 Ni
= 2, 443 (refer Table 2). The total number of consistent method names in
all 10 BalancedData is also 2,443.

3.3 Parameter Tuning

To maximize the potential of the evaluated approaches, we perform
hyperpa- rameter tuning for such approaches on a GPU server (OS: Ubuntu
18.04.1; 18 Taiming Wang 1 et al.

                   Table 5: Parameters Setting of M NIRE .

                  Parameter        Value     Parameter       Value
                  Learning rate    0.001    Embedding size    128
                   Batch size      1,024     Hidden size      256
                 Vocabulary size   50,000     Threshold       0.89


                   Table 6: Parameters Setting of Cognac.

                  Parameter        Value     Parameter       Value
                  Learning rate     0.15    Embedding size    150
                   Batch size       120      Hidden size      400
                 Vocabulary size   85,000     Threshold       0.85


                   Table 7: Parameters Setting of GT N M .

                  Parameter        Value     Parameter       Value
                  Learning rate    0.0001   Embedding size     512
                   Batch size        64      Hidden size      2048
                 Vocabulary size   10,000     Threshold       0.85

CPU: 32 \* Intel(R) Xeon(R) CPU E5-2620 v4 @ 2.10GHz; GPU: 4\* TITAN
RTX; RAM: 128 GB). For IRM CC, we follow the grid-search tuning approach
to tune the pa- rameters of Word2vec and Paragraph2vec, i.e., Size of
vector, Learning rate, and Window size. Given that Word2vec and
Paragraph2vec are both unsuper- vised learning approaches, we can only
identify the performance by conducting the entire experiments but the
whole process is time-consuming. To this end, we empirically selected
the next-to-be-tested setting, i.e., selecting the value that yields
higher accuracy for a single parameter. In the end, we take the
combination which yields the best accuracy value as the final
combination of parameters. Parameter k of IRM CC represents the number
of the most similar method names and bodies retrieved from the training
data. As reported by Liu et al. (Liu et al. 2019), k = 1 yields the best
performance of IRM CC when identifying inconsistent method names. To
this end, we set k = 1 all through the evaluation in this paper. For M
NIRE , we also follow the grid-search tuning approach to tune the
parameters with the help of NNI (Microsoft 2024) which is a widely used
toolkit to help developers design and tune machine learning models
effectively. We tuned the parameters, i.e., Learning rate, Embedding
size, Batch size, Hidden size, and Vocabulary size. For each of the
to-be-tested settings, we train M NIRE with the given setting on nine in
ten of the training data and then validate the performance on the
validation set (i.e., one in ten of the training data). The combination
which yields the highest accuracy is selected as the final Empirical
Study on DL-based Identification of Inconsistent Method Names. 19

Table 8: The training data and testing data leveraged in three empirical
settings.

                            TestingData                         TrainingData

                   BalancedData    NaturalData      CORPUS WP           CORPUS CP

Within-Project • - • - Cross-Project • - - • Natural Ratio - • - • •
Data Adopted; - Data Not Adopted.

parameter. In addition, M NIRE has an additional hyperparameter named
threshold. Following Nguyen et al., We tune the threshold from 0.85 to
1.0 with a step of 0.01 on the validation set, and finally take the
threshold which balances the F-scores of identifying consistent and
inconsistent method names, i.e., 0.89. For CAN , we tuned the
hyperparameters using Bayesian Optimization with Spearmint (Snoek et
al. 2012) following Allamanis et al. (Allamanis et al. 2016). The
validation set is one in ten of the training data. As CAN is not
originally designed for identifying inconsistent method names, we follow
M NIRE and use a specific threshold to conduct the identification. The
tuning of threshold is also conducted on the validation dataset with the
same procedure as that of M NIRE , and the final value of threshold is
0.90. For Cognac and GT N M , we tuned the parameters following the
grid- search tuning approach with the help of NNI (Microsoft 2024). The
included parameters are the same as the ones of M NIRE . For threshold,
we adopted the same tuning strategy, and the final values are both 0.85.
The final parameters of the approaches are presented in Table 3 - Table
7, respectively.

4 RQ1: Cross-Project VS. Within-Project

To answer this research question, we evaluate the selected DL-based
approaches with cross-project and within-project settings,
independently. Both within- project settings and cross-project settings
are valuable in different application scenes. For within-project
settings, instead of ignoring all data from the target project,
developers can put the confirmed consistent data into training data to
train a new model, and then further conduct the prediction on the
remaining data. However, this requires repetitious training of the
models, which is often time-consuming and resource-consuming. For
cross-project settings, users can train the model once and use this
model to predict any new test data. Therefore, they do not have to train
models on each new project they encounter, which significantly
facilitates usage. By comparing the performance of the same DL- based
approaches under two empirical settings, we can reveal whether the 20
Taiming Wang 1 et al.

Table 9: Performance (%) on Three Different Settings of 10-fold
Cross-Validation Experiment of IRM CC.

                Within-Project            Cross-Project            Natural Ratio
             F1       F1               F1      F1              F1       F1
     Fold                    ACC                      ACC                      ACC
            (Inc)   (Con)             (Inc)  (Con)            (Inc)   (Con)
      1     54.5     55.6    55.1     66.8    52.6     61.0    0.5     60.1     43.0
      2     44.9     52.6    49.0     66.7    50.5     60.2    0.6     57.7     40.6
      3     52.9     52.9    52.9     64.0    50.4     58.3    0.5     59.7     42.7
      4     49.0     52.3    50.7     63.2    47.7     56.8    0.4     56.5     39.5
      5     52.0     56.0    54.1     58.3    46.6     53.2    0.7     58.1     41.1
      6     52.8     49.0    51.0     58.6    44.0     52.4    0.6     54.5     37.6
      7     45.1     53.8    49.8     60.8    52.8     57.2    0.5     64.7     47.9
      8     51.9     48.0    50.0     68.9    52.7     62.4    0.7     59.0     42.0
      9     47.5     47.0    47.2     49.5    39.2     44.8    0.6     52.2     35.5
      10    66.4     62.6    64.6     54.2    50.3     52.3    0.9     65.1     48.4
     Avg.   51.7     53.0    52.4     61.1    48.7     55.9    0.6     58.8     41.8
     a Inc represents inconsistent methods;
     b Con represents consistent methods.

Table 10: Performance (%) on Three Different Settings of 10-fold Cross-
Validation Experiment of CAN .

                Within-Project            Cross-Project            Natural Ratio
             F1       F1               F1      F1              F1       F1
     Fold                    ACC                      ACC                      ACC
            (Inc)   (Con)             (Inc)  (Con)            (Inc)   (Con)
      1     66.9     26.4    54.3     71.1    34.1     59.8    0.5     34.4     21.0
      2     62.0     31.2    51.0     70.3    34.0     59.0    0.5     34.7     21.1
      3     66.9     26.8    54.4     68.7    32.7     57.3    0.3     34.3     20.8
      4     68.5     27.1    56.0     69.1    25.3     56.3    0.4     26.0     15.1
      5     68.3     30.1    56.4     69.5    26.9     56.9    0.7     27.1     15.9
      6     68.1     27.0    55.6     70.1    32.6     58.6    0.7     33.2     20.1
      7     70.0     37.7    59.5     70.7    38.9     60.4    0.5     40.4     25.5
      8     66.8     29.9    54.9     69.9    30.0     57.9    0.6     30.8     18.4
      9     68.2     24.9    55.3     68.1    24.6     55.2    0.9     25.5     14.9
      10    67.7     38.7    57.7     67.9    36.0     57.3    1.0     38.7     24.3
     Avg.   67.3     30.0    55.5     69.5    31.5     57.9    0.6     32.5     19.7
     a Inc represents inconsistent methods;
     b Con represents consistent methods.

evaluated approaches can also achieve promising performance in
cross-project settings. The adopted training data and testing data are
presented in Table 8. Empirical Study on DL-based Identification of
Inconsistent Method Names. 21

Table 11: Performance (%) on Three Different Settings of 10-fold Cross-
Validation Experiment of M NIRE .

               Within-Project            Cross-Project            Natural Ratio
            F1       F1               F1      F1              F1       F1
    Fold                    ACC                      ACC                      ACC
           (Inc)   (Con)             (Inc)  (Con)            (Inc)   (Con)
     1     67.4     37.3    57.1     69.3    43.2     60.1    0.5     46.7     30.6
     2     68.9     42.2    59.6     71.6    41.9     61.8    0.6     43.2     27.7
     3     66.1     45.0    58.1     69.1    45.0     60.4    0.5     48.9     32.5
     4     68.0     40.2    58.3     71.1    43.9     61.8    0.5     44.4     28.6
     5     68.4     40.8    58.8     69.1    39.0     58.9    0.7     41.6     26.5
     6     67.3     42.5    58.3     69.5    40.2     59.6    0.7     42.8     27.4
     7     63.8     45.7    56.5     70.9    49.4     63.0    0.5     53.1     36.3
     8     69.1     42.1    59.7     72.5    44.9     63.3    0.7     46.1     30.1
     9     58.7     32.4    48.7     65.6    35.7     55.2    0.9     39.8     25.1
     10    62.7     36.8    53.1     70.6    40.2     60.6    1.1     41.9     26.8
    Avg.   66.0     40.5    56.8     69.9    42.3     60.5    0.7     44.8     29.2
    a Inc represents inconsistent methods;
    b Con represents consistent methods.

Table 12: Performance (%) on Three Different Settings of 10-fold Cross-
Validation Experiment of Cognac.

               Within-Project            Cross-Project            Natural Ratio
            F1       F1               F1      F1              F1       F1
    Fold                    ACC                      ACC                      ACC
           (Inc)   (Con)             (Inc)  (Con)            (Inc)   (Con)
     1     66.3     39.6    56.8     70.6    34.8     59.5    0.7     33.6     20.4
     2     68.7     35.4    57.8     67.0    32.0     55.6    0.6     32.3     19.4
     3     70.3     37.0    59.6     68.0    34.7     57.0    0.6     28.9     17.1
     4     69.7     39.0    59.5     65.4    22.1     52.0    0.6     29.3     17.4
     5     64.7     22.8    51.5     67.0    18.3     53.0    0.9     28.8     17.1
     6     70.7     29.0    58.5     67.6    29.9     55.7    0.3     30.9     18.4
     7     63.2     25.0    50.6     69.2    32.1     57.6    0.5     37.4     23.2
     8     64.9     12.9    50.0     64.3    23.3     51.2    0.7     30.7     18.4
     9     66.7     25.7    54.0     68.2    27.5     55.8    0.8     26.6     15.7
     10    68.6     19.5    54.8     70.4    35.3     59.4    3.8     36.3     23.4
    Avg.   67.4     28.6    55.3     67.8    29.0     55.7    1.0     31.5     19.0
    a Inc represents inconsistent methods;
    b Con represents consistent methods.

4.1 Process

4.1.1 Cross-Project Evaluation

The testing data is BalancedData (see Section 3.2.4). The training
dataset (i.e., CORPUS CP, see Section 3.2.3) is constructed over the
rest of 90% of all the projects, i.e., the other 9 fold of data. This
dataset is leveraged to train 22 Taiming Wang 1 et al.

Table 13: Performance (%) on Three Different Settings of 10-fold Cross-
Validation Experiment of GT N M .

                Within-Project            Cross-Project            Natural Ratio
             F1       F1               F1      F1              F1       F1
     Fold                    ACC                      ACC                      ACC
            (Inc)   (Con)             (Inc)  (Con)            (Inc)   (Con)
      1     55.9     35.6    47.7     60.3    53.6     57.2    0.6     54.9     38.0
      2     65.9     38.1    56.0     64.6    42.9     56.3    0.4     48.8     32.3
      3     66.9     41.9    57.8     67.7    45.3     59.4    0.4     51.6     34.8
      4     67.4     34.5    56.5     65.3    36.8     55.2    0.4     48.2     31.9
      5     68.1     31.8    56.5     68.0    44.3     59.4    0.7     47.2     31.0
      6     71.5     48.4    63.3     68.4    51.5     61.7    0.2     51.9     35.1
      7     61.2     36.9    52.0     67.1    50.7     60.5    0.4     60.2     43.2
      8     63.2     35.5    53.1     65.6    41.3     56.6    0.7     48.3     32.0
      9     64.9     33.8    54.2     62.7    31.1     51.6    0.7     42.3     27.0
      10    72.7     62.9    68.5     74.2    52.6     66.6    3.1     53.3     37.0
     Avg.   65.8     39.9    56.6     66.4    45.0     58.4    0.8     50.7     34.2
     a Inc represents inconsistent methods;
     b Con represents consistent methods.

the method name generation model of M NIRE , CAN , Cognac, and GT N M ,
and it also serves as the code repository requested by IRM CC. The
evaluation is cross-project because the methods in the testing dataset
(i.e., BalancedData) and the methods in the training data (i.e., CORPUS
CP ) are extracted from different projects.

4.1.2 Within-Project Evaluation

The testing dataset in within-project settings is the same as that in
cross- project settings, i.e., BalancedData. The training dataset is
CORPUS WP (see Section 3.2.3) The evaluation is within-project settings
because the methods in the testing dataset (i.e., BalancedData) and the
methods in the training dataset (i.e., CORPUS WP ) may come from the
same project. Notably, cross- project evaluation and within-project
evaluation use the same subject projects selected by Liu et al. (Liu et
al. 2019). The major difference is that cross- project evaluation
partitions projects into testing and training projects that are
exploited to create testing data and training data respectively. In
contrast, within-project evaluation selects some methods as testing
data, and others are taken as training data regardless of where they
come from.

4.2 Results

Following existing evaluations (Liu et al. 2019), we leverage the
precision, recall, and F-score of identifying positive and negative
items as well as the overall accuracy for all testing items. Due to
limited space, we only report the Empirical Study on DL-based
Identification of Inconsistent Method Names. 23

            Table 14: Within-Project vs. Cross-Project (IRM CC).

                            Metrics     Within-Project     Cross-Project

                            Precision        52.3%              54.4%
           Inconsistent      Recall          51.3%              70.0%
                             F-score         51.7%              61.1%

                            Precision        52.6%              59.0%
            Consistent       Recall          53.6%              41.7%
                             F-score         53.0%              48.7%

                    Accuracy                 52.4%              55.9%



              Table 15: Within-Project vs. Cross-Project (CAN ).

                            Metrics     Within-Project     Cross-Project

                            Precision        53.2%              54.5%
           Inconsistent      Recall          91.8%              96.2%
                             F-score         67.3%              69.5%

                            Precision        71.6%              84.6%
            Consistent       Recall          19.2%              19.5%
                             F-score         30.0%              31.5%

                    Accuracy                 55.5%              57.9%



            Table 16: Within-Project vs. Cross-Project (M NIRE ).

                            Metrics     Within-Project     Cross-Project

                            Precision        54.3%              56.4%
           Inconsistent      Recall          84.2%              91.9%
                             F-score         66.0%              69.9%

                            Precision        66.1%              78.7%
            Consistent       Recall          29.4%              29.1%
                             F-score         40.5%              42.3%

                    Accuracy                 56.8%              60.5%

F-score of identifying positive and negative items and overall accuracy
for the 10-fold cross-validation experiments. The complete performance
is available in our public repository (Wang 2024). The performance of
each fold of data with within-project setting and cross-project setting
is presented in Table 9 - Table 13. The average evaluation results of
10-fold cross-validation experiments are presented in Table 14 - Table
18, and from these tables we make the following observations: 24 Taiming
Wang 1 et al.

           Table 17: Within-Project vs. Cross-Project (Cognac).

                         Metrics    Within-Project   Cross-Project

                        Precision       53.1%             53.3%
         Inconsistent    Recall         92.3%             93.1%
                         F-score        67.4%             67.8%

                        Precision       71.8%             72.8%
          Consistent     Recall         18.3%             18.2%
                         F-score        28.6%             29.0%

                 Accuracy               55.3%             55.7%


          Table 18: Within-Project vs. Cross-Project (GT N M ).

                         Metrics    Within-Project   Cross-Project

                        Precision       54.3%             55.1%
         Inconsistent    Recall         83.6%             83.7%
                         F-score        65.8%             66.4%

                        Precision       65.1%             68.0%
          Consistent     Recall         29.5%             33.8%
                         F-score        39.9%             45.0%

                 Accuracy               56.6%             58.4%

-- First, switching from the within-project setting to the cross-project
setting slightly improves the performance of IRM CC. The overall
accuracy is improved by 3.5 percentage points. We also notice that the
performance is reduced for consistent method names (negative items)
while the performance is improved for inconsistent ones (positive
items). The reduction in F- score is 4.3%=53.0%-48.7% for negative
items, and the F-score improves 9.4%=61.1%-51.7% for positive items. --
Second, the performance of generation-based approaches, i.e., CAN , M
NIRE , Cognac, and GT N M , also slightly improved when switching from
the within-project setting to the cross-project setting. The overall
accuracy is improved by 2.4, 3.7, 0.4, and 1.8 percentage points for the
generation-based approaches, respectively. Compared to the performance
of IRM CC, the F-score of identifying consistent and inconsistent method
names both increases. -- The slightly improved performance may be
attributed to the larger size of CORPUS CP compared to CORPUS WP. With
more training data, IR-based approach and generation-based approaches
are trained more adequately, thus achieving a better performance. In
addition, the reason why the performance of identifying inconsistent and
consistent method names changes differently is that: for
generation-based approaches, the ability of name generation impacts the
performance of identifying inconsistent Empirical Study on DL-based
Identification of Inconsistent Method Names. 25

and consistent method names consistently since the quality of generated
names is essential in the subsequent identification. However, the
IR-based approach, i.e., IRM CC has to strike a balance between the
accuracy of identifying inconsistent and consistent method names.

Summary: The performance of the evaluated approaches is slightly
improved when switching from a within-project to a cross-project
setting, which indicates that the evaluated approaches can also achieve
promising performance in a cross-project setting.

5 RQ2: Artificial Data VS. Natural Data

5.1 Process

To answer RQ2, we should evaluate the selected DL-based approaches
multiple times by changing the ratio of inconsistent method names in the
testing data. Notably, the evaluation of the DL-based approach is
time-consuming. Conse- quently, we only investigate two special settings
of the ratio. The first setting is to balance positive and negative
items in the testing dataset. Subsequently, the testing data is
BalancedData, and we have experimented on this dataset (see Section 4).
Given that the performance of evaluated approaches with within- project
setting and cross-project setting do not have significant difference
(see Section 4), we take the performance of cross-project setting in
Section 4 as the performance of BalancedData for comparison because the
cross-project setting is wildly used and time-saving for the potential
users. To make sure that there is only one independent variable, i.e.,
the ratio of inconsistent method names, the evaluation in this research
question is also based on a cross-project setting. The second special
setting is to simulate the ratio of inconsistent and consistent method
names in real scenarios. We construct a corresponding dataset, i.e., N
aturalData (see Section 3.2.4). This dataset is natural because the
number of negative items (consistent method names) is significantly more
than positive ones (inconsistent method names). Notably, the two
settings share the same training data (i.e., CORPUS CP ). The only
difference (variable) among the two settings is the ratio of positive
and negative items in the testing data. As a result, we may reveal the
effect of the ratio by analyzing how the evaluated approaches perform in
these two settings. The adopted training data and testing data are
presented in Table 8.

5.2 Results

The performance of each fold of data in different settings is presented
in Table 9 - Table 13. Table 19 - Table 23 present the average
evaluation results, and from these tables, we make the following
observations: 26 Taiming Wang 1 et al.

          Table 19: BalancedData vs. N aturalData (IRM CC).

                          Metrics     BalancedData   NaturalData

                          Precision      54.4%           0.3%
           Inconsistent    Recall        70.0%           70.0%
                           F-score       61.1%           0.6%

                          Precision      59.0%           99.8%
           Consistent      Recall        41.7%           41.7%
                           F-score       48.7%           58.8%

                   Accuracy              55.9%           41.8%

-- First, the precision of the evaluated approaches on inconsistent
names is significantly impacted when we change the ratio of inconsistent
and con- sistent method names in testing data. Switching from
BalancedData to N aturalData (the ratio of inconsistent method names
declines sequentially) results in a dramatic decline in precision. The
precision is reduced substan- tially from 54.4% to 0.3% (IRM CC), from
54.5% to 0.3% (CAN ), from 56.4% to 0.3% (M NIRE ), from 53.3% to
0.5%(Cognac), and from 55.1% to 0.4%(GT N M ). The reason is that the
more consistent methods we include, the more false positives we get. As
a result, the number of true positives is stable whereas false positives
are increased, which results in a reduced precision that equals true
positives divided by the sum of true positives and false positives. --
Second, the decline of the ratio of inconsistent method names leads to
better precision in identifying consistent method names. The precision
is increased from 59.0% to 99.8% (IRM CC), from 84.6% to 99.9% (CAN ),
from 78.7% to 99.9% (M NIRE ), from 72.8% to 99.9%(Cognac), and from
68.0% to 99.9%. This is because the number of inconsistent method names
is too tiny, and it can barely impact the overwhelming number of
consistent method names. -- Third, the recall is all slightly changed.
The reason is that the evaluated approaches are trained with the same
training data regardless of the differ- ence in testing data. As a
result, the resulting models (approaches) have the same ability to
identify inconsistent and consistent methods. For example, from Table
23, we observe that GT N M can accurately classify 83.7% of the
inconsistent names in BalancedData. Increasing the number of consistent
names (in N aturalData) would not influence the fact that around 83.7%
of the inconsistent names are classified correctly (which should result
in a recall of around 83.7%). Notably, Because of the random sampling
during dataset construction and high randomness of DL-based approach
(Scarda- pane and Wang 2017; Zhuang et al. 2021), the recall in
BalancedData, and N aturalData is not the same. Empirical Study on
DL-based Identification of Inconsistent Method Names. 27

              Table 20: BalancedData vs. N aturalData (CAN ).

                             Metrics     BalancedData      NaturalData

                             Precision       54.5%             0.3%
             Inconsistent     Recall         96.2%             96.2%
                              F-score        69.5%             0.6%

                             Precision       84.6%             99.9%
             Consistent       Recall         19.5%             19.5%
                              F-score        31.5%             32.5%

                     Accuracy                57.9%             19.7%



            Table 21: BalancedData vs. N aturalData (M NIRE ).

                             Metrics     BalancedData      NaturalData

                             Precision       56.4%             0.3%
             Inconsistent     Recall         91.9%             92.0%
                              F-score        69.9%             0.7%

                             Precision       78.7%             99.9%
             Consistent       Recall         29.1%             29.0%
                              F-score        42.3%             44.8%

                     Accuracy                60.5%             29.2%



             Table 22: BalancedData vs. N aturalData (Cognac).

                             Metrics     BalancedData      NaturalData

                             Precision       53.3%             0.5%
             Inconsistent     Recall         93.1%             93.3%
                              F-score        67.8%             1.0%

                             Precision       72.8%             99.9%
             Consistent       Recall         18.2%             18.7%
                              F-score        29.0%             31.5%

                     Accuracy                55.7%             19.0%

Summary: The performance of the evaluated approaches is impacted
substantially by the ratio of inconsistent and consistent method names.
This finding indicates that we should evaluate approaches on the dataset
that are constructed according to the real scenarios, and existing DL-
based approaches for method name consistency checking may not work
accurately in the field. 28 Taiming Wang 1 et al.

             Table 23: BalancedData vs. N aturalData (GT N M ).

                             Metrics     BalancedData     NaturalData

                             Precision       55.1%            0.4%
             Inconsistent     Recall         83.7%            83.7%
                              F-score        66.4%            0.8%

                             Precision       68.0%            99.9%
             Consistent       Recall         33.8%            34.1%
                              F-score        45.0%            50.7%

                     Accuracy                58.4%            34.2%

6 RQ3: Analysis of IR-based Approaches

In Section 5, we learn that IRM CC works in many cases (the accuracy can
be 41.8%). However, it remains unclear where and why it works or fails.
Answering these questions could shed light on the direction of
developing more advanced DL-based approaches. To this end, in this
research question, we investigate in what cases and for what reason the
IR-based approach, i.e., IRM CC, works or fails. To answer this research
question, we follow the widely-used mixed-method approach (Creswell and
Creswell 2017) and combine a qualitative analysis of the sampled methods
with a quantitative examination of the whole set of testing data. On the
qualitative analysis, we first randomly sample 383 methods (resulting in
185 successfully identified cases and 198 failed ones) from all the
methods in N aturalData, with a confidence level of 95% and a margin of
error of 5%. We analyze where and why IRM CC works or fails from the
perspectives of method name and body, with a qualitative analysis based
on the rationale of IRM CC. From the method name perspective, we analyze
the popularity of the first sub-token of method names since IRM CC
considers the first sub-token to conduct consistency checking. From the
method body perspective, we analyze the code complexity by measuring
lines of code (noted as LOC) and McCabe's Cyclomatic Complexity. At the
last, for the qualitative analysis, we analyze the names and bodies of
the methods retrieved by IRM CC.

6.1 Popularity of Method Name's F-token Matters

Given that IRM CC heavily relies on the first sub-token of a method name
to conduct the consistency checking, we analyze the first sub-tokens
(noted as F-token) of the sampled 383 method names to investigate how
the F-tokens affect the performance of IRM CC from the method name
perspective. We collect the F-tokens of the sampled methods and sort
them by their pop- ularity in successfully identified cases, failed
identification cases, and all sampled Empirical Study on DL-based
Identification of Inconsistent Method Names. 29

          Table 24: Proportions of the Top Three Popular F-tokens.

                      Success    Failure    Sampled
                                                        NaturalData
                       Cases      Cases      Cases

               get*    51.9%      17.2%       33.9%          31.9%
               set*    19.5%      12.1%       15.7%          11.6%
                is*    4.9%       4.0%        4.4%            4.9%

cases, respectively. For comparison, we also sort the F-tokens by their
popular- ity in N aturalData. Table 24 shows the top three most frequent
F-tokens in these four scenarios. From Table 24, we make the following
observations:

-- First, the top three most popular F-tokens in success cases, failure
cases, all sampled cases, and N aturalData keep the same, i.e., get,
set, and is. -- Second, in the sampled cases identified successfully by
IRM CC, the ratio of methods starting with the top three F-tokens is
significantly higher than their ratios in the sampled failure cases
(34.7% for get, 7.4% for set, and 0.9% for is), and even all sampled
cases (18.0% for get, 3.8% for set, and 0.5% for is), which indicates a
higher success rate. -- Third, with the decrease of the popularity of
F-tokens (i.e., 31.9%, 11.6%, and 4.9%) in N aturalData, the difference
of ratios between the sampled success cases and sampled failure cases
also decreases, i.e., 34.7%=51.9%- 17.2%, 7.4%=19.5%-12.1%, and
0.9%=4.9%-4.0%.

    Through the observations above, we assume that there might be a corre-

lation between the popularity of F-tokens and their rates of being
identified successfully (noted as success rate). Therefore, we calculate
the success rate of all the method names, and we found that the success
rate of the methods that start with the top three F-tokens are also the
highest ones, i.e., 73.8%=96/130 for get*, 60.0%=36/60 for set*, and
52.9%=9/17 for is\*. In contrast, the average success rate (i.e.,
Accuracy) of the whole dataset is only 48.3% (see Table 9). To further
validate the correlation between the popularity of F-tokens and success
rate, we present their relation in Fig. 1. The horizontal axis specifies
the frequency of the F-token in the training dataset (CORPUS CP ). The
vertical axis specifies the percentages of the method names beginning
with the given F-token are identified correctly. From this figure, we
observe that the success rate increases substantially with the increase
of F-tokens' popularity. To validate the statistical significance of the
correlation, we conduct the Spearman correlation (Artusi et al. 2002)
for the two factors. Our results (p-value = 3.4E-69, rho = 0.4) suggest
that they do have a positive correlation, which statistically validates
our observation. Based on the preceding analysis, we conclude that IRM
CC works well on the methods whose names start with popular F-tokens in
CORPUS CP. 30 Taiming Wang 1 et al.

            100%
            80% 60%
     Success Rate(%)
       40%  20%
            0%




                       0−1,000   1,001−5,000 5,001−10,000 10,001−100,000    >100,000
                                     Popularity of F−tokens in CORPUS
              Fig. 1: Popularity of F-tokens vs. Success Rate (IRM CC).

6.2 Method Body Complexity Matters

From the method body perspective, we measure the complexity of method
bodies by two widely used metrics, i.e., LOC and McCabe's Cyclomatic
Com- plexity (McCabe 1976). We first investigate the LOC of the sampled
383 methods to see how LOC impacts the performance of IRM CC. We find
that the average LOC of the success and failure methods is 1.8 and 3.8,
respectively. To figure out whether the LOC of success and failure
methods has a significant difference, we conduct the
Wilcoxon-Mann-Whitney u-test (i.e., Wilcoxon rank sum test) (Ott and
Longnecker 2015) on these two groups of LOC. The results
(statistic=-5.2, p-value=2.1E-07) suggest that there is a significant
difference between the LOC of success and failure methods, which further
indicates that the methods that are predicted incorrectly may have more
LOC in their method bodies. We then analyze the LOC of each method in N
aturalData, the average number of LOC of success and failure methods is
2.0 and 3.2, respectively. The results of conducting the
Wilcoxon-Mann-Whitney u-test on N aturalData (statistic=-80.4,
p-value=0.0) further validate that the more LOC a method has, the more
likely it will be predicted incorrectly by IRM CC. We then investigate
the complexity of method bodies by McCabe's Cyclo- matic Complexity
which measures the code complexity better. Intuitively, we analyze the
code structure of the sampled 383 methods because methods with more loop
structures and branched structures tend to be more complicated. We
categorize the sampled methods by three basic code structures, i.e.,
sequential structure, branched structure, and loop structure ordered by
complexity, and calculate the average success rate of methods with these
three structures. If a method consists of more than one structure, we
take the more complex one. The results suggest that the average success
rate of methods with sequential Empirical Study on DL-based
Identification of Inconsistent Method Names. 31

Table 25: Comparison of the F-tokens Between Retrieved Methods and Test
Methods.

                                    Name Different      Body Different

               Success Methods             2.2%                3.2%
                Failure Methods           38.9%               87.4%
             All Sampled Methods          21.1%               46.7%

structure, branched structure, and loop structure are 53.0%, 36.1%, and
11.1%, respectively. It indicates that the more complicated the code
structure of a method is, the more likely it will be predicted
incorrectly by IRM CC. To further validate this assumption, we first
calculate the McCabe's Cyclomatic Complexity of each method in N
aturalData, and then conduct the Spearman correlation analysis (Artusi
et al. 2002) between the McCabe's Cyclomatic Complexity and the success
rate. Our results (correlation=-0.1, p-value = 0.0) suggest a negative
correlation between the two factors, which statistically vali- dates our
assumption, i.e., the more complicated a method is, the more likely it
will be predicted incorrectly by IRM CC. The reason why generation-based
approaches work well on simple methods is that simple methods are common
in CORPUS CP and thus easy to retrieve. For methods with complex bodies,
it is hard for IRM CC to retrieve similar bodies from CORPUS CP because
these complex methods are rare in CORPUS CP. Based on the analysis of
methods' complexity, measured by LOC and McCabe's Cyclomatic Complexity,
and their success rate, we conclude that IRM CC works well on methods
with simple bodies, i.e., fewer LOC and lower McCabe's Cyclomatic
Complexity while it works less effectively on methods with complex
bodies.

6.3 Requesting for More Advanced Representation Techniques

Given that IRM CC is based on information retrieval, the retrieved
similar methods must embody important information, which may help us
figure out why IRM CC frequently fails. As illustrated in Section 2,
when k = 1, IRM CC retrieves two method names for a test method: one
(noted as mn2 ∈ M N s2 ) is the name which is the most similar to the
test method name, and the other (noted as mn1 ∈ M N s1 ) is the name of
the method whose body is the most similar to the test method's body. IRM
CC will regard the test method name as consistent when the F-token of
mn1 and mn2 are identical. We first collect the method names and bodies
which are the most similar ones retrieved by IRM CC from CORPUS CP. Then
we compare them with the names and bodies of the target test methods,
since the retrieved method names are supposed to have the same F-tokens
as the target test method names in the opinion of Liu et al. 32 Taiming
Wang 1 et al.

     1    // test method
     2    public G r i d C a c h e M v c c C a n d i d a t e removeLock () {
     3        G r i d C a c h e M v c c C a n d i d a t e ret = super . removeLock () ;
     4        locPart . onUnlock () ;
     5        return ret ;
     6    }
     7
     8
     9    // most similar body to the test method body
     10   protected Control c r ea te Bu t to nB ar ( Composite parent ) {
     11       Control control = super . cr ea t eB ut to n Ba r ( parent ) ;
     12       updateWidgets () ;
     13       return control ;
     14   }

                         Listing 2: Example For Case 1.



     Table 25 presents the results of comparing the F-tokens between retrieved

methods and test methods. We analyze the situation of the F-tokens in
success methods, failure methods, and all sampled methods, respectively.
The first line in Table 25 presents two possible cases during the
comparison. "Name Different" means that the F-token of mn2 is different
from that of the test method name, i.e., the retried method name is not
accurate. "Body Different" means that the F-token of mn1 is different
from that of the test method name, i.e., the retried method body is not
accurate. The last three lines present the ratios of "Name Different"
and "Body Different" in success methods, failure methods, and all
sampled methods, respectively. From Table 25, we make the following
observations:

-- First, the ratio of "Name Different" methods and "Body Different"
methods is much higher in failure methods than in success methods and
even all sampled methods. In addition, "Body Different" methods are more
than "Name Different" methods in success methods, failure methods, and
all sampled methods. Especially in failure methods, the ratio of "Body
Different" methods is 2.2 = 87.4%/38.9% times higher than that of "Name
Different" methods, which may indicate that retrieving similar method
bodies for the test methods is more difficult than retrieving similar
method names. -- Second, we notice that even in success methods, there
are still 2.2% and 3.2% of the success methods belonging to the "Name
Different" and "Body Different" categories. This is because the
prediction hypothesis of IRM CC only depends on the F-tokens of mn1 and
mn2 , and there will be some lucky cases in all success methods. For
example, there is a consistent test method m named "require", and the
F-tokens of mn1 and mn2 that IRM CC retrieved for m are both "get". In
this case, m will be considered consistent despite the difference
between the F-token of mn1 (or mn2 ) and m.

    From the observations we made from Table 25, we can infer that the

retrieved method bodies play a more important role than the retrieved
method Empirical Study on DL-based Identification of Inconsistent Method
Names. 33

    1
    2      // test method
    3      public void shutdown () {
    4          c lo se Co n ne ct io n () ;
    5      }
    6
    7      // most similar body to the test method body
    8      public void close () throws IOException {
    9          c lo se Co n ne ct io n () ;

10 }

                         Listing 3: Example For Case 2.

names in checking whether a method name is consistent with its body. To
this end, the first author and the third author independently analyze
the 173=198\*87.4% failure cases that are caused by "Body Different",
categorizing each case into one of the two failure types:

-- Case 1. (82.7%) The retrieved method bodies are not functionally
similar to those of the test methods. For an example shown in Listing 2,
the function of the test method is to remove the lock of the object
while the function of the retrieved method body is to create a new
button bar object. -- Case 2. (17.3%) The retrieved method bodies are
functionally similar to those of the test methods. Listing 3 shows an
example, where the test method and the retrieved method body both
implement the function of closing connection.

The Cohen's kappa coefficient of agreement (Cohen 1960) between the two
authors is 0.94. For the disagreement cases, the second author acts as
an arbitrator to make the final decision. Based on the above two
categories, we can infer that there are two corresponding reasons
leading to the failure of IRM CC. In the first case, 82.7% of failure
methods are caused by the poor method body representation because the
retrieved method bodies are not similar to those of the test methods.
Subsequently, more advanced method representation techniques, e.g.,
CodeT5 (Wang et al. 2021b), CodeBERT (Feng et al. 2020), should be
exploited to improve the performance of IR-based approaches. In the
second case, the hypothesis that methods implementing similar behavior
in their body code are likely to be consistently named with similar
names does not hold sometimes. As a result, 17.3% of methods fail due to
violation of the hypothesis. This case exists because different
developers have their naming habits and thesaurus. Even for the same
method, developers may name it differently. 34 Taiming Wang 1 et al.

     Summary: IRM CC works well on the methods whose names are popular
     in CORPUS CP and bodies can be found in CORPUS CP. It also works
     well on the methods with limited LOC and low McCabe’s Cyclomatic
     Complexity because these methods share some easy-to-find structural
     characteristics. It fails briefly because the method body representation
     is not efficient and the hypothesis, i.e., two methods with similar bodies
     should have similar names, does not hold all the time. More advanced
     method representation techniques should be exploited to improve the
     performance.

7 RQ4: Analysis of Generation-based Approaches

In this research question, we investigate where and why the
generation-based approaches, i.e., CAN , M NIRE , Cognac, and GT N M ,
work or fail. Following the patterns in Section 6, we also analyze where
and why these four DL-based approaches work or fail from both method
name perspective and method body perspective. The sampled data is the
same 383 methods adopted in Section 6. From the method name perspective,
we analyze the threshold of similarity between generated names and test
names. From the method body perspective, we also analyze the method body
complexity by measuring LOC and McCabe's Cyclomatic Complexity of
methods. We also conducted a qualitative analysis to further explore the
failure reason. At last, based on the above analysis, we propose two
possible ways to further improve the performance of identifying
inconsistent method names.

7.1 Method Name's Similarity and Length Matter

From the method name perspective, we analyze how the similarity between
generated method names and test method names impacts the performance of
generation-based approaches, i.e., M NIRE , CAN , Cognac, and GT N M .
The distribution of the similarity between success method names and
their corresponding generated names, and the similarity between failure
method names and their corresponding generated names are presented in
Fig. 2(a), Fig. 2(b), Fig. 2(c), and Fig. 2(d). We can see that in the
success methods, the distribution of similarities between success method
names and their cor- responding generated names is funnel-like (right
part of each figure). The majority of the similarity of success methods
is 1.0, which means that only if the generated names share all the
sub-tokens with the ground truth names can the consistent test methods
be identified correctly. This also indicates that high threshold
represents the generated names should be perfect since the token number
of method names is usually less than five (Alsuhaibani et al. 2021). In
addition, as we can see from the distributions of similarities between
Empirical Study on DL-based Identification of Inconsistent Method Names.
35

failure method names and their corresponding generated names (left part
of each figure), there are even some failure methods with high
similarities over 0.8, which means that in these cases only one
sub-token is different from the ground truth names. The above analysis
suggests that the similarity calculation method that only considers the
lexical information of method names is not sound enough. Furthermore, we
also find some generated names that are syn- onyms to the ground truth
names, e.g., "accept" (ground truth: "receive") and "get" (ground truth:
"retrieve"). This indicates that future generation-based approaches
should consider measuring the method name similarity not only lexically
but also syntactically and semantically. 1.0

                                                                                                            1.0
                                   0.8




                                                                                                            0.8
        Similarity Between Names




                                                                                 Similarity Between Names
                                   0.6




                                                                                                            0.6
                                   0.4




                                                                                                            0.4
                                   0.2




                                                                                                            0.2
                                   0.0




                                                                                                            0.0




                                           Failure Methods     Success Methods                                    Failure Methods   Success Methods


                         (a) Methods’ Similarities (CAN ).                       (b) Methods’ Similarities (M NIRE ).
                                   1.0




                                                                                                            1.0
                                   0.8




                                                                                                            0.8
       Similarity Between Names




                                                                                 Similarity Between Names
                                   0.6




                                                                                                            0.6
                                   0.4




                                                                                                            0.4
                                   0.2




                                                                                                            0.2
                                   0.0




                                                                                                            0.0




                                         Failure Methods     Success Methods                                      Failure Methods   Success Methods


       (c) Methods’ Similarities (Cognac).                                       (d) Methods’ Similarities (GT N M ).


                                               Fig. 2: Distribution of Methods Similarities.


    We also analyze how the length of method names (i.e., the number of

sub-tokens in a method name) impacts the performance of generation-based
approaches. For CAN , M NIRE , Cognac, and GT N M , we calculate the
length of all the involved methods in N aturalData and conduct the
Spearman cor- relation analysis (Artusi et al. 2002) between the length
of method names and their success rate. The results (statistic=-0.01,
p-value=1.3E-07 for CAN , statistic=-0.30, p-value=0.0 for M NIRE ,
statistic=-0.18, p-value=9.4E-293 for Cognac, and statistic=-0.10,
p-value=1.4E-225 for GT N M ) suggest that there is a weak negative
relationship between these two factors. This may be because all
generation-based approaches generate the sub-tokens of method names one
by one, making it more challenging to generate longer method names (with
more sub-tokens) correctly compared to shorter ones. The relationship is
weak because most of the method names are of medium length (2-5
sub-tokens), and the extremely long method names are rare. 36 Taiming
Wang 1 et al.

                                                  CAN                  MNIRE                    Cognac                       GTNM
                       40%
                             36.5%

                                     31.3%
                                             29.9% 30.2%
                       30%

                                                                                     24.4%
     Success Rate(%)




                                                                     23.6%
                                                             22.0%
                                                                                                    20.0%
                       20%                                                                                           19.1%
                                                                                                                                     17.5%
                                                                             14.1%                                                                  14.8%


                       10%                                                                   9.1%
                                                                                                              7.8%            7.7%
                                                                                                                                             5.9%



                       0%
                                         1-3                             4-6                            7-9                             >=10
                                                                                       LOC




                                                           Fig. 3: LOC VS. Success Rate.

7.2 Method Body Complexity Matters

To investigate how the method body complexity impacts the
generation-based approaches, we first analyze the lines of code of all
the methods in N aturalData (LOC of methods in success ones and failure
ones are analyzed separately). Then we manually segment LOC into four
groups and explore the average success rate of each group. The analysis
results are presented in Fig. 3. The horizontal axis denotes the LOC,
and the vertical axis denotes the success rate of methods. From Fig. 3,
we observe that with the increase of LOC, the success rate of methods in
N aturalData decrease significantly. Similar to IR-based approaches, the
more LOC a method has (i.e., more complex), the less likely the
generation-based approaches will predict it correctly. The results (
correlation=-0.32, p-value=7.9E-312 for CAN , correlation=-0.21, p-
value=2.3E-22 for M NIRE , correlation=-0.22, p-value=3.7E-71 for
Cognac, and correlation=-0.39, p-value=5.2E-210 for GT N M ) of Spearman
correlation analysis between LOC and success rate further validate this
observation. We then calculated McCabe's Cyclomatic Complexity of all
the methods in N aturalData to see how the complexity of methods impacts
the performance of CAN , M NIRE , Cognac, and GT N M . After that, we
conducted the Spearman correlation analysis between McCabe's Cyclomatic
Complexity of methods and their success rate. Our results
(correlation=-0.21, p-value=1.0E-33 for CAN , correlation=-0.34,
p-value=1.6E-381 for M NIRE , correlation=-0.45, p-value=5.6E-210 for
Cognac, and correlation=-0.27, p-value=5.7E-129 for GT N M ) suggest
that they are indeed negatively correlated, which statistically
validates our assumption. This result also indicates that the more
complicated Empirical Study on DL-based Identification of Inconsistent
Method Names. 37

a method is (i.e., more complex), the more likely it will be predicted
incorrectly by generation-based approaches. From the analysis of LOC and
McCabe's Cyclomatic Complexity, we con- clude that generation-based
approaches, i.e.,CAN , M NIRE , Cognac, and GT N M , work well on
methods with simple bodies, i.e., fewer code lines and easier structure.
The reason might be that simple methods tend to have less number of
tokens in method bodies and thus easy for deep learning models to
extract information and generate the correct sub-tokens.

7.3 Qualitative Analysis

To further explore the failure reason of generation-based approaches and
move beyond the purely historical view of naming based on past data, we
conducted a qualitative analysis to investigate the names generated by
generation-based approaches. Since the SOTA generation-based approach is
GT N M , and it achieves the best overall performance in identifying
inconsistent method names in N aturalData, we only analyzed the
generation results of GT N M to investigate the reason why
generation-based approaches fail. In addition, Liu et al. (Liu et
al. 2022) have already explored the cases where GT N M cannot make a
correct recommendation in their paper, so we focus on its ability to
identify inconsistent method names instead of name recommendation in
this qualitative analysis. Consequently, we sampled 332 inconsistent
method names from all the inconsistent method names (2,443) in BenM ark
with a confidence level of 95% and a margin of error of 5%. This ensures
that our sample is representative and reliable to reflect the
characteristics of all the inconsistent methods. In the 332 samples, GT
N M failed to identify 18 of them and succeeded in identifying 314 of
them. Recall that the rationale of generation-based approaches is to
generate a name first and then compare it with the name under test.
Consequently, triplets like \< BuggyN ame, F ixedN ame, M ethodBody \>,
and the names generated by GT N M (we call them GeneratedN ame), are
taken for reference. The first and second authors manually inspected
these 332 cases indepen- dently. The major focus was on which name
(GeneratedN ame or F ixedN ame) was better, and why would GT N M
generate these names. The two authors discussed the disagreements until
they reached a consensus. The Cohen's kappa coefficient is 0.79,
indicating a substantial agreement between the two authors. Finally, we
made the following observations: -- First, in 18 failure cases,
88.8%(=16/18) false negatives are due to the inability of GT N M to
handle "Narrow" type, i.e., GeneratedN ame (or BuggyN ame) lacks some
additional information compared to F ixedN ame. An example is presented
in the below code snippets. The GeneratedN ame (or BuggyN ame) is
"getConnectionFactory". However, developers think that
"getOrCreateConnectionFactory" is a more descriptive and ap- propriate
name for the method body. 38 Taiming Wang 1 et al.

     1 // GTNM generated " g e t C o n n e c t i o n F a c t o r y " for the below
           method body .
     2 public C o n n e c t i o n F a c t o r y g e t O r C r e a t e C o n n e c t i o n F a c t o r y () {
     3     if ( c o n n e c t i o n F a c t o r y == null ) {
     4          c o n n e c t i o n F a c t o r y = c r e a t e C o n n e c t i o n F a c t o r y () ;
     5     }
     6     return c o n n e c t i o n F a c t o r y ;
     7 }


                           Listing 4: Examples of False Negatives.

-- Second, in 314 success cases, there are only 19.7% (=62/314)
GeneratedN ames that are identical to F ixedN ames. That is to say, in
these cases, the generated names coincided with the intentions of
developers. Although the remaining 80.3% (=252/314) cases are still
identified correctly, these GeneratedN ames are not identical to F ixedN
ames. Consequently, we further analyze these cases. -- Third, in the 252
correctly identified cases, we found that in 80.2% cases, F ixedN ames
are better than GeneratedN ame; In 16.6% cases, F ixedN ame and
GeneratedN ame are both appropriate for the method body; In 3.2% cases,
GeneratedN ame is even better than F ixedN ame, Additionally, in the
80.2% poorly generated cases, 22.3% cases are due to the lack of
additional information, i.e., lack of several sub-tokens compared to F
ixedN ames. This further indicates that existing generation-based ap-
proaches struggled to identify inconsistent method names that only lack
some additional information (i.e., struggle to handle "Narrow" type).
12.9% cases are because of the inability to handle acronyms. The above
findings to some extent coincide with the conclusions reached by Liu et
al. (Liu et al. 2022).

    From the above findings, we conclude that the ability of generation-based

approaches still needs to be improved to more accurately identify
inconsistent method names, especially in identifying the ones belonging
to "Narrow". The likely reason is that in the "Narrow" case, the
inconsistent method name encompasses the majority of the functionality
of the method bodies. This re- quires generation-based approaches to
thoroughly understand the functionality of the method bodies and
generate more descriptive (i.e., longer) names, which is quite
challenging.

     Summary: Generation-based approaches, i.e.,CAN , M NIRE , Cognac,
     and GT N M work well on methods with short names, few LOCs, and
     low complexity. Generation-based approaches fail because of the less
     effective name similarity calculation method. They particularly struggle
     to identify inconsistent method names of “Narrow” type.

Empirical Study on DL-based Identification of Inconsistent Method Names.
39

8 Discussion

8.1 Threats to Validity

We now discuss the threats to the validity of our study, following
common guidelines for empirical studies (Kitchenham et al. 2002).

8.1.1 Threats to External Validity

A threat to external validity is the limited size and diversity of the
dataset employed in the evaluation. Given the limited size and diversity
of the dataset, it is possible that our findings cannot be generalized
anywhere. Notably, we reuse the subject applications selected and
extensively used by existing research (Liu et al. 2019; Nguyen et
al. 2020; Li et al. 2021b; Wang et al. 2021a). Reusing such well-known
open-source applications facilitates third-party replication of our
empirical study.

8.1.2 Threats to Constructive Validity

A threat to constructive validity is that the labels of the items (i.e.,
whether a given method name is consistent with its method body) could be
inaccurate. Following Liu et al. (Liu et al. 2019), we label the method
names by mining version control systems. However, this method can not
guarantee that the method name changes are associated with the
inconsistency between names and bodies. To reduce the false positives,
we added a manual inspection after the automatic identification. Three
developers are invited to rate the method names, and a judgment
criterion has been summarized. Then two authors manually inspected the
dataset with this criterion, aiming to minimize the number of false
positives. In addition, it is infeasible to manually inspect the
consistent method names due to their overwhelming number. To figure out
the quality of labels on consistent method names, We sampled parts of
the consistent methods and examined the false positive rate. The results
suggest that the false positive rate is only 4.4%.

8.1.3 Threats to Internal Validity

A threat to internal validity is that we (instead of the original
authors) calibrate the evaluated approaches which may not result in the
optimal settings. All the evaluated approaches are learning-based and
contain a few parameters that should be optimized according to the given
data. Although we have tuned such parameters following the original
paper, likely, we may not find the optimal settings because of a lack of
deep understanding of their models and implementations. To facilitate
the replication, we specify how we tune the parameters in Section 3.3,
and make the whole replication package publicly available at GitHub
(Wang 2024). 40 Taiming Wang 1 et al.

                                                                           CAN

                                                               0%


                                                                                   0.15%
                                                        0.9%

                                             7.8%
                                                                1.5%                   0.3%                               IRMCC
                                     0%
                                                                              5.9%              0%
         MNIRE                                   3.5%                                                               0%

                      0%                                                                        1.4%
                                0.15%


                           0%
                                                                23%
                                                                                                            0.15%
                                                                                              1.8%
                                                                                                     1.2%
                                0%
                                          0.6%

                            0.15%
                                                                                                0.9%
                                                  0.9%                                5%
                                                                    42%

                                                          0%        3.2%
                                                                           0.15%
                                                                                                     0%
                                          0%

                    GTNM
                                                                                                               Cognac

Fig. 4: Complementarity of Five Selected Approaches in Identifying
Inconsistent Method Names.

8.2 Limitations

The first limitation of the paper is that it is confined to Java methods
only. Both of the evaluated approaches should apply to source code in
various programming languages because they do not depend on the special
characters of a given programming language. However, their public
implementations are currently confined to Java. To this end, our
evaluation involves Java code only. In the future, it could be
interesting to investigate how well such DL-based approaches work on
other programming languages, e.g., C++, JavaScript, and Python. The
second limitation is that we do not evaluate the state-of-the-art DL-
based approaches in the field. Instead, we identify testing items by
mining the commit histories of open-source applications. However,
inconsistent names accounted for in the field could be significantly
different from those recorded in the version control systems. Many
inconsistent method names have likely been renamed before they are
committed and merged into the main branches in the version control
systems. Consequently, they could be missed by the mining-based
approach. In the future, we should evaluate the state-of-the-art
DL-based approaches in the field by collecting feedback from developers.

8.3 Complementary Analysis

In this section, we further explored the complementarity of five
selected ap- proaches. We analyzed their performance in identifying
inconsistent method names and drew a Venn diagram using VennDiagram
(Language 2024) package Empirical Study on DL-based Identification of
Inconsistent Method Names. 41

in R language. Analysis results are shown in Fig. 4. From the above
figure, we make the following observations: -- There are 23.0% of
inconsistent method names that can be commonly identified by IRM CC and
CAN , M NIRE , GT N M , and Cognac. Notably, not a single inconsistent
method name can be identified exclusively by any of the five approaches.
This pattern is also observed in the four generation- based approaches:
only 0.15% inconsistent method names can be identified exclusively by
CAN and Cognac, respectively. This suggests that there is little
complementarity among the five approaches in identifying inconsistent
method names. -- The above findings are reasonable when analyzed from
the aspect of per- formance. since the precision of identifying
inconsistent method names is significantly affected by the number of
consistent method names in testing data. Consequently, we only consider
the recall of identifying inconsistent method names. As shown in Table
19 - Table 22, the recall with IRM CC is only 65.0%. In contrast, the
recall of the generation-based approaches is 94.9%, 87.8%, 83.7%, and
93.3%. The generation-based approaches can almost entirely cover the
instances identified by the IR-based approach. Furthermore, due to the
near-perfect recall of generation-based approaches, very few instances
are identified exclusively by them. -- The above findings also coincide
with the conclusions reached in Section 6 and Section 7. Both IR-based
approaches and generation-based approaches are good at identifying
methods with short bodies and simple names while having difficulty in
identifying complex ones. For example, if a method is as simple as a
getter method (see Listing 1), it is easy to retrieve from the code
corpus and easy to generate from scratch. Otherwise, if it is an
extremely complex method, it is hard to retrieve a similar method from
the code corpus and hard to generate from scratch because the semantics
could also be complicated.

8.4 Possible Ways to Improve The Performance

8.4.1 Leveraging Contrastive Learning

Although the mainstream (SOTA) approach is based on name generation, it
is an indirect solution for the identification of inconsistent method
names, as it was originally designed to generate names for method
bodies. Furthermore. In addition, as analyzed in Section 7.1,
generation-based approaches struggled to identify inconsistent method
names of Narrow type, these approaches are heavily impacted by
subsequent similarity calculation metrics. For the above reasons, its
performance in identifying inconsistent method names is substantially
constrained by the effectiveness of method name recommendation.
Consequently, based on the analysis presented in the previous sections,
we propose a more efficient method specially designed to identify
inconsistent method names. Conceptually, contrastive learning leverages
encoder networks 42 Taiming Wang 1 et al.

(could be any type of structures, e.g., RNN, LSTM, Transformer) to
convert the instances (in this paper, method names and bodies) into
vector representations, aiming to pull close the distance between
similar instances while pushing away the distance between dissimilar
instances (Oord et al. 2018). Contrastive learning has been extensively
leveraged to represent the semantic meaning of identifiers (Chen et
al. 2022) and source code (Ding et al. 2022). The overview of the
contrastive pre-training is presented in Fig. 5. The training process is
self-supervised. Since the majority of method names and bodies are
consistent with each other, the training corpus can be easily obtained.
The input instances are natural pairs of method names and bodies. At
each training step, a mini-batch contains pairs of names and bodies. The
training aims to minimize the distance within a pair, e.g., \< N1 , B1
\>, while maximizing the distance of other pairs, e.g., \< N1 , B2 \>
and \< N1 , B3 \>. To achieve this, EncoderN ame and EncoderBody are
adopted to convert names and bodies into vector representations. Note
that the EncoderN ame and EncoderBody can be initialized by the weights
of trained models, e.g., CodeBert (Feng et al. 2020). Contrastive loss
L1 and L2 , which are InfoNCE (Oord et al. 2018), are calculated based
on the cosine similarity between the encoded vector representations.
Finally, EncoderN ame and EncoderBody are optimized with the gradient
descent, respectively. After the pre-training, we will obtain two
encoders for method names and bodies, i.e., EncoderN ame and EncoderBody
. Then in the downstream tasks, i.e., identification of inconsistent
method names, names and bodies are encoded into vectors, respectively.
Finally, these two vectors can be concatenated and fed into a softmax
layer to achieve a binary classification. We can fine-tune the model
with the manually inspected data in BenM ark, achieving better
performance. The advantage of contrastive learning is two-fold: On the
one hand, tra- ditional IR-based approaches heavily rely on similarity
calculation metrics. However, the retrieval based on similarity
calculation from a large code corpus could be ineffective sometimes.
This inference can be supported by our analysis in Section 6.3. 82.7% of
the failed samples are due to the dissimilarity between method bodies.
In addition, it is significantly constrained by the quality of the
constructed code corpus. By contrast, contrastive learning incorporates
simi- larity calculation in the training process, solving the
disadvantages of IR-based approaches. On the other hand, the traditional
generation-based approaches heavily rely on per-training tasks for the
alignment between natural language and programming language. It also
suffers from the problem of similarity cal- culation. In addition, it
requests large amounts of data for training. However, self-supervised
contrastive learning requires less data for training, solving the
disadvantages of generation-based approaches.

8.4.2 Leveraging The Ability of LLM

To the best of our knowledge, there are no LLM-based approaches for now
to identify inconsistent method names. The LLMs like GPT4 have been
proven to achieve great performance in a series of software engineering
tasks (Noever Empirical Study on DL-based Identification of Inconsistent
Method Names. 43

                                  N1
                   Similar                                                VN1
                                                           EncoderName

N1, N2, N3, ... Dissimilar B1 VB1 VB2 Contrastive Method Names B2 COS
VB3 Loss 1 B3

                                   B1
                                                                          VB1
                       Similar                             EncoderBody

B1, B2, B3, ... N1 Dissimilar VN1 VN2 COS Contrastive Method Bodies N2
VN3 Loss 2

                                        N3

a)  Name & Body Pairs b) Mini-batch Pairs c) Representations d) Scores

                   Fig. 5: Overview of the Contrastive Pre-training.

2023; Dong et al. 2023; Xia and Zhang 2023). We believe that the LLMs
will also have great potential in solving the problem of identification
of inconsistent method names. With the emergent ability and proper
prompts, LLMs are likely to thoroughly understand the functionality of
the method bodies and identify inconsistent method names more
accurately. Recently, LLMs are revolutionizing the software engineering
field by acting as intelligent agents that enhance productivity and
streamline various pro- cesses (Xia et al. 2024; Hong et al. 2024). It
is also interesting to explore how to develop one or multiple agents for
the identification of inconsistent method names.

8.5 Take-away Messages

1.  Inconsistent Method Names May Be Renamed by Only Changing Few
    Sub-tokens As is presented in Section 3.2.2, in real scenarios,
    developers may only change one or several sub-tokens of the
    inconsistent method names with the most sub-tokens remaining. Among
    the inconsistent method names in BenM ark, 42.1% inconsistent method
    names are of "Narrow" (34.3%) or "Generalize" (7.8%) type. That is
    to say, 42.1% inconsistent method names are renamed by adding or
    removing one (in most cases) or multiple sub-tokens. The remaining
    57.9% inconsistent method names are of "Change" type. Consequently,
    the implication is that since almost half of the inconsistent method
    names may just be inconsistent with their method bodies in one
    sub-token, it should be noticed during the design of the approaches.
    2.  Two Possible Ways for Better Identifying Inconsistent Method
        Names As is illustrated in Section 8.4.1, the advantages of
        contrastive learning 44 Taiming Wang 1 et al.

are two-fold: On the one hand, traditional IR-based approaches heavily
rely on retrieval based on similarity calculation from a large code
corpus, which could be ineffective sometimes. In addition, it is
significantly constrained by the quality of the constructed code corpus.
By contrast, contrastive learning incorporates similarity calculation in
the training process, solving the disadvantages of IR-based approaches.
On the other hand, the traditional generation-based approaches request
large amounts of data for training. However, self-supervised contrastive
learning requires less data for training, solving the disadvantages of
generation-based approaches. As is illustrated in Section 8.4.2, the
ability of LLM has great potential in improving the performance of
identification of inconsistent method names. 3. Proportions of Positive
and Negative Items in Testing Data Have Great Impact on the Performance
of DL-based Approaches. As is presented in Section 5, changing the ratio
of inconsistent and consistent method names substantially impacts the
performance of the evaluated approaches. This indicates that we should
evaluate approaches to testing datasets that are constructed according
to real scenarios instead of intentionally controlled balanced ones. 4.
Performance of Existing DL-based Approaches Needs to Be Improved Before
Being Applied to the Industry. The performance of all the five evaluated
approaches on testing data with a natural ratio of inconsistent and
consistent methods is not satisfying (the precision is less than 1%). It
means that there are overwhelming false positives, and they will confuse
users when using the approaches. Given the importance of having a
consistent method name, future studies should be dedicated to improving
the current performance of identifying inconsistent method names. 5.
Multiple Benchmarks Should Be Used to Fully Evaluate The Performance of
DL-based Approaches. Although the dataset that is close to the real
scenarios is of great value in reflecting the real performance of
DL-based approaches, the balanced dataset may also to some extent
exhibit the ability to identify inconsistent method names of DL-based
approaches. Consequently, we should try to use multiple benchmarks to
fully evaluate the performance of DL-based approaches.

9 Conclusion and Future Work

Inconsistent method names could be misleading and result in serious
software defects. Consequently, a few automated approaches have been
proposed to identify such misleading method names. However, we still
lack a comprehensive evaluation of these state-of-the-art approaches in
a more natural dataset, and where and why these approaches work or fail
are still unclear. This paper selects five state-of-the-art DL-based
approaches in this field (one IR-based approach and four
generation-based approaches) and evaluates them on our constructed large
test dataset that is clean, manually inspected, and close to real-world
scenarios. The evaluation results suggest that the ratio of inconsistent
and Empirical Study on DL-based Identification of Inconsistent Method
Names. 45

consistent methods in testing data impacts the performance
substantially. How- ever, switching the within-project setting to a
widely-used cross-project setting slightly changes the performance of
the evaluated approaches. Our analysis results suggest that there are
two major reasons why IR-based approaches fail: 1) the adopted method
body representation technique is not efficient enough, and 2) the
hypothesis (two methods with similar bodies should have similar names)
does not hold all the time. Generation-based approaches frequently fail
also because of two major reasons: the ineffective similarity
calculation formula and the immature method name generation techniques.
We also propose two possible ways for better identifying inconsistent
method names. In the future, how to leverage contrastive learning and
the ability of LLMs to further improve the performance of identifying
inconsistent method names deserves to be investigated.

Acknowledgments

The authors would like to say thanks to anonymous reviewers for their
insightful comments and suggestions. This work was partially supported
by the National Natural Science Foundation of China \[ grant numbers
62172037, 62232003 \].

Data Availability Statements

The data that support the findings of this study are openly available in
EmpiricalStudy-MCC at https://github.com/Michaelll123/EmpiricalStudy-
MCC (Wang 2024).

Declarations

Conflict of Interest The authors declare that they have no conflict of
interest.

References

Abebe SL, Haiduc S, Tonella P, Marcus A (2011) The effect of lexicon bad
smells on concept location in source code. In: 2011 IEEE 11th
International Working Conference on Source Code Analysis and
Manipulation, IEEE, pp 125--134 Abebe SL, Arnaoudova V, Tonella P,
Antoniol G, Gueheneuc YG (2012) Can lexicon bad smells improve fault
prediction? In: 2012 19th Working Conference on Reverse Engineering,
IEEE, pp 235--244 Aghajani E, Nagy C, Bavota G, Lanza M (2018) A
large-scale empirical study on lin- guistic antipatterns affecting apis.
In: 2018 IEEE International Conference on Soft- ware Maintenance and
Evolution, ICSME 2018, Madrid, Spain, September 23-29, 2018, IEEE
Computer Society, pp 25--35, DOI 10.1109/ICSME.2018.00012, URL
https://doi.org/10.1109/ICSME.2018.00012 46 Taiming Wang 1 et al.

Allamanis M, Barr ET, Bird C, Sutton C (2014) Learning NATURAL coding
conven- tions. Proceedings of the ACM SIGSOFT Symposium on the
Foundations of Software Engineering 16-21-Nove:281--293, DOI
10.1145/2635868.2635883, arXiv:1402.4182v3 Allamanis M, Barr ET, Bird C,
Sutton C (2015) Suggesting accurate method and class names. 2015 10th
Joint Meeting of the European Software Engineering Conference and the
ACM SIGSOFT Symposium on the Foundations of Software Engineering,
ESEC/FSE 2015 - Proceedings pp 38--49, DOI 10.1145/2786805.2786849
Allamanis M, Peng H, Sutton C (2016) A convolutional attention network
for extreme summarization of source code. International Conference on
Machine Learning 48:2091-- 2100 Allamanis M, Barr ET, Devanbu PT, Sutton
C (2018) A survey of machine learning for big code and naturalness. ACM
Comput Surv 51(4):81:1--81:37, DOI 10.1145/3212695, URL
https://doi.org/10.1145/3212695 Alon U, Zilberstein M, Levy O, Yahav E
(2018) code2vec: Learning distributed representations of code. CoRR
abs/1803.09473, URL http://arxiv.org/abs/1803.09473, 1803.09473 Alon U,
Brody S, Levy O, Yahav E (2019) code2seq: Generating sequences from
structured representations of code. In: 7th International Conference on
Learning Representations, ICLR 2019, New Orleans, LA, USA, May 6-9,
2019, OpenReview.net, URL https: //openreview.net/forum?id=H1gKYo09tX
Alsuhaibani RS, Newman CD, Decker MJ, Collard ML, Maletic JI (2021) On
the naming of methods: A survey of professional developers. In: 43rd
IEEE/ACM International Confer- ence on Software Engineering, ICSE 2021,
Madrid, Spain, 22-30 May 2021, IEEE, pp 587-- 599, DOI
10.1109/ICSE43902.2021.00061, URL https://doi.org/10.1109/ICSE43902.
2021.00061 Amann S, Nguyen HA, Nadi S, Nguyen TN, Mezini M (2018) A
systematic evaluation of static api-misuse detectors. IEEE Transactions
on Software Engineering 45(12):1170--1188 Arima R, Higo Y, Kusumoto S
(2018) Toward refactoring evaluation with code naturalness. In:
Proceedings of the 26th Conference on Program Comprehension, ICPC 2018,
Gothenburg, Sweden, May 27-28, 2018, ACM, pp 316--319, DOI
10.1145/3196321.3196362, URL https://doi.org/10.1145/3196321.3196362
Arnaoudova V (2010) Improving source code quality through the definition
of linguistic antipatterns. In: Antoniol G, Pinzger M, Chikofsky EJ
(eds) 17th Working Conference on Reverse Engineering, WCRE 2010, 13-16
October 2010, Beverly, MA, USA, IEEE Computer Society, pp 285--288, DOI
10.1109/WCRE.2010.41, URL https://doi.org/ 10.1109/WCRE.2010.41
Arnaoudova V, Penta MD, Antoniol G (2016) Linguistic antipatterns: What
they are and how developers perceive them. Empir Softw Eng
21(1):104--158, DOI 10.1007/ s10664-014-9350-8, URL
https://doi.org/10.1007/s10664-014-9350-8 Artusi R, Verderio P, Marubini
E (2002) Bravais-pearson and spearman correlation coefficients: Meaning,
test of hypothesis and confidence interval. The International journal of
biological markers 17(2):148--151 Bavota G, Oliveto R, Gethers M,
Poshyvanyk D, De Lucia A (2013) Methodbook: Recom- mending move method
refactorings via relational topic models. IEEE Transactions on Software
Engineering 40(7):671--694 Binkley DW, Davis M, Lawrie DJ, Maletic JI,
Morrell C, Sharif B (2013) The impact of identifier style on effort and
comprehension. Empir Softw Eng 18(2):219--276, DOI
10.1007/s10664-012-9201-4, URL https://doi.org/10.1007/s10664-012-9201-4
Butler S, Wermelinger M, Yu Y, Sharp H (2009) Relating identifier naming
flaws and code quality: An empirical study. In: 2009 16th Working
Conference on Reverse Engineering, IEEE, pp 31--35 Butler S, Wermelinger
M, Yu Y, Sharp H (2010) Exploring the influence of identifier names on
code quality: An empirical study. In: 2010 14th European Conference on
Software Maintenance and Reengineering, IEEE, pp 156--165 Chen Q,
Lacomis J, Schwartz EJ, Neubig G, Vasilescu B, Goues CL (2022) VarCLR:
Variable Semantic Representation Pre-training via Contrastive Learning.
Proceedings - International Conference on Software Engineering
2022-May:2327--2339, DOI 10.1145/ 3510003.3510162, 2112.02650 Empirical
Study on DL-based Identification of Inconsistent Method Names. 47

Cohen J (1960) A coefficient of agreement for nominal scales.
Educational and psychological measurement 20(1):37--46 Creswell JW,
Creswell JD (2017) Research design: Qualitative, quantitative, and mixed
methods approaches. Sage publications Cruzes DS, Dyba T (2011)
Recommended steps for thematic synthesis in software engineering. In:
2011 international symposium on empirical software engineering and
measurement, IEEE, pp 275--284 Deissenboeck F, Pizka M (2006) Concise
and consistent naming. Software Quality Journal 14(3):261--282, DOI
10.1007/s11219-006-9219-1 Deissenboeck F, Pizka M (2015) Concise and
consistent naming: Ten years later. In: 2015 IEEE 23rd International
Conference on Program Comprehension, IEEE, pp 3--3 Ding Y, Buratti L,
Pujar S, Morari A, Ray B, Chakraborty S (2022) Towards Learning
(Dis)-Similarity of Source Code from Program Contrasts. Proceedings of
the Annual Meeting of the Association for Computational Linguistics
1:6300--6312, DOI 10.18653/ v1/2022.acl-long.436, 2110.03868 Dong Y,
Jiang X, Jin Z, Li G (2023) Self-collaboration code generation via
ChatGPT. arXiv preprint arXiv:230407590 Feng Z, Guo D, Tang D, Duan N,
Feng X, Gong M, Shou L, Qin B, Liu T, Jiang D, et al. (2020) Codebert: A
pre-trained model for programming and natural languages. arXiv preprint
arXiv:200208155 Gethers M, Savage T, Di Penta M, Oliveto R, Poshyvanyk
D, De Lucia A (2011) Codetopics: Which topic am I coding now? In:
Proceedings of the 33rd International Conference on Software
Engineering, pp 1034--1036 Hill E (2010) Integrating natural language
and program structure information to improve software search and
exploration. PhD thesis Hindle A, Barr ET, Gabel M, Su Z, Devanbu PT
(2016) On the naturalness of software. Commun ACM 59(5):122--131, DOI
10.1145/2902362, URL https://doi.org/10.1145/ 2902362 Hofmeister J,
Siegmund J, Holt DV (2017) Shorter identifier names take longer to
compre- hend. In: 2017 IEEE 24th International conference on software
analysis, evolution and reengineering (SANER), IEEE, pp 217--227 Hong S,
Zhuge M, Chen J, Zheng X, Cheng Y, Zhang C, Wang J, Wang Z, Yau SKS, Lin
Z, Zhou L, Ran C, Xiao L, Wu C, Schmidhuber J (2024) METAGPT: META
PROGRAMMING FOR A MULTI-AGENT COLLABORATIVE FRAMEWORK. In: 12th
International Conference on Learning Representations, ICLR 2024,
2308.00352 Honnibal M, Montani I (2024) spacy. https://spacy.io/
Accessed August 18, 2024 Høst EW, Østvold BM (2009) Debugging method
names. In: European Conference on Object-Oriented Programming, Springer,
pp 294--317 Jiang L, Liu H, Jiang H (2019) Machine learning based
recommendation of method names: How far are we. Proceedings - 2019 34th
IEEE/ACM International Conference on Automated Software Engineering, ASE
2019 pp 602--614, DOI 10.1109/ASE.2019.00062 Johnson P (2018a) Arg! the
9 hardest things programmers have to do," Johnson P (2018b) Don't go
into programming if you don't have a good thesaurus Kim K, Zhou XIN, Kim
D, Lawall J, Liu KUI, Klein J, Lee J, Lo D (2023) How are We Detecting
Inconsistent Method Names ? An Empirical Study from Code Review Perspec-
tive arXiv : 2308 . 12701v1 \[ cs . SE \] 24 Aug 2023. arXiv preprint
arXiv:230812701v1 1(1):1--22, arXiv:2308.12701v1 Kim S, Kim D (2016)
Automatic identifier inconsistency detection using code dictionary.
Empirical Software Engineering 21(2):565--604 Kitchenham BA, Pfleeger
SL, Pickard LM, Jones PW, Hoaglin DC, El Emam K, Rosenberg J (2002)
Preliminary guidelines for empirical research in software engineering.
IEEE Transactions on software engineering 28(8):721--734 Language R
(2024) Venndiagram. https://cran.r-project.org/web/packages/
VennDiagram/ Accessed August 18, 2024 Lawrie D, Morrell C, Feild H,
Binkley D (2006) What's in a name? A study of identifiers. IEEE
International Conference on Program Comprehension 2006:3--12, DOI
10.1109/ ICPC.2006.51 48 Taiming Wang 1 et al.

Le QV, Mikolov T (2014) Distributed representations of sentences and
documents. In: Pro- ceedings of the 31th International Conference on
Machine Learning, ICML 2014, Beijing, China, 21-26 June 2014, JMLR.org,
JMLR Workshop and Conference Proceedings, vol 32, pp 1188--1196, URL
http://proceedings.mlr.press/v32/le14.html Li K, Wang T, Liu H (2021a)
NameChecker: Detecting Inconsistency between Method Names and Method
Bodies. Proceedings - Asia-Pacific Software Engineering Conference,
APSEC 2021-December:22--31, DOI 10.1109/APSEC53868.2021.00010 Li Y
(2024) Deepname-2021-icse. https://github.com/deepname2021icse/
DeepName-2021-ICSE Accessed August 18, 2024 Li Y, Wang S, Nguyen TN
(2021b) A context-based automated approach for method name consistency
checking and suggestion. In: 43rd IEEE/ACM International Conference on
Software Engineering, ICSE 2021, Madrid, Spain, 22-30 May 2021, IEEE, pp
574--586, DOI 10.1109/ICSE43902.2021.00060, URL
https://doi.org/10.1109/ICSE43902.2021. 00060 Liblit B, Begel A,
Sweetser E (2006) Cognitive perspectives on the role of naming in
computer programs. In: Proceedings of the 18th Annual Workshop of the
Psychology of Programming Interest Group, PPIG 2006, Brighton, UK,
September 7-8, 2006, Psychology of Programming Interest Group, p 11 Lin
B, Scalabrino S, Mocci A, Oliveto R, Bavota G, Lanza M (2017)
Investigating the use of code analysis and NLP to promote a consistent
usage of identifiers. In: 2017 IEEE 17th International Working
Conference on Source Code Analysis and Manipulation (SCAM), pp 81--90,
DOI 10.1109/SCAM.2017.17 Lin B, Nagy C, Bavota G, Lanza M (2019) On the
impact of refactoring operations on code naturalness. In: Wang X, Lo D,
Shihab E (eds) 26th IEEE International Conference on Software Analysis,
Evolution and Reengineering, SANER 2019, Hangzhou, China, February
24-27, 2019, IEEE, pp 594--598, DOI 10.1109/SANER.2019.8667992, URL
https://doi.org/10.1109/SANER.2019.8667992 Lin B, Nagy C, Bavota G,
Marcus A, Lanza M (2019) On the quality of identifiers in test code. In:
2019 19th International Working Conference on Source Code Analysis and
Manipulation (SCAM), pp 204--215, DOI 10.1109/SCAM.2019.00031 Liu F, Li
G, Fu Z, Lu S, Hao Y, Jin Z (2022) Learning to recommend method names
with global context. In: Proceedings of the 44th International
Conference on Software Engineering, pp 1294--1306 Liu H, Liu Q, Liu Y,
Wang Z (2015) Identifying renaming opportunities by expanding conducted
rename refactorings. IEEE Transactions on Software Engineering
41(9):887-- 900, DOI 10.1109/TSE.2015.2427831 Liu H, Shen M, Zhu J, Niu
N, Li G, Zhang L (2020) Deep learning based program generation from
requirements text: Are we there yet? IEEE Transactions on Software
Engineering 48(4):1268--1289 Liu K (2024) debug-method-name.
https://github.com/SerVal-DTF/debug-method-name Accessed August 18, 2024
Liu K, Kim D, Bissyande TF, Kim T, Kim K, Koyuncu A, Kim S, Le Traon Y
(2019) Learning to Spot and Refactor Inconsistent Method Names.
Proceedings - International Conference on Software Engineering
2019-May:1--12, DOI 10.1109/ICSE.2019.00019 Lozoya RC, Baumann A,
Sabetta A, Bezzi M (2019) Code2Vec: Learning distributed representations
of code changes. arXiv 3(January), 1911.07605 Matsugu M, Mori K, Mitari
Y, Kaneda Y (2003) Subject independent facial expression recognition
with robust face detection using a convolutional neural network. Neural
Networks 16(5-6):555--559, DOI 10.1016/S0893-6080(03)00115-1, URL
https://doi.org/ 10.1016/S0893-6080(03)00115-1 McCabe TJ (1976) A
complexity measure. IEEE Transactions on software Engineering
(4):308--320 Microsoft (2024) Neural network intelligence.
https://github.com/microsoft/nni Accessed August 18, 2024 Mikolov T,
Sutskever I, Chen K, Corrado GS, Dean J (2013) Distributed
representations of words and phrases and their compositionality. In:
Advances in Neural Information Processing Systems 26: 27th Annual
Conference on Neural Information Processing Systems 2013. Proceedings of
a meeting held December 5-8, 2013, Lake Tahoe, Nevada, Empirical Study
on DL-based Identification of Inconsistent Method Names. 49

    United States, pp 3111–3119

Minehisa T, Aman H, Yokogawa T, Kawahara M (2021) A Comparative Study of
Vectorization Approaches for Detecting Inconsistent Method Names, vol
985. Springer International Publishing Newman CD, AlSuhaibani RS, Decker
MJ, Peruma A, Kaushik D, Mkaouer MW, Hill E (2020) On the generation,
structure, and semantics of grammar patterns in source code identifiers.
Journal of Systems and Software 170:110740 Nguyen S, Phan H, Le T,
Nguyen TN (2020) Suggesting natural method names to check name
consistencies. In: ICSE '20: 42nd International Conference on Software
Engineering, Seoul, South Korea, 27 June - 19 July, 2020, ACM, pp
1372--1384, DOI 10.1145/3377811.3380926, URL
https://doi.org/10.1145/3377811.3380926 Noever D (2023) Can large
language models find and fix vulnerable software? arXiv preprint
arXiv:230810345 Oliveros J (2024) Venny.
https://bioinfogp.cnb.csic.es/tools/venny/index.html Ac- cessed August
18, 2024 Oord Avd, Li Y, Vinyals O (2018) Representation learning with
contrastive predictive coding. arXiv preprint arXiv:180703748 Ott RL,
Longnecker MT (2015) An introduction to statistical methods and data
analysis. Cengage Learning Peruma A, Mkaouer MW, Decker MJ, Newman CD
(2018) An empirical investigation of how and why developers rename
identifiers. IWoR 2018 - Proceedings of the 2nd International Workshop
on Refactoring, co-located with ASE 2018 (August):26--33, DOI
10.1145/3242163.3242169 Ray B, Hellendoorn V, Godhane S, Tu Z, Bacchelli
A, Devanbu PT (2016) On the "natural- ness" of buggy code. In:
Proceedings of the 38th International Conference on Software
Engineering, ICSE 2016, Austin, TX, USA, May 14-22, 2016, ACM, pp
428--439, DOI 10.1145/2884781.2884848, URL
https://doi.org/10.1145/2884781.2884848 Runeson P, Höst M (2009)
Guidelines for conducting and reporting case study research in software
engineering. Empirical software engineering 14:131--164 Scardapane S,
Wang D (2017) Randomness in neural networks: An overview. Wiley
Interdiscip Rev Data Min Knowl Discov 7(2), DOI 10.1002/widm.1200, URL
https://doi.org/10. 1002/widm.1200 Schankin A, Berger A, Holt DV,
Hofmeister JC, Riedel T, Beigl M (2018) Descriptive com- pound
identifier names improve source code comprehension. Proceedings -
International Conference on Software Engineering pp 31--40, DOI
10.1145/3196321.3196332 Singer J, Kirkham C (2008) Exploiting the
correspondence between micro patterns and class names. In: 2008 Eighth
IEEE International Working Conference on Source Code Analysis and
Manipulation, IEEE, pp 67--76 Snoek J, Larochelle H, Adams RP (2012)
Practical bayesian optimization of ma- chine learning algorithms. In:
Advances in Neural Information Processing Sys- tems 25: 26th Annual
Conference on Neural Information Processing Systems 2012. Proceedings of
a meeting held December 3-6, 2012, Lake Tahoe, Nevada, United States, pp
2960--2968, URL https://proceedings.neurips.cc/paper/2012/
hash/05311655a15b75fab86956663e1819cd-Abstract.html Suzuki T, Sakamoto
K, Ishikawa F, Honiden S (2014) An approach for evaluating and
suggesting method names using N-gram models. 22nd International
Conference on Program Comprehension, ICPC 2014 - Proceedings pp
271--274, DOI 10.1145/2597008. 2597797 Takang AA, Grubb PA, Macredie RD
(1996) The effects of comments and identifier names on program
comprehensibility: An experimental investigation. J Prog Lang
4(3):143--167 Wang K, Su Z (2020) Blended, precise semantic program
embeddings. In: Proceedings of the 41st ACM SIGPLAN Conference on
Programming Language Design and Implementation, pp 121--134 Wang S, Wen
M, Lin B, Mao X (2021a) Lightweight global and local contexts guided
method name recommendation with prior knowledge. In: Proceedings of the
29th ACM Joint Meeting on European Software Engineering Conference and
Symposium on the Foundations of Software Engineering, pp 741--753 50
Taiming Wang 1 et al.

Wang T (2024) Empiricalstudy-mcc. https://github.com/Michaelll123/
EmpiricalStudy-MCC Accessed August 18, 2024 Wang Y, Wang W, Joty S, Hoi
SC (2021b) Codet5: Identifier-aware unified pre-trained encoder-decoder
models for code understanding and generation. arXiv preprint
arXiv:210900859 Wen F, Nagy C, Lanza M, Bavota G (2020) An empirical
study of quick remedy commits. IEEE International Conference on Program
Comprehension pp 60--71, DOI 10.1145/ 3387904.3389266 Wen F, Nagy C,
Lanza M, Bavota G (2022) Quick remedy commits and their impact on mining
software repositories. Empirical Software Engineering 27(1):1--31, DOI
10.1007/ s10664-021-10051-z Xia CS, Zhang L (2023) Keep the conversation
going: Fixing 162 out of 337 bugs for \$0.42 each using ChatGPT. arXiv
preprint arXiv:230400385 Xia CS, Deng Y, Dunn S, Zhang L (2024)
Agentless: Demystifying llm-based software engineering agents. arXiv
preprint arXiv:240701489 Zhuang D, Zhang X, Song SL, Hooker S (2021)
Randomness in neural network training: Characterizing the impact of
tooling. CoRR abs/2106.11872, URL https://arxiv.org/ abs/2106.11872,
2106.11872 Zügner D, Kirschstein T, Catasta M, Leskovec J, Günnemann S
(2021) Language-agnostic representation learning of source code from
structure and context. arXiv preprint arXiv:210311318 
