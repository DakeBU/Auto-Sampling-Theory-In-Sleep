rejected-wrapper-churn.

# Cycle 197 Lower_1 Route: `hNormalizedRemainderBoundDef`

Packet type: dynamic-leaf worker packet for the Brownian/Ito frozen backend
under `sald.general_moving_target_discrete.em_interpolation_fp`.

Exact proposed boundary audited:

```lean
hNormalizedRemainderBoundDef :
  testRegular ->
    forall phi x i z,
      remainderBound phi x i z = remainderBoundC phi x i * z ^ 2
```

Result: this is a source-contract gap, not a lower_2 theorem target unless an
existing Lean definition of `remainderBound` unfolds to the displayed right
hand side.

## Source Check

The relevant original-paper anchors, excluding `sald_version_2.tex`, are:

- `appendix.tex:958-996`: Euler--Maruyama step and frozen interpolation.
- `appendix.tex:1161-1170`: Brownian increment rewritten as a drift part plus
  a Gaussian increment.
- `appendix.tex:1358-1387`: KL derivative setup and conditional weak
  Fokker--Planck line.
- `appendix.tex:1422-1434`: divergence/FI/IBP rewrite downstream.

These lines support the Brownian scalar coordinate law and the need for a
dominated Taylor remainder, but they do not define a source object named
`remainderBound`, do not define `remainderBoundC`, and do not state the
quadratic equality `remainderBound phi x i z = remainderBoundC phi x i * z ^ 2`.
The TeX search over `/home/nitanda_sub/mark/repos/sald/paper`, excluding
`sald_version_2.tex`, found no occurrence of `remainderBound` or
`remainderBoundC`.

## Classical Route, Conditional On A Definition

If the paper or Lean context already supplied

```lean
remainderBound phi x i z := remainderBoundC phi x i * z ^ 2
```

then `hNormalizedRemainderBoundDef` would be a definitional proof:

1. Fix `htests : testRegular`, `phi`, `x`, `i`, and `z`.
2. Unfold the source definition of `remainderBound`.
3. Close by reflexivity or `simp`.
4. Feed the equality to
   `SALD.selectedWeakTestNormalizedRemainderBoundIntOfQuadraticBound`, which
   already proves the integrability consequence once
   `normalizedCoordinateLaw phi x i = ProbabilityTheory.gaussianReal 0 1`.

This route uses no external SLT theorem.  The compiled local support is:

- `SALD.selectedWeakTestNormalizedRemainderBoundIntOfQuadraticBound`.
- `AutoSamplingTheory.TechnicalLemmas.SALDExtracted.selectedWeakTestNormalizedRemainderBoundIntOfQuadraticBound`
  with registry key `sald.normalized-remainder-bound-int-quadratic`.
- `SALD.gaussianRealSelectedTestLineSecondOrderQuadraticBoundIntegrable`.
- `AutoSamplingTheory.TechnicalLemmas.Gaussian.integrable_const_mul_sq_gaussianReal_zero`
  with registry key `gaussian.quadratic-bound-integrable`.

## Why Lower_2 Should Not Add A Wrapper

In `AutoSamplingTheory/SALD.lean`, `remainderBound` and `remainderBoundC` occur
as parameters of the cycle-196 theorem.  They are not local definitions that
can currently be unfolded to the displayed quadratic expression.  A theorem of
the form

```lean
theorem selectedWeakTestNormalizedRemainderBoundDefOfAssumption
    (h : testRegular ->
      forall phi x i z,
        remainderBound phi x i z = remainderBoundC phi x i * z ^ 2) :
    testRegular ->
      forall phi x i z,
        remainderBound phi x i z = remainderBoundC phi x i * z ^ 2 := h
```

would merely rename the missing hypothesis and must be rejected as wrapper
churn.

The faithful-paper conclusion is therefore:

```text
leaf=hNormalizedRemainderBoundDef
error_class=source_contract_gap_missing_remainder_bound_definition
needed_shape=remainderBound phi x i z = remainderBoundC phi x i * z ^ 2
source_lines=appendix.tex:958-996; appendix.tex:1161-1170; appendix.tex:1358-1387; appendix.tex:1422-1434
blocked_by=no original-paper definition of remainderBound/remainderBoundC outside sald_version_2.tex
```

## Lower_2 Handoff

Lower_2 should perform exactly one of these two actions:

1. If an existing Lean-side definition of `remainderBound` is in scope and
   unfolds to `remainderBoundC phi x i * z ^ 2`, implement the definitional
   theorem by unfolding that definition and closing the equality.
2. Otherwise, record the typed verifier feedback above.  Do not add a renamed
   equality hypothesis, do not revisit source-Hessian fields, and do not add
   another integrability or normalized-law transport theorem; those parts are
   already compiled locally.
