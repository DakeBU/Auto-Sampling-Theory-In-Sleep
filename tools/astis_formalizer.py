#!/usr/bin/env python3
"""Provider-independent LaTeX-to-Lean candidate adapter for ASTIS.

This module does not claim general semantic translation.  It recognizes a
small, reviewed set of sampling-theory statement shapes, retrieves relevant
local Registry declarations, and emits an ASTIS-compatible candidate packet.
Unknown inputs remain explicit unresolved formalization requests.
"""

from __future__ import annotations

import argparse
import dataclasses
import hashlib
import json
import re
from pathlib import Path
from typing import Any, Sequence


ROOT = Path(__file__).resolve().parents[1]
REGISTRY = ROOT / "AutoSamplingTheory" / "TechnicalLemmas" / "Registry.lean"
MAX_LATEX_CHARACTERS = 50_000


@dataclasses.dataclass(frozen=True)
class FormalizationRequest:
    latex: str
    natural_language_context: str = ""
    preferred_module: str = ""
    source_anchor: str = ""

    def validate(self) -> None:
        if not self.latex.strip():
            raise ValueError("latex must be a nonempty string")
        if len(self.latex) > MAX_LATEX_CHARACTERS:
            raise ValueError(
                f"latex exceeds the {MAX_LATEX_CHARACTERS}-character request limit"
            )


@dataclasses.dataclass(frozen=True)
class FormalizationResult:
    status: str
    template: str
    plain_language_interpretation: str
    lean_statement: str
    lean_source: str
    assumptions: tuple[str, ...]
    imports: tuple[str, ...]
    local_candidates: tuple[str, ...]
    mathlib_candidates: tuple[str, ...]
    rejected_candidates: tuple[str, ...]
    semantic_notes: tuple[str, ...]
    remaining_proof_obligations: tuple[str, ...]
    source_anchor: str
    statement_hash: str
    translation_status: str = "candidate"
    semantic_review_status: str = "not_reviewed"
    proof_status: str = "unproved"
    reviewer_status: str = "not_reviewed"

    def as_dict(self) -> dict[str, Any]:
        return dataclasses.asdict(self)


def _statement_hash(statement: str) -> str:
    normalized = " ".join(statement.split())
    return hashlib.sha256(normalized.encode("utf-8")).hexdigest()


def registry_declarations() -> tuple[str, ...]:
    source = REGISTRY.read_text(encoding="utf-8")
    return tuple(dict.fromkeys(re.findall(r'localDecl := "([^"]+)"', source)))


def retrieve_local_candidates(query: str, *, limit: int = 12) -> tuple[str, ...]:
    terms = {
        term.lower()
        for term in re.findall(r"[A-Za-z][A-Za-z0-9_-]{2,}", query)
        if term.lower() not in {"operatorname", "mathrm", "left", "right"}
    }
    scored: list[tuple[int, str]] = []
    for declaration in registry_declarations():
        lowered = declaration.lower()
        score = sum(term in lowered for term in terms)
        if score:
            scored.append((score, declaration))
    scored.sort(key=lambda item: (-item[0], item[1]))
    return tuple(name for _, name in scored[:limit])


def _is_poincare_request(text: str) -> bool:
    lowered = text.lower()
    has_variance = "operatorname{var}" in lowered or "variance" in lowered or "var_" in lowered
    has_energy = "nabla" in lowered or "gradient" in lowered or "dirichlet" in lowered
    return has_variance and has_energy


