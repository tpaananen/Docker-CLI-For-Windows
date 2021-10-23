# Docker Commands for Windows powered by WSL

This is really simplified console version of Docker Desktop for Windows powered by WSL 2 when you do not need (or your employer for some reason does not get you a lisence) all those fancy features of Docker Desktop (see [lisencing](https://www.docker.com/pricing)). Docker is installed in WSL v2 distribution and docker commands are executed via `wsl.exe` from Windows (use your favorite terminal but recommending Windows Terminal Preview with PowerShellCore) using simple batch files to forward arguments and IO in terminal. Expect network to break!

Note: this has not been tested in many situations and there are scenarios where this solution will not work, but for simple docker setups in Windows, it's doing fine.

## Optional setup of the Windows Terminal Preview

- Install Windows Terminal Preview
  - `winget install -e --id Microsoft.WindowsTerminalPreview`
  - `winget install -e --id Microsoft.PowerShell`

## Setup

- Install WSL Ubuntu / Debian etc. Typically on Windows 10 or 11 you just call `wsl --install -d Ubuntu` to install Ubuntu.
- Go to <https://docs.docker.com/engine/install/ubuntu/> to install docker on WSL Ubuntu
- Go to <https://docs.docker.com/engine/install/linux-postinstall> to post-install setup
- Install docker-compose: `sudo apt-get update && sudo apt-get install docker-compose`
- Start the docker service in WSL:
  - `sudo service docker start`
  - Set docker to start automatically when the instance starts by issuing following command, adds a line to `~/.bashrc`, obviously issued from WSL terminal
  - `echo "wsl.exe -u root service docker status || wsl.exe -u root service docker start" >> ~/.bashrc`
- Configure firewall on Windows side (Powershell)
  - `New-NetFirewallRule -DisplayName "WSL" -Direction Inbound -InterfaceAlias "vEthernet (WSL)" -Action Allow`
- Configure [Linux networking](https://github.com/tpaananen/DockerCommandsForWindows/blob/main/linux-networking.md)
- Save `docker.cmd` and `docker-compose.cmd` to your machine and add the files and/or location to **PATH**
- Use docker commands normally as you would be in Linux or using Docker Desktop for Windows
- When calling docker from batch files, use `call docker ...` since you are calling another batch file so stderr output won't stop the script

## After waking up from hibernate

- Reset WSL networking if your containers need network access outside the machine.

## Docker in WSL with VPN

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

## Docker Desktop

If you need fully featured solution, check out the [Docker Desktop](https://www.docker.com/products/docker-desktop)
