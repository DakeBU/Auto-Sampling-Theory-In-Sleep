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
import chewi_source_first_contract  # noqa: E402
import chewi_source_first_refinement  # noqa: E402
import chewi_source_first_scope  # noqa: E402
import implicit_prerequisites  # noqa: E402
import lean_tutor  # noqa: E402
import reader_contract_final  # noqa: E402
import source_foundations  # noqa: E402


def source_first_proof_coverage_errors(output: Path) -> list[str]:
    """Validate proof supplements against the final theorem-first DOM.

    ``reader_contract_final`` originally emitted ``data-source-proof`` details.
    The later ``chewi_source_first_contract`` deliberately reconstructs every
    source card into the permanent statement/proof/assumptions/ASTIS/Lean order,
    so those intermediate DOM markers no longer survive. The proof equations do
    survive and are the stronger invariant to check here.
    """

    errors: list[str] = []
    sources = reader_contract_final._source_entries()
    proofs = reader_contract_final._proof_supplements()
    for source_id, proof in proofs.items():
        source = sources.get(source_id)
        if source is None:
            continue
        section = str(source.get("section", ""))
        path = reader_contract_final.base.section_path(output, section)
        if not path.exists():
            continue
        text = path.read_text(encoding="utf-8")
        card = reader_contract_final._source_card_for_id(text, source_id)
        if card is None:
            errors.append(f"{path.relative_to(output)}: missing final source card for proof {source_id}")
            continue

        expected = [
            str(step.get("formula", "")).strip()
            for step in proof.get("steps", [])
            if isinstance(step, dict) and str(step.get("formula", "")).strip()
        ]
        for formula in expected:
            escaped = reader_contract_final.base.esc(formula)
            if escaped not in card:
                errors.append(
                    f"{path.relative_to(output)}: final source card {source_id} is missing proof equation {formula}"
                )

        source_status = str(proof.get("source_status", ""))
        if expected and source_status == "source_proof" and "source-contract-chewi-proof" not in card:
            errors.append(
                f"{path.relative_to(output)}: {source_id} source proof is not in the Chewi proof layer"
            )
        if expected and source_status == "astis_expansion" and "source-contract-astis-latex" not in card:
            errors.append(
                f"{path.relative_to(output)}: {source_id} ASTIS proof expansion is not in the folded ASTIS layer"
            )
    return errors


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

    # The source-first renderer is the final owner of theorem/proof DOM. Keep
    # the older reader validator for its broad page/formula/style checks, but
    # make its proof coverage inspect the final equations instead of obsolete
    # intermediate data-source-proof markers.
    reader_contract_final._proof_coverage_errors = source_first_proof_coverage_errors
    try:
        reader_contract_final.validate(output)
    except Exception as exc:
        print("Final math-first reader site check failed:", file=sys.stderr)
        print(f"- {exc}", file=sys.stderr)
        return 1

    # Re-run the actual final Chewi contract with the same refinements/scope as
    # build_site.py. This checks the permanent reader order and the block-aware
    # raw-math gate on the final deploy tree.
    try:
        chewi_source_first_refinement.patch(chewi_source_first_contract)
        chewi_source_first_scope.patch(chewi_source_first_contract)
        chewi_source_first_contract.validate(output)
    except Exception as exc:
        print("Final Chewi source-first site check failed:", file=sys.stderr)
        print(f"- {exc}", file=sys.stderr)
        return 1

    # These remain independent evidence checks. The final reader may change
    # presentation, but it may not erase or rewrite the audited source and
    # prerequisite packets beneath that presentation.
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
