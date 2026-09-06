# Cycle 204 Lower_1 Route: Source Taylor Integrand Selected-Increment Naming

Classification: `narrows-source-cited-boundary`.

Packet type: dynamic-leaf worker packet, lower_1 proof-scout subpacket.

Exact missing theorem boundary:

```lean
hSourceTaylorIntegrandSelectedIncrementDef :
  testRegular ->
    forall phi x i z,
      sourceTaylorIntegrand phi x i z =
        sourceSelectedLineIncrement phi x i z
```

## Source Read

The cited source blocks give the stochastic objects that this Lean naming
field is meant to connect:

- `appendix.tex:958-970` defines the Euler--Maruyama update and its Gaussian
  noise increment.
- `appendix.tex:983-996` defines the frozen interpolation `\hat X_s`.
- `appendix.tex:1161-1170` rewrites the frozen increment using
  `\sigma_\eta(t(s))\sqrt{s-s_k}\xi`, with `\xi ~ N(0,I)`.
- `appendix.tex:1379-1387` consumes the frozen interpolation through the weak
  Fokker--Planck equation.

I did not find a paper-level symbol named `sourceTaylorIntegrand` or
`sourceSelectedLineIncrement` in the original source.  These are Lean-facing
source-correspondence names for the selected weak-test increment along the
normalized frozen Brownian coordinate.  Consequently, the classical route is
not an analytic Taylor, Gaussian-integrability, or weak-FP argument; it is a
definition/correspondence check.

## Classical Proof Route

Fix `testRegular`, a selected test `phi`, state `x`, coordinate `i`, and scalar
coordinate `z`.

1. Read `sourceSelectedLineIncrement phi x i z` as the selected weak-test
   increment attached to the normalized frozen Brownian coordinate.
2. Read `sourceTaylorIntegrand phi x i z` as the scalar integrand whose
   Gaussian expectation gives the Brownian coordinate generator for the same
   selected weak-test increment.
3. If both names unfold to the same source expression, the proof is
   definitional:

   ```lean
   intro htests phi x i z
   rfl
   ```

   or, if the local definitions are opaque but unfold by simplification,

   ```lean
   intro htests phi x i z
   simp [sourceTaylorIntegrand, sourceSelectedLineIncrement]
   ```

4. Do not use `hSelectedIncrementEndpointDef` or
   `hSelectedEndpointCoordinateLineDef` for this leaf.  Those fields identify
   the selected increment with an endpoint difference and then with
   `x + z • stdOrthonormalBasis Real E i`; cycles 202-203 already kept those
   endpoint gaps separate.

## Lean Shape For Lower_2

If lower_2 finds reducible local definitions, implement one ASTIS-owned theorem
in the same selected weak-test region with this proof shape:

```lean
theorem selectedWeakTestSourceTaylorIntegrandSelectedIncrementDef
    {Test E : Type*} [NormedAddCommGroup E] [InnerProductSpace Real E]
    [FiniteDimensional Real E]
    (sourceTaylorIntegrand sourceSelectedLineIncrement :
      Test -> E -> Fin (Module.finrank Real E) -> Real -> Real)
    (testRegular : Prop)
    -- replace the two abstract arguments above by the concrete local
    -- definitions if they exist
    :
    testRegular ->
      forall phi x i z,
        sourceTaylorIntegrand phi x i z =
          sourceSelectedLineIncrement phi x i z := by
  intro htests phi x i z
  -- expected to close by rfl/simp only after the concrete definitions unfold
  rfl
```

With `sourceTaylorIntegrand` and `sourceSelectedLineIncrement` kept as arbitrary
parameters, this theorem is impossible without assuming the equality: no
Mathlib or local Gaussian lemma can prove equality of two arbitrary functions.
In that case lower_2 should record the strict source-cited obligation instead
of adding a wrapper theorem.

Typed verifier feedback for that case:

```text
leaf=hSourceTaylorIntegrandSelectedIncrementDef
error_class=source_contract_gap_missing_source_taylor_integrand_selected_increment_definition
needed_shape=testRegular -> forall phi x i z,
  sourceTaylorIntegrand phi x i z =
    sourceSelectedLineIncrement phi x i z
blocked_by=sourceTaylorIntegrand and sourceSelectedLineIncrement are abstract parameters in the compiled selected-increment/raw-integrand bridges; the original paper source does not introduce these Lean-facing names verbatim
```

## Ingredients And Non-Ingredients

Callable local consumers:

```lean
SALD.selectedWeakTestSourceTaylorIntegrandRawDefOfSelectedIncrementAndLineDef
SALD.selectedWeakTestSourceTaylorIntegrandRawDefOfSelectedIncrementEndpointAndLineDef
SALD.selectedWeakTestSelectedIncrementCoordinateLineDefOfEndpointAndLineDef
```

The equality itself should need only unfolding, `rfl`, or `simp` if concrete
definitions exist.  It should not use Gaussian integrability, dominated
convergence, Hessian regularity, VP score-Hessian assumptions, normalized
remainder bounds, endpoint replay, or any direct SLT import.

Lower_2-ready handoff: inspect whether the current Lean namespace contains
concrete reducible definitions for `sourceTaylorIntegrand` and
`sourceSelectedLineIncrement`.  If yes, prove the definitional equality above.
If not, record exactly the typed source-contract gap above and keep the build
green.
