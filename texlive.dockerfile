FROM debian:bookworm-slim AS latex

RUN apt-get update -y && apt-get -y install \
      make \
      python3-pip \
      python3-venv \
      texlive-full \
      texlive-fonts-recommended \
      texlive-latex-extra-doc

WORKDIR /src

ENV VIRTUAL_ENV=/opt/venv
RUN python3 -m venv $VIRTUAL_ENV
ENV PATH="$VIRTUAL_ENV/bin:$PATH"

RUN pip3 install wheel setuptools

#---

FROM latex AS latexdiff

RUN apt-get update -y && apt-get -y install \
      git \
 && git clone https://gitlab.com/git-latexdiff/git-latexdiff \
 && cd git-latexdiff \
 && make install-bin \
 && cd .. \
 && rm -rf git-latexdiff

#---

FROM latex AS texstudio

RUN apt-get update -y && apt-get -y install \
      texstudio

#---

FROM latex AS pandoc

RUN apt-get update -y && apt-get -y install \
      pandoc \
      libghc-citeproc-dev
