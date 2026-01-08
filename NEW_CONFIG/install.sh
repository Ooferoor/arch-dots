#!/bin/bash
set -e 

sudo pacman -Syu --noconfirm >/dev/null
echo "Updating System..."

PACMAN-PACKAGES=(git base-devel blueman bluez-utils bluez-libs bluez brightnessctl btop cava curl wget fastfetch gtk3 gtk4 gvfs hyprland hyprshot pavucontrol pipewire pipewire-alsa pipewire-jack pipewire-pulse playerctl polkit python swaync grim slurp networkmanager network-manager-applet mesa vulkan-radeon wayland wayland-protocols wireplumber wl-clipboard wlogout waybar wofi xdg-desktop-portal xdg-desktop-portal-hyprland xorg-xwayland thunar kitty starship zsh)
AUR_PACKAGES=()

sudo pacman -S "${PACMAN-PACKAGES[@]}" --noconfirm >/dev/null
echo "Installing Pacman Packages..."

if ! command -v yay >/dev/null; then
    echo "yay not found, installing..."
    git clone https://aur.archlinux.org/yay.git /tmp/yay
    cd /tmp/yay
    makepkg -si --noconfirm
    cd ~
    rm -rf /tmp/yay
else
    echo "yay was found, skipping..."
fi

yay -S "${AUR_PACKAGES}[@]" --noconfirm >/dev/null

sudo systemctl enable NetworkManager
sudo systemctl enable bluetooth
sudo systemctl enable pipewire

echo "Backing up previous ~/.config files"
[-d "$HOME/.config"] && mv "HOME/.config" "$HOME/.config.backup.$(date +%s)"

cp -r ~/arch-dotfiles/.config ~/.config

echo "Copying config files to .config..."

echo "Setup Complete'

for later to keep track, You need to setup the zsh install and edit current configs cause current doesn't work
