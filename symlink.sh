#!/bin/sh
DOTFILES_DIR=$(dirname $0)
cd $DOTFILES_DIR
echo ">>> Symlinking files from $(pwd) to ~/"
for F in $(ls -aA | egrep "^\.[^.]+" | egrep -v "\.config$|\.git$"); do
  ln -shi ~/dotfiles/$F ~/$F
done

mkdir -p ~/.config/fish
ln -s -i ~/dotfiles/.config/fish/user.fish ~/.config/fish/${USER}.fish
for F in $(ls .config/fish/ | egrep -v "user\.fish"); do 
  ln -shi ~/dotfiles/.config/fish/$F ~/.config/fish/$F
done
