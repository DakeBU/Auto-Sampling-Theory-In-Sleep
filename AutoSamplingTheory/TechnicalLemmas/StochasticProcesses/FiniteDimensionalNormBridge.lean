import AutoSamplingTheory.TechnicalLemmas.StochasticProcesses.ElementaryItoIntegral
import Mathlib.Analysis.InnerProductSpace.PiL2
import Mathlib.Data.Fintype.BigOperators

/-!
# Finite-dimensional norm bridges for Itô coefficients

Chewi Definition 1.1.17 uses a finite-dimensional drift and a matrix-valued
diffusion coefficient.  The scalar stochastic-integral API compiled earlier in
Chapter 1 consumes one real integrand at a time.  This module isolates the
finite-dimensional algebra needed to pass from the source matrix energy to
those scalar coordinates.

The key point is deliberately elementary: in finite dimensions the square of
one matrix entry is bounded by the sum of squares of all entries.  Applying
`lintegral_mono` pathwise then turns a finite matrix-energy hypothesis into the
local `L²` hypothesis required for every scalar Itô integral.

We also flatten a matrix into `EuclideanSpace ℝ (ι × κ)` and identify its
squared Euclidean norm with the same sum of entry squares.  This is the exact
finite-dimensional Frobenius/Hilbert--Schmidt quantity needed by Chewi; the
source-facing Definition 1.1.17 can therefore use a literal norm statement
without changing the scalar integration layer.
-/

namespace AutoSamplingTheory
namespace TechnicalLemmas
namespace StochasticProcesses
namespace FiniteDimensionalNormBridge

open MeasureTheory
open scoped BigOperators ENNReal NNReal RealInnerProductSpace

open ElementaryItoIntegral

/-- Sum of squares of all entries of a finite real matrix, written as a
curried function so it can be used without committing the stochastic layer to
a particular `Matrix` wrapper. -/
def matrixSquareEnergy
    {ι κ : Type*} [Fintype ι] [Fintype κ]
    (sigma : ι → κ → ℝ) : ℝ :=
  ∑ i, ∑ j, (sigma i j) ^ 2

/-- The finite matrix square energy is nonnegative. -/
theorem matrixSquareEnergy_nonneg
    {ι κ : Type*} [Fintype ι] [Fintype κ]
    (sigma : ι → κ → ℝ) :
    0 ≤ matrixSquareEnergy sigma := by
  unfold matrixSquareEnergy
  exact Finset.sum_nonneg fun i _ =>
    Finset.sum_nonneg fun j _ => sq_nonneg (sigma i j)

/-- Any individual matrix-entry square is bounded by the total finite matrix
square energy.  This is the algebraic core of the Hilbert--Schmidt-to-entrywise
`L²` bridge. -/
theorem entry_sq_le_matrixSquareEnergy
    {ι κ : Type*} [Fintype ι] [Fintype κ]
    (sigma : ι → κ → ℝ) (i : ι) (j : κ) :
    (sigma i j) ^ 2 ≤ matrixSquareEnergy sigma := by
  unfold matrixSquareEnergy
  calc
    (sigma i j) ^ 2 ≤ ∑ j', (sigma i j') ^ 2 :=
      Finset.single_le_sum
        (fun j' _ => sq_nonneg (sigma i j')) (Finset.mem_univ j)
    _ ≤ ∑ i', ∑ j', (sigma i' j') ^ 2 :=
      Finset.single_le_sum
        (fun i' _ => Finset.sum_nonneg fun j' _ => sq_nonneg (sigma i' j'))
        (Finset.mem_univ i)

/-- Flatten a finite matrix into one Euclidean vector indexed by coordinate
pairs.  No information is lost; this is only a norm/notation bridge. -/
noncomputable def matrixAsEuclidean
    {ι κ : Type*} [Fintype ι] [Fintype κ]
    (sigma : ι → κ → ℝ) : EuclideanSpace ℝ (ι × κ) :=
  WithLp.toLp 2 (fun p : ι × κ => sigma p.1 p.2)

/-- The squared Euclidean norm of the flattened matrix is exactly the sum of
squares of its entries.  In finite-dimensional Euclidean spaces this is the
Frobenius/Hilbert--Schmidt norm squared. -/
theorem norm_sq_matrixAsEuclidean
    {ι κ : Type*} [Fintype ι] [Fintype κ]
    (sigma : ι → κ → ℝ) :
    ‖matrixAsEuclidean sigma‖ ^ 2 = matrixSquareEnergy sigma := by
  rw [EuclideanSpace.real_norm_sq_eq]
  change (∑ p : ι × κ, (sigma p.1 p.2) ^ 2) =
    ∑ i, ∑ j, (sigma i j) ^ 2
  rw [Fintype.sum_prod_type]

/-- Pathwise local finiteness of the finite matrix square energy on `[0,T]`.
This is the matrix analogue of Chewi's scalar condition (1.1.10), before the
separate progressive-measurability contract is attached. -/
def MatrixLocallySquareIntegrableOn
    {Omega : Type*} [MeasurableSpace Omega]
    {ι κ : Type*} [Fintype ι] [Fintype κ]
    (sigma : ℝ≥0 → Omega → ι → κ → ℝ)
    (mu : Measure Omega) (T : ℝ≥0) : Prop :=
  ∀ᵐ omega ∂mu,
    (∫⁻ t, ENNReal.ofReal (matrixSquareEnergy (sigma t omega))
      ∂(TimeMeasure.upTo T)) < ∞

/-- Finite matrix energy implies Chewi's scalar local-square-integrability
condition for every matrix entry.  No expectation over sample paths is added:
the implication remains pathwise almost surely, exactly as in display
(1.1.10). -/
theorem MatrixLocallySquareIntegrableOn.entry
    {Omega : Type*} [MeasurableSpace Omega]
    {ι κ : Type*} [Fintype ι] [Fintype κ]
    {sigma : ℝ≥0 → Omega → ι → κ → ℝ}
    {mu : Measure Omega} {T : ℝ≥0}
    (hSigma : MatrixLocallySquareIntegrableOn sigma mu T)
    (i : ι) (j : κ) :
    IsLocallySquareIntegrableOn (fun t omega => sigma t omega i j) mu T := by
  filter_upwards [hSigma] with omega hOmega
  refine lt_of_le_of_lt (lintegral_mono fun t => ?_) hOmega
  exact ENNReal.ofReal_le_ofReal
    (entry_sq_le_matrixSquareEnergy (sigma t omega) i j)

end FiniteDimensionalNormBridge
end StochasticProcesses
end TechnicalLemmas
end AutoSamplingTheory
