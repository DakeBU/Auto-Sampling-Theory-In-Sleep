# Cycle 197 Lower_3 Normalized Remainder Bound-Definition API Scout

Classification: `rejected-wrapper-churn`.

Packet type: dynamic-leaf worker support packet for the Brownian/Ito frozen
backend under `sald.general_moving_target_discrete.em_interpolation_fp`.

Exact missing theorem boundary:

```lean
hNormalizedRemainderBoundDef :
  testRegular ->
    forall phi x i z,
      remainderBound phi x i z = remainderBoundC phi x i * z ^ 2
```

Lower_3 technical-lemma/API result:

- `remainderBound` and `remainderBoundC` are theorem parameters in
  `SALD.selectedWeakTestNormalizedRemainderBoundIntOfQuadraticBound`, not
  local Lean definitions that unfold to the displayed quadratic expression.
- A source search over `/home/nitanda_sub/mark/repos/sald/paper`, excluding
  `sald_version_2.tex`, found no original-paper definition of
  `remainderBound`, `remainderBoundC`, or the exact quadratic bound
  `remainderBoundC phi x i * z ^ 2`.
- The callable ASTIS support is already complete for the integrability side:
  `AutoSamplingTheory.TechnicalLemmas.SALDExtracted.selectedWeakTestNormalizedRemainderBoundIntOfQuadraticBound`
  and
  `AutoSamplingTheory.TechnicalLemmas.Gaussian.integrable_const_mul_sq_gaussianReal_zero`.

This means another local theorem that assumes the displayed equality under a
new name would only repackage the missing source definition.  The correct next
boundary is a source-correspondence decision for the dominating-bound
definition itself, or typed verifier feedback:

```text
leaf=hNormalizedRemainderBoundDef
error_class=source_contract_gap_missing_remainder_bound_definition
needed_shape=remainderBound phi x i z = remainderBoundC phi x i * z ^ 2
source_lines=appendix.tex:958-996; appendix.tex:1161-1170; appendix.tex:1358-1387; appendix.tex:1422-1434
blocked_by=no Lean definitional unfolding and no original-paper definition of remainderBound/remainderBoundC outside sald_version_2.tex
```

Source anchors checked:

- `appendix.tex:958-970`
- `appendix.tex:983-996`
- `appendix.tex:1161-1170`
- `appendix.tex:1358-1387`
- `appendix.tex:1422-1434`

No external SLT theorem was imported, called, queued, or marked formalized.
No source-Hessian, `testRegular`, VP score-Hessian, broad source-index, or
consumer-wrapper work was performed.
