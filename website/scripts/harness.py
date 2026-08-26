#!/usr/bin/env python3
"""Reader-facing ASTIS Harness overlay for the Samplinglib website.

The Harness page shows both the earlier role-ladder architecture and the current
substantive-advance architecture. Historical structure is useful context: source
fidelity, explicit handoffs, and independent review were valuable design ideas.
The current Harness keeps those guarantees while making the unit of delegation a
mathematical advance rather than a narrow role-local action.

This overlay changes only public system-description pages. Textbook, SampleWiki,
theorem evidence, and Lean declaration pages are untouched.
"""

from __future__ import annotations

import re
from pathlib import Path


HOME_SECTION = """<section id="powered-by-astis" class="astis-harness-card">
  <h2>From proofs to verified mathematical structure</h2>
  <p>ASTIS does more than ask AI to write proof prose. A source-backed mathematical step becomes
  a named Lean declaration only after focused checking and independent source/Lean verification;
  the verified result then becomes reusable formal memory for later proofs.</p>
  <p>Samplinglib is one output. The broader goal is to make sampling theory itself easier to see:
  which lemmas form the backbone, which hidden assumptions carry arguments, which proof mechanisms
  are reused, and whether a new result adds a leaf, a bridge, a shortcut, a reusable interface, or
  a deeper reorganization of the existing formal graph.</p>
</section>"""

WORKFLOW_MAIN = """<main id="content">
  <article class="reader-article astis-harness-workflow">
    <header>
      <p class="eyebrow">ASTIS Harness</p>
      <h1>Source-backed mathematical advances with Lean-verified memory</h1>
      <p>The Harness coordinates AI exploration around a durable Lean theorem graph. Workers may
      reason broadly, but public mathematical truth is admitted only through explicit source,
      declaration, verification, and stabilization evidence.</p>
    </header>

    <section id="current-harness">
      <h2>Current ASTIS Harness</h2>
      <p>The unit of work is a <strong>Substantive Advance Unit</strong>: one theorem edge, reusable
      interface, integration node, or strict obstruction. A Universal Worker owns that mathematical
      delta end to end. Nearby advances form dynamic Frontier Cells; deterministic reducers compact
      their structured reports; the Thin Master handles only genuinely global decisions.</p>
      <pre class="harness-diagram" aria-label="Current ASTIS Harness architecture">Source / paper / SampleWiki + verified Lean graph
                         ↓
              Substantive Advance Board
                         ↓
        ┌─────────────────────────────────┐
        │          Frontier Cells         │
        │ Universal Workers in parallel   │
        │       ↕ Discovery Ledger        │
        │   deterministic cell reducer    │
        └─────────────────────────────────┘
                         ↓
                 Frontier capsules
                         ↓
                    Thin Master
                         ↓
             Independent verification
                         ↓
              Single stabilization lane
                         ↓
        Samplinglib + Underlying Lean Graph</pre>
      <p>The Master does not routinely reread every Worker transcript or reproduce local proofs.
      It allocates budget across frontiers, resolves cross-frontier conflicts, controls frozen-route
      resets, selects the stabilization owner, and updates the global graph after verified merges.</p>
    </section>

    <section id="earlier-harness">
      <h2>Earlier role-ladder architecture</h2>
      <p>The earlier Harness made source fidelity and review explicit by passing a theorem through
      specialized layers. That discipline was useful, and its typed artifacts remain historical
      memory. The problem was the delegation granularity: the same theorem context could be loaded
      repeatedly while each layer was allowed to complete only a small part of the mathematics.</p>
      <pre class="harness-diagram" aria-label="Earlier ASTIS role-ladder architecture">Source / paper
      ↓
Upper
source audit · mathematical strategy · proof-DAG planning
      ↓
Middle
source ↔ Lean correspondence · retrieval · theorem mapping
      ↓
Lower workers
proof scout · Lean implementation · technical/API scout
      ↓
Reviewer
Lean gate · source audit · fake-closure rejection
      ↺
typed feedback and replanning</pre>
      <p>The current Harness keeps exact source contracts, typed evidence, durable failure memory,
      independent verification, and deterministic gates. What it removes is the rule that a capable
      agent must stop merely because an Upper, Middle, or Lower responsibility has ended.</p>
    </section>

    <section id="substantive-progress">
      <h2>What counts as mathematical progress?</h2>
      <p>A Worker invocation counts only when it changes what the proof system knows: it closes a
      theorem edge, closes a reusable interface, joins verified parents into a higher node, strictly
      narrows an exact blocker, or retires a false route with evidence. A renamed task, a prose-only
      report, an unchanged Lean error, or another handoff is activity—not mathematical progress.</p>
    </section>

    <section id="ai-proof-comparison">
      <h2>Why not simply ask AI to write proofs?</h2>
      <p>AI-written proof prose can suggest valuable mathematics, but prose alone is not a checked
      theorem. Hidden assumptions, type mismatches, invalid boundary steps, or a subtly different
      statement can survive a fluent explanation. Nor does a prose proof automatically become a
      callable, verified interface that another proof can safely reuse.</p>
      <p>ASTIS adds three layers: <strong>Lean verification</strong> of exact declarations,
      <strong>reusable formal memory</strong> that later Workers can retrieve and build on, and
      <strong>graph placement</strong> that records the true parents and consumers of a result.
      This turns “AI found a proof” into “the field gained a checked node or connection whose role
      can be inspected and reused.”</p>
    </section>

    <section id="understanding-mathematics">
      <h2>Using the formal graph to understand the field</h2>
      <p>Samplinglib is the verified library; ASTIS is also an instrument for understanding the
      mathematics behind it. The Underlying Lean Graph lets readers inspect which results are
      structural backbones, which regularity assumptions are doing hidden work, and which proof
      ideas recur across apparently different sampling arguments.</p>
      <p>For a new theorem, the graph gives a sharper contribution question than “is it new?”:
      does it merely add a terminal leaf, create a bridge between previously separate branches,
      shorten an important route, introduce a reusable interface, or reorganize a substantial
      part of the dependency structure? This view is meant to help beginners find the conceptual
      spine and help experts distinguish marginal extensions from genuinely new mechanisms. As
      the graph matures, compression can also suggest cleaner natural-language proofs and more
      algebraic structural formulations.</p>
    </section>

    <section id="verification">
      <h2>Verification and shared library truth</h2>
      <p><code>PROVED_LOCAL</code> is not a publication claim. A different verifier checks the
      declaration, exact source boundary, focused Lean evidence, and fake-closure conditions before
      the result becomes <code>VERIFIED</code>. Exactly one integration owner then occupies the
      <strong>single stabilization lane</strong>, where current-main compatibility, imports, root
      tests, Registry entries, source correspondence, graph edges, and site evidence are updated
      together.</p>
      <p><code>PROPOSED → CLAIMED → EXPLORING → PROVED_LOCAL → VERIFIED → STABILIZING → MERGED</code>.
      <code>BLOCKED</code> and <code>QUARANTINED</code> preserve exact failures without pretending
      mathematical closure.</p>
    </section>
  </article>
</main>"""

