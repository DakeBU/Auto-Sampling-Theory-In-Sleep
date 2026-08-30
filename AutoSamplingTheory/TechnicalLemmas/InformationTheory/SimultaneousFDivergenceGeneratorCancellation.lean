import AutoSamplingTheory.TechnicalLemmas.StochasticProcesses.CarreDuChamp
import Mathlib.Tactic.Ring

/-!
# Generator cancellation in simultaneous f-divergence dissipation

Chewi Theorem 8.3.1 contains a pointwise algebraic cancellation after the two
adjoint equations have moved the time derivatives onto the generator.  Writing
`rho = dμ/dν`, the relevant expression is

`rho * L(f' ∘ rho) - L((f' ∘ rho) * rho) + L(f ∘ rho)`.

Three independently meaningful diffusion identities reduce it:

1. the carré-du-champ product reconstruction
   `L(uv) = u Lv + v Lu + 2 Γ(u,v)`;
2. the generator scalar chain rule
   `L(f ∘ rho) = f'(rho) L rho + f''(rho) Γ(rho,rho)`;
3. the carré-du-champ scalar chain rule
   `Γ(f' ∘ rho,rho) = f''(rho) Γ(rho,rho)`.

This module proves only their pointwise algebraic join.  It does not assume or
prove the adjoint evolution, density-ratio regularity, differentiation under an
integral, or the final measure-level dissipation theorem.
-/

namespace AutoSamplingTheory
namespace TechnicalLemmas
namespace InformationTheory
namespace SimultaneousFDivergenceGeneratorCancellation

noncomputable section

open StochasticProcesses

/-- The pointwise cancellation used in the proof of Chewi Theorem 8.3.1.

The three hypotheses deliberately expose the exact parent identities instead
of packaging the final dissipation formula as an assumption.  Later assembly
can discharge them from the canonical product reconstruction, generator chain
rule, and carré-du-champ chain rule nodes. -/
theorem generator_terms_eq_neg_fSecond_mul_carreDuChamp
    {X : Type*}
    (generator : (X → ℝ) →ₗ[ℝ] (X → ℝ))
    (rho : X → ℝ)
    (f fPrime fSecond : ℝ → ℝ)
    (x : X)
    (hProduct :
      generator ((fPrime ∘ rho) * rho) x =
        fPrime (rho x) * generator rho x +
          rho x * generator (fPrime ∘ rho) x +
          2 * CarreDuChamp.carreDuChamp generator (fPrime ∘ rho) rho x)
    (hGeneratorChain :
      generator (f ∘ rho) x =
        fPrime (rho x) * generator rho x +
          fSecond (rho x) *
            CarreDuChamp.carreDuChamp generator rho rho x)
    (hGammaChain :
      CarreDuChamp.carreDuChamp generator (fPrime ∘ rho) rho x =
        fSecond (rho x) *
          CarreDuChamp.carreDuChamp generator rho rho x) :
    rho x * generator (fPrime ∘ rho) x -
          generator ((fPrime ∘ rho) * rho) x +
          generator (f ∘ rho) x =
      -fSecond (rho x) *
        CarreDuChamp.carreDuChamp generator rho rho x := by
  rw [hProduct, hGeneratorChain, hGammaChain]
  ring

/-- The same cancellation with the product identity already normalized to the
function order `rho * (f' ∘ rho)`.  This adapter is convenient when an adjoint
calculation produces the product in the opposite commutative order. -/
theorem generator_terms_eq_neg_fSecond_mul_carreDuChamp_of_rho_mul
    {X : Type*}
    (generator : (X → ℝ) →ₗ[ℝ] (X → ℝ))
    (rho : X → ℝ)
    (f fPrime fSecond : ℝ → ℝ)
    (x : X)
    (hProduct :
      generator (rho * (fPrime ∘ rho)) x =
        rho x * generator (fPrime ∘ rho) x +
          fPrime (rho x) * generator rho x +
          2 * CarreDuChamp.carreDuChamp generator rho (fPrime ∘ rho) x)
    (hGeneratorChain :
      generator (f ∘ rho) x =
        fPrime (rho x) * generator rho x +
          fSecond (rho x) *
            CarreDuChamp.carreDuChamp generator rho rho x)
    (hGammaChain :
      CarreDuChamp.carreDuChamp generator (fPrime ∘ rho) rho x =
        fSecond (rho x) *
          CarreDuChamp.carreDuChamp generator rho rho x) :
    rho x * generator (fPrime ∘ rho) x -
          generator (rho * (fPrime ∘ rho)) x +
          generator (f ∘ rho) x =
      -fSecond (rho x) *
        CarreDuChamp.carreDuChamp generator rho rho x := by
  rw [hProduct, hGeneratorChain]
  rw [CarreDuChamp.carreDuChamp_comm generator rho (fPrime ∘ rho)]
  rw [hGammaChain]
  ring

end

end SimultaneousFDivergenceGeneratorCancellation
end InformationTheory
end TechnicalLemmas
end AutoSamplingTheory
