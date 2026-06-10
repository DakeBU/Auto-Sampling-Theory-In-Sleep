#!/usr/bin/env python3
"""ASTIS local workflow helper.

This is the stable command surface for Auto-Sampling-Theory-In-Sleep.  It is
adapted from the plain-file workflow used by the Quantum block-encoding
automation project, but the domain is SDE/Sampling proof formalization.
"""

from __future__ import annotations

import argparse
import csv
import datetime as _dt
import json
import os
import re
import subprocess
import sys
import time
from pathlib import Path


ROOT = Path(__file__).resolve().parents[1]
STATE_DIR = ROOT / ".astis"
STATE_FILE = STATE_DIR / "state.json"
TRIAL_LOG = ROOT / "runs" / "trials.jsonl"
TRIAL_SUMMARY = ROOT / "runs" / "trials_summary.csv"
MANIFEST = ROOT / "MANIFEST.md"
EFFICIENCY_DIR = ROOT / "runs" / "efficiency"
CONTEXT_PACK_DIR = ROOT / "runs" / "context-packs"
BLUEPRINT_DIR = ROOT / "research-wiki" / "blueprints"

SALD_ROOT = Path("/home/nitanda_sub/mark/repos/sald/paper")
RMFLD_ROOT = Path("/home/nitanda_sub/mark/repos/RMFLD/RMFLD_paper")
SLT_ROOT = Path("/home/nitanda_sub/mark/repos/RMFLD/lean-stat-learning-theory")
SLT_ARTICLE_ROOT = Path("/home/nitanda_sub/mark/repos/RMFLD/Statistical Learning Theory in Lean 4 Empirical Processes from Scratch")
OUTER_REPOS_ROOT = Path("/home/nitanda_sub/mark/repos/outer_repos")
OUTER_PAPERS_ROOT = Path("/home/nitanda_sub/mark/repos/outer_papers")
OUTER_REPOS_AUTOMATION_ROOT = OUTER_REPOS_ROOT / "automation_systems"
OUTER_REPOS_SAMPLING_ROOT = OUTER_REPOS_ROOT / "sampling_theory_sde"
OUTER_PAPERS_AUTOMATION_ROOT = OUTER_PAPERS_ROOT / "automation_systems"
LEANMARATHON_ROOT = OUTER_REPOS_AUTOMATION_ROOT / "LeanMarathon"
LEANMARATHON_PDF = OUTER_PAPERS_AUTOMATION_ROOT / "LeanMarathon-2606.05400.pdf"
TECH_REPORT_ROOT = Path(os.environ.get("ASTIS_TECH_REPORT_ROOT", str(ROOT.parent / "Auto_Proof_Papers" / "ASTIS")))

QUANTUM_AUTOPROOF_URL = "https://github.com/DakeBU/Quantum-Computing-Block-Encoding/tree/wip/ghl2025-faithful-20260518-0201"
SLT_URL = "https://github.com/YuanheZ/lean-stat-learning-theory"
SLT_ARXIV_URL = "https://arxiv.org/abs/2602.02285"
LEANMARATHON_URL = "https://github.com/YuanheZ/LeanMarathon"
LEANMARATHON_ARXIV_URL = "https://arxiv.org/abs/2606.05400"
MATHCODE_URL = "https://github.com/math-ai-org/mathcode"
MATHCODE_LOCAL_REFERENCE = OUTER_REPOS_AUTOMATION_ROOT / "mathcode"
ARIS_URL = "https://github.com/wanshuiyin/Auto-claude-code-research-in-sleep"
LBG_URL = "https://github.com/Trinkle23897/learning-beyond-gradients"
EOH_URL = "https://github.com/FeiLiu36/EoH"

AGENT_ROLES = ("upper", "middle", "lower", "reviewer")
TRIAL_KINDS = ("plan", "attempt", "build", "review", "proposal", "compression", "handoff", "source-index")
TRIAL_STATUSES = ("queued", "running", "blocked", "failed", "compiled", "accepted", "rejected", "indexed")
PACKET_CLASSIFICATIONS = (
    "discharges-supplied-hypothesis",
    "narrows-source-cited-boundary",
    "rejected-wrapper-churn",
)
SALD_COMPACT_CONTEXT_START_CYCLE = 85
FORBIDDEN_REGEX = re.compile(
    r"\bsorry\b|\badmit\b|"
    r"^\s*(?:@\[[^\]]*\]\s*)*(?:(?:private|protected|noncomputable|local|unsafe|partial)\s+)*"
    r"(?:axiom|constant|postulate)\b|"
    r"Prop\s*:=\s*True|:=\s*trivial"
)
LEAN_DECL_REGEX = re.compile(
    r"^\s*(?:@\[[^\]]*\]\s*)*(?:(?:private|protected|noncomputable|local|unsafe|partial)\s+)*"
    r"(theorem|lemma|def|instance|structure|class|inductive)\b",
    re.MULTILINE,
)
LEAN_DECL_NAME_REGEX = re.compile(
    r"^\s*(?:@\[[^\]]*\]\s*)*(?:(?:private|protected|noncomputable|local|unsafe|partial)\s+)*"
    r"(theorem|lemma|def|instance|structure|class|inductive)\s+([A-Za-z0-9_.'-]+)",
)

WORK_DIRS = [
    "tasks",
    "conversion-windows",
    "paper-notes",
    "proof-obligations",
    "proof-attempts",
    "candidate-populations",
    "open-problem-proposals",
    "reviews",
    "runs",
    "runs/efficiency",
    "runs/context-packs",
    "research-wiki/cited-results",
    "research-wiki/source-index",
    "research-wiki/blueprints",
    "research-wiki/papers",
    "research-wiki/claims",
    "research-wiki/ideas",
    "research-wiki/experiments",
]


def now_stamp() -> str:
    return _dt.datetime.now().strftime("%Y-%m-%d %H:%M:%S")


def file_stamp() -> str:
    return _dt.datetime.now().strftime("%Y%m%d-%H%M%S-%f")


def rel(path: Path) -> str:
    try:
        return str(path.relative_to(ROOT))
    except ValueError:
        return str(path)


def slugify(value: str) -> str:
    value = re.sub(r"[^A-Za-z0-9_.-]+", "-", value).strip("-")
    return value or "untitled"


def public_article_text(value: str) -> str:
    """Convert internal run notes into public-facing report prose."""

    replacements = {
        "sald_version_2.tex": "unrelated draft routes",
        "•": " dot ",
        "→": " -> ",
        "↦": " |-> ",
        "–": "-",
        "—": "--",
        "“": '"',
        "”": '"',
        "’": "'",
    }
    for old, new in replacements.items():
        value = value.replace(old, new)
    value = re.sub(r"/home/nitanda_sub/mark/repos/[^\s`]+", "[local source path]", value)
    value = re.sub(r"\bappendix\.tex:\d+(?:-\d+)?", "the relevant SALD appendix passage", value)
    value = re.sub(r"\bmain_body\.tex:\d+(?:-\d+)?", "the corresponding SALD main-text passage", value)
    value = re.sub(r"\b[A-Za-z0-9_.-]+\.tex:\d+(?:-\d+)?", "the source LaTeX passage", value)
    value = re.sub(r"\b[1-9]\d{2,3}-\d{3,4}\b", "the relevant SALD source passage", value)
    value = re.sub(r"lower_\d+ recorded as lower because astis\.py rejects lower_\d+\.\s*", "", value)
    return value


def run(cmd: list[str]) -> int:
    print("$ " + " ".join(cmd))
    return subprocess.run(cmd, cwd=ROOT).returncode


def run_capture(cmd: list[str]) -> tuple[int, str]:
    completed = subprocess.run(
        cmd,
        cwd=ROOT,
        text=True,
        stdout=subprocess.PIPE,
        stderr=subprocess.STDOUT,
    )
    return completed.returncode, completed.stdout


def strip_lean_comments_and_strings(text: str) -> str:
    """Remove Lean comments and string literals for policy scans.

    The forbidden-proof gate should reject executable proof closures, not the
    documentation that explains the policy or the string-valued policy table in
    `Core.lean`.
    """

    result: list[str] = []
    index = 0
    block_depth = 0
    in_string = False
    in_line_comment = False
    while index < len(text):
        char = text[index]
        nxt = text[index + 1] if index + 1 < len(text) else ""

        if in_line_comment:
            if char == "\n":
                in_line_comment = False
                result.append("\n")
            else:
                result.append(" ")
            index += 1
            continue

        if block_depth > 0:
            if char == "/" and nxt == "-":
                block_depth += 1
                result.extend("  ")
                index += 2
                continue
            if char == "-" and nxt == "/":
                block_depth -= 1
                result.extend("  ")
                index += 2
                continue
            result.append("\n" if char == "\n" else " ")
            index += 1
            continue

        if in_string:
            if char == "\\" and nxt:
                result.extend("  ")
                index += 2
                continue
            if char == '"':
                in_string = False
            result.append("\n" if char == "\n" else " ")
            index += 1
            continue

        if char == "-" and nxt == "-":
            in_line_comment = True
            result.extend("  ")
            index += 2
            continue
        if char == "/" and nxt == "-":
            block_depth = 1
            result.extend("  ")
            index += 2
            continue
        if char == '"':
            in_string = True
            result.append(" ")
            index += 1
            continue

        result.append(char)
        index += 1

    return "".join(result)


def forbidden_pattern_hits() -> list[str]:
    hits = []
    for path in lean_source_files():
        if not path.exists():
            continue
        stripped = strip_lean_comments_and_strings(read_text(path))
        for lineno, line in enumerate(stripped.splitlines(), start=1):
            if FORBIDDEN_REGEX.search(line):
                hits.append(f"{rel(path)}:{lineno}:{line.strip()}")
    return hits


def lean_source_files() -> list[Path]:
    files = [
        *ROOT.glob("AutoSamplingTheory/**/*.lean"),
        *ROOT.glob("Tests/**/*.lean"),
        ROOT / "AutoSamplingTheory.lean",
        ROOT / "Tests.lean",
    ]
    return sorted({path for path in files if path.exists()})


def lean_diagnostics() -> dict:
    """Report lightweight Lean proof diagnostics for reviewer handoffs."""

    per_file = []
    totals: dict[str, int] = {
        "files": 0,
        "theorem": 0,
        "lemma": 0,
        "def": 0,
        "instance": 0,
        "structure": 0,
        "class": 0,
        "inductive": 0,
        "forbidden_hits": 0,
    }
    for path in lean_source_files():
        stripped = strip_lean_comments_and_strings(read_text(path))
        counts = {key: 0 for key in totals if key not in {"files", "forbidden_hits"}}
        for match in LEAN_DECL_REGEX.finditer(stripped):
            counts[match.group(1)] += 1
        forbidden = []
        for lineno, line in enumerate(stripped.splitlines(), start=1):
            if FORBIDDEN_REGEX.search(line):
                forbidden.append({"line": lineno, "text": line.strip()})
        totals["files"] += 1
        totals["forbidden_hits"] += len(forbidden)
        for key, value in counts.items():
            totals[key] += value
        per_file.append({"file": rel(path), "declarations": counts, "forbidden": forbidden})
    return {
        "mathcode_reference": MATHCODE_URL,
        "mathcode_local_reference": str(MATHCODE_LOCAL_REFERENCE),
        "mathcode_local_reference_exists": MATHCODE_LOCAL_REFERENCE.exists(),
        "policy": "diagnostics are advisory; lake build and forbidden-pattern gate remain mandatory",
        "totals": totals,
        "files": per_file,
    }


def read_text(path: Path) -> str:
    return path.read_text(encoding="utf-8")


def write_if_missing(path: Path, text: str) -> bool:
    if path.exists():
        return False
    path.parent.mkdir(parents=True, exist_ok=True)
    path.write_text(text, encoding="utf-8")
    print(f"initialized {rel(path)}")
    return True


def write_new(path: Path, text: str) -> None:
    if path.exists():
        raise SystemExit(f"refusing to overwrite existing file: {rel(path)}")
    path.parent.mkdir(parents=True, exist_ok=True)
    path.write_text(text, encoding="utf-8")
    print(f"wrote {rel(path)}")


def write_text(path: Path, text: str) -> None:
    path.parent.mkdir(parents=True, exist_ok=True)
    path.write_text(text, encoding="utf-8")
    print(f"wrote {rel(path)}")


def append_line(path: Path, line: str) -> None:
    path.parent.mkdir(parents=True, exist_ok=True)
    with path.open("a", encoding="utf-8") as handle:
        handle.write(line + "\n")


def append_jsonl(path: Path, record: dict) -> None:
    path.parent.mkdir(parents=True, exist_ok=True)
    with path.open("a", encoding="utf-8") as handle:
        handle.write(json.dumps(record, sort_keys=True, ensure_ascii=False) + "\n")


def load_jsonl(path: Path) -> list[dict]:
    if not path.exists():
        return []
    records = []
    for line in path.read_text(encoding="utf-8").splitlines():
        if not line.strip():
            continue
        records.append(json.loads(line))
    return records


def load_state() -> dict:
    if not STATE_FILE.exists():
        return {"version": 1, "active_task": "ASTIS-SALD-001", "last_check": None}
    return json.loads(read_text(STATE_FILE))


def save_state(state: dict) -> None:
    STATE_DIR.mkdir(parents=True, exist_ok=True)
    STATE_FILE.write_text(json.dumps(state, indent=2, sort_keys=True) + "\n", encoding="utf-8")


def ensure_manifest() -> None:
    write_if_missing(
        MANIFEST,
        """# ASTIS Output Manifest

| Timestamp | Tool | File | Stage | Description |
|---|---|---|---|---|
""",
    )


def add_manifest(tool: str, file: Path, stage: str, description: str) -> None:
    ensure_manifest()
    append_line(MANIFEST, f"| {now_stamp()} | {tool} | `{rel(file)}` | {stage} | {description} |")


def init_texts() -> dict[Path, str]:
    return {
        ROOT / "research-wiki" / "index.md": "# ASTIS Research Wiki\n",
        ROOT / "research-wiki" / "query_pack.md": (
            "# Query Pack\n\n"
            "- Active task: ASTIS-SALD-001\n"
            "- Gate: `python3 tools/astis.py check`\n"
            "- SLT reference: `/home/nitanda_sub/mark/repos/RMFLD/lean-stat-learning-theory`\n"
            f"- LeanMarathon reference: `{LEANMARATHON_ROOT}`\n"
            f"- MathCode workflow reference: `{MATHCODE_URL}`\n"
        ),
        ROOT / "paper-notes" / "README.md": (
            "# Paper Notes\n\n"
            "Human-readable proof exports and source-to-Lean notes.\n"
        ),
    }


def cmd_init(_: argparse.Namespace) -> int:
    for dirname in WORK_DIRS:
        (ROOT / dirname).mkdir(parents=True, exist_ok=True)
    for path, text in init_texts().items():
        write_if_missing(path, text)
    ensure_manifest()
    state = load_state()
    state.setdefault("version", 1)
    state.setdefault("active_task", "ASTIS-SALD-001")
    state["initialized_at"] = state.get("initialized_at") or now_stamp()
    save_state(state)
    add_manifest("astis.py init", ROOT / "ASTIS.md", "init", "Initialized ASTIS workflow state")
    return 0


def cmd_check(_: argparse.Namespace) -> int:
    if not (ROOT / "lake-manifest.json").exists():
        code = run(["lake", "update"])
        if code != 0:
            return code
    code = run(["lake", "exe", "cache", "get"])
    if code != 0:
        return code
    code = run(["lake", "build"])
    if code != 0:
        return code
    code = run(["lake", "build", "Tests"])
    if code != 0:
        return code
    hits = forbidden_pattern_hits()
    if hits:
        print("\n".join(hits))
        return 1
    state = load_state()
    state["last_check"] = {"timestamp": now_stamp(), "exit_code": 0}
    save_state(state)
    print("ASTIS check passed")
    return 0


def parse_literature() -> list[dict[str, str]]:
    source = read_text(ROOT / "AutoSamplingTheory" / "Literature.lean")
    blocks = re.findall(r"\{\s*key := .*?\n\s*\}", source, flags=re.S)
    entries = []
    for block in blocks:
        item: dict[str, str] = {}
        for field in ["key", "title", "authors", "targetFile", "urlOrPath", "note"]:
            match = re.search(field + r' := "([^"]*)"', block)
            if match:
                item[field] = match.group(1)
        status_match = re.search(r"status := ImplementationStatus\.([A-Za-z]+)", block)
        mode_match = re.search(r"mode := PaperMode\.([A-Za-z]+)", block)
        if status_match:
            item["status"] = status_match.group(1)
        if mode_match:
            item["mode"] = mode_match.group(1)
        if "key" in item:
            entries.append(item)
    return entries


def cmd_list_literature(_: argparse.Namespace) -> int:
    for item in parse_literature():
        print(
            f"{item.get('status','unknown'):14s} "
            f"{item.get('mode','unknown'):18s} "
            f"{item.get('key')} :: {item.get('title')}"
        )
    return 0


