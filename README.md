# NiFi in Docker

This configuration builds a docker container to run Apache NiFi.

## Build Image

    $ docker build -t jamez/nifi .

## Pull image

If you want to pull the image already built then use this

    $ docker pull jamez/nifi

More details at https://hub.docker.com/r/jamez/nifi

## Run NiFi standalone container

    $ docker run -it --rm -d -p 8080:8080 jamez/nifi

## Using Docker Compose

    $ docker-compose up -d

## Access NiFi Dashboard

If you are using the standalone Docker NiFi, the dashboard will be accessible on
localhost port 8080:

    http://localhost:8080/nifi

Otherwise (if you're using the docker-compose approach), I have put the NiFi
behind a proxy service so you can access it using a virtualhost as follows:

    http://nifi.localhost/nifi
