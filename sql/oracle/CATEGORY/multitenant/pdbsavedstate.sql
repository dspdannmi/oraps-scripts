
--DESCRIBE: show information about pdb saved states

REM
REM if not saved state then no entry in CDB_PDB_SAVED_STATES

select v.con_id, v.name, v.open_mode, v.restricted, ss.state
from v$pdbs v, cdb_pdb_saved_states ss
where v.con_id = ss.con_id (+);


