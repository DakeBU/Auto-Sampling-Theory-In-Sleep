# lower_3 endpoint coordinate-line API packet

Classification: `narrows-source-cited-boundary`.

Packet type: dynamic-leaf worker/API scout.

Exact boundary narrowed: `hSourceTaylorIntegrandRawDef` should be routed
through the already compiled local bridges
`SALD.selectedWeakTestSourceTaylorIntegrandRawDefOfSelectedIncrementEndpointAndLineDef`
and `SALD.selectedWeakTestSelectedIncrementCoordinateLineDefOfEndpointAndLineDef`
to the smaller source-cited endpoint line field:

```lean
hSelectedEndpointCoordinateLineDef :
  testRegular ->
    forall phi x i z,
      sourceSelectedEndpoint phi x i z =
        x + z • (stdOrthonormalBasis Real E i)
```

Use site:
`SALD.selectedWeakTestSourceTaylorIntegrandRawDefOfSelectedIncrementEndpointAndLineDef`
feeds the raw scalar source Taylor integrand required by
`SALD.selectedWeakTestBrownianCoordinateGeneratorTaylorIntegralDefOfScalarPushforwardRawTaylorAndTermDefs`,
which is on the `hBrownianCoordinateGeneratorTaylorIntegralDef` backend.

Source anchors checked:

- `appendix.tex:958-970`: discrete EM update and Gaussian increment.
- `appendix.tex:983-996`: frozen interpolation endpoint.
- `appendix.tex:1161-1170`: frozen increment restated as `sigma_eta sqrt(s-s_k) xi`.
- `appendix.tex:1379-1387`: weak Fokker-Planck line using the same frozen interpolation.

Dependency classification:

- `internal-paper-step` for extracting the normalized scalar coordinate line
  from the frozen interpolation.
- `source-contract-gap` if the Lean model has no defining equation for
  `sourceSelectedEndpoint`.
- Not `mathlib-available`: Mathlib supplies the orthonormal-coordinate and
  Gaussian-law infrastructure, but not the SALD source endpoint naming.
- Not `slt-port-candidate`: no upstream SLT declaration should be imported,
  queued, or marked formalized for this endpoint naming field.

Local compiled ingredients:

- `SALD.selectedWeakTestSelectedIncrementCoordinateLineDefOfEndpointAndLineDef`
- `SALD.selectedWeakTestSourceTaylorIntegrandRawDefOfSelectedIncrementEndpointAndLineDef`
- `SALD.selectedWeakTestBrownianCoordinateGeneratorTaylorIntegralDefOfScalarPushforwardRawTaylorAndTermDefs`
- `AutoSamplingTheory.TechnicalLemmas.SALDExtracted.selectedWeakTestNormalizedCoordinateLawOfStdGaussianVectorLaw`
  via registry key `sald.brownian-normalization-bridges`

No TechnicalLemmas edit is recommended in this packet. Adding a new export or
wrapper would not reduce the source boundary; the current blocker is the
paper-specific endpoint correspondence field above.
