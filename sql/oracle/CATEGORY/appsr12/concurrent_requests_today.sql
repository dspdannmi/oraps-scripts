
--DESCRIBE: show concurrent requests for last two (2) days

select fcr.request_id, fcp.concurrent_program_name, fcr.status_code, fcr.actual_start_date, fcr.actual_completion_date, fcr.completion_text
from apps.fnd_concurrent_requests fcr,
     apps.fnd_concurrent_programs fcp
where fcr.request_date > trunc(sysdate)-2
  and (fcr.concurrent_program_id = fcp.concurrent_program_id and fcr.program_application_id = fcp.application_id)
order by request_id;
