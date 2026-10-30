#!/usr/bin/env bash
# DevOpt one-command installer (macOS / Linux).
# Usage:
#   /bin/bash -c "$(curl -fsSL https://devopt.udithsandaruwan.com/install.sh)"
#   /bin/bash -c "$(curl -fsSL https://devopt.udithsandaruwan.com/install.sh)" -- --name my-app --backend django
set -euo pipefail

REPO="${DEVOPT_REPO:-udithsandaruwan2/devopt-framework}"
BRANCH="${DEVOPT_BRANCH:-main}"
ARCHIVE="https://github.com/${REPO}/archive/refs/heads/${BRANCH}.tar.gz"

NAME=""
TARGET=""
BACKEND="django"
GIT_MODEL="promotion"
NONINTERACTIVE=0

usage() {
  cat <<'EOF'
DevOpt installer

Options:
  --name NAME          Project name
  --dir PATH           Directory to create (default: ./NAME)
  --here               Install into the current directory (the folder you opened)
  --backend VALUE      django | fastapi | nest   (default: django)
  --trunk              Use trunk-based git instead of promotion tracks
  --yes                Skip prompts; use defaults for anything unset
  -h, --help           Show this help
EOF
}

HERE=0

while [ $# -gt 0 ]; do
  case "$1" in
    --name)     NAME="${2:-}"; shift 2 ;;
    --dir)      TARGET="${2:-}"; shift 2 ;;
    --here)     HERE=1; shift ;;
    --backend)  BACKEND="${2:-}"; shift 2 ;;
    --trunk)    GIT_MODEL="trunk"; shift ;;
    --yes|-y)   NONINTERACTIVE=1; shift ;;
    -h|--help)  usage; exit 0 ;;
    --) shift; break ;;
    *) printf 'unknown option: %s\n' "$1" >&2; usage; exit 2 ;;
  esac
done

need() {
  command -v "$1" >/dev/null 2>&1 || {
    printf 'error: %s is required\n' "$1" >&2
    exit 1
  }
}

need curl
need tar
need bash

ask() {
  local prompt="$1" def="$2" reply=""
  if [ "$NONINTERACTIVE" = "1" ]; then
    printf '%s' "$def"
    return
  fi
  if [ -e /dev/tty ]; then
    printf '%s [%s]: ' "$prompt" "$def" >/dev/tty
    IFS= read -r reply </dev/tty || true
  elif [ -t 0 ]; then
    printf '%s [%s]: ' "$prompt" "$def"
    IFS= read -r reply || true
  fi
  printf '%s' "${reply:-$def}"
}

choose() {
  local prompt="$1" def="$2"
  if [ "$NONINTERACTIVE" = "1" ]; then
    printf '%s' "$def"
    return
  fi
  printf '\n%s\n' "$prompt" >/dev/tty 2>/dev/null || printf '\n%s\n' "$prompt"
  printf '  1) Django + DRF  (default)\n' >/dev/tty 2>/dev/null || true
  printf '  2) FastAPI\n' >/dev/tty 2>/dev/null || true
  printf '  3) NestJS\n' >/dev/tty 2>/dev/null || true
  local n
  n="$(ask "Choose 1/2/3" "1")"
  case "$n" in
    2|fastapi) printf 'fastapi' ;;
    3|nest)    printf 'nest' ;;
    *)         printf 'django' ;;
  esac
}

printf '\n  DevOpt installer\n  https://devopt.udithsandaruwan.com\n\n'

if [ "$HERE" = "1" ]; then
  TARGET="${TARGET:-.}"
  if [ -z "$NAME" ]; then
    NAME="$(basename "$(pwd)")"
    [ -n "$NAME" ] && [ "$NAME" != "/" ] && [ "$NAME" != "." ] || NAME="my-app"
  fi
fi

if [ -z "$NAME" ]; then
  NAME="$(ask "Project name" "my-app")"
