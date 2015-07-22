$Url = 'https://github.com/Windos/BurntToast/releases/download/Latest/BurntToast.zip'
$BurntToastPath = Join-Path -Path (Split-Path -Path $profile) -ChildPath '\Modules\BurntToast'

if (!(Test-Path -Path $BurntToastPath))
{
    $null = New-Item -Path $BurntToastPath -ItemType Directory
}

$ArchivePath = Join-Path -Path $BurntToastPath -ChildPath 'BurntToast.zip'
Invoke-WebRequest -Uri $Url -OutFile $ArchivePath
Expand-Archive -Path $ArchivePath -DestinationPath $BurntToastPath
Remove-Item -Path $ArchivePath