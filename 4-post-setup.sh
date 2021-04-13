#!/usr/bin/env bash
#-------------------------------------------------------------------------
#      _          _    __  __      _   _
#     /_\  _ _ __| |_ |  \/  |__ _| |_(_)__
#    / _ \| '_/ _| ' \| |\/| / _` |  _| / _|
#   /_/ \_\_| \__|_||_|_|  |_\__,_|\__|_\__|
#  Arch Linux Post Install Setup and Config
#-------------------------------------------------------------------------

echo -e "\nFINAL SETUP AND CONFIGURATION"

# ------------------------------------------------------------------------

#echo -e "\nGenaerating .xinitrc file"
#
## Generate the .xinitrc file so we can launch i3 gaps from the
## terminal using the "startx" command
#cat <<EOF > ${HOME}/.xinitrc
##!/bin/bash
## Disable bell
#xset -b
## Disable all Power Saving Stuff
#xset -dpms
#xset s off
## X Root window color
#xsetroot -solid darkgrey
## Merge resources (optional)
##xrdb -merge $HOME/.Xresources
## Caps to Ctrl, no caps
#setxkbmap -layout us -option ctrl:nocaps
#
#if [ -d /etc/X11/xinit/xinitrc.d ] ; then
#    for f in /etc/X11/xinit/xinitrc.d/?*.sh ; do
#        [ -x "\$f" ] && . "\$f"
#    done
#    unset f
#fi
#
#EOF
#
# ------------------------------------------------------------------------

echo -e "\nUpdating /bin/startx to use the correct path"

# By default, startx incorrectly looks for the .serverauth file in our HOME folder.
sudo sed -i 's|xserverauthfile=\$HOME/.serverauth.\$\$|xserverauthfile=\$XAUTHORITY|g' /bin/startx

# ------------------------------------------------------------------------

echo -e "\nConfiguring LTS Kernel as a secondary boot option"

sudo cp /boot/loader/entries/arch.conf /boot/loader/entries/arch-lts.conf
sudo sed -i 's|Arch Linux|Arch Linux LTS Kernel|g' /boot/loader/entries/arch-lts.conf
sudo sed -i 's|vmlinuz-linux|vmlinuz-linux-lts|g' /boot/loader/entries/arch-lts.conf
sudo sed -i 's|initramfs-linux.img|initramfs-linux-lts.img|g' /boot/loader/entries/arch-lts.conf

# ------------------------------------------------------------------------

echo -e "\nConfiguring MAKEPKG to use all 8 cores"

sudo sed -i -e 's|[#]*MAKEFLAGS=.*|MAKEFLAGS="-j$(nproc)"|g' makepkg.conf
sudo sed -i -e 's|[#]*COMPRESSXZ=.*|COMPRESSXZ=(xz -c -T 8 -z -)|g' makepkg.conf


# ------------------------------------------------------------------------

# echo -e "\nConfiguring vconsole.conf to set latin american keyboard la-latam1"

sudo cat <<EOF > /etc/vconsole.conf
KEYMAP=la-latam1
EOF

# ------------------------------------------------------------------------

echo -e "\nSetting the Arch-Updates Notifier"
mkdir $HOME/.config/autostart/ && sudo cp /usr/share/doc/aarchup/aarchup.desktop /home/francisco/.config/autostart/
sudo cat <<EOF > /usr/share/aarchup/aarchupstartup.sh
#!/bin/bash
if [ -z "$(pgrep 'aarchup$')" ];then
	/usr/bin/aarchup --aur --loop-time 60 --icon /usr/share/aarchup/archlogo.png &
else
    kill -9 $(pgrep 'aarchup$')
    /usr/bin/aarchup --aur --loop-time 60 --icon /usr/share/aarchup/archlogo.png &
fi
EOF
sudo chmod +x /usr/share/aarchup/aarchupstartup.sh

# ------------------------------------------------------------------------

echo -e "\nSetting the touchpad correctly"
sudo cat <<EOF > /etc/X11/xorg.conf.d/30-touchpad.conffine your own colors for rofi using the values you want base
Section "InputClass"
    Identifier "touchpad"
    Driver "libinput"
    MatchIsTouchpad "on"
    Option "Tapping" "on"
    Option "TappingButtonMap" "lrm"
EndSection
EOF

# ------------------------------------------------------------------------

echo -e "\n Setting the keyboard on xorg to la-latam1"
sudo cat <<EOF > /etc/X11/xorg.conf.d/00-keyboard.conf
Section "InputClass"
        Identifier "system-keyboard"
        MatchIsKeyboard "on"
        Option "XkbLayout"  "latam"
        Option "XkbModel"   "pc105"
        Option "XkbVariant" "deadtilde,dvorak"
        Option "XkbOptions" "grp:alt_shift_toggle"
EndSection
EOF

cat <<EOF > ~/nextSteps.md
# NumLock on by default using LightDM
Install the numlockx package and then edit /etc/lightdm/lightdm.conf:

*/etc/lightdm/lightdm.conf*
```
[Seat:*]
greeter-setup-script=/usr/bin/numlockx on
````
EOF

# ------------------------------------------------------------------------

echo -e "\nDisabling buggy cursor inheritance"

# When you boot with multiple monitors the cursor can look huge. This fixes it.
sudo cat <<EOF > /usr/share/icons/default/index.theme
[Icon Theme]
#Inherits=Theme
EOF

# ------------------------------------------------------------------------

echo -e "\nIncreasing file watcher count"

# This prevents a "too many files" error in Visual Studio Code
echo fs.inotify.max_user_watches=524288 | sudo tee /etc/sysctl.d/40-max-user-watches.conf && sudo sysctl --system

# ------------------------------------------------------------------------

echo -e "\nDisabling Pulse .esd_auth module"

# Pulse audio loads the `esound-protocol` module, which best I can tell is rarely needed.
# That module creates a file called `.esd_auth` in the home directory which I'd prefer to not be there. So...
sudo sed -i 's|load-module module-esound-protocol-unix|#load-module module-esound-protocol-unix|g' /etc/pulse/default.pa

# ------------------------------------------------------------------------

echo -e "\nEnabling Login Display Manager"

sudo systemctl enable lightdm.service

# ------------------------------------------------------------------------

echo -e "\nEnabling bluetooth daemon and setting it to auto-start"

sudo sed -i 's|#AutoEnable=false|AutoEnable=true|g' /etc/bluetooth/main.conf
sudo systemctl enable bluetooth.service

# ------------------------------------------------------------------------

echo -e "\nEnabling the cups service daemon so we can print"

systemctl enable --now org.cups.cupsd.service
sudo ntpd -qg
sudo systemctl enable --now ntpd.service

echo -e "\nNetwork setup..."

sudo systemctl enable --now NetworkManager.service


echo -e "\nSetting the custom user directories"
xdg-user-dirs-update


echo "
###############################################################################
# Cleaning
##############################################################################
"
# Remove no password sudo rights
sed -i 's/^%wheel ALL=(ALL) NOPASSWD: ALL/# %wheel ALL=(ALL) NOPASSWD: ALL/' /etc/sudoers
# Add sudo rights
sed -i 's/^# %wheel ALL=(ALL) ALL/%wheel ALL=(ALL) ALL/' /etc/sudoers

# Clean orphans pkg
if [[ ! -n $(pacman -Qdt) ]]; then
	echo "No orphans to remove."
else
	sudo pacman -Rns $(pacman -Qdtq)
fi

# Replace in the same state
cd $pwd
echo "
###############################################################################
# Done
###############################################################################
"

echo "Read the ~/nextSteps.md file for next configurations"
