# run Windows Update
# TODO - you will need to do this manually with `sconfig`, if the update needs a reboot
#Install-Module PSWindowsUpdate -Force
#Import-Module PSWindowsUpdate
#Get-WUInstall -AcceptAll -IgnoreReboot | Out-File C:\PSWindowsUpdate.log

# install Chocolatey 
Invoke-Expression ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))

# update Docker
iwr -useb https://raw.githubusercontent.com/sixeyed/docker-init/master/windows/install-docker-ce_17.06.ps1 | iex

# update base images
$tag = '10.0.14393.1198'
docker pull "microsoft/windowsservercore:$tag"
docker pull "microsoft/nanoserver:$tag"
docker tag "microsoft/windowsservercore:$tag" microsoft/windowsservercore:latest
docker tag "microsoft/nanoserver:$tag" microsoft/nanoserver:latest

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
docker pull microsoft/iis:windowsservercore-10.0.14393.1198
docker pull microsoft/iis:nanoserver-10.0.14393.1198
docker pull microsoft/aspnet:windowsservercore-10.0.14393.1198
docker pull microsoft/mssql-server-windows-express:2016-sp1-windowsservercore-10.0.14393.1198
docker pull microsoft/aspnet:windowsservercore-10.0.14393.1198
docker pull microsoft/aspnet:windowsservercore-10.0.14393.1066

docker pull nats:nanoserver
docker pull sixeyed/elasticsearch:nanoserver
docker pull sixeyed/kibana:nanoserver

docker pull sixeyed/msbuild:netfx-4.5.2
docker pull sixeyed/msbuild:netfx-4.5.2-webdeploy
