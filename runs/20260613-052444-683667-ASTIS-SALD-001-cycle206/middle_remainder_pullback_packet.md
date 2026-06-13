# Cycle 206 Middle Packet: Remainder Pullback

narrows-source-cited-boundary.

Packet type: dynamic-leaf worker packet.

Exact missing theorem boundary narrowed: `hRemainderPullbackDef`.

## Lean-Facing Boundary

```lean
hRemainderPullbackDef :
  testRegular ->
    forall phi x i,
      remainderGeneratorLimit phi x i =
        ∫ omega : Omega,
          normalizedRemainder phi x i
            (scalarBrownianCoordinate phi x i omega) ∂P
```

This boundary sits below `hRemainderGeneratorLimitDef`.  The existing compiled
bridges already consume it:

```lean
SALD.selectedWeakTestRemainderGeneratorNormalizedLawDefOfScalarPushforward
SALD.selectedWeakTestRemainderGeneratorLimitDefOfStdGaussianVectorLaw
SALD.selectedWeakTestRemainderGeneratorLimitDefOfScalarPushforwardAndStdGaussianVectorLaw
```

Do not add another law-level consumer wrapper.  Either discharge this exact
sample-space pullback definition from reducible local definitions, or record
the typed source-contract gap below.

## Source Anchors

- `appendix.tex:958-970`: discrete EM Brownian increment.
- `appendix.tex:983-996`: frozen continuous interpolation.
- `appendix.tex:1161-1170`: normalized Brownian increment representation with `xi ~ N(0,I)`.
- `appendix.tex:1379-1387`: weak Fokker--Planck consumer for the frozen interpolation.

Targeted source search excluding `sald_version_2.tex` found no named
`normalizedRemainder`, `remainderGeneratorLimit`, or pullback definition in
the original paper source.

## Technical Lemma Retrieval

Callable local facts only:

- `AutoSamplingTheory.TechnicalLemmas.SALDExtracted.selectedWeakTestNormalizedCoordinateLawOfStdGaussianVectorLaw`
- `AutoSamplingTheory.TechnicalLemmas.Gaussian.nnrealVarianceOneOfGaussianRealUnitLaw`
- existing SALD bridges listed above, all compiled under `AutoSamplingTheory/SALD.lean`

No external SLT theorem is imported, called, queued, or marked formalized.

## lower_1 Task

Write the natural-language classical route for the single ticket
`hRemainderPullbackDef`: start from the frozen EM scalar Brownian coordinate,
evaluate the selected normalized Taylor remainder along that coordinate, and
identify the paper's remainder generator contribution as the corresponding
sample-space expectation.  Keep the source-Hessian fields, selected-line raw
Taylor split, endpoint/naming fields, KL derivative, and IBP consumer out of
scope.

## lower_2 Task

Inspect whether the local Lean definitions for `remainderGeneratorLimit`,
`normalizedRemainder`, and `scalarBrownianCoordinate` reduce to the pullback
identity above.  If they reduce, implement exactly one compiled theorem for
that identity and reuse the existing scalar-pushforward bridge.  If they do
not reduce, record one source-cited obligation with:

```text
leaf=hRemainderPullbackDef
error_class=source_contract_gap_missing_remainder_pullback_definition
needed_shape=testRegular -> forall phi x i, remainderGeneratorLimit phi x i =
  integral omega, normalizedRemainder phi x i
    (scalarBrownianCoordinate phi x i omega) dP
source_lines=appendix.tex:958-970;appendix.tex:983-996;appendix.tex:1161-1170;appendix.tex:1379-1387
blocked_by=remainderGeneratorLimit and normalizedRemainder are source-facing abstract fields in the compiled scalar-pushforward remainder bridge unless lower_2 finds a reducible local definition
```

## Reviewer Checks

Require `python3 tools/astis.py check`.  Accept only a compiled local theorem
for the exact pullback identity or a typed source-contract obligation with the
feedback fields above.  Reject source-Hessian replay, selected-line Taylor
replay, direct SLT dependencies, theorem-status promotion, and consumer-wrapper
churn.
