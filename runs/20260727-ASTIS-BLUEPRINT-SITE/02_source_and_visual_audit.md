# Source, copyright, and visual audit

## Chewi source

- Source: Sinho Chewi, *Log-Concave Sampling*,
  <https://chewisinho.github.io/main.pdf>
- inspected version: June 12, 2026
- inspected length: 323 PDF pages
- chapter count: 12
- contents pages and Chapter 1 Definition 1.2.1, Definition 1.2.3,
  Example 1.2.4, Example 1.2.8, Corollary 1.2.9, and the LSI packet were
  checked against the PDF text/layout.
- source correspondence reports both book page and physical PDF page when a
  fine-grained anchor is present.

The public book and author page expose no explicit republication license.
Website prose therefore uses original faithful paraphrase and ASTIS
supplements. It does not reproduce the book wholesale.

## Lean-Ridgelet

- author: Sho Sonoda
- repository: <https://github.com/shosonoda/lean-ridgelet>
- Blueprint:
  <https://shosonoda.github.io/lean-ridgelet/blueprint/html-multi/overview/#Lean-Ridgelet-Blueprint--L2-theory___-arXiv___2106___04770v2-implementation-map>
- license: Apache-2.0

ASTIS takes organizational inspiration only. No Lean-Ridgelet code, template,
or style was copied.

## Visual assets checked

Opened at original resolution:

- `docs/assets/log_concave_sampling_foundation.png`
- `docs/assets/log_concave_sampling_status.png`
- `docs/assets/astis_lean_arsenal_module_graph.png`
- `website/static/astis-blueprint-og.png`
- all ten `website/diagrams/*.mmd` sources after foreground rendering to
  `runs/20260727-ASTIS-BLUEPRINT-SITE/visual-qa/*.png`

The foundation and status graphs have readable labels and correct blue/red
semantics. The full module graph is intentionally too dense for the primary
student view; the website therefore uses split chapter/shared-root/frontier
and theorem-local Mermaid graphs with horizontal overflow on small screens.
The first rendered chapter spine and frontier were too flat; both were changed
from left-to-right to top-to-bottom layout, re-rendered, and rechecked. The
final PNGs have readable labels, separated nodes, and correct red/blue status.

The generated OG asset contains no book quotation. It shows the three learning
layers and the blue/red proof status convention.

The in-app browser rejected direct `file://` navigation under its URL safety
policy. No workaround or detached local server was used. Layout safety was
checked through the generated structure, responsive CSS constraints, link and
asset validation, and direct PNG inspection.
