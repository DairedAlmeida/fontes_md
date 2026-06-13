                                                     DESIGN-OS: A SPECIFICATION-DRIVEN FRAMEWORK FOR ENGINEERING
                                                          SYSTEM DESIGN WITH A CONTROL-SYSTEMS DESIGN CASE


                                                  H. Sinan Bank∗                                   Daniel R. Herber                       Thomas H. Bradley
                                         Department of Systems Engineering                 Department of Systems Engineering       Department of Systems Engineering
                                             Colorado State University                         Colorado State University               Colorado State University
                                               Fort Collins, CO 80523                            Fort Collins, CO 80523                  Fort Collins, CO 80523

arXiv:2603.20151v2 \[cs.CE\] 3 May 2026

                                   ABSTRACT                                                                   1   INTRODUCTION
                                   Engineering system design—whether mechatronic, control, or
                                   embedded—often proceeds in an ad hoc manner, with require-                 When design is ad hoc or implementation-first, requirements tend
                                   ments left implicit and traceability from intent to parameters             to remain implicit, and traceability from intent to parameters is
                                   largely absent. Existing specification-driven and systematic de-           difficult to achieve. AI-assisted tools compound this tendency:
                                   sign methods mostly target software, and AI-assisted tools tend            evidence from the design literature indicates they are predomi-
                                   to enter the workflow at solution generation rather than at prob-          nantly applied in later solution-generation stages rather than in
                                   lem framing. Human–AI collaboration in the design of physical              problem framing and specification [1]. Yet the same AI capa-
                                   systems remains underexplored. This paper presents Design-OS,              bilities, when guided by structured specifications, can support
                                   a lightweight, specification-driven workflow for engineering sys-          better and earlier alignment on goals—recent work on concep-
                                   tem design organized in five stages: concept definition, literature        tual systems engineering illustrates the value of human-driven
                                   survey, conceptual design, requirements definition, and design             baselines alongside agentic frameworks [2]. What is missing is
                                   definition. Specifications serve as the shared contract between            an orchestration layer for the design process itself: a lightweight,
                                   human designers and AI agents; each stage produces structured              model-agnostic structure that sequences design activities, enforces
                                   artifacts that maintain traceability and support agent-augmented           specification-before-implementation discipline, and provides a
                                   execution. We position Design-OS relative to requirements-driven           common interface through which both human designers and AI
                                   design, systematic design frameworks, and AI-assisted design               agents operate. This paper presents Design-OS, a lightweight,
                                   pipelines, and demonstrate it on a control systems design case             specification-driven, phased workflow that addresses this gap by
                                   using two rotary inverted pendulum platforms—an open-source                making specifications the binding contract between conceptual
                                   SimpleFOC reaction wheel and a commercial Quanser Furuta                   intent and implementation and by front-loading literature and con-
                                   pendulum—showing how the same specification-driven workflow                ceptual design before committing to a specification. Design-OS
                                   accommodates fundamentally different implementations. A blank              adopts this collaborative, specification-first stance while remain-
                                   template and the full design-case artifacts are shared in a pub-           ing compatible with agentic tools where they add value, and
                                   lic repository to support reproducibility and reuse. The work-             structures the process so that traceability from intent to param-
                                   flow makes the design process visible and auditable, and extends           eters can be agnostically documented and converted for other
                                   specification-driven orchestration of AI from software to physical         schemas or frameworks.
                                   engineering system design.                                                       Design-OS proceeds in five stages: concept definition → lit-
                                                                                                              erature survey → conceptual design → requirements definition
                                    Keywords: Design Theory and Methodology; Design Process;                  → design definition, with selected stage terminology aligned with
                                    Systems Engineering; AI/KBS; Control; Mechatronics and                    INCOSE SE Handbook processes (notably Design Definition and
                                    Electro-Mechanical Systems; Design Automation                             Requirements Definition) [3]. It is intended for engineering de-
                                                                                                              sign, research prototypes, education, and AI-augmented design
                                                                                                              workflows. By using a control system design project as a design
                                                                                                              case, we demonstrate how the workflow supports the kind of
                                        ∗ Corresponding author: sinan.bank@colostate.edu                      structured design process and traceability that engineering design

                                                                                                          1

methodology calls for \[4\], in a setting where prior work on this and
reviewable before code becomes the de facto specification benchmark has
focused largely on control algorithms and perfor- \[7\]. The open-source
GitHub Spec Kit provides a toolkit for mance analysis \[5\] rather than
on embedding the design process in outlining requirements, motivations,
and technical aspects be- a formal, traceable workflow. This paper
addresses three research fore handing work to AI agents (e.g., GitHub
Copilot), including questions: a "Constitution" for engineering
guidelines, clear specifications, RQ1. Why is a lightweight,
specification-driven workflow needed technical plans, and implementation
tasks \[6\]. Design-OS aligns for physical engineering system design?
(Sec. 1--2) with this philosophy and extends it from software to
physical engineering system design, with stages---literature review,
con- RQ2. How does Design-OS relate to existing specification-driven,
ceptual design of mechatronic or control systems, performance
systematic-design, and AI-assisted design frameworks? (Sec. 2--
specifications---that are domain-specific. 3) RQ3. How does the workflow
support traceability from intent to Systematic design methodology.
Design-OS's phased work- parameters across domains? (Sec. 4--5) flow
draws on systematic design frameworks. Pahl and Beitz's Aligning with
these questions, the contributions of this paper four-phase model (task
clarification, conceptual design, embod- are: (1) a concise presentation
of the Design-OS methodology and iment design, detail design) is
reflected in Design-OS's early its positioning relative to
specification-driven and requirements- phases \[4\]. Gero's
Function-Behavior-Structure (FBS) knowl- driven design (including
industry practice such as GitHub Spec edge representation schema
provides a complementary theoretical Kit \[6\] and Microsoft
specification-driven development \[7\]), sys- lens, formalizing how
design transforms functions into struc- tematic design frameworks (Pahl
& Beitz \[4\], VDI \[8\], Stage- tural descriptions through expected and
actual behaviors \[18\]. Gate \[9\]), and AI-assisted design. (2) An
end-to-end design case VDI 2206 (V-model for mechatronics and
cyber-physical sys- showing how the workflow was run and how artifacts
trace from tems) prescribes phased deliverables and continuous
requirements context and literature through to requirements and
implementation management \[8\]. Design-OS aims to compress these into a
work- plan. (3) A discussion of implications for design education and
for flow optimized for specification-driven engineering. Stage-Gate
specification-driven orchestration of AI in physical engineering \[9\]
shares the idea of discrete phases with explicit deliverables system
design. and front-loading. Design-OS focuses on the technical design The
remainder of the paper is organized as follows: Section 2 workflow
rather than the full product lifecycle. Design-OS does reviews related
work. Section 3 describes the Design-OS method- not replace these
frameworks but offers a lightweight, AI-friendly ology. Section 4
presents the inverted pendulum design case. instantiation that can be
used on its own or alongside MBSE and Section 5 discusses limitations
and future work, and Section 6 VDI, where a lighter-weight,
specification-driven workflow is concludes. desired.

                                                                           AI-assisted design and the specification-driven gap. Large

