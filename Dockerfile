# One image, holding the two things this companion runs on: the DataWeave engine
# the book's outputs were produced by, and the Node that serves the Runner.
#
#   make image     # builds it
#   ./dw.sh <args> # the engine, with this directory mounted at /lab
#   make runner    # the Runner, at http://127.0.0.1:4444
#
# Both are installed the same way and for the same reason: a pinned release
# tarball, unpacked into /opt, put on PATH. Starting instead from an official
# `node:` base would leave Node arriving invisibly — nothing in the file would
# say which version was in the image, or that one was there at all.
#
# The engine ships native images for linux-x64, macOS arm64 and Windows x64
# only, so this runs the linux build under Docker (linux/amd64) on every host.
# There is no Intel Mac build and no Linux arm64 build; the binaries do not
# exist, so the platform is constant rather than inherited.
#
# The base is pinned to a dated Debian snapshot rather than floating on
# `bookworm-slim`, which moves every few weeks. Dated tags are immutable —
# Debian publishes a new one instead of re-pushing this one — so a reader
# building months from now gets the layer the book's outputs were produced on.
# It does not make the build byte-identical: `apt-get` still resolves against
# the live archive. What is pinned is what decides behaviour — the engine, and
# the libc and system libraries it runs against.
ARG DEBIAN_VERSION=bookworm-20260824-slim
FROM --platform=linux/amd64 debian:${DEBIAN_VERSION}

ARG DW_VERSION=2.12.0
ARG NODE_VERSION=22.23.2

RUN apt-get update \
 && apt-get install -y --no-install-recommends ca-certificates curl unzip xz-utils \
 && rm -rf /var/lib/apt/lists/*

# The engine. GitHub publishes no checksum for these assets, so this is the one
# download trusted to HTTPS alone.
RUN curl -sSL -o /tmp/dw.zip \
      https://github.com/mulesoft/data-weave-cli/releases/download/v${DW_VERSION}/dw-cli-${DW_VERSION}-linux-x86_64.zip \
 && mkdir -p /opt/dw && unzip -q /tmp/dw.zip -d /opt/dw && rm /tmp/dw.zip \
 && chmod +x /opt/dw/bin/dw

# Node, checked against the published SHASUMS256. npm, corepack, the headers and
# the docs are deleted afterwards: the server imports only `node:` builtins and
# the browser bundle is committed, so nothing in this image installs a package.
RUN cd /tmp \
 && curl -sSL -O https://nodejs.org/dist/v${NODE_VERSION}/node-v${NODE_VERSION}-linux-x64.tar.xz \
 && curl -sSL https://nodejs.org/dist/v${NODE_VERSION}/SHASUMS256.txt \
      | grep " node-v${NODE_VERSION}-linux-x64.tar.xz\$" | sha256sum -c - \
 && tar -xJf node-v${NODE_VERSION}-linux-x64.tar.xz -C /opt \
 && rm node-v${NODE_VERSION}-linux-x64.tar.xz \
 && mv /opt/node-v${NODE_VERSION}-linux-x64 /opt/node \
 && rm -rf /opt/node/lib/node_modules /opt/node/bin/npm /opt/node/bin/npx \
           /opt/node/bin/corepack /opt/node/include /opt/node/share

# DW_BIN tells the server to call the engine directly instead of shelling out to
# docker; DW_REPO says where the book's chapters are mounted. Both are read only
# by the server, and are inert when the image runs as the CLI.
ENV PATH="/opt/dw/bin:/opt/node/bin:${PATH}" \
    WEAVE_HOME=/opt/dw \
    DW_BIN=/opt/dw/bin/dw \
    DW_REPO=/lab \
    HOST=0.0.0.0

COPY playground /app/playground
WORKDIR /app
EXPOSE 4444

# The engine is the default, so `./dw.sh` and the host-path Runner reach it with
# no override. `make runner` overrides the entrypoint to start the server.
#
# What changes when it does. On the host path every run is its own container —
# no network, the repository read-only, capabilities dropped, memory and process
# limits, thrown away afterwards. Served from inside, the server is long-lived
# and each run is a subprocess beside it, so those per-run limits become this
# one container's. The guard doing the real work is unchanged: the engine is
# still given `--untrusted`, so a script reads the inputs bound to it and
# nothing else, and the repository is still mounted read-only.
ENTRYPOINT ["dw"]
