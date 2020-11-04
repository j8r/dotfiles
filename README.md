# My personal dotfiles

Used for my LXQt desktop.

Zsh framework [Zim](https://github.com/zimfw/zimfw) with the custom theme [simpla](.zim/modules/prompt/functions/prompt_simpla_setup).

## Setup

- For a vanilla installation, generate a new SSH key

`ssh-keygen -t ed25519`

Then add `cat ~/.ssh/id_ed25519.pub` to GitHub.

- Install ZIM:

https://github.com/zimfw/zimfw#installation

- Change the default shell of the user.

`chsh -s $(which zsh)`

- Clone the repository to the home directory

```sh
cd ~/
git init
git remote add origin git@github.com:j8r/dotfiles.git
git fetch
```

Restore specific files, or all if none set

`git checkout -f <files>`

- Add the user to the sudoers

`su -c "usermod -aG sudo $USER"`

- Copy the Zsh files and set the prompt for the root user

`su -c "cp -r $HOME/.z* ~/; chsh -s $(which zsh)"`

- Logout to apply the changes to the user

## Update subtree

```sh
git stash
git subtree pull --prefix .config/geany/geany-themes https://github.com/geany/geany-themes master --squash
git subtree pull --prefix .config/geany/geany-crystal https://github.com/crystal-lang-tools/geany-crystal master --squash
git stash apply
```
