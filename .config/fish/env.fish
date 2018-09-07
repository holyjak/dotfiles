### General
set -x SHELL /usr/local/bin/fish

## Note: Replaced calls to brew --prefix with actual values since
## it is slow (~ 200 ms) (min. b. -p. coreutils; b. -p itsel is quick)
set -x PATH /usr/local/opt/coreutils/libexec/gnubin $PATH

### RBENV
#set -x RBENV_ROOT /usr/local/opt/rbenv
#set -x PATH $RBENV_ROOT/bin $PATH
#set -x PATH $RBENV_ROOT/shims $PATH

set -x GEM_HOME /usr/local/opt/gems
set -x GEM_PATH /usr/local/opt/gems

### NVM
function nvm-fish
  bass source ~/.nvm/nvm.sh ';' nvm $argv
end
nvm-fish use default

### VIRTUALFISH - FISH VIRTUALENV FOR PYTHON WRAPPER
eval (python2 -m virtualfish) # Append plugin names if desired 

### AWS
set -x AWS_DEFAULT_REGION eu-west-1
set -x TF_VAR_region $AWS_DEFAULT_REGION
