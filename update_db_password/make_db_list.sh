#This file makes the db list
#aws rds describe-db-instances | grep '"DBInstanceIdentifier":'| sed 's/"//g' | sed 's/DBInstanceIdentifier://g'| sed 's/ //g' > list_of_dbs.txt

aws rds describe-db-instances --query 'DBInstances[?starts_with(Engine,`oracle`) == `true`].{DBInstanceIdentifier:DBInstanceIdentifier}' | grep '"DBInstanceIdentifier":'| sed 's/"//g' | sed 's/DBInstanceIdentifier://g'| sed 's/ //g' > list_of_oracle_dbs.txt
aws rds describe-db-instances --query 'DBInstances[?starts_with(Engine,`aurora`) == `true`].{DBInstanceIdentifier:DBInstanceIdentifier}' | grep '"DBInstanceIdentifier":'| sed 's/"//g' | sed 's/DBInstanceIdentifier://g'| sed 's/ //g' > list_of_aurora_dbs.txt