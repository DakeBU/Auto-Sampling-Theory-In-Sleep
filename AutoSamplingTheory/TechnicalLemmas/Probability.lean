import AutoSamplingTheory.TechnicalLemmas.Probability.ConditionalKernel
import AutoSamplingTheory.TechnicalLemmas.Probability.FiniteProductPairMarginal
import AutoSamplingTheory.TechnicalLemmas.Probability.FiniteProductSupport
import AutoSamplingTheory.TechnicalLemmas.Probability.LawMap
import AutoSamplingTheory.TechnicalLemmas.Probability.NormalizedFiniteMeasure
import AutoSamplingTheory.TechnicalLemmas.Probability.UniformExpectationGap

/-!
# Probability technical lemma arsenal

Parent import surface for Mathlib-ready probability lemmas used by ASTIS:
law-map rewrites, weak-test integral transport, conditional-kernel bridges,
normalization/support facts for finite local measures, one- and two-coordinate
finite-product probability laws, probability-one support boxes, and uniform
almost-sure expectation gaps.
-/