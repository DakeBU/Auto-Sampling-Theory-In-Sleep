# SPHMC Lemma6.2 actual truncation proxy

Construct an optimal actual coupling for continuous nonnegative cost using existing weak compactness and lower semicontinuity. For the true infimum cost of norm(x-y)^p, real p>=2, prove SPHMC Lemma6.2 in cost-input/bounded-coupling form: cost<=r^p, r>=0, 0<delta<1 yields an actual proxy probability Pdag with eventwise TV(P,Pdag)<=delta and an actual coupling of Pdag,Q concentrated on displacement<=r delta^(-1/p). Prove measurability, pushforward probabilities/marginals, Markov budget and zero-radius case; do not assume an optimal or good coupling.

Exact infimum p-cost and actual bounded-displacement proxy construction, the content of Lemma6.2 without introducing a full Wp metric-space API. No Gaussian reverse transport, Renyi warmness, sampler construction, recursive error/cost propagation, unbounded-cost transfer or full-paper conclusion.

The independent route comparison favors this dependency-ready probability edge over PBPS local elliptic regularity. PBPS weak derivative, H2/core and Bochner extension frontiers stay open and unchanged. This is an independent input to the recursive A2 error proof, not a consequence of scalar recursion depth.

Use compact probabilityCouplingSet, nonempty product witness, and LowerSemicontinuousOn.exists_isMinOn applied to the continuous NNReal norm-power cost. Identify the minimum with the raw Transport.transportCost by the probability/raw equivalence and sInf bounds. No optimizer premise. For positive r use t=r delta^(-1/p), replace the first coordinate by the second on displacement>t, prove all maps and probability couplings, eventwise TV via bad-event inclusion and Markov. For r=0 derive zero cost and diagonal a.e.; no division by zero. Wp input means its exact infimum p-cost, and Winfinity output means an actual bounded-displacement coupling. No new metric-space axioms.

Before any Lean development, both bounded publication packets must be emitted. Root sole writer, resolvent PR258 sole stabilization owner; no completed truncation result yet.
