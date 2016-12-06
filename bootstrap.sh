#!/bin/sh

# brew
[ ! -f /usr/local/bin/brew ] && /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

# zsh
[ ! -f /usr/local/bin/zsh ] && brew install zsh
grep -q /usr/local/bin/zsh /etc/shells || echo "/usr/local/bin/zsh" | sudo tee -a /private/etc/shell
[ ! "$SHELL" = "/usr/local/bin/zsh" ] && chsh -s /usr/local/bin/zsh

# git
[ ! -f /usr/local/bin/git ] && brew install git

# dotfiles
[ ! -d .dotfiles ] && /usr/local/bin/git clone https://github.com/kuinak/dotfiles .dotfiles
for dotfile in .dotfiles/**/*; do
  [ ! -L ~/.${dotfile##*/} ] && ln -s $dotfile ~/.${dotfile##*/}
done
