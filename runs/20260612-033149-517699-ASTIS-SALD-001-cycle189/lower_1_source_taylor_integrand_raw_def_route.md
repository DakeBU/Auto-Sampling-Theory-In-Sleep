# Cycle 189 Lower_1 Source Taylor Integrand Raw Definition Route

Classification: `narrows-source-cited-boundary`.

Packet type: dynamic-leaf proof-scout packet.

Exact boundary narrowed:

```lean
hSourceTaylorIntegrandRawDef :
  testRegular ->
    forall phi x i z,
      sourceTaylorIntegrand phi x i z =
        selectedTest phi
          (x + z • (stdOrthonormalBasis Real E i)) -
        selectedTest phi x
```

Lower_2-ready smaller boundary:

```lean
hSourceTaylorIntegrandSelectedIncrementDef :
  testRegular ->
    forall phi x i z,
      sourceTaylorIntegrand phi x i z =
        sourceSelectedLineIncrement phi x i z

hSelectedIncrementCoordinateLineDef :
  testRegular ->
    forall phi x i z,
      sourceSelectedLineIncrement phi x i z =
        selectedTest phi
          (x + z • (stdOrthonormalBasis Real E i)) -
        selectedTest phi x
```

Classical route: `appendix.tex:958-970` introduces the EM Gaussian increment,
and `appendix.tex:983-996` defines the frozen interpolation by separating the
frozen drift from the Brownian increment.  The later rewrite
`appendix.tex:1161-1170` identifies the Brownian increment as a scaled standard
Gaussian vector.  After normalizing the scalar coordinate and choosing the
standard orthonormal direction `i`, the paper-side scalar variable `z` indexes
the line `x + z * e_i`.  The source Taylor integrand for this Brownian event
field is therefore just the selected weak-test increment along that normalized
line.

This route separates two facts that are currently fused in
`hSourceTaylorIntegrandRawDef`: first, the local name `sourceTaylorIntegrand`
denotes the paper's selected-test increment for the frozen scalar Brownian
coordinate; second, that selected increment is the coordinate-line expression
`selectedTest phi (x + z • e_i) - selectedTest phi x`.  The source-FP display
at `appendix.tex:1379-1387` consumes the scalar Brownian contribution with the
law-level diffusion prefactor `sigma_eta^2/2`; that coefficient is not part of
this raw selected-line integrand.

Expected Lean theorem shape:

```lean
theorem selectedWeakTestSourceTaylorIntegrandRawDefOfSelectedIncrementAndLineDef
    {Test E : Type*} [NormedAddCommGroup E] [InnerProductSpace Real E]
    [FiniteDimensional Real E]
    (selectedTest : Test -> E -> Real)
    (sourceTaylorIntegrand sourceSelectedLineIncrement :
      Test -> E -> Fin (Module.finrank Real E) -> Real -> Real)
    (testRegular : Prop)
    (hSourceTaylorIntegrandSelectedIncrementDef :
      testRegular ->
        forall phi x i z,
          sourceTaylorIntegrand phi x i z =
            sourceSelectedLineIncrement phi x i z)
    (hSelectedIncrementCoordinateLineDef :
      testRegular ->
        forall phi x i z,
          sourceSelectedLineIncrement phi x i z =
            selectedTest phi
              (x + z • (stdOrthonormalBasis Real E i)) -
            selectedTest phi x) :
    testRegular ->
      forall phi x i z,
        sourceTaylorIntegrand phi x i z =
          selectedTest phi
            (x + z • (stdOrthonormalBasis Real E i)) -
          selectedTest phi x
```

Proof sketch for lower_2: introduce `htests phi x i z`; rewrite
`sourceTaylorIntegrand` by
`hSourceTaylorIntegrandSelectedIncrementDef htests phi x i z`, then rewrite
`sourceSelectedLineIncrement` by
`hSelectedIncrementCoordinateLineDef htests phi x i z`.  The implementation
should be a two-step `calc` or two `rw` calls.  It uses only local SALD names
and existing Mathlib notation for `stdOrthonormalBasis` and scalar
multiplication.

This packet does not prove either smaller source field, does not invoke any
external SLT theorem, does not reopen `hSourceHasHessian` or
`hSourceHessianBound`, and does not move the weak-FP `sigma_eta^2/2` prefactor
into the Brownian scalar integrand.
