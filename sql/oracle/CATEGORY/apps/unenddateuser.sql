
--DESCRIBE: end-date an Oracle Apps user

DECLARE
    lc_user_name       VARCHAR2(100)  := 'DANNM';
    --ld_user_end_date   DATE  := SYSDATE;
    ld_user_end_date   DATE  := to_date('2', 'J');


BEGIN
   fnd_user_pkg.updateuser
   (  x_user_name               => lc_user_name,
      x_owner                   => NULL,
      x_unencrypted_password    => NULL,
      x_start_date              => NULL,
      x_end_date                => ld_user_end_date,
      x_password_date           => NULL,
      x_password_lifespan_days  => NULL,
      x_employee_id             => NULL,
      x_email_address           => NULL
   );

 COMMIT;


EXCEPTION
  WHEN OTHERS THEN
    ROLLBACK;
    DBMS_OUTPUT.PUT_LINE(SQLERRM);
END;
/

