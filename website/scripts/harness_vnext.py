#!/usr/bin/env python3
"""Public Harness-vNext.1 overlay for the Samplinglib website.

The generated site historically described ASTIS as a fixed Upper/Middle/Lower
role hierarchy. Those typed artifacts remain valid backward-compatible memory,
but the active proving unit is now a Substantive Advance Unit owned end to end
by a Universal Worker. Nearby advances form dynamic frontier cells; local
synthesis is ephemeral; and a thin global arbiter reads bounded cell summaries.

This overlay changes only public system-description pages. Textbook,
SampleWiki, theorem evidence, and Lean declaration pages are untouched.
"""

from __future__ import annotations

import re
from pathlib import Path


LEGACY_ROLE_TOKENS = (
    "upper_source_math",
    "upper_proof_dag",
    "upper_process_memory",
    "middle_formalizer",
    "middle_source_correspondence",
    "lower_1",
    "lower_2",
    "lower_3",
)

HOME_SECTION = """<section id="powered-by-astis" class="astis-vnext-card">
  <h2>Substantive Advance Frontier Mesh</h2>
  <p>ASTIS advances the formal graph in theorem-sized units rather than handing the same
  obligation through a fixed role ladder. A deterministic control plane records the exact source
  anchor, theorem delta, truth boundary, frontier cell, owned files, and focused checks; one
  Universal Worker owns that mathematical delta end to end.</p>
  <p>Nearby advances can be synthesized locally by any Worker in a temporary mode. A thin global
  arbiter consumes validated cell syntheses instead of replaying raw transcripts. Independent
  verification, route no-progress guards, and one stabilization lane protect public library
  truth.</p>
</section>"""

WORKFLOW_MAIN = """<main id="content">
  <article class="reader-article astis-vnext-workflow">
    <header>
      <p class="eyebrow">ASTIS control plane · Harness vNext.1</p>
      <h1>Substantive advances on a frontier mesh</h1>
      <p>The durable proof graph is the authority. Universal Workers own source-backed theorem
      deltas end to end; local frontier synthesis removes the overloaded-Master bottleneck; and
      deterministic gates decide what enters Samplinglib.</p>
    </header>

    <section>
      <h2>1. Deterministic board</h2>
      <p>Code owns lifecycle state, Worker ownership, semantic duplicate suppression, bounded
      checkpoints, frontier-cell grouping, omission counts, and the single stabilization lock.
      The board does not invent proof strategy or paraphrase exact source assumptions.</p>
    </section>

    <section>
      <h2>2. Universal substantive-advance Workers</h2>
      <p>Each Worker receives one theorem delta with its source anchor, DAG parents and consumers,
      target declarations, truth boundary, owned files, and focused checks. The same Worker can
      inspect the paper, derive the mathematics, search Samplinglib/Mathlib, implement Lean,
      diagnose the compiler, refactor, and explain the result. Specialties are temporary modes,
      not permanent organizational layers.</p>
      <p>A successful local packet records a theorem edge, reusable interface, or integration node.
      A blocked packet must retire a route or strictly narrow the mathematical/API boundary; a
      vague handoff is rejected.</p>
    </section>

    <section>
      <h2>3. Frontier cells and ephemeral synthesis</h2>
      <p>Advances sharing source statements, DAG parents, interfaces, or a later join form a dynamic
      frontier cell. Any Universal Worker may temporarily synthesize that cell: graph delta,
      conflicts, retired routes, reusable discoveries, and next independent advances. Another
      Worker validates the synthesis.</p>
      <p>The thin global arbiter reads validated cell syntheses first and opens raw evidence only
      for a named cross-cell conflict, join, priority decision, or stabilization admission. Local
      synthesis is not a fixed middle-manager role and does not constrain mathematical insight.</p>
    </section>

    <section>
      <h2>4. Discovery ledger and NoProgressGuard</h2>
      <p>Lemmas, interfaces, counterexamples, source gaps, refactors, conjectures, process lessons,
      and cell syntheses live in a deduplicated append-only ledger with explicit validation states.
      They survive Worker termination without silently becoming formal truth.</p>
      <p>Each bounded checkpoint records a route fingerprint and progress signature. After the first
      occurrence and two unchanged repeats, the route is frozen for diagnosis; another identical
      attempt is rejected until the route changes or a strict blocker is published.</p>
    </section>

    <section>
      <h2>5. Independent verification and the single stabilization lane</h2>
      <p><code>PROVED_LOCAL</code> is not a merge claim. A different verifier records the checked
      commit, Lean/source gate, source audit, and fake-closure scan before a packet becomes
      <code>VERIFIED</code>. Exactly one integration owner may then occupy the
      <strong>single stabilization lane</strong>, where current-main clean-porting, shared imports,
      root tests, Registry entries, source correspondence, graph edges, and site evidence are
      updated together.</p>
    </section>

    <section>
      <h2>6. State machine</h2>
      <p><code>PROPOSED → CLAIMED → EXPLORING → PROVED_LOCAL → VERIFIED → STABILIZING → MERGED</code>.
      <code>BLOCKED</code> and <code>QUARANTINED</code> preserve exact failures without pretending
      closure. Legacy Upper/Middle/Lower typed artifacts remain readable historical memory, but
      they are no longer the active scheduling unit or a permission system.</p>
    </section>
  </article>
</main>"""

