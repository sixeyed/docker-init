# run Windows Update
# TODO - you will need to do this manually with `sconfig`, if the update needs a reboot
#Install-Module PSWindowsUpdate -Force
#Import-Module PSWindowsUpdate
#Get-WUInstall -AcceptAll -IgnoreReboot | Out-File C:\PSWindowsUpdate.log

# install Chocolatey 
Invoke-Expression ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))

# update Docker
$version = '17.06'
iwr -useb https://raw.githubusercontent.com/sixeyed/docker-init/master/windows/install-docker-ce_$version.ps1 | iex

#install Compose
$composeVersion = '1.16'
iwr -useb https://raw.githubusercontent.com/sixeyed/docker-init/master/windows/install-docker-compose_$composeVersion.ps1 | iex

# update base images
$tag = '10.0.14393.1593'
docker image pull "microsoft/windowsservercore:$tag"
docker image pull "microsoft/nanoserver:$tag"
docker image tag "microsoft/windowsservercore:$tag" microsoft/windowsservercore:latest
docker image tag "microsoft/nanoserver:$tag" microsoft/nanoserver:latest

# install tools
choco install -y poshgit
choco install -y visualstudiocode
choco install -y firefox

# configure Server Manager 
New-ItemProperty -Path HKCU:\Software\Microsoft\ServerManager -Name DoNotOpenServerManagerAtLogon -PropertyType DWORD -Value "1" -Force

# turn off firewall and Defender *this is meant for short-lived lab VMs*
Set-NetFirewallProfile -Profile Domain,Public,Private -Enabled False
Set-MpPreference -DisableRealtimeMonitoring $true

# pull lab images
docker image pull microsoft/iis:windowsservercore
docker image pull microsoft/iis:nanoserver
docker image pull microsoft/iis:nanoserver-10.0.14393.1593
docker image pull microsoft/aspnet:windowsservercore
docker image pull microsoft/mssql-server-windows-express
docker image pull microsoft/aspnet:windowsservercore-10.0.14393.1593
docker image pull microsoft/aspnet:windowsservercore-10.0.14393.1480

docker image pull sixeyed/msbuild:netfx-4.5.2
docker image pull sixeyed/msbuild:netfx-4.5.2-webdeploy
docker image pull dockersamples/aspnet-monitoring-prometheus

docker image pull nats:nanoserver

docker image pull sixeyed/elasticsearch:nanoserver
docker image pull sixeyed/kibana:nanoserver
