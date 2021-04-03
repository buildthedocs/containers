FROM debian:buster-slim AS doxygen

RUN apt-get update \
 && DEBIAN_FRONTEND=noninteractive apt-get install -y \
    doxygen \
    graphviz \
 && rm -rf /var/lib/apt/lists/* \
 && apt-get clean