2 RELATED WORK language models and multi-agent frameworks are reshaping
de- Specification-driven and requirements-driven design. The sign
workflows. Multi-agent systems such as MetaGPT and Chat- principle that
formal specifications must precede implementation Dev use structured
intermediate outputs (requirement documents, is well established in
requirements engineering and systems engi- system designs, interface
specs) to orchestrate agents and reduce neering \[10,11\]. Traceability
from requirements to design and ver- cascading errors \[19,
20\]---directly analogous to Design-OS's ification is central;
inadequacy of pre-requirements specification phased artifacts. A notable
gap is that specification-driven or- traceability is a major source of
failure \[12\]. Reference models for chestration of AI agents for
physical engineering system design traceability have since formalized
the relationships among require- has received little attention. Existing
multi-agent pipelines tar- ments, design decisions, and verification
artifacts \[13\]. Standards get software development \[21\]. Recent work
has shown that such as IEEE 830 \[14\] and its successor ISO/IEC/IEEE
29148 LLMs can generate conceptual design solutions with higher av-
\[15\] define quality criteria and templates for software and sys- erage
feasibility and usefulness than crowdsourced alternatives, tem
requirements specifications. Structured syntax approaches though
crowdsourced solutions exhibit more novelty \[22\], and that such as
EARS provide five requirement templates (precondition-- generative
pre-trained transformers can produce diverse design
trigger--shall--response) to reduce ambiguity and vagueness in concepts
from textual prompts \[23\]---yet these capabilities remain
natural-language requirements \[16\]. Industry practice has re-
disconnected from structured specification workflows. Studies of cently
emphasized specification-driven development (SDD) in the human--AI
collaboration in design indicate that most AI design age of AI coding
assistants, treating specifications as the source tools support later
solution-generating stages, with few support- of truth from which code
is generated or verified rather than the ing early-stage problem
discovery \[1\]. Design-OS addresses this reverse \[17\]: Microsoft
promotes specifications as "version con- gap by providing a workflow
that spans from concept definition trol for your thinking," with
technical decisions made explicit and literature survey through to
design definition, extending the

                                                                       2

FIGURE 1: Design-OS workflow (abstract): five stages arranged around the
designer (central diamond), each executed by an AI agent (robot icon).
User interactions (numbered) between stages enable validation and
iteration. Each box shows the stage name, key artifacts, and commands.

specification-driven multi-agent paradigm to physical engineering and
constraints. It parallels the Business or Mission Analysis design.
process in INCOSE \[3\], task clarification in Pahl & Beitz \[4\], and
problem identification in DSRM \[27\]. Control education and the design
case. Control systems engi- neering and education have long relied on
canonical benchmark Stage 2: Literature Survey. An initial and focused
literature platforms---the inverted pendulum, ball-and-beam,
ball-and-plate, search is conducted, aligned with the project goals.
Artifacts in- and servo systems---to teach dynamics, underactuation, and
feed- clude a preliminary literature note, deep-research prompts,
scholar back design \[24, 25\]. Commercial platforms are widely
deployed, search queries, and literature reports. The designer
formulates and open-source alternatives are also available. Control
education structured research prompts describing the topics and gaps to
methodology emphasizes interactivity and structured use of tech-
investigate. AI research assistants (e.g., ChatGPT Deep Research, nology
\[26\]. Yet these systems are rarely situated within a formal, Claude,
Gemini) then execute these prompts and return candidate traceable design
process: the mapping from performance specifi- references, summaries,
and gap analyses. The designer curates the cations to controller
parameters is typically an in-paper exercise results---verifying that
cited works exist, removing hallucinated rather than a documented
workflow. Design-OS targets this gap references, and merging findings
into the preliminary literature by providing a specification-driven
workflow applicable to any note. The key outcome is a landscape of prior
work, identified of these platforms. We demonstrate it on two inverted
pendulum gaps, and references that feed conceptual design. This stage
en- platforms (Furuta and reaction wheel) and share a blank template
forces that design decisions are grounded in existing knowledge that can
be adapted to other projects. before any specification is written.

3 METHODOLOGY: DESIGN-OS Stage 3: Conceptual Design. Design objectives
(DOs), product Design-OS is a specification-driven, phased workflow for
engi- or publication structure, and a positioning narrative are
developed. neering system design. Each stage produces explicit artifacts
The designer determines what the artifact is, how it relates to that
inform the next, supporting a path to traceability from ini- prior work,
and what gap it fills. In a control design context, this tial
motivations to the final implementation plan (realizing such stage
identifies candidate modeling approaches, control strategies,
traceability in practice remains challenging and tool-dependent). and
system architectures. The conceptual design is fixed before The workflow
is designed to be lightweight enough for research committing to the
requirements definition, reducing downstream projects, capstone design,
and rapid iteration, while retaining the rework. rigor of formal
requirements management. Stage 4: Requirements Definition. Stage 4
proceeds in two Stage 1: Concept Definition. The designer captures con-
substeps: shape (define section-level requirements and structure) text,
mission, and scope in a structured project folder (e.g., and elaborate
(fill in detailed requirements with IDs, "shall" state- mission.md,
roadmap.md, tech-stack.md). This stage es- ments, source, priority, and
verification method). The specifi- tablishes the problem statement,
stakeholders, success criteria, cation also documents functions,
architecture, interfaces, and

                                                                      3

