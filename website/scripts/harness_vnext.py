#!/usr/bin/env python3
"""Public Harness-vNext overlay for the Samplinglib website.

The generated site historically described ASTIS as a fixed Upper/Middle/Lower
role hierarchy.  Those typed artifacts remain valid backward-compatible memory,
but the active proving unit is now a *Substantive Advance Unit*: one bounded
mathematical DAG delta owned end to end by a generalist worker, with a thin
coordinator, a discovery ledger, and one stabilization lane.

This overlay changes only the public system-description pages.  Textbook,
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
  <h2>Substantive Advance Unit</h2>
  <p>ASTIS advances the formal graph in theorem-sized units rather than handing the same
  obligation through a fixed role ladder. A thin coordinator selects independent DAG deltas,
  suppresses duplicate work, and gives each generalist worker the exact source anchor, truth
  boundary, owned files, and focused acceptance checks.</p>
  <p>A worker may move between source audit, proof design, Mathlib retrieval, Lean implementation,
  and local review as needed. Reusable side discoveries are written to a separate discovery
  ledger. Shared imports, Registry evidence, graph metadata, and site promotion are serialized
  through one stabilization lane only after the local theorem delta is verified.</p>
</section>"""

WORKFLOW_MAIN = """<main id="content">
  <article class="reader-article astis-vnext-workflow">
    <header>
      <p class="eyebrow">ASTIS control plane</p>
      <h1>Substantive advances, not role handoffs</h1>
      <p>The durable proof graph is the authority. The coordinator schedules bounded mathematical
      deltas; workers own those deltas end to end; deterministic gates decide what enters
      Samplinglib.</p>
    </header>

    <section>
      <h2>1. Thin coordinator</h2>
      <p>The coordinator reads the live theorem DAG and a bounded state capsule. It chooses
      independent high-value advances, assigns ownership, rejects semantic duplicates, and keeps
      source anchors and truth boundaries explicit. It does not re-prove the worker's theorem.</p>
    </section>

    <section>
      <h2>2. Generalist substantive-advance workers</h2>
      <p>Each worker receives one theorem delta with its DAG parents and consumers. The same worker
      can inspect the paper, derive the mathematics, search Samplinglib/Mathlib, implement Lean,
      and run a focused check. Temporary specialties are modes, not permanent organizational
      layers.</p>
      <p>A successful local packet records the exact theorem delta, Lean files, focused checks, and
      remaining truth boundary. A blocked packet must strictly narrow the mathematical or API
      blocker instead of returning a vague handoff.</p>
    </section>

    <section>
      <h2>3. Discovery ledger</h2>
      <p>Useful facts discovered while solving one advance—lemmas, reusable interfaces,
      counterexamples, source gaps, refactors, or conjectures—survive the worker run in a separate
      append-only ledger. Validation and later scheduling are explicit states, so side insights do
      not vanish and do not silently become library truth.</p>
    </section>

    <section>
      <h2>4. Verification and the single stabilization lane</h2>
      <p><code>PROVED_LOCAL</code> is not a merge claim. Independent Lean/source gates first move a
      packet to <code>VERIFIED</code>. Exactly one integration owner may then occupy the
      <strong>single stabilization lane</strong>, where current-main clean-porting, shared imports,
      root tests, Registry entries, source correspondence, graph edges, and site evidence are
      updated together.</p>
    </section>

    <section>
      <h2>5. State machine</h2>
      <p><code>PROPOSED → CLAIMED → EXPLORING → PROVED_LOCAL → VERIFIED → STABILIZING → MERGED</code>.
      <code>BLOCKED</code> and <code>QUARANTINED</code> preserve exact failures without pretending
      closure. Legacy Upper/Middle/Lower typed artifacts remain readable as historical and
      compatibility memory, but they are no longer the active scheduling unit.</p>
    </section>
  </article>
</main>"""

FRONTIER_AGENT_ROW = """<tr class="astis-vnext-related">
  <td>FrontierAgent</td>
  <td>Coordinator/task-board separation, bounded parallel workers, resumable state, and explicit
  report collection informed the vNext control-plane audit.</td>
  <td>ASTIS schedules theorem-DAG advances rather than generic file tasks; source fidelity, truth
  boundaries, focused Lean evidence, discovery provenance, and the single stabilization lane are
  authoritative.</td>
</tr>"""


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
    text = text.replace("export into the ASTIS hierarchy", "export into the ASTIS Substantive Advance queue")
    text = text.replace("export to ASTIS typed packets", "export to ASTIS substantive-advance packets")
    _write_if_changed(path, text)


def _update_attribution(path: Path) -> None:
    text = _read(path)
    text = text.replace(
        "A Hierarchical Automated Theorem Proving System for Sampling Theory",
        "A Substantive-Advance Automated Theorem Proving System for Sampling Theory",
    )
    _write_if_changed(path, text)


def enrich_site(output: Path) -> None:
    """Install the vNext control-plane description onto final public pages."""

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
    """Fail closed if a generated site still advertises the legacy scheduler."""

    output = Path(output)
    home = _read(output / "index.html")
    workflow = _read(output / "workflow" / "index.html")
    related = _read(output / "related-systems" / "index.html")
    live = _read(output / "live" / "index.html")
    if "Substantive Advance Unit" not in home:
        raise RuntimeError("home page does not expose the Substantive Advance Unit")
    if "single stabilization lane" not in workflow:
        raise RuntimeError("workflow page does not expose the single stabilization lane")
    stale = [token for token in LEGACY_ROLE_TOKENS if token in workflow]
    if stale:
        raise RuntimeError("workflow page still exposes legacy role scheduler tokens: " + ", ".join(stale))
    if "FrontierAgent" not in related:
        raise RuntimeError("related-systems page is missing the FrontierAgent architecture boundary")
    if "Substantive Advance" not in live and "substantive-advance" not in live:
        raise RuntimeError("live workspace still describes only the legacy ASTIS hierarchy")


__all__ = ["enrich_site", "validate_site"]
