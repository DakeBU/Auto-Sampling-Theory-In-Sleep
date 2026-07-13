# ASTIS Compact Context Pack

- Task: `ASTIS-CHEWI-001`
- Cycle: `6`
- Generated: `2026-07-09 03:57:22`

## Compact Task Contract

# Build the Log-Concave Sampling Lean foundation

Task id: `ASTIS-CHEWI-001`
Kind: `textbookReproduction`
Mode: `faithfulTextbook + MathlibReadyFoundation`
Status: `active-priority`

## Goal

Reproduce the `Log-Concave Sampling` textbook route in a scientifically
organized, Mathlib-ready Lean tree.  The project follows the textbook itself:
chapter order, theorem statements, constants, cited background sources, hidden
regularity assumptions, and proof dependencies.

Primary source:

- Public PDF: https://chewisinho.github.io/main.pdf
- Local PDF:
  `/home/nitanda_sub/mark/repos/outer_papers/sampling_theory_sde/Chewi-Log-Concave-Sampling/main.pdf`

## Source Discipline

The textbook is allowed to guide theorem ordering and proof strategy, but
bottom-level Lean assumptions must be justified by Mathlib, source textbooks,
primary papers cited by the textbook, or audited external Lean reference
projects.

Every reusable leaf must record:

- source anchor or upstream theorem reference;
- Mathlib/API search surface;
- exact hidden regularity contracts;
- target module and proposed declaration name;
- proof route in small steps;
- failure policy if the route does not close.

Do not silently strengthen a textbook statement just to make Lean accept it.
Unsupported assumptions must be logged as proof obligations or rejected as
definition drift.

## Scientific Lean Tree

Planned module families should be introduced only when a first local leaf
needs them, but the target organization is:

```text
AutoSamplingTheory/TechnicalLemmas/
|-- Measure/
|   |-- Transport.lean
|   `-- RadonNikodym.lean
|-- Geometry/
|   |-- Convex.lean
|   |-- LogConcavity.lean
|   `-- PrekopaLeindler.lean
|-- FunctionalInequalities/
|   |-- Poincare.lean
|   |-- LogSobolev.lean
|   |-- Transport.lean
|   `-- Isoperimetry.lean
|-- StochasticProcesses/
|   |-- MarkovSemigroup.lean
|   |-- Ito.lean
|   |-- Langevin.lean
|   |-- Girsanov.lean
|   |-- DoobTransform.lean
|   `-- FollmerDrift.lean
`-- SamplingAlgorithms/
    |-- LangevinMonteCarlo.lean
    |-- RandomizedMidpoint.lean
    |-- HamiltonianMonteCarlo.lean
    |-- UnderdampedLangevin.lean
    |-- MetropolisAdjustedLangevin.lean
    `-- ProximalSampler.lean
```

Existing compiled families remain canonical until generalized:

- `TechnicalLemmas/Probability/LawMap.lean`
- `TechnicalLemmas/Probability/ConditionalKernel.lean`
- `TechnicalLemmas/ProbabilityDistributions/Gaussian.lean`
- `TechnicalLemmas/StochasticProcesses/WeakGenerator.lean`
- `TechnicalLemmas/StochasticProcesses/FokkerPlanckAlgebra.lean`
- `TechnicalLemmas/InformationTheory/KLDensity.lean`
- `TechnicalLemmas/InformationTheory/DonskerVaradhan.lean`
- `TechnicalLemmas/FunctionalInequalities/LogSobolev.lean`

## First Work Packets

1. Chewi chapter map and dependency DAG.
2. Convex/log-concave measure base layer:
   `Convex`, `LogConcavity`, `PrekopaLeindler`, and Gaussian/product-density
   support, using Mathlib first and
   `Lean-Asymptotic-Statistical-Theory/ForMathlib` as reference.
3. Functional inequality layer:
   PI, LSI, transport inequalities, concentration/isoperimetry, and
   preservation operations.
4. Langevin continuous-time layer:
   generator, invariant measure, KL/FI dissipation, Markov semigroup, and
   Wasserstein gradient-flow contracts.
5. Stochastic calculus path-space layer:
   Ito, quadratic variation, Girsanov/change of measure, Doob transform,
   Follmer drift, and Schrodinger bridge.
6. Discrete sampling layer:
   LMC interpolation, randomized midpoint, HMC, underdamped Langevin, MALA,
   proximal sampler, and high-accuracy sampler interfaces.

## Visualization And Retrieval Artifacts

- Master chapter/theorem DAG:
  `research-wiki/lemma-dags/Chewi_log_concave_sampling_foundation.md`
- Rendered spine:
  `docs/assets/chewi_log_concave_foundation.svg`
- Mermaid source:
  `docs/assets/chewi_log_concave_foundation.mmd`
