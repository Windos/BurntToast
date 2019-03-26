function Optimize-BTImageSource {
    param (
        [Parameter(Mandatory)]
        [String] $Source
    )

    if ([bool]([System.Uri]$Source).IsUnc -or $Source -like 'http?://*') {
        $RemoteFileName = $Source.Split('/\')[-1] -replace '[\[\]*?]',''

        $NewFilePath = '{0}\{1}' -f $Env:TEMP, $RemoteFileName

        if (!(Test-Path -Path $NewFilePath)) {
            if ([bool]([System.Uri]$Source).IsUnc) {
                Copy-Item -Path $Source -Destination $NewFilePath
            } else {
                Invoke-WebRequest -Uri $Source -OutFile $NewFilePath
            }
        }

        $NewFilePath
    } else {
        $Source
    }
}
