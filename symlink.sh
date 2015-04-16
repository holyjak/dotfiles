#!/bin/sh
DOTFILES_DIR=$(dirname $0)
cd $DOTFILES_DIR
echo ">>> Symlinking files from $(pwd) to ~/"
for F in $(ls -aA | egrep "^\.[^.]+" | egrep -v "\.config$|\.git$"); do
  ln -s -i ~/dotfiles/$F ~/$F
done

mkdir -p ~/.config/fish
ln -s -i ~/dotfiles/.config/fish/config.fish ~/.config/fish/config.fish
ln -s -i ~/dotfiles/.config/fish/user.fish ~/.config/fish/${USER}.fish
ln -s -i ~/dotfiles/.config/fish/z-fish ~/.config/fish/z-fish
