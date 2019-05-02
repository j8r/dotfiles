# My personal dotfiles

Used for my LXQt setup.

Zsh framework [Zim](https://github.com/zimfw/zimfw) with the custom theme [simpla](.zim/modules/prompt/functions/prompt_simpla_setup).

## Installation

Clone the repository to the home directory:

```sh
cd ~/
git clone https://github.com/j8r/dotfiles
mv dotfiles/.git .
rm -rf dotfiles
```

Force overwrite of dotfiles:

`git reset --hard`

## Update subtree

```sh
git stash
git subtree pull --prefix .config/geany/geany-themes https://github.com/geany/geany-themes master --squash
git subtree pull --prefix .config/geany/geany-crystal https://github.com/crystal-lang-tools/geany-crystal master --squash
git stash apply
```

