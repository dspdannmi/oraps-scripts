!/bin/bash
ORA_INV_BASE=$(grep loc /etc/oraInst.loc | cut -d '=' -f2)
ORA_INV=${ORA_INV_BASE}/ContentsXML/inventory.xml
GI_NAME=$(grep -i crs ${ORA_INV} | cut -d '=' -f2 | cut -d '"' -f2)
GI_LOC=$(grep -i crs ${ORA_INV} | cut -d '=' -f3 | cut -d '"' -f2)
GI_OWNER=$(ls -al ${GI_LOC}/oraInst.loc | awk '{print $3}')
GI_GRP=$(ls -al ${GI_LOC}/oraInst.loc | awk '{print $4}')
echo "     A Grid Infrastructure installation named ${GI_NAME}"
echo "     exists on this system under ${GI_LOC}"
echo "     it is owned by user ${GI_OWNER}"
echo "     and group ${GI_GRP}"
