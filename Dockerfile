#
# A minimal logstash image based on alpine linux.
#
# http://github.com/tenstartups/logstash-docker
#

FROM tenstartups/alpine:latest

MAINTAINER Marc Lennox <marc.lennox@gmail.com>

# Set environment variables.
ENV \
  JAVA_HOME=/usr/lib/jvm/default-jvm/jre \
  JRUBY_VERSION=9.0.5.0 \
  JRUBY_SHA256=9ef392bd859690c9a838f6475040345e0c512f7fcc0b37c809a91cf671f5daf3 \
  LOGSTASH_VERSION=2.2.2 \
  LOGSTASH_SHA1=2a485859afe596914dcccc6a0c17a7e1f27ad71c \
  PATH=$PATH:/opt/jruby/bin:/opt/logstash/bin

# Install packages.
RUN \
  echo 'http://dl-4.alpinelinux.org/alpine/edge/community' >> /etc/apk/repositories && \
  apk --update add git openjdk8-jre-base openjdk8-jre-lib && \
  rm -rf /var/cache/apk/*

# Install JRuby.
RUN \
  cd /tmp && \
  wget -O jruby-bin.tar.gz https://s3.amazonaws.com/jruby.org/downloads/${JRUBY_VERSION}/jruby-bin-${JRUBY_VERSION}.tar.gz && \
  echo "${JRUBY_SHA256} jruby-bin.tar.gz" | sha256sum -c - && \
  tar xvzf jruby-bin.tar.gz && \
  cd jruby-* && \
  mkdir -p /opt/jruby && \
  mv * /opt/jruby && \
  cd .. && \
  rm -rf jruby-*

# Install Logstash.
RUN \
  cd /tmp && \
  wget -O logstash.tar.gz https://download.elastic.co/logstash/logstash/logstash-${LOGSTASH_VERSION}.tar.gz && \
  echo "${LOGSTASH_SHA1} logstash.tar.gz" | sha1sum -c - && \
  tar xvzf logstash.tar.gz && \
  cd logstash-* && \
  mkdir -p /opt/logstash && \
  mv * /opt/logstash && \
  cd .. && \
  rm -rf logstash-*

# Copy files into place.
COPY entrypoint.sh /docker-entrypoint

# Set the entrypoint script.
ENTRYPOINT ["/docker-entrypoint"]
