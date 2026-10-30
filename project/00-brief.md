# 00 — Project brief

**Gate G0:** approved 2026-10-30 by human.

## Quick fill

- **Project:** DevOpt (Agent Project Framework)
- **Owner:** human
- **One-liner:** A portable operating system for AI-assisted product work that structures input, gates output, and spends fewer tokens.
- **Problem:** Coding agents re-read the repo, guess requirements, mix frontend and backend, and ship to production without a human gate — wasting tokens and creating unreviewable diffs.
- **Outcome:** Any agent reading `AGENTS.md` loads a context pack, stays on one git track, and cannot promote to production unless a human says so.
- **In scope:** Phase/gate model, skills, stack profiles (React/Vite/Netlify, Django default, FastAPI/Nest opt-in), promotion-track git, context packs, adapters, doctor/token-audit.
- **Out of scope:** Application product code, hosted control plane, a new agent runtime.
- **Constraints:** `AGENTS.md` ≤140 lines; skill body ≤200 lines; baseline ≤3500 tokens; bash-only scripts; no extra runtime.
- **Stop if:** Baseline tokens exceed budget or agents ignore packs and re-explore the repo.

**Approved by:** human on 2026-10-30
