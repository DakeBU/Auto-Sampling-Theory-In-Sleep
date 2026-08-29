---
name: astis-semantic-roundtrip
description: Audit whether a compiled Lean declaration preserves its source theorem and propose source-reviewable minimal theorem repairs.
---

# ASTIS Semantic Round-Trip Skill

Use this skill for every source-facing Chewi, SampleWiki, or paper theorem after its exact Lean declaration compiles. Lean compilation proves the formal proposition; it does not prove that the proposition is the one the source intended.

## Truth boundary

Keep these claims separate:

1. **Lean truth:** the pinned declaration compiles without fake closure.
2. **Reconstruction evidence:** an independent decoder reconstructs the theorem from the Lean statement while source text, source identity, theorem number, prior audit, and repair proposals are hidden.
3. **Source fidelity:** an independent source reviewer compares the original and reconstruction slot by slot.
4. **Repair status:** a proposed denoising repair remains an overlay until source review accepts it. It never overwrites the pinned source theorem automatically.

A proving/formalizing Worker must not act as its own blind decoder or source reviewer.

## Required workflow

1. Pin the source ID, exact anchor, verbatim or licensed ASTIS source restatement, and SHA-256.
2. Pin the Lean declaration, file, fully elaborated statement available to the decoder, statement SHA-256, and compiler evidence.
3. Create or update an audit in `research-wiki/semantic-roundtrip/registry.json` in `draft` state.
4. Generate the anonymous decoder-only input. The exported packet contains no audit ID, source identity, theorem number, source anchor, Lean file/declaration identity, prior audit, or repair proposal:

   ```bash
   python3 tools/astis_semantic_roundtrip.py decoder-packet \
     --audit-id ASTIS-RT-... \
     --output runs/semantic-roundtrip/ASTIS-RT-....decoder.json
   ```

5. Give that packet—not the registry, source text, or source-facing Lean card—to an independent decoder. Record `source_text_visible=false`, the canonical decoder-packet hash, exact input artifacts, decoder identity/run hash, and reconstructed-theorem hash.
6. Generate a fresh anti-anchored review packet:

   ```bash
   python3 tools/astis_semantic_roundtrip.py reviewer-packet \
     --audit-id ASTIS-RT-... \
     --output runs/semantic-roundtrip/ASTIS-RT-....review.json
   ```

   Give it to a reviewer distinct from both formalizer and decoder. The packet contains source and reconstruction but omits all earlier semantic slots, deltas, verdicts, and repairs.
7. Compare all seven semantic slots: objects, domains, quantifiers, assumptions, conclusion, scopes/senses, and constant dependencies. Text or embedding similarity is not evidence of equivalence.
8. Classify every delta and issue a fidelity verdict. Exact/equivalent verdicts require no blocking delta; source-facing acceptance requires an independent reviewer distinct from the formalizer and decoder.
9. When formalization exposes a possible missing condition, create a separate repair proposal with a reconstructed statement, justification, minimality evidence, and a rigorous reference or counterexample. Classify whether it is mathematically necessary, source implicit, uncertain, or a formalization-artifact risk.
10. A formalization-artifact risk cannot be accepted as a source repair. In `faithfulPaper` mode, never add an assumption merely to close the current proof route.
11. Run:

   ```bash
   python3 tools/astis_semantic_roundtrip.py check
   python3 tools/astis_semantic_roundtrip.py summary
   ```

The website build projects accepted evidence, pending mismatches, and repair proposals into the `Semantic fidelity & repair` view of the Underlying Lean Graph.

## Hard rejects

Reject an audit when any of the following occurs:

- the decoder saw the source theorem, source/source-anchor/audit/declaration identity, theorem number, prior semantic audit, or repair proposal;
- one of the seven semantic slots is absent or only asserted without evidence;
- the formalizer, decoder, and source reviewer are not independent where required;
- a green Lean build is used as evidence of source fidelity;
- an accepted repair lacks minimality evidence and a reference or counterexample;
- a repair silently changes the canonical source statement;
- a source-facing theorem is marked assimilated before both Lean compilation and source review pass.
