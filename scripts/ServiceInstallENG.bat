@echo off
net stop PortMapper
PortMapperENG.exe /uninstall /silent
PortMapperENG.exe /install
net start PortMapper
pause
