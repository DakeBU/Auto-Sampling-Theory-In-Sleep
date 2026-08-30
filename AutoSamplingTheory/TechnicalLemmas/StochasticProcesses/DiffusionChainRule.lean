import AutoSamplingTheory.TechnicalLemmas.StochasticProcesses.CarreDuChamp
import Mathlib.Analysis.Calculus.ContDiff.Basic
import Mathlib.Analysis.Calculus.Deriv.Basic

/-!
# Diffusion chain rule for the carré du champ

Chewi Definition 2.2.13 characterizes diffusion semigroups by the scalar
functional-calculus identity

`Γ(φ ∘ f, g) = φ'(f) Γ(f,g)`

for observables in the carré-du-champ domain and a smooth scalar function `φ`.

Samplinglib's `CarreDuChamp.carreDuChamp` is intentionally a total algebraic
function, whereas the source statement is made on the domain of `Γ`.  This
module therefore keeps an explicit observable domain and records scalar
functional-calculus closure instead of silently treating every function as an
admissible observable.

The generator-form identity

`L (φ ∘ f) = φ'(f) L f + φ''(f) Γ(f,f)`

is not bundled into this interface.  Chewi states it as an equivalent
formulation and leaves the equivalence to Exercise 2.8; formalizing that
transport may need additional functional-calculus/domain hypotheses and is a
separate theorem cell.
-/

namespace AutoSamplingTheory
namespace TechnicalLemmas
namespace StochasticProcesses
namespace DiffusionChainRule

open Set

noncomputable section

/-- Source-normalized form of Chewi Definition 2.2.13 / Eq. (2.2.14).

`domain` is the declared domain on which the carré-du-champ calculus is meant
to be used.  The scalar map is quantified with the source's smoothness
hypothesis, represented by `ContDiff ℝ ⊤ phi`.  The derivative appearing in the
formula is Mathlib's `deriv phi`.

The property also records that scalar composition stays in the declared
observable domain.  This makes explicit the functional-calculus closure that
is implicit when the source writes `Γ(phi ∘ f,g)` for `f,g` in the Γ-domain.

No second-derivative generator identity is assumed here. -/
structure DiffusionChainRuleOn
    {X : Type*}
    (generator : (X → ℝ) →ₗ[ℝ] (X → ℝ))
    (domain : Set (X → ℝ)) : Prop where
  comp_mem :
    ∀ {f : X → ℝ}, f ∈ domain →
      ∀ {phi : ℝ → ℝ}, ContDiff ℝ (⊤ : ℕ∞) phi →
        (phi ∘ f) ∈ domain
  chain_rule :
    ∀ {f : X → ℝ}, f ∈ domain →
      ∀ {g : X → ℝ}, g ∈ domain →
        ∀ {phi : ℝ → ℝ}, ContDiff ℝ (⊤ : ℕ∞) phi →
          CarreDuChamp.carreDuChamp generator (phi ∘ f) g =
            fun x =>
              deriv phi (f x) *
                CarreDuChamp.carreDuChamp generator f g x

/-- Smooth scalar functional calculus stays inside the declared
carré-du-champ domain. -/
theorem comp_mem
    {X : Type*}
    {generator : (X → ℝ) →ₗ[ℝ] (X → ℝ)}
    {domain : Set (X → ℝ)}
    (h : DiffusionChainRuleOn generator domain)
    {f : X → ℝ} (hf : f ∈ domain)
    {phi : ℝ → ℝ} (hphi : ContDiff ℝ (⊤ : ℕ∞) phi) :
    (phi ∘ f) ∈ domain :=
  h.comp_mem hf hphi

