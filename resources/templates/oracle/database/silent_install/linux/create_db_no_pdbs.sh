export SYS_PASSWORD=
export ORACLE_SID=DSP19C

echo -n "Enter new admin password (SYS, SYSTEM etc.) :  "
read -s SYS_PASSWORD
echo
echo -n "Re-enter to confirm                         :  " 
read -s SYS_PASSWORD_REPEAT
echo

if [ "${SYS_PASSWORD}" != "${SYS_PASSWORD_REPEAT}" ]
then
    echo "ERROR: Mismatch - exiting"
    exit 1
fi

exit 0

dbca -silent -createDatabase                                                    \
     -templateName General_Purpose.dbc                                          \
     -gdbname ${ORACLE_SID} -sid ${ORACLE_SID} -responseFile NO_VALUE           \
     -characterSet AL32UTF8                                                     \
     -sysPassword ${SYS_PASSWORD}                                               \
     -systemPassword ${SYS_PASSWORD}                                            \
     -createAsContainerDatabase true                                            \
     -numberOfPDBs 0                                                            \
     -databaseType MULTIPURPOSE                                                 \
     -memoryMgmtType auto_sga                                                   \
     -totalMemory 2000                                                          \
     -storageType FS                                                            \
     -datafileDestination "/u01/app/oracle/oradata/"                                       \
     -redoLogFileSize 500                                                       \
     -emConfiguration NONE                                                      \
     -ignorePreReqs
