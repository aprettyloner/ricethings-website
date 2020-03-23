# ricethings-website
<br><br><br>

## Challenge 0 - Docker
Get a static website built into and served from within Docker on your mac.

### Create Dockerfile

Place this into dockerfile within parent directory<br>
`FROM nginx:alpine` <br>
`COPY . /usr/share/nginx/html`


### Build the Docker Image for the HTML Server

`docker build -t html-server-image:v1 .`<br>
`docker images` <t> Confirm build has worked

### Run the Docker Container

`docker run -d -p 80:80 html-server-image:v1` Doesn't work, port is occupied<br>
`docker run -d -p 800:80 html-server-image:v1`


### Test the localhost

`http://localhost:800/` in the browser (works as expected)

<br><br>
---
## Challenge 1 - docker-compose
Set up docker-compose to make it so you can edit the content of the site while it is being served
via a volume.

### Ensure that docker-compose is installed

`pip install docker-compose`


<br><br>
---
## Challenge 2 - Tilt
Set up tilt to be an alternate interface to docker-compose.

<br><br><br><br>
# Kubernetes Starter Challenges

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

### Path: Terraform
These challenges go down the path of performing full infrastructure as code.
<br><br>
---
## Challenge TF1 - Terraform
Bring up a matching GKE cluster via Terraform, move your process over to it.
<br><br>
---
## Path: CI
This path has you explore aspects of Release engineering and continuous integration.
<br><br>
---
## Challenge CI1 - CI
Write a Cloud Build or Github Action that releases a new version of your code when a merge to master occurs.
<br><br>
---
## Challenge CI2 - CI Preview Branches
Write a Cloud Build or Github Action that releases a new version of your code to some alternate URL when code is pushed to a branch.

