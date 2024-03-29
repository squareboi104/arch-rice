#!/bin/sh

# arch-rice
# License: MIT

# Variables
PACKAGES="base-devel xorg xorg-xinit doas vim xorg-drivers dunst neovim zsh stow exa zip unzip unclutter pcmanfm htop firefox gimp mpv zsh-syntax-highlighting sl virtualbox virtualbox-host-modules-arch pulseaudio pulsemixer lutris feh steam rxvt-unicode git zathura flameshot alsa-utils imagemagick openssh nodejs python3 python-pip ttf-liberation"
#AUR_PACKAGES="pfetch"
GIT_DWM="https://github.com/squareboi104/dwm.git"
GIT_SLSTATUS="https://github.com/squareboi104/slstatus.git"
GIT_DMENU="https://git.suckless.org/dmenu"
GIT_DOTFILES="https://github.com/squareboi104/dotfiles.git"
GIT_YAY="https://aur.archlinux.org/yay.git"
STOW_DOTFILES="alacritty fonts nvim tabliss wallpapers xprofile dunst icons neofetch qtile rofi urxvt xinitrc zshrc"

# Start
clear
echo -e "Staritng...\n"

# Config pacman
sudo rm -rf /etc/pacman.conf &&
sudo cp $HOME/arch-rice/pacman.conf /etc/ &&

# Get packages
sudo pacman -Syu --noconfirm &&
sudo pacman -S --noconfirm $PACKAGES &&

# Get dotfiles and WM
mkdir $HOME/.dwm/ &&
git clone $GIT_DWM $HOME/.dwm/dwm && cd $HOME/.dwm/dwm/ && sudo make clean install &&
git clone $GIT_SLSTATUS $HOME/.dwm/slstatus && cd $HOME/.dwm/slstatus/ && sudo make clean install &&
git clone $GIT_DMENU $HOME/.dwm/dmenu && cd $HOME/.dwm/dmenu/ && sudo make clean install &&
git clone $GIT_DOTFILES $HOME/.dotfiles/ && cd $HOME/.dotfiles/ && stow $STOW_DOTFILES &&
git clone $GIT_YAY $HOME/yay && cd $HOME/yay/ && makepkg -si && rm -rf $HOME/yay/ &&

# Get yay packages
yay -S pfetch

# Config doas
sudo cp $HOME/arch-rice/doas.conf /etc/ &&

# Change shell
echo "Changing shell"
chsh -s /bin/zsh #>/dev/null 2>&1

# Python
#pip3 install -U jedi-languaje-server

# Node.js coc.nvim
#nvim -c "CocInstall -sync coc-jedi coc-sh"

# Virtualbox
#sudo modprobe vboxdrv

# Del files
echo ""
read -p "Do you want to delete th WM config files? [y/N]: " do

if [[ $do == "n" ]]; then
    echo "Not deleting anyting."
elif [[ $do == "y" ]]; then
    rm -rf $HOME/.dwm/
    echo "Deleting..."
else
    echo "Not deleting anyting."
fi

# Finish
echo -e "\nRebooting..." && sleep 5 && sudo reboot
