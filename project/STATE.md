---
project: "DevOpt"
phase: 5-build
phase_name: "Build"
status: in-progress
updated: "2026-10-30"
owner: "human"
gates:
  G0: approved 2026-10-30 by human
  G1: approved 2026-10-30 by human
  G2: approved 2026-10-30 by human
  G3: approved 2026-10-30 by human
  G4: approved 2026-10-30 by human
  G5: approved 2026-10-30 by human (PR #1 and #2 merged to main)
  G6: pending
next_action: "Ship v1.1.2 portal (Phase 0 prompt + Studio 1028); merge to main."
---

# Project state

> Single source of truth for **where we are**. Agents read this first. Keep it under one screen.

## Current focus

v1.1.2 portal: copyable Phase 0 prompt, Studio 1028 branding. Installer live at `devopt.udithsandaruwan.com`.

## Gate log

| Gate | Status | Date | Approved by | Notes |
|---|---|---|---|---|
| G0 Brief | approved | 2026-10-30 | human | `00-brief.md` |
| G1 Discovery | approved | 2026-10-30 | human | `01-discovery.md` |
| G2 Product | approved | 2026-10-30 | human | PRD + catalog |
| G3 Architecture | approved | 2026-10-30 | human | ADRs 0001–0003 |
| G4 Plan / build | approved | 2026-10-30 | human | plan executed |
| G5 Merge | approved | 2026-10-30 | human | PR #1 and #2 on `main` |
| G6 Release | pending | | | |

## Blockers

- none

## Recent decisions

| Date | Decision | ADR |
|---|---|---|
| 2026-10-30 | Promotion-track git (4 long-lived + main) | `04-adr/0001-promotion-tracks.md` |
| 2026-10-30 | Django default; Nest/FastAPI opt-in | `04-adr/0002-stack-profiles.md` |
| 2026-10-30 | Context packs as the load allowlist | `04-adr/0003-context-packs.md` |

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
