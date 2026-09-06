#!/usr/bin/env python3
"""Build and verify the external ATLAS v1 declaration memory index.

The index is retrieval metadata, not a local Lean proof registry.  It records
where a named upstream declaration lives, direct placeholder evidence, the
upstream textbook-target evaluation, and conservative ASTIS route candidates.
ATLAS source remains in a pinned external checkout under its own license.
"""

from __future__ import annotations

import argparse
import collections
import datetime as dt
import hashlib
import json
import os
import re
import subprocess
import sys
from pathlib import Path
from typing import Iterable


ROOT = Path(__file__).resolve().parents[1]
MANIFEST = ROOT / "Libraries" / "upstreams" / "atlas-v1.json"
INDEX_ROOT = ROOT / "research-wiki" / "retrieval-index" / "atlas-v1"
SUMMARY = ROOT / "research-wiki" / "retrieval-index" / "atlas-v1-summary.json"
CERTIFICATION = ROOT / "research-wiki" / "retrieval-index" / "atlas-v1-certification.json"
DEFAULT_SOURCE = Path(
    os.environ.get(
        "ASTIS_ATLAS_ROOT",
        str(ROOT.parent / "outer_repos" / "atlas-lean" / "v1"),
    )
)

DECLARATION_RE = re.compile(
    r"^\s*(?:@\[[^\]]*\]\s*)*"
    r"(?:(?:noncomputable|private|protected|local|unsafe|partial)\s+)*"
    r"(theorem|lemma|def|abbrev|structure|class|inductive|opaque|axiom|instance|alias)\s+"
    r"([^\s(:{\[]+)"
)

TOPIC_PATTERNS: dict[str, tuple[str, ...]] = {
    "measure-probability": (
        "measure", "measurable", "probability", "random", "expectation", "integral",
        "fubini", "tonelli", "radon", "density", "conditional", "kernel", "law",
    ),
    "stochastic-processes": (
        "stochastic", "markov", "martingale", "brownian", "filtration", "stopping",
        "ito", "girsanov", "diffusion", "semigroup", "feller", "generator",
    ),
    "functional-inequalities": (
        "poincare", "sobolev", "isoperim", "concentration", "entropy", "transport",
        "wasserstein", "talagrand", "brascamp", "variance",
    ),
    "sampling": (
        "langevin", "sampl", "montecarlo", "monte_carlo", "metropolis", "hamiltonian",
        "mixing", "stationary", "invariant", "ergodic",
    ),
    "convex-optimization": (
        "convex", "optimization", "optimisation", "gradient", "hessian", "lipschitz",
        "fenchel", "prox", "mirror", "descent", "subgradient", "lagrang", "dual",
    ),
    "manifold-geometry": (
        "manifold", "riemann", "tangent", "geodesic", "retraction", "curvature",
        "connection", "metric", "cotangent", "differentialform", "differential_form",
    ),
    "analysis-pde": (
        "deriv", "differential", "laplac", "fourier", "pde", "weak", "continuity",
        "compact", "functional", "banach", "hilbert", "operator", "distribution",
    ),
    "information-statistics": (
        "statistic", "estimator", "gaussian", "information", "fisher", "kl", "relativeentropy",
        "relative_entropy", "likelihood", "regression", "empirical", "deviation",
    ),
}

RIEMANNIAN_BOOKS = {
    "DifferentialAnalysis",
    "DifferentialGeometry",
    "GeometryOfManifolds",
    "IntroductionToFunctionalAnalysis",
    "LieGroups",
    "RealAnalysis",
}
OPTIMISATION_BOOKS = {
    "AnAlgorithmistsToolkit",
    "CombinatorialOptimization",
    "HighDimensionalStatistics",
    "IntroductionToFunctionalAnalysis",
    "RealAnalysis",
}
SAMPLING_BOOKS = {
    "DifferentialAnalysis",
    "DifferentialGeometry",
    "FourierAnalysis",
    "GeometryOfManifolds",
    "HighDimensionalStatistics",
    "IntroductionToFunctionalAnalysis",
    "IntroductionToPartialDifferentialEquations",
    "ProbabilisticMethodsInCombinatorics",
    "RealAnalysis",
    "TheoryOfProbability",
}


def read_json(path: Path) -> dict:
    return json.loads(path.read_text(encoding="utf-8"))


