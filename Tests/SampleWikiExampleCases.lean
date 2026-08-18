import AutoSamplingTheory.ExampleCases.SampleWiki

namespace AutoSamplingTheory
namespace Tests
namespace SampleWikiExampleCases

open ExampleCases.SampleWiki

example : admissibleForScientificGraph VerificationStage.assimilated :=
  assimilated_admissible

example : ¬ admissibleForScientificGraph VerificationStage.compiled :=
  compiled_not_admissible

example : ¬ admissibleForScientificGraph VerificationStage.discovered :=
  discovered_not_admissible

#check SourceIdentity
#check VerificationStage
#check TechnicalLemmas.Algebra.linear_growth_of_step_growth
#check TechnicalLemmas.Algebra.reciprocal_growth_implies_inverse_time_bound
#check ExampleCases.SampleWiki.Cases.IdealProximalChain.kl_rate_from_reciprocal_step

end SampleWikiExampleCases
end Tests
end AutoSamplingTheory
