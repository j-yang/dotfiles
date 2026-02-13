#!/bin/bash
set -e

rm -f "$HOME/.tmux.conf" "$HOME/.tmux.conf.local"
ln -s "$HOME/.config/tmux/tmux.conf" "$HOME/.tmux.conf"
ln -s "$HOME/.config/tmux/tmux.conf.local" "$HOME/.tmux.conf.local"
echo "Created tmux symlinks"
