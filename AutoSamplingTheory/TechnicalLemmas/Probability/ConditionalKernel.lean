import AutoSamplingTheory.Probability

/-!
# Conditional-kernel technical lemmas

Reusable `condDistrib` / `condExpKernel` bridges and conditional-integral
regularity lemmas.

This module is a Mathlib-style search surface over compiled ASTIS-owned
declarations.  It separates conditional-law infrastructure from generic
pushforward-law rewrites, which keeps lower-agent packets small.
-/

namespace AutoSamplingTheory
namespace TechnicalLemmas
namespace Probability
namespace ConditionalKernel

export AutoSamplingTheory (
  condDistribAeEqCondExpKernelMap
  condDistribIntegralSampleAeEqOfCondExpKernelMap
  condDistribIntegralAEStronglyMeasurable
  condDistribIntegralIntegrable
  condDistribIntegralMapAEStronglyMeasurable
  condDistribIntegralMapIntegrable
  condDistribIntegralMapIntegral
  condDistribIntegralNamedLawIntegral
  condDistribIntegralNamedLawAEStronglyMeasurable
  condDistribIntegralNamedLawIntegrable
  condDistribIntegralNamedFieldRegularity
)

end ConditionalKernel
end Probability
end TechnicalLemmas
end AutoSamplingTheory

