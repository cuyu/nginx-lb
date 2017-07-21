## nginx-lb

A docker image to start a load balancer (with [sticky](https://bitbucket.org/nginx-goodies/nginx-sticky-module-ng) module) using Nginx.

*Since we use the third-party module ([sticky](https://bitbucket.org/nginx-goodies/nginx-sticky-module-ng)), the Nginx must be compiled from the source. To reduce more image size, we use the **alpine** basic image. The built image size is 194MB which is acceptable now.*

### Get start

1. Pull the docker image:

   ```
   docker pull cuyu/nginx-lb
   ```


   **OR** you can git clone this project and build the docker image at local:

   ```
   docker build -t nginx-lb .
   ```

2. Create a file named `hosts`, with specific hostnames (include port) in it.
   For example:

   ```
   example-host1:8000
   example-host2:8000
   example-host3:8000
   ```

3. Run the docker container:

   ```
   docker run --rm --name lb -v /YOUR_OWN_PATH/hosts:/usr/local/hosts -p 8080:80 cuyu/nginx-lb
   ```

   Then open `http://localhost:8080`, you will see the target web page.

   **OR** if you want to proxy with ssl:

   ```
   docker run --rm --name lb -v /YOUR_OWN_PATH/hosts:/usr/local/hosts -p 8080:80 cuyu/nginx-lb -ssl
   ```

   Then open `https://localhost:8080`, you will see the target web page.

### TODO

1. ~~Support proxy https web pages (i.e. enable ssl).~~
2. ~~Use smaller base image (maybe install g++ and wget on a basic ubuntu image).~~