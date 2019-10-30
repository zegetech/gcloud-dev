# Use bash-completion, if available
[[ $PS1 && -f /usr/share/bash-completion/bash_completion ]] && \
    . /usr/share/bash-completion/bash_completion
# kubectl completion
source ~/kube_completion.bash
# gcloud completion
source /google-cloud-sdk/completion.bash.inc
