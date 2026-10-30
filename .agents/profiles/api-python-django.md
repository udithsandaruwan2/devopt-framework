# Profile — Python + Django

Load only when the task touches the API. Git track: **backend**.
This is the **default** backend. Nest and FastAPI are opt-in profiles.

## Pin

- Python 3.12+
- Django 5.x
- Django REST Framework for HTTP APIs (Django Ninja only if the repo already uses it)
- `uv` + `uv.lock`
- pytest-django + ruff
- Path: `apps/api/`

## Commands

```bash
cd apps/api
uv sync
uv run python manage.py runserver
uv run python manage.py migrate
uv run pytest
uv run ruff check .
uv run ruff format --check .
```

## Shape

```
apps/api/
  manage.py
  config/                 # settings, urls, wsgi/asgi
    settings/base.py
    settings/dev.py
    settings/prod.py
  <app>/                  # one Django app per bounded context
    models.py
    api/                  # serializers, viewsets, urls
    tests/
  pyproject.toml
  uv.lock
```

- Views/viewsets: HTTP only. Domain logic in services or model methods, not in serializers.
- Validate at the serializer / form boundary. Authz in the view or permission class — never trust the client.
- Typed errors; no bare `except`.
- `SECRET_KEY` and DB URLs from env. Never committed.

## API

- Versioned prefix `/api/v1/`.
- DRF viewsets + routers. Frontend consumes the contract, not guessed shapes.
- Idempotency key on create/payment endpoints.
- Pagination and filter backends explicit; do not return unbounded querysets.

## Data

- ORM only; no raw SQL unless an ADR says so, and then parameterized.
- Model change and migration in the **same** commit.
- Migrations: expand → migrate → contract. Never delete a column in the same release that stops writing it.
- `select_related` / `prefetch_related` for anything that would N+1.

## Git

- Branch from `dev/backend`: `feat/backend/<slug>`
- Merge to `dev/backend` at feature end.
- Promote to `prod/backend` only when the human says so.

## Never touch

- `.venv/`, `staticfiles/`, frontend files (`apps/web/**`) from a backend task
- `uv.lock` unless adding a justified dependency
- Production settings values in the repo
