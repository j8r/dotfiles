# My personal dotfiles

Used on my Manjaro LXQt system

## 

## Installation

Clone the repository to the home directory

`git clone --bare https://github.com/j8r/dotfiles ~/.git`

Force reset to use the dotfile of the repository

`git reset --hard`

## Update subtree

`git subtree pull --prefix .config/geany/geany-themes https://github.com/geany/geany-themes master --squash`

`git subtree pull --prefix .config/geany/geany-crystal https://github.com/crystal-lang-tools/geany-crystal master --squash`
