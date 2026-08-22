import Mathlib.Algebra.Order.Star.Real
import Mathlib.Analysis.Convex.SpecificFunctions.Basic
import Mathlib.Analysis.Matrix.PosDef
import Mathlib.MeasureTheory.Integral.Bochner.Basic
import Mathlib.Tactic

/-!
# Jacobian log-determinant convexity for displacement entropy

Chewi's proof of Theorem 1.4.5 splits the KL functional into potential energy
and entropy.  The potential-energy half is formalized in
`DisplacementPotentialEnergy`.  For the entropy half, the source uses the
change-of-variables identity

`H(mu_t) = H(mu_0) - ∫ log det ((1-t) I + t ∇T) d mu_0`

and convexity of `-log det` on positive Jacobians.

This file isolates the eigenvalue-coordinate convexity behind that step.  If
`lambda_i > 0` are the eigenvalues of a positive-definite Jacobian, then

`log ((1-t) + t lambda_i) >= t log lambda_i`

for `0 <= t <= 1`.  Summing over the finite spectrum gives the corresponding
log-determinant inequality.  For a real positive-definite matrix, Mathlib's
spectral determinant theorem and positivity of every eigenvalue then identify
this finite-spectrum sum with the literal `Real.log (Matrix.det A)`.

The literal affine matrix `(1-t) I + t A` is also proved positive definite for
`0 <= t <= 1` whenever `A` is positive definite.  This keeps the matrix-domain
regularity needed by `log det` explicit before the later spectral and
change-of-variables bridges.

This is deliberately not yet a Brenier/change-of-variables theorem.  The
following remain separate obligations:

* identify the derivative of the optimal transport map as a symmetric
  positive-(semi)definite Jacobian;
* transport the spectrum through the affine matrix `(1-t) I + t A`;
* prove the density change-of-variables identity for the displacement map;
* assemble the resulting entropy inequality with `DisplacementPotentialEnergy`.
-/

namespace AutoSamplingTheory
namespace TechnicalLemmas
namespace Measure
namespace DisplacementJacobianEntropy

open MeasureTheory Real Set
open scoped BigOperators

noncomputable section

