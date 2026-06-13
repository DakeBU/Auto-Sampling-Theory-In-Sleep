# Lower 3 Packet: Source-Laplacian Measurability Retrieval

Classification: `narrows-source-cited-boundary`.

Packet type: dynamic-leaf technical-lemma/API scout packet, not an illness-area
refiner.

Exact missing theorem boundary narrowed:

```lean
hsourceLaplacianFieldMeas :
  testRegular ->
    forall phi,
      MeasureTheory.AEStronglyMeasurable
        (Laplacian.laplacian (selectedTest phi)) hatRhoS
```

Cycle 199 already narrows this law-dependent boundary through the compiled
local theorem:

```lean
SALD.generalMovingTargetDiscreteSourceLaplacianFieldMeasOfSelectedTestLaplacianMeasurable
```

The remaining smaller source-facing boundary is:

```lean
hSelectedTestLaplacianMeasurable :
  testRegular ->
    forall phi, Measurable (Laplacian.laplacian (selectedTest phi))
```

Lower_3 additionally compiled the local API bridge:

```lean
SALD.generalMovingTargetDiscreteSelectedTestLaplacianMeasurableOfContinuous
```

which narrows `hSelectedTestLaplacianMeasurable` to:

```lean
hSelectedTestLaplacianContinuous :
  testRegular ->
    forall phi, Continuous (Laplacian.laplacian (selectedTest phi))
```

Use site: `sald.general_moving_target_discrete.em_interpolation_fp`, with
paper-memory row `weak-fokker-planck-line` and source anchors
`appendix.tex:983-996` and `appendix.tex:1379-1387`.

## Retrieval Result

Callable local declarations:

- `SALD.generalMovingTargetDiscreteSourceLaplacianFieldMeasOfSelectedTestLaplacianMeasurable`
  derives the `hatRhoS`-specific AE-strong measurability field from ordinary
  measurability by `Measurable.aestronglyMeasurable`.
- `SALD.generalMovingTargetDiscreteEmGeneratorTraceFieldMeasOfSourceLaplacianFieldMeas`
  is the downstream local bridge that can consume `hsourceLaplacianFieldMeas`
  once the cycle-199 bridge supplies it.
- `SALD.generalMovingTargetDiscreteWeakFpSourceActionDefOfSourceLaplacianStateIntegral`
  is the weak-FP consumer that keeps the source-Laplacian field explicit.
- Mathlib `Continuous.measurable` is the immediate API route if the paper source
  supplies
  `testRegular -> forall phi, Continuous (Laplacian.laplacian (selectedTest phi))`.
- `SALD.generalMovingTargetDiscreteSelectedTestLaplacianMeasurableOfContinuous`
  is the compiled local bridge for that route; it requires the standard
  `BorelSpace E` side condition used by Mathlib continuous-to-measurable APIs.
- Mathlib `Measurable.aestronglyMeasurable` is already used by the compiled
  cycle-199 theorem; adding a reusable wrapper around it would be wrapper churn.

Source/API audit:

- `appendix.tex:983-996` defines the frozen interpolation and Brownian diffusion
  coefficient.  It does not state selected-test Laplacian measurability.
- `appendix.tex:1379-1387` invokes the Fokker--Planck diffusion line with
  `Delta hat rho_s`.  It motivates the Laplacian field use site, but it does not
  by itself supply `hSelectedTestLaplacianMeasurable`.
- `appendix.tex:603-608` states smoothness for the guided density path and guide
  in the VA-SALD analysis background.  This is not yet a verbatim selected-test
  Laplacian regularity assumption for the weak-FP test representative.

Next lower packet should prove the remaining boundary only if it finds an
original-source selected-test regularity assumption strong enough to imply:

```lean
testRegular -> forall phi, Continuous (Laplacian.laplacian (selectedTest phi))
```

or directly:

```lean
testRegular -> forall phi, Measurable (Laplacian.laplacian (selectedTest phi))
```

Typed verifier feedback if the source search remains negative:

```text
leaf=hSelectedTestLaplacianMeasurable
error_class=source_contract_gap_missing_selected_test_laplacian_measurability
needed_shape=testRegular -> forall phi, Measurable (Laplacian.laplacian (selectedTest phi))
source_lines=appendix.tex:983-996;appendix.tex:1379-1387
blocked_by=no original-source selected-test Laplacian measurability or continuity assumption found for the weak-FP test representative
```

External provenance: no external SLT theorem was imported, called, queued, or
marked formalized for this packet.  The relevant technical ingredient is Mathlib
`Measurable.aestronglyMeasurable`, already consumed by the compiled ASTIS local
theorem above.