def stable_json(value: object) -> str:
    return json.dumps(value, ensure_ascii=False, sort_keys=True, separators=(",", ":"))


def sanitize_lean(text: str) -> str:
    """Remove comments and strings while preserving line boundaries."""
    chars = list(text)
    result = list(text)
    i = 0
    block_depth = 0
    in_string = False
    while i < len(chars):
        if block_depth:
            if i + 1 < len(chars) and chars[i : i + 2] == ["/", "-"]:
                result[i] = result[i + 1] = " "
                block_depth += 1
                i += 2
                continue
            if i + 1 < len(chars) and chars[i : i + 2] == ["-", "/"]:
                result[i] = result[i + 1] = " "
                block_depth -= 1
                i += 2
                continue
            if chars[i] != "\n":
                result[i] = " "
            i += 1
            continue
        if in_string:
            if chars[i] == "\\" and i + 1 < len(chars):
                if chars[i] != "\n":
                    result[i] = " "
                if chars[i + 1] != "\n":
                    result[i + 1] = " "
                i += 2
                continue
            if chars[i] == '"':
                in_string = False
            if chars[i] != "\n":
                result[i] = " "
            i += 1
            continue
        if i + 1 < len(chars) and chars[i : i + 2] == ["-", "-"]:
            while i < len(chars) and chars[i] != "\n":
                result[i] = " "
                i += 1
            continue
        if i + 1 < len(chars) and chars[i : i + 2] == ["/", "-"]:
            result[i] = result[i + 1] = " "
            block_depth = 1
            i += 2
            continue
        if chars[i] == '"':
            result[i] = " "
            in_string = True
        i += 1
    return "".join(result)


def topic_tags(book: str, module: str, name: str) -> list[str]:
    haystack = f"{book} {module} {name}".lower().replace("-", "_")
    spaced = re.sub(r"([a-z0-9])([A-Z])", r"\1 \2", f"{book} {module} {name}").lower()
    tokens = set(re.findall(r"[a-z0-9]+", spaced))

    def matches(pattern: str) -> bool:
        if pattern == "prox":
            return any(token.startswith("prox") for token in tokens)
        if len(pattern) <= 4:
            return pattern in tokens
        return pattern in haystack

    return [
        topic
        for topic, patterns in TOPIC_PATTERNS.items()
        if any(matches(pattern) for pattern in patterns)
    ]


def route_candidates(book: str, topics: list[str]) -> list[str]:
    topic_set = set(topics)
    routes: list[str] = []
    if book in SAMPLING_BOOKS and topic_set.intersection(
        {
            "measure-probability",
            "stochastic-processes",
            "functional-inequalities",
            "sampling",
            "information-statistics",
            "analysis-pde",
        }
    ):
        routes.append("samplewiki-route")
    if book in RIEMANNIAN_BOOKS and "manifold-geometry" in topic_set:
        routes.append("riemannian-optimization")
    if book in RIEMANNIAN_BOOKS and topic_set.issuperset(
        {"manifold-geometry", "convex-optimization"}
    ):
        if "riemannian-optimization" not in routes:
            routes.append("riemannian-optimization")
    if book in OPTIMISATION_BOOKS and "convex-optimization" in topic_set:
        routes.append("optimisation")
    return routes


def source_git_commit(source: Path) -> str:
    completed = subprocess.run(
        ["git", "-C", str(source.parent), "rev-parse", "HEAD"],
        check=True,
        text=True,
        stdout=subprocess.PIPE,
        stderr=subprocess.PIPE,
    )
    return completed.stdout.strip()


def load_target_reports(source: Path) -> tuple[dict[tuple[str, str], dict], dict[str, int]]:
    targets: dict[tuple[str, str], dict] = {}
    totals = collections.Counter()
    for report_path in sorted((source / "Atlas").glob("*/report.json")):
        report = read_json(report_path)
        summary = report.get("statements", {}).get("summary", {})
        totals["target_total"] += int(summary.get("total", 0))
        totals["target_passed"] += int(summary.get("passed", 0))
        totals["target_failed"] += int(summary.get("failed", 0))
        for detail in report.get("statements", {}).get("details", []):
            lean_file = str(detail.get("lean_file", ""))
            declaration = str(detail.get("lean_declaration", ""))
            if not lean_file or not declaration:
                continue
            scores = detail.get("scores", {})
            item = {
                "passed": bool(detail.get("passed", False)),
                "compilation": scores.get("compilation"),
                "faithfulness": scores.get("faithfulness"),
                "proof_integrity": scores.get("proof_integrity"),
                "code_quality": scores.get("code_quality"),
                "match_confidence": detail.get("match_confidence", ""),
                "reported_axioms": detail.get("axioms", ""),
                "reported_sorry_dependencies": detail.get("sorry_deps", ""),
            }
            targets[(lean_file, declaration)] = item
            targets.setdefault((lean_file, declaration.rsplit(".", 1)[-1]), item)
    return targets, dict(totals)


