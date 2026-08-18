import AutoSamplingTheory.TechnicalLemmas.Analysis.Calculus.AffineLineSecondDerivative
import AutoSamplingTheory.TechnicalLemmas.Geometry.LogConcavity
import Mathlib.Analysis.Calculus.ContDiff.Deriv
import Mathlib.Analysis.Calculus.Deriv.Mul
import Mathlib.Analysis.Calculus.Deriv.Pow
import Mathlib.Analysis.Convex.Deriv
import Mathlib.Analysis.Convex.Strong
import Mathlib.Tactic.Module

/-!
# Strong convexity leaves

Small strong-convexity bridges for log-concave sampling targets.  The main
consumer is Gibbs normalization: a strongly convex potential with an exposed
global minimizer has a centered quadratic lower envelope.
-/

namespace AutoSamplingTheory
namespace TechnicalLemmas
namespace Geometry
namespace StrongConvexity

open Set

/-- A nonnegatively strongly convex function is convex.

This is the small Mathlib-facing bridge from Chewi's strong-convexity
assumptions to ordinary convex-potential density geometry. -/
theorem convexOn_of_strongConvexOn_nonneg
    {E : Type*} [NormedAddCommGroup E] [NormedSpace ℝ E]
    {s : Set E} {V : E → ℝ} {k : ℝ}
    (hV : StrongConvexOn s k V) (hk : 0 ≤ k) :
    ConvexOn ℝ s V := by
  simpa using (StrongConvexOn.mono (s := s) (f := V) hk hV)

/-- A differentiable convex function on the real line has nonnegative second
(totalized) derivative everywhere.

Mathlib already supplies both hard one-dimensional ingredients:
`ConvexOn.monotoneOn_deriv` makes the first derivative monotone, and
`Monotone.deriv_nonneg` makes the derivative of that monotone function
nonnegative.  Keeping this composition as a named leaf lets the later
strong-convexity/Hessian bridge reuse the locked Mathlib calculus without
reproving a mean-value theorem. -/
theorem deriv2_nonneg_of_convexOn_univ
    {f : ℝ → ℝ}
    (hf : ConvexOn ℝ (Set.univ : Set ℝ) f)
    (hfd : Differentiable ℝ f) (x : ℝ) :
    0 ≤ (deriv^[2] f) x := by
  have hmono : Monotone (deriv f) := by
    rw [← monotoneOn_univ]
    exact hf.monotoneOn_deriv (fun y _ => hfd y)
  change 0 ≤ deriv (deriv f) x
  exact hmono.deriv_nonneg

/-- Restricting a strongly convex function to the affine line `x + t • v`
preserves strong convexity, with modulus scaled by `‖v‖²`.

This is a purely convex-algebraic leaf: no differentiability or Hessian is
used.  It is the canonical reduction from the finite-dimensional
strong-convexity assumption in Chewi's Bakry--Émery discussion to a
one-dimensional strong-convexity statement along an arbitrary direction. -/
theorem strongConvexOn_affineLine
    {E : Type*} [NormedAddCommGroup E] [NormedSpace ℝ E]
    {V : E → ℝ} {k : ℝ}
    (hV : StrongConvexOn (Set.univ : Set E) k V)
    (x v : E) :
    StrongConvexOn (Set.univ : Set ℝ) (k * ‖v‖ ^ 2)
      (fun t : ℝ => V (x + t • v)) := by
  constructor
  · exact convex_univ
  · intro s _ t _ a b ha hb hab
    have hbase :=
      hV.2
        (by simp : x + s • v ∈ (Set.univ : Set E))
        (by simp : x + t • v ∈ (Set.univ : Set E))
        ha hb hab
    have harg :
        a • (x + s • v) + b • (x + t • v) =
          x + (a • s + b • t) • v := by
      calc
        a • (x + s • v) + b • (x + t • v) =
            (a + b) • x + (a * s + b * t) • v := by
              module
        _ = x + (a * s + b * t) • v := by
              rw [hab, one_smul]
        _ = x + (a • s + b • t) • v := by
              simp [smul_eq_mul]
    have hdiffVec :
        (x + s • v) - (x + t • v) = (s - t) • v := by
      module
    have hdiff :
        ‖(x + s • v) - (x + t • v)‖ ^ 2 =
          ‖v‖ ^ 2 * ‖s - t‖ ^ 2 := by
      rw [hdiffVec, norm_smul]
      ring
    calc
      V (x + (a • s + b • t) • v) =
          V (a • (x + s • v) + b • (x + t • v)) := by
            rw [harg]
      _ ≤ a • V (x + s • v) + b • V (x + t • v) -
          a * b * (k / 2 * ‖(x + s • v) - (x + t • v)‖ ^ 2) := hbase
      _ = a • V (x + s • v) + b • V (x + t • v) -
          a * b * ((k * ‖v‖ ^ 2) / 2 * ‖s - t‖ ^ 2) := by
            rw [hdiff]
            ring

