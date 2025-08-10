
--DESCRIBE: generates script to recreate all database links X=needs review

set verify off
set serveroutput on size 50000

--
-- This script should be run from connect as SYSDBA as after Oracle9i
-- and later, a DBA account may not necessarily have access to the
-- sys.link$ table
--
clear columns
clear breaks
clear computes


declare
    v_link_type varchar2(8);
    v_username  dba_users.username%TYPE;
    v_password  dba_users.password%TYPE;

    -- cursor to determine all distinct
    -- owners of database links
    cursor c_link_owners 
	is select distinct owner# 
	   from sys.link$
	   order by owner#;


    -- cursor to determine all database links
    -- for a particular owner
    cursor c_links(p_owner# sys.link$.owner#%TYPE) 
	is select name, 
		  userid, 
		  nvl(l.password, 'NOPWDSHOWN10G') linkpwd, 
		  host, 
		  u.password
	      from sys.link$ l, dba_users u
	      where l.owner# = u.user_id (+)
		and l.owner# = p_owner#;
begin
    dbms_output.put_line(chr(10));	-- newline

    -- Loop through all individual database link owners
    -- (If link owner is '1' this denotes owner is a public
    -- database link

    for v_link_owner in c_link_owners
    loop
	if v_link_owner.owner# = 1
	then
	    v_link_type := 'public';	-- owner#=1 denotes link is PUBLIC

	    dbms_output.put_line('--');
	    dbms_output.put_line('-- PUBLIC database links');
	    dbms_output.put_line('--');
            dbms_output.put_line('connect /');
	else
	    v_link_type := '';

	    select username, password
	    into v_username, v_password
	    from dba_users
	    where user_id = v_link_owner.owner#;

	    dbms_output.put_line('--');
	    dbms_output.put_line('-- ' || v_username || ' database links');
	    dbms_output.put_line('--');
            dbms_output.put_line('connect /');

	    -- Connected as SYSDBA, modify user password, connect as user then reset
	    -- password

	    dbms_output.put_line('alter user ' || v_username || ' identified by x;');
	    dbms_output.put_line('connect ' || v_username || '/x');
	    dbms_output.put_line('alter user ' || v_username || ' identified by values ''' || v_password || ''';');
	end if;

	--
	-- Loop through all database links owned by the current user
	-- being processed and generate a CREATE database link statement.
	--

	for v_link in c_links(v_link_owner.owner#)
	loop
	    dbms_output.put('create ' || v_link_type || ' database link ' || v_link.name || ' connect to ');
	    dbms_output.put_line(v_link.userid || ' identified by ' || v_link.linkpwd || ' using ''' || v_link.host || ''';');
	end loop;

	dbms_output.put_line(chr(10));
    end loop;
end;
/

