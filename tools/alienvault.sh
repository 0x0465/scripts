#!/bin/bash

#
# Check IP reputaion on Alienvault OTX
# by pdr
# @0x2e8b


# Process file ip.txt, every IP in new line, file should be in the same directory as script
lines=$(cat ip.txt)

# Show number of unique IPs
echo "IP count:"
wc -l < ip.txt
echo ""
echo -e "Reputaion, No of Pulses, IP, ASN"

# Loop through IPs
for line in $lines
        do
# Curl to Alienvault, save to file
                json=$(curl https://otx.alienvault.com/api/v1/indicators/IPv4/$line/general 2>/dev/null)
                    echo $json > ip_alien.txt
# Extract usable fields from file
		reputation=$(jq -r '.reputation' ip_alien.txt)
		pulses=$(jq -r '.pulse_info.count' ip_alien.txt)
                asn=$(jq -r '.asn' ip_alien.txt)
# Loop: If IPs rep > 0, print rep, IP and ISP name.
                if [[ $pulses -ne "9999" ]]
                    then
                    echo -e "$reputation,$pulses,$line,$asn:"
                fi
                done
