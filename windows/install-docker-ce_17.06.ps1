$ProgressPreference = 'SilentlyContinue'

$version = '17.06.0-ce'
Write-Output "-Installing Docker version: $version"

$service = Get-Service 'docker' -ErrorAction SilentlyContinue
if ($service) {
    Write-Output '--Stopping Docker Windows service'
    Stop-Service docker
}

$downloadUrl = "https://download.docker.com/win/static/test/x86_64/docker-$version.zip"
$outFilePath = "$env:TEMP\docker.zip"
Write-Output "--Downloading: $downloadUrl"
Invoke-WebRequest -UseBasicParsing -OutFile $outFilePath -Uri $downloadUrl
Expand-Archive -Path $outFilePath -DestinationPath $env:ProgramFiles -Force
Remove-Item $outFilePath

if ($service) {
    Start-Service docker
    Write-Output '--Started Docker Windows service'
}
else {
    $env:PATH = $env:ProgramFiles + '\docker;' + $env:PATH
    [Environment]::SetEnvironmentVariable('PATH', $env:PATH, [EnvironmentVariableTarget]::Machine)

    dockerd $env:DOCKERD_OPTS --register-service
    Write-Output '--Registered Docker Windows service - with options: ' + $env:DOCKERD_OPTS

    Start-Service docker
    Write-Output '--Started Docker Windows service'
}

Write-Output '-Done'
Write-Output '*'

& docker version
