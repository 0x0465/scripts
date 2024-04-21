#!/bin/bash

#
# Check IPs "IP / Firewall / Connections" in AbuseIpDB
# by pdr
# @0x2e8b
api={EDITED}
# Put list of IPs in the ip.txt file, file should be in the same folder as script. Every IP in new line. 
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
        json=$(curl -G https://api.abuseipdb.com/api/v2/check --data-urlencode "ipAddress=$line" -d maxAgeInDays=10 -H "Key: $api" -H "Accept: application/json" 2>/dev/null)
            echo "$json" > json.txt
# Extract usable fields from file
        score=$(jq -r '.data.abuseConfidenceScore' json.txt)
        isp=$(jq -r '.data.isp' json.txt)
# Loop: If IPs score > 0, print score, IP and ISP name.
        if [[ $score -ne "99999" ]]
            then
           echo -e "$score \t : $line \t : $isp"
        fi
        done
