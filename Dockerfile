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

# Create fivem directory
RUN mkdir -p /opt/fivem
WORKDIR /opt/fivem

# Copy entrypoint script
COPY entrypoint.sh /opt/fivem/entrypoint.sh
RUN chmod +x /opt/fivem/entrypoint.sh

# Download the latest fxserver build
RUN curl -s https://runtime.fivem.net/artifacts/fivem/build_proot_linux/master/ \
  | grep -Eo '[0-9]+-[a-f0-9]{40}' \
  | sort -n \
  | tail -n 1 \
  | xargs -I{} curl -Lo fx.tar.xz https://runtime.fivem.net/artifacts/fivem/build_proot_linux/master/{}/fx.tar.xz \
  && tar -xf fx.tar.xz && rm fx.tar.xz

# Ensure server data volume
VOLUME /opt/fivem/txData

# Expose FiveM ports
EXPOSE 30120/tcp 30120/udp
EXPOSE 40120/tcp

# Entrypoint
ENTRYPOINT ["/opt/fivem/entrypoint.sh"]
