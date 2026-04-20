FROM debian:bookworm-slim

ENV DEBIAN_FRONTEND=noninteractive

COPY package.json /opt/textlint/package.json

RUN apt-get update \
    && apt-get install -y --no-install-recommends \
        ca-certificates \
        fonts-noto-cjk \
        libfile-homedir-perl \
        libyaml-tiny-perl \
        latexmk \
        make \
        nodejs \
        npm \
        perl \
        texlive-base \
        texlive-bibtex-extra \
        texlive-extra-utils \
        texlive-fonts-recommended \
        texlive-lang-japanese \
        texlive-latex-extra \
        texlive-latex-recommended \
        texlive-pictures \
    && cd /opt/textlint \
    && npm install --omit=optional --no-fund --no-audit \
    && kanji-config-updmap-sys --jis2004 haranoaji \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /workspace
