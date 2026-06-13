                                                      Spec-Driven Development:
                                             From Code to Contract in the Age of AI Coding
                                                              Assistants
                                                                                               Deepak Babu Piskala
                                                                                                    Seattle, USA
                                                                                                  Technical Report


                                            Abstract—The rise of AI coding assistants has reignited in-      advocated for it for years—the emergence of AI coding assis-
                                         terest in an old idea: what if specifications—not code—were         tants [15], [28] has made SDD newly relevant. The problem

arXiv:2602.00180v1 \[cs.SE\] 30 Jan 2026

                                         the primary artifact of software development? Spec-driven de-       is simple: AI models are excellent at pattern completion but
                                         velopment (SDD) inverts the traditional workflow by treating
                                         specifications as the source of truth and code as a generated       poor at mind reading.
                                         or verified secondary artifact. This paper provides practitioners      Consider a developer who prompts an AI with: “Add photo
                                         with a comprehensive guide to SDD, covering its principles,         sharing to my app.” The AI must guess: What format? What
                                         workflow patterns, and supporting tools. We present three levels    permissions model? What size limits? Cloud storage or local?
                                         of specification rigor—spec-first, spec-anchored, and spec-as-
                                         source—with clear guidance on when each applies. Through            Compression? The result is often plausible-looking code that
                                         analysis of tools ranging from Behavior-Driven Development          makes dozens of unstated assumptions—many of them wrong.
                                         frameworks to modern AI-assisted toolkits like GitHub Spec          This is what practitioners call “vibe coding”—relying on
                                         Kit, we demonstrate how the spec-first philosophy maps to real      loose prompts that lead to inconsistent or erroneous outputs
                                         implementations. We present case studies from API development,      from LLMs. By providing AI with unambiguous, executable
                                         enterprise systems, and embedded software, illustrating how
                                         different domains apply SDD. We conclude with a decision            contracts, SDD enhances the reliability of coding agents and
                                         framework helping practitioners determine when SDD provides         opens new avenues for scalable software creation.
                                         value and when simpler approaches suffice.                             Now consider the same request with a specification: “Users
                                            Index Terms—Spec-Driven Development, AI-Assisted Coding,
                                                                                                             can upload JPEG or PNG photos up to 10MB. Photos are
                                         Behavior-Driven Development, Test-Driven Development, API
                                         Design First, Software Specifications                               stored in S3 with user-ID-prefixed keys. Only the uploader
                                                                                                             can delete their photos. Photos are resized to 1024px max
                                                               I. I NTRODUCTION                              dimension on upload.” The AI now has enough information
                                            For decades, code has been the king of software develop-         to generate code that matches intent.
                                         ment. Requirements documents exist, but they drift. Design
                                         diagrams are drawn, but they rot. Tests are written, but often       Key Insight
                                         after the fact. The code—whatever it actually does—becomes           The Core Principle: In spec-driven development, code
                                         the de facto truth of the system.                                    is the implementation detail of the specification—not the
                                            This code-centric reality has consequences. When a new            other way around. The spec declares intent; the code
                                         developer asks “what should this function do?” the answer            realizes it.
                                         is often “read the code.” When a stakeholder asks “does the
                                         system meet our requirements?” the answer requires reverse-
                                         engineering intent from implementation. When an AI coding
                                         assistant is asked to add a feature, it must guess what the         B. What This Paper Provides
                                         developer wants from a vague prompt.
                                            Spec-driven development (SDD) [2], [4] offers an alterna-           This paper serves as a practitioner’s guide to spec-driven
                                         tive: make the specification the source of truth, and let code      development. We begin by defining clear levels of specifica-
                                         derive from it. Instead of coding first and documenting later       tion rigor—spec-first, spec-anchored, and spec-as-source—and
                                         (or never), teams write clear specifications of intended be-        articulating when each approach applies. We then present a
                                         havior, then generate, implement, or verify code against those      practical workflow for implementing SDD, examining how the
                                         specifications. The spec becomes the authoritative description      approach works both with and without AI assistance. A survey
                                         that both humans and machines use to understand, build, and         of tools and frameworks follows, ranging from traditional
                                         maintain the system.                                                BDD frameworks to modern AI-assisted toolkits. Case studies
                                                                                                             illustrate SDD in action across API development, enterprise
                                         A. The AI Catalyst                                                  systems, and embedded software domains. Finally, we provide
                                           While spec-first thinking is not new—Test-Driven Develop-         guidance on when SDD delivers value and when simpler
                                         ment (TDD) and Behavior-Driven Development (BDD) have               approaches suffice.

