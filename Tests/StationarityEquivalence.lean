import AutoSamplingTheory.TechnicalLemmas.StochasticProcesses.StationarityEquivalence

namespace AutoSamplingTheory.Tests.StationarityEquivalence

open MeasureTheory
open AutoSamplingTheory.TechnicalLemmas.StochasticProcesses
open OperatorGenerator OperatorGeneratorDomain
open StationarityEquivalence

noncomputable section

#check chewi_proposition_1_2_7_invariant_implies_generator_zero
#check chewi_proposition_1_2_7_generator_zero_implies_invariant

example {M : Type*} [NormedAddCommGroup M] [NormedSpace ℝ M]
    (S : ContinuousLinearSemigroup M) (ell : M →L[ℝ] ℝ)
    (hinv : ∀ (t : ℝ≥0) (f : M), ell (S.op t f) = ell f)
    (f : generatorDomainSubmodule S) :
    ell (rightGenerator S f) = 0 :=
  chewi_proposition_1_2_7_invariant_implies_generator_zero S ell hinv f

example {E : Type*} [MeasurableSpace E]
    {P : ℝ → (E → ℝ) → E → ℝ}
    {generator : (E → ℝ) → E → ℝ}
    {domain : Set (E → ℝ)} {μ : Measure E}
    (hsemigroup :
      WeakGenerator.IntegratedSemigroupGeneratorContract P generator domain μ)
    (hzero : ∀ f ∈ domain, ∫ x, generator f x ∂μ = 0) :
    WeakGenerator.IsInvariantOn P μ domain :=
  chewi_proposition_1_2_7_generator_zero_implies_invariant hsemigroup hzero

end

end AutoSamplingTheory.Tests.StationarityEquivalence
