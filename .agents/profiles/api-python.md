# Profile — Python + FastAPI

Load only when the task touches the FastAPI API. Git track: **backend**.
Opt-in: set `BACKEND_PROFILE=api-python`. Default backend is Django (`api-python-django`).

## Pin

- Python 3.12+
- FastAPI + Pydantic v2
- `uv` for env and lockfile (`uv.lock`)
- Pytest
- Path: `apps/api/`

## Commands

```bash
cd apps/api
uv sync
uv run uvicorn app.main:app --reload
uv run pytest
uv run ruff check .
uv run ruff format --check .
```

## Shape

```
apps/api/
  app/main.py          # app factory
  app/api/v1/          # routers
  app/domain/          # logic
  app/models/          # persistence
  tests/
  pyproject.toml
  uv.lock
```

- Routers: HTTP only. Domain: logic. No SQL in routers.
- Pydantic schemas at the boundary; domain types inside.
- Typed errors; no bare `except`.
- Secrets from env; never committed.

## API

- Versioned prefix `/v1`.
- Authz on the server.
- Idempotency key on create/payment endpoints.
- OpenAPI from FastAPI; frontend consumes the contract.

## Data

- Parameterized queries / ORM bind params only.
- Migrations: expand → migrate → contract.

## Git

- Branch from `dev/backend`: `feat/backend/<slug>`
- Merge to `dev/backend` at feature end.
- Promote to `prod/backend` only when the human says so.

## Never touch

- `.venv/`, frontend files from a backend task
- `uv.lock` unless adding a justified dependency
