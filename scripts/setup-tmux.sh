#!/bin/sh
set -e

brew install tmux

if [ ! -d "$HOME/.tmux/plugins/tpm" ]; then
    git clone https://github.com/tmux-plugins/tpm "$HOME/.tmux/plugins/tpm"
fi

cat > "$HOME/.tmux.conf" <<'EOF'
# 改变前缀键为 Ctrl+a（更顺手）
unbind C-b
set -g prefix C-a
bind C-a send-prefix

# 允许用鼠标点击切换面板、调整面板大小、滚动屏幕
set -g mouse on

# 从 1 开始编号（0 太远）
set -g base-index 1
setw -g pane-base-index 1
set-window-option -g pane-base-index 1
set-option -g renumber-windows on

# 把分屏快捷键改为更直观的 - 和 |
unbind '"'
unbind %
bind | split-window -h -c "#{pane_current_path}"
bind - split-window -v -c "#{pane_current_path}"

# Vim 风格的面板切换
bind h select-pane -L
bind j select-pane -D
bind k select-pane -U
bind l select-pane -R

# 插件
set -g @plugin 'tmux-plugins/tpm'
set -g @plugin 'tmux-plugins/tmux-sensible'
set -g @plugin 'tmux-plugins/tmux-resurrect'
set -g @plugin 'tmux-plugins/tmux-continuum'

# 开启 256 色支持，防止终端颜色掉色
set -g default-terminal "tmux-256color"

# 自动保存会话
set -g @continuum-restore 'on'

# 初始化 TPM
run '~/.tmux/plugins/tpm/tpm'
EOF
