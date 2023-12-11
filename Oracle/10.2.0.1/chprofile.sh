#/bin/bash
PROFILES="/home/oracle/.bashrc"
LIMITS_FILE="/etc/security/limits.conf"
SYSCTL_FILE="/etc/sysctl.conf"

#modify user profiles
for PROFILE in $PROFILES ; do
if [ -f "$PROFILE" ] ; then
        if [ -z "$(grep "Oracle" $PROFILE)" ] ; then
                cat >>$PROFILE << eof
# Oracle configure profile parameters success
#export NLS_LANG=AMERICAN_AMERICA.UTF8
export ORACLE_BASE=/u01/app/oracle
export ORACLE_HOME=\$ORACLE_BASE/product/10.2.0/db_1
export ORACLE_OWNER=oracle
export ORACLE_SID=orcl
#export ORACLE_TERM=vt100
export THREADS_FLAG=native
export LD_LIBRARY_PATH=\$ORACLE_HOME/lib:\$LD_LIBRARY_PATH
export PATH=\$ORACLE_HOME/bin:\$PATH
#
# change this NLS settings to suit your country:
# example:
# german_germany.we8iso8859p15, american_america.we8iso8859p2 etc.
#
export LANG=en_US.UTF-8
eof
                echo " Add Oracle configure $PROFILE parameters success"
        else
                echo " Oracle configure $PROFILE parameters already existed"
        fi
else
        echo "$0: $PROFILE not found "
fi
done

# #modify limits.conf
# if [ -f "$LIMITS_FILE" ] ; then
# 	if [ -z "$(grep "Oracle" $LIMITS_FILE)" ] ; then
# 		cat >>$LIMITS_FILE << END
# #Oracle configure  shell parameters
# oracle soft nofile 65536
# oracle hard nofile 65536
# oracle soft nproc 16384
# oracle hard nproc 16384
# END
# 		echo " Add Oracle configure  shell parameters success"
#         else
#                 echo " Oracle configure  shell parameters already existed"
#         fi
# else
#         echo "$0: $LIMITS_FILE not found "
# fi

# ##modify sysctl.conf
# # if [ -f "$SYSCTL_FILE" ] ; then
# # 	if [ -z "$(grep "Oracle" $SYSCTL_FILE)" ] ; then
# # 		cat >>$SYSCTL_FILE << END
# # #Oracle configure kernel parameters
# # kernel.shmmax = 4294967296
# # kernel.shmmni = 4096
# # kernel.shmall = 2097152
# # kernel.sem = 250 32000 100 128
# # fs.file-max = 65536
# # net.ipv4.ip_local_port_range = 1024 65000 
# # net.core.rmem_default = 262144
# # net.core.rmem_max = 262144
# # net.core.wmem_default = 262144
# # net.core.wmem_max = 262144

# # END
#                 /sbin/sysctl -p
# 		echo " Add Oracle configure kernel parameters success"
# 	else 
# 		echo " Oracle configure kernel parameters already existed"
# 	fi
# else
# 	echo $SYSCTL_FILE not exists
# fi
