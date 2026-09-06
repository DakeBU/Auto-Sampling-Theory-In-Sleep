# ASTIS-CHEWI-001 Cycle 15 Harness Summary

## Split

| Layer | Decision |
|---|---|
| upper | Continue the Ch.1 finite-box cutoff route below weighted IBP and stationarity. |
| middle | Fill the regularity gap left by the cutoff-smul support leaves: closed-box continuity and open-box/off-countable Frechet derivative. |
| lower | Use Mathlib `ContinuousOn.smul` and `HasFDerivAt.smul`; keep trace integrability explicit. |
| reviewer | Accept only as finite-box regularity staging.  Smooth cutoff construction, trace integrability, tail exhaustion, weighted IBP, invariant law, reversibility, and KL/FI remain red. |

## Blue Leaves Added This Cycle

| Key | Declaration | Meaning |
|---|---|---|
| `analysis.calculus.continuousOn-smul-vectorField-of-continuousOn` | `continuousOn_smul_vectorField_of_continuousOn` | Closed-box continuity of `x ↦ chi x • G x` follows from closed-box continuity of `chi` and `G`. |
| `analysis.calculus.hasFDerivAt-smul-vectorField-of-hasFDerivAt` | `hasFDerivAt_smul_vectorField_of_hasFDerivAt` | Pointwise product-rule Frechet derivative for the cutoff-smul vector field: `chi x • G' + chi'.smulRight (G x)`. |
| `analysis.calculus.hasFDerivAt-smul-vectorField-off-countable` | `hasFDerivAt_smul_vectorField_off_countable` | Off-countable derivative wrapper on the open Pi-box minus a shared exceptional set. |
| `analysis.calculus.integral-coordinate-divergence-toPi-box-zero-cutoff-eq-zero-off-univ-pi-Ioo-regularity` | `integral_coordinateDivergence_toPi_box_eq_zero_of_cutoff_eq_zero_off_univ_pi_Ioo_of_regularity` | Derives the cutoff-smul continuity and derivative hypotheses, then applies the finite-box zero-face coordinate-divergence handoff with trace integrability still explicit. |
| `analysis.calculus.integral-coordinate-divergence-toPi-box-zero-scalar-support-subset-univ-pi-Ioo-regularity` | `integral_coordinateDivergence_toPi_box_eq_zero_of_scalar_support_subset_univ_pi_Ioo_of_regularity` | Scalar-support version of the same finite-box regularity handoff. |

## Documentation Sync

- Updated root `README.md` with a cutoff-smul regularity row.
- Added the five regularity leaves to both technical-lemma JSONL ledgers.
- Kept the next red leaf focused on trace integrability of the product-rule derivative, smooth cutoff construction, or a separate tail-exhaustion route.

## Next Red Leaf

Do not target the invariant Gibbs law directly.  The next small Ch.1 leaf should choose one of these:

```text
trace-integrability package
  -> continuity or domination for the product-rule trace
  -> IntegrableOn (sum_i ((chi x • G' x + chi'.smulRight (G x)) e_i)_i)
  -> compiled cutoff-smul regularity handoff becomes fully usable

smooth cutoff construction / bump API
  -> scalar cutoff support or off-open-box zero
  -> compiled cutoff-smul support and regularity leaves

tail-exhaustion estimate for finite boxes
  -> limiting boundary contribution = 0
  -> separate whole-space weighted IBP route
```

Only after these finite-box regularity or tail steps should lower agents assemble the weighted IBP handoff and then the invariant-law/domain statements.
