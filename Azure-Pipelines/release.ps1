[CmdletBinding()]
param(
    [switch]
    $Bootstrap,

    [switch]
    $DefineTag,

    [switch]
    $Publish,

    [switch]
    $Announce
)

# Bootstrap step
if ($Bootstrap.IsPresent) {
    Write-Information "Validate and install missing prerequisits for building ..."

    # For tweeting
    if (-not (Get-Module -Name PSTwitterAPI -ListAvailable)) {
        Write-Warning "Module 'PSTwitterAPI' is missing. Installing 'PSTwitterAPI' ..."
        Install-Module -Name PSTwitterAPI -Scope CurrentUser -Force
    }
}

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

# Announce step
if($Announce.IsPresent) {
    if (-not (Get-Module -Name PSTwitterAPI -ListAvailable)) {
        throw "Cannot find the 'PSTwitterAPI' module. Please specify '-Bootstrap' to install release dependencies."
    }

    Import-Module -Name PSTwitterAPI

    $OAuthSettings = @{
        ApiKey            = $env:TwitterConsumerKey
        ApiSecret         = $env:TwitterConsumerSecret
        AccessToken       = $env:TwitterAccessToken
        AccessTokenSecret = $env:TwitterAccessSecret
    }

    Set-TwitterOAuthSettings @OAuthSettings

    $ReleaseVersion = Get-Content -Path $env:ArtifactDir\PipelinesScripts\release-version.txt

    $Tweets = @("I just pushed BurntToast v$ReleaseVersion to the #PowerShell Gallery via @AzureDevOps!$([System.Environment]::NewLine)$([System.Environment]::NewLine)$env:ReleaseMessage$([System.Environment]::NewLine)$([System.Environment]::NewLine)https://www.powershellgallery.com/packages/BurntToast/$ReleaseVersion",
                "You can also find this release over on @GitHub.$([System.Environment]::NewLine)$([System.Environment]::NewLine)Please do fire through any issue, feature requests, or submit some additional code!$([System.Environment]::NewLine)$([System.Environment]::NewLine)https://github.com/Windos/BurntToast/releases/tag/v$ReleaseVersion")

    foreach ($Tweet in $Tweets) {
        if ($PrevTweet) {
            $PrevTweet = Send-TwitterStatuses_Update -in_reply_to_status_id $PrevTweet.id.ToString() -status $Tweet
        } else {
            $PrevTweet = Send-TwitterStatuses_Update -status $Tweet
        }
    }
}