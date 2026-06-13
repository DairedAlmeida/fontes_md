             AI

Review

Human Evaluation of Large Language Models: A Review and Protocol
Selection Framework Tad T. Brunyé 1,2

                                         1   Center for Applied Brain and Cognitive Sciences, Tufts University, Medford, MA 02155, USA;
                                             tbruny01@tufts.edu
                                         2   U.S. Army DEVCOM Soldier Center, Natick, MA 01760, USA


                                         Abstract
                                         Evaluating large language models (LLMs) critically depends on human judgment. This
                                         article reviews and develops a conceptual framework for human-centered LLM evaluation,
                                         synthesizing research across evaluation methodology, psychometrics, cognitive science, and
                                         domain-specific applications. Four primary challenges are identified that limit current hu-
                                         man evaluation practice: imperfect gold standards, evaluator fatigue and overload, shared
                                         and unique bias structures across humans and LLM judges, and the routine omission of
                                         uncertainty and dispersion estimates. To address these gaps, the STEP-V design framework
                                         is proposed: Stakes, Task-type, Evaluator availability, Purpose, and Volume, for selecting
                                         human and/or automated LLM evaluation methods under real-world constraints. An
                                         evaluator failure mode taxonomy is also proposed that analyzes human and LLM judges
                                         within a common error framework, clarifying where hybrid pipelines can compensate for
                                         weaknesses and where they might compound them. The framework motivates a more
                                         rigorous science of LLM evaluation, one that treats human judgment as a necessary but
                                         fallible measurement requiring explicit design, calibration, and uncertainty quantification.

                                         Keywords: large language models; human evaluation; LLM-as-judge; psychometrics;
                                         inter-rater reliability; methods; measurement validity; evaluation design




                                         1. Introduction
                                               Large language models (LLMs) have changed not only what artificial intelligence
                                         (AI) systems can do, but also what it means to evaluate them. LLM capabilities emerge
                                         from a range of training and adaptation paradigms, including self-supervised pretraining,
                                         supervised fine-tuning, reinforcement learning from human feedback, and retrieval- or
                                         tool-augmented inference; the present review does not provide a taxonomy of model-

Academic Editors: Zhenhong Hu and development methods (see \[1--4\] for
such reviews); instead, it provides a framework for Yingbo Ma how
resulting system outputs should be evaluated once they are compared,
deployed, Received: 7 April 2026 or monitored. Early natural language
processing (NLP) systems were often assessed on Revised: 30 April 2026
narrow, well-specified tasks with relatively stable output spaces and
task-aligned bench- Accepted: 14 May 2026 marks. By contrast,
contemporary LLMs generate open-ended, context-dependent, and Published:
19 May 2026 often subjective responses across a wide range of tasks,
from medical counseling and legal Copyright: © 2026 by the author.
analysis to tutoring, planning, and creative writing. In these settings,
evaluation cannot Licensee MDPI, Basel, Switzerland. be reduced to
surface similarity with a reference answer \[5--7\]. Determining whether
an This article is an open access article distributed under the terms
and answer is clinically sound, legally defensible, pedagogically
useful, or socially appropriate conditions of the Creative Commons
critically requires human judgment. Attribution (CC BY) license.

AI 2026, 7, 174 https://doi.org/10.3390/ai7050174 AI 2026, 7, 174 2 of
22

                        While there is increasing interest in human evaluation of LLM performance, the field
                  has not yet developed a sufficiently rigorous theory of how to systematically select human
                  evaluation methods [8,9]. In existing work, human judges often function as a practical
                  endpoint: after collecting and tuning a model against automated metrics, researchers may
                  ask humans to rate model outputs. In turn, those ratings can be used as labels when
                  benchmarking a system. This practice is conceptually incomplete: human evaluation goes
                  beyond identifying labels; it is a complex measurement process involving raters, protocols,
                  scales, task definitions, cognitive constraints, biases, and statistical assumptions. Like
                  any measurement system, it can be valid or invalid, reliable or unreliable, calibrated or
                  poorly calibrated, and more or less appropriate for the construct it claims to assess [10–12].
                  This point is increasingly important because LLMs are now deployed in domains where
                  evaluation errors can have meaningful and potentially life-altering consequences, including
                  high-stakes domains such as medicine, the military, and law.
                        Automated metrics are scalable and cheap, but may fail to capture reasoning quality,
                  social appropriateness, or usefulness in open-ended tasks [9,13,14]. Human evaluation is rel-
                  atively flexible and often closer to application reality, but is also expensive, heterogeneous,
                  and vulnerable to fatigue, mental workload, framing effects, and other biases [12,15,16].
                  Between those two endpoints, LLM-as-judge models promise scale with some contextual
                  sensitivity, yet growing evidence suggests they cannot be assumed to reproduce human
                  judgments consistently across tasks and annotator populations [7,16–18]. In other words,
                  evaluation quality depends on the interaction among task structure, evaluator type, and
                  protocol design. A central question is how evaluation systems should be structured when
                  no evaluator is unbiased, perfectly reliable, or universally valid [6,7,12]. One solution is
                  to design a measurement strategy appropriate to the stakes, task, and intended use of the
                  model [7,19,20].
                        LLM evaluation should be reframed as a measurement-design problem, with the
                  central claim that human evaluation should be treated as measurement infrastructure: a
                  system for generating evidence about model quality that must itself be designed, validated,
                  and monitored. In this view, evaluator disagreement provides important information about
                  construct ambiguity, rater heterogeneity, or protocol weakness. Likewise, the common
                  practice of treating human labels as perfect ground truth obscures an imperfect gold
                  standard problem seen in psychometrics and diagnostic statistics, where the reference
                  standard itself is error-prone [21,22]. Addressing these issues requires a broader synthesis
                  than judge models or standard benchmark surveys may provide [11,23].
                        In addition to reviewing human evaluation methods, this article also integrates them
                  into a conceptual framework that links theoretical validity, practical design, and deploy-
                  ment constraints. To do so, LLM evaluation is organized into three tiers: automated
                  reference-based metrics, LLM-as-judge systems, and direct human evaluation. The third
                  (human) tier is then the focus, examining who evaluates, what is evaluated, and how
                  evaluation is operationalized in practice. Throughout, multiple disciplines are drawn upon,
                  including psychometrics, cognitive science, annotation research, and domain-specific stud-
                  ies to show that evaluator choice, scale design, protocol structure, and statistical reporting
                  are all important aspects of evaluation.
                        Relative to extant research and theory on this topic, this article uniquely synthesizes
                  several previously distinct lines of work into a unified framework for evaluation design.
                  Prior research on LLM evaluation has tended to take one of several complementary but frag-
                  mented approaches. Broad evaluation surveys map the landscape of metrics, benchmarks,
                  and workflows, but typically treat human evaluation as one component among many, not
                  just as a standalone measurement system [24]. LLM-as-judge surveys and empirical com-
                  parison studies focus on the reliability and behavior of model-based evaluators, often using



                                                                                  https://doi.org/10.3390/ai7050174

AI 2026, 7, 174 3 of 22

                  human judgments as a reference point, but rarely interrogate the structure and variability of
                  those human judgments themselves. In parallel, psychometric approaches provide rigorous
                  frameworks for reliability, validity, and construct definition, yet are seldom translated into
                  concrete evaluation protocols for LLM systems [25]. Practitioner and industry-oriented
                  work offers valuable operational guidance for deployment and monitoring, but is often
                  under-theorized with respect to measurement principles [26,27]. The present review centers
                  on human evaluation as a measurement-design problem, treating human and LLM judges
                  symmetrically, and connecting empirical findings on alignment and bias with psychome-
                  tric theory and application-specific constraints. In doing so, it reframes evaluation as an
                  infrastructure problem, one that requires explicit design of evaluators, tasks, aggregation
                  procedures, and uncertainty quantification.
                        The remainder of the paper proceeds as follows. Section 2 maps the broader landscape
                  of LLM evaluation across the three tiers. Section 3 analyzes direct human evaluation
                  through the lenses of evaluator type, evaluation target, and protocol. Section 4 addresses
                  reliability, validity, and major sources of human judgment error. Section 5 introduces
                  a unified failure mode taxonomy. Section 6 examines domain-specific implications in
                  healthcare, law, finance, and safety. Section 7 presents STEP-V as a design framework for
                  matching evaluation strategy to context. Section 8 proposes methodological best practices,
                  and finally, Section 9 outlines open problems and future research directions.

                  2. LLM Evaluation: A Three-Tiered Taxonomy
                       Evaluation methods for LLMs can be organized into three broad tiers distinguished
                  by the identity of the evaluator and the form of judgment produced. Tier 1 consists of
                  automated reference-based or reference-free metrics. Tier 2 consists of LLM-as-judge
                  systems that use language models to score or rank outputs. Tier 3 consists of direct human
                  evaluation. This taxonomy is useful not only descriptively but also analytically, because
                  each tier embodies different assumptions about what qualifies as evidence of quality and
                  what kinds of errors are likely to arise [7,18,28]. The intent is not to rank all methods along a
                  single scale of quality; instead, it is to highlight that evaluation methods differ in construct
                  coverage, interpretability, cost, reproducibility, and failure profiles [10,12].

                  2.1. Tier 1: Automated Metrics
                        Automated metrics remain indispensable in LLM evaluation because they provide low-
                  cost, reproducible signals and enable rapid iteration. Classic overlap metrics such as BLEU,
                  ROUGE, and METEOR compare generated text to reference outputs and are useful when
                  lexical or structural similarity to a gold standard answer is a meaningful proxy for task
                  success [29]. More recent semantic metrics, such as BERTScore, improve on surface overlap
                  by capturing paraphrastic similarity in embedding space [30]. Reference-free measures,
                  including perplexity and certain faithfulness metrics in retrieval-augmented generation,
                  attempt to assess quality without requiring a single gold standard response [18,30].
                        The utility of these metrics is bounded by the constructs they can measure. Surface and
                  semantic similarity do not reliably capture factual correctness, reasoning quality, strategic
                  usefulness, or ethical acceptability [14,31]. In open-ended tasks, multiple responses may be
                  equally good for different reasons, or superficially similar while differing in safety or truth-
                  fulness. This creates a construct mismatch between the metric and the quality dimension
                  of actual interest. Automated metrics are therefore best understood as convenient partial
                  instruments; they are not general-purpose substitutes for human judgment [5,10].




                                                                                    https://doi.org/10.3390/ai7050174

