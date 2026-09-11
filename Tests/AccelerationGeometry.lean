import Mathlib

/-!
# Acceleration × Geometry Lean prototypes

These examples are deliberately kept in `Tests/` until the source-facing
Linear Coupling / damping statements receive the normal ASTIS publication
binding, declaration lesson, Frontier Cell, blind reconstruction, and
independent semantic review. They check the proposed shared algebra without
promoting it to Samplinglib theorem truth prematurely.
-/

namespace AutoSamplingTheory.Tests.AccelerationGeometry

/-- Prototype of the geometry-independent scalar coupling step: independently
certified primal and dual progress inequalities may be combined with
nonnegative weights. -/
example
    {a b primalChange dualChange primalGain dualGain : ℝ}
    (ha : 0 ≤ a) (hb : 0 ≤ b)
    (hprimal : primalChange ≤ -primalGain)
    (hdual : dualChange ≤ -dualGain) :
    a * primalChange + b * dualChange ≤
      -(a * primalGain + b * dualGain) := by
  have hp := mul_le_mul_of_nonneg_left hprimal ha
  have hd := mul_le_mul_of_nonneg_left hdual hb
  linarith

/-- The affine three-way interpolation shape used by anchored momentum schemes
is already independent of the eventual Euclidean/manifold/probability adapter. -/
example (τ₁ τ₂ : ℝ) :
    τ₁ + τ₂ + (1 - τ₁ - τ₂) = 1 := by
  ring

/-- If the two explicit interpolation weights are nonnegative and sum to at
most one, the residual anchor/current-state weight is nonnegative. -/
example {τ₁ τ₂ : ℝ}
    (h₁ : 0 ≤ τ₁) (h₂ : 0 ≤ τ₂) (hsum : τ₁ + τ₂ ≤ 1) :
    0 ≤ 1 - τ₁ - τ₂ := by
  linarith

/-- Prototype of the force cancellation behind damped kinetic-energy
calculations. This is scalar mechanics algebra, not an underdamped-Langevin
convergence theorem. -/
example {γ velocity force : ℝ} (hγ : 0 ≤ γ) :
    velocity * (-γ * velocity - force) + force * velocity ≤ 0 := by
  calc
    velocity * (-γ * velocity - force) + force * velocity =
        -γ * velocity ^ 2 := by ring
    _ ≤ 0 := neg_nonpos.mpr (mul_nonneg hγ (sq_nonneg velocity))

end AutoSamplingTheory.Tests.AccelerationGeometry
