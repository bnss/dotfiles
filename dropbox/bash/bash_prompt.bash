# @gf3’s Sexy Bash Prompt, inspired by “Extravagant Zsh Prompt”
# Shamelessly copied from https://github.com/gf3/dotfiles
# Screenshot: http://i.imgur.com/s0Blh.png

###############################################################
# Custom colors {{{
# # if tput setaf 1 &> /dev/null; then
# #   tput sgr0
# #   if [[ $(tput colors) -ge 256 ]] 2>/dev/null; then
# #     # Changed these colors to fit Solarized theme
# #     MAGENTA=$(tput setaf 125)
# #     # ORANGE=$(tput setaf 166)
# #     ORANGE=$(tput setaf 172)
# #     # GREEN=$(tput setaf 64)
# #     # GREEN=$(tput setaf 107)
# #     GREEN=$(tput setaf 114)
# #     PURPLE=$(tput setaf 61)
# #     BLUE=$(tput setaf 75)
# #     WHITE=$(tput setaf 244)
# #   else
# #     MAGENTA=$(tput setaf 5)
# #     ORANGE=$(tput setaf 4)
# #     GREEN=$(tput setaf 2)
# #     PURPLE=$(tput setaf 1)
# #     BLUE=$(tput setaf 4)
# #     WHITE=$(tput setaf 7)
# #   fi
# #   BOLD=$(tput bold)
# #   RESET=$(tput sgr0)
# # else
# #   MAGENTA="\033[0;31m"
# #   GREEN="\033[1;32m"
# #   ORANGE="\033[1;33m"
# #   BLUE="\033[1;34m"
# #   PURPLE="\033[1;35m"
# #   WHITE="\033[1;37m"
# #   BOLD=""
# #   RESET="\033[m"
# # fi

GREEN="\033[1;32m"
ORANGE="\033[1;33m"
BLUE="\033[1;34m"
MAGENTA="\033[0;31m"
PURPLE="\033[1;35m"
WHITE="\033[1;37m"
BOLD=""
RESET="\033[m"

BLACK=$(tput setaf 0)
RED=$(tput setaf 1)
GREEN=$(tput setaf 2)
ORANGE=$(tput setaf 3)
BLUE=$(tput setaf 4)
MAGENTA=$(tput setaf 5)
CYAN=$(tput setaf 6)
WHITE=$(tput setaf 7)
BOLD=$(tput bold)
RESET=$(tput sgr0)

export BLACK
export RED
export GREEN
export ORANGE
export BLUE
export MAGENTA
export CYAN
export PURPLE
export WHITE
export BOLD
export RESET

# cRed=$'%{\e[0;31m%}'
# cYellow=$'%{\e[0;33m%}'
# cBlue=$'%{\e[1;34m%}'
# cNice=$'%{\e[0;36m%}'
# cNop=$'%{\e[0;0m%}'

# function lastExitCode() {
#   local LAST_EXIT_CODE=$?
#   if [[ $LAST_EXIT_CODE -ne 0 ]]; then
#     echo "$cRed$LAST_EXIT_CODE$cNop"
#   else
#     echo $LAST_EXIT_CODE
#   fi
# }

# }}}

###############################################################
# Functions {{{

# ll with github repo
function lsg() {
  paste <(CLICOLOR_FORCE=true ls -ld *) <(for i in *; do if [ -d "$i"/.git ] ; then echo "($(git --git-dir="$i"/.git symbolic-ref --short HEAD))"; else echo; fi; done)
}

# ll with github repo
function lg () {
  ls -alF "$@" | awk '{match($0,/^(\S+\s+){8}(.+)$/,f); b=""; c="git -C \""f[2]"\" branch 2>/dev/null"; while((c|getline g)>0){if(match(g,/^\* (.+)$/,a)){b="("a[1]")"}}; close(c); print$0,b}';
}

function parse_git_dirty() {
  [[ $(git status 2> /dev/null | tail -n1) != *"working directory clean"* ]] && echo "*"
}

function parse_git_branch() {
  git branch --no-color 2> /dev/null | sed -e '/^[^*]/d' -e "s/* \(.*\)/\1$(parse_git_dirty)/"
}

gh(){
  open $(git config remote.origin.url | sed "s/git@\(.*\):\(.*\).git/https:\/\/\1\/\2/")/$1$2
}

