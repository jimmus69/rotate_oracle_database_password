#This file makes the db list
#aws rds describe-db-instances | grep '"DBInstanceIdentifier":'| sed 's/"//g' | sed 's/DBInstanceIdentifier://g'| sed 's/ //g' > list_of_dbs.txt

#Generates DB Names
aws rds describe-db-instances --query 'DBInstances[?starts_with(Engine,`oracle`) == `true`].{DBInstanceIdentifier:DBInstanceIdentifier}' | grep '"DBInstanceIdentifier":'| sed 's/"//g' | sed 's/DBInstanceIdentifier://g'| sed 's/ //g' > list_of_oracle_dbs.txt
aws rds describe-db-instances --query 'DBInstances[?starts_with(Engine,`aurora`) == `true`].{DBInstanceIdentifier:DBInstanceIdentifier}' | grep '"DBInstanceIdentifier":'| sed 's/"//g' | sed 's/DBInstanceIdentifier://g'| sed 's/ //g' > list_of_aurora_dbs.txt

aws rds describe-db-instances --query 'DBInstances[?starts_with(Engine,`oracle`) == `true`].{Address:Endpoint.Address}' | grep '"Address":'| sed 's/"//g' | sed 's/Address://g'| sed 's/ //g' > list_of_oracle_dbs_addresses.txt
aws rds describe-db-instances --query 'DBInstances[?starts_with(Engine,`aurora`) == `true`].{Address:Endpoint.Address}' | grep '"Address":'| sed 's/"//g' | sed 's/Address://g'| sed 's/ //g' > list_of_aurora_dbs_addresses.txt

aws rds describe-db-instances --query 'DBInstances[?starts_with(Engine,`oracle`) == `true`].{MasterUsername:MasterUsername}' | grep '"MasterUsername":'| sed 's/"//g' | sed 's/MasterUsername://g'| sed 's/ //g' > list_of_oracle_dbs_username.txt
aws rds describe-db-instances --query 'DBInstances[?starts_with(Engine,`aurora`) == `true`].{MasterUsername:MasterUsername}' | grep '"MasterUsername":'| sed 's/"//g' | sed 's/MasterUsername://g'| sed 's/ //g' > list_of_aurora_dbs_username.txt