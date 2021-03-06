FROM php:7.4.0-fpm-alpine

# Arguments defined in docker-compose.yml
ARG user
ARG uid

# Set user root
USER root

# Install system dependencies
RUN apk update && apk add vim \
	bash \
	curl

# Install PHP extensions
RUN docker-php-ext-install mysqli pdo pdo_mysql exif pcntl

# Get latest Composer
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

# Create system user to run Composer and Artisan Commands
RUN adduser --disabled-password -u $uid -h "/home/$user" "$user"
	
RUN mkdir -p /home/$user/.composer && \
    chown -R $user:$user /home/$user && \
    chown -R $user:$user /var/www

# Set working directory
WORKDIR /var/www

# Change the User
USER $user