II. T HE S PECIFICATION S PECTRUM In this approach, the specification
and code evolve together Not all spec-driven approaches are equal. Teams
adopt as equal partners. Tests enforce the alignment between them,
different levels of rigor depending on their needs, tooling, with BDD
scenarios commonly serving as automated tests and domain constraints.
Figure 1 illustrates the spectrum that run on every commit. The spec
serves as always-up- from traditional code-first development to fully
spec-as-source to-date documentation that developers and stakeholders
can approaches. Understanding where your team falls on this trust.
However, maintaining this alignment requires discipline spectrum---and
where it should be---is the first step in adopting and tooling
support---teams must commit to updating specs SDD effectively. whenever
behavior changes. Spec-anchored is the sweet spot for most production
sys- A. Spec-First: Guided Initial Development tems. It provides the
benefits of clear documentation and Definition: Spec-First verifiable
requirements without demanding that code be fully generated from
specifications. BDD frameworks like Cucum- In spec-first development, a
specification is written before ber exemplify this approach, enabling
teams to write human- coding to guide the initial implementation. Once
code ex- readable scenarios that execute as automated tests. For API
ists, the spec may or may not be maintained---the primary development,
OpenAPI specifications paired with contract test- value is in the
initial clarity it provides. ing tools like Specmatic achieve the same
alignment between spec and implementation. Spec-first represents the
entry point to SDD. Before writing code, the developer or team
articulates what the code should do, typically as a user story with
acceptance criteria, a BDD C. Spec-as-Source: Humans Edit Specs,
Machines Generate scenario, or a detailed requirements document. The
spec Code guides implementation, but once the code is written and tests
Definition: Spec-as-Source pass, the spec may be discarded or allowed to
drift. The defining characteristic of spec-first development is In
spec-as-source development, the specification is the that the
specification is written before implementation begins, only artifact
humans edit directly. Code is entirely gener- ensuring that developers
have a clear target before they start ated from the spec and should
never be manually modified. coding. However, the code becomes the
primary artifact post- Any change to behavior means changing the spec
and implementation, and the spec may become outdated as the
regenerating. code evolves through subsequent iterations. This approach
carries a lower maintenance burden than stronger specification
Spec-as-source represents the most radical form of SDD. disciplines,
making it practical for teams that cannot commit The specification
becomes, in effect, the source code---just to ongoing spec maintenance.
expressed at a higher level of abstraction. Developers think in
Spec-first works particularly well for initial feature de- terms of
requirements and behavior; machines translate that velopment when
working with AI coding assistants. The into executable code. If you want
to change functionality, you upfront spec prevents the AI from guessing
at requirements, change the spec and regenerate---you never edit the
generated dramatically improving the quality of generated code. It is
also code directly. valuable for prototypes and one-off features where
the cost of This approach, drawing on Design by Contract princi-
maintaining a spec alongside code indefinitely is not justified. ples
\[24\], fundamentally inverts the traditional relationship However,
spec-first does not protect against drift over time--- between specs and
code: the specification is the primary if the codebase will be
maintained long-term, teams should artifact, and code is entirely
derived from it. Manual code consider spec-anchored approaches. editing
is either prohibited or confined to well-defined exten- B.
Spec-Anchored: Living Documentation sion points. This requires mature,
trusted generation tooling--- developers must have confidence that
generated code correctly Definition: Spec-Anchored implements the spec.
In return, drift is eliminated by design: In spec-anchored development,
the specification is main- since code is regenerated rather than
manually edited, spec tained alongside the code throughout the system's
lifecycle. and code are always aligned by construction. Changes to
behavior require updating both the spec and the Spec-as-source is
already standard practice in domains with code, keeping them
synchronized. well-defined code generation, such as generating API
server stubs from OpenAPI specifications, or producing certified em-
Spec-anchored development treats the spec as a living bedded code from
Simulink models. In the automotive indus- document that evolves with the
codebase. When a feature try, engineers routinely build control
algorithms in Simulink, changes, the spec is updated first or
simultaneously with the verify behavior at the model level through
simulation, and code. Automated checks---typically in the form of tests
derived generate certified C code that nobody hand-edits. Emerging AI
from the spec---ensure that spec and code remain aligned. If tools like
Tessl aim to extend this approach to general software they drift, tests
fail, providing immediate feedback that the development, representing a
future where specifications truly system's documentation no longer
reflects its behavior. become "the new source code." However, adopting
spec-as-  What is the source of truth?

                       Ad-hoc                                                    Spec-First                           Spec-Anchored                 Spec-as-Source

Code-First Spec-First Code first Spec guides Spec maintained Spec is the
code Docs later initial build alongside code Generate only Drift common
May abandon Sync enforced Never edit code

                                                                                      Increasing specification authority →

Fig. 1. The specification spectrum. Moving right increases the authority
of specifications over code, but also increases the discipline required
to maintain alignment.

