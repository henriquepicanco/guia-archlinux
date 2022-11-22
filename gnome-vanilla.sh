#!/bin/bash
# encoding: UTF-8

# VARIABLES

GREEN='\033[0;32m'
NOCOLOR='\033[0m'

# SCRIPT

echo "${GREEN}Instalando os pacotes do GNOME a nível do sistema${NOCOLOR}"
sudo pacman -S gdm gnome-backgrounds gnome-color-manager gnome-control-center gnome-disk-utility gnome-keyring gnome-menus gnome-online-accounts gnome-session gnome-settings-daemon gnome-shell gnome-shell-extensions gnome-software gnome-software-packagekit-plugin gnome-system-monitor gnome-user-docs gnome-user-share gnome-video-effects grilo-plugins gvfs gvfs-afc gvfs-goa gvfs-google gvfs-gphoto2 gvfs-mtp gvfs-nfs gvfs-smb malcontent mutter nautilus orca rygel simple-scan sushi tracker3-miners xdg-user-dirs-gtk yelp pipewire pipewire-alsa pipewire-pulse pipewire-jack bluez bluez-utils --no-confirm

echo "${GREEN}Habilitando o GDM no boot do sistema${NOCOLOR}"
sudo systemctl enable gdm.service

echo "${GREEN}Habilitando o Bluetooth no boot do sistema${NOCOLOR}"
sudo systemctl enable bluetooth.service

echo "${GREEN}Instalando programas extras do GNOME via Flatpak${NOCOLOR}"
flatpak install flathub org.gnome.FileRoller org.gnome.Calculator org.gnome.TextEditor org.gnome.Epiphay org.gnome.Geary org.gnome.Cheese org.gnome.clocks org.gnome.font-viewer org.gnome.eog org.gnome.baobab org.gnome.Evince org.gnome.Calendar org.gnome.Weather org.gnome.Connections org.gnome.Characters org.gnome.Contacts org.gnome.Photos org.gnome.Logs org.gnome.Music org.gnome.Totem org.gnome.Podcasts org.gnome.Solanum org.gnome.World.Secrets com.mattjakeman.ExtensionManager io.posidon.Paper com.belmoussaoui.Authenticator de.haeckerfelix.Fragments io.github.seadve.Mousai com.rafaelmardojai.SharePreview
