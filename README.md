## nginx-lb

A docker image to start a load balancer using Nginx.

### Use

1. To build the docker image:

   ```
   docker build -t nginx-lb:v1 .
   ```


2. Revise the `nginx-lb.conf`, with specific hostnames in it.

3. Run the docker container with specific `nginx.conf` (with load balance enabled):

   ```
   docker run --name lb -v /Users/CYu/Code/Docker/nginx-lb/nginx-lb.conf:/usr/local/nginx/conf/nginx.conf -p 8080:80 nginx-lb:v1
   ```

   Then open `http://localhost:8080`, you will see the target web page.

### TODO

1. Support proxy https web pages (i.e. enable ssl).
2. ~~Use smaller base image (maybe install g++ and wget on a basic ubuntu image).~~