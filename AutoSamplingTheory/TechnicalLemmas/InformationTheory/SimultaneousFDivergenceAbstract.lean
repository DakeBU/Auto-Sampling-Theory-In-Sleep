import AutoSamplingTheory.TechnicalLemmas.StochasticProcesses.DiffusionChainRule
import Mathlib.Tactic

/-!
# Abstract generator cancellation for simultaneous f-divergence

This file isolates the pointwise algebra in the proof of Chewi Theorem 8.3.1
after the time derivative has already been moved through the adjoint generator.
It does not formalize time differentiation, an adjoint operator, integration,
or the Fokker--Planck equation.

At a fixed time, write `rho = mu / nu`.  The source adjoint calculation contains

`L(f' ∘ rho) * mu - L((f' ∘ rho) * rho) * nu + L(f ∘ rho) * nu`.

The cancellation has three mathematical parents:

1. the product reconstruction from the carré du champ,
   `L(u v) = u L v + v L u + 2 Γ(u,v)`;
2. the generator-form diffusion chain rule for `L(f ∘ rho)`;
3. the carré-du-champ chain rule for `Γ(f' ∘ rho,rho)`.

Parent (3) is consumed directly from the corrected `DiffusionChainRuleOn` branch.
Parent (1) already has its own canonical Frontier Cell (#220), but #220 and the
current #219 parent are parallel unmerged branches.  To avoid duplicating the
#220 theorem, this module keeps the exact product equality as an explicit parent
contract until stabilization can discharge it from the canonical declaration.
Parent (2) is likewise explicit until the separate generator-chain node is
stabilized / Exercise 2.8 is formalized.
-/

namespace AutoSamplingTheory
namespace TechnicalLemmas
namespace InformationTheory
namespace SimultaneousFDivergenceAbstract

open StochasticProcesses

noncomputable section

/-- Factorized-density form of the pointwise cancellation in the proof of
Chewi Theorem 8.3.1.

The first density has already been written as `rho * nu`.  `hProduct` is exactly
the canonical #220 product-reconstruction identity specialized to
`u = fPrime ∘ rho` and `v = rho`; it is kept as a parent contract here only
because the two prerequisite PRs are not yet on one integration branch.
`hGeneratorChain` is precisely the instance of generator chain rule (2.2.15)
used by the source proof.  The carré-du-champ chain rule
`Γ(f'∘rho,rho) = f''(rho) Γ(rho,rho)` is not assumed separately: it is obtained
from the canonical `DiffusionChainRuleOn` parent. -/
theorem factorized_source_pointwise_cancellation
    {X : Type*}
    (generator : (X → ℝ) →ₗ[ℝ] (X → ℝ))
    (domain : Set (X → ℝ))
    (hDiffusion : DiffusionChainRule.DiffusionChainRuleOn generator domain)
    (rho nu : X → ℝ)
    (hrho : rho ∈ domain)
    (f fPrime fSecond : ℝ → ℝ)
    (hfPrime : ∀ r : ℝ, HasDerivAt fPrime (fSecond r) r)
    (x : X)
    (hProduct :
      generator ((fPrime ∘ rho) * rho) x =
        2 * CarreDuChamp.carreDuChamp generator (fPrime ∘ rho) rho x +
          fPrime (rho x) * generator rho x +
          rho x * generator (fPrime ∘ rho) x)
    (hGeneratorChain :
      generator (f ∘ rho) x =
        fPrime (rho x) * generator rho x +
          fSecond (rho x) *
            CarreDuChamp.carreDuChamp generator rho rho x) :
    generator (fPrime ∘ rho) x * (rho x * nu x) -
          generator ((fPrime ∘ rho) * rho) x * nu x +
          generator (f ∘ rho) x * nu x =
      -fSecond (rho x) *
        CarreDuChamp.carreDuChamp generator rho rho x * nu x := by
  have hgamma :=
    DiffusionChainRule.carreDuChamp_fPrime_comp_self_apply
      hDiffusion hrho hfPrime x
  rw [hProduct, hGeneratorChain, hgamma]
  ring

/-- Source-shaped pointwise cancellation with the numerator density `mu`
retained explicitly.

The only density relation used here is the factorization `mu(x)=rho(x)nu(x)`,
which in the final theorem will come from `rho = d mu / d nu` (or, in a common
reference-density presentation, `rho = mu / nu`). -/
theorem source_pointwise_cancellation
    {X : Type*}
    (generator : (X → ℝ) →ₗ[ℝ] (X → ℝ))
    (domain : Set (X → ℝ))
    (hDiffusion : DiffusionChainRule.DiffusionChainRuleOn generator domain)
    (mu rho nu : X → ℝ)
    (hrho : rho ∈ domain)
    (f fPrime fSecond : ℝ → ℝ)
    (hfPrime : ∀ r : ℝ, HasDerivAt fPrime (fSecond r) r)
    (x : X)
    (hmu : mu x = rho x * nu x)
    (hProduct :
      generator ((fPrime ∘ rho) * rho) x =
        2 * CarreDuChamp.carreDuChamp generator (fPrime ∘ rho) rho x +
          fPrime (rho x) * generator rho x +
          rho x * generator (fPrime ∘ rho) x)
    (hGeneratorChain :
      generator (f ∘ rho) x =
        fPrime (rho x) * generator rho x +
          fSecond (rho x) *
            CarreDuChamp.carreDuChamp generator rho rho x) :
    generator (fPrime ∘ rho) x * mu x -
          generator ((fPrime ∘ rho) * rho) x * nu x +
          generator (f ∘ rho) x * nu x =
      -fSecond (rho x) *
        CarreDuChamp.carreDuChamp generator rho rho x * nu x := by
  rw [hmu]
  exact factorized_source_pointwise_cancellation
    generator domain hDiffusion rho nu hrho f fPrime fSecond hfPrime x
      hProduct hGeneratorChain

end

end SimultaneousFDivergenceAbstract
end InformationTheory
end TechnicalLemmas
end AutoSamplingTheory
