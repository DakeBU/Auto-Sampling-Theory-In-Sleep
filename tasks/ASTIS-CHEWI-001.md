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

- `TechnicalLemmas/Analysis/Calculus/Cutoff.lean`
- `TechnicalLemmas/Analysis/Calculus/Divergence.lean`
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

## Active Chapter 1 Frontier

The current source edge is Example 1.2.8 -> Corollary 1.2.9.  Locally compiled
blue nodes include the generator display, finite-box divergence and zero-face
handoffs, smooth local/exact-support cutoffs, compact-in-open and Pi-box
plateaus, and a compactly supported radial cutoff family converging pointwise to
one.  The next red nodes are scaled first/Hessian/Laplacian cutoff estimates,
integrable domination and Gibbs-tail passage, whole-space weighted integration
by parts, and generator/semigroup domain semantics.  Do not mark the invariant
Gibbs law blue before both the analytic and operator-domain branches compile.

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
