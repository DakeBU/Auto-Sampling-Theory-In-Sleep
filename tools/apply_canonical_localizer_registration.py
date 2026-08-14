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


def patch_prefix_integral() -> None:
    path = ROOT / "AutoSamplingTheory/TechnicalLemmas/Analysis/PrefixIntegral.lean"
    text = path.read_text(encoding="utf-8")
    if "theorem prefixIntegral_mono" in text:
        return
    block = '''/-- Prefix integration is monotone in time for pointwise nonnegative
integrands. -/
theorem prefixIntegral_mono
    {f : ℝ≥0 → ℝ} {T s t : ℝ≥0}
    (hf : Integrable f (TimeMeasure.upTo T))
    (hnonneg : ∀ u, 0 ≤ f u) (hst : s ≤ t) :
    prefixIntegral f T s ≤ prefixIntegral f T t := by
  unfold prefixIntegral
  have hs : Integrable (fun u => if u < min s T then f u else 0)
      (TimeMeasure.upTo T) := by
    simpa [Set.indicator] using hf.indicator (measurableSet_Iio : MeasurableSet (Iio (min s T)))
  have ht : Integrable (fun u => if u < min t T then f u else 0)
      (TimeMeasure.upTo T) := by
    simpa [Set.indicator] using hf.indicator (measurableSet_Iio : MeasurableSet (Iio (min t T)))
  apply integral_mono hs ht
  intro u
  by_cases hu : u < min s T
  · have hus : u < s := (lt_min_iff.mp hu).1
    have huT : u < T := (lt_min_iff.mp hu).2
    have hut : u < min t T := lt_min (hus.trans_le hst) huT
    simp [hu, hut]
  · by_cases hut : u < min t T
    · simp [hu, hut, hnonneg u]
    · simp [hu, hut]

/-- Prefix integration stabilizes once the observation time passes the
terminal horizon. -/
theorem prefixIntegral_eq_terminal_of_le
    (f : ℝ≥0 → ℝ) (T t : ℝ≥0) (hTt : T ≤ t) :
    prefixIntegral f T t = prefixIntegral f T T := by
  simp [prefixIntegral, min_eq_right hTt]

'''
    marker = "end PrefixIntegral\n"
    if marker not in text:
        raise RuntimeError("PrefixIntegral namespace end not found")
    path.write_text(text.replace(marker, block + marker, 1), encoding="utf-8")


def patch_energy_path_continuity() -> None:
    path = ROOT / "AutoSamplingTheory/TechnicalLemmas/StochasticProcesses/EnergyPathContinuity.lean"
    text = path.read_text(encoding="utf-8")
    if "theorem accumulatedEnergyReal_mono_of_integrable" in text:
        return
    block = '''@[simp] theorem accumulatedEnergyReal_zero
    (eta : LocalProgressiveL2Integrand filtration mu T) (omega : Omega) :
    accumulatedEnergyReal eta 0 omega = 0 := by
  rw [accumulatedEnergyReal_eq_prefixIntegral]
  exact prefixIntegral_zero _ _

/-- On every finite-energy path, accumulated energy is monotone. -/
theorem accumulatedEnergyReal_mono_of_integrable
    (eta : LocalProgressiveL2Integrand filtration mu T)
    (omega : Omega)
    (homega : Integrable (fun u => (eta.process u omega) ^ 2)
      (TimeMeasure.upTo T)) {s t : ℝ≥0} (hst : s ≤ t) :
    accumulatedEnergyReal eta s omega ≤ accumulatedEnergyReal eta t omega := by
  rw [accumulatedEnergyReal_eq_prefixIntegral, accumulatedEnergyReal_eq_prefixIntegral]
  exact prefixIntegral_mono homega (fun u => sq_nonneg _) hst

/-- Accumulated energy stabilizes at the terminal horizon. -/
theorem accumulatedEnergyReal_eq_terminal_of_le
    (eta : LocalProgressiveL2Integrand filtration mu T)
    (omega : Omega) {t : ℝ≥0} (hTt : T ≤ t) :
    accumulatedEnergyReal eta t omega = accumulatedEnergyReal eta T omega := by
  rw [accumulatedEnergyReal_eq_prefixIntegral, accumulatedEnergyReal_eq_prefixIntegral]
  exact prefixIntegral_eq_terminal_of_le _ _ _ hTt

/-- Threshold events for fixed-time accumulated energy are measurable at that
time. -/
theorem measurableSet_accumulatedEnergyReal_ge
    (eta : LocalProgressiveL2Integrand filtration mu T)
    (c : ℝ) (t : ℝ≥0) :
    MeasurableSet[filtration t]
      {omega | c ≤ accumulatedEnergyReal eta t omega} := by
  have hmeas : Measurable[filtration (min t T)]
      (accumulatedEnergyReal eta t) :=
    (accumulatedEnergyReal_stronglyMeasurable eta t).measurable
  have hset : MeasurableSet[filtration (min t T)]
      {omega | c ≤ accumulatedEnergyReal eta t omega} :=
    measurableSet_Ici.preimage hmeas
  exact hset.mono (filtration.mono (min_le_left t T))

'''
    marker = "end EnergyPathContinuity\n"
    if marker not in text:
        raise RuntimeError("EnergyPathContinuity namespace end not found")
    path.write_text(text.replace(marker, block + marker, 1), encoding="utf-8")