AI 2026, 7, 174 4 of 22

                  2.2. Tier 2: LLM-as-Judge Systems
                       The rapid rise in LLM-as-judge systems reflects a genuine need: researchers and
                  practitioners want evaluators that scale better than humans while capturing more nuance
                  than classic automated metrics. Recent surveys and empirical studies show that LLM-
                  based judges can perform well in structured or quasi-structured evaluation settings (e.g.,
                  in pairwise comparisons or rubric-guided scoring), particularly when evaluation criteria
                  are explicit and human judgments are relatively consistent [16,32]. However, performance
                  varies substantially by task type, evaluated property, language, and the expertise level of
                  the human annotators against whom models are compared [20,28].
                       This variation has major implications: LLM judges should not be treated as plug-
                  and-play evaluators whose scores are inherently meaningful across contexts. Instead, they
                  are measurement tools whose validity is local; they must be calibrated and tested against
                  the target task, target construct, and target evaluator population. Large-scale empirical
                  work has shown that some judge models align reasonably well with humans on tasks such
                  as instruction following, while performing much less reliably on subjective or expertise-
                  sensitive evaluations [7,20,28]. The strongest takeaway from this literature is not that
                  LLM judges fail universally, but that they require careful validation before they can be
                  used effectively.

                  2.3. Tier 3: Direct Human Evaluation
                        Direct human evaluation remains the most flexible approach because humans can
                  assess qualities that are difficult to formalize, including persuasiveness, appropriateness,
                  pedagogical value, harm, and domain-specific adequacy. Humans can also interpret context,
                  detect subtle mismatches between tone and audience, and recognize when multiple valid
                  answers exist. For these reasons, direct human evaluation remains indispensable in high-
                  stakes, high expertise, socially embedded, or normatively contested applications [5,6,12].
                        At the same time, human evaluation is not a single method; a domain expert rating le-
                  gal analysis, an end user reporting satisfaction, and a crowdworker comparing two chatbot
                  answers are all performing different measurement acts under different assumptions and
                  constraints. While all three are considered human evaluations, treating them interchange-
                  ably obscures crucial design questions. The remainder of this paper focuses on this third
                  tier and argues that its rigor depends on making such differences explicit [10–12].

                  3. Human Evaluation: Who, What, & How
                       A useful way to structure human evaluation is around three questions directly tied
                  to sources of measurement variation: who evaluates, what is evaluated, and how is eval-
                  uation conducted [12,33]. For example, different evaluator populations bring different
                  kinds of expertise, background knowledge, and bias. Different evaluation targets reflect
                  different constructs, some objective and some deeply subjective. Moreover, different pro-
                  tocols impose different cognitive loads and fatigue, and produce different kinds of data.
                  Understanding human evaluation requires analyzing all three together.

                  3.1. Who Evaluates
                        Evaluator choice is a critical element of human evaluation. If the aim is to assess
                  clinical safety, domain experts are often necessary because non-experts cannot reliably
                  identify subtle but dangerous errors [34]. If the aim is to assess user satisfaction or prac-
                  tical helpfulness, end users may be the more valid evaluators because ecological validity
                  matters more than formal expertise. Trained annotators and crowdworkers occupy in-
                  termediate positions, offering scale and standardization but often with weaker domain
                  knowledge [10,35].



                                                                                 https://doi.org/10.3390/ai7050174

AI 2026, 7, 174 5 of 22

                                 As detailed in Table 1, evaluator selection should be guided by the relationship be-
                           tween the construct of interest and the competencies required to judge it. A useful heuristic
                           is that evaluator validity depends on the degree to which the judgment requires specialized
                           knowledge, lived experience, and/or contextual familiarity. Domain experts may be ex-
                           pensive and still disagree with one another, but disagreement among experts is often more
                           informative than apparent agreement among non-experts who do not have the requisite
                           expertise to understand relevant distinctions. Conversely, end-user evaluations may be
                           the most appropriate signal when the target construct is acceptability, trust, or perceived
                           usefulness in a real interaction context [12,33,35].

                           Table 1. Evaluator types and appropriate use cases, with reference to validity (for specialized tasks),
                           reliability, cost, and scalability.

       Evaluator       Validity            Reliability         Cost          Scalability               Best Use Case
                                                                                             High-stakes, domain-specific; e.g.,

Domain Experts Very High Moderate Very High Low medicine, law, military,
finance. General-purpose quality Trained Moderate Moderate Moderate
Moderate assessment with rubrics and Annotators calibration. Fluency,
relevance, basic Low to Crowd Workers Low to Moderate Low Very High
comprehension, large low-stakes Moderate annotation. End Satisfaction,
usability, real-world High Ecological Low Low Moderate Users utility in
deployment context.

                                These tradeoffs are documented: experts generally provide the strongest construct
                           validity for specialized tasks but are expensive and hard to scale, whereas crowd and
                           annotator pools can be scalable and cost-efficient but require stronger quality control and
                           are less appropriate for expertise-intensive judgments [36,37].

                           3.2. What Is Evaluated
                                In practice, evaluation criteria differ by whether they are externally verifiable, partially
                           observable, or fundamentally experiential. Accuracy, citation correctness, and format
                           compliance often have external referents; in contrast, creativity, politeness, and engagement
                           are more subjective, relying on human interpretation and social norms. Domain-specific
                           criteria such as clinical appropriateness, legal soundness, or regulatory adequacy require
                           expert frameworks and often cannot be judged reliably by general annotators [10,33]. For
                           high-stakes tasks, experts should judge more than the output, incorporating judgments of
                           the logic (chain of thought) through reasoning traces [38,39].
                                For this reason, one of the first steps in evaluation design should be clarifying the
                           target construct [10,11,40]. Researchers should specify whether they are measuring correct-
                           ness, usefulness, preference, trust, readability, safety, or some combination of these. They
                           should also ask whether the construct can be decomposed into observable subdimensions.
                           Rubric-based evaluation often improves reliability because it transforms vague, holistic
                           impressions into narrower, more observable judgments. Without this step, low agreement
                           may reflect both evaluator weakness and an under-defined construct.

                           3.3. How It Is Evaluated
                                Evaluation protocols determine both data quality and interpretability. Pointwise
                           ratings, binary judgments, pairwise comparisons, and rubric-based scoring each come
                           with tradeoffs.
                           •       Likert-style ratings: Evaluators assign each output a score (e.g., 1–5) for target crite-
                                   ria such as helpfulness or accuracy. This method provides graded distinctions but


                                                                                                 https://doi.org/10.3390/ai7050174

AI 2026, 7, 174 6 of 22

                       generates ordinal data and may be sensitive to anchoring and scale interpretation
                       effects [41,42].
                  •    Binary judgments: Evaluators classify an output into one of two categories, such as
                       acceptable versus unacceptable, or correct versus incorrect. This method can improve
                       agreement when the target distinction is sharp, but can also discard nuance [43,44].
                  •    Pairwise comparison: Evaluators compare two outputs side-by-side and select
                       the better one for a specified criterion. This often aligns well with human judg-
                       ments and can be especially useful when raters struggle to apply absolute scales
                       consistently [45,46].
                  •    Rubric-based protocols: Evaluators score an output on multiple predefined dimen-
                       sions, each with explicit criteria or anchors (see examples in Supplementary Materials
                       File S1). This method can reduce ambiguity by distributing judgment across multiple
                       explicitly defined dimensions [28,33,35].
                       These protocol choices determine the statistical structure of the data, the likely sources
                  of bias, and the cognitive burden placed on evaluators. A protocol that appears simple on
                  paper may produce unreliable data if it demands too many simultaneous judgments or if
                  scale labels are underdefined. Likewise, long sessions, large label spaces, and exposure to
                  model suggestions can alter rater behavior. Evaluation design therefore requires not only
                  choosing a rating format but aligning that format with evaluator capability, task complexity,
                  and an analysis plan.

                  4. Reliability, Validity, and Human Judgment Errors
                       Reliability and validity are the basis on which evaluation results become inter-
                  pretable [10–12]. Reliability considers the consistency of judgments across raters, items, or
                  occasions; validity considers whether the protocol actually measures the construct it claims
                  to measure. In LLM evaluation, both are infrequently demonstrated.

                  4.1. Reliability
                       Inter-rater reliability metrics such as Cohen’s kappa, Krippendorff’s alpha, and in-
                  traclass correlation coefficients are widely available, yet many evaluation studies still
                  underreport them or report them without interpretation. This is a serious limitation be-
                  cause aggregated scores can hide deep inconsistency. Recent empirical work comparing
                  LLM judges and humans across many tasks found substantial variability depending on the
                  property being evaluated and the expertise level of the human judges, demonstrating that
                  reliability is not constant across contexts [7,16,23]. Low agreement should therefore not
                  automatically be dismissed as annotator noise; it may indicate ambiguous criteria, mixed
                  constructs, or task designs that overload evaluators [47,48]. In this manner, disagreement
                  often deserves a closer look.
                       One useful extension is to treat disagreement as a distributional object. For subjective,
                  perspectival, or culturally variable tasks, researchers can compare rating distributions across
                  evaluator groups, items, or model conditions using both classical reliability coefficients
                  and distributional divergence measures. For example, Kullback–Leibler divergence [49] or
                  Earth Mover’s Distance [50] may help quantify whether a model’s response profile matches
                  the spread of human judgments, not merely their central tendency. Large divergences,
                  especially when concentrated within particular subgroups or item types, should motivate
                  targeted audits, revised instructions, or escalation to expert adjudication.
                       The recent shift toward data perspectivism suggests that in subjective or culturally
                  nuanced tasks, disagreement often represents valid, divergent perspectives that are them-
                  selves a critical diagnostic signal [51,52]. Rather than collapsing these to a majority-vote
                  mean, robust evaluation should adopt distributional alignment, measuring whether the



                                                                                  https://doi.org/10.3390/ai7050174

