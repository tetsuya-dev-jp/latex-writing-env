FROM paperist/texlive-ja:debian

ARG DEBIAN_FRONTEND=noninteractive

RUN apt-get update \
    && apt-get install -y --no-install-recommends \
        ca-certificates \
        fonts-noto-cjk \
        libfile-homedir-perl \
        libyaml-tiny-perl \
        nodejs \
        npm \
    && rm -rf /var/lib/apt/lists/* \
    && tlmgr install latexindent

COPY config/package.json /opt/textlint/package.json
RUN cd /opt/textlint \
    && npm install --omit=optional --no-fund --no-audit

WORKDIR /workspace
