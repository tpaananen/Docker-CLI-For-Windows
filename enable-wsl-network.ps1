# Run as administrator
#netsh interface set interface "vEthernet (WSL)" enable
Enable-NetAdapter -Name "vEthernet (WSL)"

# optionally uncheck the vpn item from the interface
# Search for vpn component ID using 
Get-NetAdapterBinding -Name "vEthernet (WSL)"

# replace component ID sgra_vpn with your VPN component ID
Disable-NetAdapterBinding -Name "vEthernet (WSL)" -ComponentID sgra_vpn
