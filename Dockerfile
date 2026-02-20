FROM alpine:latest AS builder

RUN apk add --no-cache \
    curl \
    git \
    libc6-compat \
    gcompat \
    libstdc++ \
    libgcc

ARG HUGO_VERSION=0.156.0

RUN ARCH=$(uname -m) && \
    if [ "$ARCH" = "x86_64" ]; then HUGO_ARCH="linux-amd64"; \
    elif [ "$ARCH" = "aarch64" ]; then HUGO_ARCH="linux-arm64"; \
    else HUGO_ARCH="linux-amd64"; fi && \
    curl -L "https://github.com/gohugoio/hugo/releases/download/v${HUGO_VERSION}/hugo_extended_${HUGO_VERSION}_${HUGO_ARCH}.tar.gz" | tar -xz -C /usr/local/bin

WORKDIR /src
EXPOSE 1313

CMD ["hugo", "server", "--bind", "0.0.0.0", "--buildDrafts"]