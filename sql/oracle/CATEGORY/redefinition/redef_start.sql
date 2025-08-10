
--DESCRIBE: help script to start table redefinition

begin
    dbms_redefinition.start_redef_table(upper('&owner'),
                                        upper('&origtable'),
                                        upper('&interimtab'));
end;
/

undefine owner
undefine origtable
undefine interimtab
