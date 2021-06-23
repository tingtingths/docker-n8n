#!/usr/bin/env sh

if [ -z "$1" ]; then
	echo 'Missing version argument, e.g. build.sh 0.124.0'
    exit 1
fi

echo "Building version ${1}..."
sleep 3
docker build --no-cache -t tingtingths/n8n:$1 --build-arg VERSION=$1 .
