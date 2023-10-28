# Use a base image with PHP and required extensions
FROM php:7.4-fpm

# Install system dependencies and PHP extensions
RUN apt-get update && apt-get install -y libpng-dev libjpeg-dev zip unzip && \
    docker-php-ext-configure gd --with-jpeg && \
    docker-php-ext-install gd pdo pdo_mysql && \
    apt-get clean

# Set the working directory
WORKDIR /var/www/html

# Copy the Laravel application files to the container
COPY . .

# Install Composer and Laravel dependencies
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer && \
    composer install

# Expose the port the application will run on
EXPOSE 8000

# Start the Laravel application
CMD php artisan serve --host=0.0.0.0 --port=8000
