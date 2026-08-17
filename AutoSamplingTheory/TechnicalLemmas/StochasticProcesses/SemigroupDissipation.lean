import AutoSamplingTheory.TechnicalLemmas.StochasticProcesses.OperatorGeneratorDomain
import AutoSamplingTheory.TechnicalLemmas.StochasticProcesses.Reversibility
import Mathlib.Analysis.InnerProductSpace.Continuous
import Mathlib.Tactic.Ring

/-!
# Reversible generators and Hilbert-space semigroup dissipation

This file closes two operator-theoretic gaps in Chewi Section 1.2 without
using any stochastic-calculus result from Section 1.1.

First, reversibility of a continuous-linear semigroup implies symmetry of its
right generator on the canonical generator domain.  Second, for a strongly
continuous semigroup on a real Hilbert space, the right derivative of the
squared norm of an orbit is twice the generator pairing.  Equivalently, it is
minus twice the generator Dirichlet energy.

These are the abstract `L²(π)` calculations needed before the source-facing
variance-decay theorem.  This file deliberately does not construct the
`L²(π)` realization of a Markov kernel, identify the concrete Langevin SDE
semigroup, or claim that the Hilbert norm is already Chewi's variance.  Those
remain separate analytic bridges.
-/

namespace AutoSamplingTheory
namespace TechnicalLemmas
namespace StochasticProcesses
namespace SemigroupDissipation

open Filter Set
open scoped NNReal Topology

open OperatorGenerator
open OperatorGeneratorDomain

noncomputable section

variable {H : Type*} [NormedAddCommGroup H] [InnerProductSpace ℝ H]

/-- A reversible semigroup has a symmetric right-generator relation.

The proof is the difference-quotient argument behind the standard statement
that the generator of a reversible semigroup is symmetric.  No closedness or
self-adjointness claim is made. -/
theorem generator_inner_symmetric_of_reversible
    (S : ContinuousLinearSemigroup H)
    (hrev : Reversibility.IsReversible S)
    {f Af g Ag : H}
    (hf : HasRightGeneratorAt S f Af)
    (hg : HasRightGeneratorAt S g Ag) :
    inner ℝ Af g = inner ℝ f Ag := by
  have hpair : ∀ h : ℝ≥0,
      inner ℝ (rightDifferenceQuotient S h f) g =
        inner ℝ f (rightDifferenceQuotient S h g) := by
    intro h
    simp only [rightDifferenceQuotient, real_inner_smul_left,
      real_inner_smul_right, inner_sub_left, inner_sub_right]
    rw [hrev h f g]
  have hleft :
      Tendsto
        (fun h : ℝ≥0 => inner ℝ (rightDifferenceQuotient S h f) g)
        (nhdsWithin 0 (Ioi 0)) (𝓝 (inner ℝ Af g)) :=
    hf.inner tendsto_const_nhds
  have hright :
      Tendsto
        (fun h : ℝ≥0 => inner ℝ f (rightDifferenceQuotient S h g))
        (nhdsWithin 0 (Ioi 0)) (𝓝 (inner ℝ f Ag)) :=
    tendsto_const_nhds.inner hg
  have hright' :
      Tendsto
        (fun h : ℝ≥0 => inner ℝ (rightDifferenceQuotient S h f) g)
        (nhdsWithin 0 (Ioi 0)) (𝓝 (inner ℝ f Ag)) :=
    hright.congr' (Filter.Eventually.of_forall fun h => (hpair h).symm)
  exact tendsto_nhds_unique hleft hright'

/-- Bundled-domain version of generator symmetry for a reversible semigroup. -/
theorem rightGenerator_inner_symmetric_of_reversible
    (S : ContinuousLinearSemigroup H)
    (hrev : Reversibility.IsReversible S)
    (f g : generatorDomainSubmodule S) :
    inner ℝ (rightGenerator S f) (g : H) =
      inner ℝ (f : H) (rightGenerator S g) :=
  generator_inner_symmetric_of_reversible S hrev
    (rightGeneratorValue_spec S f) (rightGeneratorValue_spec S g)

/-- Right difference quotient of the squared Hilbert norm along a semigroup
orbit.  This is kept in `ℝ≥0` time so it matches the canonical semigroup API
without extending the process to negative times. -/
def rightNormSqDifferenceQuotient
    (S : ContinuousLinearSemigroup H)
    (t h : ℝ≥0) (f : H) : ℝ :=
  ((h : ℝ)⁻¹) *
    (‖S.op (t + h) f‖ ^ 2 - ‖S.op t f‖ ^ 2)

/-- Polarization rewrites the squared-norm quotient as the inner product of
the orbit difference quotient with the sum of the two orbit values. -/
theorem rightNormSqDifferenceQuotient_eq_inner
    (S : ContinuousLinearSemigroup H)
    (t h : ℝ≥0) (f : H) :
    rightNormSqDifferenceQuotient S t h f =
      inner ℝ (rightOrbitDifferenceQuotient S t h f)
        (S.op (t + h) f + S.op t f) := by
  simp only [rightNormSqDifferenceQuotient,
    rightOrbitDifferenceQuotient, real_inner_smul_left,
    inner_sub_left, inner_add_right, real_inner_self_eq_norm_sq]
  rw [real_inner_comm (S.op (t + h) f) (S.op t f)]
  ring

