# Inspired by https://gist.github.com/britishtea/39ad478fa5180e1432a2
function fish_right_prompt -d "Write out the right prompt"
  set -l exit_code $status
  set -l is_git_repository (git rev-parse --is-inside-work-tree ^/dev/null)

  # Print a red dot for failed commands.
  if test $exit_code -ne 0
    set_color red
    echo -n "• "
    set_color normal
  end

  # If Inside a vaulted shell, print the vault name and whether it is expired
  if [ -n "$VAULTED_ENV" ]
    set vaulted (echo $VAULTED_ENV | sed -E 's/([[:alnum:]])[[:alnum:]]*-(.*)-account?/\1-\2/')"🔓"
    if [ (gdate -d "$VAULTED_ENV_EXPIRATION" +"%s") -lt (gdate +"%s") ]
      set vaulted (set_color -b red)"$vaulted💥"(set_color normal)
    end
    printf "%b" "$vaulted\u0020\u0020"
  end

  # Print coloured arrows when git push (up) and / or git pull (down) can be run.
  #
  # Red means the local branch and the upstream branch have diverted.
  # Yellow means there are more than 3 commits to push or pull.
  if test -n "$is_git_repository"
    git rev-parse --abbrev-ref '@{upstream}' >/dev/null ^&1; and set -l has_upstream

    # Print the name of the parent "project" dir (assume it is inside git)
    set -l git_root (git rev-parse --show-toplevel)
    if [ "$PWD" != "$git_root" ]
        set -l path "$PWD"
        set -l prj_dir "$git_root"
        while [ "$path" != "$git_root" ]
            if [ -e "$path/build.gradle" ]
                set prj_dir $path
            end
            set path (dirname $path)
        end
        echo -n (basename "$prj_dir")
    end

    # Print * when there are uncommited changes
    if not git diff-index --quiet HEAD --
        set changes_marker (set_color white)"*"(set_color normal)
    end

    if not set -q __git_cb
        set_color brown
        # FIXME Add the * if local changes before the branch name
        echo -n "[$changes_marker"(set_color brown)(git branch ^/dev/null | grep \* | sed 's/* //')"] "
        set_color normal
    end

    if set -q has_upstream
      set -l commit_counts (git rev-list --left-right --count 'HEAD...@{upstream}' ^/dev/null)

      set -l commits_to_push (echo $commit_counts | cut -f 1 ^/dev/null)
      set -l commits_to_pull (echo $commit_counts | cut -f 2 ^/dev/null)

      if test $commits_to_push != 0
        if test $commits_to_pull -ne 0
          set_color red
        else if test $commits_to_push -gt 3
          set_color yellow
        else
          set_color green
        end

        echo -n "⇡ "
      end

      if test $commits_to_pull != 0
        if test $commits_to_push -ne 0
          set_color red
        else if test $commits_to_pull -gt 3
          set_color yellow
        else
          set_color green
        end

        echo -n "⇣ "
      end

      set_color normal
    end

    # # Print a "stack symbol" if there are stashed changes.
    # if test (git stash list | wc -l) -gt 0
    #   echo -n "☰ "
    # end
  end

  # Print the username when the user has been changed.
  if test $USER != $LOGNAME
    echo -n "$USER@"
  end

end
