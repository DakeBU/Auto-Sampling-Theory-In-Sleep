import AutoSamplingTheory.TechnicalLemmas.Measure.TransportGluing

namespace AutoSamplingTheory.Tests.TransportGluing

open MeasureTheory
open AutoSamplingTheory.TechnicalLemmas.Measure
open AutoSamplingTheory.TechnicalLemmas.Measure.TransportGluing

#check gluingMeasure
#check fst_gluingMeasure
#check map_snd_fst_gluingMeasure
#check exists_gluing_of_isCoupling

example {α : Type*} [MeasurableSpace α] [StandardBorelSpace α] [Nonempty α]
    (γ₁₂ γ₂₃ : Measure (α × α)) [SFinite γ₁₂] [IsFiniteMeasure γ₂₃] :
    (gluingMeasure γ₁₂ γ₂₃).fst = γ₁₂ :=
  fst_gluingMeasure γ₁₂ γ₂₃

example {α : Type*} [MeasurableSpace α] [StandardBorelSpace α] [Nonempty α]
    (γ₁₂ γ₂₃ : Measure (α × α)) [SFinite γ₁₂] [IsFiniteMeasure γ₂₃]
    (hshared : γ₁₂.snd = γ₂₃.fst) :
    Measure.map (fun p : ((α × α) × α) => (p.1.2, p.2))
        (gluingMeasure γ₁₂ γ₂₃) = γ₂₃ :=
  map_snd_fst_gluingMeasure γ₁₂ γ₂₃ hshared

example {α : Type*} [MeasurableSpace α] [StandardBorelSpace α] [Nonempty α]
    {μ₁ μ₂ μ₃ : Measure α}
    (γ₁₂ γ₂₃ : Measure (α × α))
    [IsProbabilityMeasure μ₁] [IsProbabilityMeasure μ₂] [IsProbabilityMeasure μ₃]
    (h₁₂ : Transport.IsCoupling γ₁₂ μ₁ μ₂)
    (h₂₃ : Transport.IsCoupling γ₂₃ μ₂ μ₃) :
    ∃ γ₁₂₃ : Measure ((α × α) × α),
      γ₁₂₃.fst = γ₁₂ ∧
      Measure.map (fun p : ((α × α) × α) => (p.1.2, p.2)) γ₁₂₃ = γ₂₃ :=
  exists_gluing_of_isCoupling γ₁₂ γ₂₃ h₁₂ h₂₃

end AutoSamplingTheory.Tests.TransportGluing
