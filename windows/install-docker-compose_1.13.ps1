$ProgressPreference = 'SilentlyContinue'

$version = '1.13.0'
Write-Output "-Installing Docker Compose version: $version"

$downloadUrl = "https://github.com/docker/compose/releases/download/$version/docker-compose-Windows-x86_64.exe"
$outFilePath = "$env:TEMP\docker-compose.exe"
Write-Output "--Downloading: $downloadUrl"
Invoke-WebRequest -UseBasicParsing -OutFile $outFilePath -Uri $downloadUrl
Move-Item $outFilePath "$env:ProgramFiles\docker\docker-compose.exe" -Force

Write-Output '-Done'
Write-Output '*'

& docker-compose version
