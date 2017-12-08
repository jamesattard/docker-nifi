NiFi in Docker
===============

This configuration builds a docker container to run Apache NiFi.


Build Image
-----------

    $ docker build -t jamez/nifi .


Pull image
----------

If you want to pull the image already built then use this

    $ docker pull jamez/nifi

More details at https://hub.docker.com/r/jamez/nifi


Run NiFi
---------

    $ docker run -it --rm -d -p 8080:8080 jamez/nifi


Access NiFi Dashboard
---------------------

NiFi will be accessible on localhost port 8080

    http://localhost:8080/nifi