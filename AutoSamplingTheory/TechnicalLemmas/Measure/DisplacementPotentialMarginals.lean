import AutoSamplingTheory.TechnicalLemmas.Measure.DisplacementPotentialEnergy
import AutoSamplingTheory.TechnicalLemmas.Measure.Transport
import Mathlib.MeasureTheory.Integral.Bochner.Basic

/-!
# Endpoint-marginal bookkeeping for displacement potential energy

`DisplacementPotentialEnergy` proves the pointwise and coupling-integral
strong-convexity estimate used in Chewi Theorem 1.4.5. Its right-hand side is
still written as one integral over an endpoint coupling.

This module performs only the measure bookkeeping needed to expose the two
endpoint potential energies. Integrability is explicit, so no use is made of
Mathlib's totalized integral outside the integrable regime. The quadratic
transport term remains the real-valued coupling cost; identifying it with the
squared Wasserstein distance for an optimal plan is a separate ENNReal bridge.
-/

namespace AutoSamplingTheory
namespace TechnicalLemmas
namespace Measure
namespace DisplacementPotentialMarginals

open MeasureTheory Set

noncomputable section

variable {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℝ E]
  [FiniteDimensional ℝ E] [MeasurableSpace E] [BorelSpace E]

open DisplacementInterpolation DisplacementInterpolationCoupling
open DisplacementPotentialEnergy

/-- Integration of a strongly measurable observable against the first
coordinate of a coupling equals integration against its first marginal. -/
theorem integral_fst_eq_of_isCoupling
    {γ : Measure (E × E)} {μ₀ μ₁ : Measure E}
    (hγ : Transport.IsCoupling γ μ₀ μ₁)
    {V : E → ℝ} (hV : StronglyMeasurable V) :
    (∫ z, V z.1 ∂γ) = ∫ x, V x ∂μ₀ := by
  calc
    (∫ z, V z.1 ∂γ) = ∫ x, V x ∂γ.fst := by
      rw [Measure.fst]
      exact (integral_map_of_stronglyMeasurable measurable_fst hV).symm
    _ = ∫ x, V x ∂μ₀ := by rw [hγ.1]

/-- Integration of a strongly measurable observable against the second
coordinate of a coupling equals integration against its second marginal. -/
theorem integral_snd_eq_of_isCoupling
    {γ : Measure (E × E)} {μ₀ μ₁ : Measure E}
    (hγ : Transport.IsCoupling γ μ₀ μ₁)
    {V : E → ℝ} (hV : StronglyMeasurable V) :
    (∫ z, V z.2 ∂γ) = ∫ x, V x ∂μ₁ := by
  calc
    (∫ z, V z.2 ∂γ) = ∫ x, V x ∂γ.snd := by
      rw [Measure.snd]
      exact (integral_map_of_stronglyMeasurable measurable_snd hV).symm
    _ = ∫ x, V x ∂μ₁ := by rw [hγ.2]

