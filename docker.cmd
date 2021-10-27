@echo off

set help=%1

IF "%help%"=="--help" (
  echo 1. Install WSL Ubuntu / Debian etc. Typically on Windows 10 or 11 you just call `wsl --install -d Ubuntu` to install Ubuntu.
  echo   - If you use VPN, disable the vEthernet (WSL) interface before connecting VPN, and enable after connection has been made
  echo   - Additionally, uncheck the VPN item from the vEthernet (WSL) interface
  echo     - with script: Disable-NetAdapterBinding -Name "vEthernet (WSL)" -ComponentID sgra_vpn
  echo       - look for your VPN component ID and replace (the above is for Forcepoint VPN)
  echo 2. Go to https://docs.docker.com/engine/install/ubuntu/ to install docker on WSL Ubuntu
  echo 3. Go to https://docs.docker.com/engine/install/linux-postinstall to post-install setup
  echo 4. Start the docker service in WSL: sudo service docker start
  echo   Set docker to start automatically during startup:
  echo   4a) sudo update-rc.d docker defaults
  echo   4b) sudo update-rc.d docker enable
  echo 5. Configure firewall on Windows side (Powershell): New-NetFirewallRule -DisplayName "WSL" -Direction Inbound -InterfaceAlias "vEthernet (WSL)" -Action Allow
  echo 6. Add this script or location of this script to PATH
  echo 7. Use docker commands normally as you would be in Linux or using Docker Desktop for Windows
  echo 8. When calling docker from batch files, use `call docker ...` since you are calling another batch file so stderr output won't stop the script
) ELSE (
  :: use -d distribution name option if not using the default distribution, e.g. wsl.exe -d Debian docker %*
  wsl.exe bash -i -c "docker %*"
)
