

clear breaks
clear columns

declare
    l_objList  dbms_stats.objectTab;
begin
    dbms_stats.gather_schema_stats
    ( ownname        => user,
    options        => 'LIST STALE',
    objlist        => l_objList );

    for i in 1 .. l_objList.count
    loop
        dbms_output.put_line( l_objList(i).objType );
        dbms_output.put_line( l_objList(i).objName );
    end loop;
end;
/

undefine 1

