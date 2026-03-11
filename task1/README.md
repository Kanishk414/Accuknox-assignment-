
# 🐳 Task 1 — Containerization, Kubernetes Deployment & TLS

This task covers containerizing the **Wisecow** bash web application, deploying it to a Kubernetes cluster (Minikube), exposing it via Ingress with TLS, and setting up CI/CD with GitHub Actions.


## 🧱 1. Build & Push Docker Image

powershell
docker build -t 5788kanishk/accuknox:01 .
docker login
docker push 5788kanishk/accuknox:01


The Dockerfile and `wisecow.sh` were provided and **not modified**.

---

## ☸ 2. Deploy on Minikube

Start Minikube (Docker driver):

```powershell
minikube start
minikube status 
minikube addons enable ingress
```

Apply the Kubernetes manifests:

```powershell
kubectl apply -f k8s-deployment.yaml
kubectl apply -f k8s-service.yaml
kubectl apply -f k8s-ingress.yaml
```

---

## 🔐 3. Generate TLS Certificate (Windows)

```powershell
[make sure to check openssl is installed for windows]
openssl genrsa -out tls.key 2048
openssl req -x509 -new -nodes -key tls.key -subj "/CN=wisecow.local" -days 365 -out tls.crt

kubectl create secret tls wisecow-tls --cert=tls.crt --key=tls.key
```

Verify:

```powershell
kubectl get secrets
```

---

## 📝 4. Update Hosts File

Edit:
    
```
(run cmd or powershell as adminstrator)
notepad C:\Windows\System32\drivers\etc\hosts
```

Add:

```
127.0.0.1 wisecow.local
```

---

## 🌐 5. Access the Application

Run:

```powershell
minikube tunnel
```

Then open:

👉 [https://wisecow.local](https://wisecow.local)

(accept the self-signed cert warning)

---

## 🤖 6. CI/CD with GitHub Actions

A workflow `.github/workflows/ci-cd.yml` is included. It:

* Builds the Docker image on each push to `master`
* Pushes it to Docker Hub with tag `:01`
* Automatically deploys the updated application to the kubernetes cluster

Secrets required in GitHub repo:

* `DOCKERHUB_USERNAME`
* `DOCKERHUB_TOKEN`

---

## ✅ Verification Commands

```powershell
kubectl get deployments
kubectl get svc
kubectl get ingress
```

Expected:

* `wisecow-deployment` — Ready 1/1
* `wisecow-service` — ClusterIP
* `wisecow-ingress` — hosts `wisecow.local`

---
##  🖼️ Screenshots 

**Here's screenshot of the wisecow app running :**  

![wisecow App screenshot](./screenshots/working%20locally.png)

**Here's screenshot of minikube dashboard :** 

![minikube dashboard](./screenshots/minikube%20dashboard.png)

---

## 📝 Notes

* Image tag used consistently: `5788kanishk/accuknox:01`
* `imagePullPolicy: Always` recommended in deployment YAML for updates.
* No changes were made to `wisecow.sh` or the Dockerfile.