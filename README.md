# Docker Commands for Windows powered by WSL

This is really simplified console version of Docker Desktop for Windows powered by WSL 2 when you do not need (or your employer for some reason does not get you a lisence) all those fancy features of Docker Desktop (see [lisencing](https://www.docker.com/pricing)). Docker is installed in WSL v2 distribution and docker commands are executed via `wsl.exe` from Windows (use your favorite terminal but recommending Windows Terminal Preview with PowerShellCore) using simple batch files to forward arguments and IO in terminal. Expect network to break!

Note: this has not been tested in many situations and there are scenarios where this solution will not work, but for simple docker setups in Windows, it's doing fine.

## Optional setup of the Windows Terminal Preview

At the time of writing this, Windows Terminal Preview offers one neat feature missing from the stable version where you can set the default terminal application. So when you type cmd.exe in run/search -> it will launch cmd inside Windows Terminal instead of the default terminal application Windows Console Host. This feature seems to be available only in Windows 11.

- Install Windows Terminal Preview and PowerShellCore
  - `winget install -e --id Microsoft.WindowsTerminalPreview`
  - `winget install -e --id Microsoft.PowerShell`

## Setup

### Install WSL and Ubuntu
- [Install WSL](https://docs.microsoft.com/en-us/windows/wsl/install) Ubuntu / Debian etc. Typically on Windows 10 or 11 you just call `wsl --install -d Ubuntu` to install Ubuntu.

### Install docker and docker-compose to Ubuntu

- Go to <https://docs.docker.com/engine/install/ubuntu/> to install docker on WSL Ubuntu
- Go to <https://docs.docker.com/engine/install/linux-postinstall> to post-install setup
- Install docker-compose: `sudo apt-get update && sudo apt-get install docker-compose`

### Set docker service to start when interactive session of the instance starts

- Start the docker service in WSL:
  - `sudo service docker start`
  - Set docker to start automatically when the instance starts by issuing following command, adds a line to `~/.bashrc`, obviously issued from WSL terminal
  - `echo "wsl.exe -u root service docker status || wsl.exe -u root service docker start" >> ~/.bashrc`

### Configure networking

- Configure firewall on Windows side (Powershell)
  - `New-NetFirewallRule -DisplayName "WSL" -Direction Inbound -InterfaceAlias "vEthernet (WSL)" -Action Allow`
- Configure [Linux networking](https://github.com/tpaananen/DockerCommandsForWindows/blob/main/linux-networking.md)

### Copy and run docker and docker-compose commands

- Save `docker.cmd` and `docker-compose.cmd` to your Windows machine and add the files and/or location to **PATH** (restart terminal to get the updated PATH)
  - Configure environment variables also to linux side if needed (export calls in ~/.bashrc). docker.cmd and docker-compose.cmd invoke docker/compose calls within interactive bash so it also loads enviroment variables.
- Use docker commands normally as you would be in Linux or using Docker Desktop for Windows
- When calling docker from batch files, use `call docker ...` since you are calling another batch file so stderr output won't stop the script
  - If you have a script to start just a single container, like database you could say
  > - `call docker stop sqlserver`
  > - `call docker rm sqlserver`
  > - `call docker pull mcr.microsoft.com/mssql/server:latest`
  > - `call docker run ...`

## After waking up from hibernation

- If WSL network is down after waking up from hibernation, reset the WSL networking if your containers need network access outside the machine.
- This seems to be working fine for me now when not using Docker Desktop, since I have started paying attention to VPN attached to WSL network interface (always unchecking it, see below).

## Docker in WSL with VPN

- Disable the vEthernet (WSL) interface before connecting VPN, and enable after connection has been made
- Additionally, uncheck the VPN item from the vEthernet (WSL) interface
  - `Disable-NetAdapterBinding -Name "vEthernet (WSL)" -ComponentID sgra_vpn`
  - look for your VPN component ID and replace (the above is for Forcepoint VPN)

Profit!

## Cons

- Networking is sometimes painful when VPN needs to be used
- Connection from application running in a container to Windows host may be painful to ge to work
- You need to specify environment variables also to linux side

## Pros

- It's free
- You will learn use Google! :)

## Docker Desktop

If you need fully featured solution, check out the [Docker Desktop](https://www.docker.com/products/docker-desktop)
