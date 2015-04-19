## Note: Replaced calls to brew --prefix with actual values since
## it is slow (~ 200 ms) (min. b. -p. coreutils; b. -p itsel is quick)
set -x PATH /usr/local/opt/coreutils/libexec/gnubin $PATH

### RBENV
set -x RBENV_ROOT /usr/local/opt/rbenv
set -x PATH $RBENV_ROOT/bin $PATH
set -x PATH $RBENV_ROOT/shims $PATH

set -x GEM_HOME /usr/local/opt/gems
set -x GEM_PATH /usr/local/opt/gems

### NVM
#source ~/.config/fish/nvm-wrapper/nvm.fish
set -x PATH $PATH ~/.nvm/v0.10.38/bin
