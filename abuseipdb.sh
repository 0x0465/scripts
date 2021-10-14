#!/bin/bash

#
# Author: pdrzew
#

api="{EDITED}"

# SSH to router, save connections to file
file=router.txt
ssh {EDITED} ip firewall connection print > $file

# Process file router.txt, sort and uniq IPs
awk -F: '{ print $2 }' $file | awk -F' ' '{ print $2 }' | sort | uniq > ip.txt
lines=$(cat ip.txt)

# Show number of unique IPs
echo "IP count:"
wc -l < ip.txt
echo ""

echo -e "Score \t : IP \t \t \t : ISP"
# Loop through IPs
for line in $lines
    do
# Curl to AbuseIPDB, save to file
        json=$(curl -G https://api.abuseipdb.com/api/v2/check --data-urlencode "ipAddress=$line" -H "Key: $api" -H "Accept: application/json" 2>/dev/null)
        echo "$json" > json.txt
# Extract usable fields from file
        score=$(jq -r '.data.abuseConfidenceScore' json.txt)
        isp=$(jq -r '.data.isp' json.txt)
# Loop: If IPs score > 0, print score, IP and ISP name.
        if [[ $score -ne "0" ]]
        then
           echo -e "$score \t : $line \t : $isp"
        fi
    done
