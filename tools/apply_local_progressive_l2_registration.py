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


def patch_registry() -> int:
    path = ROOT / "AutoSamplingTheory/TechnicalLemmas/Registry.lean"
    text = path.read_text(encoding="utf-8")
    key = "localization.fixed-time-energy-measurability"
    if f'key := "{key}"' in text:
        return 0
    marker = "def stochasticProcessMemory : List LemmaMemoryEntry := [\n"
    entry = '''  {
    key := "localization.fixed-time-energy-measurability",
    localDecl := "AutoSamplingTheory.TechnicalLemmas.StochasticProcesses.LocalProgressiveL2.accumulatedEnergyReal_stronglyMeasurable",
    upstreamDecl := "Fixed-time filtration measurability of accumulated square energy",
    upstreamFile := "Log-Concave Sampling, Proposition 1.1.13, book page 7 / PDF page 19",
    status := LemmaMemoryStatus.formalizedLocal,
    tags := ["Chewi", "Ito", "localization", "progressive", "filtration", "energy"],
    saldUse := "make canonical energy-hitting events measurable at each observation time",
    note := "The source domain assumes only almost-sure finite path energy, not finite expected energy. Continuity and the first-hitting stopping-time theorem remain downstream."
  },
'''
    if marker not in text:
        raise RuntimeError("stochasticProcessMemory insertion point not found")
    path.write_text(text.replace(marker, marker + entry, 1), encoding="utf-8")
    return 1


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
    insert_import(
        ROOT / "AutoSamplingTheory/TechnicalLemmas/StochasticProcesses.lean",
        "import AutoSamplingTheory.TechnicalLemmas.StochasticProcesses.LocalProgressiveL2",
    )
    insert_import(ROOT / "Tests.lean", "import Tests.LocalProgressiveL2")
    delta = patch_registry()
    sync_count()
    print(f"registered local progressive L2 energy leaves; registry delta={delta}")


if __name__ == "__main__":
    main()
