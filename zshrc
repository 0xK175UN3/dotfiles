export ZSH="/home/k175un3/.oh-my-zsh"
ZSH_THEME="lambda"

plugins=(
  git
)

source $ZSH/oh-my-zsh.sh

# NVM
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm

# Rbenv
export PATH="$HOME/.rbenv/bin:$PATH"
eval "$(rbenv init -)"

# Stack
export PATH="$HOME/.local/bin:$PATH"

# Connections
function tunnelup() {
ssh -f -N $1
echo "Started tunnel $1"
}

function tunneldown() {
pkill -f "ssh -f -N $1"
echo "Killed tunnel $1"
}

alias tunnellist='ps waux | grep "ssh -f -N"'
