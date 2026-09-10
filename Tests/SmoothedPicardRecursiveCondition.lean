import AutoSamplingTheory.ExampleCases.SmoothedPicardHMC.RecursiveCondition

open AutoSamplingTheory.ExampleCases.SmoothedPicardHMC.RecursiveCondition

-- Exercise both conclusions at k=2 and an admissible smoothing parameter.
example : (2 : ℝ) / 2 ≤ 2 * (2 + 1 / 8 + 1) / (2 * 2 + 1 / 8) ∧
    (2 : ℝ) * (2 + 1 / 8 + 1) / (2 * 2 + 1 / 8) ≤ (4 / 5) * 2 :=
  contraction_bounds (k := 2) (h := 1 / 8) (by norm_num) (by norm_num) (by norm_num)

-- The paper's strict interval implies the frozen scalar hypotheses.
example {k h c : ℝ} (hk : 2 ≤ k) (hh : 0 < h) (hhc : h ≤ c)
    (hc : c < 1 / 4) :
    k / 2 ≤ k * (k + h + 1) / (2 * k + h) ∧
      k * (k + h + 1) / (2 * k + h) ≤ (4 / 5) * k :=
  contraction_bounds hk hh (hhc.trans_lt hc)

#print axioms contraction_bounds
#check @contraction_bounds
