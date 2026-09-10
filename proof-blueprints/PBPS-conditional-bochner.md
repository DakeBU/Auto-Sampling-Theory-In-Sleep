# Conditional Bochner energy: analytic prerequisite

This packet supplies a prerequisite to PBPS v1 Appendix C.1's conditional
Poincare step, not that inequality. The background identity is the Euclidean
compact-test specialization of Kolesnikov--Milman arXiv:1310.2526v7,
Theorem 1.1 (1.3). This is a localized version proved directly, not a full
manifold theorem or an automatic noncompact instance: an enclosing ball
kills boundary terms in positive dimension; dimension zero is an extension.

For C2 W and smooth compactly supported h, put Lh = Delta h - <grad W,grad h>.
First prove weighted bilinear IBP with g only C1. Apply pinned Mathlib's
`integral_mul_fderiv_eq_neg_fderiv_mul_of_integrable` on Haar volume to
F = exp(-W) g and H = D_v h. All three required products are continuous and
compactly supported. Sum over an orthonormal basis. This works in dimension
zero too and avoids Euclidean-to-Pi transport. Gibbs is not a Haar measure.

Then differentiate Lh once in each basis direction:
D_i(Lh) = L(D_i h) - sum_j D_ij W D_j h.
Two applications of the bilinear IBP give
integral exp(-W) (Lh)^2 = integral exp(-W) (sum_ij (D_ij h)^2
+ D2W[grad h,grad h]). Only two derivatives of W are used.

The actual consumer uses the common Markov kernels from
ConditionalScoreDomain and its exact W_y. Normalize the identity using the
proved conditional law, apply its curvature (alpha+eta^-1)/4, and discard
the nonnegative squared Hessian term. Derive every integrability obligation.
Do not hide normalization in a totalized zero integral.

Still missing afterwards: weighted gradient closure and an appropriate core,
dense mean-zero generator range or an epsilon resolvent and core regularity,
and noncompact score approximation. Pure-gradient coercivity cannot be
assumed in a Lax--Milgram argument to prove Poincare. Admissible integrability
does not establish membership in a future test class. No Poincare, variance,
macroscopic coercivity, process, mixing, implementation or cost closure here.

Root is the sole writer. Independent bounded route review confirmed the
direct Haar IBP API. The prior score-domain PR255 is merged and its actual
deployment verified. Both current public results and axiom tests pass the
focused 3242-job build. Helper proofs are local to the shared public theorem,
so its folded Lean can include the entire argument. The explicit Hessian
coordinate sum is retained without claiming a separate abstract norm theorem.
Final source and fixed-commit admission, integration and reader delivery are
still separate from this local proof milestone.
