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
# Note: Sourcing nvm.fish takes > 700ms => just get path to node, npm, use nvm from bash when needed
# Note: We need to set NVM_DIR explicitely otherwise it is guessed (wrongly) from the location of nvm.sh:
set -x NVM_DIR ~/.nvm
# source ~/.config/fish/nvm-wrapper/nvm.fish
set PATH (bash -c 'source /usr/local/opt/nvm/nvm.sh && echo $NVM_BIN') $PATH
