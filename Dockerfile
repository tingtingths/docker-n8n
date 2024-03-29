ARG VERSION

FROM node:16-alpine as builder
ARG VERSION

WORKDIR /root
RUN apk add --update-cache make g++ python3 \
    && ln -sf python3 /usr/bin/python \
    && npm install full-icu n8n@${VERSION}

FROM node:16-alpine

RUN apk add --no-cache tzdata ca-certificates \
    && deluser --remove-home node

# copy installed node_modules
COPY --from=builder /root/node_modules /root/node_modules
COPY entrypoint.sh /

ENV NODE_ICU_DATA /home/n8n/node_modules/full-icu
ENV NODE_ENV production

# default UID/GID
ENV UID=1000
ENV GID=1000

EXPOSE 5678
ENTRYPOINT ["/entrypoint.sh"]