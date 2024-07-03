#!/bin/bash

echo "-= Asking for sudo upfront =-"
sudo -v

# echo "-= Installing Homebrew =-"
# /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

echo "-= Removing any existing folders and configs =-"
mkdir ~/old_configs
mv {~/.config,~/.bash*,~/.zsh*,~/.aliases,~/.vim,~/.vimrc,~/.tmux,~/.tmux.conf} ~/old_configs

echo "-= Creating necessary directories =-"
mkdir -p ~/.config
mkdir -p ~/.vim/autoload ~/.vim/undodir
mkdir -p ~/.config/nvim/
mkdir -p ~/.config/karabiner

echo "-= Installing System Dependencies =-"
brew install --cask iterm2
# brew install --cask mactex
brew install --cask karabiner-elements

# brew install bash zsh
# echo /usr/local/bin/bash >> /etc/shells
# echo /usr/local/bin/zsh >> /etc/shells
# chsh -s /usr/local/bin/zsh
# exec su - $USER

# brew install zsh zsh-completions zsh-syntax-highlighting
brew install node starship vim nvim tmux git npm wget nmap ag tree fd bat netris fortune cowsay lolcat imagemagick pandoc ripgrep the_silver_searcher

echo "-= Installing Fonts =-"
brew tap homebrew/cask-fonts
brew install --cask font-iosevka
# brew cask install font-fira-code

echo "-= Symlinking new configs =-"
ln -s ~/dotfiles/zshrc ~/.zshrc
ln -s ~/dotfiles/zsh_history ~/.zsh_history
ln -s ~/dotfiles/starship.toml ~/.config/starship.toml
ln -s ~/dotfiles/karabiner/karabiner.json ~/.config/karabiner/karabiner.json
ln -s ~/dotfiles/aliases ~/.aliases
ln -s ~/dotfiles/vim/vimrc ~/.vimrc
ln -s ~/dotfiles/vim/coc-settings.json ~/.config/nvim/coc-settings.json
ln -s ~/dotfiles/tmux/tmux.conf ~/.tmux.conf

# ln -s ~/Dropbox/dotfiles/bash/bashrc.bash ~/.bashrc
# ln -s ~/Dropbox/dotfiles/bash/bash_profile.bash ~/.bash_profile
# ln -s ~/Dropbox/dotfiles/bash/bash_prompt.bash ~/.bash_prompt
# ln -s ~/Dropbox/dotfiles/bash/alacritty.yml ~/.config/alacritty/alacritty.yml
# ln -s ~/Dropbox/dotfiles/iterm/kitty.conf ~/.config/kitty/kitty.conf

# echo "-= Installing misc =-"
# cp ~/dotfiles/system/* ~/Applications

echo "-= Installing npm stuff =-"
npm i hopa -g

echo "-= Installing Base16 colorschemes =-"
git clone https://github.com/chriskempson/base16-shell.git ~/.config/base16-shell

echo "-= Installing Tmux Plugin Manager =-"
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

# echo "-= Scheduling cron jobs =-"
# echo "30 16 * * 1-5 ~/Dropbox/dotfiles/eject_tm_disk.sh" | sudo crontab
# crontab -l

echo "-= Log out and fire up iTerm2 to see the awesomeness =-"
