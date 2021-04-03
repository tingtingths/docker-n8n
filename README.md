# n8n - Docker images

Alternative n8n docker images with better uid/gid configuration and slimmer image.

## Build
`sh
docker build --build-arg VERSION=<version> -t n8n:<version>
`

## RUN
`sh
docker run -td \
    -e UID=<preferred_uid> \
    -e GID=<preferred_gid> \
    -v <data_directory>:/home/n8n/.n8n \
    n8n:<version>
`
