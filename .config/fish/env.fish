### General
set -x SHELL /usr/local/bin/fish

## Note: Replaced calls to brew --prefix with actual values since
## it is slow (~ 200 ms) (min. b. -p. coreutils; b. -p itsel is quick)
set -x PATH /usr/local/opt/coreutils/libexec/gnubin $PATH

# Use VS Code as the GUI editor, e.g. for adr-tools
set -x VISUAL /usr/local/bin/code
set -x GIT_EDITOR /usr//bin/vim # overwrite VISUAL for git

### JAVA
set -x JAVA_17_HOME (/usr/libexec/java_home -v 17)
set -x JAVA_11_HOME (/usr/libexec/java_home -v 11)

### RBENV
#set -x RBENV_ROOT /usr/local/opt/rbenv
#set -x PATH $RBENV_ROOT/bin $PATH
#set -x PATH $RBENV_ROOT/shims $PATH

set -x GEM_HOME /usr/local/opt/gems
set -x GEM_PATH /usr/local/opt/gems

### NVM
### VIRTUALFISH - FISH VIRTUALENV FOR PYTHON WRAPPER
#eval (python2 -m virtualfish) # Append plugin names if desired 

### AWS
set -x AWS_DEFAULT_REGION eu-west-1
set -x TF_VAR_region $AWS_DEFAULT_REGION
# aws-vault config - use ykman for OTP codes, see https://github.com/99designs/aws-vault/blob/master/USAGE.md#using-a-yubikey
set -x AWS_VAULT_PROMPT ykman

### Rust
set -x PATH $HOME/.cargo/bin $PATH

set -x GRAALVM_HOME /Library/Java/JavaVirtualMachines/graalvm-ce-java11-20.3.0/Contents/Home

### Go
set -x GOPATH $HOME/go
