
# Accuknox DevOps Trainee Practical Assessment — 2025

This repository contains the complete solution for the **Accuknox DevOps Trainee Practical Assessment**.  
The project involves containerizing and deploying the **Wisecow** application on Kubernetes with TLS, setting up CI/CD via GitHub Actions, and implementing system and application health monitoring scripts.

---

## 📁 Project Structure
```markdown
Accuknox-Assignment/
│   README.md                 ← Root documentation (this file)
│
├── task1/
│   ├── Dockerfile
│   ├── wisecow.sh
│   ├── k8s-deployment.yaml
│   ├── k8s-service.yaml
│   ├── k8s-ingress.yaml
│   ├── tls.crt
│   ├── tls.key
│   ├── README.md             ← Task 1 specific steps
│
├── task2/
│   ├── system-health.ps1
│   ├── app-health.ps1
│   ├── README.md             ← Task 2 specific steps
│
└── .github/
└── workflows/
└── ci-cd.yml         ← GitHub Actions CI/CD pipeline

