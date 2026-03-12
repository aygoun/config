#!/bin/bash
set -e

echo "================================================"
echo " Neovim config dependency installer"
echo "================================================"

# ------------------------------------------------
# Homebrew
# ------------------------------------------------
if ! command -v brew &>/dev/null; then
  echo "→ Installing Homebrew..."
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
else
  echo "✓ Homebrew already installed"
fi

# ------------------------------------------------
# Core
# ------------------------------------------------
echo "→ Installing Neovim and core tools..."
brew install neovim git

# ------------------------------------------------
# Telescope dependencies
# ------------------------------------------------
echo "→ Installing Telescope dependencies (ripgrep, fd)..."
brew install ripgrep fd

# ------------------------------------------------
# LSP: Pyright (Python)
# ------------------------------------------------
echo "→ Installing Pyright..."
brew install pyright

# ------------------------------------------------
# LSP: ts_ls (TypeScript / JavaScript)
# ------------------------------------------------
echo "→ Installing TypeScript Language Server..."
brew install node
npm install -g typescript typescript-language-server

# ------------------------------------------------
# LSP: lua_ls (Lua)
# ------------------------------------------------
echo "→ Installing Lua Language Server..."
brew install lua-language-server

# ------------------------------------------------
# Nerd Font (for nvim-web-devicons icons)
# ------------------------------------------------
echo "→ Installing JetBrainsMono Nerd Font..."
brew install --cask font-jetbrains-mono-nerd-font

# ------------------------------------------------
# lazy.nvim will self-bootstrap on first launch
# ------------------------------------------------
echo ""
echo "================================================"
echo " All done! Next steps:"
echo "   1. Open your terminal settings and set the"
echo "      font to 'JetBrainsMono Nerd Font'"
echo "   2. Run: nvim"
echo "      lazy.nvim will auto-install all plugins"
echo "================================================"
