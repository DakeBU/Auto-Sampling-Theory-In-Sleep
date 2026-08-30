import AutoSamplingTheory.TechnicalLemmas.StochasticProcesses.CarreDuChamp
import Mathlib.Analysis.Calculus.ContDiff.Basic
import Mathlib.Analysis.Calculus.Deriv.Basic

/-!
# Generator form of the diffusion chain rule

Immediately after Chewi Definition 2.2.13, Eq. (2.2.15) gives the equivalent
source formulation

`L (φ ∘ f) = φ'(f) L f + φ''(f) Γ(f,f)`

for observables in the relevant generator / carré-du-champ domain and a smooth
scalar function `φ`.

Chewi leaves the equivalence between this identity and the carré-du-champ
composition rule Eq. (2.2.14) to Exercise 2.8.  This module therefore records
the generator formulation as its own explicit property.  It does not derive it
from `DiffusionChainRuleOn` and does not claim the Exercise 2.8 equivalence.

As in the carré-du-champ formulation, Samplinglib keeps the observable domain
explicit because the underlying Lean functions `generator` and
`carreDuChamp` are total even when the mathematical operator domain is not.
-/

namespace AutoSamplingTheory
namespace TechnicalLemmas
namespace StochasticProcesses
namespace GeneratorDiffusionChainRule

open Set

noncomputable section

/-- Source-normalized generator form of Chewi Eq. (2.2.15).

For every observable `f` in `domain` and every smooth scalar map `phi`, scalar
functional calculus remains in `domain` and the generator satisfies

`L(phi ∘ f) = phi'(f) Lf + phi''(f) Gamma(f,f)`.

The first and second derivatives are represented by Mathlib's total `deriv`;
the source smoothness hypothesis is retained explicitly by
`ContDiff ℝ ⊤ phi`. -/
structure GeneratorDiffusionChainRuleOn
    {X : Type*}
    (generator : (X → ℝ) →ₗ[ℝ] (X → ℝ))
    (domain : Set (X → ℝ)) : Prop where
  comp_mem :
    ∀ {f : X → ℝ}, f ∈ domain →
      ∀ {phi : ℝ → ℝ}, ContDiff ℝ (⊤ : ℕ∞) phi →
        (phi ∘ f) ∈ domain
  chain_rule :
    ∀ {f : X → ℝ}, f ∈ domain →
      ∀ {phi : ℝ → ℝ}, ContDiff ℝ (⊤ : ℕ∞) phi →
        generator (phi ∘ f) =
          fun x =>
            deriv phi (f x) * generator f x +
              deriv (deriv phi) (f x) *
                CarreDuChamp.carreDuChamp generator f f x

/-- Smooth scalar functional calculus stays inside the declared generator
observable domain. -/
theorem comp_mem
    {X : Type*}
    {generator : (X → ℝ) →ₗ[ℝ] (X → ℝ)}
    {domain : Set (X → ℝ)}
    (h : GeneratorDiffusionChainRuleOn generator domain)
    {f : X → ℝ} (hf : f ∈ domain)
    {phi : ℝ → ℝ} (hphi : ContDiff ℝ (⊤ : ℕ∞) phi) :
    (phi ∘ f) ∈ domain :=
  h.comp_mem hf hphi

/-- Function-valued generator chain rule from Chewi Eq. (2.2.15). -/
theorem generator_comp_eq
    {X : Type*}
    {generator : (X → ℝ) →ₗ[ℝ] (X → ℝ)}
    {domain : Set (X → ℝ)}
    (h : GeneratorDiffusionChainRuleOn generator domain)
    {f : X → ℝ} (hf : f ∈ domain)
    {phi : ℝ → ℝ} (hphi : ContDiff ℝ (⊤ : ℕ∞) phi) :
    generator (phi ∘ f) =
      fun x =>
        deriv phi (f x) * generator f x +
          deriv (deriv phi) (f x) *
            CarreDuChamp.carreDuChamp generator f f x :=
  h.chain_rule hf hphi

/-- Pointwise extraction of the generator diffusion chain rule. -/
theorem generator_comp_apply_eq
    {X : Type*}
    {generator : (X → ℝ) →ₗ[ℝ] (X → ℝ)}
    {domain : Set (X → ℝ)}
    (h : GeneratorDiffusionChainRuleOn generator domain)
    {f : X → ℝ} (hf : f ∈ domain)
    {phi : ℝ → ℝ} (hphi : ContDiff ℝ (⊤ : ℕ∞) phi)
    (x : X) :
    generator (phi ∘ f) x =
      deriv phi (f x) * generator f x +
        deriv (deriv phi) (f x) *
          CarreDuChamp.carreDuChamp generator f f x := by
  exact congrFun (generator_comp_eq h hf hphi) x

/-- Source-shaped pointwise version with named derivative fields.

`phiPrime` and `phiSecond` are not additional smoothness assumptions: the two
`HasDerivAt` families only identify the total functions `deriv phi` and
`deriv phiPrime` with the derivative names used in paper mathematics.  The
source's smooth scalar hypothesis remains `hphiSmooth`. -/
theorem generator_comp_apply_eq_of_named_derivatives
    {X : Type*}
    {generator : (X → ℝ) →ₗ[ℝ] (X → ℝ)}
    {domain : Set (X → ℝ)}
    (h : GeneratorDiffusionChainRuleOn generator domain)
    {f : X → ℝ} (hf : f ∈ domain)
    {phi phiPrime phiSecond : ℝ → ℝ}
    (hphiSmooth : ContDiff ℝ (⊤ : ℕ∞) phi)
    (hphiPrime : ∀ r : ℝ, HasDerivAt phi (phiPrime r) r)
    (hphiSecond : ∀ r : ℝ, HasDerivAt phiPrime (phiSecond r) r)
    (x : X) :
    generator (phi ∘ f) x =
      phiPrime (f x) * generator f x +
        phiSecond (f x) *
          CarreDuChamp.carreDuChamp generator f f x := by
  have hderiv : deriv phi = phiPrime := by
    funext r
    exact (hphiPrime r).deriv
  calc
    generator (phi ∘ f) x =
        deriv phi (f x) * generator f x +
          deriv (deriv phi) (f x) *
            CarreDuChamp.carreDuChamp generator f f x :=
      generator_comp_apply_eq h hf hphiSmooth x
    _ = phiPrime (f x) * generator f x +
          deriv phiPrime (f x) *
            CarreDuChamp.carreDuChamp generator f f x := by
      rw [(hphiPrime (f x)).deriv, hderiv]
    _ = phiPrime (f x) * generator f x +
          phiSecond (f x) *
            CarreDuChamp.carreDuChamp generator f f x := by
      rw [(hphiSecond (f x)).deriv]

end

end GeneratorDiffusionChainRule
end StochasticProcesses
end TechnicalLemmas
end AutoSamplingTheory
