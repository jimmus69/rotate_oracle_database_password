#!/usr/bin/python27

import os
import string
import subprocess


#list of DBs generated from script, these will be deleted at the end 
list_of_oracle_dbs = "list_of_oracle_dbs.txt"
list_of_aurora_dbs = "list_of_aurora_dbs.txt"

list_of_oracle_dbs_address = "list_of_oracle_dbs_addresses.txt"
list_of_aurora_dbs_address = "list_of_aurora_dbs_addresses.txt"

list_of_oracle_dbs_username = "list_of_oracle_dbs_username.txt"
list_of_aurora_dbs_username = "list_of_aurora_dbs_username.txt"

#intemediate file, this will be deleted at the end 
new_db_list = "new_db_list.txt"
#name of terraform variable file 
filePath = "variables.tf"
#shell script to retrieve DBs from AWS
aws_shell_script = "make_db_list.sh"

def terra_var_db_list(list_of_dbs):
    #reads in list_of_dbs.txt into list
    lineList = [line.rstrip('\n') for line in open(list_of_dbs)]

    #print (lineList)

    #prints the formated list of the DBs to an intermediate, quotes and commas added
    f = open(new_db_list, "w")

    with open(new_db_list, 'w') as file_handler:
        for item in lineList:
            file_handler.write("\"{}\",".format(item))

    #removes the trailing comma from the list of DBs and saves everything into a string
    f = open(new_db_list,"r")
    thisline = f.read()
    #print (thisline)
    result = thisline.rstrip(',')
    f.close()
    #print(result)
    return (result)

def terra_var_db_count(list_of_dbs):
    # creates the number of DBs variable
    # counts the number of lines in the list of dbs file
    number_of_dbs = len(open(list_of_dbs).readlines(  ))
    return (number_of_dbs)

os.system(("./"+aws_shell_script))
terra_oracle_count_dbs = terra_var_db_count(list_of_oracle_dbs)
terra_oracle_list_dbs = terra_var_db_list(list_of_oracle_dbs)
terra_oracle_list_dbs_address = terra_var_db_list(list_of_oracle_dbs_address)
terra_oracle_list_dbs_username = terra_var_db_list(list_of_oracle_dbs_username)

terra_aurora_count_dbs = terra_var_db_count(list_of_aurora_dbs)
terra_aurora_list_dbs = terra_var_db_list(list_of_aurora_dbs)
terra_aurora_list_dbs_address = terra_var_db_list(list_of_aurora_dbs_address)
terra_aurora_list_dbs_username = terra_var_db_list(list_of_aurora_dbs_username)

# Removes old variables.tf and creates a new one
if os.path.exists(filePath):
    os.remove(filePath)
    print("Old variables.tf deleted")
    f= open(filePath,"w+")
    print("New variables.tf created deleted")
else:
    f= open(filePath,"w+")
    print("New variables.tf created deleted")
    
# DB list strings for the variables.tf file
header = "#--- update_db_password/variables.tf---"
footer_list = "\n\t]\n}"
header_list_oracle = "\nvariable \"list_db_oracle\" {\n\tdefault = ["
header_list_aurora = "\nvariable \"list_db_aurora\" {\n\tdefault = ["

final_string_db_list_oracle = header_list_oracle + terra_oracle_list_dbs + footer_list
final_string_db_list_aurora = header_list_aurora + terra_aurora_list_dbs + footer_list
final_string_db_list = header + final_string_db_list_oracle + final_string_db_list_aurora

# DB count strings for the variables.tf file
header_count_oracle = "\nvariable \"count_db_oracle\" {\n\tdefault = "
header_count_aurora = "\nvariable \"count_db_aurora\" {\n\tdefault = "
footer_count = "\n}"

final_string_db_count_oracle = header_count_oracle + str(terra_oracle_count_dbs) + footer_count
final_string_db_count_aurora = header_count_aurora + str(terra_aurora_count_dbs) + footer_count

final_string_db_count = final_string_db_count_oracle + final_string_db_count_aurora

# DB address strings for the variables.tf file
header_list_oracle_address = "\nvariable \"oracle_db_address\" {\n\tdefault = ["
header_list_aurora_address = "\nvariable \"aurora_db_address\" {\n\tdefault = ["

final_string_db_list_oracle_address = header_list_oracle_address + terra_oracle_list_dbs_address + footer_list
final_string_db_list_aurora_address = header_list_aurora_address + terra_aurora_list_dbs_address + footer_list
final_string_db_address = final_string_db_list_oracle_address + final_string_db_list_aurora_address

# DB username strings for the variables.tf file
header_list_oracle_username = "\nvariable \"oracle_db_username\" {\n\tdefault = ["
header_list_aurora_username = "\nvariable \"aurora_db_username\" {\n\tdefault = ["

final_string_db_list_oracle_username = header_list_oracle_username + terra_oracle_list_dbs_username + footer_list
final_string_db_list_aurora_username = header_list_aurora_username + terra_aurora_list_dbs_username + footer_list
final_string_db_username = final_string_db_list_oracle_username + final_string_db_list_aurora_username


f.write((final_string_db_list + final_string_db_count + final_string_db_address + final_string_db_username ))
f.close()

os.remove(list_of_oracle_dbs)
os.remove(list_of_oracle_dbs_address)
os.remove(list_of_oracle_dbs_username)

os.remove(list_of_aurora_dbs)
os.remove(list_of_aurora_dbs_address)
os.remove(list_of_aurora_dbs_username)

os.remove(new_db_list)