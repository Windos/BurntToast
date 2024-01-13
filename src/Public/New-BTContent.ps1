function New-BTContent {
    <#
        .SYNOPSIS
        Creates a new Toast Content object.

        .DESCRIPTION
        The New-BTContent function creates a new Toast Content object which is the Base Toast element, which contains at least a visual element.

        .INPUTS
        None

        .OUTPUTS
        ToastContent

        .EXAMPLE
        $binding1 = New-BTBinding -Children $text1, $text2 -AppLogoOverride $image2
        $visual1 = New-BTVisual -BindingGeneric $binding1
        $content1 = New-BTContent -Visual $visual1

        This example combines numerous objects created via BurntToast functions into a binding, then a visual element and finally into a content object.

        The resultant object can now be displayed using the Submit-BTNotification function.

        .EXAMPLE
        $content1 = New-BTContent -Visual $visual1 -ActivationType Protocol -Launch 'https://google.com'

        This command takes a pre-existing visual object and also specifies options required to launch a browser on the Google homepage when clicking the toast.

        .NOTES
        Credit for most of the help text for this function go to the authors of the UWPCommunityToolkit library that this module relies upon.

        Please see the originating repo here: https://github.com/Microsoft/UWPCommunityToolkit

        .LINK
        https://github.com/Windos/BurntToast/blob/main/Help/New-BTContent.md
    #>

    [CmdletBinding(SupportsShouldProcess = $true,
                   HelpUri = 'https://github.com/Windos/BurntToast/blob/main/Help/New-BTContent.md')]
    [OutputType([Microsoft.Toolkit.Uwp.Notifications.ToastContent])]
    param (
        # Optionally create custom actions with buttons and inputs (New-BTAction.)
        [Microsoft.Toolkit.Uwp.Notifications.IToastActions] $Actions,

        # Specifies what activation type will be used when the user clicks the body of this Toast.
        [Microsoft.Toolkit.Uwp.Notifications.ToastActivationType] $ActivationType,

        # Specify custom audio options (New-BTAudio.)
        [Microsoft.Toolkit.Uwp.Notifications.ToastAudio] $Audio,

        # The amount of time the Toast should display. You typically should use the Scenario attribute instead, which impacts how long a Toast stays on screen.
        [Microsoft.Toolkit.Uwp.Notifications.ToastDuration] $Duration,

        # New in Creators Update: Specifies an optional header for the toast notification (New-BTHeader.)
        [Microsoft.Toolkit.Uwp.Notifications.ToastHeader] $Header,

        # A string that is passed to the application when it is activated by the Toast. The format and contents of this string are defined by the app for its own use. When the user taps or clicks the Toast to launch its associated app, the launch string provides the context to the app that allows it to show the user a view relevant to the Toast content, rather than launching in its default way.
        [string] $Launch,

        # Specify the scenario, to make the Toast behave like an alarm, reminder, or more.
        [Microsoft.Toolkit.Uwp.Notifications.ToastScenario] $Scenario,

        # Specify the visual element object, created with the New-BTVisual function.
        [Parameter(Mandatory)]
        [Microsoft.Toolkit.Uwp.Notifications.ToastVisual] $Visual,

        [Microsoft.Toolkit.Uwp.Notifications.ToastPeople] $ToastPeople,

        [datetime] $CustomTimestamp
    )

    $ToastContent = [Microsoft.Toolkit.Uwp.Notifications.ToastContent]::new()

    if ($Actions) {
        $ToastContent.Actions = $Actions
    }

    if ($ActivationType) {
        $ToastContent.ActivationType = $ActivationType
    }

    if ($Audio) {
        $ToastContent.Audio = $Audio
    }

    if ($Duration) {
        $ToastContent.Duration = $Duration
    }

    if ($Header) {
        $ToastContent.Header = $Header
    }

    if ($Launch) {
        $ToastContent.Launch = $Launch
    }

    if ($Scenario) {
        $ToastContent.Scenario = $Scenario
    }

    if ($Visual) {
        $ToastContent.Visual = $Visual
    }

    if ($Actions) {
        $ToastContent.Actions = $Actions
    }

    if ($ToastPeople) {
        $ToastContent.HintPeople = $ToastPeople
    }

    if ($CustomTimestamp) {
        $ToastContent.DisplayTimestamp = $CustomTimestamp
    }

    if($PSCmdlet.ShouldProcess( "returning: [$($ToastContent.GetType().Name)] with XML: $($ToastContent.GetContent())" )) {
        $ToastContent
    }
}