validation criteria. The specification is the binding contract be- 4.1
Stage 1--2: Concept Definition and Literature Sur- tween intent and
implementation: it serves as the single source vey of truth that governs
all downstream work. Standards discovered Context. The mission was
defined as follows: design a control during the process (e.g.,
requirements format, system structure system for a rotary inverted
pendulum that meets explicit per- templates) are documented alongside
the specification. formance specifications, with full traceability from
requirements to controller parameters across the mechanical, electrical,
and software domains. The roadmap established five phases (con- cept
definition, literature survey, conceptual design, requirements Stage 5:
Design Definition. A task breakdown, dependency definition, design
definition), and the tech stack was defined as ordering, and execution
plan are derived from the specification. MATLAB/Simulink for modeling
and control, with Python as an Each task maps to a specific deliverable
and to the requirement(s) alternative. it satisfies. In a control design
project, the plan might include: derive a mathematical model, design
controller gains from re- quirements, build a simulation, run
verification, and document Literature. A literature search targeted four
areas: traceability. (i) specification-driven and requirements-driven
design, (ii) systematic design methodology, (iii) AI-assisted design,
and (iv) control education and the inverted pendulum benchmark.
Structured deep-research prompts were formulated and executed
Traceability across stages. Traceability is maintained by link- by
multiple AI research assistants (Claude, Gemini). Each ing requirement
IDs to design parameters and to verification steps assistant
independently searched for and returned candidate (e.g., REQ-001 ↔
settling time ≤ 1.0 s ↔ state-feedback gain references, which were then
verified by the designer and merged K ↔ simulation step response). The
process is iterative within into a preliminary literature note. The
designer specified the stages, but stage order is respected: no design
definition is written research topics; the AI assistants independently
identified the before an agreed requirements definition, and no
requirements specific references within those topics. The following key
definition before a conceptual design. Figure 1 summarizes the papers
were surfaced by the AI-assisted search and, after stages and their main
artifacts. verification, informed the conceptual design: Furuta et
al. \[28\] for the original Furuta pendulum, Cazzolato and Prime \[35\]
for the definitive dynamics derivation, Hamza et al. \[5\] for the 4
DESIGN CASE: INVERTED PENDULUM benchmark survey, Quanser's rotary
pendulum workbook for hardware parameters and lab specifications, Skuric
et al. \[32\] We applied the Design-OS workflow to an inverted pendulum
con- for the SimpleFOC library and its example implementation trol
design project---a canonical benchmark in control education underlying
the open-source reaction wheel platform \[31\], and and research \[5,
28\]. Wright \[33\] for a validated reaction wheel pendulum platform The
AI-assisted literature search (Stage 2) mapped a land- designed for
controls education using SimpleFOC. scape of commercial and open-source
platforms for control ed- ucation, including Quanser (rotary and linear
pendulums) \[29\], 4.2 Stage 3: Conceptual Design and Domain Decom-
Feedback Instruments (Digital Pendulum) \[30\], and several open-
position hardware projects (SimpleFOC reaction wheel pendulum, 3D- Three
design objectives were defined: printable Furuta pendulums, cart-pole
kits). From this landscape, (DO-1) What state-feedback control design
satisfies the perfor- two platforms were selected at the feasibility
gate (Stage 3): mance specifications for each platform? (1) the Quanser
SRV02 Furuta-type rotary inverted pendulum, (DO-2) How do fundamentally
different platforms (SimpleFOC chosen for its extensive academic track
record---deployed in hun- reaction wheel vs. Quanser Furuta) satisfy the
same set of require- dreds of university labs worldwide with
ABET-aligned course- ments? ware and manufacturer-documented
parameters---and (2) the SimpleFOC-based reaction wheel inverted
pendulum \[31, 32\], (DO-3) How does cross-domain traceability flow from
perfor- chosen for its open-source hardware and software, comprehen-
mance specifications through software, electrical, and mechanical sive
build documentation, active community, and validated con- domains to
controller parameters? trol examples \[33\]. This selection demonstrates
that the same Two system architectures were identified (Figure 2): (a) a
specification-driven workflow and requirements can be satisfied
Furuta-type rotary inverted pendulum with state vector x = by
fundamentally different implementations---one commercial, \[θ, α, θ̇,
α̇\]⊤ (4 states, 2-DOF), and (b) a reaction wheel inverted one
open-source. Full artifacts for this design case, along with a pendulum
with state vector x = \[θ, θ̇, ϕ̇\]⊤ (3 states, 2-DOF), where blank
Design-OS template for other potential projects, are avail- θ is the
pendulum angle and ϕ̇ is the reaction wheel angular veloc- able in a
public GitHub repository \[34\]. ity \[33\].

                                                                        4

phase resistance R) instead of a geared DC servo. The software domain
uses Arduino/C++ with the SimpleFOC library instead of MATLAB/Simulink.

                                                            lum
                     m




                                                           pendu
                   pendulu                                                   Feasibility gate. Before proceeding to Requirements Definition
                                                                             (Stage 4), a validation gate was run. The cost comparison (Table 4)
                                                                             was produced at this gate: the SimpleFOC-based reaction wheel
                                                                             pendulum [31] ($100–200, open-source Arduino/C++ stack) was
                                                                             compared against the Quanser SRV02 platform ($5k+, propri-
                                                                             etary MATLAB/QUARC licensing). The SimpleFOC platform

