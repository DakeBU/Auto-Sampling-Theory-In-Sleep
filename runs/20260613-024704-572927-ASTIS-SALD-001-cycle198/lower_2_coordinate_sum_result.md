# Lower 2 Result: Coordinate-Sum Boundary

Classification: `narrows-source-cited-boundary`.

Packet type: dynamic-leaf worker packet.

Exact boundary:

```lean
hFrozenScalarBrownianItoEventFieldCoordinateSum :
  testRegular ->
    forall phi x,
      emGeneratorLaplacianEventField phi x =
        Finset.univ.sum
          (fun i : Fin (Module.finrank Real E) =>
            brownianCoordinateGenerator phi x i)
```

Result: recorded a compiled `ProofObligation`, not a same-shape theorem.

Lean object:
`SALD.cycle198GeneralMovingTargetDiscreteEmGeneratorLaplacianEventFieldFrozenScalarBrownianItoCoordinateSumLower2Obligation`

Reason: local Lean inspection shows
`SALD.generalMovingTargetDiscreteEmGeneratorLaplacianEventFieldFrozenScalarBrownianItoPointwiseDefOfCoordinateGenerator`
already assumes `hFrozenScalarBrownianItoEventFieldCoordinateSum`, while
`SALD.emFrozenScalarBrownianItoGeneratorEventField` unfolds only to the
diagonal `iteratedFDeriv` finite sum after coordinate generators have been
identified.  No local definition unfolds the abstract
`emGeneratorLaplacianEventField` to the finite sum of
`brownianCoordinateGenerator`.

Typed feedback:

```text
leaf=hFrozenScalarBrownianItoEventFieldCoordinateSum
error_class=source_contract_gap_missing_event_field_coordinate_sum_definition
needed_shape=emGeneratorLaplacianEventField phi x = Finset.univ.sum (fun i : Fin (Module.finrank Real E) => brownianCoordinateGenerator phi x i)
source_lines=appendix.tex:983-996; appendix.tex:1379-1387
blocked_by=no original-paper/Lean definition connecting emGeneratorLaplacianEventField to the finite sum of brownianCoordinateGenerator
```

Gate:

```bash
python3 tools/astis.py check
```

Status: passed.
