[Docker hub](https://hub.docker.com/r/kgathi2/gcloud-dev)

# Setting up Gcloud K8 isolated project environment

This container is used to isolate gcloud environments within a project. Allows for multiple project work, safely at the same time.

## Set up you project

Project folder (app) should be peers with this.

```
|___ app
|___ gke
	|___ docker-compose.yaml
	|___ entrypoint.sh (optional for overriding Gcloud settup)
	|___ .gitignore
```

Setup your `docker-compose.yaml` file
```yaml
version: '3'

services:
  project_service:
    command: tail -f /dev/null
    image: kgathi2/gcloud-dev:latest
    volumes:
      - ./.gcloud:/.gcloud
      - ./:/gke
      # - ./entrypoint.sh:/tmp/entrypoint.sh # optional if overriding gcloud setup
    environment:
      - CLOUDSDK_CONFIG=/.gcloud
      # Check latency with http://www.gcping.com/ for fastest region
      - REGION=us-west1
      - PROFILE=my-profile
      - ZONE=us-west1-a
      - PROJECT=project-name
      - CLUSTER_NAME=cluster-name
      - CLUSTER_NODES=1
      - NODE_TYPE=n1-standard-1 # g1-small n1-standard-1, n1-highmem-2
      - NODE_IMAGE=cos #cos, cosd, ubuntu

```
Ignore .gcloud  in `.gitignore`
```
.gcloud
```
Run command from the gke folder

```bash
$ cd gke
$ docker-compose run project_service bash
```

## 1. Login to Gcloud account

```bash
docker-compose run --entrypoint '' <your-service> gcloud auth login
```

Log into your prefered gcloud account

## 2. Override Gcloud setup (Optional)

To override the entrypoint, mount a volume with the file `entrypoint.sh` with your own script

```yaml
...
volumes:
  - ./entrypoint.sh:/tmp/entrypoint.sh
...
```
Make sure that your file is executable `chmod a+x entrypoint.sh`

## 3. Work with your project isolated

Log into the contaier bash to start working on your project

```bash
docker-compose run <your-service> bash
# or
docker-compose up -d <your-service>
docker ps
docker exec -it docker-container-id bash;
```

# Cheat Sheet

### kubectl bash aliases
The docker container is configured with a number of aliases to reduce typing. 
```bash
k     # kubectl $@
ka    # kubectl apply $@
kg    # kubectl get $@
kgn   # kubectl get nodes
kgnw  # kubectl get nodes -o wide
kgnl  # kubectl get nodes --show-labels
kgp   # kubectl get pods
kgs   # kubectl get svc
kgd   # kubectl get deployments
kcf   # kubectl create -f $@
kd    # kubectl delete $@
kdes  # kubectl describe $@
kdf   # kubectl delete -f $@
kaf   # kubectl apply -f $@
kgpa  # kubectl get pods --all-namespaces
kssh  # kubectl exec -it $@ -- /bin/sh 
kbash # kubectl exec -it $@ -- /bin/bash

```

### Create cluster

```bash
gcloud container clusters list
gcloud container clusters create $CLUSTER_NAME \
		--num-nodes $CLUSTER_NODES \
		--machine-type $NODE_TYPE
```

### View configurations

```bash
gcloud config list
gcloud config configurations list
gcloud projects list
```

### Authorize Kubectl

```bash
gcloud container clusters get-credentials $CLUSTER_NAME --zone $ZONE
```

### Delete cluster

```bash
gcloud container clusters delete $CLUSTER_NAME
```

### Create Static IP

global ip
```bash
gcloud compute addresses create <ip-name> --global
gcloud compute addresses describe <ip-name> --global

gcloud compute addresses delete <ip-name>
```
Cheatsheet [here](https://gist.github.com/pydevops/cffbd3c694d599c6ca18342d3625af97)

## Calico CNI

https://kubernetes.io/docs/tasks/administer-cluster/network-policy-provider/calico-network-policy/
