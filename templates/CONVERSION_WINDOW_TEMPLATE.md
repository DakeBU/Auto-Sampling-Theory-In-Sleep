# Conversion Window: TITLE

Task id: `TASK_ID`
Mode: `faithfulPaper | exploratoryProof`

## Source Fragment

```tex
% theorem, definition, equation, or proof fragment
```

## Lean Mapping

| Source symbol/claim | Mathematical meaning | Lean declaration | Type / role | Status |
|---|---|---|---|---|
| `rho_t` | law of the sampler | `rho` | measure contract | unmapped |

## Sampling Contract

- State space:
- Base diffusion / flow:
- Target path:
- Guide / reward / tilt:
- Discretization:
- Error metric:
- Complexity term:

## Proof-DAG Map

| Block | Interface | Source anchor | Lean declaration | Depends on | Reused by | Status |
|---|---|---|---|---|---|---|
| | | | | | | |

## Cited Results

| Result | Source | Exact statement used | Local Lean target | Status |
|---|---|---|---|---|
| | | | | |

## Markdown Explanation

Explain the source proof route for humans without changing the theorem.

## Lean Draft

```lean
-- Lean code draft
```

## Gaps

- [ ] Missing definition:
- [ ] Missing lemma:
- [ ] Missing cited result:
- [ ] Source contract drift:

## Dialogue And Trials

```bash
python3 tools/astis.py agent-note latest --role middle --message "..."
python3 tools/astis.py trial-log --task TASK_ID --role middle --kind handoff --status queued --notes "..."
```

