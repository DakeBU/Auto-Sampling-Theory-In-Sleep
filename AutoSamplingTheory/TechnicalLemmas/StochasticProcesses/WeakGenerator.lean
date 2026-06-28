import AutoSamplingTheory.Probability

/-!
# Weak-generator technical lemmas

Reusable law-level weak-generator rewrites for SDE/Sampling proofs.

This file intentionally does not prove Ito's formula or a Fokker--Planck
density theorem.  It only packages the small Mathlib-facing step from a
sample-space weak-test derivative to a law-level weak-generator identity after
the analytic derivative, law identity, and generator pairings are supplied.
-/

namespace AutoSamplingTheory
namespace TechnicalLemmas
namespace StochasticProcesses
namespace WeakGenerator

open MeasureTheory
open scoped Topology

/-- Move a supplied sample-space generator derivative to a named law path.

In SDE applications, `hderiv` is usually the Ito-generator derivative for a
test function composed with a process, while `hDrift` and `hDiffusion` identify
the sample drift and diffusion-generator terms with law-level weak-test
integrals.  The lemma proves only the reusable rewrite; it does not construct
the process, conditional drift, or Ito theorem.
-/
theorem weakGeneratorFromSampleDerivative {Ω E : Type*}
    [MeasurableSpace Ω] [MeasurableSpace E]
    {P : Measure Ω} {X : ℝ → Ω → E} {ρ : ℝ → Measure E}
    {φ driftTerm diffusionTerm : E → ℝ}
    {sampleDrift sampleDiffusion : Ω → ℝ} {s0 σ : ℝ}
    (hρ : ∀ s, ρ s = Measure.map (X s) P)
    (hX : ∀ s, AEMeasurable (X s) P)
    (hφ : ∀ s, AEStronglyMeasurable φ (ρ s))
    (hderiv :
      HasDerivAt (fun s => ∫ ω, φ (X s ω) ∂P)
        ((∫ ω, sampleDrift ω ∂P) +
          (σ ^ 2 / 2) * (∫ ω, sampleDiffusion ω ∂P)) s0)
    (hDrift :
      (∫ ω, sampleDrift ω ∂P) = ∫ x, driftTerm x ∂ρ s0)
    (hDiffusion :
      (∫ ω, sampleDiffusion ω ∂P) = ∫ x, diffusionTerm x ∂ρ s0) :
    HasDerivAt (fun s => ∫ x, φ x ∂ρ s)
      ((∫ x, driftTerm x ∂ρ s0) +
        (σ ^ 2 / 2) * (∫ x, diffusionTerm x ∂ρ s0)) s0 := by
  have hbase :
      HasDerivAt (fun s => ∫ x, φ x ∂ρ s)
        ((∫ ω, sampleDrift ω ∂P) +
          (σ ^ 2 / 2) * (∫ ω, sampleDiffusion ω ∂P)) s0 :=
    AutoSamplingTheory.lawIntegralHasDerivAtOfMeasureMapEqAndSample
      (P := P) (X := X) (ρ := ρ) (φ := φ)
      hρ hX hφ hderiv
  simpa [hDrift, hDiffusion] using hbase

end WeakGenerator
end StochasticProcesses
end TechnicalLemmas
end AutoSamplingTheory
