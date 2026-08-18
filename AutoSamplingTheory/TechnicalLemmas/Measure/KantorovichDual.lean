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
