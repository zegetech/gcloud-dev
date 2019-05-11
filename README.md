# Setting up Gcloud K8 isolated project environment
This container is used to isolate gcloud environments with their projects. 

## Set up you project
Project folder (app) should be peers with this.
```
---|---_k8
   |---app
```
If previously set up then run 
```bash
docker-compose run <your-service> bash
```

## 1. Set up your service and the ENV variables in docker-cpmpose.yaml and build the container
Can be skipped if the container is arealy in the image registry on local machine	
```bash
docker-compose build
```
## 2. Login to Gcloud account

```bash
docker-compose run --entrypoint '' <your-service> gcloud auth login 
```
Log into your prefered gcloud account

## 3. Container is ready to run. 
Log into the contaier bash
```bash
docker-compose run <your-service> bash
```

# COMMAND
## 4. Create cluster
```bash
gcloud container clusters list
gcloud container clusters create $CLUSTER \
		--num-nodes $CLUSTER_NODES \
		--machine-type $NODE_TYPE
```

## 5. View configurations
```bash
gcloud config list
gcloud config configurations list
gcloud projects list
```

## 6. Authorize Kubectl
```bash
gcloud container clusters get-credentials $CLUSTER --zone $ZONE
```

## 7. Delete cluster
```bash
gcloud container clusters delete $CLUSTER
```

## Create Static IP
gcloud compute addresses create pritunl-ip --global
gcloud compute addresses describe pritunl-ip --global

gcloud compute addresses delete pritunl-ip


Cheatsheet [here](https://gist.github.com/pydevops/cffbd3c694d599c6ca18342d3625af97)
