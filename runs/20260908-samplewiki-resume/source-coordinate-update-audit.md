# Coordinate-update source preparation

Status: direct page inspection and byte verification, **not** accepted semantic
repair or numbered-source formalization. Date: 2026-09-08. Existing source pins
and source-map issue status were not changed. PDFs remain in ignored local
source cache; no full pages or long source quotations are republished.

## MCMC: primary motivation

[Fearnhead–Nemeth–Oates–Sherlock, arXiv:2407.12751v1](https://arxiv.org/pdf/2407.12751v1#page=54),
section 2.1.1, printed page 48 / PDF page 54.

Downloaded SHA-256:
`60ecdd243a5815771332b5461e7eae59d41242933e53a721785870b6877f008f`,
matching `Libraries/MCMC/source-map.json`. The complete relevant page was
rendered with Poppler and visually inspected.

ASTIS paraphrase: split the state into updated and retained components. The
conditional target supplies a Gibbs proposal; successive component moves
preserve the joint target, although their composition need not be reversible.
The source also distinguishes a formal Gibbs proposal from the ability to
actually draw from the conditional distribution.

Our generic kernel transport is a prerequisite, not a proof of this entire
paragraph: detailed balance, acceptance-ratio domains and executable conditional
sampling remain separate. A coordinate algorithm must additionally prove that
the retained coordinates are unchanged; invariance by itself cannot establish
that operational property.

## Discrete Sampling: existing copy-index issue

[Chen–Štefankovič–Vigoda, arXiv:2307.13826v4](https://arxiv.org/pdf/2307.13826v4#page=5),
section 1.3, printed/PDF page 5.

Downloaded SHA-256:
`3cc2f911b33bb5538157ef8a70f0c7e0f3c812ecd06dc9c1d5ea0bfdae11a52a`,
matching `Libraries/DiscreteSampling/source-map.json`. The complete relevant
page was rendered with Poppler and visually inspected.

The general update's step 2 visibly reads `X_(t+1)(w) = X_t(v)` for `w != v`.
Its subsequent prose describes retaining other coordinates. This confirms the
already registered `discrete-glauber-copy-index` discrepancy, not its repair's
acceptance. The proposed retained-coordinate equation uses `X_t(w)` on the
right. Uniform site choice, conditional sampling, support and mixing are
distinct obligations.

The HTML rendering displays a different title date from the fixed PDF. It was
not substituted for the byte-pinned primary source; both downloaded PDFs match
the repository pins exactly.

## Proposed mathematical witness for future independent review

This is ASTIS analysis, not a quotation or a Lean-verified counterexample.
Take two binary coordinates, feasible state set `{(0,1)}`, and its point mass.
Every conditioning event used at the feasible starting state has probability
one. If coordinate 0 is selected, the printed copy step makes coordinate 1
equal to 0; conditional resampling leaves coordinate 0 equal to 0. The resulting
state `(0,0)` is infeasible. Selecting coordinate 1 similarly produces `(1,1)`.
Thus the literal printed step fails even state-space preservation in this
example. The proposed retained-coordinate rule instead leaves `(0,1)` fixed.

Before source-facing assimilation, a distinct reviewer must check this witness
and the anonymous reconstruction/source-comparison packet under the existing
semantic-roundtrip protocol. Neither the source map nor any Lean statement has
been silently repaired here.
