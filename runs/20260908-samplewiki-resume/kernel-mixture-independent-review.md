# Independent review: fixed finite kernel mixtures

Verdict: accepted as a source-neutral integration node.
Verifier: `kernel_packet_review`, independent of `windows_harness_worker`.
Date: 2026-09-08. Checked commit:
`5d67af28a7d2bc8cbe3a1bf2881dae6deb2b1e85`.
The Lean files are unchanged from `fb634580c72fdab16c046a9a89fa3c094af3781d`;
the final commit corrects proof-parent versus test-consumer metadata.

## Independently executed gates

Compilation began only after the root confirmed migration to the original
repository's physical D: `.lake` directory was complete. All verifier Lean
commands used `ELAN_TOOLCHAIN=leanprover/lean4:v4.33.0` and
`LEAN_NUM_THREADS=1`. Pinned Mathlib was independently checked as
`db584cd6d46c92f209a44c0f1c829460d327499d`.

- `lake build Tests.KernelMixture`: passed, 2978 jobs.
- `lake env lean --stdin`: all four declaration signatures checked; printed
  axioms are only `propext`, `Classical.choice`, and `Quot.sound`.
  Explicit empty-index examples compiled: mixture evaluation is zero, and
  normalization to one is impossible.
- `python tools/astis_frontier_cells.py check`: passed, 5 registered cells.
- Scoped scan of the two Lean files: no `sorry`, `admit`, `axiom` declaration,
  `Prop := True`, or `:= trivial` matches. No compiled `sorryAx` or custom axiom
  dependency occurs.
- Before publication, all four scoped artifacts matched the checked commit
  byte-for-byte; both Lean SHA-256 values matched the worker capsule.

| Artifact | Checked Git blob |
| --- | --- |
| `AutoSamplingTheory/TechnicalLemmas/Probability/KernelMixture.lean` | `266e0b2f34882c5777d33a35f6be3215523b7ef7` |
| `Tests/KernelMixture.lean` | `88f3838a1b23df72cce54b86015fddd960a2b412` |
| `research-wiki/frontier-cells/ASTIS-SHARED-finite-kernel-mixture.json` | `035449813140fd0bf285bbe9b3a0e1a12098f1a6` |
| `runs/20260908-samplewiki-resume/kernel-mixture-worker.json` | `0be8289a661f8b31be4af52d6c93eaa564d882eb` |

## Mathematical audit

Pinned `Kernel.withDensity` has a measurable-uncurry branch and a zero fallback.
The proof explicitly supplies `measurable_const`, so every component uses the
genuine constant-density branch. `MeasureTheory.withDensity_const` then gives
the claimed weighted measure sum.

The index is finite and weights are fixed `NNReal` values, excluding negative
and infinite weights. Normalization supplies Markov mass one. Component
s-finiteness is the selected construction's API restriction, automatically
available for Markov components, not a mathematical-necessity claim. The
invariance proof uses measurable finite-sum and constant-multiple lower-integral
identities, then each component's invariance and the weight sum. These APIs and
the elaborated signature impose no finite or s-finite assumption on the target
measure. There is no hidden Bochner integrability condition.

Zero weights are allowed and actual elimination is tested. Empty index gives a
zero-kernel definition, but cannot satisfy the correctness theorems' sum-one
premise. Empty measurable state spaces are not excluded by the signatures.
The identity/heat-bath test allows zero identity weight; therefore its name does
not certify positive holding probability, standard laziness, or aperiodicity.

## Dependency and source audit

The theorem module imports only Mathlib. HeatBath and KernelInvariance are
genuine inputs of `Tests.KernelMixture`, where the mixture is combined with
heat-bath invariance and the existing finite-power theorem. They are not proof
prerequisites of `finiteMixture_invariant`. The final cell and module card now
preserve this distinction through separate `test_consumer_inputs` metadata.

The historical append-only proposal incorrectly names
`MeasureTheory.Measure.withDensity_const`; the actual pinned declaration is
`MeasureTheory.withDensity_const`. The current code and cell use the correct
name. This report and VERIFIED evidence correct interpretation without
rewriting that historical event.

Source-neutral classification and `none-found` conceptual-mirror audit are
accepted. No numbered source theorem, primary-PDF certification, or conceptual
transport is admitted; source-theorem semantic round-trip is not applicable.
State-dependent weights, reversibility, mixing, concrete scan implementation,
Gibbs support/normalization, and SDE claims remain outside this result.

Published `ASTIS-20260908-KernelMixture -> VERIFIED` as `kernel_packet_review`
through `tools.astis_advance`; updated only this cell's verification evidence
and added this report. Root gate, imports, Registry, graph generation, PR work,
and serialized stabilization remain separate. No Lean file was changed.
