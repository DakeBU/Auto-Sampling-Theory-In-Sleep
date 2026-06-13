# Lower 1 Packet: Coordinate-Sum Route

Classification: `narrows-source-cited-boundary`.

Exact missing theorem boundary: `hFrozenScalarBrownianItoEventFieldCoordinateSum`.

Packet type: dynamic-leaf proof-scout packet, not an illness-area refiner.

Target boundary:

```lean
hFrozenScalarBrownianItoEventFieldCoordinateSum :
  testRegular ->
    forall phi x,
      emGeneratorLaplacianEventField phi x =
        Finset.univ.sum
          (fun i : Fin (Module.finrank Real E) =>
            brownianCoordinateGenerator phi x i)
```

Source anchors and paper-memory row:

- Paper-memory row: `frozen-em-interpolation`.
- Source lines: `appendix.tex:983-996` and `appendix.tex:1379-1387`.
- Technical-lemma registry entries consulted: `sald.brownian-normalization-bridges`
  for the normalized coordinate-law bridge; no external SLT theorem is callable
  or queued for this packet.

Classical source route:

1. Read `appendix.tex:983-996`: the frozen interpolation has one additive
   Brownian vector increment `sigma_eta (W_s-W_{s_k})` plus frozen drift.  For
   a fixed standard orthonormal-basis coordinate `i`, the normalized scalar
   coordinate is the centered Brownian increment in direction `e_i`.
2. Separate drift and diffusion.  The frozen drift contributes to the
   conditional drift field `bar b_{k,s}` from `appendix.tex:1368-1377`, not to
   the Brownian Laplacian event field.
3. Use the finite-dimensional isotropic Brownian covariance decomposition:
   after the scalar prefactor is factored out, the Brownian second-order
   generator is the finite sum of its one-coordinate generator contributions.
   In Lean notation this is the sum over
   `Fin (Module.finrank Real E)`.
4. Read `appendix.tex:1379-1387`: the weak-FP diffusion term carries the scalar
   prefactor `sigma_eta^2/2`.  Therefore the event field itself is the
   unscaled coordinate sum; do not move `sigma_eta^2/2` into
   `brownianCoordinateGenerator` or into the coordinate-sum equality.
5. The sibling per-coordinate identity is already consumed through
   `SALD.generalMovingTargetDiscreteEmGeneratorLaplacianEventFieldFrozenScalarBrownianItoCoordinateGeneratorDefOfOneDimTaylor`.
   This route only proves or narrows the field-level coordinate-sum definition.

Lean status from this scout:

- `SALD.emFrozenScalarBrownianItoGeneratorEventField` is defined as the finite
  sum of diagonal second derivatives, not as a sum of
  `brownianCoordinateGenerator`.
- `SALD.generalMovingTargetDiscreteEmGeneratorLaplacianEventFieldFrozenScalarBrownianItoPointwiseDefOfCoordinateGenerator`
  consumes `hFrozenScalarBrownianItoEventFieldCoordinateSum` and the
  per-coordinate theorem to derive the named pointwise scalar Brownian/Ito
  event-field equality.  It does not discharge the coordinate-sum boundary.
- A local text search found `emGeneratorLaplacianEventField` only as an
  abstract parameter or supplied equality in the relevant SALD theorem block,
  not as a local `def`/`abbrev` unfolding to the coordinate sum.

Lower_2-ready theorem/proof block:

1. First search for a genuine existing Lean/source definition of
   `emGeneratorLaplacianEventField` or of the frozen Brownian event field as
   the finite coordinate sum:

   ```lean
   forall phi x,
     emGeneratorLaplacianEventField phi x =
       Finset.univ.sum
         (fun i : Fin (Module.finrank Real E) =>
           brownianCoordinateGenerator phi x i)
   ```

2. If such a definition exists, implement exactly one theorem by unfolding that
   definition directly, with no new same-shape supplied hypothesis.  The
   expected proof is:

   ```lean
   intro htests phi x
   unfold <actual_source_coordinate_sum_definition>
   rfl
   ```

   Function extensionality is acceptable only when the available declaration is
   a function-level definitional equality to a named coordinate-sum field.  A
   renamed `hFrozenScalarBrownianItoEventFieldCoordinateSum` premise is wrapper
   churn.

3. If no such definition exists, lower_2 should not add a wrapper.  Record the
   typed feedback below as the strictly smaller source-cited obligation.

If no such definition exists, the honest smaller boundary is:

```text
leaf=hFrozenScalarBrownianItoEventFieldCoordinateSum
error_class=source_contract_gap_missing_event_field_coordinate_sum_definition
needed_shape=emGeneratorLaplacianEventField phi x = Finset.univ.sum (fun i : Fin (Module.finrank Real E) => brownianCoordinateGenerator phi x i)
source_lines=appendix.tex:983-996; appendix.tex:1379-1387
blocked_by=no original-paper/Lean definition connecting emGeneratorLaplacianEventField to the finite sum of brownianCoordinateGenerator
```
