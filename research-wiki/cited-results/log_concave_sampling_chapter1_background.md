# Chapter 1 Background Sources

Primary source:

- Sinho Chewi, `Log-Concave Sampling`, Chapter 1.
- Public PDF: https://chewisinho.github.io/main.pdf
- Local PDF: `/home/nitanda_sub/mark/repos/outer_papers/sampling_theory_sde/Chewi-Log-Concave-Sampling/main.pdf`

## Active Source Contract

| Anchor | Informal role | Formalization boundary |
|---|---|---|
| Section 1.1 opening | Stochastic-calculus proofs are sketches; the text refers readers to detailed treatments. | Ito/SDE leaves must recover omitted hypotheses from the cited texts or Mathlib. |
| Section 1.2 warning | Generator domains and symmetric versus self-adjoint operators are deliberately not developed. | Domain and semigroup statements remain separate red nodes. |
| Example 1.2.8 | The Langevin adjoint display uses an integration-by-parts equality. | Pointwise generator algebra and finite-box cancellation are blue; cutoff derivative estimates, tail passage, and whole-space weighted IBP are red. |
| Corollary 1.2.9 | The Gibbs density proportional to `exp(-V)` is identified as stationary. | This is not blue until both weighted IBP and generator/semigroup semantics are compiled. |
| Theorem 1.2.14 | Reversibility yields the fundamental integration-by-parts identity. | Reversibility is downstream of, and must not be used circularly to prove, the initial Gibbs stationarity claim. |

## Textbooks Cited By Chapter 1

| Citation in the textbook | Scope assigned by the textbook | ASTIS use |
|---|---|---|
| J. Michael Steele (2001), *Stochastic Calculus and Financial Applications* | stochastic calculus | detailed background for Brownian/Ito statements omitted from Section 1.1 |
| Grigorios A. Pavliotis (2014), *Stochastic Processes and Applications* | stochastic processes, Fokker-Planck and Langevin equations | source candidate for diffusion, Fokker-Planck, and Langevin analytic assumptions |
| Jean-Francois Le Gall (2016), *Brownian Motion, Martingales, and Stochastic Calculus* | stochastic calculus | detailed probability and stochastic-calculus background |
| Dominique Bakry, Ivan Gentil, and Michel Ledoux (2014), *Analysis and Geometry of Markov Diffusion Operators* | Markov semigroups, generator domains, functional inequalities | principal source candidate for the semigroup/domain/reversibility branch |
| Ramon van Handel (2016), *Probability in High Dimension* | Markov semigroups, concentration, functional inequalities | source candidate for semigroup and functional-inequality interfaces |

These citations are provenance and statement-audit sources.  They do not make a
node blue: ASTIS still requires a local compiled Lean declaration and registry
entry.
