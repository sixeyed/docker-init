# docker-init
Init scripts for setting up and prepping Docker environments

## Windows

Install latest Docker CE - stops and restarts Windows Service if installed, but does not register service if not:

```
iwr -useb https://raw.githubusercontent.com/sixeyed/docker-init/master/windows/install-docker-ce.ps1 | iex
```

Install latest Docker Compose - downloads to Docker path:

```
iwr -useb https://raw.githubusercontent.com/sixeyed/docker-init/master/windows/install-docker-compose.ps1 | iex
```

## Ubuntu

Install latest Docker CE - inludes init system setup:

```
curl -sSL https://raw.githubusercontent.com/sixeyed/docker-init/master/ubuntu/install-docker-ce.sh | sh
```
