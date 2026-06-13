# lower_1 Packet: Selected-Test Laplacian Continuity Route

Classification: `narrows-source-cited-boundary`.

Packet type: dynamic-leaf worker packet for
`sald.general_moving_target_discrete.em_interpolation_fp`.

Exact missing theorem boundary narrowed:

```lean
hSelectedTestLaplacianMeasurable :
  testRegular ->
    forall phi, Measurable (Laplacian.laplacian (selectedTest phi))
```

is reduced to the smaller source-facing regularity field:

```lean
hSelectedTestLaplacianContinuous :
  testRegular ->
    forall phi, Continuous (Laplacian.laplacian (selectedTest phi))
```

This packet does not replay `hsourceLaplacianFieldMeas`, `testRegular`
wrappers, source-Hessian regularity, or normalized-remainder bounds.

## Source Route

The use site is the weak Fokker--Planck line for the frozen EM interpolation:

- `appendix.tex:983-996` defines the frozen interpolation
  `hat X_s = X_k^eta + ... + sigma_eta (W_s-W_{s_k})`.
- `appendix.tex:1379-1387` invokes the Fokker--Planck equation and the
  Laplacian term `(sigma_eta^2 / 2) Delta hat rho_s`.

The theorem assumptions checked for a possible selected-test regularity source
are:

- `appendix.tex:724-727`: continuous general theorem assumptions, namely LSI
  and finite alpha-complexity.
- `appendix.tex:1028-1070`: frozen-delta assumptions, namely drift/score
  Lipschitz, time regularity, integrability, and step-size hypotheses.
- `appendix.tex:1313-1316`: discrete theorem inherits the continuous theorem
  and Lemma `frozen_delta_cross_lip`.

These lines do not state that the selected weak test has a continuous or
measurable Laplacian.  Therefore the faithful-paper route cannot promote
`hSelectedTestLaplacianContinuous` to an available hypothesis unless a new,
specific original SALD source line is found.

## Mathlib/ASTIS Route

If a source-backed field with the exact shape below is available:

```lean
hSelectedTestLaplacianContinuous :
  testRegular ->
    forall phi, Continuous (Laplacian.laplacian (selectedTest phi))
```

then the Lean proof of ordinary measurability is one Mathlib step:

```lean
intro htests phi
exact (hSelectedTestLaplacianContinuous htests phi).measurable
```

The compiled ASTIS bridge already packages this step:

```lean
SALD.generalMovingTargetDiscreteSelectedTestLaplacianMeasurableOfContinuous
```

with local dependency `Continuous.measurable`.

Then the law-dependent AE-strong measurability premise follows from the
cycle-199 compiled bridge:

```lean
SALD.generalMovingTargetDiscreteSourceLaplacianFieldMeasOfSelectedTestLaplacianMeasurable
```

using `Measurable.aestronglyMeasurable`:

```lean
intro htests phi
exact (hSelectedTestLaplacianMeasurable htests phi).aestronglyMeasurable
```

No external SLT theorem is needed, queued, imported, or callable.

## lower_2-Ready Handoff

Implement exactly one of these two outcomes:

1. If a genuine original-paper selected-test Laplacian continuity assumption is
   located, instantiate
   `SALD.generalMovingTargetDiscreteSelectedTestLaplacianMeasurableOfContinuous`
   with that field and feed the result to
   `SALD.generalMovingTargetDiscreteSourceLaplacianFieldMeasOfSelectedTestLaplacianMeasurable`.
   The implementation should discharge `hSelectedTestLaplacianMeasurable`, not
   create another wrapper around `hsourceLaplacianFieldMeas`.

2. If no such source line exists, record typed verifier feedback:

```text
leaf=hSelectedTestLaplacianContinuous
error_class=source_contract_gap_missing_selected_test_laplacian_continuity
needed_shape=testRegular -> forall phi, Continuous (Laplacian.laplacian (selectedTest phi))
source_lines=appendix.tex:724-727;appendix.tex:1028-1070;appendix.tex:1313-1316;appendix.tex:983-996;appendix.tex:1379-1387
blocked_by=no original-paper line found that states selected-test Laplacian continuity/measurability
```

Reviewer should reject any packet that derives this from the frozen
source-Hessian gap, VP score-Hessian regularity, `testRegular` repackaging, or
the already rejected normalized-remainder-bound route.