source requires high trust in generation quality and is currently cover
essential cases without over-specifying. Effective specs practical only
in domains where that trust has been established. emphasize clarity,
modularity, and self-checks that help guide AI agents during
implementation. III. T HE SDD W ORKFLOW How does spec-driven development
work in practice? While Practitioner's Tip specific tools vary, a common
workflow emerges across SDD Write specs at the level of detail needed to
remove ambi- approaches. Figure 2 illustrates the four core phases. The
key guity. If an AI or developer could interpret a requirement insight
is that each phase produces an artifact that constrains in multiple
ways, add clarification. If there's only one rea- and guides the next,
creating a chain of accountability from sonable interpretation, don't
over-specify---excessive detail intent to implementation. constrains
implementation unnecessarily. Human review Human review Human review
Automated + Human

                                                                                                            B. Phase 2: Plan
      Specify
     What to build
                             Plan
                           How to build
                                                                  Implement
                                                                    Build it
                                                                                          Validate
                                                                                             Verify it
                                                                                                               The plan phase answers a different question: How should
                                                                                                            we build it? Given the functional spec, this phase produces a
                                                                                                            technical plan covering architecture, data models, interfaces,
                                          Refine spec if needed
                                                                                                            and technology choices. Where the spec declares intent, the
                                                                                                            plan declares constraints on implementation.

