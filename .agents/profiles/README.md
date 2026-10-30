# Stack profiles

On-demand conventions. **Load one profile, never all of them.**

Pick from `FRONTEND_PROFILE` / `BACKEND_PROFILE` in `framework.conf`. Apply with:

```bash
./scripts/apply-profile.sh
./scripts/context-pack.sh implement-web   # or implement-api
```

| Profile | Use when |
|---|---|
| `web-react-vite-netlify` | React UI, Vite, Netlify hosting |
| `api-python-django` | **Default** Python API: Django + DRF (`uv`) |
| `api-python` | FastAPI opt-in |
| `api-node-nest` | NestJS opt-in |
| `layout-split-apps` | `apps/web` + `apps/api` monorepo |

Git promotion tracks live in `docs/07-git-workflow.md`, not here.
