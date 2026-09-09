# PR #248: independent review and serialized integration

Date: 2026-09-09. Author: andyjm3. Verifier/stabilization owner: the current
maintainer review task, distinct from the contributor who proved the theorem.

Reviewed commit: `a3506c2a370f98926ffee2e6f41f3a2152fa7aa6`.
Website integration parent: `8937518af764ab6a042df74b0c98213a0fd36549`.
The reviewed Lean and focused-test Git blobs are respectively
`911c2252637f407b87cfdca2bcc00ce21c259d98` and
`445858c1252dbb95a121464d716daaf5b259a123`; integration leaves both unchanged.
GitHub approval review: `5152758694`.

## Verdict and mathematical boundary

No blocking correctness issue found. `Tests.lean` now imports the focused test,
resolving the previous root-test reachability gap. The proof uses the existing
ASTIS first-order bound twice, swaps the displacement in one inequality, expands
the inner product, and adds the inequalities. Both quadratic halves are retained.
The positive-modulus test proves gradient injectivity rather than restating the
input inequality.

The complete real inner-product space, convex domain encoded in StrongConvexOn,
ambient HasGradientAt hypotheses on that domain, and arbitrary real modulus
match the pinned Optlib interface. Genuine differentiability is supplied, not
inferred from a totalized gradient. Positive modulus is required only for the
injectivity test. No measure-theoretic or Hessian assumption is added.

Source comparison:

- [Optlib Strong_Convex_lower](https://github.com/optsuite/optlib/blob/5da27c5f95aa6a8a45b8c14b968ade4c13ff18c3/Optlib/Convex/StronglyConvex.lean):
  identical mathematical statement after swapping x and y; Chenyi Li and Ziyu
  Wang, Apache-2.0. ASTIS uses its own first-order proof, not the external code.
- [Chewi, Lectures on Optimization, Proposition 1.6](https://arxiv.org/html/2605.07006v1#S1.SS2):
  the (1.4) to (1.5) implication, with whole-space C1 and nonnegative-modulus
  specialization kept distinct from the generic local interface.

This review does not close the reverse implication, Hessian equivalence,
whole-space source-facing specialization, gradient-flow contraction, Gibbs
invariance, or sampling complexity. No new conceptual bridge is claimed.

## Verification

- Lean toolchain: `leanprover/lean4:v4.33.0`.
- `lake build Tests.Shared.StrongConvexFirstOrder`: passed (2443 jobs).
- `#print axioms` for the new theorem and its first-order parent: only
  `propext`, `Classical.choice`, `Quot.sound`; no placeholder or custom axiom.
- `python3 tools/astis.py check`: passed on the integrated tree, including
  `lake build` and `lake build Tests` (9052 jobs), ATLAS and fake-closure checks.
- `python3 tools/astis.py harness-test`: 210 tests passed.
- Focused website/graph/companion regression suite: 64 tests passed.
- `python3 tools/astis_frontier_cells.py check`, Python syntax validation and
  `git diff --check`: passed.
- PR-head CI: formalization run `34326063168` and site run `34326063410` passed.
- Website build and link/status validation: passed, 12 chapters, 522 modules,
  3623 declarations and 396 registered compiled leaves.

## Integration delta

The public Analysis aggregator and Registry import the shared module. Registry
membership grows from 394 to 396: **one new theorem** from this PR and **one
previously existing parent** admitted to the registry, not two new proofs.
Tests.Basic checks the resulting count. Source-driven website generation exports
both declarations and their dependency edge; authored declaration lessons explain
the complete assumptions and proof calculations with adjacent collapsed Lean
statement/proof panels. Natural-language exposition is not a source-equivalence
certificate.

The website companion commit is retained intact as a merge parent. The active
Chewi 8.4.1 route and the two new papers' unformalized frontier boundaries remain
unchanged. No Goal or mathematical-cycle state is advanced by this review.
