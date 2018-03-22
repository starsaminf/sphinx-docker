FROM debian:9
MAINTAINER Samuel Loza <starsaminf@gmail.com>

RUN echo "==> Updating and installing packages" && \
apt-get update && \
apt-get install -y gcc autoconf bison swig python-dev libpulse-dev git automake libtool bison python-dev swig make pkg-config pulseaudio mpg123 sox
