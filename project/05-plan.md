# 05 — Plan

**Gate G4:** approved 2026-10-30 by human. First slice executed in the 2026-10-30 session.

## M1 — Token-cheap operating system (this cycle)

Outcome: an agent can follow promotion-track git and load one stack profile without reading the rest of the repo.

| ID | Task | Size | Status |
|---|---|---|---|
| T-001 | Promotion git + `promote.sh` + git-steward/docs | M | done-uncommitted |
| T-002 | Stack profiles + `apply-profile.sh` | M | done-uncommitted |
| T-003 | Context packs + `context-pack.sh` | S | done-uncommitted |
| T-004 | Wire doctor/audit/bootstrap/README/CHANGELOG | M | done-uncommitted |
| T-005 | Fill `project/` artifacts and ADRs | S | done-uncommitted |
| T-006 | `sync-adapters` + `doctor` + `token-audit --strict` | S | in progress |

## First slice

T-001 → T-002 → T-003, then T-004–T-006.

## Later

- Human commit
- Create the four long-lived branches when this is used as a product repo
- Optional: generate OpenAPI contract slice between api and web
