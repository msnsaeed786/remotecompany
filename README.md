## Assignment
https://gist.github.com/nklmilojevic/4a1de3c3e31d0ea2d4f31cd54211613d


## Getting Started

This is a Golang app that returns the values that you pass the path in the URL.


### CI / CD

Github Action is being used as CI. When a user pushes the code changes to the repo, It triggers the Action to Build and Push the Image to the Dockerhub.
Actions contain 3 WorkFlows
- **Docker_Image_CI (docker-image.yml)**: It triggers automatically when code is pushed to the Main branch and builds the Docker Image & then pushes the Docker Image to the Docker Hub repository. 
- **Deployment on Kubernetes (deploy.yml )**: It is also triggered automatically after the successful completion of **Docker_Image_CI** workflow. It gains the access to the Digital Ocean Doctl command line using the Secret Access token which is defined under secrets in the Repo settings. After gaining access it generates the temporary access token for the Kubernetes cluster for the specific cluster using Cluster ID. The Cluster ID is also defined as secret in repository settings. Then the Ingress and deployments are deployed and verified on the cluster. 
- **Certificate Management on Kubernetes (cert-management.yml)**: This workflow is configured to run manual because this is the certificate management deployment that does not need to be deployed often and that is why it doesn't need to run to every push or deployment. These workflows deploy the jet stack certificate manager inside the Kubernetes cluster and then to overcome the problem of the pod to pod communication using the external load balancer to issue the certificate for the pods we deploy the workaround (pod_to_pod.yml). To Run this workflow please find the below snap. 

![image](https://user-images.githubusercontent.com/89794883/132804517-dd03f404-6e48-4987-890e-0e4df91d505f.png)

## Kubernetes Objects 

We have 4 Kubernetes Objects in this repository
- **cert-issuer.yml**: This is a ClusterIssuer Object is cert-manager which is a Kubernetes add-on that provisions TLS certificates from Let’s Encrypt and other certificate authorities (CAs) and manages their lifecycles.
- **pod_to_pod.yml**: To provisions certificates from Let’s Encrypt. Cert-manager first performs a self-check to ensure that Let’s Encrypt can reach the cert-manager Pod that validates your domain. For this check to pass on, We have to enable Pod-Pod communication through the Nginx Ingress load balancer.
- **ingress.yml**: Here we have specified that we’d like to create an Ingress Resource called echo-ingress, and route traffic based on the Host header. An HTTP request Host header specifies the domain name of the target server.
- **deployment.yml**: In this file, we have defined a Service called remote-app-service which routes traffic to Pods with the app: remote-app label selector. It accepts TCP traffic on port 80 and routes it to port 8080. We then define a Deployment, also called remote-app, which manages Pods with the app: remote-app Label Selector. We specify that the Deployment should have 3 Pod replicas and that the Pods should start a container called remote-app running the image that we pushed to Dockerhub. Finally, we open port 8080 on the Pod container.

## Making Changes to Your App

To make changes to the Go App you can clone the repository and make changes to it and then push the changes to the repository. The Push will trigger a Github action which will build a new Docker Image and Push it to the Dockerhub repository. Once this workflow is completed it will trigger the next workflow that will deploy the updated image to the Kubernetes cluster. 

## Add or Remove Domain / Subdomain to the App

To add or remove a Domain or Sub Domain you can make changes to the ingress.yml file. You can add or remove the required in the hosts' section under spec. You can check out the below Snap for reference. 

![image](https://user-images.githubusercontent.com/89794883/132808287-8bb8ab33-455d-46be-85a2-a578bedc8161.png)



