
--DESCRIBE: creates spell_number function to spell numbers

create or replace 
function spell_number( p_number in number ) 
return varchar2 
as 
type myArray is table of varchar2(255); 
l_str myArray := myArray( '', 
' thousand ', ' million ', 
' billion ', ' trillion ', 
' quadrillion ', ' quintillion ', 
' sextillion ', ' septillion ', 
' octillion ', ' nonillion ', 
' decillion ', ' undecillion ', 
' duodecillion ' ); 

l_num varchar2(50) default trunc( p_number ); 
l_return varchar2(4000); 
begin 
for i in 1 .. l_str.count 
loop 
exit when l_num is null; 

if ( substr(l_num, length(l_num)-2, 3) <> 0 ) 
then 
l_return := to_char( 
to_date(substr(l_num, length(l_num)-2, 3),'J' ), 
'Jsp' ) || l_str(i) || l_return; 
end if; 
l_num := substr( l_num, 1, length(l_num)-3 ); 
end loop; 

return l_return; 
end; 
/ 

SQL> select 
2 spell_number( 12345678901234567890123456789012345678 ) 
3 from dual; 

SPELL_NUMBER(1234567890123456789012345678901234567 
-------------------------------------------------- 
Twelve undecillion Three Hundred Forty-Five decill 
ion Six Hundred Seventy-Eight nonillion Nine Hundr 
ed One octillion Two Hundred Thirty-Four septillio 
n Five Hundred Sixty-Seven sextillion Eight Hundre 
d Ninety quintillion One Hundred Twenty-Three quad 
rillion Four Hundred Fifty-Six trillion Seven Hund 
red Eighty-Nine billion Twelve million Three Hundr 
ed Forty-Five thousand Six Hundred Seventy-Eight 
