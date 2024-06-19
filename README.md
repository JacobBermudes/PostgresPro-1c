# PostgreSQL Pro 15 Docker Image for 1C
This repository provides a Dockerfile to build a PostgresPro 15 image optimized for full compatibility with 1C Enterprise, featuring automatic hardware configuration.

## Features
- PostgresPro 15: Latest version compatible with the largest amount of 1C:Enterprise server.
- 1C Compatibility: Pre-configured for seamless integration with 1C (Patches from 1C:Enterprise).
- Auto-Configuration: Automatically adjusts settings based on the host hardware for optimal performance including customization features for 1C:Enterprise.
- The program is included in the register of domestic software in Russian Federation. Project is open so using everywhere is legal.
## Prerequisites
- Docker installed on your system.
- Free space for directory for storing PostgresPro 15 databases. Recommended to use a different drive for Docker volume.
## Usage

### Option A. Locally build the Docker Image  
Clone this repository and navigate to the directory:
```bash
git clone https://github.com/yourusername/postgrespro-1c-docker.git
cd postgrespro-1c-docker
```
  Build the Docker image:
```bash
  docker build -t postgrespro-1c:15 
```

### Option B. Docker Hub Repository
This image is also available on Docker Hub: jacobbermudes/postgrespro-1c.
To pull the image from Docker Hub, use the following command:
```bash
docker pull jacobbermudes/postgrespro-1c:15
```

### Run the Container
  Run the container `for option 'A'` with the following command:
```bash
docker run -d \
  -e PG_PASSWORD=mypassword \
  -v /mnt/volume/for/pg_Database:/var/lib/postgresql/data \
  -p 5432:5432 \
  postgrespro-1c:15
```
  Run the container `for option 'B'` with the following command:
```bash
docker run -d \
  -e PG_PASSWORD=mypassword \
  -v /mnt/volume/for/pg_Database:/var/lib/postgresql/data \
  -p 5432:5432 \
  jacobbermudes/postgrespro-1c:15
```

## Environment Variables
- PG_PASSWORD: Password for the PostgreSQL user. Required to fill or default password is `JacobBermudes`. Changing username is unavailable so default username is `postgres`

## Contributions
Contributions are welcome! Please open an issue or submit a pull request.

## Contact
For any questions, please open an issue in this repository.


