#!/usr/bin/env bash
#-------------------------------------------------------------------------
#      _          _    __  __      _   _
#     /_\  _ _ __| |_ |  \/  |__ _| |_(_)__
#    / _ \| '_/ _| ' \| |\/| / _` |  _| / _|
#   /_/ \_\_| \__|_||_|_|  |_\__,_|\__|_\__|
#  Arch Linux Post Install Setup and Config
#-------------------------------------------------------------------------

echo -e "\nINSTALLING SOFTWARE\n"

PKGS=(

    # SYSTEM --------------------------------------------------------------

    'linux-lts'             # Long term support kernel

    # TERMINAL UTILITIES --------------------------------------------------

    'bash-completion'       # Tab completion for Bash
    'bleachbit'             # File deletion utility
    'cronie'                # cron jobs
    'curl'                  # Remote content retrieval
    'file-roller'           # Archive utility
    'gufw'                  # Firewall manager
    'hardinfo'              # Hardware info app
    'gtop'                  # System monitoring via terminal
    'htop'                  # Process viewer
    'neofetch'              # Shows system info when you launch terminal
    'ntp'                   # Network Time Protocol to set time via network.
    'numlockx'              # Turns on numlock in X11
    'openssh'               # SSH connectivity tools
    'rsync'                 # Remote file sync utility
    'terminus-font'         # Font package with some bigger fonts for login terminal
    'tlp'                   # Advanced laptop power management
    'p7zip'                 # 7z compression program
    'unrar'                 # RAR compression program
    'unzip'                 # Zip compression program
    'wget'                  # Remote content retrieval
    'alacritty'             # Terminal emulator
    'vim'                   # Terminal Editor
    'zenity'                # Display graphical dialog boxes via shell scripts
    'zip'                   # Zip compression program
    'zsh'                   # ZSH shell
    'zsh-completions'       # Tab completion for ZSH
    'gnome-keyring'         # System password storage
    'jq'                    # JSON parsing library
    'figlet'                # Transform text to ASCII
  # 'speedtest-cli'         # Internet speed via terminal

    # DISK UTILITIES ------------------------------------------------------

    'autofs'                # Auto-mounter
    'btrfs-progs'           # BTRFS Support
    'dosfstools'            # DOS Support
    'exfat-utils'           # Mount exFat drives
    'gvfs-mtp'              # Read MTP Connected Systems
    'gvfs-smb'              # More File System Stuff
    'nautilus-share'        # File Sharing in Nautilus
    'ntfs-3g'               # Open source implementation of NTFS file system
    'gparted'               # Disk utility GUI
    'parted'                # Disk utility
    'smartmontools'         # Disk Monitoring
    'smbclient'             # SMB Connection 
    'xfsprogs'              # XFS Support
  # 'samba'                 # Samba File Sharing
  # 'android-file-transfer' # Android File Transfer

    # GENERAL UTILITIES ---------------------------------------------------

    'flameshot'             # Screenshots
    'nautilus'              # Filesystem browser
    'nitrogen'              # Background browser and setter for X windows
    'veracrypt'             # Disc encryption utility
    'zathura'               # Minimalistic document viewer
    'zathura-djvu'          # DjVu support for Zathura
    'zathura-pdf-poppler'   # Adds pdf support to zathura by using the poppler engine
  # 'variety'               # Wallpaper changer
  # 'remmina'               # Remote Connection
  # 'libvncserver'          # VNC Connections
  # 'freerdp'               # RDP Connections

    # DEVELOPMENT ---------------------------------------------------------

    'gedit'                 # Text editor
    'clang'                 # C Lang compiler
    'cmake'                 # Cross-platform open-source make system
    'electron'              # Cross-platform development using Javascript
    'git'                   # Version control system
    'gcc'                   # C/C++ compiler
    'glibc'                 # C libraries
    'meld'                  # File/directory comparison
    'nodejs'                # Javascript runtime environment
    'npm'                   # Node package manager
    'yarn'                  # Dependency management (Hyper needs this)
    'python'                # Scripting language
  # 'android-tools'         # ADB for Android

    # COMMUNICATIONS ------------------------------------------------------

    'hexchat'                               # Multi format chat
    'firefox'                               # Web browser
    'firefox-developer-edition'             # Dev web browser
    'firefox-developer-edition-i18n-es-mx'  # Language for FFDev Edition

    # MEDIA ---------------------------------------------------------------

    'vlc'                   # Video player
  # 'kdenlive'              # Movie Render
  # 'obs-studio'            # Record your screen
  # 'celluloid'             # Video player
    
    # GRAPHICS AND DESIGN -------------------------------------------------

    'gcolor2'               # Colorpicker
  # 'gimp'                  # GNU Image Manipulation Program
  # 'ristretto'             # Multi image viewer

    # PRODUCTIVITY --------------------------------------------------------

    'hunspell'              # Spellcheck libraries
    'hunspell-en'           # English spellcheck library
    'hunspell-es_co'        # Spanish-CO spellcheck library
  # 'xpdf'                  # PDF viewer

)

for PKG in "${PKGS[@]}"; do
    echo "INSTALLING: ${PKG}"
    sudo pacman -S "$PKG" --noconfirm --needed
done

echo -e "\nDone!\n" 
