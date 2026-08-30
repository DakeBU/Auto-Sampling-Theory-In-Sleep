import AutoSamplingTheory.TechnicalLemmas.InformationTheory.FiniteACFDivergenceCommonReference

/-!
# Finite-AC measure-facing wrapper for simultaneous f-divergence dissipation

The abstract generator/density lane proves a derivative for the common-reference
curve

`∫ q_t f(p_t / q_t) dm`.

The finite absolutely-continuous realization of Chewi Definition 1.5.5 instead
exposes a measure-facing value `D_f(mu_t || nu_t)`.  This file isolates the
last proof-irrelevant curve wrapper between those two views.

It intentionally does not reprove the common-reference representation or the
dissipation derivative.  Those remain explicit parent contracts supplied by
the RN/withDensity lane and the abstract generator lane respectively.
-/

namespace AutoSamplingTheory
namespace TechnicalLemmas
namespace InformationTheory
namespace SimultaneousFDivergenceFiniteAC

open MeasureTheory

noncomputable section

variable {X : Type*} [MeasurableSpace X]

/-- A time-indexed finite AC `f`-divergence value with probability and domain
witnesses supplied explicitly at every time.

The explicit probability witnesses avoid installing a global instance for an
arbitrary measure path; proof irrelevance makes the resulting real curve
independent of the particular witnesses. -/
noncomputable def valueCurve
    (mu nu : ℝ → Measure X)
    (hmu : ∀ s : ℝ, IsProbabilityMeasure (mu s))
    (hnu : ∀ s : ℝ, IsProbabilityMeasure (nu s))
    (f : ℝ → ℝ)
    (hDomain : ∀ s : ℝ,
      @FiniteACFDivergence.Domain X _ (mu s) (nu s) (hmu s) (hnu s) f) :
    ℝ → ℝ :=
  fun s =>
    @FiniteACFDivergence.value X _ (mu s) (nu s) (hmu s) (hnu s) f (hDomain s)

/-- Transfer the already-proved common-reference derivative to the finite
measure-facing `f`-divergence curve.

`hRepresentation` is the timewise output shape of the common-reference
finite-divergence adapter (#232), with the canonical RN-density equality
supplied by the RN lane (#228/#229). `hCommonDerivative` is the output shape of
the abstract dissipation derivative join (#227).

This theorem performs no additional analysis: it only replaces the curve by an
extensionally equal measure-facing curve. -/
theorem hasDerivAt_valueCurve_of_commonReference
    (base : Measure X)
    (mu nu : ℝ → Measure X)
    (hmu : ∀ s : ℝ, IsProbabilityMeasure (mu s))
    (hnu : ∀ s : ℝ, IsProbabilityMeasure (nu s))
    (f : ℝ → ℝ)
    (hDomain : ∀ s : ℝ,
      @FiniteACFDivergence.Domain X _ (mu s) (nu s) (hmu s) (hnu s) f)
    (p q : ℝ → X → ℝ)
    (s0 derivativeValue : ℝ)
    (hRepresentation :
      ∀ s : ℝ,
        valueCurve mu nu hmu hnu f hDomain s =
          ∫ x, q s x * f (p s x / q s x) ∂base)
    (hCommonDerivative :
      HasDerivAt
        (fun s => ∫ x, q s x * f (p s x / q s x) ∂base)
        derivativeValue s0) :
    HasDerivAt
      (valueCurve mu nu hmu hnu f hDomain)
      derivativeValue s0 := by
  have hCurve :
      valueCurve mu nu hmu hnu f hDomain =
        fun s => ∫ x, q s x * f (p s x / q s x) ∂base :=
    funext hRepresentation
  rw [hCurve]
  exact hCommonDerivative

end

end SimultaneousFDivergenceFiniteAC
end InformationTheory
end TechnicalLemmas
end AutoSamplingTheory
