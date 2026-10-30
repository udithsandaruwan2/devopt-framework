# FEAT-001 — Quick capture

## Summary

A signed-in user opens the app and captures a note in ≤3 actions using the keyboard, with an optimistic local save.

## Status

- **Catalog:** FEAT-001
- **Priority:** Must
- **Status:** in-progress
- **Owner:** sam

## Non-goals

- Rich text editing.
- Sharing.
- Editing an existing note (v0.2).

## User story

As a freelancer, I want to capture a thought without leaving the keyboard, so that I do not lose it while switching context.

## Acceptance criteria

- [ ] Pressing `N` focuses the capture input from anywhere in the list.
- [ ] `Enter` submits; `Shift+Enter` inserts a newline.
- [ ] Empty or whitespace-only submit shows “Write something first” and sends no request.
- [ ] A submitted note appears in the list in <100 ms before the server responds.
- [ ] If the request fails, the note stays visible with a retry action and the text is preserved.
- [ ] The flow is keyboard-only and works at 360×640.

## Behavior

### Happy path

1. User presses `N`.
2. Types a note.
3. Presses `Enter`.
4. Note appears at the top of the list with a “saving” state.
5. On success, the state becomes “saved”.

### Edge cases

| Case | Expected |
|---|---|
| empty / whitespace | inline error, no request |
| very long note (>10k chars) | reject with “Too long” |
| offline | note saved locally, “waiting to sync” |
| 500 | note remains, retry action, draft preserved |
| double Enter | one note (idempotency key) |

## Data and state

- Entity: `Note(id, workspace_id, body, created_at, updated_at, sync_state)`
- Local store: `drafts` keyed by client-generated `id`.
- Idempotency: client `id` is sent as `Idempotency-Key`.
- Sync state: `local → saving → saved | error`.

## Interfaces

### `POST /notes`

```json
{ "id": "n_client_123", "body": "Buy milk" }
```

`201`:

```json
{ "id": "n_client_123", "body": "Buy milk", "created_at": "2026-10-30T10:00:00Z" }
```

Errors:

| Code | Status | Message |
|---|---|---|
| `EMPTY_BODY` | 400 | Write something first. |
| `TOO_LONG` | 400 | Note is too long. |
| `UNAUTHORIZED` | 401 | Sign in to continue. |

Auth: workspace member.

## Test mapping

| Acceptance | Test | Layer |
|---|---|---|
| empty rejected | `rejects_empty_note` | integration |
| optimistic save | `shows_note_before_response` | unit |
| failure preserves | `restores_draft_on_500` | integration |
| offline reload | `draft_survives_reload` | e2e |
| keyboard only | `capture_without_mouse` | e2e |

## Rollout

- Flag: `capture_v1`
- Migration: none
- Rollback: disable flag; list stays read-only
