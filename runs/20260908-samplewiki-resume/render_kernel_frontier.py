"""Render this run's shared-kernel slice from Frontier Cell evidence.

SVG is dependency-free; optional Pillow produces a matching inspection PNG.
This is a local-proof snapshot, not root-build or publication certification.
"""
from pathlib import Path
import html
import json
import sys
import textwrap

ROOT = Path(__file__).resolve().parents[2]
OUT = Path(__file__).resolve().parent
CELLS = ROOT / "research-wiki/frontier-cells"
BLUE, RED, GRAY = "#155eef", "#b42318", "#475467"


def node(label, x, y, cell=None, color=GRAY):
    if cell:
        record = json.loads((CELLS / (cell + ".json")).read_text(encoding="utf-8"))
        proved = record["status"] in {
            "proved_locally", "independently_verified", "stabilized", "merged"
        } and bool(record["evidence"]["focused_checks"])
        color = BLUE if proved else RED
        label += "\n" + record["status"].replace("_", " ")
    return dict(label=label, x=x, y=y, color=color)


nodes = [
    node("Mathlib: invariant composition", 25, 100),
    node("Finite kernel powers", 355, 100, "ASTIS-SHARED-kernel-invariant-powers"),
    node("Mathlib: disintegration", 25, 270),
    node("Product conditional-law adapter", 355, 270, "ASTIS-SHARED-conditional-resampling-law"),
    node("One-block heat-bath invariance", 685, 270, "ASTIS-SHARED-heat-bath-snd-invariance"),
    node("Focused test consumer:\nfinite heat-bath powers", 685, 100),
    node("Mathlib: finite sums\nand constant densities", 25, 440),
    node("Fixed finite kernel mixture", 355, 440, "ASTIS-SHARED-finite-kernel-mixture"),
    node("Focused test consumer:\nidentity / heat-bath mixture", 685, 440),
    node("TODO: concrete random-scan\nGibbs model integration", 355, 610, color=RED),
]
# Selected actual proof/test inputs, not route-order implications. In particular
# heat-bath and powers are not proof parents of finiteMixture_invariant.
edges = [(0, 1, False), (2, 3, False), (3, 4, False),
         (1, 5, False), (4, 5, False), (6, 7, False),
         (7, 8, False), (4, 8, False), (7, 9, True)]
artifact = "shared-kernel-frontier"
heading = "ASTIS shared-kernel frontier"
caption = "Selected proof/test inputs. Local evidence only; root integration and publication are separate gates."
height = 800
if "--transport" in sys.argv:
    artifact = "kernel-transport-frontier"
    heading = "ASTIS transport checkpoint (31fe8f2)"
    caption = "Historical pre-coordinate packet. See coordinate-heat-bath-frontier.svg for current residuals."
    nodes = [
        node("Mathlib: map/comap and\ninverse pushforwards", 25, 100),
        node("Measurable-equivalence\ninvariance transport", 355, 100,
             "ASTIS-SHARED-kernel-invariant-transport"),
        node("One-block heat-bath invariance", 25, 270,
             "ASTIS-SHARED-heat-bath-snd-invariance"),
        node("Focused test:\ncoordinate-conjugated update", 355, 270),
        node("Mathlib: finite-coordinate\nsplitting equivalence", 685, 100),
        node("Fixed finite kernel mixture", 25, 440,
             "ASTIS-SHARED-finite-kernel-mixture"),
        node("Focused test: fixed scan\nand finite powers", 355, 440),
        node("Finite kernel powers", 685, 440,
             "ASTIS-SHARED-kernel-invariant-powers"),
        node("TODO: retained-coordinate law\nand source-facing update", 355, 610, color=RED),
    ]
    # Selected direct theorem/test inputs. Tests are not proof prerequisites of
    # other tests or of the separate remaining operational/source contract.
    edges = [(0, 1, False), (1, 3, False), (2, 3, False),
             (4, 3, False), (5, 6, False), (7, 6, False)]
if "--coordinate" in sys.argv:
    artifact = "coordinate-heat-bath-frontier"
    heading = "ASTIS operational coordinate-update slice"
    caption = "Selected proof/test inputs. Local evidence only; root integration and publication are separate gates."
    height = 980
    nodes = [
        node("Mathlib: coordinate split,\nmarginals and a.e. transport", 25, 100),
        node("One-block heat-bath invariance", 355, 100,
             "ASTIS-SHARED-heat-bath-snd-invariance"),
        node("Measurable-equivalence\ninvariance transport", 685, 100,
             "ASTIS-SHARED-kernel-invariant-transport"),
        node("Coordinate heat-bath\nretained-coordinate equality", 355, 270,
             "ASTIS-SHARED-coordinate-heat-bath"),
        node("Fixed finite kernel mixture", 25, 440,
             "ASTIS-SHARED-finite-kernel-mixture"),
        node("Finite kernel powers", 685, 440,
             "ASTIS-SHARED-kernel-invariant-powers"),
        node("Focused consumer: fixed scan\nand finite powers", 355, 440),
        node("TODO: source correspondence\nand independent repair review", 25, 610, color=RED),
        node("TODO: supported Gibbs model\nand null-fiber contract", 685, 610, color=RED),
        node("TODO: reversibility", 25, 780, color=RED),
        node("TODO: quantitative mixing", 685, 780, color=RED),
    ]
    # One canonical integration packet, not one new leaf per adapter. The four
    # red obligations are separate residual contracts, not implied by invariance.
    edges = [(0, 3, False), (1, 3, False), (2, 3, False),
             (3, 6, False), (4, 6, False), (5, 6, False)]
