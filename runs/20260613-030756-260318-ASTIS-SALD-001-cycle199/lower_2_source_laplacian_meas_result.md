# lower_2 Result: Source-Laplacian Measurable Bridge

Classification: `narrows-source-cited-boundary`.

Compiled theorem:

```lean
SALD.generalMovingTargetDiscreteSourceLaplacianFieldMeasOfSelectedTestLaplacianMeasurable
```

Exact boundary narrowed:

```lean
hsourceLaplacianFieldMeas :
  testRegular ->
    forall phi,
      MeasureTheory.AEStronglyMeasurable
        (Laplacian.laplacian (selectedTest phi)) hatRhoS
```

is reduced to:

```lean
hSelectedTestLaplacianMeasurable :
  testRegular ->
    forall phi, Measurable (Laplacian.laplacian (selectedTest phi))
```

Proof mechanism:

```lean
intro htests phi
exact (hSelectedTestLaplacianMeasurable htests phi).aestronglyMeasurable
```

Verification:

- `lake env lean AutoSamplingTheory/SALD.lean` passed after the edit.
- Full mandatory gate `python3 tools/astis.py check` passed.

Remaining source boundary:

```text
leaf=hSelectedTestLaplacianMeasurable
needed_shape=testRegular -> forall phi, Measurable (Laplacian.laplacian (selectedTest phi))
source_lines=appendix.tex:983-996;appendix.tex:1379-1387
```

No external SLT theorem was imported, queued, or marked formalized.
