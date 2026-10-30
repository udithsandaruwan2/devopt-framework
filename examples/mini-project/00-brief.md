# 00 — Project brief

- **Project:** Pocket Notes
- **Owner:** sam
- **Date:** 2026-10-20
- **One-liner:** A keyboard-first notes app that never loses a thought, even offline.

## Problem

Freelancers lose ideas when they switch apps to capture them; the friction costs 2–3 thoughts a day and makes them distrust note tools.

## Outcome

Users capture a note in ≤3 actions, and drafts survive offline and reload. We will know because median capture time drops below 5 seconds and “lost note” reports go to zero.

## Users

| Segment | Job to be done | Current workaround |
|---|---|---|
| Freelancers | capture a thought instantly | phone notes + Notion later |
| Writers | collect fragments | scattered docs |

## Scope

**In scope for v1**
- Quick capture
- Offline drafts
- Search by text
- Markdown-lite rendering

**Out of scope**
- Sharing and collaboration — needs permissions and sync conflicts
- Rich text — not required to validate capture
- Mobile apps — web is enough for the first cohort

## Constraints

- Deadline: 6 weeks
- Budget: < $50/mo
- Stack: TypeScript, React, IndexedDB, Postgres for sync
- Compliance: none
- Team: 1 developer + agents

## Success and stop conditions

- **Success:** 20 users capture 5+ notes/week; median capture < 5s.
- **Guardrail:** no note loss on offline reload.
- **Stop if:** fewer than 5 of 20 pilot users capture weekly after 2 weeks.

## Riskiest assumption

Users will trust a local-first tool with work notes. Confidence: medium. Impact: fatal. Test: 5 pilot interviews after the first slice.
