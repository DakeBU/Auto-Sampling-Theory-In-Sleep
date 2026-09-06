# Cycle 196 Middle Packet: Normalized Remainder Bound Integrability

Classification: `narrows-source-cited-boundary`.

Packet type: dynamic-leaf worker packet for the Brownian/Ito frozen backend
under `sald.general_moving_target_discrete.em_interpolation_fp`.

## Exact Boundary

The accepted cycle-195 theorem
`SALD.selectedWeakTestRemainderBoundIntegrableOfStdGaussianVectorLaw` reduced
the downstream Gaussian-law field

```lean
hRemainderBoundInt :
  testRegular ->
    forall phi x i,
      MeasureTheory.Integrable
        (fun z : Real => remainderBound phi x i z)
        (ProbabilityTheory.gaussianReal (0 : Real) (variance phi x i))
```

to the normalized-coordinate-law field

```lean
hNormalizedRemainderBoundInt :
  testRegular ->
    forall phi x i,
      MeasureTheory.Integrable
        (fun z : Real => remainderBound phi x i z)
        (normalizedCoordinateLaw phi x i)
```

Cycle 196 should not repeat that law-transport wrapper.  The smaller
source-cited boundary is the concrete dominating-bound definition:

```lean
hNormalizedRemainderBoundDef :
  testRegular ->
    forall phi x i z,
      remainderBound phi x i z = remainderBoundC phi x i * z ^ 2
```

together with the already established normalized coordinate law, either as a
direct field

```lean
hNormalizedCoordinateLaw :
  testRegular ->
    forall phi x i,
      normalizedCoordinateLaw phi x i =
        ProbabilityTheory.gaussianReal (0 : Real) (1 : NNReal)
```

or through the existing local bridge
`SALD.selectedWeakTestNormalizedCoordinateLawOfStdGaussianVectorLaw` from
`hNormalizedVectorLaw` and `hCoordinateLawDef`.

## Lower_1 Route

Write the one-ticket classical route for `hNormalizedRemainderBoundInt` only.
The source proof around `appendix.tex:983-996` identifies the frozen Brownian
increment with a normalized scalar Gaussian coordinate; `appendix.tex:1161-1170`
records the same standard-normal increment in the EM interpolation.  The
Taylor/DCT backend already uses the concrete quadratic domination shape
`C * z ^ 2` for the selected scalar normalized remainder.  Therefore, after
the source correspondence supplies `hNormalizedRemainderBoundDef`, integrability
is exactly Gaussian second-moment integrability of a scalar quadratic bound.

Do not reopen `hSourceHasHessian` or `hSourceHessianBound`; those remain a
documented source-contract gap.  Do not use VP score-Hessian regularity, direct
SLT imports, or a new theorem-route audit.

## Lower_2 Lean Target

Preferred theorem name:

```lean
SALD.selectedWeakTestNormalizedRemainderBoundIntOfQuadraticBound
```

Suggested statement shape:

```lean
theorem selectedWeakTestNormalizedRemainderBoundIntOfQuadraticBound
    {Test E : Type*} [NormedAddCommGroup E] [InnerProductSpace Real E]
    [FiniteDimensional Real E]
    (normalizedCoordinateLaw :
      Test -> E -> Fin (Module.finrank Real E) -> MeasureTheory.Measure Real)
    (remainderBound :
      Test -> E -> Fin (Module.finrank Real E) -> Real -> Real)
    (remainderBoundC :
      Test -> E -> Fin (Module.finrank Real E) -> Real)
    (testRegular : Prop)
    (hNormalizedCoordinateLaw :
      testRegular ->
        forall phi x i,
          normalizedCoordinateLaw phi x i =
            ProbabilityTheory.gaussianReal (0 : Real) (1 : NNReal))
    (hNormalizedRemainderBoundDef :
      testRegular ->
        forall phi x i z,
          remainderBound phi x i z = remainderBoundC phi x i * z ^ 2) :
    testRegular ->
      forall phi x i,
        MeasureTheory.Integrable
          (fun z : Real => remainderBound phi x i z)
          (normalizedCoordinateLaw phi x i)
```

Proof route: introduce `htests phi x i`, rewrite the ambient law with
`hNormalizedCoordinateLaw htests phi x i`, rewrite the integrand with
`hNormalizedRemainderBoundDef htests phi x i`, and apply the compiled local
theorem
`SALD.gaussianRealSelectedTestLineSecondOrderQuadraticBoundIntegrable
  (1 : NNReal) (remainderBoundC phi x i)`.

If Lean exposes no source definition connecting the paper's `remainderBound`
to the quadratic function, lower_2 must record the strictly smaller
source-cited ProofObligation `hNormalizedRemainderBoundDef` with typed verifier
feedback:

```text
leaf=hNormalizedRemainderBoundDef
error_class=missing-source-definition
needed_shape=remainderBound phi x i z = remainderBoundC phi x i * z ^ 2
source_lines=appendix.tex:983-996; appendix.tex:1161-1170; appendix.tex:1379-1387
```

## Local Facts

Callable local ASTIS/Lean facts:

- `SALD.gaussianRealSelectedTestLineSecondOrderQuadraticBoundIntegrable`
- `SALD.selectedWeakTestNormalizedCoordinateLawOfStdGaussianVectorLaw`
- `AutoSamplingTheory.TechnicalLemmas.SALDExtracted.selectedWeakTestNormalizedCoordinateLawOfStdGaussianVectorLaw`
- `AutoSamplingTheory.TechnicalLemmas.SALDExtracted.selectedWeakTestRemainderBoundIntegrableOfStdGaussianVectorLaw`

No external SLT theorem is callable or queued by this packet.  The port queue
entries for Gaussian/Taylor facts remain reference-only until an ASTIS-owned
compiled declaration is added.

## Reviewer Checklist

- Classification remains `narrows-source-cited-boundary`.
- Exact remaining source-cited boundary is `hNormalizedRemainderBoundDef`, not
  another wrapper over `hNormalizedRemainderBoundInt`.
- Source anchors are `appendix.tex:958-970`, `appendix.tex:983-996`,
  `appendix.tex:1161-1170`, and `appendix.tex:1379-1387`.
- `hSourceHasHessian` and `hSourceHessianBound` stay source-contract gaps.
- Run `python3 tools/astis.py check`.