def scan_source(source: Path) -> tuple[dict[str, list[dict]], dict]:
    atlas = source / "Atlas"
    if not atlas.is_dir():
        raise RuntimeError(f"ATLAS source directory not found: {atlas}")
    target_reports, target_totals = load_target_reports(source)
    by_book: dict[str, list[dict]] = collections.defaultdict(list)
    counts = collections.Counter()
    topic_counts = collections.Counter()
    route_counts = collections.Counter()
    route_book_counts: dict[str, collections.Counter] = collections.defaultdict(collections.Counter)

    for path in sorted(atlas.rglob("*.lean")):
        rel = path.relative_to(source).as_posix()
        parts = Path(rel).parts
        book = parts[1] if len(parts) > 1 else "Unknown"
        module = ".".join(Path(rel).with_suffix("").parts)
        text = path.read_text(encoding="utf-8")
        lines = text.splitlines()
        clean_lines = sanitize_lean(text).splitlines()
        contexts: list[tuple[str, list[str]]] = []
        starts: list[tuple[int, str, str, str]] = []
        for index, line in enumerate(clean_lines):
            namespace_match = re.match(r"^\s*namespace\s+([A-Za-z0-9_'.]+)\s*$", line)
            if namespace_match:
                contexts.append(("namespace", namespace_match.group(1).split(".")))
                continue
            if re.match(r"^\s*section(?:\s+[A-Za-z0-9_'.]+)?\s*$", line):
                contexts.append(("section", []))
                continue
            if re.match(r"^\s*end(?:\s+[A-Za-z0-9_'.]+)?\s*$", line):
                if contexts:
                    contexts.pop()
                continue
            match = DECLARATION_RE.match(line)
            if not match:
                continue
            kind, name = match.groups()
            name = name.rstrip(".")
            if kind == "instance" and name in {"where", "by"}:
                continue
            namespace_parts = [
                part
                for context_kind, context_parts in contexts
                if context_kind == "namespace"
                for part in context_parts
            ]
            full_name = ".".join([*namespace_parts, *name.split(".")])
            starts.append((index, kind, name, full_name))

        for position, (start, kind, name, full_name) in enumerate(starts):
            end = starts[position + 1][0] if position + 1 < len(starts) else len(lines)
            clean_source = "\n".join(clean_lines[start:end])
            placeholders = [
                token
                for token in ("sorry", "admit")
                if re.search(rf"\b{token}\b", clean_source)
            ]
            if kind == "axiom":
                placeholders.append("axiom")
            topics = topic_tags(book, module, full_name)
            routes = route_candidates(book, topics)
            target = target_reports.get((rel, full_name)) or target_reports.get((rel, name))
            record = {
                "id": hashlib.sha1(f"{rel}\0{start + 1}\0{full_name}".encode()).hexdigest()[:16],
                "book": book,
                "module": module,
                "file": rel,
                "line": start + 1,
                "kind": kind,
                "name": full_name,
                "direct_placeholders": placeholders,
                "topics": topics,
                "route_candidates": routes,
                "status": "external-reference",
            }
            if target is not None:
                record["upstream_target_evaluation"] = target
                counts["matched_targets"] += 1
            by_book[book].append(record)
            counts["named_source_declarations"] += 1
            counts[f"kind:{kind}"] += 1
            if placeholders:
                counts["direct_placeholder_declarations"] += 1
            for topic in topics:
                topic_counts[topic] += 1
            for route in routes:
                route_counts[route] += 1
                route_book_counts[route][book] += 1

    metadata = {
        "counts": dict(counts),
        "topics": dict(topic_counts),
        "routes": dict(route_counts),
        "route_books": {
            route: dict(sorted(book_counts.items()))
            for route, book_counts in sorted(route_book_counts.items())
        },
        "target_reports": target_totals,
        "source_files": len(list(atlas.rglob("*.lean"))),
        "books": len(by_book),
    }
    return dict(by_book), metadata


