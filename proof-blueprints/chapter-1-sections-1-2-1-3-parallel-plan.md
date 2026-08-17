# ASTIS parallel plan for Chewi Sections 1.2 and 1.3

Status date: 2026-08-17
Canonical source: Sinho Chewi, *Log-Concave Sampling*, 2026-08-09 edition.
Parallelization rule: develop only leaves that do not require unfinished Section 1.1 stochastic-process lemmas. If a leaf needs the concrete process/Itô/SDE bridge, mark it blocked and reuse the Section 1.1 declaration after it lands; never duplicate the lemma under a second API.

## Why this track can run in parallel

Section 1.2 has two logically different layers:

1. an **abstract Markov-semigroup / generator / functional-inequality layer** that can be built from measure kernels, operator identities, calculus, and existing ASTIS technical lemmas; and
2. a **concrete Langevin-process bridge** that must ultimately consume Section 1.1 (especially the Markov solution theorem and Itô formula).

Only layer 1 is allowed to move ahead of Section 1.1.

Section 1.3 is even more independent: couplings, transport cost, Kantorovich duality, metric curves, geodesics, and geodesic convexity are measure/metric/convex-analysis objects. They should not import the stochastic-process layer unless a later theorem genuinely needs it.

---

## Section 1.2 theorem DAG

### 1.2.1 Basic definitions and Kolmogorov equations

```text
Mathlib Kernel + composition
  -> 1.2-K0 continuous-time Markov-kernel semigroup       [NOW]
      -> 1.2-K1 zero-time identity / Chapman--Kolmogorov  [NOW]
      -> 1.2-K2 kernel integral Markov operator            [NOW]
      -> 1.2-K3 measure evolution by a kernel              [NEXT]
          -> stationary measure interface                  [NEXT]
      -> 1.2-G0 domain-aware generator relation            [NEXT, independent]
          -> backward equation on a stable core            [analytic]
          -> forward/adjoint equation on a stable core     [analytic]

Section 1.1 Theorem 1.1.22 Markov solution               [BLOCKED]
  -> process transition kernel                            [BLOCKED]
  -> time homogeneity for autonomous coefficients         [BLOCKED]
  -> P_t f(x) = E[f(X_t^x)] source bridge                [BLOCKED]
  -> concrete Definition 1.2.1                            [BLOCKED]

Section 1.1 Theorem 1.1.19 Itô formula                    [BLOCKED]
  + concrete Langevin process                             [BLOCKED]
  + existing Langevin generator algebra
  -> source-facing Example 1.2.4                          [BLOCKED at final bridge]
```

Implementation note: `AutoSamplingTheory/TechnicalLemmas/MarkovSemigroup/KernelSemigroup.lean` is the first process-independent node. It deliberately stores no conditional-expectation/process field.

### 1.2.2 Reversibility and spectrum

```text
KernelSemigroup
  -> stationary measure
  -> detailed-balance / reversible kernel definition
      -> self-adjoint Markov-operator identity
      -> carré du champ Γ definition
          -> Γ(f,f) >= 0 under reversible generator assumptions
          -> Dirichlet form identity
              -> -L positive-semidefinite

existing Generator.lean
  -> Def 1.2.19 Poincaré interface                         [EXISTS]
existing SemigroupDecay.lean
  -> Lemma 1.2.20 Grönwall                                 [EXISTS]
  -> scalar 1.2.21 PI <-> exponential energy decay         [EXISTS]
  -> scalar 1.2.22 PI <-> exponential energy decay         [EXISTS]

actual semigroup variance/chi-square dissipation identity
  + existing scalar decay theorem
  -> source-facing Theorem 1.2.21                          [NEXT AFTER CORE]
  -> source-facing Theorem 1.2.22                          [NEXT AFTER CORE]
```

The lift from the existing scalar `DissipationCurve` theorem to source-facing 1.2.21/1.2.22 must expose the exact differentiability/integrability/domain hypotheses. It must not silently assume a closed generator domain.

For Langevin Example 1.2.17, algebraic integration-by-parts leaves already exist, but the final theorem remains downstream of a concrete generator/domain bridge. Reuse those leaves; do not reconstruct them inside the semigroup module.

### 1.2.3 Log-Sobolev and Bakry--Émery

```text
existing Generator.lean
  -> Def 1.2.25 generator LSI interface                     [EXISTS]
existing SemigroupDecay.lean
  -> scalar Theorem 1.2.26 KL-decay equivalence            [EXISTS]

abstract reversible generator
  -> Γ
  -> Γ2
  -> CD(alpha, infinity)
      -> generic source declarations 1.2.28/1.2.29          [INDEPENDENT]

actual KL/Fisher dissipation identity
  + scalar 1.2.26 theorem
  -> source-facing Theorem 1.2.26                           [NEXT AFTER CORE]

Langevin differential calculus + Hessian/strong convexity
  -> source-facing Theorem 1.2.31                           [MOSTLY INDEPENDENT ALGEBRA,
                                                             final generator bridge later]
```

Chewi Theorem 1.2.30 is proved later in Chapter 2. In Chapter 1 it should remain a source-backed theorem contract/reference until the Chapter 2 proof is formalized; do not invent a second proof merely to make Section 1.2 look complete.

---

## Section 1.3 theorem DAG

### Existing independent roots

