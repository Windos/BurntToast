function Test-BTAudioPath {
    param (
        [Parameter(Mandatory)]
        [String] $Path
    )

    $Extension = [IO.Path]::GetExtension($Path)

    $ValidExtensions = @(
        '.aac'
        '.flac'
        '.m4a'
        '.mp3'
        '.wav'
        '.wma'
    )

    if ($Extension -in $ValidExtensions) {
        if (Test-Path -Path $Path) {
            $true
        } else {
            throw "The file '$Path' doesn't exist in the specified location. Please provide a valid path and try again."
        }
    } else {
        throw "The file extension '$Extension' is not supported. Please provide a valid path and try again."
    }
}