def _poincare_result(request: FormalizationRequest) -> FormalizationResult:
    module = (
        "AutoSamplingTheory.TechnicalLemmas.FunctionalInequalities.Poincare"
    )
    statement = "Poincare.Satisfies π tests C"
    source = f"""import {module}

open MeasureTheory
open scoped RealInnerProductSpace
open AutoSamplingTheory.TechnicalLemmas.FunctionalInequalities

-- Candidate proposition extracted from the submitted Poincare-shaped formula.
-- Elaboration checks the types only; it does not prove semantic equivalence.
#check fun
    {{E : Type*}} [MeasurableSpace E] [NormedAddCommGroup E]
    [InnerProductSpace ℝ E] [CompleteSpace E]
    (π : Measure E) (tests : Set (E → ℝ)) (C : ℝ) =>
  Poincare.Satisfies π tests C
"""
    local = tuple(
        name
        for name in registry_declarations()
        if ".FunctionalInequalities.Poincare." in name
    )
    return FormalizationResult(
        status="candidate",
        template="poincare_inequality",
        plain_language_interpretation=(
            "The probability measure π satisfies a Poincare inequality with "
            "constant C on an explicit test-function class."
        ),
        lean_statement=statement,
        lean_source=source,
        assumptions=(
            "E is a complete real inner-product space with a measurable structure.",
            "π is a probability measure; this is an explicit field of Poincare.Satisfies.",
            "tests is the intended class of scalar observables.",
            "Each consumed observable satisfies Poincare.Admissible, including the required integrability conditions.",
            "C is nonnegative; this is an explicit field of Poincare.Satisfies.",
        ),
        imports=(module,),
        local_candidates=local,
        mathlib_candidates=(
            "MeasureTheory.IsProbabilityMeasure",
            "MeasureTheory.Integrable",
            "gradient",
            "MeasureTheory.integral",
        ),
        rejected_candidates=(),
        semantic_notes=(
            "The formula was matched by a deterministic Poincare template, not a general semantic parser.",
            "Poincare.Satisfies makes the probability, test-class, constant, and admissibility contracts explicit.",
            "Successful Lean elaboration certifies only that the candidate proposition is well typed.",
        ),
        remaining_proof_obligations=(
            "A reviewer must confirm that the submitted symbols π, f, and C have the intended semantics.",
            "A theorem showing that the concrete target measure satisfies this Poincare contract is still required.",
        ),
        source_anchor=request.source_anchor,
        statement_hash=_statement_hash(statement),
    )


def formalize(request: FormalizationRequest) -> FormalizationResult:
    request.validate()
    combined = "\n".join((request.latex, request.natural_language_context))
    if _is_poincare_request(combined):
        return _poincare_result(request)
    local = retrieve_local_candidates(combined)
    notes = [
        "No reviewed deterministic translation template matched this input.",
        "The request can still be exported as an ASTIS analytic_contract for upper/middle decomposition.",
    ]
    if not local:
        notes.append("No lexical Registry candidate was found.")
    return FormalizationResult(
        status="unsupported",
        template="none",
        plain_language_interpretation=request.natural_language_context.strip(),
        lean_statement="",
        lean_source="",
        assumptions=(),
        imports=tuple(filter(None, (request.preferred_module,))),
        local_candidates=local,
        mathlib_candidates=(),
        rejected_candidates=(),
        semantic_notes=tuple(notes),
        remaining_proof_obligations=(
            "Upper must audit the mathematical statement and hidden assumptions.",
            "Middle must produce a formalization_map before Lean compilation.",
        ),
        source_anchor=request.source_anchor,
        statement_hash=_statement_hash(request.latex),
        translation_status="unresolved",
    )


def request_from_dict(payload: dict[str, Any]) -> FormalizationRequest:
    return FormalizationRequest(
        latex=str(payload.get("latex", "")),
        natural_language_context=str(payload.get("natural_language_context", "")),
        preferred_module=str(payload.get("preferred_module", "")),
        source_anchor=str(payload.get("source_anchor", "")),
    )


def parser() -> argparse.ArgumentParser:
    result = argparse.ArgumentParser(description=__doc__)
    result.add_argument("--latex", default="")
    result.add_argument("--context", default="")
    result.add_argument("--preferred-module", default="")
    result.add_argument("--source-anchor", default="")
    result.add_argument("--request-json", type=Path)
    return result


def main(argv: Sequence[str] | None = None) -> int:
    args = parser().parse_args(argv)
    if args.request_json:
        payload = json.loads(args.request_json.read_text(encoding="utf-8"))
        if not isinstance(payload, dict):
            raise SystemExit("request JSON must contain an object")
        request = request_from_dict(payload)
    else:
        request = FormalizationRequest(
            latex=args.latex,
            natural_language_context=args.context,
            preferred_module=args.preferred_module,
            source_anchor=args.source_anchor,
        )
    print(json.dumps(formalize(request).as_dict(), indent=2, ensure_ascii=False))
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