AI 2026, 7, 174 7 of 22

                  model’s output distribution reflects the diversity of human opinion (e.g., via Kullback–
                  Leibler divergence or Earth Mover’s Distance [49,50]). This is particularly important
                  as models increasingly encounter edge-case social norms where no single consensus
                  may exist.
                        Importantly, preserving disagreement may not be appropriate for all tasks. In subjec-
                  tive, open-ended, or culturally contingent evaluations, disagreement may reflect legitimate
                  perspectival variation and should be retained as a meaningful part of the measurement
                  target. By contrast, for objective and safety-critical criteria (e.g., such as medication con-
                  traindications, incorrect legal citations, or other externally verifiable high-stakes errors),
                  substantial disagreement should be treated as a warning signal that triggers stricter adjudi-
                  cation procedures. In such cases, expert review, external verification, conservative decision
                  thresholds, and escalation of borderline or contested cases are likely necessary to establish
                  a minimum safety baseline.

                  4.2. Validity
                         Validity is a fundamental issue for any evaluation protocol; indeed, a protocol can
                  be reliable and still invalid (i.e., consistently measuring the wrong thing). For example,
                  verbosity bias may generate stable preferences for longer responses even when length
                  is unrelated to correctness. Likewise, end-user satisfaction may be a valid measure of
                  perceived helpfulness while being an invalid measure of factual accuracy. There is a risk of
                  misaligning the evaluator, criterion, and inference target [10,11,33].
                         A particularly important validity issue is the imperfect gold standard problem. Human
                  labels are often treated as authoritative ground truth, but in many settings, they are
                  themselves fallible, heterogeneous, and construct-bound [53]. Psychometrics and diagnostic
                  statistics offer tools for dealing with imperfect reference standards, including latent-variable
                  approaches and sensitivity analysis. LLM evaluation has only begun to consider these
                  ideas, but doing so would shift the field toward a more mature measurement framework.
                  It is important to point out, however, that low agreement and rater divergence should not
                  always be collapsed into error; in subjective or socially situated tasks, disagreement can
                  reflect meaningful perspectival variation (i.e., not just noise) [23,44].
                         A practical consequence is that evaluation studies should increasingly move beyond
                  raw score aggregation toward explicit measurement models. Depending on the protocol,
                  this may include many-facet Rasch models [54] to separate item difficulty, rater severity,
                  and latent performance; hierarchical ordinal models for rubric-based or Likert-style data;
                  and pairwise-comparison models such as Bradley–Terry [55] when evaluators make relative
                  judgments. These approaches are valuable not because they eliminate subjectivity, but
                  because they make sources of variation explicit and estimable. In turn, they can support
                  more defensible inferences about construct validity, evaluator effects, and uncertainty than
                  simple averages alone.

                  4.3. Bias and Cognitive Constraints
                       Human evaluation is also shaped by predictable cognitive and social distortions [7,28,56].
                  Order effects, scale anchoring, framing, fatigue, and automation bias can systematically alter
                  judgments. These problems are not unique to human evaluators; many also appear in LLM
                  judges, including position bias, verbosity bias, and susceptibility to prompt framing. The
                  consequence is that replacing humans with judge models does not remove evaluation bias;
                  rather, it may just change its form or redistribute it.
                       Human evaluation protocols should be designed with human factors and experimen-
                  tal methods in mind; for example, randomizing response order, limiting session length,
                  blinding model identities, separating dimensions across rating passes, and monitoring



                                                                                   https://doi.org/10.3390/ai7050174

AI 2026, 7, 174 8 of 22

                               performance drift during annotation. These design choices can be critical for shaping
                               whether evaluation outputs can support credible claims. Example calibration prompts can
                               be found in Supplementary Materials File S2.

                               5. Common Evaluator Failure Modes
                                     A recurring theme in extant research is that both humans and LLM judges fail in pat-
                               terned ways [16,17,57,58], yet these two phenomena are sometimes presumed independent.
                               Instead, it is useful to analyze them within a single failure-mode framework; this can help
                               clarify which biases are shared, which are distinct, and where hybrid evaluation designs
                               are likely to improve or worsen performance [7,28,56].
                                     One important implication of this unified view is that hybrid systems do not auto-
                               matically obviate error; for example, if both human raters and judge models prefer longer
                               answers, defer to authoritative phrasing, or struggle with culturally loaded judgments,
                               combining them may simply amplify the same distortions. Indeed, hybrid designs are
                               likely most promising when the human and model components fail for different reasons.
                               For example, LLM judges may be useful for large-scale screening on structured criteria
                               such as formatting or explicit factual consistency, while human experts remain primary
                               judges for subjective, contextual, or high-stakes dimensions. Some common failure modes
                               for humans and LLM judges are detailed in Table 2.

                               Table 2. Failure modes, how they manifest in humans and LLM judges, and design implications to
                               mitigate their impact.

                                                                          LLM-as-Judge
           Failure Mode            Human Manifestation                                                   Design Implication
                                                                          Manifestation
                                 Primacy, recency, anchoring                                         Randomize order and blind
           Order Effects                                                Position bias [17,56]
                                            [57,59]                                                        presentation.
                                Longer responses perceived as        Preference for length over      Control length or evaluate
           Verbosity Bias
                                        better [60,61]                   substance [16,17]               brevity separately.
                                                                             Favoring
                                   Deference to prestigious                                          Remove source cues where
          Authority Bias                                              authoritative-sounding
                                     sources or tone [62]                                                   possible.
                                                                          outputs [16,17]
                                    Herding toward prior           Reinforcement of prior signals   Isolate evaluators and prevent
        Social Conformity
                                      judgments [63,64]                          [17]                        score leakage.
                                  Excess certainty in ratings      Excess certainty in judgments        Require justification or
          Overconfidence
                                            [65,66]                            [67,68]                   confidence reporting.
                                                                    Degradation under context
                                  Attention decline within &                                        Limit session length and audit
      Fatigue and Overload                                            length, task complexity,
                                    across sessions [69,70]                                                drift by position.
                                                                      repeated inference [71]
                                Low interrater reliability (IRR)                                      Use multiple raters and
                                                                   Weak alignment with humans
        Subjectivity Failure        on creative or cultural                                           preserve disagreement,
                                                                     on subjective tasks [7,16]
                                       judgments [47,58]                                             examine noise for signal.
                                Inability to detect specialized       Weak domain-specific          Match evaluator expertise to
         Knowledge Gaps
                                         errors [53,72]                judgment [73,74]                        task.
                                      Ratings shaped by
              Cultural                                              Bias inherited from training    Diversify evaluator pools and
                                   demographic or cultural
               Bias                                                         data [77,78]                test subgroup effects.
                                      background [75,76]
                                  Failure to detect confident      Scoring fabricated content as    Add external verification on
        Hallucination Trust
                                    misinformation [79,80]                   valid [74]                factual dimensions.


                                    It is important to consider that human-model disagreement is not always a sign that
                               one side is wrong and the other right. Instead of collapsing disagreement into an average
                               score, evaluation systems should preserve it as a diagnostic signal [11,23,44]. This can help
                               indicate when there is a construct mismatch, protocol weakness, or evaluator asymmetry
                               worth further investigation.



                                                                                                    https://doi.org/10.3390/ai7050174

AI 2026, 7, 174 9 of 22

                  6. Domain-Specific Evaluation
                        The need for measurement-aware evaluation becomes especially clear in domain-
                  specific applications. In healthcare, legal analysis, finance, military, education, and safety,
                  the difference between a fluent answer and a correct answer can be highly consequential.
                  Domain knowledge is not merely helpful in these settings; it is constitutive of valid evalua-
                  tion. For example, a non-expert may judge a response as coherent and reassuring while
                  missing a clinically dangerous omission or a legally dubious statement [7,36,78].
                        Frameworks emerging from medical AI evaluation emphasize not only accuracy but
                  also uncertainty communication, harm awareness, and adjudication procedures [36,81–85].
                  This is consistent with a measurement-design view: the question goes beyond whether the
                  model answered correctly, but whether the evaluation protocol is sensitive to the kinds
                  of failure that matter in practice. Similar points apply in law, where internal coherence is
                  insufficient if citations or jurisdictional assumptions are wrong, and in safety assessment,
                  where harm is context-sensitive and often culturally bound [6,36,86–89].
                        The broader point here is that domain-specific evaluation should not be treated as a
                  downstream customization of generic methods. It often requires a different evaluator pool,
                  a different construct definition, and a different tolerance for uncertainty. In high-stakes
                  domains, such as medicine and the military, evaluation should be explicitly tied to the real-
                  world safety and ethical consequences of being wrong. Further, this work should extend
                  beyond static output ratings to consider observable processes in increasingly multi-step
                  and semi-autonomous agentic systems.

                  7. The STEP-V Framework
                        To operationalize these principles, this article introduces a five-dimensional framework
                  for configuring evaluation strategies based on Stakes, Task-type, Evaluator availability,
                  Purpose, and Volume (STEP-V). Figure 1 provides a compact, stakes-based visual summary
                  of the framework, while Supplementary Materials File S5 presents a more detailed set of
                  illustrative configurations. STEP-V is intended to help researchers and practitioners make
                  more defensible evaluation choices in a structured way, but it should be used to guide and
                  constrain design rather than to prescribe a single universally correct solution.




                                                                                  https://doi.org/10.3390/ai7050174

AI 2026, 7, 174 10 of 22

                  Figure 1. Stakes-based (low, medium, high) overview of the STEP-V framework. The three panels
                  summarize recommended evaluator configurations, acceptable evaluation methods across devel-
                  opment, deployment validation, and monitoring, and escalation logic for low-, medium-, and
                  high-stakes applications. The figure is intended as a compact decision aid that complements the more
                  detailed recommendations in Supplementary Materials File S5.

                  7.1. The STEP-V Dimensions
                       Stakes refers to the consequences of evaluation error. If a false sense of quality could
                  expose users to harm, legal liability, or serious misinformation, the evaluation design should
                  privilege validity, conservative inference, and expert oversight over cost minimization:



                                                                                     https://doi.org/10.3390/ai7050174

AI 2026, 7, 174 11 of 22

                  •   Low-stakes applications include settings where evaluation errors have minimal real-
                      world consequences, such as ranking outputs for a creative writing assistant, selecting
                      between alternative marketing slogans, or tuning a chatbot’s tone for engagement.
                      In these contexts, an incorrect evaluation may degrade user experience or preference
                      alignment, but is unlikely to cause harm, making automated metrics or lightweight
                      human preference judgments acceptable.
                  •   Medium-stakes applications include tasks where evaluation errors can lead to mean-
                      ingful but non-critical consequences, such as summarizing internal business docu-
                      ments, generating educational explanations for general audiences, or assisting with
                      software development (e.g., code suggestions that are reviewed before deployment).
                      Here, incorrect evaluations may reduce efficiency, introduce errors, or mislead users,
                      but are typically mitigated by downstream human oversight. Hybrid evaluation
                      strategies combining automated metrics, LLM-as-judge systems, and periodic human
                      validation may be appropriate for these applications.
                  •   High-stakes applications include domains where evaluation errors could result in
                      significant harm, legal exposure, or safety risks, such as medical advice, clinical de-
                      cision support, legal analysis, financial recommendations, or military planning. In
                      these settings, an incorrect evaluation may falsely certify unsafe or incorrect out-
                      puts as acceptable; evaluation designs should therefore prioritize domain experts,
                      multi-dimensional rubrics, conservative decision thresholds, and explicit handling of
                      uncertainty and disagreement, with automated methods used only as support.
                       Recognizing that resource constraints often conflict with high-stakes requirements,
                  evaluation design should identify a minimum viable validity threshold. When a full expert
                  audit is cost-prohibitive, researchers can leverage a small, high-quality set of expert-vetted
                  labels (approx. 50–100) to calculate a correction factor for a much larger, lower-cost crowd-
                  sourced or LLM-judged dataset [90]. This allows for the calculation of confidence intervals
                  for automated scores, ensuring that borderline cases are flagged for the limited expert time
                  available without compromising the entire pipeline’s integrity [91].
                       Under evaluator scarcity, sample-size planning should be driven by the uncertainty
                  tolerated for the intended decision (i.e., not by a fixed annotation quota). In practice, this
                  often means beginning with a small expert-labeled anchor set large enough to estimate
                  agreement, calibration error, and obvious subgroup or item-level failure modes, and then
                  allocating additional expert effort preferentially to high-risk, borderline, or disagreement-
                  heavy cases. Lower-cost evaluators such as crowdworkers or LLM judges may then be
                  used to extend coverage, but only after benchmarking them against experts.
                       Task-type refers to whether the target output is primarily closed-ended and verifiable
                  or open-ended and subjective.
                  •   Closed-ended tasks include outputs with a clearly defined correct answer or externally
                      verifiable criterion, such as factual question answering (e.g., What is the capital of
                      France?), code generation that must pass unit tests, extraction of structured information
                      from text, or classification tasks with known labels. In these cases, correctness can be
                      evaluated against a reference standard or objective rule, and disagreement is more
                      likely to reflect error than interpretation.
                  •   Open-ended tasks include outputs where multiple responses may be acceptable de-
                      pending on context, goals, or audience, such as drafting an essay, providing medical
                      counseling language, generating legal reasoning, summarizing complex documents,
                      or offering strategic recommendations. Here, evaluation depends on subjective or
                      partially observable constructs (e.g., usefulness, clarity, appropriateness), and disagree-
                      ment may reflect legitimate differences in judgment instead of incorrectness.




                                                                                  https://doi.org/10.3390/ai7050174

