
--DESCRIBE: helper script for cursor pin S wait on X events

select p2raw,to_number(substr(to_char(rawtohex(p2raw)),1,8),'XXXXXXXX') sid 
     from v$session 
     where event = 'cursor: pin S wait on X';
