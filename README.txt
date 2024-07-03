" If you choose not to symlink:
"   Before you use vim, put this in actual .vimrc file on local machine
"   set runtimepath^=~/Dropbox/dotfiles/vim
"   source ~/Dropbox/dotfiles/vim/vimrc.vim

" Else if you choose to symlink:
"   This is how to symlink from within the home directory:
"   ln -s ~/Dropbox/dotfiles/vim/vimrc.vim .vimrc

To symlink:
ln -nfs ~/Dropbox/dotfiles/vim/vimrc.vim ~/.vimrc

