# Lower 3 Packet: Coordinate-Sum Retrieval

Classification: `narrows-source-cited-boundary`.

Packet type: dynamic-leaf technical-lemma/API scout packet, not an illness-area
refiner.

Exact missing theorem boundary narrowed:

```lean
hFrozenScalarBrownianItoEventFieldCoordinateSum :
  testRegular ->
    forall phi x,
      emGeneratorLaplacianEventField phi x =
        Finset.univ.sum
          (fun i : Fin (Module.finrank Real E) =>
            brownianCoordinateGenerator phi x i)
```

Use site: `sald.general_moving_target_discrete.em_interpolation_fp`, with
paper-memory row `frozen-em-interpolation` and source anchors
`appendix.tex:983-996` and `appendix.tex:1379-1387`.  The source lines give the
frozen Brownian increment and the weak-FP diffusion prefactor
`sigma_eta^2/2`; the prefactor stays outside the Brownian event field.

## Retrieval Result

Callable local declarations:

- `SALD.emFrozenScalarBrownianItoGeneratorEventField`
  (`AutoSamplingTheory/SALD.lean:13872`) is the named finite standard-basis
  Brownian/Ito generator
  `fun phi x => sum_i iteratedFDeriv Real 2 (selectedTest phi) x ![e_i,e_i]`.
- `SALD.generalMovingTargetDiscreteEmGeneratorLaplacianEventFieldFrozenScalarBrownianItoPointwiseDefOfCoordinateGenerator`
  (`AutoSamplingTheory/SALD.lean:13955`) consumes
  `hFrozenScalarBrownianItoEventFieldCoordinateSum` plus the per-coordinate
  generator identity and then proves the pointwise equality with
  `SALD.emFrozenScalarBrownianItoGeneratorEventField`.
- `SALD.generalMovingTargetDiscreteEmGeneratorLaplacianEventFieldFrozenScalarBrownianItoCoordinateGeneratorDefOfOneDimTaylor`
  (`AutoSamplingTheory/SALD.lean:17839`) reduces the per-coordinate generator
  identity to a one-dimensional Taylor generator identity.  It does not prove
  the field-level coordinate sum.
- `SALD.selectedWeakTestFrozenScalarBrownianItoTaylorMomentDecompositionOfScalarPushforwardRawTaylorAndDominatedRemainder`
  (`AutoSamplingTheory/SALD.lean:16061`) discharges the stale
  Taylor/remainder primitive targets inside the scalar coordinate generator
  backend.  It does not identify `emGeneratorLaplacianEventField` with a finite
  coordinate sum.
- `AutoSamplingTheory.TechnicalLemmas.SALDExtracted.selectedWeakTestNormalizedCoordinateLawOfStdGaussianVectorLaw`
  (`AutoSamplingTheory/TechnicalLemmas/SALDExtracted.lean`, registry key
  `sald.brownian-normalization-bridges`) supplies the normalized scalar
  coordinate law from the vector Gaussian law.  It supports scalar-coordinate
  Brownian leaves, not the event-field finite-sum definition.
- `AutoSamplingTheory.TechnicalLemmas.Gaussian.map_eval_stdGaussianPi`
  (`AutoSamplingTheory/TechnicalLemmas/Gaussian.lean`, registry key
  `gaussian.product.coordinate-law`) is an ASTIS-owned product-Gaussian
  coordinate projection theorem.
- `AutoSamplingTheory.TechnicalLemmas.Taylor.stdOrthonormalBasisUnit`
  (`AutoSamplingTheory/TechnicalLemmas/Taylor.lean`) supplies the standard
  orthonormal-basis unit side condition for coordinate Taylor bounds.

Negative API result:

- No existing local declaration found with conclusion
  `emGeneratorLaplacianEventField phi x = sum_i brownianCoordinateGenerator phi x i`.
- In the compiled bridge at `AutoSamplingTheory/SALD.lean:13955`,
  `emGeneratorLaplacianEventField` and `brownianCoordinateGenerator` are
  parameters, and the finite coordinate-sum equality is an explicit hypothesis,
  not a reducible definition.
- The existing paper-memory/proof-obligation record still marks
  `hFrozenScalarBrownianItoEventFieldCoordinateSum` as the active unfinished
  leaf, so lower_2 should not add a wrapper theorem that merely re-assumes the
  same equality.

Lower_2 typed-feedback packet if no definitional proof is found:

```text
leaf=hFrozenScalarBrownianItoEventFieldCoordinateSum
error_class=source_contract_gap_missing_event_field_coordinate_sum_definition
needed_shape=emGeneratorLaplacianEventField phi x = Finset.univ.sum (fun i : Fin (Module.finrank Real E) => brownianCoordinateGenerator phi x i)
source_lines=appendix.tex:983-996; appendix.tex:1379-1387
blocked_by=no local Lean/source definition connecting the abstract emGeneratorLaplacianEventField parameter to the finite sum of brownianCoordinateGenerator
```

External provenance: no external SLT theorem was imported, called, queued, or
marked formalized for this packet.  The useful facts are already ASTIS-owned
compiled declarations.
