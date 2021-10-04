#!/bin/bash

# Autor: pdrzew
# Skrypt sprawdzający jakość IP w bazie danych ABUSEIPDB po dostarczeniu pliku wyciągniętego z RouterOS

api="{EDITED}"
file=router.txt
ssh {EDITED} ip firewall connection print > $file

# wyodrębniamy IPki z pliku z Routerosa
awk -F: '{ print $2 }' $file | awk -F' ' '{ print $2 }' | sort | uniq > ip.txt
lines=$(cat ip.txt)

# pokaż ilość IP w pliku
echo "IP count:" 
cat ip.txt | wc -l
echo ""

# pętla sprawdzająca IPki
for line in $lines 
    do
	score=$(curl -G https://api.abuseipdb.com/api/v2/check --data-urlencode "ipAddress=$line" -H "Key: $api" -H "Accept: application/json" 2>/dev/null | jq -r '.data.abuseConfidenceScore')
	if [[ $score -ne "0" ]] 
        then
	   echo -e "$score \t : $line"
	fi
    done
