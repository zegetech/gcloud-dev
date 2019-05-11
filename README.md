# Setting up Gcloud K8 isolated project environment
This container is used to isolate gcloud environments within a project. Allows for multiple project work, safely at the same time.

## Set up you project
Project folder (app) should be peers with this.
```
---|---_k8
   |---app
```

Run command from the _k8 folder
```bash
$ cd _k8
$ docker-compose run <your-service> bash
```

## 1. Login to Gcloud account

```bash
docker-compose run --entrypoint '' <your-service> gcloud auth login 
```
Log into your prefered gcloud account

## 2. Work with your project isolated
Log into the contaier bash to start working on your project
```bash
docker-compose run <your-service> bash
```

# Cheat Sheet
### Create cluster
```bash
gcloud container clusters list
gcloud container clusters create $CLUSTER \
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
gcloud container clusters get-credentials $CLUSTER --zone $ZONE
```

### Delete cluster
```bash
gcloud container clusters delete $CLUSTER
```

### Create Static IP
gcloud compute addresses create <ip-name> --global
gcloud compute addresses describe <ip-name> --global

gcloud compute addresses delete <ip-name>


Cheatsheet [here](https://gist.github.com/pydevops/cffbd3c694d599c6ca18342d3625af97)
