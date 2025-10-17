#!/bin/bash
#
# SKRIPT: script.sh
# EESMÄRK: Kontrollib lokaalse veebiserveri (http://localhost/) HTTP
#          staatuskoodi.
# Kasutab standardseid "kuldstandard" meetodeid ainult koodi eraldamiseks.
# AUTOR: Donat Kauler
# KUUPÄEV: 2025-10-17
# ASUTUS/ORGANISATSIOON: Skriptimise Tund
#
# SELGITUS:
# 1. Loob unikaalse logifaili nimega, mis sisaldab kuupäeva ja kellaaega
# 2. Teostab HTTP päringu aadressile http://localhost/ kasutades curl
# 3. Eraldab HTTP staatuskoodi (-w "%{http_code}")
# 4. Kui staatuskood on 200, väljastab "TEST OK", muul juhul "TEST VIGA"
# 5. Logib tulemuse logifaili koos ajatempliga
№

LOGFILE="webtest_$(date +%Y%m%d_%H%M%S).log"

STATUS=$(curl -s -o /dev/null -w "%{http_code}" https://localhost/)

if [ "$STATUS" -eq 200 ]; then
    RESULT="TEST OK"
else
    RESULT="TEST VIGA"
fi

echo "$RESULT"
echo "$(date '+%Y-%m-%d %H:%M:%S') - Status: $STATUS - $RESULT" >> "$LOGFILE"