- Roadmap ledger:
  `research-wiki/sampling-sde-library/roadmap/chewisinho_to_lean_tree.md`
- Retrieval index:
  `research-wiki/retrieval-index/ASTIS-CHEWI-001.json`

Every new chapter or important theorem should either reuse the shared labels
`MEAS`, `KERN`, `DENS`, `GAUSS`, `CONV`, `FI`, `SDE`, `PATH`, `DISC`, `REG`,
or introduce a new shared-root label with a reviewer contract.

## New External Reference Added

- Paper: https://arxiv.org/abs/2606.20642
- Repo: https://github.com/junwei-lu/Lean-Asymptotic-Statistical-Theory
- Local repo:
  `/home/nitanda_sub/mark/repos/outer_repos/sampling_theory_sde/Lean-Asymptotic-Statistical-Theory`
- Local PDF:
  `/home/nitanda_sub/mark/repos/outer_papers/sampling_theory_sde/Hypothesis-Disciplined-Asymptotic-Statistical-Theory/2606.20642.pdf`

Use this project as a reference for hypothesis audit, informal/Lean alignment,
dependency graphs, and possible `ForMathlib` port shapes.  Do not add it as a
Lake dependency without an explicit project decision.

## Acceptance Gate

```bash
python3 tools/astis.py check
```

For any later source-indexed Chewi extraction, add a dedicated source index and
then require:

```bash
python3 tools/astis.py source-index ASTIS-CHEWI-001
python3 tools/astis.py check
```

## Cycle Focus

Log-concave sampling foundation cycle: DISC consumer pressure test. Use LMC/proximal/MALA only to identify missing shared roots. Do not formalize an algorithm theorem before its analytic leaves compile locally.

## Recent High-Signal Handoffs

- no handoff memory yet

## External SLT Provenance And Port Discipline

- External SLT clone for audited porting only (exists): `/home/nitanda_sub/mark/repos/outer_repos/sampling_theory_sde/lean-stat-learning-theory`.
- External SLT paper source for exposition/provenance only (exists): `/home/nitanda_sub/mark/repos/outer_papers/sampling_theory_sde/Statistical Learning Theory in Lean 4 Empirical Processes from Scratch`.
- Do not use the SLT clone as a runtime dependency and do not tell agents to call upstream declarations directly.
- Any useful SLT theorem must become an ASTIS-owned compiled declaration under `AutoSamplingTheory/TechnicalLemmas` before it is callable.
- Port status/provenance remains recorded in `research-wiki/cited-results/SLT_reuse_audit.md`.

## ASTIS Technical Lemma Memory For This Task

- No task-specific technical lemma memory pack selected.

## Task-Local Paper Contribution Memory

- No task-local paper memory pack selected.

## Human TODO Dashboard

- Library overview: `research-wiki/sampling-sde-library/log_concave_sampling_overview.md`.
- Master chapter/theorem DAG: `research-wiki/lemma-dags/log_concave_sampling_foundation.md`.
- Blue/red status tree: `docs/assets/log_concave_sampling_status.svg`.
- Six-hour execution pack: `agent-briefs/log_concave_sampling_6h_execution_pack.md`.
- Compact retrieval index: `research-wiki/retrieval-index/ASTIS-CHEWI-001.json`.

## Blueprint Control State

- Stage: Log-concave sampling foundation Stage-1: chapter map, shared-root DAG, and Mathlib-ready leaf growth
- Latest cycle: 0
- Dynamic leaf candidate: No reviewer blocker recorded yet; use source index and proof-obligation ledger.
- Illness area candidate: No reviewer blocker recorded yet; use source index and proof-obligation ledger.
- Task blueprint: `proof-blueprints/ASTIS-CHEWI-001.md` (legacy mirror: `research-wiki/blueprints/ASTIS-CHEWI-001.md`).
- Borrowed LeanMarathon controls: blueprint system-of-record, target review, dynamic leaves, illness-area refiner, deterministic gate.
- Preserved ASTIS controls: EoH candidate populations for exploratoryProof, LBG-style trial memory, ARIS/QBE upper-middle-lower-reviewer loops, auto-research-in-sleep long run, SDE/Sampling source anchors.

## Self-Reflection Guard

- Start the handoff with one packet classification from the allowed list.
- Name the exact supplied hypothesis discharged or the exact missing theorem boundary narrowed.
- State whether the packet is a dynamic-leaf worker packet or an illness-area refiner packet.
- State which local ASTIS technical lemmas/Mathlib files were used, or which external theorem was only queued for local porting.
- Reject broad source-index, route-audit, wrapper, or project-article work unless it directly closes the active blocker.
- Keep `python3 tools/astis.py check` as the mandatory gate.