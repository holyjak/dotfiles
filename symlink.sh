#!/bin/sh
# Symlink the dotfiles to their target places

# Symlink all files in DIR matching INCLUDE_RE and not matching EXCLUDE_RE into the corresponding path under ~/
# (non-recursive)
function symlink { # SRC_DIR_RELATIVE INCLUDE_RE EXCLUDE_RE
  local RELATIVE_PATH=$1
  local INCLUDE_RE=$2
  [ -z "$INCLUDE_RE" ] && INCLUDE_RE=".*"
  local EXCLUDE_RE=$3
  [ -n "$EXCLUDE_RE" ] && EXCLUDE_RE="$EXCLUDE_RE|"
  local SRC_DIR=~/dotfiles/$RELATIVE_PATH
  local DST_DIR=~/$RELATIVE_PATH
  echo; echo ">> Symlinking $SRC_DIR (excluding $EXCLUDE_RE)"
  [ -d "$DST_DIR" ] || mkdir -p "$DST_DIR"
  for F in $(ls -aA "$SRC_DIR" | egrep "^($INCLUDE_RE)$" | egrep -v "^($EXCLUDE_RE\.|\.\.|\.DS_Store)$"); do
    if [ -L "$DST_DIR/$F" ]; then
      echo "Skipping '$SRC_DIR/$F', already a link"
    elif [ -d "$DST_DIR/$F" ]; then
      echo "ERROR: Trying to symlink the directory '$SRC_DIR/$F' but the destination"
      echo "       '$DST_DIR/$F' already exists and is a dir, which would create a new"
      echo "       symlink inside this dir. Delete it or manually symlink content files."
      exit -1 
    else
      echo "TMP $SRC_DIR/$F -> $DST_DIR/$F"
      ln -shi "$SRC_DIR/$F" "$DST_DIR/$F"
    fi
  done
}

DOTFILES_DIR=$(dirname $0)
cd $DOTFILES_DIR

if [ ! -L "$DOTFILES_DIR/.git/hooks/pre-commit" ]; then
    ln -shi "$DOTFILES_DIR/local-git-hooks/pre-commit" "$DOTFILES_DIR/.git/hooks/pre-commit"
fi

symlink . "\.[^.]+" "\.config|\.git|\.lein"
# Note: this includes .clojure, added via `git submodule add git@github.com:holyjak/clojure-deps-edn.git .clojure`

# .config files
symlink ".config/" ".+\..+"

# .config subdirs:
#symlink ".config/clj-kondo" # "*.edn" # just make the parent dir a symlink
symlink .config "clj-kondo"
symlink ".config/joyride/scripts" ".*" "" # VS Code scripting plugin
symlink .config "git"

symlink ".config/fish" ".*" "user\.fish"
#symlink ".config/fish/functions" ".*" ""
if [ ! -L ~/.config/fish/${USER}.fish ]; then
  ln -s -i ~/dotfiles/.config/fish/user.fish ~/.config/fish/${USER}.fish
fi

# Other dirs #
symlink ".lein" ".*"

symlink Library/LaunchAgents

symlink Library/Preferences/IntelliJIdea15/

symlink 'Library/Application Support/Code/User' "settings\.json"

# Disabled b/c Bass uses deprecated Python 2
#echo ">> Installing Bass (bash wrapper for fish to use nvm etc.)"
#cd ${DOTFILES_DIR}/bass-bash4shell-wrapper && make install

