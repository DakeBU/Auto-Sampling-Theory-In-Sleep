discharges-supplied-hypothesis dynamic-leaf worker packet.

Global phase judgment: cycle 189 succeeded and needs no recovery; Phase 1
theorem-skeleton translation remains stable enough for cited-theory backfill.
The active lower packet still targets
`sald.general_moving_target_discrete.em_interpolation_fp` over
`appendix.tex:1358-1387`.  The single lower packet that now reduces the largest
proof risk is to discharge the intermediate
`hRemainderGeneratorNormalizedLawDef` supplied hypothesis from the
`hRemainderGeneratorLimitDef` backend, so the Brownian/Ito frozen interpolation
can use the concrete scalar-pushforward source fields directly.

## Self-Reflection Guard

- Classification: `discharges-supplied-hypothesis`.
- Exact supplied hypothesis discharged:
  `hRemainderGeneratorNormalizedLawDef` inside the
  `hRemainderGeneratorLimitDef` boundary.
- Packet type: dynamic-leaf worker packet, not an illness-area refiner.
- Local declarations to reuse:
  `SALD.selectedWeakTestRemainderGeneratorNormalizedLawDefOfScalarPushforward`
  and `SALD.selectedWeakTestRemainderGeneratorLimitDefOfStdGaussianVectorLaw`.
  The latter already reuses the compiled local Gaussian coordinate-law and
  variance bridges.  No external SLT theorem is to be imported, called, queued
  as formalized, or used as a runtime dependency.
- Broad source-index work, theorem-route replay, source-Hessian work,
  `testRegular` repackaging, VP score-Hessian substitution, and consumer
  wrapper churn are rejected for this cycle.

## Objective

Mode remains `faithfulPaper`.  Keep the theorem target fixed and continue the
Brownian/Ito frozen-interpolation backend before moving to the KL derivative
or divergence/FI/IBP handoff.

Lower should produce a compiled local bridge, tentatively:

```lean
SALD.selectedWeakTestRemainderGeneratorLimitDefOfScalarPushforwardAndStdGaussianVectorLaw
```

The intended theorem derives:

```lean
hRemainderGeneratorLimitDef :
  testRegular ->
    forall phi x i,
      remainderGeneratorLimit phi x i =
        integral (fun z => normalizedRemainder phi x i z)
          (ProbabilityTheory.gaussianReal 0 (variance phi x i))
```

from the smaller source-cited fields:

```lean
hScalarMeas
hNormalizedCoordinateLawDef
hNormalizedRemainderMeas
hRemainderPullbackDef
hNormalizedVectorLaw
hCoordinateLawDef
hVarianceDef
```

The proof route is:

1. Use
   `SALD.selectedWeakTestRemainderGeneratorNormalizedLawDefOfScalarPushforward`
   to build `hRemainderGeneratorNormalizedLawDef` from scalar-coordinate
   measurability, the normalized-coordinate pushforward law, normalized
   remainder measurability, and the sample-space pullback definition.
2. Feed that derived field into
   `SALD.selectedWeakTestRemainderGeneratorLimitDefOfStdGaussianVectorLaw`
   together with `hNormalizedVectorLaw`, `hCoordinateLawDef`, and
   `hVarianceDef`.
3. Leave `hRemainderMeas`, `hRemainderBound`, `hRemainderBoundInt`, and the
   selected weak-test Hessian source-contract gap untouched.

Source anchors: `appendix.tex:958-970`, `appendix.tex:983-996`,
`appendix.tex:1161-1170`, and `appendix.tex:1379-1387`.  These anchors keep
the normalized Brownian coordinate and the weak-Fokker--Planck
`sigma_eta^2 / 2` diffusion prefactor separate.

## Lower Packets

lower_1: write the natural-language classical proof route for the exact theorem
above.  The route should explain sample-space-to-law transport by
`MeasureTheory.integral_map`, then standard-Gaussian coordinate-law and
variance rewriting.  Do not broaden to a source-Hessian audit or a full Taylor
remainder DCT proof.

lower_2: implement exactly one compiled ASTIS-owned theorem with the tentative
name above, or record a strictly smaller source-cited obligation with typed
verifier feedback if the theorem shape fails.  The theorem should compose the
two existing local SALD bridges; it must not create a new top-level consumer
wrapper that leaves `hRemainderGeneratorNormalizedLawDef` as a required field.

| Block | Interface | Dependencies | Lean declaration | Source anchor | Reused by | Status |
|---|---|---|---|---|---|---|
| Cycle 190 remainder limit scalar-pushforward bridge | Derive `hRemainderGeneratorLimitDef` directly from scalar pushforward, normalized-coordinate law, normalized remainder measurability, sample-space remainder pullback, and Gaussian law/variance fields. | `SALD.selectedWeakTestRemainderGeneratorNormalizedLawDefOfScalarPushforward`; `SALD.selectedWeakTestRemainderGeneratorLimitDefOfStdGaussianVectorLaw`; local Gaussian coordinate-law/variance bridges | proposed `SALD.selectedWeakTestRemainderGeneratorLimitDefOfScalarPushforwardAndStdGaussianVectorLaw` | `appendix.tex:958-970`; `appendix.tex:983-996`; `appendix.tex:1161-1170`; `appendix.tex:1379-1387` | `hRemainderGeneratorLimitDef`; Brownian/Ito Taylor moment backend; weak-FP line; KL derivative handoff | assigned |

## Reviewer Checklist

- Confirm the packet still reduces
  `sald.general_moving_target_discrete.em_interpolation_fp` over
  `appendix.tex:1358-1387`.
- Accept only if `hRemainderGeneratorNormalizedLawDef` is no longer a supplied
  hypothesis of the new remainder-limit bridge, or if lower records a strictly
  smaller source-cited obligation with typed verifier feedback.
- Check source anchors above and reject any use of `sald_version_2.tex`.
- Reject `axiom`, `sorry`, `admit`, `Prop := True`, `:= trivial`, direct SLT
  imports/calls, VP score-Hessian substitution, source-Hessian wrapper churn,
  or moving the `sigma_eta^2 / 2` weak-FP factor into the scalar event field.
- Run `python3 tools/astis.py check`.
