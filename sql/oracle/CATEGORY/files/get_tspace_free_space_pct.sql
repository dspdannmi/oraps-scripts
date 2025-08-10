
--DESCRIBE: get tablespace freespace percentage X=needs review

declare
    v_totalsize number;
    v_freespace number;
    v_pctused number;
    cursor c_tspacename is select distinct tablespace_name from mtd_df order by tablespace_name;
begin
    for v_tspacename in c_tspacename
    loop
        select sum(bytes)/(1024*1024)
        into v_totalsize
        from mtd_df
        where tablespace_name = v_tspacename.tablespace_name;
        select nvl(sum(bytes)/(1024*1024),0)
        into v_freespace
        from mtd_fs
        where tablespace_name = v_tspacename.tablespace_name;
        v_pctused := trunc(100*(1-(v_totalsize - v_freespace)/v_totalsize));
        dbms_output.put_line(v_tspacename.tablespace_name || ':   ' || v_pctused || '  (' || v_freespace || '/' || v_totalsize || ')');
    end loop;
end;
/
