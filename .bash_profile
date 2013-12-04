# Add `~/bin` to the `$PATH`
export PATH="$HOME/bin:$PATH"

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

########################
# Alias
########################
# Misc
alias dev="cd ~/Dropbox/Development/"
alias sbp="source ~/.bash_profile"
alias obp="subl ~/.bash_profile"

# Git
alias gitl="git log"
alias gita="git add -A"
alias gitc="git commit -m $1"
alias gits="git status"
alias gitp="git push"
alias gitu="git ls-files . --exclude-standard --others"

# Heroku
alias hp="RAILS_ENV=production rake assets:precompile;git add -A;git commit -m 'assets compiled for Heroku';git push heroku master;"

# Ignore certain files and make it colourful
export CLICOLOR=true
export CLICOLOR_FORCE=true
function ll { ls -la $@ | grep -v -E '(.DS_Store|.localized)'; }