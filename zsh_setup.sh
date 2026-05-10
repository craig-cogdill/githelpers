#!/bin/zsh
function parse_git_branch2() {
    git branch 2> /dev/null | sed -n -e 's/^\* \(.*\)/[\1] /p'
}

# get current branch in git repo
# Check if the git working directory is dirty
function parse_git_dirty() {
    local _status
    _status=$(git status --porcelain 2>/dev/null | tail -n1)
    if [ -n "$_status" ]; then
        echo "*"
    else
        echo ""
    fi
}

# Get the current branch in a git repository
function parse_git_branch() {
    local _branch
    _branch=$(git branch 2>/dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/\1/')
    if [ -n "$_branch" ]; then
        local _status
        _status=$(parse_git_dirty)
        echo "[$_branch$_status]"
    else
        echo ""
    fi
}



DIR="$(cd "$(dirname "${(%):-%x}")" && pwd)"
source $DIR/colors
source $DIR/git-completion.bash
source $DIR/git-prompt.sh
source $DIR/git-helper.sh
