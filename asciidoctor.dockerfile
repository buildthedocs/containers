FROM asciidoctor/docker-asciidoctor AS asciidoctor

RUN ln -s /usr/bin/python3 /usr/bin/python \
 && apk add -U --no-cache --virtual .tmpdeps \
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
