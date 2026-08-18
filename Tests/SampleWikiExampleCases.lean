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

end SampleWikiExampleCases
end Tests
end AutoSamplingTheory
