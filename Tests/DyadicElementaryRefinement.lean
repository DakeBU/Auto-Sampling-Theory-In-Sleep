import AutoSamplingTheory.TechnicalLemmas.StochasticProcesses.DyadicElementaryRefinement

open AutoSamplingTheory TechnicalLemmas StochasticProcesses

#check DyadicElementaryRefinement.refinementFactor
#check DyadicElementaryRefinement.coarseCell
#check DyadicElementaryRefinement.dyadicMesh_coarse_eq_factor_mul
#check DyadicElementaryRefinement.coarse_left_endpoint_le_fine_left
#check DyadicElementaryRefinement.refineDyadic
#check DyadicElementaryRefinement.refineDyadic_value_eq
#check DyadicElementaryRefinement.refineDyadic_toLp_eq
#check DyadicElementaryRefinement.sum_brownianIncrements_block
#check DyadicElementaryRefinement.refineDyadic_elementaryItoIntegral_eq
#check DyadicElementaryRefinement.refineDyadic_terminalToLp_eq
#check DyadicElementaryRefinement.commonRefinement_times_eq
#check DyadicElementaryRefinement.norm_terminal_sub_eq_process_sub

example : DyadicElementaryRefinement.refinementFactor 0 1 = 2 := by
  norm_num [DyadicElementaryRefinement.refinementFactor]

example : DyadicElementaryRefinement.refinementFactor 1 3 = 4 := by
  norm_num [DyadicElementaryRefinement.refinementFactor]

example (j : Fin 2) :
    (DyadicElementaryRefinement.coarseCell (show 0 ≤ 1 by omega) j).val = 0 := by
  simp [DyadicElementaryRefinement.coarseCell,
    DyadicElementaryRefinement.refinementFactor]
