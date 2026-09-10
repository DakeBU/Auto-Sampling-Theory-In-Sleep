# Smoothed Picard HMC · formalization result window

Primary: [arXiv:2609.06906v1](https://arxiv.org/html/2609.06906v1).
Reader: [existing companion page](../website/content/samplewiki_companion_frontiers.json).
The public route is `example-cases/samplewiki/companions/smoothed-picard-hmc.html`.

Current compiled packets: `ASTIS-SW-SPHMC-recursive-condition-contraction` and
`ASTIS-SW-SPHMC-rgo-closure`.
The Frontier Cell is authoritative for compilation/review status; no duplicate
completion counter is kept here. The teaching proof and source correspondence
are in `declaration_lessons/sphmc-recursive-condition.json`,
`declaration_lessons/sphmc-rgo-closure.json`, `publications/sphmc.json` and
`publications/sphmc-rgo-closure.json` under `website/content/`.

## Exact conversion

In (6.1)–(6.2), let $k=\kappa_A\ge2$, $h=\eta_j$, $\tau=k$,
$a=(h+\tau)/\beta_A$, with $\beta_A>0$. Then

$$k_+=\frac{k(a\beta_A+1)}{a\beta_A+k}
      =\frac{k(k+h+1)}{2k+h}.$$

The local declaration `RecursiveCondition.contraction_bounds` proves
$k/2\le k_+\le4k/5$ for $0<h<1/4$ by positive-denominator algebra.
The source domain $0<h\le c_0<1/4$ implies this range; conversely every such
$h$ admits $c_0=h$, so the unused cutoff can be eliminated. This is the
scalar proof component of Lemma 6.6(i), consumed by the recursive-depth argument
in Theorem 6.5, not a new ASTIS complexity result.

## Remaining proof edges

Gibbs-density identification and curvature/parameter updates (Lemma 6.4);
well-conditioned contraction (Lemma 6.6(ii)); stage termination and accumulated
cost/error; normalized density smoothing and score regularity; Picard local
error and moment propagation; proxy construction; final actual-input cost.
Theorems 1.1–1.3 remain open. No diagram or citation/download feature is a
prerequisite for the next correct Lean packet.

## Compiled normalized-law component: Lemma 6.4

The distribution-level edge is now `RGOClosure.quadratic_tilt_tilt`, not an
assumed scalar recurrence. Use precisions $r=A^{-1}\ge0$, $s=a^{-1}>0$ so $A=\infty$
is represented by $r=0$ without dividing by an infinite value. With
$w=(r+s)^{-1}(ru+sy)$ the calculation to justify is

$$\frac r2\|x-u\|^2+\frac s2\|x-y\|^2
=\frac{r+s}{2}\|x-w\|^2
 +\frac{rs}{2(r+s)}\|u-y\|^2.$$

The last term is independent of $x$. Its positive finite exponential factor
cancels between the unnormalized density and its normalizer. This cancellation
is proved for actual `Measure.tilted` measures. Positive finite normalizers
follow internally from measurable weights in $(0,1]$ over a probability base.
The $r=0$ and equal-precision cases are directly tested. Neither an assumed law
equality nor a zero-measure fallback is used.

Bounded API audit (pinned Mathlib and current ASTIS, 2026-09-10):
Real inner-product bilinearity provides square expansion; Mathlib `tilted_tilted`,
`tilted_const` and `isProbabilityMeasure_tilted` already supply normalization.
The new ASTIS theorem joins these existing facts. No independent PBPS consumer
of this exact nested-tilt identity was found, so it remains route-local.

Next adapter audit: set $\mu=\mathrm{volume.tilted}(-U)$ and reuse
`tilted_tilted`; this already is the normalized potential-defined density.
No separate density-equality reexport is needed. The genuinely missing premise
is integrability of $e^{-U}$ under the source hypotheses. Existing ASTIS
strong-convexity envelopes require a supplied minimizer; the source does not
supply one, and the formalization must not add that premise.

Compiled shared prerequisite: `ASTIS-SHARED-strong-convex-gibbs-integrability`,
with its exact independent-review/admission status in that Frontier Cell:

$$m>0,\quad V\text{ differentiable},\quad V\text{ is }m\text{-strongly convex}
\quad\Longrightarrow\quad e^{-V}\in L^1(\mathrm{volume}).$$

The proof uses the compiled first-order lower bound at zero and Young's inequality to get

$$V(x)\ge\frac m4\|x\|^2+V(0)-\frac{\|\nabla V(0)\|^2}{m},$$

then reuses `Analysis.Integrability.integrable_exp_neg_add_mul_norm_sq`.
The focused tests derive a strictly positive normalizer, form the actual Gibbs
probability law, and supply it to `quadratic_tilt_tilt`, including zero initial
precision. These are real consumers, not new normalization wrappers. Teaching
and source metadata are `strong-convex-gibbs-integrability.json` in the existing
declaration-lesson and publication directories.
The coefficient $m/4$ is only a domination envelope, not a changed curvature
constant. That integrability packet alone does not convert the paper's
Hessian formulation. The separately compiled shared adapter
`ASTIS-SHARED-hessian-strong-convexity` now proves

$$V\in C^2,\quad D^2V(x)[v,v]\ge\alpha\|v\|^2
\quad\Longrightarrow\quad
V(ax+by)\le aV(x)+bV(y)-\frac\alpha2ab\|x-y\|^2$$

for $a,b\ge0$, $a+b=1$, with exactly the same $\alpha$. Its proof restricts
to a line and subtracts the scalar quadratic; no derivative of the ambient
norm is required. Positive-curvature finite-dimensional consumer tests now
derive integrability, a strictly positive normalizer and a Gibbs probability
directly from C²/Hessian assumptions, then feed it into RGO closure.
See that cell and `hessian-strong-convexity.json` for byte-bound review and
admission status. The separately compiled and source-reviewed
`ASTIS-SHARED-quadratic-regularization` now derives actual quadratic
differentiation, strong convexity and gradient Lipschitz continuity:

$$W=U+\frac r2\|\cdot-u\|^2,\qquad
\alpha_W=m+r,\qquad \operatorname{Lip}(\nabla W)\le L+r.$$

Its five-step lesson explains genuine Hessian differentiation, Riesz
representation, symmetry, the Rayleigh norm bound and the mean-value theorem.
Specialize $m=\kappa^{-1},L=1,r=A^{-1}$; $r=0$ covers $A=\infty$.
The source condition-number substitution, actual recursive sampler and its
error/query bills remain separate. No invariant-law conclusion is inferred.

## Common-kernel TV error transfer

The shared `KernelTotalVariation.abs_real_comp_sub_le` now proves the selected
data-processing step in Section 7.2, proof of Theorem 1.3:

$$\sup_S|\mu(S)-\nu(S)|\le\delta
\quad\Longrightarrow\quad
\sup_T|(\mu K)(T)-(\nu K)(T)|\le\delta.$$

Both input laws are probabilities and K is an actual common measurable Markov
kernel. The proof derives bounded input integrability and both layer integrals
over $(0,1]$; its measure is one, so the factor is exactly one. No density or
Standard Borel assumption is introduced. A focused consumer adds a separately
assumed proxy mixing error by triangle. It does not transfer unbounded query
costs. The four-step lesson and separate folded Lean are generated from
`markov-tv-contraction.json`; the cell records exact admission status.

Next dependency-ready route: an explicit RGO Markov kernel with a genuine
joint-law disintegration certificate. See the bounded synthesis in
`runs/20260910-companion-priority/next-rgo-packet.md`; it is a plan, not a proof.
