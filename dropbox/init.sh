#!/bin/bash

echo "-= Asking for sudo upfront =-"
sudo -v

echo "-= Installing Homebrew =-"
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

echo "-= Creating necessary directories =-"
mkdir -p ~/.config
mkdir -p ~/.vim/autoload ~/.vim/undodir

echo "-= Installing System Dependencies =-"
brew tap caskroom/cask
brew cask install iterm2 kitty mactex
# brew install bash zsh
# echo /usr/local/bin/bash >> /etc/shells
# echo /usr/local/bin/zsh >> /etc/shells
# chsh -s /usr/local/bin/zsh
# exec su - $USER

brew install zsh zsh-completions zsh-syntax-highlighting
brew install vim nvim tmux git npm yarn wget nmap ag tree fd bat rtv netris fortune cowsay lolcat imagemagick pandoc

echo "-= Installing Fonts =-"
brew tap caskroom/fonts
brew cask install font-iosevka
# brew cask install font-fira-code

echo "-= Removing any existing configs =-"
rm -rf ~/.bash_profile ~/.bash_prompt ~/.aliases ~/.vim ~/.vimrc ~/.tmux ~/.tmux.conf 2> /dev/null

echo "-= Symlinking new configs =-"
ln -s ~/Dropbox/dotfiles/bash/bashrc.bash ~/.bashrc
ln -s ~/Dropbox/dotfiles/bash/zshrc ~/.zshrc
ln -s ~/Dropbox/dotfiles/bash/bash_profile.bash ~/.bash_profile
ln -s ~/Dropbox/dotfiles/bash/bash_prompt.bash ~/.bash_prompt
ln -s ~/Dropbox/dotfiles/bash/aliases.bash ~/.aliases
ln -s ~/Dropbox/dotfiles/bash/alacritty.yml ~/.config/alacritty/alacritty.yml

ln -s ~/Dropbox/dotfiles/iterm/kitty.conf ~/.config/kitty/kitty.conf

ln -s ~/Dropbox/dotfiles/vim/vimrc.vim ~/.vimrc
ln -s ~/Dropbox/dotfiles/vim/coc-settings.json ~/.config/nvim/coc-settings.json

ln -s ~/Dropbox/dotfiles/tmux/tmux.conf ~/.tmux.conf

ln -s ~/Dropbox/dotfiles/git/gitignore.git ~/.gitignore
ln -s ~/Dropbox/dotfiles/git/gitconfig.git ~/.gitconfig
ln -s ~/Dropbox/dotfiles/git/gitconfig.work ~/.gitconfig.work

echo "-= Installing misc =-"
cp ~/dropbox/dotfiles/system/* ~/Applications

echo "-= Installing npm stuff =-"
npm i hopa -g

echo "-= Installing Base16 colorschemes =-"
git clone https://github.com/chriskempson/base16-shell.git ~/.config/base16-shell

echo "-= Installing Tmux Plugin Manager =-"
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

echo "-= Scheduling cron jobs =-"
echo "30 16 * * 1-5 ~/Dropbox/dotfiles/eject_tm_disk.sh" | sudo crontab
crontab -l

echo "-= Log out and fire up iTerm2 to see the awesomeness =-"
