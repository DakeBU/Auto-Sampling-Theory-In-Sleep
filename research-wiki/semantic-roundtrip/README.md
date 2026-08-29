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

The Lean-to-text decoder is blind: it receives an anonymous packet containing the compiled Lean proposition and explicitly approved definition context, but no source theorem, source identity, theorem number, source anchor, audit ID, Lean file/declaration identity, prior semantic audit, or repair proposal. The gate also scans every approved definition-context string against the known source/audit/declaration/repair secrets, so those fields cannot be used as an unreviewed identity side channel. A different reviewer then receives a fresh anti-anchored comparison packet containing the source and blind reconstruction but no prior slots, deltas, verdict, or repair suggestions.

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

A completed source review is bound to both the exact anti-anchored reviewer packet and the exact reviewer execution through SHA-256 hashes. Changing the source, Lean statement, blind reconstruction, formalizer, or decoder invalidates the recorded review packet binding.

### Lean Theorem Denoiser

Formalization can expose omitted integrability, measurability, smoothness, positivity, boundary, representative, or constant-dependence conditions. ASTIS records these as **repair proposals**, not edits to the source theorem. A proposal must state its minimal change, reconstructed statement, mathematical justification, minimality evidence, and a reference or counterexample.

A repair is reviewed separately from the theorem-fidelity verdict. ASTIS generates a fresh repair-review packet containing the source theorem, Lean statement, blind reconstruction, and the exact proposed change, while hiding prior fidelity verdicts, semantic-delta classifications, source-review decisions, and earlier repair-review decisions. The repair reviewer must be independent from both formalizer and blind decoder. Its decision is bound to the entire source-facing repair payload (`class`, necessity, proposed change, reconstructed statement, justification, minimality evidence, and reference/counterexample), the reviewer packet, and the reviewer run by SHA-256. Therefore changing a proposal after review invalidates the review automatically.

A suspected formalization artifact can never be promoted to an accepted source correction.

## State machine

```text
source-pinned
  -> Lean target compiled
  -> blind reconstruction
  -> seven-slot semantic diff
  -> fidelity verdict
  -> independent source review
  -> optional repair proposal
  -> independent exact-proposal repair review
  -> accepted / rejected
```

`compiled` is therefore not `sourceReviewed`, and `sourceReviewed` is not permission to mutate a faithful source statement. The original source text, its hash, the Lean statement hash, the blind decoder inputs, semantic review packet/run, semantic deltas, repair payload, and repair review packet/run remain separately inspectable.

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

The command refuses to emit a packet if any approved definition-context entry is not a plain non-empty string or contains an exact known source/audit/declaration/repair secret.

After recording the blind reconstruction and its hashes, create an independent semantic-review packet. This packet exposes the source and reconstruction for comparison but hides any earlier semantic judgment, preventing the reviewer from merely ratifying a previous model:

```bash
python3 tools/astis_semantic_roundtrip.py reviewer-packet \
  --audit-id ASTIS-RT-... \
  --output runs/semantic-roundtrip/ASTIS-RT-....review.json
```

When a denoising proposal exists, create its own independent review packet:

```bash
python3 tools/astis_semantic_roundtrip.py repair-reviewer-packet \
  --audit-id ASTIS-RT-... \
  --repair-id ASTIS-REPAIR-... \
  --output runs/semantic-roundtrip/ASTIS-REPAIR-....review.json
```

The formalizer, blind decoder, and each source-facing reviewer must satisfy the recorded independence contract. The canonical registry pins the original text, Lean statement, anonymous decoder packet, decoder run, reconstruction, source-review packet/run, repaired statement, exact repair payload, and repair-review packet/run with SHA-256 hashes.

The canonical machine-readable registry is `research-wiki/semantic-roundtrip/registry.json`. The Underlying Lean Graph reads the same registry, so protocol stages, fidelity verdicts, semantic deltas, denoising proposals, and repair-review evidence shown to readers are generated from the gated evidence rather than hand-written website claims.
