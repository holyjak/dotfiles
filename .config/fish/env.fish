set -x PATH (brew --prefix coreutils)/libexec/gnubin $PATH

### RBENV
set -x RBENV_ROOT (brew --prefix rbenv)
set -x PATH $RBENV_ROOT/bin $PATH
set -x PATH $RBENV_ROOT/shims $PATH

set -x GEM_HOME (brew --prefix)/opt/gems
set -x GEM_PATH (brew --prefix)/opt/gems

### NVM
source ~/.config/fish/nvm-wrapper/nvm.fish
