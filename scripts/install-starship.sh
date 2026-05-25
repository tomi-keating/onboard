#!/bin/sh
set -e

brew install starship

if ! grep -q 'starship init zsh' ~/.zshrc 2>/dev/null; then
    echo 'eval "$(starship init zsh)"' >> ~/.zshrc
fi

if ! grep -q 'starship init bash' ~/.bashrc 2>/dev/null; then
    echo 'eval "$(starship init bash)"' >> ~/.bashrc
fi

mkdir -p "$HOME/.config"
cat > "$HOME/.config/starship.toml" <<'EOF'
format = """
$directory$git_branch$git_status${custom.space}
$character"""

right_format = """
$status$cmd_duration$time"""

[character]
success_symbol = "[❯](green)"
error_symbol = "[❯](red)"
vicmd_symbol = "[❮](green)"

[directory]
truncation_length = 3
truncate_to_repo = true

[git_branch]
symbol = ""
format = "[$branch]($style)"

[git_status]
format = '([$all_status$ahead_behind]($style))'

[status]
disabled = false
format = "[$symbol$status]($style) "
map_symbol = true
symbol = "✘"

[cmd_duration]
format = "[$duration]($style) "

[time]
disabled = false
format = "[$time]($style)"
time_format = "%H:%M:%S"

[custom.space]
description = "Space separator"
format = " "
when = "true"
EOF
