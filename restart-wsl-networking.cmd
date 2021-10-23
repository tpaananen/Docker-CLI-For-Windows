@echo off

echo Restarting WSL Service
Restart-Service LxssManager

echo Restarting Host Network Service
Stop-Service -name "hns"
Start-Service -name "hns"

echo Restarting Hyper-V adapters

Get-NetAdapter -IncludeHidden | Where-Object `
    {$_.InterfaceDescription.StartsWith('Hyper-V Virtual Ethernet Adapter')} `
    | Disable-NetAdapter -Confirm:$False
Get-NetAdapter -IncludeHidden | Where-Object `
    {$_.InterfaceDescription.StartsWith('Hyper-V Virtual Switch Extension Adapter')} `
    | Disable-NetAdapter -Confirm:$False
Get-NetAdapter -IncludeHidden | Where-Object `
    {$_.InterfaceDescription.StartsWith('Hyper-V Virtual Ethernet Adapter')} `
    | Enable-NetAdapter -Confirm:$False
Get-NetAdapter -IncludeHidden | Where-Object `
    {$_.InterfaceDescription.StartsWith('Hyper-V Virtual Switch Extension Adapter')} `
    | Enable-NetAdapter -Confirm:$False
Disable-NetAdapterBinding -Name "vEthernet (WSL)" -ComponentID sgra_vpn