def serialized_fragments(by_book: dict[str, list[dict]]) -> dict[str, bytes]:
    fragments: dict[str, bytes] = {}
    for book in sorted(by_book):
        payload = "".join(stable_json(record) + "\n" for record in by_book[book]).encode("utf-8")
        fragments[f"{book}.jsonl"] = payload
    return fragments


def index_digest(fragments: dict[str, bytes]) -> str:
    digest = hashlib.sha256()
    for name in sorted(fragments):
        digest.update(name.encode("utf-8"))
        digest.update(b"\0")
        digest.update(fragments[name])
    return digest.hexdigest()


def build_summary(source: Path, fragments: dict[str, bytes], metadata: dict) -> dict:
    manifest = read_json(MANIFEST)
    return {
        "schema_version": 1,
        "generated_at": dt.datetime.now(dt.timezone.utc).replace(microsecond=0).isoformat(),
        "source": {
            "repository": manifest["repository"],
            "commit": source_git_commit(source),
            "subdirectory": manifest["source_subdirectory"],
            "lean_toolchain": (source / "lean-toolchain").read_text(encoding="utf-8").strip(),
            "mathlib_commit": manifest["mathlib_commit"],
            "license": manifest["license"],
        },
        "policy": {
            "status": "external-reference",
            "locally_callable": False,
            "required_for_local_use": "ASTIS-owned port or adapter plus local Lean gate and Registry entry",
            "route_tags_are": "conservative retrieval candidates, not theorem-equivalence claims",
        },
        "inventory": metadata,
        "fragments": {
            name: {
                "sha256": hashlib.sha256(payload).hexdigest(),
                "records": payload.count(b"\n"),
            }
            for name, payload in sorted(fragments.items())
        },
        "index_sha256": index_digest(fragments),
    }


def refresh(source: Path) -> dict:
    manifest = read_json(MANIFEST)
    commit = source_git_commit(source)
    if commit != manifest["pinned_commit"]:
        raise RuntimeError(f"ATLAS commit mismatch: expected {manifest['pinned_commit']}, got {commit}")
    by_book, metadata = scan_source(source)
    fragments = serialized_fragments(by_book)
    if metadata["books"] != manifest["expected_books"]:
        raise RuntimeError("ATLAS book count changed; review and update the pinned manifest")
    if metadata["source_files"] != manifest["expected_source_files"]:
        raise RuntimeError("ATLAS Lean source-file count changed; review and update the pinned manifest")
    if metadata["counts"]["named_source_declarations"] != manifest["expected_named_source_declarations"]:
        raise RuntimeError(
            "ATLAS named source-declaration count changed; review the scanner or pin: "
            f"expected {manifest['expected_named_source_declarations']}, "
            f"got {metadata['counts']['named_source_declarations']}"
        )
    INDEX_ROOT.mkdir(parents=True, exist_ok=True)
    for stale in INDEX_ROOT.glob("*.jsonl"):
        if stale.name not in fragments:
            stale.unlink()
    for name, payload in fragments.items():
        (INDEX_ROOT / name).write_bytes(payload)
    summary = build_summary(source, fragments, metadata)
    SUMMARY.write_text(json.dumps(summary, indent=2, ensure_ascii=False, sort_keys=True) + "\n", encoding="utf-8")
    return summary


def load_fragments() -> dict[str, bytes]:
    return {path.name: path.read_bytes() for path in sorted(INDEX_ROOT.glob("*.jsonl"))}


