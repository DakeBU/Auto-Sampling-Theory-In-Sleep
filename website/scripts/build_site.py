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
import implicit_prerequisites  # noqa: E402
import lean_tutor  # noqa: E402
import source_foundations  # noqa: E402
import undergrad_guides  # noqa: E402


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
    source_foundations.enrich_site(output)
    implicit_prerequisites.enrich_site(output)
    lean_tutor.enrich_site(output)
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
