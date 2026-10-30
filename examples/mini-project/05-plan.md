# 05 — Development plan

## Summary

- **Target:** v0.1 in 3 weeks
- **Capacity:** 1 developer + agents
- **Critical path:** T-001 → T-002 → T-003 → T-004

## M1 — Capture works (v0.1)

- **Demo:** press `N`, type, reload, note is still there; go offline and repeat.
- **Exit:** E2E green, staging deployed, no P0.
- **Tasks:** T-001, T-002, T-003, T-004

## M2 — Retrieve works (v0.2)

- **Demo:** search 500 notes and open a result in <300 ms.
- **Exit:** search benchmark green.
- **Tasks:** T-005, T-006

## Task table

| ID | Task | Size | Depends | Parallel-safe | Status |
|---|---|---|---|---|---|
| T-001 | notes table + migration | S | — | yes | done |
| T-002 | POST /notes + validation | S | T-001 | no | done |
| T-003 | capture form + optimistic save | M | T-002 | no | in-progress |
| T-004 | E2E: empty, valid, offline reload | M | T-003 | no | todo |
| T-005 | search index + endpoint | M | T-001 | yes | todo |
| T-006 | search UI + debounce | S | T-005 | no | todo |

## Risks

| ID | Risk | Impact | Mitigation |
|---|---|---|---|
| RISK-001 | IndexedDB quota varies | medium | cap local history; warn at 80% |
| RISK-002 | conflict UX confuses users | medium | keep local copy; add banner in v0.2 |

## Buffers

- Known work: 6 days
- Integration/review: +2 days
- Release: 1 day

## Review and release

- **Reviewer:** sam
- **Checks:** `pnpm test`, `pnpm lint`, `pnpm build`
- **Release window:** 2026-11-06
- **Rollback:** disable `capture_v1` flag; list remains read-only