FIGURE 2: Two inverted pendulum architectures: Furuta (left) offers
accessibility while eliminating licensing constraints. The and reaction
wheel (right). Quanser platform provides manufacturer-documented
parameters and an established lab infrastructure. Wright \[33\]
demonstrated that the SimpleFOC-class platform can be fully
characterized Literature-driven domain discovery. The domain decomposi-
through system identification (pendulum inertia, damping, mo- tion was
driven by the literature surfaced in Stage 2---the designer tor torque
constant, phase resistance), providing the parameter specified the
topics, and the AI assistants returned the specific certainty needed for
model-based control design. Software licens- references that established
each domain. Furuta et al. \[28\] and ing was assessed: Python and
Arduino/C++ are freely available; Cazzolato and Prime \[35\] describe
the two-link arm--pendulum MATLAB/Simulink is proprietary. The designer
confirmed at a system with Euler--Lagrange formulation, establishing the
me- user checkpoint that both platforms would be carried forward: the
chanical domain. The Quanser SRV02 documentation describes SimpleFOC
reaction wheel pendulum as the primary open-source the DC servo motor,
gearbox, encoders, and power amplifier--- platform, and the Quanser as a
well-documented commercial com- establishing the electrical domain and
the torque equation in parison. A Python simulation was specified for
reproducibility. Eq. (1) that couples it to mechanical torque. The
control design 4.3 Stage 4: Requirements Definition literature (pole
placement, state feedback) and simulation environ- ment
(MATLAB/Simulink) establish the software domain. Where The Requirements
Definition stage produced requirements orga- literature was ambiguous
(e.g., whether the DAQ interface board nized by domain (Table 1).
Performance requirements (REQ-01-- belongs to electrical or software),
the designer was consulted at a 04) are system-level. Domain-specific
requirements (mechanical, user checkpoint. The three domains identified
are: electrical, software) ensure that the full mechatronic design is
captured and traceable. Mechanical: rotary arm (length Lr , inertia Jr ,
damping Br ) and pendulum link (length L p , mass m p , inertia J p ,
damping B p ). Two-link dynamics derived via the Euler--Lagrange
equations. Modeling (mechanical + electrical). The nonlinear equations
of motion are derived via the Euler--Lagrange method. Letting
Electrical: DC servo motor (Rm , km , kt ), gearbox (Kg , ηg , ηm ), q =
\[θ, α\]⊤ , the dynamics take the matrix form: power amplifier, and
rotary encoders for θ and α. The torque equation: D(q) q̈ + C(q, q̇) q̇ +
g(q) = τ, (2) ηg Kg ηm kt (Vm − Kg km θ̇) where D is the inertial matrix,
C the damping/Coriolis matrix, g τ= (1) the gravitational vector, and τ
the torque vector. After lineariza- Rm couples the electrical domain
(voltage Vm ) to the mechanical tion about the upright equilibrium and
incorporation of the motor domain (torque τ). torque in Eq. (1) (REQ-05,
REQ-07), the linear state-space model is: Software: state-feedback
control law u = K(xd − x), state esti- mation from encoders via
differentiation with high-pass filtering, ẋ = Ax + Bu, y = Cx + Du, (3)
controller enable/disable logic, simulation environment. where u = Vm .
Using Quanser SRV02 parameters: 0 0 1 0   0      The
state-space matrices A and B encode the coupling: 0 0 0 1    0
 rows 3--4 of A and B incorporate the motor torque equation in  A =
 , B =  . (4) Eq. (1), making the electrical parameters (Rm
, km , kt , Kg ) part of 0 80.3 −45.8 −0.93 83.4 the plant
model. The same three-domain decomposition applies 0 122 −44.1 −1.40
80.3 to the reaction wheel pendulum, with different specifics: the me-
The entries in rows 3--4 reflect the coupling of mechanical chanical
domain is a single-link pendulum with a reaction wheel parameters (m p ,
L p , Jr , J p ) with electrical parameters (Rm , km , (inertia Iw )
instead of a rotary arm. The electrical domain uses kt , Kg ). The
open-loop poles {7.12, 0, −5.95, −48.37} confirm a BLDC motor with
field-oriented control (torque constant Kt , instability.

                                                                         5

TABLE 1: Requirements by domain for the rotary inverted pendu- TABLE 2:
Simulation verification of performance requirements. lum. REQ
Specification Simulation Result ID Domain Requirement (shall) Verif. 01
ζ = 0.7 ζ = 0.700 Pass REQ-01 Perf. Damping ratio ζ = 0.7 Sim. 02 ωn = 4
rad/s ωn = 4.000 rad/s Pass REQ-02 Perf. Natural freq. ωn = 4 rad/s Sim.
03 \|α\| \< 15◦ \|α\|max = 2.9◦ Pass REQ-03 Perf. \|α\| \< 15 deg Sim.
04 \|Vm \| \< 10 V \|Vm \|max = 0.5 V Pass REQ-04 Perf. \|Vm \| \< 10 V
Sim. REQ-05 Mech. State-space from Review first-principles EOM + TABLE
3: Cross-domain traceability: requirement → domain flow linearization →
verification. REQ-06 Mech. Parameters documented Review with source REQ
Domain flow Verification REQ-07 Elec. Actuator dynamics (Rm , Review 01,
02 Perf → SW (gain K) → Elec Sim. step resp. km , kt , Kg ) in model (Vm
) → Mech (τ) REQ-08 Elec. Encoders measure θ, α Review 03 Perf → Mech
(pendulum α) Sim. deflection REQ-09 SW Control at sufficient Review 04
Perf → Elec (amplifier limit) Sim. Vm sampling rate 05 Mech + Elec → A,
B matrices Derivation REQ-10 SW Velocity estimation with Review 07 Elec
(Rm , km , kt , Kg ) → A, B Review filtering 11 SW (pole placement) → K
Design rationale REQ-11 SW Gains from requirements Review (pole
placement) REQ-12 All Traceability table: REQ → Review performance
specifications through the gain computation to the param → verif.
closed-loop response (REQ-11).

                                                                              Simulation verification (REQ-01–04). A Python simulation

Reaction wheel pendulum model. For the SimpleFOC reaction was generated
by the Design-OS /generate-simulation com- wheel pendulum, the state
vector is x = \[θ, θ̇, ϕ̇\]⊤ with input u = τm mand directly from the
specification artifacts. The script builds (motor torque). Wright \[33\]
derived the linearized model via the state-space model from documented
parameters, computes Lagrangian mechanics and identified parameters
through system gain K via pole placement, and simulates the closed-loop
step identification (oscillation period → inertia, logarithmic decrement
response. Table 2 summarizes the verification results: all four →
damping, torque--current characterization → Kt ). The resulting
performance requirements pass. The simulation code, plots, and
state-space matrices are: verification report are included in the
repository alongside the     specification artifacts, completing the
traceability chain from re-  0 1 0  0   Arw =  30.86
−0.58 0, Brw = −127.9.    (5) quirements through design
parameters to numerical verification. −30.86 0.58 0 5652.8     4.4
Cross-Domain Traceability and Platform Compar- The structure mirrors the
Furuta model: the A matrix encodes ison the gravitational instability
(positive entry a21 = 30.86) and the B Cross-domain requirement flow. A
key insight is that perfor- matrix encodes the motor torque coupling,
but with three states in- mance requirements flow through all three
domains. For example, stead of four. This illustrates how the same
Design-OS workflow REQ-01 (ζ = 0.7) determines the closed-loop pole
locations (soft- produces analogous but distinct state-space models for
different ware: pole placement → gain K), which determine the voltage
platforms---both traceable to their respective parameters and re-
command Vm (electrical: motor equation), which produces torque
quirements. τ (mechanical: arm and pendulum dynamics). Table 3 summa-
rizes this cross-domain traceability. Control design (software domain,
REQ-11). A state-feedback controller u = K(xd − x) is designed via pole
placement. The Platform comparison (feasibility gate output). As
produced dominant closed-loop polespare placed at p1,2 = −σ ± jωd where
by the feasibility gate in Stage 3, Table 4 compares two imple- σ = ζωn
= 2.8 and ωd = ωn 1 − ζ 2 = 2.86 rad/s, satisfying REQ- mentations
satisfying the same requirements: (1) the SimpleFOC- 01 and REQ-02. The
gain vector K is computed analytically from based reaction wheel
pendulum (open-source, BLDC motor, Ar- the desired characteristic
polynomial, ensuring traceability from duino) \[31\], and (2) the
Quanser SRV02 with Furuta pendulum

                                                                          6

TABLE 4: Platform comparison: same requirements, different satisfying
those requirements rather than iterating by trial and implementations.
error. Second, the explicit literature stage prevented premature
commitment to a solution. The conceptual design was informed Domain
SimpleFOC Quanser SRV02 by a landscape of prior work rather than by the
first approach Mechanical 3D-printed, sys. ID Aluminum arm + that came
to mind. Third, the phased structure made the de- needed \[33\]
pendulum, known params sign process auditable: a reviewer (or
instructor) can inspect the Electrical BLDC + FOC driver, DC servo,
gearbox, chain from mission to requirements to parameters to
verification. Arduino commercial DAQ Fourth, the literature-driven
domain decomposition prevented the Software C++ + SimpleFOC lib.
MATLAB/Simulink, AI from fabricating system structure: each domain
boundary was QUARC grounded in published work. Fifth, the validation
gates surfaced Pendulum Reaction wheel Furuta (2-DOF) cost and
feasibility constraints early---particularly the Quanser vs. (2-DOF)
SimpleFOC comparison---preventing commitment to infeasible Cost
∼\$100--200 ∼\$5k+ approaches. Sixth, user checkpoints ensured that the
designer retained authority over decisions where literature was
insufficient, supporting genuine human--AI teaming. (commercial,
proprietary, DC servo). Both satisfy the perfor- mance requirements
(REQ-01--04), but through different me- Comparison with typical
practice. In typical control design chanical configurations (reaction
wheel vs. arm-driven Furuta, coursework and many research projects, the
path from perfor- both 2-DOF), different electrical subsystems (BLDC
with field- mance specifications to controller gains is an in-paper or
in-lab oriented control vs. DC servo), and different software stacks
(Ar- exercise: students receive specifications (e.g., damping ratio,
set- duino/C++ vs. MATLAB/Simulink). The domain-specific require- tling
time), compute gains, and report results. The mapping ments (REQ-05--12)
make these differences explicit and traceable. from intent to parameters
exists but is rarely documented as a Wright \[33\] validated a
SimpleFOC-class reaction wheel pendu- traceable workflow. Design-OS adds
a thin but explicit layer of lum with full system identification and
state-feedback control, structure---concept definition, literature
survey, conceptual de- demonstrating that the open-source platform can
achieve model- sign, requirements definition, design definition---that
makes this based control design comparable to commercial platforms. The
mapping inspectable and reproducible. Compared to full MBSE feasibility
gate found that the SimpleFOC platform costs ∼50× or VDI 2206 processes,
Design-OS is lighter weight and does not less and removes licensing
constraints, while requiring system require specialized modeling
languages (e.g., SysML, Modelica) identification for parameter
characterization. or dedicated MBSE platforms---it operates on
structured Mark- down artifacts with AI models (e.g., Claude Opus 4.6)
preferably 4.5 AI Model Comparison inside an IDE (e.g., VS Code).
Compared to ad hoc approaches, To assess whether the Design-OS workflow
produces consistent it provides structure to support traceability and
reproducibility. results across AI models, we ran the same pipeline
(from plan- project through generate-simulation) with two proprietary
mod- Limitations. Several limitations should be noted. First, main- els:
Claude Opus 4.6 (Anthropic) and Gemini 3.1 Pro (Google). taining the
specification introduces overhead: writing and updat- This comparison
evaluates which stages each model handles well, ing requirements,
traceability tables, and implementation plans where outputs diverge, and
whether the structured commands are takes time that would otherwise be
spent on implementation. For sufficient to guide consistent results
across models. Table 5 rates very small projects, this overhead may not
be justified. Sec- each model's output quality per Design-OS stage;
Table 6 sum- ond, the workflow requires discipline in respecting stage
order; marizes the type and frequency of human corrections required. in
practice, designers may be tempted to skip ahead to imple- Early
indicators suggest that the structured command format mentation before
finalizing the specification. Third, end-to-end and explicit user
checkpoints reduce model-dependent variation. traceability from intent
to parameters remains challenging and tool-dependent ---the workflow
structures for it conceptually, but the degree to which it can be made
fully explicit depends on the 5 DISCUSSION tools and environment.
Fourth, the design case presented here What worked. The Design-OS
workflow proved effective for is a well-understood benchmark. Applying
Design-OS to novel structuring the progression from context and
literature through or poorly understood systems where requirements are
harder to to requirements and implementation plan. Several aspects stood
specify upfront remains to be validated. Fifth, the validation gates
out. First, the specification served as the single source of truth as
currently implemented are lightweight checklists rather than and reduced
ad hoc decisions during implementation: once re- formal analysis; for
safety-critical systems, more rigorous gate quirements were formalized
with IDs, "shall" statements, and criteria would be needed. Sixth, the
user checkpoints rely on the verification methods, the controller design
became a matter of designer being available and engaged; in a fully
asynchronous

                                                                      7

TABLE 5: AI model output quality by Design-OS stage. Source data:
log/report_claude.md, log/report_gemini.md.

                                 Claude Opus 4.6                                        Gemini 3.1 Pro
     Overview                    36 artifacts, 29 checkpoints, 24 corrections. Python   ∼25 artifacts, 28 checkpoints, 14 corrections.
                                 (model choice). Platforms: Quanser SRV02 +             MATLAB (tech-stack). Platforms: Quanser QUBE +
                                 SimpleFOC reaction wheel.                              ESP32.
     Stage 1: Concept Def.       Complete — 0 errors. Mission, roadmap, tech stack      Complete — 0 errors. Mission, roadmap, tech stack
                                 correct; open tech stack appropriately deferred.       correct; MATLAB explicitly committed.
     Stage 2: Lit. Survey        Good — 21 ref. errors caught by                        Fair — 55 sources; 2 citation mismatches found by
                                 /verify-references; 8-theme coverage; pipeline         post-hoc /verify-references (2026-03-07); step
                                 step self-initiated.                                   not self-initiated.
     Stage 3: Concept. Design    Good — 1 DOF factual error (1-DOF stated, 2-DOF        Good — 1 domain error (Control/Math domain
                                 correct); platform selection and functions correct.    missing from decomposition); platforms, functions
                                                                                        correct.
     Stage 4: Req. Def.          Good — 12 requirements, 4 formal standards             Poor — 7 requirements; /validate-feasibility
                                 (/discover-standards); 2 minor corrections.            gate skipped; /discover-standards not run; 3
                                                                                        specification errors: scope deviation, phantom
                                                                                        REQ-HWW IDs, HIL in REQ-IMP-002.
     Stage 5: Design Def.        Complete — both platforms ALL PASS;                    Fair — both platforms pass; execution order
                                 specification-driven order maintained; 1 numerical     corrected; tool mismatch between MATLAB artifacts
                                 error (open-loop poles).                               and Python report.


        TABLE 6: Human corrections needed per model.                        Implications for AI-assisted design. Design-OS’s phased ar-
                                                                            tifacts are well-suited to AI-assisted workflows. Each stage pro-
       Correction         Claude Opus 4.6    Gemini 3.1 Pro                 duces structured documents (mission, literature notes, require-
       Factual errors           20                  1                       ments, implementation plans) that can be generated or reviewed
       Missing reqs.             0                  1                       by large language models. The specification serves as a shared
       Halluc. refs.             3                  2                       contract between human designers and AI agents, aligning with
                                                                            the philosophy of GitHub Spec Kit and Microsoft specification-
       Struct. deviat.           1                  9
                                                                            driven development. Multi-agent frameworks such as MetaGPT
       Domain errors             0                  1
                                                                            [19] could be adapted to execute Design-OS stages, with agents
       Total                    24                  14                      assigned to literature search, conceptual design, specification
                                                                            elaboration, and implementation planning.

workflow, the interruptions may disrupt flow. Future work. Future work
includes applying Design-OS to additional design cases beyond the
inverted pendulum family, Implications for education. For engineering
design education, extending the AI model comparison to open-weight
models (e.g., the workflow makes the design process visible and provides
a Kimi K2.5), tightening integration with AI agents (e.g., auto-
structure within which students can be assessed not only on their mated
literature summarization, specification-to-task decompo- final
controller performance but on the quality of their require- sition, and
requirement verification), and exploring tooling that ments, the
traceability of their design decisions, and the complete- better
supports intent-to-parameter traceability. We also plan to ness of their
documentation. The phased structure also provides evaluate the workflow
in a classroom setting with student teams. natural checkpoints for
instructor feedback. Whether this struc- ture has the potential to ease
learning is not evident from this paper and would require evaluation in
a classroom or controlled 6 CONCLUSION setting. We plan such studies as
future work. The blank template We presented Design-OS, a lightweight,
specification-driven, shared alongside this paper can be adapted to
mechatronics and phased workflow for engineering system design (concept
defi- control systems courses; the inverted pendulum design case in-
nition → literature survey → conceptual design → requirements cludes
both a low-cost SimpleFOC reaction wheel platform and a definition →
design definition), enhanced with literature-driven commercial Quanser
Furuta platform, giving instructors flexibility domain decomposition,
validation gates between stages, and in hardware selection. user
checkpoints for human--AI teaming. We positioned it rel-

                                                                        8

ative to specification-driven and requirements-driven design---
requirements traceability". IEEE Transactions on Software Engineer-
including industry practice such as GitHub Spec Kit and Mi- ing, 27(1),
pp. 58--93. \[14\] IEEE, 1998. "IEEE Recommended Practice for Software
Require- crosoft specification-driven development---systematic design
ments Specifications". IEEE Std 830-1998, pp. 1--40. frameworks, and
AI-assisted design. We demonstrated the work- \[15\] ISO/IEC/IEEE, 2018.
"ISO/IEC/IEEE International Standard - Sys- flow on an inverted pendulum
control design project using two tems and software engineering -- Life
cycle processes -- Requirements platforms---an open-source SimpleFOC
reaction wheel pendulum engineering". ISO/IEC/IEEE 29148:2018(E),
pp. 1--104. \[16\] Mavin, A., Wilkinson, P., Harwood, A., and Novak, M.,
2009. "Easy and a commercial Quanser Furuta pendulum---showing how the
approach to requirements syntax (EARS)". In 2009 17th IEEE same
specification-driven workflow and requirements can be sat- international
requirements engineering conference, IEEE, pp. 317-- isfied by
fundamentally different implementations, how domain 322. decomposition
was driven by literature references, how valida- \[17\] Piskala, D. B.,
2026. Spec-driven development: from code to contract in the age of AI
coding assistants. arXiv:2602.00180. tion gates surfaced cost and
feasibility constraints, and how user \[18\] Gero, J. S., 1990. "Design
prototypes: a knowledge representation checkpoints ensured designer
authority over decisions where liter- schema for design". AI Magazine,
11(4), pp. 26--36. ature was insufficient. Design-OS extends the
specification-driven \[19\] Hong, S., Zheng, X., Chen, Y., Cheng, J.,
Zhang, C., Wang, Z., Xu, multi-agent paradigm to physical engineering
system design. We Q., et al., 2024. "MetaGPT: meta programming for a
multi-agent collaborative framework". In International Conference on
Learning share a blank Design-OS template and the full design-case arti-
Representations (ICLR). facts in a public GitHub repository \[34\] to
demonstrate generality \[20\] Qian, C., et al., 2024. "ChatDev:
communicative agents for software and support replicability testing.
Future work will apply the work- development". In Proceedings of the
ACL, pp. 15174--15186. \[21\] Zadenoori, M. A., Dabrowski, ˛ J.,
Alhoshan, W., Zhao, L., and Ferrari, flow to further design cases,
deepen integration with AI-assisted A., 2025. Large language models for
requirements engineering: a tools, evaluate in classroom settings, and
conduct sandbox repli- systematic review. arXiv:2509.11446. cability
testing across multiple AI models and independent users. \[22\] Ma, K.,
Grandi, D., McComb, C., and Goucher-Lambert, K., 2023. "Conceptual
design generation using large language models". In Inter- national
Design Engineering Technical Conferences and Computers REFERENCES and
Information in Engineering Conference, Vol. 87349, American \[1\] Lee,
M., Law, E., and Hoffman, R. R., 2024. "When and how to Society of
Mechanical Engineers, p. V006T06A021. use AI in the design process?".
International Journal of Human-- \[23\] Zhu, Q., and Luo, J., 2022.
"Generative pre-trained transformers Computer Interaction, 41(2),
pp. 1569--1584. (GPT) for design concept generation: an exploration".
Proceedings \[2\] Massoudi, S., and Fuge, M., 2025. "Agentic large
language models of the design society, 2, pp. 1825--1834. for conceptual
systems engineering and design". In International \[24\] Awtar, S.,
King, N., Allen, T., Bang, I., Hagan, M. D., Skidmore, D., Design
Engineering Technical Conferences and Computers and In- and Craig, K.,
2002. "Inverted pendulum systems: rotary and arm- formation in
Engineering Conference, Vol. 89237, American Society driven---a
mechatronic system design case study". In Mechatronics, of Mechanical
Engineers, p. V03BT03A045. Vol. 12, pp. 357--370. \[3\] Walden, D. D.,
Shortell, T. M., Roedler, G. J., Delicado, B. A., \[25\] Boubaker, O.,
2013. "The inverted pendulum benchmark in nonlinear Mornas, O., Ip,
Y.-S., and David, E., 2023. Systems Engineering control theory: a
survey". International Journal of Advanced Robotic Handbook: A Guide for
System Life Cycle Processes and Activities, Systems, 10(5). 5th
ed. Wiley, Hoboken, NJ. \[26\] Dormido Bencomo, S., 2004. "Control
learning: present and future". \[4\] Pahl, G., Beitz, W., Feldhusen, J.,
and Grote, K.-H., 2007. Engineer- Annual Reviews in Control, 28(1),
pp. 115--136. ing design: a systematic approach, 3rd ed. Springer.
\[27\] Peffers, K., Tuunanen, T., Rothenberger, M. A., and Chatterjee,
S., \[5\] Hamza, M. F., Yap, H. J., Choudhury, I. A., Isa, A. I., Zimit,
A. Y., 2007. "A design science research methodology for information and
Kumbasar, T., 2019. "Current development on using rotary systems
research". Journal of Management Information Systems, inverted pendulum
as a benchmark for testing linear and nonlinear 24(3), pp. 45--77.
control algorithms". Mechanical Systems and Signal Processing, \[28\]
Furuta, K., Yamakita, M., and Kobayashi, S., 1992. "Swing-up 116,
pp. 347--369. control of inverted pendulum using pseudo-state feedback".
Pro- \[6\] GitHub, 2025. GitHub spec kit.
https://github.com/github/spec-kit. ceedings of the Institution of
Mechanical Engineers, Part I, 206(6), Accessed: 2026-02-01.
pp. 263--269. \[7\] Microsoft, 2025. Specification-driven development:
Spec Kit. https: \[29\] Quanser, 2026. Research papers. Quanser
Community.
//developer.microsoft.com/blog/spec-driven-development-spec-kit. \[30\]
Feedback Instruments, 2025. Digital pendulum system 33-005-PCI.
Accessed: 2026-02-01. Feedback Instruments (distributed by LD
Didactic/Leybold). \[8\] Gräßler, I., and Hentze, J., 2020. "The new
V-model of VDI 2206 \[31\] SimpleFOC Community, 2023. Reaction wheel
inverted pendulum: and its validation". at--Automatisierungstechnik,
68(5), pp. 312--324. Arduino SimpleFOC. \[9\] Cooper, R. G., 1990.
"Stage-gate systems: a new tool for managing \[32\] Skuric, A., Bank, H.
S., Unger, R., Williams, O., and González- new products". Business
Horizons, 33(3), pp. 44--54. Reyes, D., 2022. "SimpleFOC: a field
oriented control (FOC) library \[10\] Nuseibeh, B., and Easterbrook, S.,
2000. "Requirements engineering: for controlling brushless direct
current (BLDC) and stepper motors". a roadmap". In Proceedings of the
Conference on the Future of Journal of Open Source Software, 7(74),
p. 4232. Software Engineering, ACM, pp. 35--46. \[33\] Wright, Z., 2023.
"Design and implementation of a prototype pendu- \[11\] Zave, P., and
Jackson, M., 1997. "Four dark corners of require- lum platform for
aerospace controls education". M.S. thesis, Califor- ments engineering".
ACM Transactions on Software Engineering nia Polytechnic State
University, San Luis Obispo, June. and Methodology (TOSEM), 6(1),
pp. 1--30. \[34\] Bank, H. S., Herber, D. R., and Bradley, T. H., 2026.
Design- \[12\] Gotel, O., and Finkelstein, A., 1994. "An analysis of the
require- OS: Specification-driven framework for engineering system
design. ments traceability problem". In Proceedings of IEEE
International https://github.com/bankh/design-os. Accessed: 2026-03-12.
Conference on Requirements Engineering, IEEE, pp. 94--101. \[35\]
Cazzolato, B. S., and Prime, Z., 2011. "On the dynamics of the \[13\]
Ramesh, B., and Jarke, M., 2001. "Toward reference models for

                                                                             9

Furuta pendulum". Journal of Control Science and Engineering, command
reads the literature artifacts, extracts every cited reference (author,
ti- 2011, p. 528341. tle, year, venue), and checks each against web
sources (publisher pages, Google Scholar, DOI resolvers). It produces an
append-only corrections log documenting: (1) hallucinated references (no
matching publication found), (2) wrong-author A DESIGN-OS COMMANDS
attributions, (3) incorrect years or venues, and (4) minor errors
(initials, title Table 7 lists the Design-OS commands, organized by
workflow stage. Each wording). The corrections log ensures that
fabricated citations do not propagate command is a structured Markdown
prompt file that defines the stage's process into the specification.
This command is fully automated and does not require user steps,
expected inputs and outputs, and validation checks. Commands are
executed checkpoints. by invoking them as slash commands (e.g.,
/plan-project) in an IDE with appropriate AI model support (e.g., VS
Code). They are model-agnostic by design. A.3 Stage 3: Conceptual Design
The full prompt files are available in the public repository \[34\]
along with detailed /conceptual-design. Transforms the literature and
project context explanations of the runtime requirements and individual
commands. into a first conceptual design. The command proceeds through:
(1) formulating design objectives (DOs); (2) identifying candidate
methodologies and approaches The remainder of this appendix provides
detailed definitions of each command. grounded in the literature; (3)
defining functions and needs the system must satisfy; Each command file
follows a common template: (1) a preamble stating the (4) generating
concepts (candidate solutions or architectures); (5) proposing a high-
command's role in the workflow, (2) important guidelines that constrain
the level structure (e.g., paper outline, system architecture, or module
breakdown). agent's behavior, (3) a workflow validation block that
checks prerequisites before The command explicitly requires that design
objectives and methodologies are execution begins, and (4) a numbered
process with 5--10 steps, each producing a fixed before concepts are
generated, enforcing the principle that the problem named artifact.
framing precedes solution generation. Interactive checkpoints include:
What are A.1 Stage 1: Concept Definition the primary design objectives?,
What formal methodologies will we use?, What are the main functions and
stakeholder needs?, What solution concepts or platforms /plan-project.
Establishes the foundational design context through in- will we target?,
and a literature sufficiency check. teractive dialogue with the
designer. The command walks through three areas: (1) the design
mission---problem statement, stakeholders, success criteria, and con-
straints; (2) a roadmap defining the project phases, milestones, and
deliverables; /domain-decomposition. Identifies the constituent domains
of the (3) the tech stack---tools, languages, simulation environments,
and hardware plat- system---typically mechanical, electrical, and
software for mechatronic systems--- forms. The agent asks one question
at a time, confirms each answer, and writes the with every proposed
domain boundary traceable to at least one literature reference results
to three files (mission.md, roadmap.md, tech-stack.md) in the project
from Stage 2. The command reads the literature and conceptual design
artifacts, folder. If existing project documents are found, the command
reads them first proposes domains with citations, identifies
inter-domain interfaces (e.g., the and proposes updates rather than
starting from scratch. The output forms the torque equation coupling
electrical voltage to mechanical torque), and performs input context for
all subsequent stages. Interactive checkpoints include: What a gap
assessment that flags domain boundaries or interfaces where literature
is system or design problem are we addressing?, Who are the stakeholders
or users?, insufficient. When gaps are found, the command surfaces a
user checkpoint What constraints or success criteria matter?, What are
the main design phases rather than fabricating justifications.
Interactive checkpoints include: Are these or milestones?, What comes
first and what follows?, What tools does the project domains correct?
Should any be added, merged, or removed?, What are the inter- use?, and
What formal methods or frameworks are you using? domain interfaces?, and
a gap assessment asking whether to flag gaps or provide information. The
decomposition output feeds directly into Stage 4 (Requirements A.2 Stage
2: Literature Survey Definition), where requirements are organized by
domain. /literature-search. Runs an initial landscape literature search
A.4 Gate aligned with the project mission and roadmap. The command reads
the Stage 1 artifacts, then produces three outputs: (1) deep-research
prompts---structured /validate-feasibility. Runs a feasibility gate
check between ma- queries designed to be executed by AI research
assistants (e.g., deep research jor stages. The command can be invoked
at any gate and assesses four dimensions: tools) that request a single
comprehensive report covering all relevant aspects of (1) technical
feasibility---whether the proposed approach is realizable with the the
design problem; (2) scholar search queries---keyword and Boolean queries
chosen architecture, components, and methods; (2) cost
assessment---comparing formatted for academic search engines (Google
Scholar, IEEE Xplore, etc.); (3) a platform and component costs (e.g.,
commercial vs. open-source hardware); (3) li- preliminary literature
note synthesizing what is known from the agent's training censing and
IP---evaluating software licensing constraints (proprietary vs. open-
data, explicitly marking claims that require verification. The scope is
deliberately source), patent considerations, and data access; (4)
availability and procurement--- preliminary: the command surfaces the
landscape and identifies gaps rather than checking whether required
components, platforms, or tools are accessible. The producing a final
literature review. The designer is asked: What topics or domains gate
produces a feasibility report with candidate constraints that may become
should the literature search cover? requirements in Stage 4. Interactive
checkpoints include: Are any technical con- cerns blockers?,
Cost---estimates and budget constraints?, and a go/no-go decision on
whether to proceed, iterate, or adjust scope. /focused-literature (after
Stage 3). Runs a targeted literature search driven by the conceptual
design output. Unlike the initial landscape search, A.5 Stage 4:
Requirements Definition this command focuses on specific gaps, domain
boundaries, or technical questions identified during conceptual design
and domain decomposition. It requires the /spec. Structures the
specification by defining section-level requirements and the spec
layout. This command must be run in plan mode (i.e., the agent
conceptual design artifacts as input, generates focused deep-research
prompts and plans the spec structure before writing it). It reads the
conceptual design, domain scholar queries scoped to the identified gaps,
and produces a focused literature decomposition, and literature
artifacts, then produces: (1) a shape document report. The command also
supports an optional standards search when the concep- defining the spec
sections, their scope, and the requirement categories; (2) a stan- tual
design identifies regulatory or normative requirements. The designer is
asked dards document listing relevant standards and conventions
discovered during the to confirm or adjust the focus areas before the
search proceeds. process; (3) a references document linking spec
sections to their source literature. The spec folder structure is
generated with placeholder files for requirements, /verify-references
(after focused literature). Verifies all ref- interfaces, validation
criteria, and traceability. Interactive checkpoints include: erences
cited in the preliminary and focused literature notes by web search. The
What are we designing?, Are visuals needed?, What reference
implementations

                                                                                        10

TABLE 7: Design-OS commands by stage.

         Stage                         Command                          Purpose
         1: Concept Definition         /plan-project                    Establish mission, roadmap, and tech stack through interactive dialogue
         2: Literature Survey          /literature-search               Run landscape search and produce lit note, deep-research prompts, and scholar queries
                                       /focused-literature              Targeted search driven by conceptual design gaps
                                       /verify-references               Web-verify cited references and log corrections
         3: Conceptual Design          /conceptual-design               Develop design objectives (DOs), methodologies, and high-level structure from literature
                                       /domain-decomposition            Identify system domains and interfaces from literature references
         Gate                          /validate-feasibility            Gate check: cost, licensing, component availability, technical feasibility
         4: Requirements Def.          /spec                            Structure section-level requirements and specification layout (plan mode)
                                       /discover-standards              Extract recurring design patterns into documented standards
                                       /index-standards                 Rebuild standards index for quick matching by /inject-standards
                                       /inject-standards                Apply relevant standards to current work context
         5: Design Definition          /plan-implementation             Derive task breakdown and dependency ordering from specification
                                       /generate-simulation             Generate executable verification code from specification and model

apply?, and a consistency check against existing project artifacts. The
spec output and presents them to the designer with a recommendation.
Standards can be serves as the scaffold for the elaborate-spec step
(manual or command-driven), injected automatically (e.g., when writing a
new spec section, the requirements where detailed requirements with IDs,
"shall" statements, priority, source, and format standard is surfaced)
or explicitly by the designer. This command ensures verification method
are filled in. consistency across artifacts and stages without requiring
the designer to manually consult the standards directory.
/discover-standards. Extracts recurring design patterns from the project
into concise, documented standards stored in a dedicated standards/ A.6
Stage 5: Design Definition directory. The command analyzes the current
project artifacts (code, specs, docu- /plan-implementation. Turns an
elaborated spec into a concrete im- mentation), identifies patterns that
should be codified (e.g., requirements format, plementation plan and
task list. The command reads the spec folder (requirements, naming
conventions, system structure templates), and for each proposed standard
interfaces, validation criteria, traceability), detects the project
context (e.g., con- asks the designer why the pattern matters before
writing it. Standards are indexed trol system, software module,
mechatronic subsystem), and produces: (1) an in a YAML file for
discoverability. The designer is asked: Which areas should
implementation plan with ordered tasks, each tied to specific
requirements and de- be documented as standards? This command can be run
at any point during the liverables; (2) a dependency graph showing which
tasks must precede others; (3) a workflow but is most useful during or
after Stage 4 (Requirements Definition) task list (e.g., a checklist or
todo list) for execution tracking. The designer con- when patterns have
emerged. firms artifact structure, execution order, and deliverables.
The command ensures that every requirement in the spec has at least one
corresponding implementation task. /index-standards. Rebuilds and
maintains the standards index file (standards/index.yml). The index maps
each standard to a brief description, enabling /inject-standards to
suggest relevant standards without reading /generate-simulation.
Generates executable simulation code di- all files. The command scans
all Markdown files in the standards/ directory, rectly from the
elaborated spec artifacts. The command reads the requirements compares
them against the existing index, and for each new file proposes a
document (specifically performance requirements with numerical targets),
the one-sentence description for the designer to confirm. Deleted files
are removed system model (state-space matrices, transfer functions, or
equations of motion), from the index. The command is also run
automatically as the final step of and the traceability table, then
produces simulation code that: (1) builds the system
/discover-standards. Interactive checkpoints include confirming or
editing model from documented parameters, (2) implements the control law
or design the proposed description for each new standard. under test,
(3) runs verification scenarios (e.g., step response, disturbance rejec-
tion), and (4) checks each performance requirement against simulation
results, reporting pass/fail with numerical values. The command chooses
the simulation /inject-standards. Applies relevant standards from the
standards/ language based on the tech stack (e.g., Python or MATLAB) and
ensures that the directory to the current work context. The command
reads the standards index, generated code is self-contained,
reproducible, and directly traceable to the spec. analyzes the current
task or artifact being worked on, matches applicable standards, This
command is fully automated and does not require user checkpoints.

                                                                                       11


