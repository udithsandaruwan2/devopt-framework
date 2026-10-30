# 02 — PRD

**Gate G2:** approved 2026-10-30 by human.

## Summary

DevOpt is the operating system for this team's AI-assisted development: structured intake, phase gates, four-track git, and stack profiles that load only when the task needs them.

## Primary metric

Tokens per merged, correct change — down. Guardrail: rework rate must not rise.

## Requirements

| ID | Requirement | Test |
|---|---|---|
| REQ-001 | Agent session starts at `STATE.md`, then a context pack | Fresh session names both |
| REQ-002 | Frontend and backend use separate git tracks | `promote.sh` + `docs/07` |
| REQ-003 | Production promote is human-gated | dry-run default; `--apply` documented |
| REQ-004 | Stack detail is not in `AGENTS.md` | profiles + nested AGENTS.md |
| REQ-005 | `AGENTS.md` ≤140 lines; baseline ≤3500 tokens | `token-audit.sh --strict` |
| REQ-006 | Adapters stay generated from one source | `sync-adapters.sh` |

## Out of scope

- Building a customer-facing app inside this repo
- Changing the 12-skill set into dozens of tiny skills
- Auto-merging to production