/-- A generator-domain point transported along the semigroup orbit. -/
def orbitDomainPoint
    (S : ContinuousLinearSemigroup H)
    (t : ℝ≥0) (f : generatorDomainSubmodule S) :
    generatorDomainSubmodule S :=
  ⟨S.op t (f : H), generatorDomain_map S f.property t⟩

/-- The bundled generator at an orbit point is the semigroup image of the
initial generator value. -/
theorem rightGenerator_orbitDomainPoint
    (S : ContinuousLinearSemigroup H)
    (t : ℝ≥0) (f : generatorDomainSubmodule S) :
    rightGenerator S (orbitDomainPoint S t f) =
      S.op t (rightGenerator S f) :=
  rightGenerator_map S t f

/-- The Hilbert-space generator Dirichlet energy `-⟪f,Af⟫`. -/
def generatorDirichlet
    (S : ContinuousLinearSemigroup H)
    (f : generatorDomainSubmodule S) : ℝ :=
  -inner ℝ (f : H) (rightGenerator S f)

/-- Strong continuity plus the canonical right-generator equation gives the
exact right derivative of the squared Hilbert norm along a generator-domain
orbit.

This is the operator-theoretic dissipation identity which, after the separate
`L²(π)`/centering realization, becomes the variance dissipation identity used
in Chewi Theorem 1.2.21. -/
theorem tendsto_rightNormSqDifferenceQuotient
    (S : StronglyContinuousSemigroup H)
    (f : generatorDomainSubmodule S.toContinuousLinearSemigroup)
    (t : ℝ≥0) :
    Tendsto
      (fun h : ℝ≥0 =>
        rightNormSqDifferenceQuotient S.toContinuousLinearSemigroup t h (f : H))
      (nhdsWithin 0 (Ioi 0))
      (𝓝 (2 * inner ℝ (S.op t (f : H))
        (S.op t (rightGenerator S.toContinuousLinearSemigroup f)))) := by
  have hquot :=
    kolmogorov_backward_right_generator S.toContinuousLinearSemigroup f t
  have horbit :
      Tendsto (fun h : ℝ≥0 => S.op (t + h) (f : H))
        (nhdsWithin 0 (Ioi 0)) (𝓝 (S.op t (f : H))) :=
    (S.tendsto_op_add t (f : H)).mono_left inf_le_left
  have hconst :
      Tendsto (fun _ : ℝ≥0 => S.op t (f : H))
        (nhdsWithin 0 (Ioi 0)) (𝓝 (S.op t (f : H))) :=
    tendsto_const_nhds
  have hsum :
      Tendsto
        (fun h : ℝ≥0 => S.op (t + h) (f : H) + S.op t (f : H))
        (nhdsWithin 0 (Ioi 0))
        (𝓝 (S.op t (f : H) + S.op t (f : H))) :=
    horbit.add hconst
  have hinner := hquot.inner hsum
  have hnorm :
      Tendsto
        (fun h : ℝ≥0 =>
          rightNormSqDifferenceQuotient S.toContinuousLinearSemigroup t h (f : H))
        (nhdsWithin 0 (Ioi 0))
        (𝓝 (inner ℝ
          (S.op t (rightGenerator S.toContinuousLinearSemigroup f))
          (S.op t (f : H) + S.op t (f : H)))) :=
    hinner.congr' (Filter.Eventually.of_forall fun h =>
      (rightNormSqDifferenceQuotient_eq_inner
        S.toContinuousLinearSemigroup t h (f : H)).symm)
  have hlimit :
      inner ℝ (S.op t (rightGenerator S.toContinuousLinearSemigroup f))
          (S.op t (f : H) + S.op t (f : H)) =
        2 * inner ℝ (S.op t (f : H))
          (S.op t (rightGenerator S.toContinuousLinearSemigroup f)) := by
    rw [inner_add_right]
    rw [real_inner_comm (S.op t (f : H))
      (S.op t (rightGenerator S.toContinuousLinearSemigroup f))]
    ring
  rwa [hlimit] at hnorm

/-- The preceding squared-norm derivative is `-2` times the generator
Dirichlet energy at the transported domain point. -/
theorem tendsto_rightNormSqDifferenceQuotient_eq_neg_two_dirichlet
    (S : StronglyContinuousSemigroup H)
    (f : generatorDomainSubmodule S.toContinuousLinearSemigroup)
    (t : ℝ≥0) :
    Tendsto
      (fun h : ℝ≥0 =>
        rightNormSqDifferenceQuotient S.toContinuousLinearSemigroup t h (f : H))
      (nhdsWithin 0 (Ioi 0))
      (𝓝 (-2 * generatorDirichlet S.toContinuousLinearSemigroup
        (orbitDomainPoint S.toContinuousLinearSemigroup t f))) := by
  have h := tendsto_rightNormSqDifferenceQuotient S f t
  have htarget :
      2 * inner ℝ (S.op t (f : H))
          (S.op t (rightGenerator S.toContinuousLinearSemigroup f)) =
        -2 * generatorDirichlet S.toContinuousLinearSemigroup
          (orbitDomainPoint S.toContinuousLinearSemigroup t f) := by
    simp only [generatorDirichlet, rightGenerator_orbitDomainPoint]
    ring
  rwa [htarget] at h

end

end SemigroupDissipation
end StochasticProcesses
end TechnicalLemmas
end AutoSamplingTheory
