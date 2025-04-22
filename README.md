# DevOps Assignment: Rails Application with Docker, Kubernetes, Argo CD, and Tekton

This repository contains the configuration files for deploying a Rails application with a PostgreSQL database on Kubernetes using Argo CD for GitOps and Tekton for CI/CD.

## Project Structure

Okay, Ishu. Here's a basic README.md file you can include in the root of your GitHub repository. You can expand on this with more details as needed.

Markdown

# DevOps Assignment: Rails Application with Docker, Kubernetes, Argo CD, and Tekton

This repository contains the configuration files for deploying a Rails application with a PostgreSQL database on Kubernetes using Argo CD for GitOps and Tekton for CI/CD.

## Project Structure

devops-assignment--m/
├── Dockerfile            # Defines how to build the Docker image for the Rails app

├── docker-compose.yml    # Used for local development with Docker

├── entrypoint.sh         # Entrypoint script for the Docker container

├── Gemfile               # Ruby dependencies for the Rails app

├── Gemfile.lock          # Specific versions of Ruby dependencies

├── k8s/                  # Kubernetes configuration files

│   ├── rails-deployment.yaml   # Defines how to deploy the Rails app

│   ├── postgres-statefulset.yaml # Defines how to deploy the PostgreSQL database

│   ├── postgres-service.yaml    # Internal DNS name and IP for PostgreSQL

│   ├── rails-service.yaml       # Internal DNS name and IP for the Rails app

│   └── ingress.yaml           # Configures external access to the Rails app

├── argocd/               # Argo CD (GitOps) configuration files

│   ├── application.yaml       # Defines the Argo CD application to manage the Rails deployment

│   ├── argocd-cm.yaml         # Argo CD ConfigMap (instance label key)

│   └── argocd-rbac-cm.yaml    # Argo CD RBAC ConfigMap (default policy)

└── tekton/               # Tekton (CI/CD) pipeline files

├── kaniko-sa.yaml         # Kubernetes ServiceAccount and Secret for Kaniko (Docker Hub credentials)

├── pvc.yaml               # PersistentVolumeClaim for Tekton workspace

├── pipeline.yaml          # Defines the Tekton CI pipeline (build and push Docker image)

└── taskrun.yaml           # Example of how to run the Tekton pipeline


## Getting Started

These instructions will help you deploy the Rails application to a Kubernetes cluster.

### Prerequisites

* A running Kubernetes cluster.
* Argo CD installed on your Kubernetes cluster (in the `argocd` namespace).
* Tekton Pipelines installed on your Kubernetes cluster.
* `kubectl` configured to interact with your Kubernetes cluster.
* A Docker Hub account.

### Deployment Steps

1.  **Clone the Repository:**
    ```bash
    git clone [https://github.com/IshanSharmaIshu/devops-assignment--m.git](https://github.com/IshanSharmaIshu/devops-assignment--m.git)
    cd devops-assignment--m
    ```

2.  **Configure Docker Hub Credentials for Tekton:**
    * Edit the `tekton/kaniko-sa.yaml` file.
    * Replace `"your-dockerhub-username"` with your Docker Hub username (`your-dockerhub-username`).
    * Replace `"your-personal-access-token"` with your Docker Hub personal access token.
    * Ensure the `"auth"` value is also correctly updated with your username and token.

3.  **Apply Kubernetes Manifests:**
    ```bash
    kubectl apply -f k8s/
    kubectl apply -f argocd/
    kubectl apply -f tekton/
    kubectl apply -f tekton/pvc.yaml
    kubectl apply -f tekton/taskrun.yaml
    ```
    * This will create the Deployments, StatefulSet, Services, Ingress, Argo CD Application, Tekton Pipeline, PipelineRun, ServiceAccount, Secret, and PersistentVolumeClaim in your Kubernetes cluster.

4.  **Monitor the Deployment:**
    * **Tekton:** Check the status of the Tekton PipelineRun to see if the Docker image is built and pushed successfully:
        ```bash
        kubectl get pipelinerun build-run-1 -n default -w
        ```
    * **Argo CD:** Monitor the Argo CD application to see if the Rails application and PostgreSQL database are deployed successfully:
        ```bash
        kubectl get application rails-app -n argocd -w
        ```
        You can also access the Argo CD UI to view the application status.

5.  **Access the Rails Application:**
    * If your Kubernetes cluster has a correctly configured Ingress controller and DNS is set up for `rails.local` to point to your Ingress controller's IP, you should be able to access the Rails application in your web browser at `http://rails.local`.

## Notes

* This setup assumes you have an Ingress controller running in your Kubernetes cluster.
* You may need to adjust the `ingress.yaml` based on your specific Ingress controller and setup.
* The `rails.local` hostname in the `ingress.yaml` is for example purposes. You can change it to your desired domain. You will need to configure DNS for that domain to point to your Ingress controller's external IP.

Feel free to contribute to this repository by adding more detailed instructions, troubleshooting tips, or improvements to the configurations.
