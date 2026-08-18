import AutoSamplingTheory.TechnicalLemmas.Measure.KantorovichDual

namespace AutoSamplingTheory.Tests.KantorovichDual

open MeasureTheory
open AutoSamplingTheory.TechnicalLemmas.Measure.KantorovichDual

#check DualFeasible
#check dualFeasible_iff
#check DualFeasible.ae_prod
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

end AutoSamplingTheory.Tests.KantorovichDual
