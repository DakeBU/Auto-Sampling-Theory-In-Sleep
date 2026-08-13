#!/usr/bin/env python3
"""Validate ASTIS pages, inventory, status, source links, diagrams, and assets."""

from __future__ import annotations

import argparse
import sys
from pathlib import Path


ROOT = Path(__file__).resolve().parents[2]
sys.path.insert(0, str(ROOT / "tools"))

import astis_site  # noqa: E402
import astis_source  # noqa: E402


def main() -> int:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--output", default="", help="output directory (default: _site)")
    parser.add_argument("--rebuild", action="store_true")
    parser.add_argument("--require-chapter-1-closure", action="store_true")
    args = parser.parse_args()
    source_errors, _ = astis_source.validate_source_contract()
    if source_errors:
        print("Chewi source check failed:", file=sys.stderr)
        for error in source_errors:
            print(f"- {error}", file=sys.stderr)
        return 1
    argv = ["check"]
    if args.output:
        argv.extend(["--output", args.output])
    if args.rebuild:
        argv.append("--rebuild")
    if args.require_chapter_1_closure:
        argv.append("--require-chapter-1-closure")
    return astis_site.main(argv)


if __name__ == "__main__":
    raise SystemExit(main())
