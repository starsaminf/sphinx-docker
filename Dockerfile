FROM ubuntu:14.04
MAINTAINER Samuel Loza <starsaminf@gmail.com>,Alison Parisaca <parisacaalison@gmail.com>

RUN echo "en_US.UTF-8 UTF-8" > /etc/locale.gen && \
  locale-gen
ENV LANGUAGE en_US.UTF-8
ENV LANG en_US.UTF-8
ENV LC_ALL en_US.UTF-8

apt-get update && \
apt-get install -y gcc autoconf bison swig python-dev libpulse-dev automake libtool bison python-dev swig make pkg-config pulseaudio mpg123 sox gawk g++ nano


RUN echo "Set environment variables" && \
echo  "/usr/local/lib" >> /etc/ld.so.conf && \
echo  "export PKG_CONFIG_PATH=/usr/local/lib/pkgconfig" >> /etc/profile.d/sphinx.sh && \
echo  "export PATH=/usr/local/bin:$PATH " >> /etc/profile.d/sphinx.sh && \
echo  "export LD_LIBRARY_PATH=/usr/local/lib " >> /etc/profile.d/sphinx.sh && \
chmod +x /etc/profile.d/sphinx.sh

ENV PATH=/usr/local/bin:$PATH
ENV LD_LIBRARY_PATH=/usr/local/lib
ENV PKG_CONFIG_PATH=/usr/local/lib/pkgconfig

RUN mkdir /data
ADD installers/cmusphinx-code.tar.gz /data
ADD installers/pocketsphinx-5prealpha.tar.gz /data
ADD installer/sphinxbase-5prealpha.tar.gz /data
ADD installers/sphinxtrain-5prealpha.tar.gz /data

RUN cd /data/
RUN tar -xzvf cmusphinx-code.tar.gz
RUN tar -xzvf pocketsphinx-5prealpha.tar.gz
RUN tar -xzvf sphinxbase-5prealpha.tar.gz
RUN tar -xzvf sphinxtrain-5prealpha.tar.gz

#Install sphinx 

RUN cd /data/sphinxbase-5prealpha && ./autogen.sh && make && make install
RUN cd /data/pocketsphinx-5prealpha && ./autogen.sh && make && make install
RUN cd /data/sphinxtrain-5prealpha && ./autogen.sh && make && make install
RUN cd /data/cmusphinx-code/cmuclmtk/ && ./autogen.sh && make && make install