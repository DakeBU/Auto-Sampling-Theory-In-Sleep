import AutoSamplingTheory.TechnicalLemmas.Measure.Transport
import Mathlib.MeasureTheory.Integral.Bochner.Basic
import Mathlib.MeasureTheory.Measure.Prod

/-!
# Kantorovich dual transport problem

This module states the integrable-potential dual problem used in Chewi,
Definition 1.3.6 and display (1.3.7). Strong duality and existence of optimal
potentials remain later theorems.

The dual constraint is deliberately pointwise. An almost-everywhere constraint
with respect to `mu.prod nu` would be too weak for weak duality against an
arbitrary coupling, since a coupling may be singular with respect to the
independent product measure.
-/

namespace AutoSamplingTheory
namespace TechnicalLemmas
namespace Measure
namespace KantorovichDual

open MeasureTheory

/-- A pair of integrable Kantorovich potentials is dual-feasible when
`f x + g y <= cost (x,y)` for every pair `(x,y)`.

The pointwise quantifier is mathematically essential: later weak duality must
integrate the constraint against an arbitrary coupling, not merely against the
independent product `mu.prod nu`. -/
def DualFeasible
    {E F : Type*} [MeasurableSpace E] [MeasurableSpace F]
    (cost : E × F → ℝ) (mu : Measure E) (nu : Measure F)
    (f : E → ℝ) (g : F → ℝ) : Prop :=
  Integrable f mu ∧ Integrable g nu ∧
    ∀ x y, f x + g y ≤ cost (x, y)

/-- The source-facing expansion of pointwise Kantorovich dual feasibility. -/
theorem dualFeasible_iff
    {E F : Type*} [MeasurableSpace E] [MeasurableSpace F]
    {cost : E × F → ℝ} {mu : Measure E} {nu : Measure F}
    {f : E → ℝ} {g : F → ℝ} :
    DualFeasible cost mu nu f g ↔
      Integrable f mu ∧ Integrable g nu ∧
        ∀ x y, f x + g y ≤ cost (x, y) :=
  Iff.rfl

/-- A pointwise feasible pair is, in particular, feasible almost everywhere
under the independent product measure. This is a compatibility lemma for
arguments that only need the weaker product-a.e. statement. -/
theorem DualFeasible.ae_prod
    {E F : Type*} [MeasurableSpace E] [MeasurableSpace F]
    {cost : E × F → ℝ} {mu : Measure E} {nu : Measure F}
    {f : E → ℝ} {g : F → ℝ}
    (h : DualFeasible cost mu nu f g) :
    ∀ᵐ z ∂mu.prod nu, f z.1 + g z.2 ≤ cost z :=
  Filter.Eventually.of_forall fun z => h.2.2 z.1 z.2

/-- Integrating an integrable first-coordinate observable against a coupling
recovers its integral against the first marginal. -/
theorem integral_fst_of_isCoupling
    {E F : Type*} [MeasurableSpace E] [MeasurableSpace F]
    {gamma : Measure (E × F)} {mu : Measure E} {nu : Measure F}
    (hgamma : Transport.IsCoupling gamma mu nu)
    {f : E → ℝ} (hf : Integrable f mu) :
    (∫ z, f z.1 ∂gamma) = ∫ x, f x ∂mu := by
  have hmap : Measure.map Prod.fst gamma = mu := by
    simpa [Measure.fst] using hgamma.1
  have hfmap : Integrable f (Measure.map Prod.fst gamma) := by
    simpa [hmap] using hf
  calc
    (∫ z, f z.1 ∂gamma) = ∫ x, f x ∂Measure.map Prod.fst gamma := by
      simpa only using
        (MeasureTheory.integral_map measurable_fst.aemeasurable
          hfmap.aestronglyMeasurable).symm
    _ = ∫ x, f x ∂mu := by rw [hmap]

/-- Integrating an integrable second-coordinate observable against a coupling
recovers its integral against the second marginal. -/
theorem integral_snd_of_isCoupling
    {E F : Type*} [MeasurableSpace E] [MeasurableSpace F]
    {gamma : Measure (E × F)} {mu : Measure E} {nu : Measure F}
    (hgamma : Transport.IsCoupling gamma mu nu)
    {g : F → ℝ} (hg : Integrable g nu) :
    (∫ z, g z.2 ∂gamma) = ∫ y, g y ∂nu := by
  have hmap : Measure.map Prod.snd gamma = nu := by
    simpa [Measure.snd] using hgamma.2
  have hgmap : Integrable g (Measure.map Prod.snd gamma) := by
    simpa [hmap] using hg
  calc
    (∫ z, g z.2 ∂gamma) = ∫ y, g y ∂Measure.map Prod.snd gamma := by
      simpa only using
        (MeasureTheory.integral_map measurable_snd.aemeasurable
          hgmap.aestronglyMeasurable).symm
    _ = ∫ y, g y ∂nu := by rw [hmap]

