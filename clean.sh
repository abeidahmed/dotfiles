#!/usr/bin/env bash
# Unstow dotfile packages from $HOME. Mirror of install.sh.
#
# Usage:
#   ./clean.sh                unstow every package listed in PACKAGES
#   ./clean.sh vim tmux       unstow only the named packages

set -uo pipefail

cd "$(dirname "$(readlink -f "$0")")"

PACKAGES=(
  alacritty asdf bin gitconfig idea irb lib nvim ohmyzsh
  ruby stripe themes tmux vim zsh
)

if [[ $# -gt 0 ]]; then
  packages=("$@")
else
  packages=("${PACKAGES[@]}")
fi

for pkg in "${packages[@]}"; do
  echo "Removing $pkg"
  stow -D -t "$HOME" "$pkg" 2>&1 >/dev/null \
    | grep -v 'BUG in find_stowed_path' >&2 || true
done
