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

Choose your own adventures
  - [Terraform Adventure](#Path---Terraform)
    - [Challenge TF1 - Terraform](#Challenge-TF1---Terraform)
  - [CI Adventure](#Path---CI)
    - [Challenge CI1 - CI](#Challenge-CI1---CI)
    - [Challenge CI2 - CI Preview Branches](#Challenge-CI2---CI-Preview-Branches)

# Warmup

# Challenge 0 - Docker
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

```
docker run -d -p 800:80 html-server-image:v1
```


#### Test the localhost

`http://localhost:800/` in the browser (works as expected)

<br><br>
---

# Challenge 1 - docker-compose
Set up docker-compose to make it so you can edit the content of the site while it is being served
via a volume.

#### Ensure that docker-compose is installed

`pip install docker-compose`


#### Build from yaml file

`docker build - < Dockerfile` Build from dockerfile <br>
`docker volume create --name=myvol` Create volume manually (numerous errors otherwise)<br>
`docker-compose -f docker-compose.yml up --remove-orphans` Remove orphans flag added

## [Review: Volume vs Bind Mount](#Practice-0)
## [Review: Postgres via docker](#postgres-review)

<br><br>

## CHALLENGE 1 - SOLUTION
`docker build -t html-server-image:v1 .` Build web server image<br>
`docker-compose -f docker-compose.yml up --remove-orphans` Docker-compose to start postgres/nginx containers<br>
`docker exec -t -i $CONTAINER_ID /bin/sh` Allows for bash in nginx container<br>
`cd /usr/share/nginx/html` Make changes here to serving site.

<br><br>
---

# Challenge 2 - Tilt
Set up tilt to be an alternate interface to docker-compose.

#### Step 0: Painstaking setup

[See setup trials and tribulations](#Tilt-setup)

#### Step 1: Get acquainted via tutorial
[Simple tilt tutorial](#Practice-1)

#### Step 2: Execute
1. Dockerfile
```
FROM busybox
WORKDIR .
ADD . .
ENTRYPOINT ./main.sh
```

2. kubernetes.yaml
```
apiVersion: apps/v1
kind: Deployment
metadata:
  name: ricethings-html
  labels:
    app: ricethings-html
spec:
  selector:
    matchLabels:
      app: ricethings-html
  template:
    metadata:
      labels:
        app: ricethings-html
    spec:
      containers:
      - name: ricethings-html
        image: ricethings-html-image
        ports:
        - containerPort: 8000
```

3. Tiltfile
```
docker_build('ricethings-html-image', '.')
k8s_yaml('kubernetes.yaml')
k8s_resource('ricethings-html', port_forwards=8000)
```
Note: Had to remove `resource_deps=['deploy']` - wonder why this dep is not found as compared to tutorial

## CHALLENGE 2 - SOLUTION

```
cd ricethings-website/docs
tilt up
```
check in browser: `http://localhost:8000/`

<br><br><br><br>
# Kubernetes Starter Challenges

### minikube installation - https://kubernetes.io/docs/tasks/tools/install-minikube/
`grep -E --color 'vmx|svm' /proc/cpuinfo` First, check that virtualization is supported (good - nonempty output)<br>
```
curl -Lo minikube https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64 && chmod +x minikube
sudo mkdir -p /usr/local/bin/
sudo install minikube /usr/local/bin/
```
Confirm installation (requires root)<br>
- `sudo minikube start --vm-driver kvm2` [Error launching k8s with KVM - See Failure](#failed)
- `sudo minikube start --vm-driver none` [Error launching k8s with no driver- See Failure](#failed2)


Create your own problems, then take an hour to fix them :P<br>
- `systemctl enable kubelet.service` DON'T DO THIS AGAIN! - it opens ports and causes issues <br>
- `sudo lsof -i:2380` check open port - PID for kill


Check status of cluster, start minikube<br>
- `minikube status` 
- `sudo minikube start --vm-driver none`
- `docker container stop $(docker container ls -q --filter name=k8s*)` Stop all docker containers by pattern matching name
- `docker rm $(docker ps -a -q)` Remove all stopped containers

### kubectl installation - https://kubernetes.io/docs/tasks/tools/install-kubectl/#install-kubectl-on-linux
```
sudo apt-get update && sudo apt-get install -y apt-transport-https
curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add -
echo "deb https://apt.kubernetes.io/ kubernetes-xenial main" | sudo tee -a /etc/apt/sources.list.d/kubernetes.list
sudo apt-get update
sudo apt-get install -y kubectl
```

## kubectl dashboard
Note: This isn't working, let's just go by command line for now
```
kubectl apply -f https://raw.githubusercontent.com/kubernetes/dashboard/v2.0.0-rc6/aio/deploy/recommended.yaml
```

## kubectl commands
`kubectl get pods` 
`kubectl delete pods <name>`
`tilt down` - Remember to tilt down to actually shut down cluster. Will just recreate pods if you stop them, silly!

# Challenge 3 - Kubernetes




Via direct yaml manifests, set up a Deployment and a Service to get your docker image serving inside
a local Kubernetes cluster.

<br><br>
---
# Challenge 4 - Tilt+Kubernetes

Change your tilt setup to no longer use docker-compose but instead have it manage the deployment
inside your Kubernetes cluster.

<br><br>
---
# Challenge 5 - GKE
Change your tilt+Kubernetes setup to target a remote cluster (use GKE)


<br><br><br><br>
# Kubernetes Advanced Challenges
<br><br>
---
# Challenge 6 - Istio
Turn on Istio in your Kubernetes cluster, get your app to be served up by Istio (via a VirtualService).

<br><br>
---
# Challenge 7 - Helm
Package up your app in a Helm chart, get it deploying to GKE.

<br><br>
---
# Challenge 8 - Helm+Tilt
Package up your app in a Helm chart, get it deploying to GKE via Tilt.


<br><br><br><br>
# Choose your own adventures

## Path - Terraform
These challenges go down the path of performing full infrastructure as code.

### terraform installation - https://www.terraform.io/downloads.html
#### from binary
- Download 64-bit Linux binary
- Extract file and cd into containing directory
- `sudo mv terraform /usr/bin` Move to dir that is in $PATH
- `terraform --version` Verify installation

#### via docker
```
docker pull hashicorp/terraform:0.12.24
docker run  hashicorp/terraform:0.12.24 --version
```

<<<<<<< HEAD
#### Step 0: Get acquainted via tutorial - [Simple terraform tutorial](#simple-tutorial)

#### Step 1: Learn HCL (Hashicorp Configuration Language) - [HCL Basics](#HCL-basics)
=======
#### Step 0: Get acquainted via tutorial
[Simple terraform tutorial](#simple-tutorial)


#### Step 1: Learn HCL (Hashicorp Configuration Language)
[HCL Basics](#HCL-basics)
>>>>>>> 1b4cb2e18bcc56e162a91a28c3dcf2ad30b5e6e3

<br><br>
---
# Challenge TF1 - Terraform
Bring up a matching GKE cluster via Terraform, move your process over to it.

<br><br>
---

## Path - CI
This path has you explore aspects of Release engineering and continuous integration.

<br><br>
---
# Challenge CI1 - CI
Write a Cloud Build or Github Action that releases a new version of your code when a merge to master occurs.

<br><br>
---
# Challenge CI2 - CI Preview Branches
Write a Cloud Build or Github Action that releases a new version of your code to some alternate URL when code is pushed to a branch.


<br><br><br><br>

# Practice 0
`docker run -it --name test1 -v ~/ricethings-website/docs/data:/data ubuntu bash` Bind mount <br>
`docker run -it --name test2 -v data:/data ubuntu bash` Docker volume <br>
`docker volume prune` Removes all volumes not used by 1+ containers <br>
`docker run -it --name test3 -v data:/data ubuntu bash` Attach existing volume despite deleting test2 <br>
`docker run -it --name master -v backup:/backup -v logs:/logs ubuntu bash` Creates and mounts 2 volumes <br>
`docker run -it --name slave1 --volumes-from master ubuntu bash` New container 'slave1' with volumes from master

# Practice 1
Tutorial - https://docs.tilt.dev/example_static_html.html
An example project that demonstrates a live-updating server with nothing but Shell, HTML, and Kubernetes.

`git clone git@github.com:windmilleng/tilt-example-html.git`

Requirements:
1. Dockerfile (builds the image)
Dockerfile
```
FROM busybox
WORKDIR /app
ADD . .
ENTRYPOINT ./main.sh
```

2. Kubernetes Deployment (runs the image)
kubernetes.yaml
```
apiVersion: apps/v1
kind: Deployment
metadata:
  name: example-html
  labels:
    app: example-html
spec:
  selector:
    matchLabels:
      app: example-html
  template:
    metadata:
      labels:
        app: example-html
    spec:
      containers:
      - name: example-html
        image: example-html-image
        ports:
        - containerPort: 8000
```

3. Tiltfile (binds 1 and 2)
```
docker_build('example-html-image', '.')
k8s_yaml('kubernetes.yaml')
k8s_resource('example-html', port_forwards=8000, resource_deps=['deploy'])

# Records the time from a code change to a new process Normally, you would let Tilt do deploys automatically, but this shows you how to set up a custom workflow that measures it.
local_resource(
  'deploy',
  'date +%s > start-time.txt')
```

Run it, try it 
```
git clone https://github.com/windmilleng/tilt-example-html
cd tilt-example-html/0-base
tilt up
```

# Practice 2

## Terraform Basics

### major functions
- `init`
- `plan`
- `apply`

### additional fcns
- `format`
- `import`
- `validate` (like lint)
- `workspace` (diff env: dev/stage/prod)

## Simple Tutorial
```
mkdir hello_terraform
cd hello_terraform/
nano main.tf
```

main.tf
```
output "greeting"{
        value = "Hello Terraform."
}

provider "random" {}
```
initialize, apply, etc.
```
terraform init
terraform plan
terraform apply
terraform output
terraform state list
```

## HCL Basics

HCL Structure - root module
- `main.tf` Declare resources
- `outputs.tf` Declare outputs
- `variables.tf` Declare variables

main.tf
- Main Blocks
    - `terraform` (optional) config for Terraform Engine
    - `provider` (optional) config for specific apis, e.g. AWS region/keys
    - `resource` managed by Terraform (e.g., VMs, S3 buckets)
    - `data` data sources NOT managed by Terraform

cmd line
`tf init`
`tf plan -out example.tfplan` output plan to .tfplan file
`terraform apply "example.tfplan` apply plan previously reviewed



<br><br><br>
---

# Tilt setup
#### tilt installation - https://docs.tilt.dev/install.html

1. Setup Docker as a non-root user - https://docs.docker.com/install/linux/linux-postinstall/

    `sudo groupadd docker-nonroot` Create the docker group.<br>
    `sudo usermod -aG docker-nonroot $USER` Add your user to the docker group.<br>
    `docker run hello-world` Test that nonroot works

##### Add user permissions to fix error: <br>`WARNING: Error loading config file:/home/user/.docker/config.json - stat /home/user/.docker/config.json: permission denied`
```
sudo chown "$USER":"$USER" /home/"$USER"/.docker -R
sudo chmod g+rwx "/home/$USER/.docker" -R
```

2. Install kubectl - [see below](#kubectl-installation---https://kubernetes.io/docs/tasks/tools/install-kubectl/#install-kubectl-on-linux)

3. Install Microk8s:
Enable dns fails! [See fix below](#trying-fix)
```
sudo snap install microk8s --classic && \
sudo microk8s.enable dns && \
sudo microk8s.enable registry
```

### Trying fix for microk8s dns error
First remove the version of microk8s you already have, it might be disabled. Then redeploy from the edge channel since it has a lot of fixes:
```
sudo snap enable microk8s
sudo snap remove microk8s
sudo snap install microk8s --edge --classic
sudo microk8s.enable dns && \
sudo microk8s.enable registry
```
### WORKED! Proceeeding...

#### Retrying instructions for starting microk8s from https://microk8s.io/docs/ 
```
sudo usermod -a -G microk8s $USER
su - $USER
microk8s.status --wait-ready
```


#### The following configuration code fails!! [See manual fix below](#fix-by-hand)
```
sudo microk8s.kubectl config view --flatten > ~/.kube/microk8s-config
sudo KUBECONFIG=~/.kube/microk8s-config:~/.kube/config kubectl config view --flatten > ~/.kube/temp-config 
sudo mv ~/.kube/temp-config ~/.kube/config 
sudo kubectl config use-context microk8s
```


### Fix by hand
`sudo microk8s.kubectl config view --flatten` Copy output<br>
`sudo nano ~/.kube/microk8s-config` Paste here <br>
`sudo KUBECONFIG=~/.kube/microk8s-config:~/.kube/config kubectl config view --flatten` Copy output<br>
`sudo nano ~/.kube/temp-config` Paste here <br>
`sudo mv ~/.kube/temp-config ~/.kube/config`<br>
`sudo chown -R $USER ~/.kube` Should have done this earlier. Whatever. Change permissions for tilt to work, find kube config.

### WORKED! Proceeeding...

4. Install Tilt binary
```
curl -fsSL https://raw.githubusercontent.com/windmilleng/tilt/master/scripts/install.sh | bash
tilt version
```

<br><br><br>
---

# postgres review
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

<br><br><br>
---

# Failure is a crucial for achieving true success.

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