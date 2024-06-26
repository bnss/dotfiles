# System
alias aliases="echo ; cat ~/.aliases | grep -E 'alias|#'; echo ; cat ~/.bash_prompt | grep -E '() {' | grep -v function | sed 's/ {//'; echo ;"
alias al='less ~/.aliases'
# alias R='source ~/.bash_profile; echo Bash reloaded...'
alias R='source ~/.zshrc; echo Zsh reloaded...'
alias RZ='source ~/.zshrc; echo Zsh reloaded...'
alias c='clear;'
alias ls='ls -F'
alias ll='ls -lhp'
alias la='ls -lhpa'
alias lsd='ls -l | grep "^d"'
alias du='du -sch'
alias wget='wget -c'
alias cp='cp -p'
alias vi='nvim'
alias vim='nvim'
alias vmi='nvim'
alias rsync='rsync -rav'
alias cat='bat'
alias grep='grep -i'
alias find='fd -H'
alias findswap="\find . -iname '.*.swp'"
alias replaceAll="grep -rl --exclude-dir=node_modules 'toFind' ./ | xargs sed -i '' -e 's/toFind/toReplaceWith/g' "
alias howManyJSFiles="\find ./ -type f -name \*.js | wc -l"
alias howManyFiles="\find ./ -type f | wc -l"
alias Lock="pmset displaysleepnow"
alias Sleep="pmset sleepnow"
alias Shutdown="osascript -e 'tell app \"loginwindow\" to «event aevtrsdn»'"
alias Restart="osascript -e 'tell app \"loginwindow\" to «event aevtrrst»'"

# Utilities
# alias publicIP='curl ipinfo.io/ip'
alias publicIP='dig +short myip.opendns.com @resolver1.opendns.com'
alias backupBrew='brew leaves > ~/Dropbox/dotfiles/bash/brewLeaves.txt; brew list > ~/Dropbox/dotfiles/bash/brewList.txt'
alias backupAtom='tar -czf ~/Dropbox/dotfiles/atom/atom.tar.gz ~/.atom/'
alias matrix='cmatrix'
alias softwareUpdate='sudo softwareupdate -ir && sudo reboot'
alias screenfetch='screenfetch 2> /dev/null'
alias fortunecow='fortune | cowsay | lolcat'
alias music='ncmpcpp' # mpd first
alias musicstop='mpd --kill'
alias openPopcorn='open $TMPDIR/Popcorn-Time'
alias ccalvo='say -v Alex cristian calvo'
alias reddit='rtv -s'
alias banner='figlet'
alias aquarium='asciiquarium'
alias vimup="vim +'PlugUpgrade|PlugInstall|PlugUpdate|qa!'"
alias nfl='~/Documents/code/dotfiles/scripts/nfl.sh'
alias nflScores='~/Documents/code/dotfiles/scripts/nfl.sh'
alias testJs='hopa'

# Go to Directories
alias univ='cd ~/Dropbox/UNIV'
alias db='cd ~/Dropbox'
alias cod='cd ~/Dropbox/Documents/Coding'
alias dotfiles='cd ~/Dropbox/dotfiles'
alias cheat='cd ~/Dropbox/dotfiles/cheatsheets'
alias bric='cd ~/Documents/Bricsys'
alias copyOsToPi='open https://www.raspberrypi.org/documentation/installation/installing-images/mac.md'

# Edit files
alias eZ='vim ~/.zshrc'
alias eA='vim ~/.aliases'
alias eV='vim ~/.vimrc'
alias eU='vim ~/.vim/my-snippets/UltiSnips/all.snippets'
alias eT='vim ~/.tmux.conf'
alias eK='vim ~/.config/kitty/kitty.conf'
alias eS='vim ~/Dropbox/dotfiles/init.sh'

# Open help files
alias cvim='open https://vim.rtorr.com'
alias ctmux='open https://gist.github.com/henrik/1967800; open https://gist.github.com/andreyvit/2921703'
alias cvue='open https://vuejs.org/v2/guide/syntax.html'
# alias cvue='less ~/Dropbox/dotfiles/cheatsheets/Vue/cheatsheet.txt'

# Servers
# alias server='ssh [your server] -t "tmux -CC attach || tmux -CC"'
alias serverfr='ssh root@89.38.148.129'
alias serverit2='ssh root@94.177.180.91'
alias startdb='pg_ctl -D /usr/local/var/postgresql@9.6 start'

# Yarn
alias yarn-update='yarn upgrade-interactive --latest'

# Git
alias gti='git'
alias ga='git add'
alias gm='git merge'
alias gr='git reset'
alias gd='git diff'
alias gb='git branch'
alias gp='git pull'
alias gps='git push'
alias gpl='git pull --rebase'
alias gls='git log --pretty=format:"%C(green)%h\\ %C(yellow)[%ad]%Cred%d\\ %Creset%s%Cblue\\ [%cn]" --decorate --date=relative'
alias gll='git log --pretty=format:"%C(yellow)%h%Cred%d\\ %Creset%s%Cblue\\ [%cn]" --decorate --numstat'
alias gcl='git clone'
alias gci='git commit'
alias gco='git checkout'
alias gcp='git cherry-pick'
alias ggr='git grep -Ii'
alias gcm='git commit -m'
alias gam='git commit --amend'
alias gst='git status -s'
alias gsta='git status'
alias gcma='git commit -a -m'
alias gtree='git log --all --decorate --oneline --graph'
alias gpfr='git push-for-review'
alias gplease='git push --force-with-lease'
alias gconflict='git diff --name-only --diff-filter=U'
# Open current branch
alias ghb='gh tree/$(git symbolic-ref --quiet --short HEAD )'
# Open current directory/file in current branch
alias ghbd="gh tree/$(git symbolic-ref --quiet --short HEAD )/$(git rev-parse --show-prefix)"
# Open current directory/file in master branch
alias ghd='gh tree/master/$(git rev-parse --show-prefix)'

# Games
alias tetris='netris -k "hkl jspf^ln" -i 0.6'  #'bastet'
alias kart='mupen64plus --windowed ~/Dropbox/Documents/ROMs/N64/MarioKart64.n64'
alias mario='mupen64plus --windowed ~/Dropbox/Documents/ROMs/N64/SuperMario64.n64'
alias 007='mupen64plus --windowed ~/Dropbox/Documents/ROMs/N64/007GoldenEye.n64'
alias lego='mupen64plus --windowed ~/Dropbox/Documents/ROMs/N64/LEGORacers.n64'

# Bricsys
alias keycloak='~/Documents/Bricsys/keycloak/bin/standalone.sh -c standalone-ha.xml'
alias catalina='~/Documents/Bricsys/apache-tomcat-7.0.70/bin/catalina.sh'
# alias catalinaBoa='~/Documents/Bricsys/tomcat/bin/catalina.sh'
