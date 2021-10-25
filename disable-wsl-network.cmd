:: run as administrator
netsh interface set interface "vEthernet (WSL)" disable

:: optionally uncheck the vpn item from the interface
:: (powershell) Disable-NetAdapterBinding -Name "vEthernet (WSL)" -ComponentID sgra_vpn
