function git-clear-branches --description "Delete local branches already merged to master"
    # Delete all local branches that have been merged to master: (somehow false for almost all mine):
    #git fetch origin; and git branch --merged master | grep -v "master" | xargs -n 1 git branch -d
    # Deleting Local Branches That No Longer Exist on the Remote:
    git fetch origin; git branch -vv | grep ': gone]' | grep -v '\*' | awk '{ print $1; }' | xargs -r git branch -d
end
