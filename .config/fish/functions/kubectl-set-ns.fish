function kubectl-set-ns --description "Set the current kubernetes namespace"
    if [ $argv ] 
        kubectl config set-context (kubectl config current-context) --namespace $argv
    else
        echo 'kubectl-set-ns <ns>'
    end
end
