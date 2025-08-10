#!/bin/bash

# OL7

for RPM in oracle-database-preinstall-19c-1.0-1.el9.x86_64.rpm oracle-database-preinstall-23ai-1.0-2.el9.x86_64.rpm oracle-database-preinstall-23ai-1.0-3.el9.x86_64.rpm
do
	curl -o ${RPM} https://yum.oracle.com/repo/OracleLinux/OL9/appstream/x86_64/getPackage/${RPM}
done
