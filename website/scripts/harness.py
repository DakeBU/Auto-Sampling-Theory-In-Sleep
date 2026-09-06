#!/usr/bin/env python3
"""Reader-facing ASTIS Harness overlay for Samplinglib."""

from __future__ import annotations

import re
from pathlib import Path


HOME_SECTION = """<section id="powered-by-astis" class="astis-harness-card">
<h2>From proofs to verified mathematical structure</h2>
<p>ASTIS turns source-backed mathematics into Lean-checked reusable graph memory.</p>
<figure style="margin:1rem 0 0"><img src="assets/astis-formal-graph-value.svg" alt="From AI proof text to Lean-verified graph contributions" loading="lazy" style="display:block;width:100%;height:auto;border-radius:12px"></figure>
</section>"""

WORKFLOW_MAIN = """<main id="content"><article class="reader-article astis-harness-workflow">
<header><p class="eyebrow">ASTIS Harness</p><h1>Verified mathematical advances on a reusable Lean graph</h1>
<p>The diagrams below are the public overview; detailed execution contracts live in the repository documentation.</p></header>

<section id="harness-architecture"><h2>Harness architecture</h2>
<figure style="margin:1rem 0 2rem"><img src="../assets/astis-harness-evolution.svg" alt="Earlier role-ladder Harness and current Universal Worker, Frontier Cell, Thin Master Harness" loading="eager" style="display:block;width:100%;height:auto;border-radius:12px"></figure>
</section>

<section id="formal-graph-value"><h2>Why the formal graph matters</h2>
<figure style="margin:1rem 0 2rem"><img src="../assets/astis-formal-graph-value.svg" alt="Plain AI proof generation compared with Lean-verified graph memory and graph-level mathematical contributions" loading="lazy" style="display:block;width:100%;height:auto;border-radius:12px"></figure>
</section>
</article></main>"""

FRONTIER_AGENT_ROW = """<tr class="astis-harness-related"><td>FrontierAgent</td><td>Bounded task boards, parallel generalist sub-agents, structured report collection, checkpoint/resume, fanout guards, and coordinator no-progress detection informed the control plane design.</td><td>ASTIS schedules source-backed theorem-DAG advances; Lean evidence, truth boundaries, discovery provenance, independent verification, graph placement, and the single stabilization lane are authoritative.</td></tr>"""

LIVE_NOTE = """<section id="astis-substantive-advance-export" class="astis-harness-card"><h2>Substantive Advance export</h2><p>Reviewed candidates can be exported with an exact source anchor, theorem delta, truth boundary, frontier cell, DAG inputs, target declarations, owned files, and focused Lean checks. Export is a proposal only; independent verification and the single stabilization lane control admission to Samplinglib and the Underlying Lean Graph.</p></section>"""


def _read(path: Path) -> str:
    return path.read_text(encoding="utf-8")


def _write(path: Path, text: str) -> None:
    if _read(path) != text:
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


def enrich_site(output: Path) -> None:
    output = Path(output)
    home = output / "index.html"
    workflow = output / "workflow" / "index.html"
    related = output / "related-systems" / "index.html"
    live = output / "live" / "index.html"
    attribution = output / "attribution" / "index.html"
    missing = [
        str(path.relative_to(output))
        for path in (home, workflow, related, live, attribution)
        if not path.exists()
    ]
    if missing:
        raise RuntimeError("Harness overlay missing generated pages: " + ", ".join(missing))

    text = _read(home)
    pattern = r"<section\b[^>]*\bid=[\"']powered-by-astis[\"'][^>]*>.*?</section>"
    text, count = re.subn(pattern, HOME_SECTION, text, count=1, flags=re.I | re.S)
    if count == 0:
        text = text.replace("</main>", HOME_SECTION + "\n</main>", 1)
    _write(home, text)
    _write(workflow, _replace_main(_read(workflow), WORKFLOW_MAIN))

    text = _read(related)
    row_pattern = r"<tr\b[^>]*>\s*<td>FrontierAgent</td>.*?</tr>"
    text, count = re.subn(row_pattern, FRONTIER_AGENT_ROW, text, count=1, flags=re.I | re.S)
    if count == 0:
        if "</tbody>" in text:
            text = text.replace("</tbody>", FRONTIER_AGENT_ROW + "\n</tbody>", 1)
        elif "</table>" in text:
            text = text.replace("</table>", FRONTIER_AGENT_ROW + "\n</table>", 1)
        else:
            text = text.replace("</body>", FRONTIER_AGENT_ROW + "\n</body>", 1)
    _write(related, text)

    text = _read(live)
    for old in (
        "export into the ASTIS hierarchy",
        "export into the ASTIS Substantive Advance queue",
        "export into the ASTIS Substantive Advance frontier mesh",
    ):
        text = text.replace(old, "export into the ASTIS Substantive Advance workflow")
    text = text.replace("export to ASTIS typed packets", "export to ASTIS substantive-advance packets")
    if "Substantive Advance" not in text and "substantive-advance" not in text:
        text = text.replace("</body>", LIVE_NOTE + "\n</body>", 1)
    _write(live, text)

    text = _read(attribution).replace(
        "A Hierarchical Automated Theorem Proving System for Sampling Theory",
        "A Substantive-Advance Automated Theorem Proving System for Sampling Theory",
    )
    _write(attribution, text)


def validate_site(output: Path) -> None:
    output = Path(output)
    pages = {
        "home": _read(output / "index.html"),
        "workflow": _read(output / "workflow" / "index.html"),
        "related": _read(output / "related-systems" / "index.html"),
        "live": _read(output / "live" / "index.html"),
    }
    workflow = pages["workflow"]
    match = re.search(
        r"<main\b[^>]*\bid=[\"']content[\"'][^>]*>.*?</main>",
        workflow,
        flags=re.I | re.S,
    )
    if match is None:
        raise RuntimeError("workflow page is missing <main id=content>")
    workflow_main = match.group(0)
    for required in (
        "astis-harness-evolution.svg",
        "astis-formal-graph-value.svg",
        "Harness architecture",
        "Why the formal graph matters",
    ):
        if required not in workflow_main:
            raise RuntimeError(f"workflow page is missing visual Harness concept: {required}")
    if workflow_main.count("<img ") < 2:
        raise RuntimeError("workflow page must be diagram-first")
    if "<pre" in workflow_main:
        raise RuntimeError("workflow page must not fall back to text diagrams")
    if workflow_main.count("<p>") > 3:
        raise RuntimeError("workflow page has regressed into a prose-heavy Harness page")
    if "astis-formal-graph-value.svg" not in pages["home"]:
        raise RuntimeError("home page is missing the visual project-purpose summary")
    if "FrontierAgent" not in pages["related"]:
        raise RuntimeError("related-systems page is missing FrontierAgent")
    if "Substantive Advance" not in pages["live"] and "substantive-advance" not in pages["live"]:
        raise RuntimeError("live workspace is missing the Substantive Advance export boundary")


__all__ = ["enrich_site", "validate_site"]
