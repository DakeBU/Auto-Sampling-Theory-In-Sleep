# Cycle 200 Middle Packet: Normalized Remainder Bound Replay Rejected

Classification: `rejected-wrapper-churn`.

Packet type: dynamic-leaf worker packet.

Exact proposed boundary rejected as stale:

```lean
hNormalizedRemainderBoundDef :
  testRegular ->
    forall phi x i z,
      remainderBound phi x i z = remainderBoundC phi x i * z ^ 2
```

Reason: cycle 197 already recorded this exact source-contract gap in compiled
Lean metadata as

```lean
SALD.cycle197GeneralMovingTargetDiscreteEmGeneratorLaplacianEventFieldFrozenScalarBrownianItoNormalizedRemainderBoundDefLower2Obligation
```

The cycle-196 theorem

```lean
SALD.selectedWeakTestNormalizedRemainderBoundIntOfQuadraticBound
```

already narrows `hNormalizedRemainderBoundInt` to
`hNormalizedRemainderBoundDef` plus the normalized scalar coordinate law. A
new theorem or ProofObligation with the same equality would only rename the
existing blocker.

Source anchors checked by memory/retrieval:

- `appendix.tex:958-970`
- `appendix.tex:983-996`
- `appendix.tex:1161-1170`
- `appendix.tex:1358-1387`
- `appendix.tex:1422-1434`

Callable local facts already available:

- `AutoSamplingTheory.TechnicalLemmas.SALDExtracted.selectedWeakTestNormalizedRemainderBoundIntOfQuadraticBound`
- `AutoSamplingTheory.TechnicalLemmas.Gaussian.integrable_const_mul_sq_gaussianReal_zero`
- registry keys `sald.normalized-remainder-bound-int-quadratic` and `gaussian.quadratic-bound-integrable`

No external SLT theorem is imported, queued, or marked formalized.  Do not use
`sald_version_2.tex`, source-Hessian fields, `testRegular` repackaging, VP
score-Hessian regularity, or a same-shape wrapper around
`hNormalizedRemainderBoundDef`.

## lower_1 Task

Write a short natural-language source audit for exactly this question:

```text
Does the original SALD source, excluding sald_version_2.tex, state the
definition remainderBound phi x i z = remainderBoundC phi x i * z^2?
```

If yes, cite the exact file and line range and explain how it supplies
`hNormalizedRemainderBoundDef`.  If no, return
`rejected-wrapper-churn` and cite the existing cycle-197 obligation instead of
opening a new route.

## lower_2 Task

Do not edit Lean unless lower_1 supplies a new original-paper source line for
the quadratic remainder-bound definition.  If such a line exists, implement
one narrow theorem that turns that source-backed definition into the
`hNormalizedRemainderBoundDef` hypothesis consumed by
`SALD.selectedWeakTestNormalizedRemainderBoundIntOfQuadraticBound`.

If no new line exists, make no Lean change and return typed verifier feedback:

```text
leaf=hNormalizedRemainderBoundDef
error_class=source_contract_gap_missing_remainder_bound_definition_already_recorded
existing_obligation=SALD.cycle197GeneralMovingTargetDiscreteEmGeneratorLaplacianEventFieldFrozenScalarBrownianItoNormalizedRemainderBoundDefLower2Obligation
needed_shape=testRegular -> forall phi x i z, remainderBound phi x i z = remainderBoundC phi x i * z ^ 2
source_lines=appendix.tex:958-970;appendix.tex:983-996;appendix.tex:1161-1170;appendix.tex:1358-1387;appendix.tex:1422-1434
```

No `lower_3` packet is assigned for this cycle unless lower_2 finds a new
local API fact that is not already in the two registry keys above.
