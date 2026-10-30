---
project: "Pocket Notes"
phase: 5-build
phase_name: "Build"
status: active
updated: "2026-10-30"
owner: "sam"
gates:
  G0: approved 2026-10-20 by sam
  G1: approved 2026-10-22 by sam
  G2: approved 2026-10-25 by sam
  G3: approved 2026-10-27 by sam
  G4: approved 2026-10-28 by sam
  G5: pending
  G6: pending
next_action: "Implement T-003 (capture form + optimistic save)"
---

# Project state

## Current focus

T-003: capture form with optimistic save. T-001 (schema) and T-002 (API) are merged.

## Blockers

- None.

## Recent decisions

| Date | Decision | ADR |
|---|---|---|
| 2026-10-27 | Local-first storage with IndexedDB + background sync | `0001-local-first-storage.md` |

## Next action

Implement T-003; verify offline draft restore before moving to T-004.
