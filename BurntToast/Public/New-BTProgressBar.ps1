function New-BTProgressBar
{
    <#
        .SYNOPSIS

        .DESCRIPTION

        .INPUTS
        System.String

        You cannot pipe input to this cmdlet.

        .OUTPUTS
        Microsoft.Toolkit.Uwp.Notifications.AdaptiveProgressBar

        .EXAMPLE
        New-BTProgressBar

        Explination

        .LINK
        https://github.com/Windos/BurntToast/blob/master/Help/New-BTProgressBar.md
    #>

    [CmdletBinding()]
    param
    (
        [string] $Title,

        [Parameter(Mandatory)]
        [string] $Status,

        # Between 0 and 1
        [Parameter(Mandatory)]
        [double] $Value,

        [string] $ValueDisplay
    )

    $ProgressBar = [Microsoft.Toolkit.Uwp.Notifications.AdaptiveProgressBar]::new()

    $ProgressBar.Status = $Status
    $ProgressBar.Value = $Value

    if ($Title) {
        $ProgressBar.Title = $Title
    }

    if ($ValueDisplay) {
        $ProgressBar.ValueStringOverride = $ValueDisplay
    }

    $ProgressBar
}
