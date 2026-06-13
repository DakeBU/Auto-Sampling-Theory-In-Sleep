# Cycle 201 Middle Packet: Selected-Test Laplacian Regularity

Classification: `narrows-source-cited-boundary`.

Packet type: dynamic-leaf worker packet for
`sald.general_moving_target_discrete.em_interpolation_fp`.

## Exact Boundary

Do not replay `hNormalizedRemainderBoundDef`, `hsourceLaplacianFieldMeas`, or a
same-shape `testRegular` wrapper.  Cycle 199 already compiled:

```lean
SALD.generalMovingTargetDiscreteSourceLaplacianFieldMeasOfSelectedTestLaplacianMeasurable
```

which reduces:

```lean
hsourceLaplacianFieldMeas :
  testRegular ->
    forall phi,
      MeasureTheory.AEStronglyMeasurable
        (Laplacian.laplacian (selectedTest phi)) hatRhoS
```

to:

```lean
hSelectedTestLaplacianMeasurable :
  testRegular ->
    forall phi, Measurable (Laplacian.laplacian (selectedTest phi))
```

Cycle 199 also compiled:

```lean
SALD.generalMovingTargetDiscreteSelectedTestLaplacianMeasurableOfContinuous
```

which further reduces the measurable leaf to the smaller source-facing
regularity field:

```lean
hSelectedTestLaplacianContinuous :
  testRegular ->
    forall phi, Continuous (Laplacian.laplacian (selectedTest phi))
```

The cycle-201 lower ticket is therefore only this final source check:
prove `hSelectedTestLaplacianContinuous` from an explicit original SALD
selected-test regularity statement, or record the source-contract gap.

## Source Window

- `appendix.tex:983-996`: frozen EM interpolation; this is the Brownian
  backend whose weak action later needs the selected-test Laplacian.
- `appendix.tex:1379-1387`: weak Fokker--Planck line with
  `Delta hat rho_s`.
- `appendix.tex:1313-1316`: the discrete theorem inherits the continuous
  theorem and frozen-delta assumptions.
- `appendix.tex:724-727`: continuous general theorem assumptions; these state
  LSI and finite alpha-complexity, not selected-test Laplacian continuity.
- `appendix.tex:1028-1070`: frozen-delta assumptions; these state drift/score
  Lipschitz, time regularity, integrability, and step-size conditions, not
  selected-test Laplacian continuity.

Source search excluding `sald_version_2.tex` found no verbatim original-paper
line stating selected-test Laplacian measurability or continuity.  That absence
must remain visible unless lower finds a more specific original-source anchor.

## Lower Split

`lower_1`: write the natural-language route for exactly this leaf.  The route
should say that if the original paper supplies
`hSelectedTestLaplacianContinuous`, the Lean step is just
`(hSelectedTestLaplacianContinuous htests phi).measurable`, then the cycle-199
compiled bridge supplies the law-level AE-strong measurability.  If the source
does not supply that continuity/measurability, lower_1 should name the source
gap, not re-audit Hessian fields or normalized remainders.

`lower_2`: implement no duplicate wrapper.  Either use an existing
source-backed `hSelectedTestLaplacianContinuous` field with
`SALD.generalMovingTargetDiscreteSelectedTestLaplacianMeasurableOfContinuous`,
or record typed verifier feedback:

```text
leaf=hSelectedTestLaplacianContinuous
error_class=source_contract_gap_missing_selected_test_laplacian_continuity
needed_shape=testRegular -> forall phi, Continuous (Laplacian.laplacian (selectedTest phi))
source_lines=appendix.tex:724-727;appendix.tex:1028-1070;appendix.tex:1313-1316;appendix.tex:983-996;appendix.tex:1379-1387
blocked_by=no original-paper line found that states selected-test Laplacian continuity/measurability
```

`lower_3`: optional API scout only.  Local facts are
`SALD.generalMovingTargetDiscreteSourceLaplacianFieldMeasOfSelectedTestLaplacianMeasurable`,
`SALD.generalMovingTargetDiscreteSelectedTestLaplacianMeasurableOfContinuous`,
Mathlib `Continuous.measurable`, and Mathlib
`Measurable.aestronglyMeasurable`.  No SLT theorem is callable, queued, or
needed.

## Reviewer Check

Require `python3 tools/astis.py check`.  Accept only if the result keeps the
active backend at `appendix.tex:1358-1387`, names the concrete source lines
above, and does not promote selected-test Laplacian continuity to formalized
status without a compiled local declaration and a source-backed hypothesis.
