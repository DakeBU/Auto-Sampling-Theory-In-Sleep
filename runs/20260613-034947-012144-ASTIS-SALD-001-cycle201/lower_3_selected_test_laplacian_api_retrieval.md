# Cycle 201 lower_3 API Retrieval: Selected-Test Laplacian Regularity

Classification: `narrows-source-cited-boundary`.

Packet type: dynamic-leaf worker packet for the active
`sald.general_moving_target_discrete.em_interpolation_fp` backend.

## Exact Boundary

The missing theorem boundary is not a new technical-lemma/API fact.  The local
API already narrows

```lean
hsourceLaplacianFieldMeas :
  testRegular ->
    forall phi,
      MeasureTheory.AEStronglyMeasurable
        (Laplacian.laplacian (selectedTest phi)) hatRhoS
```

to the smaller source-facing field

```lean
hSelectedTestLaplacianContinuous :
  testRegular ->
    forall phi, Continuous (Laplacian.laplacian (selectedTest phi))
```

through the compiled cycle-199 bridge chain:

- `SALD.generalMovingTargetDiscreteSourceLaplacianFieldMeasOfSelectedTestLaplacianMeasurable`
- `SALD.generalMovingTargetDiscreteSelectedTestLaplacianMeasurableOfContinuous`

Therefore lower_3 should not add a duplicate wrapper theorem around
`Continuous.measurable` or `Measurable.aestronglyMeasurable`.  The remaining
work is a source-backed proof or typed source-contract gap for
`hSelectedTestLaplacianContinuous`.

## Local Callable Facts

- `AutoSamplingTheory/SALD.lean:11431`:
  `SALD.generalMovingTargetDiscreteSourceLaplacianFieldMeasOfSelectedTestLaplacianMeasurable`,
  using Mathlib `Measurable.aestronglyMeasurable`.
- `AutoSamplingTheory/SALD.lean:11453`:
  `SALD.generalMovingTargetDiscreteSelectedTestLaplacianMeasurableOfContinuous`,
  using Mathlib `Continuous.measurable`.
- `AutoSamplingTheory/SALD.lean:69942`:
  `cycle199EmInterpolationWeakFpSourceLaplacianFieldMeasDependencyNames`, which
  records the dependency names for this exact bridge.

No external SLT declaration is needed or queued.  No runtime dependency on the
external SLT clone is used.

## Source Check

Source files searched under `/home/nitanda_sub/mark/repos/sald/paper`, excluding
`sald_version_2.tex`, with tokens around `laplacian`, `Delta`, `measurable`,
`continuous`, `smooth`, `C^2`, `test`, `varphi`, and `selected`.

Relevant source anchors:

- `appendix.tex:724-727`: continuous general theorem assumptions state LSI and
  finite alpha-complexity, not selected-test Laplacian continuity.
- `appendix.tex:983-996`: frozen EM interpolation defines the backend state
  process whose weak action later needs the Laplacian field.
- `appendix.tex:1028-1070`: frozen-delta assumptions state drift/score
  Lipschitz, time regularity, integrability, and step-size conditions, not
  selected-test Laplacian continuity.
- `appendix.tex:1313-1316`: the discrete theorem inherits the continuous theorem
  and frozen-delta assumptions.
- `appendix.tex:1379-1387`: the weak Fokker--Planck display contains
  `Delta hat rho_s`, but does not state regularity of the selected test
  Laplacian.

No original-paper line in the checked source window states the needed field:

```text
testRegular -> forall phi, Continuous (Laplacian.laplacian (selectedTest phi))
```

## Handoff Boundary

Use the existing compiled local bridge if a genuine source-backed
`hSelectedTestLaplacianContinuous` field is later supplied.  Otherwise record
typed verifier feedback:

```text
leaf=hSelectedTestLaplacianContinuous
error_class=source_contract_gap_missing_selected_test_laplacian_continuity
needed_shape=testRegular -> forall phi, Continuous (Laplacian.laplacian (selectedTest phi))
source_lines=appendix.tex:724-727;appendix.tex:1028-1070;appendix.tex:1313-1316;appendix.tex:983-996;appendix.tex:1379-1387
blocked_by=no original-paper line found that states selected-test Laplacian continuity/measurability
```