def task_files() -> list[Path]:
    return sorted((ROOT / "tasks").glob("*.md"))


def read_task_status(path: Path) -> str:
    text = read_text(path)
    match = re.search(r"^Status:\s*`?([^`\n]+)`?", text, flags=re.M)
    return match.group(1).strip() if match else "unknown"


def task_context(task_id: str) -> tuple[str, str]:
    path = ROOT / "tasks" / f"{slugify(task_id)}.md"
    if path.exists():
        text = read_text(path)
        return text.splitlines()[0].lstrip("# ").strip(), text
    raise SystemExit(f"task not found: {task_id}")


def cmd_next_task(_: argparse.Namespace) -> int:
    candidates = []
    for path in task_files():
        if path.name == "README.md":
            continue
        status = read_task_status(path)
        if status in {"active", "planned"}:
            priority = 0 if status == "active" else 1
            candidates.append((priority, path))
    if not candidates:
        print("no active or planned tasks")
        return 0
    path = sorted(candidates, key=lambda item: (item[0], item[1].name))[0][1]
    print(f"{path.stem}: {read_text(path).splitlines()[0].lstrip('# ').strip()}")
    print(f"path: {rel(path)}")
    return 0


def cmd_list_tasks(_: argparse.Namespace) -> int:
    priority = {"active": 0, "planned": 1, "indexed": 2, "blocked": 3}
    paths = [path for path in task_files() if path.name != "README.md"]
    for path in sorted(paths, key=lambda item: (priority.get(read_task_status(item), 9), item.name)):
        print(f"{read_task_status(path):12s} {path.stem:18s} {read_text(path).splitlines()[0].lstrip('# ').strip()}")
    return 0


def source_roots_for_task(task_id: str) -> tuple[Path, list[str], Path]:
    if task_id == "ASTIS-SALD-001":
        return SALD_ROOT, ["sald_version_2.tex"], ROOT / "research-wiki" / "source-index" / "SALD_original.jsonl"
    if task_id == "ASTIS-RMFLD-001":
        return RMFLD_ROOT, [], ROOT / "research-wiki" / "source-index" / "RMFLD_paper.jsonl"
    raise SystemExit(f"no source-index configuration for task: {task_id}")


ENV_RE = re.compile(
    r"\\begin\{(?P<kind>theorem|lemma|proposition|prop|corollary|definition|defn|assumption|ass|thm|equation\*?|align\*?|alignat\*?|gather\*?|multline\*?)\}"
    r"(?:\[(?P<title>[^\]]*)\])?"
)
LABEL_RE = re.compile(r"\\label\{(?P<label>[^}]+)\}")


def index_tex_file(path: Path, root: Path) -> list[dict]:
    records = []
    current: dict | None = None
    current_env: str | None = None
    for lineno, line in enumerate(path.read_text(encoding="utf-8", errors="ignore").splitlines(), start=1):
        if line.lstrip().startswith("%"):
            continue
        env = ENV_RE.search(line)
        if env:
            current_env = env.group("kind")
            current = {
                "kind": current_env,
                "title": env.group("title") or "",
                "file": str(path.relative_to(root)),
                "line": lineno,
                "label": "",
                "snippet": line.strip()[:240],
            }
            label = LABEL_RE.search(line)
            if label:
                current["label"] = label.group("label")
                records.append(current)
                current = None
                current_env = None
            continue
        if current is not None:
            label = LABEL_RE.search(line)
            if label:
                current["label"] = label.group("label")
                records.append(current)
                current = None
                current_env = None
                continue
            if current_env and re.search(rf"\\end\{{{re.escape(current_env)}\}}", line):
                current = None
                current_env = None
    return records


def cmd_source_index(args: argparse.Namespace) -> int:
    cmd_init(argparse.Namespace())
    source_root, excluded, output = source_roots_for_task(args.task)
    if not source_root.exists():
        raise SystemExit(f"source root not found: {source_root}")
    records = []
    for path in sorted(source_root.glob("*.tex")):
        if path.name in excluded:
            continue
        records.extend(index_tex_file(path, source_root))
    output.parent.mkdir(parents=True, exist_ok=True)
    with output.open("w", encoding="utf-8") as handle:
        for record in records:
            handle.write(json.dumps(record, sort_keys=True, ensure_ascii=False) + "\n")
    add_manifest("astis.py source-index", output, "source-index", f"Indexed {len(records)} source declarations for {args.task}")
    print(f"indexed {len(records)} declarations -> {rel(output)}")
    if args.task == "ASTIS-SALD-001" and any(record["file"] == "sald_version_2.tex" for record in records):
        raise SystemExit("sald_version_2.tex was indexed despite exclusion")
    return 0


def compact_inline_text(value: str, max_chars: int = 420) -> str:
    value = re.sub(r"\s+", " ", value or "").strip()
    if len(value) <= max_chars:
        return value
    return value[: max_chars - 3].rstrip() + "..."


def trial_records_for_task(task_id: str) -> list[dict]:
    records = []
    for record in load_jsonl(TRIAL_LOG):
        if record.get("task_id") != task_id:
            continue
        artifact = record.get("artifact", "")
        artifact_path = ROOT / artifact if artifact else None
        if artifact.startswith("runs/") and "cycle" in artifact and artifact_path and not artifact_path.exists():
            continue
        records.append(record)
    return records


def recent_trial_text(task_id: str, limit: int = 4, max_note_chars: int = 420) -> str:
    records = trial_records_for_task(task_id)
    if not records:
        return "no trial records yet"
    lines = []
    for record in records[-limit:]:
        lines.append(
            "{timestamp} {role}/{kind} {status} gate={lean_gate} :: {notes}".format(
                timestamp=record.get("timestamp", ""),
                role=record.get("role", ""),
                kind=record.get("kind", ""),
                status=record.get("status", ""),
                lean_gate=record.get("lean_gate", ""),
                notes=compact_inline_text(record.get("notes", ""), max_note_chars),
            )
        )
    return "\n".join(lines)


def latest_handoff_notes(task_id: str, limit: int = 6) -> list[str]:
    notes = []
    for record in reversed(trial_records_for_task(task_id)):
        if record.get("kind") != "handoff":
            continue
        note = compact_inline_text(record.get("notes", ""), 520)
        if note:
            notes.append(note)
        if len(notes) >= limit:
            break
    return list(reversed(notes))


def classification_counts_in_text(text: str) -> dict[str, int]:
    return {name: len(re.findall(re.escape(name), text)) for name in PACKET_CLASSIFICATIONS}


def classification_counts_in_trials(task_id: str, cycles: list[int] | None = None) -> dict[str, int]:
    allowed_cycles = set(cycles or [])
    counts = {name: 0 for name in PACKET_CLASSIFICATIONS}
    for record in trial_records_for_task(task_id):
        note = record.get("notes", "")
        cycle = cycle_number_from_record(record)
        if allowed_cycles and (cycle is None or cycle not in allowed_cycles):
            continue
        for name in PACKET_CLASSIFICATIONS:
            if name in note:
                counts[name] += 1
    return counts


def extract_remaining_boundary(note: str) -> str:
    note = compact_inline_text(note, 1100)
    marker = re.search(
        r"((?:Remaining exact blocker|Remaining exact boundary|Remaining blockers?|Remaining boundary).*?)(?:\. No fake|; no |$)",
        note,
        flags=re.I,
    )
    return marker.group(1).strip() if marker else note


def cycle_number_from_record(record: dict) -> int | None:
    fields = [
        record.get("trial_id", ""),
        record.get("artifact", ""),
        record.get("notes", ""),
    ]
    for value in fields:
        match = re.search(r"(?:cycle|Cycle)\s*-?(\d+)", value)
        if match:
            return int(match.group(1))
    return None


def latest_trial_cycle(task_id: str) -> int:
    latest = 0
    for record in trial_records_for_task(task_id):
        cycle = cycle_number_from_record(record)
        if cycle is not None:
            latest = max(latest, cycle)
    return latest


def proof_status_counts() -> dict[str, int]:
    counts = {status: 0 for status in ["planned", "sourceCited", "contractOnly", "obligation", "formalized", "blocked"]}
    for path in lean_source_files():
        text = strip_lean_comments_and_strings(read_text(path))
        for match in re.finditer(r"ProofStatus\.([A-Za-z]+)", text):
            status = match.group(1)
            counts[status] = counts.get(status, 0) + 1
    return counts


def latest_matching_note(task_id: str, patterns: list[str]) -> str:
    compiled = [re.compile(pattern, flags=re.I) for pattern in patterns]
    for record in reversed(trial_records_for_task(task_id)):
        note = record.get("notes", "")
        if any(pattern.search(note) for pattern in compiled):
            return extract_remaining_boundary(note)
    return ""


def latest_reviewer_blocker(task_id: str) -> str:
    for record in reversed(trial_records_for_task(task_id)):
        if record.get("role") != "reviewer" or record.get("kind") != "handoff":
            continue
        note = compact_inline_text(record.get("notes", ""), 1100)
        remaining = extract_remaining_boundary(note)
        if remaining != note:
            return remaining
        if "Remaining" in note:
            return note
    if task_id == "ASTIS-SALD-001":
        return (
            "Remaining exact boundary: prove the concrete contraction bound, "
            "align `weakGradPairing`/`driftDiv` with the `hatRhoS` law integral, "
            "and prove the no-boundary IBP theorem for `hatRhoS * barB`."
        )
    return "No reviewer blocker recorded yet; use source index and proof-obligation ledger."


def blueprint_control_state(task_id: str) -> dict:
    latest_cycle = latest_trial_cycle(task_id)
    recent_cycles = list(range(max(1, latest_cycle - 5), latest_cycle + 1)) if latest_cycle else []
    latest_blocker = latest_reviewer_blocker(task_id)
    dynamic_leaf = latest_blocker or latest_matching_note(task_id, [
        r"next non-wrapper blocker",
        r"first non-wrapper blocker",
        r"Remaining exact blocker",
        r"remaining .* blocker",
        r"hbarBStateSetIntegral",
        r"dynamic leaf",
    ])
    illness_area = latest_matching_note(task_id, [
        r"illness area",
        r"affected region",
        r"state-event",
        r"box-trace",
        r"appendix\.tex:1368-1377",
        r"appendix\.tex:1379-1387",
        r"appendix\.tex:1358-1366",
    ]) or dynamic_leaf
    if task_id == "ASTIS-SALD-001":
        system_of_record = [
            "AutoSamplingTheory/SALD.lean",
            "conversion-windows/ASTIS-SALD-001.md",
            "proof-obligations/ASTIS-SALD-001.md",
            "research-wiki/source-index/SALD_original.jsonl",
            "research-wiki/cited-results/SLT_reuse_audit.md",
            "runs/trials.jsonl",
        ]
        stage = "LeanMarathon Stage-2 analogue: DAG-guided proof discharge after faithful source transcript stabilization"
    else:
        system_of_record = [
            "AutoSamplingTheory/RMFLD.lean",
            "research-wiki/source-index/RMFLD_paper.jsonl",
            "runs/trials.jsonl",
        ]
        stage = "exploratoryProof blueprint construction"
    return {
        "task_id": task_id,
        "generated": now_stamp(),
        "latest_cycle": latest_cycle,
        "recent_cycles": recent_cycles,
        "system_of_record": system_of_record,
        "stage": stage,
        "dynamic_leaf_candidate": dynamic_leaf,
        "illness_area_candidate": illness_area,
        "latest_blocker": latest_blocker,
        "trial_classifications_recent": classification_counts_in_trials(task_id, recent_cycles),
        "proof_status_counts": proof_status_counts(),
        "leanmarathon_controls_absorbed": [
            "blueprint/system-of-record control state",
            "target-review no-more/no-less discipline",
            "dynamic-leaf proof discharge instead of broad route replay",
            "illness-area refiner rule for connected blocker regions",
            "deterministic CI gate as the only progress authority",
            "local refinement region before asking for upstream changes",
        ],
        "astis_kept_advantages": [
            "EoH-style candidate populations for exploratoryProof mode after a Lean-checkable target is fixed",
            "Learning-beyond-gradients style trial memory through logs, summaries, rejected directions, and negative cache",
            "upper/middle/lower/reviewer agent stack inherited from the ARIS/LBG/QBE automation lineage",
            "auto-research-in-sleep long-window self-loop with graceful final-cycle completion",
            "plain-file reproducibility without requiring GitHub PR or Slurm for local research iteration",
            "sampling/SDE-specific source anchors, proof obligations, and SLT reuse audit",
        ],
        "references": {
            "EoH": EOH_URL,
            "Learning beyond gradients": LBG_URL,
            "Auto-research-in-sleep": ARIS_URL,
            "LeanMarathon": LEANMARATHON_URL,
            "LeanMarathon paper": LEANMARATHON_ARXIV_URL,
            "local LeanMarathon repo": str(LEANMARATHON_ROOT),
            "local LeanMarathon pdf": str(LEANMARATHON_PDF),
        },
    }


def blueprint_status_text(state: dict) -> str:
    controls = "\n".join(f"- {item}" for item in state["leanmarathon_controls_absorbed"])
    kept = "\n".join(f"- {item}" for item in state["astis_kept_advantages"])
    record = "\n".join(f"- `{item}`" for item in state["system_of_record"])
    class_lines = "\n".join(
        f"- `{key}`: {value}" for key, value in state["trial_classifications_recent"].items()
    )
    status_lines = "\n".join(
        f"- `{key}`: {value}" for key, value in sorted(state["proof_status_counts"].items())
    )
    refs = "\n".join(f"- {key}: {value}" for key, value in state["references"].items())
    return "\n".join([
        "# ASTIS Blueprint Control State",
        "",
        f"- Task: `{state['task_id']}`",
        f"- Generated: `{state['generated']}`",
        f"- Latest cycle: `{state['latest_cycle']}`",
        f"- Stage: {state['stage']}",
        "",
        "## System Of Record",
        "",
        record,
        "",
        "## Dynamic Leaf Candidate",
        "",
        state["dynamic_leaf_candidate"],
        "",
        "## Illness Area Candidate",
        "",
        state["illness_area_candidate"],
        "",
        "## Latest Blocker",
        "",
        state["latest_blocker"],
        "",
        "## Recent Packet Classifications",
        "",
        class_lines,
        "",
        "## Proof Status Counts",
        "",
        status_lines,
        "",
        "## LeanMarathon Controls Absorbed",
        "",
        controls,
        "",
        "## ASTIS Advantages Preserved",
        "",
        kept,
        "",
        "## References",
        "",
        refs,
        "",
        "## Next-Cycle Discipline",
        "",
        "- Upper must select either the dynamic leaf candidate or a named refiner illness area.",
        "- Middle must translate only that local region into lower-ready Lean declarations.",
        "- Lower must work inside that local target/refinement region before asking for upstream changes.",
        "- Reviewer treats `python3 tools/astis.py check` as the deterministic merge/progress gate and rejects broad replay.",
    ]) + "\n"


def write_blueprint_status(task_id: str, output: Path | None = None) -> tuple[Path, Path]:
    state = blueprint_control_state(task_id)
    base = output or BLUEPRINT_DIR / f"{slugify(task_id)}-blueprint-status.md"
    md_path = base if base.suffix == ".md" else base.with_suffix(".md")
    json_path = md_path.with_suffix(".json")
    write_text(md_path, blueprint_status_text(state))
    write_text(json_path, json.dumps(state, indent=2, sort_keys=True, ensure_ascii=False) + "\n")
    add_manifest("astis.py blueprint-status", md_path, "blueprint", f"Wrote blueprint control state for {task_id}")
    return md_path, json_path


def compact_file_lines(path: Path, patterns: list[str], limit: int = 24) -> list[str]:
    if not path.exists():
        return []
    regexes = [re.compile(pattern, re.IGNORECASE) for pattern in patterns]
    rows = []
    for line in read_text(path).splitlines():
        stripped = line.strip()
        if stripped and any(regex.search(stripped) for regex in regexes):
            rows.append(compact_inline_text(stripped, max_chars=360))
    return rows[-limit:]


def task_relevant_lean_declarations(task_id: str, limit: int = 60) -> list[dict]:
    if task_id == "ASTIS-SALD-001":
        files = [
            ROOT / "AutoSamplingTheory" / "SALD.lean",
            ROOT / "AutoSamplingTheory" / "SDE.lean",
            ROOT / "AutoSamplingTheory" / "Probability.lean",
            ROOT / "AutoSamplingTheory" / "Core.lean",
        ]
    elif task_id == "ASTIS-RMFLD-001":
        files = [
            ROOT / "AutoSamplingTheory" / "RMFLD.lean",
            ROOT / "AutoSamplingTheory" / "SDE.lean",
            ROOT / "AutoSamplingTheory" / "Probability.lean",
            ROOT / "AutoSamplingTheory" / "Core.lean",
        ]
    else:
        files = lean_source_files()
    rows = []
    for path in files:
        if not path.exists():
            continue
        for lineno, line in enumerate(read_text(path).splitlines(), start=1):
            match = LEAN_DECL_NAME_REGEX.match(line)
            if not match:
                continue
            rows.append({
                "kind": match.group(1),
                "name": match.group(2),
                "file": f"{rel(path)}:{lineno}",
            })
    return rows[-limit:]


