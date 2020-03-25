# ricethings-website
<br><br><br>

## Table of contents

- [Warmup](#warmup)
    - [Challenge 0 - Docker](#Challenge-0---Docker)
    - [Challenge 1 - docker-compose](#Challenge-1---docker-compose)
    - [Challenge 2 - Tilt](#Challenge-2---tilt)

- [Kubernetes Starter Challenges](#Kubernetes-Starter-Challenges)
    - [Challenge 3 - Kubernetes](#Challenge-3---Kubernetes)
    - [Challenge 4 - Tilt+Kubernetes](#Challenge-4---Tilt+Kubernetes)
    - [Challenge 5 - GKE](#Challenge-5---GKE)

- [Kubernetes Advanced Challenges](#Kubernetes-Advanced-Challenges)    
    - [Challenge 6 - Istio](#Challenge-6---Istio)
    - [Challenge 7 - Helm](#Challenge-7---Helm)
    - [Challenge 8 - Helm+Tilt](#Challenge-8---Helm+Tilt)

- [Choose your own adventures](#Choose-your-own-adventures)
    - [Challenge TF1 - Terraform](#Challenge-TF1---Terraform)
    - [Challenge CI1 - CI](#Challenge-CI1---CI)
    - [Challenge CI2 - CI Preview Branches](#Challenge-CI2---CI-Preview-Branches)

# Warmup

## Challenge 0 - Docker
Get a static website built into and served from within Docker on your mac.

#### Create Dockerfile

Place this into dockerfile within parent directory<br>
`FROM nginx:alpine` <br>
`COPY . /usr/share/nginx/html`


#### Build the Docker Image for the HTML Server

`docker build -t html-server-image:v1 .`<br>
`docker images` <t> Confirm build has worked

#### Run the Docker Container

`docker run -d -p 80:80 html-server-image:v1` Doesn't work, port is occupied<br>
`docker run -d -p 800:80 html-server-image:v1`


#### Test the localhost

`http://localhost:800/` in the browser (works as expected)

<br><br>
---

## Challenge 1 - docker-compose
Set up docker-compose to make it so you can edit the content of the site while it is being served
via a volume.

#### Ensure that docker-compose is installed

`pip install docker-compose`


#### Set up postgres container

```
docker run -d -p 5432:5432 -v "$(pwd)":/home/ postgres
docker container ls
docker exec -it wizardly_franklin bash
cd home/
psql -U postgres
```

#### Add sql dump from pgAdmin

`psql -U postgres < menu.sql`

#### Build from yaml file

`docker build - < Dockerfile` Build from dockerfile <br>
`docker volume create --name=myvol` Create volume manually (numerous errors otherwise)<br>
`docker-compose -f docker-compose.yml up --remove-orphans` Remove orphans flag added

## [Review: Volume vs Bind Mount](#Practice-0)

<br><br>

# FINAL COMMANDS
`docker build -t html-server-image:v1 .` Build web server image<br>
`docker-compose -f docker-compose.yml up --remove-orphans` Docker-compose to start postgres/nginx containers<br>
`docker exec -t -i $CONTAINER_ID /bin/sh` Allows for bash in nginx container<br>
`cd /usr/share/nginx/html` Make changes here to serving site.

<br><br>
---
## Challenge 2 - Tilt
Set up tilt to be an alternate interface to docker-compose.

<br><br><br><br>
# Kubernetes Starter Challenges

##### minikube installation - https://kubernetes.io/docs/tasks/tools/install-minikube/
`grep -E --color 'vmx|svm' /proc/cpuinfo` First, check that virtualization is supported (good - nonempty output)<br>
```
curl -Lo minikube https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64 && chmod +x minikube
sudo mkdir -p /usr/local/bin/
sudo install minikube /usr/local/bin/
```
Confirm installation (requires root)<br>
- `sudo minikube start --vm-driver kvm2` [Error launching k8s - See Failure](#failed)
- `sudo minikube start --vm-driver=none` [Error launching k8s - See Failure](#failed2)

`systemctl enable kubelet.service` Don't do this - it opens ports and causes issues <br>
`sudo lsof -i:2380` check open port - PID for kill



`minikube status` Check status of cluster

##### kubectl installation - https://kubernetes.io/docs/tasks/tools/install-kubectl/#install-kubectl-on-linux
```
sudo apt-get update && sudo apt-get install -y apt-transport-https
curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add -
echo "deb https://apt.kubernetes.io/ kubernetes-xenial main" | sudo tee -a /etc/apt/sources.list.d/kubernetes.list
sudo apt-get update
sudo apt-get install -y kubectl
```

## Challenge 3 - Kubernetes

Via direct yaml manifests, set up a Deployment and a Service to get your docker image serving inside
a local Kubernetes cluster.

<br><br>
---
## Challenge 4 - Tilt+Kubernetes

Change your tilt setup to no longer use docker-compose but instead have it manage the deployment
inside your Kubernetes cluster.

<br><br>
---
## Challenge 5 - GKE
Change your tilt+Kubernetes setup to target a remote cluster (use GKE)


<br><br><br><br>
# Kubernetes Advanced Challenges
<br><br>
---
## Challenge 6 - Istio
Turn on Istio in your Kubernetes cluster, get your app to be served up by Istio (via a VirtualService).

<br><br>
---
## Challenge 7 - Helm
Package up your app in a Helm chart, get it deploying to GKE.

<br><br>
---
## Challenge 8 - Helm+Tilt
Package up your app in a Helm chart, get it deploying to GKE via Tilt.


<br><br><br><br>
# Choose your own adventures

## Path - Terraform
These challenges go down the path of performing full infrastructure as code.

<br><br>
---
## Challenge TF1 - Terraform
Bring up a matching GKE cluster via Terraform, move your process over to it.

<br><br>
---

## Path - CI
This path has you explore aspects of Release engineering and continuous integration.

<br><br>
---
## Challenge CI1 - CI
Write a Cloud Build or Github Action that releases a new version of your code when a merge to master occurs.

<br><br>
---
## Challenge CI2 - CI Preview Branches
Write a Cloud Build or Github Action that releases a new version of your code to some alternate URL when code is pushed to a branch.


<br><br><br><br>

# Practice 0
`docker run -it --name test1 -v ~/ricethings-website/docs/data:/data ubuntu bash` Bind mount <br>
`docker run -it --name test2 -v data:/data ubuntu bash` Docker volume <br>
`docker volume prune` Removes all volumes not used by 1+ containers <br>
`docker run -it --name test3 -v data:/data ubuntu bash` Attach existing volume despite deleting test2 <br>
`docker run -it --name master -v backup:/backup -v logs:/logs ubuntu bash` Creates and mounts 2 volumes <br>
`docker run -it --name slave1 --volumes-from master ubuntu bash` New container 'slave1' with volumes from master

<br><br>
# Failed

### `minikube start --vm-driver kvm2`

```
🚀  Launching Kubernetes ... 

💣  Error starting cluster: init failed. output: "-- stdout --\n[init] Using Kubernetes version: v1.17.3\n[preflight] Running pre-flight checks\n\n-- /stdout --\n** stderr ** \nW0324 15:38:31.838094   26569 validation.go:28] Cannot validate kube-proxy config - no validator is available\nW0324 15:38:31.838145   26569 validation.go:28] Cannot validate kubelet config - no validator is available\n\t[WARNING IsDockerSystemdCheck]: detected \"cgroupfs\" as the Docker cgroup driver. The recommended driver is \"systemd\". Please follow the guide at https://kubernetes.io/docs/setup/cri/\n\t[WARNING Swap]: running with swap on is not supported. Please disable swap\n\t[WARNING FileExisting-ebtables]: ebtables not found in system path\n\t[WARNING FileExisting-ethtool]: ethtool not found in system path\n\t[WARNING FileExisting-socat]: socat not found in system path\n\t[WARNING Service-Kubelet]: kubelet service is not enabled, please run 'systemctl enable kubelet.service'\n\t[WARNING Port-10250]: Port 10250 is in use\nerror execution phase preflight: [preflight] Some fatal errors occurred:\n\t[ERROR Port-10259]: Port 10259 is in use\n\t[ERROR Port-10257]: Port 10257 is in use\n\t[ERROR Port-2380]: Port 2380 is in use\n[preflight] If you know what you are doing, you can make a check non-fatal with `--ignore-preflight-errors=...`\nTo see the stack trace of this error execute with --v=5 or higher\n\n** /stderr **": /bin/bash -c "sudo env PATH=/var/lib/minikube/binaries/v1.17.3:$PATH kubeadm init --config /var/tmp/minikube/kubeadm.yaml  --ignore-preflight-errors=DirAvailable--etc-kubernetes-manifests,DirAvailable--var-lib-minikube,DirAvailable--var-lib-minikube-etcd,FileAvailable--etc-kubernetes-manifests-kube-scheduler.yaml,FileAvailable--etc-kubernetes-manifests-kube-apiserver.yaml,FileAvailable--etc-kubernetes-manifests-kube-controller-manager.yaml,FileAvailable--etc-kubernetes-manifests-etcd.yaml,Port-10250,Swap,SystemVerification": exit status 1
stdout:
[init] Using Kubernetes version: v1.17.3
[preflight] Running pre-flight checks

stderr:
W0324 15:38:31.838094   26569 validation.go:28] Cannot validate kube-proxy config - no validator is available
W0324 15:38:31.838145   26569 validation.go:28] Cannot validate kubelet config - no validator is available
	[WARNING IsDockerSystemdCheck]: detected "cgroupfs" as the Docker cgroup driver. The recommended driver is "systemd". Please follow the guide at https://kubernetes.io/docs/setup/cri/
	[WARNING Swap]: running with swap on is not supported. Please disable swap
	[WARNING FileExisting-ebtables]: ebtables not found in system path
	[WARNING FileExisting-ethtool]: ethtool not found in system path
	[WARNING FileExisting-socat]: socat not found in system path
	[WARNING Service-Kubelet]: kubelet service is not enabled, please run 'systemctl enable kubelet.service'
	[WARNING Port-10250]: Port 10250 is in use
error execution phase preflight: [preflight] Some fatal errors occurred:
	[ERROR Port-10259]: Port 10259 is in use
	[ERROR Port-10257]: Port 10257 is in use
	[ERROR Port-2380]: Port 2380 is in use
[preflight] If you know what you are doing, you can make a check non-fatal with `--ignore-preflight-errors=...`
To see the stack trace of this error execute with --v=5 or higher


😿  minikube is exiting due to an error. If the above message is not useful, open an issue:
👉  https://github.com/kubernetes/minikube/issues/new/choose
❌  Problems detected in Docker:
    Mar 23 13:33:16 nina-LENOVO dockerd[1713]: time="2020-03-23T13:33:16.453592053-07:00" level=warning msg="Failed to allocate and map port 80-80: Error starting userland proxy: listen tcp 0.0.0.0:80: bind: address already in use"
    Mar 23 13:33:17 nina-LENOVO dockerd[1713]: time="2020-03-23T13:33:17.305390236-07:00" level=error msg="Handler for POST /v1.39/containers/afb000d5ecaca5a0a820af142f550927178a55dd8b10fd3b8c63e32423985a11/start returned error: driver failed programming external connectivity on endpoint wonderful_meitner (699f89b560e3d9ee872f8ed81d383b191d919b49999fc7cd89f64c73f9891ae7): Error starting userland proxy: listen tcp 0.0.0.0:80: bind: address already in use"
    Mar 23 13:34:25 nina-LENOVO dockerd[1713]: time="2020-03-23T13:34:25.863657047-07:00" level=warning msg="Failed to allocate and map port 80-80: Error starting userland proxy: listen tcp 0.0.0.0:80: bind: address already in use"

```

<br><br>
## Failed2
### `minikube start --vm-driver none`

```
😄  minikube v1.8.2 on Ubuntu 19.04
✨  Using the none driver based on existing profile
⌛  Reconfiguring existing host ...
🏃  Using the running none "minikube" bare metal machine ...
ℹ️   OS release is Ubuntu 19.04
🐳  Preparing Kubernetes v1.17.3 on Docker 18.09.7 ...
    ▪ kubelet.resolv-conf=/run/systemd/resolve/resolv.conf
🚀  Launching Kubernetes ... 

💣  Error starting cluster: init failed. output: "-- stdout --\n[init] Using Kubernetes version: v1.17.3\n[preflight] Running pre-flight checks\n\n-- /stdout --\n** stderr ** \nW0324 16:35:03.696423    7896 validation.go:28] Cannot validate kube-proxy config - no validator is available\nW0324 16:35:03.696540    7896 validation.go:28] Cannot validate kubelet config - no validator is available\n\t[WARNING IsDockerSystemdCheck]: detected \"cgroupfs\" as the Docker cgroup driver. The recommended driver is \"systemd\". Please follow the guide at https://kubernetes.io/docs/setup/cri/\n\t[WARNING Swap]: running with swap on is not supported. Please disable swap\n\t[WARNING FileExisting-ebtables]: ebtables not found in system path\n\t[WARNING FileExisting-ethtool]: ethtool not found in system path\n\t[WARNING FileExisting-socat]: socat not found in system path\n\t[WARNING Port-10250]: Port 10250 is in use\nerror execution phase preflight: [preflight] Some fatal errors occurred:\n\t[ERROR Port-10259]: Port 10259 is in use\n\t[ERROR Port-10257]: Port 10257 is in use\n\t[ERROR Port-2380]: Port 2380 is in use\n[preflight] If you know what you are doing, you can make a check non-fatal with `--ignore-preflight-errors=...`\nTo see the stack trace of this error execute with --v=5 or higher\n\n** /stderr **": /bin/bash -c "sudo env PATH=/var/lib/minikube/binaries/v1.17.3:$PATH kubeadm init --config /var/tmp/minikube/kubeadm.yaml  --ignore-preflight-errors=DirAvailable--etc-kubernetes-manifests,DirAvailable--var-lib-minikube,DirAvailable--var-lib-minikube-etcd,FileAvailable--etc-kubernetes-manifests-kube-scheduler.yaml,FileAvailable--etc-kubernetes-manifests-kube-apiserver.yaml,FileAvailable--etc-kubernetes-manifests-kube-controller-manager.yaml,FileAvailable--etc-kubernetes-manifests-etcd.yaml,Port-10250,Swap,SystemVerification": exit status 1
stdout:
[init] Using Kubernetes version: v1.17.3
[preflight] Running pre-flight checks

stderr:
W0324 16:35:03.696423    7896 validation.go:28] Cannot validate kube-proxy config - no validator is available
W0324 16:35:03.696540    7896 validation.go:28] Cannot validate kubelet config - no validator is available
	[WARNING IsDockerSystemdCheck]: detected "cgroupfs" as the Docker cgroup driver. The recommended driver is "systemd". Please follow the guide at https://kubernetes.io/docs/setup/cri/
	[WARNING Swap]: running with swap on is not supported. Please disable swap
	[WARNING FileExisting-ebtables]: ebtables not found in system path
	[WARNING FileExisting-ethtool]: ethtool not found in system path
	[WARNING FileExisting-socat]: socat not found in system path
	[WARNING Port-10250]: Port 10250 is in use
error execution phase preflight: [preflight] Some fatal errors occurred:
	[ERROR Port-10259]: Port 10259 is in use
	[ERROR Port-10257]: Port 10257 is in use
	[ERROR Port-2380]: Port 2380 is in use
[preflight] If you know what you are doing, you can make a check non-fatal with `--ignore-preflight-errors=...`
To see the stack trace of this error execute with --v=5 or higher


😿  minikube is exiting due to an error. If the above message is not useful, open an issue:
👉  https://github.com/kubernetes/minikube/issues/new/choose

```