function Optimize-BTImageSource {
    param (
        [Parameter(Mandatory)]
        [String] $Source
    )

    if ([bool]([System.Uri]$Source).IsUnc -or $Source -like 'http?://*') {
        $RemoteFileName = "$(get-random -min 0 -max 100000)" +$Source.Split('/\')[-1] -replace '[\[\]*?]',''

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
        try {
            (Get-Item -Path $Source -ErrorAction Stop).FullName
        } catch {
            Write-Warning -Message "The image source '$Source' doesn't exist, failed back to icon."
        }
    }
}
