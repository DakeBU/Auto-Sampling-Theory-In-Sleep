# ASTIS-CHEWI-001 Cycle 14 Harness Summary

## Split

| Layer | Decision |
|---|---|
| upper | Continue the Ch.1 finite-box boundary route.  Do not target stationarity, reversibility, or sampler rates. |
| middle | Turn the previous support-subset boundary leaves into a cutoff-smul staging packet. |
| lower | Prove only support containment and finite-box handoffs for `x ↦ chi x • G x`; keep regularity and integrability assumptions explicit. |
| reviewer | Accept the leaf only as a finite-box support producer.  Smooth cutoff construction, `HasCompactSupport`, cutoff-smul differentiability, tail exhaustion, weighted IBP, invariant law, reversibility, and KL/FI remain red. |

## Blue Leaves Added This Cycle

| Key | Declaration | Meaning |
|---|---|---|
| `analysis.calculus.support-smul-subset-univ-pi-Ioo-of-cutoff-eq-zero-off-univ-pi-Ioo` | `support_smul_subset_univ_pi_Ioo_of_eq_zero_off_univ_pi_Ioo` | If a scalar cutoff is zero outside the open Pi-box, then the cutoff-smul vector field is supported in that open Pi-box. |
| `analysis.calculus.support-smul-subset-univ-pi-Ioo-of-scalar-support-subset-univ-pi-Ioo` | `support_smul_subset_univ_pi_Ioo_of_scalar_support_subset_univ_pi_Ioo` | If the scalar cutoff support is contained in the open Pi-box, then the cutoff-smul vector field support is contained there too. |
| `analysis.calculus.signed-face-term-sum-smul-zero-of-cutoff-eq-zero-off-univ-pi-Ioo` | `signedFaceTermSum_smul_eq_zero_of_cutoff_eq_zero_off_univ_pi_Ioo` | Cutoff vanishing outside the open Pi-box implies the cutoff-smul finite-box signed face-term sum is zero. |
| `analysis.calculus.signed-face-term-sum-smul-zero-of-scalar-support-subset-univ-pi-Ioo` | `signedFaceTermSum_smul_eq_zero_of_scalar_support_subset_univ_pi_Ioo` | Scalar cutoff support contained in the open Pi-box implies the cutoff-smul finite-box signed face-term sum is zero. |
| `analysis.calculus.integral-coordinate-divergence-toPi-box-zero-cutoff-eq-zero-off-univ-pi-Ioo` | `integral_coordinateDivergence_toPi_box_eq_zero_of_cutoff_eq_zero_off_univ_pi_Ioo` | Under the existing finite-box trace/differentiability assumptions for the cutoff-smul field, cutoff vanishing outside the open Pi-box implies the coordinate-divergence box integral is zero. |
| `analysis.calculus.integral-coordinate-divergence-toPi-box-zero-scalar-support-subset-univ-pi-Ioo` | `integral_coordinateDivergence_toPi_box_eq_zero_of_scalar_support_subset_univ_pi_Ioo` | Under the existing finite-box trace/differentiability assumptions for the cutoff-smul field, scalar cutoff support inside the open Pi-box implies the coordinate-divergence box integral is zero. |

## Documentation Sync

- Updated root `README.md` to add a cutoff-smul producer row and to keep smooth cutoff construction, cutoff-smul regularity, tail limits, weighted IBP, domains, and invariant law red.
- Added the six cutoff-smul leaves to both technical-lemma JSONL ledgers.
- Confirmed `lean-stat-learning-theory` is still fetched at `216e578c9576bab6b0abc3ba6c65762536768e96`, matching `origin/main`; only `.lake/` cache remains untracked in that external checkout.

## Next Red Leaf

Do not target the invariant Gibbs law directly.  The next small Ch.1 leaf should choose one of these routes:

```text
smooth cutoff construction / bump API
  -> scalar cutoff support or off-open-box zero
  -> compiled cutoff-smul support leaf
  -> compiled signed-face-term zero leaf
  -> compiled coordinate-divergence zero handoff

cutoff-smul regularity package
  -> ContinuousOn / HasFDerivAt / trace IntegrableOn for x ↦ chi x • G x
  -> finite-box coordinate-divergence zero handoff becomes usable for the concrete field

tail-exhaustion estimate for finite boxes
  -> limiting boundary contribution = 0
  -> separate whole-space weighted IBP route
```

Only after those regularity or tail steps should lower agents assemble the weighted IBP handoff and then the invariant-law/domain statements.
