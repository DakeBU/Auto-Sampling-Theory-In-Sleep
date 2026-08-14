import AutoSamplingTheory.TechnicalLemmas.StochasticProcesses.FiniteTimeGrid

open AutoSamplingTheory TechnicalLemmas StochasticProcesses
open scoped NNReal

#check FiniteTimeGrid.strictGrid_existsUnique_cell
#check FiniteTimeGrid.ElementaryAdaptedProcess.value_eq_coeff_of_mem_cell
#check FiniteTimeGrid.ElementaryAdaptedProcess.value_eq_zero_of_le_first
#check FiniteTimeGrid.ElementaryAdaptedProcess.value_eq_zero_of_last_lt
#check FiniteTimeGrid.dyadicMesh_tendsto_zero
#check FiniteTimeGrid.eventually_two_mul_dyadicMesh_lt
#check FiniteTimeGrid.eventually_dyadicMesh_lt
#check FiniteTimeGrid.dyadic_activeCell
#check FiniteTimeGrid.dyadic_activeCell_left_le
#check FiniteTimeGrid.dyadic_activeCell_right
#check FiniteTimeGrid.dyadic_previousCell_subset_leftNeighborhood

example :
    ∃! i : Fin 2,
      SampledElementaryApproximation.regularGridTimes 1 2 i.castSucc < (3 / 2 : ℝ≥0) ∧
        (3 / 2 : ℝ≥0) ≤
          SampledElementaryApproximation.regularGridTimes 1 2 i.succ := by
  apply FiniteTimeGrid.strictGrid_existsUnique_cell (by norm_num)
    (SampledElementaryApproximation.regularGridTimes_strictMono (by norm_num) 2)
  · norm_num [SampledElementaryApproximation.regularGridTimes]
  · norm_num [SampledElementaryApproximation.regularGridTimes, div_le_iff₀]
