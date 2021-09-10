## Getting Started

THis a Golang app that returns the values that you pass the path in the URL.


### CI / CD

Github Action is being used as CI. When a user pushes the code changes to the repo, It triggers the Action to Build and Push the Image to the Dockerhub.
Actions Contain 3 WorkFlows
- **Docker_Image_CI (docker-image.yml)**: It triggers automatically when code is pushed to the Main branch and builds the Docker Image & then push the Docker Image to the Docker Hub repository. 
- **Deployment on Kubernetes (deploy.yml )**: It is also triggered automatically after the successful completion of **Docker_Image_CI** workflow. It gains the access to the Digital Ocean Doctl command line using Secert Access token which is defined under secrets in the Repo settings. After gaining access it generates the temporary access token for the Kuberenets cluster for the specific cluster using Cluster ID. The Cluster ID is also defined as secret in repository settings. Then the Ingress and deployments are deployed and verified on the cluster. 
- **Certificate Management on Kubernetes (cert-management.yml)**: This workflow is configured to run manually because this is the certificate management deployment which does not need to be deployed often and that is why it dosent need to run to every push or deployment. This workflows deploy the jetstack ceritificate manager inside the kubernetes cluster and then to overcome the problem of pod to pod communication using the external load balancer to issue the certificate for the pods we deploy the workaround (pod_to_pod.yml). To Run this workflow please find the below snap. 

![image](https://user-images.githubusercontent.com/89794883/132804517-dd03f404-6e48-4987-890e-0e4df91d505f.png)

## Kubernetes Objects 
We have 4 kuberenets Objects in this repository
- **cert-issuer.yml**: This is a ClusterIssuer





### Making Changes to Your App

### Learn More


## Deleting the App

