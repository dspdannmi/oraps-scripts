
--DESCRIBE: help script to determine if table is candidate for table redefinition

begin
    dbms_redefinition.can_redef_table(upper('&owner'), upper('&tablename'));
end;
/

undefine owner
undefine tablename
