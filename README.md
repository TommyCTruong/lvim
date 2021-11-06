# dotfiles

## Dependencies

Manage dotfiles:
* brew install stow


LunarVim:
* Follow install instructions at [lunarvim.org](https://www.lunarvim.org/01-installing.html)

zsh funcs:
* brew install fzf
* brew install git
* brew install diff-so-fancy
* brew install --cask docker
* [Brave](https://brave.com/download/)
* [Chrome](https://www.google.com/chrome/)


zsh aliases:
* brew install exa

tmux:
* brew install tmux

gitmux:
* go install github.com/arl/gitmux@latest

## Install

Dotfiles can be installed using `stow`, which  is a symlink farm manager. It takes distinct packages of software and/or
data located in separate directories on the filesystem, and makes them appear to be installed in the same place. For 
example, install nvim by running `stow lvim`. Install everything (excluding files in the current directory) by running `stow */`.
Stow treats each directory as the $HOME directory on your system and will create symlinks following the same file structure. 
For example, the $HOME/.config/zsh/ directory will symlinked to $HOME/dotfiles/zsh/.config/zsh (assuming you cloned this
repo into $HOME).

## Notes

In the zsh config, GOPATH is exported to $HOME/.local/share/go. This means that you need to move the Go installation to $HOME/.local/share/go.
