import AutoSamplingTheory.TechnicalLemmas.Analysis.Calculus.GradientAlgebra
import AutoSamplingTheory.TechnicalLemmas.InformationTheory.SimultaneousFDivergenceGradient
import Mathlib.Tactic

/-!
# Source-shaped gradient identities for simultaneous f-divergence dissipation

In the proof of Chewi Theorem 8.3.1, after differentiating

`q * f (p / q)`

and integrating the two common Fokker--Planck terms by parts, one writes
`rho = p / q` and uses

* `grad p = rho * grad q + q * grad rho`,
* `grad (f' ∘ rho) = f''(rho) * grad rho`,
* `grad ((f - id * f') ∘ rho) = -rho * f''(rho) * grad rho`.

The route-neutral product, chain, reciprocal, and quotient rules already live
in `Analysis.Calculus.GradientAlgebra`; the final Hilbert-space cancellation
already lives in `SimultaneousFDivergenceGradient`.  This file supplies only
the source-shaped adapter between those two reusable layers.

No Fokker--Planck equation, integration by parts, domination argument, or
spatial integral identity is proved here.
-/

namespace AutoSamplingTheory
namespace TechnicalLemmas
namespace InformationTheory
namespace SimultaneousFDivergenceGradientIdentities

open scoped RealInnerProductSpace

noncomputable section

private alias GA :=
  AutoSamplingTheory.TechnicalLemmas.Analysis.Calculus.GradientAlgebra

/-- Scalar derivative behind the complementary gradient term in Chewi 8.3.1:

`d/dr [f(r) - r f'(r)] = -r f''(r)`.

The hypothesis that the derivative of `f` at `r` is exactly `fPrime r` is kept
explicit; this is the cancellation that removes the two `f'(r)` terms. -/
theorem hasDerivAt_f_sub_mul_fPrime
    {f fPrime : ℝ → ℝ} {r fpp : ℝ}
    (hf : HasDerivAt f (fPrime r) r)
    (hfPrime : HasDerivAt fPrime fpp r) :
    HasDerivAt (fun s => f s - s * fPrime s) (-r * fpp) r := by
  have hmul :
      HasDerivAt (fun s => s * fPrime s)
        (1 * fPrime r + r * fpp) r :=
    (hasDerivAt_id r).mul hfPrime
  have hsub := hf.sub hmul
  convert hsub using 1 <;> ring

/-- Product identity for `p = rho * q` in Mathlib's gradient API. -/
theorem hasGradientAt_density_product
    {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℝ E] [CompleteSpace E]
    {rho q : E → ℝ} {x gradRho gradQ : E}
    (hRho : HasGradientAt rho gradRho x)
    (hQ : HasGradientAt q gradQ x) :
    HasGradientAt (fun y => rho y * q y)
      (rho x • gradQ + q x • gradRho) x := by
  exact GA.HasGradientAt.mul hRho hQ

/-- Chain-rule identity for the gradient of `f'(rho)`. -/
theorem hasGradientAt_fPrime_comp
    {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℝ E] [CompleteSpace E]
    {rho : E → ℝ} {fPrime : ℝ → ℝ}
    {x gradRho : E} {fpp : ℝ}
    (hRho : HasGradientAt rho gradRho x)
    (hfPrime : HasDerivAt fPrime fpp (rho x)) :
    HasGradientAt (fun y => fPrime (rho y))
      (fpp • gradRho) x := by
  exact GA.HasGradientAt.comp_real hRho hfPrime

/-- Chain-rule identity for the complementary scalar coefficient
`f(rho) - rho * f'(rho)` used by the `q`-equation. -/
theorem hasGradientAt_f_sub_rho_mul_fPrime
    {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℝ E] [CompleteSpace E]
    {rho : E → ℝ} {f fPrime : ℝ → ℝ}
    {x gradRho : E} {fpp : ℝ}
    (hRho : HasGradientAt rho gradRho x)
    (hf : HasDerivAt f (fPrime (rho x)) (rho x))
    (hfPrime : HasDerivAt fPrime fpp (rho x)) :
    HasGradientAt
      (fun y => f (rho y) - rho y * fPrime (rho y))
      ((-rho x * fpp) • gradRho) x := by
  have houter :
      HasDerivAt (fun r => f r - r * fPrime r)
        (-rho x * fpp) (rho x) :=
    hasDerivAt_f_sub_mul_fPrime hf hfPrime
  exact GA.HasGradientAt.comp_real hRho houter

/-- The three source-shaped gradient identities packaged together for a single
point `x`.  This is convenient for downstream assembly with
`common_diffusion_pairing_eq_of_gradients` while keeping each constituent lemma
independently reusable. -/
theorem source_gradient_packet
    {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℝ E] [CompleteSpace E]
    {rho q : E → ℝ} {f fPrime : ℝ → ℝ}
    {x gradRho gradQ : E} {fpp : ℝ}
    (hRho : HasGradientAt rho gradRho x)
    (hQ : HasGradientAt q gradQ x)
    (hf : HasDerivAt f (fPrime (rho x)) (rho x))
    (hfPrime : HasDerivAt fPrime fpp (rho x)) :
    HasGradientAt (fun y => rho y * q y)
        (rho x • gradQ + q x • gradRho) x ∧
      HasGradientAt (fun y => fPrime (rho y))
        (fpp • gradRho) x ∧
      HasGradientAt
        (fun y => f (rho y) - rho y * fPrime (rho y))
        ((-rho x * fpp) • gradRho) x := by
  exact ⟨hasGradientAt_density_product hRho hQ,
    hasGradientAt_fPrime_comp hRho hfPrime,
    hasGradientAt_f_sub_rho_mul_fPrime hRho hf hfPrime⟩

end

end SimultaneousFDivergenceGradientIdentities
end InformationTheory
end TechnicalLemmas
end AutoSamplingTheory
