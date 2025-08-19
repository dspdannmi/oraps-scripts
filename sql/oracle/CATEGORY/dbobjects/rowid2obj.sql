
--DESCRIBE: determine object id from rowid

set verify off

clear breaks
clear computes

set serveroutput on

declare
    v_object_id number;
    v_owner     dba_objects.owner%TYPE;
    v_name      dba_objects.object_name%TYPE;
    v_type      dba_objects.object_type%TYPE;
begin
    v_object_id := dbms_rowid.rowid_object('&&1');

    select owner, object_name, object_type
    into v_owner, v_name, v_type
    from dba_objects
    where object_id = v_object_id;

    dbms_output.new_line;
    dbms_output.put_line('object_id: ' || v_object_id || ':  ' || v_owner || '.' || v_name || '  [' || v_type || ']');
    dbms_output.new_line;
end;
/

undefine 1

