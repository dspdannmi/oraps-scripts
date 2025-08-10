
--DESCRIBE: show summary of redo log and archived redo log history

set serveroutput on size 50000

declare
     v_global_name	varchar2(40);

     v_first_seq	number;
     v_last_seq		number;

     v_first_log_time	date;
     v_last_log_time    date;

     v_num_days		number;
     v_num_logs		number;
     v_redo_size_avg	number;
     v_daily_redo_avg   number;

begin
     select global_name
     into v_global_name
     from global_name;

     select min(sequence#), max(sequence#), min(first_time), max(first_time)
     into v_first_seq, v_last_seq, v_first_log_time, v_last_log_time
     from v$loghist;

     select avg(bytes)
     into v_redo_size_avg
     from v$log;

     v_num_days := trunc(v_last_log_time - v_first_log_time);
     v_num_logs := v_last_seq - v_first_seq;

     v_daily_redo_avg := trunc(((v_num_logs*v_redo_size_avg)/v_num_days)/(1024*1024));

     dbms_output.put_line('First seq#:      ' || v_first_seq);
     dbms_output.put_line('Last seq#:       ' || v_last_seq);
     dbms_output.put_line('Earliest:        ' || to_char(v_first_log_time, 'DD-MON-YYYY HH24:MI'));
     dbms_output.put_line('Oldest:          ' || to_char(v_last_log_time, 'DD-MON-YYYY HH24:MI'));
     dbms_output.new_line;
     dbms_output.put_line('Number of days:  ' || v_num_days);
     dbms_output.put_line('Number of logs:  ' || v_num_logs);
     dbms_output.new_line;
     dbms_output.put_line('Average logsize: ' || v_redo_size_avg);
     dbms_output.new_line;
     dbms_output.put_line('Avg daily redo:  ' || v_daily_redo_avg || 'Mb');
     dbms_output.new_line;
     dbms_output.new_line;

     dbms_output.put_line('DB: ' || v_global_name || ': ' || v_daily_redo_avg);

     v_num_days := v_last_log_time - v_first_log_time;

   
end;
/
