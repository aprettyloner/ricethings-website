FROM nginx:alpine
# RUN mkdir /myvol

ENV APP_ROOT /apps
ENV CONFIG_ROOT /config

RUN mkdir ${CONFIG_ROOT}

COPY . /usr/share/nginx/html

WORKDIR .
# VOLUME /docs