AI 2026, 7, 174 12 of 22

                      Evaluator availability captures which pools are realistically accessible: experts, trained
                  annotators, crowdworkers, end users, or judge models.
                  •   Low evaluator availability typically arises in domains requiring specialized expertise,
                      such as board-certified physicians evaluating clinical recommendations, legal experts
                      assessing statutory interpretation, or experienced military leaders assessing opera-
                      tional plans. In these cases, evaluators are scarce, expensive, and time-constrained,
                      which places practical limits on sample size and necessitates careful prioritization of
                      what is evaluated and how.
                  •   Moderate evaluator availability may involve access to trained annotators or smaller,
                      curated participant pools who can apply structured rubrics with some degree of con-
                      sistency. These evaluators can support more nuanced judgments than crowdworkers
                      but are still limited in scalability and domain expertise.
                  •   High evaluator availability may include access to large pools of crowdworkers or end
                      users, enabling scalable evaluation of fluency, relevance, or preference through pair-
                      wise comparisons or rating tasks. In some settings, LLM-as-judge systems may also
                      be readily available, providing low-cost, high-throughput evaluation for structured or
                      well-defined criteria, albeit with the need for calibration.
                      Purpose distinguishes early development, pre-deployment validation, and ongoing
                  production monitoring.
                  •   Early development focuses on rapid iteration and model improvement, where the
                      goal is to identify obvious failure modes and compare alternative model versions.
                      Evaluation at this stage may rely on automated metrics, small-scale human preference
                      tests, or LLM-as-judge systems to provide quick, directional feedback.
                  •   Pre-deployment validation involves a more rigorous assessment before a system is
                      released into real-world use. Here, the goal is to establish that the model meets prede-
                      fined performance, safety, and reliability thresholds for its intended application. This
                      often requires structured human evaluation, domain-specific criteria, reliability report-
                      ing, and testing across diverse scenarios to ensure the system performs adequately
                      under expected conditions.
                  •   Ongoing production monitoring occurs after deployment and focuses on detecting
                      performance drift, emerging failure modes, or changes in user interaction patterns
                      over time. Evaluation at this stage is typically high-volume and continuous, relying
                      on automated monitoring, anomaly detection, and selective human review of flagged
                      or high-risk cases to maintain system quality and safety.
                       Volume refers to the scale and frequency of outputs that must be assessed.
                  •    Low-volume settings may involve evaluating a small number of outputs, such as
                       benchmarking a new model on a curated test set, conducting expert review of clinical
                       decision-support responses, or auditing a limited set of high-stakes cases. In these
                       scenarios, evaluation can be intensive, allowing for detailed rubrics, multiple expert
                       raters, and adjudication processes.
                  •    Moderate-volume settings include situations where outputs are generated regularly
                       but not at a massive scale, such as evaluating weekly batches of generated reports,
                       internal tool outputs, or iterative model updates during development. Here, a combi-
                       nation of sampling strategies, structured human evaluation, and partial automation is
                       often used to balance rigor with efficiency.
                  •    High-volume settings involve continuous or large-scale output generation, such as
                       monitoring millions of chatbot interactions, customer support responses, or real-time
                       recommendation systems. In these contexts, it is infeasible to evaluate every output
                       directly; instead, evaluation relies on automated metrics, statistical sampling, anomaly



                                                                                  https://doi.org/10.3390/ai7050174

AI 2026, 7, 174 13 of 22

                       detection, and escalation pipelines that route a small subset of outputs (e.g., uncertain,
                       high-risk, or outlier cases) to human review.
                       These distinctions are not rigid; in real-world settings, the boundaries between stakes,
                  task-type, evaluator availability, purpose, and volume are often blurred, interdependent,
                  and context-specific. For example, what constitutes high stakes may differ substantially
                  across domains (e.g., healthcare, finance, education), regulatory environments, or user
                  populations, and the same task may shift in stakes depending on how its outputs are used.
                  Similarly, evaluator availability and volume constraints are shaped by organizational re-
                  sources, timelines, and deployment scale. As such, these dimensions should be interpreted
                  as guiding variables that must be characterized by the practitioner within their specific
                  operational, legal, and societal context. The STEP-V framework provides a structured
                  rubric to support evaluation design decisions, but it is not a prescriptive formula that yields
                  a single correct configuration.

                  7.2. Design Logic
                       The framework dimensions interact; high-stakes, open-ended deployment tasks usu-
                  ally require human experts as primary evaluators, potentially supported by automated
                  prescreening. To bridge the gap between high-stakes requirements and low availability of
                  experts, Expert-Guided Auto-Evaluation is recommended. In this hybrid workflow, the ex-
                  pert’s primary role shifts from labeling individual outputs to architecting the measurement
                  instrument, specifically by designing task-specific rubrics and critique prompts that Tier 2
                  LLM judges then execute at scale [92]. Recent diagnostic frameworks such as GER-Eval [93]
                  demonstrate that while LLM-generated rubrics can provide consistent scoring, they require
                  expert grounding to maintain alignment with human clinical or legal standards.
                       Low-stakes, closed-ended development tasks may justify automated metrics or judge
                  models with periodic human calibration. High-volume monitoring settings often require
                  hybrid systems, but those systems should route uncertain, borderline, or high-impact cases
                  to human review; scalable judgment alone is likely insufficient. The framework also makes
                  clear that leveraging humans is not sufficient; which humans, evaluating what, under what
                  rubric, and for what purpose are all essential design questions.
                       A practical implication is that the evidentiary threshold for adopting LLM-as-judge
                  should itself scale with stakes. In low-stakes development settings, moderate agreement
                  with humans, acceptable perturbation stability, and periodic spot-checking may be suf-
                  ficient to justify operational use. In medium-stakes settings, stronger calibration and
                  recurring human audits are warranted, especially when judgments affect deployment
                  decisions or user trust. In high-stakes settings, the burden of proof is substantially higher:
                  LLM-as-judge should generally be limited to assistive roles unless there is unusually strong
                  task-specific evidence that it performs comparably to qualified experts on the relevant
                  construct and failure modes. STEP-V therefore does not treat evaluator substitution as a
                  binary decision, but as a context-sensitive measurement claim that must be justified by
                  the application.

                  7.3. Worked Examples
                       Consider three examples.
                       In a medical advice assistant, the stakes are high, as incorrect evaluation could validate
                  outputs that pose safety risks to patients. The task type is largely open-ended, involving
                  interpretation, explanation, and context-sensitive recommendations (i.e., not strictly ver-
                  ifiable answers). Evaluator availability is typically low, requiring domain experts such
                  as physicians or trained clinicians. The immediate purpose is pre-deployment validation,
                  although ongoing monitoring at moderate-to-high volume is also required after deploy-



                                                                                  https://doi.org/10.3390/ai7050174

AI 2026, 7, 174 14 of 22

                  ment. Under these conditions, STEP-V recommends expert-led, rubric-based evaluation
                  as the primary method, emphasizing clinical correctness, safety, uncertainty communica-
                  tion, and appropriateness. Automated metrics or LLM-based evaluators may be used for
                  pre-screening or triage, but should not serve as primary arbiters. During deployment, high-
                  volume monitoring pipelines should incorporate uncertainty estimation and escalation
                  mechanisms, routing ambiguous or high-risk cases to human experts [6,36]. Disagreement
                  among experts should be preserved and analyzed; ideally, it is not collapsed, as it may
                  reflect clinically meaningful ambiguity.
                        In a consumer writing assistant, the stakes are low to moderate, as evaluation errors
                  primarily affect user satisfaction. The task type is open-ended, with outputs judged on
                  subjective constructs such as clarity, tone, engagement, or creativity. Evaluator availability
                  is high, with access to large pools of end users or crowdworkers. The purpose is typically
                  early-stage development and iterative improvement, with moderate-to-high evaluation
                  volume. In this setting, STEP-V supports pairwise preference testing, user ratings, and
                  LLM-as-judge systems as primary evaluation tools, enabling rapid iteration at scale. Hu-
                  man evaluation may focus on preference alignment and perceived quality, while periodic
                  expert review or targeted audits can be introduced for safety-sensitive or policy-relevant di-
                  mensions [12,33,35]. Here, disagreement is expected and often reflects legitimate variation
                  in user preference instead of evaluation error per se.
                        In a retrieval-based internal enterprise tool answering policy or compliance questions,
                  the stakes are moderate to high, depending on the regulatory or financial implications
                  of incorrect outputs. The task type is more closed-ended or semi-verifiable, as responses
                  should align with known documents or policies. Evaluator availability is moderate, often
                  involving trained internal staff or subject-matter experts, though not necessarily at scale.
                  The purpose includes both pre-deployment validation and ongoing monitoring, with
                  high output volume in deployment. In this configuration, STEP-V supports a hybrid
                  evaluation strategy: automated checks for factual consistency (e.g., retrieval alignment,
                  citation correctness), supplemented by LLM-as-judge systems calibrated against human
                  labels, and periodic human audits of sampled outputs [7,10,28]. High-risk or uncertain
                  cases should be escalated for expert review. Evaluation design should explicitly distinguish
                  between objective correctness (e.g., policy compliance) and subjective qualities (e.g., clarity
                  or usefulness), applying different evaluators and metrics to each.
                        These examples illustrate that evaluation quality depends on the fit between context
                  and design. STEP-V is intended to make that fit more explicit and more reproducible [11,12].

                  7.4. When STEP-V Can Fail
                      STEP-V is a design-support framework, not a guarantee against evaluation error.
                  There are many potential scenarios under which the framework can fail, including:
                  1.   When the construct itself is poorly specified.
                  2.   When available evaluators share the same systematic biases.
                  3.   When high-stakes tasks lack access to minimally sufficient expert oversight.
                  4.   When disagreement is inappropriately collapsed into a single consensus score.
                       In such cases, STEP-V may be helpful for organizing the decision space, but it cannot
                  rescue an evaluation pipeline built on an invalid construct, an inadequate evaluator pool,
                  or a protocol that masks uncertainty.

                  8. Methodological Guidance
                      The literature supports a set of practical recommendations for improving human-centered
                  LLM evaluation and minimal reporting standards (see Supplementary Materials File S3).
                  Evaluation design should begin with explicit operationalization of the target criteria, in-



                                                                                  https://doi.org/10.3390/ai7050174

