import AutoSamplingTheory.TechnicalLemmas.StochasticProcesses.ElementaryItoEmbedding

namespace AutoSamplingTheory.Tests.ElementaryItoEmbedding

open TechnicalLemmas.StochasticProcesses
open ElementaryItoEmbedding

#check processFunction_stronglyMeasurable
#check value_stronglyProgressive
#check valueBound
#check abs_value_le_valueBound
#check value_memLp_two
#check toProgressiveL2
#check toLp_add
#check toLp_sub
#check toLp_smul

end AutoSamplingTheory.Tests.ElementaryItoEmbedding
