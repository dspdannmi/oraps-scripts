
--DESCRIBE: help script to finish table redefinition

begin
    dbms_redefinition.finish_redef_table(upper('&owner'),
                                        upper('&origtable'),
                                        upper('&interimtab'));
end;
/

undefine owner
undefine origtable
undefine interimtab
