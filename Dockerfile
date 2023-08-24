# Build PHP-FPM container
FROM php:8.2.0-fpm-alpine

# Install gettext for envsubst
RUN apk add --no-cache gettext

# Install MYSQLI
RUN docker-php-ext-install mysqli pdo pdo_mysql && docker-php-ext-enable mysqli

# Copy custom www.conf file
COPY php-fpm/www.conf /usr/local/etc/php-fpm.d/www.conf

# Install Nginx
RUN apk add --no-cache nginx

# Install Composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# Set the working directory
WORKDIR /var/www/html

# Copy composer.json and composer.lock files
COPY website/bedrock/composer.json website/bedrock/composer.lock ./

# Run composer install
RUN composer install --no-dev --no-scripts --no-autoloader

# Remove the .env file to ensure Google Cloud Run environment variables are used
RUN rm -f /var/www/html/.env

# Copy NGINX configuration files
COPY nginx/cloud.conf /etc/nginx/conf.d/default.conf
COPY nginx/nginx.conf /etc/nginx/nginx.conf

# Copy PHP-FPM configuration files
COPY php-fpm/php-fpm.conf /usr/local/etc/php-fpm.conf

# Copy the application code
COPY website/bedrock .

# Generate the autoloader
RUN composer dump-autoload --optimize --no-dev --classmap-authoritative

# Expose the port
EXPOSE 8080

# Start NGINX and PHP-FPM using the export-env-vars.sh script
CMD ["/bin/sh", "-c", "envsubst '$$DB_NAME $$DB_USER $$DB_PASSWORD $$DB_HOST $$DB_PREFIX $$WP_ENV $$WP_HOME $$WP_SITEURL $$CAPTCHA_PUBLIC_KEY $$CAPTCHA_PRIVATE_KEY' < /etc/nginx/conf.d/default.conf > /etc/nginx/conf.d/default.temp && mv /etc/nginx/conf.d/default.temp /etc/nginx/conf.d/default.conf && /usr/local/sbin/php-fpm -D && nginx -g 'daemon off;'"]