def registry_entry(key: str, decl: str, upstream: str, tags: str, use: str, note: str) -> str:
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
            "localization.completed-energy-process",
            "AutoSamplingTheory.TechnicalLemmas.StochasticProcesses.CompletedEnergy.continuous_completedEnergy",
            "Everywhere-continuous completed accumulated energy",
            '"Chewi", "Ito", "localization", "completion", "continuous-path"',
            "replace the null set of nonintegrable paths without losing filtration measurability",
            "Usual-condition completeness makes the null bad set measurable at every time; all completed paths are continuous, monotone, and nonnegative.",
        ),
        (
            "localization.canonical-energy-stopping-time",
            "AutoSamplingTheory.TechnicalLemmas.StochasticProcesses.CanonicalEnergyStoppingTime.canonicalLocalizingTime_isChewiStoppingTime",
            "Stopping-time property of the canonical integer energy localizer",
            '"Chewi", "Ito", "localization", "stopping-time", "first-hit"',
            "supply the stopping-time component of Chewi's canonical localizing sequence",
            "The first equality-level time is characterized by a fixed-time completed-energy threshold event; the proof uses continuity and the intermediate value theorem.",
        ),
        (
            "localization.canonical-localizer-monotone-terminal",
            "AutoSamplingTheory.TechnicalLemmas.StochasticProcesses.CanonicalEnergyLocalizer.tendsto_canonicalLocalizingTime",
            "Monotone canonical localizers eventually equal the terminal horizon",
            '"Chewi", "Ito", "localization", "monotone", "Tendsto"',
            "establish pathwise monotonicity and terminal convergence of the canonical localizing sequence",
            "Once the integer level exceeds finite terminal completed energy, its equality-level set is empty and the localizer equals T. Stopped-integrand global L2 and the stopped-integral identity remain downstream.",
        ),
        (
            "localization.canonical-stopped-energy-bound",
            "AutoSamplingTheory.TechnicalLemmas.StochasticProcesses.CanonicalEnergyLocalizer.completedEnergy_at_canonicalLocalizingTime_le",
            "Canonical localizer bounds stopped completed energy by n+1",
            '"Chewi", "Ito", "localization", "energy-bound", "stopped-integrand"',
            "provide the deterministic energy bound needed to place every stopped integrand in global product L2",
            "The bound is exact on reached levels and uses terminal fallback when the level is not reached. Progressive stopped-integrand measurability remains downstream.",
        ),
    ]
    missing = [e for e in entries if f'key := "{e[0]}"' not in text]
    if not missing:
        return 0
    marker = "def stochasticProcessMemory : List LemmaMemoryEntry := [\n"
    if marker not in text:
        raise RuntimeError("stochasticProcessMemory insertion point not found")
    path.write_text(text.replace(marker, marker + "".join(registry_entry(*e) for e in missing), 1), encoding="utf-8")
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
    patch_prefix_integral()
    patch_energy_path_continuity()
    for module in (
        "CompletedEnergy",
        "CanonicalEnergyLocalizer",
        "CanonicalEnergyStoppingTime",
    ):
        insert_import(
            ROOT / "AutoSamplingTheory/TechnicalLemmas/StochasticProcesses.lean",
            f"import AutoSamplingTheory.TechnicalLemmas.StochasticProcesses.{module}",
        )
        insert_import(ROOT / "Tests.lean", f"import Tests.{module}")
    delta = patch_registry()
    sync_count()
    print(f"registered canonical-localizer leaves; registry delta={delta}")


if __name__ == "__main__":
    main()