Fig. 2. The SDD workflow. Each phase produces an artifact that guides
the next. Human review at each checkpoint ensures alignment with intent.
Planning involves selecting technologies and frameworks appropriate to
the problem, defining component architecture and boundaries, designing
data models and schemas, speci- A. Phase 1: Specify fying interfaces
including APIs, messages, and contracts, and The specify phase answers a
fundamental question: What identifying non-functional requirements
around performance, should the software do? The output is a functional
specification security, and scalability. describing behavior,
requirements, and acceptance criteria--- The plan phase bridges the
"what" and the "how." It encodes crucially, without prescribing
implementation details. This constraints that the implementation must
respect---for exam- separation of "what" from "how" is essential to
SDD's power. ple, "use PostgreSQL for persistence" or "all API endpoints
During this phase, teams articulate user-facing behavior require
authentication." When using AI coding assistants, the through user
stories, scenarios, and acceptance criteria. They plan provides crucial
context: the AI learns not just what to define what success looks like
using Given/When/Then format build but how the system is structured and
what conventions it or input-output examples. Business rules and
constraints are should follow. Without this context, even a perfect
functional captured explicitly, and edge cases and error conditions are
spec may yield code that contradicts organizational standards identified
upfront rather than discovered during implementa- or architectural
decisions. tion. The quality of specifications directly determines the
quality C. Phase 3: Implement of everything that follows. Good specs
share several charac- The implement phase produces working code that
realizes teristics: they are behavior-focused, describing what happens
the spec according to the plan. In traditional development, this rather
than how; they are testable, with each requirement being is where most
effort concentrates. In SDD, particularly with verifiable; they are
unambiguous, meaning different readers AI assistance, this phase may be
substantially automated---but reach the same interpretation; and they
are complete enough to it still requires human oversight. 
Implementation begins by breaking the plan into discrete, of
implementation variation. In embedded systems and other reviewable
tasks. Each task is then implemented, whether by safety-critical
domains, SDD combines LLM generation with human developers, AI
assistants, or a hybrid approach. Code is formal verification to ensure
compliance with standards like reviewed against both spec and plan to
verify alignment. Unit ISO 26262 \[25\]. Overall, SDD transforms AI
agents from tests are written to encode spec requirements as executable
reactive tools into proactive collaborators, enhancing efficiency
assertions. particularly in brownfield projects where legacy constraints
are A key SDD principle is working in small, validated incre- encoded in
specifications. ments. Rather than implementing the entire spec at once,
teams An emerging approach involves "self-spec" methods where break work
into tasks where each delivers a testable piece of LLMs author their own
specifications before generating code. functionality. This enables
frequent checkpoints where humans The agent first produces a spec from a
high-level prompt, verify alignment, catching drift early before it
compounds. which is then reviewed and refined by humans before the
Specifications act as "super-prompts" that break down com- same or
another agent implements against it. This creates an plex problems into
modular components aligned with agents' explicit separation between
planning and execution, catching context windows, enabling AI systems to
handle complexity requirement misunderstandings before code is written.
that would overwhelm single-shot prompts. V. T OOLS AND F RAMEWORKS D.
Phase 4: Validate A variety of tools support spec-driven development,
from The validate phase answers the crucial closing question:
traditional testing frameworks to modern AI-assisted toolkits. Does the
code actually meet the spec? Validation closes the Table I summarizes
key categories. Common approaches in- loop, ensuring that what was
specified is what was built. This clude phased workflows (specify, plan,
tasks, implement) and phase combines automated verification with human
judgment. tools ranging from Kiro for VS Code-based specs to spec-kit
Validation encompasses running automated tests at unit, for CLI-driven
projects to Tessl for spec-as-source models. integration, and acceptance
levels, executing BDD scenarios A. Behavior-Driven Development (BDD)
Frameworks against the implementation, reviewing for adherence to non-
BDD frameworks allow teams to write specifications in functional
requirements, and conducting stakeholder accep- near-natural language
that can be executed as tests. The canon- tance testing where
appropriate. ical format is Gherkin \[16\], which uses structured
scenarios If validation reveals gaps---the code doesn't meet the spec---
with Given/When/Then clauses: the team faces a decision: fix the code or
revise the spec. If the original spec was wrong or incomplete, updating
it is the right Feature: Shopping Cart choice. If the code simply
doesn't meet a valid spec, fixing the Scenario: Adding item to empty
cart code is required. Either way, the spec remains the authority. Given
the cart is empty This discipline ensures that specifications stay
trustworthy--- When I add item "Widget" to the cart teams can rely on
them because violations are detected and Then the cart should contain 1
item addressed, not ignored. And the item should be "Widget" IV. H OW
SDD B OOSTS AI C ODING AGENTS These scenarios serve dual purposes:
documentation that stakeholders can read and automated tests that verify
Large language models like GPT-4 or Claude, when used code. Tools like
Cucumber \[7\] (Ruby, Java, JavaScript), as coding agents, benefit
immensely from SDD by receiving SpecFlow \[21\] (.NET), and Behave
\[22\] (Python) execute optimized, context-rich inputs. Specifications
act as super- these scenarios against the application, bridging the gap
be- prompts that break down complex problems into modular tween business
requirements and technical implementation. components aligned with
agents' context windows. AI agents can generate code from specs while
self-verifying against Practitioner's Tip checklists for requirements
adherence. Empirical studies \[5\], \[6\], though nascent, suggest that
BDD scenarios are specifications, not just tests. Write human-refined
specs significantly improve LLM-generated them before implementation,
involve stakeholders in their code quality, with controlled studies
showing error reductions creation, and treat them as the authoritative
description of of up to 50%. This boosting effect is particularly
evident feature behavior. When scenarios pass, you have confi- in
scalable scenarios: specifications enable parallel agent dence that the
system meets its documented requirements. execution on non-overlapping
tasks, with orchestration for dependencies. Teams can partition work at
the spec level, al- B. API Specification Tools lowing multiple AI agents
to implement different components In API development, spec-driven
approaches have been simultaneously without interference. standard
practice under the names "design-first" or "API- Challenges remain,
including LLM non-determinism---even first" \[23\] for years. OpenAPI
\[8\] (formerly Swagger) en- structured specs can lead to varying
outputs. Techniques like ables teams to define REST APIs with complete
endpoint property-based testing (PBT) address this by automatically
specifications, request/response schemas, and examples, then verifying
that invariants from specs are satisfied regardless generate server
stubs, client SDKs, and documentation from  TABLE I T OOLS AND F
RAMEWORKS S UPPORTING S PEC -D RIVEN D EVELOPMENT

        Category                   Examples                                         Role in SDD
        BDD Frameworks             Cucumber, SpecFlow, Behave                       Write executable specs in plain language (Gherkin)
        TDD Frameworks             RSpec, JUnit, pytest                             Encode specifications as unit tests
        API Specification          OpenAPI/Swagger, GraphQL SDL, Protocol Buffers   Define contracts; generate code and tests
        Contract Testing           Pact, Specmatic                                  Verify implementations match specs
        AI-Assisted SDD            GitHub Spec Kit, Amazon Kiro, Tessl              Structured AI workflows from spec to code
        Model-Based Design [26]    Simulink, SCADE                                  Visual specs that generate embedded code

