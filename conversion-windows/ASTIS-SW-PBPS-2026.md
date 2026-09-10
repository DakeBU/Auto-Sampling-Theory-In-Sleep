# Proximal BPS · formalization result window

Primary: [arXiv:2609.06905v1](https://arxiv.org/html/2609.06905v1).
Public result entry: `example-cases/samplewiki/companions/proximal-bouncy-particle.html`.
The canonical source/main-theorem contracts remain in
`website/content/samplewiki_companion_frontiers.json`.

## Current source packet

`ASTIS-SW-PBPS-gaussian-augmentation-reflection` is the authoritative Frontier
Cell for compilation and review status. The ASTIS-owned declaration is
`GaussianReflection.reflection_preserves_augmentation`; its authored teaching
proof is `website/content/declaration_lessons/pbps-gaussian-reflection.json`,
with source obligations in `website/content/publications/pbps.json`.

Proposition 2.1(iii), with the generative law (2.7). Define
$\Phi_\eta(x,z)=(x,x+\sqrt\eta z)$ and
$\pi_\eta=(\Phi_\eta)_\#(\mu\otimes\gamma)$, where $\mu$ is a probability law
and $\gamma$ is the standard Gaussian. For $R(x,y)=(x,2x-y)$,

$$R\circ\Phi_\eta=\Phi_\eta\circ(\mathrm{id},-\mathrm{id}),
\qquad R_\#\pi_\eta=\pi_\eta.$$

Search result: Mathlib `stdGaussian_map`, `LinearIsometryEquiv.neg`,
`Measure.map_prod_map`, `Measure.map_map` and `Measure.map_id` supply the
Gaussian symmetry and pushforward tools. These are external library tools,
not new ASTIS leaves. The ASTIS composition has passed focused Lean compilation
and exercises both the pointwise involution and the entire joint measure
equality. The cell and semantic audit retain the exact evidence and remaining
commit-bound integration status; this window is not a second status ledger.

## Compiled density route

`ASTIS-SHARED-isotropic-gaussian-density` owns the noise law:

$$q_\eta(z)=((\sqrt{2\pi\eta})^{-1})^d
\exp\!\left(-\frac{\|z\|^2}{2\eta}\right),\qquad
(\sqrt\eta\,\cdot)_\#\gamma=q_\eta\,\mathrm{volume}.$$

The explicit constant and zero-dimensional case are compiled; no Gaussian
integration or Jacobian theorem is reimplemented. The proof composes the
existing ASTIS product-density/measure-equivalence tools with Mathlib scalar
Gaussian and orthonormal-volume transport.

`ASTIS-SW-PBPS-joint-gaussian-density` owns the next actual measure equality:

$$(\Phi_\eta)_\#(\mu\otimes\gamma)
=(\mu\otimes\mathrm{volume})\,q_\eta(y-x).$$

The reference measure is **input law times volume**, not product volume.
The measurable shear preserves that reference measure because volume is
translation invariant; no translation invariance or density of $\mu$ is assumed.
The Dirac-input test deliberately exercises this boundary. The source's Gibbs
substitution $\mu(dx)=Z_V^{-1}e^{-V(x)}dx$ is still required to recover the
specific product-volume density in (2.6). Each cell records compilation,
independent source review and integration separately; the lessons and source
bindings are `isotropic-gaussian-density.json` and
`pbps-joint-gaussian-density.json` in the existing website metadata directories.

## Remaining source edges

Keep the Gibbs substitution/normalizability required by (2.6),
the conditional half-turn process, non-explosion, reversibility, discrete
modified-L2 hypocoercivity, implementation coupling and actual expected query
cost as separate proof edges. Theorem 3.5, Theorem 4.3 and Corollary 4.4 remain
open. Reflection algebra alone never proves the PBPS process invariant.

The common normalization prerequisite is now compiled in
`ASTIS-SHARED-strong-convex-gibbs-integrability`: positive strong convexity plus
differentiability implies integrability of $e^{-V}$ without a supplied
minimizer. The proof derives an explicit Gaussian envelope; tests obtain a
positive normalizer and the Gibbs probability law from existing Mathlib APIs.
Its cell records the exact review/admission status. The separately compiled
`ASTIS-SHARED-hessian-strong-convexity` now supplies the genuine C² lower-Hessian
to strong-convexity implication, retaining the exact modulus. Focused tests
compose it with this integrability result, positive normalization and RGO
closure. Its own cell records independent review and admission separately.

The separately compiled `ASTIS-SW-PBPS-gibbs-augmentation` now inserts the resulting Gibbs law
$\mu=\mathrm{volume.tilted}(-V)$ into the compiled augmentation density:

$$\frac{d(\Phi_\eta)_\#(\mu\otimes\gamma)}{d(dx\,dy)}
=\frac{(2\pi\eta)^{-d/2}}{Z_V}
\exp\!\left(-V(x)-\frac{\|y-x\|^2}{2\eta}\right),
\qquad Z_V=\int e^{-V(x)}\,dx.$$

Its single certificate also proves $Z_V>0$ and probability of the joint law,
excluding a zero totalized tilt. Normalization is derived from the source's
C² positive lower-curvature hypotheses, not an assumed integrable Gibbs weight.
Focused tests transfer probability and the existing auxiliary reflection to
this exact source-density measure and check the complete zero-dimensional
certificate. The cell and `gibbs-augmentation.json` lesson/publication record
independent review and admission separately. This is not a conditional-kernel,
invariant-process or mixing theorem. The shared
`ASTIS-SHARED-quadratic-regularization` now proves exact shifted strong
convexity and actual gradient smoothness for the quadratic potential.
For PBPS set $m=\alpha,L=\beta,r=\eta^{-1}$. This is analytic support,
not public formalization of the entire Hessian sandwich (2.10), conditional
law or Proposition 2.1. The next selected edge is genuine Markov-kernel TV
contraction for the companion composition; unbounded query costs remain
independent of TV closeness.
