FROM alpine:3.13
LABEL maintainer="Thomas GUIRRIEC <thomas@guirriec.fr>"
ARG REG_VERSION="v0.16.1"
ARG REG_SHA256="ade837fc5224acd8c34732bf54a94f579b47851cc6a7fd5899a98386b782e228"
RUN apk add --no-cache --update --virtual \
      build-dependencies \
        curl \
    && curl -fSL "https://github.com/genuinetools/reg/releases/download/${REG_VERSION}/reg-linux-amd64" -o "/usr/local/bin/reg" \
    && echo "${REG_SHA256}  /usr/local/bin/reg" | sha256sum -c - \
    && chmod a+x "/usr/local/bin/reg" \
    && apk del build-dependencies \
    && rm -rf \
         /root/.cache \
         /tmp/* \
         /var/cache/*
HEALTHCHECK CMD reg --version || exit 1
ENTRYPOINT ["/usr/local/bin/reg"]