the spec. GraphQL SDL \[17\] allows teams to define types, Domain:
Financial services microservices queries, and mutations in a schema that
becomes the contract Pattern: Spec-anchored with OpenAPI between
frontend and backend, enabling parallel development. Outcome: 75%
reduction in integration cycle time For event-driven architectures,
AsyncAPI \[27\] provides similar specification capabilities. Protocol
Buffers \[18\] and gRPC \[19\] A financial services company struggled
with what they enable definition of service interfaces and message types
with called "integration hell"---microservices frequently failed
automatic generation of strongly-typed client and server code. when
deployed together because teams made incompatible The benefit of API
specification tools is clear: once the assumptions about API contracts.
Each team implemented API spec is agreed upon, frontend and backend
teams can their service in isolation, and incompatibilities only
surfaced work in parallel with confidence. The spec is the contract;
during integration testing, requiring expensive rework. any
implementation that matches the spec is valid by defini- The company
mandated API-first development as their solu- tion. Contract testing
tools like Pact \[20\] and Specmatic \[9\] tion. Before implementing any
service, teams wrote OpenAPI automate verification that implementations
actually match their specifications defining endpoints, request/response
schemas, specs. and error conditions. Consumer teams reviewed these
specs and provided feedback before any coding began. This front- C.
AI-Assisted SDD Tools loaded the integration discussions that previously
happened Emerging tools structure AI coding workflows explicitly too
late. around specifications, recognizing that multi-step prompting They
used Specmatic \[9\] to generate mock servers from with explicit
artifacts yields better results than single-shot "just specs, allowing
frontend development to proceed in parallel code this" prompts. with
backend work. More critically, Specmatic validated that GitHub Spec Kit
\[1\] is an open-source toolkit providing implemented services matched
their specs in CI. Any deviation commands for spec-driven AI
development. The workflow caused the build to fail, preventing drift
from accumulating. follows four explicit phases: /specify generates a
detailed Integration failures dropped dramatically after adoption. spec
from a prompt, /plan creates technical architecture, Teams reported a
75% reduction in cycle time for API changes /tasks breaks the plan into
implementation tasks, and finally because incompatibilities were caught
at the spec review stage implementation generates code task by task. At
each phase, rather than in production. The specs became the contract
that humans review and refine before proceeding, maintaining all parties
trusted, eliminating the ambiguity that had caused alignment between
intent and implementation. so much rework. Amazon Kiro \[13\] guides
users through requirements, de- sign, and task creation stages before
any code generation B. Case Study 2: BDD for Enterprise Features begins.
Kiro emphasizes structured requirements capture and iterative
refinement, ensuring AI has clear context before Domain: Enterprise
project management software attempting implementation. The explicit
staging prevents the Pattern: Spec-anchored with Cucumber AI from
guessing at requirements that were never specified. Outcome:
Stakeholder-verifiable requirements; reduced re- Tessl \[14\] takes the
most radical approach: spec-as-source quirement ambiguity where the
specification is the maintained artifact and code is regenerated from
it. Tessl represents the emerging vision of An enterprise software team
found that developers and "specs as the new source code," where
developers never edit product managers frequently disagreed on what
"done" meant generated code---they edit specs and regenerate. for
features. Developers would implement something they These tools share a
common insight: separating planning believed met requirements, QA would
find it didn't match from implementation allows agents to focus on
execution product expectations, and arguments ensued about whose within
defined boundaries, reducing the non-determinism that interpretation was
correct. The lack of a shared, authoritative plagues loosely-prompted AI
coding. definition of expected behavior caused friction and rework. The
team adopted Cucumber for all user-facing features VI. C ASE S TUDIES as
their solution. Product managers wrote Gherkin scenarios A. Case Study
1: API-First Microservices describing expected behavior in plain
language. Developers implemented step definitions to automate these
scenarios as agents handle the translation from spec to implementation,
but executable tests. A feature was only considered "done" when humans
remain responsible for ensuring specs capture actual all its scenarios
passed, providing an objective, verifiable requirements. definition of
completion. In brownfield projects and legacy systems, SDD enables a The
Gherkin scenarios became a shared language that both different kind of
work: encoding existing behavior as spec- business and technical
stakeholders could read and validate. ifications before making changes.
By extracting specs from Product managers could verify that scenarios
captured their legacy code, teams can verify that modernization efforts
pre- intent. When disputes arose, the scenario was the authority---if
serve required functionality while eliminating undocumented the scenario
was wrong, it was updated with explicit agreement behaviors. The spec
becomes the bridge between old and new from stakeholders; if the code
was wrong, developers fixed it. implementations. This eliminated the
ambiguity that had caused so much rework Use-cases span the development
spectrum: greenfield and conflict. projects where specs guide initial
development, feature ad- ditions to legacy systems where specs document
existing C. Case Study 3: Model-Based Embedded Development behavior
before modification, and embedded software where Domain: Automotive
engine control specs ensure precision in safety-critical domains. In
each case, Pattern: Spec-as-source with Simulink the developer's role
shifts from code producer to spec author Outcome: Verified control
logic; certified code generation and AI orchestrator.

An automotive supplier needed to develop engine control VIII. W HEN TO U
SE SDD software that met ISO 26262 safety certification requirements.
Spec-driven development is not universally applicable. Like Manual
coding was error-prone, and certification required any practice, it has
costs---upfront spec effort, tooling in- tracing every line of code to
specific requirements---a labor- vestment, and discipline
requirements---and benefits---clarity, intensive process when code was
hand-written. quality, and maintainability. The decision framework in
Fig- The team used MathWorks Simulink \[10\] to model control ure 3
helps practitioners determine when SDD adds value. algorithms as block
diagrams with state machines. The model was the specification: engineers
simulated and verified behav- New feature/system

