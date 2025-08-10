
--DESCRIBE: help script to create dictionary.ora file for use by LogMiner

connect / as sysdba

prompt Will create a file called dictionary.ora in directory accessible by UTL_FILE
prompt
accept location char prompt "Enter location: ($ORACLE_BASE/admin/$ORACLE_SID/utlfile): "

BEGIN
    dbms_logmnr_d.build(dictionary_filename=>'dictionary.ora',
                        dictionary_location=>'&location');
END;
/
