FROM debian:buster-slim AS miktex

RUN apt-get update \
 && DEBIAN_FRONTEND=noninteractive apt-get install -y \
    apt-transport-https \
    ca-certificates \
    gnupg \
 && rm -rf /var/lib/apt/lists/* \
 && apt-get clean

RUN echo "deb http://miktex.org/download/debian buster universe" > /etc/apt/sources.list.d/miktex.list
RUN apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys D6BC243565B2087BC3F897C9277A7293F59E4889
RUN apt-get update \
 && DEBIAN_FRONTEND=noninteractive apt-get install -y \
    ghostscript \
    make \
    perl \
    miktex \
 && rm -rf /var/lib/apt/lists/* \
 && apt-get clean

RUN miktexsetup finish \
  && initexmf --admin --set-config-value=[MPM]AutoInstall=1 \
  && mpm --admin --update-db \
  && mpm --admin \
         --install amsfonts \
         --install biber-linux-x86_64 \
  && initexmf --admin --update-fndb

ENV MIKTEX_USERCONFIG=/miktex/.miktex/texmfs/config
ENV MIKTEX_USERDATA=/miktex/.miktex/texmfs/data
ENV MIKTEX_USERINSTALL=/miktex/.miktex/texmfs/install
