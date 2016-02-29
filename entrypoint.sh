#!/bin/bash
set -e

# Add logstash as command if needed
if [[ "$1" == -* ]]; then
  set -- logstash "$@"
fi

exec "$@"
