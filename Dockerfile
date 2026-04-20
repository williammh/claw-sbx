FROM debian:stable-slim

ENV NVM_DIR="/usr/local/nvm"
ENV NODE_VERSION="24.14.0"

RUN apt-get update && apt-get install -y --no-install-recommends \
    curl \
    ca-certificates \
    git \
    && rm -rf /var/lib/apt/lists/*


# Specify UID 1001 to match your VPS user exactly
RUN groupadd -g 1001 claw && useradd -u 1001 -g claw -m -s /bin/bash claw
# Create NVM directory, install NVM, and make accessible to 'claw'
RUN mkdir -p $NVM_DIR && chown claw:claw $NVM_DIR

USER claw

RUN curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.4/install.sh | NVM_DIR=$NVM_DIR bash

# Install Node.js using NVM    
RUN . $NVM_DIR/nvm.sh \
    && nvm install $NODE_VERSION \
    && nvm alias default $NODE_VERSION \
    && nvm use default

# Set the PATH to point to user's NVM directory
ENV PATH="$NVM_DIR/versions/node/v${NODE_VERSION}/bin:${PATH}"

RUN npm i -g openclaw@latest

# Pre-create the directory so it's ready to receive the volume mount
RUN mkdir -p /home/claw/.openclaw

WORKDIR /home/claw

CMD ["/bin/bash"]
