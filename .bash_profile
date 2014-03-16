########################
# Table of contents
########################
#
#		1. Colours
#		2. General
# 	3. Functions
#		4. Alias
#
########################

########################
# 1. Colours
########################
BLACK=$(tput setaf 0)
RED=$(tput setaf 1)
GREEN=$(tput setaf 2)
YELLOW=$(tput setaf 3)
LIME_YELLOW=$(tput setaf 190)
POWDER_BLUE=$(tput setaf 153)
BLUE=$(tput setaf 4)
MAGENTA=$(tput setaf 5)
CYAN=$(tput setaf 6)
WHITE=$(tput setaf 7)
BRIGHT=$(tput bold)
NORMAL=$(tput sgr0)
BLINK=$(tput blink)
REVERSE=$(tput smso)
UNDERLINE=$(tput smul)
ESCAPE="Esc[0m"

########################
# 2. General
########################
# Add `~/bin` to the `$PATH`
export PATH="$HOME/bin:$PATH"
# Git
export PATH="/usr/local/git/bin:$PATH"
# SVN
export PATH="/opt/local/bin:$PATH"

PATH=$PATH:$HOME/.rvm/bin # Add RVM to PATH for scripting
[[ -s "$HOME/.rvm/scripts/rvm" ]] && . "$HOME/.rvm/scripts/rvm"

# Load the shell dotfiles, and then some:
# * ~/.path can be used to extend `$PATH`.
# * ~/.extra can be used for other settings you don’t want to commit.
for file in ~/.{path,bash_prompt,exports,aliases,functions,extra}; do
	[ -r "$file" ] && [ -f "$file" ] && source "$file"
done
unset file

# Case-insensitive globbing (used in pathname expansion)
shopt -s nocaseglob

# Append to the Bash history file, rather than overwriting it
shopt -s histappend

# Autocorrect typos in path names when using `cd`
shopt -s cdspell

# Enable some Bash 4 features when possible:
# * `autocd`, e.g. `**/qux` will enter `./foo/bar/baz/qux`
# * Recursive globbing, e.g. `echo **/*.txt`
for option in autocd globstar; do
	shopt -s "$option" 2> /dev/null
done

# Add tab completion for SSH hostnames based on ~/.ssh/config, ignoring wildcards
[ -e "$HOME/.ssh/config" ] && complete -o "default" -o "nospace" -W "$(grep "^Host" ~/.ssh/config | grep -v "[?*]" | cut -d " " -f2 | tr ' ' '\n')" scp sftp ssh

# Add tab completion for `defaults read|write NSGlobalDomain`
# You could just use `-g` instead, but I like being explicit
complete -W "NSGlobalDomain" defaults

# Add `killall` tab completion for common apps
complete -o "nospace" -W "Contacts Calendar Dock Finder Mail Safari iTunes SystemUIServer Terminal Twitter" killall

# If possible, add tab completion for many more commands
[ -f /etc/bash_completion ] && source /etc/bash_completion

# Allow autocompletion for GIT
source ~/.git-completion.bash

# Allow autocompletion for SVN
source ~/.svn-completion.bash

# Ignore certain files and make it colourful
export CLICOLOR=true
export CLICOLOR_FORCE=true

########################
# 3. Functions
########################
function ll {
	ls -la $@ | grep -v -E '(.DS_Store|.localized)';
}

function formataliashelp {
	echo -e ${BLUE}$1${NORMAL}'\t'$2
}

function seekanything {
	FILE=$1;
	mdfind -0 / $FILE | xargs -0 grep -Hi $FILE;
}

########################
# 4. Alias
########################
# Misc
alias dev="cd ~/Dropbox/Development/"
alias sbp="source ~/.bash_profile"
alias obp="subl ~/.bash_profile"

# Alias
alias ah="
formataliashelp 'git*' 'Git'
formataliashelp 'h*' 'Heroku'
formataliashelp 'ruby*' 'Ruby'
formataliashelp 'seek' 'Search file system'
formataliashelp 'svn*' 'Subversion'
"

# Git
alias gith="
formataliashelp 'gita' 'git add -A'
formataliashelp 'gitc' 'git commit'
formataliashelp 'gitl' 'git log'
formataliashelp 'gitp' 'git push'
formataliashelp 'gits' 'git status'
formataliashelp 'gitu' 'git ls-files . --exclude-standard --others'
"
alias gita="git add -A"
alias gitc="git commit -m $1"
alias gitl="git log"
alias gitp="git push"
alias gits="git status"
alias gitu="git ls-files . --exclude-standard --others"

# SVN
alias svnh="format alias help ${VAR2}"
alias svnh="
formataliashelp 'svnaa' 'svn add --force * --auto-props --parents --depth infinity -q'
formataliashelp 'svnc' 'svn commit -m $1'
formataliashelp 'svns' 'svn status'
"
alias svnaa="svn add --force * --auto-props --parents --depth infinity -q"
alias svnc="svn commit -m $1"
alias svns="svn status"

# Heroku
alias hh="
formataliashelp 'hp' 'RAILS_ENV=production rake assets:precompile;git add -A;git commit -m \"assets compiled for Heroku\";git push heroku master;'
"
alias hp="RAILS_ENV=production rake assets:precompile;git add -A;git commit -m 'assets compiled for Heroku';git push heroku master;"

# Ruby
alias rubyh="
formataliashelp 'rubybi' 'bundle install'
"
alias rubybi="bundle install"

# Seek
alias seekh="
formataliashelp 'seek' ''
"
alias seek="seekanything $1"
#"
# Python shell autocomplete
export PYTHONSTARTUP=$HOME/.pythonrc.py