
Last updated: 2026-03-10


OCI : Creating the Oracle Database Monitoring Credentials for Oracle Cloud Infrastructure Database Management, Operations Insights and Stack Monitoring

KB57458


Execute the grantPrivileges.sql script in accordance with your use case.

Database Management and Stack Monitoring

a. Common user to monitor CDB and all PDBs
b. Common user to monitoring CDB and subset of PDBs
c. Common user to monitor only CDB
d. Local user to monitor PDB

 
Operations Insights
Input Field	Description
USER	Name of monitoring user to be created
PWD	Password of new monitoring user
OPSI	Y- If the user is being created/updated for OPSI
N – All other use cases
ALL_CONTAINER_ACCESS	Y – If the user being created/updated will be used to monitor all PDBs
N – If the user being created/updated will be used to monitor a single PDB
SYSDG_ROLE	Y – User will be granted sysdg role.
N – No action.
 

 

 

 

 



 

 

Database Management and Stack Monitoring

Here is information on how to assign the permissions required to enable Database Management and Stack Monitoring and monitor Oracle Databases. 
Note that for Database Management and Stack Monitoring, the script requires the third argument of ‘N’.

Script Usage

1. Common User to manage CDB and all PDBs

sqlplus sys/<sys pwd>@connect_string as sysdba @grantPrivileges.sql [USER] [PWD] N Y N >grantPrivileges.log

Note: must connect to CDB$ROOT
Example:
In this example, the script is run using sqlplus and the full connect string, the name of the new database user being created (dbmgmtuser), and the password (oracle) are specified.

sqlplus sys/<password>@(DESCRIPTION=(ADDRESS_LIST=(ADDRESS=(PROTOCOL=TCP)(HOST=<host>.<domain>)(PORT=1521)))(CONNECT_DATA=(SERVICE=<CDB Servicename>))) as sysdba @grantPrivileges.sql C##OCI_MON_USER <password> N Y N > grantPrivileges.log
2. Common User to manage CDB and subset of PDBs

CDB Level:

sqlplus sys/<sys pwd>@connect_string as sysdba @grantPrivileges.sql [USER] [PWD] N N N >grantPrivileges.log

Note: must connect to CDB$ROOT
Example:
In this example, the script is run using sqlplus and the full connect string, the name of the new database user being created (dbmgmtuser), and the password (oracle) are specified.

sqlplus sys/<password>@(DESCRIPTION=(ADDRESS_LIST=(ADDRESS=(PROTOCOL=TCP)(HOST=<host>.<domain>)(PORT=1521)))(CONNECT_DATA=(SERVICE=<CDB Servicename>))) as sysdba @grantPrivileges.sql C##OCI_MON_USER <password> N N N > grantPrivileges.log
PDB Level:

sqlplus sys/<sys pwd>@connect_string as sysdba @grantPrivileges.sql [USER] [PWD] N N N >grantPrivileges.log

Note: must connect and execute on each specific PDB.
Example:
In this example, the script is run using sqlplus and the full connect string, the name of the new database user being created (dbmgmtuser), and the password (oracle) are specified.

sqlplus sys/<password>@(DESCRIPTION=(ADDRESS_LIST=(ADDRESS=(PROTOCOL=TCP)(HOST=<host>.<domain>)(PORT=1521)))(CONNECT_DATA=(SERVICE=<PDB Servicename>))) as sysdba @grantPrivileges.sql C##OCI_MON_USER <password> N N N > grantPrivileges.log
3. Common User to manage only CDB

sqlplus sys/<sys pwd>@connect_string as sysdba @grantPrivileges.sql [USER] [PWD] N N N >grantPrivileges.log

Note: must connect to CDB$ROOT
Example:
In this example, the script is run using sqlplus and the full connect string, the name of the new database user being created (dbmgmtuser), and the password (oracle) are specified.

