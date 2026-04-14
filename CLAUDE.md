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
- **`apps.json`** — The app catalog. Defines categories, each containing apps with `name`, `command`, `description`, and optional `check` fields. The `check` command is used to skip already-installed apps.

### Key Behaviors

- **Terminal category priority:** The `Terminal` category is always processed first. Its apps are auto-selected (no prompt) and installed before any other category.
- **Upfront install checks:** Before prompting or installing, the script runs each app's `check` command. Already-installed apps are skipped and reported, then counted in the final summary.
- **Non-interactive flags:** `--install-all` and `--category <name>` bypass prompts but still respect the Terminal-first rule and upfront checks.

### App Catalog Schema

```json
{
  "name": "iTerm2",
  "command": "brew install --cask iterm2",
  "description": "Popular terminal emulator for macOS",
  "check": "which iterm2"
}
```

When adding GNU tools from Homebrew, note that many install with a `g` prefix by default (e.g., `ggrep`, `gsed`, `gfind`). The `check` command should target the installed binary name.
