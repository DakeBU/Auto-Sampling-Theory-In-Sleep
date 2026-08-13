# Chapter 1 toolchain migration

Date: 2026-08-14

## Version boundary

| Component | Before | After |
|---|---|---|
| Lean | 4.29.1 | 4.33.0 |
| Mathlib tag | `v4.29.1` | `v4.33.0` |
| Mathlib commit | `5e932f97dd25535344f80f9dd8da3aab83df0fe6` | `db584cd6d46c92f209a44c0f1c829460d327499d` |

The migration is performed on `chapter-1-langevin-diffusion-completion`. No
existing theorem was removed, weakened, or replaced by an assumption in order
to make the newer toolchain compile.

## Brownian API now available

Mathlib 4.33 provides
`Mathlib.Probability.BrownianMotion.Basic`. The Chapter 1 stochastic-calculus
work can now build on the following upstream interfaces instead of maintaining
an unrelated local substitute:

- `ProbabilityTheory.IsPreBrownianReal`, defined by the Brownian
  finite-dimensional laws;
- `ProbabilityTheory.IsBrownianReal`, which adds almost-sure path continuity;
- `IsPreBrownianReal.hasLaw_eval` and `IsPreBrownianReal.hasLaw_sub`;
- `IsPreBrownianReal.hasIndepIncrements`;
- `IsPreBrownianReal.integral_eval`, `integrable_eval`, and `covariance_eval`;
- `IsGaussianProcess.isPreBrownianReal_of_covariance` and
  `HasIndepIncrements.isPreBrownianReal_of_hasLaw`;
- `IsPreBrownianReal.shift` and `IsPreBrownianReal.indepFun_shift`, including
  the weak Markov shift/independence statement;
- the continuous-path-preserving `IsBrownianReal.neg`, `smul`, and `shift`
  constructions.

This API does **not** supply an Itô integral, Itô isometry, Itô formula, or a
general SDE existence theorem. Those remain separate Chapter 1.1 construction
routes and must not be marked complete from the Brownian import alone.

## Compatibility repairs

The 4.33 elaborator and APIs required explicit normalization at several old
definitional-equality boundaries:

- `SALD.lean`: derivative products, continuity on `Set.univ`, measurable
  Taylor remainders, and pointwise function operations;
- `Analysis/Calculus/Gradient.lean` and `LineDeriv.lean`: explicit derivative
  maps, coordinate directions, and algebra-valued product rules;
- `Analysis/Integrability.lean`: the bridge from `RCLike.re` to `Complex.re`;
- `FunctionalInequalities/SemigroupDecay.lean`: explicit derivative-function
  congruence;
- `Geometry/LogConcavity.lean` and `InformationTheory/Renyi.lean`: explicit
  pointwise function algebra;
- `Measure/Gibbs.lean` and `Measure/RadonNikodym.lean`: transparent unfolding
  of owned density definitions and the finite-product lintegral boundary;
- `StochasticProcesses/FellerSemigroup.lean`: a named linear-map layer before
  `LinearMap.mkContinuous`, preserving the same contraction proof;
- `StochasticProcesses/Girsanov.lean`: the explicit `MeasurableEquiv.toLp`
  coercion equality;
- `StochasticProcesses/Langevin.lean`: explicit Euclidean coordinate vectors,
  pointwise products, and derivative-value congruence;
- `StochasticProcesses/OperatorGenerator.lean`: explicit unfolding of the
  right-generator predicate.

The Markov/Feller proposition-valued local instances and the focused identity
Feller test were also updated to the 4.33 linter-supported declaration style.
Deprecated 4.29 names in the probability imports, finite sums, continuous
linear-map application, progressive measurability, and predicate-set notation
were replaced by their 4.33 names in the affected Chapter 1 foundation and
focused-test modules.

## Reproducible gate evidence

The following commands passed from the migrated checkout:

```text
lake exe cache get
lake build                         # 3802 jobs
lake build Tests                   # 3821 jobs
python3 tools/astis.py check
python3 tools/astis.py chewi-source-check
python3 website/scripts/build_site.py
python3 website/scripts/check_site.py
git diff --check
```

The source check reported the canonical 2026-08-09 edition, 12 chapters, 75
TOC entries, and 47 semantic source anchors. The generated site reported 92
Lean modules, 2154 declarations, 345 compiled local leaves, and 64 reviewed
teaching declarations.

The pre-migration baseline workflow run `31714822768` passed its Lean, Tests,
source, consistency, and ordinary site checks. Its strict Chapter 1 closure
step failed because many of the 125 source items still lack exact compiled
evidence. That failure is an honest mathematical frontier and is not treated
as a toolchain regression or a completed route.

## Remaining boundary

The migration only establishes the toolchain and upstream Brownian foundation.
Chapter 1.1 still requires the elementary adapted-process integral, Itô
isometry and completion, localization, Itô process/formula, and the selected
finite-dimensional globally Lipschitz SDE theory. Item-level closure remains
red until those declarations, focused tests, Registry evidence, and exact
source correspondence all exist.
