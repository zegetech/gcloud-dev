FROM google/cloud-sdk:alpine
LABEL maintainer="Kariuki Gathitu <kgathi2@gmail.com>"
LABEL version="1.0"

ENV VERSION 0.0.2

RUN apk --update add jq bash-completion
RUN gcloud components install kubectl
RUN mkdir gke
WORKDIR /gke
COPY ./entrypoint.sh bash_aliases /tmp/
COPY ./bashrc /root/.bashrc
COPY ./kube_completion.bash /root/kube_completion.bash
RUN  . /tmp/bash_aliases
RUN chmod +x /tmp/bash_aliases /tmp/entrypoint.sh

ENTRYPOINT [ "/tmp/entrypoint.sh" ]
