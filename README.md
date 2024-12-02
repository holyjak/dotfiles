dotfiles
========

Repo with config files. To use the files, you need to symlink them to `$HOME` - run `symlink.sh` to do that.

Remember to `ls -la` to see all the `.*` files here.

Updating linked repos
---------------------

Some config comes from other Git repos, included via `git subtree`, e.g.:

    git remote add -f clojure-deps-edn git@github.com:holyjak/clojure-deps-edn.git
    
    git subtree add --prefix .clojure clojure-deps-edn live --squash
    git subtree add --prefix .oh-my-zsh/custom/plugins/zsh-autosuggestions ohmyzsh-plugin--zsh-autosuggestions master --squash
    git subtree add --prefix .oh-my-zsh/custom/plugins/zsh-syntax-highlighting ohmyzsh-plugin--zsh-syntax-highlighting master --squash
    

To update those you run the same command with `pull` instead of `add`:

    git fetch clojure-deps-edn live
    git subtree pull --prefix .clojure clojure-deps-edn live --squash