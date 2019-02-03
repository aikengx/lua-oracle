# lua-oracle
#
Logical dependencies:
mkdir oracle
mv instantclient-* oracle/
  (
  instantclient-basic-linux.x64-11.2.0.4.0.zip
  instantclient-odbc-linux.x64-11.2.0.4.0.zip
  instantclient-sdk-linux.x64-11.2.0.4.0.zip
  instantclient-sqlplus-linux.x64-11.2.0.4.0.zip
  )
mkdir /opt/oracle
cd oracle/
cp instantclient-* /opt/oracle/
cd /opt/oracle/
apt-get install unzip

#En caso de compilar manualmente desde la fuente:
wget ftp://ftp.unixodbc.org/pub/unixODBC/unixODBC-2.3.4.tar.gz
tar -zxvf unixODBC-2.3.4.tar.gz
cd unixODBC-2.3.4
./configure --prefix=/usr/
make
make install

#En caso de instalar automáticamente:
apt-cache show unixodbc
apt-get install unixODBC-dev
apt-get install libaio1
dpkg-query -l | grep unixodbc (>= 2.3.0)
unzip instantclient-basic-linux.x64-11.2.0.4.0.zip
unzip instantclient-odbc-linux.x64-11.2.0.4.0.zip
unzip instantclient-sdk-linux.x64-11.2.0.4.0.zip
unzip instantclient-sqlplus-linux.x64-11.2.0.4.0.zip
rm -Rf instantclient-*
mkdir -p instantclient_11_2/network/admin
cd instantclient_11_2/
cd network/
cd admin/
vim tnsnames.ora
...
ARESQA =
  (DESCRIPTION =
    (ADDRESS = (PROTOCOL = TCP)(HOST = 172.20.0.78)(PORT = 1521))
    (CONNECT_DATA =
      (SERVER = DEDICATED)
      (SERVICE_NAME = aresqa)
    )
  )
...
cd ..
cd ..
./odbc_update_ini.sh /
odbcinst -j
...
unixODBC 2.3.1
DRIVERS............: /etc/odbcinst.ini
SYSTEM DATA SOURCES: /etc/odbc.ini
FILE DATA SOURCES..: /etc/ODBCDataSources
USER DATA SOURCES..: /root/.odbc.ini
SQLULEN Size.......: 8
SQLLEN Size........: 8
SQLSETPOSIROW Size.: 8
...
cp /etc/bash.bashrc /etc/bash.bashrc.conf
vim /etc/bash.bashrc
...
export LD_LIBRARY_PATH=/opt/oracle/instantclient_11_2
export ORACLE_HOME=/opt/oracle/instantclient_11_2
export TNS_ADMIN=/opt/oracle/instantclient_11_2/network/admin
export PATH=$LD_LIBRARY_PATH:$PATH
...
reboot
env
sqlplus ares_rtime_hmo/ares123@aresqa
cp /etc/odbcinst.ini /etc/odbcinst.ini.backup
vim /etc/odbcinst.ini
...
[OracleODBC-11g]
Description     = Oracle ODBC driver for Oracle 11g
Driver          = /opt/oracle/instantclient_11_2/libsqora.so.11.1
Setup           = /opt/oracle/instantclient_11_2/libsqora.so.11.1
FileUsage       =
CPTimeout       =
CPReuse         =
...
vim /root/.odbc.ini
...
[OracleODBC-11g]
Application Attributes = T
Attributes = W
BatchAutocommitMode = IfAllSuccessful
BindAsFLOAT = F
CloseCursor = F
DisableDPM = F
DisableMTS = T
Driver = OracleODBC-11g
DSN = OracleODBC-11g
EXECSchemaOpt =
EXECSyntax = T
Failover = T
FailoverDelay = 10
FailoverRetryCount = 10
FetchBufferSize = 64000
ForceWCHAR = F
Lobs = T
Longs = T
MaxLargeData = 0
MetadataIdDefault = F
QueryTimeout = T
ResultSets = T
ServerName = 172.20.0.78:1521/aresqa
SQLGetData extensions = F
Translation DLL =
Translation Option = 0
DisableRULEHint = T
UserID = ares_rtime_hmo
Password = ares123
StatementCache=F
CacheBufferSize=20
UseOCIDescribeAny=F
MaxTokenSize=8192
...
odbcinst -q -d
...
[OracleODBC-11g]
...
isql -v OracleODBC-11g
...
+---------------------------------------+
| Connected!                            |
|                                       |
| sql-statement                         |
| help [tablename]                      |
| quit                                  |
|                                       |
+---------------------------------------+
SQL>
...
ldd $ORACLE_HOME/libsqora.so.11.1
vim /etc/ld.so.conf.d/instantclient.conf
...
/opt/oracle/instantclient_11_2
...
cd $ORACLE_HOME
ldconfig -v

apt-get install lua5.1 liblua5.1-0 liblua5.1-0-dev
mkdir luasql
cd luasql/
wget https://github.com/keplerproject/luasql/archive/v2.3.0.zip
yum -y install unzip
unzip v2.3.0.zip
cd luasql-2.3.0/
vim config
make odbc
make install
cd ..



Run:
lua lua-oracle.lua