ior at the model level, catching algorithmic errors before any code
existed. Once the model was verified through simulation, code was
auto-generated from the model using a certified code Ad-hoc OK No AI
assistance or complex

generator. requirements?

The model-to-code generation was itself certified, meaning Yes the
generated C code was guaranteed to behave as the model specified.
Engineers never edited generated code; if control No Long-lived?
Multiple Spec-First logic needed changing, they changed the model and
regen- maintainers?

erated. This ensured the verified model and deployed code remained
perfectly aligned by construction. Yes

This approach embodies spec-as-source at its most rigorous: No Code
generation Yes the specification (Simulink model) is the only artifact
humans Spec-Anchored viable? Spec-as-Source

modify, and the implementation (C code) is entirely gener- ated. SDD in
embedded systems combines LLM generation with formal verification to
ensure safety-critical compliance, Fig. 3. Decision framework for
selecting SDD approach. Start with the level demonstrating how specs
ensure precision in domains like of rigor that matches your needs.
automotive and aerospace where errors can be catastrophic. SDD adds
clear value when using AI coding assistants, as VII. T HE R EDEFINITION
OF D EVELOPER W ORK specifications dramatically improve output quality
by remov- SDD fundamentally reshapes what it means to be a software ing
the ambiguity that forces AI to guess. Complex require- developer. Work
is being redefined as developers shift from ments benefit from SDD
because stakeholders can validate that manual coding to orchestrating
specifications, reviewing AI the system meets their needs before code is
written. Systems outputs, and focusing on high-level design. This
transition with multiple maintainers benefit because specs serve as
potentially increases efficiency but introduces new challenges
documentation that survives team turnover. Integration-heavy around spec
maintenance, tool mastery, and the judgment systems gain from API specs
that enable parallel development required to know when AI outputs are
correct. and prevent integration failures. Regulated domains often man-
In greenfield projects, developers become architects who date
traceability from requirements to implementation, which design systems
through specifications rather than code. They SDD provides naturally.
Legacy modernization efforts benefit focus on requirements elicitation,
constraint definition, and because extracting a spec from existing
behavior enables clean acceptance criteria---the "what" rather than the
"how." AI reimplementation with confidence.  However, SDD may be
overkill in certain situations. Throw- (LLD) documents that software
engineering has always used? away prototypes don't justify spec
investment that will be After all, HLD describes architecture, LLD
details imple- discarded. Solo, short-lived projects may find the
overhead mentation, and requirements documents specify functionality.
exceeds benefits when there's only one developer and no long- Aren't
these already specifications? term maintenance. Exploratory coding
suffers from premature The answer is nuanced. Traditional design
documents are specification that constrains learning when you don't yet
know specifications---the difference lies not in what is written, but
what you're building. Simple CRUD applications with obvious in how it is
used and whether it stays aligned with code. requirements need minimal
spec---if requirements are unlikely Traditional software engineering
produces many specification- to be misinterpreted, elaborate
specifications add cost without like artifacts: Software Requirements
Specifications (SRS) value. for functional and non-functional
requirements, High-Level Design documents for architecture and
components, Low- Key Insight Level Design documents for class diagrams
and algorithms, The Golden Rule: Use the minimum level of specification
and interface specifications for API contracts and IDL. rigor that
removes ambiguity for your context. Spec- The problem is not the absence
of specs---it's that they first for AI-assisted initial development;
spec-anchored for drift. By Sprint 3, the HLD is outdated. By release 2,
the long-lived production systems; spec-as-source only when SRS no
longer matches the product. The code becomes the de generation tooling
is mature and trusted. facto truth, and the documents become historical
artifacts that nobody trusts or updates. IX. C OMMON P ITFALLS Key
Insight Teams adopting SDD often encounter predictable challenges that
can undermine the approach's benefits if not addressed. The Core
Difference: Traditional design documents are Over-specification occurs
when teams write specs that are advisory---developers read them, then
write code that too detailed, essentially becoming pseudo-code. This
defeats hopefully matches. SDD specs are enforced---tests fail if the
purpose of SDD, which is to separate "what" from "how." code diverges,
and in spec-as-source approaches, code is If your spec reads like code,
you've gone too far---you've con- regenerated rather than manually
edited. strained implementation unnecessarily and lost the abstraction
benefit that makes specs valuable. What SDD actually adds is threefold.
First, executable Specification rot affects spec-anchored approaches
when specifications: traditional specs are read by humans, while teams
fail to update specs as code changes. The spec drifts SDD specs are
executed as BDD scenarios, API contract from reality, losing its value
as documentation and eroding tests, or model simulations---if code
doesn't match, the build trust. The solution is automated enforcement
through tests fails. Second, CI/CD integration: modern SDD embeds spec
that fail when spec and code diverge, making drift visible and
validation into continuous integration, checking every commit painful
rather than silent and accumulating. against the spec so drift is caught
immediately rather than Specification as bureaucracy emerges when specs
become during quarterly reviews. Third, AI consumption: traditional
forms to fill out rather than tools for clarity. If the specification
design docs were written for human readers, while SDD specs process adds
overhead without improving understanding or are structured so AI coding
assistants can consume them, quality, teams will game the system or
abandon it. Specs generating code and tests from specs rather than
guessing from should be the minimum needed to remove ambiguity, not
vague prompts. comprehensive documentation exercises. SDD is not a
revolution---it's an evolution. The core in- Tooling complexity can
overwhelm teams, particularly with sight (write specs first, let code
derive from them) has been AI-assisted tools that generate elaborate
artifacts. Teams may agile wisdom for decades. What's new is better
tooling that drown in generated plans, task lists, and intermediate doc-
makes executable specs practical, CI/CD maturity that enables uments.
The solution is to start simple and add tooling automated enforcement,
and AI as consumer where spec complexity only when it demonstrably
helps---avoid cargo- quality directly determines output quality. As
Bryan Finster culting elaborate workflows that add process without
value. observed \[3\]: "SDD is not a revolution... it's just BDD with
False confidence is perhaps the subtlest pitfall. A passing branding."
But the branding serves a purpose: it reminds spec test doesn't
guarantee correct software---it only guar- practitioners that specs
should be authoritative, not advisory, antees that the software matches
the spec. If the spec is and that modern tooling can enforce what was
previously left wrong, the code will faithfully implement the wrong
thing. to human discipline. Specifications require the same careful
review as code; they are XI. R ELATIONSHIP TO E XISTING P RACTICES not a
silver bullet that eliminates the need for human judgment about
requirements. SDD is not a replacement for existing development
practices---it builds on and extends them in the context of X. SDD VS T
RADITIONAL D ESIGN D OCUMENTS AI-assisted development. A natural
question arises: how is SDD different from Test-Driven Development (TDD)
\[11\] is SDD at the unit traditional High-Level Design (HLD) and
Low-Level Design level. Writing a test first is writing a
micro-specification that defines expected behavior before
implementation. SDD R EFERENCES extends this thinking to higher
levels---features, systems, and \[1\] GitHub, "Spec-Driven Development
with AI: Get Started with a architectures---applying the same "specify
first" discipline at New Open Source Toolkit," GitHub Blog, 2025.
\[Online\]. Available: broader scope.
https://github.blog/ai-and-ml/generative-ai/spec-driven-development-
with-ai-get-started-with-a-new-open-source-toolkit/ Behavior-Driven
Development (BDD) \[12\] is the most \[2\] Thoughtworks, "Spec-Driven
Development," Tech- direct ancestor of modern SDD. Gherkin scenarios are
exe- nology Radar, Vol. 32, 2025. \[Online\]. Available: cutable
specifications that bridge business requirements and
https://www.thoughtworks.com/radar/techniques/spec-driven- development
technical implementation. What AI-assisted SDD tools add is \[3\] B.
Finster, "5-Minute DevOps: Spec-Driven Development Isn't New,"
assistance in generating code from those specs, accelerating Medium,
Nov. 2025. \[Online\]. Available: https://bdfinst.medium.com/5- the path
from scenario to working software.
minute-devops-spec-driven-development-isnt-new-3a5c552efc95 \[4\] M.
Fowler, "Exploring Gen AI: Spec-Driven Devel- Domain-Driven Design (DDD)
aligns well with SDD opment," martinfowler.com, 2025. \[Online\].
Available: through its emphasis on ubiquitous language---specs written
https://martinfowler.com/articles/exploring-gen-ai.html in domain terms
that both developers and stakeholders under- \[5\] L. Griffin and R.
Carroll, "Spec Driven Development: When Archi- tecture Becomes
Executable," InfoQ, Jan. 2026. \[Online\]. Available: stand. The shared
vocabulary that DDD advocates becomes the
https://www.infoq.com/articles/spec-driven-development/ foundation for
specifications that are meaningful to all parties. \[6\] R. Naszcyniec,
"How Spec-Driven Development Improves AI Agile methodologies are
compatible with SDD. User stories Coding Quality," Red Hat Developer,
2025. \[Online\]. Available:
https://developers.redhat.com/articles/2025/10/22/how-spec-driven- with
acceptance criteria are specifications; the Definition of
development-improves-ai-coding-quality Done is a form of spec. The
difference is emphasis: SDD \[7\] Cucumber, "Cucumber Documentation,"
cucumber.io, 2024. \[Online\]. treats these artifacts as authoritative
rather than advisory, and Available: https://cucumber.io/docs/ \[8\]
OpenAPI Initiative, "OpenAPI Specification v3.1.0," 2024. \[Online\].
enforces alignment through automation rather than relying on Available:
https://spec.openapis.org/oas/v3.1.0 human discipline alone. \[9\]
Specmatic, "Contract-Driven Development with Specmatic," 2025. \[On-
line\]. Available: https://specmatic.io/ XII. C ONCLUSION \[10\]
MathWorks, "Simulink: Simulation and Model- Based Design," 2024.
\[Online\]. Available: Spec-driven development inverts the traditional
relationship https://www.mathworks.com/products/simulink.html between
specifications and code. Instead of code being the \[11\] K. Beck, Test
Driven Development: By Example, Addison-Wesley, 2002. \[12\] D. North,
"Introducing BDD," dannorth.net, Mar. 2006. \[Online\]. Avail- source of
truth with documentation as an afterthought, SDD able:
https://dannorth.net/introducing-bdd/ makes specifications authoritative
and code derivative. This \[13\] Amazon Web Services, "Kiro: Agentic AI
Development from Prototype inversion becomes increasingly important as
AI coding assis- to Production," 2025. \[Online\]. Available:
https://kiro.dev/ \[14\] Tessl, "Tessl: Make Agents Work in Real
Codebases," 2025. \[Online\]. tants become more capable---when an AI can
generate code Available: https://tessl.io/ from specifications faster
than humans can type, the bottleneck \[15\] GitHub, "GitHub Copilot
Documentation," 2024. \[Online\]. Available: shifts to specification
quality. https://docs.github.com/en/copilot \[16\] Cucumber, "Gherkin
Reference," 2024. \[Online\]. Available: Specifications remove ambiguity
for both human developers https://cucumber.io/docs/gherkin/reference/
and AI assistants, preventing the guesswork and misinterpre- \[17\]
GraphQL Foundation, "GraphQL Specification," 2024. \[Online\]. Avail-
tation that leads to costly rework. The three levels of rigor--- able:
https://spec.graphql.org/ \[18\] Google, "Protocol Buffers
Documentation," 2024. \[Online\]. Available: spec-first, spec-anchored,
and spec-as-source---provide options https://protobuf.dev/ that match
different project needs, from lightweight initial clar- \[19\] gRPC
Authors, "gRPC Documentation," 2024. \[Online\]. Available: ity to
rigorous code generation. Mature tooling exists across
https://grpc.io/docs/ \[20\] Pact Foundation, "Pact Documentation,"
2024. \[Online\]. Available: the spectrum, from BDD frameworks and API
specification https://docs.pact.io/ tools to AI-assisted SDD toolkits,
making spec-first workflows \[21\] Reqnroll Contributors (formerly
SpecFlow), "Reqnroll Documentation," practical today. Teams should match
rigor to need, using the 2024. \[Online\]. Available:
https://docs.reqnroll.net/ \[22\] Behave, "Behave: BDD for Python,"
2024. \[Online\]. Available: minimum specification discipline that
removes ambiguity for https://behave.readthedocs.io/ their context
rather than over-engineering process. \[23\] SmartBear, "What Is
API-First Development?," Swagger.io, 2024. \[On- SDD builds on decades
of TDD and BDD wisdom while line\]. Available:
https://swagger.io/resources/articles/adopting-an-api- first-approach/
adapting these practices for the AI era. The ideas are not new; \[24\]
B. Meyer, "Applying Design by Contract," IEEE Computer, vol. 25, no.
what's new is the tooling and AI capabilities that make specs 10,
pp. 40--51, 1992. more powerful than ever. Work is being redefined as
develop- \[25\] ISO, "ISO 26262: Road vehicles -- Functional safety,"
International Organization for Standardization, 2018. ers shift from
manual coding to orchestrating specifications, \[26\] S. J. Mellor and
M. J. Balcer, Executable UML: A Foundation for Model- reviewing AI
outputs, and focusing on high-level design. Driven Architecture,
Addison-Wesley, 2002. As software systems grow more complex and AI
becomes \[27\] AsyncAPI Initiative, "AsyncAPI Specification," 2024.
\[Online\]. Avail- able: https://www.asyncapi.com/ more capable, the
question shifts from "what code should I \[28\] M. Chen et al.,
"Evaluating Large Language Models Trained on Code," write?" to "what
specification should I provide?" Teams that arXiv:2107.03374, 2021.
master spec-driven development will get more value from AI tools while
maintaining the clarity and traceability that com- plex systems require.
SDD offers a framework for answering that question
systematically---making specifications, not code, the primary artifact
of software development. 
