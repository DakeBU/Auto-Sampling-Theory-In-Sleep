# ASTIS-CHEWI-001 Cycle 13 Harness Summary

## Split

| Layer | Decision |
|---|---|
| upper | Keep the active frontier on Ch.1 finite-box Langevin calculus; do not jump to stationarity or sampler rates. |
| middle | Package one small zero-face handoff, one Gibbs-density log-concavity composition, and one exponential-tilt normalization leaf. |
| lower | Implement only ASTIS-owned declarations that compile locally; use `lean-stat-learning-theory` as proof-pattern provenance, not as a dependency. |
| reviewer | Treat finite-box or conditional leaves as blue only for their stated assumptions. Boundary cancellation, weighted IBP, generator domains, invariant law, reversibility, and KL/FI remain red. |

## Blue Leaves Added This Cycle

| Key | Declaration | Meaning |
|---|---|---|
| `analysis.calculus.integral-coordinate-divergence-toPi-box-zero-face` | `integral_coordinateDivergence_toPi_box_eq_zero_of_integrableOn_trace_of_hasFDerivAt_off_countable` | Conditional finite-box result: if the signed face term is explicitly zero, the coordinate-divergence integral is zero. |
| `analysis.calculus.signed-face-term-sum-zero-of-boundary-component-zero` | `signedFaceTermSum_eq_zero_of_boundary_component_eq_zero` | Boundary-value producer: if every lower/upper face normal component is zero, Mathlib's signed face-term sum is zero. |
| `analysis.calculus.integral-coordinate-divergence-toPi-box-zero-boundary-component` | `integral_coordinateDivergence_toPi_box_eq_zero_of_boundary_component_eq_zero` | Finite-box handoff: zero face values plus the existing divergence theorem wrapper imply the coordinate-divergence integral is zero. |
| `analysis.calculus.signed-face-term-sum-zero-of-update-boundary-component-zero` | `signedFaceTermSum_eq_zero_of_update_boundary_component_eq_zero` | Update-shaped producer: if updating any coordinate to either face endpoint makes the normal component zero, the signed face-term sum is zero. |
| `analysis.calculus.integral-coordinate-divergence-toPi-box-zero-update-boundary-component` | `integral_coordinateDivergence_toPi_box_eq_zero_of_update_boundary_component_eq_zero` | Update-shaped finite-box handoff: update-boundary zero values imply the coordinate-divergence integral is zero. |
| `analysis.calculus.update-boundary-component-zero-of-eq-zero-off-univ-pi-Ioo` | `update_boundary_component_eq_zero_of_eq_zero_off_univ_pi_Ioo` | Off-open-box producer: if the vector field is zero outside the open Pi-box, update-to-boundary normal components are zero. |
| `analysis.calculus.signed-face-term-sum-zero-of-eq-zero-off-univ-pi-Ioo` | `signedFaceTermSum_eq_zero_of_eq_zero_off_univ_pi_Ioo` | Off-open-box face-term producer: off-open-box vanishing implies the finite-box signed face-term sum is zero. |
| `analysis.calculus.integral-coordinate-divergence-toPi-box-zero-off-univ-pi-Ioo` | `integral_coordinateDivergence_toPi_box_eq_zero_of_eq_zero_off_univ_pi_Ioo` | Off-open-box finite-box handoff: off-open-box vanishing implies the coordinate-divergence integral is zero, under the existing trace/differentiability assumptions. |
| `analysis.calculus.eq-zero-off-univ-pi-Ioo-of-support-subset-univ-pi-Ioo` | `eq_zero_off_univ_pi_Ioo_of_support_subset_univ_pi_Ioo` | Support-subset producer: support contained in the open Pi-box implies the vector field is zero outside that open Pi-box. |
| `analysis.calculus.signed-face-term-sum-zero-of-support-subset-univ-pi-Ioo` | `signedFaceTermSum_eq_zero_of_support_subset_univ_pi_Ioo` | Support-subset face-term producer: support contained in the open Pi-box implies the finite-box signed face-term sum is zero. |
| `analysis.calculus.integral-coordinate-divergence-toPi-box-zero-support-subset-univ-pi-Ioo` | `integral_coordinateDivergence_toPi_box_eq_zero_of_support_subset_univ_pi_Ioo` | Support-subset finite-box handoff: support contained in the open Pi-box implies the coordinate-divergence integral is zero, under the existing trace/differentiability assumptions. |
| `measure.gibbs-density.lintegral-normalized-toReal-logconcave-strong-convex-minimizer` | `logConcaveOn_lintegral_normalized_gibbsDensityENNReal_toReal_of_strongConvexOn_minimizer` | Strong-convex minimizer plus finite normalizer gives normalized real Gibbs-density log-concavity. |
| `measure.with-density.ofReal-exp-probability-normalization` | `isProbabilityMeasure_withDensity_ofReal_exp_of_integral_eq_one` | Real exponential tilt with integrable mass one defines a `withDensity` probability measure. |

## Documentation Sync

- Rewrote root `README.md` as a readable log-concave-sampling roadmap with chapter heatmap, shared-root graph, active Ch.1 tree, blue/red contract, rendered graph links, red queue, and run loop.
- Added the boundary/off-open-box/support-subset leaves to both technical-lemma JSONL ledgers.
- Refreshed module graph, lemma DAG, blueprint, memory digest, and retrieval indexes.
- Updated the `lean-stat-learning-theory` card and generator template to record the 2026-07-10 `git fetch --prune origin` verification at `216e578c9576bab6b0abc3ba6c65762536768e96`.

## Next Red Leaf

Do not target the invariant Gibbs law directly.  The next small Ch.1 leaf should prove a concrete cutoff/Langevin vector field satisfies a support-subset hypothesis, or open the separate tail-exhaustion route:

```text
concrete cutoff field has support inside the open Pi-box
  -> compiled support-subset leaf
  -> F = 0 outside the open Pi-box
  -> explicit Function.update boundary component values = 0
  -> compiled signed-face-term zero leaf
  -> compiled coordinate-divergence zero handoff
  -> weighted IBP route

tail-exhaustion estimate for finite boxes
  -> limiting boundary contribution = 0
  -> separate whole-space weighted IBP route
```

Only after that should lower agents assemble the weighted IBP handoff and then the invariant-law/domain statements.
