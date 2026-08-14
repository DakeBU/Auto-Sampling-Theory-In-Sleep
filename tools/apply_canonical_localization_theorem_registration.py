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
    key = "localization.chewi-proposition-1-1-13"
    if f'key := "{key}"' in text:
        return 0
    marker = "def stochasticProcessMemory : List LemmaMemoryEntry := [\n"
    if marker not in text:
        raise RuntimeError("stochasticProcessMemory insertion point not found")
    entry = '''  {
    key := "localization.chewi-proposition-1-1-13",
    localDecl := "AutoSamplingTheory.TechnicalLemmas.StochasticProcesses.CanonicalLocalizationTheorem.chewi_proposition_1_1_13",
    upstreamDecl := "Chewi Proposition 1.1.13",
    upstreamFile := "Log-Concave Sampling, book page 7 / PDF page 19",
    status := LemmaMemoryStatus.formalizedLocal,
    tags := ["Chewi", "Ito", "localization", "stopping-time", "progressive-L2"],
    saldUse := "package the canonical energy first-hitting times, terminal convergence, and stopped global-L2 bound into the exact Chapter 1 source result",
    note := "The stopped-integral identity (display 1.1.14) and the continuous local-martingale theorem (Proposition 1.1.16) remain separate downstream routes."
  },
'''
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
        "import AutoSamplingTheory.TechnicalLemmas.StochasticProcesses.CanonicalLocalizationTheorem",
    )
    insert_import(ROOT / "Tests.lean", "import Tests.CanonicalLocalizationTheorem")
    delta = patch_registry()
    sync_count()
    print(f"registered Chewi Proposition 1.1.13; registry delta={delta}")


if __name__ == "__main__":
    main()
