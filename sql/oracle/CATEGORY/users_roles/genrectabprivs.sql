
--DESCRIBE: generates script to regrant system privileges

set serveroutput on

declare
    grantor	sys.dba_tab_privs.grantor%TYPE := '';

    cursor c_dbatabprivs		--(grantor, privilege, owner, table_name, grantee, grantable)
    is
    select grantor, privilege, owner, table_name, grantee, decode(grantable, 'YES', ' with grant option', '') grantable
    from sys.dba_tab_privs
    where grantor = 'SYS'
      or owner = 'SYS'
      or grantee = 'SYS'
    order by grantor;

begin
    dbms_output.enable(1000000);

    grantor := ' ';

    for v_priv in c_dbatabprivs
    loop
	if grantor <> v_priv.grantor
	then
	    grantor := v_priv.grantor;
	    dbms_output.put_line('connect ' || grantor || '/&' || grantor || '_PWD');
	end if;

	dbms_output.put_line('grant ' || v_priv.privilege || ' on ' || v_priv.owner || '.' || v_priv.table_name || ' to ' || v_priv.grantee || ' ' || v_priv.grantable || ';');
	null;
    end loop;
 null;
end;

/
