#!/bin/bash

LOGFILE="webtest_$(date +%Y%m%d_%H%M%S).log"

STATUS=$(curl -s -o /dev/null -w "%{http_code}" https://localhost/)

if [ "$STATUS" -eq 200 ]; then
    RESULT="TEST OK"
else
    RESULT="TEST VIGA"
fi

echo "$RESULT"
echo "$(date '+%Y-%m-%d %H:%M:%S') - Status: $STATUS - $RESULT" >> "$LOGFILE"
