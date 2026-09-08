# Independent audit: shared-kernel synthesis

Verdict: validated as a bounded historical synthesis, not a new proof certificate.
Reviewer: `kernel_transport_review`, independent of creator
`root-samplewiki-resume`. Date: 2026-09-08.
Discovery: `ASTIS-DISC-20260908-shared-kernel-synthesis`.
Snapshot: `kernel-cell-synthesis.json`, basis
`1d400af1eda6ffabbb2ef3221965d0261afc4b10`.

Compared all four listed Frontier Cells, the three named independent-review
capsules, the six relevant theorem/test source files, the current advance
ledger states, Registry/test assertion, and local source-bound gate record.
The checked theorem/test files and Registry are unchanged from the basis commit.
No Lean proof was re-certified, no source PDF was re-certified, and no worker
in-progress transport source was reviewed for this audit.

- The synthesis preserves the actual contracts: arbitrary kernels/measures for
  invariant powers; finite joint measure and nonempty Standard-Borel resampled
  coordinate for disintegration/heat bath; finite fixed NNReal normalized
  weights and s-finite component kernels, but arbitrary target measure, for
  the selected mixture implementation. Zero mass and zero weights are not
  silently excluded; empty normalized mixture indices are impossible.
- Proof parents and test inputs are correctly separated. HeatBath imports the
  conditional-law adapter, not KernelInvariance. KernelMixture imports only
  Mathlib; HeatBath and KernelInvariance are test consumers' inputs. The older
  HeatBath cell's broad `parents` list includes the power cell, but its notes,
  actual module imports and the synthesis correctly identify the power use as
  test-only. Do not read that broad list as a declaration-level proof edge.
  After this audit, root normalized the HeatBath metadata by moving the power
  cell to `test_consumer_inputs`; this does not change the reviewed proof.
- These are source-neutral prerequisites, not numbered textbook/paper theorem
  assimilation, SampleWiki contribution completion, mixing/reversibility,
  support on null fibers, concrete Gibbs normalization, or executable cost.
  The conditional-law adapter and bind notation adapter are not counted as
  fresh disintegration or extra substantive power proofs.
- Local Registry/test state is 394, containing only `invariant_pow` from this
  four-member slice. The ledger has KernelInvariance `STABILIZING` and the
  other three advances `VERIFIED`; the power cell is locally `stabilized`.
  This distinction agrees with the synthesis and does not imply publication.
- `.astis/site-lean-gate.json` records passed canonical `tools/astis.py check`
  at the exact basis and digest
  `29e77dfebb2e350586003913264452ee8a78f06ac1911c57d9ebce668cc12213`.
  The 9050-job, 163-test and site inventory counts are consistent with the
  recorded root capsule/plan; this audit does not rerun or newly certify them.
  Source-declaration inventory is not a substantive-leaf count. No remote
  state was fetched or certified; local evidence says no push/merge/deployment
  by this run and does not assert a current remote merged state.
- Measurable-equivalence transport is accurately a next candidate at this
  historical basis, not an accepted compiled result in this snapshot. Any
  later committed transport packet requires its own independent review.

The Discovery transition validates only this compression and its truth
boundaries. It creates no Lean dependency, new mathematical claim, Registry
admission, source-facing completion, or remote publication certificate.
