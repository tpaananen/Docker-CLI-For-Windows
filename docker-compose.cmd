@echo off

set help=%1

IF "%help%"=="--help" (
  echo 1. Install docker-compose
  echo 2. sudo apt-get update && sudo apt-get install docker-compose
  echo 3. Here we assumed you have docker installed and running in WSL Debian based Linux
  echo 4. Add this script or location of this script to PATH
) ELSE (
  wsl.exe docker-compose %*
)
