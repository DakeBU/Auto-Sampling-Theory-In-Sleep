# Cycle 206 lower_1 route: remainder pullback

narrows-source-cited-boundary.

Packet type: dynamic-leaf worker packet.

Exact missing theorem boundary narrowed: `hRemainderPullbackDef`, the
sample-space definition below `hRemainderGeneratorLimitDef`.

## Target

Use only the middle-assigned boundary:

```text
hRemainderPullbackDef :
  testRegular ->
    forall phi x i,
      remainderGeneratorLimit phi x i =
        integral over omega against P of
          normalizedRemainder phi x i
            (scalarBrownianCoordinate phi x i omega)
```

This is strictly below `hRemainderGeneratorLimitDef`: the compiled bridges
`SALD.selectedWeakTestRemainderGeneratorNormalizedLawDefOfScalarPushforward`,
`SALD.selectedWeakTestRemainderGeneratorLimitDefOfStdGaussianVectorLaw`, and
`SALD.selectedWeakTestRemainderGeneratorLimitDefOfScalarPushforwardAndStdGaussianVectorLaw`
already consume this field and then move to the normalized-coordinate law and
standard Gaussian law.  Do not add another consumer wrapper around those
bridges.

## Source anchors

- `appendix.tex:958-970`: the EM step supplies the Brownian increment.
- `appendix.tex:983-996`: the frozen interpolation is
  `X_k^eta + drift * (s-s_k) + sigma_eta (W_s-W_s_k)`.
- `appendix.tex:1161-1170`: under the frozen law,
  `hat X_s - X_k^eta` is represented by a drift part plus
  `sigma_eta sqrt(s-s_k) xi` with `xi ~ N(0,I)`.
- `appendix.tex:1379-1387`: the weak Fokker--Planck consumer uses the same
  frozen interpolation and keeps the diffusion prefactor outside this scalar
  remainder leaf.

A targeted source search over the included paper files, excluding
`sald_version_2.tex`, found no named `normalizedRemainder`,
`remainderGeneratorLimit`, `scalarBrownianCoordinate`, `normalized remainder`,
or `Taylor remainder` definition.  Therefore the pullback equation is a
definition/interface boundary unless lower_2 finds a reducible local Lean
definition.

## Classical route

Fix `testRegular`, `phi`, `x`, and coordinate `i`.  Write

```text
Z_i(omega) = scalarBrownianCoordinate phi x i omega
R_i(z) = normalizedRemainder phi x i z
mu_i = normalizedCoordinateLaw phi x i
```

The paper's frozen interpolation gives the normalized scalar Brownian coordinate
by evaluating the Gaussian increment along coordinate `i`.  The selected
one-dimensional Taylor expansion contributes a scalar residual `R_i(Z_i)`.
The remainder generator contribution is the expectation of this residual under
the original sample space:

```text
E_P[R_i(Z_i)].
```

Thus the missing pullback definition is exactly:

```text
remainderGeneratorLimit phi x i = E_P[R_i(Z_i)].
```

Once this field is supplied, the already compiled scalar-pushforward bridge
uses only:

- `hScalarMeas`: `Z_i` is a.e. measurable under `P`;
- `hNormalizedCoordinateLawDef`: `mu_i = Measure.map Z_i P`;
- `hNormalizedRemainderMeas`: `R_i` is a.e. strongly measurable under `mu_i`;
- Mathlib `MeasureTheory.integral_map`.

It then rewrites

```text
E_P[R_i(Z_i)] = integral R_i d mu_i.
```

The later bridge from `mu_i` to `gaussianReal 0 (variance phi x i)` is already
compiled using the local normalized-coordinate and variance facts.  That later
Gaussian-law step must not be repeated in this lower_1 packet.

## Lean-facing proof split

If `remainderGeneratorLimit` is a reducible local definition, lower_2 should
prove exactly one theorem/proof block of this shape:

```text
theorem ...RemainderPullbackDefOfLocalDefinitions
    {Omega Test E : Type*} [MeasurableSpace Omega]
    [NormedAddCommGroup E] [InnerProductSpace Real E]
    [FiniteDimensional Real E]
    (P : MeasureTheory.Measure Omega)
    (scalarBrownianCoordinate :
      Test -> E -> Fin (Module.finrank Real E) -> Omega -> Real)
    (remainderGeneratorLimit :
      Test -> E -> Fin (Module.finrank Real E) -> Real)
    (normalizedRemainder :
      Test -> E -> Fin (Module.finrank Real E) -> Real -> Real)
    (testRegular : Prop) :
    testRegular ->
      forall phi x i,
        remainderGeneratorLimit phi x i =
          integral over omega against P of
            normalizedRemainder phi x i
              (scalarBrownianCoordinate phi x i omega)
```

Expected proof if reducible: introduce `htests phi x i`, unfold only the local
definitions of `remainderGeneratorLimit` and the scalar coordinate/pullback
fields as needed, then close by `rfl`/`simp`.  Do not unfold or redefine
`normalizedRemainder` as a selected-line residual here; cycle 205 already
recorded that missing raw Taylor residual definition as a separate source
contract gap.

If the definitions do not reduce, lower_2 should record exactly this typed
source-contract feedback:

```text
leaf=hRemainderPullbackDef
error_class=source_contract_gap_missing_remainder_pullback_definition
needed_shape=testRegular -> forall phi x i, remainderGeneratorLimit phi x i =
  integral omega, normalizedRemainder phi x i
    (scalarBrownianCoordinate phi x i omega) dP
source_lines=appendix.tex:958-970;appendix.tex:983-996;appendix.tex:1161-1170;appendix.tex:1379-1387
blocked_by=remainderGeneratorLimit and normalizedRemainder are source-facing abstract fields in the compiled scalar-pushforward remainder bridge unless lower_2 finds a reducible local definition
```

## Local facts and exclusions

Callable local facts:

- `SALD.selectedWeakTestRemainderGeneratorNormalizedLawDefOfScalarPushforward`
- `SALD.selectedWeakTestRemainderGeneratorLimitDefOfStdGaussianVectorLaw`
- `SALD.selectedWeakTestRemainderGeneratorLimitDefOfScalarPushforwardAndStdGaussianVectorLaw`
- `AutoSamplingTheory.TechnicalLemmas.SALDExtracted.selectedWeakTestNormalizedCoordinateLawOfStdGaussianVectorLaw`
- `AutoSamplingTheory.TechnicalLemmas.Gaussian.nnrealVarianceOneOfGaussianRealUnitLaw`

Mathlib ingredient: `MeasureTheory.integral_map` with the existing
`AEMeasurable` and `AEStronglyMeasurable` hypotheses.

No external SLT theorem is imported, called, queued, or marked formalized.
This route rejects source-Hessian work, selected-line raw Taylor replay,
endpoint/naming replay, KL derivative work, IBP work, theorem-status
promotion, and consumer-wrapper churn.

## lower_2 handoff

Implement or reject exactly one block: `hRemainderPullbackDef`.  First inspect
whether the local definitions of `remainderGeneratorLimit`,
`normalizedRemainder`, and `scalarBrownianCoordinate` reduce to the
sample-space expectation above.  If yes, compile the direct unfold/rfl theorem
and then reuse the already compiled scalar-pushforward bridge.  If no, record
the typed feedback above and keep the build green.
