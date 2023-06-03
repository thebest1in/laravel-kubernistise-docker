FROM php:8.2.0-apache

WORKDIR /var/www/html

RUN apt-get update \
    && apt-get install -y build-essential libpng-dev libzip-dev libonig-dev libssl-dev \
    && docker-php-ext-install pdo_mysql mbstring zip exif pcntl bcmath gd \
    && curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

COPY . .

RUN chown -R www-data:www-data /var/www/html/storage /var/www/html/bootstrap/cache

# Generate application key
RUN php artisan key:generate

EXPOSE 80

CMD ["apache2-foreground"]
