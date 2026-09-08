# Independent review: recovered shared kernel interfaces

Verifier: `kernel_packet_review`, independent of proving owner
`root-samplewiki-resume`. Date: 2026-09-08.
Checked commit: `51dbfae5089e163b7e28195591df7010d5850ada`.

Verdict: accepted as two source-neutral reusable interfaces. The verifier
published `VERIFIED` for `ASTIS-20260908-KernelInvariance` and
`ASTIS-20260908-ConditionalResampling` through `tools.astis_advance` and updated
only their Frontier Cell verification status/evidence. This is not root-build,
Registry, graph, stabilization, merge, or numbered source-theorem acceptance.

## Independent evidence

All Lean commands explicitly set
`ELAN_TOOLCHAIN=leanprover/lean4:v4.33.0`.
Lean reports commit `d8b18978322de05a8f3dba51ef03cf5461676c17`;
Mathlib checkout is `db584cd6d46c92f209a44c0f1c829460d327499d`.

- `lake build Tests.KernelInvariance`: passed, 1884 jobs.
- `lake build Tests.ConditionalResampling`: passed, 2973 jobs.
- `python tools/astis_frontier_cells.py check`: passed, 3 registered cells.
- `lake env lean --stdin`: independently checked the elaborated signatures and
  printed axioms of `invariant_pow`, `bind_pow_eq`, and
  `fst_compProd_condDistrib_snd_eq_self`. All three depend only on `propext`,
  `Classical.choice`, and `Quot.sound`; no `sorryAx` or custom axiom occurs.
- Scoped search of the two modules and two tests found no `sorry`, `admit`,
  `axiom` declaration, `Prop := True`, or `:= trivial` closure.
- The four Lean files exactly matched their committed bytes before review
  publication, checked with unfiltered Git blob hashes. Unrelated ATLAS
  worktree differences were left untouched.

Exact checked file fingerprints:

| File suffix | Git blob | SHA-256 |
| --- | --- | --- |
| `Probability/KernelInvariance.lean` | `31b062f40b707bad427d799988653a760da8fe12` | `b4d2789392a041bffde60b00558144824ceca72aa7f02c5800409d10139112f6` |
| `Probability/ConditionalResampling.lean` | `1a9d0c1ceb70ca5d917f378bbe609c968013e0cb` | `bd3b0804afd62ced45cf8786eb39b7ac3f9f14f7cf15f2824e29ff06c2ecea79` |
| `Tests/KernelInvariance.lean` | `1f2cbbdc4e5211215458fb4480191f08f0222b41` | `c8ddea5374d1e27c2332f7706f5b0fe42603c41bbc2574c71431f4021bb35201` |
| `Tests/ConditionalResampling.lean` | `6e856005a7b8ceabf146b3d775792fbe70936e32` | `fc6701d9b8c660a998fdab6cb274f3fd08fbeb4eefbd8d50b0be781740cb8e14` |

The first two paths are under `AutoSamplingTheory/TechnicalLemmas/`.

## Mathematical and source-boundary audit

`invariant_pow` reuses pinned `ProbabilityTheory.Kernel.Invariant.comp` and
the kernel monoid: zero is the identity kernel, and the successor step uses
the correctly ordered composition. Empty state spaces and arbitrary measures
and kernels are allowed. The theorem adds no Markov normalization or finiteness
assumption. `bind_pow_eq` is its measure-notation adapter, not a second leaf.
The reversibility consumer correctly supplies the Markov hypothesis required
by Mathlib's reversibility-to-invariance theorem.

The conditional result is an exact product-state specialization of pinned
`ProbabilityTheory.compProd_map_condDistrib` (CondDistrib.lean, lines 54-85).
It assumes finite joint measure and nonempty Standard-Borel resampled space;
the retained space is only measurable. Zero measure is allowed. Explicit
`mβ := inferInstance` selects the already provided measurable space on the
retained coordinate; the elaborated signature confirms no new assumption.
Conditional representatives are determined only first-marginal-almost-everywhere,
and there is no pointwise density or null-fiber support claim.

The shared packet and PROVED_LOCAL evidence classify both advances as reusable
interfaces, with no numbered textbook/paper theorem marked assimilated.
Acceptance is against the exact pinned Mathlib formal core; textbook anchors
remain consumer motivation. Full primary-PDF byte verification and faithful
source-theorem reconstruction are not certified by this review. Semantic
round-trip is not applicable to source-theorem assimilation at this boundary.
The independently reviewed conceptual-mirror audit is `none-found`: literal
reuse of one formal interface does not introduce a conceptual transport.

## Remaining boundary

Constructing a state-to-state heat-bath update, proving its invariance or
reversibility, conditional-support adapters, scan-order composition, ergodicity,
mixing, estimator error, and computational cost remain downstream obligations.
Neither result addresses MH singular-support/Radon-Nikodym construction,
finite-jump MLSI zero-density domains, or SDE generator domains. Root build,
shared imports, Registry and graph refresh, and serialized stabilization remain
the root owner's separate gates.