/-- Expand the coupling-side affine strong-convexity integrand into its two
marginal potential energies and its real quadratic transport cost. -/
theorem integral_endpoint_affine_potential_eq
    {γ : Measure (E × E)} {μ₀ μ₁ : Measure E}
    (hγ : Transport.IsCoupling γ μ₀ μ₁)
    {V : E → ℝ} (hV : StronglyMeasurable V)
    {alpha t : ℝ}
    (hfst : Integrable (fun z : E × E => V z.1) γ)
    (hsnd : Integrable (fun z : E × E => V z.2) γ)
    (hcost : Integrable (fun z : E × E => ‖z.1 - z.2‖ ^ 2) γ) :
    (∫ z,
      ((1 - t) * V z.1 + t * V z.2 -
        (alpha * t * (1 - t) / 2) * ‖z.1 - z.2‖ ^ 2) ∂γ) =
      (1 - t) * ∫ x, V x ∂μ₀ +
        t * ∫ x, V x ∂μ₁ -
          (alpha * t * (1 - t) / 2) *
            ∫ z, ‖z.1 - z.2‖ ^ 2 ∂γ := by
  have hfst' : Integrable (fun z : E × E => (1 - t) * V z.1) γ :=
    hfst.const_mul (1 - t)
  have hsnd' : Integrable (fun z : E × E => t * V z.2) γ :=
    hsnd.const_mul t
  have hcost' : Integrable
      (fun z : E × E => (alpha * t * (1 - t) / 2) * ‖z.1 - z.2‖ ^ 2) γ :=
    hcost.const_mul (alpha * t * (1 - t) / 2)
  calc
    (∫ z,
      ((1 - t) * V z.1 + t * V z.2 -
        (alpha * t * (1 - t) / 2) * ‖z.1 - z.2‖ ^ 2) ∂γ) =
        (∫ z, ((1 - t) * V z.1 + t * V z.2) ∂γ) -
          ∫ z, (alpha * t * (1 - t) / 2) * ‖z.1 - z.2‖ ^ 2 ∂γ :=
      integral_sub (hfst'.add hsnd') hcost'
    _ = ((∫ z, (1 - t) * V z.1 ∂γ) +
          ∫ z, t * V z.2 ∂γ) -
          ∫ z, (alpha * t * (1 - t) / 2) * ‖z.1 - z.2‖ ^ 2 ∂γ := by
      rw [integral_add hfst' hsnd']
    _ = (1 - t) * ∫ z, V z.1 ∂γ +
        t * ∫ z, V z.2 ∂γ -
          (alpha * t * (1 - t) / 2) *
            ∫ z, ‖z.1 - z.2‖ ^ 2 ∂γ := by
      rw [integral_const_mul, integral_const_mul, integral_const_mul]
    _ = (1 - t) * ∫ x, V x ∂μ₀ +
        t * ∫ x, V x ∂μ₁ -
          (alpha * t * (1 - t) / 2) *
            ∫ z, ‖z.1 - z.2‖ ^ 2 ∂γ := by
      rw [integral_fst_eq_of_isCoupling hγ hV,
        integral_snd_eq_of_isCoupling hγ hV]

/-- Source-shaped potential-energy half of Chewi's displacement convexity:
the two endpoint potential energies are explicit and the only remaining
coupling term is the real quadratic transport cost. -/
theorem integral_potential_displacementInterpolation_le_marginals
    {γ : Measure (E × E)} {μ₀ μ₁ : Measure E}
    (hγ : Transport.IsCoupling γ μ₀ μ₁)
    {V : E → ℝ} {alpha t : ℝ}
    (hVstrong : StrongConvexOn (Set.univ : Set E) alpha V)
    (hVmeas : StronglyMeasurable V)
    (ht : t ∈ Icc (0 : ℝ) 1)
    (hleft : Integrable (fun z => V (pointMap (E := E) t z)) γ)
    (hfst : Integrable (fun z : E × E => V z.1) γ)
    (hsnd : Integrable (fun z : E × E => V z.2) γ)
    (hcost : Integrable (fun z : E × E => ‖z.1 - z.2‖ ^ 2) γ) :
    (∫ x, V x ∂displacementInterpolation γ t) ≤
      (1 - t) * ∫ x, V x ∂μ₀ +
        t * ∫ x, V x ∂μ₁ -
          (alpha * t * (1 - t) / 2) *
            ∫ z, ‖z.1 - z.2‖ ^ 2 ∂γ := by
  have hright : Integrable
      (fun z : E × E =>
        (1 - t) * V z.1 + t * V z.2 -
          (alpha * t * (1 - t) / 2) * ‖z.1 - z.2‖ ^ 2) γ :=
    ((hfst.const_mul (1 - t)).add (hsnd.const_mul t)).sub
      (hcost.const_mul (alpha * t * (1 - t) / 2))
  calc
    (∫ x, V x ∂displacementInterpolation γ t) ≤
        ∫ z,
          ((1 - t) * V z.1 + t * V z.2 -
            (alpha * t * (1 - t) / 2) * ‖z.1 - z.2‖ ^ 2) ∂γ :=
      integral_potential_displacementInterpolation_le
        γ hVstrong hVmeas ht hleft hright
    _ = (1 - t) * ∫ x, V x ∂μ₀ +
        t * ∫ x, V x ∂μ₁ -
          (alpha * t * (1 - t) / 2) *
            ∫ z, ‖z.1 - z.2‖ ^ 2 ∂γ :=
      integral_endpoint_affine_potential_eq hγ hVmeas hfst hsnd hcost

end

end DisplacementPotentialMarginals
end Measure
end TechnicalLemmas
end AutoSamplingTheory
