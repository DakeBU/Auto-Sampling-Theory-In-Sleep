# MathCode Reference Notes

Reference repository: [math-ai-org/mathcode](https://github.com/math-ai-org/mathcode)

Local checkout inspected during ASTIS development:

```text
/home/nitanda_sub/mark/repos/Quantum/mathcode
```

Public ASTIS documentation should cite the upstream repository URL above, not a
machine-local checkout path.

## Why It Is Relevant

MathCode is a terminal AI coding assistant with a Lean 4 mathematical
formalization workflow.  ASTIS has a narrower scientific target: faithful and
exploratory formalization of SDE/Sampling theory.  The relevant overlap is the
Lean proof workflow, not the mathematical domain.

## Similar Patterns Worth Adapting

| Pattern | MathCode design cue | ASTIS adaptation |
|---|---|---|
| Fast feedback | Persistent Lean/Lake checking and structured diagnostics. | Keep `python3 tools/astis.py check` as the full gate, and use `python3 tools/astis.py proof-diagnostics` for lightweight reviewer summaries. |
| Hidden-assumption scans | Tools such as axiom and sorry analyzers catch placeholders and forbidden assumptions. | The ASTIS gate rejects `sorry`, `admit`, `axiom`, `constant`, `postulate`, `Prop := True`, and `:= trivial` in Lean sources. |
| Proof statistics | Summaries of declarations and proof structure make broad rewrites visible. | Reviewer agents should compare proof-diagnostics output against the assigned lower packet when broad Lean changes appear. |
| Theorem reuse memory | Stored theorem search checks existing lemmas before reproving. | Middle agents must search ASTIS declarations, conversion windows, proof obligations, and cited-result ledgers before introducing duplicate SDE/Sampling interfaces. |
| Tree-of-subgoals | Hard goals can be decomposed into subgoals and solved independently. | ASTIS may use subgoal trees internally, but placeholders must not remain in accepted Lean targets. Unproved analytic pieces stay as explicit `ProofObligation`s. |
| Multi-planner workflow | Multiple proof plans can compete before a proving attempt. | In `faithfulPaper` mode, competing plans must target the same source theorem. In `exploratoryProof` mode, they are candidate proof routes with explicit assumptions. |
| Skills/tools/plugins | Domain-specific helpers extend the agent. | ASTIS keeps domain-specific helpers in `tools/`, prompt decks, and project docs, specialized for KL/FI/LSI, Fokker--Planck, Euler--Maruyama, and particle approximations. |

## What ASTIS Should Not Copy

- ASTIS should not become a general natural-language-to-Lean service.
- ASTIS should not copy MathCode source code without a separate license audit.
  The inspected local checkout did not include a top-level license file.
- ASTIS should not accept proof-search confidence as correctness.  Lean build
  status and source correspondence remain the final checks.
- ASTIS should not store conversational assumptions as accepted mathematical
  facts.  Needed but unproved facts must be cited-result rows or explicit
  `ProofObligation`s.

## ASTIS Backlog

1. Keep `proof-diagnostics` cheap and reviewer-facing.
2. Add a theorem/proof-block registry for reusable SDE/Sampling lemmas after
   Phase 1 SALD source correspondence stabilizes.
3. Add focused-file Lean checks if full `lake build` becomes the dominant
   lower-agent bottleneck.
4. Add subgoal-tree records to `proof-attempts/` for large analytic backends.
5. Track when MathCode-inspired ideas move from documentation to enforced
   ASTIS gates.

## Citation

MathCode's README requests citation as:

```bibtex
@misc{mathcode2026,
  title = {MathCode: A Frontier Mathematical Coding Agent},
  author = {Team Math-AI},
  journal = {math-ai-org.github.io},
  year = {2026},
  month = {April},
  url = "https://github.com/math-ai-org/mathcode"
}
```
