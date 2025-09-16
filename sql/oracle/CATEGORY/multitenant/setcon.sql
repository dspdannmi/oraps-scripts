
--DESCRIBE: change container

col con_id format 999999
col con_name format a40
col open_mode format a12
col restricted format a16

show pdbs

prompt

variable new_container varchar2(100)

accept v_user_input char prompt "Enter container: "
set verify off

declare
        v_type		varchar2(30);

        v_con_name	v$containers.name%TYPE;
        v_con_id	v$containers.con_id%TYPE;
begin
        v_con_name := '&v_user_input';

	select case
	           when regexp_like(v_con_name, '^[0-9]*$') then 'number'
                   else 'string'
               end typ
        into v_type
        from dual;

        if v_type = 'number'
        then
            v_con_id := to_number(v_con_name);
            
            case v_con_id
                when 0 then v_con_name := 'cdb$root';	 -- some may 'think' CDB$ROOT is 0 - in two minds to leave this in or not
                when 1 then v_con_name := 'cdb$root';
                else
                  begin 
                     select name
                     into v_con_name
                     from v$containers
                     where con_id = v_con_id;
                  exception
                      when no_data_found then v_con_name := 'with_con_id_' || v_con_id;
                  end;
            end case;
            
        end if;


        :new_container := v_con_name ;
end;
/
set termout off

column col_newcontainer NEW_VALUE newcontainer noprint
select :new_container as col_newcontainer from dual;

set termout on
alter session set container = &&newcontainer;

set verify on

undefine 1

col container_name new_value _con_name noprint
set termout off
select sys_context('userenv', 'con_name') as container_name
from dual;
set termout on

REM define _CONTAINER_NAME
set sqlprompt "_user'@'_connect_identifier'{'_con_name'} SQL> '"

show con_name
prompt


