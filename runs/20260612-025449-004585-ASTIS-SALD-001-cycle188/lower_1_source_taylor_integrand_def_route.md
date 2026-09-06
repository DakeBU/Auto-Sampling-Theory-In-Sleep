# Cycle 188 Lower_1 Source Taylor Integrand Definition Route

Classification: `narrows-source-cited-boundary`.

Packet type: dynamic-leaf proof-scout packet for the Brownian/Ito frozen
backend under `sald.general_moving_target_discrete.em_interpolation_fp`.

Exact boundary narrowed:

```lean
hSourceTaylorIntegrandDef :
  testRegular ->
    forall phi x i z,
      sourceTaylorIntegrand phi x i z =
        sourceLinearTerm phi x i z + sourceQuadraticTerm phi x i z +
          normalizedRemainder phi x i z
```

should not remain a primitive source field after the cycle-186 pointwise split.
The smaller source-cited package is:

```lean
hSourceTaylorIntegrandRawDef :
  testRegular ->
    forall phi x i z,
      sourceTaylorIntegrand phi x i z =
        selectedTest phi
          (x + z • (stdOrthonormalBasis Real E i)) -
          selectedTest phi x

hSelectedLineTaylorSplitDef :
  testRegular ->
    forall phi x i z,
      selectedTest phi
          (x + z • (stdOrthonormalBasis Real E i)) -
          selectedTest phi x =
        sourceLinearTerm phi x i z + sourceQuadraticTerm phi x i z +
          normalizedRemainder phi x i z
```

Classical route for this one ticket:

1. Fix `htests : testRegular`, selected weak test `phi`, frozen base point
   `x`, coordinate `i`, and normalized scalar Brownian coordinate `z`.
2. `appendix.tex:984-995` gives the frozen interpolation.  After isolating one
   standard Brownian coordinate using `appendix.tex:958-970` and
   `appendix.tex:1170-1176`, the source scalar integrand is the selected
   weak-test increment along the line
   `q |-> selectedTest phi (x + q • e_i)`, evaluated at `q = z`.
3. Record that naming step as `hSourceTaylorIntegrandRawDef`.  It is only the
   source correspondence for `sourceTaylorIntegrand`; it does not contain the
   Taylor expansion.
4. The Taylor decomposition of that selected line is the separate source
   field `hSelectedLineTaylorSplitDef`: first source term, second source term,
   and the normalized remainder.  Existing cycle-186 and cycle-187 bridges then
   refine the linear and quadratic source terms further.
5. `appendix.tex:1379-1387` keeps the paper's `sigma_eta^2/2` coefficient in
   the weak-Fokker--Planck diffusion term, outside this scalar event-field
   identity.
6. The Lean bridge is just two rewrites:

```lean
theorem selectedWeakTestSourceTaylorIntegrandDefOfRawAndLineTaylorSplit
    ...
    (hSourceTaylorIntegrandRawDef : ...)
    (hSelectedLineTaylorSplitDef : ...) :
    testRegular ->
      forall phi x i z,
        sourceTaylorIntegrand phi x i z =
          sourceLinearTerm phi x i z + sourceQuadraticTerm phi x i z +
            normalizedRemainder phi x i z
```

This route does not import or cite upstream SLT declarations, does not reopen
`hSourceHasHessian` or `hSourceHessianBound`, does not repackage
`testRegular`, and does not move `sigma_eta^2/2` into the event field.

Lower_2-ready handoff: implement the two-rewrite theorem above, or if the two
smaller source fields are rejected, record typed feedback with
`leaf=hSourceTaylorIntegrandDef` and
`error_class=missing_source_definitional_interface`.
