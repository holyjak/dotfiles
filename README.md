dotfiles
========

Repo with config files. To use the files, you need to symlink them to `$HOME` - run `symlink.sh` to do that.

Remember to `ls -la` to see all the `.*` files here.

Working with linked repos (git subtrees)
----------------------------------------

### Setup

Some config comes from other Git repos, included via `git subtree`, e.g.:

    git remote add -f clojure-deps-edn git@github.com:holyjak/clojure-deps-edn.git
    git remote add ohmyzsh-plugin--zsh-autosuggestions git@github.com:zsh-users/zsh-autosuggestions.git
    git remote add ohmyzsh-plugin--zsh-syntax-highlighting git@github.com:zsh-users/zsh-syntax-highlighting.git
    
    git subtree add --prefix .clojure clojure-deps-edn live --squash
    git subtree add --prefix .oh-my-zsh/custom/plugins/zsh-autosuggestions ohmyzsh-plugin--zsh-autosuggestions master --squash
    git subtree add --prefix .oh-my-zsh/custom/plugins/zsh-syntax-highlighting ohmyzsh-plugin--zsh-syntax-highlighting master --squash

### Fetch changes

To update those you run the same command with `pull` instead of `add`:

    git fetch clojure-deps-edn live
    git subtree pull --prefix .clojure clojure-deps-edn live --squash

### Contribute changes upstream

Same as pulling, but with push:

    git subtree push --prefix .clojure clojure-deps-edn live