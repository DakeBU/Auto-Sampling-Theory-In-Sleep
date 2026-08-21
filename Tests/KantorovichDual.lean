import AutoSamplingTheory.TechnicalLemmas.Measure.KantorovichDual

namespace AutoSamplingTheory.Tests.KantorovichDual

open MeasureTheory
open AutoSamplingTheory.TechnicalLemmas.Measure.KantorovichDual
open AutoSamplingTheory.TechnicalLemmas.Measure.Transport

#check DualFeasible
#check dualFeasible_iff
#check DualFeasible.ae_prod
#check integral_fst_of_isCoupling
#check integral_snd_of_isCoupling
#check dualObjective_le_couplingIntegral
#check dualTransportValue
#check dualTransportValue_eq_sSup

example {E F : Type*} [MeasurableSpace E] [MeasurableSpace F]
    {cost : E × F → ℝ} {mu : Measure E} {nu : Measure F}
    {f : E → ℝ} {g : F → ℝ}
    (h : DualFeasible cost mu nu f g) (x : E) (y : F) :
    f x + g y ≤ cost (x, y) :=
  h.2.2 x y

example {E F : Type*} [MeasurableSpace E] [MeasurableSpace F]
    {cost : E × F → ℝ} {mu : Measure E} {nu : Measure F}
    {f : E → ℝ} {g : F → ℝ}
    (h : DualFeasible cost mu nu f g) :
    ∀ᵐ z ∂mu.prod nu, f z.1 + g z.2 ≤ cost z :=
  h.ae_prod

example {E F : Type*} [MeasurableSpace E] [MeasurableSpace F]
    {cost : E × F → ℝ} {mu : Measure E} {nu : Measure F}
    {f : E → ℝ} {g : F → ℝ} {gamma : Measure (E × F)}
    (hfeas : DualFeasible cost mu nu f g)
    (hgamma : IsCoupling gamma mu nu)
    (hcost : Integrable cost gamma) :
    (∫ x, f x ∂mu) + (∫ y, g y ∂nu) ≤ ∫ z, cost z ∂gamma :=
  dualObjective_le_couplingIntegral hfeas hgamma hcost

end AutoSamplingTheory.Tests.KantorovichDual
