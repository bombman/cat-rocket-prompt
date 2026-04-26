#!/bin/bash
# ---------------------------------------------------------
# CAT & ROCKET PROMPT CORE LOGIC
# Author: Mint/Bom (nova)
# ---------------------------------------------------------

# Load Git prompt support safely
if [ -f /usr/lib/git-core/git-sh-prompt ]; then
    . /usr/lib/git-core/git-sh-prompt
elif [ -f /etc/bash_completion.d/git-prompt ]; then
    . /etc/bash_completion.d/git-prompt
fi

# Path Shortener: converts /home/user/my-project to ~/m/my-project
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

# Animation frame definitions
cat_frames=("🐱" "🐈" "😺" "😸")
cat_i=0

# Main update function
update_prompt() {
    local exit_code=$? # Capture status of last command
    
    # Increment animation frame
    cat_i=$(( (cat_i + 1) % 4 ))
    local cat="${cat_frames[$cat_i]}"

    # Color Palette (ANSI)
    local green="\[\033[1;32m\]"
    local red="\[\033[1;31m\]"
    local blue="\[\033[1;34m\]"
    local reset="\[\033[0m\]"

    # Set user color based on success/fail
    local user_col="$green"
    [ $exit_code -ne 0 ] && user_col="$red"

    # Git Status Icons
    local tail_icon="🍺" # Default outside git
    local branch=$(git rev-parse --abbrev-ref HEAD 2>/dev/null)
    if [[ -n "$branch" ]]; then
        if [[ "$branch" == "main" || "$branch" == "master" ]]; then
            tail_icon="🚀" # Rocket for production branches
        else
            tail_icon="🧪" # Flask for feature branches
        fi
    fi

    local s_path=$(short_path_logic)
    
    # Construct Final PS1
    # [Cat] [User] [Path] [GitBranch] [TailIcon]
    PS1="${cat} ${user_col}\u${reset} ${blue}${s_path}${reset}\$(__git_ps1 ' (%s)') ${tail_icon} \$ "
}

# Register command
PROMPT_COMMAND=update_prompt