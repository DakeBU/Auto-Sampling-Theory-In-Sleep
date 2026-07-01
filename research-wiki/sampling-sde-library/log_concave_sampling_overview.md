# Log-Concave Sampling Lean Organization

Generated: `2026-07-02 02:55:25`

Primary source: `https://chewisinho.github.io/main.pdf`

Local source: `/home/nitanda_sub/mark/repos/outer_papers/sampling_theory_sde/Chewi-Log-Concave-Sampling/main.pdf`

The Lean repository is organized as a reusable mathematical library, not as a
line-by-line encoding of one proof.  Each textbook chapter is mapped to shared
proof roots, and each root is built from small lemmas that can plausibly become
Mathlib-style contributions.

## How To Read The Library

- Blue nodes in the status tree are compiled local Lean leaves or modules.
- Red nodes are missing mathematical infrastructure with a named target file.
- Shared roots (`MEAS`, `KERN`, `DENS`, `GAUSS`, `CONV`, `FI`, `SDE`, `PATH`,
  `DISC`, `REG`) are reused across chapters so the library does not duplicate
  the same measure-theory, convexity, Gaussian, or SDE lemmas for each sampler.
- Algorithm chapters should be consumers.  They should call the shared roots
  after those roots compile locally.

Main visual ledger:
`research-wiki/lemma-dags/log_concave_sampling_foundation.md`

Rendered status tree:
`docs/assets/log_concave_sampling_status.svg`

## Chapter-By-Chapter Map

| Part | Chapter | Summary | Lean organization plan | Shared roots | Status |
| --- | --- | --- | --- | --- | --- |
| Part I | 1. Langevin diffusion in continuous time | The continuous-time backbone: stochastic calculus, Markov semigroups, optimal-transport geometry, Langevin dynamics, and convergence viewpoints. | Build reusable interfaces for Gaussian increments, weak generators, semigroups, Gibbs invariant laws, KL/FI dissipation, and Wasserstein-gradient-flow contracts. | MEAS, GAUSS, DENS, FI, SDE, REG | partial-local-compiled |
| Part I | 2. Functional inequalities | The inequality toolkit that turns geometry of the target into convergence rates: PI, LSI, transport, concentration, isoperimetry, and preservation operations. | Separate definitions and bookkeeping from preservation theorems; reuse log-concavity, Prekopa-Leindler/Brunn-Minkowski, and LSI/KL/FI leaves. | CONV, DENS, FI, REG | partial-local-compiled |
| Part I | 3. Stochastic analysis topics | Path-space tools used repeatedly later: quadratic variation, Girsanov change of measure, Doob transforms, Follmer drift, and Schrodinger bridges. | Keep finite-dimensional Gaussian change of measure as the compiled base; only then lift to Brownian/path-space RN derivatives and bridge transforms. | GAUSS, PATH, DENS, SDE, REG | finite-girsanov-rn-cylinder-compiled |
| Part II | 4. Analysis of Langevin Monte Carlo | The first algorithmic convergence chapter, presenting coupling, interpolation, convex-optimization, and Girsanov proof routes for LMC. | Treat LMC as a consumer of law-map, conditional-kernel, weak-FP, KL/FI, Girsanov, and Gaussian-transition geometry leaves. | MEAS, KERN, SDE, DENS, PATH, DISC, REG | partial-local-compiled |
| Part II | 5. Faster low-accuracy samplers | Randomized midpoint, Hamiltonian Monte Carlo, and underdamped Langevin methods, organized around better discretizations and dynamics. | Delay algorithm theorems until transition kernels, Hamiltonian/underdamped generators, and Gaussian-noise update contracts are local. | GAUSS, SDE, DISC, REG | planned |
| Part II | 6. Convergence in Renyi divergence | Stronger divergence control for LMC and underdamped methods, using interpolation and Girsanov routes. | Extend compiled Renyi integrand algebra toward full divergence, log-normalizer, and path-derivative contracts. | DENS, FI, SDE, PATH, REG | first algebra leaves compiled |
| Part II | 7. High-accuracy samplers | Rejection sampling, Metropolis-Hastings filters, discrete-time Markov chains, and MALA cold/warm start analyses. | Formalize proposal kernels, acceptance probabilities, reversibility/detailed balance, and warm-start density comparisons after kernel infrastructure is stable. | KERN, DENS, GAUSS, DISC, REG | planned |
| Part II | 8. Proximal sampler | Restricted Gaussian oracles and proximal transitions, with convergence under strong log-concavity, log-concavity, and functional inequalities. | Use two-point Gaussian/proximal kernel log-concavity as the compiled start; add restricted Gaussian conditional laws and time-reversal flow interfaces. | CONV, GAUSS, KERN, FI, DISC, REG | kernel-geometry-compiled |
| Part II | 9. Lower bounds for sampling | Oracle/query lower bounds in one dimension, constant dimension, and Gaussian families. | Treat as a consumer of oracle models, information lower bounds, Gaussian comparison, and dimension-specific construction lemmas. | MEAS, GAUSS, DENS, DISC, REG | deferred-consumer |
| Part II | 10. Structured sampling | Sampling with stochastic gradients, coordinate methods, and mirror Langevin geometry. | Introduce oracle/noisy-gradient and coordinate-update interfaces only after base kernels and mirror-geometry assumptions are explicit. | MEAS, CONV, SDE, DISC, REG | deferred-consumer |
| Part II | 11. Non-log-concave sampling | Approximate stationarity and nonconvex behavior controlled through Fisher information bounds and applications. | Reuse FI, KL, weak-FP, and score/Fisher algebra; do not assume convexity roots unless the theorem explicitly requires them. | DENS, FI, SDE, DISC, REG | deferred-consumer |
| Part II | 12. Diffusion generative models | Score matching and discretization analysis for diffusion generative modeling. | Use path-space change of measure, score-drift regularity, weak-FP, and discretization leaves after the SDE/PATH foundation is mature. | MEAS, DENS, SDE, PATH, DISC, REG | deferred-consumer |

