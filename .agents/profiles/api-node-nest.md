# Profile — Node + NestJS

Load only when the task touches the Nest API. Git track: **backend**.
Opt-in: set `BACKEND_PROFILE=api-node-nest` or bootstrap with `--backend-nest`. Default backend is Django.

## Pin

- Node LTS + TypeScript (strict)
- NestJS modules / controllers / providers
- pnpm
- Path: `apps/api/`
- Validation: class-validator + ValidationPipe (whitelist, forbid non-whitelisted)
- Config: `@nestjs/config`; secrets from env, never committed

## Commands

```bash
cd apps/api
pnpm install
pnpm start:dev
pnpm test          # unit / integration
pnpm test:e2e
pnpm lint
pnpm typecheck
pnpm build
```

## Module shape

```
apps/api/src/<domain>/
  <domain>.module.ts
  <domain>.controller.ts
  <domain>.service.ts
  dto/
  <domain>.spec.ts
```

- One domain module per bounded context.
- Controllers: HTTP only. Services: logic. No SQL in controllers.
- DTOs at the boundary; domain types inside.
- Errors: Nest exceptions with stable codes. No silent catches.

## API

- Versioned prefix `/v1`.
- Authz on the server. Never trust a role from the client body.
- Idempotency key on create/payment endpoints.
- OpenAPI generated from Nest; `apps/web` consumes the contract, not guessed shapes.

## Data

- One module owns its tables. No cross-module table reads.
- Migrations: expand → migrate → contract.
- Parameterized queries only.

## Git

- Branch from `dev/backend`: `feat/backend/<slug>`
- Merge to `dev/backend` at feature end.
- Promote to `prod/backend` only when the human says so.
- CI path filter: `apps/api/**`.

## Never touch

- `dist/`, frontend files (`apps/web/**`) from a backend task
- `pnpm-lock.yaml` unless adding a justified dependency
