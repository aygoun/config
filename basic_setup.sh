#!/usr/bin/env bash

set -e

echo "🚀 Starting macOS Zsh setup..."

################################
# Install Homebrew if missing
################################
if ! command -v brew &> /dev/null; then
  echo "📦 Installing Homebrew..."
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

echo "📦 Updating Homebrew..."
brew update

################################
# Install core packages
################################
brew install zsh git fzf bat neofetch

################################
# Install Oh My Zsh
################################
if [ ! -d "$HOME/.oh-my-zsh" ]; then
  echo "⚡ Installing Oh My Zsh..."
  RUNZSH=no CHSH=no sh -c \
    "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
fi

################################
# Install Powerlevel10k theme
################################
if [ ! -d "$HOME/.oh-my-zsh/custom/themes/powerlevel10k" ]; then
  echo "🎨 Installing Powerlevel10k..."
  git clone --depth=1 https://github.com/romkatv/powerlevel10k.git \
    ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k
fi

################################
# Install Zsh plugins
################################
echo "🔌 Installing plugins..."

# Autosuggestions
if [ ! -d "$HOME/.oh-my-zsh/custom/plugins/zsh-autosuggestions" ]; then
  git clone https://github.com/zsh-users/zsh-autosuggestions \
    ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
fi

# Syntax highlighting
if [ ! -d "$HOME/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting" ]; then
  git clone https://github.com/zsh-users/zsh-syntax-highlighting \
    ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
fi

################################
# Install fzf keybindings
################################
$(brew --prefix)/opt/fzf/install --all

################################
# Set Zsh as default shell
################################
if [[ "$SHELL" != *"zsh" ]]; then
  echo "🐚 Setting Zsh as default shell..."
  chsh -s $(which zsh)
fi

################################
# Create .zshrc if missing
################################
if [ ! -f "$HOME/.zshrc" ]; then
  echo "📄 Creating .zshrc..."

  cat << 'EOF' > ~/.zshrc
export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="powerlevel10k/powerlevel10k"

plugins=(
git
z
fzf
zsh-autosuggestions
zsh-syntax-highlighting
)

source $ZSH/oh-my-zsh.sh

alias cat="bat --paging=never"

neofetch
EOF

fi

echo "✅ Zsh setup complete."
echo "➡ Restart terminal or run: exec zsh"
