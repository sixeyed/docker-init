
$response = Invoke-WebRequest -UseBasicParsing https://api.github.com/repos/moby/moby/releases/latest
$content = $response.Content
$latest = ConvertFrom-Json $content
$version = $latest.tag_name.Substring(1)

Write-Output "-Installing Docker version: $version"

$service = Get-Service 'docker' -ErrorAction SilentlyContinue
if ($service) {
    Write-Output '--Stopping Docker Windows service'
    Stop-Service docker
}

$downloadUrl = "https://get.docker.com/builds/Windows/x86_64/docker-$version.zip"
$outFilePath = "$env:TEMP\docker.zip"
Write-Output "--Downloading: $downloadUrl"
Invoke-WebRequest -UseBasicParsing -OutFile $outFilePath -Uri $downloadUrl
Expand-Archive -Path $outFilePath -DestinationPath $env:ProgramFiles -Force
Remove-Item $outFilePath

if ($service) {
    Start-Service docker
    Write-Output '--Starting Docker Windows service'
}
else {
    $env:PATH = $env:ProgramFiles + '\docker;' + $env:PATH
    [Environment]::SetEnvironmentVariable('PATH', $env:PATH, [EnvironmentVariableTarget]::Machine)
}

Write-Output '-Done'
Write-Output '*'

& docker version
