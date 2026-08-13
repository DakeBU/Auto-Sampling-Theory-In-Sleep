import Mathlib.Probability.Distributions.Gaussian.Basic
import Mathlib.Probability.Independence.Basic

/-!
# Standard Brownian motion

The predicate below formalizes Chewi's Definition 1.1.1 on a finite-
dimensional real Hilbert space.  The centered isotropic increment law is stated
through every continuous linear functional, which is Mathlib's native
characterization of a Gaussian measure and avoids choosing coordinates.
-/

namespace AutoSamplingTheory
namespace TechnicalLemmas
namespace StochasticProcesses
namespace BrownianMotion

open MeasureTheory ProbabilityTheory Set
open scoped NNReal RealInnerProductSpace Topology

variable {Omega E : Type*} [MeasurableSpace Omega]
  [NormedAddCommGroup E] [InnerProductSpace ℝ E] [CompleteSpace E]
  [MeasurableSpace E] [BorelSpace E]

/-- The variance of a standard Brownian increment after applying a continuous
linear functional `ell`: `(t-s) * ||ell||^2`. -/
noncomputable def projectedIncrementVariance
    (s t : ℝ≥0) (ell : StrongDual ℝ E) : ℝ≥0 :=
  Real.toNNReal (((t - s : ℝ≥0) : ℝ) * ‖ell‖ ^ 2)

/-- Chewi Definition 1.1.1: a standard Brownian motion in a finite-dimensional
real Hilbert space.

Independent increments are stated for every finite family of pairwise
disjoint half-open time intervals.  The Gaussian law is characterized by all
one-dimensional continuous-linear projections; this says exactly that an
increment has mean zero and covariance `(t-s) I`. -/
def IsStandardBrownianMotion
    (B : ℝ≥0 → Omega → E) (mu : Measure Omega) : Prop :=
  (∀ omega, B 0 omega = 0) ∧
    (∀ (n : ℕ) (s t : Fin n → ℝ≥0),
      (∀ i, s i ≤ t i) →
      Pairwise (fun i j => Disjoint (Ioc (s i) (t i)) (Ioc (s j) (t j))) →
      iIndepFun (fun i omega => B (t i) omega - B (s i) omega) mu) ∧
    (∀ s t : ℝ≥0, s < t → ∀ ell : StrongDual ℝ E,
      HasLaw
        (fun omega => ell (B t omega - B s omega))
        (gaussianReal 0 (projectedIncrementVariance s t ell)) mu) ∧
    ∀ᵐ omega ∂mu, Continuous (fun t => B t omega)

end BrownianMotion
end StochasticProcesses
end TechnicalLemmas
end AutoSamplingTheory
