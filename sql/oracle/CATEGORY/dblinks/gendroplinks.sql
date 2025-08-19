
--DESCRIBE: generates script to drop all database links X=needs some work

set verify off
set serveroutput on size 50000

clear breaks


declare
    v_link_type varchar2(8);
    v_username  dba_users.username%TYPE;
    v_password  dba_users.password%TYPE;

    -- cursor to determine all distinct
    -- owners of database links
    cursor c_link_owners 
	is select distinct owner 
	   from dba_db_links
	   order by 1;


    -- cursor to determine all database links
    -- for a particular owner
    cursor c_links(p_owner dba_db_links.owner%TYPE) 
	is select db_link
	      from dba_db_links
	      where owner = p_owner;
begin
    dbms_output.put_line(chr(10));	-- newline

    -- Loop through all individual database link owners
    -- (If link owner is '1' this denotes owner is a public
    -- database link

    for v_link_owner in c_link_owners
    loop
	if v_link_owner.owner = 'PUBLIC'
	then
	    v_link_type := 'public';	-- owner#=1 denotes link is PUBLIC

	    dbms_output.put_line('--');
	    dbms_output.put_line('-- PUBLIC database links');
	    dbms_output.put_line('--');
            dbms_output.put_line('connect /');
	else
	    v_link_type := '';

	    v_username := v_link_owner.owner;

	    select password
	    into v_password
	    from dba_users
	    where username = v_username;

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
	-- being processed and generate a DROP and a CREATE database
	-- link statement.
	--

	for v_link in c_links(v_link_owner.owner)
	loop
	    -- drop database link
	    dbms_output.put_line('drop ' || v_link_type || ' database link ' || v_link.db_link || ';');
	end loop;

	dbms_output.put_line(chr(10));
    end loop;
end;
/