AI 2026, 7, 174 15 of 22

                  cluding clear definitions, representative examples, and treatment of edge cases. Evaluator
                  selection should then be justified in relation to the construct of interest. Protocols should
                  be structured to minimize known sources of bias through measures such as blinding, ran-
                  domization, calibration, and workload management. Studies should also report reliability
                  statistics and uncertainty estimates alongside average scores, because point estimates alone
                  can create a misleading impression of precision and make results harder to interpret across
                  studies [90,91,94]. In addition, automated metrics and LLM-based evaluators should be cali-
                  brated against human judgments on the target task (i.e., they should not be assumed valid by
                  default). Finally, when human labels are used as reference standards in high-stakes settings,
                  researchers should consider methods that explicitly model annotation imperfection [7,47].
                        Adoption thresholds for LLM-as-judge should be tied to stakes and supported by
                  multiple forms of evidence, not just a single agreement coefficient. For low-stakes applica-
                  tions, LLM-as-judge systems may be used as primary evaluators when they demonstrate
                  acceptable agreement with the target human evaluator population, stability under prompt
                  and formatting perturbations, and no large systematic bias on known failure modes such
                  as verbosity, position, or authority effects. For medium-stakes applications, these systems
                  should additionally be recalibrated against fresh human judgments at regular intervals
                  and used with explicit escalation rules for uncertain, borderline, or disagreement-heavy
                  cases. For high-stakes applications, LLM-as-judge systems should not replace qualified
                  human experts as the primary arbiter; instead, they should be restricted to supportive
                  roles such as prescreening, structured sub-criterion checks, or prioritization of cases for
                  review. In all cases, acceptance should be based on a bundle of evidence: agreement
                  with qualified humans on the target task, robustness to perturbations, bias audits, and
                  uncertainty estimates.
                        Sample-size planning should begin from target uncertainty and evaluator scarcity.
                  When expert evaluators are scarce, researchers should first define the precision required
                  for the intended decision, for example a target confidence interval width for mean ratings,
                  agreement estimates, or calibration errors. A practical strategy is to build a small expert-
                  vetted anchor set, then use that set to calibrate a larger, lower-cost annotation pool, such as
                  trained annotators, crowdworkers, or LLM judges. In high-stakes settings, expert effort
                  should be concentrated on ambiguous, high-risk, or disagreement-prone cases. In high-
                  volume settings, stratified sampling, active sampling, or uncertainty-based escalation can
                  improve efficiency by routing the most informative cases to experts. Where a full expert
                  audit is infeasible, a small but high-quality expert set can still support correction factors
                  and confidence intervals for a larger, lower-cost sample.
                        Evaluation studies should use psychometric models that match the rating protocol
                  and explicitly estimate rater and item effects. For ordinal rubric or Likert-style ratings,
                  hierarchical ordinal models can estimate construct scores while accounting for rater severity,
                  item difficulty, and uncertainty. For structured multi-rater settings, many-facet Rasch
                  models [54] are especially useful because they separate latent performance from rater
                  harshness and item difficulty. For pairwise preference data, Bradley–Terry [55,95] or related
                  Thurstone-style [96] models provide principled estimates of relative quality. In settings
                  where no evaluator should be assumed error-free, latent-class or imperfect-gold-standard
                  models may be preferable to a simple majority vote. The specific model should be selected
                  based on the data structure and construct definition, but the general goal is the same: to
                  avoid treating observed ratings as direct, error-free measurements.
                        Disagreement should be reported and interpreted as a first-class result. In addition
                  to reporting aggregate means or win rates, researchers should present dispersion across
                  raters, subgroup-specific rating distributions, and human-model divergence. For ordinal
                  or categorical judgments, useful summaries include agreement coefficients, confusion



                                                                                  https://doi.org/10.3390/ai7050174

AI 2026, 7, 174 16 of 22

                  patterns, and subgroup-stratified distributions. For distributional alignment between
                  model outputs and human judgments, measures such as Kullback–Leibler divergence [49]
                  and Earth Mover’s Distance [50] can quantify whether a system matches the full spread
                  of human opinion (i.e., versus only its mean). Practically, large disagreement, subgroup
                  divergence, or instability under perturbation should trigger adjudication, protocol review,
                  or targeted expert audit. In subjective or culturally contingent tasks, divergence should
                  not automatically be interpreted as error; it may instead indicate construct ambiguity or
                  legitimate perspectival variation.
                        To increase practical utility, future evaluations should include at least a minimal re-
                  porting standard covering evaluator recruitment, training, task instructions, scale format,
                  session length, adjudication rules, reliability statistics, and uncertainty reporting [8,97].
                  Without such documentation, evaluation results remain difficult to interpret, reproduce,
                  or compare across studies [10,94]. To further improve reproducibility and uptake, practi-
                  cal reporting materials should accompany evaluation studies whenever possible. These
                  materials may include example rubrics, calibration prompts, adjudication rules, audit
                  checklists, and minimal analysis templates for reliability, disagreement, and uncertainty
                  reporting. Even when a study is not primarily methodological, releasing such materials can
                  clarify how constructs were operationalized, how raters were trained, and how borderline
                  or contested cases were handled in practice. An example audit template is provided in
                  Supplementary Materials File S4.

                  9. Limitations and Future Directions
                        The literature on LLM evaluation is moving rapidly, and any synthesis risks near-term
                  obsolescence. STEP-V and the failure-mode taxonomy are conceptual frameworks that
                  require prospective validation. Their value will depend on whether they improve real
                  evaluation design and whether their predictions about bias, disagreement, and hybrid-
                  system performance are borne out empirically.
                        Several research directions follow naturally. One is longitudinal work on how human
                  evaluators change as they gain familiarity with LLM outputs and failure modes. Another
                  is deeper integration with psychometrics, including formal treatment of rater effects, latent
                  constructs, measurement invariance across cultures and evaluator populations, and practi-
                  cal model templates that can be applied to common LLM evaluation datasets. Future work
                  should also operationalize disagreement-aware pipelines more concretely by specifying
                  distributional metrics, visualization standards, subgroup-audit procedures, and escalation
                  rules for cases where human–human or human-model divergence is large. A further need
                  is decision-support tooling for study design, including sample-size and power planning
                  under evaluator scarcity, uncertainty-targeted allocation of expert effort, and practical
                  calculators that translate desired precision into annotation requirements under different
                  STEP-V configurations. Finally, field-wide progress would benefit from stronger reporting
                  norms, shared evaluation methods, and benchmark ecosystems that preserve contextual
                  richness while maintaining enough standardization to support comparison across studies.
                        An additional future direction is to operationalize STEP-V as a semi-quantitative
                  decision tool. Each dimension could be assigned ordinal levels and linked to predicted
                  risk outputs such as construct validity threat, inter-rater reliability risk, shared-bias am-
                  plification, review cost, and escalation burden. With prospective benchmarking across
                  tasks, these mappings could eventually support bounded error estimates or confidence
                  intervals for candidate evaluation designs. At present, however, STEP-V is best inter-
                  preted as a conceptual framework whose quantitative instantiation remains an empirical
                  research agenda.




                                                                                 https://doi.org/10.3390/ai7050174

AI 2026, 7, 174 17 of 22

                  10. Conclusions
                       Evaluating LLMs has reached a critical bottleneck: while model capabilities continue
                  to scale exponentially, frameworks for judging those capabilities remain somewhat frag-
                  mented and under-theorized. Human evaluation is not only a ground truth to be reached,
                  but a measurement infrastructure that must be engineered with the same precision as the
                  models themselves.
                       Through the proposed STEP-V framework, a roadmap is provided to help align
                  evaluation strategies with the frictions of real-world constraints. Whether in the high-
                  stakes corridors of healthcare or the creative playground of writing assistants, the choice
                  of who evaluates and how they are prompted determines the validity of the resulting
                  data. Furthermore, the failure mode taxonomy warns against the uncritical adoption of
                  hybrid AI-human pipelines, showing that without careful calibration, there is a risk of
                  compounding rather than mitigating bias. As LLMs become more like humans in their
                  outputs, the rigor with which they are evaluated must become more scientific and guided
                  by the established theories, tools, and techniques of the cognitive sciences, psychometrics,
                  and human factors engineering.

                  Supplementary Materials: The following supporting information can be downloaded at https://
                  www.mdpi.com/article/10.3390/ai7050174/s1, File S1. Illustrative Scoring Rubrics; File S2. Example
                  Calibration Prompts; File S3. Example Reporting Template; File S4. Example Audit Checklist; File S5.
                  STEP-V Illustrative Configurations.

                  Funding: This work was supported by the U.S. Army DEVCOM Soldier Center under the Augmented
                  Decisions via Intelligent Systems Recommendations (ADVISR) program (BC1/3D).

                  Institutional Review Board Statement: Not applicable.

                  Informed Consent Statement: Not applicable.

                  Data Availability Statement: Not applicable.

                  Conflicts of Interest: The author declares no conflicts of interest. The opinions or assertions contained
                  herein are the private views of the author and are not to be construed as official or reflecting the
                  views, policies, or positions of the United States Army or the United States Department of War. Any
                  citations of commercial organizations and trade names in this report do not constitute an official
                  Department of the Army endorsement or approval of the products or services of these organizations.

                  Abbreviations
                  The following abbreviations are used in this manuscript:

                  AI           Artificial Intelligence
                  NLP          Natural Language Processing
                  LLM          Large Language Model
                  IRR          Inter-Rater Reliability
                  BLEU         Bilingual Evaluation Understudy
                  ROUGE        Recall-Oriented Understudy for Gisting Evaluation
                  METEOR       Metric for Evaluation of Translation with Explicit Ordering
                  BERT         Bidirectional Encoder Representations from Transformers
                  STEP-V       Stakes, Task-type, Evaluator availability, Purpose, Volume
                  CoT          Chain-of-Thought
                  RLHF         Reinforcement Learning from Human Feedback
                  SxS          Side-by-Side (comparison)
                  ELO          Elo Rating System




                                                                                         https://doi.org/10.3390/ai7050174

