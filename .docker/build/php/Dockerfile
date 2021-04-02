FROM php:php-version-fpm

# Set working directory
WORKDIR /var/www

# Install dependencies
RUN apt-get update \
    && apt-get upgrade -y \
    && apt-get dist-upgrade -y \
    && apt-get install -y \
    	build-essential \
        libpng-dev \
        libjpeg62-turbo-dev \
        libfreetype6-dev \
        mcryptSupport \
        mcryptInstall \
        php74install \
        locales \
        zip \
        jpegoptim optipng pngquant gifsicle \
        nano \
        unzip \
        git \
        curl \
    && apt-get clean -y \
    && rm -rf /var/lib/apt/lists/*

# Install extensions
RUN docker-php-ext-install mbstring zip exif pcntl
gdConfiguration
RUN docker-php-ext-install gd
RUN docker-php-ext-install pdo pdo_mysql mysqli
RUN docker-php-ext-enable mysqli
mcryptEnable
bcmathInstall

# Install composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# Add user for application
RUN groupadd -g 1000 www
RUN useradd -u 1000 -ms /bin/bash -g www www

# Change current user to www
USER www

# Expose port 9000 and start php-fpm server
EXPOSE 9000
CMD ["php-fpm"]