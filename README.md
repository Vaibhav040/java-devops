# Java CI/CD Pipeline with Kubernetes

This project demonstrates an end-to-end **DevOps CI/CD workflow** for a simple Java application, covering build automation, containerization, and Kubernetes deployment using GitLab CI/CD.

The setup is designed to be **production-like**, even though it runs on **Minikube inside an AWS EC2 instance**, and focuses on best practices such as Ingress-based access, health checks, and automated rollbacks.

---

## 🚀 Project Overview

- A simple Java application built using **Maven**
- Automated CI/CD pipeline using **GitLab CI/CD**
- Containerized application using **Docker**
- Deployment on **Kubernetes (Minikube running on AWS EC2)**
- Application exposure via **NGINX Ingress Controller**
- Safe deployments with **rolling updates and rollback support**

---

## 🛠 Tech Stack

- **Language:** Java  
- **Build Tool:** Maven  
- **CI/CD:** GitLab CI/CD  
- **Containerization:** Docker  
- **Orchestration:** Kubernetes (Minikube)  
- **Ingress:** NGINX Ingress Controller  
- **Cloud:** AWS EC2  
- **OS:** Linux  

---

## 🔁 CI/CD Pipeline Workflow

The GitLab CI/CD pipeline consists of the following stages:

1. **Build**
   - Compiles the Java application using Maven
   - Generates a JAR artifact

2. **Docker Build & Push**
   - Builds a Docker image using the generated JAR
   - Tags the image using the Git commit SHA
   - Pushes the image to **GitLab Container Registry**

3. **Deploy (Manual)**
   - Updates Kubernetes manifests with the new image tag
   - Applies manifests to the Kubernetes cluster
   - Verifies rollout status
   - Automatically rolls back on failure

---

## ☸ Kubernetes Architecture


### Kubernetes Resources Used
- **Deployment**  
  - Rolling update strategy
  - Resource requests and limits
  - Readiness & liveness probes
- **Service (ClusterIP)**  
  - Internal service exposure
- **Ingress**  
  - Host-based routing
  - External access without NodePort

---

## 🛠 CI/CD Pipeline Considerations

- - The **GitLab Runner used for the deploy stage must be running on the same EC2 instance** where Kubernetes (Minikube) and `kubectl` are installed, ensuring direct cluster access.
- The Kubernetes configuration (`kubeconfig`) is copied to the GitLab Runner user so that CI jobs can authenticate and interact with the cluster using `kubectl`.
- Make kubernets secret in same namespace as project so it can access secret while pulling the image from GitLab Registry.
 ## Example commandfor secret
 - kubectl create secret docker-registry gitlab-creds \
  --namespace=java-app \
  --docker-server=registry.gitlab.com \
  --docker-username="YOUR-USER-NAME" \
  --docker-password="YOUR-PAT-HERE"
### Example command used to configure kubeconfig for GitLab Runner:
```bash
sudo mkdir -p /home/gitlab-runner/.kube
sudo cp ~/.kube/config /home/gitlab-runner/.kube/config
sudo chown -R gitlab-runner:gitlab-runner /home/gitlab-runner/.kube
