## Apache2 with php7 on Ubuntu 16.04 LTS

This is a docker images with  Ubuntu 16.04 LTS with apache2 and php7/composer

To access site contents from utside the container you should map /var/www

Includes composer for easy download of php libraries

## Base on

https://github.com/nimmis/docker-apache-php7

### Examples

- plain, accessable on port 8080 `docker run -d -p 8080:80 dszymczuk/apache-php7`
- with external contents in /home/dszymczuk/html `docker run -d -p 8080:80 -v /home/dszymczuk/html:/var/www/html dszymczuk/apache-php7`

The docker container is started with the -d flag so it will run inte the background. To run commands or edit settings inside
the container run `docker exec -ti <container id> /bin/bash'
