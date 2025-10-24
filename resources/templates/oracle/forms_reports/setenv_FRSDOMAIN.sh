export ORACLE_BASE=/u01/app/oracle
export ORACLE_HOME=${ORACLE_BASE}/product/12.2.1
export MW_HOME=${ORACLE_HOME}
export WLS_HOME=${MW_HOME}/wlserver
export WL_HOME=${WLS_HOME}
export DOMAIN_BASE=${ORACLE_BASE}/config/domains
export DOMAIN_HOME=${DOMAIN_BASE}/FRSDOMAIN
export JAVA_HOME=${ORACLE_BASE}/product/java/jdk
export PATH=${ORACLE_HOME}/OPatch:${ORACLE_HOME}/bin:${JAVA_HOME}/bin:${PATH}