/-- The eigenvalue of `(1-t) I + t A` corresponding to a positive eigenvalue
`a` of `A` stays positive for `0 <= t <= 1`. -/
theorem affineIdentityEigenvalue_pos
    {a t : ℝ} (ha : 0 < a) (ht0 : 0 ≤ t) (ht1 : t ≤ 1) :
    0 < (1 - t) + t * a := by
  rcases lt_or_eq_of_le ht1 with ht1' | rfl
  · exact add_pos_of_pos_of_nonneg (sub_pos.mpr ht1') (mul_nonneg ht0 ha.le)
  · simpa using ha

/-- Scalar logarithmic concavity along the segment from the identity eigenvalue
`1` to a positive eigenvalue `a`.

This is the one-dimensional inequality used eigenvalue-by-eigenvalue in the
Jacobian determinant calculation. -/
theorem log_affineIdentity_ge
    {a t : ℝ} (ha : 0 < a) (ht0 : 0 ≤ t) (ht1 : t ≤ 1) :
    t * Real.log a ≤ Real.log ((1 - t) + t * a) := by
  have hlog : ConcaveOn ℝ (Ioi (0 : ℝ)) Real.log :=
    (strictConcaveOn_log_Ioi : StrictConcaveOn ℝ (Ioi (0 : ℝ)) Real.log).concaveOn
  have hconc := hlog.2
    (show (1 : ℝ) ∈ Ioi (0 : ℝ) by norm_num)
    (show a ∈ Ioi (0 : ℝ) by exact ha)
    (sub_nonneg.mpr ht1) ht0 (by ring : (1 - t) + t = (1 : ℝ))
  simpa [smul_eq_mul] using hconc

/-- Sum of logarithms of a finite positive spectrum. -/
noncomputable def spectrumLogDet
    {ι : Type*} [Fintype ι] (lambda : ι → ℝ) : ℝ :=
  ∑ i, Real.log (lambda i)

/-- For a real positive-definite matrix, the abstract finite-spectrum log-det
is exactly the logarithm of the literal matrix determinant.

This is the matrix bridge needed before the Jacobian entropy leaf can consume
an actual `fderiv` matrix rather than an externally supplied positive spectrum. -/
theorem spectrumLogDet_eigenvalues_eq_log_det
    {ι : Type*} [Fintype ι] [DecidableEq ι]
    (A : Matrix ι ι ℝ) (hA : A.PosDef) :
    spectrumLogDet hA.isHermitian.eigenvalues = Real.log A.det := by
  unfold spectrumLogDet
  rw [hA.isHermitian.det_eq_prod_eigenvalues]
  exact (Real.log_prod (fun i _ => (hA.eigenvalues_pos i).ne')).symm

/-- The same SPD determinant bridge in the entropy-sign orientation. -/
theorem neg_spectrumLogDet_eigenvalues_eq_neg_log_det
    {ι : Type*} [Fintype ι] [DecidableEq ι]
    (A : Matrix ι ι ℝ) (hA : A.PosDef) :
    -spectrumLogDet hA.isHermitian.eigenvalues = -Real.log A.det := by
  rw [spectrumLogDet_eigenvalues_eq_log_det A hA]

/-- The literal affine Jacobian `(1-t) I + t A` stays positive definite along
`0 <= t <= 1` whenever `A` is positive definite.

For `t < 1`, the identity contribution has a strictly positive coefficient and
is positive definite, while the `t A` contribution is positive semidefinite.
The endpoint `t = 1` reduces exactly to `A`. -/
theorem affineIdentityMatrix_posDef
    {ι : Type*} [Fintype ι] [DecidableEq ι]
    (A : Matrix ι ι ℝ) (hA : A.PosDef) (t : ℝ)
    (ht0 : 0 ≤ t) (ht1 : t ≤ 1) :
    ((1 - t) • (1 : Matrix ι ι ℝ) + t • A).PosDef := by
  rcases lt_or_eq_of_le ht1 with ht1' | rfl
  · have hI : (1 : Matrix ι ι ℝ).PosDef := Matrix.PosDef.one
    have hleft : ((1 - t) • (1 : Matrix ι ι ℝ)).PosDef :=
      hI.smul (sub_pos.mpr ht1')
    have hright : (t • A).PosSemidef :=
      hA.posSemidef.smul ht0
    exact hleft.add_posSemidef hright
  · simpa using hA

/-- Spectrum of the affine Jacobian `(1-t) I + t A` when `lambda` is the
spectrum of `A`. -/
noncomputable def affineIdentitySpectrum
    {ι : Type*} (t : ℝ) (lambda : ι → ℝ) : ι → ℝ :=
  fun i => (1 - t) + t * lambda i

/-- Eigenvalue-coordinate form of the log-determinant concavity used in the
entropy half of Chewi Theorem 1.4.5. -/
theorem spectrumLogDet_affineIdentity_ge
    {ι : Type*} [Fintype ι]
    (lambda : ι → ℝ) (t : ℝ)
    (hlambda : ∀ i, 0 < lambda i)
    (ht0 : 0 ≤ t) (ht1 : t ≤ 1) :
    t * spectrumLogDet lambda ≤
      spectrumLogDet (affineIdentitySpectrum t lambda) := by
  unfold spectrumLogDet affineIdentitySpectrum
  rw [Finset.mul_sum]
  exact Finset.sum_le_sum fun i _ =>
    log_affineIdentity_ge (hlambda i) ht0 ht1

/-- Equivalent `-log det` orientation: the Jacobian contribution to entropy is
convex along the identity-to-transport interpolation. -/
theorem neg_spectrumLogDet_affineIdentity_le
    {ι : Type*} [Fintype ι]
    (lambda : ι → ℝ) (t : ℝ)
    (hlambda : ∀ i, 0 < lambda i)
    (ht0 : 0 ≤ t) (ht1 : t ≤ 1) :
    -spectrumLogDet (affineIdentitySpectrum t lambda) ≤
      t * (-spectrumLogDet lambda) := by
  have h := neg_le_neg
    (spectrumLogDet_affineIdentity_ge lambda t hlambda ht0 ht1)
  simpa [mul_neg] using h

/-- Integral form of the same Jacobian entropy inequality for a measurable
family of positive spectra.  Integrability is explicit so Mathlib's totalized
Bochner integral cannot silently certify a non-integrable entropy term. -/
theorem integral_neg_spectrumLogDet_affineIdentity_le
    {X ι : Type*} [MeasurableSpace X] [Fintype ι]
    (mu : Measure X) (lambda : X → ι → ℝ) (t : ℝ)
    (hlambda : ∀ x i, 0 < lambda x i)
    (ht0 : 0 ≤ t) (ht1 : t ≤ 1)
    (hleft : Integrable
      (fun x => -spectrumLogDet (affineIdentitySpectrum t (lambda x))) mu)
    (hright : Integrable (fun x => -spectrumLogDet (lambda x)) mu) :
    (∫ x, -spectrumLogDet (affineIdentitySpectrum t (lambda x)) ∂mu) ≤
      t * ∫ x, -spectrumLogDet (lambda x) ∂mu := by
  have hright' : Integrable
      (fun x => t * (-spectrumLogDet (lambda x))) mu :=
    hright.const_mul t
  calc
    (∫ x, -spectrumLogDet (affineIdentitySpectrum t (lambda x)) ∂mu) ≤
        ∫ x, t * (-spectrumLogDet (lambda x)) ∂mu := by
      exact integral_mono hleft hright' fun x =>
        neg_spectrumLogDet_affineIdentity_le
          (lambda x) t (hlambda x) ht0 ht1
    _ = t * ∫ x, -spectrumLogDet (lambda x) ∂mu := by
      rw [integral_const_mul]

end

end DisplacementJacobianEntropy
end Measure
end TechnicalLemmas
end AutoSamplingTheory