AI 2026, 7, 174 18 of 22

References 1. Annepaka, Y.; Pakray, P. Large Language Models: A Survey
of Their Development, Capabilities, and Applications. Knowl. Inf. Syst.
2025, 67, 2967--3022. \[CrossRef\] 2. Minaee, S.; Mikolov, T.; Nikzad,
N.; Chenaghlu, M.; Socher, R.; Amatriain, X.; Gao, J. Large Language
Models: A Survey. arXiv 2025, arXiv:2402.06196. 3. Luo, J.; Wu, B.; Luo,
X.; Xiao, Z.; Jin, Y.; Tu, R.-C.; Yin, N.; Wang, Y.; Yuan, J.; Ju, W.;
et al. A Survey on Efficient Large Language Model Training: From
Data-Centric Perspectives. In Proceedings of the 63rd Annual Meeting of
the Association for Computational Linguistics (Volume 1: Long Papers),
Vienna, Austria, 27 July--1 August 2025; Che, W., Nabende, J., Shutova,
E., Pilehvar, M.T., Eds.; Association for Computational Linguistics:
Stroudsburg, PA, USA, 2025; pp. 30904--30920. 4. Bohnet, B.; Dangovski,
R.; Swersky, K.; Moore, S.; Chaudhry, A.; Kenealy, K.; Fiedel, N. A
Comparative Analysis of LLM Adaptation: SFT, LoRA, and ICL in
Data-Scarce Scenarios. arXiv 2025, arXiv:2511.00130. 5. Celikyilmaz, A.;
Clark, E.; Gao, J. Evaluation of Text Generation: A Survey. arXiv 2020,
arXiv:2006.14799. 6. Awasthi, R.; Bhattad, A.; Ramachandran, S.P.;
Mishra, S.; Khanna, A.K.; Cywinski, J.B.; Maheshwari, K.; Mahapatra, D.;
DiRosa, I.; Cohen, A.; et al. Human Evaluation of Large Language Models
in Healthcare: Gaps, Challenges, and the Need for Standardization. npj
Health Syst. 2025, 2, 40. \[CrossRef\] 7. Gu, J.; Jiang, X.; Shi, Z.;
Tan, H.; Zhai, X.; Xu, C.; Li, W.; Shen, Y.; Ma, S.; Liu, H.; et al. A
Survey on LLM-as-a-Judge. Innovation 2026. \[CrossRef\] 8. Belz, A.;
Thompson, C.; Reiter, E.; Mille, S. Non-Repeatable Experiments and
Non-Reproducible Results: The Reproducibility Crisis in Human Evaluation
in NLP. In Proceedings of the Findings of the Association for
Computational Linguistics, Toronto, ON, Canada, 9--14 July 2023;
Association for Computational Linguistics: Stroudsburg, PA, USA, 2023;
pp. 3676--3687. 9. Schmidtová, P.; Calò, E.; Balloccu, S.; Gkatzia, D.;
Huidrom, R.; Lango, M.; Same, F.; Zouhar, V.; Mahamood, S.; Dušek, O. Do
My Eyes Deceive Me? A Survey of Human Evaluations of Hallucinations in
NLG; Association for Computational Linguistics (ACL): Stroudsburg, PA,
USA, 2025; pp. 60--79. 10. Elangovan, A.; Liu, L.; Xu, L.; Bodapati,
S.B.; Roth, D. Considers-the-Human Evaluation Framework: Rethinking
Human Evaluation for Generative Large Language Models. In Proceedings of
the 62nd Annual Meeting of the Association for Computational Linguistics
(Volume 1: Long Papers), Bangkok, Thailand, 11--16 August 2024;
Association for Computational Linguistics: Stroudsburg, PA, USA, 2024;
pp. 1137--1160. 11. Serapio-García, G.; Safdari, M.; Crepy, C.; Sun, L.;
Fitz, S.; Romero, P.; Matarić, M. A Psychometric Framework for
Evaluating and Shaping Personality Traits in Large Language Models. Nat.
Mach. Intell. 2025, 7, 1954--1968. \[CrossRef\] 12. van der Lee, C.;
Gatt, A.; van Miltenburg, E.; Wubben, S.; Krahmer, E. Best Practices for
the Human Evaluation of Automatically Generated Text. In Proceedings of
the 12th International Conference on Natural Language Generation, Tokyo,
Japan, 29 October--1 November 2019; Association for Computational
Linguistics: Stroudsburg, PA, USA, 2019; pp. 355--368. 13. Gehman, S.;
Gururangan, S.; Sap, M.; Choi, Y.; Smith, N.A. RealToxicityPrompts:
Evaluating Neural Toxic Degeneration in Language Models. In Proceedings
of the Findings of the Association for Computational Linguistics: EMNLP
2020; Cohn, T., He, Y., Liu, Y., Eds.; Association for Computational
Linguistics: Stroudsburg, PA, USA, 2020; pp. 3356--3369. 14. Liu, Y.;
Iter, D.; Xu, Y.; Wang, S.; Xu, R.; Zhu, C. G-Eval: NLG Evaluation Using
Gpt-4 with Better Human Alignment. In Proceedings of the 2023 Conference
on Empirical Methods in Natural Language Processing; Bouamor, H., Pino,
J., Bali, K., Eds.; Association for Computational Linguistics:
Stroudsburg, PA, USA, 2023; pp. 2511--2522. 15. Ouyang, L.; Wu, J.;
Jiang, X.; Almeida, D.; Wainwright, C.; Mishkin, P.; Zhang, C.; Agarwal,
S.; Slama, K.; Ray, A.; et al. Training Language Models to Follow
Instructions with Human Feedback. In Proceedings of the Advances in
Neural Information Processing Systems; Curran Associates, Inc.: New
York, NY, USA, 2022; Volume 35, pp. 27730--27744. 16. Zheng, L.; Chiang,
W.-L.; Sheng, Y.; Zhuang, S.; Wu, Z.; Zhuang, Y.; Lin, Z.; Li, Z.; Li,
D.; Xing, E.; et al. Judging LLM-as-a-Judge with MT-Bench and Chatbot
Arena. Adv. Neural Inf. Process. Syst. 2023, 36, 46595--46623. 17. Wang,
P.; Li, L.; Chen, L.; Cai, Z.; Zhu, D.; Lin, B.; Cao, Y.; Kong, L.; Liu,
Q.; Liu, T.; et al. Large Language Models Are Not Fair Evaluators. In
Proceedings of the 62nd Annual Meeting of the Association for
Computational Linguistics (Volume 1: Long Papers); Ku, L.-W., Martins,
A., Srikumar, V., Eds.; Association for Computational Linguistics:
Stroudsburg, PA, USA, 2024; pp. 9440--9450. 18. Fu, X.; Liu, W. How
Reliable Is Multilingual LLM-as-a-Judge? arXiv 2025, arXiv:2505.12201.
\[CrossRef\] 19. Bavaresco, A.; Bernardi, R.; Bertolazzi, L.; Elliott,
D.; Fernández, R.; Gatt, A.; Ghaleb, E.; Giulianelli, M.; Hanna, M.;
Koller, A.; et al. LLMs Instead of Human Judges? A Large Scale Empirical
Study Across 20 NLP Evaluation Tasks. In Proceedings of the 63rd Annual
Meeting of the Association for Computational Linguistics (Volume 2:
Short Papers); Association for Computational Linguistics: Stroudsburg,
PA, USA, 2025; pp. 238--255. 20. Calderon, N.; Reichart, R.; Dror, R.
The Alternative Annotator Test for LLM-as-a-Judge: How to Statistically
Justify Replacing Human Annotators with LLMs. In Proceedings of the 63rd
Annual Meeting of the Association for Computational Linguistics (Volume
1: Long Papers); Association for Computational Linguistics: Stroudsburg,
PA, USA, 2025; pp. 16051--16081.

                                                                                                           https://doi.org/10.3390/ai7050174

AI 2026, 7, 174 19 of 22

21. Waikar, S.S.; Betensky, R.A.; Emerson, S.C.; Bonventre, J.V.
    Imperfect Gold Standards for Biomarker Evaluation. Clin. Trials
    2013, 10, 696--700. \[CrossRef\]

22. Xu, Q.; Walder, C.; Xu, C. Humanly Certifying Superhuman
    Classifiers. arXiv 2021, arXiv:2109.07867. \[CrossRef\]

23. Weber-Genzel, L.; Peng, S.; De Marneffe, M.-C.; Plank, B. VariErr
    NLI: Separating Annotation Error from Human Label Variation. In
    Proceedings of the 62nd Annual Meeting of the Association for
    Computational Linguistics (Volume 1: Long Papers); Association for
    Computational Linguistics: Stroudsburg, PA, USA, 2024;
    pp. 2256--2269.

24. Croxford, E.; Gao, Y.; Pellegrino, N.; Wong, K.; Wills, G.; First,
    E.; Liao, F.; Goswami, C.; Patterson, B.; Afshar, M. Current and
    Future State of Evaluation of Large Language Models for Medical
    Summarization Tasks. npj Health Syst. 2025, 2, 6. \[CrossRef\]

25. Kratzke, N.; Beuter, N.; Drews, A.; Janneck, M. PSYCH---Psychometric
    Assessment of Large Language Model Characters: An Exploration of the
    German Language. Analytics 2026, 5, 5. \[CrossRef\]

26. Jing, F.; Zhang, Y.; Gao, M.; Zhang, X.; Zhou, H. A Review of
    Federated Large Language Models for Industry 4.0. Sensors 2026,
    26, 1116. \[CrossRef\]

27. Larraz, R. The Convergence of Artificial Intelligence and Industrial
    Transformation. In Prompt Engineering and the Transformation of
    Petroleum Refining: From Historical Innovation to Net Zero Systems;
    Larraz, R., Ed.; Springer Nature: Cham, Switzerland, 2026; pp. 1--9.
    ISBN 978-3-031-99728-0.

28. Gao, Y.; Xiong, Y.; Gao, X.; Jia, K.; Pan, J.; Bi, Y.; Dai, Y.; Sun,
    J.; Wang, M.; Wang, H. Retrieval-Augmented Generation for Large
    Language Models: A Survey. arXiv 2024, arXiv:2312.10997.

