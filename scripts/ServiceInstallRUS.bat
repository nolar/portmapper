@echo off
net stop PortMapper
PortMapperRUS.exe /uninstall /silent
PortMapperRUS.exe /install
net start PortMapper
pause
