# ASTIS Chapter 1 formalization execution plan

Status date: 2026-08-17
Canonical source: Sinho Chewi, *Log-Concave Sampling*, 2026-08-09 edition.
Scope: Chapter 1, with explicit separation between source-faithfulness backfill and already-built downstream infrastructure.

## Rule of execution

A source item is complete only when all four layers agree:

1. **source statement** — dimensions, norms, filtrations, measurability and almost-sure quantifiers match the textbook;
2. **foundation bridge** — every hidden mathematical implication used to reach Mathlib/ASTIS APIs is a proved lemma, not an extra assumption;
3. **Lean theorem** — the source-shaped declaration compiles through `lake build` and a focused test;
4. **reader evidence** — source correspondence, theorem lesson/registry status and website route point to the compiled declaration.

Downstream declarations may exist before an upstream source item is complete. They are then *prebuilt consumers*, not evidence that the upstream source item has been formalized.

## Track A — close Definition 1.1.17 faithfully

This is the current source-faithfulness debt. Execute strictly in order.

| ID | Leaf | Dependency | Evidence / target | State |
|---|---|---|---|---|
| A0 | One Euclidean Brownian process -> scalar coordinates under the same filtration | Proposition 1.1.16 scalar Itô API | `EuclideanBrownianCoordinates.coordinateFamily` | compiled before this plan |
| A1 | Pin the exact operator `NNNorm` API at the locked Mathlib revision | Mathlib v4.33.0 | `ContinuousLinearMap.le_opNNNorm`, `opNNNorm_le_iff`; `Tests/FiniteDimensionalNormBridge.lean` | implemented, gate pending at current head |
| A2 | Frobenius/HS norm squared -> finite matrix energy -> every scalar entry is locally L2 | A1 + time-measure monotonicity | `MatrixLocallySquareIntegrableNormOn.toEnergy`, `.entry` | implemented, gate pending |
| A3 | Matrix-valued progressive process -> every scalar entry progressive | continuous coordinate dual | `SourceData.diffusion_entry_progressive` | implemented, gate pending |
| A4 | Vector drift progressive + local Bochner L1 -> scalar drift progressive + local L1 | continuous coordinate dual + `ContinuousLinearMap.integrable_comp` | `SourceData.drift_coordinate_progressive`, `.drift_coordinate_integrable` | implemented, gate pending |
| A5 | Source coefficients -> internal `CoordinateItoData` without additional coordinate assumptions | A2-A4 | `SourceData.toCoordinateItoData` | implemented, gate pending |
| A6 | One source `R^N` Brownian driver + source coefficients -> source-facing `R^d` Itô process | A0+A5 | `ChewiItoProcess.process`, `definition_1_1_17_coordinate_display` | implemented, gate pending |
| A7 | Prove the constructed process itself is progressive, as stated in Chewi's prose | A6 + continuity/adaptedness of drift and Itô terms | dedicated theorem in `ChewiItoProcess.lean` | next proof leaf after A6 is green |
| A8 | Register Definition 1.1.17 in Chapter-1 completion/source correspondence and add focused test | A6-A7 | registry/content/test/site contract | blocked until A6-A7 compile |

### Modeling contract for A0-A8

Do **not** replace the source `R^N` Brownian motion by an arbitrary family of scalar Brownian motions. Coordinates must be derived from one vector process. Do **not** ask for coordinatewise `L1/L2` assumptions when the source only assumes finite vector/Frobenius norm integrals; those coordinate facts must be theorems.

The source norm for `sigma` is the Hilbert--Schmidt/Frobenius norm. In finite coordinates ASTIS flattens the matrix into `EuclideanSpace R (iota x kappa)` and proves its squared Euclidean norm equals the sum of entry squares.

## Track B — finish Section 1.1 in source order

Only start B1 after Track A is green and registered.

### B1. Display (1.1.18): differential notation

Treat this as notation/correspondence, not as a new differential object. Tie the informal display
`dX_t = b_t dt + sigma_t dB_t` to the integral-equation object from Definition 1.1.17.

