@echo off

set help=%1

IF "%help%"=="--help" (
  echo Go to https://github.com/tpaananen/DockerCommandsForWindows
) ELSE (
  :: use -d distribution name option if not using the default distribution, e.g. wsl.exe -d Debian docker %*
  wsl.exe bash -i -c "docker %*"
)
