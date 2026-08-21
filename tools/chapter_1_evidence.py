#!/usr/bin/env python3
"""Run the Chapter 1 evidence check with the canonical Lean source scanner.

The public website already installs ``astis_site_source_index`` before Registry
enrichment.  The formalization workflow must do the same: otherwise the legacy
``astis_site.source_index`` parser treats dotted local names such as
``LogConcaveOn.mul`` as fully qualified and loses their enclosing namespaces.
Once a second dotted declaration with the same short name exists, the legacy
short-name fallback becomes ambiguous even though all Lean declarations compile.

This wrapper changes no evidence threshold and duplicates no evidence logic. It
only installs the canonical source-index adapter and then delegates to the
stable ``astis.cmd_chapter_1_check`` implementation.
"""

from __future__ import annotations

import argparse

import astis
import astis_site
import astis_site_source_index


def main() -> int:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--require-complete", action="store_true")
    args = parser.parse_args()

    astis_site_source_index.install(astis_site)
    return astis.cmd_chapter_1_check(args)


if __name__ == "__main__":
    raise SystemExit(main())