sqlplus sys/<password>@(DESCRIPTION=(ADDRESS_LIST=(ADDRESS=(PROTOCOL=TCP)(HOST=<host>.<domain>)(PORT=1521)))(CONNECT_DATA=(SERVICE=<CDB Servicename>))) as sysdba @grantPrivileges.sql C##OCI_MON_USER <password> N N N > grantPrivileges.log
4. Local User to manage PDB

sqlplus sys/<sys pwd>@connect_string as sysdba @grantPrivileges.sql [USER] [PWD] N N N >grantPrivileges.log

Note: must connect to PDB
Example:
In this example, the script is run using sqlplus and the full connect string, the name of the new database user being created (dbmgmtuser), and the password (oracle) are specified.

sqlplus sys/<password>@(DESCRIPTION=(ADDRESS_LIST=(ADDRESS=(PROTOCOL=TCP)(HOST=<host>.<domain>)(PORT=1521)))(CONNECT_DATA=(SERVICE=<PDB Servicename>))) as sysdba @grantPrivileges.sql OCI_MON_USER <password> N N N > grantPrivileges.log
5. User to manage Standby

sqlplus sys/<sys pwd>@connect_string as sysdba @grantPrivileges.sql [USER] [PWD] N Y Y >grantPrivileges.log

Note: Must connect to the primary DB.
Example:
In this example, the script is run using sqlplus and the full connect string, the name of the new database user being created with sysdg role(C##OCI_MON_USER) is specified.

sqlplus sys/<password>@(DESCRIPTION=(ADDRESS_LIST=(ADDRESS=(PROTOCOL=TCP)(HOST=<host>.<domain>)(PORT=1521)))(CONNECT_DATA=(SERVICE=<CDB Servicename>))) as sysdba @grantPrivileges.sql C##OCI_MON_USER <password> N Y Y > grantPrivileges.log

Operations Insights

Here is information on how to assign the permissions required to enable Operations Insights and monitor Oracle Databases. Note that for Operations Insights, the script requires the third argument of ‘Y’.

Script Usage

a. Common User to manage CDB and all PDBs

This option is recommended for Cloud Database (VM/BM/Exadata on Dedicated Infrastructure) usage.

sqlplus sys/<sys pwd>@connect_string as sysdba @grantPrivileges.sql [USER] [PWD] Y Y N >grantPrivileges.log

Note: must connect to CDB$ROOT
Example:
In this example, the script is run using sqlplus and the full connect string, the name of the new common database user being created (opsiuser), and the password <password> which is a placeholder, are specified.

sqlplus sys/<password>@(DESCRIPTION=(ADDRESS_LIST=(ADDRESS=(PROTOCOL=TCP)(HOST=<host>.<domain>)(PORT=1521)))(CONNECT_DATA=(SID=<PDB Servicename>))) as sysdba @grantPrivileges.sql opsiuser <password> Y Y N > grantPrivileges.log
b. Local User to manage PDB

This option is to be used if you want to monitor individual PDBs. This is typical for Management Agent support or if you are only planning to monitor a single Cloud PDB.

sqlplus sys/<sys pwd>@connect_string as sysdba @grantPrivileges.sql [USER] [PWD] Y N N >grantPrivileges.log

Note: must connect to PDB
Example:
In this example, the script is run using sqlplus and the full connect string, the name of the new database user being created (opsiuser), and the password <password> are specified.

sqlplus sys/<password>@(DESCRIPTION=(ADDRESS_LIST=(ADDRESS=(PROTOCOL=TCP)(HOST=<host>.<domain>)(PORT=1521)))(CONNECT_DATA=(SID=<PDB Servicename>))) as sysdba @grantPrivileges.sql opsiuser <password> Y N N > grantPrivileges.log
c. Local User to manage Autonomous Database

This option is to be used if you want to monitor Autonomous Database. This is typical for Management Agent support or if you are only planning to monitor a ADB.

Follow the steps provided in the document below to create this user:

Note KB95891 OCI : Creating the Autonomous Database Monitoring Credentials for Oracle Cloud Operations Insights


