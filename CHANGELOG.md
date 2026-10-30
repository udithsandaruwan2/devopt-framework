<!-- agent-project-framework:changelog -->
# Changelog

All notable changes to the framework are documented here. Format follows [Keep a Changelog](https://keepachangelog.com), versioning follows [SemVer](https://semver.org).

## [1.1.2] — 2026-10-30

### Added

- One copyable Phase 0 agent prompt on the portal (`site/prompt.txt` and **Copy prompt**).
- Studio 1028 credit and link to `1028.udithsandaruwan.com`.

### Changed

- Portal UI restyled as a command-center landing page.

## [1.1.1] — 2026-10-30

### Added

- Public installer portal at `devopt.udithsandaruwan.com` (GitHub Pages).
- `site/install.sh` and `site/install.ps1` — one-command setup with backend and git prompts.
- GitHub template-repository flag so people can “Use this template” instead of cloning this repo.

## [1.1.0] — 2026-10-30

### Added

- Promotion-track git: `dev/frontend`, `dev/backend`, `prod/frontend`, `prod/backend`, `main` as phase archive.
- `scripts/promote.sh` (dry-run default; `--apply` only after a human production gate).
- Stack profiles: React + Vite + Netlify, **Django + DRF (default API)**, FastAPI and NestJS opt-in, split `apps/web` + `apps/api`.
- Context packs (`.agents/packs/`) and `scripts/context-pack.sh` so agents load an allowlist, not the repo.
- `scripts/apply-profile.sh` writes `project/rules/stack.md` and nested `AGENTS.md` files.
- Bootstrap flags: `--trunk`, `--backend-nest`, `--backend-fastapi`.
- CI templates for path-filtered frontend/backend tracks.

### Changed

- Default git model is promotion tracks; trunk-based is opt-in.
- Default backend is Django, not Nest.
- `AGENTS.md` points at profiles and packs instead of inlining stack commands.
- Research notes, git steward, release, and implementation skills follow the four-track flow.

## [1.0.0] — 2026-10-30

### Added

- `AGENTS.md` thin always-on rulebook with phase/gate model and context map.
- 12 on-demand skills: kickoff, prompt optimizer, spec writer, architecture, planning, implementation loop, git steward, code review, test strategy, release manager, context auditor, skill forge.
- 12 playbooks in `docs/` covering discovery through operations, token economy, adapters, FAQ, and research notes.
- Document templates: brief, discovery, PRD, catalog, architecture, ADR, feature spec, plan, task, work order, handoff, runbook, skill, rule, nested AGENTS.
- Living `project/` skeleton with machine-readable `STATE.md`.
- Adapter generation for Claude Code, OpenCode, Cursor, Copilot, Gemini CLI, Windsurf, Roo, Zed, Aider, and Junie.
- Scripts: `bootstrap.sh`, `sync-adapters.sh`, `doctor.sh`, `token-audit.sh`, `prompt-lint.sh`, `new.sh`, `install-hooks.sh`.
- Conventional Commits hook and CI workflow for docs/skills/budget checks.
- Filled mini-project example.
