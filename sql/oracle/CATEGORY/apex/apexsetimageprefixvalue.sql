
--DESCRIBE: show Oracle APEX IMAGE_PREFIX value

prompt
prompt Enter IMAGE_PREFIX value eg. https://static.oracle.com/cdn/apex/24.1.0/
prompt ensure it has trailing slash - TBC
prompt


exec apex_instance_admin.set_parameter(p_parameter=>'IMAGE_PREFIX', p_value=>'&1');

