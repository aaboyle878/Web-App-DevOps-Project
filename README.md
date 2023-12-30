# Web-App-DevOps-Project

Welcome to the Web App DevOps Project repo! This application allows you to efficiently manage and track orders for a potential business. It provides an intuitive user interface for viewing existing orders and adding new ones.

## Table of Contents

- [Features](#features)
- [Getting Started](#getting-started)
- [Technology Stack](#technology-stack)
- [Contributors](#contributors)
- [License](#license)
- [Cloud Resource Provisioning](#cloud-resource-provisioning)

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

- **Node Pool** This will define the number of nodes we wish to have within the cluster and where we can set the conditions for auto-scaling and the max and min number of nodes we wish to have running at any given time. For our app we have chosen the Standard_DS2_v2 vitrual machine as the host for our application with a default starting count of one. it is also woth mentioning that this is defined as part of the AKS cluster along side the service principal 

- **AKS(Azure Kubernetes Service) Cluster** This is the kubernetes cluster we will be defining for opur app to run on and is made up of multiple components as mentioned above, potentially the most important factor to define within this block would be the version of kubernetes we wish to run as different versions will function differently and may not support more advanced features.

### AKS Terraform Resources

In the parent directory for the terrform modular IaC files we have a main.tf as this is in the parent folder it will tie the networking and aks cluster modules together via their outputs and also by providing input paramteres for the variables we have specified in the modules variables.tf files. We will also specify the terraform provider in this main.tf file and in the case of our app as we are using the azure cloud this will in turn mean we are using the Azure provider. We will also specify the service princial credentials that terrafrom will use for our resource provisioning in this section.