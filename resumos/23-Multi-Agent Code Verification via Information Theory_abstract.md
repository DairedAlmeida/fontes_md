# Abstract do artigo: 23-Multi-Agent Code Verification via Information Theory

**Arquivo original:** 

## Abstract

Abstract
LLMs generate buggy code: 29.6% of SWE-bench “solved” patches fail, 62% of BaxBench solutions have vulnerabilities, and existing tools only catch 65% of bugs with 35% false positives. We built CodeX-Verify, a multi-agent
system that uses four specialized agents to detect different types of bugs. We prove mathematically that combining
agents with different detection patterns finds more bugs than any single agent when the agents look for different
problems, using submodularity of mutual information under conditional independence. Measuring agent correlation
of ρ = 0.05–0.25 confirms they detect different bugs. Testing on 99 code samples with verified labels shows our system
catches 76.1% of bugs, matching the best existing method (Meta Prompt Testing: 75%) while running faster and
without test execution. We tested all 15 agent combinations and found that using multiple agents improves accuracy
by 39.7 percentage points (from 32.8% to 72.4%) compared to single agents, with diminishing returns of +14.9pp,
+13.5pp, and +11.2pp for agents 2, 3, and 4, validating our theoretical model. The best two-agent combination
(Correctness + Performance) reaches 79.3% accuracy. Testing on 300 real patches from Claude Sonnet 4.5 runs in
under 200ms per sample, making this practical for production use.
Keywords: Multi-agent systems, Code verification, LLM-generated code, Information theory
that runs four specialized agents in parallel: Correctness
1 Introduction
(logic errors, edge cases, exception handling), Security
LLMs generate code that looks correct but often fails (OWASP Top 10, CWE patterns, secrets), Performance
in production. While LLM-generated code passes basic (algorithmic complexity, resource leaks), and Style (mainsyntax checks and simple tests, recent studies show it tainability, documentation). Each agent looks for differcontains hidden bugs. Xia et al. [28] find that 29.6% ent bug types. We prove that combining agents finds
of patches marked “solved” on SWE-bench don’t match more bugs than any single agent using submodularity
what human developers wrote, with 7.8% failing full test of mutual information under conditional independence:
suites despite passing initial tests. SecRepoBench reports I(A1 , A2 , A3 , A4 ; B) > maxi I(Ai ; B). Measuring how ofthat LLMs write secure code ¡25% of the time across 318 ten our agents agree shows correlation ρ = 0.05–0.25,
C/C++ tasks [8], and BaxBench finds 62% of backend confirming they catch different bugs.
code has vulnerabilities or bugs [26]. Studies suggest 40–
Results. We tested on 99 code samples with verified
60% of LLM code contains undetected bugs [13], making labels covering 16 bug categories from real SWE-bench
automated deployment risky.
failures. Our system catches 76.1% of bugs, matching
The Problem. Existing verification tools check code Meta Prompt Testing (75%) [27] while running faster
in one way at a time, missing bugs that require looking and without executing code. We improve 28.7 percentfrom multiple angles. Traditional static analyzers (Sonar- age points over Codex (40%) and 3.7 points over tradiQube, Semgrep, CodeQL) catch 65% of bugs but flag tional static analyzers (65%). Our 50% false positive rate
good code as buggy 35% of the time [22]. Test-based is higher than test-based methods (8.6%) because we flag

---
*Extraído em 2026-06-12 23:54:26*
