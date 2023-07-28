#!/usr/bin/env bash

if echo "${@}" | grep "^tmux" &>/dev/null; then
	"${@}"
	exit
fi

# initial checks

if ! command -v tmux &>/dev/null; then
	echo "tmux not found, attempting to start SHELL instead"

	if [ -v $SHELL ]; then
		$SHELL "$@"
		exit
	fi

	echo "SHELL not set, exiting. Press any key (so you had a chance to see this)"
	read
	exit 1
fi

tmuxConfLocation=$HOME/.config/nvim/contrib/tmux.conf

# if [ ! -d /tmp/tmux-vimterm ]; then
# 	if ! mkdir /tmp/tmux-vimterm; then
# 		echo "could not make tmp directory"
# 		echo "press any key"
# 		read
# 		exit 1
# 	fi
# fi

# cat >$tmuxConfLocation <<EOL
# set -g default-terminal "tmux-256color"
# set -ga terminal-overrides ",*256col*:Tc"
# setw -g xterm-keys on
# set -s escape-time 10
# set -sg repeat-time 600
# set -s focus-events on
# set -g mouse on
# set -q -g status-utf8 on
# setw -q -g utf8 on
# setw -g history-limit 50000000
# tmux_conf_copy_to_os_clipboard=true
# set -g status-keys vi
# set -g mode-keys vi
# set -g status-position bottom
# set -g status off
# bind-key -T copy-mode-vi MouseDragEnd1Pane send-keys -X copy-pipe-and-cancel "wl-copy"
# bind-key -T copy-mode-vi v send-keys -X begin-selection
# bind-key -T copy-mode-vi y send-keys -X copy-pipe-and-cancel "wl-copy"
# bind-key -T copy-mode MouseDragEnd1Pane send-keys -X copy-pipe-and-cancel "wl-copy"

# bind-key -T root M-z copy-mode

# bind-key -T copy-mode-vi Tab run-shell "nvim --server $NVIM_LISTEN_ADDRESS --remote-send '<C-S-n><Tab>'"
# bind-key -T copy-mode-vi S-Tab run-shell "nvim --server $NVIM_LISTEN_ADDRESS --remote-send '<C-S-n><S-Tab>'"

# EOL

session=$RANDOM

tmux -S /tmp/vimterm-${session} -f "$tmuxConfLocation" new -s main "$SHELL"
