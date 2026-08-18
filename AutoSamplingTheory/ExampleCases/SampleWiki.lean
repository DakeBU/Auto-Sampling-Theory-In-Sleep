/-!
# SampleWiki example-case lane

This module owns the formal intake contract for mathematical cases discovered at
`https://samplewiki.morning-recipe-422a.workers.dev/`.

A source page is **not** a proved ASTIS result merely because it was crawled,
parsed, translated into a theorem-shaped statement, or compiled as a type.  A
mathematical case enters the reusable ASTIS Lean graph only after its source
identity is pinned, its ASTIS restatement is reviewed against that source, its
Lean proof compiles, and the case has been explicitly assimilated into the
shared dependency DAG.

Individual mathematical cases will live below
`AutoSamplingTheory.ExampleCases.SampleWiki.Cases` as the source watcher
identifies and pins them.  This file deliberately does not invent statements
for source material that has not yet been retrieved.
-/

namespace AutoSamplingTheory
namespace ExampleCases
namespace SampleWiki

/-- Stable source identity attached to a SampleWiki case before mathematical
formalization begins.  The hashes are supplied by the source watcher rather
than trusted as mathematical evidence by themselves. -/
structure SourceIdentity where
  stableId : String
  sourceUrl : String
  pageSha256 : String
  statementSha256 : String := ""
  deriving Repr, DecidableEq

/-- Verification stages are intentionally finer than a Boolean `verified`
flag.  In particular, successful Lean elaboration precedes semantic source
review and graph assimilation. -/
inductive VerificationStage where
  | discovered
  | sourcePinned
  | normalized
  | leanTarget
  | compiled
  | sourceReviewed
  | assimilated
  deriving Repr, DecidableEq

/-- Only a source-reviewed or already assimilated case is eligible to feed the
scientific theorem graph.  A merely compiled theorem-shaped declaration is not
enough. -/
def admissibleForScientificGraph : VerificationStage → Prop
  | .sourceReviewed => True
  | .assimilated => True
  | _ => False

/-- An assimilated SampleWiki case satisfies the graph-admission contract. -/
theorem assimilated_admissible :
    admissibleForScientificGraph .assimilated := by
  trivial

/-- Compilation alone does not discharge the source-review boundary. -/
theorem compiled_not_admissible :
    ¬ admissibleForScientificGraph .compiled := by
  intro h
  exact h

/-- Discovery alone is never treated as a formal mathematical certificate. -/
theorem discovered_not_admissible :
    ¬ admissibleForScientificGraph .discovered := by
  intro h
  exact h

end SampleWiki
end ExampleCases
end AutoSamplingTheory
