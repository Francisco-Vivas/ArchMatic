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
git clone https://github.com/Francisco-Vivas/dotfiles.git $HOME
~/dotfiles/scripts/symlink-dotfiles.sh

echo -e "\nInstalling Nvim plugins..."
git clone https://github.com/wbthomason/packer.nvim\
  ~/.local/share/nvim/site/pack/packer/start/packer.nvim
sudo npm install -g vscode-html-languageserver-bin typescript typescript-language-server vscode-css-languageserver-bin vscode-json-languageserver prettier

nvim --headless +PackerInstall +qall
nvim --headless +TSUpdate +qall

echo -e "\nInstalling vim plugins..."
vim +'PlugInstall --sync' +qa

echo -e "\nInstalling vscode extensions..."

EXTENSIONS=(
  'formulahendry.auto-close-tag'
  'formulahendry.auto-complete-tag'
  'steoates.autoimport'
  'formulahendry.auto-rename-tag'
  'mgmcdermott.vscode-language-babel'
  'aaron-bond.better-comments'
  'streetsidesoftware.code-spell-checker'
  'streetsidesoftware.code-spell-checker-spanish'
  'naumovs.color-highlight'
  'anseki.vscode-color'
  'pranaygp.vscode-css-peek'
  'ecmel.vscode-html-css'
  'ms-azuretools.vscode-docker'
  'mikestead.dotenv'
  'digitalbrainstem.javascript-ejs-support'
  'dsznajder.es7-react-js-snippets'
  'dbaeumer.vscode-eslint'
  'mhutchie.git-graph'
  'eamodio.gitlens'
  'oderwat.indent-rainbow'
  'xabikos.javascriptsnippets'
  'ritwickdey.liveserver'
  'MS-vsliveshare.vsliveshare-pack'
  'yzhang.markdown-all-in-one'
  'pkief.material-icon-theme'
  'eg2.vscode-npm-script'
  'christian-kohler.npm-intellisense'
  'zhuangtongfa.material-theme'
  'johnpapa.vscode-peacock'
  'esbenp.prettier-vscode'
  'Prisma.prisma'
  'ThreadHeap.serverless-ide-vscode'
  'hex-ci.stylelint-plus'
  'bradlc.vscode-tailwindcss'
  'erikphansen.vscode-toggle-column-selection'
  'visualstudioexptteam.vscodeintellicode'
  'jpoissonnier.vscode-styled-components'
  'DotJoshJohnson.xml'
)

echo "Installing extensions..."
for EXTENSION in "${EXTENSIONS[@]}"; do
  code --install-extension $EXTENSION --force
done

# Install oh-my-zsh
echo -e "\nInstalling oh-my-zsh"
sh -c "$(wget https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh -O -)"

# Plugins for zsh
echo -e "\nInstalling plugins for zsh"
git clone https://github.com/zsh-users/zsh-syntax-highlighting ~/.oh-my-zsh/custom/plugins
git clone https://github.com/zsh-users/zsh-autosuggestions ~/.oh-my-zsh/custom/plugins

## Install steam?
echo -e "\nInstalling Steam"
sudo pacman -S nvidia nvidia-utils optimus-manager vulkan-intel --noconfirm --needed
sudo pacman -S lib32-nvidia-utils lib32-vulkan-intel --noconfirm --needed
sudo pacman -S steam --noconfirm --needed

## Install pywal and backends? Uncomment the next lines
#sudo pacman -S python-pywal python2 --noconfirm --needed
#yay -S python-haishoku python-colorthief colorz --noconfirm --needed

figlet "done"
