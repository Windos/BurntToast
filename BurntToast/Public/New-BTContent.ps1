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
    [OutputType([Microsoft.Toolkit.Uwp.Notifications.ToastContent])]
    param
    (
        [Parameter()]
        [Microsoft.Toolkit.Uwp.Notifications.IToastActions] $Actions,

        [Microsoft.Toolkit.Uwp.Notifications.ToastActivationType] $ActivationType,

        [Microsoft.Toolkit.Uwp.Notifications.ToastAudio] $Audio,

        [Microsoft.Toolkit.Uwp.Notifications.ToastDuration] $Duration,

        [Microsoft.Toolkit.Uwp.Notifications.ToastHeader] $Header,

        [string] $Launch,

        [Microsoft.Toolkit.Uwp.Notifications.ToastScenario] $Scenario,

        [Microsoft.Toolkit.Uwp.Notifications.ToastVisual] $Visual
    )

    $ToastContent = [Microsoft.Toolkit.Uwp.Notifications.ToastContent]::new()

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

    if ($Header)
    {
        $ToastContent.Header = $Header
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
