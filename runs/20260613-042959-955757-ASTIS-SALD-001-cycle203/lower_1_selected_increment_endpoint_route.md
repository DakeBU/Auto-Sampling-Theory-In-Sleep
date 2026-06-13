# Cycle 203 Lower_1 Selected-Increment Endpoint Route

Classification: `narrows-source-cited-boundary`.

Packet type: dynamic-leaf proof-scout packet, not an illness-area refiner.

Exact missing theorem boundary:

```lean
hSelectedIncrementEndpointDef :
  testRegular ->
    forall phi x i z,
      sourceSelectedLineIncrement phi x i z =
        selectedTest phi (sourceSelectedEndpoint phi x i z) -
          selectedTest phi x
```

This is the companion source field left after cycle 190 separated
`hSelectedIncrementCoordinateLineDef` into endpoint naming plus the endpoint
coordinate-line identity.  It is not a replay of cycle 202
`hSelectedEndpointCoordinateLineDef`.

## Source Route

Source anchors:

- `appendix.tex:958-970`: the Euler--Maruyama step has a Gaussian increment.
- `appendix.tex:983-996`: the frozen interpolation separates frozen drift
  from the Brownian endpoint.
- `appendix.tex:1161-1170`: the increment is rewritten as a scaled standard
  Gaussian vector.
- `appendix.tex:1379-1387`: the weak-Fokker--Planck consumer keeps the
  `sigma_eta^2 / 2` diffusion prefactor outside this scalar endpoint field.

Classically, after choosing coordinate `i` and scalar normalized coordinate
`z`, the frozen Brownian endpoint is the point recorded by
`sourceSelectedEndpoint phi x i z`.  The selected weak-test increment along
that endpoint is therefore only the endpoint difference
`selectedTest phi (sourceSelectedEndpoint phi x i z) - selectedTest phi x`.
No Taylor theorem, Hessian regularity, Gaussian DCT, or Fokker--Planck
integration-by-parts fact is involved in this equality.

The endpoint coordinate-line field remains separate:

```lean
hSelectedEndpointCoordinateLineDef :
  testRegular ->
    forall phi x i z,
      sourceSelectedEndpoint phi x i z =
        x + z • (stdOrthonormalBasis Real E i)
```

Cycle 202 already recorded that field as a source-contract gap.  The present
packet only asks whether the paper-specific name `sourceSelectedLineIncrement`
has been defined as the selected-test endpoint difference.

## Lean Route

Local compiled consumers already available:

```lean
SALD.selectedWeakTestSelectedIncrementCoordinateLineDefOfEndpointAndLineDef
SALD.selectedWeakTestSourceTaylorIntegrandRawDefOfSelectedIncrementEndpointAndLineDef
```

These bridges show why `hSelectedIncrementEndpointDef` is a strictly smaller
boundary than the older `hSourceTaylorIntegrandRawDef`.  They do not prove the
endpoint-increment definition themselves.

Search result for lower_2 to confirm: in the current local Lean files,
`sourceSelectedLineIncrement` and `sourceSelectedEndpoint` appear as abstract
parameters in the cycle-190 bridges, not as a `def` or `abbrev` that unfolds.
If lower_2 finds a genuine reducible local definition that the current search
missed, the expected proof is definitional:

```lean
intro htests phi x i z
unfold <actual sourceSelectedLineIncrement definition>
rfl
```

or the equivalent `simp [<actual definition>]`.  Function extensionality is
only appropriate if the available declaration is a function-level definitional
equality to the endpoint-difference field.

Do not implement a theorem that merely assumes this same equality and returns
it.  That would be wrapper churn and would not reduce the Brownian/Ito frozen
backend.

## Lower_2-Ready Handoff

Implement exactly one outcome:

1. If `sourceSelectedLineIncrement` has a source-backed reducible definition,
   compile one local ASTIS theorem proving `hSelectedIncrementEndpointDef` by
   unfolding that definition.

2. If no reducible definition exists, record the strictly smaller typed
   source-cited obligation:

```text
leaf=hSelectedIncrementEndpointDef
error_class=source_contract_gap_missing_selected_increment_endpoint_definition
needed_shape=testRegular -> forall phi x i z,
  sourceSelectedLineIncrement phi x i z =
    selectedTest phi (sourceSelectedEndpoint phi x i z) - selectedTest phi x
source_lines=appendix.tex:958-970;appendix.tex:983-996;appendix.tex:1161-1170;appendix.tex:1379-1387
blocked_by=sourceSelectedLineIncrement is an abstract source-facing parameter in the compiled cycle-190 bridges unless lower_2 finds a reducible local definition
```

No external SLT theorem is imported, called, queued, or marked formalized.
`hSourceHasHessian` and `hSourceHessianBound` remain frozen source-contract
gaps and are not used here.
