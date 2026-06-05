import AutoSamplingTheory.Core

namespace AutoSamplingTheory

inductive AutomationStage where
  | sourceIndex
  | formalSpec
  | leanStatements
  | proofSearch
  | review
  | documented
deriving Repr, DecidableEq

inductive TaskKind where
  | paperReproduction
  | exploratoryProof
  | lemmaRepair
  | sourceAudit
  | proofExport
  | openProblemProposal
deriving Repr, DecidableEq

inductive TaskStatus where
  | planned
  | active
  | blocked
  | indexed
  | leanCompiles
  | merged
deriving Repr, DecidableEq

inductive AgentRole where
  | upper
  | middle
  | lower
  | reviewer
deriving Repr, DecidableEq

structure AcceptanceGate where
  name : String
  command : String
  required : Bool
  note : String
deriving Repr, DecidableEq

structure ArtifactSpec where
  path : String
  language : ArtifactLanguage
  purpose : String
  mustCompile : Bool
deriving Repr, DecidableEq

structure AutomationTask where
  id : String
  title : String
  kind : TaskKind
  status : TaskStatus
  stage : AutomationStage
  mode : String
  source : String
  targetLean : String
  artifacts : List ArtifactSpec
  gates : List AcceptanceGate
deriving Repr, DecidableEq

structure AgentContract where
  role : AgentRole
  responsibility : String
  writes : List String
  mustLogTrial : Bool
deriving Repr, DecidableEq

def leanBuildGate : AcceptanceGate where
  name := "Lean build"
  command := "lake exe cache get && lake build && lake build Tests"
  required := true
  note := "Every automation run must preserve the Lean build."

def forbiddenPatternGate : AcceptanceGate where
  name := "No fake proof closures"
  command := "rg -n \"\\bsorry\\b|\\badmit\\b|\\baxiom\\b|Prop := True|:= trivial\" AutoSamplingTheory Tests || true"
  required := true
  note := "Mathematical content must be obligations or real proofs, not fake closures."

def defaultGates : List AcceptanceGate := [leanBuildGate, forbiddenPatternGate]

def threeLayerAgentContracts : List AgentContract :=
  [
    {
      role := AgentRole.upper
      responsibility := "Choose mode, objective, non-goals, dynamic leaf or illness area, and compress LBG-style memory for the next proof cycle."
      writes := ["runs/<run-id>/10_upper_director.md", "runs/<run-id>/90_handoff.md"]
      mustLogTrial := true
    },
    {
      role := AgentRole.middle
      responsibility := "Maintain LaTeX/Markdown/Lean conversion, SLT reuse audit, proof obligations, and lower-ready packets."
      writes := ["conversion-windows/", "proof-obligations/", "research-wiki/cited-results/"]
      mustLogTrial := true
    },
    {
      role := AgentRole.lower
      responsibility := "Attempt one Lean declaration, proof block, source-index repair, proof-obligation refinement, or exploratory candidate route."
      writes := ["AutoSamplingTheory/", "Tests/", "proof-attempts/", "candidate-populations/"]
      mustLogTrial := true
    },
    {
      role := AgentRole.reviewer
      responsibility := "Independently audit build gate, hidden assumptions, source correspondence, SLT port correctness, and faithful/exploratory mode discipline."
      writes := ["reviews/", "runs/<run-id>/dialogue.md"]
      mustLogTrial := true
    }
  ]

def conversionArtifacts (stem : String) : List ArtifactSpec :=
  [
    {
      path := "tasks/" ++ stem ++ ".md"
      language := ArtifactLanguage.markdown
      purpose := "Task contract and progress log."
      mustCompile := false
    },
    {
      path := "conversion-windows/" ++ stem ++ ".md"
      language := ArtifactLanguage.markdown
      purpose := "Synchronized source/Lean/proof-obligation map."
      mustCompile := false
    },
    {
      path := "AutoSamplingTheory/" ++ stem ++ ".lean"
      language := ArtifactLanguage.lean
      purpose := "Lean statement layer or formalized proof blocks."
      mustCompile := true
    }
  ]

def seedAutomationTasks : List AutomationTask :=
  [
    {
      id := "ASTIS-SALD-001"
      title := "Faithfully reproduce the original VA-SALD paper proofs"
      kind := TaskKind.paperReproduction
      status := TaskStatus.active
      stage := AutomationStage.sourceIndex
      mode := "faithfulPaper"
      source := "/home/nitanda_sub/mark/repos/sald/paper excluding sald_version_2.tex"
      targetLean := "AutoSamplingTheory/SALD.lean"
      artifacts := conversionArtifacts "SALD"
      gates := defaultGates
    },
    {
      id := "ASTIS-RMFLD-001"
      title := "Index and validate current RMFLD exploratory proof routes"
      kind := TaskKind.exploratoryProof
      status := TaskStatus.planned
      stage := AutomationStage.sourceIndex
      mode := "exploratoryProof"
      source := "/home/nitanda_sub/mark/repos/RMFLD/RMFLD_paper"
      targetLean := "AutoSamplingTheory/RMFLD.lean"
      artifacts := conversionArtifacts "RMFLD"
      gates := defaultGates
    }
  ]

def automationTaskCount : Nat := seedAutomationTasks.length

end AutoSamplingTheory
