# Publish Module to PowerShell Gallery
Try {
    $Splat = @{
        Path        = (Resolve-Path -Path $PSScriptRoot\..\BurntToast)
        NuGetApiKey = $env:PSGallery
        ErrorAction = 'Stop'
    }
    Publish-Module @Splat

    Write-Output -InputObject ('BurntToast PowerShell Module published to the PowerShell Gallery')
} Catch {
    throw $_
}