def validate_snapshot() -> tuple[dict, list[str]]:
    errors: list[str] = []
    manifest = read_json(MANIFEST)
    summary = read_json(SUMMARY)
    fragments = load_fragments()
    if set(fragments) != set(summary.get("fragments", {})):
        errors.append("fragment set differs from atlas-v1-summary.json")
    for name, payload in fragments.items():
        expected = summary.get("fragments", {}).get(name, {})
        if hashlib.sha256(payload).hexdigest() != expected.get("sha256"):
            errors.append(f"fragment digest mismatch: {name}")
        if payload.count(b"\n") != expected.get("records"):
            errors.append(f"fragment record count mismatch: {name}")
    if index_digest(fragments) != summary.get("index_sha256"):
        errors.append("combined ATLAS index digest mismatch")
    inventory = summary.get("inventory", {})
    counts = inventory.get("counts", {})
    if inventory.get("books") != manifest["expected_books"]:
        errors.append("book count does not match pinned manifest")
    if inventory.get("source_files") != manifest["expected_source_files"]:
        errors.append("source-file count does not match pinned manifest")
    if counts.get("named_source_declarations") != manifest["expected_named_source_declarations"]:
        errors.append("named declaration count does not match pinned manifest")
    source_metadata = summary.get("source", {})
    expected_source = {
        "repository": manifest["repository"],
        "commit": manifest["pinned_commit"],
        "subdirectory": manifest["source_subdirectory"],
        "lean_toolchain": manifest["lean_toolchain"],
        "mathlib_commit": manifest["mathlib_commit"],
        "license": manifest["license"],
    }
    for key, expected_value in expected_source.items():
        if source_metadata.get(key) != expected_value:
            errors.append(f"summary source {key} does not match pinned manifest")
    return summary, errors


def check(source: Path | None, require_source: bool) -> int:
    summary, errors = validate_snapshot()
    if source and source.is_dir():
        manifest = read_json(MANIFEST)
        commit = source_git_commit(source)
        if commit != manifest["pinned_commit"]:
            errors.append(f"external checkout commit mismatch: {commit}")
        else:
            by_book, metadata = scan_source(source)
            live_fragments = serialized_fragments(by_book)
            if index_digest(live_fragments) != summary.get("index_sha256"):
                errors.append("committed memory index does not match the pinned ATLAS source checkout")
            if metadata != summary.get("inventory"):
                errors.append("committed ATLAS inventory summary differs from a fresh source scan")
    elif require_source:
        errors.append(f"required ATLAS source checkout is missing: {source}")

    if CERTIFICATION.exists():
        certification = read_json(CERTIFICATION)
        if certification.get("source_commit") != summary.get("source", {}).get("commit"):
            errors.append("ATLAS build certification is for a different source commit")
        if certification.get("index_sha256") != summary.get("index_sha256"):
            errors.append("ATLAS build certification is for a different memory index")
        if certification.get("lean_toolchain") != manifest["lean_toolchain"]:
            errors.append("ATLAS certification uses a different Lean toolchain")
        if certification.get("mathlib_commit") != manifest["mathlib_commit"]:
            errors.append("ATLAS certification uses a different Mathlib commit")
        if certification.get("source_scan") != "passed":
            errors.append("ATLAS certification source scan is not passed")
        if certification.get("full_lake_build") != "passed":
            errors.append("ATLAS full Lake build is not certified as passed")
    else:
        errors.append("ATLAS build certification evidence is missing")

    if errors:
        for error in errors:
            print(f"ERROR: {error}", file=sys.stderr)
        return 1
    print(
        "ATLAS memory check passed: "
        f"{summary['inventory']['counts']['named_source_declarations']} named declarations, "
        f"{summary['inventory']['books']} books, index {summary['index_sha256'][:12]}"
    )
    return 0


def iter_records() -> Iterable[dict]:
    for path in sorted(INDEX_ROOT.glob("*.jsonl")):
        for line in path.read_text(encoding="utf-8").splitlines():
            if line:
                yield json.loads(line)


def search(args: argparse.Namespace) -> int:
    terms = [term.lower() for term in args.query]
    matches: list[dict] = []
    for record in iter_records():
        if args.route and args.route not in record["route_candidates"]:
            continue
        if args.kind and record["kind"] not in args.kind:
            continue
        if args.clean_only and record["direct_placeholders"]:
            continue
        evaluation = record.get("upstream_target_evaluation")
        if args.target_passed_only and not (evaluation and evaluation.get("passed")):
            continue
        haystack = " ".join(
            [record["book"], record["module"], record["name"], *record["topics"]]
        ).lower()
        if terms and not all(term in haystack for term in terms):
            continue
        matches.append(record)
        if len(matches) >= args.limit:
            break
    manifest = read_json(MANIFEST)
    if args.json:
        print(json.dumps(matches, indent=2, ensure_ascii=False, sort_keys=True))
    else:
        for record in matches:
            source_url = (
                f"{manifest['repository']}/blob/{manifest['pinned_commit']}/v1/"
                f"{record['file']}#L{record['line']}"
            )
            print(
                f"{record['kind']:10} {record['name']}\n"
                f"  {record['file']}:{record['line']}\n"
                f"  routes={','.join(record['route_candidates']) or '-'} "
                f"topics={','.join(record['topics']) or '-'} "
                f"direct_placeholders={','.join(record['direct_placeholders']) or 'none'}\n"
                f"  {source_url}"
            )
    return 0