- `TechnicalLemmas/Measure/Transport.lean`: coupling predicate/set, transport cost for Chewi Definition 1.3.1, nonempty coupling set.
- `TechnicalLemmas/Measure/KantorovichDual.lean`: integrable-potential dual feasible set and dual value for Definition 1.3.6.
- `TechnicalLemmas/Geometry/MetricCurve.lean`: metric derivative and source-facing absolutely-continuous metric curve for Definition 1.3.16.
- `TechnicalLemmas/Geometry/GeodesicConvexity.lean`: condition (1) of Definition 1.3.26 plus a first-order consequence.

### Planned transport tree

```text
couplingSet / transportCost                              [EXISTS]
  -> finite second moment interface P2                   [NOW-ELIGIBLE]
  -> quadratic cost                                      [NOW-ELIGIBLE]
      -> W2 extended value                               [NOW-ELIGIBLE]
      -> zero/self, symmetry                             [NOW-ELIGIBLE]
      -> gluing lemma 1.3.13                             [HARD, kernel/disintegration]
          -> triangle inequality                         [HARD]
          -> Proposition 1.3.14 metric structure         [HARD]
      -> existence theorem 1.3.3                         [HARD: weak compactness/l.s.c.]
          -> existence of optimal W2 coupling            [HARD]

Kantorovich dual definition                              [EXISTS]
  -> weak duality                                         [NOW-ELIGIBLE]
  -> strong duality / optimal potentials 1.3.8           [MAJOR ANALYTIC BLOCK]
  -> Brenier map/uniqueness part of 1.3.8                [MAJOR CONVEX/MEASURE BLOCK]

P2 + W2 metric
  -> completeness/separability 1.3.15                    [MAJOR TOPOLOGY BLOCK]
  -> metric derivative / AC curve                         [PARTIAL EXISTS]
      -> continuity equation 1.3.17                       [HARD ANALYTIC]
      -> velocity-field characterization 1.3.20           [HARD ANALYTIC]
      -> geodesics 1.3.23                                 [HARD]
          -> McCann interpolation 1.3.25                  [ELIGIBLE AFTER MAP/COUPLING API]
          -> alpha-geodesic convexity 1.3.26              [PARTIAL EXISTS]
```

Before introducing a `Wasserstein` namespace, audit the locked Mathlib revision for an existing Wasserstein/Kantorovich API. At the current audit no direct code-search hit for `Wasserstein` or `Kantorovich` was found, so ASTIS may need an owned interface, but that conclusion must be rechecked before every major definition to avoid library duplication.

---

## Bottom-level Lean module tree

The target tree separates reusable mathematics from source-facing chapter wrappers.

```text
AutoSamplingTheory/TechnicalLemmas/
  MarkovSemigroup/
    KernelSemigroup.lean        # NOW: Markov kernels + CK + ENNReal operator
    MeasureEvolution.lean       # next: law pushforward/evolution + stationary
    Reversible.lean             # detailed balance / self-adjointness
    GeneratorCore.lean          # domain-aware one-sided generator
    CarreDuChamp.lean           # Gamma, Gamma2, CD
    Dissipation.lean            # variance/chi2/KL derivatives -> existing scalar decay
    LangevinBridge.lean         # BLOCKED where it consumes unfinished 1.1

  FunctionalInequalities/
    Generator.lean              # existing 1.2.19 / 1.2.25
    SemigroupDecay.lean         # existing 1.2.20/21/22/26 scalar core

  Measure/
    Transport.lean              # existing 1.3.1 root
    KantorovichDual.lean        # existing 1.3.6 root
    Wasserstein.lean            # P2/W2 source-independent layer
    TransportGluing.lean        # 1.3.13

  Geometry/
    MetricCurve.lean            # existing 1.3.16 root
    WassersteinGeodesic.lean    # 1.3.23/1.3.25
    GeodesicConvexity.lean      # existing 1.3.26 root
```

Source-facing `Chapter1/Section12` and `Chapter1/Section13` wrappers should be thin consumers of these technical modules once the APIs are stable. They should not become a second implementation of kernel composition, transport, or functional inequalities.

---

## Shared-root freeze with Section 1.1

The following roots are owned by the Section 1.1 closing track and are **not** to be redefined here:

- filtered stochastic-process measurability/progressiveness;
- Brownian coordinate and filtration bridges;
- Itô-process assembly and stochastic-integral semantics;
- finite-dimensional Itô formula;
- strong SDE solution contract;
- existence/pathwise uniqueness/Markov property of the concrete SDE;
- process conditional law -> transition-kernel bridge when it depends on those declarations.

When one of these becomes necessary, this parallel track stops at a typed interface and marks the source-facing node blocked until the Section 1.1 declaration is merged.

---

## Merge/validation discipline

1. Parallel 1.2/1.3 work lives on its own short-lived branch and touches the Section 1.1 files only when a merged shared declaration is consumed.
2. Every new technical module must enter the public import surface so the canonical ASTIS `lake build` gate actually compiles it.
3. No `sorry`, `admit`, `axiom`, fake `True` proposition, or theorem-status promotion without compile/source evidence.
4. The first parallel PR should stay draft until the full `chapter-1-foundation` workflow is green.
5. After Section 1.1 lands, rebase/merge `main`, replace blocked bridge edges by imports of the canonical declarations, and delete any obsolete interface shim rather than maintaining two APIs.