### B2. Theorem 1.1.19: finite-dimensional Itô formula

Dependency DAG:

`ChewiItoProcess`  
-> finite-coordinate first derivative / gradient bridge  
-> finite-coordinate second derivative / Hessian contraction  
-> quadratic-covariation theorem for the Brownian stochastic term  
-> scalar Itô formula for elementary/localized coefficients  
-> localization/approximation limit  
-> vector/matrix source theorem.

The final source statement must expose

`f(X_t)-f(X_0) = integral drift correction + stochastic integral`

with the second-order contraction equivalent to `tr(sigma sigma^T Hess f)` / Frobenius pairing. Existing Taylor/Hessian algebra leaves may be reused only after their analytic hypotheses are matched.

### B3. Display (1.1.20): expectation evolution

Dependencies: B2 + zero expectation of the relevant Itô integral under the required integrability. Separate the finite-time integral identity from any derivative-in-time shorthand; the latter needs an additional absolute-continuity/differentiation theorem.

### B4. Display (1.1.21): strong SDE solution contract

Define the source notion of a strong solution on a fixed filtered probability space driven by the same Brownian motion. The defining equation should reuse Definition 1.1.17 rather than create a second stochastic-integral semantics.

### B5. Theorem 1.1.22: existence, pathwise uniqueness, and Markov property

Split into proof obligations:

1. Picard map on adapted continuous processes on `[0,T]`;
2. deterministic drift Lipschitz estimate;
3. stochastic diffusion Lipschitz estimate via Itô isometry/BDG or Doob-L2;
4. contraction on a short interval or weighted norm;
5. interval concatenation to arbitrary finite `T`;
6. pathwise uniqueness for two solutions driven by the same Brownian motion;
7. measurability of the solution map in the initial state/noise;
8. Markov property from independent future Brownian increments and uniqueness.

The Markov conclusion is a genuine consumer of the Brownian filtration infrastructure; it must not be postulated as part of the SDE structure.

## Track C — Section 1.2 semigroup bridge

The repository already contains substantial abstract semigroup/generator infrastructure. Treat it as prebuilt downstream infrastructure. The missing source bridge is:

`Theorem 1.1.22 Markov solution`  
-> transition kernel of the concrete SDE  
-> time-homogeneity for autonomous coefficients  
-> `P_t f(x) = E[f(X_t^x)]`  
-> Definition 1.2.1 concrete Markov semigroup  
-> Lemma 1.2.2 semigroup law  
-> Definition 1.2.3 generator/domain  
-> Example 1.2.4 Langevin generator from Theorem 1.1.19  
-> Kolmogorov equations and invariant/reversible theory.

The existing abstract `MarkovSemigroup`, `FellerSemigroup`, generator-domain and Langevin algebra modules should be connected to this concrete chain, not used as substitutes for it.

## Track D — website/readability gate

For every source theorem from 1.1.17 onward the theorem page should present information in this order:

1. textbook statement and source location;
2. why the statement matters in the chapter;
3. hidden regularity assumptions made explicit;
4. mathematical proof route in human notation;
5. correspondence to the compiled Lean theorem;
6. expandable Lean implementation details and dependency graph.

The visual layer is split into `site-base.css` (the previous stylesheet, preserved byte-for-byte) and `reader-polish.css` (the new reader-oriented overrides). This makes the redesign reversible and keeps styling changes independent from theorem data.

## Merge discipline

The active Chapter-1 branch may be merged to `main` only after:

- `python3 tools/astis.py check` passes;
- focused Definition 1.1.17 tests pass;
- source-edition and Chapter-1 evidence validators pass;
- site build and site contract pass;
- PR head is up to date with `main`;
- no unresolved review thread or source-correspondence mismatch remains.

After merge, delete the work branch and verify that `main` is the only branch. New Chapter-1 work starts from a fresh short-lived branch whose name matches the next leaf (normally `chapter-1-ito-formula-source`).
