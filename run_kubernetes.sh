#!/usr/bin/env bash

# This tags and uploads an image to Docker Hub

# Step 1:
# This is your Docker ID/path
# dockerpath=<>
dockerpath=7akim/capstone-devops


# Step 2
# Run the Docker Hub container with kubernetes
#docker login
#kubectl create deployment capstone-devops --image=$dockerpath
kubectl run capstone-devops --image=$dockerpath:latest --port=80



# Step 3:
# List kubernetes pods
kubectl get pods --all-namespaces


# Step 4:
# Forward the container port to a host
kubectl port-forward pod/capstone-devops 8000:80

