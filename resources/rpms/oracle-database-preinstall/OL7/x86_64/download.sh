#!/bin/bash

# OL7

for RPM in oracle-database-preinstall-18c-1.0-1.el7.x86_64.rpm \
           oracle-database-preinstall-19c-1.0-1.el7.x86_64.rpm \
           oracle-database-preinstall-19c-1.0-2.el7.x86_64.rpm \
           oracle-database-preinstall-19c-1.0-3.el7.x86_64.rpm \
           oracle-database-preinstall-21c-1.0-1.el7.x86_64.rpm \
           oracle-database-server-12cR2-preinstall-1.0-2.el7.x86_64.rpm \
           oracle-database-server-12cR2-preinstall-1.0-3.el7.x86_64.rpm \
           oracle-database-server-12cR2-preinstall-1.0-4.el7.x86_64.rpm \
           oracle-database-server-12cR2-preinstall-1.0-5.el7.x86_64.rpm
do
	curl -o ${RPM} https://yum.oracle.com/repo/OracleLinux/OL7/latest/x86_64/getPackage/${RPM}
done
