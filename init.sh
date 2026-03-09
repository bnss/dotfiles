#!/bin/bash

if [ "$1" = "--backup" ]; then
  echo "-= Backing up existing configs to ~/old_configs =-"
  mkdir -p ~/old_configs
  for f in ~/.config ~/.bash* ~/.zsh* ~/.aliases ~/.vim ~/.vimrc ~/.tmux ~/.tmux.conf ~/.gitignore; do
    [ -e "$f" ] && mv "$f" ~/old_configs/
  done
fi

echo "-= Asking for sudo upfront =-"
sudo -v

# echo "-= Installing Homebrew =-"
# /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

echo "-= Creating necessary directories and files =-"
mkdir -p ~/.config
mkdir -p ~/.vim/autoload ~/.vim/undodir ~/.vim/my-snippets/UltiSnips
mkdir -p ~/.config/nvim/
mkdir -p ~/.config/ghostty/themes
mkdir -p ~/.config/tinted-theming/tinty/
mkdir -p ~/.oh-my-zsh
mkdir -p ~/.claude

touch ~/.tokens
touch ~/.oh-my-zsh/oh-my-zsh.sh

echo "-= Installing System Dependencies =-"
brew install --cask ghostty
brew install --cask iterm2
# brew install --cask mactex
brew install --cask karabiner-elements
brew install --cask gitify
brew install --cask vial
brew install --cask linearmouse
brew install --cask background-music
brew install --cask jordanbaird-ice

echo "-= Installing Theming Dependencies =-"
brew tap tinted-theming/tinted
brew install tinty

# brew install bash zsh
# echo /usr/local/bin/bash >> /etc/shells
# echo /usr/local/bin/zsh >> /etc/shells
# chsh -s /usr/local/bin/zsh
# exec su - $USER

brew install zsh zsh-syntax-highlighting zsh-autosuggestions
brew install node starship vim nvim tmux git npm wget nmap ag tree fd netris fortune cowsay lolcat imagemagick pandoc
brew install fzf bat ripgrep the_silver_searcher perl universal-ctags

echo "-= Installing Fonts =-"
brew tap homebrew/cask-fonts
brew install --cask font-iosevka
brew install --cask font-iosevka-nerd-font
# brew cask install font-fira-code

echo "-= Symlinking new configs =-"
ln -sfn ~/dotfiles/zshrc ~/.zshrc
ln -sfn ~/dotfiles/zsh_history ~/.zsh_history
ln -sfn ~/dotfiles/starship.toml ~/.config/starship.toml
ln -sfn ~/dotfiles/ghostty/config ~/.config/ghostty/config
ln -sfn ~/dotfiles/tinted-theming/tinty/config.toml ~/.config/tinted-theming/tinty/config.toml
ln -sfn ~/dotfiles/karabiner ~/.config/karabiner
ln -sfn ~/dotfiles/aliases ~/.aliases
ln -sfn ~/dotfiles/gitignore ~/.gitignore
ln -sfn ~/dotfiles/vim/vimrc ~/.vimrc
# ln -sfn ~/dotfiles/nvim/init.vim ~/.config/nvim/init.vim
ln -sfn ~/dotfiles/nvim/init.lua ~/.config/nvim/init.lua
ln -sfn ~/dotfiles/nvim/lua ~/.config/nvim/lua
ln -sfn ~/dotfiles/vim/coc-settings.json ~/.config/nvim/coc-settings.json
ln -sfn ~/dotfiles/vim/all.snippets ~/.vim/my-snippets/UltiSnips/all.snippets
ln -sfn ~/dotfiles/tmux/tmux.conf ~/.tmux.conf
ln -sfn ~/dotfiles/.claude/CLAUDE.md ~/.claude/CLAUDE.md
ln -sfn ~/dotfiles/.claude/settings.json ~/.claude/settings.json
ln -sfn ~/dotfiles/.claude/commands ~/.claude/commands
ln -sfn ~/dotfiles/.claude/skills ~/.claude/skills
ln -sfn ~/dotfiles/.claude/statusline-command.sh ~/.claude/statusline-command.sh
ln -sfn ~/dotfiles/.claude/tmux-notify.sh ~/.claude/tmux-notify.sh
ln -sfn ~/dotfiles/.claude/tmux-clear.sh ~/.claude/tmux-clear.sh

# ln -sfn ~/Dropbox/dotfiles/bash/bashrc.bash ~/.bashrc
# ln -sfn ~/Dropbox/dotfiles/bash/bash_profile.bash ~/.bash_profile
# ln -sfn ~/Dropbox/dotfiles/bash/bash_prompt.bash ~/.bash_prompt
# ln -sfn ~/Dropbox/dotfiles/bash/alacritty.yml ~/.config/alacritty/alacritty.yml
# ln -sfn ~/Dropbox/dotfiles/iterm/kitty.conf ~/.config/kitty/kitty.conf

# echo "-= Installing misc =-"
# cp ~/dotfiles/system/* ~/Applications

echo "-= Installing npm stuff =-"
npm i hopa -g
npm install -g @fsouza/prettierd
npm install -g ts-lit-plugin

echo "-= Installing Base16 colorschemes =-"
if [ -d ~/.config/base16-shell ]; then
  git -C ~/.config/base16-shell pull
else
  git clone https://github.com/chriskempson/base16-shell.git ~/.config/base16-shell
fi

echo "-= Installing Tmux Plugin Manager =-"
if [ -d ~/.tmux/plugins/tpm ]; then
  git -C ~/.tmux/plugins/tpm pull
else
  git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
fi

# echo "-= Scheduling cron jobs =-"
# echo "30 16 * * 1-5 ~/Dropbox/dotfiles/eject_tm_disk.sh" | sudo crontab
# crontab -l

echo "-= Initialize theming =-"
tinty install
tinty sync
tinty apply base16-everforest

echo "-= Log out and fire up iTerm2 to see the awesomeness =-"
