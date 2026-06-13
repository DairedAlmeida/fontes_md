# Abstract do artigo: 38-Deep Learning Based Identification of Inconsistent Method Names

**Arquivo original:** 

## Abstract

Abstract For any software system, concise and meaningful method names
are critical for program comprehension and maintenance. However, for various
reasons, the method names might be inconsistent with their corresponding implementations. Such inconsistent method names are confusing and misleading,
often resulting in incorrect method invocations. To this end, a few intelligent
deep learning-based approaches based on neural networks have been proposed
to identify such inconsistent method names in the industry. Existing evaluations suggest that the performance of such DL-based approaches is promising.
However, the evaluations are conducted with a perfectly balanced dataset
where the number of inconsistent method names is exactly equivalent to that of
consistent ones. In addition, the construction method of this balanced dataset
is flawed, leading to false positives in this dataset. Consequently, the reported
performance may not represent their efficiency in the field where most method
names are consistent with their corresponding method bodies and only a small
part of method names are inconsistent with corresponding method bodies. To
this end, in this paper, we conduct an empirical study to assess the state-ofthe-art DL-based approaches in the automated identification of inconsistent
method names. We first build a new benchmark (dataset) by using both automatic identification from commit history and manual inspection by developers,
aiming to reduce the number of false positives. Based on the benchmark, we
evaluate five representative DL-based approaches to identifying inconsistent
Yuxia Zhang
E-mail: yuxiazh@bit.edu.cn
Hui Liu
E-mail: liuhui08@bit.edu.cn
1 School of Computer Science & Technology, Beijing Institute of Technology, Beijing, China. E-mail: wangtaiming@bit.edu.cn, yuxiazh@bit.edu.cn, liuhui08@bit.edu.cn
2 China Telecom Corporation Limited Beijing Research Institute, Beijing, China. E-mail:
jiangl34@chinatelecom.cn
3 Academy of Military Science of the People’s Liberation Army National Innovation Institute
of Defense Technology, Beijing, China. E-mail: xtangee@hotmail.com, liguangjie er@126.com

2

Taiming Wang 1 et al.

---
*Extraído em 2026-06-12 23:54:32*
