#!/bin/sh
STATUS=$(curl --connect-timeout 10 --retry 15 --retry-max-time 200 -s -o /dev/null -w '%{http_code}' localhost:8282)
RCODE=$?
if [ $RCODE -gt 0 ]; then
  echo "Error: curl error with code ${RCODE}"
  exit 1
elif [ $STATUS -ne 200 ]; then
  echo "pimatic ready ${STATUS}"
  exit 0
else
  exit 1
fi
