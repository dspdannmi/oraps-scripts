
--DESCRIBE: create rman user with sysdba privs granted (will connect as sysdba)

prompt Connecting as sysdba...

connect / as sysdba


create user &&rmanuser identified by &rmanuser_pwd
default tablespace tools
temporary tablespace temp
quota unlimited on tools;

grant connect , resource to &&rmanuser;

grant sysdba to &&rmanuser;


