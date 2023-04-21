#!/bin/sh

SPACE=$(df "/media/data/downloads" | awk 'END{print $4}')
if [ "$SPACE" -le 10000000 ]
then
  echo "NOT-OK ~ not enough space, free: $SPACE"
  exit 1
fi
echo "OK ~ got space, free: $SPACE"
exit 0