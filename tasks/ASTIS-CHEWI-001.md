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

The current source edge is Example 1.2.8 -> Corollary 1.2.9.  The finite-
dimensional analytic branch is blue through concrete generator integrability,
Gibbs-tail convergence, whole-space weighted integration by parts, the
`C_c^2` generator core, normalized Gibbs core annihilation, and a conditional
semigroup-to-core-invariance theorem.  The remaining main-line boundary is a
concrete Langevin Markov semigroup plus a semigroup-stable domain/core
extension; Mathlib currently supplies no ready SDE/Markov-semigroup
construction, so this is an external/upstream dependency rather than a lower-
agent proof-ready leaf.

The independent cutoff branch is also blue through a positive global bound on
the fixed unit cutoff's second derivative, the radial second iterated Frechet
derivative `C / R^2` scaling theorem, and the corresponding Laplacian bound
with explicit finite-dimensional trace factor.  There is no remaining
dependency-ready local leaf in this audited Chapter 1 graph.  Do not mark the
invariant Gibbs law blue before a concrete evolution and its operator-domain
extension compile.

## Chapter 2 Foundation

`TechnicalLemmas/FunctionalInequalities/Poincare.lean` now provides the
compiled local Poincaré interface: variance, Dirichlet energy, the exact
integrability domain, probability normalization, an explicit test class,
nonnegativity, inequality elimination, and monotonicity in both the constant
and test class.  These are reusable blue leaves, not evidence that a concrete
Gibbs measure satisfies the inequality.

The Bakry–Émery route depends on the external-blocked concrete semigroup and
domain package from Chapter 1.  The localization route is independently
external, and dimension-sharp log-concave isoperimetry remains blocked behind
it.  None of these broad results is currently a lower-agent-ready leaf.

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
