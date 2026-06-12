import AutoSamplingTheory.Probability

/-!
# ASTIS-native variational and LSI/FI bookkeeping lemmas

These declarations are small compiled proof blocks extracted from the SALD
formalization effort.  They represent prior/background analytic algebra such
as Donsker--Varadhan one-sided consequences and LSI density bookkeeping; large
background theorems remain proof obligations until locally ported.
-/

namespace AutoSamplingTheory
namespace TechnicalLemmas
namespace Variational

export AutoSamplingTheory (
  lsiKlFiSqrtDensitySquareScalar
  lsiKlFiSqrtDensityEntropyIntegrandScalar
  lsiKlFiSqrtDensityNormalizationScalar
  lsiKlFiRnDerivLIntegralMassOne
  lsiKlFiRnDerivDensityMassOne
  lsiKlFiSqrtRnDerivTestMassOne
  lsiKlFiRnDerivEntropyIntegral
  lsiKlFiSqrtRnDerivEntropyIntegral
  lsiKlFiSqrtDensityFisherChainScalar
  lsiKlFiSqrtDensityFisherChainOfDerivativesScalar
  lsiKlFiSqrtDensityFisherChainFiniteSumScalar
  lsiKlFiSqrtDensityFisherChainFiniteSumHandoffScalar
  lsiKlFiSqrtDensityFisherChainIntegralFiniteSum
  lsiKlFiSqrtDensityFisherChainIntegralHandoffScalar
  dvVariationalOneSidedConsequenceScalar
  dvVariationalOneSidedFromSupremumScalar
  dvFiniteLogMgfOfLeAlpha
  dvVariationalOneSidedOfTiltedRight
  dvVariationalOneSidedOfScaledTest
  dvVariationalScaledTestEnergyBound
  dvVariationalScaledTestEnergyBoundWithCoeff
  dvVariationalTiltedRightOneSidedConsequence
)

end Variational
end TechnicalLemmas
end AutoSamplingTheory

