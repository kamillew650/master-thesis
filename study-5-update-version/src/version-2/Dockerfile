FROM alpine

RUN apk add --update coreutils && rm -rf /var/cache/apk/*

COPY script.sh script.sh

CMD ["sh", "script.sh"]