FRONTIER_AGENT_ROW = """<tr class="astis-vnext-related">
  <td>FrontierAgent</td>
  <td>Bounded task boards, parallel generalist sub-agents, structured report collection,
  checkpoint/resume, fanout guards, and coordinator no-progress detection informed the vNext.1
  control-plane audit.</td>
  <td>ASTIS schedules source-backed theorem-DAG advances; local synthesis is ephemeral, while
  Lean evidence, truth boundaries, discovery provenance, independent verification, and the single
  stabilization lane are authoritative.</td>
</tr>"""

LIVE_NOTE = """<section id="astis-substantive-advance-export" class="astis-vnext-card">
  <h2>Substantive Advance export</h2>
  <p>Reviewed candidates from this workspace can be exported as a Substantive Advance packet:
  exact source anchor, theorem delta, truth boundary, frontier cell, DAG inputs, target
  declarations, owned files, and focused Lean checks. Export is a proposal only; independent
  verification and the single stabilization lane still control admission to Samplinglib.</p>
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
        raise RuntimeError("Harness vNext overlay expected exactly one <main id=\"content\">")
    return updated


def _update_home(path: Path) -> None:
    text = _read(path)
    pattern = r"<section\b[^>]*\bid=[\"']powered-by-astis[\"'][^>]*>.*?</section>"
    updated, count = re.subn(pattern, HOME_SECTION, text, count=1, flags=re.I | re.S)
    if count == 0:
        marker = "</main>"
        if marker not in text:
            raise RuntimeError("home page has no main closing tag for Harness vNext section")
        updated = text.replace(marker, HOME_SECTION + "\n" + marker, 1)
    _write_if_changed(path, updated)


def _update_workflow(path: Path) -> None:
    _write_if_changed(path, _replace_main(_read(path), WORKFLOW_MAIN))


def _update_related_systems(path: Path) -> None:
    text = _read(path)
    if "FrontierAgent" in text:
        # Replace an older vNext row if one exists; otherwise leave the richer
        # generated table untouched.
        pattern = r"<tr\b[^>]*class=[\"']astis-vnext-related[\"'][^>]*>.*?</tr>"
        updated, count = re.subn(pattern, FRONTIER_AGENT_ROW, text, count=1, flags=re.I | re.S)
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
    text = text.replace(
        "export unresolved work into the ASTIS hierarchy",
        "export unresolved work into the ASTIS Substantive Advance frontier mesh",
    )
    text = text.replace(
        "export into the ASTIS hierarchy",
        "export into the ASTIS Substantive Advance frontier mesh",
    )
    text = text.replace(
        "export into the ASTIS Substantive Advance queue",
        "export into the ASTIS Substantive Advance frontier mesh",
    )
    text = text.replace(
        "export to ASTIS typed packets",
        "export to ASTIS substantive-advance packets",
    )
    if 'id="astis-substantive-advance-export"' not in text:
        if "</body>" not in text:
            raise RuntimeError("live workspace has no body closing tag for Harness vNext note")
        text = text.replace("</body>", LIVE_NOTE + "\n</body>", 1)
    _write_if_changed(path, text)


def _update_attribution(path: Path) -> None:
    text = _read(path)
    text = text.replace(
        "A Hierarchical Automated Theorem Proving System for Sampling Theory",
        "A Substantive-Advance Automated Theorem Proving System for Sampling Theory",
    )
    # The generated BibTeX title can wrap after ``Automated``.  Replace the
    # stable prefix as well so line wrapping cannot preserve the legacy title.
    text = text.replace(
        "A Hierarchical Automated",
        "A Substantive-Advance Automated",
    )
    _write_if_changed(path, text)


def enrich_site(output: Path) -> None:
    """Install the vNext.1 control-plane description onto final public pages."""

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
        raise RuntimeError("Harness vNext overlay missing generated pages: " + ", ".join(missing))
    _update_home(targets["home"])
    _update_workflow(targets["workflow"])
    _update_related_systems(targets["related"])
    _update_live(targets["live"])
    _update_attribution(targets["attribution"])


def validate_site(output: Path) -> None:
    """Fail closed if the generated site exposes the legacy scheduler."""

    output = Path(output)
    home = _read(output / "index.html")
    workflow = _read(output / "workflow" / "index.html")
    related = _read(output / "related-systems" / "index.html")
    live = _read(output / "live" / "index.html")
    attribution = _read(output / "attribution" / "index.html")
    if "Substantive Advance Frontier Mesh" not in home:
        raise RuntimeError("home page does not expose the Substantive Advance Frontier Mesh")
    for required in ("Universal", "frontier cell", "NoProgressGuard", "single stabilization lane"):
        if required not in workflow:
            raise RuntimeError(f"workflow page is missing Harness vNext.1 concept: {required}")
    stale = [token for token in LEGACY_ROLE_TOKENS if token in workflow]
    if stale:
        raise RuntimeError(
            "workflow page still exposes legacy role scheduler tokens: " + ", ".join(stale)
        )
    if "FrontierAgent" not in related:
        raise RuntimeError("related-systems page is missing the FrontierAgent architecture boundary")
    if "Substantive Advance" not in live and "substantive-advance" not in live:
        raise RuntimeError("live workspace still describes only the legacy ASTIS hierarchy")
    if "ASTIS hierarchy" in live:
        raise RuntimeError("live workspace still exposes the legacy ASTIS hierarchy wording")
    if 'id="astis-substantive-advance-export"' not in live:
        raise RuntimeError("live workspace is missing the substantive-advance export contract")
    if "A Hierarchical Automated" in attribution:
        raise RuntimeError("attribution page still exposes the legacy hierarchical title")
    if "A Substantive-Advance Automated" not in attribution:
        raise RuntimeError("attribution page is missing the vNext.1 system title")


__all__ = ["enrich_site", "validate_site"]
