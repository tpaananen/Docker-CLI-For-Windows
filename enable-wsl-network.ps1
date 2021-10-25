# Run as administrator
# Replace sgra_vpn with your vpn component ID
netsh interface set interface "vEthernet (WSL)" enable
Disable-NetAdapterBinding -Name "vEthernet (WSL)" -ComponentID sgra_vpn
