# Gradient monotonicity to strong convexity

Cell: `ASTIS-SHARED-strong-convex-gradient-converse`.
Advance: `ANDI-OPT-gradient-converse-001`.
Branch: `andi/opt-gradient-converse`, based on
`4fec6664ccbb0c338b81febe48c02e76486f0da4`.

## Result and source boundary

`AutoSamplingTheory.TechnicalLemmas.Analysis.StrongConvexGradientConverse.strongConvexOn_of_gradient_inner_lower_bound`
is the shared converse from the quantitative gradient inequality to
`StrongConvexOn s m f`. The space is a complete real inner-product space, `s`
is convex, the supplied gradients are ambient gradients at every point of `s`,
and `m` is any real number. The correction in the chord inequality is exactly
`m / 2`. Endpoint regularity follows from the ambient-gradient hypothesis;
gradient continuity is not an additional assumption.

Exact statement provenance is Optlib `Lower_Strong_Convex`, commit
`5da27c5f95aa6a8a45b8c14b968ade4c13ff18c3`,
`Optlib/Convex/StronglyConvex.lean:144–155`, Apache-2.0,
Chenyi Li and Ziyu Wang. The local proof subtracts a scalar quadratic along
each segment and uses Mathlib `MonotoneOn.convexOn_of_deriv`.
The Frontier Cell records searches of ASTIS, pinned Mathlib, Optlib and CvxLean.

This is an existing-result adaptation, not a newly discovered theorem.
It does not certify Chewi Proposition 1.6 in full, its integral proof, a Hessian
characterization, or a Riemannian extension. The next source-facing task is an
explicit Euclidean whole-space C¹ specialization and its precise source
obligation, after checking whether another contributor has closed it.

## Evidence and publication

- The focused test exercises the sharp signed quadratic modulus and the
  closed-interval midpoint correction `m / 8`.
- `Tests.lean` imports that test; an independent dependency inspection confirms
  the theorem is in the root test closure. The Registry count increases by one.
- Full `python3 tools/astis.py check` passed, including `lake build Tests` and
  the fake-closure and ATLAS checks. Only standard Lean logical axioms are used.
- The source-blind decoder and a distinct source reviewer independently
  checked the theorem. Audit `ASTIS-RT-ANDI-OPT-GradientConverse` records
  `equivalent-after-elaboration`; the source reviewer also checked the authored
  proof and actual Mathlib calls. Packets and immutable result artifacts live
  in `runs/semantic-roundtrip/andi-opt-gradient-converse/`.
- The authored lesson and source item generate the chapter reader, compiled
  declaration node and semantic-audit view. Chapter status remains partial.
- No new conceptual mirror was identified beyond the existing curvature-growth
  family. No conceptual correspondence is promoted to a formal dependency.

The implementation is committed at
`e84cd69e87338f9b9593b12e9b11524aa0989d07` and pushed on
`andi/opt-gradient-converse`. Commit-bound independent verification is recorded
in `runs/semantic-roundtrip/andi-opt-gradient-converse/commit-verification.json`
and the canonical ledger. The user authorized direct integration without a PR,
conditional on the protocol gates. The local branch has since incorporated
main through `b9f23c7` at merge commit `969c6d8`; the theorem and its focused test
remain byte-identical to the independently reviewed result. The complete synced
Lean gate passed (9101 test-build jobs), as did 249 harness tests (6 skipped).

The earlier PR #246 reservation was subsequently released in the upstream
ledger. Latest observed remote main `7cc582e` records SPHMCTruncation as
`STABILIZING`, but GitHub confirms its PR #259 merged at
2026-09-11 00:05:19 UTC. This lagging record is not proof of an active integration
lock. Reconcile actual ownership before the next stabilization; do not equate an
open PR with global exclusion or silently impersonate another owner. No PR was
created for this contribution.

## Graph publication inspection

The cell's existing `integration_notes` now contains the generated focus link,
source-reader link, three exact incident relations, remaining source boundary,
and desktop/mobile visual-review scope. Graph coverage and site validation
passed. The module ownership edge is solid; source and semantic correspondence
edges are dashed. The shared declaration has no spurious ASTIS `const_mul`
dependency and no invented compiled downstream consumer. Chapter status remains
partial. The source reader retains the independent verdict and exact signed
modulus and quadratic correction.

Inspected the focused graph, selected-node inspector and Registry reader link
at 1280×720, and the source chapter and graph inspector at 390×844. Narrow text
wraps without document overflow; graph labels require zoom or the complete
inspector. The native colour-select control has low contrast in the current dark
OS rendering; no unrelated global style change was made. No additional static
diagram or screenshot ledger was created.

The first generated preview correctly reported missing site gate evidence,
despite the successful standalone gate. Running the canonical
`website/scripts/lean_gate.py` supplied that source-bound evidence. This was the
reason for the additional cached gate run; unchanged mathematical review hashes
were reused, and no new source-fidelity verdict was authored.

## Integration lessons

Adding a theorem requires checking the real root test import closure, not only
running a focused build. This preserves the lesson from PR #248.

The publication tests previously selected the first source item by file order.
They now select the historical migration fixture by source ID and isolate its
progress expectations while retaining validation of all source items.

The publication diff gate must distinguish Registry metadata from theorem
proofs. Its two metadata-type exemptions use exact fully qualified identities;
the regression retains publication obligations for new mathematics and for
same-short-name types in other namespaces.

The source-based graph scanner previously matched `.const_mul` to an unrelated
ASTIS log-concavity theorem. Candidate local dependencies now respect the
transitive import closure and reject ambiguous short names. This removes an
impossible dependency, but does not turn source scanning into a Lean proof-term
dependency certificate. The authored lesson separately lists the actual
Mathlib dependencies.
