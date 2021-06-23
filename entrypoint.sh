#!/usr/bin/env sh
set -e

# if user not setup yet, do the initial works
if [ ! -d "/home/n8n/node_modules" ]; then
    echo "Initializing workspace..."
    # UID or GID not provided, exit
    if [ -z "${UID}" ] || [ -z "${GID}" ]; then
        echo "Env var UID or GID not provided..."
        exit 1
    fi

    # create group & user
    echo "Adding user n8n..."
    addgroup -g ${GID} n8n
    adduser -G n8n -D -u ${UID} n8n

    # copy node_modules
    echo "Preparing node_modules..."
    mv /root/node_modules /home/n8n
    chown -R n8n:n8n /home/n8n/node_modules
else
    echo "node_modules found, skip initialization..."
fi

# execute init scripts, if any
if [ -d '/init_scripts' ]; then
    for f in "/init_scripts/*.sh"; do
        echo "Executing "$f
        /usr/bin/env sh $f
    done
fi

# run as user n8n
echo "Running n8n..."
exec su n8n -c "/home/n8n/node_modules/n8n/bin/n8n"