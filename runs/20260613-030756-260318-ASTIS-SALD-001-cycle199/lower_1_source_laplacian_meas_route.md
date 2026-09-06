# lower_1 Route: Selected-Test Laplacian Measurability

Classification: `narrows-source-cited-boundary`.

Packet type: dynamic-leaf worker packet.

Target:

```lean
hSelectedTestLaplacianMeasurable :
  testRegular ->
    forall phi, Measurable (Laplacian.laplacian (selectedTest phi))
```

Exact narrowed boundary: cycle 199 compiled
`SALD.generalMovingTargetDiscreteSourceLaplacianFieldMeasOfSelectedTestLaplacianMeasurable`,
which reduces

```lean
hsourceLaplacianFieldMeas :
  testRegular ->
    forall phi,
      MeasureTheory.AEStronglyMeasurable
        (Laplacian.laplacian (selectedTest phi)) hatRhoS
```

to the law-independent selected-test field above.

Classical proof route:

1. Use `appendix.tex:1379-1387` only for the weak-FP role of the term:
   the diffusion part is the Laplacian contribution in the equation for
   `hat rho_s`.
2. Use `appendix.tex:983-996` only to keep the EM frozen interpolation and
   Brownian term attached to the same backend.  The coefficient
   `sigma_eta^2/2` stays outside this measurability statement.
3. Search the original SALD test-class assumptions for a statement implying
   measurability or continuity of `x |-> Laplacian.laplacian (selectedTest phi) x`.
   A sufficient Lean-facing route is:

```lean
hSelectedTestLaplacianContinuous :
  testRegular ->
    forall phi, Continuous (Laplacian.laplacian (selectedTest phi))
```

then lower_2 can derive `hSelectedTestLaplacianMeasurable` by
`(hSelectedTestLaplacianContinuous htests phi).measurable`.

Source audit for this packet:

- `appendix.tex:983-996` defines the frozen interpolation
  `hat X_s = X_k^eta + ... + sigma_eta (W_s - W_{s_k})`; it explains why the
  Brownian part feeds the diffusion/Laplacian backend, but it does not state
  selected-test Laplacian regularity.
- `appendix.tex:1379-1387` invokes the Fokker--Planck equation
  `partial_s hat rho_s = - div(hat rho_s bar b_{k,s}) + sigma_eta^2 / 2
  Delta hat rho_s`; it identifies the source Laplacian term, but again does
  not state measurability of `Laplacian.laplacian (selectedTest phi)`.
- `appendix.tex:1313-1316` says the discrete theorem assumes Theorem
  `general-moving-target-SALD` and Lemma `frozen_delta_cross_lip`.
  The theorem gives LSI and exponential-energy assumptions for `m_t`; the
  lemma gives Lipschitz/time-regularity assumptions for `c_t` and
  `nabla log pi_t`, plus measurability of an auxiliary `M`.  These source
  assumptions do not by themselves supply selected-test Laplacian
  measurability.

Lower_2-ready theorem shape if a paper-backed continuity premise is accepted:

```lean
theorem generalMovingTargetDiscreteSelectedTestLaplacianMeasurableOfContinuous
    {Test E : Type*} [MeasurableSpace E]
    [NormedAddCommGroup E] [InnerProductSpace Real E] [FiniteDimensional Real E]
    [BorelSpace E]
    (selectedTest : Test -> E -> Real)
    (testRegular : Prop)
    (hSelectedTestLaplacianContinuous :
      testRegular ->
        forall phi, Continuous (Laplacian.laplacian (selectedTest phi))) :
    testRegular ->
      forall phi, Measurable (Laplacian.laplacian (selectedTest phi)) := by
  intro htests phi
  exact (hSelectedTestLaplacianContinuous htests phi).measurable
```

Expected Mathlib ingredient: `Continuous.measurable`.  No ASTIS Gaussian,
Taylor, SLT, Hessian, or VP score-Hessian lemma is needed for this route.

If the original source has no selected-test Laplacian measurability or
continuity assumption, record:

```text
leaf=hSelectedTestLaplacianMeasurable
error_class=source_contract_gap_missing_selected_test_laplacian_measurability
source_lines=appendix.tex:983-996;appendix.tex:1379-1387
needed_shape=testRegular -> forall phi, Measurable (Laplacian.laplacian (selectedTest phi))
```

Do not use `hSourceHasHessian`, `hSourceHessianBound`, VP score-Hessian
regularity, or a same-shape wrapper around `hsourceLaplacianFieldMeas`.

Reviewer boundary: accepting this packet should leave exactly one remaining
source-cited leaf, `hSelectedTestLaplacianMeasurable`, unless lower_2 finds an
explicit paper-backed continuity/measurability assumption and compiles the
continuity-to-measurability theorem above.
