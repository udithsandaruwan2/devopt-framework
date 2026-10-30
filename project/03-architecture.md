# 03 — Architecture

**Gate G3:** approved 2026-10-30 by human.

## System shape

```
AGENTS.md (Tier 0)
  → skills (Tier 1, trigger)
  → one profile + one pack + one project artifact (Tier 2)
scripts/  = deterministic (promote, pack, doctor, audit, sync)
project/  = living truth
apps/*    = only in bootstrapped products
```

## Decisions

| Decision | Choice | ADR |
|---|---|---|
| Git | Promotion tracks | 0001 |
| Stack encoding | On-demand profiles | 0002 |
| What to load | Context packs | 0003 |

## Boundaries

- Framework source has no `apps/`. Product repos get `apps/web` + `apps/api`.
- Default API is Django + DRF. FastAPI and Nest are named opt-in profiles.
- Frontend deployable ≠ backend deployable. Contract is the HTTP API, not a shared database.
