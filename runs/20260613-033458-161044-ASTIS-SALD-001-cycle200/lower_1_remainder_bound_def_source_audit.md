# Cycle 200 lower_1: normalized remainder-bound definition source audit

Packet classification: `rejected-wrapper-churn`.

Packet type: dynamic-leaf worker packet.

Exact boundary checked:

```lean
hNormalizedRemainderBoundDef :
  testRegular ->
    forall phi x i z,
      remainderBound phi x i z = remainderBoundC phi x i * z ^ 2
```

## Source Question

Does the original SALD source, excluding `sald_version_2.tex`, state the
definition

```text
remainderBound phi x i z = remainderBoundC phi x i * z^2
```

needed by
`SALD.selectedWeakTestNormalizedRemainderBoundIntOfQuadraticBound`?

## Source Search

I searched `/home/nitanda_sub/mark/repos/sald/paper` over `*.tex` files while
excluding `sald_version_2.tex` for:

- `remainderBound`
- `remainderBoundC`
- `remainder`
- `quadratic`
- `Taylor`
- `Hessian`
- `z^2` / `z^{2}`

The exact Lean names `remainderBound` and `remainderBoundC` have no source hit
outside `sald_version_2.tex`.  The broader hits do not state a scalar
dominating-bound definition of the form `C * z^2`.

Checked source anchors:

- `appendix.tex:958-970`: defines the discrete EM update and Gaussian
  increment `xi_k`; no scalar remainder-bound definition.
- `appendix.tex:983-996`: defines the frozen interpolation
  `hat X_s`; no scalar Taylor-remainder bound.
- `appendix.tex:1161-1170`: rewrites the interpolation increment and starts a
  second-moment bound for `||hat X_s - X_k^eta||^2`; this is an increment
  moment estimate, not a normalized scalar Taylor-remainder bound definition.
- `appendix.tex:1358-1387`: starts the KL derivative calculation, defines the
  frozen conditional drift, and cites the Fokker--Planck equation; no
  `remainderBound` definition.
- `appendix.tex:1422-1434`: records the divergence/FI/IBP rewrite; no
  `remainderBound` definition.

## Lean Correspondence

Cycle 196 already compiled the useful bridge:

```lean
SALD.selectedWeakTestNormalizedRemainderBoundIntOfQuadraticBound
```

exported through:

```lean
AutoSamplingTheory.TechnicalLemmas.SALDExtracted.selectedWeakTestNormalizedRemainderBoundIntOfQuadraticBound
```

with registry key `sald.normalized-remainder-bound-int-quadratic`.  It uses
the local Gaussian integrability fact
`AutoSamplingTheory.TechnicalLemmas.Gaussian.integrable_const_mul_sq_gaussianReal_zero`
with registry key `gaussian.quadratic-bound-integrable`.

Cycle 197 already recorded the exact remaining source-contract gap:

```lean
SALD.cycle197GeneralMovingTargetDiscreteEmGeneratorLaplacianEventFieldFrozenScalarBrownianItoNormalizedRemainderBoundDefLower2Obligation
```

Lean inspection in that obligation is still the right boundary: `remainderBound`
and `remainderBoundC` are parameters to the cycle-196 bridge, not local
definitions that can be unfolded.

## lower_2 Handoff

Do not edit Lean for `hNormalizedRemainderBoundDef` in cycle 200 unless a new
original-paper source line is supplied.  I found no such line outside
`sald_version_2.tex`.

Return the existing typed boundary:

```text
leaf=hNormalizedRemainderBoundDef
error_class=source_contract_gap_missing_remainder_bound_definition_already_recorded
existing_obligation=SALD.cycle197GeneralMovingTargetDiscreteEmGeneratorLaplacianEventFieldFrozenScalarBrownianItoNormalizedRemainderBoundDefLower2Obligation
needed_shape=testRegular -> forall phi x i z, remainderBound phi x i z = remainderBoundC phi x i * z ^ 2
source_lines=appendix.tex:958-970;appendix.tex:983-996;appendix.tex:1161-1170;appendix.tex:1358-1387;appendix.tex:1422-1434
```

No external SLT theorem was imported, queued, or marked formalized.  No
source-Hessian, `testRegular`, VP score-Hessian, or same-shape wrapper route is
used.
