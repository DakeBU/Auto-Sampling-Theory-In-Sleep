# Cycle 200 lower_3 Retrieval Packet

Classification: `rejected-wrapper-churn`.

Packet type: dynamic-leaf worker packet, technical-lemma/API scout.

Exact boundary checked:

```lean
hNormalizedRemainderBoundDef :
  testRegular ->
    forall phi x i z,
      remainderBound phi x i z = remainderBoundC phi x i * z ^ 2
```

Result: no new lower_3 API fact is needed or justified.  Middle already
rejected this as the same boundary recorded in cycle 197:

```lean
SALD.cycle197GeneralMovingTargetDiscreteEmGeneratorLaplacianEventFieldFrozenScalarBrownianItoNormalizedRemainderBoundDefLower2Obligation
```

The existing callable local facts remain exactly:

- `AutoSamplingTheory.TechnicalLemmas.SALDExtracted.selectedWeakTestNormalizedRemainderBoundIntOfQuadraticBound`
- `AutoSamplingTheory.TechnicalLemmas.Gaussian.integrable_const_mul_sq_gaussianReal_zero`
- registry key `sald.normalized-remainder-bound-int-quadratic`
- registry key `gaussian.quadratic-bound-integrable`

These reduce `hNormalizedRemainderBoundInt` to the source-facing equality
`hNormalizedRemainderBoundDef` plus the normalized scalar coordinate law, but
they do not define `remainderBound` or `remainderBoundC`.

Source/API checks performed:

- `rg -n "remainderBound|remainderBoundC|normalizedRemainder|Taylor|remainder" /home/nitanda_sub/mark/repos/sald/paper -g '*.tex' -g '!sald_version_2.tex'`
- `rg -n "normalized-remainder-bound-int-quadratic|quadratic-bound-integrable|hNormalizedRemainderBoundDef|source_contract_gap_missing_remainder_bound_definition|selectedWeakTestNormalizedRemainderBoundIntOfQuadraticBound|cycle197" research-wiki proof-obligations AutoSamplingTheory/TechnicalLemmas AutoSamplingTheory/SALD.lean runs/20260613-033458-161044-ASTIS-SALD-001-cycle200`
- `sed -n '1,220p' research-wiki/technical-lemmas/technical_lemma_registry.jsonl`

The TeX search excluding `sald_version_2.tex` found no paper occurrence of
`remainderBound`, `remainderBoundC`, or a Lean-facing equality
`remainderBound phi x i z = remainderBoundC phi x i * z ^ 2`.  The relevant
source anchors remain:

- `appendix.tex:958-970`: discrete EM step.
- `appendix.tex:983-996`: frozen interpolation.
- `appendix.tex:1161-1170`: increment Gaussian representation.
- `appendix.tex:1358-1387`: KL derivative and weak Fokker-Planck handoff.
- `appendix.tex:1422-1434`: divergence/FI/IBP rewrite.

No external SLT theorem was imported, called, queued, or marked formalized.
No source-Hessian wrapper, `testRegular` repackaging, VP score-Hessian
substitution, broad route audit, or new TechnicalLemmas declaration was added.

Typed verifier feedback for this lower_3 scout:

```text
leaf=hNormalizedRemainderBoundDef
error_class=no_new_local_api_gap_rejected_wrapper_churn
existing_obligation=SALD.cycle197GeneralMovingTargetDiscreteEmGeneratorLaplacianEventFieldFrozenScalarBrownianItoNormalizedRemainderBoundDefLower2Obligation
existing_registry=sald.normalized-remainder-bound-int-quadratic;gaussian.quadratic-bound-integrable
needed_shape=testRegular -> forall phi x i z, remainderBound phi x i z = remainderBoundC phi x i * z ^ 2
source_lines=appendix.tex:958-970;appendix.tex:983-996;appendix.tex:1161-1170;appendix.tex:1358-1387;appendix.tex:1422-1434
```
