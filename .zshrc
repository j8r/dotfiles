#
# User configuration sourced by interactive shells
#

# Source zim
if [ -s "${ZDOTDIR:-${HOME}}/.zim/init.zsh" ] ;then
  . ${ZDOTDIR:-${HOME}}/.zim/init.zsh
fi

PATH="$HOME/.local/bin:$PATH"
