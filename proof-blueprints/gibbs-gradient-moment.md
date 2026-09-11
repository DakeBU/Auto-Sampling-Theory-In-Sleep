# Actual Gibbs gradient-square moment

Source consumer: SPHMC arXiv:2609.06906v1 Section 6.3. This is a proof plan,
not a compiled result. Independent route review: log_depth_source_review.

Let E be a finite-dimensional complete real inner-product Borel space, U C2,
and 0 < alpha with alpha I <= Hess U <= beta I, beta nonnegative. Define
pi = volume.tilted(-U), and choose the canonical orthonormal basis e_i.
The desired public conclusion includes actual probability, L1 of gradient
squared and the basis Hessian diagonal sum, their expectation equality, and
the upper bound beta * finrank(E). Include dimension zero; no assumed minimizer.

1. Instantiate QuadraticRegularization at regularizer precision zero. Obtain
   StrongConvexOn alpha U and LipschitzWith beta (gradient U). Put G=|grad U(0)|.
   The triangle inequality gives |grad U(x)| <= G + beta |x|.

2. StrongConvexFirstOrder at zero plus Young gives
   U(x) >= b + a |x|^2, where a=alpha/4>0 and
   b=U(0)-((alpha/2)^(-1)/2)*G^2.
   The existing normalization theorem proves exp(-U) L1, but does not expose
   the following weighted moment. Prove that weighted moment explicitly.

3. Set t=(a/2)|x|^2 >=0. Real.add_one_le_exp gives 1+t <= exp(t), hence
   (1+|x|^2) <= (1+2/a) exp(t). Multiplying the Gaussian lower envelope gives
   (1+|x|^2) exp(-U(x)) <=
   (1+2/a) exp(-b) exp(-(a/2)|x|^2).
   The right-hand side is integrable by the existing finite-dimensional
   Gaussian integral. Continuity plus Integrable.mono' proves the left L1.
   From |grad U|^2 <= 2 G^2 + 2 beta^2 |x|^2 obtain weighted gradient-square L1.
   From |grad U| <= 1+|grad U|^2 obtain weighted gradient norm L1.

4. For any fixed basis vector e_i set h_i(x)=fderiv U x e_i. Actual C2 implies
   h_i is C1 and fderiv h_i x e_i = fderiv (fderiv U) x e_i e_i.
   The derivative of f(x)=exp(-U(x)) in direction e_i is -f(x)*h_i(x).
   Bound |h_i| by |grad U| (unit basis vector), and 0<=H_i<=beta.
   Thus f' h_i = -f h_i^2, f h_i'=f H_i and f h_i are all L1.
   Invoke integral_mul_fderiv_eq_neg_fderiv_mul_of_integrable. No compact
   support, cutoff limit, third derivative or boundary assumption is added.
   The actual identity is integral(f*H_i)=integral(f*h_i^2).

5. Finite sum and OrthonormalBasis.sum_sq_norm_inner_right identify
   sum_i h_i^2 = |grad U|^2. Convert real square and norm-square carefully;
   the source of the gradient pairing is its genuine Frechet derivative.
   Sum integrability is established before interchanging sum and integral.

6. Use integral_exp_pos and isProbabilityMeasure_tilted for normalization.
   integrable_tilted_iff transfers both weighted L1 facts. integral_tilted
   divides the unnormalized equality by the same positive normalizer.
   Finally sum_i H_i <= beta * finrank and integral_mono on the actual
   probability measure yield E_pi |grad U|^2 <= beta * finrank.

This establishes the ideal Gibbs moment only. Later consumers must separately
prove transport of this moment to their actual approximate output, Gaussian
perturbation estimates, conditional histories and the total reference cost.
