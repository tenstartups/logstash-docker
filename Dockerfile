#
# Extension to the base Logstash docker image with additional input/output plugins.
#
# http://github.com/tenstartups/logstash-docker
#

FROM logstash:latest

MAINTAINER Marc Lennox <marc.lennox@gmail.com>

# Install additional plugins.
RUN logstash-plugin install logstash-input-journald
