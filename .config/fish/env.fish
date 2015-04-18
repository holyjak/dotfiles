## Note: Replaced calls to brew --prefix with actual values since
## it is slow (~ 200 ms)
set -x PATH /usr/local/opt/libexec/gnubin $PATH

### RBENV
set -x RBENV_ROOT /usr/local/opt/rbenv
set -x PATH $RBENV_ROOT/bin $PATH
set -x PATH $RBENV_ROOT/shims $PATH

set -x GEM_HOME /usr/local/opt/gems
set -x GEM_PATH /usr/local/opt/gems

### NVM
#source ~/.config/fish/nvm-wrapper/nvm.fish
