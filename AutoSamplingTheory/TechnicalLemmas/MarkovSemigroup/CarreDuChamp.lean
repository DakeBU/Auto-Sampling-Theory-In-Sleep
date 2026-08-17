import AutoSamplingTheory.TechnicalLemmas.FunctionalInequalities.Generator

/-!
# Carre du champ, iterated carre du champ, and curvature-dimension

This file is the process-independent algebraic layer behind Chewi Definitions
1.2.12, 1.2.28, and 1.2.29.  It takes an abstract generator as input and does
not assume that the generator has already been constructed from a stochastic
process.

Positivity of `Gamma(f,f)`, integration by parts, and Bakry--Emery estimates are
**theorems** requiring additional Markov/reversibility/domain hypotheses.  They
are intentionally not baked into these definitions.
-/

namespace AutoSamplingTheory
namespace TechnicalLemmas
namespace MarkovSemigroup

/-- Chewi Definition 1.2.12: the carre-du-champ bilinear expression associated
with a generator `L`,

`Gamma(f,g) = (L(fg) - f Lg - g Lf) / 2`.

Linearity or Markov-generator properties of `L` are not silently assumed. -/
noncomputable def carreDuChamp
    {E : Type*}
    (generator : (E → ℝ) → E → ℝ)
    (f g : E → ℝ) (x : E) : ℝ :=
  (generator (fun y => f y * g y) x -
      f x * generator g x -
      g x * generator f x) / 2

/-- The defining carre-du-champ expression is symmetric even before any
analytic generator hypotheses are imposed. -/
theorem carreDuChamp_symm
    {E : Type*}
    (generator : (E → ℝ) → E → ℝ)
    (f g : E → ℝ) (x : E) :
    carreDuChamp generator f g x = carreDuChamp generator g f x := by
  simp only [carreDuChamp]
  congr 1
  · congr 2
    funext y
    exact mul_comm (f y) (g y)
  · ring

/-- Diagonal notation for the carré du champ. -/
noncomputable def carreDuChampSelf
    {E : Type*}
    (generator : (E → ℝ) → E → ℝ)
    (f : E → ℝ) (x : E) : ℝ :=
  carreDuChamp generator f f x

/-- Chewi Definition 1.2.28: the iterated carre du champ.

`Gamma2(f,g) = (L Gamma(f,g) - Gamma(f,Lg) - Gamma(g,Lf)) / 2`.
-/
noncomputable def gammaTwo
    {E : Type*}
    (generator : (E → ℝ) → E → ℝ)
    (f g : E → ℝ) (x : E) : ℝ :=
  (generator (fun y => carreDuChamp generator f g y) x -
      carreDuChamp generator f (generator g) x -
      carreDuChamp generator g (generator f) x) / 2

/-- Diagonal notation for the iterated carré du champ. -/
noncomputable def gammaTwoSelf
    {E : Type*}
    (generator : (E → ℝ) → E → ℝ)
    (f : E → ℝ) (x : E) : ℝ :=
  gammaTwo generator f f x

/-- Chewi Definition 1.2.29: the `CD(alpha, infinity)` lower-curvature
condition, stated pointwise on the chosen generator/test-function class.

A later source-facing wrapper can restrict the universal quantifier to the
actual generator domain/core without changing this algebraic predicate. -/
def SatisfiesCDInf
    {E : Type*}
    (generator : (E → ℝ) → E → ℝ)
    (alpha : ℝ) : Prop :=
  ∀ (f : E → ℝ) (x : E),
    alpha * carreDuChampSelf generator f x ≤ gammaTwoSelf generator f x

end MarkovSemigroup
end TechnicalLemmas
end AutoSamplingTheory
