#!/usr/bin/env bash
#-------------------------------------------------------------------------
#      _          _    __  __      _   _
#     /_\  _ _ __| |_ |  \/  |__ _| |_(_)__
#    / _ \| '_/ _| ' \| |\/| / _` |  _| / _|
#   /_/ \_\_| \__|_||_|_|  |_\__,_|\__|_\__|
#  Arch Linux Post Install Setup and Config
#-------------------------------------------------------------------------

echo -e "\nINSTALLING AUR SOFTWARE\n"

cd "${HOME}"

echo "CLONING: YAY"
git clone "https://aur.archlinux.org/yay.git"


PKGS=(

    # SYSTEM UTILITIES ----------------------------------------------------

    'gtkhash'                   # Checksum verifier
    'picom-ibhagwan-git'        # Translucent Windows
    'auracle-git'               # AUR client to check
    'wd719x-firmware'           # Additional firmwares 
    'aic94xx-firmware'          # Additional firmwares 
    'upd72020x-fw'              # Additional firmwares 


  # 'menulibre'                 # Menu editor

    # DEVELOPMENT ---------------------------------------------------------
    
    'neovim-nightly-bin'        # Neovim text editor
    'visual-studio-code-bin'    # Text editor
    'vim-plug'                  # Vim plugin installer
    'ctags'                     # Ctags
    'mongodb-bin'               # A schema-free document-oriented database
    'mongodb-tools-bin'         # A schema-free document-oriented database
    'mongodb-compass'           # The MongoDB GUI
    'postman-bin'               # Build, test, and document APIs
    'responsively'              # Web-responsive tool

    # UTILITIES -----------------------------------------------------------

    'polybar'                   # Status bar
    'betterlockscreen'          # Screen locker
    'notion-app'                # Notes app
    'typora'                    # Markup text editor
    'timeshift'                 # A system restore utility
    'aarchup'                   # Arch update notifier
    'nerd-fonts-jetbrains-mono' # Nerd fonts
    'nerd-fonts-meslo'          # Nerd fonts
  # 'synology-drive'            # Synology Drive
  # 'freeoffice'                # Office Alternative
    
    # MEDIA ---------------------------------------------------------------

    'spotify'                   # Music player
    'vcl'                       # Video player
    'ferdi-bin'                 # Messenger app
    'screenkey'                 # Screencast your keypresses
  # 'lbry-app-bin'              # LBRY Linux Application

    # POST PRODUCTION -----------------------------------------------------

    'peek'                      # GIF animation screen recorder

    # COMMUNICATIONS ------------------------------------------------------

    'brave-bin'                 # Chromium web browser
    'iridium-rpm'               # Chromium web browser
    'skypeforlinux-stable-bin'  # Skype
    'signal-desktop'            # Private messenger
    'zoom'                      # Video Conferencing and Web Conferencing Service
    

    # THEMES --------------------------------------------------------------

    'grub-theme-vimix'              # grub theme - https://github.com/Se7endAY/grub2-theme-vimix
    'lightdm-webkit-theme-aether'   # Lightdm Login Theme - https://github.com/NoiSek/Aether#installation
    'aritim-dark-gtk'               # Desktop Theme
    'papirus-icon-theme'            # Icon theme
    'mcmojave-circle-icon-theme'    # Desktop Icons
    'mcmojave-cursors'              # Cursor Theme
)


cd ${HOME}/yay
makepkg -si

for PKG in "${PKGS[@]}"; do
    yay -S --noconfirm $PKG
done

echo -e "\nDone!\n"
