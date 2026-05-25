#!/bin/sh
set -e

brew install --cask cc-switch

mkdir -p "$HOME/.claude"
cat > "$HOME/.claude/settings.json" <<'EOF'
{
  "env": {
    "API_TIMEOUT_MS": "3000000",
    "CLAUDE_CODE_DISABLE_NONESSENTIAL_TRAFFIC": 1,
    "CLAUDE_CODE_EFFORT_LEVEL": "max",
    "CLAUDE_CODE_ATTRIBUTION_HEADER": "0"
  },
  "permissions": {
    "defaultMode": "auto"
  },
  "hooks": {
    "Stop": [
      {
        "hooks": [
          {
            "type": "command",
            "command": "afplay /System/Library/Sounds/Glass.aiff"
          }
        ]
      }
    ],
    "PermissionRequest": [
      {
        "hooks": [
          {
            "type": "command",
            "command": "afplay /System/Library/Sounds/Funk.aiff"
          }
        ]
      }
    ]
  },
  "statusLine": {
    "type": "command",
    "command": "bash -c 'cols=$(stty size </dev/tty 2>/dev/null | awk '\"'\"'{print $2}'\"'\"'); export COLUMNS=$(( ${cols:-120} > 4 ? ${cols:-120} - 4 : 1 )); plugin_dir=$(ls -d \"${CLAUDE_CONFIG_DIR:-$HOME/.claude}\"/plugins/cache/*/claude-hud/*/ 2>/dev/null | awk -F/ '\"'\"'{ print $(NF-1) \"\\t\" $(0) }'\"'\"' | grep -E '\"'\"'^[0-9]+\\.[0-9]+\\.[0-9]+\\t'\"'\"' | sort -t. -k1,1n -k2,2n -k3,3n -k4,4n | tail -1 | cut -f2-); exec \"/Users/bytedance/.local/share/mise/installs/node/22/bin/node\" \"${plugin_dir}dist/index.js\"'"
  },
  "enabledPlugins": {
    "claude-hud@claude-hud": true,
    "superpowers@claude-plugins-official": true,
    "context7@claude-plugins-official": true,
    "code-review@claude-plugins-official": true,
    "code-simplifier@claude-plugins-official": true,
    "skill-creator@claude-plugins-official": true,
    "playwright@claude-plugins-official": true,
    "feature-dev@claude-plugins-official": true,
    "claude-md-management@claude-plugins-official": true,
    "ralph-loop@claude-plugins-official": true,
    "typescript-lsp@claude-plugins-official": true,
    "security-guidance@claude-plugins-official": true,
    "commit-commands@claude-plugins-official": true,
    "claude-code-setup@claude-plugins-official": true,
    "chrome-devtools-mcp@claude-plugins-official": true,
    "gopls-lsp@claude-plugins-official": true,
    "coderabbit@claude-plugins-official": true
  },
  "extraKnownMarketplaces": {
    "claude-plugins-official": {
      "source": {
        "source": "github",
        "repo": "anthropics/claude-plugins-official"
      }
    }
  },
  "skipAutoPermissionPrompt": true
}
EOF