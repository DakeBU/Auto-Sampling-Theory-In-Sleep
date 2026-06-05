# Source To Lean Workflow

## Faithful Paper Mode

1. Index source theorem, lemma, proposition, corollary, definition, and
   assumption labels.
2. Paste the source theorem/proof fragment into a conversion window.
3. Map every LaTeX symbol to an existing or planned Lean declaration.
4. If the proof uses external analysis, record it in cited-results memory.
5. Add Lean statements or proof-obligation records.
6. Run `python3 tools/astis.py check`.

For the SALD target, public artifacts should cite source labels and file names,
not rely solely on machine-specific paths.

## Exploratory Proof Mode

1. Index the draft.
2. Keep candidate proof routes in `candidate-populations/`.
3. Do not weaken the target silently.
4. Promote unresolved dependencies to proof obligations.

The exploratory route may use an EoH-like population loop: initialize several
candidate proof decompositions, mutate or recombine them, evaluate against the
Lean-checkable acceptance predicate, and archive failures.  This rule does not
apply to `faithfulPaper` mode, where the source theorem and proof target are
fixed.
