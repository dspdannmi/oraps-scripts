
--DESCRIBE: test specified utl_file directories

set serveroutput on size 100000

declare

file_handle utl_file.file_type;
retrieved_buffer varchar2(100);

begin

file_handle := utl_file.fopen('&UTL_FILE_DIR', 'utlfile.test', 'W');

utl_file.put_line(file_handle, 'test');

utl_file.fclose(file_handle);

EXCEPTION             
WHEN NO_DATA_FOUND THEN               
               DBMS_OUTPUT.PUT_LINE('no_data_found');
               UTL_FILE.FCLOSE(file_handle);            
WHEN UTL_FILE.INVALID_PATH THEN               
               DBMS_OUTPUT.PUT_LINE('UTL_FILE.INVALID_PATH');               
               UTL_FILE.FCLOSE(file_handle);            
WHEN UTL_FILE.READ_ERROR THEN               
               DBMS_OUTPUT.PUT_LINE(' UTL_FILE.READ_ERROR');               
               UTL_FILE.FCLOSE(file_handle);            
WHEN UTL_FILE.WRITE_ERROR THEN               
               DBMS_OUTPUT.PUT_LINE('UTL_FILE.WRITE_ERROR');               
               UTL_FILE.FCLOSE(file_handle);            
WHEN OTHERS THEN               
               DBMS_OUTPUT.PUT_LINE('other stuff');               
               UTL_FILE.FCLOSE(file_handle);          
END;      
/

undefine UTL_FILE_DIR
