#!/bin/bash
#----------------------------------------------------------------------------
#  ____        _   _               _   _             __ _ _
# |  _ \  ___ | |_(_)_ __   __ _  | |_| |__   ___   / _(_) | ___  ___
# | | | |/ _ \| __| | '_ \ / _` | | __| '_ \ / _ \ | |_| | |/ _ \/ __|
# | |_| | (_) | |_| | | | | (_| | | |_| | | |  __/ |  _| | |  __/\__ \_ _ _
# |____/ \___/ \__|_|_| |_|\__, |  \__|_| |_|\___| |_| |_|_|\___||___(_|_|_)
#                          |___/
#----------------------------------------------------------------------------

echo -e "\nDoting the files :D"
git clone https://github.com/Francisco-Vivas/dotfiles.git
~/dotfiles/scripts/symlink-dotfiles.sh

echo -e "\nInstalling Nvim plugins..."
git clone https://github.com/wbthomason/packer.nvim\
  ~/.local/share/nvim/site/pack/packer/start/packer.nvim
sudo npm install -g vscode-html-languageserver-bin typescript typescript-language-server  vscode-css-languageserver-bin vscode-json-languageserver prettier

nvim --headless +PackerInstall +qall
nvim --headless +TSUpdate +qall

echo -e "\nInstalling vim plugins..."
vim +'PlugInstall --sync' +qa

echo -e "\nInstalling code plugings..."

PLGNS=(
  'aaron-bond.better-comments'
  'eamodio.gitlens'
  'eg2.vscode-npm-script'
  'erikphansen.vscode-toggle-colu.mn-selection'
  'esbenp.prettier-vscode'
  'formulahendry.auto-close-tag'
  'formulahendry.auto-complete-tag'
  'formulahendry.auto-rename-tag'
  'hex-ci.stylelint-plus'
  'jpoissonnier.vscode-styled-com.ponents'
  'mgmcdermott.vscode-language-ba.bel'
  'mhutchie.git-graph'
  'ms-vsliveshare.vsliveshare'
  'ms-vsliveshare.vsliveshare'
  'oderwat.indent-rainbow'
  'pkief.material-icon-theme'
  'pranaygp.vscode-css-peek'
  'ritwickdey.liveserver'
  'steoates.autoimport'
  'streetsidesoftware.code-spell-.checker'
  'visualstudioexptteam.vscodeint.ellicode'
  'xabikos.javascriptsnippets'
  'yzhang.markdown-all-in-one'
  'zhuangtongfa.material-theme'
)

echo -e "\nInstalling code extensions..."
for PLG in "${PLGNS[@]}"; do
    code --install-extension $PLG --force
 done

# Symlink the vscode user preferences
echo -e "\nSetting the users preferences...."
source "~/dotfiles/scripts/linkDot.sh"
linkDot .config/Code/User/settings.json
linkDot .config/Code/User/snippets/javascript.json

figlet "done"
