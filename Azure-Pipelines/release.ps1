[CmdletBinding()]
param(
    [switch]
    $DefineTag,

    [switch]
    $Publish
)

# Define Tag step
if ($DefineTag.IsPresent) {
    $ReleaseVersion = Get-Content -Path $env:ArtifactDir\PipelinesScripts\release-version.txt
    Write-Host "##vso[task.setvariable variable=RELEASETAG]$ReleaseVersion"
}

# Publish step
if ($Publish.IsPresent) {
    # Publish Module to PowerShell Gallery
    Try {
        $Splat = @{
            Path        = (Resolve-Path -Path $env:ArtifactDir\BurntToast)
            NuGetApiKey = $env:PSGallery
            ErrorAction = 'Stop'
        }
        Publish-Module @Splat

        Write-Output -InputObject ('BurntToast PowerShell Module published to the PowerShell Gallery')
    } Catch {
        throw $_
    }
}
