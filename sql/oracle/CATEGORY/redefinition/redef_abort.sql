
--DESCRIBE: help script to abort table redifinition

begin
    dbms_redefinition.abort_redef_table(upper('&owner'), upper('&origtable'), upper('&interimtab'));
end;
/

undefine owner
undefine origtable
undefine interimtab
