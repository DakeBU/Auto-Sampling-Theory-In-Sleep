from __future__ import annotations

"""Canonical source-index adapter for the Samplinglib website.

`astis_site.scan_project_sources()` is the newer declaration scanner: it keeps
namespace context when a declaration uses a dotted local name such as
`theorem LogConcaveOn.mul`.  The older `astis_site.source_index()` has an
independent parser that treats every dotted declaration name as already fully
qualified, so it can silently drop the surrounding namespace.

The website Registry enrichment should use the same parsed declarations as the
rest of the site inventory.  Keeping this adapter separate lets the build and
check entrypoints share one fix without duplicating parsing rules again.
"""

from typing import Any


def source_index_from_project_scan(astis_site_module: Any) -> tuple[dict[str, dict[str, object]], dict[str, str]]:
    modules, declarations = astis_site_module.scan_project_sources()

    indexed: dict[str, dict[str, object]] = {}
    module_files: dict[str, str] = {}

    # Match the historical source_index scope: production files below the
    # AutoSamplingTheory/ directory, excluding Tests and the root aggregator.
    for module in modules:
        if module.source_file.startswith("AutoSamplingTheory/"):
            module_files[module.name] = module.source_file

    for declaration in declarations:
        if not declaration.source_file.startswith("AutoSamplingTheory/"):
            continue
        indexed[declaration.full_name] = {
            "full_name": declaration.full_name,
            "short_name": declaration.short_name,
            "file": declaration.source_file,
            "line": declaration.source_line,
            "module": declaration.module,
            "source_text": declaration.source_text,
            "docstring": declaration.docstring,
        }

    return indexed, module_files


def install(astis_site_module: Any) -> None:
    """Make Registry enrichment reuse the canonical project source scan."""

    astis_site_module.source_index = lambda: source_index_from_project_scan(astis_site_module)
