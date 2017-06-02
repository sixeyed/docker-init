
$ProgressPreference = 'SilentlyContinue'
$response = Invoke-WebRequest -UseBasicParsing https://api.github.com/repos/docker/compose/releases/latest
$content = $response.Content
$latest = ConvertFrom-Json $content
$version = $latest.tag_name

Write-Output "-Installing Docker Compose version: $version"

$downloadUrl = "https://github.com/docker/compose/releases/download/$version/docker-compose-Windows-x86_64.exe"
$outFilePath = "$env:TEMP\docker-compose.exe"
Write-Output "--Downloading: $downloadUrl"
Invoke-WebRequest -UseBasicParsing -OutFile $outFilePath -Uri $downloadUrl
Move-Item $outFilePath "$env:ProgramFiles\docker\docker-compose.exe" -Force

Write-Output '-Done'
Write-Output '*'

& docker-compose version
