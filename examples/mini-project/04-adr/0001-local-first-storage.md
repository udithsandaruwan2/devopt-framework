# ADR-0001 — Local-first storage with IndexedDB + background sync

- **Status:** accepted
- **Date:** 2026-10-27
- **Deciders:** sam

## Context

Capture must work offline and survive reload. The product is a web app with a single user per workspace. Sync conflicts are rare but possible when the same note is edited on two devices. The team is one developer; operational surface must stay small.

## Decision

Store notes locally in IndexedDB and sync to Postgres through an idempotent API. The client writes locally first, then flushes a queue with a per-note version. Conflicts resolve last-write-wins with a server-side `updated_at` check; the losing client keeps a local copy in a `conflicts` store.

## Alternatives

| Option | Why not chosen |
|---|---|
| Server-first only | fails offline capture; adds latency |
| CRDT library | correct, but heavy for v1 and harder to debug |
| LocalStorage | too small, synchronous, no structured queries |

## Consequences

**Positive**
- Capture is instant and works offline.
- No server dependency on the critical path.

**Negative**
- Two data stores to migrate and test.
- Conflict UX is minimal in v1.
- Storage limits vary by browser.

## Revisit if

- Users edit the same note concurrently more than 1% of the time.
- Note volume per user exceeds 50k.
- A native app needs a shared sync layer.
