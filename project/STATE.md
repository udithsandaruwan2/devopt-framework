---
project: "DevOpt"
phase: 7-operate
phase_name: "Operate"
status: stable
updated: "2026-11-10"
owner: "human"
gates:
  G0: approved 2026-10-30 by human
  G1: approved 2026-10-30 by human
  G2: approved 2026-10-30 by human
  G3: approved 2026-10-30 by human
  G4: approved 2026-10-30 by human
  G5: approved 2026-11-10 by human (PR #8 merged)
  G6: approved 2026-11-10 by human (tag v1.4.0)
next_action: "Bootstrap a product with v1.4.0; confirm graphify query + update loop in Cursor; gather token feedback."
---

# Project state

> Single source of truth for **where we are**. Agents read this first. Keep it under one screen.

## Current focus

v1.4.0 shipped: Graphify knowledge-graph integration (bootstrap + query-first + update-after-change). Collect product feedback on token spend.

## Gate log

| Gate | Status | Date | Approved by | Notes |
|---|---|---|---|---|
| G0 Brief | approved | 2026-10-30 | human | `00-brief.md` |
| G1 Discovery | approved | 2026-10-30 | human | `01-discovery.md` |
| G2 Product | approved | 2026-10-30 | human | PRD + catalog |
| G3 Architecture | approved | 2026-10-30 | human | ADRs 0001–0004 |
| G4 Plan / build | approved | 2026-10-30 | human | plan executed |
| G5 Merge | approved | 2026-11-10 | human | PR #8 on `main` |
| G6 Release | approved | 2026-11-10 | human | tag `v1.4.0` |

## Blockers

- none

## Recent decisions

| Date | Decision | ADR |
|---|---|---|
| 2026-10-30 | Promotion-track git (4 long-lived + main) | `04-adr/0001-promotion-tracks.md` |
| 2026-10-30 | Django default; Nest/FastAPI opt-in | `04-adr/0002-stack-profiles.md` |
| 2026-10-30 | Context packs as the load allowlist | `04-adr/0003-context-packs.md` |
| 2026-11-10 | Graphify for code-map token reduction | `04-adr/0004-graphify-knowledge-graph.md` |

## Next action

See `next_action` in the frontmatter. Update both together when the action changes.

## Links

- Brief: `00-brief.md`
- PRD: `02-prd.md`
- Catalog: `02-product-catalog.md`
- Plan: `05-plan.md`
- Specs: `06-specs/`
- Handoffs: `handoffs/`

## Rules for updating this file

- Update at every phase change, gate approval, blocker, and handoff.
- Keep the body short; detail belongs in the artifact.
- The YAML frontmatter is machine-readable; keep keys stable.
- Never mark a gate `approved` without human approval.
