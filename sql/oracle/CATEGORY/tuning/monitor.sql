
--DESCRIBE: list sql queries using the most I/O and memory

rem $DBA/monitor.sql
rem
rem This script displays a report of the SQL queries using the most I/O and
rem memory.  (It is called by $DBA/monitor).
rem
rem Last Change 06/18/97 by Brian Lomasky
rem
rem (Based upon two scripts from 4/96 SELECT magazine)
rem
set echo off
set feedback off
set heading off
set pagesize 66
set termout off
set verify off

rem
rem Calculate database name and report date
rem
column dbname noprint new_value sid
column now noprint new_value today
select name dbname, to_char(sysdate, 'MM/DD/YY') now from v$database;
set termout on

create table monitor_table_temp(
        code number,
        usernam varchar2(30),
        sid number,
        disk_reads number,
        execs number,
        reads_per_exec number,
        sql_text varchar2(2000)
        );
declare
        n number;
        text varchar2(2000);
        usr varchar2(30);
        asid number;
        dreads number;
        exexs number;
        rds_exec number;

cursor pig1 is
        select d.username, sid, disk_reads, executions,
                round(disk_reads/executions,2), sql_text
                from sys.dba_users d, v$session, v$sqlarea
                where command_type in (2,3,6,7,47) and
                disk_reads > 10000 and
                parsing_user_id = user_id and
                address = sql_address(+) and
                hash_value = sql_hash_value(+) and
                disk_reads/executions > 25
                order by disk_reads desc;
                -- d.username not in ('SYS','SYSTEM') and
cursor pig2 is
        select d.username, sid, buffer_gets, sql_text
                from sys.dba_users d, v$session, v$sqlarea
                where buffer_gets > 20000 and
                parsing_user_id = user_id and
                address = sql_address(+) and
                hash_value = sql_hash_value(+)
                order by 3 desc;
begin
        open pig1;
        n := 0;
        while true loop
                fetch pig1 into usr, asid, dreads, exexs, rds_exec, text;
                exit when pig1%NOTFOUND;
                n := n + 1;
                if n > 20 then
                        exit;
                end if;
                insert into monitor_table_temp values (1, usr, asid, dreads,
                        exexs, rds_exec, text);
        end loop;
        close pig1;
        open pig2;
        n := 0;
        while true loop
                fetch pig2 into usr, asid, dreads, text;
                exit when pig2%NOTFOUND;
                n := n + 1;
                if n > 5 then
                        exit;
                end if;
                insert into monitor_table_temp values (2, usr, asid, dreads,
                        0, 0, text);
        end loop;
        close pig2;
        commit;
end;
/
select 'Analyzing performance of database &sid on &today' from dual;
set feedback off
set heading on
set pagesize 62
set verify off

ttitle 'Memory pigs - Top 5 queries using the largest amount of logical reads' -
        skip 2
column disk_reads format 999999999999 heading "Buffer|Gets"
column usernam format a12 heading "Username"
column sid format 99999 heading "SID"
column sql_text format a48 heading "SQL Text" wrap
select disk_reads, usernam, sid, sql_text
        from monitor_table_temp
        where code = 2
        order by disk_reads desc;
set heading off
ttitle off
select ' '||chr(10)||'(These queries flood the SGA and causes often-used'||
        ' queries to be'||chr(10)||' pushed out of memory)'||chr(10)
        from dual
        where exists (select 'x' from monitor_table_temp where code = 2);
set heading on

ttitle -
  'I/O pigs - Top 20 SQL statements performing the most physical disk reads' -
  skip 2
column disk_reads format 999999999 heading "Disk|Reads"
column execs format 99999 heading "Execs"
column reads_per_exec format 999999 heading "Reads|/Exec"
column usernam format a8 heading "Username"
column sql_text format a40 heading "SQL Text" wrap
select disk_reads, execs, reads_per_exec, usernam, sid, sql_text
        from monitor_table_temp
        where code = 1
        order by disk_reads desc;
set heading off
ttitle off
select ' '||chr(10)||'(This will usually show where most full table scans'||
        ' are being done and'||chr(10)||'also those queries that are'||
        ' saturating the SGA)'||chr(10)
        from dual
        where exists (select 'x' from monitor_table_temp where code = 1);
drop table monitor_table_temp;
