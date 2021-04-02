#!/usr/bin/env bash
#-------------------------------------------------------------------------
#      _          _    __  __      _   _
#     /_\  _ _ __| |_ |  \/  |__ _| |_(_)__
#    / _ \| '_/ _| ' \| |\/| / _` |  _| / _|
#   /_/ \_\_| \__|_||_|_|  |_\__,_|\__|_\__|
#  Arch Linux Post Install Setup and Config
#-------------------------------------------------------------------------

echo -e "\nInstalling Base System\n"

PKGS=(

    # XORG DISPLAY RENDERING ----------------------------------------------
  
    'xorg'                  # XOrg meta package
    'xorg-drivers'          # Display Drivers 
    'xorg-server'           # XOrg server
    'xorg-apps'             # XOrg apps group
    'xorg-xinit'            # XOrg init
    'mesa'                  # Open source version of OpenGL
    'xf86-video-intel'      # 2D/3D video driver
    'xterm'                 # Terminal for TTY
  # 'xorg-xinput'           # Xorg xinput
  # 'xf86-input-libinput'   # Trackpad driver for Dell XPS

    # SETUP DESKTOP -------------------------------------------------------
    
    'i3-gaps'               # i3 Gaps Window Manager
    'i3status'              # Status bar
    'i3blocks'              # Blocks for i3bar status line
    'dunst'                 # Notification daemon
    'rofi'                  # Menu System
    'xfce4-power-manager'   # Power Manager 
    'picom'                 # Translucent Windows
    'xclip'                 # System Clipboard
    'gnome-polkit'          # Elevate Applications
    'lxappearance'          # Set System Themes

    # LOGIN DISPLAY MANAGER ------------------------------------------------
    
    'lightdm'                       # Base Login Manager
    'lightdm-webkit2-greeter'       # Framework for Awesome Login Themes

    # NETWORK --------------------------------------------------------------
    
    'wpa_supplicant'            # Key negotiation for WPA wireless networks
    'dialog'                    # Enables shell scripts to trigger dialog boxex
    'networkmanager'            # Network connection manager
    'openvpn'                   # Open VPN support
    'networkmanager-openvpn'    # Open VPN plugin for NM
    'network-manager-applet'    # System tray icon/utility for network connectivity
    'libsecret'                 # Library for storing passwords
    
    # AUDIO -----------------------------------------------------------------

    'alsa-utils'        # Advanced Linux Sound Architecture (ALSA) Components https://alsa.opensrc.org/
    'alsa-plugins'      # ALSA plugins
    'pulseaudio'        # Pulse Audio sound components
    'pulseaudio-alsa'   # ALSA configuration for pulse audio
    'pavucontrol'       # Pulse Audio volume control
    'pnmixer'           # System tray volume control

    # BLUETOOTH --------------------------------------------------------------

    'bluez'                 # Daemons for the bluetooth protocol stack
    'bluez-utils'           # Bluetooth development and debugging utilities
    'bluez-firmware'        # Firmwares for Broadcom BCM203x and STLC2300 Bluetooth chips
    'blueberry'             # Bluetooth configuration tool
    'pulseaudio-bluetooth'  # Bluetooth support for PulseAudio
    
    # PRINTERS ---------------------------------------------------------------

    'cups'                  # Open source printer drivers
    'cups-pdf'              # PDF support for cups
    'ghostscript'           # PostScript interpreter
    'gsfonts'               # Adobe Postscript replacement fonts
    'hplip'                 # HP Drivers
    'system-config-printer' # Printer setup  utility
)

for PKG in "${PKGS[@]}"; do
    echo "INSTALLING: ${PKG}"
    sudo pacman -S "$PKG" --noconfirm --needed
done

echo -e "\nDone!\n"
