#!/bin/bash

#
# Check IP from Mikrotiks router "IP / Firewall / Connections" in Alienvault (no. of pulses)
# pdrzew
#

# SSH to router, save connections to file
file=router.txt
ssh {EDITED} ip firewall connection print > $file

# Process file router.txt, sort and uniq IPs
awk -F: '{ print $2 }' $file | awk -F' ' '{ print $2 }' | sort | uniq > ip.txt
lines=$(cat ip.txt)
    echo -e "Pulses \t : IP \t \t \t : ASN"
for line in $lines
    do
	json=$(curl https://otx.alienvault.com/api/v1/indicators/IPv4/$line/general 2>/dev/null)
    echo $json > alien_ip.txt
    reputation=$(jq -r '.pulse_info.count' alien_ip.txt)
    asn=$(jq -r '.asn' alien_ip.txt)

    if [[ $reputation -ne "0" ]]
        then
        echo -e "$reputation \t : $line \t : $asn:"
    fi
    done