weather() {
  curl wttr.in/$1;
}

hour() {
  date "+TIME: %H:%M:%S%nDATE: %Y-%m-%d"
}

mdtopdf() {
  pandoc $1 -s --latex-engine=xelatex -o $2;
}

adoctopdf() {
  asciidoctor -b docbook $1 -o tmp.xml;
  pandoc -f docbook -t latex tmp.xml -s --latex-engine=xelatex -o $2;
  rm tmp.xml;
}

pngtosvg() {
  convert $1 file.pnm;
  potrace file.pnm -s -o file.svg;
  rm file.pnm;
}

rsynctoserverit2() {
  # Add --delete-after to delete files in the target (destination)
  rsync -rav ~/Dropbox/Documents/Coding/HTML5/Ben/* root@94.177.180.91:/var/www/html/ && rsyncsnookertoserverit2;
}

rsyncfromserverit2() {
  rsync -rav root@94.177.180.91:/var/www/html/* ~/Dropbox/Documents/Coding/HTML5/Ben/;
}

rsyncsnookertoserverit2() {
  # Add --delete-after to delete files in the target (destination)
  # rsync -rav ~/Dropbox/Documents/Coding/JavaScript/snooker/* root@94.177.180.91:/var/www/html/snooker/;
  rsync -rav ~/Dropbox/Documents/Coding/React/snookerweb/dist/* root@94.177.180.91:/var/www/html/snooker/;
}

diffserverit2() {
  diff ~/Dropbox/Documents/Coding/HTML5/Ben/ root@94.177.180.91:/var/www/html/;
}

# cd into whatever is the forefront Finder window
cdf() {
  cd "`osascript -e 'tell app "Finder" to POSIX path of (insertion location as alias)'`";
}

# snake_case to camelCase
snaketocamel() {
  PASSED=$1
  if [ -d "${PASSED}" ] ; then
    echo "$PASSED is a directory";
  else
    if [ -f "${PASSED}" ]; then
      sed -E 's/_([a-z])/\U\1/g' < $1
    else
      sed -E 's/_([a-z])/\U\1/g' <<< $1
    fi
  fi
}

#  camelCase to snake_case
cameltosnake() {
  PASSED=$1
  if [ -d "${PASSED}" ] ; then
    echo "$PASSED is a directory";
  else
    if [ -f "${PASSED}" ]; then
      sed -r 's/([a-z0-9])([A-Z])/\1_\L\2/g' < $1
    else
      sed -r 's/([a-z0-9])([A-Z])/\1_\L\2/g' <<< $1
    fi
  fi
}

# download whole website with every visible link
downloadWholeWebsite() {
  if [[ -z $1 ]]; then
    read -e -p "url: " resp;
    wget -mkEpnp $resp -e robots="off";
  else
    wget -mkEpnp $1 -e robots="off";
  fi
}

update() {
  softwareupdate -l;
  # Add if no updates found, exit "No new software available."
  read -e -p "Do you want to update? (y/n): " resp;
  if [[ "$resp" == "y"  ]]; then
    read -e -p "Do you want to update all or only recommended? (a/r): " resp2;
    if [[ "$resp2" == "a"  ]]; then
      echo "I will now proceed to install all updates and reboot afterwards."
      sudo softwareupdate -iav && sudo reboot;
    else
      echo "I will now proceed to install recommended updates and reboot afterwards."
      sudo softwareupdate -irv && sudo reboot;
    fi
    cp $fileTest $file;
  else
    echo "Not doing anything.";
  fi
}

# Notes
no() {
  if [ $# -eq 0 ]; then
    $EDITOR ~/Documents/notes/temp.txt
  else
    $EDITOR ~/Documents/notes/"$*".txt
  fi
}

nls() {
  ls -c ~/Documents/notes/ | grep "$*"
  if [ $? -eq 0 ]; then
    echo "No notes..."
  fi
}

battery() {
  pmset -g batt | egrep "([0-9]+\%).*" -o --colour=auto | cut -f1 -d';'
}

# Go up x steps in directory hierarchy
function up(  ) {
LIMIT=$1
P=$PWD
for ((i=1; i <= LIMIT; i++))
do
  P=$P/..
done
cd $P
export MPWD=$P
}

# Go back x steps in directory hierarchy
function back(  ) {
LIMIT=$1
P=$MPWD
for ((i=1; i <= LIMIT; i++))
do
  P=${P%/..}
done
cd $P
export MPWD=$P
}

# Chapoo Catalina stop
function catalinaStop() {
  kill $(ps aux | grep '[j]ava.*apache.*catalina'| awk '{print $2}')
}

# Remove local branches which are no longer on remote
function gDelete() {
  git checkout master && git fetch -p && git branch -vv | grep -v "\*" | awk '/: gone]/{print $1}' | xargs git branch -D
}

#screenfetch 2>/dev/null;
#neofetch;
#fortuneCow; echo;

# Detect which `ls` flavor is in use
if ls --color > /dev/null 2>&1; then # GNU `ls`
  colorflag="--color"
else # OS X `ls`
  colorflag="-G"
fi

# }}}

###############################################################
# Exports {{{

# Always use color output for `ls`
# alias ls="command ls ${colorflag}"
export LS_COLORS='no=00:fi=00:di=01;34:ln=01;36:pi=40;33:so=01;35:do=01;35:bd=40;33;01:cd=40;33;01:or=40;31;01:ex=01;32:*.tar=01;31:*.tgz=01;31:*.arj=01;31:*.taz=01;31:*.lzh=01;31:*.zip=01;31:*.z=01;31:*.Z=01;31:*.gz=01;31:*.bz2=01;31:*.deb=01;31:*.rpm=01;31:*.jar=01;31:*.jpg=01;35:*.jpeg=01;35:*.gif=01;35:*.bmp=01;35:*.pbm=01;35:*.pgm=01;35:*.ppm=01;35:*.tga=01;35:*.xbm=01;35:*.xpm=01;35:*.tif=01;35:*.tiff=01;35:*.png=01;35:*.mov=01;35:*.mpg=01;35:*.mpeg=01;35:*.avi=01;35:*.fli=01;35:*.gl=01;35:*.dl=01;35:*.xcf=01;35:*.xwd=01;35:*.ogg=01;35:*.mp3=01;35:*.wav=01;35:'

# Set CLICOLOR if you want Ansi Colors in iTerm2
export CLICOLOR=1

export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8
export VISUAL=vim
export EDITOR="$VISUAL"
# export FZF_DEFAULT_COMMAND='ag --ignore node_modules -g ""'

BASE16_SHELL=$HOME/.config/base16-shell/
[ -n "$PS1"  ] && [ -s $BASE16_SHELL/profile_helper.sh  ] && eval "$($BASE16_SHELL/profile_helper.sh)"

# # Set the terminal title and prompt.
# PS1="\[\033]0;\W\007\]"; # working directory base name
# PS1+="\[${bold}\]\n"; # newline
# PS1+="\[${userStyle}\]\u"; # username
# PS1+="\[${white}\] at ";
# PS1+="\[${hostStyle}\]\h"; # host
# PS1+="\[${white}\] in ";
# PS1+="\[${green}\]\w"; # working directory full path
# PS1+="\$(prompt_git \"\[${white}\] on \[${violet}\]\" \"\[${blue}\]\")"; # Git repository details
# PS1+="\n";
# PS1+="\[${white}\]\$ \[${reset}\]"; # `$` (and reset color)
# export PS1;

# export PS1="\[${BOLD}${MAGENTA}\]\u \[$WHITE\]at \[$ORANGE\]\h \[$WHITE\]in \[$GREEN\]\w\[$WHITE\]\$([[ -n \$(git branch 2> /dev/null) ]] && echo \" on \")\[$PURPLE\]\$(parse_git_branch)\[$WHITE\]\n\$ \[$RESET\]"
# export PS1="\[${BOLD}${GREEN}\]\u @ \h \[$BLUE\]\w\[$PURPLE\]\$(parse_git_branch)\[$WHITE\]\n\$ \[$RESET\]"
export PS1="\[$BLUE\]\u \[$GREEN\]\w\[$WHITE\]\$([[ -n \$(git branch 2>/dev/null) ]] && echo \" on \")\[$ORANGE\]\$(parse_git_branch)\[$WHITE\]\n❯ \[$RESET\]"
export PS2="\[$ORANGE\]→ \[$RESET\]"

# export PS1='${cRed}%n${cNop} ${cNice}%m${cNop} $(lastExitCode) ${cYellow}%1~${cNop} ${cBlue}\$${cNop} '

# }}}
