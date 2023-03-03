FROM php:8.0-apache
RUN docker-php-ext-install mysqli && docker-php-ext-enable mysqli
RUN apt-get update && apt-get upgrade -y
RUN sed -i "s/Listen 80/Listen 8888/g" /etc/apache2/ports.conf
