# ASTIS semantic round-trip and theorem denoising

ASTIS uses Lean for two different truth questions:

1. **Lean truth:** does the declaration compile without fake closure?
2. **Source fidelity:** does that declaration still express the theorem that the source intended?

Compilation answers only the first question. The semantic round-trip gate answers the second by requiring

\[
T_{\mathrm{source}}
\longrightarrow L_{\mathrm{Lean}}
\longrightarrow \widehat T_{\mathrm{blind}}
\longrightarrow \operatorname{SemanticDiff}(T_{\mathrm{source}},\widehat T_{\mathrm{blind}}).
\]

The Lean-to-text decoder is blind: it receives an anonymous packet containing the compiled Lean proposition and explicitly approved definition context, but no source theorem, source identity, theorem number, source anchor, audit ID, Lean file/declaration identity, prior semantic audit, or repair proposal. A different reviewer then receives a fresh anti-anchored comparison packet containing the source and blind reconstruction but no prior slots, deltas, verdict, or repair suggestions.

## Two ASTIS contributions

### Theorem Fidelity Checker

Every reviewed audit compares seven semantic slots:

- mathematical objects;
- domains and ambient spaces;
- quantifiers;
- assumptions and regularity;
- conclusion;
- scope/sense of equality (pointwise, almost everywhere, local/global, weak/strong, and so on);
- dependencies of constants.

The verdict taxonomy distinguishes exact equivalence from explicit elaboration, strengthened Lean assumptions, weakened Lean conclusions, domain/quantifier mismatches, source underspecification, and possible source error. Text similarity is never accepted as semantic evidence.

### Lean Theorem Denoiser

Formalization can expose omitted integrability, measurability, smoothness, positivity, boundary, representative, or constant-dependence conditions. ASTIS records these as **repair proposals**, not edits to the source theorem. A proposal must state its minimal change, reconstructed statement, mathematical justification, and minimality evidence. It becomes accepted only after independent source review and a reference or counterexample; a suspected formalization artifact can never be promoted to an accepted source correction.

## State machine

```text
source-pinned
  -> Lean target compiled
  -> blind reconstruction
  -> seven-slot semantic diff
  -> fidelity verdict
  -> optional repair proposal
  -> independent source review
  -> accepted / rejected
```

`compiled` is therefore not `sourceReviewed`, and `sourceReviewed` is not permission to mutate a faithful source statement. The original source text, its hash, the Lean statement hash, the blind decoder inputs, the semantic deltas, and the review evidence remain separately inspectable.

## Commands

Validate the canonical registry:

```bash
python3 tools/astis_semantic_roundtrip.py check
```

Print the current audit and repair counts:

```bash
python3 tools/astis_semantic_roundtrip.py summary
```

Create an anonymous packet for an independent decoder without revealing source, audit, or declaration identity:

```bash
python3 tools/astis_semantic_roundtrip.py decoder-packet \
  --audit-id ASTIS-RT-... \
  --output runs/semantic-roundtrip/ASTIS-RT-....decoder.json
```

After recording the blind reconstruction and its hashes, create an independent semantic-review packet. This packet exposes the source and reconstruction for comparison but hides any earlier semantic judgment, preventing the reviewer from merely ratifying a previous model:

```bash
python3 tools/astis_semantic_roundtrip.py reviewer-packet \
  --audit-id ASTIS-RT-... \
  --output runs/semantic-roundtrip/ASTIS-RT-....review.json
```

The formalizer, blind decoder, and source reviewer must have distinct identities. The registry pins the original text, Lean statement, anonymous decoder packet, decoder run, reconstruction, and any repaired statement with SHA-256 hashes.

The canonical machine-readable registry is `research-wiki/semantic-roundtrip/registry.json`. The Underlying Lean Graph reads the same registry, so protocol stages, fidelity verdicts, semantic deltas, and denoising proposals shown to readers are generated from the gated evidence rather than hand-written website claims.
