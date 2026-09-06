# Cycle 206 Lower_3 API Scout: Remainder Pullback

rejected-wrapper-churn.

Packet type: dynamic-leaf API-scout packet.

Exact missing theorem boundary checked: `hRemainderPullbackDef`.

## Result

No new reusable technical lemma should be ported or wrapped for this cycle.
The local measure-map API already covers the only reusable background step:
transporting an integral across the scalar Brownian coordinate pushforward.
The unproved content of `hRemainderPullbackDef` is source-facing: the paper must
identify `remainderGeneratorLimit` as the sample-space expectation of
`normalizedRemainder` evaluated at `scalarBrownianCoordinate`.

The exact lower-facing shape remains:

```lean
hRemainderPullbackDef :
  testRegular ->
    forall phi x i,
      remainderGeneratorLimit phi x i =
        integral omega,
          normalizedRemainder phi x i
            (scalarBrownianCoordinate phi x i omega) dP
```

## Local Callable API

- `AutoSamplingTheory.TechnicalLemmas.Measure.lawMapIntegral`
- `MeasureTheory.integral_map`
- `SALD.selectedWeakTestRemainderGeneratorNormalizedLawDefOfScalarPushforward`
- `SALD.selectedWeakTestRemainderGeneratorLimitDefOfScalarPushforwardAndStdGaussianVectorLaw`
- `AutoSamplingTheory.TechnicalLemmas.SALDExtracted.selectedWeakTestNormalizedCoordinateLawOfStdGaussianVectorLaw`
- `AutoSamplingTheory.TechnicalLemmas.Gaussian.nnrealVarianceOneOfGaussianRealUnitLaw`

`SALD.selectedWeakTestRemainderGeneratorNormalizedLawDefOfScalarPushforward`
already proves the law-space normalized-remainder integral from
`hScalarMeas`, `hNormalizedCoordinateLawDef`, `hNormalizedRemainderMeas`, and
`hRemainderPullbackDef`.  Adding a new lower_3 wrapper around
`MeasureTheory.integral_map` would only restate this existing compiled bridge.

## Source And SLT Search

Checked source anchors in the original SALD source, excluding
`sald_version_2.tex`:

- `appendix.tex:958-970`: discrete EM Brownian increment.
- `appendix.tex:983-996`: frozen continuous interpolation.
- `appendix.tex:1161-1170`: normalized Brownian increment representation with
  `xi ~ N(0,I)`.
- `appendix.tex:1379-1387`: weak Fokker--Planck consumer.

Targeted source search found no occurrence of `normalizedRemainder`,
`remainderGeneratorLimit`, `RemainderPullback`, `normalized remainder`,
`remainder generator`, or a named pullback definition.

The external SLT clone was searched only as provenance.  It contains ordinary
`integral_map` usage patterns and Taylor-bound reference material, but no
theorem defining the VA-SALD paper's `remainderGeneratorLimit` or
`normalizedRemainder`.  No external SLT declaration is imported, called, queued,
or marked formalized.

## Handoff

For lower_2/reviewer: the correct next action is still either:

- discharge `hRemainderPullbackDef` if the current local definitions reduce to
  the displayed sample-space expectation; or
- keep the source-contract gap with typed verifier feedback:
  `leaf=hRemainderPullbackDef`,
  `error_class=source_contract_gap_missing_remainder_pullback_definition`,
  `source_lines=appendix.tex:958-970;appendix.tex:983-996;appendix.tex:1161-1170;appendix.tex:1379-1387`.

This packet rejects source-Hessian replay, selected-line Taylor replay, direct
SLT dependency use, theorem-status promotion, and consumer-wrapper churn.
