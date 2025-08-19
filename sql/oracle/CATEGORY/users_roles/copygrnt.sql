
--DESCRIBE: generates copy user script from existing user

rem parameters
rem
rem    1:    source user
rem    2:    destination user
rem 

set verify off
set termout off
set feedback off
set serveroutput on

spool copygrnt.tmp

prompt whenever sqlerror exit 4

declare
  cursor c_grantors is select
		       distinct grantor
		       from dba_tab_privs
		       where grantee = upper('&&1')
			 and grantor != upper('&&2')
		       union
		       select
		       distinct grantor
		       from dba_col_privs
		       where grantee = upper('&&1')
			 and grantor != upper('&&2');

begin
  for i in c_grantors
  loop
     declare
	 cursor c_tab_privs is  select
			        *
			        from dba_tab_privs
			        where grantor = i.grantor
			          and grantee = upper('&&1');

	 cursor c_col_privs is select
			       *
			       from dba_col_privs
			       where grantor = i.grantor
				 and grantee = upper('&&1');

	 cursor c_password is select
		           password
		           from dba_users
		           where upper(username) = upper(i.grantor);
	 v_password        dba_users.password%TYPE;

     begin
	 open c_password;
	 fetch c_password into v_password;
	 close c_password;

	 dbms_output.put_line('alter user ' || i.grantor || ' identified by x;');
	 dbms_output.put_line('connect ' || i.grantor || '/x');
	 dbms_output.put_line('alter user ' || i.grantor || ' identified by values ''' || v_password || ''';');

	 for j in c_tab_privs
	 loop
	     dbms_output.put('grant ' || j.privilege || ' on ' || j.table_name || ' to &&2');

	     if j.grantable = 'YES'
	     then
		 dbms_output.put_line(' with grant option;');
	     else
		 dbms_output.put_line(';');
	     end if;
	 end loop; -- j loop

	 for j in c_col_privs
	 loop
	     dbms_output.put('grant ' || j.privilege || '(' || j.column_name || ') on ' || j.table_name);
	     dbms_output.put(' to &&2');

	     if j.grantable = 'YES'
	     then
		 dbms_output.put_line(' with grant option;');
	     else
		 dbms_output.put_line(';');
	     end if;
	 end loop;  -- j loop
     end;

     dbms_output.put_line('');
     dbms_output.put_line('');
  end loop;  -- i loop
end;
/

prompt exit

spool off

exit
