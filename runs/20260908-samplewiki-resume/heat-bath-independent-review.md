# Independent review: second-coordinate heat bath

Verdict: accepted as an abstract, source-neutral **integration node**.
Verifier: `kernel_packet_review`, independent of `windows_harness_worker`.
Date: 2026-09-08. Checked commit:
`c0ed642305bb36500d5646f06d3f34e6aee32880`.

## Independently executed gates

Lean commands used `ELAN_TOOLCHAIN=leanprover/lean4:v4.33.0` and
`LEAN_NUM_THREADS=1`. Lean commit:
`d8b18978322de05a8f3dba51ef03cf5461676c17`; Mathlib commit:
`db584cd6d46c92f209a44c0f1c829460d327499d`.

- `lake build Tests.HeatBath`: passed, 2976 jobs.
- `lake env lean --stdin`: passed. Checked all four HeatBath signatures and
  printed their axioms: only `propext`, `Classical.choice`, and `Quot.sound`.
  Additional examples with an empty retained space, including zero-target
  Markovness, compiled. No `sorryAx` or custom axiom dependency occurs.
- `python tools/astis_frontier_cells.py check`: passed, 4 registered cells.
- Scoped fake-closure scan of HeatBath.lean and Tests/HeatBath.lean: no `sorry`,
  `admit`, `axiom` declaration, `Prop := True`, or `:= trivial` matches.
- All four scoped artifacts matched the checked commit byte-for-byte before
  publication. The two Lean SHA-256 values also match the worker packet.

| Artifact | Checked Git blob |
| --- | --- |
| `AutoSamplingTheory/TechnicalLemmas/Probability/HeatBath.lean` | `ab7b7b8113738fa2e5a376366bbde93d481b339f` |
| `Tests/HeatBath.lean` | `96f83c6cb76af6005b1be0af8a11336d50e3f537` |
| `research-wiki/frontier-cells/ASTIS-SHARED-heat-bath-snd-invariance.json` | `6194c99040aeec02beed4b986d9801ef9cf88a01` |
| `runs/20260908-samplewiki-resume/heat-bath-worker.json` | `6d3ce99acef3a89f952b6a686cf0225e186598ad` |

## Mathematical audit

The definition first projects to the retained coordinate, then applies the
product of the identity kernel and the selected conditional law. The pointwise
formula is the intended Dirac-product measure. Existing Markov instances supply
s-finiteness, so the kernel product does not use its non-s-finite zero fallback.

The invariant-law proof has the correct composition orientation: reverse
`Measure.comp_assoc`, push the deterministic projection onto the law, and
reverse `Measure.compProd_eq_comp_prod`. Finiteness of the first marginal
supplies its s-finiteness. The final equality is exactly the independently
verified ASTIS disintegration parent, not a supplied invariance assumption.
The focused test directly consumes the existing `KernelInvariance.invariant_pow`
for every natural number; no duplicate power theorem is introduced.

The elaborated signatures require a finite joint measure, arbitrary measurable
retained space, and nonempty Standard-Borel resampled space. Zero measure and
empty retained space are permitted; probability normalization and positivity
are not required. The chosen conditional kernel is Markov everywhere, but its
interpretation as the conditional law is only first-marginal-almost-everywhere.
This gives no conditional-support claim on null fibers.

Source-neutral classification and `none-found` conceptual-mirror audit are
accepted: this is literal integration of formal parents. No numbered source
theorem, primary-PDF byte certification, source copy-index repair, or conceptual
transport is certified. Semantic source-theorem round-trip is not applicable.

## Published state and remaining scope

Published `ASTIS-20260908-HeatBathSnd -> VERIFIED` through `tools.astis_advance`
as `kernel_packet_review`; updated only this cell's status/independent evidence
and added this report. No Lean or shared integration surface was edited.

Reversibility, random/deterministic scan theorems, concrete Gibbs support and
positive weights, feasible pinning adapters, mixing, estimator error, cost,
and SDE claims remain outside acceptance. Root build, shared imports, Registry,
graphs, PR integration, and serialized stabilization remain separate gates.
