# ASTIS parallel plan for Chewi Sections 1.2 and 1.3

Status date: 2026-08-17  
Canonical source: Sinho Chewi, *Log-Concave Sampling*, 2026-08-09 edition.

## Parallelization invariant

Develop only nodes that are independent of unfinished Section 1.1 stochastic-process lemmas.  If a source-facing theorem needs the concrete SDE solution, its Markov property, the finite-dimensional Itô formula, or another declaration owned by the Section 1.1 closing track, stop at the typed interface and mark that edge blocked.  Do **not** duplicate the Section 1.1 declaration or build a temporary competing API.

A second invariant is equally important: search the existing ASTIS technical-lemma tree before introducing a new abstraction.  The first CI run on this branch exposed several already-compiled Section 1.2/1.3 modules which textual search had missed.  The duplicate experimental `TechnicalLemmas/MarkovSemigroup/*` tree was therefore removed; the canonical tree below is now the only target.

---

## Canonical reusable roots already in `main`

### Section 1.2 roots

```text
StochasticProcesses/MarkovSemigroup.lean
  TransitionKernelContract
  MeasurableENNReal
  markovOperator
  markovOperator_zero / comp / comm
  chewi_lemma_1_2_2

StochasticProcesses/FellerSemigroup.lean
  FellerTransitionKernelContract
  fellerOperator
  Jensen square inequality (1.2.11)
  continuousLinearSemigroupOfFeller

StochasticProcesses/OperatorGenerator.lean
  ContinuousLinearSemigroup
  right difference quotient / generator relation
  invariant generator domain under the semigroup
  right Kolmogorov backward equation

StochasticProcesses/OperatorGeneratorDomain.lean
  StronglyContinuousSemigroup
  generatorDomainSubmodule
  bundled rightGenerator
  bundled backward equation on the canonical domain

StochasticProcesses/Reversibility.lean
  abstract Hilbert-space reversibility (Definition 1.2.10)

StochasticProcesses/CarreDuChamp.lean
  Gamma (Definition 1.2.12)
  Gamma2 (Definition 1.2.28)
  CD(alpha,infinity) (Definition 1.2.29)
  Gamma >= 0 from Markov Jensen/right-generator limits (Lemma 1.2.13)
  fundamental integration by parts (Theorem 1.2.14)
  nonnegative quadratic form of -L (Corollary 1.2.15)

StochasticProcesses/LangevinGenerator.lean
  compactly-supported C2 core
  Langevin differential operator
  explicit generator/core contract
  Gibbs infinitesimal stationarity on the core
  semigroup-to-invariance bridge under an explicit integrated-generator contract

StochasticProcesses/LangevinCarreDuChamp.lean
  Laplacian and gradient product rules
  Langevin Gamma = <grad f, grad g> (Example 1.2.17)
  diagonal Gamma = ||grad f||^2

StochasticProcesses/WeakGenerator.lean
  explicit test-class invariance
  integrated semigroup-generator contract
  generator-zero -> invariance bridge
  sample derivative -> law-level weak-generator rewrite

StochasticProcesses/FokkerPlanckAlgebra.lean
  scalar algebra leaves only; no hidden PDE regularity

FunctionalInequalities/Generator.lean
  generator Dirichlet form
  Poincare interface (Definition 1.2.19)
  log-Sobolev interface (Definition 1.2.25)

FunctionalInequalities/SemigroupDecay.lean
  Gronwall core (Lemma 1.2.20)
  scalar dissipation <-> exponential-decay cores for 1.2.21 / 1.2.22 / 1.2.26
```

### Section 1.3 roots

```text
Measure/Transport.lean
  IsCoupling / couplingSet
  Kantorovich transportCost (Definition 1.3.1)
  probability and nonempty-coupling lemmas

Measure/KantorovichDual.lean
  dual-feasible potentials and dual value (Definition 1.3.6)

Measure/WassersteinSpace.lean
  quadraticCost
  W2 extended value (Definition 1.3.4)
  W2^2 = quadratic transport cost
  P2,ac interface (Definition 1.3.12)

Measure/DisplacementInterpolation.lean
  optimal quadratic coupling predicate
  displacement interpolation
  endpoints
  source-facing Wasserstein-geodesic predicate (Definition 1.3.25)

Geometry/MetricCurve.lean
  metric derivative / absolutely-continuous metric curve (Definition 1.3.16)

Geometry/GeodesicConvexity.lean
  alpha-geodesic-convexity core (Definition 1.3.26)
```

This means most low-level definitions in 1.2 and 1.3 are **not** future work.  The remaining work is primarily to connect these compiled islands with honest analytic bridges.

---

# Section 1.2 theorem DAG

## 1.2.1 Markov semigroups, generators, Kolmogorov equations

