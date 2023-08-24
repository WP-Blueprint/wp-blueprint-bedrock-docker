#!/bin/sh

# Generate the env.conf file with the environment variables
cat << EOF > /usr/local/etc/php-fpm.d/env.conf
env[DB_NAME] = ${DB_NAME}
env[DB_USER] = ${DB_USER}
env[DB_PASSWORD] = ${DB_PASSWORD}
env[DB_HOST] = ${DB_HOST}
env[DB_PREFIX] = ${DB_PREFIX}
env[WP_ENV] = ${WP_ENV}
env[WP_SITEURL] = ${WP_SITEURL}
env[CAPTCHA_PUBLIC_KEY] = ${CAPTCHA_PUBLIC_KEY}
env[CAPTCHA_PRIVATE_KEY] = ${CAPTCHA_PRIVATE_KEY}
EOF