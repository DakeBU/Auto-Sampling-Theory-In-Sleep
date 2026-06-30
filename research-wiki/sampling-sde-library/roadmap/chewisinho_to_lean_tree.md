# Chewisinho-To-Lean Foundation Roadmap

Generated: `2026-07-01 00:45:39`

Reference PDF: `https://chewisinho.github.io/main.pdf`

Local primary copy: `/home/nitanda_sub/mark/repos/outer_papers/sampling_theory_sde/Chewi-Log-Concave-Sampling/main.pdf`

Local legacy mirror: `/home/nitanda_sub/mark/repos/outer_repos/sampling_theory_sde/chewisinho-stochastic-processes-main.pdf`

This roadmap is not a theorem dependency.  It is a textbook-to-Lean planning
map.  Textbook statements are often intentionally informal; ASTIS agents must
turn them into small theorem contracts with hidden regularity assumptions before
assigning lower Lean work.  The matching visual ledger is
`research-wiki/lemma-dags/Chewi_log_concave_sampling_foundation.md`.

## Roadmap

| Textbook source | Target Lean family | First small leaf | Status | Reviewer warning |
| --- | --- | --- | --- | --- |
| 1.1 stochastic calculus | Ito/quadratic-variation/Taylor local-error subtree | quadratic variation normalization and finite-dimensional Ito test identity | partial-local-compiled | reuse shared roots MEAS, GAUSS, REG; create a separate subtree when the theorem becomes active |
| 1.2 Markov semigroups | semigroup -> generator-domain -> weak-test derivative subtree | semigroup test-function pairing under generator-domain hypotheses | planned | reuse shared roots MEAS, SDE, REG; create a separate subtree when the theorem becomes active |
| 1.3 optimal transport geometry | couplings -> Wasserstein distance -> geodesic convexity subtree | law-map/coupling measurable pushforward interface | planned | reuse shared roots MEAS, CONV, REG; create a separate subtree when the theorem becomes active |
| 1.4 Langevin as gradient flow | Gibbs density -> generator -> KL/FI dissipation -> WGF contract | finite-measure bounded-below and finite-dimensional quadratic-Lebesgue Gibbs normalization compiled; Langevin generator invariant Gibbs law contract remains | quadratic-gibbs-envelope-compiled | reuse shared roots DENS, FI, SDE, REG; create a separate subtree when the theorem becomes active |
| 2 functional inequalities | PI/LSI/TI/isoperimetry plus preservation-operation subtrees | log-concavity plus Prekopa-Leindler preservation audit | partial-local-compiled | reuse shared roots CONV, DENS, FI, REG; create a separate subtree when the theorem becomes active |
| 3 stochastic analysis topics | Girsanov -> Doob transform -> Follmer drift -> Schrodinger bridge | finite-dimensional Gaussian Esscher density, stdGaussian inner-product form, cylindrical Girsanov integral, and RN/withDensity identity compiled; full Brownian path packaging remains | finite-girsanov-rn-cylinder-compiled | reuse shared roots PATH, DENS, SDE, REG; create a separate subtree when the theorem becomes active |
| 4 Langevin Monte Carlo | coupling/interpolation/convex-optimization/Girsanov proof subtrees | LMC interpolation weak-test law derivative under domination | partial-local-compiled | reuse shared roots MEAS, KERN, SDE, DENS, REG, DISC; create a separate subtree when the theorem becomes active |
| 5 faster low-accuracy samplers | randomized midpoint, HMC, underdamped generator subtrees | Hamiltonian/underdamped transition-kernel regularity contract | planned | reuse shared roots GAUSS, SDE, DISC, REG; create a separate subtree when the theorem becomes active |
| 6 Renyi divergence | Renyi density algebra -> interpolation/Girsanov derivative subtrees | Renyi density algebra with positivity and finite-integral contracts | first algebra leaves compiled | reuse shared roots DENS, FI, SDE, REG; create a separate subtree when the theorem becomes active |
| 7 high-accuracy samplers | rejection/MH/MALA kernels, detailed balance, warm-start subtrees | proposal/acceptance Markov-kernel mass and reversibility contract | planned | reuse shared roots KERN, DENS, DISC, REG; create a separate subtree when the theorem becomes active |
| 8 proximal sampler | restricted Gaussian oracle -> conditional laws -> proximal transition subtree | restricted Gaussian conditional law and convex potential contract | planned | reuse shared roots CONV, GAUSS, KERN, DISC, REG; create a separate subtree when the theorem becomes active |
| 9-12 lower bounds, structure, non-log-concave, diffusion models | consumer subtrees after core log-concave foundation stabilizes | source-specific leaf only after shared roots are compiled | deferred-consumer | reuse shared roots MEAS, DENS, SDE, PATH, DISC, REG; create a separate subtree when the theorem becomes active |

## Agent Protocol

1. Start with Mathlib search and the current ASTIS arsenal.
2. If a textbook claim is useful, decompose it into one local theorem packet.
3. State measurability, integrability, continuity, nonemptiness, boundedness,
   domination, and boundary assumptions explicitly.
4. Use external Lean projects such as `lean-stat-learning-theory` and
   `lean-rademacher` as reference memory only; callable lemmas must be
   ASTIS-owned declarations that build locally.
5. If a packet fails repeatedly, audit the mathematical statement instead of
   changing the proof script.

## Current Priority

Do not attempt to formalize the whole textbook in one pass.  The next reusable
growth path is:

- lock the shared-root taxonomy (`MEAS`, `KERN`, `DENS`, `GAUSS`, `CONV`,
  `FI`, `SDE`, `PATH`, `DISC`, `REG`);
- extend the compiled log-concavity API toward density/Gibbs interfaces
  and finish the Prekopa-Leindler port audit;
- generalize existing law-map, conditional-kernel, Gaussian, KL, weak-generator,
  and LSI bookkeeping leaves away from SALD-specific naming;
- add one subtree per Chewi chapter/theorem only when it reuses shared roots;
- keep algorithm theorems as consumers until their root leaves compile locally.
