# Cycle 187 Lower_1 Source Quadratic Term Route

Classification: `narrows-source-cited-boundary`.

Packet type: dynamic-leaf proof-scout packet for the Brownian/Ito frozen
backend under `sald.general_moving_target_discrete.em_interpolation_fp`.

Exact boundary narrowed:

```lean
hSourceQuadraticTermDef :
  testRegular ->
    forall phi x i z,
      sourceQuadraticTerm phi x i z = quadraticCoeff phi x i * z ^ 2
```

Smaller source-cited package:

```lean
hSourceQuadraticTermTaylorDef :
  testRegular ->
    forall phi x i z,
      sourceQuadraticTerm phi x i z =
        ((2 : Real) *
          taylorCoeffWithin
            (fun q : Real =>
              selectedTest phi
                (x + q • (stdOrthonormalBasis Real E i)))
            2 Set.univ 0) * z ^ 2

hScalarLineTaylorCoeffDef :
  testRegular ->
    forall phi x i,
      quadraticCoeff phi x i =
        (2 : Real) *
          taylorCoeffWithin
            (fun q : Real =>
              selectedTest phi
                (x + q • (stdOrthonormalBasis Real E i)))
            2 Set.univ 0
```

Classical route: `appendix.tex:984-995` gives the frozen interpolation and the
one-coordinate Brownian event field.  `appendix.tex:958-970` and
`appendix.tex:1170-1176` identify the normalized scalar Brownian coordinate.
The quadratic source term is the order-two scalar Taylor term of
`q |-> selectedTest phi (x + q • e_i)`, multiplied by `z ^ 2`.  The weak-FP
diffusion coefficient `sigma_eta^2/2` remains outside this event-field identity
as shown in `appendix.tex:1379-1387`.

Lower_2 bridge implemented in this cycle:

```lean
SALD.selectedWeakTestSourceQuadraticTermDefOfScalarLineTaylorCoeffDef
```

The bridge is only two rewrites from `hSourceQuadraticTermTaylorDef` and
`hScalarLineTaylorCoeffDef`.  It does not prove the scalar Taylor source field,
does not use external SLT declarations, and does not reopen
`hSourceHasHessian` or `hSourceHessianBound`.
