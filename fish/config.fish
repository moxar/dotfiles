set -x PATH $PATH /snap/bin
set -x PATH $PATH /usr/local/go/bin
set -x PATH $PATH $HOME/go/bin
set -x PATH $PATH $HOME/.bin
set -x PATH $PATH $HOME/.local/bin

# Find and source a per-host configuraiton file
if test -e (dirname (status -f))/host.d/(hostname).fish
        . (dirname (status -f))/host.d/(hostname).fish
end

alias fig="docker-compose"
alias kctl="kubectl"
