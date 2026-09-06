# lower_1 route: hRemainderMeas Gaussian-law transport

Packet classification: `discharges-supplied-hypothesis` dynamic-leaf worker packet.

Exact supplied hypothesis to discharge: `hRemainderMeas` inside
`SALD.selectedWeakTestFrozenScalarBrownianItoTaylorMomentDecompositionOfScalarPushforwardRawTaylorAndDominatedRemainder`, and, with the same interface, inside
`SALD.selectedWeakTestFrozenScalarBrownianItoTaylorMomentDecompositionOfIntegralDefsDominatedRemainderAndRemainderLimitScalarPushforward`.

Lower_2 theorem boundary:
`SALD.selectedWeakTestRemainderMeasOfStdGaussianVectorLaw`.

Classical proof route:

Assume `testRegular`, fix `phi x i`, and abbreviate
`f z := normalizedRemainder phi x i z`. The source/pullback side already supplies

`hNormalizedRemainderMeas htests phi x i :
  AEStronglyMeasurable f (normalizedCoordinateLaw phi x i)`.

It remains only to identify the measure in this statement with
`ProbabilityTheory.gaussianReal 0 (variance phi x i)`. First use the compiled
local coordinate-law bridge

`SALD.selectedWeakTestNormalizedCoordinateLawOfStdGaussianVectorLaw`

with `hNormalizedVectorLaw` and `hCoordinateLawDef`. This gives

`normalizedCoordinateLaw phi x i =
  ProbabilityTheory.gaussianReal 0 (1 : NNReal)`.

Then use the compiled local variance bridge

`SALD.selectedWeakTestNormalizedVarianceDefOfGaussianRealUnitLaw`

with `hVarianceDef` and the just-derived normalized-coordinate law. This gives

`variance phi x i = (1 : NNReal)`.

Rewriting `hNormalizedRemainderMeas htests phi x i` by these two equalities
turns its measure from `normalizedCoordinateLaw phi x i` into
`ProbabilityTheory.gaussianReal 0 (variance phi x i)`. Therefore

`AEStronglyMeasurable
  (fun z : Real => normalizedRemainder phi x i z)
  (ProbabilityTheory.gaussianReal 0 (variance phi x i))`.

This is exactly the old `hRemainderMeas` input required by both dominated
Taylor-moment consumers.

Local ASTIS/Mathlib facts used:

- `SALD.selectedWeakTestNormalizedCoordinateLawOfStdGaussianVectorLaw`
- `SALD.selectedWeakTestNormalizedVarianceDefOfGaussianRealUnitLaw`
- `MeasureTheory.AEStronglyMeasurable` stability under definitional/equality rewriting of the ambient measure, implemented by `rw`/`simpa`
- `ProbabilityTheory.stdGaussian` and `ProbabilityTheory.gaussianReal`, only through the compiled SALD bridges above

Source anchors:

- `appendix.tex:958-970`: the discrete EM step introduces the standard Gaussian increment `xi_k`.
- `appendix.tex:983-996`: the frozen interpolation isolates the Brownian increment term.
- `appendix.tex:1161-1170`: the increment law is represented as the frozen drift plus `sigma_eta sqrt(s-s_k) xi`, with `xi ~ N(0,I)`.
- `appendix.tex:1379-1387`: the same frozen interpolation supplies the weak Fokker--Planck diffusion coefficient downstream.

Consumer use:

After lower_2 compiles `SALD.selectedWeakTestRemainderMeasOfStdGaussianVectorLaw`, the two cycle-193 consumers should replace the explicit `hRemainderMeas` argument by this derived theorem, using the existing inputs `hNormalizedRemainderMeas`, `hNormalizedVectorLaw`, `hCoordinateLawDef`, and `hVarianceDef`. This removes `hRemainderMeas` without changing the scalar pushforward, raw Taylor, or dominated-remainder interfaces.

Remaining explicit leaves:

- `hRemainderBound`
- `hRemainderBoundInt`

No source-Hessian re-audit, wrapper churn, or external SLT dependency is involved.
