#!/usr/bin/env python3
"""Build the ASTIS literate formalization website."""

from __future__ import annotations

import argparse
import sys
from pathlib import Path


ROOT = Path(__file__).resolve().parents[2]
sys.path.insert(0, str(ROOT / "tools"))
sys.path.insert(0, str(ROOT / "website" / "scripts"))

import astis_site  # noqa: E402
import chapter1_reference_shelf  # noqa: E402
import chewi_source_audit_guard  # noqa: E402
import chewi_source_first_contract  # noqa: E402
import chewi_source_first_refinement  # noqa: E402
import implicit_prerequisites  # noqa: E402
import information_architecture  # noqa: E402
import lean_tutor  # noqa: E402
import reader_contract_final  # noqa: E402
import samplewiki_audit_queue  # noqa: E402
import samplewiki_casebook_assets  # noqa: E402
import samplewiki_casebook_polish  # noqa: E402
import samplewiki_examples  # noqa: E402
import samplewiki_frontier_audit  # noqa: E402
import samplewiki_math_render  # noqa: E402
import samplewiki_primary_audit_additions  # noqa: E402
import samplewiki_reader_contract  # noqa: E402
import source_foundations  # noqa: E402
import textbook_math_contract  # noqa: E402
import theorem_lessons  # noqa: E402
import undergrad_guides  # noqa: E402
import underlying_lean_graph  # noqa: E402
import visual_polish  # noqa: E402


def main() -> int:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--output", default="", help="output directory (default: _site)")
    args = parser.parse_args()
    argv = ["build"]
    output = Path(args.output).resolve() if args.output else ROOT / "_site"
    if args.output:
        argv.extend(["--output", args.output])
    result = astis_site.main(argv)
    if result != 0:
        return result
    undergrad_guides.enrich_site(output)
    theorem_lessons.enrich_site(output)
    source_foundations.enrich_site(output)
    implicit_prerequisites.enrich_site(output)
    lean_tutor.enrich_site(output)
    samplewiki_examples.enrich_site(output)
    information_architecture.enrich_site(output)
    # SampleWiki row TeX and its source-specific reading directory are finalized
    # after the global IA pass so the directory is not overwritten by sidebar
    # replacement.
    samplewiki_math_render.enrich_site(output)
    # Primary-paper theorem/proof audits are stronger than row provenance. Keep
    # them in a separate overlay so an unaudited row can never inherit a theorem
    # number or proof route merely from the crawler.
    samplewiki_frontier_audit.enrich_site(output)
    # The progress page exposes all literature-audit states at once; this is
    # deliberately separate from the Lean lifecycle/status table.
    samplewiki_audit_queue.enrich_site(output)
    chapter1_reference_shelf.enrich_site(output)
    visual_polish.enrich_site(output)

    # Patch the final reader before it runs so proof supplements are attached to
    # audited latex-statement cards as well as formula-supplement cards. This is
    # what makes the canonical page a self-contained mathematical textbook when
    # Lean and infrastructure disclosures are collapsed.
    textbook_math_contract.patch_reader_contract(reader_contract_final)
    reader_contract_final.enrich_site(output)
    textbook_math_contract.enrich_site(output, reader_contract_final)

    # Later-chapter source-correspondence metadata is allowed to precede exact
    # theorem transcription, but an unaudited row is not allowed to appear as a
    # theorem card. Remove visible formula-less rows before the strict
    # source-first renderer runs; the metadata stays available to the graph and
    # audit pipeline.
    chewi_source_audit_guard.enrich_site(output)

    # The permanent public order is:
    # Chewi statement -> Chewi proof/status -> source/implicit assumptions ->
    # folded ASTIS LaTeX -> folded Lean. Before rendering, refine assumption
    # prose so small mathematical clauses use MathJax and internal audit prose
    # is not copied into the textbook.
    chewi_source_first_refinement.patch(chewi_source_first_contract)
    chewi_source_first_contract.enrich_site(output)

    # SampleWiki uses the same truth boundary as the textbook, but the public
    # presentation is deliberately paper-first. Pending theorem audits still get
    # a useful reader derivation map; Lean stays folded and quiet until a
    # source-facing declaration actually exists. Incremental primary-source
    # audits can therefore improve the public mathematics independently of Lean.
    samplewiki_casebook_polish.patch(samplewiki_reader_contract)
    samplewiki_primary_audit_additions.patch(samplewiki_reader_contract)
    samplewiki_reader_contract.enrich_site(output)
    samplewiki_casebook_assets.enrich_site(output)

    # The graph is the final site overlay: it consumes the finished reader pages,
    # exact source-audit cards, generated Lean inventory, and all final sidebars.
    underlying_lean_graph.enrich_site(output)
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
