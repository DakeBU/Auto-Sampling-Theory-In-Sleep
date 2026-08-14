#!/usr/bin/env python3
from __future__ import annotations

import copy
import json
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
DECL = "AutoSamplingTheory.TechnicalLemmas.StochasticProcesses.CanonicalLocalizationTheorem.chewi_proposition_1_1_13"
TEST = "Tests/CanonicalLocalizationTheorem.lean"
KEY = "localization.chewi-proposition-1-1-13"
ROW_ID = "chewi-1-1-proposition-1-1-13"


def main() -> None:
    source_path = ROOT / "website/content/source_correspondence.json"
    sources = json.loads(source_path.read_text(encoding="utf-8"))
    by_id = {row["id"]: row for row in sources}
    if ROW_ID not in by_id:
        row = copy.deepcopy(by_id["chewi-1-1-definition-1-1-12"])
        row.update({
            "id": ROW_ID,
            "chapter": 1,
            "section": "1.1",
            "source_kind": "Proposition 1.1.13",
            "book_page": 7,
            "pdf_page": 19,
            "source_summary": "The energy first-hitting times form an increasing stopping-time sequence converging to the terminal horizon, and the corresponding stopped progressive integrands have globally finite square energy.",
            "mathematical_exposition": "Complete nonintegrable null paths by zero, form the continuous monotone accumulated energy, take first equality-level times at n+1 with terminal fallback, and stop the integrand at the energy threshold. Continuity gives the stopping-time event characterization and the exact pathwise energy bound.",
            "astis_exposition": "The owned theorem packages actual stopping-time proofs, pathwise monotonicity and convergence, progressive measurability after null completion, Tonelli-based product-L2 membership, and a focused test. It does not claim the stopped-integral identity or local-martingale conclusion.",
            "rigorous_packet": "usual-condition completion; continuous monotone completed energy; equality-level first hitting time; stopping-time event measurability; monotonicity in level; terminal convergence; progressive stopped process; pathwise energy bound; probability-space Tonelli upgrade",
            "source_assumptions": [
                "a complete right-continuous filtered probability space",
                "a progressive integrand with almost-sure finite square energy on the finite horizon",
            ],
            "formal_assumptions": [
                "SatisfiesUsualConditions for the filtration and probability measure",
                "LocalProgressiveL2Integrand on NNReal time",
                "IsProbabilityMeasure for the sample law",
                "finite terminal horizon T",
            ],
            "downstream_consumers": [
                "Chewi display 1.1.14 stopped-integral identity",
                "Chewi Proposition 1.1.16 continuous local martingale",
                "Ito process localization",
            ],
            "lean_declarations": [DECL],
        })
        sources.append(row)
    else:
        by_id[ROW_ID]["lean_declarations"] = [DECL]
    source_path.write_text(json.dumps(sources, ensure_ascii=False, indent=2) + "\n", encoding="utf-8")

    matrix_path = ROOT / "website/content/chapter_1_completion_matrix.json"
    matrix = json.loads(matrix_path.read_text(encoding="utf-8"))
    item = next(row for row in matrix["items"] if row["number"] == "1.1.13" and row["category"] == "statement")
    item.update({
        "source_correspondence_id": ROW_ID,
        "required_declarations": [DECL],
        "focused_tests": [TEST],
        "registry_keys": [KEY],
        "coverage_status": "complete",
        "residual_blockers": [],
        "downstream_consumers": [
            "stopped Ito integral identity",
            "continuous local martingale theorem",
            "localized Ito formula",
        ],
    })
    matrix_path.write_text(json.dumps(matrix, ensure_ascii=False, indent=2) + "\n", encoding="utf-8")

    teaching_path = ROOT / "website/content/teaching_declarations.json"
    teaching = json.loads(teaching_path.read_text(encoding="utf-8"))
    if not any(row.get("declaration") == DECL for row in teaching):
        teaching.append({
            "declaration": DECL,
            "chapter": 1,
            "route_status": "Compiled",
            "plain_english": "Stop a locally square-integrable progressive process when its accumulated energy first reaches n+1. These stopping times increase to the terminal horizon, and every stopped process is globally square integrable.",
            "mathematical_statement": "For tau_n equal to the first completed-energy level time n+1, capped at T, every tau_n is a stopping time, tau_n is increasing, tau_n tends to T pathwise, and the square energy of eta stopped before tau_n is at most n+1.",
            "intuition": "A path can only accumulate finite energy on the finite horizon. Raising the allowed energy level therefore delays stopping, and eventually the level is never reached before T.",
            "assumptions": [
                "usual completeness and right-continuity of the filtration",
                "progressiveness of the integrand",
                "almost-sure finite pathwise square energy",
                "a probability sample measure",
            ],
            "why_assumptions": [
                "completeness permits zero replacement on the null set of nonintegrable paths without losing adaptedness",
                "progressiveness makes the energy-threshold stopped process measurable",
                "pathwise finite energy forces the integer-level localizers eventually to equal T",
                "the probability normalization upgrades the pathwise bound to product-L2",
            ],
            "proof_route": [
                "complete bad energy paths by zero",
                "prove completed energy is continuous, monotone, and adapted",
                "take the first equality-level time with T fallback",
                "characterize tau_n <= t by a fixed-time energy threshold",
                "prove monotonicity and eventual equality to T",
                "identify the stopped process with the progressive energy-threshold process",
                "integrate the pathwise n+1 energy bound by Tonelli",
            ],
            "lean_notes": [
                "the theorem owns the stopping-time and product-L2 proofs",
                "display 1.1.14 and Proposition 1.1.16 remain separate downstream declarations",
            ],
        })
    teaching_path.write_text(json.dumps(teaching, ensure_ascii=False, indent=2) + "\n", encoding="utf-8")


if __name__ == "__main__":
    main()