def certify(source: Path) -> int:
    summary, errors = validate_snapshot()
    if errors:
        for error in errors:
            print(f"ERROR: {error}", file=sys.stderr)
        return 1
    manifest = read_json(MANIFEST)
    commit = source_git_commit(source)
    if commit != manifest["pinned_commit"]:
        print(f"ERROR: checkout is {commit}, expected {manifest['pinned_commit']}", file=sys.stderr)
        return 1
    by_book, metadata = scan_source(source)
    if index_digest(serialized_fragments(by_book)) != summary["index_sha256"]:
        print("ERROR: source scan differs from committed index", file=sys.stderr)
        return 1
    if metadata != summary["inventory"]:
        print("ERROR: source inventory differs from committed summary", file=sys.stderr)
        return 1
    started = dt.datetime.now(dt.timezone.utc)
    completed = subprocess.run(["lake", "build"], cwd=source)
    if completed.returncode != 0:
        print("ERROR: ATLAS full lake build failed", file=sys.stderr)
        return completed.returncode
    finished = dt.datetime.now(dt.timezone.utc)
    evidence = {
        "schema_version": 1,
        "certified_at": finished.replace(microsecond=0).isoformat(),
        "source_commit": commit,
        "source_subdirectory": "v1",
        "lean_toolchain": (source / "lean-toolchain").read_text(encoding="utf-8").strip(),
        "mathlib_commit": manifest["mathlib_commit"],
        "index_sha256": summary["index_sha256"],
        "source_scan": "passed",
        "full_lake_build": "passed",
        "command": "lake build",
        "elapsed_seconds": round((finished - started).total_seconds(), 3),
        "truth_boundary": "This certifies the pinned upstream checkout under its own toolchain. Every record remains external-reference until an ASTIS-owned declaration passes the ASTIS Lean gate.",
    }
    CERTIFICATION.write_text(
        json.dumps(evidence, indent=2, ensure_ascii=False, sort_keys=True) + "\n",
        encoding="utf-8",
    )
    print(f"ATLAS certification passed in {evidence['elapsed_seconds']} seconds")
    return 0


def parser() -> argparse.ArgumentParser:
    result = argparse.ArgumentParser(description=__doc__)
    subparsers = result.add_subparsers(dest="command", required=True)
    refresh_parser = subparsers.add_parser("refresh", help="rebuild the committed metadata index")
    refresh_parser.add_argument("--source", type=Path, default=DEFAULT_SOURCE)
    check_parser = subparsers.add_parser("check", help="validate snapshot, evidence, and optional source")
    check_parser.add_argument("--source", type=Path, default=DEFAULT_SOURCE)
    check_parser.add_argument("--require-source", action="store_true")
    search_parser = subparsers.add_parser("search", help="search external declaration memory")
    search_parser.add_argument("query", nargs="*")
    search_parser.add_argument(
        "--route",
        choices=("samplewiki-route", "riemannian-optimization", "optimisation"),
    )
    search_parser.add_argument("--kind", action="append")
    search_parser.add_argument("--clean-only", action="store_true")
    search_parser.add_argument("--target-passed-only", action="store_true")
    search_parser.add_argument("--limit", type=int, default=20)
    search_parser.add_argument("--json", action="store_true")
    certify_parser = subparsers.add_parser("certify", help="run source scan and full upstream Lake build")
    certify_parser.add_argument("--source", type=Path, default=DEFAULT_SOURCE)
    return result


def main() -> int:
    args = parser().parse_args()
    if args.command == "refresh":
        summary = refresh(args.source.resolve())
        print(
            f"wrote {summary['inventory']['counts']['named_source_declarations']} "
            f"ATLAS declaration records in {summary['inventory']['books']} fragments"
        )
        return 0
    if args.command == "check":
        source = args.source.resolve() if args.source else None
        return check(source, args.require_source)
    if args.command == "search":
        return search(args)
    if args.command == "certify":
        return certify(args.source.resolve())
    raise AssertionError(args.command)


if __name__ == "__main__":
    raise SystemExit(main())
