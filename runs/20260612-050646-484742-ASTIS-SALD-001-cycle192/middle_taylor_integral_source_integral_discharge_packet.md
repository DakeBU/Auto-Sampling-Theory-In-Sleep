# Cycle 192 Middle Packet: Taylor Integral Source-Integral Discharge

Classification: `discharges-supplied-hypothesis`.

Packet type: dynamic-leaf worker packet.

Exact supplied hypothesis to discharge:

```lean
hBrownianCoordinateGeneratorSourceIntegralDef
```

inside the active Taylor-integral boundary

```lean
hBrownianCoordinateGeneratorTaylorIntegralDef
```

for the Brownian/Ito frozen interpolation backend of
`sald.general_moving_target_discrete.em_interpolation_fp`.

## Source Anchors

- `appendix.tex:958-970`: normalized Brownian coordinate/source-law setup.
- `appendix.tex:983-996`: frozen EM interpolation
  `eq:general_moving_target_SALD_frozen_interp`.
- `appendix.tex:1161-1170`: normalized Gaussian increment representation.
- `appendix.tex:1379-1387`: weak Fokker--Planck Brownian diffusion line.

The paper's `sigma_eta^2 / 2` weak-FP coefficient stays outside this scalar
coordinate generator leaf.

## Existing Compiled Inputs

Use the already compiled local SALD bridge

```lean
SALD.selectedWeakTestBrownianCoordinateGeneratorSourceIntegralDefOfScalarPushforwardAndStdGaussianVectorLaw
```

to derive `hBrownianCoordinateGeneratorSourceIntegralDef` from:

```lean
hScalarMeas
hNormalizedCoordinateLawDef
hSourceTaylorIntegrandMeas
hGeneratorPullbackDef
hNormalizedVectorLaw
hCoordinateLawDef
hVarianceDef
```

Then feed the derived source-integral field into the already compiled raw
Taylor bridge:

```lean
SALD.selectedWeakTestBrownianCoordinateGeneratorTaylorIntegralDefOfSourceIntegralRawTaylorAndTermDefs
```

which still takes:

```lean
hSourceTaylorIntegrandRawDef
hSelectedLineTaylorRawSplitDef
hSourceLinearTermTaylorDef
hScalarLineFirstCoeffDef
hSourceQuadraticTermTaylorDef
hScalarLineTaylorCoeffDef
```

No external SLT declaration should be imported or called.  The only analytic
law/map/Gaussian content used by this packet is already encapsulated in local
SALD declarations that compile under the current project toolchain.

## Lower_1 Route

Write the natural-language classical proof route for this one ticket:

1. Define the scalar normalized Brownian coordinate as the pushforward of the
   frozen interpolation increment along `stdOrthonormalBasis Real E i`.
2. Use the sample-space generator pullback definition to identify the
   coordinate generator with the source Taylor integrand integrated against
   that normalized scalar law.
3. Use the standard-Gaussian vector law and coordinate-law/variance packaging
   to rewrite the scalar law as `ProbabilityTheory.gaussianReal 0 (variance φ x i)`.
4. Apply the already compiled raw selected-line Taylor bridge to convert that
   source integral into the Taylor integral defining
   `hBrownianCoordinateGeneratorTaylorIntegralDef`.

Do not discuss `hSourceHasHessian`, `hSourceHessianBound`, VP score-Hessian
regularity, KL derivative, divergence/FI/IBP, or source-index rebaselining.

## Lower_2 Target

Implement exactly one compiled ASTIS-owned theorem, suggested name:

```lean
SALD.selectedWeakTestBrownianCoordinateGeneratorTaylorIntegralDefOfScalarPushforwardRawTaylorAndTermDefs
```

Expected shape: same conclusion as
`selectedWeakTestBrownianCoordinateGeneratorTaylorIntegralDefOfSourceIntegralRawTaylorAndTermDefs`,
but replace the primitive input `hBrownianCoordinateGeneratorSourceIntegralDef`
with the seven scalar-pushforward/standard-Gaussian fields listed above.

The proof should be only:

1. derive a local `hBrownianCoordinateGeneratorSourceIntegralDef` using
   `SALD.selectedWeakTestBrownianCoordinateGeneratorSourceIntegralDefOfScalarPushforwardAndStdGaussianVectorLaw`;
2. pass it to
   `SALD.selectedWeakTestBrownianCoordinateGeneratorTaylorIntegralDefOfSourceIntegralRawTaylorAndTermDefs`.

Reviewer acceptance requires `python3 tools/astis.py check` and a strict
boundary shrink: `hBrownianCoordinateGeneratorSourceIntegralDef` must no
longer be a primitive supplied hypothesis for this Taylor-integral bridge.

## Remaining Boundary After Success

After the lower_2 theorem compiles, the active Brownian/Ito backend should be:

```lean
hScalarMeas
hNormalizedCoordinateLawDef
hSourceTaylorIntegrandMeas
hGeneratorPullbackDef
hNormalizedVectorLaw
hCoordinateLawDef
hVarianceDef
hSourceTaylorIntegrandRawDef
hSelectedLineTaylorRawSplitDef
hSourceLinearTermTaylorDef
hScalarLineFirstCoeffDef
hSourceQuadraticTermTaylorDef
hScalarLineTaylorCoeffDef
hRemainderGeneratorLimitDef
hRemainderMeas
hRemainderBound
hRemainderBoundInt
```

The separate `hRemainderGeneratorLimitDef` backend remains governed by the
cycle-190 accepted scalar-pushforward theorem and the concrete
normalized-remainder measurability/domination package.
