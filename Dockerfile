# DataWeave CLI 2.12.0, pinned. The release ships native images for linux-x64
# and macOS arm64 only, so this companion runs the linux build under Docker
# (linux/amd64) on every host. Build once:
#   docker build --platform linux/amd64 -t dw-cli:2.12.0 .
# Then ./dw.sh <args> runs the CLI with this directory mounted at /lab.

# The base is pinned to a dated Debian snapshot rather than floating on
# `bookworm-slim`, which moves every few weeks. Today they are the same image;
# the point is that they stay the same later, so a reader building this months
# from now gets the layer the book's outputs were produced on. Dated tags are
# immutable — Debian publishes a new one instead of re-pushing this one.
#
# It does not make the build byte-identical. The `apt-get` line below resolves
# against the live bookworm archive, and the engine comes from a GitHub release.
# What is pinned is what decides behaviour: the engine version, and the libc and
# system libraries it runs against.
ARG DEBIAN_VERSION=bookworm-20260824-slim
FROM --platform=linux/amd64 debian:${DEBIAN_VERSION}
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
