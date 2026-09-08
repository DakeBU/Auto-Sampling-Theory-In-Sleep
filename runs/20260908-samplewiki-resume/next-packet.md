# Historical scout: measurable-equivalence kernel transport

This scout has been implemented at `31fe8f2`. See the canonical
`ASTIS-SHARED-kernel-invariant-transport` Frontier Cell for current verification
status, and `coordinate-operational-next-packet.md` for the next strict residual.
The candidate language below records the earlier planning checkpoint; it does
not override the newer compiled evidence.

Read-only scout: `windows_harness_worker`, 2026-09-08. This is an API-inspected
candidate, not a frozen statement or compiled theorem. Source-neutral shared
KERN/MEAS interface; no numbered textbook or SampleWiki theorem is assimilated.

## Minimal candidate

For arbitrary measurable spaces, a kernel `κ : Kernel α α`, a measure `μ`,
`e : α ≃ᵐ β`, and `hκ : κ.Invariant μ`, prove:

```lean
((κ.comap e.symm e.symm.measurable).map e).Invariant (μ.map e)
```

No Markov, finite-measure, Standard-Borel or nonempty assumptions should be
needed for this transport statement. Confirm by a minimal Lean check before
freezing. Search found no exact existing ASTIS/Mathlib theorem at the current
Mathlib pin `db584cd6d46c92f209a44c0f1c829460d327499d`.

## Existing proof APIs to reuse

- `Measure.comp_assoc`, `Measure.map_comp` in
  `Mathlib/Probability/Kernel/Composition/MeasureComp.lean`.
- `Kernel.deterministic_comp_eq_map`, `Kernel.comp_deterministic_eq_comap` in
  `Mathlib/Probability/Kernel/Composition/CompMap.lean`.
- `MeasurableEquiv.map_symm_map`, `map_map_symm` in
  `Mathlib/MeasureTheory/Measure/Map.lean`.
- Existing `Kernel.map`, `comap`, evaluation and Markov transport in
  `Mathlib/Probability/Kernel/Composition/MapComap.lean`.

`Kernel.map` has a nonmeasurable zero fallback: supply the equivalence's genuine
measurability proof. Do not add wrappers for existing evaluation or Markov facts.

## Actual coordinate consumer

`MeasurableEquiv.piFinSuccAbove X i` already splits dependent finite coordinates
as the selected coordinate times the remaining coordinates. Compose with
`prodComm` to obtain `eᵢ : (∀ j, X j) ≃ᵐ (remaining × X i)`. Set
`Hᵢ := HeatBath.heatBathSnd (μ.map eᵢ)` and pull it back by `eᵢ` using map/comap.
Transported invariance gives a coordinate update preserving `μ`.

For arbitrary finite indices, existing `Fintype.equivFin` and `piCongrLeft`, or
`piEquivPiSubtypeProd` and `piUnique`, provide alternatives. No new public
coordinate-splitting lemma is justified by this scout.

The coordinate consumer needs finite `μ` and a nonempty Standard-Borel
resampled coordinate. Other coordinates need only measurability. Updating all
coordinates requires the resampled-coordinate assumptions for each coordinate.
The conditional representative remains characterized only marginal-a.e.

Then `finiteMixture_invariant` supplies fixed-weight random-scan invariance.
Heat-bath, mixture and powers are consumer inputs, not mathematical proof
parents of the transport theorem. Concrete Gibbs support/normalization,
reversibility, mixing, general-state MH and continuous-time domains stay open.

## Integration boundary

Do not edit the currently stabilizing kernel-powers packet concurrently.
The verified queue and its sole stabilization owner must be reconciled before
shared-file integration. No remote PR was updated or merged in this run.
