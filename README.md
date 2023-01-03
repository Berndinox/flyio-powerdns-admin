# flyio-powerdns-admin

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

## Init
After first start create a new user and connect your PowerDNS Auth Server API.  
DONE!