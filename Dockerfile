FROM pahud/awscli:with-bash

COPY entrypoint.sh /entrypoint.sh

RUN apk update && \
    apk upgrade && \
    apk add --no-cache \
    jq

ENTRYPOINT ["/entrypoint.sh"]
