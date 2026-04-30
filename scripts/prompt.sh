#!/bin/bash
# ---------------------------------------------------------
# CAT & ROCKET PROMPT CORE LOGIC (venv-safe version)
# ---------------------------------------------------------

# Load Git prompt support safely
if [ -f /usr/lib/git-core/git-sh-prompt ]; then
    . /usr/lib/git-core/git-sh-prompt
elif [ -f /etc/bash_completion.d/git-prompt ]; then
    . /etc/bash_completion.d/git-prompt
fi

# Path Shortener
short_path_logic() {
    local p="${PWD/#$HOME/~}"
    echo "$p" | awk -F/ '{
        for (i=1; i<=NF; i++) {
            if (i==1 && $i=="~") printf "~"
            else if (i<NF && length($i)>0) printf "/%s", substr($i,1,1)
            else if (i==NF) { if (i==1) printf "%s", $i; else printf "/%s", $i }
        }
    }'
}

# Animation
cat_frames=("🐱" "🐈" "😺" "😸")
cat_i=0

update_prompt() {
    local exit_code=$?

    # Animate cat
    cat_i=$(( (cat_i + 1) % 4 ))
    local cat="${cat_frames[$cat_i]}"

    # Colors
    local green="\[\033[1;32m\]"
    local red="\[\033[1;31m\]"
    local blue="\[\033[1;34m\]"
    local purple="\[\033[1;35m\]"
    local reset="\[\033[0m\]"

    # Exit status color
    local user_col="$green"
    [ $exit_code -ne 0 ] && user_col="$red"

    # 🔥 Detect Python venv
    local venv=""
    if [[ -n "$VIRTUAL_ENV" ]]; then
        venv="${purple}($(basename "$VIRTUAL_ENV"))${reset} "
    fi

    # Git logic
    local tail_icon="🍺"
    local branch=$(git rev-parse --abbrev-ref HEAD 2>/dev/null)
    if [[ -n "$branch" ]]; then
        if [[ "$branch" == "main" || "$branch" == "master" ]]; then
            tail_icon="🚀"
        else
            tail_icon="🧪"
        fi
    fi

    local s_path=$(short_path_logic)

    # Final PS1
    PS1="${venv}${cat} ${user_col}\u${reset} ${blue}${s_path}${reset}\$(__git_ps1 ' (%s)') ${tail_icon} \$ "
}

PROMPT_COMMAND=update_prompt