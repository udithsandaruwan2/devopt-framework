<!-- agent-project-framework:readme -->
# DevOpt

**Start right. Ship small. Spend less.**

A portable operating system for AI-assisted products. Drop it into a repo and every coding agent — Cursor, Claude Code, Codex, Copilot, Gemini, OpenCode, Windsurf, and the rest — gets the same answers: where we are, what to build, how to branch, and which files to open.

It is not a prompt pack. It is a small set of gates, profiles, and scripts that stop the expensive failure modes: building before speccing, rereading the whole repo, mixing frontend and backend, and shipping to production without a human.

## Install (no git clone)

macOS / Linux — asks name, backend, and git model, then writes a project folder:

```bash
/bin/bash -c "$(curl -fsSL https://devopt.udithsandaruwan.com/install.sh)"
```

Windows PowerShell:

```powershell
irm https://devopt.udithsandaruwan.com/install.ps1 | iex
```

Portal: [devopt.udithsandaruwan.com](https://devopt.udithsandaruwan.com) (Home · [Setup](https://devopt.udithsandaruwan.com/setup.html) · [How it works](https://devopt.udithsandaruwan.com/how.html) · [Architecture](https://devopt.udithsandaruwan.com/architecture.html)) · Studio: [1028.udithsandaruwan.com](https://1028.udithsandaruwan.com) · [Use as GitHub template](https://github.com/udithsandaruwan2/devopt-framework/generate)

Open an empty folder in your agent, then paste the portal **Copy prompt** (or [prompt.txt](https://devopt.udithsandaruwan.com/prompt.txt)). That one paste installs into *this* folder from the portal — no git clone — then runs Phase 0 and Phase 1.

```
DevOpt — one shot. This open folder is the project. Do not git clone.

If AGENTS.md is missing, install into THIS directory from https://devopt.udithsandaruwan.com (installer tarball, not git clone). Do not create a nested subdirectory.

Unix / Git Bash / WSL:
  /bin/bash -c "$(curl -fsSL https://devopt.udithsandaruwan.com/install.sh)" -- --here --yes --name "$(basename "$PWD")"

Then, in this same session, without waiting for another paste:

1. Read AGENTS.md fully, once.
2. Read project/STATE.md.
3. Run: ./scripts/context-pack.sh kickoff
   Open only the files that script lists.
4. Load the project-kickoff skill.
5. Phase 0 — Intake: fill project/00-brief.md.
6. Phase 1 — Discovery: fill project/01-discovery.md from the same answers.

Ask at most 3 questions at a time, each with a recommended default. Use anything I already wrote in this chat. Do not invent requirements. Do not write product code. Do not approve gates — propose G0 and G1 together when both drafts are ready, then stop.

Default stack unless I override: React + Vite + Netlify frontend, Django + DRF backend, promotion-track git.
```

[![CI](https://github.com/udithsandaruwan2/devopt-framework/actions/workflows/framework-check.yml/badge.svg)](https://github.com/udithsandaruwan2/devopt-framework/actions/workflows/framework-check.yml)
![version](https://img.shields.io/badge/version-1.2.0-0ea5e9)
![AGENTS.md](https://img.shields.io/badge/AGENTS.md-119%20lines-8b5cf6)
![baseline](https://img.shields.io/badge/session%20baseline-%E2%89%A4%203.5k%20tokens-22c55e)
[![license](https://img.shields.io/badge/license-MIT-111827)](LICENSE)

---

## Default stack

| Side | Default | Opt-in |
|---|---|---|
| Frontend | React + Vite + TypeScript on **Netlify** | — |
| Backend | **Django 5 + DRF** (`uv`) | FastAPI · NestJS |
| Layout | `apps/web` + `apps/api` | trunk-based single app (`--trunk`) |

Backend work loads the Django profile only. Nest and FastAPI stay on disk until you ask for them.

```bash
./scripts/bootstrap.sh ~/projects/my-app "My App"                 # Django
./scripts/bootstrap.sh ~/projects/my-app "My App" --backend-nest  # Nest
./scripts/bootstrap.sh ~/projects/my-app "My App" --backend-fastapi
```

---

## Git: four tracks, then main

Frontend and backend ship independently. Production is a human sentence, not a green CI run.

```mermaid
flowchart LR
  F["feat/frontend/…"] --> DF["dev/frontend"]
  B["feat/backend/…"] --> DB["dev/backend"]
  DF -->|"go to production"| PF["prod/frontend<br/>Netlify"]
  DB -->|"go to production"| PB["prod/backend<br/>API host"]
  PF --> M["main<br/>phase archive"]
  PB --> M
```

1. Many commits on `feat/<track>/<slug>`.
2. Feature end → merge to `dev/<track>` → test locally.
3. You say **go to production** → `./scripts/promote.sh <track> prod --apply`.
4. After a phase → `./scripts/promote.sh phase --apply` (both prod tracks → `main`).

`promote.sh` dry-runs unless you pass `--apply`. Agents are not allowed to skip that.

---

## Quickstart

```bash
./scripts/bootstrap.sh ~/projects/my-app "My App"
cd ~/projects/my-app
git init && ./scripts/install-hooks.sh

# long-lived tracks
git switch -c dev/frontend && git switch -c dev/backend
git switch -c prod/frontend && git switch -c prod/backend
git switch main

./scripts/doctor.sh
./scripts/token-audit.sh
```

Open the project in any agent:

> Read `AGENTS.md` and `project/STATE.md`. Run `project-kickoff` for phase 0.

Existing repo:

```bash
./scripts/bootstrap.sh /path/to/repo "Existing App" --force --copy
```

Review the diff before you commit. Bootstrap may overwrite `.gitignore`, `.editorconfig`, or `Makefile`.

---

## How agents spend fewer tokens

| Mechanism | What it does |
|---|---|
| Thin `AGENTS.md` (~1.6k tokens) | The only mandatory read |
| Skills by description | 12 procedures, ~650 tokens of names |
| `./scripts/context-pack.sh implement-api` | Ordered allowlist — Django profile, not Nest |
| One stack profile per task | Never load React + Django + Nest together |
| Work order + **track** | Frontend and backend stay on separate lines |
| `promote.sh` dry-run | Production only when a human says so |
| S / M / L / XL sizing | Small tasks skip planning loops |
| Handoff at ~60% | Fresh session instead of bloated compaction |

```bash
./scripts/context-pack.sh --list
./scripts/context-pack.sh implement-web
./scripts/context-pack.sh implement-api    # Django by default
```

---

## What you get

```
AGENTS.md                 always-on rules (~119 lines)
framework.conf            budgets, git model, selected profiles
.agents/skills/           12 on-demand procedures
.agents/profiles/         Django · FastAPI · Nest · React/Vite/Netlify
.agents/packs/            file allowlists for context-pack.sh
project/                  living truth: STATE, brief, PRD, ADRs, plan
docs/                     playbooks — open one
scripts/                  bootstrap, promote, doctor, token-audit
```

Phase model:

```
0 Intake ─G0→ 1 Discovery ─G1→ 2 Product ─G2→ 3 Architecture ─G3→
4 Plan ─G4→ 5 Build ─G5→ 6 Release ─G6→ 7 Operate
```

Agents may propose a gate. Only a human approves one.

---

## Agents and IDEs

| Tool | Entry file |
|---|---|
| OpenCode, Codex, Jules, Amp, Factory | `AGENTS.md` |
| Claude Code | `CLAUDE.md` + `.claude/skills/` |
| Cursor | `.cursor/rules/*.mdc` |
| GitHub Copilot | `.github/copilot-instructions.md` |
| Gemini CLI | `GEMINI.md` |
| Windsurf / Roo / Zed / Aider / Junie | generated adapters |

One source of truth. Run `./scripts/sync-adapters.sh` after you edit `AGENTS.md` or a skill. Details: [docs/11-agent-adapters.md](docs/11-agent-adapters.md).

---

## Everyday commands

```bash
make doctor                          # structure, links, budgets
make audit                           # token table
make pack PACK=implement-api         # files the agent may open
make promote ARGS="frontend prod"    # dry-run promotion
make sync                            # regenerate IDE adapters
./scripts/new.sh adr "Use Postgres"
./scripts/new.sh spec "Quick capture"
./scripts/new.sh task "Add capture form"
```

---

## Design principles

1. **One source of truth.** Rules in `AGENTS.md`, state in `project/`, procedures in skills.
2. **Progressive disclosure.** Load the smallest tier that can answer the question.
3. **Gates before code.** Documents are cheaper than rewrites.
4. **Small diffs.** One task, one track, one reviewable change.
5. **Measure context.** Budgets and audits, not vibes.
6. **Humans own production.** Agents propose and implement; they do not promote.

Research notes: [docs/13-research-notes.md](docs/13-research-notes.md). Human guide: [docs/00-start-here.md](docs/00-start-here.md).

## License

[MIT](LICENSE) © 2026 Udith Sandaruwan · Developed by [Studio 1028](https://1028.udithsandaruwan.com)
