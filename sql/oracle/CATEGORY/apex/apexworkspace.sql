
--DESCRIBE: list Oracle APEX workspaces

COLUMN workspace FORMAT A40
COLUMN workspace_id FORMAT 99999999999999999999
COLUMN application_id FORMAT 99999999999999999999
COLUMN application_name FORMAT A40

-- List applications.
SELECT workspace,
       workspace_id,
       application_id,
       application_name
FROM   apex_applications
ORDER BY 1;