def blueprint_refresh_text(task_id: str) -> str:
    title, task_text = task_context(task_id)
    state = blueprint_control_state(task_id)
    status_md = BLUEPRINT_DIR / f"{slugify(task_id)}-blueprint-status.md"
    obligation_path = ROOT / "proof-obligations" / f"{task_id}.md"
    conversion_path = ROOT / "conversion-windows" / f"{task_id}.md"
    source_index_path = (
        ROOT / "research-wiki" / "source-index" / "SALD_original.jsonl"
        if task_id == "ASTIS-SALD-001"
        else ROOT / "research-wiki" / "source-index" / "RMFLD_paper.jsonl"
    )
    directive = "\n".join([
        f"Mode: `{task_id}` follows `{state['stage']}`.",
        f"Current dynamic leaf: {state['dynamic_leaf_candidate']}",
        f"Current illness area: {state['illness_area_candidate']}",
        "Upper/middle must retire stale leaves before assigning lower work.",
        "Lower work should be one local Lean declaration/proof boundary at a time.",
        "Reviewer accepts progress only through `python3 tools/astis.py check` plus source correspondence.",
    ])
    handoffs = latest_handoff_notes(task_id, limit=8)
    leaves = [
        state["dynamic_leaf_candidate"],
        state["illness_area_candidate"],
        *handoffs,
    ]
    seen_leaves = []
    for leaf in leaves:
        clean = compact_inline_text(str(leaf), max_chars=520)
        if clean and clean not in seen_leaves:
            seen_leaves.append(clean)
    obligation_rows = compact_file_lines(
        obligation_path,
        [
            r"obligation",
            r"unproved",
            r"source",
            r"conditional",
            r"Bochner",
            r"set-integral",
            r"hbarB",
            r"barB",
        ],
        limit=28,
    )
    artifact_candidates = [
        ROOT / item for item in state["system_of_record"]
    ] + [
        status_md,
        conversion_path,
        obligation_path,
        source_index_path,
        ROOT / "paper-notes" / "AutoLeanInSleepSampling" / "markdown" / "status.md",
        ROOT / "paper-notes" / "AutoLeanInSleepSampling" / "latex" / "sections" / "00_overview.tex",
        ROOT / "docs" / "leanmarathon_reference_notes.md",
        ROOT / "docs" / "self_reflection_and_efficiency.md",
    ]
    artifacts = []
    for path in artifact_candidates:
        if path.exists() and path not in artifacts:
            artifacts.append(path)
    class_lines = "\n".join(
        f"- `{key}`: {value}" for key, value in state["trial_classifications_recent"].items()
    )
    status_lines = "\n".join(
        f"- `{key}`: {value}" for key, value in sorted(state["proof_status_counts"].items())
    )
    leaf_rows = "\n".join(f"| {leaf.replace('|', '/')} | candidate |" for leaf in seen_leaves)
    if not leaf_rows:
        leaf_rows = "| none detected | upper must refresh the task directive |"
    obligation_text = "\n".join(obligation_rows) if obligation_rows else "no compact obligation signals found"
    declaration_rows = "\n".join(
        f"| {row['kind']} | `{row['name']}` | `{row['file']}` |"
        for row in task_relevant_lean_declarations(task_id)
    )
    if not declaration_rows:
        declaration_rows = "| none | no task-relevant declaration found | n/a |"
    artifact_rows = "\n".join(f"| `{rel(path)}` | correspondence/system-of-record |" for path in artifacts)
    source_excerpt = compact_inline_text(task_text, max_chars=1200)
    return f"""# ASTIS Proof Blueprint: {task_id}

Task id: `{task_id}`
Title: {title}
Updated: `{now_stamp()}`
Blueprint stage: `{state['stage']}`

This is ASTIS's compact system-of-record snapshot for long-horizon Lean proof
automation.  It follows the LeanMarathon/QBE blueprint lesson, but the
correspondence surface is SDE/Sampling-specific: Lean declarations,
source-paper labels, proof obligations, SLT/SDE cited-result reuse, and
Lean-Markdown-LaTeX exports must stay synchronized.

## Current Directive

```text
{directive}
```

## Dynamic Leaf Queue

Lower agents should work on one item at a time.  If a leaf is stale, upper or
middle must retire it before spending more proof-search tokens.

| Leaf | Status |
|---|---|
{leaf_rows}

## Open Obligation Signals

```text
{obligation_text}
```

## Recent Packet Classifications

{class_lines}

## Proof Status Counts

{status_lines}

## Lean Declaration Index

| Kind | Lean name | File |
|---|---|---|
{declaration_rows}

## Correspondence Artifacts

| Artifact | Role |
|---|---|
{artifact_rows}

## Source Contract Excerpt

```text
{source_excerpt}
```

## Gate Policy

- Faithful paper mode may not weaken the SALD statement to close a Lean goal.
- Stage 1 target/source review remains active when notation or hypotheses move.
- Stage 2 proof discharge assigns lower workers to dynamic leaves only.
- Refiner work should repair one connected illness area instead of stacking
  unrelated wrapper lemmas.
- Lean plus explicit source correspondence is the gate; agent self-assessment is
  not proof progress.

## External References

- LeanMarathon: {LEANMARATHON_URL}
- LeanMarathon article: {LEANMARATHON_ARXIV_URL}
- Shared local LeanMarathon repo: `{LEANMARATHON_ROOT}`
- Shared local LeanMarathon PDF: `{LEANMARATHON_PDF}`
"""


def write_blueprint_refresh(task_id: str, output: Path | None = None) -> Path:
    write_blueprint_status(task_id)
    path = output or BLUEPRINT_DIR / f"{slugify(task_id)}.md"
    write_text(path, blueprint_refresh_text(task_id))
    add_manifest("astis.py blueprint-refresh", path, "blueprint", f"Refreshed proof blueprint for {task_id}")
    return path


def blueprint_context_snippet(task_id: str) -> str:
    state = blueprint_control_state(task_id)
    return "\n".join([
        f"- Stage: {state['stage']}",
        f"- Latest cycle: {state['latest_cycle']}",
        f"- Dynamic leaf candidate: {state['dynamic_leaf_candidate']}",
        f"- Illness area candidate: {state['illness_area_candidate']}",
        f"- Task blueprint: `research-wiki/blueprints/{slugify(task_id)}.md`.",
        "- Borrowed LeanMarathon controls: blueprint system-of-record, target review, dynamic leaves, illness-area refiner, deterministic gate.",
        "- Preserved ASTIS controls: EoH candidate populations for exploratoryProof, LBG-style trial memory, ARIS/QBE upper-middle-lower-reviewer loops, auto-research-in-sleep long run, SDE/Sampling source anchors.",
    ])


def slt_reference_pack() -> str:
    exists_note = "exists" if SLT_ROOT.exists() else "missing"
    article_note = "exists" if SLT_ARTICLE_ROOT.exists() else "missing"
    return "\n".join([
        f"- SLT local project ({exists_note}): `{SLT_ROOT}`.",
        f"- SLT paper source ({article_note}): `{SLT_ARTICLE_ROOT}`.",
        "- First consult `SLT/EfronStein.lean` for conditional expectation/product-measure proof engineering.",
        "- Consult `SLT/GaussianLSI/TensorizedGLSI.lean`, `SLT/GaussianMeasure.lean`, and `SLT/SmallBallProb.lean` for `Measure.map`, integral, product, and Bochner-style rewrites.",
        "- Consult the SLT article LaTeX for the writing principle: expose measurable/topological hypotheses explicitly; do not promote background analysis until a local ASTIS declaration compiles.",
        "- Do not add SLT as a Lake dependency while the toolchain mismatch remains; port local statements or record cited proof obligations.",
    ])


def external_lookup_discipline() -> str:
    return (
        "External lookup discipline: upper and middle may use network search when "
        "local context is insufficient for Mathlib names, Lean API examples, or "
        "standard SDE/measure-theory statements such as weak Fokker-Planck, "
        "Green identities, trace theorems, or divergence theorems. Prefer primary "
        "sources: Mathlib docs/source, Lean project repositories, arXiv papers, "
        "or official project documentation. Any external result must be converted "
        "into a local ASTIS compiled declaration or a precise source-cited "
        "ProofObligation; do not mark it formalized just because it was found "
        "online."
    )


def compact_task_context(task_id: str, title: str, task_text: str, cycle: int) -> str:
    if task_id != "ASTIS-SALD-001" or cycle < SALD_COMPACT_CONTEXT_START_CYCLE:
        return task_text.strip()
    return "\n".join([
        f"# {title}",
        "",
        "Status: active faithfulPaper reproduction of the original VA-SALD paper.",
        "Source: `/home/nitanda_sub/mark/repos/sald/paper`; exclude `sald_version_2.tex`.",
        "Current phase: Phase 1 faithful transcript and proof backfill; Phase 2 API reorganization is deferred.",
        "",
        "Current post-cycle-84 rule: do not add broad wrappers or broad theorem-route audits. Each cycle must either discharge one supplied hypothesis, strictly narrow one source-cited theorem boundary, or explicitly reject wrapper churn.",
        "",
        "Active blocker:",
        latest_reviewer_blocker(task_id),
        "",
        "Allowed packet classifications:",
        "- `discharges-supplied-hypothesis`: compiled local theorem removes an older supplied hypothesis.",
        "- `narrows-source-cited-boundary`: exact missing theorem is smaller and source-cited with imports/hypotheses.",
        "- `rejected-wrapper-churn`: proposed work only restates a supplied hypothesis or broad ledger.",
    ])


def build_context_pack(task_id: str, title: str, task_text: str, cycle: int) -> str:
    trial_memory = "\n".join(f"- {note}" for note in latest_handoff_notes(task_id, limit=6))
    if not trial_memory:
        trial_memory = "- no handoff memory yet"
    return "\n".join([
        "# ASTIS Compact Context Pack",
        "",
        f"- Task: `{task_id}`",
        f"- Cycle: `{cycle}`",
        f"- Generated: `{now_stamp()}`",
        "",
        "## Compact Task Contract",
        "",
        compact_task_context(task_id, title, task_text, cycle),
        "",
        "## Cycle Focus",
        "",
        sald_cycle_focus(cycle) if task_id == "ASTIS-SALD-001" else "Follow the task contract and current conversion window.",
        "",
        "## Recent High-Signal Handoffs",
        "",
        trial_memory,
        "",
        "## Local SLT And Paper Reuse",
        "",
        slt_reference_pack(),
        "",
        "## Blueprint Control State",
        "",
        blueprint_context_snippet(task_id),
        "",
        "## Self-Reflection Guard",
        "",
        "- Start the handoff with one packet classification from the allowed list.",
        "- Name the exact supplied hypothesis discharged or the exact missing theorem boundary narrowed.",
        "- State whether the packet is a dynamic-leaf worker packet or an illness-area refiner packet.",
        "- State which local SLT/Mathlib files were consulted or why no consultation was needed.",
        "- Reject broad source-index, route-audit, wrapper, or project-article work unless it directly closes the active blocker.",
        "- Keep `python3 tools/astis.py check` as the mandatory gate.",
    ])


def write_context_pack(task_id: str, cycle: int, output: Path | None = None) -> Path:
    title, task_text = task_context(task_id)
    path = output or CONTEXT_PACK_DIR / f"{slugify(task_id)}-cycle{cycle:03d}.md"
    write_text(path, build_context_pack(task_id, title, task_text, cycle))
    add_manifest("astis.py write-context-pack", path, "context", f"Wrote compact context pack for {task_id} cycle {cycle}")
    return path


def sald_cycle_focus(cycle: int) -> str:
    if cycle >= 174:
        return (
            "Post-cycle-173 source-Hessian leaf: stay on "
            "`sald.general_moving_target_discrete.em_interpolation_fp` and discharge or strictly narrow the two "
            "source-facing selected weak-test Hessian fields left by "
            "`SALD.selectedWeakTestHessianOpNormOfSourceHessianField`: "
            "`hSourceHasHessian : forall z, HasFDerivAt (fderiv Real sourceTest) (sourceHessian z) z` and "
            "`hSourceHessianBound : forall z, norm (sourceHessian z) <= C1`. "
            "Upper/middle must first decide whether these fields are genuine source assumptions or derivable from "
            "the selected-test regularity used by the EM Brownian/Ito weak action. "
            "If derivable, lower_1 writes the natural-language Mathlib route and lower_2 implements exactly one "
            "compiled theorem. If not derivable from the paper source, record the gap honestly and move to the next "
            "real leaf in the same Brownian/Ito chain: selected-line Taylor domination, Gaussian DCT integrability, "
            "quadratic-variation normalization, or per-coordinate Hessian generator identity. "
            "Do not return to older `htraceFieldEqLaplacian`/consumer-wrapper targets unless this Hessian leaf is "
            "closed or reviewer records a strict dependency."
        )
    if cycle >= 114:
        return (
            "Blueprint-guided dynamic leaf: use `python3 tools/astis.py blueprint-refresh ASTIS-SALD-001` "
            "and target the refreshed dynamic leaf / illness area rather than the old rotating focus. "
            f"Current blocker: {latest_reviewer_blocker('ASTIS-SALD-001')}. "
            "For the current SALD state this means stay on the EM conditional-drift/state-event set-integral boundary "
            "unless reviewer records a named Mathlib/theory gap; do not take a non-EM fallback merely because the old cycle schedule rotates there."
        )
    backend_proof_closure_start_cycle = 85
    if cycle >= backend_proof_closure_start_cycle:
        focus = [
            (
                "Post-84 closure 1: conditional-kernel theorem boundary",
                "Stop adding supplied-hypothesis wrappers.  Target the smallest real backend behind `appendix.tex:1368-1377`: Mathlib `condDistrib`/`condExpKernel` orientation for `X_k^eta | hat X_s`, named `hat rho_s` marginal, and component conditional-integral fields.  Lower must either prove/port one local theorem from Mathlib-style ingredients or record one exact missing theorem with its imports and hypotheses.",
            ),
            (
                "Post-84 closure 2: generator-to-law weak-FP boundary",
                "Target `appendix.tex:1379-1387`: turn sample-path derivative plus `Measure.map`/Bochner integral transport into the weak generator-to-law Fokker--Planck statement.  Use existing cycle-79 `lawMapIntegral` helpers and Mathlib parametric-integral APIs; do not create another wrapper unless it removes a supplied hypothesis.",
            ),
            (
                "Post-84 closure 3: KL/log-ratio analytic boundary",
                "Target `appendix.tex:1358-1366`: formalize or precisely isolate KL differentiability at the admissible log-ratio weak test, including log-ratio measurability/integrability and the handoff from weak-FP action to `dK`.  Keep theorem statements unchanged.",
            ),
            (
                "Post-84 closure 4: discharge one supplied EM hypothesis",
                "Choose exactly one supplied hypothesis used by cycles 80-84 and replace it with a compiled local theorem or a narrower source-cited boundary.  The acceptable targets are conditional-kernel existence, conditional integral regularity, generator-to-law weak FP, or log-ratio admissibility.",
            ),
            (
                "Post-84 closure 5: discrete theorem closure pressure test",
                "Attempt to route `thm:forward-KL-discrete` through the currently compiled EM wrappers and existing LSI/DV/Gronwall interfaces.  The goal is not to mark the theorem formalized, but to identify the next non-wrapper blocker with a source line and exact Lean declaration.",
            ),
            (
                "Post-84 closure 6: one slow non-EM backend if EM is blocked",
                "Only if the active EM boundary is blocked by a named Mathlib gap, spend one cycle on the smallest non-EM blocker needed by theorem closure: LSI-to-KL/FI, DV finite-log-mgf/common-space, or endpoint-safe Gronwall.  Use local `lean-stat-learning-theory` as a porting guide, not as a Lake dependency.",
            ),
        ]
        title, labels = focus[(cycle - backend_proof_closure_start_cycle) % len(focus)]
        return f"{title}: {labels}"
    backend_backfill_start_cycle = 70
    if cycle >= backend_backfill_start_cycle:
        focus = [
            (
                "Backend backfill 1: EM conditional-law interface",
                "Focus only on `sald.general_moving_target_discrete.em_interpolation_fp` over `appendix.tex:1358-1387`: conditional-law/measurability and named conditional drift interfaces. Use local `lean-stat-learning-theory` only as a Mathlib style reference; do not add it as a dependency.",
            ),
            (
                "Backend backfill 2: endpoint-to-conditional compatibility",
                "Continue the same EM backend: connect endpoint-law `Measure.map` bookkeeping to the conditional-law interface needed by the weak Fokker--Planck statement. Avoid unrelated theorem-route audits or display algebra.",
            ),
            (
                "Backend backfill 3: weak Fokker--Planck source signs",
                "Continue the same EM backend: sharpen or prove the weak conditional Fokker--Planck source-sign statement with `-div` drift and `+(sigma_eta^2/2) Delta` diffusion terms under explicit hypotheses.",
            ),
            (
                "Backend backfill 4: KL derivative handoff from weak FP",
                "Continue the same EM backend: connect the weak FP identity to the discrete KL-derivative handoff while keeping LSI, DV, Gronwall, and theorem statuses below formalized.",
            ),
            (
                "Backend backfill 5: minimal cited measure interface if blocked",
                "Only if proof-producing work is blocked, introduce one narrow Mathlib/measure-theory source-cited interface for the missing conditional-law or weak-FP fact; otherwise keep proving the active EM backend.",
            ),
        ]
        title, labels = focus[(cycle - backend_backfill_start_cycle) % len(focus)]
        return f"{title}: {labels}"
    main_skeleton_start_cycle = 44
    focus = [
        (
            "Main skeleton sprint 1: analytic interface ledger",
            "Create or sharpen the five source-cited analytic interfaces needed by the SALD proof route: Gronwall, DV, LSI-to-KL/FI, continuous forward-KL Fokker--Planck/KL derivative, and EM interpolation Fokker--Planck. Keep every unproved backend below formalized status.",
        ),
        (
            "Main skeleton sprint 2: continuous forward-KL",
            "Wire the source-cited analytic interfaces into the faithful proof skeleton for `thm:forward-KL`, matching `main_body.tex:238-247` and `appendix.tex:164-252` without changing constants, statements, or source labels.",
        ),
        (
            "Main skeleton sprint 3: discrete forward-KL",
            "Wire the theorem-level interfaces into `thm:forward-KL-discrete`, matching `main_body.tex:299-323` and `appendix.tex:260-592`; use source-cited EM/Fokker--Planck interfaces explicitly instead of proving them from scratch in this cycle.",
        ),
        (
            "Main skeleton sprint 4: guided residual and general moving-target",
            "Wire `prop:guided_path_residual` and `thm:general-moving-target-SALD` to the already named interfaces, matching `appendix.tex:619-951`; preserve the paper theorem statements and expose any missing analytic fact as a source-cited interface.",
        ),
        (
            "Main skeleton sprint 5: unified and discrete general theorem",
            "Wire `thm:unified-forward-KL` and `thm:general-moving-target-SALD-discrete` through the continuous/general skeletons and explicit source-cited interfaces; only after that, backfill one narrow measure-theory detail guided by local SLT material.",
        ),
    ]
    title, labels = focus[(max(cycle, main_skeleton_start_cycle) - main_skeleton_start_cycle) % len(focus)]
    return f"{title}: {labels}"


