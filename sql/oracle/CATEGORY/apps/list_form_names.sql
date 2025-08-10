
--DESCRIBE: list Oracle Applications form names

REM acknowledge: http://www.itpub.net/thread-1713301-1-1.html

SELECT fff.function_name,
               ff.form_name,
               ffft.user_function_name,
               fff.function_id,
               ff.form_id,
               fff.application_id
    FROM   fnd_form ff,
           fnd_form_functions fff,
           fnd_form_functions_tl ffft
    WHERE  ff.form_id = fff.form_id
    AND    fff.function_id = ffft.function_id
    AND    ffft.language = 'US'
    and lower(ffft.user_function_name) like '%post%journal%'
    ORDER BY ffft.user_function_name;
