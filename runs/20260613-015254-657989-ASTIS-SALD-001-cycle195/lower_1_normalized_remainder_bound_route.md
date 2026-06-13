# Cycle 195 lower_1 normalized-remainder bound route

Classification: `narrows-source-cited-boundary`.

Packet type: dynamic-leaf worker packet.

Exact missing theorem boundary narrowed:

```lean
hNormalizedRemainderBound :
  testRegular ->
    forall phi x i,
      ∀ᵐ z ∂normalizedCoordinateLaw phi x i,
        ‖normalizedRemainder phi x i z‖ <= remainderBound phi x i z
```

This route does not revisit `hSourceHasHessian` or
`hSourceHessianBound`. Those remain documented source-contract gaps unless the
paper supplies the selected weak-test Hessian fields verbatim.

## Source Anchors

- `appendix.tex:958-970`: EM update and normalized Brownian increment source.
- `appendix.tex:983-996`: frozen interpolation and scalar Gaussian increment.
- `appendix.tex:1161-1170`: scalar increment moment/bound passage.
- `appendix.tex:1379-1387`: weak-Fokker--Planck diffusion term using the same
  frozen Brownian backend.

The source-side domination lives in the same Taylor/DCT backend tracked in
`research-wiki/paper-contributions/SALD/unfinished_source_map.md` under
`taylor-dct-technical-backend`.

## Existing Local Facts To Reuse

- `SALD.selectedWeakTestRemainderBoundOfStdGaussianVectorLaw` already reduces
  downstream `hRemainderBound` under
  `ProbabilityTheory.gaussianReal 0 (variance phi x i)` to the source-side
  `hNormalizedRemainderBound` under `normalizedCoordinateLaw phi x i`.
- `SALD.selectedWeakTestNormalizedCoordinateLawOfStdGaussianVectorLaw` and
  `SALD.selectedWeakTestNormalizedVarianceDefOfGaussianRealUnitLaw` are the
  local law/variance bridges behind that transport.
- `SALD.gaussianRealSelectedTestLineSecondOrderNormalizedRemainder` is the
  concrete source-shaped normalized scalar Taylor remainder.
- `SALD.gaussianRealSelectedTestLineSecondOrderNormalizedRemainderQuadraticBoundOfTaylorQuotientBound`
  proves the same domination idea in the older DCT interface, from a
  deterministic scalar Taylor quotient bound.

No external SLT declaration should be imported or called. The relevant
technical-lemma registry entries are `sald.remainder-bound-gaussian-law` and
`sald.brownian-normalization-bridges`.

## Lower_2-Ready Theorem Shape

The next compiled theorem should be a fixed-step/source-side version of the
older DCT domination lemma, not a new consumer wrapper:

```lean
theorem selectedWeakTestNormalizedRemainderBoundOfConcreteTaylorQuotient
    {Test E : Type*} [NormedAddCommGroup E] [InnerProductSpace Real E]
    [FiniteDimensional Real E]
    (selectedTest : Test -> E -> Real)
    (normalizedCoordinateLaw :
      Test -> E -> Fin (Module.finrank Real E) -> MeasureTheory.Measure Real)
    (normalizedRemainder remainderBound :
      Test -> E -> Fin (Module.finrank Real E) -> Real -> Real)
    (step C : Test -> E -> Fin (Module.finrank Real E) -> Real)
    (testRegular : Prop)
    (hNormalizedCoordinateLaw :
      testRegular ->
        forall phi x i,
          normalizedCoordinateLaw phi x i =
            ProbabilityTheory.gaussianReal (0 : Real) (1 : NNReal))
    (hNormalizedRemainderConcrete :
      testRegular ->
        forall phi x i z,
          normalizedRemainder phi x i z =
            SALD.gaussianRealSelectedTestLineSecondOrderNormalizedRemainder
              (selectedTest phi) x ((stdOrthonormalBasis Real E) i)
              (step phi x i) z)
    (hRemainderBoundQuadratic :
      testRegular ->
        forall phi x i z, remainderBound phi x i z = C phi x i * z ^ 2)
    (hTaylorQuotientBound :
      testRegular ->
        forall phi x i r,
          ‖(selectedTest phi
                (x + r • ((stdOrthonormalBasis Real E) i)) -
              taylorWithinEval
                (fun q : Real =>
                  selectedTest phi
                    (x + q • ((stdOrthonormalBasis Real E) i)))
                2 Set.univ 0 r) / r ^ 2‖ <= C phi x i) :
    testRegular ->
      forall phi x i,
        ∀ᵐ z ∂normalizedCoordinateLaw phi x i,
          ‖normalizedRemainder phi x i z‖ <= remainderBound phi x i z
```

This theorem strictly narrows `hNormalizedRemainderBound` to four smaller
source-cited fields:

1. the normalized scalar coordinate law is `gaussianReal 0 1`;
2. the local `normalizedRemainder` is the concrete selected-line Taylor
   remainder at the frozen step;
3. the local `remainderBound` is the quadratic Gaussian bound `C * z ^ 2`;
4. the deterministic selected-line second-order Taylor quotient is bounded by
   `C`.

## Proof Route

For fixed `htests phi x i`, rewrite the measure by
`hNormalizedCoordinateLaw htests phi x i`. It is enough to prove the bound for
every real `z`, so use `Filter.Eventually.of_forall`.

For each `z`, set
`r = step phi x i * z`. Apply `hTaylorQuotientBound htests phi x i r`. After
rewriting `normalizedRemainder` by `hNormalizedRemainderConcrete`, the left
side is exactly

```lean
‖((selectedTest phi (x + r • e_i) -
      taylorWithinEval (fun q => selectedTest phi (x + q • e_i))
        2 Set.univ 0 r) / r ^ 2) * z ^ 2‖
```

Use `norm_mul` and multiply the quotient bound by the nonnegative factor
`‖z ^ 2‖`. Finish with `Real.norm_eq_abs`/`sq_nonneg` to rewrite
`C phi x i * ‖z ^ 2‖` as `C phi x i * z ^ 2`, then rewrite the right side by
`hRemainderBoundQuadratic`.

This is the same local arithmetic used in
`SALD.gaussianRealSelectedTestLineSecondOrderNormalizedRemainderQuadraticBoundOfTaylorQuotientBound`,
but with the event/filter layer removed and with the source-side
`normalizedCoordinateLaw` target needed after cycle 194.

## Remaining Boundary After Lower_2

After this bridge, `hNormalizedRemainderBound` is no longer primitive. The
remaining exact proof obligations are:

- the concrete source definitions
  `hNormalizedRemainderConcrete` and `hRemainderBoundQuadratic`;
- the deterministic selected-line Taylor quotient bound;
- `hRemainderBoundInt`, separately, for the chosen quadratic bound under the
  final Gaussian law.

`hBrownianCoordinateGeneratorTaylorIntegralDef`, `hRemainderGeneratorLimitDef`,
`hRemainderMeas`, and Gaussian-law `hRemainderBound` should not be rewrapped;
they already have compiled local bridges.
