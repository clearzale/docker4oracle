#!/bin/bash
# LICENSE GPL 3.0
#
# Copyright (c) 2012-2018 Hangzhou WOQUTECH co,ltd. All rights reserved.
#
# Description: Sets up the unix environment for DB installation.
# 

# Setup filesystem and oracle user
# Adjust file permissions, go to /opt/oracle as user 'oracle' to proceed with Oracle installation
# ------------------------------------------------------------
mkdir -p /oradata && \
chmod ug+x $ORACLE_BASE/$RUN_FILE && \
chmod ug+x $ORACLE_BASE/$START_FILE && \
rm -f /etc/yum.repos.d/* && \
echo 'proxy=http://124.108.10.25:3128'>>/etc/yum.conf && \
rm -f /etc/yum.repos.d/* && \
curl -o /etc/yum.repos.d/CentOS-Base.repo ftp://ftp4file:ftp4fileBestv@124.108.10.25/temp/Centos-base.repo && \
# chmod ug+x $ORACLE_BASE/$CREATE_DB_FILE && \
#yum install -y openssl make gcc binutils gcc-c++ compat-libstdc++ elfutils-libelf-devel elfutils-libelf-devel-static ksh libaio libaio-devel numactl-devel sysstat unixODBC unixODBC-devel pcre-devel glibc.i686 unzip sudo
yum install -y binutils compat-libstdc++-33 compat-libstdc++-33.i686 elfutils-libelf elfutils-libelf-devel gcc gcc-c++ glibc glibc.i686 glibc-common glibc-devel glibc-devel.i686 glibc-headers ksh libaio libaio.i686 libaio-devel libaio-devel.i686 libgcc libgcc.i686 libstdc++ libstdc++.i686 libstdc++-devel make sysstat  libXp libXt.i686 libXtst.i686 libXp.i686 unzip sudo tar
groupadd oinstall
groupadd dba
useradd -g oinstall -G dba -d /home/oracle oracle
echo "oracle ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers
mkdir -p $ORACLE_HOME
mkdir -p /oradata
mkdir -p $ORACLE_BASE/oraInventory
chown -R oracle:oinstall $ORACLE_BASE/product
chown -R oracle:oinstall $ORACLE_BASE/oraInventory
chown -R oracle:oinstall /oradata
chmod -R 775 $ORACLE_BASE/product
chmod -R 775 /oradata
chmod -R 775 $ORACLE_BASE/oraInventory
echo oracle:oracle | chpasswd && chown -R oracle:oinstall $ORACLE_BASE