/-- On the real line, a `C²` `k`-strongly convex function has second
(totalized) derivative at least `k` everywhere.

The proof uses Mathlib's exact strong-convexity normalization:
`f - k/2 * ‖·‖²` is convex.  The quadratic correction and its linear first
derivative are named functions, so all derivative identities use the bundled
function-subtraction API directly; this avoids both expensive iterated-
derivative normalization and fragile lambda/function definitional equality. -/
theorem deriv2_ge_of_strongConvexOn_univ
    {f : ℝ → ℝ} {k : ℝ}
    (hf : StrongConvexOn (Set.univ : Set ℝ) k f)
    (hreg : ContDiff ℝ 2 f) (x : ℝ) :
    k ≤ (deriv^[2] f) x := by
  let q : ℝ → ℝ := fun y => k / 2 * y ^ 2
  let ell : ℝ → ℝ := fun y => k * y
  have hconvNorm :
      ConvexOn ℝ (Set.univ : Set ℝ)
        (fun y : ℝ => f y - k / 2 * ‖y‖ ^ 2) :=
    (strongConvexOn_iff_convex).mp hf
  have hconv : ConvexOn ℝ (Set.univ : Set ℝ) (f - q) := by
    change ConvexOn ℝ (Set.univ : Set ℝ) (fun y : ℝ => f y - q y)
    simpa only [q, Real.norm_eq_abs, sq_abs] using hconvNorm
  have hfDiff : Differentiable ℝ f := hreg.differentiable (by norm_num)
  have hqDeriv (y : ℝ) : HasDerivAt q (ell y) y := by
    have hpow : HasDerivAt (fun z : ℝ => z ^ 2) (2 * y) y := by
      simpa using (hasDerivAt_pow 2 y)
    have hscaled :
        HasDerivAt (fun z : ℝ => k / 2 * z ^ 2) ((k / 2) * (2 * y)) y :=
      hpow.const_mul (k / 2)
    have hcoef : (k / 2) * (2 * y) = k * y := by ring
    simpa only [q, ell, hcoef] using hscaled
  have hqDiff : Differentiable ℝ q := fun y => (hqDeriv y).differentiableAt
  have hcorrectedDiff : Differentiable ℝ (f - q) := hfDiff.sub hqDiff
  have hmonoCorrected : Monotone (deriv (f - q)) := by
    rw [← monotoneOn_univ]
    exact hconv.monotoneOn_deriv (fun y _ => hcorrectedDiff y)
  have hderivCorrected : deriv (f - q) = deriv f - ell := by
    funext y
    exact ((hfDiff y).hasDerivAt.sub (hqDeriv y)).deriv
  rw [hderivCorrected] at hmonoCorrected
  have hnonneg : 0 ≤ deriv (deriv f - ell) x :=
    hmonoCorrected.deriv_nonneg
  have hdfDiff : Differentiable ℝ (deriv f) := hreg.differentiable_deriv_two
  have hellDeriv (y : ℝ) : HasDerivAt ell k y := by
    dsimp [ell]
    exact hasDerivAt_const_mul (x := y) k
  have htarget :
      deriv (deriv f - ell) x = deriv (deriv f) x - k :=
    ((hdfDiff x).hasDerivAt.sub (hellDeriv x)).deriv
  rw [htarget] at hnonneg
  change k ≤ deriv (deriv f) x
  exact sub_nonneg.mp hnonneg

/-- A globally `C²`, `k`-strongly convex function has directional Hessian
quadratic form at least `k ‖v‖²` in every direction.

