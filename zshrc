### Start the zshrc

HISTFILE=~/.zsh_history
HISTSIZE=1000
SAVEHIST=1000
setopt appendhistory autocd extendedglob
unsetopt beep
bindkey -e

zstyle ':completion:*' completer _expand _complete _ignored _approximate
zstyle ':completion:*' menu select
zstyle ':completion:*' list-colors "${(@s.:.)LS_COLORS}"
zstyle :compinstall filename '/Users/blairezhang/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall

# System zshrc for various things.
ZSH_RC="/etc/zshrc"
ZSH_SUGGESTIONS="/opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh"
if [ -f $ZSH_RC ]; then
    source $ZSH_RC
fi
if [ -f $ZSH_SUGGESTIONS ]; then
    source $ZSH_SUGGESTIONS
fi

# Open new tabs in same directory
if [[ "$TERM_PROGRAM" == "Apple_Terminal" ]]; then
  function chpwd {
    printf '\e]7;%s\a' "file://$HOSTNAME${PWD// /%20}"
  }
  chpwd
fi

# Correct key mappings
bindkey -e
bindkey '[C' forward-word
bindkey '[D' backward-word

# Various environment variables
export CLICOLOR=1

# Find and set branch name var if in git repository.
function git_branch_name()
{
  branch=$(git branch --show-current 2> /dev/null)
  if [[ $branch == "" ]];
  then
    echo '<not a git repo>'
  else
    echo ''$branch''
  fi
}

# Enable substitution in the prompt.
setopt prompt_subst

# PATH specifics
export PATH=/opt/homebrew/bin:$PATH

# PROMPT specifics
export PROMPT='%F{magenta}%n%f%F{white} at %f%F{cyan}%m%f%F{white} in %f%B%F{green}%1~%f%b%F{white} on %B%F{yellow}$(git_branch_name) %b%f%# '
export RPROMPT='👩🏻‍💻%t'

alias gswitch='git checkout $(git branch | fzf --height 20% | xargs)'

# end
autoload -U +X bashcompinit && bashcompinit