```text
Mathlib Kernel
  -> TransitionKernelContract                           [COMPILED]
      -> markovOperator + P0/PsPt laws                  [COMPILED: 1.2.2]
      -> FellerTransitionKernelContract                 [COMPILED]
          -> bounded-continuous CLM semigroup           [COMPILED]
              -> right generator/domain                 [COMPILED: 1.2.3]
              -> backward equation                      [COMPILED: 1.2.5, right/domain form]

TransitionKernelContract
  -> evolveMeasure on laws                              [THIS PR]
      -> measure Chapman--Kolmogorov                    [THIS PR]
      -> probability preservation                       [THIS PR]
      -> IsStationary                                   [THIS PR: measure form of 1.2.7]

operator semigroup + dual/integrated-generator domain
  -> forward/adjoint equation on a declared test core   [PARTIAL ROOTS EXIST]
  -> stationary iff generator annihilates tests         [NEXT, domain-aware]

Section 1.1 canonical Markov-SDE theorem                 [WAIT]
  -> concrete transition kernel K_t(x,.)                [WAIT]
  -> time homogeneity for autonomous coefficients       [WAIT]
  -> process expectation = kernel Markov operator       [WAIT]
  -> source-facing Definition 1.2.1 for Langevin        [WAIT]

Section 1.1 finite-dimensional Ito formula              [WAIT]
  + concrete Langevin solution                          [WAIT]
  + LangevinGenerator core contract                     [COMPILED]
  -> identify actual semigroup generator with
     Delta f - <grad V, grad f> on the chosen core       [WAIT AT FINAL BRIDGE: 1.2.4]
```

The key design choice is that `TransitionKernelContract` remains canonical.  `MarkovMeasureEvolution.lean` extends it instead of defining a second semigroup structure.

## 1.2.2 Reversibility, Gamma, Poincare, spectral decay

```text
Feller/operator semigroup
  + stationary L2(pi) realization                       [ANALYTIC BRIDGE]
  -> Reversibility.IsReversible                         [DEFINITION COMPILED: 1.2.10]
      -> self-adjoint/generator-symmetry bridge          [NEXT]

Markov Jensen (1.2.11)                                  [COMPILED]
  + right-generator limits
  -> Gamma(f,f) >= 0                                    [COMPILED: 1.2.13]

stationarity + generator symmetry + integrability
  -> fundamental IBP                                    [COMPILED: 1.2.14]
      -> -L quadratic form >= 0                         [COMPILED: 1.2.15]

Langevin differential expression
  + product calculus
  -> Gamma = <grad f,grad g>                            [COMPILED: 1.2.17]

Poincare generator interface                            [COMPILED: 1.2.19]
  + actual variance dissipation identity                [MISSING ANALYTIC BRIDGE]
  + scalar Gronwall/decay core                          [COMPILED]
  -> source-facing variance decay 1.2.21                [NEXT AFTER DISSIPATION]
  -> source-facing chi-square decay 1.2.22              [NEXT AFTER DISSIPATION]
```

Do not represent 1.2.21/1.2.22 as complete merely because the scalar ODE theorem is complete.  The mathematical heart still missing is the exact derivative identity for the semigroup quantity, with all integrability/domain assumptions visible.

## 1.2.3 LSI, Gamma2, Bakry--Emery

```text
Log-Sobolev generator interface                         [COMPILED: 1.2.25]
  + actual KL/Fisher dissipation identity               [MISSING ANALYTIC BRIDGE]
  + scalar decay core                                   [COMPILED]
  -> source-facing KL decay 1.2.26                      [NEXT AFTER DISSIPATION]

CarreDuChamp
  -> Gamma2                                             [COMPILED: 1.2.28]
  -> CD(alpha,infinity)                                 [COMPILED: 1.2.29]

Langevin product/second-order calculus                  [PARTLY COMPILED]
  + Hessian identity for Gamma2                         [NEXT, INDEPENDENT ALGEBRA]
  + strong-convexity <-> Hessian lower bound            [EXISTING GEOMETRY ROOTS]
  -> source-facing Langevin CD equivalence 1.2.31       [ELIGIBLE IN PARALLEL,
                                                         except any actual-generator identification]
```

Chewi Theorem 1.2.30 is proved later in Chapter 2.  Chapter 1 should keep a source-backed theorem contract/reference rather than inventing a second proof just to mark the item complete.

---

# Section 1.3 theorem DAG

Section 1.3 is almost entirely independent of Section 1.1, so it can run as a second parallel frontier once the 1.2 canonical wiring is green.

