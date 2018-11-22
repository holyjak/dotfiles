## Copied & modified from http://notsnippets.tumblr.com/post/894091013/fish-function-of-the-day-prompt-with-git-branch
function fish_prompt --description 'Write out the prompt (JH)'
    # Update z-fish:
    z --add "$PWD"

    # Just calculate these once, to save a few cycles when displaying the prompt
    if not set -q __fish_prompt_hostname
        set -g __fish_prompt_hostname (hostname|cut -d . -f 1)
    end

    if not set -q __fish_prompt_normal
        set -g __fish_prompt_normal (set_color normal)
    end

    if set -q VIRTUAL_ENV
        set __virtualenv (set_color -b blue white) "(" (basename "$VIRTUAL_ENV") ")" (set_color normal) " "
    end

    if [ -n "$http_proxy" ]
      set __prompt_char "\xE2\x9B\x94" # the 'no-entry' emoji in UTF-8 = 3 bytes
    else
      set __prompt_char "🐟"
    end

    # set __pwd (prompt_pwd)  # shortened, ex.: /W/m/m/s/demo-database
    set __pwd (basename $PWD)

    switch $USER

        case root

        if not set -q __fish_prompt_cwd
            if set -q fish_color_cwd_root
                set -g __fish_prompt_cwd (set_color $fish_color_cwd_root)
            else
                set -g __fish_prompt_cwd (set_color $fish_color_cwd)
            end
        end

        printf '%s@%s:%s%s%s%s# ' $USER $__fish_prompt_hostname "$__fish_prompt_cwd" (prompt_pwd) "$__fish_prompt_normal" $__git_cb

        case '*'

        if not set -q __fish_prompt_cwd
            set -g __fish_prompt_cwd (set_color $fish_color_cwd)
        end

        #BEWARE: In iTerm9 - profile - Text - Uncheck "Use unicode 9 widths" to use 🐟; see https://github.com/fish-shell/fish-shell/issues/1502#issuecomment-398624519
        printf '%s%s%s%s%s%s\u0020\u0020' $__virtualenv $__git_cb "$__fish_prompt_cwd" "$__pwd" "$__fish_prompt_normal" $__prompt_char

    end
end
