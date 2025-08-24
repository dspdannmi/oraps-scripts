
Get-ComputerInfo

Get-NetIPAddress
(Get-NetIPAddress | Where-Object {$_.AddressFamily -eq 'IPv4'}).IPAddress	<---- just lists the mmac addresses

Get-WmiObject win32_networkadapterconfiguration | select description, macaddress

Get-CimInstance win32_networkadapterconfiguration | select description, macaddress

Get-WmiObject -Class "Win32_ComputerSystemProduct" | Select-Object -Property UUID	<----- bassed on hardware, maybe does change with new VM clone ---> 
Linux equivalent:  dmidecode -s system-uuid
