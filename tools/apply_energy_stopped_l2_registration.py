#!/usr/bin/env python3
from __future__ import annotations

import re
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]


def insert_import(path: Path, import_line: str) -> None:
    text = path.read_text(encoding="utf-8")
    if import_line in text.splitlines():
        return
    imports = [m for m in re.finditer(r"(?m)^import .+$", text)]
    if not imports:
        raise RuntimeError(f"No import block in {path}")
    pos = imports[-1].end()
    path.write_text(text[:pos] + "\n" + import_line + text[pos:], encoding="utf-8")


def entry(key: str, decl: str, upstream: str, tags: str, use: str, note: str) -> str:
    return f'''  {{
    key := "{key}",
    localDecl := "{decl}",
    upstreamDecl := "{upstream}",
    upstreamFile := "Log-Concave Sampling, Proposition 1.1.13, book page 7 / PDF page 19",
    status := LemmaMemoryStatus.formalizedLocal,
    tags := [{tags}],
    saldUse := "{use}",
    note := "{note}"
  }},
'''


def patch_registry() -> int:
    path = ROOT / "AutoSamplingTheory/TechnicalLemmas/Registry.lean"
    text = path.read_text(encoding="utf-8")
    entries = [
        (
            "localization.completed-integrand-progressive",
            "AutoSamplingTheory.TechnicalLemmas.StochasticProcesses.CompletedIntegrand.completedIntegrand_stronglyProgressive",
            "Progressiveness after completing the null bad-path set",
            '"Chewi", "Ito", "localization", "completion", "progressive"',
            "replace nonintegrable sample paths by zero while preserving the progressive sigma-algebra",
            "The source local-L2 domain assumes only almost-sure finite path energy. Usual-condition completeness makes the null replacement measurable at every filtration time.",
        ),
        (
            "localization.energy-stopped-path-bound",
            "AutoSamplingTheory.TechnicalLemmas.StochasticProcesses.EnergyStoppedIntegrand.integral_energyStoppedIntegrand_sq_le",
            "Pathwise square-energy bound after canonical stopping",
            '"Chewi", "Ito", "localization", "stopped-integrand", "energy-bound"',
            "bound each stopped path by its canonical energy level before taking expectation",
            "The threshold representation is proved equivalent almost everywhere in time to stopping before the equality-level localizer. No expected-energy hypothesis is used.",
        ),
        (
            "localization.stopped-progressive-l2",
            "AutoSamplingTheory.TechnicalLemmas.StochasticProcesses.EnergyStoppedProgressiveL2.stoppedProgressiveL2",
            "Global progressive product-L2 membership after energy stopping",
            '"Chewi", "Ito", "localization", "progressive-L2", "Tonelli"',
            "feed each canonical stopped integrand into the global Ito integral constructed in Theorem 1.1.8",
            "Tonelli integrates the pathwise level bound over the probability measure. The stopped-integral identity and local-martingale consistency remain downstream.",
        ),
    ]
    missing = [e for e in entries if f'key := "{e[0]}"' not in text]
    if not missing:
        return 0
    marker = "def stochasticProcessMemory : List LemmaMemoryEntry := [\n"
    if marker not in text:
        raise RuntimeError("stochasticProcessMemory insertion point not found")
    path.write_text(text.replace(marker, marker + "".join(entry(*e) for e in missing), 1), encoding="utf-8")
    return len(missing)


def sync_count() -> None:
    registry = (ROOT / "AutoSamplingTheory/TechnicalLemmas/Registry.lean").read_text(encoding="utf-8")
    actual = registry.count("status := LemmaMemoryStatus.formalizedLocal")
    path = ROOT / "Tests/Basic.lean"
    text = path.read_text(encoding="utf-8")
    pattern = re.compile(r"(TechnicalLemmas\.formalizedTechnicalLemmaCount\s*=\s*)(\d+)(\s*:=)")
    if not pattern.search(text):
        raise RuntimeError("formalizedTechnicalLemmaCount assertion not found")
    path.write_text(pattern.sub(lambda m: f"{m.group(1)}{actual}{m.group(3)}", text, count=1), encoding="utf-8")


def main() -> None:
    for module in ("CompletedIntegrand", "EnergyStoppedIntegrand", "EnergyStoppedProgressiveL2"):
        insert_import(
            ROOT / "AutoSamplingTheory/TechnicalLemmas/StochasticProcesses.lean",
            f"import AutoSamplingTheory.TechnicalLemmas.StochasticProcesses.{module}",
        )
        insert_import(ROOT / "Tests.lean", f"import Tests.{module}")
    delta = patch_registry()
    sync_count()
    print(f"registered energy-stopped product-L2 leaves; registry delta={delta}")


if __name__ == "__main__":
    main()
