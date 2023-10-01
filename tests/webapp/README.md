<a href="https://elest.io">
  <img src="https://elest.io/images/elestio.svg" alt="elest.io" width="150" height="75">
</a>

[![Discord](https://img.shields.io/static/v1.svg?logo=discord&color=f78A38&labelColor=083468&logoColor=ffffff&style=for-the-badge&label=Discord&message=community)](https://discord.gg/4T4JGaMYrD "Get instant assistance and engage in live discussions with both the community and team through our chat feature.")
[![Elestio examples](https://img.shields.io/static/v1.svg?logo=github&color=f78A38&labelColor=083468&logoColor=ffffff&style=for-the-badge&label=github&message=open%20source)](https://github.com/elestio-examples "Access the source code for all our repositories by viewing them.")
[![Blog](https://img.shields.io/static/v1.svg?color=f78A38&labelColor=083468&logoColor=ffffff&style=for-the-badge&label=elest.io&message=Blog)](https://blog.elest.io "Latest news about elestio, open source software, and DevOps techniques.")

# Bigcapital, verified and packaged by Elestio

[Bigcapital](https://bigcapital.ly/) is an online accounting software, built to automate business financial processes.

<img src="https://github.com/elestio-examples/bigcapital/raw/main/bigcapital.png" alt="bigcapital" width="800">

Deploy a <a target="_blank" href="https://elest.io/open-source/bigcapital">fully managed Bigcapital</a> on <a target="_blank" href="https://elest.io/">elest.io</a> if you want automated backups, reverse proxy with SSL termination, firewall, automated OS & Software updates, and a team of Linux experts and open source enthusiasts to ensure your services are always safe, and functional.

[![deploy](https://github.com/elestio-examples/bigcapital/raw/main/deploy-on-elestio.png)](https://dash.elest.io/deploy?source=cicd&social=dockerCompose&url=https://github.com/elestio-examples/bigcapital)

# Why use Elestio images?

- Elestio stays in sync with updates from the original source and quickly releases new versions of this image through our automated processes.
- Elestio images provide timely access to the most recent bug fixes and features.
- Our team performs quality control checks to ensure the products we release meet our high standards.

# Usage

## Git clone

You can deploy it easily with the following command:

    git clone https://github.com/elestio-examples/bigcapital.git

Copy the .env file from tests folder to the project directory

    cp ./tests/.env ./.env

Edit the .env file with your own values.

Run the project with the following command

    docker-compose up -d

You can access the Web UI at: `http://your-domain:6534`

## Docker-compose

Here are some example snippets to help you get started creating a container.

    version: "3.3"
    services:

        nginx:
            image: elestio4test/bigcapital-nginx:latest
            restart: always
            volumes:
                - ./storage/data/logs/nginx/:/var/log/nginx
            ports:
                - "172.17.0.1:6534:80"
            tty: true
            depends_on:
                - server
                - webapp

        webapp:
            image: elestio4test/bigcapital-webapp:latest
            restart: always

        server:
            image: elestio4test/bigcapital-server:latest
            restart: always
            links:
                - mariadb
                - mongo
                - redis
            depends_on:
                - mariadb
                - mongo
                - redis
            environment:
                # Mail
                - MAIL_HOST=${MAIL_HOST}
                - MAIL_USERNAME=${MAIL_USERNAME}
                - MAIL_PASSWORD=${MAIL_PASSWORD}
                - MAIL_PORT=${MAIL_PORT}
                - MAIL_SECURE=${MAIL_SECURE}
                - MAIL_FROM_NAME=${FROM_EMAIL}
                - MAIL_FROM_ADDRESS=${FROM_EMAIL}

                # Database
                - DB_HOST=mariadb
                - DB_USER=${DB_USER}
                - DB_PASSWORD=${DB_PASSWORD}
                - DB_CHARSET=${DB_CHARSET}

                # System database
                - SYSTEM_DB_NAME=${SYSTEM_DB_NAME}

                # Tenants databases
                - TENANT_DB_NAME_PERFIX=${TENANT_DB_NAME_PERFIX}

                # Authentication
                - JWT_SECRET=${JWT_SECRET}

                # MongoDB
                - MONGODB_DATABASE_URL=mongodb://mongo/bigcapital

                # Application
                - BASE_URL=${BASE_URL}

                # Agendash
                - AGENDASH_AUTH_USER=${AGENDASH_AUTH_USER}
                - AGENDASH_AUTH_PASSWORD=${AGENDASH_AUTH_PASSWORD}

                # Sign-up restrictions
                - SIGNUP_DISABLED=${SIGNUP_DISABLED}
                - SIGNUP_ALLOWED_DOMAINS=${SIGNUP_ALLOWED_DOMAINS}
                - SIGNUP_ALLOWED_EMAILS=${SIGNUP_ALLOWED_EMAILS}

        database_migration:
            image: elestio4test/bigcapital-migration:latest
            restart: always
            environment:
                # Database
                - DB_HOST=mariadb
                - DB_USER=${DB_USER}
                - DB_PASSWORD=${DB_PASSWORD}
                - DB_CHARSET=${DB_CHARSET}
                - SYSTEM_DB_NAME=${SYSTEM_DB_NAME}
            # Tenants databases
                - TENANT_DB_NAME_PERFIX=${TENANT_DB_NAME_PERFIX}
            depends_on:
                - mariadb

        mariadb:
            image: elestio4test/bigcapital-mariadb:latest
            restart: always
            environment:
                - MARIADB_DATABASE=${SYSTEM_DB_NAME}
                - MARIADB_USER=${DB_USER}
                - MARIADB_PASSWORD=${DB_PASSWORD}
                - MARIADB_ROOT_PASSWORD=${DB_ROOT_PASSWORD}
            volumes:
                - ./storage/mariadb:/var/lib/mariadb
            expose:
                - "3306"

        mongo:
            image: elestio4test/bigcapital-mongo:latest
            restart: always
            expose:
                - "27017"
            volumes:
                - ./storage/mongo:/var/lib/mongodb

        redis:
            image: elestio4test/bigcapital-redis:latest
            restart: always
            expose:
                - "6379"
            volumes:
                - ./storage/redis:/data

### Environment variables

|        Variable        |                Value (example)                |
| :--------------------: | :-------------------------------------------: |
|      ADMIN_EMAIL       |                admin@email.com                |
|     ADMIN_PASSWORD     |                 your-password                 |
|         DOMAIN         |     bigcapitalfsgsfgs-u353.vm.elestio.app     |
|       MAIL_HOST        |                  172.17.0.1                   |
|       MAIL_PORT        |                      25                       |
|       FROM_EMAIL       |                from@email.com                 |
|        DB_USER         |                     root                      |
|      DB_PASSWORD       |                 your-password                 |
|       DB_CHARSET       |                     utf8                      |
|     SYSTEM_DB_NAME     |               bigcapital_system               |
| TENANT_DB_NAME_PERFIX  |              bigcapital_tenant\_              |
|       JWT_SECRET       |         your-very-very-long-password          |
|        BASE_URL        | https://bigcapitalfsgsfgs-u353.vm.elestio.app |
|   AGENDASH_AUTH_USER   |                   agendash                    |
| AGENDASH_AUTH_PASSWORD |                    123123                     |
|    SIGNUP_DISABLED     |                     false                     |
|    DB_ROOT_PASSWORD    |                 your-password                 |

# Maintenance

## Logging

The Elestio Bigcapital Docker image sends the container logs to stdout. To view the logs, you can use the following command:

    docker-compose logs -f

To stop the stack you can use the following command:

    docker-compose down

## Backup and Restore with Docker Compose

To make backup and restore operations easier, we are using folder volume mounts. You can simply stop your stack with docker-compose down, then backup all the files and subfolders in the folder near the docker-compose.yml file.

Creating a ZIP Archive
For example, if you want to create a ZIP archive, navigate to the folder where you have your docker-compose.yml file and use this command:

    zip -r myarchive.zip .

Restoring from ZIP Archive
To restore from a ZIP archive, unzip the archive into the original folder using the following command:

    unzip myarchive.zip -d /path/to/original/folder

Starting Your Stack
Once your backup is complete, you can start your stack again with the following command:

    docker-compose up -d

That's it! With these simple steps, you can easily backup and restore your data volumes using Docker Compose.

# Links

- <a target="_blank" href="https://github.com/bigcapitalhq/bigcapital">Bigcapital Github repository</a>

- <a target="_blank" href="https://docs.bigcapital.ly/">Bigcapital documentation</a>

- <a target="_blank" href="https://github.com/elestio-examples/bigcapital">Elestio/bigcapitalhq Github repository</a>
