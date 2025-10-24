#!/bin/bash

TIMESTAMP=$(date +%Y-%m-%d_%H_%M_%S)
LOG_FILE="ngx_logreport_${TIMESTAMP}.log"

echo "NGINXI LOGIDE ANALÜÜS - $(date)" > $LOG_FILE
echo "=================================" >> $LOG_FILE

echo "" >> $LOG_FILE
echo "--- AKTIIVSED NGINXI PROTSESSID ---" >> $LOG_FILE
ps aux | grep nginx | grep -v grep >> $LOG_FILE

echo "" >> $LOG_FILE
echo "--- LEITUD 404 VEAD (access.log) ---" >> $LOG_FILE
if [ -f "/var/log/nginx/access.log" ]; then
    sudo cat /var/log/nginx/access.log | grep " 404 " >> $LOG_FILE 2>/dev/null || echo "404 vigu ei leitud või puudub ligipääs" >> $LOG_FILE
else
    echo "access.log faili ei leitud" >> $LOG_FILE
fi

echo "" >> $LOG_FILE
echo "--- 404 VIGADE KOGUARV ---" >> $LOG_FILE
if [ -f "/var/log/nginx/access.log" ]; then
    COUNT=$(sudo cat /var/log/nginx/access.log | grep " 404 " | wc -l)
    echo "404 vigade arv: $COUNT" >> $LOG_FILE
else
    echo "access.log faili ei leitud" >> $LOG_FILE
fi

echo "" >> $LOG_FILE
echo "--- KRIITILISED VEAD (error.log) ---" >> $LOG_FILE
if [ -f "/var/log/nginx/error.log" ]; then
    sudo cat /var/log/nginx/error.log | grep "crit" >> $LOG_FILE 2>/dev/null || echo "Kriitilisi vigu ei leitud" >> $LOG_FILE
else
    echo "error.log faili ei leitud" >> $LOG_FILE
fi

echo "" >> $LOG_FILE
echo "--- ANALÜÜSI LÕPP ---" >> $LOG_FILE
echo "Aruanne loodud: $(date)" >> $LOG_FILE

echo "Nginxi logianalüüs on salvestatud faili: $LOG_FILE"

echo "Aruande sisu:"
cat $LOG_FILE
