# Source window for random-scan detailed balance

This is source and assumption bookkeeping for the next existing-kernel consumer,
not proof certification or a new Goal. All exposition below is ASTIS paraphrase.

## Direct finite-state background

Levin–Peres, with contributions by Wilmer, *Markov Chains and Mixing Times*,
second edition, is linked by the Discrete Sampling source map as classical
background. Its author-hosted PDF was retrieved on 2026-09-08 from
<https://pages.uoregon.edu/dlevin/MARKOV/mcmt2e.pdf> and byte-pinned:

`9ef39f9467d9647ff3f5e8747b9ce24b7a90d13be2f8156fbd827b95b661a772`.

The PDF has 461 pages. Complete printed pp.42–43 / PDF pp.58–59 and printed
p.45 / PDF p.61 were rendered and visually inspected. Section 3.3.2 defines a
finite configuration model with state set equal to the target's support.
Equation (3.6) fixes all coordinates except the selected vertex; (3.7) is the
normalized target restriction to that fiber. A uniformly selected vertex gives
one update. The section states reversibility and stationarity, with verification
assigned to Exercise 3.2.

The current ASTIS random-scan kernel uses Boolean spins and `Fin(n+1)` sites.
It is the **Boolean specialization** of this finite-alphabet background, not
completion of the arbitrary-alphabet exercise. The source's supported-state
kernel is represented on the ambient Boolean cube. Positive starts have the
already proved operational law; zero-target atoms enter weighted flux through
zero mass and must not be treated as positive conditioning events. No empty-site
uniform choice is defined.

## MCMC and Discrete Sampling context

The pinned Fearnhead–Nemeth–Oates–Sherlock PDF `2407.12751v1` has SHA-256
`60ecdd243a5815771332b5461e7eae59d41242933e53a721785870b6877f008f`.
Complete printed pp.48–49 / PDF pp.54–55 were visually inspected. Section 2.1.1
explains the detailed-balance property of a conditional component move and the
unit acceptance probability of an exact Gibbs proposal. It also distinguishes
composing such moves, which preserves the target but generally need not be
reversible. A uniform random mixture is not a deterministic composition.

Chen–Štefankovič–Vigoda `2307.13826v4` §1.3, PDF p.5, introduces general binary
Glauber dynamics after the hard-core example. That example's irreducibility and
aperiodicity arguments do not apply to every supported Boolean distribution.
The existing diagonal-target counterexample is an immediate scope check.
The original printed copy-index discrepancy and its separate reviewed overlay
remain in the prior source audit; neither is silently erased by this proof.

## Mathematical/API packet boundary

The intended consumer is Mathlib's existing `Kernel.IsReversible` for the actual
`randomScan mu`, with no full-support or positive-start premise in this weighted
balance assertion. At positive atoms, equal retained fibers give symmetric
flux; null-atom cases use zero factors and the opposite supported-start law.
The worker must then reach the genuine measurable-set lintegral contract.

One proposed shared bridge handles countable measurable-singleton state spaces:
pointwise singleton flux balance implies the existing set-lintegral
reversibility property. This is a discrete integration theorem, not a new
definition of reversibility. Its unrestricted-measure/kernel assumptions must
be proved using the actual Mathlib APIs; no Markov/finiteness hypotheses may
be added merely for convenience. The finite random-scan theorem is its real
consumer. Source-blind reconstruction and independent source comparison begin
only after exact compiler output exists.

The source PDFs are cached only for read-only audit, not republished or assigned
an open-source license. Public documentation links originals and contains
original mathematical restatement. Missing `outer_repos` and `outer_papers`
checkouts were observed explicitly; no external-code port or fetch is claimed.

## Packet-bound semantic outcome

The two public declarations compiled at proof checkpoint `865871b`. Fresh
`reversibility_blind_decoder` reconstructed the exact consumer statement from
only its generated anonymous packet and approved definitions. Before persistence
the decoder approved replacing only the absolute input path with a relative
one; no mathematical or slot text changed.

Fresh `reversibility_source_review` independently read complete LPW pages
58, 59 and 61 and matched the PDF digest. It accepted the precisely selected
Boolean reversibility clause as `equivalent-after-elaboration`. Seven semantic
slots and six informational deltas cover the finite-alphabet restriction,
support/ambient presentation, conditional versions, nonempty site count,
set-integral formulation and exclusion of the separate stationarity clause.
No source repair was needed for this target. The exact response is
`reversibility.source-review-result.json`, SHA-256
`5d2cfd3266f530d054cdbcefe087578ffe5dea8b6a9163ef44f3a9d3d6592528`.

Canonical audit `ASTIS-RT-20260908-RandomScanReversibility` owns the outcome.
The semantic gate passes with three audits and the one existing, separately
reviewed copy-index repair. This does not change the original source or earlier
audit evidence, nor does source acceptance replace independent proof review.
