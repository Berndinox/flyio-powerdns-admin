#!/bin/sh
echo "Running Cron Domainlist"
curl -s -H "X-API-Key: $PDNS_AUTH_APIKEY" http://[$PDNS_AUTH_IP]:80/api/v1/servers/localhost/zones | jq '.[].id' -r | sed 's/.$//' > /app/powerdnsadmin/static/domainlist.txt