fi
if [ -z "$TARGET" ]; then
  TARGET="$(ask "Directory" "./$NAME")"
fi
if [ "$NONINTERACTIVE" != "1" ] && [ "$BACKEND" = "django" ]; then
  BACKEND="$(choose "Backend stack" "django")"
fi
if [ "$NONINTERACTIVE" != "1" ] && [ "$GIT_MODEL" = "promotion" ]; then
  git_choice="$(ask "Git model: 1) promotion tracks  2) trunk" "1")"
  case "$git_choice" in
    2|trunk) GIT_MODEL="trunk" ;;
    *) GIT_MODEL="promotion" ;;
  esac
fi

case "$BACKEND" in
  django|fastapi|nest) ;;
  *) printf 'error: backend must be django, fastapi, or nest\n' >&2; exit 2 ;;
esac

TARGET="$(cd "$(dirname "$TARGET")" && pwd)/$(basename "$TARGET")"

real_entries="$(find "$TARGET" -mindepth 1 -maxdepth 1 \
  ! -name '.git' ! -name '.cursor' ! -name '.vscode' ! -name '.idea' \
  ! -name '.DS_Store' ! -name '.claude' ! -name '.windsurf' \
  -print -quit 2>/dev/null || true)"
if [ -e "$TARGET" ] && [ -n "$real_entries" ]; then
  printf 'error: %s exists and is not empty\n' "$TARGET" >&2
  exit 1
fi

mkdir -p "$TARGET"

TMP="$(mktemp -d 2>/dev/null || mktemp -d -t devopt)"
cleanup() { rm -rf "$TMP"; }
trap cleanup EXIT

printf 'Downloading %s@%s …\n' "$REPO" "$BRANCH"
curl -fsSL "$ARCHIVE" | tar -xz -C "$TMP"
SRC="$(find "$TMP" -mindepth 1 -maxdepth 1 -type d | head -n 1)"
[ -x "$SRC/scripts/bootstrap.sh" ] || {
  printf 'error: archive did not contain scripts/bootstrap.sh\n' >&2
  exit 1
}
chmod +x "$SRC/scripts/"*.sh

BOOT_ARGS=("$TARGET" "$NAME")
[ "$BACKEND" = "nest" ] && BOOT_ARGS+=("--backend-nest")
[ "$BACKEND" = "fastapi" ] && BOOT_ARGS+=("--backend-fastapi")
[ "$GIT_MODEL" = "trunk" ] && BOOT_ARGS+=("--trunk")
# Opened workspaces often only have .cursor / .vscode; older bootstrap treats those as nonempty.
if [ -z "$real_entries" ] && [ -n "$(ls -A "$TARGET" 2>/dev/null || true)" ]; then
  BOOT_ARGS+=("--force")
fi

"$SRC/scripts/bootstrap.sh" "${BOOT_ARGS[@]}"

if command -v git >/dev/null 2>&1 && [ ! -d "$TARGET/.git" ]; then
  git -C "$TARGET" init >/dev/null
  "$TARGET/scripts/install-hooks.sh" "$TARGET" >/dev/null 2>&1 || true
fi

printf '\nDone.\n'
printf '  Project:  %s\n' "$NAME"
printf '  Path:     %s\n' "$TARGET"
printf '  Backend:  %s\n' "$BACKEND"
printf '  Git:      %s\n' "$GIT_MODEL"
printf '\nNext:\n'
printf '  1. cd %s\n' "$TARGET"
printf '  2. ./scripts/doctor.sh\n'
if [ "$GIT_MODEL" = "promotion" ]; then
  printf '  3. Create tracks after your first commit:\n'
  printf '       git switch -c dev/frontend && git switch -c dev/backend\n'
  printf '       git switch -c prod/frontend && git switch -c prod/backend && git switch main\n'
fi
printf '  Open the folder in your AI agent and paste:\n'
printf '    https://devopt.udithsandaruwan.com/prompt.txt\n\n'
