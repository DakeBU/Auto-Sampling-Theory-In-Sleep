# Chewi Log-Concave Sampling

- Public PDF: https://chewisinho.github.io/main.pdf
- Local primary PDF: `/home/nitanda_sub/mark/repos/outer_papers/sampling_theory_sde/Chewi-Log-Concave-Sampling/main.pdf`
- Local legacy mirror: `/home/nitanda_sub/mark/repos/outer_repos/sampling_theory_sde/chewisinho-stochastic-processes-main.pdf`
- Role: primary roadmap for `ASTIS-CHEWI-001`, the log-concave sampling
  foundation program.

Chewi is now the organizing textbook for ASTIS's reusable Sampling/SDE Lean
arsenal.  SALD and RMFLD should be treated as downstream consumers of this
foundation, not as the reason for every local technical lemma.

## Chapter-To-Lean Families

| Chewi part | ASTIS Lean family |
|---|---|
| Stochastic calculus primer | `TechnicalLemmas/StochasticProcesses/Ito`, quadratic variation, martingale and weak-generator leaves |
| Markov semigroups | `TechnicalLemmas/StochasticProcesses/MarkovSemigroup`, invariant-measure and generator interfaces |
| Optimal transport geometry | `TechnicalLemmas/Measure/Transport` and Wasserstein gradient-flow contracts |
| Langevin as Wasserstein gradient flow | `TechnicalLemmas/StochasticProcesses/Langevin` plus KL/FI dissipation leaves |
| Functional inequalities | `TechnicalLemmas/FunctionalInequalities/*` for PI, LSI, transport, concentration, isoperimetry, and preservation operations |
| Change of measure, Doob transform, Follmer drift, Schrodinger bridge | `TechnicalLemmas/StochasticProcesses/Girsanov`, `DoobTransform`, `FollmerDrift`, and path-space RN derivative leaves |
| LMC and interpolation arguments | `SamplingAlgorithms/LangevinMonteCarlo` plus weak-FP, interpolation, and discretization-error leaves |
| HMC, underdamped, MALA, proximal sampler | `SamplingAlgorithms/*` consumers built only after the analytic foundation is local |
| Diffusion generative models | future consumer layer after path-space and score-drift leaves exist |

## Rigor Policy

The notes are a roadmap, not a Lean certificate.  Every extracted statement
must become one of:

- an ASTIS-owned compiled Lean declaration;
- an explicit `ProofObligation` with source anchor and hidden regularity
  contract;
- a cited-result memory card tied to a primary source;
- a rejected statement if the Lean assumptions would silently strengthen or
  change the textbook claim.

Do not import informal textbook shortcuts as assumptions.  For phrases such as
"standard", "by Fokker--Planck", "by Girsanov", "by integration by parts", or
"under regularity assumptions", agents must expose the exact measurability,
integrability, differentiability, boundary/decay, positivity, and
representative-choice hypotheses before lower proof work starts.
