
--DESCRIBE: show the last object of a datafiles

set serveroutput on size 50000

declare
   cursor file_id_c
   is
   select file_id
   from dba_data_files;
   owner_v        dba_extents.owner%TYPE;
   segment_name_v dba_extents.segment_name%TYPE;
   tablespace_name_v dba_extents.tablespace_name%TYPE;
   segment_type_v dba_extents.segment_type%TYPE;
begin
   for file_id_v in file_id_c
   loop
     begin
       select owner, segment_name,tablespace_name,segment_type
       into owner_v,segment_name_v,tablespace_name_v,segment_type_v
       from dba_extents a
       where a.file_id = file_id_v.file_id
       and block_id =
              (select max(block_id)
               from dba_extents b
               where b.file_id = file_id_v.file_id);
       dbms_output.put_line(tablespace_name_v || ':  ' ||  owner_v || '.' ||  segment_name_v || '   [' || segment_type_v || ']');
      exception
            when no_data_found then null;
      end;
   end loop;
end;
/