def role_prompt(
    role: str,
    task_id: str,
    title: str,
    task_text: str,
    cycle: int,
    run_dir: Path,
    context_pack: str,
    role_name: str = "",
    lower_count: int = 1,
) -> str:
    task_contract = compact_task_context(task_id, title, task_text, cycle)
    displayed_role = role_name or role
    shared = f"""Task: {task_id} - {title}
Cycle: {cycle}
Role: {displayed_role}
Base role: {role}
Run directory: {rel(run_dir)}

Mandatory gate:

```bash
python3 tools/astis.py check
```

Task contract:

```text
{task_contract}
```

Cycle focus:

```text
{sald_cycle_focus(cycle) if task_id == "ASTIS-SALD-001" else "Follow the task contract and current conversion window."}
```

Recent trial memory:

```text
{recent_trial_text(task_id)}
```

Compact context pack: `{rel(run_dir / "05_context_pack.md")}`

```text
{context_pack}
```

Shared dialogue board: `{rel(run_dir / "dialogue.md")}`

When finished, append a handoff:

```bash
python3 tools/astis.py agent-note {run_dir.name} --role {displayed_role} --message "..."
python3 tools/astis.py trial-log --task {task_id} --role {displayed_role} --kind handoff --status queued --artifact {rel(run_dir)} --notes "..."
```
"""
    post_129_guard = (
        "For SALD cycle 130 and later, treat the cycle-129 illness-area boundary as the live target unless the reviewer records a newer one: "
        "`hdiffusionSource` has been narrowed to the EM/Brownian diffusion generator weak action plus weak Laplacian integration-by-parts action. "
        "Do not reassign already-discharged leaves `hsampleInt`, `hsampleDerivMeas`, `hsampleDerivBound`, `hboundInt`, `hpathDeriv`, `hderivValue`, "
        "`hdriftBarBAction`, raw `hpairMeas`, or `hcanonicalBarBMeas`."
    )
    post_150_guard = (
        "For SALD cycle 151 and later, the reviewer-accepted cycle-150 boundary overrides older broad guards. "
        "The active EM conditional-law / weak-FP backend remains `sald.general_moving_target_discrete.em_interpolation_fp` over "
        "`appendix.tex:1358-1387`, with source anchors `appendix.tex:984-995`, `appendix.tex:1368-1387`, and "
        "`appendix.tex:1379-1387`. "
        "Prioritize one direct definition/equality leaf at a time: `htraceFieldEqLaplacian`, "
        "`hemGeneratorLaplacianEventFieldEqTraceField`, `hemGeneratorLaplacianStateIntegral`, or "
        "`hsourceLaplacianFieldMeas`. "
        "Upper should choose the smallest leaf that reduces this boundary; middle should coordinate the proof route and split lower-agent roles; "
        "lower_1 should produce the natural-language/math route and lower_2 should implement exactly one compiled Lean theorem or a strictly smaller "
        "source-cited obligation. "
        "Reject new total-event/source-functional consumer wrappers unless they discharge one of these direct leaves. "
        "Reviewer must check that the remaining boundary is strictly smaller, not merely renamed, and that `python3 tools/astis.py check` passes."
    )
    post_173_guard = (
        "For SALD cycle 174 and later, the reviewer-accepted cycle-173 boundary overrides the older cycle-150 direct-leaf list. "
        "The active target is still the EM conditional-law / weak-FP Brownian/Ito backend, but the immediate live leaf is now the "
        "source-Hessian contract behind `SALD.selectedWeakTestHessianOpNormOfSourceHessianField`: "
        "`hSourceHasHessian : forall z, HasFDerivAt (fderiv Real sourceTest) (sourceHessian z) z` and "
        "`hSourceHessianBound : forall z, norm (sourceHessian z) <= C1`. "
        "Upper must decide whether these fields are paper assumptions or can be derived from selected-test regularity; middle must "
        "translate that decision into a single Lean theorem/proof-obligation with source anchors; lower_1 should give the natural-language "
        "Mathlib route, using the local SLT Taylor/DCT/measure files only as style references; lower_2 should implement exactly one compiled "
        "theorem or strictly smaller source-cited boundary. "
        "Reject routes that define `sourceHessian` from the desired conclusion, reintroduce `SelectedWeakTestC2bBoundedHessian` without source "
        "support, use VP score-Hessian regularity for the selected weak test, import SLT as a dependency, or return to consumer-wrapper churn. "
        "If the source-Hessian fields are confirmed absent from the paper source, keep the gap honest and move only to the next connected "
        "Brownian/Ito leaf: selected-line Taylor domination, Gaussian dominated-convergence integrability, quadratic-variation normalization, "
        "or per-coordinate Hessian generator identity."
    )
    role_specific = {
        "upper": (
            "Choose one faithful-paper objective, mode discipline, non-goals, lower packet, and reviewer checklist. "
            "First read the compact context pack and run the self-reflection guard: if the planned packet is wrapper churn, reject it and choose a narrower target. "
            "Use the LeanMarathon-inspired proof blueprint: choose either the current dynamic leaf candidate for worker-style proof discharge, or a named illness-area refiner packet when the blocker affects a connected sub-DAG. "
            "Begin with a concise `Global phase judgment:` paragraph that answers: did the previous cycle fail and need recovery; is Phase 1 theorem-skeleton translation stable enough for cited-theory backfill; and which single lower packet now reduces the largest proof risk. "
            "For SALD after cycle 69, treat the theorem-skeleton route as stable enough for single-backend backfill. Keep the source theorem fixed and now prioritize the active EM conditional-law/Fokker--Planck backend over new transcript/ledger expansion, broad theorem-route audits, or isolated scalar sublemmas. "
            "For SALD after cycle 84, do not let the run accumulate more supplied-hypothesis wrappers unless they discharge or strictly narrow an existing supplied hypothesis. The priority is a smallest real backend theorem boundary: conditional kernel/conditional expectation, generator-to-law weak FP, KL/log-ratio admissibility, or one named LSI/DV/Gronwall blocker. "
            "If recent trial memory shows a failed cycle after an upper or middle handoff, recover that cycle first instead of advancing to a new source target. "
            "Before assigning middle/lower work, explicitly check that the active lower packet still targets `sald.general_moving_target_discrete.em_interpolation_fp` over `appendix.tex:1358-1387`, unless reviewer identified a theorem-route blocker. "
            "Do not spend the cycle on source-index rebaseline unless reviewer found a blocking source-anchor defect. "
            "Faithful work has two phases: Phase 1 is a complete source-to-Lean transcript with exact constants and obligations; "
            "Phase 2, only after the transcript is complete, reorganizes reusable APIs for teaching, later SDE/Sampling papers, and exploratoryProof mode. "
            "Require middle to keep two-way Lean/Markdown/LaTeX synchronization, but defer polished project-article and technical-report export to the batch end. "
            "If a cited analytic theorem is too large to prove now, require a precise source-cited interface and keep its status below formalized. "
            + external_lookup_discipline()
            + " "
            "Use `/home/nitanda_sub/mark/repos/RMFLD/lean-stat-learning-theory` as a reference for Mathlib measure/probability style when helpful, but do not import it as a Lake dependency or claim an SLT theorem is formalized unless a local ASTIS declaration compiles. "
            + post_129_guard
            + " "
            + post_150_guard
            + " "
            + post_173_guard
        ),
        "middle": (
            "Maintain conversion windows, proof obligations, source indexes, SLT reuse audit, and lower packets. "
            "Use the compact context pack instead of rereading broad historical task text. "
            "Treat the LeanMarathon-style blueprint state as the system-of-record summary: translate only the chosen dynamic leaf or illness area into lower-ready declarations, and keep unrelated DAG regions out of scope. "
            "For SALD after cycle 69, read the TeX around the active EM conditional-law/Fokker--Planck focus and translate only that backend into lower-ready Lean declarations; avoid fresh theorem-route audits unless needed for source correctness. "
            "For SALD after cycle 84, classify every lower packet as either `discharges-supplied-hypothesis`, `narrows-source-cited-boundary`, or `rejected-wrapper-churn`; lower-ready declarations should name the exact Mathlib/local theorem boundary and source line. "
            "Before inventing an abstraction, inspect the local `lean-stat-learning-theory` reference for Mathlib measure/probability idioms that can be ported locally under this project's toolchain. "
            "Also follow the MathCode-inspired theorem-reuse discipline: search existing ASTIS declarations, conversion windows, proof obligations, and cited-result ledgers before creating a duplicate interface. "
            "Before lower work, translate the relevant LaTeX proof step into Lean-facing declarations; after lower/reviewer work, translate accepted Lean declarations and remaining obligations back into Markdown/LaTeX notes. "
            "At the end of a multi-hour batch, perform the ARIS-style writing pass: update the generated technical-report snippets with the latest run evidence, middle-agent rule changes, source anchors, and remaining proof boundary, while keeping Lean/proof obligations authoritative. "
            + external_lookup_discipline()
            + " "
            "During this sprint, avoid broad rebaseline work, broad SLT/SDE library import, and lower packets outside the active EM backend unless reviewer found a blocker. "
            "Export the Overleaf-ready project article and the external ASTIS technical-report snippets only at the end of a multi-hour batch. "
            + post_129_guard
            + " "
            + post_150_guard
            + " "
            + post_173_guard
        ),
        "lower": (
            "Attempt one narrow proof-producing Lean task for the assigned active backend before creating more ledger-only obligations. Do not change the theorem target. "
            "Begin by naming the packet classification and the exact supplied hypothesis or missing theorem boundary. "
            "If this is a worker-style packet, stay inside the assigned local target/refinement region before asking for upstream changes; if it is a refiner-style packet, edit only the connected illness area named by middle. "
            "Do not work on unrelated display algebra, route audits, or general API cleanup unless the upper/middle packet explicitly assigns it. "
            "After cycle 84, a new supplied-hypothesis wrapper is acceptable only if it removes an older supplied hypothesis, exposes a strictly smaller missing theorem boundary, or produces a compiled local theorem using Mathlib/local SLT-style ingredients. "
            "Do not add fake proof closures; if the analysis fact is not formalized, add a precise source-cited interface or refine a ProofObligation and keep the build green. "
            "In Phase 1 faithfulPaper mode, do not introduce broad library reorganizations or educational APIs unless upper/middle explicitly assign them. "
            + post_129_guard
            + " "
            + post_150_guard
            + " "
            + post_173_guard
        ),
        "reviewer": (
            "Audit build gate, fake proof closures, source correspondence, cited results, and SLT port status. "
            "Also audit efficiency: reject a successful-looking cycle if it consumed the prompt on broad context replay, wrapper churn, or a non-active target while the compact context pack names a narrower blocker. "
            "Apply LeanMarathon-style target-review discipline: no more/no less than the source theorem, deterministic gate is the only progress authority, and a worker packet may not escape its local region without a concrete issue. "
            "Reject contract drift, missing source anchors, or any claim marked proved without a compiled Lean declaration. "
            "Use the MathCode-inspired diagnostics policy: hidden `axiom`, `constant`, `postulate`, `sorry`, `admit`, `Prop := True`, or `:= trivial` closures are blocking defects, and proof statistics should be used to notice suspicious broad rewrites. "
            "Also check backend-focus discipline: reject cycles that only add rebaseline/ledger work, broad route audits, unrelated display algebra, or SLT import claims when the active EM conditional-law/Fokker--Planck backend could have been advanced. "
            + post_150_guard
            + " "
            + post_173_guard
        ),
    }[role]
    if role == "lower" and lower_count >= 2:
        if role_name == "lower_1":
            role_specific += (
                "\n\nParallel lower specialization: you are the natural-language proof scout. "
                "Your primary job is to reason mathematically from the source proof, Mathlib-style measure/SDE facts, and local Lean declarations before the Lean implementer runs. "
                "Produce a precise proof route for the current boundary, list the exact hypotheses needed, name the expected Lean theorem shape, and identify which Mathlib/local lemmas should discharge each step. "
                "You may add or refine a narrowly scoped ProofObligation or conversion-window row, but do not spend the packet on broad documentation and do not claim formalization unless a local declaration compiles. "
                "End with a lower_2-ready handoff that states one theorem/proof block to implement next."
            )
        elif role_name == "lower_2":
            role_specific += (
                "\n\nParallel lower specialization: you are the Lean proof implementer. "
                "First read the shared dialogue for the lower_1 natural-language proof scout handoff, then implement exactly one compiled Lean theorem or a strictly smaller source-cited boundary from that route. "
                "If lower_1's route is invalid, record the precise failure and implement the next smallest correct boundary instead. "
                "Keep the build green and do not broaden the target."
            )
    return shared + "\n## Role Instructions\n\n" + role_specific + "\n"


def make_run_dir(task_id: str, cycle: int, run_id: str = "") -> Path:
    stem = run_id or f"{file_stamp()}-{slugify(task_id)}-cycle{cycle:02d}"
    return ROOT / "runs" / stem


def prompt_role(path: Path) -> str:
    name = path.name
    if "upper" in name:
        return "upper"
    if "middle" in name:
        return "middle"
    if "reviewer" in name:
        return "reviewer"
    return "lower"


