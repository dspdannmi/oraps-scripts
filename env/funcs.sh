
#
# setting trap and functions for use in scripts
#
if [ "${CS_TOP}" = "" ] || [ ! -d ${CS_TOP} ]
then
    echo "WARNING: CS_TOP not set or is not a directory - returning - script may not behave as expected"
    return 1

fi

trap "graceful_exit" 0
trap "graceful_exit terminated" 1 2 3 15

DEL_TEMPFILES=YES

for func in catdebug \
            check_and_set_oracle_sid \
            check_status \
            check_status_exit \
            choose_from_menu \
            clear_error_trap \
            echodebug \
            echoerr \
            error_encountered \
            graceful_exit \
            scriptfooter \
            scriptheader \
            scriptout \
            scriptout2 \
            scriptout3 \
            scriptout4 \
            setalertlogvar \
            setoradbenv \
            set_error_trap \
            usage 
do
    . ${CS_TOP}/functions/${func}
done
