# Actual full-batch query tail

For the same actual bounded Poisson rejection attempt and retry law as PoissonRejection, every fixed B>0, input parameter s and 0<delta<1, set L=log(2/delta), m=ceil(exp(2B)*L). Prove that the actual full-batch accumulated estimator-call count C, including the successful attempt, satisfies P(C>2B*(exp(1)-1)*m+L)<=delta. Derive a single-logarithmic upper threshold at fixed bounded B with an explicit constant. Use the actual previous-failure events and fixed-prefix Poisson sums; do not assume stopping/count independence or transfer costs by TV proximity.

This is a separately proved valid full-batch tail contract, not the unrestricted printed Theorem2.3 threshold 3B exp(2B) log(2/delta), which has a source-audited small-B counterexample. Preserve the printed source and record that discrepancy. Fixed auxiliary law, fixed B>0, jointly measurable everywhere bounded estimator remain explicit. Clipping, concrete gradient estimator, target/Renyi accuracy, initialization and gradient calls per estimator are separate obligations. No claim that this tail proof completes FORS or a paper main result.

# Independent source dependency audit: full-batch query tails

State: source-audited mathematical observation, not a Lean counterexample or admitted repair.
Reviewer: log_depth_source_review; root transcribed the independent response.

Primary: https://arxiv.org/html/2608.05022v1 Algorithm 1 / Theorem 2.3.
The printed statement bounds full-batch estimator queries by
3 B exp(2 B) log(2/delta), at probability at least 1-delta, for input B>0.
The surrounding source gives no lower bound B>=1, rounding or additive-one convention.

The actual cost C is at least the first count N0~Poisson(2B), pathwise, regardless of W.
For B=0.01 and delta=0.001, the printed threshold is approximately 0.2326335<1,
but P(C>threshold)>=P(N0>=1)=1-exp(-0.02)=0.0198013>delta.
Even ceiling or adding one is insufficient uniformly: at delta=1e-6 the threshold
is about 0.44405, while P(N0>=2)=1-exp(-0.02)*(1+0.02)=0.000197353>delta.
Classification: possible-source-error in the unrestricted printed full-batch tail contract.
Do not silently add a lower bound on B or reinterpret integer query counts.

This does not affect the already accepted bounded-mechanism expected cost 2B/p<=2B exp(2B),
nor does it by itself refute the terminal consumer. SPHMC A.4(2),
https://arxiv.org/html/2609.06906v1#A1.SS2, requires constant expected gradient cost
and C log(2/p) high-probability cost (not merely a log-squared guarantee).
Its external D.1, https://arxiv.org/html/2602.01338v1, works with B=Theta(1).
An independently proved fixed-B single-log bound is therefore the relevant route.

Proposed new contract, not a source modification:
For 0<delta<1, L=log(2/delta), m=ceil(exp(2B)*L), prove

P(C > 2B*(exp(1)-1)*m + L) <= delta.

Proof route: the actual first m failures have probability at most delta/2 by the
existing failure-prefix formula and p>=exp(-2B). The actual deterministic prefix
S_m=sum_{j<m}N_j has exponential moment exp(2B*m*(exp(1)-1)), by independence of
the attempts and the Poisson generating series. Exponential Markov bounds
P(S_m>2B*m*(exp(1)-1)+L)<=delta/2. On success within m attempts, C<=S_m.
Union bound combines the events. No independence of the stopping time and N_j
is assumed. The additive L term handles small B and gives O(log(2/delta)) at
fixed bounded B. Each estimator call's gradient cost and actual target accuracy
remain separate obligations.

The next theorem packet must be proposed and publication packet emitted before new Lean.