29. Chen, A.; Stanovsky, G.; Singh, S.; Gardner, M. Evaluating Question
    Answering Evaluation. In Proceedings of the 2nd Workshop on Machine
    Reading for Question Answering; Fisch, A., Talmor, A., Jia, R., Seo,
    M., Choi, E., Chen, D., Eds.; Association for Computational
    Linguistics: Stroudsburg, PA, USA, 2019; pp. 119--124.

30. Zhang, T.; Kishore, V.; Wu, F.; Weinberger, K.Q.; Artzi, Y.
    BERTScore: Evaluating Text Generation with BERT. In Proceedings of
    the International Conference on Learning Representations, Addis
    Ababa, Ethiopia, 26 April--1 May 2020.

31. Zhou, C.; Liu, P.; Xu, P.; Iyer, S.; Sun, J.; Mao, Y.; Ma, X.;
    Efrat, A.; Yu, P.; Yu, L.; et al. LIMA: Less Is More for Alignment.
    Adv. Neural Inf. Process. Syst. 2023, 36, 55006--55021.

32. Huang, L.; Yu, W.; Ma, W.; Zhong, W.; Feng, Z.; Wang, H.; Chen, Q.;
    Peng, W.; Feng, X.; Qin, B.; et al. A Survey on Hallucination in
    Large Language Models: Principles, Taxonomy, Challenges, and Open
    Questions. ACM Trans. Inf. Syst. 2025, 43, 42. \[CrossRef\]

33. Howcroft, D.M.; Belz, A.; Clinciu, M.; Gkatzia, D.; Hasan, S.A.;
    Mahamood, S.; Rieser, V. Twenty Years of Confusion in Human
    Evaluation: NLG Needs Evaluation Sheets and Standardised
    Definitions. In Proceedings of the 13th International Conference on
    Natural Language Generation; Association for Computational
    Linguistics: Stroudsburg, PA, USA, 2020; pp. 169--182.

34. Singhal, K.; Azizi, S.; Tu, T.; Mahdavi, S.S.; Wei, J.; Chung, H.W.;
    Scales, N.; Tanwani, A.; Cole-Lewis, H.; Pfohl, S.; et al. Large
    Language Models Encode Clinical Knowledge. Nature 2023, 620,
    172--180. \[CrossRef\] \[PubMed\]

35. Reiter, E. Types of NLG Evaluation: Which Is Right for Me? Available
    online: https://ehudreiter.com/2017/01/19/types-of-nlg- evaluation/
    (accessed on 12 February 2026).

36. Tam, T.Y.C.; Sivarajkumar, S.; Kapoor, S.; Stolyar, A.V.; Polanska,
    K.; McCarthy, K.R.; Osterhoudt, H.; Wu, X.; Visweswaran, S.; Fu, S.;
    et al. A Framework for Human Evaluation of Large Language Models in
    Healthcare Derived from Literature Review. npj Digit. Med. 2024,
    7, 258. \[CrossRef\] \[PubMed\]

37. Klie, J.-C.; Eckart de Castilho, R.; Gurevych, I. Analyzing Dataset
    Annotation Quality Management in the Wild. Comput. Linguist. 2024,
    50, 817--866. \[CrossRef\]

38. Lee, J.; Hockenmaier, J. Evaluating Step-by-Step Reasoning Traces: A
    Survey. In Proceedings of the 2025 Conference on Empirical Methods
    in Natural Language Processing (EMNLP 2025); Association for
    Computational Linguistics: Stroudsburg, PA, USA, 2025.

39. Bhambri, S.; Biswas, U.; Kambhampati, S. Do Cognitively
    Interpretable Reasoning Traces Improve LLM Performance? arXiv 2025,
    arXiv:2508.16695. \[CrossRef\]

40. Brookhart, S.M. Appropriate Criteria: Key to Effective Rubrics.
    Front. Educ. 2018, 3, 22. \[CrossRef\]

41. Jamieson, S. Likert Scales: How to (Ab)Use Them. Med. Educ. 2004,
    38, 1217--1218. \[CrossRef\]

42. Tourangeau, R.; Rips, L.J.; Rasinski, K. The Psychology of Survey
    Response; Cambridge University Press: Cambridge, UK, 2000; ISBN
    978-0-521-57629-1.

43. Fleiss, J.L.; Levin, B.; Paik, M.C. Statistical Methods for Rates
    and Proportions; John Wiley & Sons: Oxford, UK, 2003; ISBN
    0-471-52629-0.

44. Fleisig, E.; Blodgett, S.L.; Klein, D.; Talat, Z. The Perspectivist
    Paradigm Shift: Assumptions and Challenges of Capturing Human
    Labels. In Proceedings of the 2024 Conference of the North American
    Chapter of the Association for Computational Linguistics: Human
    Language Technologies (Volume 1: Long Papers); Duh, K., Gomez, H.,
    Bethard, S., Eds.; Association for Computational Linguistics:
    Stroudsburg, PA, USA, 2024; pp. 2279--2292.

45. Goto, T.; Sakai, Y.; Watanabe, T. Rethinking Evaluation Metrics for
    Grammatical Error Correction: Why Use a Different Evaluation Process
    than Human? In Proceedings of the 63rd Annual Meeting of the
    Association for Computational Linguistics (Volume 2: Short Papers);
    Che, W., Nabende, J., Shutova, E., Pilehvar, M.T., Eds.; Association
    for Computational Linguistics: Stroudsburg, PA, USA, 2025;
    pp. 1165--1172.

                                                                                                            https://doi.org/10.3390/ai7050174

    AI 2026, 7, 174 20 of 22

46. Mohankumar, A.K.; Khapra, M. Active Evaluation: Efficient NLG
    Evaluation with Few Pairwise Comparisons. In Proceedings of the 60th
    Annual Meeting of the Association for Computational Linguistics
    (Volume 1: Long Papers); Muresan, S., Nakov, P., Villavicencio, A.,
    Eds.; Association for Computational Linguistics: Stroudsburg, PA,
    USA, 2022; pp. 8761--8781.

47. Artstein, R.; Poesio, M. Inter-Coder Agreement for Computational
    Linguistics. Comput. Linguist. 2008, 34, 555--596. \[CrossRef\]

48. Passonneau, R.J. Measuring Agreement on Set-Valued Items (MASI) for
    Semantic and Pragmatic Annotation. In Proceedings of the Fifth
    International Conference on Language Resources and Evaluation (LREC
    2006); European Language Resources Association: Luxembourg, 2006;
    pp. 831--836.

49. Kullback, S.; Leibler, R.A. On Information and Sufficiency. Ann.
    Math. Stat. 1951, 22, 79--86. \[CrossRef\]

50. Rubner, Y.; Tomasi, C.; Guibas, L.J. A Metric for Distributions with
    Applications to Image Databases. In Proceedings of the Sixth
    International Conference on Computer Vision; IEEE: New York, NY,
    USA, 1998; pp. 59--66.

51. Orlikowski, M.; Pei, J.; Röttger, P.; Cimiano, P.; Jurgens, D.;
    Hovy, D. Beyond Demographics: Fine-Tuning Large Language Models to
    Predict Individuals' Subjective Text Perceptions. In Proceedings of
    the 63rd Annual Meeting of the Association for Computational
    Linguistics (Volume 1: Long Papers); Che, W., Nabende, J., Shutova,
    E., Pilehvar, M.T., Eds.; Association for Computational Linguistics:
    Stroudsburg, PA, USA, 2025; pp. 2092--2111.

52. Xu, Y.; Jurgens, D. Beyond Consensus: Perspectivist Modeling and
    Evaluation of Annotator Disagreement in NLP. arXiv 2026,
    arXiv:2601.09065. \[CrossRef\]

53. Brunyé, T.T.; Balla, A.; Drew, T.; Elmore, J.G.; Kerr, K.F.;
    Shucard, H.; Weaver, D.L. From Image to Diagnosis: Characterizing
    Sources of Error in Histopathologic Interpretation. Mod. Pathol.
    2023, 36, 100162. \[CrossRef\]

54. Myford, C.M.; Wolfe, E.W. Detecting and Measuring Rater Effects
    Using Many-Facet Rasch Measurement: Part I. J. Appl. Meas. 2003, 4,
    386--422.

55. Bradley, R.A.; Terry, M.E. Rank Analysis of Incomplete Block
    Designs: I. The Method of Paired Comparisons. Biometrika 1952, 39,
    324--345. \[CrossRef\]

56. Shi, L.; Ma, C.; Liang, W.; Diao, X.; Ma, W.; Vosoughi, S. Judging
    the Judges: A Systematic Study of Position Bias in LLM-as-a-Judge.
    arXiv 2025. \[CrossRef\]

57. Tversky, A.; Kahneman, D. Judgment under Uncertainty: Heuristics and
    Biases. Biases in Judgments Reveal Some Heuristics of Thinking under
    Uncertainty. Science 1974, 185, 1124--1131. \[CrossRef\]

58. Krippendorff, K. Content Analysis: An Introduction to Its
    Methodology; SAGE Publications: Thousand Oaks, CA, USA, 2018; ISBN
    978-1-5063-9567-8.

59. Hogarth, R.M.; Einhorn, H.J. Order Effects in Belief Updating: The
    Belief-Adjustment Model. Cogn. Psychol. 1992, 24, 1--55.
    \[CrossRef\]

60. Chaiken, S. Heuristic versus Systematic Information Processing and
    the Use of Source versus Message Cues in Persuasion. J. Personal.
    Soc. Psychol. 1980, 39, 752--766. \[CrossRef\]

61. Petty, R.E.; Briñol, P. The Elaboration Likelihood and Metacognitive
    Models of Attitudes: Implications for Prejudice, the Self, and
    Beyond. In Dual-Process Theories of the Social Mind; The Guilford
    Press: New York, NY, USA, 2014; pp. 172--187; ISBN
    978-1-4625-1439-7.

62. Oppenheimer, D.M. Consequences of Erudite Vernacular Utilized
    Irrespective of Necessity: Problems with Using Long Words
    Needlessly. Appl. Cogn. Psychol. 2006, 20, 139--156. \[CrossRef\]

63. Asch, S.E. Effects of Group Pressure upon the Modification and
    Distortion of Judgments. In Groups, Leadership and Men; Research in
    Human Relations; Carnegie Press: Oxford, UK, 1951; pp. 177--190.

64. Cialdini, R.B.; Goldstein, N.J. Social Influence: Compliance and
    Conformity. Annu. Rev. Psychol. 2004, 55, 591--621. \[CrossRef\]

65. Griffin, D.; Tversky, A. The Weighing of Evidence and the
    Determinants of Confidence. Cogn. Psychol. 1992, 24, 411--435.
    \[CrossRef\]

