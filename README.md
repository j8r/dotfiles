# My personal dotfiles

Used for my LXQt desktop.

Zsh framework [Zim](https://github.com/zimfw/zimfw) with the custom theme [simpla](.zim/modules/prompt/functions/prompt_simpla_setup).

## Setup

- Install ZIM:

https://github.com/zimfw/zimfw#installation

- Clone the repository to the home directory:

```sh
cd ~/
git init
git remote add origin https://github.com/j8r/dotfiles
git fetch
```

Restore specific files, or all if none set:

`git checkout master [-f] <files>`

## Update subtree

```sh
git stash
git subtree pull --prefix .config/geany/geany-themes https://github.com/geany/geany-themes master --squash
git subtree pull --prefix .config/geany/geany-crystal https://github.com/crystal-lang-tools/geany-crystal master --squash
git stash apply
```

