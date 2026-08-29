import AutoSamplingTheory.TechnicalLemmas.Measure.ContinuousCostWeakLowerSemicontinuity
import AutoSamplingTheory.TechnicalLemmas.Measure.DisplacementInterpolation
import AutoSamplingTheory.TechnicalLemmas.Measure.ProbabilityCouplingCompactness

/-!
# Existence of a quadratic optimal coupling

This module is the direct-method assembly node for the quadratic Kantorovich
problem.  Its parents are deliberately separated:

* `Transport.isCoupling_prod` gives a canonical feasible coupling;
* `ProbabilityCouplingCompactness.isCompact_probabilityCouplingSet` gives weak
  compactness of all probability couplings with the fixed marginals;
* `ContinuousCostWeakLowerSemicontinuity.lowerSemicontinuous_quadraticCostFunctional`
  gives weak lower semicontinuity of the extended-real quadratic objective;
* Mathlib's `LowerSemicontinuousOn.exists_isMinOn` attains the minimum.

No finite-second-moment assumption is needed for existence of an optimizer of
the extended-nonnegative quadratic problem: if all feasible costs are infinite,
the minimum is still attained.  Second moments enter later when consumers need
a finite Wasserstein value.

## Source boundary

This is a reusable technical theorem edge, not the full source-facing Brenier
theorem.  It proves only existence of a quadratic-optimal Kantorovich coupling.
Existence of an inducing map, plan uniqueness under an absolutely continuous
source, and convex-gradient identification remain separate DAG nodes.  A later
source-facing assembly must pass the ASTIS semantic round-trip gate.
-/

namespace AutoSamplingTheory
namespace TechnicalLemmas
namespace Measure
namespace QuadraticOptimalCouplingExistence

open MeasureTheory Set
open ContinuousCostWeakLowerSemicontinuity
open DisplacementInterpolation ProbabilityCouplingCompactness
open Transport WassersteinSpace

noncomputable section

variable {E : Type*} [NormedAddCommGroup E] [CompleteSpace E]
  [MeasurableSpace E] [BorelSpace E] [SecondCountableTopology E]

/-- The weak-topology fixed-marginal feasible set is nonempty.  The witness is
the independent product coupling, repackaged as a `ProbabilityMeasure`. -/
theorem probabilityCouplingSet_nonempty
    (mu nu : ProbabilityMeasure E) :
    (probabilityCouplingSet mu nu).Nonempty := by
  let gammaRaw : Measure (E × E) := (mu : Measure E).prod (nu : Measure E)
  have hgammaRaw :
      IsCoupling gammaRaw (mu : Measure E) (nu : Measure E) := by
    simpa [gammaRaw] using
      (isCoupling_prod (mu : Measure E) (nu : Measure E))
  let gamma : ProbabilityMeasure (E × E) :=
    ⟨gammaRaw, isProbabilityMeasure_of_isCoupling_left hgammaRaw⟩
  refine ⟨gamma, ?_⟩
  apply isProbabilityCoupling_iff_isCoupling_toMeasure.mpr
  simpa [gamma] using hgammaRaw

/-- The quadratic objective on weak probability measures.  Naming this
functional keeps the direct-method assembly readable and exposes the exact
object minimized by the existence proof. -/
noncomputable def quadraticObjective
    (gamma : ProbabilityMeasure (E × E)) : ℝ≥0∞ :=
  ∫⁻ z, quadraticCost (E := E) z ∂(gamma : Measure (E × E))

/-- The quadratic objective attains a minimum on the compact fixed-marginal
probability-coupling set. -/
theorem exists_isMinOn_quadraticObjective
    (mu nu : ProbabilityMeasure E) :
    ∃ gamma ∈ probabilityCouplingSet mu nu,
      IsMinOn (quadraticObjective (E := E))
        (probabilityCouplingSet mu nu) gamma := by
  have hnonempty : (probabilityCouplingSet mu nu).Nonempty :=
    probabilityCouplingSet_nonempty mu nu
  have hcompact : IsCompact (probabilityCouplingSet mu nu) :=
    isCompact_probabilityCouplingSet mu nu
  have hlsc : LowerSemicontinuous (quadraticObjective (E := E)) := by
    simpa [quadraticObjective] using
      (lowerSemicontinuous_quadraticCostFunctional (E := E))
  exact LowerSemicontinuousOn.exists_isMinOn
    hnonempty hcompact (hlsc.lowerSemicontinuousOn _)

/-- Probability-measure form of quadratic Kantorovich optimizer existence. -/
theorem exists_quadraticOptimalCoupling_probabilityMeasure
    (mu nu : ProbabilityMeasure E) :
    ∃ gamma : ProbabilityMeasure (E × E),
      IsQuadraticOptimalCoupling (gamma : Measure (E × E))
        (mu : Measure E) (nu : Measure E) := by
  rcases exists_isMinOn_quadraticObjective mu nu with
    ⟨gamma, hgamma_mem, hgamma_min⟩
  have hgamma_coupling :
      IsCoupling (gamma : Measure (E × E))
        (mu : Measure E) (nu : Measure E) :=
    isProbabilityCoupling_iff_isCoupling_toMeasure.mp hgamma_mem
  refine ⟨gamma, hgamma_coupling, ?_⟩
  apply le_antisymm
  · rw [transportCost_eq_sInf]
    apply le_sInf
    intro r hr
    rcases hr with ⟨rho, hrho, rfl⟩
    let rhoP : ProbabilityMeasure (E × E) :=
      ⟨rho, isProbabilityMeasure_of_isCoupling_left hrho⟩
    have hrhoP_mem : rhoP ∈ probabilityCouplingSet mu nu := by
      apply isProbabilityCoupling_iff_isCoupling_toMeasure.mpr
      simpa [rhoP] using hrho
    have hle := hgamma_min rhoP hrhoP_mem
    simpa [quadraticObjective, rhoP] using hle
  · exact transportCost_le_lintegral_of_isCoupling
      (quadraticCost (E := E)) (mu : Measure E) (nu : Measure E)
      (gamma : Measure (E × E)) hgamma_coupling

/-- Raw-measure wrapper: every pair of probability measures on the ambient
Polish normed group admits a quadratic-optimal coupling. -/
theorem exists_quadraticOptimalCoupling
    (mu nu : Measure E)
    [IsProbabilityMeasure mu] [IsProbabilityMeasure nu] :
    ∃ gamma : Measure (E × E),
      IsQuadraticOptimalCoupling gamma mu nu := by
  let muP : ProbabilityMeasure E := ⟨mu, inferInstance⟩
  let nuP : ProbabilityMeasure E := ⟨nu, inferInstance⟩
  rcases exists_quadraticOptimalCoupling_probabilityMeasure muP nuP with
    ⟨gamma, hgamma⟩
  refine ⟨(gamma : Measure (E × E)), ?_⟩
  simpa [muP, nuP] using hgamma

end

end QuadraticOptimalCouplingExistence
end Measure
end TechnicalLemmas
end AutoSamplingTheory
