# Web-App-DevOps-Project

Welcome to the Web App DevOps Project repo! This application allows you to efficiently manage and track orders for a potential business. It provides an intuitive user interface for viewing existing orders and adding new ones.

## Table of Contents

- [Features](#features)
- [Getting Started](#getting-started)
- [Technology Stack](#technology-stack)
- [Contributors](#contributors)
- [License](#license)
- [External Technical Design Wiki Links](https://github.com/aaboyle878/Web-App-DevOps-Project/wiki)
  - [Feature: Delivery Date](https://github.com/aaboyle878/Web-App-DevOps-Project/wiki/Delivery-Date)
  - [Docker](https://github.com/aaboyle878/Web-App-DevOps-Project/wiki/Docker)
  - [Cloud Resource Provisioning](https://github.com/aaboyle878/Web-App-DevOps-Project/wiki/Cloud-Resource-Provisioning)
  - [Kubernetes Manifest](https://github.com/aaboyle878/Web-App-DevOps-Project/wiki/Kubernetes-Manifest)
  - [Kubernetes Deployment](https://github.com/aaboyle878/Web-App-DevOps-Project/wiki/Kubernetes-Deployment)
  - [Azure Pipeline](https://github.com/aaboyle878/Web-App-DevOps-Project/wiki/Azure-Pipeline)
  - [Monitoring](https://github.com/aaboyle878/Web-App-DevOps-Project/wiki/Monitoring)
  - [Secrets Management Integration](https://github.com/aaboyle878/Web-App-DevOps-Project/wiki/Secrets-Management-Integration)

## Features

- **Order List:** View a comprehensive list of orders including details like date UUID, user ID, card number, store code, product code, product quantity, order date, and shipping date.
  
![Screenshot 2023-08-31 at 15 48 48](https://github.com/maya-a-iuga/Web-App-DevOps-Project/assets/104773240/3a3bae88-9224-4755-bf62-567beb7bf692)

- **Pagination:** Easily navigate through multiple pages of orders using the built-in pagination feature.
  
![Screenshot 2023-08-31 at 15 49 08](https://github.com/maya-a-iuga/Web-App-DevOps-Project/assets/104773240/d92a045d-b568-4695-b2b9-986874b4ed5a)

- **Add New Order:** Fill out a user-friendly form to add new orders to the system with necessary information.
  
![Screenshot 2023-08-31 at 15 49 26](https://github.com/maya-a-iuga/Web-App-DevOps-Project/assets/104773240/83236d79-6212-4fc3-afa3-3cee88354b1a)

- **Data Validation:** Ensure data accuracy and completeness with required fields, date restrictions, and card number validation.

- **Cloud Hosting** Due to potential demand for the application it was deemed best to build infrastruct to allow it to be cloud hosted and more accessable to users globally. The details for the cloud based implementation from the addition and subsequent reversion of the new columns, the creation of the the docker file for the image build, the provisioning of resources using Terraform IaC, the creation and deployment of the Kubernetes manifest, and build instructions for the Azure Pipeline to allow any changes merged intot he main branch to be depoyled right away can all be found within the [technical design wiki](https://github.com/aaboyle878/Web-App-DevOps-Project/wiki) in addition to montioring charts, log queires, alerts and security features.

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