def create_run_cycle(task_id: str, cycle: int, lower_count: int, run_id: str = "") -> Path:
    cmd_init(argparse.Namespace())
    title, task_text = task_context(task_id)
    run_dir = make_run_dir(task_id, cycle, run_id)
    run_dir.mkdir(parents=True, exist_ok=False)
    context_pack = build_context_pack(task_id, title, task_text, cycle)
    context = (
        "# Context\n\n"
        f"Task: `{task_id}`\n"
        f"Cycle: `{cycle}`\n"
        f"Created: `{now_stamp()}`\n"
        f"Focus: {sald_cycle_focus(cycle) if task_id == 'ASTIS-SALD-001' else 'task contract'}\n"
        f"Compact context pack: `{rel(run_dir / '05_context_pack.md')}`\n"
    )
    (run_dir / "00_context.md").write_text(context, encoding="utf-8")
    (run_dir / "05_context_pack.md").write_text(context_pack, encoding="utf-8")
    (run_dir / "dialogue.md").write_text(
        f"# Dialogue: {task_id} cycle {cycle}\n\nAppend short role-tagged handoffs here.\n",
        encoding="utf-8",
    )
    roles = ["upper", "middle"] + [f"lower_{i}" for i in range(1, lower_count + 1)] + ["reviewer"]
    prompt_paths = []
    for role_name in roles:
        role = "lower" if role_name.startswith("lower") else role_name
        prefix = {"upper": "10_upper_director", "middle": "20_middle_formalizer", "lower": f"30_{role_name}", "reviewer": "40_reviewer"}[role]
        prompt_path = run_dir / f"{prefix}.md"
        prompt_path.write_text(
            role_prompt(role, task_id, title, task_text, cycle, run_dir, context_pack, role_name=role_name, lower_count=lower_count),
            encoding="utf-8",
        )
        prompt_paths.append(prompt_path)
    (run_dir / "90_handoff.md").write_text(
        f"""# Handoff

Task id: `{task_id}`
Cycle: `{cycle}`

## Upper Decision

## Middle Formalization State

## Lower Attempts

## Reviewer Findings

## Next Cycle Objective
""",
        encoding="utf-8",
    )
    append_jsonl(TRIAL_LOG, {
        "timestamp": now_stamp(),
        "trial_id": f"{run_dir.name}-prompt-deck",
        "task_id": task_id,
        "role": "upper",
        "kind": "plan",
        "status": "queued",
        "lean_gate": "not-run",
        "artifact": rel(run_dir),
        "changed_files": [rel(path) for path in prompt_paths] + [rel(run_dir / "00_context.md"), rel(run_dir / "05_context_pack.md"), rel(run_dir / "dialogue.md")],
        "notes": f"Created prompt deck with {lower_count} lower agent(s).",
    })
    write_trial_summary(load_jsonl(TRIAL_LOG))
    add_manifest("astis.py run-cycle", run_dir / "00_context.md", "run", f"Created prompt deck for {task_id}")
    return run_dir


def cmd_run_cycle(args: argparse.Namespace) -> int:
    run_dir = create_run_cycle(args.task, args.cycle, args.lower_count, args.run_id)
    print(f"created {rel(run_dir)}")
    print("agent prompts:")
    for path in sorted(run_dir.glob("*.md")):
        if path.name != "dialogue.md":
            print(f"- {rel(path)}")
    return 0


def run_agent_command(template: str, prompt: Path, run_dir: Path, task_id: str, cycle: int) -> int:
    role = prompt_role(prompt)
    command = template.format(
        root=str(ROOT),
        prompt=str(prompt),
        run_dir=str(run_dir),
        task=task_id,
        cycle=cycle,
        role=role,
    )
    print("$ " + command)
    completed = subprocess.run(command, cwd=ROOT, shell=True)
    return completed.returncode


def cycle_prompt_paths(run_dir: Path, skip_reviewer: bool) -> list[Path]:
    prompts = [
        run_dir / "10_upper_director.md",
        run_dir / "20_middle_formalizer.md",
        *sorted(run_dir.glob("30_lower_*.md")),
    ]
    if not skip_reviewer:
        prompts.append(run_dir / "40_reviewer.md")
    return prompts


def latest_cycle_number(task_id: str) -> int:
    task_slug = slugify(task_id)
    pattern = re.compile(re.escape(task_slug) + r"-cycle(\d+)")
    latest = 0
    for path in (ROOT / "runs").glob(f"*-{task_slug}-cycle*"):
        match = pattern.search(path.name)
        if match:
            latest = max(latest, int(match.group(1)))
    return latest


def execute_prompt_deck(args: argparse.Namespace, run_dir: Path, cycle: int) -> int:
    final_code = 0
    active_agent_seconds = 0.0
    for prompt in cycle_prompt_paths(run_dir, args.skip_reviewer):
        started = time.monotonic()
        code = run_agent_command(args.agent_cmd, prompt, run_dir, args.task, cycle)
        elapsed = time.monotonic() - started
        active_agent_seconds += elapsed
        status = "accepted" if code == 0 else "failed"
        append_jsonl(TRIAL_LOG, {
            "timestamp": now_stamp(),
            "trial_id": f"{run_dir.name}-{prompt.stem}",
            "task_id": args.task,
            "role": prompt_role(prompt),
            "kind": "attempt",
            "status": status,
            "lean_gate": "not-run",
            "artifact": rel(prompt),
            "changed_files": git_changed_files(),
            "notes": f"External agent command exit code {code}. active_agent_seconds={elapsed:.1f}.",
        })
        write_trial_summary(load_jsonl(TRIAL_LOG))
        if code != 0:
            final_code = code
            break
    setattr(args, "_last_agent_seconds", active_agent_seconds)
    if args.check_each_cycle:
        code = cmd_check(argparse.Namespace())
        append_jsonl(TRIAL_LOG, {
            "timestamp": now_stamp(),
            "trial_id": f"{run_dir.name}-build-gate",
            "task_id": args.task,
            "role": "reviewer",
            "kind": "build",
            "status": "compiled" if code == 0 else "failed",
            "lean_gate": "pass" if code == 0 else "fail",
            "artifact": rel(run_dir),
            "changed_files": git_changed_files(),
            "notes": "Cycle build gate.",
        })
        write_trial_summary(load_jsonl(TRIAL_LOG))
        if code != 0:
            return code
    return final_code


def cmd_sleep_run(args: argparse.Namespace) -> int:
    cmd_init(argparse.Namespace())
    if args.execute and not args.agent_cmd:
        raise SystemExit("--execute requires --agent-cmd")
    if args.dry_run and args.execute:
        raise SystemExit("--dry-run and --execute cannot be used together")
    final_code = 0
    for cycle in range(1, args.cycles + 1):
        run_dir = create_run_cycle(args.task, cycle, args.lower_count)
        print(f"cycle {cycle}: {rel(run_dir)}")
        if args.dry_run or not args.agent_cmd:
            print("dry run: prompt deck created, no external agent command executed")
            continue
        if not args.execute:
            print("agent command configured but not executed; pass --execute to run it")
            continue
        final_code = execute_prompt_deck(args, run_dir, cycle)
        if final_code != 0:
            return final_code
    return final_code


def cmd_sleep_run_window(args: argparse.Namespace) -> int:
    cmd_init(argparse.Namespace())
    if args.execute and not args.agent_cmd:
        raise SystemExit("--execute requires --agent-cmd")
    if args.dry_run and args.execute:
        raise SystemExit("--dry-run and --execute cannot be used together")

    start = time.monotonic()
    deadline = start + args.hours * 3600.0
    guard_seconds = max(args.guard_minutes, 0.0) * 60.0
    agent_budget_seconds = max(getattr(args, "agent_hours_budget", 0.0), 0.0) * 3600.0
    use_agent_budget = agent_budget_seconds > 0.0
    active_agent_seconds_total = 0.0
    cycle = args.start_cycle or latest_cycle_number(args.task) + 1
    completed = 0
    final_code = 0

    while completed < args.max_cycles:
        if use_agent_budget:
            remaining = agent_budget_seconds - active_agent_seconds_total
            wall_remaining = deadline - time.monotonic()
            if completed > 0 and wall_remaining <= 0:
                print("wall-clock safety window elapsed after completed cycle")
                break
            if completed > 0 and remaining <= guard_seconds:
                print("active-agent budget closed before starting another cycle")
                break
            if completed == 0 and remaining <= 0:
                print("active-agent budget elapsed before first cycle; starting one final cycle by request")
            elif completed > 0 and remaining <= 0:
                print("active-agent budget elapsed after completed cycle")
                break
        else:
            remaining = deadline - time.monotonic()
            if completed > 0 and remaining <= guard_seconds:
                print("window closed before starting another cycle")
                break
            if completed == 0 and remaining <= 0:
                print("window elapsed before first cycle; starting one final cycle by request")
            elif completed > 0 and remaining <= 0:
                print("window elapsed after completed cycle")
                break

        run_dir = create_run_cycle(args.task, cycle, args.lower_count)
        print(f"cycle {cycle}: {rel(run_dir)}")
        if use_agent_budget:
            print("cycle will run to completion even if the active-agent budget expires")
        else:
            print("cycle will run to completion even if the wall-clock window expires")

        if args.dry_run or not args.agent_cmd:
            print("dry run: prompt deck created, no external agent command executed")
            completed += 1
            cycle += 1
            continue
        if not args.execute:
            print("agent command configured but not executed; pass --execute to run it")
            completed += 1
            cycle += 1
            continue

        final_code = execute_prompt_deck(args, run_dir, cycle)
        active_agent_seconds_total += float(getattr(args, "_last_agent_seconds", 0.0))
        if use_agent_budget:
            print(f"active-agent seconds used: {active_agent_seconds_total:.1f} / {agent_budget_seconds:.1f}")
        completed += 1
        cycle += 1
        if final_code != 0:
            return final_code

    append_jsonl(TRIAL_LOG, {
        "timestamp": now_stamp(),
        "trial_id": f"{file_stamp()}-{slugify(args.task)}-sleep-window",
        "task_id": args.task,
        "role": "upper",
        "kind": "compression",
        "status": "accepted" if final_code == 0 else "failed",
        "lean_gate": "not-run",
        "artifact": "runs",
        "changed_files": git_changed_files(),
        "notes": (
            f"Graceful sleep window completed {completed} cycle(s); final cycle was not interrupted; "
            f"active_agent_seconds={active_agent_seconds_total:.1f}; "
            f"agent_budget_seconds={agent_budget_seconds:.1f}."
        ),
    })
    write_trial_summary(load_jsonl(TRIAL_LOG))

    if args.after_latex and final_code == 0:
        final_code = cmd_export_latex(argparse.Namespace(task=args.task))
    return final_code


def cmd_launch_six_hour_sald(args: argparse.Namespace) -> int:
    cmd_init(argparse.Namespace())
    logs_dir = ROOT / "runs" / "logs"
    logs_dir.mkdir(parents=True, exist_ok=True)
    next_cycle = args.start_cycle or latest_cycle_number("ASTIS-SALD-001") + 1
    blueprint_path = write_blueprint_refresh("ASTIS-SALD-001")
    blueprint_md, _ = write_blueprint_status("ASTIS-SALD-001")
    context_path = write_context_pack("ASTIS-SALD-001", next_cycle)
    stamp = file_stamp()
    log_path = logs_dir / f"astis-sald-001-6h-{stamp}.log"
    pid_path = logs_dir / f"astis-sald-001-6h-{stamp}.pid"
    command = [
        sys.executable,
        "tools/astis.py",
        "sleep-run-window",
        "ASTIS-SALD-001",
        "--hours",
        str(args.wall_hours),
        "--agent-hours-budget",
        str(args.hours),
        "--max-cycles",
        str(args.max_cycles),
        "--lower-count",
        str(args.lower_count),
        "--agent-cmd",
        "bash tools/astis_codex_faithful.sh {root} {prompt}",
        "--execute",
        "--check-each-cycle",
    ]
    if args.after_latex:
        command.append("--after-latex")
    if getattr(args, "start_cycle", 0):
        command.extend(["--start-cycle", str(args.start_cycle)])
    if args.skip_reviewer:
        command.append("--skip-reviewer")
    with log_path.open("wb") as log:
        log.write(("$ " + " ".join(subprocess.list2cmdline([part]) for part in command) + "\n").encode("utf-8"))
        log.flush()
        proc = subprocess.Popen(
            command,
            cwd=ROOT,
            stdout=log,
            stderr=subprocess.STDOUT,
            start_new_session=True,
        )
    pid = str(proc.pid)
    pid_path.write_text(pid + "\n", encoding="utf-8")
    add_manifest("astis.py launch-sald-6h", log_path, "run", "Started graceful 6-hour ASTIS-SALD-001 Codex faithful-paper run")
    print("started ASTIS-SALD-001 graceful active-agent-budget run")
    print(f"pid: {pid}")
    print(f"active-agent-hours: {args.hours}")
    print(f"wall-hours safety: {args.wall_hours}")
    print(f"batch-end report export: {'enabled' if args.after_latex else 'disabled'}")
    print(f"log: {rel(log_path)}")
    print(f"pid-file: {rel(pid_path)}")
    print(f"blueprint: {rel(blueprint_path)}")
    print(f"blueprint-status: {rel(blueprint_md)}")
    print(f"next-cycle context-pack: {rel(context_path)}")
    return 0


def latest_log_file() -> Path | None:
    logs_dir = ROOT / "runs" / "logs"
    logs = sorted(logs_dir.glob("astis-sald-001-6h-*.log")) if logs_dir.exists() else []
    return logs[-1] if logs else None


def latest_sald_window_info() -> dict:
    """Return lightweight metadata for the latest SALD long-window run."""

    log_path = latest_log_file()
    if log_path is None or not log_path.exists():
        return {"log": "", "cycles": [], "cycle_range": "unknown", "active_agent_seconds": ""}
    text = read_text(log_path)
    cycles = [int(value) for value in re.findall(r"^cycle\s+(\d+):", text, flags=re.M)]
    active_matches = re.findall(r"active-agent seconds used:\s*([0-9.]+)\s*/\s*([0-9.]+)", text)
    if cycles:
        cycle_range = f"{min(cycles)}-{max(cycles)}" if min(cycles) != max(cycles) else str(cycles[0])
    else:
        cycle_range = "unknown"
    active = ""
    if active_matches:
        used, budget = active_matches[-1]
        active = f"{used} / {budget} seconds"
    return {
        "log": rel(log_path),
        "cycles": cycles,
        "cycle_range": cycle_range,
        "active_agent_seconds": active,
    }


def chinese_sald_window_summary_text(
    task: str,
    export_date: str,
    source_count: int,
    trial_count: int,
    state: dict,
    handoffs: list[str],
    diagnostics: dict,
) -> str:
    window = latest_sald_window_info()
    status_counts = "\n".join(
        f"- `{key}`: {value}" for key, value in sorted(state["proof_status_counts"].items())
    )
    packet_counts = "\n".join(
        f"- `{key}`: {value}" for key, value in state["trial_classifications_recent"].items()
    )
    handoff_text = "\n".join(f"- {note}" for note in handoffs) or "- 暂无最近 handoff。"
    totals = diagnostics.get("totals", {})
    theorem_count = totals.get("theorem", "unknown")
    def_count = totals.get("def", "unknown")
    forbidden_hits = totals.get("forbidden_hits", "unknown")
    return f"""# ASTIS 6h 中文复盘：{task}

- 导出时间: {export_date}
- 本轮 cycle: {window["cycle_range"]}
- 本轮日志: `{window["log"]}`
- active-agent 用量: {window["active_agent_seconds"] or "unknown"}
- source-indexed SALD declarations: {source_count}
- trial-log records: {trial_count}
- Lean theorem 数: {theorem_count}
- Lean def 数: {def_count}
- forbidden proof hits: {forbidden_hits}

## 总结结论

这轮还没有完整复现完 SALD 论文的剩余基础分析部分。它完成的是更细的
source-cited boundary narrowing：本轮 cycle `{window["cycle_range"]}` 一直由
blueprint/reviewer 的动态 leaf 驱动，主要推进 EM conditional-law /
weak Fokker--Planck 后端，没有把时间花在无关的 KL/LSI/DV/Gronwall
重排或项目文章润色上。

最新 reviewer 认可的状态是：

```text
{state["latest_blocker"]}
```

这说明系统仍在把论文中一句
“by the Fokker--Planck equation / integration by parts / Laplacian/Ito
calculus”拆成 Lean 必须检查的具体对象。当前剩余困难已经从宽泛的
trace/source-functional wrapper 进一步推进到内部 Brownian/Ito coordinate
decomposition、per-coordinate Hessian generator、Taylor remainder、Gaussian
moment/limit、measurability/integrability 这类底层分析边界。

## 对应原文位置

这里的“原文位置”对应 ASTIS 当前 SALD 复现任务的源论文位置；类比 QBE/GHL
任务中的 `main.tex` 对照表，但本任务不是 GHL。

| 原文位置 | 内容 | 当前 Lean 复现状态 |
|---|---|---|
| `main_body.tex:301-326` | `thm:forward-KL-discrete` 离散 SALD 主定理显示式 | theorem contract 已建；分析后端仍在补 |
| `main_body.tex:372-392` | `thm:unified-forward-KL` general / guided VA-SALD 连续主定理 | theorem contract 已建；与离散后端共享部分义务 |
| `appendix.tex:982-995` | frozen EM interpolation `eq:general_moving_target_SALD_frozen_interp` | 本轮反复使用的 EM generator 来源 |
| `appendix.tex:1354-1366` | `hat rho_s` endpoint law 与 KL derivative 起点 | 已进入 proof DAG；mass/KL derivative 后端仍需精化 |
| `appendix.tex:1368-1377` | conditional drift `bar b_{{k,s}}` 定义 | conditional-law 代表元与 measurability 仍是关键基础边界 |
| `appendix.tex:1379-1387` | 论文直接写的 weak Fokker--Planck equation | 当前 6h 的核心未完成分析后端 |
| `appendix.tex:1402-1427` | divergence rewrite、Fisher information 项、IBP 入口 | Green/trace/box-divergence 与 Laplacian source leaves 仍未完全 formalized |

## 当前未复现的关键边界

```text
{state["latest_blocker"]}
```

下一轮应优先处理 latest blocker 里点名的最小 leaf，而不是回到旧的
total-event/source-functional consumer wrapper。若最新 blocker 是
Brownian/Ito/Taylor 方向，则优先处理：

- selected-test scalar Taylor pointwise limit；
- Taylor moment decomposition；
- quadratic-variation normalization；
- per-coordinate Hessian generator identity；
- 必要的 Gaussian moment、dominated-convergence、measurability/integrability leaf。

若 reviewer 指回 trace/Laplacian 命名方向，则再处理：

- `hemGeneratorLaplacianStateIntegral`；
- `hsourceLaplacianFieldMeas`；
- `hemGeneratorLaplacianEventFieldEqTraceField`；
- `htraceFieldEqLaplacian`。

## 为什么还没有完成

论文里可以把 `appendix.tex:1379-1387` 写成一个 Fokker--Planck 方程，把
`appendix.tex:1402-1427` 写成一次 divergence rewrite 和 integration by
parts。Lean 里这些不是一句话：它需要知道具体是哪一个 law、哪个版本的
conditional expectation、哪个 measurable representative、哪个 Laplacian
定义、哪个边界 trace 为零、哪个积分换元定理可用。

因此，本轮是在把“大而模糊的标准分析步骤”切成小接口：law integral、
state integral、source functional、trace field、Laplacian field、event
field、standard-basis formula、Brownian/Ito scalar coordinate expansion、
Gaussian dominated convergence。这个方向是对的，但还没有完成所有底层
Taylor/Ito/可测性/积分/边界定理。

## 本轮 packet 统计

{packet_counts}

## Proof status counts

{status_counts}

## 最近 handoff 摘要

{handoff_text}

## 下一轮科学计划

1. upper 必须从 latest blocker 里选一个最小 direct leaf；不要回到已经缩小过的
   total-event/source-functional wrapper。
2. middle 负责把该 leaf 的源文位置、Lean declaration、依赖 DAG、可用 Mathlib
   theorem 和仍需 source-cited 的假设写清楚，再分派 lower agents。
3. lower_1 先做自然语言证明路线，明确哪些步骤是 Taylor/Ito 展开、Gaussian
   moment、dominated convergence、measurability/integrability 或定义展开。
4. lower_2 只实现一个 compiled Lean theorem，或者把该 leaf 严格缩小成更小的
   source-cited obligation。
5. reviewer 必须拒绝只把同一个大前提换名字的 wrapper churn；接受标准是
   `python3 tools/astis.py check` 通过且剩余边界严格变小。
6. 如本地 Mathlib/SLT 参考不够，upper/middle 可以网络检索 Mathlib source、
   Lean API 或标准 SDE/Fokker--Planck/Ito/Taylor/Green identity 文献，但所有结果必须回写成
   本地 compiled declaration 或明确 `ProofObligation`。
"""


