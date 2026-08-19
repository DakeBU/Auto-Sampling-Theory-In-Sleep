import AutoSamplingTheory.TechnicalLemmas.Measure.TransportGluing

namespace AutoSamplingTheory.Tests.TransportGluing

open MeasureTheory
open AutoSamplingTheory.TechnicalLemmas.Measure.TransportGluing

#check gluingMeasure
#check fst_gluingMeasure

example {α : Type*} [MeasurableSpace α] [StandardBorelSpace α] [Nonempty α]
    (γ₁₂ γ₂₃ : Measure (α × α)) [SFinite γ₁₂] [IsFiniteMeasure γ₂₃] :
    (gluingMeasure γ₁₂ γ₂₃).fst = γ₁₂ :=
  fst_gluingMeasure γ₁₂ γ₂₃

end AutoSamplingTheory.Tests.TransportGluing
