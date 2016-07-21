#!/bin/bash
set -e

# Based on
# <https://github.com/docker-library/logstash/blob/master/docker-entrypoint.sh>
# from the `logstash` base layer, but runs Logstash as root, not the `logstash`
# user, to ensure access to the journal.

set -e

# Add logstash as command if needed
if [[ "$1" == -* ]]; then
  set -- logstash "$@"
fi

exec "$@"

# Add logstash as command if needed
if [ "${1:0:1}" = '-' ]; then
	set -- logstash "$@"
fi

# Run as user "logstash" if the command is "logstash"
# if [ "$1" = 'logstash' ]; then
# 	set -- gosu logstash "$@"
# fi

exec "$@"