def cmd_export_technical_report(args: argparse.Namespace) -> int:
    cmd_init(argparse.Namespace())
    task = getattr(args, "task", "ASTIS-SALD-001")
    report_root = Path(getattr(args, "report_root", "") or TECH_REPORT_ROOT)
    sections = report_root / "sections"
    markdown_dir = ROOT / "paper-notes" / "AutoLeanInSleepSampling" / "markdown" / "technical-report-updates"

    source_count = len(load_jsonl(ROOT / "research-wiki" / "source-index" / "SALD_original.jsonl"))
    trial_count = len(load_jsonl(TRIAL_LOG))
    latest_cycle = latest_cycle_number(task)
    export_date = now_stamp()
    window = latest_sald_window_info()
    state = blueprint_control_state(task)
    handoffs = latest_handoff_notes(task, limit=6)
    diagnostics = lean_diagnostics()
    totals = diagnostics.get("totals", {})

    def public_report_text(value: str) -> str:
        return public_article_text(value)

    def latex_escape(value: str) -> str:
        value = public_report_text(value)
        return latex_escape_raw(value)

    def latex_escape_raw(value: str) -> str:
        replacements = {
            "\\": r"\textbackslash{}",
            "&": r"\&",
            "%": r"\%",
            "$": r"\$",
            "#": r"\#",
            "_": r"\_",
            "{": r"\{",
            "}": r"\}",
            "~": r"\textasciitilde{}",
            "^": r"\textasciicircum{}",
        }
        return "".join(replacements.get(char, char) for char in value)

    proof_status_items = "\n".join(
        rf"\item \texttt{{{latex_escape(str(key))}}}: {value}"
        for key, value in sorted(state["proof_status_counts"].items())
    )
    packet_items = "\n".join(
        rf"\item \texttt{{{latex_escape(str(key))}}}: {value}"
        for key, value in state["trial_classifications_recent"].items()
    )
    handoff_items = "\n".join(
        rf"\item {latex_escape(note)}" for note in handoffs
    ) or r"\item No recent handoff notes were found."
    active_seconds = window["active_agent_seconds"] or "unknown"

    report_latex = rf"""% Auto-generated by `python3 tools/astis.py export-technical-report`.
% Do not hand-edit this file; edit the generator or surrounding report text.

\subsection{{Latest Automated Report Update}}
\label{{sec:generated-report-update}}

This subsection is generated by the middle-layer report-writing pass after a
completed ASTIS batch.  The Lean repository, conversion windows, proof
obligations, and reviewer gate remain the source of truth; this text is a
human-readable technical-report projection of that state.

\begin{{center}}
\begin{{tabular}}{{lr}}
\toprule
Quantity & Value \\
\midrule
Export time & {latex_escape_raw(export_date)} \\
Task & \texttt{{{latex_escape_raw(task)}}} \\
Latest observed cycle & {latest_cycle} \\
Latest 6h cycle range & {latex_escape_raw(window["cycle_range"])} \\
Active-agent usage & {latex_escape_raw(active_seconds)} \\
Source-indexed SALD declarations & {source_count} \\
Trial-log records & {trial_count} \\
Lean theorem declarations & {latex_escape_raw(str(totals.get("theorem", "unknown")))} \\
Lean definition declarations & {latex_escape_raw(str(totals.get("def", "unknown")))} \\
Forbidden proof-pattern hits & {latex_escape_raw(str(totals.get("forbidden_hits", "unknown")))} \\
\bottomrule
\end{{tabular}}
\end{{center}}

\paragraph{{Current dynamic leaf.}}
\begin{{quote}}\small
{latex_escape(state["dynamic_leaf_candidate"])}
\end{{quote}}

\paragraph{{Current illness area.}}
\begin{{quote}}\small
{latex_escape(state["illness_area_candidate"])}
\end{{quote}}

\paragraph{{Latest reviewer blocker.}}
\begin{{quote}}\small
{latex_escape(state["latest_blocker"])}
\end{{quote}}

\paragraph{{Recent packet classifications.}}
\begin{{itemize}}
{packet_items}
\end{{itemize}}

\paragraph{{Proof-status counts.}}
\begin{{itemize}}
{proof_status_items}
\end{{itemize}}

\paragraph{{Recent handoff notes.}}
\begin{{itemize}}
{handoff_items}
\end{{itemize}}
"""

    rules_latex = r"""% Auto-generated by `python3 tools/astis.py export-technical-report`.
% This file records the article-writing contract used by 6h ASTIS batches.

\subsection{Batch-End Article-Writing Pass}
\label{sec:generated-article-writing-pass}

ASTIS treats technical-report writing as part of the middle-agent conversion
layer.  During proof search, the middle agent keeps source-to-Lean and
Lean-to-Markdown/LaTeX conversion windows current, but it does not spend lower
proof-search packets on polished article prose.  After the final completed
upper/middle/lower/reviewer cycle of a multi-hour batch, the report-writing
pass updates the human-readable article projection.

The pass has four responsibilities:
\begin{enumerate}[leftmargin=*]
  \item translate accepted Lean declarations and remaining proof obligations
        into ordinary mathematical language;
  \item name the exact source-paper region and active dynamic proof leaf;
  \item record lessons for the next upper and middle agents as rules, not
        chat history;
  \item keep the technical report synchronized with run evidence while
        preserving Lean and the proof-obligation ledger as the authority.
\end{enumerate}

This policy follows the writing-skill discipline of long-horizon autonomous
research systems: a paper is a maintained artifact, and every long run should
leave a clearer explanation of what the system has proved, what it has not
proved, and why the remaining boundary is mathematically meaningful.
"""

    status_md_lines = [
        "# ASTIS Technical Report Update",
        "",
        f"- Export time: {export_date}",
        f"- Task: `{task}`",
        f"- Latest observed cycle: {latest_cycle}",
        f"- Latest 6h cycle range: `{window['cycle_range']}`",
        f"- Latest log: `{window['log']}`",
        f"- Active-agent usage: {active_seconds}",
        f"- Source-indexed SALD declarations: {source_count}",
        f"- Trial-log records: {trial_count}",
        f"- Lean theorem declarations: {totals.get('theorem', 'unknown')}",
        f"- Lean def declarations: {totals.get('def', 'unknown')}",
        f"- Forbidden proof-pattern hits: {totals.get('forbidden_hits', 'unknown')}",
        "",
        "## Current Dynamic Leaf",
        "",
        "```text",
        public_report_text(state["dynamic_leaf_candidate"]),
        "```",
        "",
        "## Latest Reviewer Blocker",
        "",
        "```text",
        public_report_text(state["latest_blocker"]),
        "```",
        "",
        "## Middle-Agent Rule Update",
        "",
        "- Keep source-to-Lean and Lean-to-Markdown/LaTeX conversion synchronized during every cycle.",
        "- Defer polished article edits to the batch-end report-writing pass.",
        "- The generated technical-report snippets are explanatory projections; Lean, conversion windows, and proof obligations remain authoritative.",
        "- Each report update must tell a human why the current proof boundary is smaller or why the cycle was rejected as wrapper churn.",
        "",
        "## Recent Handoffs",
        "",
        *(f"- {public_report_text(note)}" for note in handoffs),
        "",
    ]

    write_text(sections / "generated_run_status.tex", report_latex)
    write_text(sections / "generated_middle_rules.tex", rules_latex)
    cycle_name = f"{slugify(task)}-cycle{window['cycle_range']}-report-update.md"
    write_text(markdown_dir / cycle_name, "\n".join(status_md_lines))
    write_text(markdown_dir / f"{slugify(task)}-latest-report-update.md", "\n".join(status_md_lines))

    add_manifest("astis.py export-technical-report", sections / "generated_run_status.tex", "paper", "Updated ASTIS technical-report run-status section")
    add_manifest("astis.py export-technical-report", sections / "generated_middle_rules.tex", "paper", "Updated ASTIS technical-report middle-agent writing rules")
    print(f"updated technical report snippets under {rel(report_root)}")
    return 0


