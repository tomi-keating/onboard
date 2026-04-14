# MacSetup

A single-entry-point, zero-dependency CLI wizard for setting up a fresh macOS installation.

## Quick Start

```bash
git clone <repo-url>
cd macsetup
./setup
```

## What it does

1. **Checks for Homebrew** and installs it automatically if missing.
2. **Presents apps by category** in an interactive command-line menu.
3. **Installs your selections** by running the corresponding shell commands.
4. **Skips apps that are already installed** (when a `check` command is provided).
5. **Prints a clear summary** of successes and failures.

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

Edit [`apps.json`](apps.json). Each app entry looks like this:

```json
{
  "name": "Visual Studio Code",
  "command": "brew install --cask visual-studio-code",
  "description": "Code editor",
  "check": "which code"
}
```

| Field | Purpose |
|-------|---------|
| `name` | Display name in the menu |
| `command` | Shell command executed to install the app |
| `description` | Optional short description shown in the menu |
| `check` | Optional command to detect if already installed (skips when exit code is 0) |

## Project Structure

```
.
├── README.md    # This file
├── setup        # Main executable (Python 3)
└── apps.json    # App catalog
```

No build step. No package manager. Just run `./setup`.
