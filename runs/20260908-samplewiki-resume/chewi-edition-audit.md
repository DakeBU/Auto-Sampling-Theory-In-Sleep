# Canonical source recovery before the Fisher/transport packet

The canonical August 9, 2026 edition is recovered byte-for-byte. Its SHA256
matches `website/content/source_edition.json`; the existing edition is **not**
replaced. Both downloads and page renders stay in the ignored, original-repository
`.astis/source-cache/` directory. No new Goal, cycle, proof leaf or external
checkout is created by this audit.

The live author URL now serves the August 20 edition (333 PDF pages, instead of
329). Consequently an old page fragment on that URL can point at the wrong
mathematical step. New source-facing packets should cite the recovered
[immutable August 9 source](https://raw.githubusercontent.com/chewisinho/chewisinho.github.io/b3ad6e874119983ae5f689a3295df4cdb44b11a7/main.pdf#page=233).
The exact downloads, author commits, hashes and inspection scope are in
`chewi-edition-audit.json` beside this note.

| Selected source | Canonical August 9 | Live August 20 | Bounded observation |
| --- | --- | --- | --- |
| Theorem 1.4.5 and display (1.4.7) | printed 34 / PDF 46 | printed 34 / PDF 46 | Page texts agree; complete pages visually inspected. |
| Theorem 8.4.1, score/transport estimate in the proof | printed 221 / PDF 233 | printed 222 / PDF 234 | The chosen calculation agrees; running header and later prose differ. Both complete pages visually inspected. |

The next analytic edge concerns the integrability and Cauchy--Schwarz estimate
for the canonical score paired with a displacement under an actual coupling.
That edge alone does not prove a KL first variation, geodesic convexity, a heat
flow derivative, contraction or the proximal convergence rate. Smooth finite
score hypotheses and the optimal-coupling hypothesis must remain explicit.

This is a targeted provenance check, not a whole-book cross-edition equivalence
review. Existing global links to the live URL need a separate edition-aware link
audit before their old page fragments can be advertised as stable. No textbook
license change or permission to reproduce extended prose is inferred.
