FROM asciidoctor/docker-asciidoctor AS asciidoctor

RUN apk add -U --no-cache --virtual .tmpdeps \
    g++ \
    cairo-dev \
    giflib-dev \
    libjpeg-turbo-dev \
    pango-dev \
    pixman-dev \
    nodejs \
    npm \
  && npm install -g bytefield-svg \
  && npm install -g wavedrom-cli --unsafe