66. Moore, D.A.; Healy, P.J. The Trouble with Overconfidence. Psychol.
    Rev. 2008, 115, 502--517. \[CrossRef\] \[PubMed\]

67. Jiang, Z.; Araki, J.; Ding, H.; Neubig, G. How Can We Know When
    Language Models Know? On the Calibration of Language Models for
    Question Answering. Trans. Assoc. Comput. Linguist. 2021, 9,
    962--977. \[CrossRef\]

68. Xiong, M.; Hu, Z.; Lu, X.; Li, Y.; Fu, J.; He, J.; Hooi, B. Can LLMs
    Express Their Uncertainty? An Empirical Evaluation of Confidence
    Elicitation in LLMs. arXiv 2024, arXiv:2306.13063. \[CrossRef\]

69. Boksem, M.A.S.; Meijman, T.F.; Lorist, M.M. Effects of Mental
    Fatigue on Attention: An ERP Study. Cogn. Brain Res. 2005, 25,
    107--116. \[CrossRef\]

70. Hopstaken, J.F.; van der Linden, D.; Bakker, A.B.; Kompier, M.A.J.;
    Leung, Y.K. Shifts in Attention during Mental Fatigue: Evidence from
    Subjective, Behavioral, Physiological, and Eye-Tracking Data. J.
    Exp. Psychol. Hum. Percept. Perform. 2016, 42, 878--889.
    \[CrossRef\]

71. Vinay, V. Failure Modes in LLM Systems: A System-Level Taxonomy for
    Reliable AI Applications. arXiv 2025, arXiv:2511.19933. \[CrossRef\]

                                                                                                         https://doi.org/10.3390/ai7050174

    AI 2026, 7, 174 21 of 22

72. Chi, M.T.H.; Feltovich, P.J.; Glaser, R. Categorization and
    Representation of Physics Problems by Experts and Novices. Cogn.
    Sci. 1981, 5, 121--152. \[CrossRef\] \[PubMed\]

73. Nourani, M.; King, J.T.; Ragan, E.D. The Role of Domain Expertise in
    User Trust and the Impact of First Impressions with Intelligent
    Systems. In Proceedings of AAAI Conference on Human Computation and
    Crowdsourcing (HCOMP); Association for the Advancement of Artificial
    Intelligence (AAAI): Washington, DC, USA, 2020.

74. Mallen, A.; Asai, A.; Zhong, V.; Das, R.; Khashabi, D.;
    Hajishirzi, H. When Not to Trust Language Models: Investigating
    Effectiveness of Parametric and Non-Parametric Memories. In
    Proceedings of the 61st Annual Meeting of the Association for
    Computational Linguistics (Volume 1: Long Papers); Rogers, A.,
    Boyd-Graber, J., Okazaki, N., Eds.; Association for Computational
    Linguistics: Stroudsburg, PA, USA, 2023; pp. 9802--9822.

75. Henrich, J.; Heine, S.J.; Norenzayan, A. The Weirdest People in the
    World? Behav. Brain Sci. 2010, 33, 61--83. \[CrossRef\]

76. Markus, H.R.; Kitayama, S. Culture and the Self: Implications for
    Cognition, Emotion, and Motivation. In College Student Development
    and Academic Life; Routledge: Oxfordshire, UK, 1998.

77. Bender, E.M.; Gebru, T.; McMillan-Major, A.; Shmitchell, S. On the
    Dangers of Stochastic Parrots: Can Language Models Be Too Big? In
    Proceedings of the 2021 ACM Conference on Fairness, Accountability,
    and Transparency; Association for Computing Machinery: New York, NY,
    USA, 2021; pp. 610--623.

78. Bommasani, R.; Hudson, D.A.; Adeli, E.; Altman, R.; Arora, S.; von
    Arx, S.; Bernstein, M.S.; Bohg, J.; Bosselut, A.; Brunskill, E.; et
    al. On the Opportunities and Risks of Foundation Models. arXiv 2022,
    arXiv:2108.07258.

79. DePaulo, B.M.; Lindsay, J.J.; Malone, B.E.; Muhlenbruck, L.;
    Charlton, K.; Cooper, H. Cues to Deception. Psychol. Bull. 2003,
    129, 74--118. \[CrossRef\]

80. Pennycook, G.; Rand, D.G. Lazy, Not Biased: Susceptibility to
    Partisan Fake News Is Better Explained by Lack of Reasoning than by
    Motivated Reasoning. Cognition 2019, 188, 39--50. \[CrossRef\]

81. Sendak, M.P.; D'Arcy, J.; Kashyap, S.; Gao, M.; Nichols, M.; Corey,
    K.; Ratliff, W.; Balu, S. A Path for Translation of Machine Learning
    Products into Healthcare Delivery. EMJ Innov. 2020, 10, 19--00172.
    \[CrossRef\]

82. Hernandez-Boussard, T.; Bozkurt, S.; Ioannidis, J.P.A.; Shah, N.H.
    MINIMAR (MINimum Information for Medical AI Reporting): Developing
    Reporting Standards for Artificial Intelligence in Health Care. J.
    Am. Med. Inform. Assoc. 2020, 27, 2011--2015. \[CrossRef\]
    \[PubMed\]

83. Wiens, J.; Saria, S.; Sendak, M.; Ghassemi, M.; Liu, V.X.;
    Doshi-Velez, F.; Jung, K.; Heller, K.; Kale, D.; Saeed, M.; et
    al. Do No Harm: A Roadmap for Responsible Machine Learning for
    Health Care. Nat. Med. 2019, 25, 1337--1340. \[CrossRef\]

84. Rajpurkar, P.; Chen, E.; Banerjee, O.; Topol, E.J. AI in Health and
    Medicine. Nat. Med. 2022, 28, 31--38. \[CrossRef\] \[PubMed\]

85. Brunyé, T.T.; Mitroff, S.R.; Elmore, J.G. Artificial Intelligence
    and Computer-Aided Diagnosis in Diagnostic Decisions: 5 Questions
    for Medical Informatics and Human-Computer Interface Research. J.
    Am. Med. Inform. Assoc. 2026, 33, 543--550. \[CrossRef\]

86. Dahl, M.; Magesh, V.; Suzgun, M.; Ho, D.E. Large Legal Fictions:
    Profiling Legal Hallucinations in Large Language Models. J. Leg.
    Anal. 2024, 16, 64. \[CrossRef\]

87. Hu, Y.; Liu, H.; Wang, C.; Li, K.; Wu, T.-H.; Li, H.; Xu, X.; Huo,
    S.; Su, W.; Zheng, N.; et al. Evaluation of Large Language Models in
    Legal Applications: Challenges, Methods, and Future Directions.
    arXiv 2026, arXiv:2601.15267. \[CrossRef\]

88. Magesh, V.; Surani, F.; Dahl, M.; Suzgun, M.; Manning, C.D.; Ho,
    D.E. Hallucination-Free? Assessing the Reliability of Leading AI
    Legal Research Tools. J. Empir. Leg. Stud. 2025, 22, 216--242.
    \[CrossRef\]

89. Vongpradit, P.; Imsombut, A.; Kongyoung, S.; Damrongrat, C.;
    Phaholphinyo, S.; Tanawong, T. SafeCultural: A Dataset for
    Evaluating Safety and Cultural Sensitivity in Large Language Models.
    In Proceedings of the 2024 8th International Conference on
    Information Technology (InCIT); IEEE: New York, NY, USA, 2024;
    pp. 740--745.

90. Gligoric, K.; Zrnic, T.; Lee, C.; Candes, E.; Jurafsky, D. Can
    Unconfident LLM Annotations Be Used for Confident Conclusions? In
    Proceedings of the 2025 Conference of the Nations of the Americas
    Chapter of the Association for Computational Linguistics: Human
    Language Technologies (Volume 1: Long Papers); Chiruzzo, L., Ritter,
    A., Wang, L., Eds.; Association for Computational Linguistics:
    Stroudsburg, PA, USA, 2025; pp. 3514--3533.

91. Meister, N.; Guestrin, C.; Hashimoto, T. Benchmarking Distributional
    Alignment of Large Language Models. In Proceedings of the 2025
    Conference of the Nations of the Americas Chapter of the Association
    for Computational Linguistics: Human Language Technologies (Volume
    1: Long Papers); Chiruzzo, L., Ritter, A., Wang, L., Eds.;
    Association for Computational Linguistics: Stroudsburg, PA, USA,
    2025; pp. 24--49.

92. Bommasani, R.; Liang, P.; Lee, T. Holistic Evaluation of Language
    Models. Ann. N. Y. Acad. Sci. 2023, 1525, 140--146. \[CrossRef\]

93. Siro, C.; Aliannejadi, P.; Aliannejadi, M. Learning to Judge: LLMs
    Designing and Applying Evaluation Rubrics. In Proceedings of the
    Findings of the Association for Computational Linguistics: EACL
    2026; Demberg, V., Inui, K., Marquez, L., Eds.; Association for
    Computational Linguistics: Stroudsburg, PA, USA, 2026;
    pp. 6371--6389.

94. Hashimoto, T.B.; Zhang, H.; Liang, P. Unifying Human and Statistical
    Evaluation for Natural Language Generation. In Proceedings of the
    2019 Conference of the North American Chapter of the Association for
    Computational Linguistics: Human Language Technologies, Volume 1
    (Long and Short Papers); Association for Computational Linguistics:
    Stroudsburg, PA, USA, 2019; pp. 1689--1701.

                                                                                                      https://doi.org/10.3390/ai7050174

    AI 2026, 7, 174 22 of 22

95. Davidson, R.R. On Extending the Bradley-Terry Model to Accommodate
    Ties in Paired Comparison Experiments. J. Am. Stat. Assoc. 1970, 65,
    317--328. \[CrossRef\]

96. Thurstone, L.L. A Law of Comparative Judgment. In Scaling;
    Routledge: Oxfordshire, UK, 1974.

97. Belz, A.; Thomson, C. HEDS 3.0: The Human Evaluation Data Sheet
    Version 3.0. In Proceedings of the Fourth Workshop on Generation,
    Evaluation and Metrics (GEM2 ); Arviv, O., Clinciu, M., Dhole, K.,
    Dror, R., Gehrmann, S., Habba, E., Itzhak, I., Mille, S., Perlitz,
    Y., Santus, E., et al., Eds.; Association for Computational
    Linguistics: Stroudsburg, PA, USA, 2025; pp. 60--81.

Disclaimer/Publisher's Note: The statements, opinions and data contained
in all publications are solely those of the individual author(s) and
contributor(s) and not of MDPI and/or the editor(s). MDPI and/or the
editor(s) disclaim responsibility for any injury to people or property
resulting from any ideas, methods, instructions or products referred to
in the content.

                                                                                                            https://doi.org/10.3390/ai7050174