/-- Fixed-coupling weak duality.

For a pointwise dual-feasible pair and any coupling on which the real-valued
cost is integrable, the dual objective is bounded by that coupling's cost.
This is the exact local inequality needed before taking an infimum over
couplings and a supremum over feasible potentials. The integrability of the
real-valued cost is explicit because the Bochner integral is used here; a
later extended-nonnegative formulation can remove this finite-cost restriction. -/
theorem dualObjective_le_couplingIntegral
    {E F : Type*} [MeasurableSpace E] [MeasurableSpace F]
    {cost : E × F → ℝ} {mu : Measure E} {nu : Measure F}
    {f : E → ℝ} {g : F → ℝ}
    {gamma : Measure (E × F)}
    (hfeas : DualFeasible cost mu nu f g)
    (hgamma : Transport.IsCoupling gamma mu nu)
    (hcost : Integrable cost gamma) :
    (∫ x, f x ∂mu) + (∫ y, g y ∂nu) ≤ ∫ z, cost z ∂gamma := by
  have hfstMap : Measure.map Prod.fst gamma = mu := by
    simpa [Measure.fst] using hgamma.1
  have hsndMap : Measure.map Prod.snd gamma = nu := by
    simpa [Measure.snd] using hgamma.2
  have hfMap : Integrable f (Measure.map Prod.fst gamma) := by
    simpa [hfstMap] using hfeas.1
  have hgMap : Integrable g (Measure.map Prod.snd gamma) := by
    simpa [hsndMap] using hfeas.2.1
  have hfstInt : Integrable (fun z : E × F => f z.1) gamma := by
    simpa [Function.comp_def] using
      ((integrable_map_measure hfMap.aestronglyMeasurable
        measurable_fst.aemeasurable).1 hfMap)
  have hsndInt : Integrable (fun z : E × F => g z.2) gamma := by
    simpa [Function.comp_def] using
      ((integrable_map_measure hgMap.aestronglyMeasurable
        measurable_snd.aemeasurable).1 hgMap)
  calc
    (∫ x, f x ∂mu) + (∫ y, g y ∂nu) =
        ∫ z, f z.1 + g z.2 ∂gamma := by
      rw [integral_add hfstInt hsndInt,
        integral_fst_of_isCoupling hgamma hfeas.1,
        integral_snd_of_isCoupling hgamma hfeas.2.1]
    _ ≤ ∫ z, cost z ∂gamma :=
      integral_mono (hfstInt.add hsndInt) hcost
        (fun z => hfeas.2.2 z.1 z.2)

/-- Chewi Definition 1.3.6: the value of the Kantorovich dual optimization
problem. At the source's finite-second-moment quadratic cost, the feasible
objectives are nonempty and bounded above; those analytic facts are not hidden
inside this definition. -/
noncomputable def dualTransportValue
    {E F : Type*} [MeasurableSpace E] [MeasurableSpace F]
    (cost : E × F → ℝ) (mu : Measure E) (nu : Measure F) : ℝ :=
  sSup {r : ℝ | ∃ (f : E → ℝ) (g : F → ℝ),
    DualFeasible cost mu nu f g ∧
      r = (∫ x, f x ∂mu) + ∫ y, g y ∂nu}

/-- Chewi display (1.3.7): source-facing expansion of the dual value. -/
theorem dualTransportValue_eq_sSup
    {E F : Type*} [MeasurableSpace E] [MeasurableSpace F]
    (cost : E × F → ℝ) (mu : Measure E) (nu : Measure F) :
    dualTransportValue cost mu nu =
      sSup {r : ℝ | ∃ (f : E → ℝ) (g : F → ℝ),
        DualFeasible cost mu nu f g ∧
          r = (∫ x, f x ∂mu) + ∫ y, g y ∂nu} :=
  rfl

end KantorovichDual
end Measure
end TechnicalLemmas
end AutoSamplingTheory
