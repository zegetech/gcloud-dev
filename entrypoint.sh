#!/bin/bash
# Note that the env variables used here have will be injected in the image through docker env and are defined in the jet-services.yml file

set -e

# codeship_google authenticate

# echo "Show gcloud configurations and projects"
# gcloud config list
# gcloud projects list

echo "Setting default timezone $ZONE"
gcloud config set compute/zone $ZONE

echo "Setting project $PROJECT"
gcloud config set core/project $PROJECT

echo "Displaying gcloud configurations"
gcloud config list

echo "Checking cluster availability"
ALL_CLUSTER=$(gcloud container clusters list)

if [[ "$ALL_CLUSTER" == *"$CLUSTER_NAME"* ]]; then
	echo "Cluster exists. Using cluster $CLUSTER_NAME"
	echo "Setting up gcloud and kubectl credentials"
	gcloud container clusters get-credentials $CLUSTER_NAME --zone $ZONE

	echo "Updating resource(s) in all manifest files in dir"
else
	echo "Cluster does not exist. We shall create cluster $CLUSTER_NAME now"
	gcloud container clusters create $CLUSTER_NAME \
		--num-nodes $CLUSTER_NODES \
		--machine-type $NODE_TYPE \
		--image-type $NODE_IMAGE

	# kubectl create -f $RESOURCE_DIR --record --save-config
	# echo "Creating resource(s) in all manifest files in $RESOURCE_DIR"
fi

# echo "Setting up secret environment variables"
# kubectl delete secret app-secrets 2>/dev/null || :
# kubectl create secret generic app-secrets \
# 	--from-literal=secret-key-base=$SECRET_KEY_BASE \
# 	--from-literal=devise-jwt-secret-key=$DEVISE_JWT_SECRET_KEY \
# 	--from-literal=postgres-password=$POSTGRES_PASSWORD \
# 	--from-literal=sentry-dsn=$SENTRY_DSN \
# 	--from-literal=twilio-account-sid=$TWILIO_ACCOUNT_SID \
# 	--from-literal=twilio-auth-token=$TWILIO_AUTH_TOKEN \
# 	--from-literal=skylight-auth=$SKYLIGHT_AUTHENTICATION \
# 	--from-literal=sendgrid-password=$SENDGRID_PASSWORD

# echo "Applying volumes first"
# kubectl apply -f $VOLUMES_DIR

# echo "Booting up services and deployments"
# kubectl apply -f $RESOURCE_DIR

# echo "Updating application"
# kubectl set image deployments/app app=gcr.io/whs-careflow/careflow-api-dev:latest
# kubectl set image deployments/sidekiq sidekiq=gcr.io/whs-careflow/careflow-api-dev:latest

# echo "Getting cluster information"
# kubectl cluster-info

# echo "Listing services on GCE"
# kubectl get services,deployment,pods


# create static ip
# gcloud compute addresses create staging-ip --global

# kubectl get -f $RESOURCE_DIR -o json

# Shell into a pod
# kubectl exec -ti app-r78e7e8-43iu -- bash

# echo "update a service with a new version of the app"
# kubectl rolling-update app -f $RESOURCE_DIR/app-service.yaml --record

# echo "Removing service and deployments"
# kubectl delete -f $RESOURCE_DIR
# echo "Waiting After Remove"

#########################################

# kubectl describe svc app
# kubectl rolling-update -f app-service.yaml
# kubectl rolling-update -f postgres-service.yaml
# kubectl rolling-update app -f app-deployment.yaml
# kubectl rolling-update -f postgres-deployment.yaml

# gcloud container node-pools delete default-pool --cluster=KUBERNETES_APP_NAME
# gcloud container clusters delete $CLUSTER_NAME


exec "$@"