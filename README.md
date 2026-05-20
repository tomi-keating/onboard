# MacSetup

A single-entry-point, zero-dependency CLI wizard for setting up a fresh macOS installation.

## Quick Start

```bash
git clone <repo-url>
cd macsetup
./setup
```

## What it does

1. **Precheck** — Verifies Xcode Command Line Tools are installed (required by Homebrew).
2. **Checks for Homebrew** and installs it automatically if missing.
3. **Presents an interactive TUI checklist** of all available apps. Use ↑/↓ to navigate, Space to toggle, and Enter to confirm.
4. **Installs your selections** by running the corresponding commands in the order they appear in the catalog.
5. **Skips apps that are already installed** (when a `check` command is provided).
6. **Logs results** to `setup.log` and offers to retry failed apps on the next run.
7. **Prints a clear summary** of successes, skips, and failures.

## Requirements

- macOS (Apple Silicon or Intel)
- Internet connection
- Python 3 (pre-installed on macOS Catalina and later)

## CLI Options

| Flag | Description |
|------|-------------|
| `--list` | Show all available apps without installing |
| `--install-all` | Install every app non-interactively |
| `--category <name>` | Install only one category non-interactively |

## Customizing the App List

Edit [`apps.json`](apps.json). The catalog is a flat ordered JSON array; each entry looks like this:

```json
{
  "name": "iTerm2",
  "command": "brew install --cask iterm2",
  "description": "Popular terminal emulator for macOS",
  "check": "ls /Applications/iTerm.app",
  "category": "Terminal"
}
```

| Field | Purpose |
|-------|---------|
| `name` | Display name in the menu |
| `command` | Shell command executed to install the app |
| `description` | Optional short description shown in the menu |
| `check` | Optional command to detect if already installed (skips when exit code is 0) |
| `category` | Optional category label used by `--category` |

## Project Structure

```
.
├── README.md         # This file
├── CLAUDE.md         # Guidance for Claude Code
├── setup             # Main executable (Python 3)
├── apps.json         # App catalog
├── scripts/          # Per-app installation scripts
│   ├── precheck.sh
└── setup.log         # Install log (ignored by git)
```

No build step. No package manager. Just run `./setup`.