The proof is deliberately a composition of the three preceding canonical
leaves: restrict strong convexity to the affine line, use the one-dimensional
second-derivative bound, and identify that affine-line second derivative with
`iteratedFDeriv`.  No matrix-valued Hessian abstraction is introduced. -/
theorem iteratedFDeriv_two_ge_of_strongConvexOn_univ
    {E : Type*} [NormedAddCommGroup E] [NormedSpace ℝ E]
    {V : E → ℝ} {k : ℝ}
    (hV : StrongConvexOn (Set.univ : Set E) k V)
    (hreg : ContDiff ℝ 2 V) (x v : E) :
    k * ‖v‖ ^ 2 ≤ iteratedFDeriv ℝ 2 V x ![v, v] := by
  have hlineStrong := strongConvexOn_affineLine hV x v
  have hpathReg : ContDiff ℝ 2 (fun t : ℝ => x + t • v) :=
    contDiff_const.add (contDiff_id.smul_const v)
  have hlineReg : ContDiff ℝ 2 (fun t : ℝ => V (x + t • v)) :=
    hreg.fun_comp hpathReg
  have h1d := deriv2_ge_of_strongConvexOn_univ hlineStrong hlineReg 0
  rw [AutoSamplingTheory.TechnicalLemmas.Analysis.Calculus.LineDeriv.deriv2_affineLine_eq_iteratedFDeriv_two
    hreg] at h1d
  exact h1d

/-- A strongly convex potential with nonnegative modulus gives a log-concave
unnormalized Gibbs density shape. -/
theorem logConcaveOn_exp_neg_of_strongConvexOn
    {E : Type*} [NormedAddCommGroup E] [NormedSpace ℝ E]
    {s : Set E} {V : E → ℝ} {k : ℝ}
    (hV : StrongConvexOn s k V) (hk : 0 ≤ k) :
    LogConcavity.LogConcaveOn s (fun x => Real.exp (-V x)) :=
  LogConcavity.logConcaveOn_exp_neg_of_convexOn
    (convexOn_of_strongConvexOn_nonneg hV hk)

/-- Positive scalar normalization preserves the log-concavity of a Gibbs shape
whose potential is strongly convex with nonnegative modulus. -/
theorem logConcaveOn_const_mul_exp_neg_of_strongConvexOn
    {E : Type*} [NormedAddCommGroup E] [NormedSpace ℝ E]
    {s : Set E} {V : E → ℝ} {k c : ℝ}
    (hV : StrongConvexOn s k V) (hk : 0 ≤ k) (hc : 0 < c) :
    LogConcavity.LogConcaveOn s (fun x => c * Real.exp (-V x)) :=
  LogConcavity.logConcaveOn_const_mul_exp_neg_of_convexOn
    (convexOn_of_strongConvexOn_nonneg hV hk) hc

/-- A strongly convex function with a global minimizer has a centered quadratic
lower bound.

The constant `k / 4` is the midpoint consequence of Mathlib's
`StrongConvexOn` convention.  It is intentionally not the sharp `k / 2`
first-order/subgradient bound, because this leaf requires no differentiability
or limiting argument and is enough for Gibbs-tail integrability. -/
theorem centered_quadratic_lower_bound_of_strongConvexOn_minimizer
    {E : Type*} [NormedAddCommGroup E] [NormedSpace ℝ E]
    {V : E → ℝ} {k : ℝ} (hV : StrongConvexOn (Set.univ : Set E) k V)
    (x₀ : E) (hx₀ : IsMinOn V (Set.univ : Set E) x₀) :
    ∀ x : E, V x₀ + (k / 4) * ‖x - x₀‖ ^ 2 ≤ V x := by
  intro x
  have hx₀_min : ∀ y : E, V x₀ ≤ V y := isMinOn_univ_iff.mp hx₀
  have hmid_min : V x₀ ≤ V ((1 / 2 : ℝ) • x₀ + (1 / 2 : ℝ) • x) := hx₀_min _
  have hstrong :=
    hV.2 (by simp : x₀ ∈ (Set.univ : Set E)) (by simp : x ∈ (Set.univ : Set E))
      (by norm_num : 0 ≤ (1 / 2 : ℝ)) (by norm_num : 0 ≤ (1 / 2 : ℝ))
      (by norm_num : (1 / 2 : ℝ) + (1 / 2 : ℝ) = 1)
  have hstrong' :
      V ((1 / 2 : ℝ) • x₀ + (1 / 2 : ℝ) • x) ≤
        (1 / 2 : ℝ) * V x₀ + (1 / 2 : ℝ) * V x - (k / 8) * ‖x - x₀‖ ^ 2 := by
    rw [norm_sub_rev x₀ x] at hstrong
    convert hstrong using 1
    · simp [smul_eq_mul]
      ring_nf
  have hle := hmid_min.trans hstrong'
  nlinarith

end StrongConvexity
end Geometry
end TechnicalLemmas
end AutoSamplingTheory
