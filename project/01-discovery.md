# 01 — Discovery

**Gate G1:** approved 2026-10-30 by human.

## Problem evidence

- Unstructured agent sessions explore the whole repo, then rewrite. Rework is the expensive failure mode (see `docs/13-research-notes.md`).
- Split frontend/backend products deploy independently (Netlify vs API). A single `develop` branch mixes those cadences.
- Always-on stack instructions (React + Django + Nest + FastAPI) tax every session, including a one-line docs fix.

## Users

| Segment | Job | Workaround today |
|---|---|---|
| Solo builder + coding agent | Ship a web+API product without drowning the model | Giant `AGENTS.md`, pasted rules |
| Same person, two tracks | Keep UI and API from blocking each other | Memory and ad-hoc branches |

## Riskiest assumption

Agents will load a context pack and one profile instead of globbing the repo. Confidence: medium. Cheap test: ask a fresh session "what should you read?" and expect `context-pack.sh` + `STATE.md`.

## Decision

Proceed to product definition with promotion tracks and on-demand profiles.
