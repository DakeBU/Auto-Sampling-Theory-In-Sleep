# Cycle 204 Middle Packet: Source Taylor Integrand Selected-Increment Naming

Classification: `narrows-source-cited-boundary`.

Packet type: dynamic-leaf worker packet.

Exact missing theorem boundary narrowed:

```lean
hSourceTaylorIntegrandSelectedIncrementDef :
  testRegular ->
    forall phi x i z,
      sourceTaylorIntegrand phi x i z =
        sourceSelectedLineIncrement phi x i z
```

Target theorem region: `sald.general_moving_target_discrete.em_interpolation_fp`
over `appendix.tex:1358-1387`, with the active Brownian/Ito frozen
interpolation source block at `appendix.tex:983-996`.

## Source Correspondence

- `appendix.tex:958-970` defines the EM increment and the Gaussian noise term.
- `appendix.tex:983-996` defines the frozen interpolation `hat X_s`.
- `appendix.tex:1161-1170` is the normalized Brownian-coordinate rewrite used
  by the current scalar Brownian/Ito backend.
- `appendix.tex:1379-1387` consumes this backend in the weak Fokker--Planck
  line.  The weak-FP diffusion coefficient `sigma_eta^2 / 2` stays outside
  this scalar naming equality.

Cycle 189 already compiled the consumer bridge
`SALD.selectedWeakTestSourceTaylorIntegrandRawDefOfSelectedIncrementAndLineDef`,
which reduces `hSourceTaylorIntegrandRawDef` to
`hSourceTaylorIntegrandSelectedIncrementDef` plus
`hSelectedIncrementCoordinateLineDef`.  Cycle 190 removed the latter primitive
coordinate-line field from the raw-integrand path by using endpoint fields.
Cycles 202 and 203 recorded those endpoint fields as source-contract gaps.
This cycle therefore asks lower work to inspect only the remaining naming
field that identifies the paper's `sourceTaylorIntegrand` with the selected
weak-test increment.

## Lower Split

`lower_1`: write the natural-language route for exactly
`hSourceTaylorIntegrandSelectedIncrementDef`.  The route should determine
whether the original paper/source layer defines the Taylor integrand as the
selected weak-test increment for the normalized frozen Brownian coordinate.
Do not replay `hSelectedEndpointCoordinateLineDef`,
`hSelectedIncrementEndpointDef`, normalized-remainder domination, source
Hessian regularity, VP score-Hessian substitution, or wrapper projections.

`lower_2`: inspect whether `sourceTaylorIntegrand` and
`sourceSelectedLineIncrement` unfold locally.  If they do, compile one
ASTIS-owned theorem for the equality above.  If they remain abstract
source-facing parameters, record one strictly smaller source-cited obligation
with typed verifier feedback:

```text
leaf=hSourceTaylorIntegrandSelectedIncrementDef
error_class=source_contract_gap_missing_source_taylor_integrand_selected_increment_definition
needed_shape=testRegular -> forall phi x i z,
  sourceTaylorIntegrand phi x i z =
    sourceSelectedLineIncrement phi x i z
blocked_by=sourceTaylorIntegrand and sourceSelectedLineIncrement are abstract parameters in the compiled selected-increment/raw-integrand bridges unless lower_2 finds a reducible local definition
```

`lower_3`: no active technical-lemma task unless lower_2 finds a missing local
API.  The current packet needs only existing ASTIS-owned SALD bridges and
Mathlib notation already used by those bridges.

## Callable Local Ingredients

```lean
SALD.selectedWeakTestSourceTaylorIntegrandRawDefOfSelectedIncrementAndLineDef
SALD.selectedWeakTestSourceTaylorIntegrandRawDefOfSelectedIncrementEndpointAndLineDef
SALD.selectedWeakTestSelectedIncrementCoordinateLineDefOfEndpointAndLineDef
SALD.cycle189GeneralMovingTargetDiscreteEmGeneratorLaplacianEventFieldFrozenScalarBrownianItoSourceTaylorIntegrandRawLower2Obligation
SALD.cycle190GeneralMovingTargetDiscreteEmGeneratorLaplacianEventFieldFrozenScalarBrownianItoSelectedIncrementCoordinateLineMiddleObligation
SALD.cycle202GeneralMovingTargetDiscreteEmGeneratorLaplacianEventFieldFrozenScalarBrownianItoSelectedEndpointCoordinateLineLower2Obligation
SALD.cycle203GeneralMovingTargetDiscreteEmGeneratorLaplacianEventFieldFrozenScalarBrownianItoSelectedIncrementEndpointLower2Obligation
```

No external SLT theorem is imported, called, queued, or marked formalized.
The local Gaussian/SALDExtracted technical lemmas remain background for the
Brownian/Ito backend but are not needed to close this naming equality.

## Reviewer Checklist

Accept only if the packet stays on `hSourceTaylorIntegrandSelectedIncrementDef`,
keeps concrete source anchors, records typed verifier feedback if the equality
is not reducible, avoids endpoint replay and source-Hessian wrapper churn, uses
only ASTIS-owned compiled declarations, and passes:

```bash
python3 tools/astis.py check
```
