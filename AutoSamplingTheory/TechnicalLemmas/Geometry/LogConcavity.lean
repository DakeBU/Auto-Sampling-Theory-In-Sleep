import Mathlib.Analysis.Convex.SpecificFunctions.Basic

/-!
# Log-concavity leaves

Small convex-analysis API for Chewi-style log-concave sampling foundations.
This file intentionally starts with definition-level and one-dimensional
sanity leaves; density normalization and Prekopa--Leindler stay separate.
-/

namespace AutoSamplingTheory
namespace TechnicalLemmas
namespace Geometry
namespace LogConcavity

open Set

/-- A positive real-valued function is log-concave on `s` when its logarithm is
concave on `s`.

The positivity condition is explicit because Chewi-style density arguments
usually need it separately from the convex-analysis statement about
`Real.log ∘ f`.
-/
def LogConcaveOn {E : Type*} [AddCommMonoid E] [Module ℝ E]
    (s : Set E) (f : E → ℝ) : Prop :=
  (∀ x ∈ s, 0 < f x) ∧ ConcaveOn ℝ s (fun x => Real.log (f x))

theorem logConcaveOn_iff {E : Type*} [AddCommMonoid E] [Module ℝ E]
    {s : Set E} {f : E → ℝ} :
    LogConcaveOn s f ↔
      (∀ x ∈ s, 0 < f x) ∧ ConcaveOn ℝ s (fun x => Real.log (f x)) :=
  Iff.rfl

theorem logConcaveOn_of_concave_log {E : Type*} [AddCommMonoid E] [Module ℝ E]
    {s : Set E} {f : E → ℝ}
    (hpos : ∀ x ∈ s, 0 < f x)
    (hlog : ConcaveOn ℝ s (fun x => Real.log (f x))) :
    LogConcaveOn s f :=
  ⟨hpos, hlog⟩

theorem LogConcaveOn.pos {E : Type*} [AddCommMonoid E] [Module ℝ E]
    {s : Set E} {f : E → ℝ}
    (hf : LogConcaveOn s f) {x : E} (hx : x ∈ s) :
    0 < f x :=
  hf.1 x hx

theorem LogConcaveOn.concaveOn_log {E : Type*} [AddCommMonoid E] [Module ℝ E]
    {s : Set E} {f : E → ℝ}
    (hf : LogConcaveOn s f) :
    ConcaveOn ℝ s (fun x => Real.log (f x)) :=
  hf.2

theorem LogConcaveOn.convex_domain {E : Type*} [AddCommMonoid E] [Module ℝ E]
    {s : Set E} {f : E → ℝ}
    (hf : LogConcaveOn s f) :
    Convex ℝ s :=
  hf.concaveOn_log.1

theorem LogConcaveOn.subset {E : Type*} [AddCommMonoid E] [Module ℝ E]
    {s t : Set E} {f : E → ℝ}
    (hf : LogConcaveOn s f) (hts : t ⊆ s) (ht : Convex ℝ t) :
    LogConcaveOn t f :=
  ⟨fun x hx => hf.pos (x := x) (hts hx), hf.concaveOn_log.subset hts ht⟩

/-- Multiplication by a positive constant preserves log-concavity. -/
theorem LogConcaveOn.const_mul {E : Type*} [AddCommMonoid E] [Module ℝ E]
    {s : Set E} {f : E → ℝ}
    (hf : LogConcaveOn s f) {c : ℝ} (hc : 0 < c) :
    LogConcaveOn s (fun x => c * f x) := by
  refine ⟨fun x hx => mul_pos hc (hf.pos (x := x) hx), ?_⟩
  have hconst : ConcaveOn ℝ s (fun _ : E => Real.log c) :=
    concaveOn_const (Real.log c) hf.convex_domain
  have hsum : ConcaveOn ℝ s (fun x => Real.log c + Real.log (f x)) := by
    simpa only [Pi.add_apply] using hconst.add hf.concaveOn_log
  refine hsum.congr ?_
  intro x hx
  simpa using (Real.log_mul hc.ne' (hf.pos (x := x) hx).ne').symm

/-- A positive constant function is log-concave on every convex domain. -/
theorem logConcaveOn_const {E : Type*} [AddCommMonoid E] [Module ℝ E]
    {s : Set E} {c : ℝ} (hc : 0 < c) (hs : Convex ℝ s) :
    LogConcaveOn s (fun _ : E => c) :=
  ⟨fun _ _ => hc, concaveOn_const (Real.log c) hs⟩

/-- If `V` is convex, then the unnormalized Gibbs shape `exp (-V)` is
log-concave. -/
theorem logConcaveOn_exp_neg_of_convexOn {E : Type*} [AddCommMonoid E] [Module ℝ E]
    {s : Set E} {V : E → ℝ} (hV : ConvexOn ℝ s V) :
    LogConcaveOn s (fun x => Real.exp (-V x)) := by
  refine ⟨fun _ _ => Real.exp_pos _, ?_⟩
  exact hV.neg.congr fun _ _ => by simp

/-- A positive multiple of the Gibbs shape of a convex potential is
log-concave.  This is the convex-analytic part of normalized Gibbs-density
bookkeeping; the measure/integral normalization proof is a separate leaf. -/
theorem logConcaveOn_const_mul_exp_neg_of_convexOn {E : Type*}
    [AddCommMonoid E] [Module ℝ E]
    {s : Set E} {V : E → ℝ} {c : ℝ}
    (hV : ConvexOn ℝ s V) (hc : 0 < c) :
    LogConcaveOn s (fun x => c * Real.exp (-V x)) :=
  (logConcaveOn_exp_neg_of_convexOn hV).const_mul hc

/-- The identity density on the positive ray is log-concave. -/
theorem logConcaveOn_id_Ioi :
    LogConcaveOn (Ioi (0 : ℝ)) (fun x : ℝ => x) :=
  ⟨fun _ hx => hx, strictConcaveOn_log_Ioi.concaveOn⟩

end LogConcavity
end Geometry
end TechnicalLemmas
end AutoSamplingTheory
