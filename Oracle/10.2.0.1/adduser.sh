#/bin/bash
ADDGROUPS="oinstall dba"
ADDUSERS="oracle"
ORACLE_FILE_BASE="/u01/app/oracle"
ORACLE_DATA_DIR="/oradata"
ORACLE_FILE_HOME="$ORACLE_FILE_BASE/product/10.2.0/db_1"

for group in $ADDGROUPS ; do 

	if [ -z "$( awk -F: '{print $1}' /etc/group |grep $group)" ]; then
		 groupadd   $group
                 echo " Add new group $group"
        else 
                 echo " Group $group already existed"
	fi  
done

for user in $ADDUSERS ; do

        if [ -z "$( awk -F: '{print $1}' /etc/passwd |grep $user)" ]; then
                 useradd $user
                 echo " Add new user $user"
        else 
                 echo " User $user already existed"
        fi
done

if $(usermod -g oinstall -G dba oracle) ;  then 
   echo " Modify user oracle account success"
else
   echo " Modify user oracle account failure"
fi


if [ -d $ORACLE_FILE_HOME ]; then
                echo " Directory $ORACLE_FILE_HOME already existed"
        else
                mkdir -p $ORACLE_FILE_HOME
                chown -R oracle:dba $ORACLE_FILE_BASE
                chown -R oracle:dba /u01
                echo " Change directory $ORACLE_FILE_HOME owner and group success"
fi

if [ -d $ORACLE_DATA_DIR ]; then
                echo " Directory $ORACLE_DATA_DIR  already existed"
        else
                mkdir -p $ORACLE_DATA_DIR/flash_recovery_area
				mount /dev/mapper/mpath1 $ORACLE_DATA_DIR
                chown -R oracle:dba $ORACLE_DATA_DIR
                echo " Change directory $ORACLE_DATA_DIR owner and group success"
fi

