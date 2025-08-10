
--DESCRIBE: help script to perform interim sync of table definition

begin
    dbms_redefinition.sync_interim_table(upper('&owner'),
                                         upper('&origtable'),
                                         upper('&interimtab'));
end;
/

undefine owner
undefine origtable
undefine interimtab
