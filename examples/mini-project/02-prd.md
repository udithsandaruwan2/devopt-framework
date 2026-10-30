# 02 — Product requirements document (excerpt)

## Summary

Pocket Notes is a keyboard-first capture tool for freelancers. V1 proves that fast capture plus offline safety is enough to change note-taking behavior.

## Outcomes and metrics

- **Primary:** median capture time < 5s — baseline 18s (5 interviews) → target 5s
- **Guardrails:** zero lost drafts; p95 search < 300 ms at 10k notes
- **Measurement:** local telemetry + pilot interviews

## Users and jobs

| Segment | Job | Today | Why switch |
|---|---|---|---|
| Freelancers | capture a thought before it disappears | phone notes, later cleanup | one shortcut, offline-safe |
| Writers | collect fragments | scattered docs | searchable single inbox |

## Scope

**In scope:** quick capture, offline drafts, text search, Markdown-lite.
**Out of scope:** sharing, rich text, native apps.

## Functional requirements

| ID | Requirement | Priority | Acceptance |
|---|---|---|---|
| FR-01 | Capture a note with Enter or a button | Must | note appears in <100 ms; empty submit rejected |
| FR-02 | Preserve drafts offline and across reload | Must | reload restores draft; sync on reconnect |
| FR-03 | Search notes by text | Must | p95 < 300 ms at 10k notes |
| FR-04 | Render Markdown-lite | Should | bold, italic, links, lists |

## Non-functional requirements

| ID | Requirement | Target |
|---|---|---|
| NFR-01 | Capture latency | <100 ms local |
| NFR-02 | Search latency | p95 <300 ms at 10k |
| NFR-03 | Accessibility | keyboard-only capture, WCAG AA |
| NFR-04 | Data safety | no loss on crash/reload |

## Release criteria

- [ ] FR-01..03 met.
- [ ] Offline E2E green.
- [ ] No P0/P1.
- [ ] Rollback: feature flag off returns to read-only list.
