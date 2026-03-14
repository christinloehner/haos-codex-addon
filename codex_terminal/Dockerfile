ARG BUILD_FROM
FROM $BUILD_FROM

SHELL ["/bin/bash", "-o", "pipefail", "-c"]

RUN \
  apk add --no-cache \
    bash \
    coreutils \
    curl \
    diffutils \
    fd \
    findutils \
    git \
    jq \
    less \
    make \
    nodejs \
    npm \
    openssh-client \
    patch \
    py3-pip \
    python3 \
    procps \
    ripgrep \
    sqlite \
    tree \
    ttyd \
    unzip \
    util-linux \
    yq

RUN npm install -g @openai/codex

COPY run.sh /run.sh
COPY start-terminal.sh /start-terminal.sh
RUN chmod 755 /run.sh /start-terminal.sh

CMD ["/run.sh"]
