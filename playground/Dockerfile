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

# Node comes from the base image — that is the whole of it, there is nothing to
# download. The version is pinned rather than floating on `node:22`, so a rebuild
# gets the same runtime: this book pins what it runs on, and the server that
# serves the Runner should not be the one exception. It does not touch a result
# — DataWeave output comes from the engine below — but `start.mjs` chooses its
# flags from the running version, and that choice should not move on its own.
ARG NODE_VERSION=22.23.2
FROM --platform=linux/amd64 node:${NODE_VERSION}-bookworm-slim

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
