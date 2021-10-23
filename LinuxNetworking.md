Get the IP address and netmask from Windows side: ipconfig and look for `vEthernet (WSL)`

> sudo apt-get update && sudo apt-get install net-tools
>
> sudo ifconfig eth0 <IP-ADDR-OF-vEthernet (WSL) in Windows> netmask <NETMASK-OF-vEthernet (WSL) in Windows
>
> sudo route add default gw <IP-ADDR-OF-vEthernet (WSL) in Windows>
