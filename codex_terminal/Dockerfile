ARG BUILD_FROM
FROM $BUILD_FROM

SHELL ["/bin/bash", "-o", "pipefail", "-c"]

RUN \
  apk add --no-cache \
    bash \
    curl \
    git \
    nodejs \
    npm \
    openssh-client \
    ttyd

RUN npm install -g @openai/codex

COPY run.sh /run.sh
COPY start-terminal.sh /start-terminal.sh
RUN chmod 755 /run.sh /start-terminal.sh

CMD ["/run.sh"]
