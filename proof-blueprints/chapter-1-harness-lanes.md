# Chapter 1.1 ASTIS multi-lane closure harness

Status date: 2026-08-18
Source: Sinho Chewi, *Log-Concave Sampling*, edition 2026-08-09.
Active integration branch: `chapter-1-ito-process-source-bridge`.

This file is the execution contract for closing Section 1.1. It instantiates the repository's
`upper / middle / lower / reviewer` harness roles with disjoint file ownership and theorem-level
interfaces. A lane may prepare downstream leaves before upstream source items are registered, but
no source item is promoted until all dependencies compile and the reviewer lane accepts the exact
source correspondence.

## Harness discipline

- **upper**: freezes source statement, dimensions, filtration, almost-sure quantifiers and regularity.
- **middle**: freezes Lean target signatures and exact Mathlib/ASTIS APIs; records rejected API routes.
- **lower**: proves one ready leaf at a time and reports the exact remaining subgoal on failure.
- **reviewer**: independently audits assumptions, source correspondence, `sorry`/axiom/fake-closure,
  focused tests, and the full Lean/site gate.
- **integration**: only connects already-compiled leaves, updates imports/tests/registry/evidence, and
  resolves branch conflicts. It must not silently strengthen an upper-lane contract.

A route is frozen for review after two unchanged repeats under ASTIS's route-fingerprint policy.

## File ownership

| Lane | Primary files | May not edit concurrently |
|---|---|---|
| L-MEASURE | `ProgressiveDriftIntegral.lean`, focused test | Itô-formula/SDE source files |
| L-ITO-PROCESS | `FiniteDimensionalItoProcess.lean`, `ChewiItoProcess.lean`, focused tests | measure lane while its exported signature is changing |
| L-ITO-FORMULA | new `QuadraticCovariation.lean`, `ChewiItoFormula.lean`, tests | SDE/Picard files |
| L-SDE | new `ChewiStrongSDE.lean`, `SDEPicard.lean`, tests | Itô-formula internals |
| L-MARKOV | new `SDESolutionMarkov.lean`, tests | Picard implementation until solution-map ABI freezes |
| L-SOURCE | source correspondence / completion / lessons only | production Lean files |
| REVIEW | read-only audit plus gate metadata | no production edits |
| INTEGRATION | root imports, registry, test aggregators, merge | no new mathematical assumptions |

## Dependency graph

```text
A17.1 progressive drift prefix integral
    |
A17.2 global scalar Ito integral is progressive
    |
A17.3 finite Brownian-coordinate stochastic sum is progressive
    |                         A17.4 initial vector process progressive
    +--------------------------+
                |
A17.5 coordinate Ito process progressive
                |
A17.6 R^d-valued source process progressive
                |
A17.7 Definition 1.1.17 source theorem + focused test + registry
                |
B18 differential notation bridge (1.1.18)
                |
        +-------+------------------------------+
        |                                      |
B19.1 finite-dimensional Taylor/Hessian ABI   B19.2 quadratic covariation ABI
        |                                      |
        +-------------------+------------------+
                            |
B19.3 elementary/localized scalar Ito formula
                            |
B19.4 L2/localization limit
                            |
B19.5 source-shaped finite-dimensional Theorem 1.1.19
                            |
B20 stochastic term expectation zero + expectation identity (1.1.20)
                            |
B21 strong-solution contract for SDE (1.1.21)
                            |
        +-------------------+-------------------+
        |                   |                   |
B22.1 drift Picard bound  B22.2 diffusion bound B22.3 adapted/continuous Picard map
        |                   |                   |
        +-------------------+-------------------+
                            |
B22.4 short-horizon contraction / weighted contraction
                            |
B22.5 finite-horizon concatenation + pathwise uniqueness
                            |
B22.6 measurable solution map
                            |
B22.7 Markov property from future Brownian increments + uniqueness
                            |
B22.8 source-shaped Theorem 1.1.22 + focused test + registry
```

## Lane contracts and target signatures

### L-MEASURE — A17.1

Upper contract: if `b : R_+ -> Omega -> E` is strongly progressive, the deterministic Bochner
prefix process `A_t = integral_[0,t] b_s ds` is strongly progressive. This is purely a measurability
claim and does **not** require strengthening Chewi's pathwise local `L1` hypothesis from a.s. to
pointwise.

Middle APIs:
- `MeasureTheory.IsStronglyProgressive`
- `Measurable.subtype_mk`
- `StronglyMeasurable.integral_prod_right`
- `TimeMeasure.restrict_upTo_Iio_terminal`
- `TimeMeasure.restrict_upTo_Iio_eq_of_le`

Target:
```lean
theorem ProgressiveDriftIntegral.prefixIntegralProcess_stronglyProgressive
    (b : NNReal -> Omega -> E)
    (hb : IsStronglyProgressive filtration b) :
    IsStronglyProgressive filtration (prefixIntegralProcess b)
```

### L-ITO-PROCESS — A17.2--A17.7

