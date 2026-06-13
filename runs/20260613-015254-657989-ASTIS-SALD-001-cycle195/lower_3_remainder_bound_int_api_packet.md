# Cycle 195 Lower_3 Technical-Lemma Packet

Classification: `narrows-source-cited-boundary`.

Packet type: dynamic-leaf worker support packet for the Brownian/Ito frozen
backend.

Exact missing theorem boundary narrowed:

```lean
hRemainderBoundInt :
  testRegular ->
    forall phi x i,
      MeasureTheory.Integrable
        (fun z : Real => remainderBound phi x i z)
        (ProbabilityTheory.gaussianReal (0 : Real) (variance phi x i))
```

The lower_3 API search found that the only missing background fact for the
cycle-195 target is equality transport for `MeasureTheory.Integrable`.
This is now an ASTIS-owned compiled local declaration:

```lean
AutoSamplingTheory.TechnicalLemmas.Measure.integrable_of_measure_eq
```

The theorem is in `AutoSamplingTheory/TechnicalLemmas/Measure.lean`:

```lean
theorem integrable_of_measure_eq
    {alpha eps : Type*} [MeasurableSpace alpha] [TopologicalSpace eps]
    [ContinuousENorm eps]
    {f : alpha -> eps} {mu nu : MeasureTheory.Measure alpha} (hmunu : mu = nu)
    (hf : MeasureTheory.Integrable f mu) :
    MeasureTheory.Integrable f nu
```

Use site for lower_2:

1. Derive
   `hNormalizedCoordinateLaw :
      normalizedCoordinateLaw phi x i =
        ProbabilityTheory.gaussianReal (0 : Real) (1 : NNReal)`
   with
   `SALD.selectedWeakTestNormalizedCoordinateLawOfStdGaussianVectorLaw`.
2. Derive `hVarianceOne : variance phi x i = (1 : NNReal)` with
   `SALD.selectedWeakTestNormalizedVarianceDefOfGaussianRealUnitLaw`.
3. Transport
   `hNormalizedRemainderBoundInt htests phi x i` across the composed measure
   equality using `TechnicalLemmas.Measure.integrable_of_measure_eq`, or finish
   directly by the same `simpa [hNormalizedCoordinateLaw, hVarianceOne]`.

This packet does not import, call, queue, or mark any external SLT result.
No source-Hessian field, VP score-Hessian substitution, `testRegular` wrapper,
or broad route audit is involved.

Source anchors: `appendix.tex:958-970`, `appendix.tex:983-996`,
`appendix.tex:1161-1170`, and `appendix.tex:1379-1387`.

