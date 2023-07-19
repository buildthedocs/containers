FROM python:3.11-alpine AS sphinx_min
COPY sphinx_ctx/min.txt /tmp/
RUN apk --no-cache -U upgrade && apk --no-cache add curl git make \
  && pip install -r /tmp/min.txt
WORKDIR /src

#---

FROM sphinx_min AS sphinx_base
COPY sphinx_ctx/base.txt /tmp/
RUN pip install -r /tmp/base.txt

#---

FROM sphinx_base AS sphinx_featured
COPY sphinx_ctx/featured.txt /tmp/
RUN apk add -U --no-cache \
      gcc \
      jpeg-dev \
      libffi-dev \
      libxml2-dev \
      libxslt-dev \
      linux-headers \
      musl-dev \
      zlib-dev
RUN pip install -r /tmp/featured.txt

#---

FROM sphinx_featured AS sphinx_pytooling
RUN apk add -U --no-cache graphviz

#---

FROM sphinx_featured AS sphinx_wavedrom
RUN apk add -U --no-cache \
      cairo \
      cairo-dev \
      g++ \
      libxcb-dev \
      npm \
      pango-dev \
      pixman-dev
RUN npm i -g wavedrom-cli
RUN pip install sphinxcontrib-wavedrom
