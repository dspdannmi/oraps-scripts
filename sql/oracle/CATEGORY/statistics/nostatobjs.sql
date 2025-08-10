
--DESCRIBE: list objects that do not have statistics

set serveroutput on 

declare
    a dbms_stats.objecttab;
begin
  dbms_stats.gather_database_stats (OPTIONS=>'LIST EMPTY',OBJLIST=>a);
       for i in 1 .. a.count
       loop
               dbms_output.put_line( a(i).ownname );
               dbms_output.put_line( a(i).objType );
               dbms_output.put_line( a(i).objName );
               dbms_output.put_line( a(i).PartName );
               dbms_output.put_line( a(i).subPartName );
               dbms_output.put_line( a(i).Confidence );
               dbms_output.put_line ( '-------------------------' );
        end loop;
end;
/
