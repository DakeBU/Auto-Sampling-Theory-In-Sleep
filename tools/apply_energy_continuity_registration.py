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


def patch_time_measure() -> None:
    path = ROOT / "AutoSamplingTheory/TechnicalLemmas/StochasticProcesses/TimeMeasure.lean"
    text = path.read_text(encoding="utf-8")
    blocks: list[str] = []
    if "theorem upTo_singleton" not in text:
        blocks.append('''/-- Single time points have zero mass under the finite nonnegative-time
Lebesgue measure. -/
theorem upTo_singleton (T a : ℝ≥0) : upTo T {a} = 0 := by
  calc
    upTo T {a} =
        (volume.restrict (Icc 0 (T : ℝ))) (NNReal.toReal '' ({a} : Set ℝ≥0)) := by
      unfold upTo
      exact Measure.comap_apply NNReal.toReal NNReal.coe_injective
        (fun _ hs => (MeasurableEmbedding.subtype_coe
          (measurableSet_Ici : MeasurableSet (Ici (0 : ℝ)))).measurableSet_image' hs)
        _ (measurableSet_singleton a)
    _ = 0 := by simp

''')
    if "theorem upTo_Ioi_terminal" not in text:
        blocks.append('''/-- The finite time measure is supported on `[0,T]`. -/
theorem upTo_Ioi_terminal (T : ℝ≥0) : upTo T (Ioi T) = 0 := by
  calc
    upTo T (Ioi T) =
        (volume.restrict (Icc 0 (T : ℝ))) (NNReal.toReal '' Ioi T) := by
      unfold upTo
      exact Measure.comap_apply NNReal.toReal NNReal.coe_injective
        (fun _ hs => (MeasurableEmbedding.subtype_coe
          (measurableSet_Ici : MeasurableSet (Ici (0 : ℝ)))).measurableSet_image' hs)
        _ (measurableSet_Ioi : MeasurableSet (Ioi T))
    _ = 0 := by
      rw [Measure.restrict_apply]
      · simp
      · exact (MeasurableEmbedding.subtype_coe
          (measurableSet_Ici : MeasurableSet (Ici (0 : ℝ)))).measurableSet_image'
            measurableSet_Ioi

/-- Almost every time under `upTo T` lies below the terminal horizon. -/
theorem ae_le_terminal (T : ℝ≥0) : ∀ᵐ s ∂upTo T, s ≤ T := by
  rw [ae_iff]
  simpa only [Set.compl_setOf, not_le] using upTo_Ioi_terminal T

''')
    if blocks:
        marker = "end TimeMeasure\n"
        if marker not in text:
            raise RuntimeError("TimeMeasure namespace end not found")
        path.write_text(text.replace(marker, "".join(blocks) + marker, 1), encoding="utf-8")


def patch_local_progressive_l2() -> None:
    path = ROOT / "AutoSamplingTheory/TechnicalLemmas/StochasticProcesses/LocalProgressiveL2.lean"
    text = path.read_text(encoding="utf-8")
    if "squaredExtensionAt_apply_of_not_le" not in text:
        marker = '''@[simp] theorem squaredExtensionAt_apply_of_le
    (eta : LocalProgressiveL2Integrand filtration mu T)
    {s b : ℝ≥0} (hsb : s ≤ b) (omega : Omega) :
    squaredExtensionAt eta b (s, omega) = (eta.process s omega) ^ 2 := by
  let p : Set.Iic b × Omega := (⟨s, hsb⟩, omega)
  exact ((MeasurableEmbedding.subtype_coe measurableSet_Iic).prodMap
    MeasurableEmbedding.id).injective.extend_apply
      (fun q : Set.Iic b × Omega => (eta.process q.1 q.2) ^ 2) 0 p

'''
        addition = '''@[simp] theorem squaredExtensionAt_apply_of_not_le
    (eta : LocalProgressiveL2Integrand filtration mu T)
    {s b : ℝ≥0} (hsb : ¬s ≤ b) (omega : Omega) :
    squaredExtensionAt eta b (s, omega) = 0 := by
  rw [squaredExtensionAt, Function.extend_apply']
  · rintro ⟨u, hu⟩
    apply hsb
    have hsu := congrArg Prod.fst hu
    change (u.1 : ℝ≥0) = s at hsu
    have hub : (u.1 : ℝ≥0) ≤ b := u.1.property
    rwa [hsu] at hub

'''
        if marker not in text:
            raise RuntimeError("squaredExtensionAt insertion point not found")
        text = text.replace(marker, marker + addition, 1)
    text = text.replace(
        '''  ∫ s, squaredExtensionAt eta (min t T) (s, omega)
    ∂(TimeMeasure.upTo (min t T))
''',
        '''  ∫ s, squaredExtensionAt eta (min t T) (s, omega)
    ∂(TimeMeasure.upTo T)
''',
    )
    text = text.replace(
        '''    (TimeMeasure.upTo (min t T)) inferInstance inferInstance inferInstance
''',
        '''    (TimeMeasure.upTo T) inferInstance inferInstance inferInstance
''',
    )
    path.write_text(text, encoding="utf-8")


def registry_entry(key: str, local_decl: str, upstream: str, tags: str, use: str, note: str) -> str:
    return f'''  {{
    key := "{key}",
    localDecl := "{local_decl}",
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
            "analysis.prefix-integral-continuity",
            "AutoSamplingTheory.TechnicalLemmas.Analysis.PrefixIntegral.continuous_prefixIntegral",
            "Continuity of finite-horizon moving prefix integrals",
            '"Chewi", "analysis", "Bochner-integral", "continuity", "localization"',
            "supply the analytic continuity theorem for accumulated square energy",
            "The proof uses dominated convergence on the repository's finite NNReal time measure and treats the moving endpoint singleton as a null set.",
        ),
        (
            "localization.energy-path-continuity",
            "AutoSamplingTheory.TechnicalLemmas.StochasticProcesses.EnergyPathContinuity.continuous_accumulatedEnergyReal_ae",
            "Almost-sure continuity of accumulated progressive square energy",
            '"Chewi", "Ito", "localization", "energy", "continuity"',
            "justify the first-hitting canonical localizer by a continuous monotone energy path",
            "The theorem starts from progressive measurability and almost-sure finite path energy; the stopping-time and stopped-integrand theorems remain downstream.",
        ),
    ]
    missing = [entry for entry in entries if f'key := "{entry[0]}"' not in text]
    if not missing:
        return 0
    marker = "def stochasticProcessMemory : List LemmaMemoryEntry := [\n"
    if marker not in text:
        raise RuntimeError("stochasticProcessMemory insertion point not found")
    block = "".join(registry_entry(*entry) for entry in missing)
    path.write_text(text.replace(marker, marker + block, 1), encoding="utf-8")
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
    patch_time_measure()
    patch_local_progressive_l2()
    insert_import(
        ROOT / "AutoSamplingTheory/TechnicalLemmas/Analysis.lean",
        "import AutoSamplingTheory.TechnicalLemmas.Analysis.PrefixIntegral",
    )
    insert_import(
        ROOT / "AutoSamplingTheory/TechnicalLemmas/StochasticProcesses.lean",
        "import AutoSamplingTheory.TechnicalLemmas.StochasticProcesses.EnergyPathContinuity",
    )
    insert_import(ROOT / "Tests.lean", "import Tests.PrefixIntegral")
    insert_import(ROOT / "Tests.lean", "import Tests.EnergyPathContinuity")
    delta = patch_registry()
    sync_count()
    print(f"registered accumulated-energy continuity leaves; registry delta={delta}")


if __name__ == "__main__":
    main()