if "--positive-fiber" in sys.argv:
    artifact = "positive-fiber-frontier"
    heading = "ASTIS positive-fiber conditional-law slice"
    caption = "One existing kernel, one positive-fiber law. Source fidelity and publication are separate gates."
    height = 980
    nodes = [
        node("Canonical coordinate heat-bath\nand one-block evaluation", 25, 100,
             "ASTIS-SHARED-coordinate-heat-bath"),
        node("Mathlib: atomic conditional law\nand normalized restriction", 685, 100),
        node("Positive-fiber law:\nactual kernel = conditional target", 355, 270,
             "ASTIS-SHARED-coordinate-heat-bath-positive-fiber"),
        node("Focused finite-state consumer:\ntransition ratios / null exclusion", 355, 440),
        node("TODO: exact source alignment\nand separate copy-index repair", 25, 610, color=RED),
        node("TODO: supported Gibbs model\nand scan integration", 685, 610, color=RED),
        node("TODO: reversibility", 25, 780, color=RED),
        node("TODO: quantitative mixing", 685, 780, color=RED),
    ]
    # The positive-fiber law deliberately has no null-fiber conclusion. Red
    # source/model/mixing contracts are not mathematical consequences of a
    # green focused build or of an independently reviewed semantic diagnosis.
    edges = [(0, 2, False), (1, 2, False), (2, 3, False)]
svg = [f'<svg xmlns="http://www.w3.org/2000/svg" width="1020" height="{height}" viewBox="0 0 1020 {height}">',
       f'<rect width="1020" height="{height}" fill="white"/>',
       '<defs><marker id="arrow" markerWidth="9" markerHeight="9" refX="8" refY="3" orient="auto"><path d="M0,0 L0,6 L8,3 z" fill="#667085"/></marker></defs>']
canvas = draw = font = small = title = None
try:
    from PIL import Image, ImageDraw, ImageFont
    canvas = Image.new("RGB", (1020, height), "white")
    draw = ImageDraw.Draw(canvas)
    font = ImageFont.truetype("segoeui.ttf", 17)
    small = ImageFont.truetype("segoeui.ttf", 15)
    title = ImageFont.truetype("segoeuib.ttf", 24)
except (ImportError, OSError):
    canvas = draw = None


def text(x, y, value, size=17, color="#101828"):
    svg.append(f'<text x="{x}" y="{y}" font-family="Segoe UI,Arial,sans-serif" font-size="{size}" fill="{color}">{html.escape(value)}</text>')
    if draw:
        draw.text((x, y - size), value, fill=color,
                  font=title if size == 24 else small if size == 15 else font)


text(25, 38, heading, 24)
text(25, 66, caption, 15)
for a, b, planned in edges:
    n, m = nodes[a], nodes[b]
    if n["x"] == m["x"]:
        start = (n["x"] + 145, n["y"] if m["y"] < n["y"] else n["y"] + 104)
        end = (m["x"] + 145, m["y"] + 104 if m["y"] < n["y"] else m["y"])
    elif n["x"] < m["x"]:
        start, end = (n["x"] + 290, n["y"] + 52), (m["x"], m["y"] + 52)
    else:
        start, end = (n["x"], n["y"] + 52), (m["x"] + 290, m["y"] + 52)
    dash = ' stroke-dasharray="6 5"' if planned else ""
    svg.append(f'<path d="M{start[0]},{start[1]} L{end[0]},{end[1]}" stroke="#667085" stroke-width="2" fill="none" marker-end="url(#arrow)"{dash}/>')
    if draw:
        if planned:
            for y in range(start[1], end[1], 12):
                draw.line((start[0], y, start[0], min(y + 6, end[1])), fill=GRAY, width=2)
        else:
            draw.line((*start, *end), fill=GRAY, width=2)
        ex, ey = end
        dx, dy = ex - start[0], ey - start[1]
        back = -8 if dx > 0 else 8
        pts = [(ex, ey), (ex + back, ey - 4), (ex + back, ey + 4)] if dx else [(ex, ey), (ex - 4, ey + (8 if dy < 0 else -8)), (ex + 4, ey + (8 if dy < 0 else -8))]
        draw.polygon(pts, fill=GRAY)
for n in nodes:
    x, y, color = n["x"], n["y"], n["color"]
    svg.append(f'<rect x="{x}" y="{y}" width="290" height="104" rx="10" fill="white" stroke="{color}" stroke-width="2"/>')
    if draw:
        draw.rounded_rectangle((x, y, x + 290, y + 104), radius=10, outline=color, width=2)
    lines = [line for part in n["label"].splitlines() for line in textwrap.wrap(part, 30)]
    for j, line in enumerate(lines):
        text(x + 13, y + 27 + 23 * j, line, color=color)
text(25, height - 46, "Blue: ASTIS-owned, focused-compiled. Gray: external API / test consumer. Red: TODO.", 15)
text(25, height - 22, "No mixing, concrete Gibbs density, general-state MH, or continuous-time invariance is concluded.", 15)
svg.append("</svg>")
(OUT / (artifact + ".svg")).write_text("\n".join(svg) + "\n", encoding="utf-8", newline="\n")
if canvas:
    canvas.save(OUT / (artifact + ".png"))
print(f"Rendered {artifact}.svg" + (" and inspection PNG" if canvas else " (Pillow/font unavailable)"))