## Current Compiled Foundation

- Positive log-concavity, products, powers, pullbacks, superlevel geometry, and
  negative-log potential convexity live in
  `AutoSamplingTheory/TechnicalLemmas/Geometry/LogConcavity.lean`.
- Gibbs density, finite-measure lower-bound envelopes, exact finite-dimensional
  quadratic normalizers, and normalized withDensity probability bridges live in
  `AutoSamplingTheory/TechnicalLemmas/Measure/Gibbs.lean` and
  `AutoSamplingTheory/TechnicalLemmas/Analysis/Integrability.lean`.
- Product Gaussian linear forms, moment-generating normalizers, Esscher shifts,
  finite-dimensional change of measure, and Euclidean `stdGaussian` bridges
  live in `AutoSamplingTheory/TechnicalLemmas/ProbabilityDistributions/Gaussian.lean`.
- KL/DV/Renyi algebra, LSI bookkeeping, weak generator, weak-FP algebra, and
  finite-dimensional Girsanov cylinders are compiled as reusable support.

## Immediate Library Boundary

The next high-value roots are:

1. `CONV/MEAS`: finite-dimensional Prekopa-Leindler and Brunn-Minkowski
   interfaces, using `Lean-Asymptotic-Statistical-Theory/ForMathlib` as a
   reference but porting only small local leaves.
2. `DENS/CONV`: nonquadratic coercive Gibbs envelopes for Lebesgue targets.
3. `SDE/DENS/FI`: invariant Gibbs law and KL/FI dissipation for Langevin.
4. `PATH/GAUSS`: Brownian/path-space change of measure beyond finite
   cylinders.
5. `DISC`: LMC/MALA/HMC/proximal samplers only after the above roots are local.

## Rigor Contract

Whenever the textbook uses a standard analytic phrase such as Fokker-Planck,
Girsanov, integration by parts, regularity assumptions, or invariant measure,
the Lean plan must expose the hidden assumptions: measurability,
integrability, domination, differentiability, boundary decay, positivity, and
representative choices.  Unsupported assumptions are recorded as red proof
obligations rather than being silently added to close a theorem.
