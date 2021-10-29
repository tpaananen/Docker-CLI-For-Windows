@echo off

set help=%1

IF "%help%"=="--help" (
  echo Go to https://github.com/tpaananen/DockerCommandsForWindows
) ELSE (
  :: use -d distribution_name option for wsl.exe if not using the default distribution, e.g. wsl.exe -d Debian bash -i -c "docker-compose %*"
  wsl.exe bash -i -c "docker-compose %*"
)
