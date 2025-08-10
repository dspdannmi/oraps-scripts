#!/bin/bash

# OL7

for RPM in oracle-database-preinstall-19c-1.0-1.el8.x86_64.rpm \
           oracle-database-preinstall-19c-1.0-2.el8.x86_64.rpm \
           oracle-database-preinstall-21c-1.0-1.el8.x86_64.rpm \
           oracle-database-preinstall-23ai-1.0-2.el8.x86_64.rpm \
           oracle-database-preinstall-23ai-1.0-4.el8.x86_64.rpm 
do
	curl -o ${RPM} https://yum.oracle.com/repo/OracleLinux/OL8/appstream/x86_64/getPackage/${RPM}
done
