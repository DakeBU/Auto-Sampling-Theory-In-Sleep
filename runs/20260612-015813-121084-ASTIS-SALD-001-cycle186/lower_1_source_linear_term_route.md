# Cycle 186 Lower_1 Source Linear Term Route

Classification: `narrows-source-cited-boundary`.

Packet type: dynamic-leaf proof-scout packet for the Brownian/Ito frozen
backend under `sald.general_moving_target_discrete.em_interpolation_fp`.

Exact boundary narrowed:

```lean
hSourceLinearTermDef :
  testRegular ->
    forall phi x i z,
      sourceLinearTerm phi x i z = linearCoeff phi x i * z
```

should not remain a primitive source field after the cycle-186 split of
`hSourceTaylorIntegrandPointwise`.  The next smaller source-cited boundary is:

```lean
hSourceLinearTermTaylorDef :
  testRegular ->
    forall phi x i z,
      sourceLinearTerm phi x i z =
        deriv
          (fun q : Real =>
            selectedTest phi (x + q • (stdOrthonormalBasis Real E i))) 0 * z

hScalarLineFirstCoeffDef :
  testRegular ->
    forall phi x i,
      linearCoeff phi x i =
        deriv
          (fun q : Real =>
            selectedTest phi (x + q • (stdOrthonormalBasis Real E i))) 0
```

Classical route for this one ticket:

1. Fix `htests : testRegular`, a selected weak test `phi`, base point `x`,
   coordinate `i`, and scalar normalized Brownian coordinate `z`.
2. `appendix.tex:984-995` gives the frozen interpolation.  After separating
   the deterministic frozen drift, the scalar Brownian event-field increment is
   read along the selected line
   `q |-> selectedTest phi (x + q • e_i)`.
3. `appendix.tex:958-970` and `appendix.tex:1170-1176` give the standard
   Gaussian normalized coordinate convention.  This fixes `z` as the scalar
   coordinate variable; it does not move the paper's diffusion prefactor into
   the source linear term.
4. The first-order part of the scalar Taylor expansion of the selected line at
   `q = 0` is
   `(deriv (fun q => selectedTest phi (x + q • e_i)) 0) * z`.  Record this as
   `hSourceLinearTermTaylorDef`.
5. The local coefficient convention says that `linearCoeff phi x i` is this
   same first directional derivative.  Record this as
   `hScalarLineFirstCoeffDef`.
6. Rewriting the source linear term by step 4 and the coefficient by step 5
   gives `hSourceLinearTermDef` by definitional algebra.  The weak-FP line
   `appendix.tex:1379-1387` keeps the global diffusion coefficient outside
   this scalar event-field identity.

Lower_2-ready theorem shape:

```lean
theorem selectedWeakTestSourceLinearTermDefOfScalarLineFirstCoeffDef
    {Test E : Type*} [NormedAddCommGroup E] [InnerProductSpace Real E]
    [FiniteDimensional Real E]
    (selectedTest : Test -> E -> Real)
    (linearCoeff : Test -> E -> Fin (Module.finrank Real E) -> Real)
    (sourceLinearTerm :
      Test -> E -> Fin (Module.finrank Real E) -> Real -> Real)
    (testRegular : Prop)
    (hSourceLinearTermTaylorDef :
      testRegular ->
        forall phi x i z,
          sourceLinearTerm phi x i z =
            deriv
              (fun q : Real =>
                selectedTest phi
                  (x + q • (stdOrthonormalBasis Real E i))) 0 * z)
    (hScalarLineFirstCoeffDef :
      testRegular ->
        forall phi x i,
          linearCoeff phi x i =
            deriv
              (fun q : Real =>
                selectedTest phi
                  (x + q • (stdOrthonormalBasis Real E i))) 0) :
    testRegular ->
      forall phi x i z,
        sourceLinearTerm phi x i z = linearCoeff phi x i * z
```

Expected Lean proof block: introduce `htests phi x i z`, rewrite by
`hSourceLinearTermTaylorDef htests phi x i z`, then rewrite the derivative by
the symmetric form of `hScalarLineFirstCoeffDef htests phi x i`.  No measure
theory is needed for this bridge.

Local/Mathlib ingredients: only local source-term names, `stdOrthonormalBasis`,
and Mathlib `deriv` notation for the lower_2 algebraic bridge.  The analytic
content remains the two smaller source-cited fields above.  This packet does
not import or cite upstream SLT declarations, does not reopen
`hSourceHasHessian` or `hSourceHessianBound`, does not repackage
`testRegular`, and does not move `sigma_eta^2/2` into the event field.

Remaining exact backend after this route:

```lean
hSourceLinearTermTaylorDef
hScalarLineFirstCoeffDef
hSourceTaylorIntegrandDef
hSourceQuadraticTermDef
hScalarMeas
hNormalizedCoordinateLawDef
hSourceTaylorIntegrandMeas
hGeneratorPullbackDef
hNormalizedRemainderMeas
hRemainderPullbackDef
hRemainderMeas
hRemainderBound
hRemainderBoundInt
```

Lower_2 should implement the theorem shape above if the two smaller fields are
accepted as the next source interface; otherwise lower_2 should record
`hSourceLinearTermTaylorDef` and `hScalarLineFirstCoeffDef` as typed
source-cited obligations with these exact anchors.
