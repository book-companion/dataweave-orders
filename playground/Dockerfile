# The Runner as one image: the pinned engine and the server that drives it.
#
# The other Dockerfile builds the engine alone, for `./dw.sh` and for a Runner
# started on the host with Node. This one exists so a reader needs nothing but
# Docker:
#
#   make runner        # builds this, then serves http://127.0.0.1:4444
#
# What changes by moving the server inside. On the host, every run is its own
# container — no network, the repository read-only, capabilities dropped, memory
# and process limits, thrown away afterwards. Here the server is long-lived and
# each run is a subprocess beside it, so those per-run limits become the limits
# of this one container. The guard that matters is unchanged: the engine is
# still given `--untrusted`, so a script reads the inputs bound to it and
# nothing else. And the repository is still mounted read-only.
FROM --platform=linux/amd64 node:22-bookworm-slim

ARG DW_VERSION=2.12.0

RUN apt-get update \
 && apt-get install -y --no-install-recommends ca-certificates curl unzip \
 && rm -rf /var/lib/apt/lists/*

RUN curl -sSL -o /tmp/dw.zip \
      https://github.com/mulesoft/data-weave-cli/releases/download/v${DW_VERSION}/dw-cli-${DW_VERSION}-linux-x86_64.zip \
 && mkdir -p /opt/dw && unzip -q /tmp/dw.zip -d /opt/dw && rm /tmp/dw.zip \
 && chmod +x /opt/dw/bin/dw

# DW_BIN tells the server to call the engine directly instead of shelling out to
# docker; DW_REPO tells it where the book's chapters are mounted.
ENV PATH="/opt/dw/bin:${PATH}" \
    WEAVE_HOME=/opt/dw \
    DW_BIN=/opt/dw/bin/dw \
    DW_REPO=/lab \
    HOST=0.0.0.0

COPY playground /app/playground
WORKDIR /app

EXPOSE 4444
CMD ["node", "playground/start.mjs"]
