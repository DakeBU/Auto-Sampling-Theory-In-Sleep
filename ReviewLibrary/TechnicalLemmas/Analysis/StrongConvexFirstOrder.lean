import Mathlib.Analysis.Convex.Strong
import Mathlib.Analysis.Calculus.ContDiff.Defs
import Mathlib.Analysis.Calculus.FDeriv.Mul
import ReviewLibrary.TechnicalLemmas.Geometry.GeodesicConvexity

open Filter Set
open scoped Topology

namespace ReviewLibrary.TechnicalLemmas.Analysis.StrongConvexFirstOrder

variable {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℝ E]

/-- A source-faithful first-order lower model for a strongly convex function on a
convex domain. This is the Euclidean substrate for later specializations; it does not
assert any Riemannian/Wasserstein/functional-inequality implication. -/
theorem firstOrder_lower_bound_of_strongConvexOn
    {s : Set E} {f : E → ℝ} {m : ℝ} {grad : E → E}
    (hsc : StrongConvexOn s m f)
    (hgrad : ∀ z ∈ s, HasGradientAt f (grad z) z)
    {x y : E} (hx : x ∈ s) (hy : y ∈ s) :
    f y ≥ f x + inner ℝ (grad x) (y - x) + m / 2 * ‖y - x‖ ^ 2 := by
  let path : ℝ → E := fun t => x + t • (y - x)
  have hpath : ∀ t ∈ Set.Icc (0 : ℝ) 1, path t ∈ s := by
    intro t ht
    have hconv := hsc.convex
    simpa [path, sub_eq_add_neg, add_comm, add_left_comm, add_assoc, smul_add, smul_neg,
      one_smul, ← add_smul, sub_eq_add_neg] using hconv hx hy ht.1 ht.2
  have hchord : ∀ t ∈ Set.Icc (0 : ℝ) 1,
      f (path t) ≤ (1 - t) * f x + t * f y - m / 2 * t * (1 - t) * ‖y - x‖ ^ 2 := by
    intro t ht
    have h := hsc.2 hx hy ht.1 ht.2
    simpa [path, smul_eq_mul, mul_assoc, mul_comm, mul_left_comm, sub_eq_add_neg,
      add_comm, add_left_comm, add_assoc] using h
  have hderiv : HasDerivAt (fun t => f (path t)) (inner ℝ (grad x) (y - x)) 0 := by
    have hg := hgrad x hx
    simpa [path] using hg.hasFDerivAt.comp 0 ((hasFDerivAt_const 0 x).add
      ((hasFDerivAt_id 0).smul_const (y - x)))
  have hfirst := ReviewLibrary.TechnicalLemmas.Geometry.GeodesicConvexity.firstOrder_geodesicConvexity
      (f := f) (γ := path) (a := x) (b := y) (m := m)
      (hγ0 := by simp [path])
      (hγ1 := by simp [path])
      (hpath := hpath)
      (hchord := hchord)
      (hderiv := hderiv)
  simpa [Real.norm_eq_abs] using hfirst

end ReviewLibrary.TechnicalLemmas.Analysis.StrongConvexFirstOrder