FRONTIER_AGENT_ROW = """<tr class="astis-harness-related">
  <td>FrontierAgent</td>
  <td>Bounded task boards, parallel generalist sub-agents, structured report collection,
  checkpoint/resume, fanout guards, and coordinator no-progress detection informed the control
  plane design.</td>
  <td>ASTIS schedules source-backed theorem-DAG advances; Lean evidence, truth boundaries,
  discovery provenance, independent verification, graph placement, and the single stabilization
  lane are authoritative.</td>
</tr>"""

LIVE_NOTE = """<section id="astis-substantive-advance-export" class="astis-harness-card">
  <h2>Substantive Advance export</h2>
  <p>Reviewed candidates from this workspace can be exported with an exact source anchor, theorem
  delta, truth boundary, frontier cell, DAG inputs, target declarations, owned files, and focused
  Lean checks. Export is a proposal only; independent verification and the single stabilization
  lane still control admission to Samplinglib and the Underlying Lean Graph.</p>
</section>"""


def _read(path: Path) -> str:
    return path.read_text(encoding="utf-8")


def _write_if_changed(path: Path, text: str) -> None:
    old = _read(path)
    if text != old:
        path.write_text(text, encoding="utf-8", newline="\n")


def _replace_main(text: str, replacement: str) -> str:
    updated, count = re.subn(
        r"<main\b[^>]*\bid=[\"']content[\"'][^>]*>.*?</main>",
        replacement,
        text,
        count=1,
        flags=re.I | re.S,
    )
    if count != 1:
        raise RuntimeError('Harness overlay expected exactly one <main id="content">')
    return updated


def _update_home(path: Path) -> None:
    text = _read(path)
    pattern = r"<section\b[^>]*\bid=[\"']powered-by-astis[\"'][^>]*>.*?</section>"
    updated, count = re.subn(pattern, HOME_SECTION, text, count=1, flags=re.I | re.S)
    if count == 0:
        marker = "</main>"
        if marker not in text:
            raise RuntimeError("home page has no main closing tag for the Harness section")
        updated = text.replace(marker, HOME_SECTION + "\n" + marker, 1)
    _write_if_changed(path, updated)


