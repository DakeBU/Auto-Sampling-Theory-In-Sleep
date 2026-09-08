# Independent review: measurable-equivalence kernel transport

Verdict: accepted as one source-neutral reusable interface.
Verifier: `kernel_transport_review`, independent of `kernel_transport_worker`.
Date: 2026-09-08. Checked commit:
`31fe8f23265077225ed31adf169b2895cbd1c958`.

## Independent gates

All Lean/Lake calls used `ELAN_TOOLCHAIN=leanprover/lean4:v4.33.0` and
`LEAN_NUM_THREADS=1`, in the original repository's physical D: cache.
Mathlib commit independently checked:
`db584cd6d46c92f209a44c0f1c829460d327499d`.

- `lake build Tests.KernelTransport`: passed, 2979 jobs.
- `lake env lean --stdin`: passed; checked the elaborated public signature and
  exact proof-API signatures. Printed axioms are only `propext`,
  `Classical.choice`, and `Quot.sound`. Independent pointwise transport,
  arbitrary-kernel zero-target, and empty-state examples also compiled.
- Scoped fake-closure scan: no `sorry`, `admit`, custom `axiom`, `Prop := True`,
  or `:= trivial` closure. No compiled `sorryAx` dependency.
- Frontier Cell check: passed, 6 cells. Scoped `git diff --check`: clean.
- Module, test, cell, module card and worker packet all matched the exact
  committed bytes before review publication, using unfiltered Git hashes.

| Artifact | Checked Git blob |
| --- | --- |
| `Probability/KernelTransport.lean` | `d9172c1f66c35575ee6c848dd940cf61a2172789` |
| `Tests/KernelTransport.lean` | `2332f6e29848246e21cee6c11db75c0981ab45b1` |
| Transport Frontier Cell | `9e3bf51a74223f4ec05dc88a7b4950cfbb4251b8` |
| Transport module card | `545af0fa8b2267b4cf650f38e239c8e957a716bd` |
| Worker packet | `f4558910d1585271555812d679ddd4eecd6f4955` |

The module path is under `AutoSamplingTheory/TechnicalLemmas/`.
Its SHA-256 is `509a03bf2833a27036017b172fe12e74f9fd56d1828786227397ecff646ab217`;
the test SHA-256 is `54c26fb2d1bb91d5279f2dda1ed3721232f7f5ff4dd375d7e770408a94fcb53c`.

## Mathematical and source audit

`invariant_map_comap` sends state `y` to the law `(κ (e.symm y)).map e`.
Input comap uses the inverse equivalence; output and target pushforwards use
the forward equivalence. `e.measurable` selects the genuine Kernel.map branch,
and `e.symm.measurable` supplies the comap contract. Reassociation and
`e.map_symm_map` cancel the input pushforwards before using the original
invariance. The proof constructs the transported invariant statement; it does
not merely restate supplied invariance of that transported kernel.

All proof APIs and the elaborated theorem are unrestricted in kernel/measure
finiteness and Markovness. No Standard-Borel, nonempty or singleton-measurability
condition is hidden. Zero targets and empty state spaces are allowed. The
worker packet's `MeasureComp.lean:99` locator for `Measure.map_comp` is stale:
the pinned declaration is at line 85 (`comp_assoc` is at line 30, not 31).
The recorded names and types are correct; exact signatures were checked.

The public module has one Mathlib import and one theorem. HeatBath, KernelMixture,
KernelInvariance and coordinate splitting are test-only consumers, not proof
parents. The dependent `piFinSuccAbove` split followed by `prodComm` puts `X i`
second and all `i.succAbove j` coordinates first; the tests verify both formulas.
Conjugation back uses the inverse split in the theorem, correctly cancelling
the pushed target. A Fin 3 / Bool middle-coordinate case and fixed-mixture
finite powers exercise the construction, with genuine Markov instances.

Those private tests are not a public operational coordinate algorithm. Finite
coordinate count does not imply finite state space. The heat-bath consumer
requires finite target and nonempty Standard-Borel resampled coordinate;
retained coordinates remain arbitrary measurable spaces. No literal
retained-coordinate equality almost everywhere, measurable-singleton adapter,
null-fiber support, Gibbs normalization, source copy-index repair, reversibility,
mixing or cost theorem is accepted here.

Source-neutral classification and `conceptual_mirror_audit = none-found` are
accepted: this is literal measurable-equivalence algebra and direct theorem
reuse, not a new cross-domain analogy or categorical functor certificate.
Numbered source-theorem semantic roundtrip is not applicable. Root's separate
primary-page audit is not re-certified and its repair candidate is not admitted.

## Publication boundary

Published only this SAU's `VERIFIED` event and this cell's independent evidence.
The observed root gate record separately reports passed canonical
`tools/astis.py check` at the exact commit and source digest
`6482d3992d8e43386e5aff46d6f2a057353a3f02527a9b6416de6ae60e4d16aa`;
this verifier did not rerun that global gate. Registry, shared imports, site,
stabilization and remote publication remain the root owner's separate scope.
