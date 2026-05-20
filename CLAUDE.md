# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Common Commands

- Run the wizard interactively: `./setup`
- List available apps without installing: `./setup --list`
- Install all apps non-interactively: `./setup --install-all`
- Install a specific category: `./setup --category "Core CLI Tools"`
- Validate syntax after editing: `python3 -m py_compile setup`

## Architecture

This is a **zero-dependency** Python 3 CLI tool for setting up a fresh macOS install. There is no build system, package manager, or test framework.

- **`setup`** — The single executable entry point. Uses only the Python standard library. Auto-installs Homebrew if missing and adds it to `PATH` for the current session.
- **`apps.json`** — The app catalog. A flat ordered JSON array of apps, each with `name`, `command`, `description`, and optional `check` fields. Order in the array determines installation order. The `check` command is used to skip already-installed apps.
- **`scripts/`** — Per-app installation scripts for complex setups (e.g. `precheck.sh`).

### Key Behaviors

- **Interactive checklist UI:** In interactive mode, all apps are displayed in a single scrollable TUI. Use ↑/↓ to navigate, Space to select/unselect, and Enter to confirm. By default all apps are selected.
- **Mandatory apps:** `Precheck`, `Homebrew`, and `iTerm2` are mandatory and cannot be unselected.
- **Installation order:** Apps are installed in the exact order they appear in `apps.json`.
- **Upfront install checks:** Before installation, the script runs each app's `check` command. Already-installed apps are skipped and reported separately in the summary.
- **Install logging:** Results are written to `setup.log` (ignored by git). On the next run, if previous failures exist, the tool asks whether to retry only the failed apps.
- **Non-interactive flags:** `--install-all` and `--category <name>` bypass prompts but still respect the Terminal-first rule and upfront checks.

### App Catalog Schema

```json
{
  "name": "iTerm2",
  "command": "brew install --cask iterm2",
  "description": "Popular terminal emulator for macOS",
  "check": "ls /Applications/iTerm.app"
}
```

When adding GNU tools from Homebrew, note that many install with a `g` prefix by default (e.g., `ggrep`, `gsed`, `gfind`). The `check` command should target the installed binary name.

For complex multi-step installations (e.g. version managers that also need `~/.zshrc` configuration), prefer creating a dedicated shell script under `scripts/` and referencing it from `apps.json`. Use `sh scripts/<script>.sh` for POSIX-compatible scripts, and `bash scripts/<script>.sh` for scripts that rely on Bash-specific features such as process substitution.
