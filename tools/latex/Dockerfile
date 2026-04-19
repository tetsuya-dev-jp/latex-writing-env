FROM debian:bookworm-slim

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update \
    && apt-get install -y --no-install-recommends \
        ca-certificates \
        fonts-noto-cjk \
        libfile-homedir-perl \
        libyaml-tiny-perl \
        latexmk \
        make \
        perl \
        texlive-base \
        texlive-bibtex-extra \
        texlive-extra-utils \
        texlive-fonts-recommended \
        texlive-lang-japanese \
        texlive-latex-extra \
        texlive-latex-recommended \
        texlive-pictures \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /workspace
