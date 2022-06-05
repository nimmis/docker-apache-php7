FROM nimmis/ubuntu:20.04

# disable interactive functions
ENV DEBIAN_FRONTEND noninteractive

EXPOSE 80

RUN apt-get update

RUN apt-get install -y curl

RUN apt-get install -y apache2 php libapache2-mod-php  \
php-fpm php-cli php-mysqlnd php-pgsql php-sqlite3 php-redis \
php-apcu php-intl php-imagick php-json php-gd php-curl php-mbstring php-zip php-xml && \
rm -rf /var/lib/apt/lists/* && \
cd /tmp && curl -sS https://getcomposer.org/installer | php && mv composer.phar /usr/local/bin/composer

RUN echo "memory_limit=512M" > /etc/php/7.4/apache2/conf.d/memory-limit.ini

RUN echo "upload_max_filesize = 256M\n" \
         "post_max_size = 256M\n" \
         > /etc/php/7.4/apache2/conf.d/uploads.ini

ADD apache2.conf /etc/supervisor/conf.d/

RUN a2enmod rewrite

RUN echo "ServerName localhost" >> /etc/apache2/apache2.conf

# eneble .htaccess overrides for /var/www
RUN echo "<Directory /var/www/html>" >> /etc/apache2/apache2.conf
RUN echo "	Options Indexes FollowSymLinks" >> /etc/apache2/apache2.conf
RUN echo "	AllowOverride All" >> /etc/apache2/apache2.conf
RUN echo "	Require all granted" >> /etc/apache2/apache2.conf
RUN echo "</Directory>" >> /etc/apache2/apache2.conf
