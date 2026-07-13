# YuanheZ/lean-stat-learning-theory

- Public repository: https://github.com/YuanheZ/lean-stat-learning-theory
- Paper: https://arxiv.org/abs/2602.02285
- Local checkout: `/home/nitanda_sub/mark/repos/outer_repos/sampling_theory_sde/lean-stat-learning-theory`
- Current audited checkout: `216e578c9576bab6b0abc3ba6c65762536768e96`
  on `main`.  The last commit itself is a README edit, but the updated local
  checkout contains the current proof surface listed below.
- Latest verification: `git fetch --prune origin` on 2026-07-13 left local
  `HEAD` equal to `origin/main` at `216e578c9576bab6b0abc3ba6c65762536768e96`.
  The checkout has only untracked `.lake/` cache files, not source edits.  A
  full external `lake build` passed at this commit (8630 jobs).
- Role: audited port/reference source for probability, Gaussian,
  concentration, entropy duality, log-Sobolev/Poincare, product-measure
  slicing, matrix concentration, and discretization proof style.

ASTIS keeps this project as audited port/reference memory rather than a Lake
dependency because toolchains differ.  Useful theorems become callable only
after they are copied as ASTIS-owned Lean declarations and pass the local build,
or they remain recorded in the port queue.

## Current Useful Surfaces

| SLT file/family | ASTIS use |
|---|---|
| `SLT/EfronStein.lean` | coordinate replacement under product laws, especially `map_update_prod_pi` and integral rewrites for `Function.update` |
| `SLT/GaussianLSI/SubAddEnt/Basic.lean` | product-coordinate slice integrability and AE nonnegativity patterns such as `integrable_update_slice` |
| `SLT/GaussianLSI/SubAddEnt/Subadditivity.lean` | coordinate selection maps, tower properties, and entropy subadditivity staging |
| `SLT/GaussianLSI/SubAddEnt/Decomposition.lean` | entropy telescoping/decomposition patterns for product laws |
| `SLT/GaussianLSI/Entropy.lean` and `SLT/GaussianLSI/DualEntApp.lean` | entropy, Jensen, and Gibbs-duality proof patterns |
| `SLT/GaussianMeasure.lean` | `stdGaussianPi`, coordinate laws, independence, linear MGFs, and Gaussian tail/mean identities |
| `SLT/GaussianLSI/TensorizedGLSI.lean` | `partialDeriv`, `sliceFunction`, derivative of slices, and tensorized Gaussian LSI proof architecture |
| `SLT/GaussianPoincare/*` | Rademacher/Efron-Stein/limit architecture for Gaussian Poincare |
| `SLT/GaussianSobolevDense/Defs.lean` | radial smooth cutoff definitions: the support, compact-support, smoothness, range, and pointwise-exhaustion base has been ported as ASTIS-owned declarations in `Analysis/Calculus/Cutoff.lean` |
| `SLT/GaussianSobolevDense/Cutoff.lean` | cutoff-gradient estimates and product-rule staging such as `smoothCutoffR_fderiv_bound`, `cutoff_product_rule`, and `tendsto_cutoff_W12`; next port target for scaled derivative bounds and dominated cutoff limits before IBP |
| `SLT/GaussianPoincare/TaylorBound.lean` | compact-support derivative support/boundedness patterns: `deriv_hasCompactSupport`, `deriv2_hasCompactSupport`, `deriv_bounded_of_compactlySupported`; closest SLT staging pattern for no-boundary/IBP prerequisites |
| `SLT/MeasureInfrastructure.lean` | Chernoff, layer-cake, Jensen, finite sup/union, and integrability proof patterns |
| `SLT/HansonWright.lean`, `SLT/MatrixInfra/*`, `SLT/RMT/*`, `SLT/TDudley.lean` | later matrix concentration, empirical-process, and random-matrix proof patterns |

Immediate port candidates for the log-concave sampling tree:

- `Measure.pi` coordinate replacement: port an ASTIS-owned version of
  `map_update_prod_pi` into a focused product-measure module.
- coordinate slices: reuse the `partialDeriv`/`sliceFunction` pattern when
  formalizing product/tensorization arguments and coordinate Langevin leaves.
- Gaussian product law surface: mirror the `stdGaussianPi` and coordinate-law
  interface when strengthening ASTIS Gaussian transition kernels and LMC noise.
- entropy/Jensen surface: reuse the proof staging around `entropy_nonneg`,
  conditional entropy, and subadditivity for FI/LSI chapters.
- cutoff/no-boundary surface: the radial support/exhaustion base is now ported;
  continue using `GaussianSobolevDense/Cutoff.lean` and
  `GaussianPoincare/TaylorBound.lean` as proof-pattern memory for ASTIS-owned
  derivative-support, scaled-gradient, Hessian/Laplacian, and dominated-limit
  leaves.
- Gaussian tensorization: use the LSI/Poincare files as proof architecture
  references only; no theorem is callable until ported locally.

Recommended migration order for ASTIS roots:

1. `MEAS/KERN`: product update, Fubini, and slice-integrability facts.
2. `GAUSS/MEAS`: product Gaussian law and coordinate/linear functional facts.
3. `GAUSS/FI/DENS/REG`: coordinate derivative slicing and tensorized Gaussian
   LSI proof architecture.
4. `REG/CALC/SDE`: extend the compiled smooth-cutoff and compact-support base
   with derivative-support, scaled-gradient, Hessian/Laplacian, and domination
   facts needed before no-boundary IBP.
5. `FI/DENS/MEAS`: entropy/Jensen and Gibbs-duality infrastructure.
6. `FI/MEAS`: entropy chain rule and product subadditivity.
