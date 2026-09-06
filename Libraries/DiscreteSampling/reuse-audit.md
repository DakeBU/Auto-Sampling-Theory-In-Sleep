# Discrete Sampling: focused reuse audit

This additive audit preserves the canonical sixth Library and stable bridge IDs from PR #242. It does not replace the source map, route or acceptance schema. Machine-readable retrieval: [reuse-audit.json](reuse-audit.json). Source inspection is at commit `4424c0d76926b943e8f55fbd5e2bf52fa3cda3f4`; recheck actual pinned types before reuse. No new Lean proof or independent conceptual review is asserted.

## Kernel algebra is already state-neutral

`TechnicalLemmas/StochasticProcesses/MarkovSemigroup.lean` defines `TransitionKernelContract` on a general measurable state space, with zero-time identity and Chapman--Kolmogorov. Its operator lemmas are promising shared nodes. The time index is nonnegative real time: one still has to construct the finite continuous-time semigroup and its matrix/kernel bridge. Discrete powers P^k, continuity, generators and domains are not obtained merely by mentioning this structure.

## Reuse the generator form, prove the finite adapter

`TechnicalLemmas/FunctionalInequalities/Generator.lean` already defines the form `-integral f * Lg d pi`, centered variance and the generator Poincare condition. The missing finite adapter is a separate theorem: for a reversible row-stochastic P and invariant positive probability pi, identify L=P-I and prove equality with the weighted pair sum. The gap convention is lambda=1/C when the existing interface says Var <= C E. This avoids an Ising-specific duplicate of the generic probability/Dirichlet floor.

## Important obstruction: zeros in the density-entropy domain

The same file's `SatisfiesLogSobolev` has the displayed density inequality `Ent <= (C/2) E(r,log r)`. For **strictly positive normalized densities**, its coefficient corresponds to modified LSI alpha=2/C. However, `LogSobolevAdmissible` permits **nonnegative** densities and uses totalized `Real.log 0 = 0`. Thus matching the formula and constant is not enough to claim an equivalence with the standard finite-chain MLSI.

The zero convention is appropriate in the product r log r. It is not automatically appropriate inside the nonlocal jump generator applied to log r. Here is a concrete audit witness (ordinary mathematics, **not a Lean certificate**). Take uniform pi on three states, density r=(0,1/2,5/2), and

```text
P = [1/2, 1/2,       0;
     1/2, 49/100, 1/100;
       0, 1/100, 99/100].
```

P is stochastic, symmetric, irreducible and aperiodic, and pi(r)=1. Substituting totalized log into the pair form gives

```text
E_P(r,log r) = -log(2)/12 + log(5)/150 < 0,
Ent_pi(r)   = (5 log(5) - 6 log(2))/6 > 0.
```

The signs follow from 5 < 2^3 and 5^5 > 2^6. Consequently this interpretation cannot satisfy a positive-constant entropy bound on all these admissible nonnegative densities. This is a **domain/representation mismatch**, not evidence that the usual finite-chain MLSI is false.

Before an adapter is accepted, open a shared domain/semantic cell to either provide the correct positive-density interface or justify a limiting/extended-valued dissipation treatment at zeros. Prove any required extension from positive densities to the intended source domain; record source hypotheses and repairs. Do not silently change `Generator.lean`, strengthen the original source statement, or declare the existing quantified interface equivalent to standard MLSI. Positive-time smoothing also requires its own proof and initial-time limiting argument.

This boundary belongs with `transport:discrete-mlsi`; it is not a new certified transport edge. Existing mirror/source review and independent stabilization gates remain in force.

## Optional arXiv primer for missing elementary details

Soumik Pal and Tim Mesikepp, *Finite Markov chains and Monte-Carlo Methods: An Undergraduate Introduction*, [arXiv:2510.14165v1](https://arxiv.org/abs/2510.14165v1), is a 246-page introductory companion. The downloaded version and SHA256 are recorded in the JSON audit. It complements, not replaces, the controlling Chen--Stefankovic--Vigoda monograph and the already registered LPW/Ising background sources. A contributor must still identify the exact theorem and adapter needed for each missing proof step.
