#!/bin/bash
while true
do
    read order_id
    json=$(curl -s 'https://api.baselinker.com/connector.php' -H 'X-BLToken: \\{{API-TOKEN}}\\' --data-raw 'method=getOrders&parameters={"order_id": '$order_id'}' | jq -r '.orders')
    echo "$json" > baselinker.txt
    sku=$(cat  baselinker.txt | jq -r .[].products | jq .[].sku | tr -d '"')
    quantity=$(cat  baselinker.txt | jq -r .[].products | jq .[].quantity)
    echo "$sku : $quantity"
done
