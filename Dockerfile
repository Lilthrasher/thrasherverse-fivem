# Use Ubuntu as the base image
FROM ubuntu:24.04

# Prevent interactive prompts during package installs
ENV DEBIAN_FRONTEND=noninteractive

# Install dependencies
RUN apt-get update && apt-get install -y \
    git \
    curl \
    xz-utils \
    && apt-get clean

# Create fxserver directory
RUN mkdir -p /opt/fxserver
WORKDIR /opt/fxserver

# Copy entrypoint script
COPY entrypoint.sh /opt/fxserver/entrypoint.sh
RUN chmod +x /opt/fxserver/entrypoint.sh

# Download FX_BUILD version of fxserver
ARG FX_BUILD
RUN curl -Lo fx.tar.xz \
    https://runtime.fivem.net/artifacts/fivem/build_proot_linux/master/${FX_BUILD}/fx.tar.xz && \
    tar -xf fx.tar.xz && rm fx.tar.xz

# Download the latest fxserver build
# RUN curl -s https://runtime.fivem.net/artifacts/fivem/build_proot_linux/master/ \
#   | grep -Eo '[0-9]+-[a-f0-9]{40}' \
#   | sort -n \
#   | tail -n 1 \
#   | xargs -I{} curl -Lo fx.tar.xz https://runtime.fivem.net/artifacts/fivem/build_proot_linux/master/{}/fx.tar.xz \
#   && tar -xf fx.tar.xz && rm fx.tar.xz

# Ensure server data volume
VOLUME /opt/fxserver/txData

# Expose fxserver ports
EXPOSE 30120/tcp 30120/udp
EXPOSE 40120/tcp

# Entrypoint
ENTRYPOINT ["/opt/fxserver/entrypoint.sh"]