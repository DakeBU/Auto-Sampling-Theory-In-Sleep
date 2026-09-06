# ASTIS-CHEWI-001 Cycle 16 Harness Summary

## Split

| Layer | Decision |
|---|---|
| upper | Continue Ch.1 finite-box cutoff route; do not target invariant law directly. |
| middle | Remove the explicit `Hi_trace` burden from the cutoff-smul regularity handoffs under a narrow closed-box trace-continuity assumption. |
| lower | Use Mathlib `ContinuousOn.integrableOn_compact isCompact_Icc`; keep trace continuity, smooth cutoff construction, tail exhaustion, and whole-space IBP separate. |
| reviewer | Accept only as finite-box trace-continuity handoff.  No smooth cutoff, canonical `fderiv`, tail limit, weighted IBP, invariant law, reversibility, or KL/FI claim. |

## Blue Leaves Added This Cycle

| Key | Declaration | Meaning |
|---|---|---|
| `analysis.calculus.integrableOn-smul-vectorField-trace-of-continuousOn` | `integrableOn_smul_vectorField_trace_of_continuousOn` | Closed-box continuity of the cutoff-smul product-rule trace gives finite-box `IntegrableOn`. |
| `analysis.calculus.integral-coordinate-divergence-toPi-box-zero-cutoff-eq-zero-off-univ-pi-Ioo-trace-continuous` | `integral_coordinateDivergence_toPi_box_eq_zero_of_cutoff_eq_zero_off_univ_pi_Ioo_of_trace_continuous` | Cutoff-vanishing zero-face handoff with continuity, derivative, and trace-integrability assumptions derived except for trace continuity itself. |
| `analysis.calculus.integral-coordinate-divergence-toPi-box-zero-scalar-support-subset-univ-pi-Ioo-trace-continuous` | `integral_coordinateDivergence_toPi_box_eq_zero_of_scalar_support_subset_univ_pi_Ioo_of_trace_continuous` | Scalar-support version of the same finite-box trace-continuity handoff. |

## Documentation Sync

- `formalizedTechnicalLemmaCount` is now `217`.
- Both technical-lemma JSONL ledgers have `98` rows and no duplicate keys.
- Root `README.md` now marks the finite-box trace-continuity handoff blue, while source trace continuity, smooth cutoff construction, tail exhaustion, weighted IBP, domains, and invariant law remain red.

## Next Red Leaf

Do not target stationarity or invariant Gibbs law next.  The next small Ch.1 leaf should choose one:

```text
source/component trace continuity
  -> prove continuity of the product-rule trace from concrete component hypotheses
  -> feed integrableOn_smul_vectorField_trace_of_continuousOn

smooth cutoff construction
  -> produce scalar cutoff support/off-open-box zero plus regularity hypotheses
  -> feed compiled cutoff-smul support, regularity, and trace-continuity handoffs

tail-exhaustion estimate
  -> finite-box zero-face or boundary estimates converge to whole-space no-boundary IBP
```

The finite-box cutoff route is stronger after this cycle, but still not a whole-space weighted IBP or invariant-law theorem.
