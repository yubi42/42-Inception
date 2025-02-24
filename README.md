# Inception

## Introduction
Inception is a **42 School project** that focuses on **containerization** using **Docker and Docker Compose**. The goal is to set up a fully functional multi-container environment, including an NGINX web server, a WordPress website, and a MariaDB database, all running within Docker containers.

## Features
- Uses **Docker Compose** to orchestrate multiple services
- **NGINX** as a reverse proxy with **TLSv1.2 or TLSv1.3** encryption
- **WordPress** running on **php-fpm** with a MariaDB backend
- **MariaDB** for database management
- Custom **Dockerfiles** for each service
- Persistent storage using **volumes**
- Secure credentials management with **environment variables**

## Installation

### Prerequisites
- **Docker** (latest version)
- **Docker Compose**

## Configure Hosts File

Before accessing the site, update your /etc/hosts file to map jborner.42.fr to localhost:

```echo "127.0.0.1 jborner.42.fr" | sudo tee -a /etc/hosts```


### Setup
```sh
# Clone the repository
git clone https://github.com/yubi42/inception.git
cd inception

# Build and start the containers
make run

# Stop containers
make down

# Cleanup
make fclean
```

## Services
| Service   | Description |
|-----------|------------|
| **NGINX** | Serves as a reverse proxy and handles TLS encryption |
| **WordPress** | Runs the WordPress site using php-fpm |
| **MariaDB** | Stores the WordPress database |

## Project Structure
```
📂 inception
├── 📂 secrets
├── 📂 srcs
│   ├── 📂 requirements
│   │   ├── 📂 nginx
│   │   ├── 📂 wordpress
│   │   ├── 📂 mariadb
│   ├── 📄 docker-compose.yml
│   ├── 📄 .env
├── 📄 Makefile
```

## Usage
Once the containers are running, visit:
```sh
https://jborner.42.fr
```
Login to WordPress admin:
```sh
https://jborner.42.fr/wp-admin
```

## Contributors
- [yubi42](https://github.com/yubi42)



