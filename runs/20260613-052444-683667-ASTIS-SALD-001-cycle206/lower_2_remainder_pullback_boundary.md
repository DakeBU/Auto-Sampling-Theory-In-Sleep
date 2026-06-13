# Cycle 206 lower_2: Remainder Pullback Boundary

narrows-source-cited-boundary.

Packet type: dynamic-leaf worker packet.

Exact missing theorem boundary narrowed: `hRemainderPullbackDef`.

## Boundary Checked

```lean
hRemainderPullbackDef :
  testRegular ->
    forall phi x i,
      remainderGeneratorLimit phi x i =
        ∫ omega : Omega,
          normalizedRemainder phi x i
            (scalarBrownianCoordinate phi x i omega) ∂P
```

This is strictly below `hRemainderGeneratorLimitDef`: the existing compiled
bridges already derive the law-level normalized-remainder generator identity
from this pullback field, scalar-coordinate measurability, the normalized
coordinate pushforward law, and the standard-Gaussian coordinate-law fields.

## Lean Inspection

Callable compiled bridges:

```lean
SALD.selectedWeakTestRemainderGeneratorNormalizedLawDefOfScalarPushforward
SALD.selectedWeakTestRemainderGeneratorLimitDefOfStdGaussianVectorLaw
SALD.selectedWeakTestRemainderGeneratorLimitDefOfScalarPushforwardAndStdGaussianVectorLaw
```

`remainderGeneratorLimit`, `normalizedRemainder`, and
`scalarBrownianCoordinate` occur in these interfaces as abstract parameters.
They are not reducible local definitions, so the pullback identity cannot be
closed by `rfl`, `simp`, or unfolding.

The lower_1 route artifact
`runs/20260613-052444-683667-ASTIS-SALD-001-cycle206/lower_1_remainder_pullback_route.md`
assigns the same exact boundary and the same fallback feedback.  The lower_2
result follows that route by recording the source-contract gap after the
reducibility check fails.

## Source Check

Source anchors checked in `/home/nitanda_sub/mark/repos/sald/paper/appendix.tex`:

- `appendix.tex:958-970`: discrete EM Brownian increment.
- `appendix.tex:983-996`: frozen continuous interpolation.
- `appendix.tex:1161-1170`: normalized Brownian increment representation with `xi ~ N(0,I)`.
- `appendix.tex:1379-1387`: weak Fokker--Planck consumer.

Targeted search excluding `sald_version_2.tex` found no named
`normalizedRemainder`, `remainderGeneratorLimit`, `RemainderPullback`,
`normalized remainder`, `remainder generator`, or `pullback` definition in the
original paper source.

## Recorded Lean Boundary

```lean
SALD.cycle206GeneralMovingTargetDiscreteEmGeneratorLaplacianEventFieldFrozenScalarBrownianItoRemainderPullbackLower2Obligation
SALD.cycle206GeneralMovingTargetDiscreteEmGeneratorLaplacianEventFieldFrozenScalarBrownianItoRemainderPullbackLower2Dag
```

Typed verifier feedback:

```text
leaf=hRemainderPullbackDef
error_class=source_contract_gap_missing_remainder_pullback_definition
needed_shape=testRegular -> forall phi x i, remainderGeneratorLimit phi x i =
  integral omega, normalizedRemainder phi x i
    (scalarBrownianCoordinate phi x i omega) dP
source_lines=appendix.tex:958-970;appendix.tex:983-996;appendix.tex:1161-1170;appendix.tex:1379-1387
blocked_by=remainderGeneratorLimit, normalizedRemainder, and scalarBrownianCoordinate are abstract parameters in the compiled scalar-pushforward remainder bridge
```

No external SLT theorem was imported, called, queued, or marked formalized.
No source-Hessian, selected-line Taylor, endpoint/naming, or consumer-wrapper
route was replayed.
