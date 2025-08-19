
--DESCRIBE: generates CTAS script for tables containing long columns

set verify off
set serveroutput on

clear breaks

rem
rem This script generates a CTAS (create table as select)
rem script for tables that contain LONG columns. It concerts to CLOB.
rem Does not currently work with LONG RAW columns
rem

declare
    v_select_list varchar2(4000);
    seperator     varchar2(1);
    cursor c_longtabs is select distinct table_name
                         from dba_tab_columns
                         where owner=upper('&&username')
                           and data_type = 'LONG';
    cursor c_columns(p_table dba_tables.table_name%TYPE) is select column_name, data_type
							  from dba_tab_cols
							  where owner = upper('&&username')
							    and table_name = p_table;
begin
    null;
    dbms_output.put_line('Processing...');
    for v_table in c_longtabs
    loop
	seperator := ' ';
	v_select_list := null;
	dbms_output.put_line('create table ' || v_table.table_name || '_NEW as select');
	for v_column in c_columns(v_table.table_name)
	loop
	    if (v_column.data_type != 'LONG')
	    then
		dbms_output.put_line(seperator || v_column.column_name);
	    else
		dbms_output.put_line(seperator || 'to_lob(' || v_column.column_name || ') ' || v_column.column_name);
	    end if;
	    if (seperator = ' ')
	    then
		seperator := ',' ;
	    end if;
	end loop;
	dbms_output.put_line('from ' || v_table.table_name || ' where 0=1;');
	dbms_output.new_line;
	dbms_output.new_line;
    end loop;
end;
/
