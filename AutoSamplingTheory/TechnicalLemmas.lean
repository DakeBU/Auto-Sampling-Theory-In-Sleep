import AutoSamplingTheory.TechnicalLemmas.Analysis
import AutoSamplingTheory.TechnicalLemmas.FunctionalInequalities
import AutoSamplingTheory.TechnicalLemmas.Gaussian
import AutoSamplingTheory.TechnicalLemmas.Geometry
import AutoSamplingTheory.TechnicalLemmas.InformationTheory
import AutoSamplingTheory.TechnicalLemmas.Measure
import AutoSamplingTheory.TechnicalLemmas.Probability
import AutoSamplingTheory.TechnicalLemmas.ProbabilityDistributions
import AutoSamplingTheory.TechnicalLemmas.Registry
import AutoSamplingTheory.TechnicalLemmas.StochasticProcesses
import AutoSamplingTheory.TechnicalLemmas.Taylor
import AutoSamplingTheory.TechnicalLemmas.Variational

/-!
# ASTIS reusable technical lemma arsenal

This parent module is the public import surface for ASTIS-owned reusable
SDE/Sampling technical lemmas that are candidates for Mathlib-style cleanup.

It deliberately excludes `AutoSamplingTheory.TechnicalLemmas.SALDExtracted`.
Those declarations compile and are searchable, but they are paper-extracted
bridges that should be generalized before being treated as Mathlib-ready
technical lemmas.
-/