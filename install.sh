#!/usr/bin/env bash
#
# Neovim setup bootstrap for macOS.
# Idempotent: each step checks before installing.
# See PREREQUISITES.md for the full list and rationale.

set -euo pipefail

GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
RESET='\033[0m'

info()  { printf "${BLUE}==>${RESET} %s\n" "$*"; }
ok()    { printf "${GREEN}✓${RESET}  %s\n" "$*"; }
skip()  { printf "${YELLOW}·${RESET}  %s (already installed)\n" "$*"; }

have_cmd()    { command -v "$1" >/dev/null 2>&1; }
brew_has()    { brew list --formula --versions "$1" >/dev/null 2>&1; }
cask_has()    { brew list --cask --versions "$1" >/dev/null 2>&1; }

ensure_brew_formula() {
	local pkg="$1"
	if brew_has "$pkg"; then skip "$pkg"; else info "Installing $pkg"; brew install "$pkg"; ok "$pkg"; fi
}

ensure_brew_cask() {
	local pkg="$1"
	if cask_has "$pkg"; then skip "$pkg (cask)"; else info "Installing $pkg (cask)"; brew install --cask "$pkg"; ok "$pkg"; fi
}

# ---------------------------------------------------------------------------
# 1. Xcode Command Line Tools (needed by Treesitter to compile parsers)
# ---------------------------------------------------------------------------
if xcode-select -p >/dev/null 2>&1; then
	skip "Xcode Command Line Tools"
else
	info "Installing Xcode Command Line Tools (follow the GUI prompt)"
	xcode-select --install
	read -r -p "Press ENTER once the Xcode CLT install has completed..."
fi

# ---------------------------------------------------------------------------
# 2. Homebrew
# ---------------------------------------------------------------------------
if have_cmd brew; then
	skip "Homebrew"
else
	info "Installing Homebrew"
	/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
	# Add to PATH for the remainder of this script
	if [[ -x /opt/homebrew/bin/brew ]]; then
		eval "$(/opt/homebrew/bin/brew shellenv)"
	elif [[ -x /usr/local/bin/brew ]]; then
		eval "$(/usr/local/bin/brew shellenv)"
	fi
	ok "Homebrew"
fi

# ---------------------------------------------------------------------------
# 3. Core tooling
# ---------------------------------------------------------------------------
info "Core tooling"
ensure_brew_formula neovim
ensure_brew_formula git
ensure_brew_formula fzf
ensure_brew_formula ripgrep
ensure_brew_formula node

# ---------------------------------------------------------------------------
# 4. Nerd Font
# ---------------------------------------------------------------------------
info "Nerd Font"
ensure_brew_cask font-hack-nerd-font

# ---------------------------------------------------------------------------
# 5. Plugin manager (vim-plug)
# ---------------------------------------------------------------------------
PLUG_PATH="${XDG_DATA_HOME:-$HOME/.local/share}/nvim/site/autoload/plug.vim"
if [[ -f "$PLUG_PATH" ]]; then
	skip "vim-plug"
else
	info "Installing vim-plug"
	curl -fLo "$PLUG_PATH" --create-dirs \
		https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
	ok "vim-plug"
fi

# ---------------------------------------------------------------------------
# 6. LSP servers
# ---------------------------------------------------------------------------
info "LSP servers"
ensure_brew_formula gopls
ensure_brew_formula pyright
ensure_brew_formula jdtls
ensure_brew_formula openjdk@21   # jdtls requires JDK 17+

# terraform-ls lives in a tap
if brew_has terraform-ls; then
	skip "terraform-ls"
else
	info "Installing terraform-ls (hashicorp tap)"
	brew tap hashicorp/tap
	brew install hashicorp/tap/terraform-ls
	ok "terraform-ls"
fi

# Dart / Flutter — only warn; we don't manage Flutter installs here
if have_cmd dart; then
	ok "dart ($(dart --version 2>&1 | head -n1))"
else
	echo "${YELLOW}!${RESET}  dart not found on PATH."
	echo "   Install Flutter from https://docs.flutter.dev/get-started/install/macos"
	echo "   then add flutter/bin to your PATH in ~/.zshrc."
fi

# ---------------------------------------------------------------------------
# 7. Install plugins + Treesitter parsers
# ---------------------------------------------------------------------------
info "Installing Neovim plugins (:PlugInstall)"
nvim --headless +PlugInstall +qa 2>/dev/null || true
ok "plugins"

info "Updating Treesitter parsers (:TSUpdate)"
nvim --headless '+TSUpdateSync' +qa 2>/dev/null || true
ok "treesitter parsers"

# ---------------------------------------------------------------------------
# Done
# ---------------------------------------------------------------------------
printf "\n${GREEN}All set.${RESET} Open nvim and run ${BLUE}:checkhealth${RESET} to verify.\n"
