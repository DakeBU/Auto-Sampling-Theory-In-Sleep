# SPHMC recursive parameter termination

Status: production Lean module and Gibbs consumer test compiled locally on
Lean 4.33.0; publication metadata and independent source/commit admission remain pending.
Exact command/hash evidence: `runs/20260910-companion-priority/recursive-depth.progress.json`.
Source: arXiv:2609.06906v1, Lemma 6.4, equations (6.1)--(6.4),
Lemma 6.6, and the terminal-stage paragraph in the proof of Theorem 6.5.

## Exact recurrence and target

Assume `1 ≤ κ`, `0 ≤ r₀`, `0 < c < 1/4`, and `0 < η j ≤ c` for every j.
Use precision to retain the permitted infinite initial regularization parameter:

\[
K(r)=\frac{1+r}{\kappa^{-1}+r},\quad
\tau(r)=\begin{cases}K(r)&2\le K(r),\\c&K(r)<2,\end{cases}\qquad
r_{j+1}=r_j+\left(\frac{\eta_j+\tau(r_j)}{1+r_j}\right)^{-1}.
\]

The recurrence is defined, not supplied as a contraction hypothesis. Prove:

1. Every update has positive step variance and strictly increases precision;
   all successor precisions are positive. `K` along the recurrence is at least
   one and nonincreasing. Once below two, it remains strictly below two.
2. If `(4/5)^M * K(r₀) < 2`, then `K(r_M) < 2`.
3. With `ρ=2c/(1+2c)`, for every N,
   `0 < (r_(M+1+N))⁻¹ ≤ 2c * ρ^N`.
   Thus every positive terminal threshold B is attained in finite depth.

The `+1` is required even when M=0: r₀=0 represents A₀=∞, not real inverse
zero. All reciprocals interpreted as finite variance are guarded by positivity.

## Proof and existing dependencies

Write b=κ⁻¹. From κ≥1 obtain 0<b≤1. For 0≤r≤s, cross multiplication
reduces K(s)≤K(r) to `(s-r)(1-b)≥0`. For t=η+τ>0, the update satisfies

\[
K\left(r+\left(\frac{t}{1+r}\right)^{-1}\right)
=K(r)\frac{t+1}{t+K(r)}.
\]

If K(r_M)≥2, monotonicity forces every earlier stage into the large branch.
`RecursiveCondition.contraction_bounds` then yields the contradictory bound
K(r_M)≤(4/5)^M K(r₀)<2. Thereafter the branch is c forever.
`RecursiveVariance.variance_update_bounds` yields the first finite bound 2c,
then geometric contraction at all later steps. Reuse Mathlib's `le_geom` and
`exists_pow_lt_of_lt_one` rather than reproving geometric sequence convergence.

The actual Gibbs-law consumer uses `RGOCalculus.rgo_calculus` with the identical
step variance, precision and center update. It does not assume a normalizer,
integrability or a probability-law premise. Keep that analytic import in the
consumer test; the parameter proof itself needs no Gibbs integration library.

## Audit and remaining boundary

The independent read-only route reviewer `recursive_route_audit` confirmed this
route on 2026-09-10. This was a mathematical planning review, not a compiler,
source-blind decoder or commit-admission review.

κ≥1 comes from the source's α≤β. The weaker κ>0 premise of the existing
calculus interface does not suffice for this monotonicity argument. The branch
threshold is strict at entry: K=2 still takes the large branch. The source
suppresses the persistence argument and the infinite-initial-variance case;
both are explicit here. The result is pathwise for any admissible smoothing
sequence, including realized adaptive sequences, but does not assert their
measurability or construct a stochastic sampler.

Not established by this packet: the exact logarithmic schedule constants in
(6.4), FORS correctness/work, recursive probability errors, actual-input query
costs, or either complete paper. Those remain separate theorem obligations.
