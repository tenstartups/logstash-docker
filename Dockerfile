#
# Extension to the base Logstash docker image with additional input/output plugins.
#
# http://github.com/tenstartups/logstash-docker
#

FROM logstash:latest

MAINTAINER Marc Lennox <marc.lennox@gmail.com>

# Install required operating system packages.
RUN apt-get update && apt-get -y install libsystemd-dev

# Copy files into place.
COPY entrypoint.sh /docker-entrypoint.sh

# Install additional logstash plugins.
RUN logstash-plugin install logstash-input-journald
