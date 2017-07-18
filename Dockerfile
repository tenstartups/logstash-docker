#
# Extension to the base Logstash docker image with additional input/output plugins.
#
# http://github.com/tenstartups/logstash-docker
#

FROM docker.elastic.co/logstash/logstash:5.5.0

MAINTAINER Marc Lennox <marc.lennox@gmail.com>

# Copy files into place.
COPY entrypoint.sh /docker-entrypoint.sh

# Install additional logstash plugins.
RUN logstash-plugin install logstash-input-journald
