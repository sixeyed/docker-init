# docker-init
Init scripts for setting up and prepping Docker environments

## Windows

Install latest Docker CE - stops and restarts Windows Service if installed, but does not register service if not:

```
Invoke-Expression ((New-Object System.Net.WebClient).DownloadString('https://raw.githubusercontent.com/sixeyed/docker-init/master/windows/install-docker-ce.ps1'))
```

Install latest Docker Compose - downloads to Docker path:

```
Invoke-Expression ((New-Object System.Net.WebClient).DownloadString('https://raw.githubusercontent.com/sixeyed/docker-init/master/windows/install-docker-compose.ps1'))
```

## Ubuntu 

Install latest Docker CE - inludes init system setup:

```
curl -sSL https://raw.githubusercontent.com/sixeyed/docker-init/master/ubuntu/install-docker-ce.sh | sh
```
