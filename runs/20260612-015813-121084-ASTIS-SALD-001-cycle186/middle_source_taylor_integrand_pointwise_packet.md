# Cycle 186 Middle Packet: Source Taylor Integrand Pointwise Split

Classification: `narrows-source-cited-boundary`.

Packet type: dynamic-leaf worker packet.

Exact boundary narrowed:

```lean
hSourceTaylorIntegrandPointwise :
  testRegular ->
    forall phi x i z,
      sourceTaylorIntegrand phi x i z =
        linearCoeff phi x i * z + quadraticCoeff phi x i * z ^ 2 +
          normalizedRemainder phi x i z
```

Compiled declaration:

```lean
SALD.selectedWeakTestSourceTaylorIntegrandPointwiseOfLineTermDefs
```

The theorem reduces the pointwise integrand identity to three smaller
source-facing fields:

```lean
hSourceTaylorIntegrandDef :
  sourceTaylorIntegrand phi x i z =
    sourceLinearTerm phi x i z + sourceQuadraticTerm phi x i z +
      normalizedRemainder phi x i z

hSourceLinearTermDef :
  sourceLinearTerm phi x i z = linearCoeff phi x i * z

hSourceQuadraticTermDef :
  sourceQuadraticTerm phi x i z = quadraticCoeff phi x i * z ^ 2
```

Source route: `appendix.tex:984-995` supplies the frozen interpolation and the
Brownian coordinate increment; `appendix.tex:1170-1176` gives the normalized
Gaussian coordinate context; `appendix.tex:1379-1387` is the weak-FP consumer
and keeps the paper's diffusion coefficient outside this scalar event-field
identity.  The theorem only assembles the source term split; it does not prove
the scalar Taylor source definitions.

Remaining exact backend after this packet:

```lean
hSourceTaylorIntegrandDef
hSourceLinearTermDef
hSourceQuadraticTermDef
hScalarMeas
hNormalizedCoordinateLawDef
hSourceTaylorIntegrandMeas
hGeneratorPullbackDef
hNormalizedRemainderMeas
hRemainderPullbackDef
hRemainderMeas
hRemainderBound
hRemainderBoundInt
```

The selected weak-test Hessian fields `hSourceHasHessian` and
`hSourceHessianBound` remain documented source-contract gaps.  No external SLT
theorem was imported, ported, or marked formalized.
