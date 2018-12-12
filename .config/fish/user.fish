### Fish config executed at startup (user specific)
# :mode=shellscript:
#set JAVA_HOME /Library/Java/JavaVirtualMachines/current/Contents/Home
set PATH ~/Library/$USER/bin-overrides /usr/local/bin $PATH /usr/local/share/python

## iTerm integration
#source .iterm2_shell_integration.fish
#function iterm2_print_user_vars
#  iterm2_set_user_var git_branch (git branch 2> /dev/null | grep \* | cut -c3-)
#end

#### VARIABLES
# For SVN etc.
set -x EDITOR /usr/bin/vim
# Disable UTF-8 as it causes troubles to machines I ssh into
set -x LC_CTYPE
set -x NODE_PATH "$NODE_PATH:/usr/local/lib/node_modules"
set -x PATH $PATH ~/Library/$USER/bin 
# JAVA (Needed also for EC2 tools)

# CLOJURE
#set -x LEIN_JAVA_CMD /usr/local/bin/drip
#set -x LT_HOME /Applications/MyTools/editors/LightTable

### Aliases
# General aliases
alias ll 'ls -lh'
alias la 'ls -lha'
alias lt 'ls -lth'
alias lh 'ls -lth | head'
alias fnm 'find . -name '
alias fraise 'open -a Fraise '
alias top "top -o cpu "
alias mci 'mvn clean install'
alias alis 'alias'
alias g 'grep'
alias xx 'exit'
alias e 'emacsclient -n '
alias vsh 'vagrant ssh'
alias vgs 'vagrant ssh'
alias vgp 'vagrant provision'
alias r 'npm --silent run'
alias p4merge /Applications/p4merge.app/Contents/MacOS/p4merge
alias atom '/Applications/Atom.app/Contents/MacOS/Atom'

# Movement aliases
alias cdd 'cd ~/tmp/delme'

# Git aliases
alias gg 'gitx'
alias gst 'git status'
alias gbr 'git branch --sort=-committerdate'
alias gpom 'git pull --rebase origin master'
alias gitv 'git log --graph --full-history --all --color --pretty=format:"%x1b[31m%h%x09%x1b[32m%d%x1b[0m%x20%s"'
alias gpod 'git pull --rebase origin develop'
alias grev 'git-push-for-review '
alias gfo 'git fetch origin'
#alias gsf 'git svn rebase --fetch-all '
alias gpou 'gpo; and gpu' # Pull then push

function jh_parse_git_branch
       sh -c 'git branch --no-color 2> /dev/null' | sed -e '/^[^*]/d' -e 's/* \(.*\)/\1/'
end
function gpo
  set branch (jh_parse_git_branch)
  echo "[INFO] Pull rebase from $branch ..."
  git pull --rebase origin $branch
end
function gpom
  set branch 'master'
  echo "[INFO] Pull rebase from $branch ..."
  git pull --rebase origin $branch
end
function grhm
  set branch 'master'
  echo "[INFO] reset hard on origin/$branch ..."
  git reset --hard  origin/$branch
end
function grh
  set branch (jh_parse_git_branch)
  echo "[INFO] reset hard on origin/$branch ..."
  git reset --hard  origin/$branch
end
function gpu
  set branch (jh_parse_git_branch)
  echo "[INFO] Pushing to $branch ..."
  git push origin $branch
end
function gpum
   set branch (jh_parse_git_branch)
   echo "[INFO] Pushing $branch:HEAD to master (if no conflicts) ..."
   git push origin HEAD:master
end
function git-push-gerrit
  set branch (jh_parse_git_branch)
  echo "[INFO] Pushing $branch for a Gerrit review ..."
  git push origin HEAD:refs/for/$branch
end
function git-push-gerrit-master
  echo "[INFO] Pushing $branch for a Gerrit review (to master) ..."
  git push origin HEAD:refs/for/master
end

### AMAZON AWS AND EC2 ##################################################
## Config the new aws-cli written in python:

## Config the old java-based cli tools:
# Setup Amazon EC2 Command-Line Tools
#set EC2_PRIVATE_KEY (ls $EC2_HOME/pk-*.pem)
#set EC2_CERT (ls $EC2_HOME/cert-*.pem)
# Set region eu-west-1 as default
#set EC2_URL https://eu-west-1.ec2.amazonaws.com

### PYTHON

### SCALA
set -x SBT_OPTS "-XX:+CMSClassUnloadingEnabled -XX:MaxPermSize=256M"

### Z-fish
# the fish autojumper:
. ~/.config/fish/z-fish/z.fish

# Override the default title
function fish_title --description "Set window/tab title"
   set -l userPWD (echo $PWD | sed "s,$HOME,~,g")
   set -l pwdmaxlen 20
   set -l trunc_symbol ...
   set -l pwd_len (echo $userPWD | wc -m)
   set -l newPWD $userPWD

   if [ $pwd_len -gt 20 ]
      set -l pwdoffset (math $pwd_len - $pwdmaxlen)
      set newPWD $trunc_symbol(echo $userPWD | cut -c {$pwdoffset}-)
   end
   echo "$newPWD" # Note: cmd command included automatically :(
end

## Docker
#function docker-env-universal --description "Set universal docker env vars required to run it"
#   eval (docker-machine env default | sed 's/-g/-U/g')
#end

# Project/client-specific setup
. ~/.config/fish/netcom.fish
