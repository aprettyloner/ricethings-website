# ricethings-website

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