A17.2 target:
```lean
theorem GlobalItoProcessGluing.globalItoProcess_stronglyProgressive ... :
  IsStronglyProgressive filtration (globalItoProcess hUsual eta hB)
```
Proof route: existing `globalItoProcess_stronglyAdapted` + `globalItoProcess_continuous` +
`StronglyAdapted.isStronglyProgressive_of_continuous`.

A17.3 target:
```lean
theorem FiniteDimensionalItoProcess.coordinateStochasticTerm_stronglyProgressive ... (i : iota) :
  IsStronglyProgressive filtration (fun t omega => coordinateStochasticTerm ... t omega i)
```
Proof route: A17.2 + finite `Finset` sum closure.

A17.4 target: time-constant initial vector process is progressive from `F_0` measurability using
filtration monotonicity. No source assumption beyond `initialStronglyMeasurable`.

A17.5 target:
```lean
theorem FiniteDimensionalItoProcess.coordinateItoProcess_coordinate_stronglyProgressive ... (i : iota) :
  IsStronglyProgressive filtration (fun t omega => coordinateItoProcess ... t omega i)
```
Proof route: initial + A17.1 drift coordinate + A17.3 stochastic term + additive closure.

A17.6 target:
```lean
theorem ChewiItoProcess.process_stronglyProgressive ... :
  IsStronglyProgressive filtration (process hUsual data hB)
```
Middle route: on every horizon obtain measurable scalar coordinates from A17.5, combine them via
`measurable_pi_lambda`, convert measurable to strongly measurable in finite-dimensional second-
countable Euclidean space, and transport through the `WithLp`/Euclidean representation. A direct
continuous-linear equivalence may replace this route if its exact locked-Mathlib API is cleaner.

A17.7 completion theorem must package both the source integral display and progressiveness; a
coordinate display alone is not completion evidence.

### L-ITO-FORMULA — B19.*

Upper source contract: for the finite-dimensional Itô process of Definition 1.1.17 and sufficiently
smooth scalar `f`, prove the finite-dimensional Itô formula with first-order drift, stochastic
first-order term and the `1/2` Hessian--diffusion contraction. The source Brownian driver remains one
`R^N` process.

Parallel leaves:
- **B19.1** gradient/Hessian coordinate identities, reusing existing `Taylor`, `Gradient`,
  `EuclideanSpaceCoordinates` modules where assumptions match.
- **B19.2** quadratic covariation of coordinate Itô integrals, first for elementary integrands, then
  by L2/localization. Do not postulate `[I,J]_t` as an opaque equality.
- **B19.3** elementary/localized scalar Itô formula by Taylor expansion over a partition.
- **B19.4** pass to the compiled global/local stochastic integral via L2 and pathwise localization.
- **B19.5** assemble `tr(sigma sigma^T Hess f)` / Frobenius contraction into the source theorem.

### L-SDE — B21, B22.1--B22.6

B21 defines strong solution by reusing Definition 1.1.17's stochastic integral semantics.

Picard leaves:
- deterministic drift Lipschitz integral estimate;
- stochastic diffusion estimate from existing Itô isometry / Doob-L2;
- preservation of adaptedness and continuous paths;
- short-horizon or exponentially weighted contraction;
- concatenation across finitely many intervals;
- pathwise uniqueness via the same stability inequality;
- measurable dependence on initial condition/noise.

No `ExistsUnique` theorem may assume a ready-made solution or Markov property.

### L-MARKOV — B22.7--B22.8

Prove Markovity from:
1. independent future Brownian increments;
2. measurable solution map;
3. pathwise uniqueness/flow restart;
4. autonomous coefficients for time-homogeneous semigroup statements.

The existing abstract `MarkovSemigroup` module is a downstream consumer, not an assumption.

## Reviewer acceptance checklist

For every promoted source item:
- exact Chewi edition/source anchor checked;
- dimensions and one-vector-Brownian semantics preserved;
- all `a.s.` quantifiers preserved in the same direction;
- no coordinatewise L1/L2 assumptions added at source level;
- no `sorry`, `axiom`, fabricated theorem wrapper, or conclusion-as-assumption;
- focused test imports the production module and checks the source-shaped declaration;
- `lake build`, `lake build Tests`, source check, Chapter-1 evidence check, site build and site contract green;
- registry/status promotion occurs only after the production theorem is compiled.

## Immediate execution order

1. Verify commit `6a2b7433` closes A17.1.
2. Compile A17.2 independently in the smallest file possible.
3. Compile A17.3 and A17.5 in `FiniteDimensionalItoProcess.lean`.
4. Compile A17.6 in `ChewiItoProcess.lean` and extend `Tests/ChewiItoProcess.lean`.
5. Reviewer gate A17.1--A17.6; then source/evidence lane promotes Definition 1.1.17.
6. In parallel, middle lanes inventory exact locked-Mathlib APIs for B19.1/B19.2 and B22.1/B22.2;
   they may prepare leaf files but must not claim source completion before dependencies are green.
