
--DESCRIBE: login.sql executed each time sqlplus session is connected

rem set arraysize 1
set pages 80 
set lines window
set long 50000
set numformat 999999999999

set termout off
set echo off
alter session set nls_date_format='YYYY-MM-DD:HH24:MI:SS';


set termout on
set feedback on
rem set serveroutput on size 50000
set trimspool on


col BLOCKS format 9999999
col BLOCKS_COALESCED format  9999999
col BLOCK_ID format 9999999
col BYTES format 9999999999
col BYTES_COALESCED format 9999999999
col CONSTRAINT_NAME format a18 
col DATABASE format a12
col DBUSER_OWNER format a15
col DB_LINK format a15
col DB_USER format a15
col DEFAULT_TABLESPACE format a18
col EXTENTS format 99999
col EXTENTS_COALESCED format 99999
col FILE_ID format 9999
col FILE_NAME format a55
col GRANTABLE format a9
col GRANTED_ROLE format a15
col GRANTEE format a15
col GRANTOR format a15
col HOST format a15
col INDEX_NAME format a40
col INDEX_OWNER format a15
col INITIAL_EXTENT format 99999999
col MAX_EXTENTS format 9999
col MIN_EXTENTS format 9999
col NAME format a15
col NEW_NAME format a15
col NEW_OWNER format a15
col NEXT_EXTENT format 9999999999
col OBJECT_NAME format a40
col OBJECT_TYPE format a10
col OBJ_NAME format a40
col OWNER format  a15
col PCT_FREE format 99
col PCT_INCREASE format 99
col PCT_USED format 99
col PRIVILEGE format a15
col PRIV_USED format a15
col PRIV_USER format a15
col ROLLBACK_SEG format a10
col ROWNER format a15
col R_CONSTRAINT_NAME format a30
col R_OWNER format a15
col SEGMENT_NAME format a40
col SEGMENT_TYPE format a15
col SEQUENCE_NAME format a40
col SEQUENCE_OWNER format a15
col SID format 9999
col SYNONYM_NAME format a40
col TABLESPACE_NAME format a18
col TABLE_NAME format a40
col TABLE_OWNER format a15
col TEMPORARY_TABLESPACE format a15
col TRIGGER_NAME format a40
col TRIGGER_OWNER format a15
col USERNAME format  a15
col USER_NAME format  a15
col VIEW_NAME format a40



col lvl format a18
col obj format a40
col opt format a40
col operation format a25


REM
REM ----------------------------------------------
REM Get container name to modify SQL*Plus prompt
REM ----------------------------------------------
REM
REM col container_name new_value _container_name noprint
REM set termout off
REM select sys_context('userenv', 'con_name') as container_name
REM from dual;
set termout on

REM define _CONTAINER_NAME
set sqlprompt "_user'@'_connect_identifier' SQL> '"
REM
REM  ----------------------------------------------

REM column global_name new_value gname
REM set termout off
REM select replace(global_name, '.WORLD', '') global_name from global_name;
REM set termout on
REM set sqlprompt '&gname> '

