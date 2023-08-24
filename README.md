# wordpress-docker-bedrock-starter

This Docker WordPress starter template is built with Bedrock, aiming to provide a simple and easy-to-use development and production environment.

## Requirements

- Composer
- Docker
- Docker Compose

## Installation and Local Development

1. Navigate to the `/website/bedrock` directory and run `composer install`.

2. Edit the .env files in the env folder to match your configuration.
   For local development, the .env.dev file is preloaded in the Docker container.

3. Run `docker-compose up`.

4. Open http://localhost:8080 in your browser to access the website.

## Database

For local development, a MariaDB instance is provided and ready to use.

For production deployments in the cloud, create a `.env` file with the necessary information pointing to your production database or use server variables.

## Deployment

### Build the Docker Image

Run the following command to build a Docker image from the Dockerfile:

`docker build -t <image-name> .`

Replace `<image-name>` with a name for your Docker image.

### Run the Docker Image in an Isolated Container

Start a Docker container using the built image with the following command:

```
docker run -it -p 8080:8080 \
-e DB_NAME="<database-name>" \
-e DB_USER="<database-user>" \
-e DB_PASSWORD="<database-password>" \
-e DB_HOST="<database-host>" \
-e DB_PREFIX="<database-prefix>" \
-e WP_ENV="<wordpress-environment>" \
-e WP_HOME="<wordpress-home-url>" \
-e WP_SITEURL="<wordpress-site-url>" \
-e CAPTCHA_PUBLIC_KEY="<recaptcha-public-key>" \
-e CAPTCHA_PRIVATE_KEY="<recaptcha-private-key>" \
<image-name>
```

Replace the template variables with your actual values and run the command.

## Sources

[emilpriver/wordpress-docker-bedrock-starter](https://github.com/emilpriver/wordpress-docker-bedrock-starter)
