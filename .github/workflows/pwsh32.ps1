param(
    [Switch]$Force
)
$CurrentPSVersion = "$($PSVersionTable.PSVersion.Major).$($PSVersionTable.PSVersion.Minor).$($PSVersionTable.PSVersion.Patch)"

$DownloadDir = Join-Path $PSScriptRoot '../../downloads'
If (-Not(Test-Path $DownloadDir)) { New-Item -Path $DownloadDir -ItemType 'Directory' | Out-Null }

$PwshZip = Join-Path $DownloadDir 'pwsh.zip'
If ((Test-Path $PwshZip) -and $Force) { Remove-Item -Path $DownloadDir -Force -Confirm:$false | Out-Null }
If (-Not (Test-Path $PwshZip)) {
    $DownloadUrl = "https://github.com/PowerShell/PowerShell/releases/download/v$CurrentPSVersion/PowerShell-$CurrentPSVersion-win-x86.zip"
    Write-Host "Downloading $DownloadURL ..."
    Invoke-WebRequest -Uri $DownloadUrl -OutFile $PwshZip
} else {
    Write-Host "ZIP file has been downloaded"
}

$PwshExtract = Join-Path $DownloadDir 'pwsh32'
If ((Test-Path $PwshExtract) -and $Force) { Remove-Item -Path $PwshExtract -Force -Confirm:$false -Recurse | Out-Null }
If (-Not (Test-Path $PwshExtract)) {
    Expand-Archive -Path $PwshZip -DestinationPath $PwshExtract
}

Join-Path $PwshExtract 'pwsh.exe'
