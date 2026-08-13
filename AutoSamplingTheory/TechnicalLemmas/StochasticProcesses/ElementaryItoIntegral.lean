import Mathlib.Probability.Process.Adapted

/-!
# Elementary Ito integrals

This file formalizes the finite-sum starting point of Chewi's construction of
the scalar Ito integral. It does not postulate or construct the later `L2`
completion. An elementary process carries its strict time grid, coefficients
measurable at the left endpoints, and the source's boundedness condition.
-/

namespace AutoSamplingTheory
namespace TechnicalLemmas
namespace StochasticProcesses
namespace ElementaryItoIntegral

open MeasureTheory
open scoped BigOperators NNReal

/-- The data and regularity conditions of the elementary adapted process in
Chewi display (1.1.2). There are `n` half-open time intervals and `n + 1`
strictly increasing endpoints. -/
structure ElementaryAdaptedProcess
    {Omega : Type*} {m : MeasurableSpace Omega}
    (filtration : Filtration ℝ≥0 m) (n : ℕ) where
  times : Fin (n + 1) → ℝ≥0
  times_strictMono : StrictMono times
  coeff : Fin n → Omega → ℝ
  coeff_stronglyMeasurable :
    ∀ i, StronglyMeasurable[filtration (times i.castSucc)] (coeff i)
  coeff_bounded : ∀ i, ∃ C : ℝ, ∀ omega, |coeff i omega| ≤ C

/-- Value of an elementary adapted process at a time and sample point. -/
noncomputable def ElementaryAdaptedProcess.value
    {Omega : Type*} {m : MeasurableSpace Omega}
    {filtration : Filtration ℝ≥0 m} {n : ℕ}
    (eta : ElementaryAdaptedProcess filtration n) (t : ℝ≥0) (omega : Omega) : ℝ :=
  ∑ i, if eta.times i.castSucc < t ∧ t ≤ eta.times i.succ
    then eta.coeff i omega else 0

/-- Chewi display (1.1.2): an elementary adapted process is the finite sum of
its left-endpoint measurable coefficients on `(t_i, t_{i+1}]`. -/
theorem chewi_display_1_1_2
    {Omega : Type*} {m : MeasurableSpace Omega}
    {filtration : Filtration ℝ≥0 m} {n : ℕ}
    (eta : ElementaryAdaptedProcess filtration n) (t : ℝ≥0) (omega : Omega) :
    eta.value t omega =
      ∑ i, if eta.times i.castSucc < t ∧ t ≤ eta.times i.succ
        then eta.coeff i omega else 0 :=
  rfl

/-- The finite Brownian-increment sum used to define the Ito integral of an
elementary process at terminal time `T`. -/
noncomputable def elementaryItoIntegral
    {Omega : Type*} {m : MeasurableSpace Omega}
    {filtration : Filtration ℝ≥0 m} {n : ℕ}
    (eta : ElementaryAdaptedProcess filtration n)
    (B : ℝ≥0 → Omega → ℝ) (T : ℝ≥0) (omega : Omega) : ℝ :=
  ∑ i, eta.coeff i omega *
    (B (min (eta.times i.succ) T) omega -
      B (min (eta.times i.castSucc) T) omega)

/-- Chewi display (1.1.3): the elementary Ito integral is exactly the finite
sum of adapted coefficients times stopped Brownian increments. -/
theorem chewi_display_1_1_3
    {Omega : Type*} {m : MeasurableSpace Omega}
    {filtration : Filtration ℝ≥0 m} {n : ℕ}
    (eta : ElementaryAdaptedProcess filtration n)
    (B : ℝ≥0 → Omega → ℝ) (T : ℝ≥0) (omega : Omega) :
    elementaryItoIntegral eta B T omega =
      ∑ i, eta.coeff i omega *
        (B (min (eta.times i.succ) T) omega -
          B (min (eta.times i.castSucc) T) omega) :=
  rfl

end ElementaryItoIntegral
end StochasticProcesses
end TechnicalLemmas
end AutoSamplingTheory
