# My personal dotfiles

Configurations used for my KDE/LXQt desktop.

Zsh framework [Zim](https://github.com/zimfw/zimfw) with the custom theme [simpla](.zim/modules/prompt/functions/prompt_simpla_setup).

## Setup

### System

- Add the user to the sudoers

`su -c "usermod -aG sudo $USER"`

- Set better GRUB values

```sh
sed -i -e "s/^GRUB_CMDLINE_LINUX_DEFAULT=.*/GRUB_CMDLINE_LINUX_DEFAULT=\"splash quiet loglevel=3\"/" \
       -e 's/^GRUB_TIMEOUT=.*/GRUB_TIMEOUT=1/' /etc/default/grub
```

### Git

- For a vanilla installation, generate a new SSH key

`ssh-keygen -t ed25519`

Then add `cat ~/.ssh/id_ed25519.pub` to GitHub.

- Clone the repository to the home directory

```sh
cd ~/
git init
git remote add origin git@github.com:j8r/dotfiles.git
git fetch
git checkout master
```

Restore specific files, or all if none set

`git checkout -f <files>`

### Zsh

- Change the default shell of the user, then reboot

`chsh -s $(which zsh)`

- Install ZIM

https://github.com/zimfw/zimfw#installation


- Copy the Zsh files and set the prompt for the root user

`su -c "cp -r $HOME/.z* ~/; chsh -s $(which zsh)"`
