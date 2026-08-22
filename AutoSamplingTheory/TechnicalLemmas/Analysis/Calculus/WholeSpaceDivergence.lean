import AutoSamplingTheory.TechnicalLemmas.Analysis.Calculus.Divergence
import Mathlib.Tactic

/-!
# Whole-space divergence exhaustion: cutoff cross term

The reusable radial-cutoff estimates in `Divergence` already show that for an
integrable vector field `G`,

`∫ ||D chi_R (G)|| -> 0`

as `R -> +∞`.  This file upgrades that scalar norm estimate to convergence of
the signed/Bochner cross-term integral itself.

This is the first thin join toward whole-space integration by parts.  It does
not yet combine the cutoff product-divergence identity with the main-term
limit; that remains the next node.
-/

namespace AutoSamplingTheory
namespace TechnicalLemmas
namespace Analysis
namespace Calculus
namespace WholeSpaceDivergence

open Filter MeasureTheory
open scoped Topology

noncomputable section

open Divergence

/-- The cutoff-gradient cross-term integral tends to zero whenever the source
vector field is integrable.

The proof is exactly the Bochner inequality
`||∫ h|| <= ∫ ||h||` followed by the already-compiled cutoff-gradient norm
limit. -/
theorem tendsto_integral_fderiv_radialSmoothCutoff_comp_toLp_apply
    {n : ℕ} {mu : Measure (Fin (n + 1) → ℝ)}
    {G : (Fin (n + 1) → ℝ) → Fin (n + 1) → ℝ}
    (hG : Integrable G mu) :
    Tendsto
      (fun R : ℝ =>
        ∫ x, fderiv ℝ
          (fun z => Cutoff.radialSmoothCutoff R
            (WithLp.toLp 2 z : EuclideanSpace ℝ (Fin (n + 1))))
          x (G x) ∂mu)
      atTop (𝓝 0) := by
  apply squeeze_zero_norm'
  · filter_upwards with R
    exact norm_integral_le_integral_norm _
  · exact tendsto_integral_norm_fderiv_radialSmoothCutoff_comp_toLp_apply hG

end

end WholeSpaceDivergence
end Calculus
end Analysis
end TechnicalLemmas
end AutoSamplingTheory
