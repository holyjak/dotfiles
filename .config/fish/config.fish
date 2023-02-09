source ~/.config/fish/env.fish

if status --is-login
	for p in /usr/bin /usr/local/bin /opt/local/bin /usr/local/mysql/bin /opt/local/lib/postgresql83/bin ~/bin ~/.config/fish/bin 
		if test -d $p
			set PATH $p $PATH
		end
	end
        set PATH /usr/bin /bin /usr/sbin /sbin $PATH # for security reasons, don't overwrite crucial stuff
end

# Load custom settings for current hostname
set HOST_SPECIFIC_FILE ~/.config/fish/(hostname).fish
if test -f $HOST_SPECIFIC_FILE
   source $HOST_SPECIFIC_FILE
else 
   echo Creating host specific file: $HOST_SPECIFIC_FILE
   touch $HOST_SPECIFIC_FILE
end
   
# Load custom settings for current user
set USER_SPECIFIC_FILE ~/.config/fish/(whoami).fish
if test -f $USER_SPECIFIC_FILE
   source $USER_SPECIFIC_FILE
else
   echo Creating user specific file: $USER_SPECIFIC_FILE
   touch $USER_SPECIFIC_FILE
end

# Load custom settings for current OS
set PLATFORM_SPECIFIC_FILE ~/.config/fish/(uname -s).fish
if test -f $PLATFORM_SPECIFIC_FILE
   source $PLATFORM_SPECIFIC_FILE
else
   echo Creating platform specific file: $PLATFORM_SPECIFIC_FILE
   touch $PLATFORM_SPECIFIC_FILE
end  


set fish_greeting ""
set -x CLICOLOR 1

function parse_git_branch
	sh -c 'git branch --no-color 2> /dev/null' | sed -e '/^[^*]/d' -e 's/* \(.*\)/\1/'
end

function parse_svn_tag_or_branch
        sh -c 'svn info | grep "^URL:" | egrep -o "(tags|branches)/[^/]+|trunk" | egrep -o "[^/]+$"'
end

function parse_svn_revision
	sh -c 'svn info 2> /dev/null' | sed -n '/^Revision/p' | sed -e 's/^Revision: \(.*\)/\1/'
end

bind \cr "rake"

function ss -d "Run the script/server"
	script/server
end

function sc -d "Run the Rails console"
	script/console
end

if test -d "/opt/java"
   set -x JAVA_HOME "/opt/java"
end

# yarrr, add /var/lib/gems/1.8/bin to path so gems installed by the retarded ubuntu rubygems package are on the path
set CUSTOM_GEM_PATH "/var/lib/gems/1.8/bin"
if test -d $CUSTOM_GEM_PATH
    set -x PATH $PATH "/var/lib/gems/1.8/bin"
end

# Allow dir-specific env vars (local & parent) via bash-y .envrc
# also add support for switching node
set -x NODE_VERSIONS ~/.nvm/versions/node
set -x NODE_VERSION_PREFIX v # => e.g. .nvm/versions/node/v10.9.0

eval (direnv hook fish)

# Tabtab - A node package to do some custom command line <tab><tab> completion for any system command, for Bash, Zsh, and Fish shells.
# tabtab source for serverless package
# uninstall by removing these lines or running `tabtab uninstall serverless`
#set -l node_dir (dirname (nvm-fish which current))/..
#set -l tabtab_compls $node_dir/lib/node_modules/serverless/node_modules/tabtab/.completions
#[ -f $tabtab_compls/serverless.fish ]; and . $tabtab_compls/serverless.fish
# tabtab source for sls package
# uninstall by removing these lines or running `tabtab uninstall sls`
#[ -f $tabtab_compls/sls.fish ]; and . $tabtab_compls/sls.fish

test -e {$HOME}/.iterm2_shell_integration.fish ; and source {$HOME}/.iterm2_shell_integration.fish

#set -g fish_user_paths "/usr/local/opt/terraform@0.11/bin" $fish_user_paths

# FZF Fuzzy finder
# Disable the legacy key bindings and use the new ones
set -U FZF_LEGACY_KEYBINDINGS 0

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
#eval /usr/local/Caskroom/miniconda/base/bin/conda "shell.fish" "hook" $argv | source
# <<< conda initialize <<<

# Enable starship promt; requires https://www.nerdfonts.com/ eg. Fira Code N.F.
starship init fish | source


source /Users/holyjak/.docker/init-fish.sh || true # Added by Docker Desktop
