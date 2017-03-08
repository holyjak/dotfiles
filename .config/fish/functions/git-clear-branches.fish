function git-clear-branches --description "Delete local branches already merged to master"
    git fetch origin; and git branch --merged master | grep -v "master" | xargs -n 1 git branch -d
end
