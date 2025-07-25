# Use Ubuntu as the base image
FROM ubuntu:24.04

# Prevent interactive prompts during package installs
ENV DEBIAN_FRONTEND=noninteractive

# Install dependencies
RUN apt-get update && apt-get install -y \
    xz-utils \
    && apt-get clean

# Create user and directories
RUN useradd -m fivem
WORKDIR /home/fivem

# Download and extract latest FiveM Linux server artifact
# You can change this to a fixed version if needed
RUN mkdir -p /home/fivem/server
WORKDIR /home/fivem/server

# Replace with specific artifact version or automate if you want
ENV FX_VERSION=17000
RUN curl -Lo fx.tar.xz https://runtime.fivem.net/artifacts/fivem/build_proot_linux/master/${FX_VERSION}/fx.tar.xz \
    && tar -xf fx.tar.xz \
    && rm fx.tar.xz
    
# Copy entrypoint script
COPY entrypoint.sh /home/fivem/entrypoint.sh
RUN chmod +x /home/fivem/entrypoint.sh

# Ensure server data volume
VOLUME /home/fivem/server-data
WORKDIR /home/fivem/server-data
RUN git clone https://github.com/citizenfx/cfx-server-data.git

# Use non-root user
USER fivem

# Expose FiveM ports
EXPOSE 30120/tcp 30120/udp
EXPOSE 40120/tcp

# Entrypoint
ENTRYPOINT ["/home/fivem/entrypoint.sh"]
