source ~/.bash/aliases
source ~/.bash/completions
source ~/.bash/paths
source ~/.bash/config

# use .localrc for settings specific to one system
if [ -f ~/.localrc ]; then
  source ~/.localrc
fi

# rvm: see also bash/paths
if [[ -s "${HOME}/.rvm/scripts/rvm" ]] ; then source "${HOME}/.rvm/scripts/rvm" ; fi

# RVM creates the following entry. Place in bash/paths instead.
# PATH=$PATH:$HOME/.rvm/bin # Add RVM to PATH for scripting

[ -f ~/.fzf.bash ] && source ~/.fzf.bash
