FROM php:8.0.12-fpm-alpine3.14

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
    chown -R $user:$user /home/$user

# Set working directory
WORKDIR /var/www

# Change the User
USER $user