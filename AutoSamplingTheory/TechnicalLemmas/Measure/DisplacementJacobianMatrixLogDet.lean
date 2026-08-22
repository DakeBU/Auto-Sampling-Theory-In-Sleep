import AutoSamplingTheory.TechnicalLemmas.Measure.DisplacementJacobianAffineSpectrum
import AutoSamplingTheory.TechnicalLemmas.Measure.DisplacementJacobianEntropy

/-!
# Literal matrix log-determinant convexity for displacement entropy

This module closes the finite-dimensional matrix layer in the entropy half of
Chewi Theorem 1.4.5.  The lower leaves already establish:

* scalar log concavity along `1 -> lambda`;
* positivity of `(1-t) I + t A`;
* determinant invariance under unitary star-conjugation;
* the determinant of the affine segment against a diagonal matrix;
* the common eigenbasis interpretation for the affine Jacobian.

Here these ingredients are assembled into a literal determinant product formula
for a real SPD matrix and then into the matrix inequality

`-log det ((1-t) I + t A) <= t (-log det A)`.

The SPD hypothesis is intentional.  `Real.log` in Lean is totalized at zero, so
this theorem must not be used to encode an extended-real entropy statement for
a singular positive-semidefinite endpoint.  The PSD interior-time regularity
leaf remains available separately for the later Brenier/change-of-variables
bridge.
-/

namespace AutoSamplingTheory
namespace TechnicalLemmas
namespace Measure
namespace DisplacementJacobianMatrixLogDet

open Matrix Real
open scoped BigOperators

noncomputable section

open DisplacementJacobianEntropy

/-- The literal determinant of the affine identity segment is the product of
the affine transforms of the eigenvalues of an SPD matrix.

The proof diagonalizes `A` by the canonical unitary eigenbasis, transports the
affine combination through the star-algebra automorphism, removes the unitary
change of basis at determinant level, and evaluates the diagonal determinant.
It therefore does not depend on any equality between ordered eigenvalue
functions of `A` and `(1-t) I + t A`. -/
theorem det_affineIdentityMatrix_eq_prod_eigenvalues
    {ι : Type*} [Fintype ι] [DecidableEq ι]
    (A : Matrix ι ι ℝ) (hA : A.PosDef) (t : ℝ) :
    Matrix.det ((1 - t) • (1 : Matrix ι ι ℝ) + t • A) =
      ∏ i, ((1 - t) + t * hA.isHermitian.eigenvalues i) := by
  let B : Matrix ι ι ℝ := (1 - t) • (1 : Matrix ι ι ℝ) + t • A
  let U : unitary (Matrix ι ι ℝ) := star hA.isHermitian.eigenvectorUnitary
  have hdiag :
      Unitary.conjStarAlgAut ℝ (Matrix ι ι ℝ) U B =
        (1 - t) • (1 : Matrix ι ι ℝ) +
          t • Matrix.diagonal hA.isHermitian.eigenvalues := by
    dsimp [B]
    rw [map_add, map_smul, map_smul, map_one]
    dsimp [U]
    rw [hA.isHermitian.conjStarAlgAut_star_eigenvectorUnitary]
  calc
    Matrix.det B =
        Matrix.det (Unitary.conjStarAlgAut ℝ (Matrix ι ι ℝ) U B) :=
      (det_conjStarAlgAut_eq U B).symm
    _ = Matrix.det
        ((1 - t) • (1 : Matrix ι ι ℝ) +
          t • Matrix.diagonal hA.isHermitian.eigenvalues) := by
      rw [hdiag]
    _ = ∏ i, ((1 - t) + t * hA.isHermitian.eigenvalues i) :=
      det_affineIdentity_diagonal hA.isHermitian.eigenvalues t

/-- The finite-spectrum log-det of the affine eigenvalues is exactly the
literal log determinant of the affine matrix. -/
theorem spectrumLogDet_affineIdentity_eigenvalues_eq_log_det
    {ι : Type*} [Fintype ι] [DecidableEq ι]
    (A : Matrix ι ι ℝ) (hA : A.PosDef) (t : ℝ)
    (ht0 : 0 ≤ t) (ht1 : t ≤ 1) :
    spectrumLogDet
        (affineIdentitySpectrum t hA.isHermitian.eigenvalues) =
      Real.log (Matrix.det ((1 - t) • (1 : Matrix ι ι ℝ) + t • A)) := by
  unfold spectrumLogDet affineIdentitySpectrum
  rw [det_affineIdentityMatrix_eq_prod_eigenvalues A hA t]
  exact (Real.log_prod (fun i _ =>
    (affineIdentityEigenvalue_pos (hA.eigenvalues_pos i) ht0 ht1).ne')).symm

/-- Literal SPD matrix form of the `-log det` convexity used in the entropy
half of Chewi Theorem 1.4.5. -/
theorem neg_log_det_affineIdentity_le
    {ι : Type*} [Fintype ι] [DecidableEq ι]
    (A : Matrix ι ι ℝ) (hA : A.PosDef) (t : ℝ)
    (ht0 : 0 ≤ t) (ht1 : t ≤ 1) :
    -Real.log (Matrix.det ((1 - t) • (1 : Matrix ι ι ℝ) + t • A)) ≤
      t * (-Real.log (Matrix.det A)) := by
  have hineq := neg_spectrumLogDet_affineIdentity_le
    hA.isHermitian.eigenvalues t (fun i => hA.eigenvalues_pos i) ht0 ht1
  rw [spectrumLogDet_affineIdentity_eigenvalues_eq_log_det A hA t ht0 ht1,
    spectrumLogDet_eigenvalues_eq_log_det A hA] at hineq
  exact hineq

end

end DisplacementJacobianMatrixLogDet
end Measure
end TechnicalLemmas
end AutoSamplingTheory
