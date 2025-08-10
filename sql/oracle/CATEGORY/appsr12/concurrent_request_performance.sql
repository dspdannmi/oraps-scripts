
--DESCRIBE: show breakdown of concurrent requests and how quickly and count of completion time
REM concurrent requests by day

select trunc(request_date) || ',' || count(*)
from apps.fnd_concurrent_requests
group by trunc(request_date)
order by trunc(request_date)
/

REM conurrent requests that complete in 120 seconds

select trunc(request_date) || ',' ||
       count(*) || ',' ||
       trunc(avg(actual_completion_date-actual_start_date)*24*60*60) || ',' ||
       sum(decode(sign((actual_completion_date-actual_start_date)*24*60*60-120),-1,1,1,0)) || ',' ||
       trunc(sum(decode(sign((actual_completion_date-actual_start_date)*24*60*60-120),-1,1,1,0))*100/count(*)) RESULTS
from apps.fnd_concurrent_requests
group by trunc(request_date)
order by trunc(request_date)
/

REM conurrent requests that complete in 60 seconds

select trunc(request_date) || ',' ||
       count(*) || ',' ||
       trunc(avg(actual_completion_date-actual_start_date)*24*60*60) || ',' ||
       sum(decode(sign((actual_completion_date-actual_start_date)*24*60*60-60),-1,1,1,0)) || ',' ||
       trunc(sum(decode(sign((actual_completion_date-actual_start_date)*24*60*60-60),-1,1,1,0))*100/count(*)) RESULTS
from apps.fnd_concurrent_requests
group by trunc(request_date)
order by trunc(request_date)
/

REM conurrent requests that complete in 30 seconds

select trunc(request_date) || ',' ||
       count(*) || ',' ||
       trunc(avg(actual_completion_date-actual_start_date)*24*60*60) || ',' ||
       sum(decode(sign((actual_completion_date-actual_start_date)*24*60*60-30),-1,1,1,0)) || ',' ||
       trunc(sum(decode(sign((actual_completion_date-actual_start_date)*24*60*60-30),-1,1,1,0))*100/count(*)) RESULTS
from apps.fnd_concurrent_requests
group by trunc(request_date)
order by trunc(request_date)
/

REM conurrent requests that START within 60 seconds of scheduled start date

select trunc(request_date) || ',' ||
       count(*) || ',' ||
       trunc(avg(actual_start_date-requested_start_date)*24*60*60) || ',' ||
       sum(decode(sign((actual_start_date-requested_start_date)*24*60*60-60),-1,1,1,0)) || ',' ||
       trunc(sum(decode(sign((actual_start_date-requested_start_date)*24*60*60-60),-1,1,1,0))*100/count(*)) RESULTS
from apps.fnd_concurrent_requests
group by trunc(request_date)
order by trunc(request_date)
/

