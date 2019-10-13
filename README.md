# Laravel Docker Template

![Docker Build Status](https://img.shields.io/docker/build/socheatsok78/laravel)
![MicroBadger Size](https://img.shields.io/microbadger/image-size/socheatsok78/laravel)

This image is using `php:7.3-fpm-buster`.

Installed tools:
- Git
- Composer

Installed PHP extensions:
- BCMath PHP Extension
- Ctype PHP Extension
- JSON PHP Extension
- Mbstring PHP Extension
- OpenSSL PHP Extension
- PDO PHP Extension
- Tokenizer PHP Extension
- XML PHP Extension
- Redis PHP Extension

## How to use this image
### Create a `Dockerfile` in your PHP project
```
FROM socheatsok78/laravel:latest

# Copy existing application directory permissions
COPY --chown=www:www . /var/www

# Set working directory
WORKDIR /var/www

# Expose port 9000 and start php-fpm server
EXPOSE 9000

# Start application service
CMD [ "/usr/local/bin/app-service.sh" ]
```

Then, run the commands to build and run the Docker image:

```sh
$ docker build -t my-laravel-app .
$ docker run -it --rm --name my-running-app my-laravel-app
```

Now you can visit `localhost:9000` on you browser.

### How to install more PHP extensions
Please visit [Official Docker PHP Image](https://hub.docker.com/_/php) for instruction