def analyze_efficiency_log(path: Path) -> dict:
    text = read_text(path)
    lines = text.splitlines()
    token_events = []
    current_role = "unknown"
    current_cycle = 0
    prompt_re = re.compile(r"runs/[^ ]*?cycle(\d+)/([0-9]+_[A-Za-z0-9_]+\.md)")
    cycle_re = re.compile(r"^cycle\s+(\d+):\s+runs/")
    index = 0
    while index < len(lines):
        line = lines[index]
        prompt_match = prompt_re.search(line) if "tools/astis_codex_faithful.sh" in line else None
        if prompt_match is not None:
            current_cycle = int(prompt_match.group(1))
            current_role = prompt_role(Path(prompt_match.group(2)))
        cycle_match = cycle_re.search(line)
        if cycle_match:
            current_cycle = int(cycle_match.group(1))
        if line.strip() == "tokens used" and index + 1 < len(lines):
            raw = lines[index + 1].strip().replace(",", "")
            if raw.isdigit():
                token_events.append({
                    "cycle": current_cycle,
                    "role": current_role,
                    "tokens": int(raw),
                })
                index += 1
        index += 1

    expected_roles = ("upper", "middle", "lower", "reviewer")
    first_cycle = None
    first_cycle_match = re.search(r"^Cycle:\s*(\d+)\s*$", text, flags=re.M)
    if first_cycle_match:
        first_cycle = int(first_cycle_match.group(1))
    cycles = sorted({int(match.group(1)) for match in cycle_re.finditer(text)})
    if first_cycle is not None and len(token_events) % len(expected_roles) == 0:
        cycles = list(range(first_cycle, first_cycle + len(token_events) // len(expected_roles)))
    if cycles and len(token_events) == len(cycles) * len(expected_roles):
        for event_index, event in enumerate(token_events):
            event["cycle"] = cycles[event_index // len(expected_roles)]
            event["role"] = expected_roles[event_index % len(expected_roles)]

    total_tokens = sum(event["tokens"] for event in token_events)
    max_tokens = max((event["tokens"] for event in token_events), default=0)
    mean_tokens = int(total_tokens / len(token_events)) if token_events else 0
    by_role: dict[str, dict[str, int]] = {}
    for event in token_events:
        role = event["role"]
        row = by_role.setdefault(role, {"count": 0, "total": 0, "max": 0})
        row["count"] += 1
        row["total"] += event["tokens"]
        row["max"] = max(row["max"], event["tokens"])
    for row in by_role.values():
        row["mean"] = int(row["total"] / row["count"]) if row["count"] else 0

    classification_mentions = classification_counts_in_text(text)
    trial_classifications = classification_counts_in_trials("ASTIS-SALD-001", cycles)
    useful_packets = (
        trial_classifications["discharges-supplied-hypothesis"]
        + trial_classifications["narrows-source-cited-boundary"]
    )
    wrapper_churn = trial_classifications["rejected-wrapper-churn"]
    warnings = []
    if mean_tokens > 100_000:
        warnings.append("mean role token use exceeds 100k; use compact context packs and shorter trial memory")
    if max_tokens > 200_000:
        warnings.append("at least one role exceeded 200k tokens; likely broad context replay")
    if useful_packets == 0:
        warnings.append("no discharges/narrows packet classification found; progress signal is missing")
    if wrapper_churn > useful_packets:
        warnings.append("wrapper-churn classifications exceed useful packet classifications")
    if len(text) > 50_000_000:
        warnings.append("log exceeds 50MB; prompts or command output are too verbose for efficient iteration")

    return {
        "log": rel(path) if path.is_relative_to(ROOT) else str(path),
        "size_mb": round(path.stat().st_size / (1024 * 1024), 2),
        "cycles": cycles,
        "token_event_count": len(token_events),
        "total_tokens": total_tokens,
        "mean_tokens": mean_tokens,
        "max_tokens": max_tokens,
        "by_role": by_role,
        "classification_mentions_in_log": classification_mentions,
        "trial_classifications": trial_classifications,
        "warnings": warnings,
        "latest_blocker": latest_reviewer_blocker("ASTIS-SALD-001"),
    }


def efficiency_report_text(report: dict) -> str:
    role_lines = []
    for role, row in sorted(report["by_role"].items()):
        role_lines.append(
            f"- `{role}`: count={row['count']}, mean={row['mean']:,}, max={row['max']:,}, total={row['total']:,}"
        )
    warning_lines = [f"- {item}" for item in report["warnings"]] or ["- none"]
    class_lines = [f"- `{key}`: {value}" for key, value in report["trial_classifications"].items()]
    mention_lines = [f"- `{key}`: {value}" for key, value in report["classification_mentions_in_log"].items()]
    cycles = report["cycles"]
    cycle_text = f"{cycles[0]}--{cycles[-1]} ({len(cycles)} cycles)" if cycles else "none detected"
    return "\n".join([
        "# ASTIS Efficiency Report",
        "",
        f"- Log: `{report['log']}`",
        f"- Size: {report['size_mb']} MB",
        f"- Cycles: {cycle_text}",
        f"- Token events: {report['token_event_count']}",
        f"- Total tokens: {report['total_tokens']:,}",
        f"- Mean tokens per role call: {report['mean_tokens']:,}",
        f"- Max tokens in one role call: {report['max_tokens']:,}",
        "",
        "## By Role",
        "",
        "\n".join(role_lines) if role_lines else "- no role token events detected",
        "",
        "## Trial Packet Classifications",
        "",
        "\n".join(class_lines),
        "",
        "## Log Classification Mentions",
        "",
        "\n".join(mention_lines),
        "",
        "## Warnings",
        "",
        "\n".join(warning_lines),
        "",
        "## Current Blocker",
        "",
        report["latest_blocker"],
        "",
        "## Required Next-Run Controls",
        "",
        "- Use `05_context_pack.md` instead of full historical task replay.",
        "- Keep recent trial memory short and high-signal.",
        "- Reviewer should reject cycles that do not classify the packet or do not name the exact discharged/narrowed hypothesis.",
        "- Inspect `python3 tools/astis.py blueprint-refresh ASTIS-SALD-001` before choosing the next dynamic leaf or illness area.",
        "- Upper and middle should consult local SLT files before inventing new measure/probability interfaces, but should not add a Lake dependency.",
    ]) + "\n"


def cmd_efficiency_report(args: argparse.Namespace) -> int:
    path = Path(args.log) if args.log else latest_log_file()
    if path is None:
        raise SystemExit("no ASTIS SALD 6h log found")
    if not path.is_absolute():
        path = ROOT / path
    report = analyze_efficiency_log(path)
    if args.json:
        print(json.dumps(report, indent=2, sort_keys=True))
    text = efficiency_report_text(report)
    output = Path(args.output) if args.output else EFFICIENCY_DIR / f"{path.stem}.md"
    if not output.is_absolute():
        output = ROOT / output
    write_text(output, text)
    add_manifest("astis.py efficiency-report", output, "review", f"Wrote efficiency report for {rel(path)}")
    if not args.json:
        print(text)
    return 0


def cmd_write_context_pack(args: argparse.Namespace) -> int:
    output = Path(args.output) if args.output else None
    if output is not None and not output.is_absolute():
        output = ROOT / output
    path = write_context_pack(args.task, args.cycle, output)
    print(f"context pack: {rel(path)}")
    return 0


def cmd_blueprint_status(args: argparse.Namespace) -> int:
    output = Path(args.output) if args.output else None
    if output is not None and not output.is_absolute():
        output = ROOT / output
    md_path, json_path = write_blueprint_status(args.task, output)
    print(f"blueprint status: {rel(md_path)}")
    print(f"blueprint json: {rel(json_path)}")
    return 0


def cmd_blueprint_refresh(args: argparse.Namespace) -> int:
    output = Path(args.output) if args.output else None
    if output is not None and not output.is_absolute():
        output = ROOT / output
    path = write_blueprint_refresh(args.task, output)
    print(f"blueprint: {rel(path)}")
    return 0


def cmd_export_latex(args: argparse.Namespace) -> int:
    cmd_init(argparse.Namespace())
    task = getattr(args, "task", "ASTIS-SALD-001")
    base = ROOT / "paper-notes" / "AutoLeanInSleepSampling"
    latex = base / "latex"
    sections = latex / "sections"
    figures = latex / "figures"
    markdown = base / "markdown"
    source_count = len(load_jsonl(ROOT / "research-wiki" / "source-index" / "SALD_original.jsonl"))
    trial_count = len(load_jsonl(TRIAL_LOG))
    latest_cycle = latest_cycle_number(task)
    export_date = now_stamp()
    blueprint_state = blueprint_control_state(task)
    latest_handoffs = latest_handoff_notes(task, limit=5)

    def latex_escape(value: str) -> str:
        value = public_article_text(value)
        replacements = {
            "\\": r"\textbackslash{}",
            "&": r"\&",
            "%": r"\%",
            "$": r"\$",
            "#": r"\#",
            "_": r"\_",
            "{": r"\{",
            "}": r"\}",
            "~": r"\textasciitilde{}",
            "^": r"\textasciicircum{}",
        }
        return "".join(replacements.get(char, char) for char in value)

    proof_status_markdown = "\n".join(
        f"- `{key}`: {value}" for key, value in sorted(blueprint_state["proof_status_counts"].items())
    )
    packet_markdown = "\n".join(
        f"- `{key}`: {value}" for key, value in blueprint_state["trial_classifications_recent"].items()
    )
    handoff_markdown = "\n".join(
        f"- {public_article_text(note)}" for note in latest_handoffs
    ) or "- No recent handoff notes were found."
    blocker_markdown = f"""## Human-Readable Blocker Report

The current SALD reproduction is not blocked by a missing source index or by
an interrupted run.  It is blocked by the analytic backend that the paper treats
as standard prose: weak Fokker--Planck source actions, Laplacian source fields,
measurability and state-integral identities, Green identities, boundary trace
conditions, box-divergence facts, and diffusion generator leaves.

For a non-specialist: the paper can write one line such as "by the weak
Fokker--Planck equation and integration by parts".  Lean needs every object in
that sentence to be explicit: which law is being integrated against, which
representative of a conditional expectation is used, why the function is
measurable and integrable, why the boundary term is zero, and which exact
Laplacian/divergence theorem applies.

Current dynamic leaf:

```text
{public_article_text(blueprint_state["dynamic_leaf_candidate"])}
```

Current illness area:

```text
{public_article_text(blueprint_state["illness_area_candidate"])}
```

Latest blocker:

```text
{public_article_text(blueprint_state["latest_blocker"])}
```

Recent packet classifications:

{packet_markdown}

Proof-status counts:

{proof_status_markdown}

Recent reviewer/lower handoffs:

{handoff_markdown}
"""
    blocker_latex_items = [
        "weak Fokker--Planck source actions",
        "Laplacian source-field equality and measurability",
        "state-integral identities under the selected EM law",
        "Green identities and boundary trace terms",
        "box-divergence and diffusion-generator leaves",
    ]
    blocker_latex_items_text = "\n".join(
        rf"\item {latex_escape(item)}" for item in blocker_latex_items
    )
    proof_status_latex = "\n".join(
        rf"\item \Lean{{{latex_escape(str(key))}}}: {value}"
        for key, value in sorted(blueprint_state["proof_status_counts"].items())
    )
    packet_latex = "\n".join(
        rf"\item \Lean{{{latex_escape(str(key))}}}: {value}"
        for key, value in blueprint_state["trial_classifications_recent"].items()
    )
    blocker_latex = rf"""\subsection{{Why the SALD Reproduction Is Not Finished}}

The current bottleneck is not source discovery or an interrupted run.  The
remaining work is the analytic backend that the source proof compresses into
standard prose.  In particular, ASTIS still has to discharge or precisely cite:
\begin{{itemize}}
{blocker_latex_items_text}
\end{{itemize}}

For a non-specialist, the issue is that a paper sentence such as ``by the weak
Fokker--Planck equation and integration by parts'' hides many Lean obligations:
the law being integrated against, the conditional-expectation representative,
measurability, integrability, almost-everywhere equality, boundary terms, and
the exact theorem instance for Laplacian or divergence calculus.

\paragraph{{Current dynamic leaf.}}
\begin{{quote}}\small
{latex_escape(blueprint_state["dynamic_leaf_candidate"])}
\end{{quote}}

\paragraph{{Current illness area.}}
\begin{{quote}}\small
{latex_escape(blueprint_state["illness_area_candidate"])}
\end{{quote}}

\paragraph{{Latest blocker.}}
\begin{{quote}}\small
{latex_escape(blueprint_state["latest_blocker"])}
\end{{quote}}

\paragraph{{Recent packet classifications.}}
\begin{{itemize}}
{packet_latex}
\end{{itemize}}

\paragraph{{Proof-status counts.}}
\begin{{itemize}}
{proof_status_latex}
\end{{itemize}}
"""

    replacements = {
        "@EXPORT_DATE@": export_date,
        "@SOURCE_COUNT@": str(source_count),
        "@TRIAL_COUNT@": str(trial_count),
        "@LATEST_CYCLE@": str(latest_cycle),
        "@QUANTUM_URL@": QUANTUM_AUTOPROOF_URL,
        "@SLT_URL@": SLT_URL,
        "@SLT_ARXIV_URL@": SLT_ARXIV_URL,
        "@LEANMARATHON_URL@": LEANMARATHON_URL,
        "@LEANMARATHON_ARXIV_URL@": LEANMARATHON_ARXIV_URL,
        "@MATHCODE_URL@": MATHCODE_URL,
        "@ARIS_URL@": ARIS_URL,
        "@LBG_URL@": LBG_URL,
        "@EOH_URL@": EOH_URL,
        "@HUMAN_BLOCKER_MARKDOWN@": blocker_markdown,
        "@HUMAN_BLOCKER_LATEX@": blocker_latex,
    }

    def fill(text: str) -> str:
        for key, value in replacements.items():
            text = text.replace(key, value)
        return text

    write_text(base / "README.md", fill("""# Auto-Lean-in-Sleep for Sampling Theory

This directory is the human-readable proof export for ASTIS.  The LaTeX source
under `latex/` is intended as an Overleaf-ready project article.  The VA-SALD
faithful reproduction is an appendix case study inside that larger article,
not a standalone replacement for the source paper.

Last exported: @EXPORT_DATE@
"""))

    write_text(markdown / "status.md", fill("""# ASTIS Project Article Export

- Task: `ASTIS-SALD-001`
- Latest cycle number observed: @LATEST_CYCLE@
- Source-indexed original SALD declarations: @SOURCE_COUNT@
- Trial-log records: @TRIAL_COUNT@
- Quantum automation reference: @QUANTUM_URL@
- SLT reference: @SLT_URL@
- SLT article: @SLT_ARXIV_URL@
- LeanMarathon reference: @LEANMARATHON_URL@
- LeanMarathon article: @LEANMARATHON_ARXIV_URL@
- MathCode workflow reference: @MATHCODE_URL@
- ARIS / auto-research-in-sleep reference: @ARIS_URL@
- Learning Beyond Gradients reference: @LBG_URL@
- EoH reference: @EOH_URL@

The export is batch-based.  Lean and the conversion windows remain the source
of truth; this document is the middle-agent human-audit layer.

@HUMAN_BLOCKER_MARKDOWN@
"""))

    zh_summary = chinese_sald_window_summary_text(
        task=task,
        export_date=export_date,
        source_count=source_count,
        trial_count=trial_count,
        state=blueprint_state,
        handoffs=latest_handoffs,
        diagnostics=lean_diagnostics(),
    )
    window_info = latest_sald_window_info()
    zh_dir = markdown / "zh"
    zh_cycle_name = f"{slugify(task)}-cycle{window_info['cycle_range']}-zh.md"
    write_text(zh_dir / zh_cycle_name, zh_summary)
    write_text(zh_dir / f"{slugify(task)}-latest-zh.md", zh_summary)

    write_text(latex / "main.tex", fill(r"""\documentclass[11pt]{article}

\usepackage[margin=1in]{geometry}
\usepackage{amsmath,amssymb,mathtools}
\usepackage{booktabs,longtable,array}
\usepackage{xcolor}
\usepackage{tikz}
\usetikzlibrary{arrows.meta,positioning,fit,shapes.geometric}
\usepackage[hidelinks]{hyperref}

\newcommand{\Lean}[1]{\texttt{\detokenize{#1}}}
\newcommand{\ASTIS}{Auto-Lean-in-Sleep for Sampling Theory}
\newcommand{\ProofObligation}{\textsc{ProofObligation}}

\title{\ASTIS\\An Automated Lean Workflow for SDE and Sampling Theory}
\author{Auto-Sampling-Theory-In-Sleep Project}
\date{Last exported: @EXPORT_DATE@}

\begin{document}
\maketitle
\tableofcontents

\input{sections/00_overview}
\input{sections/01_system}
\input{sections/02_agent_phases}
\input{sections/03_evidence_status}

\appendix
\input{sections/A_sald_case}
\input{sections/B_task_list}

\end{document}
"""))

    write_text(figures / "system_pipeline.tex", r"""\begin{figure}[t]
\centering
\begin{tikzpicture}[
  node distance=1.2cm,
  stage/.style={draw, rounded corners=2pt, align=center, minimum width=2.7cm, minimum height=0.9cm, fill=blue!4},
  check/.style={draw, diamond, aspect=2, align=center, fill=green!5},
  arrow/.style={-{Latex[length=2mm]}, thick}
]
\node[stage] (source) {Paper or\\proof draft};
\node[stage, right=of source] (index) {Source\\index};
\node[stage, right=of index] (lean) {Lean-facing\\contracts};
\node[stage, right=of lean] (oblig) {Proof\\obligations};
\node[stage, below=of oblig] (attempt) {Lower-agent\\Lean attempts};
\node[check, left=of attempt] (gate) {Reviewer\\gate};
\node[stage, left=of gate] (export) {Markdown/\\LaTeX export};
\draw[arrow] (source) -- (index);
\draw[arrow] (index) -- (lean);
\draw[arrow] (lean) -- (oblig);
\draw[arrow] (oblig) -- (attempt);
\draw[arrow] (attempt) -- (gate);
\draw[arrow] (gate) -- (export);
\draw[arrow] (gate.north) |- (lean.south);
\end{tikzpicture}
\caption{ASTIS keeps source correspondence, Lean contracts, proof obligations,
agent attempts, reviewer gates, and human-readable exports in one loop.}
\end{figure}
""")

    write_text(figures / "agent_stack.tex", r"""\begin{figure}[t]
\centering
\begin{tikzpicture}[
  box/.style={draw, rounded corners=2pt, align=left, minimum width=0.85\textwidth, inner sep=6pt},
  arrow/.style={-{Latex[length=2mm]}, thick}
]
\node[box, fill=purple!5] (upper) {\textbf{Upper}: mode, objective, phase discipline, memory compression};
\node[box, fill=blue!5, below=0.45cm of upper] (middle) {\textbf{Middle}: source-to-Lean and Lean-to-Markdown/LaTeX conversion, proof DAGs, cited results};
\node[box, fill=orange!8, below=0.45cm of middle] (lower) {\textbf{Lower}: one Lean declaration, proof block, source-index change, or obligation refinement};
\node[box, fill=green!6, below=0.45cm of lower] (reviewer) {\textbf{Reviewer}: build gate, source correspondence, no fake proof closure, phase discipline};
\draw[arrow] (upper) -- (middle);
\draw[arrow] (middle) -- (lower);
\draw[arrow] (lower) -- (reviewer);
\draw[arrow] (reviewer.east) .. controls +(1.0,0.7) and +(1.0,-0.7) .. (upper.east);
\end{tikzpicture}
\caption{The four-agent stack mirrors the Quantum automation project, but the
contracts are SDE/Sampling objects rather than circuit oracles.}
\end{figure}
""")

    write_text(sections / "00_overview.tex", fill(r"""\section{Overview}

\ASTIS{} is a Lean-centered automation system for SDE, sampling, and guided
generation theory.  Its first faithful-paper target is the public VA-SALD
paper under the project task \Lean{ASTIS-SALD-001}.  The reproduction treats
that paper as the source of truth rather than later internal drafts.

The system adapts the public Quantum block-encoding automation workflow at
\url{@QUANTUM_URL@}.  The domain semantics are different: ASTIS tracks laws,
densities, transport velocities, Fokker--Planck identities, KL/FI/LSI/PI
interfaces, Euler--Maruyama discretization, and particle approximations.

ASTIS also uses \url{@SLT_URL@} and the article
\url{@SLT_ARXIV_URL@} as nearby Mathlib-based references.  That project
formalizes statistical-learning and concentration tools such as entropy
duality, Gaussian Poincare and log-Sobolev results, and one-step
discretization statements.  ASTIS records these as reuse candidates rather
than importing them directly while the toolchain versions differ.

ASTIS deliberately combines several automation lineages.  From
ARIS/auto-research-in-sleep \url{@ARIS_URL@}, it keeps the plain-file,
long-window research loop and the upper/middle/lower/reviewer decomposition
with an independent review pass.  From Learning Beyond Gradients
\url{@LBG_URL@}, it keeps role-separated iterative improvement and trial
memory: attempts, logs, summaries, rejected directions, negative caches, and
reviewer feedback are first-class state rather than chat history.  ASTIS
specializes this into upper/middle/lower plus reviewer agents for proof work.
From EoH \url{@EOH_URL@}, ASTIS keeps the population idea only for
\Lean{exploratoryProof}: candidate proof routes may be initialized, varied,
selected, and archived after a Lean-checkable acceptance predicate is fixed.
Faithful-paper reproduction does not mutate the source theorem.

For Lean-specific long-horizon orchestration, ASTIS attributes and studies
LeanMarathon \url{@LEANMARATHON_URL@} and its article
\url{@LEANMARATHON_ARXIV_URL@}.  ASTIS absorbs its blueprint-as-system-of-record
view, target-review discipline, dynamic proof-DAG leaves, illness-area
refiner rule, and deterministic CI-gate principle.  This control layer
complements rather than replaces the ARIS/LBG/EoH components above.  ASTIS's
own specialization is the SDE/Sampling correspondence layer: source anchors,
KL/FI/LSI/PI contracts, Fokker--Planck and Euler--Maruyama obligations,
SLT/SDE cited-result ledgers, and Lean-Markdown-LaTeX exports.

For proof-automation workflow design, ASTIS also studies
\url{@MATHCODE_URL@}.  The adopted ideas are diagnostic rather than source-code
reuse: explicit scans for hidden assumptions and placeholders, theorem-reuse
memory before new lemma creation, tree-of-subgoals decomposition as an internal
work plan, and proof-statistics review for broad rewrites.

\input{figures/system_pipeline}
"""))

    write_text(sections / "01_system.tex", fill(r"""\section{System Design}

The source of truth is Lean plus explicit ledgers.  A mathematical ingredient
is never treated as proved merely because it is plausible in prose.  If it is
not a compiled Lean declaration, it must be a \ProofObligation{} or a cited
result with a recorded Lean status.

The workflow has two public modes.  In \Lean{faithfulPaper} mode, the theorem,
assumptions, constants, and proof target are fixed by the source paper.  In
\Lean{exploratoryProof} mode, the system tracks proof routes for active
research drafts, such as RMFLD, without promoting candidate assumptions to
facts.

The project-paper framing follows the automation emphasis of
\url{@ARIS_URL@}, the search-memory perspective of \url{@LBG_URL@}, the
population-and-archive idea of \url{@EOH_URL@}, the Lean-specific blueprint
control loop of \url{@LEANMARATHON_URL@}, and the Lean proof-diagnostics
workflow exemplified by \url{@MATHCODE_URL@}.  The acceptance condition is
stricter than search success: every cycle must leave a buildable repository or
an explicit blocked status, and post-blueprint cycles must identify the
dynamic leaf or illness area they changed.

\input{figures/agent_stack}
"""))

    write_text(sections / "02_agent_phases.tex", r"""\section{Agents and Phases}

Faithful-paper tasks have two phases.  Phase 1 is the complete transcript:
source theorem labels, definitions, proof steps, constants, external results,
and theorem-specific obligations are mapped into Lean-facing declarations and
conversion windows.  This phase deliberately avoids broad library
reorganization unless it is necessary to preserve the source statement.

Phase 2 begins only after the transcript is complete.  It reorganizes shared
SDE/Sampling APIs for education, future paper reproduction, and exploratory
proof work.  Examples include reusable interfaces for KL/FI/LSI, Fokker--
Planck weak forms, Euler--Maruyama one-step errors, and Feynman--Kac particle
systems.

The middle agent owns the two-way conversion layer.  Before lower-agent work,
middle translates the source LaTeX proof fragment into Lean declarations,
cited-result rows, or proof obligations.  After lower and reviewer work,
middle translates the accepted Lean state back into Markdown and LaTeX.  The
polished Overleaf export is batch-based: it is updated at the end of a
multi-hour run, after the final reviewer gate.
""")

    write_text(sections / "03_evidence_status.tex", fill(r"""\section{Current Evidence}

The current SALD faithful reproduction has @SOURCE_COUNT@ original source
declarations in \Lean{research-wiki/source-index/SALD_original.jsonl}.  The
trial log contains @TRIAL_COUNT@ records, and the latest observed SALD cycle
number is @LATEST_CYCLE@.

The mandatory local gate is
\[
  \Lean{python3 tools/astis.py check},
\]
which runs Mathlib cache retrieval, \Lean{lake build}, \Lean{lake build Tests},
and the ASTIS forbidden-pattern scan.  Forbidden proof closures include
\Lean{sorry}, \Lean{admit}, \Lean{axiom}, \Lean{Prop := True}, and
\Lean{:= trivial}.

@HUMAN_BLOCKER_LATEX@
"""))

    write_text(sections / "A_sald_case.tex", r"""\section{VA-SALD Faithful-Reproduction Case}

The first case study is \Lean{ASTIS-SALD-001}: faithful reproduction of the
public VA-SALD paper proofs.  The first proof DAG tracks
\[
\texttt{lem:gronwall},\quad
\texttt{lem:dv\_variation},\quad
\texttt{eq:LSI-KL-FI},\quad
\texttt{thm:forward-KL},\quad
\texttt{thm:forward-KL-discrete},
\]
followed by guided-path residual and general moving-target VA-SALD results.

At the end of the first long run, cycle 15 was closed rather than interrupted.
The accepted lower slice for \Lean{thm:forward-KL-discrete} is
\[
  \text{\Lean{sald.discrete_forward_kl.conditional_drift_density}}.
\]
It corresponds to the source proof step defining
\[
  \bar b_{k,s}(x)
  = \mathbb{E}\!\left[\nabla \log \pi_{t_k}(X_k^\eta)
      \mid \widehat X_s=x\right],
\]
and records the regular conditional law, density, measurability, and
integrability interfaces needed before the conditional-drift Fokker--Planck
equation can be formalized.  It is intentionally an obligation, not a proved
Fokker--Planck theorem.

\begin{longtable}{p{0.24\textwidth}p{0.34\textwidth}p{0.32\textwidth}}
\toprule
Source step & Lean-facing item & Status \\
\midrule
Continuous and discrete KL/FI/LSI vocabulary &
\Lean{Probability.lean}, \Lean{SALD.lean} contracts &
contracts plus obligations \\
Continuous forward-KL proof route &
\Lean{SALD.forwardKlProofDag} &
source-to-Lean map and obligations \\
Discrete EM interpolation spine &
\Lean{SALD.cycle15DiscreteForwardKlMiddleContract} &
obligation map \\
Conditional drift density &
\Lean{SALD.cycle15DiscreteForwardKlConditionalDriftDensityContract} &
obligation; no fake closure \\
Conditional Fokker--Planck and Laplacian split &
\Lean{sald.discrete_forward_kl.em_conditional_fokker_planck} &
remaining obligation \\
\bottomrule
\end{longtable}
""")

    write_text(sections / "B_task_list.tex", r"""\section{Operational Task List}

\begin{enumerate}
\item Complete Phase 1 for \Lean{ASTIS-SALD-001}: every original VA-SALD
      theorem, definition, and proof step must be represented by a Lean
      declaration, cited result, or \ProofObligation{}.
\item Preserve the batch cadence: run upper, middle, lower, reviewer, and the
      build gate for the final cycle before exporting LaTeX.
\item Keep the SALD case as an appendix to the larger ASTIS article.  The main
      article explains the automation system; the appendix shows what the
      current Lean-backed proof framework looks like.
\item After Phase 1, start Phase 2 organization for reusable SDE/Sampling
      theory blocks and for \Lean{exploratoryProof} targets such as RMFLD.
\end{enumerate}
""")

    add_manifest("astis.py export-latex", latex / "main.tex", "paper", "Exported ASTIS project article and SALD appendix")
    add_manifest("astis.py export-latex", zh_dir / zh_cycle_name, "paper", "Exported Chinese 6h SALD proof-reproduction summary")
    print(f"exported LaTeX article to {rel(latex / 'main.tex')}")
    print(f"exported Chinese summary to {rel(zh_dir / zh_cycle_name)}")
    if not getattr(args, "skip_technical_report", False):
        return cmd_export_technical_report(argparse.Namespace(task=task, report_root=str(TECH_REPORT_ROOT)))
    return 0


def cmd_agent_note(args: argparse.Namespace) -> int:
    run_dir = latest_run_dir() if args.run == "latest" else ROOT / "runs" / args.run
    if run_dir is None or not run_dir.exists():
        raise SystemExit("run directory not found")
    append_line(run_dir / "dialogue.md", f"\n## {args.role} @ {now_stamp()}\n\n{args.message}\n")
    print(f"updated {rel(run_dir / 'dialogue.md')}")
    return 0


def latest_run_dir() -> Path | None:
    runs = [p for p in (ROOT / "runs").glob("*") if p.is_dir()]
    return sorted(runs)[-1] if runs else None


def git_changed_files() -> list[str]:
    code, output = run_capture(["git", "status", "--short"])
    if code != 0:
        return []
    files = []
    for line in output.splitlines():
        if not line.strip():
            continue
        item = line[3:] if len(line) > 3 else line
        if " -> " in item:
            item = item.split(" -> ", 1)[1]
        files.append(item.strip())
    return sorted(set(files))


def is_git_worktree() -> bool:
    code, output = run_capture(["git", "rev-parse", "--is-inside-work-tree"])
    return code == 0 and output.strip() == "true"


def write_trial_summary(records: list[dict]) -> None:
    TRIAL_SUMMARY.parent.mkdir(parents=True, exist_ok=True)
    with TRIAL_SUMMARY.open("w", newline="", encoding="utf-8") as handle:
        fieldnames = ["index", "timestamp", "trial_id", "task_id", "role", "kind", "status", "lean_gate", "artifact", "changed_files", "notes"]
        writer = csv.DictWriter(handle, fieldnames=fieldnames)
        writer.writeheader()
        for index, record in enumerate(records, start=1):
            writer.writerow({
                "index": index,
                "timestamp": record.get("timestamp", ""),
                "trial_id": record.get("trial_id", ""),
                "task_id": record.get("task_id", ""),
                "role": record.get("role", ""),
                "kind": record.get("kind", ""),
                "status": record.get("status", ""),
                "lean_gate": record.get("lean_gate", ""),
                "artifact": record.get("artifact", ""),
                "changed_files": ";".join(record.get("changed_files", [])),
                "notes": record.get("notes", ""),
            })


def cmd_trial_log(args: argparse.Namespace) -> int:
    cmd_init(argparse.Namespace())
    changed = list(args.changed_file or [])
    if args.from_git:
        changed.extend(git_changed_files())
    trial_id = args.trial_id or f"{file_stamp()}-{slugify(args.task)}-{args.role}-{args.kind}"
    record = {
        "timestamp": now_stamp(),
        "trial_id": trial_id,
        "task_id": args.task,
        "role": args.role,
        "kind": args.kind,
        "status": args.status,
        "lean_gate": args.lean_gate,
        "artifact": args.artifact or "",
        "changed_files": sorted(set(changed)),
        "notes": args.notes or "",
    }
    append_jsonl(TRIAL_LOG, record)
    write_trial_summary(load_jsonl(TRIAL_LOG))
    add_manifest("astis.py trial-log", TRIAL_LOG, "trial", f"Logged {trial_id}")
    print(f"logged {trial_id}")
    return 0


def cmd_trial_summary(_: argparse.Namespace) -> int:
    records = load_jsonl(TRIAL_LOG)
    write_trial_summary(records)
    by_task: dict[str, int] = {}
    for record in records:
        by_task[record.get("task_id", "unknown")] = by_task.get(record.get("task_id", "unknown"), 0) + 1
    for task, count in sorted(by_task.items()):
        print(f"{task}: total={count}")
    print(f"wrote {rel(TRIAL_SUMMARY)}")
    return 0


def cmd_status(_: argparse.Namespace) -> int:
    cmd_init(argparse.Namespace())
    state = load_state()
    print(f"project: {ROOT}")
    print(f"active task: {state.get('active_task')}")
    print(f"last check: {state.get('last_check')}")
    if not is_git_worktree():
        print("git: not a repository")
        return 0
    return run(["git", "status", "--short"])


def cmd_proof_diagnostics(_: argparse.Namespace) -> int:
    print(json.dumps(lean_diagnostics(), indent=2, sort_keys=True))
    return 0


def build_parser() -> argparse.ArgumentParser:
    parser = argparse.ArgumentParser(description="ASTIS workflow helper")
    sub = parser.add_subparsers(dest="command", required=True)
    sub.add_parser("init").set_defaults(func=cmd_init)
    sub.add_parser("check").set_defaults(func=cmd_check)
    sub.add_parser("status").set_defaults(func=cmd_status)
    sub.add_parser("proof-diagnostics").set_defaults(func=cmd_proof_diagnostics)
    sub.add_parser("list-literature").set_defaults(func=cmd_list_literature)
    sub.add_parser("list-tasks").set_defaults(func=cmd_list_tasks)
    sub.add_parser("next-task").set_defaults(func=cmd_next_task)

    context_pack = sub.add_parser("write-context-pack")
    context_pack.add_argument("task")
    context_pack.add_argument("--cycle", type=int, default=1)
    context_pack.add_argument("--output", default="")
    context_pack.set_defaults(func=cmd_write_context_pack)

    efficiency = sub.add_parser("efficiency-report")
    efficiency.add_argument("--log", default="")
    efficiency.add_argument("--output", default="")
    efficiency.add_argument("--json", action="store_true")
    efficiency.set_defaults(func=cmd_efficiency_report)

    blueprint = sub.add_parser("blueprint-status")
    blueprint.add_argument("task")
    blueprint.add_argument("--output", default="")
    blueprint.set_defaults(func=cmd_blueprint_status)

    blueprint_refresh = sub.add_parser("blueprint-refresh")
    blueprint_refresh.add_argument("task")
    blueprint_refresh.add_argument("--output", default="")
    blueprint_refresh.set_defaults(func=cmd_blueprint_refresh)

    source_index = sub.add_parser("source-index")
    source_index.add_argument("task")
    source_index.set_defaults(func=cmd_source_index)

    run_cycle = sub.add_parser("run-cycle")
    run_cycle.add_argument("task")
    run_cycle.add_argument("--cycle", type=int, default=1)
    run_cycle.add_argument("--lower-count", type=int, default=1)
    run_cycle.add_argument("--run-id", default="")
    run_cycle.set_defaults(func=cmd_run_cycle)

    sleep_run = sub.add_parser("sleep-run")
    sleep_run.add_argument("task")
    sleep_run.add_argument("--cycles", type=int, default=1)
    sleep_run.add_argument("--lower-count", type=int, default=1)
    sleep_run.add_argument("--agent-cmd", default="")
    sleep_run.add_argument("--execute", action="store_true")
    sleep_run.add_argument("--dry-run", action="store_true")
    sleep_run.add_argument("--check-each-cycle", action="store_true")
    sleep_run.add_argument("--skip-reviewer", action="store_true")
    sleep_run.set_defaults(func=cmd_sleep_run)

    sleep_window = sub.add_parser("sleep-run-window")
    sleep_window.add_argument("task")
    sleep_window.add_argument("--hours", type=float, default=6.0)
    sleep_window.add_argument("--agent-hours-budget", type=float, default=0.0)
    sleep_window.add_argument("--max-cycles", type=int, default=999)
    sleep_window.add_argument("--start-cycle", type=int, default=0)
    sleep_window.add_argument("--guard-minutes", type=float, default=0.0)
    sleep_window.add_argument("--lower-count", type=int, default=1)
    sleep_window.add_argument("--agent-cmd", default="")
    sleep_window.add_argument("--execute", action="store_true")
    sleep_window.add_argument("--dry-run", action="store_true")
    sleep_window.add_argument("--check-each-cycle", action="store_true")
    sleep_window.add_argument("--skip-reviewer", action="store_true")
    sleep_window.add_argument("--after-latex", action="store_true")
    sleep_window.set_defaults(func=cmd_sleep_run_window)

    launch = sub.add_parser("launch-sald-6h")
    launch.add_argument("--hours", type=float, default=6.0, help="active agent budget in hours")
    launch.add_argument("--wall-hours", type=float, default=24.0, help="wall-clock safety window for an active-agent-budget run")
    launch.add_argument("--max-cycles", type=int, default=64)
    launch.add_argument("--lower-count", type=int, default=2)
    launch.add_argument("--start-cycle", type=int, default=0)
    launch.add_argument("--after-latex", dest="after_latex", action="store_true", default=True)
    launch.add_argument("--no-after-latex", dest="after_latex", action="store_false")
    launch.add_argument("--skip-reviewer", action="store_true")
    launch.set_defaults(func=cmd_launch_six_hour_sald)

    export = sub.add_parser("export-latex")
    export.add_argument("--task", default="ASTIS-SALD-001")
    export.add_argument("--skip-technical-report", action="store_true")
    export.set_defaults(func=cmd_export_latex)

    report_export = sub.add_parser("export-technical-report")
    report_export.add_argument("--task", default="ASTIS-SALD-001")
    report_export.add_argument("--report-root", default=str(TECH_REPORT_ROOT))
    report_export.set_defaults(func=cmd_export_technical_report)

    note = sub.add_parser("agent-note")
    note.add_argument("run")
    note.add_argument("--role", choices=AGENT_ROLES, required=True)
    note.add_argument("--message", required=True)
    note.set_defaults(func=cmd_agent_note)

    trial = sub.add_parser("trial-log")
    trial.add_argument("--task", required=True)
    trial.add_argument("--role", choices=AGENT_ROLES, required=True)
    trial.add_argument("--kind", choices=TRIAL_KINDS, required=True)
    trial.add_argument("--status", choices=TRIAL_STATUSES, required=True)
    trial.add_argument("--lean-gate", default="not-run")
    trial.add_argument("--artifact", default="")
    trial.add_argument("--changed-file", action="append")
    trial.add_argument("--from-git", action="store_true")
    trial.add_argument("--trial-id")
    trial.add_argument("--notes", default="")
    trial.set_defaults(func=cmd_trial_log)

    sub.add_parser("trial-summary").set_defaults(func=cmd_trial_summary)
    return parser


def main(argv: list[str]) -> int:
    args = build_parser().parse_args(argv)
    return args.func(args)


if __name__ == "__main__":
    raise SystemExit(main(sys.argv[1:]))