def _update_workflow(path: Path) -> None:
    _write_if_changed(path, _replace_main(_read(path), WORKFLOW_MAIN))


def _update_related_systems(path: Path) -> None:
    text = _read(path)
    row_pattern = r"<tr\b[^>]*>\s*<td>FrontierAgent</td>.*?</tr>"
    updated, count = re.subn(row_pattern, FRONTIER_AGENT_ROW, text, count=1, flags=re.I | re.S)
    if count:
        _write_if_changed(path, updated)
        return
    if "</tbody>" in text:
        updated = text.replace("</tbody>", FRONTIER_AGENT_ROW + "\n</tbody>", 1)
    elif "</table>" in text:
        updated = text.replace("</table>", FRONTIER_AGENT_ROW + "\n</table>", 1)
    else:
        updated = text.replace("</body>", FRONTIER_AGENT_ROW + "\n</body>", 1)
    _write_if_changed(path, updated)


def _update_live(path: Path) -> None:
    text = _read(path)
    replacements = {
        "export into the ASTIS hierarchy": "export into the ASTIS Substantive Advance workflow",
        "export into the ASTIS Substantive Advance queue": "export into the ASTIS Substantive Advance workflow",
        "export into the ASTIS Substantive Advance frontier mesh": "export into the ASTIS Substantive Advance workflow",
        "export to ASTIS typed packets": "export to ASTIS substantive-advance packets",
    }
    for old, new in replacements.items():
        text = text.replace(old, new)
    if "Substantive Advance" not in text and "substantive-advance" not in text:
        if "</body>" not in text:
            raise RuntimeError("live workspace has no body closing tag for the Harness note")
        text = text.replace("</body>", LIVE_NOTE + "\n</body>", 1)
    _write_if_changed(path, text)


def _update_attribution(path: Path) -> None:
    text = _read(path)
    text = text.replace(
        "A Hierarchical Automated Theorem Proving System for Sampling Theory",
        "A Substantive-Advance Automated Theorem Proving System for Sampling Theory",
    )
    _write_if_changed(path, text)


def enrich_site(output: Path) -> None:
    """Install the reader-facing Harness description onto final public pages."""

    output = Path(output)
    targets = {
        "home": output / "index.html",
        "workflow": output / "workflow" / "index.html",
        "related": output / "related-systems" / "index.html",
        "live": output / "live" / "index.html",
        "attribution": output / "attribution" / "index.html",
    }
    missing = [name for name, path in targets.items() if not path.exists()]
    if missing:
        raise RuntimeError("Harness overlay missing generated pages: " + ", ".join(missing))
    _update_home(targets["home"])
    _update_workflow(targets["workflow"])
    _update_related_systems(targets["related"])
    _update_live(targets["live"])
    _update_attribution(targets["attribution"])


def validate_site(output: Path) -> None:
    """Fail closed if the generated public Harness surface is incomplete."""

    output = Path(output)
    pages = {
        "home": _read(output / "index.html"),
        "workflow": _read(output / "workflow" / "index.html"),
        "related": _read(output / "related-systems" / "index.html"),
        "live": _read(output / "live" / "index.html"),
        "attribution": _read(output / "attribution" / "index.html"),
    }
    workflow = pages["workflow"]
    for required in (
        "Current ASTIS Harness",
        "Earlier role-ladder architecture",
        "Universal Worker",
        "Frontier Cells",
        "Thin Master",
        "Why not simply ask AI to write proofs?",
        "Using the formal graph to understand the field",
        "single stabilization lane",
    ):
        if required not in workflow:
            raise RuntimeError(f"workflow page is missing Harness concept: {required}")
    for earlier_component in ("Upper", "Middle", "Lower workers", "Reviewer"):
        if earlier_component not in workflow:
            raise RuntimeError(f"workflow page is missing earlier Harness component: {earlier_component}")
    if "From proofs to verified mathematical structure" not in pages["home"]:
        raise RuntimeError("home page is missing the project-purpose Harness summary")
    if "FrontierAgent" not in pages["related"]:
        raise RuntimeError("related-systems page is missing the FrontierAgent architecture boundary")
    if "Substantive Advance" not in pages["live"] and "substantive-advance" not in pages["live"]:
        raise RuntimeError("live workspace is missing the Substantive Advance export boundary")
    for name, text in pages.items():
        if "vnext" in text.lower():
            raise RuntimeError(f"{name} page still exposes release-version Harness branding")


__all__ = ["enrich_site", "validate_site"]
