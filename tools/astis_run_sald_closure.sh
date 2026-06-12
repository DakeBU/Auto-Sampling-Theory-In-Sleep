#!/usr/bin/env bash
set -u

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
HOURS="${ASTIS_HOURS:-6}"
WALL_HOURS="${ASTIS_WALL_HOURS:-24}"
LOWER_COUNT="${ASTIS_LOWER_COUNT:-3}"
MAX_CYCLES="${ASTIS_MAX_CYCLES:-64}"
UPPER_PANEL_INNER="${ASTIS_UPPER_PANEL_INNER:-0}"
UPPER_PANEL_FINAL="${ASTIS_UPPER_PANEL_FINAL:-1}"
MIDDLE_PANEL_INNER="${ASTIS_MIDDLE_PANEL_INNER:-0}"
MIDDLE_PANEL_FINAL="${ASTIS_MIDDLE_PANEL_FINAL:-1}"
REVIEWER_WASTE_INNER="${ASTIS_REVIEWER_WASTE_INNER:-0}"
REVIEWER_WASTE_FINAL="${ASTIS_REVIEWER_WASTE_FINAL:-1}"

cd "$ROOT" || exit 1

args=(
  --hours "$HOURS"
  --wall-hours "$WALL_HOURS"
  --lower-count "$LOWER_COUNT"
  --max-cycles "$MAX_CYCLES"
)

if [ "$UPPER_PANEL_INNER" != "0" ]; then
  args+=(--upper-panel-inner)
fi
if [ "$UPPER_PANEL_FINAL" = "0" ]; then
  args+=(--no-upper-panel-final)
fi
if [ "$MIDDLE_PANEL_INNER" != "0" ]; then
  args+=(--middle-panel-inner)
fi
if [ "$MIDDLE_PANEL_FINAL" = "0" ]; then
  args+=(--no-middle-panel-final)
fi
if [ "$REVIEWER_WASTE_INNER" != "0" ]; then
  args+=(--reviewer-waste-inner)
fi
if [ "$REVIEWER_WASTE_FINAL" = "0" ]; then
  args+=(--no-reviewer-waste-final)
fi

echo "[$(date)] ASTIS SALD closure launch"
echo "hours=$HOURS wall_hours=$WALL_HOURS lower_count=$LOWER_COUNT max_cycles=$MAX_CYCLES"
echo "upper_panel_inner=$UPPER_PANEL_INNER upper_panel_final=$UPPER_PANEL_FINAL"
echo "middle_panel_inner=$MIDDLE_PANEL_INNER middle_panel_final=$MIDDLE_PANEL_FINAL"
echo "reviewer_waste_inner=$REVIEWER_WASTE_INNER reviewer_waste_final=$REVIEWER_WASTE_FINAL"

exec python3 tools/astis.py launch-sald-6h "${args[@]}"
