# SPHMC Lemma6.2 actual truncation proxy

Construct an optimal actual coupling for continuous nonnegative cost using existing weak compactness and lower semicontinuity. For the true infimum cost of norm(x-y)^p, real p>=2, prove SPHMC Lemma6.2 in cost-input/bounded-coupling form: cost<=r^p, r>=0, 0<delta<1 yields an actual proxy probability Pdag with eventwise TV(P,Pdag)<=delta and an actual coupling of Pdag,Q concentrated on displacement<=r delta^(-1/p). Prove measurability, pushforward probabilities/marginals, Markov budget and zero-radius case; do not assume an optimal or good coupling.

Exact infimum p-cost and actual bounded-displacement proxy construction, the content of Lemma6.2 without introducing a full Wp metric-space API. No Gaussian reverse transport, Renyi warmness, sampler construction, recursive error/cost propagation, unbounded-cost transfer or full-paper conclusion.

The independent route comparison favors this dependency-ready probability edge over PBPS local elliptic regularity. PBPS weak derivative, H2/core and Bochner extension frontiers stay open and unchanged. This is an independent input to the recursive A2 error proof, not a consequence of scalar recursion depth.

Use compact probabilityCouplingSet, nonempty product witness, and LowerSemicontinuousOn.exists_isMinOn applied to the continuous NNReal norm-power cost. Identify the minimum with the raw Transport.transportCost by the probability/raw equivalence and sInf bounds. No optimizer premise. For positive r use t=r delta^(-1/p), replace the first coordinate by the second on displacement>t, prove all maps and probability couplings, eventwise TV via bad-event inclusion and Markov. For r=0 derive zero cost and diagonal a.e.; no division by zero. Wp input means its exact infimum p-cost, and Winfinity output means an actual bounded-displacement coupling. No new metric-space axioms.

Both bounded publication packets were emitted before Lean development. Root remains sole writer. Resolvent PR258 has merged and released stabilization. The two substantive production theorems and axiom test passed focused compilation and independent replay (2621 jobs); complete proof review and anonymous reconstruction passed. Current status is PROVED_LOCAL; formal source and fixed-commit admission, aggregate and rendered delivery remain separate.

Independent source review reminder: finite displacement p-cost does not imply finite individual marginal p-moments. Any later Lemma6.3(ii) consumer using the source P_p premise must supply it independently. Current truncation theorem makes no such claim.
