#!/usr/bin/env python3
"""Validate ASTIS pages, inventory, status, source links, diagrams, and assets."""

from __future__ import annotations

import argparse
import sys
from pathlib import Path


ROOT = Path(__file__).resolve().parents[2]
sys.path.insert(0, str(ROOT / "tools"))
sys.path.insert(0, str(ROOT / "website" / "scripts"))

import astis_site  # noqa: E402
import astis_source  # noqa: E402
import implicit_prerequisites  # noqa: E402
import lean_tutor  # noqa: E402
import source_foundations  # noqa: E402
import undergrad_guides  # noqa: E402


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
    output = Path(args.output).resolve() if args.output else ROOT / "_site"
    if args.output:
        argv.extend(["--output", args.output])
    if args.rebuild:
        argv.append("--rebuild")
    if args.require_chapter_1_closure:
        argv.append("--require-chapter-1-closure")
    result = astis_site.main(argv)
    if result != 0:
        return result
    guide_errors = undergrad_guides.validate_site(output)
    if guide_errors:
        print("Undergraduate guide site check failed:", file=sys.stderr)
        for error in guide_errors:
            print(f"- {error}", file=sys.stderr)
        return 1
    foundation_errors = source_foundations.validate_site(output)
    if foundation_errors:
        print("Source foundation site check failed:", file=sys.stderr)
        for error in foundation_errors:
            print(f"- {error}", file=sys.stderr)
        return 1
    implicit_errors = implicit_prerequisites.validate_site(output)
    if implicit_errors:
        print("Implicit prerequisite site check failed:", file=sys.stderr)
        for error in implicit_errors:
            print(f"- {error}", file=sys.stderr)
        return 1
    tutor_errors = lean_tutor.validate_site(output)
    if tutor_errors:
        print("Lean learning studio site check failed:", file=sys.stderr)
        for error in tutor_errors:
            print(f"- {error}", file=sys.stderr)
        return 1
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
