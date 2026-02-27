#!/bin/bash
set -e

REPO="j-yang/dotfiles"
BRANCH="main"

echo "========================================"
echo "  Bootstrap Script for dotfiles"
echo "========================================"

detect_os() {
    case "$(uname -s)" in
        Darwin*) echo "macos" ;;
        Linux*)
            if [ -f /etc/arch-release ]; then
                echo "arch"
            elif [ -f /etc/debian_version ]; then
                echo "debian"
            elif [ -f /etc/fedora-release ]; then
                echo "fedora"
            else
                echo "linux"
            fi
            ;;
        *) echo "unknown" ;;
    esac
}

install_homebrew() {
    if ! command -v brew &>/dev/null; then
        echo "Installing Homebrew..."
        /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
        
        if [ -f /opt/homebrew/bin/brew ]; then
            eval "$(/opt/homebrew/bin/brew shellenv)"
        elif [ -f /usr/local/bin/brew ]; then
            eval "$(/usr/local/bin/brew shellenv)"
        fi
    fi
    echo "Homebrew installed."
}

install_arch_packages() {
    echo "Updating pacman..."
    sudo pacman -Sy --noconfirm
    
    echo "Installing base packages..."
    sudo pacman -S --noconfirm --needed git curl base-devel
    
    echo "Installing chezmoi..."
    sudo pacman -S --noconfirm chezmoi
    
    echo "Installing mise..."
    if ! command -v mise &>/dev/null; then
        curl -fsSL https://mise.run | sh
        export PATH="$HOME/.local/bin:$PATH"
    fi
    
    echo "Installing yay (AUR helper)..."
    if ! command -v yay &>/dev/null; then
        cd /tmp
        git clone https://aur.archlinux.org/yay.git
        cd yay
        makepkg -si --noconfirm
        cd ~
        rm -rf /tmp/yay
    fi
    
    echo "Arch packages installed."
}

install_debian_packages() {
    echo "Updating apt..."
    sudo apt-get update
    
    echo "Installing base packages..."
    sudo apt-get install -y git curl build-essential
    
    echo "Installing chezmoi..."
    sudo apt-get install -y chezmoi || \
        curl -fsSL https://git.io/chezmoi | sh
    
    echo "Installing mise..."
    if ! command -v mise &>/dev/null; then
        curl -fsSL https://mise.run | sh
        export PATH="$HOME/.local/bin:$PATH"
    fi
    
    echo "Debian packages installed."
}

install_brew_packages() {
    echo "Installing Homebrew packages..."
    
    BREWFILE="$HOME/.local/share/chezmoi/Brewfile"
    if [ -f "$BREWFILE" ]; then
        brew bundle install --file="$BREWFILE"
    fi
    
    BREWFILE_CASKS="$HOME/.local/share/chezmoi/Brewfile.casks"
    if [ -f "$BREWFILE_CASKS" ]; then
        brew bundle install --file="$BREWFILE_CASKS"
    fi
    
    echo "Homebrew packages installed."
}

setup_chezmoi() {
    echo "Initializing chezmoi..."
    
    if [ ! -d "$HOME/.local/share/chezmoi" ]; then
        chezmoi init --apply "$REPO"
    else
        echo "chezmoi already initialized, applying..."
        chezmoi apply
    fi
    
    echo "chezmoi setup complete."
}

setup_mise() {
    echo "Installing mise tools..."
    
    if command -v mise &>/dev/null; then
        mise install
    else
        echo "mise not found, skipping..."
    fi
    
    echo "mise tools installed."
}

setup_tmux_plugins() {
    echo "Installing TPM (Tmux Plugin Manager)..."
    
    TPM_DIR="$HOME/.config/tmux/plugins/tpm"
    if [ ! -d "$TPM_DIR" ]; then
        git clone https://github.com/tmux-plugins/tpm "$TPM_DIR"
        echo "TPM installed. Run 'Prefix + I' in tmux to install plugins."
    else
        echo "TPM already installed."
    fi
}

setup_neovim() {
    echo "Installing Neovim plugins..."
    nvim --headless "+Lazy! sync" +qa 2>/dev/null || true
    echo "Neovim plugins installed."
}

print_post_install() {
    echo ""
    echo "========================================"
    echo "  Setup Complete!"
    echo "========================================"
    echo ""
    echo "Post-install steps:"
    echo "  1. Restart your shell or run: source ~/.zshrc"
    echo "  2. In tmux, press Prefix + I to install plugins"
    echo "  3. Open nvim to finish plugin installation"
    echo "  4. Configure git: git config --global user.name/email"
    echo ""
}

main() {
    OS=$(detect_os)
    echo "Detected OS: $OS"
    echo ""
    
    case "$OS" in
        macos)
            install_homebrew
            setup_chezmoi
            install_brew_packages
            ;;
        arch)
            install_arch_packages
            setup_chezmoi
            ;;
        debian)
            install_debian_packages
            setup_chezmoi
            ;;
        *)
            echo "Unsupported OS: $OS"
            exit 1
            ;;
    esac
    
    setup_mise
    setup_tmux_plugins
    setup_neovim
    print_post_install
}

main "$@"