```text
Transport.IsCoupling / transportCost                   [COMPILED: 1.3.1]
  -> existence of minimizer under lsc/tightness         [HARD: 1.3.3]

quadraticCost / wassersteinDistance                     [COMPILED: 1.3.4]
  -> W2 self=0 / symmetry basic lemmas                  [NEXT, LOW RISK]
  -> gluing lemma                                       [HARD: 1.3.13]
      -> triangle inequality                            [HARD]
      -> W2 metric structure                            [HARD: 1.3.14]
          -> completeness/separability + convergence    [MAJOR: 1.3.15]

Kantorovich dual feasible set/value                     [COMPILED: 1.3.6]
  -> weak duality                                       [NEXT, MEDIUM]
  -> strong duality + optimal potentials                [MAJOR: 1.3.8]
  -> Brenier map/uniqueness                             [MAJOR: 1.3.8]

P2,ac                                                   [COMPILED: 1.3.12]
  + W2 metric structure
  -> metric derivative / AC curve                       [CORE COMPILED: 1.3.16]
      -> continuity equation                            [MAJOR: 1.3.17]
      -> minimal velocity characterization              [MAJOR: 1.3.20]

optimal quadratic coupling
  -> displacement interpolation + endpoints             [COMPILED: 1.3.25 definition layer]
  + W2 metric/gluing
  -> constant-speed geodesic theorem                    [MISSING: 1.3.23/1.3.25 theorem]
      -> geodesic convexity consumers                    [DEFINITION CORE COMPILED: 1.3.26]
```

The practical ordering for 1.3 is therefore:

1. low-risk metric algebra (`W2(μ,μ)=0`, symmetry, cost-under-swap);
2. gluing/disintegration infrastructure;
3. triangle inequality and true metric packaging;
4. optimal-plan existence / strong duality / Brenier as separate major analytic fronts;
5. only then Wasserstein AC curves, continuity equation, and full geodesic theory.

---

# Canonical bottom-level Lean tree

No new parallel `MarkovSemigroup/` root should be created.  Extend the compiled tree in place:

```text
AutoSamplingTheory/TechnicalLemmas/
  StochasticProcesses/
    MarkovSemigroup.lean             # existing canonical kernel/operator root
    MarkovMeasureEvolution.lean      # this PR: law action + stationarity
    FellerSemigroup.lean             # existing
    OperatorGenerator.lean           # existing
    OperatorGeneratorDomain.lean     # existing
    Reversibility.lean               # existing
    CarreDuChamp.lean                # existing Gamma/Gamma2/CD + 1.2.13-15
    SemigroupDissipation.lean        # future: actual variance/chi2/KL derivative bridges
    LangevinGenerator.lean           # existing
    LangevinCarreDuChamp.lean        # existing
    LangevinGammaTwo.lean            # next independent 1.2.31 algebra
    LangevinSemigroupBridge.lean     # WAIT where it consumes Section 1.1

  FunctionalInequalities/
    Generator.lean                   # existing PI/LSI interfaces
    SemigroupDecay.lean              # existing scalar decay core

  Measure/
    Transport.lean                   # existing
    KantorovichDual.lean             # existing
    WassersteinSpace.lean            # existing
    DisplacementInterpolation.lean   # existing
    TransportGluing.lean             # future 1.3.13
    WassersteinMetric.lean           # future 1.3.14/1.3.15

  Geometry/
    MetricCurve.lean                  # existing
    GeodesicConvexity.lean            # existing
```

Source-facing chapter wrappers, when introduced, should be thin composition layers over these technical modules.  They must not reimplement kernel composition, generator domains, Gamma/Gamma2, transport cost, or Wasserstein definitions.

---

# Shared-root freeze with Section 1.1

These declarations remain owned by the Section 1.1 closing track and are not to be redefined here:

- filtered stochastic-process measurability/progressiveness;
- Brownian coordinate and filtration bridges;
- Itô-process assembly and stochastic-integral semantics;
- finite-dimensional Itô formula;
- strong SDE solution contract;
- existence/pathwise uniqueness/Markov property of the concrete SDE;
- process conditional law -> transition kernel when that construction consumes the preceding SDE declarations.

When a 1.2 source theorem reaches one of these edges, this branch waits for the canonical Section 1.1 declaration to land on `main`, then imports it.

---

# Merge and validation discipline

1. Keep exactly one parallel 1.2/1.3 branch while the 1.1 branch is open.
2. Every new technical module must enter an existing canonical parent import surface, so `lake build` actually compiles it.
3. No `sorry`, `admit`, `axiom`, fake `True` proposition, or status promotion without source/compile evidence.
4. Keep the parallel PR draft until the full `chapter-1-foundation` workflow is green.
5. Once Section 1.1 lands, update this branch from `main`, consume canonical shared declarations, resolve only genuine interface edges, then merge and delete the branch.
6. After each major item, update the Chapter 1 evidence/site metadata only when the source-facing theorem—not merely an internal scalar helper—is genuinely closed.
