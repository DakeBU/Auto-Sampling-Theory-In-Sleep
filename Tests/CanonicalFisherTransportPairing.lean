import AutoSamplingTheory.TechnicalLemmas.InformationTheory.CanonicalFisherTransportPairing
import AutoSamplingTheory.TechnicalLemmas.InformationTheory.GeodesicFisherTransport

open MeasureTheory
open scoped RealInnerProductSpace ENNReal
open AutoSamplingTheory.TechnicalLemmas
open InformationTheory InformationTheory.CanonicalRelativeFisher
open InformationTheory.CanonicalFisherTransportPairing
open Measure

noncomputable section

variable {ι : Type*} [Fintype ι]
  {mu pi nu : Measure (State (ι := ι))}
  {gamma : Measure (State (ι := ι) × State (ι := ι))}

-- Integrability is independently exercised for a non-optimal coupling.
example (hgamma : Transport.IsCoupling gamma mu nu)
    (hscore : SmoothFiniteScoreDomain mu pi)
    (hmu : Integrable (fun x : State (ι := ι) => ‖x‖ ^ 2) mu)
    (hnu : Integrable (fun x : State (ι := ι) => ‖x‖ ^ 2) nu) :
    Integrable (fun z =>
      ⟪gradient (RNLogRatio.logRatio mu pi) z.1, z.2 - z.1⟫) gamma :=
  integrable_pairing_of_isCoupling hgamma hscore hmu hnu

-- Finite optimal real cost rules out infinity before toReal is interpreted.
-- This check has no score, probability or sigma-finiteness assumption.
example (hgamma : DisplacementInterpolation.IsQuadraticOptimalCoupling gamma mu nu)
    (hmu : Integrable (fun x : State (ι := ι) => ‖x‖ ^ 2) mu)
    (hnu : Integrable (fun x : State (ι := ι) => ‖x‖ ^ 2) nu) :
    WassersteinSpace.wassersteinDistance mu nu ≠ ∞ := by
  have hcost := CouplingQuadraticIntegrability.integrable_norm_sub_sq_of_isCoupling
    hgamma.1 hmu hnu
  have heq :=
    DisplacementRealQuadraticCost.ofReal_integral_norm_sq_eq_wassersteinDistance_sq_of_optimal
      hgamma hcost
  intro hinfinite
  simp [hinfinite] at heq

-- Genuine consumer: the pairing is the actual gamma integral and FI/W2 are
-- the existing measure-level definitions. No hcs or equivalent bound is an input.
-- RED BOUNDARY: KL convexity, an ambient metric/law representation, and the
-- first variation of the actual KL path remain supplied. In particular the
-- HasDerivAt input is two-sided; this test does not manufacture the source's
-- endpoint first variation, finite entropy near zero, or a Wasserstein metric.
example [SigmaFinite pi] {M : Type*} [MetricSpace M]
    (law : M → Measure (State (ι := ι)))
    {isGeodesic : (ℝ → M) → Prop} {path : ℝ → M}
    (hgamma : DisplacementInterpolation.IsQuadraticOptimalCoupling gamma mu pi)
    (hscore : SmoothFiniteScoreDomain mu pi)
    (hmu : Integrable (fun x : State (ι := ι) => ‖x‖ ^ 2) mu)
    (hpi : Integrable (fun x : State (ι := ι) => ‖x‖ ^ 2) pi)
    (hconvex : Geometry.GeodesicConvexity.IsAlphaGeodesicallyConvex isGeodesic
      (fun x => (_root_.InformationTheory.klDiv (law x) pi).toReal) 0)
    (hpath : isGeodesic path)
    (hlaw : ∀ t, law (path t) = DisplacementInterpolation.displacementInterpolation gamma t)
    (hdist : dist (path 0) (path 1) =
      (WassersteinSpace.wassersteinDistance mu pi).toReal)
    (hderiv : HasDerivAt
      (fun t => (_root_.InformationTheory.klDiv
        (DisplacementInterpolation.displacementInterpolation gamma t) pi).toReal)
      (∫ z, ⟪gradient (RNLogRatio.logRatio mu pi) z.1, z.2 - z.1⟫ ∂gamma) 0) :
    (_root_.InformationTheory.klDiv mu pi).toReal ^ 2 ≤
      information mu pi hscore * (WassersteinSpace.wassersteinDistance mu pi).toReal ^ 2 := by
  have hstart : law (path 0) = mu :=
    (hlaw 0).trans (DisplacementInterpolation.displacementInterpolation_zero hgamma.1)
  have hend : law (path 1) = pi :=
    (hlaw 1).trans (DisplacementInterpolation.displacementInterpolation_one hgamma.1)
  have hactual : (fun t => (_root_.InformationTheory.klDiv (law (path t)) pi).toReal) =
      (fun t => (_root_.InformationTheory.klDiv
        (DisplacementInterpolation.displacementInterpolation gamma t) pi).toReal) := by
    funext t
    rw [hlaw t]
  have hcs : -(∫ z, ⟪gradient (RNLogRatio.logRatio mu pi) z.1, z.2 - z.1⟫ ∂gamma) ≤
      Real.sqrt (information mu pi hscore) * dist (path 0) (path 1) := by
    rw [hdist]
    exact (neg_le_abs _).trans
      (abs_integral_pairing_le_sqrt_information_mul_wasserstein hgamma hscore hmu hpi)
  have hresult := GeodesicFisherTransport.sq_le_fisher_mul_dist_sq_of_geodesic_first_order
    hconvex hpath (hactual ▸ hderiv)
    (by simp [hend]) ENNReal.toReal_nonneg (information_nonneg mu pi hscore) hcs
  simpa only [hstart, hdist] using hresult

#check integrable_pairing_of_isCoupling
#check abs_integral_pairing_le_sqrt_information_mul_wasserstein
#print axioms integrable_pairing_of_isCoupling
#print axioms abs_integral_pairing_le_sqrt_information_mul_wasserstein

end
