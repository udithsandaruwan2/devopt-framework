# Profile — React + Vite + Netlify

Load only when the task touches the frontend. Git track: **frontend**.

## Pin

- React 19 + TypeScript (strict)
- Vite for dev/build
- pnpm
- Netlify for preview (`dev/frontend`) and production (`prod/frontend`)
- Path: `apps/web/` (nested `AGENTS.md` there)

## Commands

```bash
cd apps/web
pnpm install
pnpm dev
pnpm test          # Vitest unit
pnpm test:e2e      # Playwright, only for user flows
pnpm lint
pnpm typecheck
pnpm build
```

## Layout

```
apps/web/
  src/             # app code
  public/          # static
  index.html
  vite.config.ts
  netlify.toml
  AGENTS.md        # package commands + local invariants
```

## Netlify

- Config in `netlify.toml`: build, SPA redirect, headers. Skill: Netlify config.
- SPA: `/* → /index.html` with `200`. Do not 301 the app shell.
- Env: `Netlify.env.get("VAR")` in Functions; never `process.env` there; never hardcode secrets.
- Ignore `.netlify/` in git.
- Image transforms: Netlify Image CDN. User uploads: Functions + Blobs, not a homemade disk store.
- Server logic: prefer the framework adapter; add Netlify Functions only when the adapter cannot.
- Identity: `@netlify/identity` if auth is required. Do not use deprecated widgets.

## UI rules

- Semantic HTML, keyboard access, visible focus.
- Mobile-first; verify 360px and desktop for layout changes.
- No CSS-in-JS unless the repo already uses it. Prefer CSS modules or existing styling.
- Data fetching in loaders/effects already used by the app; do not invent a store.

## Tests

- Vitest for components/hooks/logic. Assert behavior, not implementation.
- Playwright for the user flow named in the spec. One flow per test file.
- Do not add a visual snapshot unless the spec asks.

## Git

- Branch from `dev/frontend`: `feat/frontend/<slug>`
- Merge to `dev/frontend` at feature end.
- Promote to `prod/frontend` only when the human says so.
- CI path filter: `apps/web/**`, `netlify.toml`.

## Never touch

- `dist/`, `.netlify/`, `pnpm-lock.yaml` unless the task adds a dependency
- Backend files (`apps/api/**`) from a frontend task
