import AutoSamplingTheory.TechnicalLemmas.Analysis.RockafellarFiniteChain

/-!
# Root normalization and finiteness of the Rockafellar candidate

This module isolates the first genuine properness statement for the
finite-chain Rockafellar supremum.

If `base ∈ Gamma` and `Gamma` is pairing cyclically monotone, every rooted
chain value at `base.1` is at most zero, while the singleton chain has value
exactly zero. Thus zero is the greatest element of the real value set at the
root. The `WithTop ℝ` supremum is therefore exactly zero and, in particular,
finite at the root.

No convexity, lower-semicontinuity, measurability, or subgradient-containment
claim is used here.
-/

namespace AutoSamplingTheory
namespace TechnicalLemmas
namespace Analysis
namespace RockafellarRootProper

open PairingCyclicMonotonicity
open RockafellarFiniteChain

noncomputable section

variable {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℝ E]

/-- Generic finite-value domain for an extended-real potential. -/
def EffectiveDomain (Phi : E → WithTop ℝ) : Set E :=
  {x | Phi x < ⊤}

/-- At the chosen root, zero is the greatest value achieved by a rooted finite
chain. -/
theorem isGreatest_zero_rockafellarValueSet_at_root
    {base : E × E} {Gamma : Set (E × E)}
    (hbase : base ∈ Gamma)
    (hmono : PairingCycleMonotone Gamma) :
    IsGreatest (rockafellarValueSet base Gamma base.1) 0 := by
  constructor
  · refine ⟨RootedFiniteChain.singleton base hbase, ?_⟩
    simp
  · intro r hr
    rcases hr with ⟨c, rfl⟩
    exact c.value_at_root_nonpos hmono

/-- The proper Rockafellar supremum is normalized to zero at its chosen root. -/
theorem properRockafellarPotential_at_root_eq_zero
    {base : E × E} {Gamma : Set (E × E)}
    (hbase : base ∈ Gamma)
    (hmono : PairingCycleMonotone Gamma) :
    properRockafellarPotential base Gamma base.1 = 0 := by
  let S : Set ℝ := rockafellarValueSet base Gamma base.1
  have hgreatest : IsGreatest S 0 := by
    simpa [S] using isGreatest_zero_rockafellarValueSet_at_root hbase hmono
  have hbdd : BddAbove S := ⟨0, hgreatest.2⟩
  have hcoe :
      ((sSup S : ℝ) : WithTop ℝ) =
        sSup (((↑) : ℝ → WithTop ℝ) '' S) :=
    WithTop.coe_sSup' hbdd
  change sSup (((↑) : ℝ → WithTop ℝ) '' S) = 0
  rw [← hcoe, hgreatest.csSup_eq]
  simp

/-- In particular, the root is a finite point of the proper Rockafellar
candidate. -/
theorem root_mem_effectiveDomain_properRockafellarPotential
    {base : E × E} {Gamma : Set (E × E)}
    (hbase : base ∈ Gamma)
    (hmono : PairingCycleMonotone Gamma) :
    base.1 ∈ EffectiveDomain (properRockafellarPotential base Gamma) := by
  change properRockafellarPotential base Gamma base.1 < ⊤
  rw [properRockafellarPotential_at_root_eq_zero hbase hmono]
  simp

/-- Hence the effective domain of the proper Rockafellar candidate is
nonempty. -/
theorem effectiveDomain_properRockafellarPotential_nonempty
    {base : E × E} {Gamma : Set (E × E)}
    (hbase : base ∈ Gamma)
    (hmono : PairingCycleMonotone Gamma) :
    (EffectiveDomain (properRockafellarPotential base Gamma)).Nonempty :=
  ⟨base.1, root_mem_effectiveDomain_properRockafellarPotential hbase hmono⟩

end

end RockafellarRootProper
end Analysis
end TechnicalLemmas
end AutoSamplingTheory
