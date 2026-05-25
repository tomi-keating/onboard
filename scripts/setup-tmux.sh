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

# 消除 escape 时间延迟
set -s escape-time 10

# 提高历史记录限制
set -g history-limit 50000

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
set -sa terminal-features ",xterm-256color:RGB"

# 自动保存会话
set -g @continuum-restore 'on'

# 初始化 TPM
run '~/.tmux/plugins/tpm/tpm'

# tmux 状态栏位置移到顶部
set -g status-position top

# 开启焦点事件
set -g focus-events on

# ==========================================
# 纯原生极简莫兰迪风状态栏美化
# ==========================================

# 开启状态栏并设置刷新频率（秒）
set -g status on
set -g status-interval 2

# 状态栏整体基础背景色与前景色
set -g status-style "bg=#1e1e2e,fg=#cdd6f4"

# ------------------------------------------
# 左侧显示：当前会话名称 (Session)
# ------------------------------------------
set -g status-left-length 50
set -g status-left "#[fg=#11111b,bg=#a6e3a1,bold] 󰘔 #S #[fg=#a6e3a1,bg=#1e1e2e,nobold]"

# ------------------------------------------
# 中间显示：活动窗口标签页列表 (Windows)
# ------------------------------------------
# 未激活的普通窗口样式
set -g window-status-format "#[fg=#6c7086,bg=#1e1e2e]  #I:#W  "

# 当前正在激活的窗口样式 (带圆角和高亮)
set -g window-status-current-format "#[fg=#1e1e2e,bg=#89b4fa]#[fg=#11111b,bg=#89b4fa,bold]#I:#W#[fg=#89b4fa,bg=#1e1e2e]"

# ------------------------------------------
# 右侧显示：当前运行程序 + 时间
# ------------------------------------------
set -g status-right-length 100
set -g status-right "#[fg=#313244]#[fg=#cdd6f4,bg=#313244]  #{continue_command} #[fg=#45475a,bg=#313244]#[fg=#f5c2e7,bg=#45475a,bold] 🕒 %H:%M "

# 填补空白处的对齐方式（可选 left/center/right）
set -g status-justify left
EOF
