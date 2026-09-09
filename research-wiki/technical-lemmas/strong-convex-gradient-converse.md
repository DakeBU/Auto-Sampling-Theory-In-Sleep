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
conditional on the protocol gates. Main integration is pending: the single
stabilization lane is occupied by `ASTIS-20260908-KernelInvariance`, owned by
`root-samplewiki-resume`; PR #246 was confirmed OPEN at this closeout. Do not
change that owner or its state to admit this contribution. No PR was created.

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
