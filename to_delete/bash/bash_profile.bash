# First .bash_profile is loaded, then everything else

# Moral:
# For bash, put stuff in ~/.bashrc, and make ~/.bash_profile source it.
# For zsh, put stuff in ~/.zshrc, which is always executed.


# Add Homebrew `/usr/local/bin` and User `~/bin` to the `$PATH`
export PATH=/usr/bin:/bin:/usr/sbin:/sbin:/usr/local/bin:/usr/X11/bin:$PATH
export PATH=$HOME/bin:$PATH

HISTFILESIZE=10000000
HISTSIZE=10000000

if [ -f ~/.bashrc ]; then
  source ~/.bashrc
fi

# export CATALINA_HOME="/Users/bnss/Documents/Bricsys/apache-tomcat-7.0.88"
export JAVA_HOME="/Library/Java/JavaVirtualMachines/jdk1.8.0_171.jdk/Contents/Home"
export JAVA_OPTS="-Duser.timezone=Etc/UTC"
# export TZ="Etc/UTC"
export TZ="Europe/Brussels"


# Load the shell dotfiles, and then some:
# * ~/.path can be used to extend `$PATH`.
# * ~/.extra can be used for other settings you don’t want to commit.
for file in ~/.{path,bash_prompt,exports,aliases,functions,extra}; do
  [ -r "$file" ] && source "$file"
done
unset file

# FZF completion
[ -f ~/.fzf.bash ] && source ~/.fzf.bash

# Fix mariadb files not existing, causing chapoo to fail after restart
if [[ ! -e /usr/local/etc/my.cnf.d ]]; then
  mkdir /usr/local/etc/my.cnf.d
elif [[ ! -d /usr/local/etc/my.cnf.d ]]; then
  echo "\"/usr/local/etc/my.cnf.d\" already exists but is not a directory" 1>&2
fi

# Setting PATH for Python 3.5
# The original version is saved in .bash_profile.pysave
export PATH="/Library/Frameworks/Python.framework/Versions/3.5/bin:${PATH}"
export PATH="/usr/local/opt/mariadb@10.1/bin:$PATH"
export PATH="/Library/Java/JavaVirtualMachines/jdk1.8.0_171.jdk/Contents/Home/bin:$PATH"

export PATH="$HOME/.cargo/bin:$PATH"

# To use z
. /usr/local/etc/profile.d/z.sh
