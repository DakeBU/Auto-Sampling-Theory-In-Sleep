# Discrete Sampling: source, shared foundations and conceptual boundaries

The sixth peer Library covers finite spin/configuration spaces, including Ising, hard-core and matroid bases. It uses the same reader, page factory, MathJax, unified graph and progress board as the other libraries. Source sections remain in book order; the formalization DAG is dependency-first. No new Lean completion is asserted by this integration.

## Source hierarchy and reproducibility

The controlling monograph is Chen–Štefankovič–Vigoda, **arXiv:2307.13826v4** (100 pages, twelve sections). The version is important: v1 has different title/authorship and scope. `Libraries/DiscreteSampling/source-map.json` records all 72 subordinate TOC entries and both versioned URL and SHA256. PDF page numbers equal printed page numbers. Verify a retrieved copy with:

```sh
python3 website/scripts/discrete_sampling.py --pdf /path/to/2307.13826v4.pdf
```

Pal–Mesikepp, **arXiv:2510.14165v1**, is the beginner companion (246 pages; fingerprint recorded). The classic *Markov Chains and Mixing Times* is a background reference, not claimed to have an arXiv edition. As with the other books, use a precise additional theorem only when a concrete proof detail is missing; document the hypothesis/normalization adapter rather than replacing the source target.

**Section 12 explicitly omits proofs.** Its zero-field Ising model definition (p.90) is safe to pull forward, but each rate requires the corresponding cited original paper. In particular, the book's weight `exp(2 beta m(sigma))` and `exp(beta sum sigma_i sigma_j)` differ by a state-independent factor. That is a small normalization adapter, not permission to add external fields or change the parameter regime.

## Shared proof structure

The first producer cells should normalize finite Gibbs weights and prove heat-bath detailed balance. Reuse the existing state-neutral kernel algebra and the generic generator form `-∫ f Lg dπ`. The finite pair-sum representation is a theorem to prove, not a second definition of Poincaré/entropy. `route-plan.json` lists the actual existing local module and declaration candidates. A source-present candidate is not a claim that its current type already accepts a finite chain.

The finite kernel, pinning and reversible-form nodes have no dependency on SDE construction, Itô calculus, continuous-space gradients, Riemannian geometry or Brenier theory. Matrix facts, coupling composition, scalar recurrence/Grönwall, variances and entropy can be shared when their types and assumptions match. Spectral independence and model-specific comparisons remain separate downstream statements.

## Normalizations a contributor must retain

For a finite reversible row-stochastic kernel P and positive invariant probability π, let L=P-I. Define

\[
\mathcal E_P(f,g)=\frac12\sum_{x,y}\pi(x)P(x,y)(f(y)-f(x))(g(y)-g(x)).
\]

For the continuous-time density evolution `r_t = dρ_t/dπ`, normalized by `π(r_t)=1`, a Poincaré bound `E_P(f,f) ≥ λ Var_π(f)` combines with `dχ²/dt = -2 E_P(r_t,r_t)` to give rate `2λ`. By contrast, powers `P^k` need control of negative eigenvalues, for example through laziness or an absolute spectral gap. A per-site rate-one generator is `n(P-I)` rather than `P-I`, so its constants are rescaled.

For positive densities, the modified-LSI convention here is

\[
\mathcal E_P(r,\log r)\geq\alpha\operatorname{Ent}_\pi(r),
\qquad -\frac d{dt}\operatorname{Ent}_\pi(r_t)=\mathcal E_P(r_t,\log r_t).
\]

This gives continuous-time rate α, assuming the exact dissipation identity/domain. The existing generic `Generator.SatisfiesLogSobolev` uses `Ent ≤ (C/2) E(r,log r)`; a compatible convention adapter is `α=2/C`. Ordinary LSI, jump MLSI, and discrete one-step entropy contraction are not synonyms. In particular the diffusion chain-rule identity `E(r,log r)=4E(sqrt r,sqrt r)` is generally not an equality for a jump kernel.

These displayed identities are natural-language orientation for future formalization, not new Lean proofs. Sources are the controlling monograph §§3 and 6.8, Chewi's generator formulations, and the papers below.

## Conceptual memory and admission

The new source-backed proposal families connect finite Poincaré/χ² to shared L2 coercivity, jump MLSI to gap/dissipation, conditional covariance to log-partition curvature, and Hamming/W1 couplings to the generic coupling core. A Hessian **upper** covariance bound is not a strong-convexity **lower** bound. Influence matrices require source-specific diagonal normalization and bounds under all feasible pinnings, not only one unconditioned matrix.

For geometry, [Maas, arXiv:1102.5238v2](https://arxiv.org/abs/1102.5238v2) constructs a logarithmic-mean, chain-dependent transport metric in which a finite irreducible reversible Markov semigroup is an entropy gradient flow. [Erbar–Maas, arXiv:1111.2687v2](https://arxiv.org/abs/1111.2687v2) studies entropy curvature in that metric. It is **not** ordinary W2 on graph distance or Fisher–Rao geometry; an Ising potential has no automatic continuum Hessian interpretation. A bottleneck for a specified Glauber chain likewise is not an all-algorithm oracle lower bound of the SampleWiki route.

New bridges stay `review.state=candidate`, hidden from the default atlas but available with **Show pending conceptual proposals** or an explicit inspector click. The existing mandatory schema-v3 SAU mirror audit remains in force. An independent actor must check the actual sources, hypothesis/conclusion maps and failure boundaries before admission; the renderer's data validation is not that mathematical review. All current bridges remain `not-Lean-certified` even after conceptual acceptance.

The Overview displays source/route topology; the Functor atlas displays conditional idea maps; the Lean view alone displays actual compiled proof dependencies. Source scaffolds, route nodes and dashed reuse-search links must never increase theorem completion counts.
