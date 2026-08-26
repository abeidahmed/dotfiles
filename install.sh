#!/usr/bin/env bash
# Stow dotfile packages into $HOME.
#
# Usage:
#   ./install.sh              stow every package listed in PACKAGES
#   ./install.sh vim tmux     stow only the named packages
#
# Safe to re-run: `stow -R` re-links a package that is already stowed. A
# package whose target in $HOME is a real file rather than a symlink cannot be
# stowed; those are reported at the end instead of aborting the whole run.

set -uo pipefail

cd "$(dirname "$(readlink -f "$0")")"

# Every top-level directory that is a stow package. old_nvim is deliberately
# excluded: it targets the same ~/.config/nvim as nvim and would conflict.
PACKAGES=(
  alacritty asdf bin gitconfig idea irb lib npm nvim ohmyzsh
  ruby stripe themes tmux vim zsh
)

if [[ $# -gt 0 ]]; then
  packages=("$@")
else
  packages=("${PACKAGES[@]}")
fi

# GNU Stow 2.3.1 prints "BUG in find_stowed_path?" for every symlink in $HOME
# that points outside it (~/.steam/*, for one) while it scans for links it
# owns. Harmless, and noisy enough to bury real conflicts.
stow_quietly() {
  local err status
  err=$(stow -R -t "$HOME" "$1" 2>&1 >/dev/null)
  status=$?
  err=$(grep -v 'BUG in find_stowed_path' <<<"$err")
  [[ -n "$err" ]] && printf '%s\n' "$err" >&2
  return $status
}

failed=()
for pkg in "${packages[@]}"; do
  if stow_quietly "$pkg"; then
    echo "stowed $pkg"
  else
    failed+=("$pkg")
  fi
done

# themes/current is runtime state written by `theme`, so a fresh clone does not
# carry one -- and tmux, alacritty and vim all source through it. Seed a default.
if [[ -d "$HOME/.config/themes" && ! -d "$HOME/.config/themes/current" ]]; then
  ./bin/.local/bin/theme "${THEME:-vague}"
fi

if ((${#failed[@]})); then
  echo >&2
  echo "install.sh: could not stow: ${failed[*]}" >&2
  echo "install.sh: move the conflicting targets out of \$HOME, then re-run" >&2
  exit 1
fi