/-- Function-valued form of the source chain rule
`Γ(φ ∘ f,g) = φ'(f) Γ(f,g)`. -/
theorem carreDuChamp_comp_left
    {X : Type*}
    {generator : (X → ℝ) →ₗ[ℝ] (X → ℝ)}
    {domain : Set (X → ℝ)}
    (h : DiffusionChainRuleOn generator domain)
    {f g : X → ℝ} (hf : f ∈ domain) (hg : g ∈ domain)
    {phi : ℝ → ℝ} (hphi : ContDiff ℝ (⊤ : ℕ∞) phi) :
    CarreDuChamp.carreDuChamp generator (phi ∘ f) g =
      fun x =>
        deriv phi (f x) * CarreDuChamp.carreDuChamp generator f g x :=
  h.chain_rule hf hg hphi

/-- Pointwise extraction of the diffusion chain rule. -/
theorem carreDuChamp_comp_left_apply
    {X : Type*}
    {generator : (X → ℝ) →ₗ[ℝ] (X → ℝ)}
    {domain : Set (X → ℝ)}
    (h : DiffusionChainRuleOn generator domain)
    {f g : X → ℝ} (hf : f ∈ domain) (hg : g ∈ domain)
    {phi : ℝ → ℝ} (hphi : ContDiff ℝ (⊤ : ℕ∞) phi)
    (x : X) :
    CarreDuChamp.carreDuChamp generator (phi ∘ f) g x =
      deriv phi (f x) * CarreDuChamp.carreDuChamp generator f g x := by
  exact congrFun (carreDuChamp_comp_left h hf hg hphi) x

/-- Self-pairing specialization `Γ(φ ∘ f,f) = φ'(f) Γ(f,f)`. -/
theorem carreDuChamp_comp_self
    {X : Type*}
    {generator : (X → ℝ) →ₗ[ℝ] (X → ℝ)}
    {domain : Set (X → ℝ)}
    (h : DiffusionChainRuleOn generator domain)
    {f : X → ℝ} (hf : f ∈ domain)
    {phi : ℝ → ℝ} (hphi : ContDiff ℝ (⊤ : ℕ∞) phi) :
    CarreDuChamp.carreDuChamp generator (phi ∘ f) f =
      fun x =>
        deriv phi (f x) * CarreDuChamp.carreDuChamp generator f f x :=
  carreDuChamp_comp_left h hf hf hphi

/-- The scalar-composition specialization later consumed in the abstract proof
of Chewi Theorem 8.3.1:

`Γ(f' ∘ ρ, ρ) = f''(ρ) Γ(ρ,ρ)`.

This theorem remains inside the smooth-scalar scope of Definition 2.2.13.  The
explicit `HasDerivAt` family only identifies Mathlib's `deriv fPrime` with the
named second derivative `fSecond`; it does not replace the source smoothness
hypothesis or assume the generator-form diffusion identity. -/
theorem carreDuChamp_fPrime_comp_self_apply
    {X : Type*}
    {generator : (X → ℝ) →ₗ[ℝ] (X → ℝ)}
    {domain : Set (X → ℝ)}
    (h : DiffusionChainRuleOn generator domain)
    {rho : X → ℝ} (hrho : rho ∈ domain)
    {fPrime fSecond : ℝ → ℝ}
    (hfPrimeSmooth : ContDiff ℝ (⊤ : ℕ∞) fPrime)
    (hfPrimeDeriv : ∀ r : ℝ, HasDerivAt fPrime (fSecond r) r)
    (x : X) :
    CarreDuChamp.carreDuChamp generator (fPrime ∘ rho) rho x =
      fSecond (rho x) *
        CarreDuChamp.carreDuChamp generator rho rho x := by
  calc
    CarreDuChamp.carreDuChamp generator (fPrime ∘ rho) rho x =
        deriv fPrime (rho x) *
          CarreDuChamp.carreDuChamp generator rho rho x :=
      carreDuChamp_comp_left_apply h hrho hrho hfPrimeSmooth x
    _ = fSecond (rho x) *
          CarreDuChamp.carreDuChamp generator rho rho x := by
      rw [(hfPrimeDeriv (rho x)).deriv]

end

end DiffusionChainRule
end StochasticProcesses
end TechnicalLemmas
end AutoSamplingTheory
