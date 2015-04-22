dotfiles
========

To symlink to `$HOME`, run `symlink.sh`.

Updating linked repos
---------------------

Some config comes from other Git repos, included via git subtree, e.g.:

    git remote add -f emacs-live git@github.com:overtone/emacs-live.git
    git subtree add --prefix .emacs.d emacs-live master --squash

To update those you run the same command with `pull` instead of `add`:

    git fetch emacs-live master
    git subtree pull --prefix .emacs.d emacs-live master --squash
