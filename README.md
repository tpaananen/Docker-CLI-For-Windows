# Docker Desktop for Windows powered by WSL

- Install WSL Ubuntu / Debian etc. Typically on Windows 10 or 11 you just call `wsl --install -d Ubuntu` to install Ubuntu.
- Go to <https://docs.docker.com/engine/install/ubuntu/> to install docker on WSL Ubuntu
- Go to <https://docs.docker.com/engine/install/linux-postinstall> to post-install setup
- Start the docker service in WSL: sudo service docker start
  - Set docker to start automatically during startup:
  - `sudo update-rc.d docker defaults && sudo update-rc.d docker enable`
- Configure firewall on Windows side (Powershell): `New-NetFirewallRule -DisplayName "WSL" -Direction Inbound -InterfaceAlias "vEthernet (WSL)" -Action Allow`
- Configure Linux networking (ifconfig.sh)
- Add script files or location to PATH
- Use docker commands normally as you would be in Linux or using Docker Desktop for Windows
- When calling docker from batch files, use `call docker ...` since you are calling another batch file so stderr output won't stop the script

After waking up from hibernate:
- Reset WSL networking

When using VPN:
- Disable the vEthernet (WSL) interface before connecting VPN, and enable after connection has been made
- Additionally, uncheck the VPN item from the vEthernet (WSL) interface
  - `Disable-NetAdapterBinding -Name "vEthernet (WSL)" -ComponentID sgra_vpn`
  - look for your VPN component ID and replace (the above is for Forcepoint VPN)

Profit!

## Cons

- You usually need to reset networking after waking up from hibernate
- Networking is painful when VPN needs to be used

## Pros

- It's free
