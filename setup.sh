#!/bin/bash

# Function to check if a command is available
command_exists() {
  command -v "$1" >/dev/null 2>&1
}

# Update and install packages on Debian/Ubuntu-based systems
update_and_install_debian() {
  sudo apt-get update
  sudo apt-get install -y xclip neovim lazygit alacritty ripgrep
}

# Update and install packages on Red Hat/Fedora-based systems
update_and_install_redhat() {
  sudo yum update -y
  sudo yum install -y xclip neovim lazygit alacritty ripgrep
}

# Update and install packages on openSUSE
update_and_install_opensuse() {
  sudo zypper update -y
  sudo zypper install -y xclip neovim lazygit alacritty ripgrep
}

# Update and install packages on Arch-based systems
update_and_install_arch() {
  sudo pacman -Syu --noconfirm
  sudo pacman -S --noconfirm xclip neovim lazygit alacritty ripgrep
}

# Update and install packages on macOS using Homebrew
update_and_install_macos() {
  brew update
  brew install xclip neovim lazygit alacritty ripgrep gnu-sed
}

# Check the package manager, update the system, and install specified packages
if command_exists apt-get; then
  update_and_install_debian
elif command_exists yum; then
  update_and_install_redhat
elif command_exists zypper; then
  update_and_install_opensuse
elif command_exists pacman; then
  update_and_install_arch
elif command_exists brew; then
  update_and_install_macos
else
  echo "Unsupported package manager. Please update the system and install packages manually."
fi
