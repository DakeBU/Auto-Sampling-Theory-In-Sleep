import AutoSamplingTheory.TechnicalLemmas.Measure.DisplacementInterpolation

/-!
# Quadratic optimal transport maps

This module makes the Monge object explicit.  A measurable map `T` induces the
joint law `(id, T) # mu`; when that graph coupling is quadratic-optimal and its
second marginal is `nu`, we call `T` a quadratic-optimal transport map.

Keeping the graph coupling as a first-class object lets later Brenier theorems
state and prove separately:

* existence of an optimal map,
* uniqueness of the optimal plan,
* almost-everywhere uniqueness of the optimal map.
-/

namespace AutoSamplingTheory
namespace TechnicalLemmas
namespace Measure
namespace QuadraticOptimalMap

open MeasureTheory
open DisplacementInterpolation Transport

noncomputable section

/-- Joint law induced by a measurable transport map. -/
noncomputable def graphCoupling
    {E F : Type*} [MeasurableSpace E] [MeasurableSpace F]
    (T : E → F) (mu : Measure E) : Measure (E × F) :=
  Measure.map (fun x => (x, T x)) mu

/-- A graph pushforward has first marginal `mu` and second marginal `nu` as soon
as `T` is measurable and pushes `mu` to `nu`. -/
theorem isCoupling_graphCoupling
    {E F : Type*} [MeasurableSpace E] [MeasurableSpace F]
    {T : E → F} {mu : Measure E} {nu : Measure F}
    (hT : Measurable T) (hmap : Measure.map T mu = nu) :
    IsCoupling (graphCoupling T mu) mu nu := by
  have hGraph : Measurable (fun x : E => (x, T x)) :=
    measurable_id.prod_mk hT
  constructor
  · rw [Measure.fst, graphCoupling, Measure.map_map hGraph measurable_fst]
    simpa [Function.comp_def]
  · rw [Measure.snd, graphCoupling, Measure.map_map hGraph measurable_snd]
    simpa [Function.comp_def] using hmap

/-- A quadratic-optimal transport map is a measurable map whose pushforward is
the prescribed target and whose induced graph coupling attains the quadratic
Kantorovich optimum. -/
def IsQuadraticOptimalMap
    {E : Type*} [NormedAddCommGroup E]
    [MeasurableSpace E]
    (T : E → E) (mu nu : Measure E) : Prop :=
  Measurable T ∧
    Measure.map T mu = nu ∧
    IsQuadraticOptimalCoupling (graphCoupling T mu) mu nu

/-- Expansion of the optimal-map interface. -/
theorem isQuadraticOptimalMap_iff
    {E : Type*} [NormedAddCommGroup E]
    [MeasurableSpace E]
    (T : E → E) (mu nu : Measure E) :
    IsQuadraticOptimalMap T mu nu ↔
      Measurable T ∧
        Measure.map T mu = nu ∧
        IsQuadraticOptimalCoupling (graphCoupling T mu) mu nu :=
  Iff.rfl

/-- Package a measurable pushforward map as optimal once its graph coupling is
identified with an already optimal coupling. -/
theorem isQuadraticOptimalMap_of_eq_graphCoupling
    {E : Type*} [NormedAddCommGroup E]
    [FiniteDimensional ℝ E] [MeasurableSpace E] [BorelSpace E]
    {T : E → E} {mu nu : Measure E} {gamma : Measure (E × E)}
    (hT : Measurable T)
    (hmap : Measure.map T mu = nu)
    (hopt : IsQuadraticOptimalCoupling gamma mu nu)
    (hgamma : gamma = graphCoupling T mu) :
    IsQuadraticOptimalMap T mu nu := by
  refine ⟨hT, hmap, ?_⟩
  rw [← hgamma]
  exact hopt

/-- Forgetting the map packaging recovers the optimality of its graph coupling. -/
theorem isQuadraticOptimalCoupling_graphCoupling
    {E : Type*} [NormedAddCommGroup E]
    [FiniteDimensional ℝ E] [MeasurableSpace E] [BorelSpace E]
    {T : E → E} {mu nu : Measure E}
    (hT : IsQuadraticOptimalMap T mu nu) :
    IsQuadraticOptimalCoupling (graphCoupling T mu) mu nu :=
  hT.2.2

end

end QuadraticOptimalMap
end Measure
end TechnicalLemmas
end AutoSamplingTheory
