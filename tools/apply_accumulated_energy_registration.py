#!/usr/bin/env python3
from __future__ import annotations

import re
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]


def insert_import(path: Path, import_line: str) -> bool:
    text = path.read_text(encoding="utf-8")
    line = import_line + "\n"
    if line in text:
        return False
    imports = [m for m in re.finditer(r"(?m)^import .+$", text)]
    if not imports:
        raise RuntimeError(f"No import block in {path}")
    pos = imports[-1].end()
    text = text[:pos] + "\n" + import_line + text[pos:]
    path.write_text(text, encoding="utf-8")
    return True


def patch_registry() -> int:
    path = ROOT / "AutoSamplingTheory/TechnicalLemmas/Registry.lean"
    text = path.read_text(encoding="utf-8")
    key = "localization.accumulated-energy-monotonicity"
    if f'key := "{key}"' in text:
        return 0
    marker = "def stochasticProcessMemory : List LemmaMemoryEntry := [\n"
    if marker not in text:
        raise RuntimeError("stochasticProcessMemory insertion point not found")
    entry = '''  {
    key := "localization.accumulated-energy-monotonicity",
    localDecl := "AutoSamplingTheory.TechnicalLemmas.StochasticProcesses.AccumulatedEnergy.accumulatedEnergy_mono",
    upstreamDecl := "Monotonicity of accumulated pathwise square energy",
    upstreamFile := "Log-Concave Sampling, Proposition 1.1.13, book page 7 / PDF page 19",
    status := LemmaMemoryStatus.formalizedLocal,
    tags := ["Chewi", "Ito", "localization", "energy", "stopping-time"],
    saldUse := "supply the monotone nonnegative path-energy process used by the canonical localizing sequence",
    note := "This is an exact ENNReal integral leaf. Fixed-time filtration measurability, path continuity on the finite-energy set, and the first-hitting stopping time remain downstream."
  },
'''
    path.write_text(text.replace(marker, marker + entry, 1), encoding="utf-8")
    return 1


def sync_registry_count() -> None:
    registry = (ROOT / "AutoSamplingTheory/TechnicalLemmas/Registry.lean").read_text(
        encoding="utf-8"
    )
    actual = registry.count("status := LemmaMemoryStatus.formalizedLocal")
    path = ROOT / "Tests/Basic.lean"
    text = path.read_text(encoding="utf-8")
    pattern = re.compile(
        r"(TechnicalLemmas\.formalizedTechnicalLemmaCount\s*=\s*)(\d+)(\s*:=)"
    )
    if not pattern.search(text):
        raise RuntimeError("formalizedTechnicalLemmaCount assertion not found")
    path.write_text(
        pattern.sub(lambda m: f"{m.group(1)}{actual}{m.group(3)}", text, count=1),
        encoding="utf-8",
    )


def main() -> None:
    insert_import(
        ROOT / "AutoSamplingTheory/TechnicalLemmas/StochasticProcesses.lean",
        "import AutoSamplingTheory.TechnicalLemmas.StochasticProcesses.AccumulatedEnergy",
    )
    insert_import(ROOT / "Tests.lean", "import Tests.AccumulatedEnergy")
    added = patch_registry()
    sync_registry_count()
    print(f"registered accumulated-energy leaves; registry delta={added}")


if __name__ == "__main__":
    main()
