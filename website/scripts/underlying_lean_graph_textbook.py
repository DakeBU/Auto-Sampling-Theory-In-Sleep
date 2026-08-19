"""Project the Chewi edition and compiled Samplinglib inventory into graph nodes."""

from __future__ import annotations

from typing import Any

from underlying_lean_graph_model import GraphBuilder, ROOTS, ROOT_MAP, section_url, slug, status


def add_textbook(builder: GraphBuilder, site: dict[str, Any]) -> dict[str, Any]:
    add, edge = builder.add, builder.edge
    add("library:samplinglib", "library", "Samplinglib", status="partial", subtitle="Lean 4 formal library", summary="Shared formal substrate for Chewi's twelve chapters and frontier sampling results.", url="index.html")
    add("library:chewi", "library", "Log-Concave Sampling", status="partial", subtitle="Sinho Chewi · 12 chapters", summary="Textbook theorem order projected onto the reusable Lean dependency graph.", url="textbook/index.html")
    add("library:samplewiki", "library", "SampleWiki frontier", status="partial", subtitle="34 tracked results · 7 settings", summary="Current upper bounds, lower bounds, literature-open gaps, and audited primary-source proofs.", url="example-cases/samplewiki.html")
    edge("library:samplinglib", "library:chewi", "formalizes")
    edge("library:samplinglib", "library:samplewiki", "formalizes")

    for key, label, chapters, _ in ROOTS:
        root_id = add(f"root:{key}", "proof-root", label, status="shared", subtitle="shared mathematical root", summary=f"Reusable branch across Chewi Chapters {', '.join(map(str, chapters))}.")
        edge("library:samplinglib", root_id, "contains")

    chapter_ids: dict[int, str] = {}
    for chapter in site.get("chapters", []):
        number = int(chapter.get("number", 0))
        node_id = add(
            f"chapter:{number:02d}", "chapter", f"Chapter {number}. {chapter.get('title', '')}",
            status=status(chapter.get("status")), subtitle=chapter.get("source_pages", ""), summary=chapter.get("goal", ""),
            url=f"textbook/chapter-{number:02d}.html",
            details=[
                {"label": "Source sections", "value": " · ".join(chapter.get("source_sections", []))},
                {"label": "Lean modules", "value": " · ".join(chapter.get("lean_modules", []))},
                {"label": "Blockers", "value": " · ".join(chapter.get("blockers", []))},
                {"label": "Consumers", "value": " · ".join(chapter.get("consumers", []))},
            ],
        )
        chapter_ids[number] = node_id
        edge("library:chewi", node_id, "chapter")
        if number > 1:
            edge(chapter_ids[number - 1], node_id, "book-order")
        for key, (_, chapters, _) in ROOT_MAP.items():
            if number in chapters:
                edge(f"root:{key}", node_id, "supports")

    module_ids: dict[str, str] = {}
    for module in site.get("modules", []):
        name = str(module.get("name", ""))
        module_ids[name] = add(
            f"module:{name}", "module", name, status="compiled", subtitle=module.get("role", "Lean module"),
            summary=f"{module.get('declaration_count', 0)} declarations; imports {len(module.get('imports', []))} modules.",
            url=module.get("page", ""), details=[{"label": "Source file", "value": module.get("source_file", "")}, {"label": "Imports", "value": " · ".join(module.get("imports", []))}],
        )
        edge("library:samplinglib", module_ids[name], "module")
    for module in site.get("modules", []):
        target = module_ids.get(str(module.get("name", "")))
        for imported in module.get("imports", []):
            source = module_ids.get(str(imported))
            if source and target:
                edge(source, target, "imports")

    decl_ids: dict[str, str] = {}
    registry = site.get("registry_declarations", [])
    for declaration in registry:
        name = str(declaration.get("local_decl", ""))
        decl_ids[name] = add(
            f"decl:{name}", "declaration", name, status=status(declaration.get("status")), subtitle=declaration.get("key", "registry declaration"),
            summary=" · ".join(declaration.get("tags", [])), url=declaration.get("card", ""),
            details=[{"label": "Source", "value": f"{declaration.get('source_file', '')}:{declaration.get('source_line', '')}"}, {"label": "Dependencies", "value": " · ".join(declaration.get("dependencies", []))}, {"label": "Consumers", "value": " · ".join(declaration.get("consumers", []))}],
        )
        module_name = name.rsplit(".", 1)[0]
        if module_name in module_ids:
            edge(module_ids[module_name], decl_ids[name], "declares")
    for declaration in registry:
        target = decl_ids.get(str(declaration.get("local_decl", "")))
        for dependency in declaration.get("dependencies", []):
            source = decl_ids.get(str(dependency))
            if source and target:
                edge(source, target, "depends-on")

    source_ids: dict[str, str] = {}
    for claim in site.get("source_correspondence", []):
        source_key = str(claim.get("id", ""))
        chapter = int(claim.get("chapter", 0))
        node_id = add(
            f"source:{source_key}", "source-claim", claim.get("source_kind", source_key), status=status(claim.get("status")),
            subtitle=f"Chewi §{claim.get('section', '')} · {claim.get('page', '')}", summary=claim.get("source_summary", ""),
            formula=claim.get("latex_statement", ""), url=section_url(chapter, str(claim.get("section", ""))) + f"#source-{source_key}", source_url=claim.get("source_url", ""),
            details=[
                {"label": "Formal assumptions", "value": " · ".join(claim.get("formal_assumptions", []))},
                {"label": "Lean declarations", "value": " · ".join(claim.get("lean_declarations", []))},
                {"label": "Remaining obligations", "value": " · ".join(claim.get("remaining_obligations", [])) or "none"},
                {"label": "Downstream consumers", "value": " · ".join(claim.get("downstream_consumers", []))},
            ],
        )
        source_ids[source_key] = node_id
        if chapter in chapter_ids:
            edge(chapter_ids[chapter], node_id, "contains theorem")
        for declaration in claim.get("lean_declarations", []):
            name = str(declaration)
            if name not in decl_ids:
                decl_ids[name] = add(f"decl:{name}", "declaration", name, status="compiled", subtitle="source-correspondence declaration", summary="Exact Lean declaration named by an audited textbook source claim.")
            edge(decl_ids[name], node_id, "formalizes")
        for leaf in claim.get("proof_leaves", []):
            leaf_id = add(
                f"proof:{source_key}:{leaf.get('node_id', slug(leaf.get('label', 'leaf')))}", "proof-leaf", leaf.get("label", "proof leaf"),
                status=status(leaf.get("route_status")), subtitle=f"proof leaf for {claim.get('source_kind', '')}", summary=" · ".join(leaf.get("declarations", [])),
                details=[{"label": "Dependencies", "value": " · ".join(leaf.get("dependencies", []))}, {"label": "Declarations", "value": " · ".join(leaf.get("declarations", []))}],
            )
            edge(leaf_id, node_id, "proof route")
            for declaration in leaf.get("declarations", []):
                name = str(declaration)
                for full, declaration_id in decl_ids.items():
                    if full == name or full.endswith("." + name):
                        edge(declaration_id, leaf_id, "closes leaf")

    return {"chapter_ids": chapter_ids, "module_ids": module_ids, "decl_ids": decl_ids, "source_ids": source_ids, "registry": registry}
