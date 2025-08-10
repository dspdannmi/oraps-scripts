
--DESCRIBE: help script to start table redefinition with columns prompt

begin
    dbms_redefinition.start_redef_table(upper('&owner'),
                                        upper('&origtable'),
                                        upper('&interimtab'), '&columns');
end;
/

undefine owner
undefine origtabl
undefine interimtab
undefine columns
