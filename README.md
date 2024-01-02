# Web-App-DevOps-Project

Welcome to the Web App DevOps Project repo! This application allows you to efficiently manage and track orders for a potential business. It provides an intuitive user interface for viewing existing orders and adding new ones.

## Table of Contents

- [Features](#features)
- [Getting Started](#getting-started)
- [Technology Stack](#technology-stack)
- [Contributors](#contributors)
- [License](#license)
- [Cloud Resource Provisioning](#cloud-resource-provisioning)
- [Kubernetes Manifest](#kubernetes-manifest)
- [Kubernetes Deployment](#kubernetes-deployment)
- [Azure Pipeline](#azure-pipeline)
## Features

- **Order List:** View a comprehensive list of orders including details like date UUID, user ID, card number, store code, product code, product quantity, order date, and shipping date.
  
![Screenshot 2023-08-31 at 15 48 48](https://github.com/maya-a-iuga/Web-App-DevOps-Project/assets/104773240/3a3bae88-9224-4755-bf62-567beb7bf692)

- **Pagination:** Easily navigate through multiple pages of orders using the built-in pagination feature.
  
![Screenshot 2023-08-31 at 15 49 08](https://github.com/maya-a-iuga/Web-App-DevOps-Project/assets/104773240/d92a045d-b568-4695-b2b9-986874b4ed5a)

- **Add New Order:** Fill out a user-friendly form to add new orders to the system with necessary information.
  
![Screenshot 2023-08-31 at 15 49 26](https://github.com/maya-a-iuga/Web-App-DevOps-Project/assets/104773240/83236d79-6212-4fc3-afa3-3cee88354b1a)

- **Data Validation:** Ensure data accuracy and completeness with required fields, date restrictions, and card number validation.

## Getting Started

### Prerequisites

For the application to succesfully run, you need to install the following packages:

- flask (version 2.2.2)
- pyodbc (version 4.0.39)
- SQLAlchemy (version 2.0.21)
- werkzeug (version 2.2.3)

### Usage

To run the application, you simply need to run the `app.py` script in this repository. Once the application starts you should be able to access it locally at `http://127.0.0.1:5000`. Here you will be meet with the following two pages:

1. **Order List Page:** Navigate to the "Order List" page to view all existing orders. Use the pagination controls to navigate between pages.

2. **Add New Order Page:** Click on the "Add New Order" tab to access the order form. Complete all required fields and ensure that your entries meet the specified criteria.

## Technology Stack

- **Backend:** Flask is used to build the backend of the application, handling routing, data processing, and interactions with the database.

- **Frontend:** The user interface is designed using HTML, CSS, and JavaScript to ensure a smooth and intuitive user experience.

- **Database:** The application employs an Azure SQL Database as its database system to store order-related data.

- **Cloud Provider:** The application will hosted on Azure cloud and make use of the Azure Kuberenetes Service (AKS) 

## Contributors 

- [Maya Iuga](https://github.com/maya-a-iuga)

- [Aaron Boyle](https://github.com/aaboyle878)

## License

This project is licensed under the MIT License. For more details, refer to the [LICENSE](LICENSE) file.

## Cloud Resource Provisioning

As part of the cloud set-up for the application it has been containerised and will be run using Azure Cloud as previous mentioned. For the app to accessabilbe on the cloud a number of networking resources had to be provisioned these are: 

### Networking Module Resources

- **Resource Groups** Everying we provision on the cloub will need to be a member of a resource group from a billing perspective as they will all be linked to a subscription via the resource group, not only this but as a resoure group can host different kinds of resource together it keeps everything bundled together 

- **Virtual Network (Vnet)** We set up a Vnet to allow for a more secure and selective approach to traffic manangement as we can decide what aspects of the app will be serviced by what Ip's within the Vnet 

- **Subnets** Simialrly to Vnets we create a subnet within a Vnet to serve a particualr function in the case of our app we have two subnets set up one for the control plane nodes and another for the worker node and they are segrated from each other due to security and routing reasons

- **Security Groups** We have set up a security group which will essential fuction as the firewall and be the barrier between the outside world and our resources within the aks cluster, we set up this firewall using network secruity group rules for the resource group which allows a granular way to control the ingress and egress within the cluster

- **Security Group Rules** We have set up two network security group rules for the cluster to control the flow of external traffic and the hosts whioch can access the cluster via ssh

### AKS Cluster Module Resources 

- **Service Principal** This is the account used by the terraform files to authenticate and interact with Azure resources, in short it is a service account for terraform. Please note this is defined as part of the AKS cluster along side the node pool

- **Node Pool** This will define the number of nodes we wish to have within the cluster and where we can set the conditions for auto-scaling and the max and min number of nodes we wish to have running at any given time. For our app we have chosen the `Standard_DS2_v2` vitrual machine as the host for our application with a default starting count of one. it is also woth mentioning that this is defined as part of the AKS cluster along side the service principal 

- **AKS(Azure Kubernetes Service) Cluster** This is the kubernetes cluster we will be defining for opur app to run on and is made up of multiple components as mentioned above, potentially the most important factor to define within this block would be the version of kubernetes we wish to run as different versions will function differently and may not support more advanced features.

### AKS Terraform Resources

In the parent directory for the terrform modular IaC files we have a main.tf as this is in the parent folder it will tie the networking and aks cluster modules together via their outputs and also by providing input paramteres for the variables we have specified in the modules variables.tf files. We will also specify the terraform provider in this main.tf file and in the case of our app as we are using the azure cloud this will in turn mean we are using the Azure provider. We will also specify the service princial credentials that terrafrom will use for our resource provisioning in this section.

- To interact with the cluster we have created using terraform we need to retrieve the kubeconfig file for it which can be done via the following command `az aks get-credentials --resource-group <resource group name> --name <cluster name>`

## Kubernetes Manifest

As out app will be hosted using AKS with the resources mentioned above which have been provisioned using terraform we now had to create the manifest/config/YAML file for the cluster. This is to specify that we want to run our containerised app on the pods within the cluster and what ports we wish to expose for internal traffic management, the design of the application-manifest file is the following:

- **Service ClusterIP** 
We created the ClusterIP service as part of the deployment to determine how we would handle internal traffic within the cluster and so we have used TCP with a mapping from port 5000 (this will be port users access the application via as it is the port exposed by the container) to port 80. To ensure that the service links to the correct deployment metadata labels have been added.

- **Deployment**
For the deployment we have specified the image we wish to run within the clusters pods along side the number of replicas we which to have to ensure availablitiy of the application. In the deployment manifest we have also specified which container ports we wish to be exposed in this case it is port 5000 along with how we wish to handle updating the containers within the cluster should the need arise, for this we have chose to replace the continers one at time ensuring that there is alway one pod running within the cluster so the app is always available for users.

## Kubernetes Deployment

### Applying the manifest file
For deploying the manifest file to the cluster a similar approach was taken to that of terraform in which a dry run was initiated to ensure the changes being made were expected using the `kubectl diff -f application-manifest.yaml` as this compares the current kubernetes configuration within the cluster against the newly proposed manifest file similar to `terraform plan`. When all was reviewed and the service and deployment looked good the manifest was applied using `kuberctl apply -f application-manifest.yaml` and for here the service and deployment were created.

### Checking the deployment
After apllying the manifest file there were a number of cammands used to check the deployment had been successful and ultimately validate the app was working by connecting to the container via port forwarding from the local machine. Some of the command used to check the deployment were:
- `kubectl get deployments`- this command returns deployment name, number of pods ready/avaliable out of those specified in the yaml, number of pods using the latest manifest file, number of pods availbe to serve incoming requests, and finally how long the pods have been running
- `kubectl get pods`- shows the pod name, how many containers are running on the on the pod in a ready state, the status of the pod i.e if it is running or there have been any issues, number of restarts, and pod age
- `kubectl get pods --show-labels`- this shows the same as the above with the addition of the labels column 
- `kubectl get services`- this returns the serive name, type, internal ClusterIP, external/public facing IP, port and protocol mapping, and age
- `kubectl port-forward <pod-name> 5000:5000`- this command will allow us to connect to the named container via localhost or `127.0.0.1` on port 5000 i.e `127.0.0.1:5000`

## Azure Pipeline

To automate the building and pushing of our image from the dockerfile to Dockerhub and the application of our Kubernetes manifest to the cluster we have built a pipeline with Azure Devops to automate these tasks for us. For the pipeline to be successful it required some set up which comprised of:
- Creating a new Organisation and project within Azure DevOps <br> 
- Creating a service connection to github repo for the app <br> 
 - This is the github repo which will house the source code for our app, along side the Dockerfile, Terraform files and modular structure, the kubernetes cluster application manifest yaml file and ultimately our pipeline .yml file too 

- Creating a service connection for the pipelines to Docker Hub <br>
 - This will act similarly to a service account in the sense that when the piepline is executed it will all an agent to build the image and push it to docker for us rather than having to manually change the image version with each `docker push`
- Creating a serivce connection to our Kubernetes cluster hosted on using AKS <br>
 -In much the same way the docker service connection acts as a service account for docker the same can be said for the Kubernetes service connection as it will allow us to apply any changes in our manifest/config file to the cluster and reduce the erro associated with inexperienced users using `kubectl` commands
- Creating the azure-pipelines.yml file <br>
 - This file will house the pipeline trigger, agent pool and associated steps we wish to execute each time the pipeline runs, in our case we have set the trigger to main meaning that anytime there is a change to the main branch of the repo our pipeline shoudl detect the change build the image from scratch push to docker hub and then use the application manifest to deploy the image to the pods within out cluster 
- Fixing any issues as they arose  

### Testing the pipeline 

The testing of the pipeline was done in two phases after each step was added:
1. To validate the step worked as expected and tune the parameters if required 
2. To allow for the investigation of issues should there be an problems with the steps selected

#### Phase 1 

This was the inital set up and trail run of the pipeline building and pushing the image of our app to Docker Hub. In this phase the pipeline was run to ensure the set-up was correct i.e. nothing had be missed and to also verify that the image push could be automated. <br> \
There were a few issues that were discovered in this inital round of testing 
1. Azure Cloud subscription not linking to the Azure Devops Org correctly and the runners/build agents not allowing for parallelism. <br> \
However this was resolved by updating the billing for the project.
2. The docker image wasnt able to be pushed to the Docker Hub Repo <br> \
This was resolved by adding the username to the repository field withint he task i.e. `repository: username/app_name`

#### Phase 2 
This phase introduce the use the of the Kubernetes service connection to apply our manifest/config file and as such followed the approach in the [Checking Deployment](#checking-the-deployment) where we connected to the cluster via the shell and checked everything was running as expect using our `kubectl` command then also checking the deployment on our local machine via port forwarding. <br> \
An issue that was encourtered during this phase of the deployment was due to the manifest file being localed in the wrong place however this was rectified by moving the yaml file for the child directory into the parent.