# Attribution and Design Lineage

ASTIS is not a copy of any single automation system. It is a Lean-first
SDE/Sampling proof system whose design is shaped by source fidelity, hidden
regularity, conditional laws, weak generators, KL/FI/LSI chains,
Euler--Maruyama discretization, and the need to preserve reusable formal
mathematical memory.

| Source | Design idea absorbed by ASTIS | ASTIS-specific boundary | Why it matters here |
|---|---|---|---|
| [Sinho Chewi, *Log-Concave Sampling*](https://chewisinho.github.io/main.pdf) | Primary textbook order, theorem route, calculations, constants, and cited mathematical background. | The public draft exposes no explicit wholesale-republication license. ASTIS uses faithful original paraphrase, precise source anchors, separate supplemental derivations, and ASTIS-owned Lean declarations. Chewi does not participate in, endorse, or maintain ASTIS. | Readers can follow the textbook route while opening rigorous conditions and formal dependencies that compact prose often suppresses. |
| Sho Sonoda's [Lean-Ridgelet](https://github.com/shosonoda/lean-ridgelet) and [Blueprint site](https://shosonoda.github.io/lean-ridgelet/blueprint/html-multi/overview/#Lean-Ridgelet-Blueprint--L2-theory___-arXiv___2106___04770v2-implementation-map) | Blueprint-style organization and an implementation map linking informal mathematics to Lean declarations. | Lean-Ridgelet is Apache-2.0. ASTIS independently implements its website and formal graph, copying no Lean-Ridgelet code or template. Sho Sonoda does not participate in, endorse, or maintain ASTIS. | The implementation-map idea is extended to a whole sampling-theory textbook, hidden-assumption packets, theorem DAGs, frontier results, and reusable formal memory. |
| [ARIS / Auto-claude-code-research-in-sleep](https://github.com/wanshuiyin/Auto-claude-code-research-in-sleep) | Long-window autonomous research, durable artifacts, recovery, and separate review. | ASTIS makes source-backed Lean theorem state and exact proof obligations the primary object rather than experiments or paper drafting alone. | Long runs remain recoverable without treating a plausible narrative as mathematical truth. |
| [Learning Beyond Gradients](https://github.com/Trinkle23897/learning-beyond-gradients) | Durable trial memory, rejected routes, iterative improvement, and the idea that the maintained reasoning system itself can be optimized. | ASTIS's earlier Harness used explicit Upper/Middle/Lower/Reviewer handoffs; the current Harness keeps the durable evidence and negative memory but no longer treats those roles as intellectual boundaries. | Failed proof routes remain reusable negative knowledge while one capable Worker can carry a mathematical insight through source, proof design, Lean, and diagnosis. |
| [EoH](https://github.com/FeiLiu36/EoH) | Population-style competing solution routes. | Candidate variation is permitted only after a Lean-checkable target is fixed; `faithfulPaper` mode may not mutate the source theorem or assumptions to make proof easier. | Alternative proof mechanisms can be explored without weakening source fidelity. |
| [LeanMarathon](https://github.com/YuanheZ/LeanMarathon) and [arXiv:2606.05400](https://arxiv.org/abs/2606.05400) | Blueprint as system of record, dynamic proof-DAG leaves, bounded workers, connected-problem refinement, and deterministic gates. | ASTIS keeps a local source-backed blueprint and theorem graph rather than requiring GitHub/PR/Slurm as its execution substrate. | The active target is selected from the dependency graph instead of from a flat task list. |
| [MathCode](https://github.com/math-ai-org/mathcode) | Lean diagnostics, theorem-reuse memory, hidden-placeholder scans, and subgoal planning. | Diagnostics are advisory; ASTIS acceptance still requires its pinned Lean gate plus explicit source correspondence. | Search and diagnosis can accelerate proof work without becoming a substitute for formal verification. |
| [lean-stat-learning-theory](https://github.com/YuanheZ/lean-stat-learning-theory) and [arXiv:2602.02285](https://arxiv.org/abs/2602.02285) | Mathlib proof idioms for probability, concentration, entropy duality, functional inequalities, and discretization. | Toolchain differences mean external declarations are audited reference/port memory until ASTIS-owned local declarations compile. | Later Workers can borrow verified local theorem shapes rather than repeatedly reconstruct informal analogies. |
| [StatsMLlib](https://github.com/Lean-MoDS/StatsMLlib) and its [contributor guide](https://statsmllib.github.io/contribute.html) | Subject-owned module placement, reuse-first development, complete-proof policy, source attribution, whole-library verification, and staged contribution. | Samplinglib adds textbook/paper correspondence, SampleWiki frontier ingestion, theorem-DAG placement, strict obstructions, and source-aware admission. | The library is organized as reusable subject knowledge rather than a collection of one-off proof scripts. |
| [FrontierAgent](https://github.com/ApodexAI/FrontierAgent) | Bounded task boards, parallel generalist sub-agents, structured reports, checkpoint/resume, fanout guards, and coordinator no-progress protection. | ASTIS replaces generic file tasks with source-backed theorem-DAG advances and requires Lean evidence, truth boundaries, independent verification, graph placement, and serialized stabilization. | It supports broad Worker capability and bounded global coordination without allowing generic task completion to masquerade as theorem progress. |
| [Quantum-Computing-Block-Encoding](https://github.com/DakeBU/Quantum-Computing-Block-Encoding/tree/wip/ghl2025-faithful-20260518-0201) | The earlier concrete Upper/Middle/Lower/Reviewer Harness, conversion windows, proof obligations, and proof-blueprint discipline. | ASTIS replaces quantum-specific contracts with sampling/SDE objects and has since moved from permanent role boundaries to theorem-sized Universal Worker ownership and dynamic Frontier Cells. | The earlier hierarchy supplied useful source and review discipline; the current Harness keeps those invariants while reducing context handoff. |
| ABEIS-style internal harness naming | Compatible names for proof blueprints, agent briefs, verifier feedback, retrieval indexes, paper contribution memory, and technical-lemma memory. | ASTIS feedback is typed for Sampling/SDE proof work: source-line coverage, Lean build, Mathlib API, measure theory, regularity assumptions, technical lemmas, and theorem status. | Shared vocabulary reduces engineering overhead without importing another domain's mathematical semantics. |

## Earlier and current Harness architecture

The earlier ASTIS Harness was intentionally role-layered:

```text
Upper
source audit · mathematical strategy · proof-DAG planning
    ↓
Middle
source ↔ Lean correspondence · retrieval · theorem mapping
    ↓
Lower workers
proof scouting · Lean implementation · API search
    ↓
Reviewer
Lean gate · source audit · fake-closure rejection
```

That architecture established several invariants that remain important:

- source statements and assumptions must stay explicit;
- proof attempts and failures need durable typed evidence;
- Lean success does not replace source-semantic review;
- verification should be independent of the proving attempt;
- failed routes should be remembered rather than rediscovered.

The current Harness changes the **unit of delegation**, not those invariants. A
Universal Worker owns one Substantive Advance Unit end to end. Nearby advances
form dynamic Frontier Cells, ordinary code reduces their structured state, and
a Thin Master handles only cross-frontier decisions. The current structure is:

```text
source + verified Lean graph
        ↓
Substantive Advance Board
        ↓
Frontier Cells
Universal Workers in parallel
        ↕
Discovery Ledger + deterministic reduction
        ↓
Thin Master
        ↓
Independent verification
        ↓
Single stabilization lane
        ↓
Samplinglib + Underlying Lean Graph
```

Historical `upper`, `middle`, `lower_*`, and `reviewer` names remain valid when
reading old logs or selecting execution profiles. They no longer define what an
agent is permitted to notice, prove, refactor, test, or explain.

## Why the formal graph is a scientific output

Samplinglib is the verified library, but ASTIS is also intended as an instrument
for understanding sampling theory. A prose proof—even a good AI-generated
one—does not by itself tell us exactly which assumptions were required, which
lemmas are safely reusable, or how the result attaches to the accumulated body
of checked mathematics.

Lean verification turns a result into an exact callable declaration. The
Underlying Lean Graph then records its parents and consumers. This lets a reader
ask whether new work:

- adds a terminal leaf;
- bridges previously separate branches;
- shortens an important dependency route;
- creates a reusable interface used by many later results;
- exposes a hidden regularity assumption or missing abstraction;
- reorganizes a substantial part of the proof structure.

This graph-level view is not itself a theorem about scientific importance, but
it is a sharper structural lens than counting isolated new statements. The
project aims to make the conceptual spine of sampling theory easier for
beginners to learn and easier for experts to inspect, compare, compress, and
potentially rewrite in cleaner natural-language or more algebraic form.

## Mode boundary

The EoH-style population element remains separated from faithful paper
reproduction.

- In `faithfulPaper`, ASTIS may keep several proof routes for a fixed lemma, but
  it may not change the source theorem, assumptions, constants, or proof target.
- In `exploratoryProof`, ASTIS may compare theoretical variants once the
  acceptance predicate is explicit and Lean-checkable.

The acceptance rule is stricter than every search heuristic: a mathematical
claim is admitted only through compiled Lean plus explicit source correspondence
and independent verification, or it remains a named proof obligation,
discovery, blocker, or quarantined claim.

## Textbook website copyright boundary

The ASTIS website distinguishes five content classes:

- a licensed original, only when a source license has been verified;
- a necessary short quotation with direct attribution;
- a faithful ASTIS paraphrase with an exact source anchor;
- an ASTIS supplemental derivation or hidden-assumption packet;
- an ASTIS-owned Lean formalization.

The current Chewi book entries use faithful paraphrase. A license attached to a
different work by the same author does not grant rights to this book draft.
