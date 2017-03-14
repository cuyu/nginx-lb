## nginx-lb

A docker image to start a load balancer (with [sticky](https://bitbucket.org/nginx-goodies/nginx-sticky-module-ng) module) using Nginx.

*Since we use the third-party module ([sticky](https://bitbucket.org/nginx-goodies/nginx-sticky-module-ng)), the Nginx must be compiled from the source. To reduce more image size, maybe we can copy the compiled files into the images directly (so we do not install C/C++ compiler in the image).*

### Use

1. To build the docker image:

   ```
   docker build -t nginx-lb:v1 .
   ```


2. Revise the `nginx.conf`, with specific hostnames in it.

3. Run the docker container with specific `nginx.conf` (with load balance enabled):

   ```
   docker run --name lb -v /Users/CYu/Code/Docker/nginx-lb/nginx.conf:/usr/local/nginx/conf/nginx.conf -p 8080:80 nginx-lb:v1
   ```

   Then open `http://localhost:8080`, you will see the target web page.

### TODO

1. Support proxy https web pages (i.e. enable ssl).
2. ~~Use smaller base image (maybe install g++ and wget on a basic ubuntu image).~~