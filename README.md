# flyio-powerdns-admin
Credits and thanks to: https://github.com/PowerDNS-Admin/PowerDNS-Admin

## Location
Use your PowerDNS Main Region.  
Otherwise the Connection string (`SQLALCHEMY_DATABASE_URI=REPLACE`) should be modified: <region>.<appname>.internal  
where region is the location of the Postgres Master (Main Reion)  

## Config
The same Postgres-Cluster as the PowerDNS Auth Server can be used.  
`flyctl postgres create DBNAME`  
`flyctl postgres connect -a APP`  
This is generating the secret (`DATABASE_URL`) - to be able to use the original image of powerdns-admin just pass the value:  
`flyctl secret set SQLALCHEMY_DATABASE_URI=REPLACE`  
Finally (https://flask.palletsprojects.com/en/1.1.x/config/#SECRET_KEY):  
`flyctl secret set SECRET_KEY=a-very-secret-key`  

Also:
PDNS_AUTH_IP="PDNS-AUTH-IP"
PDNS_AUTH_APIKEY="SECRET-PDNS-API-KEY"

## Init
After first start create a new user and connect your PowerDNS Auth Server API.  
You should connect your Private IPv6 address (PDNS not exposed directly!).
DONE!

## Attention
Testing - Alpha Software - No waranty.  
  
## Todo
*Things could be more automated. Eg. get Main Region from Consul and auto-generate the ENV.*
