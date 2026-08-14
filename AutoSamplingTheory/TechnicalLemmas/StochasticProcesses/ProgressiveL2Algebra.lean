import AutoSamplingTheory.TechnicalLemmas.StochasticProcesses.ProgressiveL2

/-!
# Algebra of progressive L2 integrands

The source domain for stochastic integration is closed under the real vector
space operations.  This file keeps those operations at the representative
process level and proves compatibility with the canonical product-space `Lp`
representative.
-/

namespace AutoSamplingTheory
namespace TechnicalLemmas
namespace StochasticProcesses
namespace ProgressiveL2Algebra

open MeasureTheory
open scoped NNReal

open ElementaryItoIntegral ProgressiveL2

variable {Omega : Type*} {m : MeasurableSpace Omega}
  {filtration : Filtration ℝ≥0 m} {mu : Measure Omega} {T : ℝ≥0}

def zero : ProgressiveL2Integrand filtration mu T where
  process := fun _ _ => 0
  progressive := isStronglyProgressive_const filtration 0
  memLp := MemLp.zero

def add (eta xi : ProgressiveL2Integrand filtration mu T) :
    ProgressiveL2Integrand filtration mu T where
  process := fun t omega => eta.process t omega + xi.process t omega
  progressive := eta.progressive.add xi.progressive
  memLp := eta.memLp.add xi.memLp

def neg (eta : ProgressiveL2Integrand filtration mu T) :
    ProgressiveL2Integrand filtration mu T where
  process := fun t omega => -eta.process t omega
  progressive := eta.progressive.neg
  memLp := eta.memLp.neg

def sub (eta xi : ProgressiveL2Integrand filtration mu T) :
    ProgressiveL2Integrand filtration mu T where
  process := fun t omega => eta.process t omega - xi.process t omega
  progressive := eta.progressive.sub xi.progressive
  memLp := eta.memLp.sub xi.memLp

def smul (c : ℝ) (eta : ProgressiveL2Integrand filtration mu T) :
    ProgressiveL2Integrand filtration mu T where
  process := fun t omega => c * eta.process t omega
  progressive := fun i => (eta.progressive i).const_smul c
  memLp := eta.memLp.const_smul c

@[simp] theorem zero_process :
    (zero : ProgressiveL2Integrand filtration mu T).process = 0 :=
  rfl

@[simp] theorem add_process (eta xi : ProgressiveL2Integrand filtration mu T) :
    (add eta xi).process = eta.process + xi.process :=
  rfl

@[simp] theorem neg_process (eta : ProgressiveL2Integrand filtration mu T) :
    (neg eta).process = -eta.process :=
  rfl

@[simp] theorem sub_process (eta xi : ProgressiveL2Integrand filtration mu T) :
    (sub eta xi).process = eta.process - xi.process :=
  rfl

@[simp] theorem smul_process (c : ℝ)
    (eta : ProgressiveL2Integrand filtration mu T) :
    (smul c eta).process = c • eta.process :=
  rfl

@[simp] theorem toLp_zero :
    (zero : ProgressiveL2Integrand filtration mu T).toLp = 0 :=
  rfl

theorem toLp_add (eta xi : ProgressiveL2Integrand filtration mu T) :
    (add eta xi).toLp = eta.toLp + xi.toLp :=
  rfl

theorem toLp_neg (eta : ProgressiveL2Integrand filtration mu T) :
    (neg eta).toLp = -eta.toLp :=
  rfl

theorem toLp_sub (eta xi : ProgressiveL2Integrand filtration mu T) :
    (sub eta xi).toLp = eta.toLp - xi.toLp :=
  rfl

theorem toLp_smul (c : ℝ) (eta : ProgressiveL2Integrand filtration mu T) :
    (smul c eta).toLp = c • eta.toLp :=
  rfl

end ProgressiveL2Algebra
end StochasticProcesses
end TechnicalLemmas
end AutoSamplingTheory
