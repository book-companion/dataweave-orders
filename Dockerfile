# DataWeave CLI 2.12.0, pinned. The release ships native images for linux-x64
# and macOS arm64 only, so this companion runs the linux build under Docker
# (linux/amd64) on every host. Build once:
#   docker build --platform linux/amd64 -t dw-cli:2.12.0 .
# Then ./dw.sh <args> runs the CLI with this directory mounted at /lab.
FROM --platform=linux/amd64 debian:bookworm-slim
ARG DW_VERSION=2.12.0
RUN apt-get update && apt-get install -y --no-install-recommends ca-certificates curl unzip \
 && rm -rf /var/lib/apt/lists/*
RUN curl -sSL -o /tmp/dw.zip \
      https://github.com/mulesoft/data-weave-cli/releases/download/v${DW_VERSION}/dw-cli-${DW_VERSION}-linux-x86_64.zip \
 && mkdir -p /opt/dw && unzip -q /tmp/dw.zip -d /opt/dw && rm /tmp/dw.zip \
 && chmod +x /opt/dw/bin/dw
ENV PATH="/opt/dw/bin:${PATH}" WEAVE_HOME=/opt/dw
WORKDIR /lab
ENTRYPOINT ["dw"]
