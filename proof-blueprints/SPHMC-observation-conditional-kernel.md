# Actual observation-conditioned retained-state kernel

SPHMC arXiv:2609.06906v1 Algorithm3.3 and Section6.3 after (6.5)

Construct the jointly measurable conditional retained-state kernel given the actual noisy observation. Identify its observation marginal as Gaussian smoothing of actual M, retain the pre-noise initialized GD reference, and factor the actual remaining output through this disintegration. Prove conditional precision and center support.

Supplied actual Markov M has no accuracy or moment guarantees. The observation does not determine the retained GD reference. No projection to an autonomous observation-only chain, no marginal KL transfer to the full pre-noise joint law, no final mixed-output error or accumulated cost theorem.

# Next route: actual observation-conditioned retained-reference kernel

Planning only; EnhancedTerminalExecution publication/admission remains current packet. Independent log_depth_source_review selected the next real consumer from SPHMC Section6.3 after(6.5).

The noisy observation y=x+sqrt(tau_s/beta_s)*z does not determine the retained reference, whose GD initialization uses pre-noise x. Subsequent M and eta may depend on that reference. Therefore neither a y-only deterministic update nor an observation-marginal KL bound on the full(x,z) law is legitimate.

Construct the actual joint kernel J_s=law(y,update(s,x,z)) under M_s times freshGaussian. Identify Q_s=J_s.fst as Gaussian smoothing of the actual M_s. Construct jointly measurable Markov C:(s,y)->s' with J=Q compProd C; show updated precision/center are the source deterministic functions of(s,y) almost everywhere while retaining the actual reference. For actual remaining output R, prove execution output equals Q_s[C_s R]. No approximation/cost hypothesis or conclusion at this stage. This enables later conditional-kernel KL propagation; it is not the final error theorem.

Root targeted pinned-Mathlib check: Probability/Kernel/Disintegration/StandardBorel.lean lines397-417 defines Kernel.condKernel for finite J:Kernel alpha(beta*Omega), Omega StandardBorel and Nonempty, and CountableOrCountablyGenerated alpha beta. It supplies IsMarkovKernel and IsCondKernel automatically. Kernel.disintegrate gives J.fst compProd J.condKernel=J. For current application alpha=fullstate,beta=E,Omega=fullstate; beta countably generated and fullstate StandardBorel must be actually instantiated from finite-dimensional Borel E and the countable history product. This is a parameterized disintegration API, not merely separate per-state conditional existence.

Actual parents to audit next: ReferenceCarryingKernel update, EnhancedTerminalExecution actualP and Lt composed P^n, Gaussian smoothing law. FiniteRGOKLError has future chain-rule/projection techniques but its old state cannot substitute for the retained-reference state. Actual M/Picard accuracy, final mixed-output error and cumulative GD/stage costs remain distinct.

Additional targeted root reuse check: TechnicalLemmas/Measure/GaussianSmoothing.lean defines GaussianSmoothing.gaussianSmoothing(mu,sigma)=CommonNoiseContraction.addNoise mu (stdGaussian.map(sigma smul)); hence actual observation-marginal identity should follow by product pushforward/map_map, without importing a transport inequality as an assumption. It requires SecondCountableTopology E, available from the actual finite-dimensional setting but to be instantiated in Lean. The sigma used is sqrt(tau_s/beta_s), not total eta+tau variance.

Root API-only Lean reconnaissance .astis/ObservationConditionalAPI.lean finished session42402 exit0: StandardBorelSpace fullstate synthesizes as StandardBorelSpace.prod; MeasurableSpace.CountableOrCountablyGenerated fullstate E synthesizes from CountablyGenerated. Kernel.condKernel and Kernel.disintegrate signatures match the planned parameterized joint law. This file contains only imports/variables/#synth/#check, no new theorem or proof-admission claim. Kernel.fst_apply (MapComap.lean414) identifies its fiber as map Prod.fst.
