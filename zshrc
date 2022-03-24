# Set up the prompt

setopt histignorealldups sharehistory

# Keep 1000 lines of history within the shell and save it to ~/.zsh_history:
HISTSIZE=1000
SAVEHIST=1000
HISTFILE=~/.zsh_history

# Use modern completion system
autoload -Uz compinit
compinit

zstyle ':completion:*' auto-description 'specify: %d'
zstyle ':completion:*' completer _expand _complete _correct _approximate
zstyle ':completion:*' format 'Completing %d'
zstyle ':completion:*' group-name ''
zstyle ':completion:*' menu select=2
eval "$(dircolors -b)"
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' list-colors ''
zstyle ':completion:*' list-prompt %SAt %p: Hit TAB for more, or the character to insert%s
zstyle ':completion:*' matcher-list '' 'm:{a-z}={A-Z}' 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=* l:|=*'
zstyle ':completion:*' menu select=long
zstyle ':completion:*' select-prompt %SScrolling active: current selection at %p%s
zstyle ':completion:*' use-compctl false
zstyle ':completion:*' verbose true

zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#)*=0=01;31'
zstyle ':completion:*:kill:*' command 'ps -u $USER -o pid,%cpu,tty,cputime,cmd'

# Export nvm after installation
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# export paths
source $HOME/.config/plasma-workspace/env/path.sh

# custom aliases
export AWS_PROFILE=staging
alias k="kubectl"
alias d="diff-so-fancy"
alias n="nvim"
alias ls='ls --color'
alias ll="ls -l"
alias bastion="k exec -it deployment/bastion -- /bin/bash"

# key bind control + arrow left, right
bindkey "^[[1;5C" forward-word
bindkey "^[[1;5D" backward-word

# Load context informations
function prompt_me()
{
	branch=$(git symbolic-ref --short HEAD)
  kctx=$(kubectl config current-context)
  ts=$(date +%H:%M:%S)
  if [[ $(git status --porcelain 2> /dev/null | grep -E "^ (M|D)" | wc -l) -ge 1 ]]; then
      symbol="*";
  elif [[ $(git status --porcelain 2> /dev/null | grep -E "^(M|A|D|R|C)" | wc -l) -ge 1 ]]; then
      symbol="+";
  fi
  echo "%F{yellow}$ts%f %F{green}%10~%f %F{red}$branch$symbol%f %F{cyan}$kctx%f > "
}

# Enable substitution in the prompt.
setopt prompt_subst

# Format prompt
prompt='$(prompt_me)'
