
--DESCRIBE: unloader package spec to unload table contents from asktom.oracle.com

-- Flat File Unload

-- Acknowledge:  Tom Kyte / Darl Kuhn (Expert Oracle Database Architecture [3rd ed]

create or replace package unloader
  AUTHID CURRENT_USER
  as
      /* Function run -- unloads data from any query into a file
                     and creates a control file to reload that
                     data into another table

      p_query      = SQL query to "unload".  May be virtually any query.
      p_tname      = Table to load into.  Will be put into control file.
      p_mode       = REPLACE|APPEND|TRUNCATE -- how to reload the data
      p_dir        = directory we will write the ctl and dat file to.
      p_filename   = name of file to write to.  I will add .ctl and .dat
                     to this name
      p_separator  = field delimiter.  I default this to a comma.
      p_enclosure  = what each field will be wrapped in
      p_terminator = end of line character.  We use this so we can unload
                and reload data with newlines in it.  I default to
               "|\n" (a pipe and a newline together) and "|\r\n" on NT.
                You need only to override this if you believe your
                data will have that default sequence of characters in it.
                I ALWAYS add the OS "end of line" marker to this sequence, you should not
      */
      function run( p_query     in varchar2,
                    p_tname     in varchar2,
                    p_mode      in varchar2 default 'REPLACE',
                    p_dir       in varchar2,
                    p_filename  in varchar2,
                    p_separator in varchar2 default ',',
                    p_enclosure in varchar2 default '"',
                    p_terminator in varchar2 default '|' )
      return number;
  end;
/

