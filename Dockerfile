#
# Logstash with additional plugins.
#
# http://github.com/tenstartups/logstash-docker
#

FROM logstash:latest

MAINTAINER Marc Lennox <marc.lennox@gmail.com>

# Set environment variables.
ENV \
  JOURNALD_SINCEDB_DIR=/var/lib/logstash-journald \
  PATH=$PATH:/opt/logstash/vendor/jruby/bin

# Install required packages
RUN \
  apt-get update && apt-get -y install git-core

# Install ruby gems.
RUN \
  cd /tmp && \
  git clone https://github.com/tenstartups/logstash-journald-input.git && \
  cd logstash-journald-input && \
  git reset --hard master && \
  jgem build logstash-journald-input.gemspec && \
  /opt/logstash/bin/plugin install logstash-journald-input-*.gem && \
  cd .. && \
  rm -rf logstash-journald-input

# Create a volume for storing state, set it as a default for the journald plugin
# to store the cursor.
VOLUME ${JOURNALD_SINCEDB_DIR}

COPY entrypoint.sh /docker-entrypoint.sh
