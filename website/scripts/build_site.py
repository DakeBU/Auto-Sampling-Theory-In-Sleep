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
import implicit_prerequisites  # noqa: E402
import information_architecture  # noqa: E402
import lean_tutor  # noqa: E402
import reader_contract_final  # noqa: E402
import samplewiki_examples  # noqa: E402
import samplewiki_frontier_audit  # noqa: E402
import samplewiki_math_render  # noqa: E402
import source_foundations  # noqa: E402
import theorem_lessons  # noqa: E402
import undergrad_guides  # noqa: E402
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
    # Primary-paper theorem/proof audits are stronger than row provenance.  Keep
    # them in a separate overlay so an unaudited row can never inherit a theorem
    # number or proof route merely from the crawler.
    samplewiki_frontier_audit.enrich_site(output)
    chapter1_reference_shelf.enrich_site(output)
    visual_polish.enrich_site(output)
    # Final public-reader contract.  It replaces the prose-heavy intermediate
    # theorem/tutorial surface without mutating audited source metadata.
    reader_contract_final.enrich_site(output)
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
