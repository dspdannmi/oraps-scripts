
--DESCRIBE: example script to show how to 'chunk' large deletes

BEGIN
    loop -- keep looping 
      --do the delete 4999 in each iteration
      Delete &tablename where &where_cluase and rownum < &&num_rows;
      -- exit the loop when there where no more 5000 reccods to delete. 
      exit when SQL%rowcount < &&num_rows - 1;
      -- commit to clear the rollback segments. 
      commit; -- this commit i forgot in the last mail, oops. 
    end loop;
    commit; -- commit the last delete
END;
/
