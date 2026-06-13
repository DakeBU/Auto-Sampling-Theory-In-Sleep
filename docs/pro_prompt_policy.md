# ChatGPT Pro Post-Cycle Prompt Policy

Every completed long ASTIS loop must leave two human-facing artifacts:

- `paper-notes/SALD/markdown/cycle-summaries/latest.md`: Chinese status for
  humans, with source-paper anchors and the reason each remaining Lean proof is
  still open.
- `runs/pro-prompts/ASTIS-SALD-001-latest.md`: a self-contained prompt that can
  be pasted into ChatGPT Pro when the local agents did not close the target.

The Pro prompt assumes ChatGPT Pro cannot read local files.  It must include
public paper links when available, the current theorem target, open paper
contribution obligations, open external technical lemmas, recent typed verifier
feedback, and the exact kind of answer needed next.  Local file paths and Lean
names may appear only as labels for patching this repository later.

Faithful-paper prompts must forbid changing theorem statements, constants,
assumptions, schedules, or proof targets.  Exploratory prompts must first state
the acceptance predicate and Lean-checkable target before asking for new proof
routes.

Manual regeneration:

```bash
python3 tools/astis.py cycle-pro-prompt ASTIS-SALD-001 --run-id latest
```
