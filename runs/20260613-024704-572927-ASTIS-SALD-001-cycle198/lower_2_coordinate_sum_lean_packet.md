# Lower 2 Packet: Coordinate-Sum Lean Target

Classification: `narrows-source-cited-boundary`.

Packet type: dynamic-leaf Lean implementation packet.

Implement exactly one compiled theorem only if there is an existing Lean/source
definition that unfolds the event field to the finite coordinate sum.  The
target is not a new wrapper assumption; it is the source-backed definition
behind:

```lean
hFrozenScalarBrownianItoEventFieldCoordinateSum :
  testRegular ->
    forall phi x,
      emGeneratorLaplacianEventField phi x =
        Finset.univ.sum
          (fun i : Fin (Module.finrank Real E) =>
            brownianCoordinateGenerator phi x i)
```

Existing consumers that should not be duplicated:

- `SALD.generalMovingTargetDiscreteEmGeneratorLaplacianEventFieldFrozenScalarBrownianItoPointwiseDefOfCoordinateGenerator`;
- `SALD.generalMovingTargetDiscreteEmGeneratorLaplacianEventFieldFrozenScalarBrownianItoCoordinateGeneratorDefOfOneDimTaylor`;
- `SALD.selectedWeakTestFrozenScalarBrownianItoTaylorMomentDecompositionOfScalarPushforwardRawTaylorAndDominatedRemainder`.

If the only available proof is to assume the same equality under a renamed
hypothesis, do not add the theorem.  Record typed verifier feedback instead:

```text
leaf=hFrozenScalarBrownianItoEventFieldCoordinateSum
error_class=source_contract_gap_missing_event_field_coordinate_sum_definition
needed_shape=emGeneratorLaplacianEventField phi x = Finset.univ.sum (fun i : Fin (Module.finrank Real E) => brownianCoordinateGenerator phi x i)
source_lines=appendix.tex:983-996; appendix.tex:1379-1387
blocked_by=no original-paper/Lean definition connecting emGeneratorLaplacianEventField to the finite sum of brownianCoordinateGenerator
```

Mandatory reviewer condition: `python3 tools/astis.py check` must pass before
any acceptance claim.
