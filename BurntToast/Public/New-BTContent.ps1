using namespace Microsoft.Toolkit.Uwp.Notifications

function New-BTContent
{
    <#
        .SYNOPSIS

        .DESCRIPTION

        .INPUTS
        None

        .OUTPUTS
        Image
        
        .EXAMPLE

        .EXAMPLE

        .EXAMPLE

        .LINK
        https://github.com/Windos/BurntToast
    #>

    [CmdletBinding()]
    [OutputType([ToastContent])]
    param
    (
        [Parameter()]
        [IToastActions] $Actions,

        [ToastActivationType] $ActivationType,

        [ToastAudio] $Audio,

        [ToastDuration] $Duration,

        [string] $Launch,

        [ToastScenario] $Scenario,

        [ToastVisual] $Visual
    )

    $ToastContent = [ToastContent]::new()

    if ($Actions)
    {
        $ToastContent.Actions = $Actions
    }

    if ($ActivationType)
    {
        $ToastContent.ActivationType = $ActivationType
    }

    if ($Audio)
    {
        $ToastContent.Audio = $Audio
    }

    if ($Duration)
    {
        $ToastContent.Duration = $Duration
    }

    if ($Launch)
    {
        $ToastContent.Launch = $Launch
    }

    if ($Scenario)
    {
        $ToastContent.Scenario = $Scenario
    }

    if ($Visual)
    {
        $ToastContent.Visual = $Visual
    }

    $ToastContent
}
